pragma solidity 0.5.1;

contract Voting{

    struct Candidate {
        uint id;
        string name;
        string party;
        uint voteCount;
    }

    mapping(uint => Candidate) public candidates;
    mapping(address => bool) public voters;

    uint public candidatesCount;
    uint public votingStart;
    uint public votingEnd;

    function addCandidate(string memory _name, string memory _party) public returns(uint) {
        candidatesCount++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, _party, 0);
        return candidatesCount;
    }

    function vote(uint8 candidateId) public {
        require((votingStart <= now) && (votingEnd > now), "");
        require((candidateId > 0) && (candidateId < candidatesCount), "");
        voters[msg.sender] = true;
        candidates[candidateId].voteCount++;
    }

    function checkVote() public returns(bool) {
        return(voters[msg.sender]);
    }

    function getcandidatesCount() public returns(uint) {
        return candidatesCount;
    }

    function getCandidate(uint _candidateId) public returns(uint, string memory,  string memory, uint) {
        return(_candidateId, candidates[_candidateId].name, candidates[_candidateId].party, candidates[_candidateId].voteCount);
    }

    function setDates(uint _votingStart, uint _votingEnd)public {
        require((votingEnd == 0) && (votingStart == 0) && (_votingStart + 1000000 > now) && (_votingEnd > _votingStart), "");
        votingStart = _votingStart;
        votingEnd = _votingEnd;
    }

    function getDates() public view returns(uint, uint) {
        return(votingStart,votingEnd);
    }

}