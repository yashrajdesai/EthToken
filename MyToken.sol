// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract MyToken {
    
    address public minter;
    mapping(address => uint256) balances;
    uint public totalSupply;
    string public name;
    string public symbol;

    event Transfer(address indexed from, address indexed to, uint tokens);

    // Create token
    constructor(string memory _name, string memory _symbol, uint256 _total) {
        name = _name;
        symbol = _symbol; 
	      totalSupply = _total;
        minter = msg.sender;
	      balances[minter] = totalSupply;
    }

    // Issue tokens 
    function mint(address reciever, uint amount) public {
        require(msg.sender == minter, "Only minter is allowed to mint tokens");
        balances[reciever] += amount;
        totalSupply += amount;
    }

    // Transfer tokens
    function transfer(address receiver, uint numTokens) public {
        require(numTokens <= balances[msg.sender], "Insufficient balance");
        balances[msg.sender] -= numTokens;
        balances[receiver] += numTokens;
        emit Transfer(msg.sender, receiver, numTokens);
    }
    
    // Returns number of tokens of the owner
    function balanceOf(address tokenOwner) public view returns (uint) {
        return balances[tokenOwner];
    }

}
