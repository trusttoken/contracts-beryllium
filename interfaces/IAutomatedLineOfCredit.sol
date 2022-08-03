// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {IProtocolConfig} from "./IProtocolConfig.sol";
import {IERC4626} from "./IERC4626.sol";
import {IDepositStrategy} from "./IDepositStrategy.sol";
import {IWithdrawStrategy} from "./IWithdrawStrategy.sol";

enum AutomatedLineOfCreditStatus {
    Open,
    Full,
    Closed
}

interface IAutomatedLineOfCredit is IERC4626 {
    struct InterestRateParameters {
        uint32 minInterestRate;
        uint32 minInterestRateUtilizationThreshold;
        uint32 optimumInterestRate;
        uint32 optimumUtilization;
        uint32 maxInterestRate;
        uint32 maxInterestRateUtilizationThreshold;
    }

    function initialize(
        IProtocolConfig _protocolConfig,
        uint256 _duration,
        IERC20 _asset,
        address _borrower,
        uint256 _maxSize,
        InterestRateParameters memory _interestRateParameters,
        IDepositStrategy _depositStrategy,
        IWithdrawStrategy _withdrawStrategy,
        address _transferStrategy,
        string memory name,
        string memory symbol
    ) external;

    function borrow(uint256 amount) external;

    function repay(uint256 amount) external;
}
