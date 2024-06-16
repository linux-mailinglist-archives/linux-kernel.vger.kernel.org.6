Return-Path: <linux-kernel+bounces-216097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC2F909B59
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 05:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DCA4B216E1
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 03:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B033816C68B;
	Sun, 16 Jun 2024 03:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OPWZECSF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB932F26
	for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 03:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718506939; cv=none; b=Oz0T22CeX6egcMpSiC8N5VWzDVGY4wlwxKUZ4OhJEnkA3d+oswbrImJy6vGMqX0AgJrVP3euJdgxK5lvp/08/bnS5c0BYc562q7Y1RQLk+38tpqVMSVnQHaR85/kbCc0nZk9Ms0vRImbZWKi7cyZIgqgWwRGMLS6XbA1BhdAgbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718506939; c=relaxed/simple;
	bh=rDilmJEiQUGj72DpBvS2k8E9uF/TpYTmNkgyQnGZruU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tJXCuxIOsmlcMX5U3gLHiH7GOVfZUlREDyilW58UoX4XuJsrwNN/H5DWZ4vjj1CURpXdswrXIBpCdBMO6/MmhQ54oY8E11WM6RWgGWTs0vCQNv7xLoNPqf44RupxI8bZ+cLqPLKUJo9ggprLYMPc21yCu/kFQgh6uHuw/3LcMFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OPWZECSF; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718506935; x=1750042935;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rDilmJEiQUGj72DpBvS2k8E9uF/TpYTmNkgyQnGZruU=;
  b=OPWZECSFVPX559eW76QV5iCJrJQvL0WV2NsFbi4ZDlkw4o2fnuolJcwb
   K4JIfRb/aK5lM5A86rVFRFKWFI2pCGBLWotmdiMSqes/HbL6qyXEBLv0q
   s54kq8VGQ1+vR5s5bZbfeURMobgw4Sg3QP8Lk9r/1y26VJFKO1ZO1Syxm
   t0UDyCBNniAVr46VYvm12NN3votgWqhbK+AFgH6A5OqpdBJF2/IKRv7Aj
   aNsdeot8yIRI7F3WsgNj/FjyGLynEOkMl0L8uREsMKZVzYEI35pZViuIe
   V+R6L8h2mnejnlyFblxS2Y8b7+AbCerlRMeF7kY4JH8ygb8qHbKedoKtA
   A==;
X-CSE-ConnectionGUID: Ttnb3xBMSJWKK3rF8F9s4Q==
X-CSE-MsgGUID: 5iP3IWggR0OTjZ1IZ03StQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11104"; a="15239943"
X-IronPort-AV: E=Sophos;i="6.08,241,1712646000"; 
   d="scan'208";a="15239943"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2024 20:02:14 -0700
X-CSE-ConnectionGUID: xh72qE5BQv+yn0NYggqsMg==
X-CSE-MsgGUID: /zxoazKPQIeDh3210w16sA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,241,1712646000"; 
   d="scan'208";a="40725953"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 15 Jun 2024 20:02:10 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sIg9g-0000la-1f;
	Sun, 16 Jun 2024 03:02:08 +0000
Date: Sun, 16 Jun 2024 11:01:50 +0800
From: kernel test robot <lkp@intel.com>
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Shawn Guo <shawn.guo@linaro.org>, Jun Nie <jun.nie@linaro.org>,
	Benjamin Li <benl@squareup.com>,
	James Willcox <jwillcox@squareup.com>, Leo Yan <leo.yan@linaro.org>,
	Joseph Gates <jgates@squareup.com>, Max Chen <mchen@squareup.com>,
	Zac Crosby <zac@squareup.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: arch/arm64/boot/dts/qcom/msm8939.dtsi:1286.22-1335.6: Warning
 (avoid_unnecessary_addr_size): /soc@0/display-subsystem@1a00000/dsi@1a98000:
 unnecessary #address-cells/#size-cells without "ranges" or child "reg"
 property
Message-ID: <202406161011.o9DyexJA-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a3e18a540541325a8c8848171f71e0d45ad30b2c
commit: 273a3dc13eb746c7b7abe7ea682811a8dacc89d6 arm64: dts: qcom: Add Square apq8039-t2 board
date:   1 year, 1 month ago
config: arm64-randconfig-r113-20240606 (https://download.01.org/0day-ci/archive/20240616/202406161011.o9DyexJA-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project d7d2d4f53fc79b4b58e8d8d08151b577c3699d4a)
reproduce: (https://download.01.org/0day-ci/archive/20240616/202406161011.o9DyexJA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406161011.o9DyexJA-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
>> arch/arm64/boot/dts/qcom/msm8939.dtsi:1286.22-1335.6: Warning (avoid_unnecessary_addr_size): /soc@0/display-subsystem@1a00000/dsi@1a98000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
   arch/arm64/boot/dts/qcom/msm8939.dtsi:475.26-478.6: Warning (unique_unit_address_if_enabled): /soc@0/qfprom@5c000/s6-p1@a1: duplicate unit-address (also used in node /soc@0/qfprom@5c000/s6-p2@a1)
   arch/arm64/boot/dts/qcom/msm8939.dtsi:495.26-498.6: Warning (unique_unit_address_if_enabled): /soc@0/qfprom@5c000/s8-p1@a4: duplicate unit-address (also used in node /soc@0/qfprom@5c000/s8-p2@a4)
   arch/arm64/boot/dts/qcom/msm8939.dtsi:520.24-523.6: Warning (unique_unit_address_if_enabled): /soc@0/qfprom@5c000/mode@d0: duplicate unit-address (also used in node /soc@0/qfprom@5c000/s0-p1@d0)
   arch/arm64/boot/dts/qcom/msm8939.dtsi:530.26-533.6: Warning (unique_unit_address_if_enabled): /soc@0/qfprom@5c000/s0-p1@d1: duplicate unit-address (also used in node /soc@0/qfprom@5c000/s1-p1@d1)

vim +1286 arch/arm64/boot/dts/qcom/msm8939.dtsi

61550c6c156c37 Bryan O'Donoghue 2023-04-07    14  
61550c6c156c37 Bryan O'Donoghue 2023-04-07    15  / {
61550c6c156c37 Bryan O'Donoghue 2023-04-07    16  	interrupt-parent = <&intc>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07    17  
61550c6c156c37 Bryan O'Donoghue 2023-04-07    18  	/*
61550c6c156c37 Bryan O'Donoghue 2023-04-07    19  	 * Stock LK wants address-cells/size-cells = 2
61550c6c156c37 Bryan O'Donoghue 2023-04-07    20  	 * A number of our drivers want address/size cells = 1
61550c6c156c37 Bryan O'Donoghue 2023-04-07    21  	 * hence the disparity between top-level and /soc below.
61550c6c156c37 Bryan O'Donoghue 2023-04-07    22  	 */
61550c6c156c37 Bryan O'Donoghue 2023-04-07    23  	#address-cells = <2>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07    24  	#size-cells = <2>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07    25  
61550c6c156c37 Bryan O'Donoghue 2023-04-07    26  	clocks {
61550c6c156c37 Bryan O'Donoghue 2023-04-07    27  		xo_board: xo-board {
61550c6c156c37 Bryan O'Donoghue 2023-04-07    28  			compatible = "fixed-clock";
61550c6c156c37 Bryan O'Donoghue 2023-04-07    29  			#clock-cells = <0>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07    30  			clock-frequency = <19200000>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07    31  		};
61550c6c156c37 Bryan O'Donoghue 2023-04-07    32  
61550c6c156c37 Bryan O'Donoghue 2023-04-07    33  		sleep_clk: sleep-clk {
61550c6c156c37 Bryan O'Donoghue 2023-04-07    34  			compatible = "fixed-clock";
61550c6c156c37 Bryan O'Donoghue 2023-04-07    35  			#clock-cells = <0>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07    36  			clock-frequency = <32768>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07    37  		};
61550c6c156c37 Bryan O'Donoghue 2023-04-07    38  	};
61550c6c156c37 Bryan O'Donoghue 2023-04-07    39  
61550c6c156c37 Bryan O'Donoghue 2023-04-07    40  	cpus {
61550c6c156c37 Bryan O'Donoghue 2023-04-07    41  		#address-cells = <1>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07    42  		#size-cells = <0>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07    43  
61550c6c156c37 Bryan O'Donoghue 2023-04-07    44  		CPU0: cpu@100 {
61550c6c156c37 Bryan O'Donoghue 2023-04-07    45  			compatible = "arm,cortex-a53";
61550c6c156c37 Bryan O'Donoghue 2023-04-07    46  			device_type = "cpu";
61550c6c156c37 Bryan O'Donoghue 2023-04-07    47  			enable-method = "spin-table";
61550c6c156c37 Bryan O'Donoghue 2023-04-07    48  			reg = <0x100>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07    49  			next-level-cache = <&L2_1>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07    50  			qcom,acc = <&acc0>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07    51  			qcom,saw = <&saw0>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07    52  			cpu-idle-states = <&CPU_SLEEP_0>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07    53  			clocks = <&apcs1_mbox>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07    54  			#cooling-cells = <2>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07    55  			L2_1: l2-cache {
61550c6c156c37 Bryan O'Donoghue 2023-04-07    56  				compatible = "cache";
61550c6c156c37 Bryan O'Donoghue 2023-04-07    57  				cache-level = <2>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07    58  			};
61550c6c156c37 Bryan O'Donoghue 2023-04-07    59  		};
61550c6c156c37 Bryan O'Donoghue 2023-04-07    60  
61550c6c156c37 Bryan O'Donoghue 2023-04-07    61  		CPU1: cpu@101 {
61550c6c156c37 Bryan O'Donoghue 2023-04-07    62  			compatible = "arm,cortex-a53";
61550c6c156c37 Bryan O'Donoghue 2023-04-07    63  			device_type = "cpu";
61550c6c156c37 Bryan O'Donoghue 2023-04-07    64  			enable-method = "spin-table";
61550c6c156c37 Bryan O'Donoghue 2023-04-07    65  			reg = <0x101>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07    66  			next-level-cache = <&L2_1>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07    67  			qcom,acc = <&acc1>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07    68  			qcom,saw = <&saw1>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07    69  			cpu-idle-states = <&CPU_SLEEP_0>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07    70  			clocks = <&apcs1_mbox>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07    71  			#cooling-cells = <2>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07    72  		};
61550c6c156c37 Bryan O'Donoghue 2023-04-07    73  
61550c6c156c37 Bryan O'Donoghue 2023-04-07    74  		CPU2: cpu@102 {
61550c6c156c37 Bryan O'Donoghue 2023-04-07    75  			compatible = "arm,cortex-a53";
61550c6c156c37 Bryan O'Donoghue 2023-04-07    76  			device_type = "cpu";
61550c6c156c37 Bryan O'Donoghue 2023-04-07    77  			enable-method = "spin-table";
61550c6c156c37 Bryan O'Donoghue 2023-04-07    78  			reg = <0x102>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07    79  			next-level-cache = <&L2_1>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07    80  			qcom,acc = <&acc2>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07    81  			qcom,saw = <&saw2>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07    82  			cpu-idle-states = <&CPU_SLEEP_0>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07    83  			clocks = <&apcs1_mbox>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07    84  			#cooling-cells = <2>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07    85  		};
61550c6c156c37 Bryan O'Donoghue 2023-04-07    86  
61550c6c156c37 Bryan O'Donoghue 2023-04-07    87  		CPU3: cpu@103 {
61550c6c156c37 Bryan O'Donoghue 2023-04-07    88  			compatible = "arm,cortex-a53";
61550c6c156c37 Bryan O'Donoghue 2023-04-07    89  			device_type = "cpu";
61550c6c156c37 Bryan O'Donoghue 2023-04-07    90  			enable-method = "spin-table";
61550c6c156c37 Bryan O'Donoghue 2023-04-07    91  			reg = <0x103>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07    92  			next-level-cache = <&L2_1>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07    93  			qcom,acc = <&acc3>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07    94  			qcom,saw = <&saw3>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07    95  			cpu-idle-states = <&CPU_SLEEP_0>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07    96  			clocks = <&apcs1_mbox>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07    97  			#cooling-cells = <2>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07    98  		};
61550c6c156c37 Bryan O'Donoghue 2023-04-07    99  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   100  		CPU4: cpu@0 {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   101  			compatible = "arm,cortex-a53";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   102  			device_type = "cpu";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   103  			enable-method = "spin-table";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   104  			reg = <0x0>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   105  			qcom,acc = <&acc4>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   106  			qcom,saw = <&saw4>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   107  			cpu-idle-states = <&CPU_SLEEP_0>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   108  			clocks = <&apcs0_mbox>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   109  			#cooling-cells = <2>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   110  			next-level-cache = <&L2_0>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   111  			L2_0: l2-cache {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   112  				compatible = "cache";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   113  				cache-level = <2>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   114  			};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   115  		};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   116  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   117  		CPU5: cpu@1 {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   118  			compatible = "arm,cortex-a53";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   119  			device_type = "cpu";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   120  			enable-method = "spin-table";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   121  			reg = <0x1>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   122  			next-level-cache = <&L2_0>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   123  			qcom,acc = <&acc5>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   124  			qcom,saw = <&saw5>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   125  			cpu-idle-states = <&CPU_SLEEP_0>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   126  			clocks = <&apcs0_mbox>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   127  			#cooling-cells = <2>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   128  		};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   129  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   130  		CPU6: cpu@2 {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   131  			compatible = "arm,cortex-a53";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   132  			device_type = "cpu";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   133  			enable-method = "spin-table";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   134  			reg = <0x2>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   135  			next-level-cache = <&L2_0>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   136  			qcom,acc = <&acc6>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   137  			qcom,saw = <&saw6>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   138  			cpu-idle-states = <&CPU_SLEEP_0>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   139  			clocks = <&apcs0_mbox>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   140  			#cooling-cells = <2>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   141  		};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   142  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   143  		CPU7: cpu@3 {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   144  			compatible = "arm,cortex-a53";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   145  			device_type = "cpu";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   146  			enable-method = "spin-table";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   147  			reg = <0x3>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   148  			next-level-cache = <&L2_0>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   149  			qcom,acc = <&acc7>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   150  			qcom,saw = <&saw7>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   151  			cpu-idle-states = <&CPU_SLEEP_0>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   152  			clocks = <&apcs0_mbox>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   153  			#cooling-cells = <2>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   154  		};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   155  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   156  		idle-states {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   157  			CPU_SLEEP_0: cpu-sleep-0 {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   158  				compatible ="qcom,idle-state-spc", "arm,idle-state";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   159  				entry-latency-us = <130>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   160  				exit-latency-us = <150>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   161  				min-residency-us = <2000>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   162  				local-timer-stop;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   163  			};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   164  		};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   165  	};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   166  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   167  	/*
61550c6c156c37 Bryan O'Donoghue 2023-04-07   168  	 * MSM8939 has a big.LITTLE heterogeneous computing architecture,
61550c6c156c37 Bryan O'Donoghue 2023-04-07   169  	 * consisting of two clusters of four ARM Cortex-A53s each. The
61550c6c156c37 Bryan O'Donoghue 2023-04-07   170  	 * LITTLE cluster runs at 1.0-1.2GHz, and the big cluster runs
61550c6c156c37 Bryan O'Donoghue 2023-04-07   171  	 * at 1.5-1.7GHz.
61550c6c156c37 Bryan O'Donoghue 2023-04-07   172  	 *
61550c6c156c37 Bryan O'Donoghue 2023-04-07   173  	 * The enable method used here is spin-table which presupposes use
61550c6c156c37 Bryan O'Donoghue 2023-04-07   174  	 * of a 2nd stage boot shim such as lk2nd to have installed a
61550c6c156c37 Bryan O'Donoghue 2023-04-07   175  	 * spin-table, the downstream non-psci/non-spin-table method that
61550c6c156c37 Bryan O'Donoghue 2023-04-07   176  	 * default msm8916/msm8936/msm8939 will not be supported upstream.
61550c6c156c37 Bryan O'Donoghue 2023-04-07   177  	 */
61550c6c156c37 Bryan O'Donoghue 2023-04-07   178  	cpu-map {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   179  		/* LITTLE (efficiency) cluster */
61550c6c156c37 Bryan O'Donoghue 2023-04-07   180  		cluster0 {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   181  			core0 {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   182  				cpu = <&CPU4>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   183  			};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   184  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   185  			core1 {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   186  				cpu = <&CPU5>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   187  			};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   188  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   189  			core2 {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   190  				cpu = <&CPU6>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   191  			};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   192  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   193  			core3 {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   194  				cpu = <&CPU7>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   195  			};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   196  		};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   197  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   198  		/* big (performance) cluster */
61550c6c156c37 Bryan O'Donoghue 2023-04-07   199  		/* Boot CPU is cluster 1 core 0 */
61550c6c156c37 Bryan O'Donoghue 2023-04-07   200  		cluster1 {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   201  			core0 {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   202  				cpu = <&CPU0>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   203  			};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   204  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   205  			core1 {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   206  				cpu = <&CPU1>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   207  			};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   208  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   209  			core2 {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   210  				cpu = <&CPU2>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   211  			};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   212  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   213  			core3 {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   214  				cpu = <&CPU3>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   215  			};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   216  		};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   217  	};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   218  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   219  	firmware {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   220  		scm: scm {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   221  			compatible = "qcom,scm-msm8916", "qcom,scm";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   222  			clocks = <&gcc GCC_CRYPTO_CLK>,
61550c6c156c37 Bryan O'Donoghue 2023-04-07   223  				 <&gcc GCC_CRYPTO_AXI_CLK>,
61550c6c156c37 Bryan O'Donoghue 2023-04-07   224  				 <&gcc GCC_CRYPTO_AHB_CLK>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   225  			clock-names = "core", "bus", "iface";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   226  			#reset-cells = <1>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   227  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   228  			qcom,dload-mode = <&tcsr 0x6100>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   229  		};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   230  	};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   231  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   232  	memory@80000000 {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   233  		device_type = "memory";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   234  		/* We expect the bootloader to fill in the reg */
61550c6c156c37 Bryan O'Donoghue 2023-04-07   235  		reg = <0x0 0x80000000 0x0 0x0>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   236  	};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   237  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   238  	pmu {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   239  		compatible = "arm,cortex-a53-pmu";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   240  		interrupts = <GIC_PPI 7 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   241  	};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   242  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   243  	reserved-memory {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   244  		#address-cells = <2>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   245  		#size-cells = <2>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   246  		ranges;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   247  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   248  		tz-apps@86000000 {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   249  			reg = <0x0 0x86000000 0x0 0x300000>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   250  			no-map;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   251  		};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   252  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   253  		smem@86300000 {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   254  			compatible = "qcom,smem";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   255  			reg = <0x0 0x86300000 0x0 0x100000>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   256  			no-map;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   257  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   258  			hwlocks = <&tcsr_mutex 3>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   259  			qcom,rpm-msg-ram = <&rpm_msg_ram>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   260  		};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   261  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   262  		hypervisor@86400000 {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   263  			reg = <0x0 0x86400000 0x0 0x100000>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   264  			no-map;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   265  		};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   266  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   267  		tz@86500000 {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   268  			reg = <0x0 0x86500000 0x0 0x180000>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   269  			no-map;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   270  		};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   271  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   272  		reserved@86680000 {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   273  			reg = <0x0 0x86680000 0x0 0x80000>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   274  			no-map;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   275  		};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   276  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   277  		rmtfs@86700000 {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   278  			compatible = "qcom,rmtfs-mem";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   279  			reg = <0x0 0x86700000 0x0 0xe0000>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   280  			no-map;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   281  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   282  			qcom,client-id = <1>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   283  		};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   284  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   285  		rfsa@867e0000 {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   286  			reg = <0x0 0x867e0000 0x0 0x20000>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   287  			no-map;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   288  		};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   289  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   290  		mpss_mem: mpss@86800000 {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   291  			reg = <0x0 0x86800000 0x0 0x5500000>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   292  			no-map;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   293  		};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   294  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   295  		wcnss_mem: wcnss@8bd00000 {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   296  			reg = <0x0 0x8bd00000 0x0 0x600000>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   297  			no-map;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   298  		};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   299  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   300  		venus_mem: venus@8c300000 {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   301  			reg = <0x0 0x8c300000 0x0 0x800000>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   302  			no-map;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   303  		};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   304  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   305  		mba_mem: mba@8cb00000 {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   306  			reg = <0x0 0x8cb00000 0x0 0x100000>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   307  			no-map;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   308  		};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   309  	};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   310  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   311  	smd {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   312  		compatible = "qcom,smd";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   313  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   314  		rpm {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   315  			interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   316  			qcom,ipc = <&apcs1_mbox 8 0>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   317  			qcom,smd-edge = <15>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   318  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   319  			rpm_requests: rpm-requests {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   320  				compatible = "qcom,rpm-msm8936";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   321  				qcom,smd-channels = "rpm_requests";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   322  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   323  				rpmcc: clock-controller {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   324  					compatible = "qcom,rpmcc-msm8936", "qcom,rpmcc";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   325  					#clock-cells = <1>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   326  					clock-names = "xo";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   327  					clocks = <&xo_board>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   328  				};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   329  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   330  				rpmpd: power-controller {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   331  					compatible = "qcom,msm8939-rpmpd";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   332  					#power-domain-cells = <1>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   333  					operating-points-v2 = <&rpmpd_opp_table>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   334  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   335  					rpmpd_opp_table: opp-table {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   336  						compatible = "operating-points-v2";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   337  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   338  						rpmpd_opp_ret: opp1 {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   339  							opp-level = <1>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   340  						};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   341  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   342  						rpmpd_opp_svs_krait: opp2 {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   343  							opp-level = <2>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   344  						};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   345  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   346  						rpmpd_opp_svs_soc: opp3 {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   347  							opp-level = <3>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   348  						};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   349  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   350  						rpmpd_opp_nom: opp4 {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   351  							opp-level = <4>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   352  						};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   353  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   354  						rpmpd_opp_turbo: opp5 {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   355  							opp-level = <5>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   356  						};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   357  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   358  						rpmpd_opp_super_turbo: opp6 {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   359  							opp-level = <6>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   360  						};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   361  					};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   362  				};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   363  			};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   364  		};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   365  	};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   366  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   367  	smp2p-hexagon {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   368  		compatible = "qcom,smp2p";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   369  		qcom,smem = <435>, <428>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   370  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   371  		interrupts = <GIC_SPI 27 IRQ_TYPE_EDGE_RISING>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   372  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   373  		mboxes = <&apcs1_mbox 14>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   374  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   375  		qcom,local-pid = <0>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   376  		qcom,remote-pid = <1>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   377  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   378  		hexagon_smp2p_out: master-kernel {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   379  			qcom,entry-name = "master-kernel";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   380  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   381  			#qcom,smem-state-cells = <1>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   382  		};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   383  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   384  		hexagon_smp2p_in: slave-kernel {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   385  			qcom,entry-name = "slave-kernel";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   386  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   387  			interrupt-controller;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   388  			#interrupt-cells = <2>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   389  			#address-cells = <0>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   390  			#size-cells = <0>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   391  		};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   392  	};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   393  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   394  	smp2p-wcnss {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   395  		compatible = "qcom,smp2p";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   396  		qcom,smem = <451>, <431>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   397  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   398  		interrupts = <GIC_SPI 143 IRQ_TYPE_EDGE_RISING>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   399  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   400  		mboxes = <&apcs1_mbox 18>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   401  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   402  		qcom,local-pid = <0>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   403  		qcom,remote-pid = <4>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   404  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   405  		wcnss_smp2p_in: slave-kernel {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   406  			qcom,entry-name = "slave-kernel";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   407  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   408  			interrupt-controller;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   409  			#interrupt-cells = <2>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   410  		};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   411  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   412  		wcnss_smp2p_out: master-kernel {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   413  			qcom,entry-name = "master-kernel";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   414  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   415  			#qcom,smem-state-cells = <1>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   416  		};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   417  	};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   418  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   419  	smsm {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   420  		compatible = "qcom,smsm";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   421  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   422  		#address-cells = <1>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   423  		#size-cells = <0>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   424  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   425  		qcom,ipc-1 = <&apcs1_mbox 8 13>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   426  		qcom,ipc-3 = <&apcs1_mbox 8 19>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   427  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   428  		apps_smsm: apps@0 {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   429  			reg = <0>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   430  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   431  			#qcom,smem-state-cells = <1>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   432  		};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   433  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   434  		hexagon_smsm: hexagon@1 {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   435  			reg = <1>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   436  			interrupts = <GIC_SPI 26 IRQ_TYPE_EDGE_RISING>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   437  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   438  			interrupt-controller;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   439  			#interrupt-cells = <2>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   440  		};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   441  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   442  		wcnss_smsm: wcnss@6 {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   443  			reg = <6>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   444  			interrupts = <GIC_SPI 144 IRQ_TYPE_EDGE_RISING>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   445  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   446  			interrupt-controller;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   447  			#interrupt-cells = <2>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   448  		};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   449  	};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   450  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   451  	soc: soc@0 {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   452  		compatible = "simple-bus";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   453  		#address-cells = <1>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   454  		#size-cells = <1>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   455  		ranges = <0 0 0 0xffffffff>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   456  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   457  		rng@22000 {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   458  			compatible = "qcom,prng";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   459  			reg = <0x00022000 0x200>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   460  			clocks = <&gcc GCC_PRNG_AHB_CLK>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   461  			clock-names = "core";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   462  		};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   463  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   464  		qfprom: qfprom@5c000 {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   465  			compatible = "qcom,msm8916-qfprom", "qcom,qfprom";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   466  			reg = <0x0005c000 0x1000>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   467  			#address-cells = <1>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   468  			#size-cells = <1>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   469  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   470  			tsens_base1: base1@a0 {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   471  				reg = <0xa0 0x1>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   472  				bits = <0 8>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   473  			};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   474  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   475  			tsens_s6_p1: s6-p1@a1 {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   476  				reg = <0xa1 0x1>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   477  				bits = <0 6>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   478  			};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   479  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   480  			tsens_s6_p2: s6-p2@a1 {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   481  				reg = <0xa1 0x2>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   482  				bits = <6 6>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   483  			};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   484  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   485  			tsens_s7_p1: s7-p1@a2 {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   486  				reg = <0xa2 0x2>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   487  				bits = <4 6>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   488  			};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   489  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   490  			tsens_s7_p2: s7-p2@a3 {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   491  				reg = <0xa3 0x1>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   492  				bits = <2 6>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   493  			};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   494  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   495  			tsens_s8_p1: s8-p1@a4 {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   496  				reg = <0xa4 0x1>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   497  				bits = <0 6>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   498  			};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   499  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   500  			tsens_s8_p2: s8-p2@a4 {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   501  				reg = <0xa4 0x2>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   502  				bits = <6 6>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   503  			};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   504  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   505  			tsens_s9_p1: s9-p1@a5 {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   506  				reg = <0xa5 0x2>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   507  				bits = <4 6>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   508  			};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   509  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   510  			tsens_s9_p2: s9-p2@a6 {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   511  				reg = <0xa6 0x1>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   512  				bits = <2 6>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   513  			};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   514  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   515  			tsens_base2: base2@a7 {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   516  				reg = <0xa7 0x1>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   517  				bits = <0 8>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   518  			};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   519  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   520  			tsens_mode: mode@d0 {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   521  				reg = <0xd0 0x1>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   522  				bits = <0 3>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   523  			};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   524  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   525  			tsens_s0_p1: s0-p1@d0 {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   526  				reg = <0xd0 0x2>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   527  				bits = <3 6>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   528  			};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   529  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   530  			tsens_s0_p2: s0-p1@d1 {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   531  				reg = <0xd1 0x1>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   532  				bits = <1 6>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   533  			};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   534  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   535  			tsens_s1_p1: s1-p1@d1 {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   536  				reg = <0xd1 0x2>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   537  				bits = <7 6>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   538  			};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   539  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   540  			tsens_s1_p2: s1-p2@d2 {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   541  				reg = <0xd2 0x2>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   542  				bits = <5 6>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   543  			};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   544  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   545  			tsens_s2_p1: s2-p1@d3 {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   546  				reg = <0xd3 0x2>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   547  				bits = <3 6>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   548  			};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   549  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   550  			tsens_s2_p2: s2-p2@d4 {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   551  				reg = <0xd4 0x1>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   552  				bits = <1 6>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   553  			};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   554  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   555  			tsens_s3_p1: s3-p1@d4 {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   556  				reg = <0xd4 0x2>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   557  				bits = <7 6>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   558  			};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   559  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   560  			tsens_s3_p2: s3-p2@d5 {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   561  				reg = <0xd5 0x2>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   562  				bits = <5 6>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   563  			};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   564  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   565  			tsens_s5_p1: s5-p1@d6 {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   566  				reg = <0xd6 0x2>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   567  				bits = <3 6>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   568  			};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   569  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   570  			tsens_s5_p2: s5-p2@d7 {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   571  				reg = <0xd7 0x1>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   572  				bits = <1 6>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   573  			};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   574  		};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   575  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   576  		rpm_msg_ram: sram@60000 {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   577  			compatible = "qcom,rpm-msg-ram";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   578  			reg = <0x00060000 0x8000>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   579  		};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   580  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   581  		bimc: interconnect@400000 {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   582  			compatible = "qcom,msm8939-bimc";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   583  			reg = <0x00400000 0x62000>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   584  			clock-names = "bus", "bus_a";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   585  			clocks = <&rpmcc RPM_SMD_BIMC_CLK>,
61550c6c156c37 Bryan O'Donoghue 2023-04-07   586  				 <&rpmcc RPM_SMD_BIMC_A_CLK>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   587  			#interconnect-cells = <1>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   588  		};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   589  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   590  		tsens: thermal-sensor@4a9000 {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   591  			compatible = "qcom,msm8939-tsens", "qcom,tsens-v0_1";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   592  			reg = <0x004a9000 0x1000>, /* TM */
61550c6c156c37 Bryan O'Donoghue 2023-04-07   593  			      <0x004a8000 0x1000>; /* SROT */
61550c6c156c37 Bryan O'Donoghue 2023-04-07   594  			nvmem-cells = <&tsens_mode>,
61550c6c156c37 Bryan O'Donoghue 2023-04-07   595  				      <&tsens_base1>, <&tsens_base2>,
61550c6c156c37 Bryan O'Donoghue 2023-04-07   596  				      <&tsens_s0_p1>, <&tsens_s0_p2>,
61550c6c156c37 Bryan O'Donoghue 2023-04-07   597  				      <&tsens_s1_p1>, <&tsens_s1_p2>,
61550c6c156c37 Bryan O'Donoghue 2023-04-07   598  				      <&tsens_s2_p1>, <&tsens_s2_p2>,
61550c6c156c37 Bryan O'Donoghue 2023-04-07   599  				      <&tsens_s3_p1>, <&tsens_s3_p2>,
61550c6c156c37 Bryan O'Donoghue 2023-04-07   600  				      <&tsens_s5_p1>, <&tsens_s5_p2>,
61550c6c156c37 Bryan O'Donoghue 2023-04-07   601  				      <&tsens_s6_p1>, <&tsens_s6_p2>,
61550c6c156c37 Bryan O'Donoghue 2023-04-07   602  				      <&tsens_s7_p1>, <&tsens_s7_p2>,
61550c6c156c37 Bryan O'Donoghue 2023-04-07   603  				      <&tsens_s8_p1>, <&tsens_s8_p2>,
61550c6c156c37 Bryan O'Donoghue 2023-04-07   604  				      <&tsens_s9_p1>, <&tsens_s9_p2>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   605  			nvmem-cell-names = "mode",
61550c6c156c37 Bryan O'Donoghue 2023-04-07   606  					   "base1", "base2",
61550c6c156c37 Bryan O'Donoghue 2023-04-07   607  					   "s0_p1", "s0_p2",
61550c6c156c37 Bryan O'Donoghue 2023-04-07   608  					   "s1_p1", "s1_p2",
61550c6c156c37 Bryan O'Donoghue 2023-04-07   609  					   "s2_p1", "s2_p2",
61550c6c156c37 Bryan O'Donoghue 2023-04-07   610  					   "s3_p1", "s3_p2",
61550c6c156c37 Bryan O'Donoghue 2023-04-07   611  					   "s5_p1", "s5_p2",
61550c6c156c37 Bryan O'Donoghue 2023-04-07   612  					   "s6_p1", "s6_p2",
61550c6c156c37 Bryan O'Donoghue 2023-04-07   613  					   "s7_p1", "s7_p2",
61550c6c156c37 Bryan O'Donoghue 2023-04-07   614  					   "s8_p1", "s8_p2",
61550c6c156c37 Bryan O'Donoghue 2023-04-07   615  					   "s9_p1", "s9_p2";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   616  			#qcom,sensors = <9>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   617  			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   618  			interrupt-names = "uplow";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   619  			#thermal-sensor-cells = <1>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   620  		};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   621  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   622  		restart@4ab000 {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   623  			compatible = "qcom,pshold";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   624  			reg = <0x004ab000 0x4>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   625  		};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   626  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   627  		pcnoc: interconnect@500000 {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   628  			compatible = "qcom,msm8939-pcnoc";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   629  			reg = <0x00500000 0x11000>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   630  			clock-names = "bus", "bus_a";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   631  			clocks = <&rpmcc RPM_SMD_PCNOC_CLK>,
61550c6c156c37 Bryan O'Donoghue 2023-04-07   632  				 <&rpmcc RPM_SMD_PCNOC_A_CLK>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   633  			#interconnect-cells = <1>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   634  		};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   635  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   636  		snoc: interconnect@580000 {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   637  			compatible = "qcom,msm8939-snoc";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   638  			reg = <0x00580000 0x14080>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   639  			clock-names = "bus", "bus_a";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   640  			clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
61550c6c156c37 Bryan O'Donoghue 2023-04-07   641  				 <&rpmcc RPM_SMD_SNOC_A_CLK>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   642  			#interconnect-cells = <1>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   643  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   644  			snoc_mm: interconnect-snoc {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   645  				compatible = "qcom,msm8939-snoc-mm";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   646  				clock-names = "bus", "bus_a";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   647  				clocks = <&rpmcc RPM_SMD_SYSMMNOC_CLK>,
61550c6c156c37 Bryan O'Donoghue 2023-04-07   648  					 <&rpmcc RPM_SMD_SYSMMNOC_A_CLK>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   649  				#interconnect-cells = <1>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   650  			};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   651  		};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   652  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   653  		tlmm: pinctrl@1000000 {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   654  			compatible = "qcom,msm8916-pinctrl";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   655  			reg = <0x01000000 0x300000>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   656  			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   657  			gpio-controller;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   658  			gpio-ranges = <&tlmm 0 0 122>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   659  			#gpio-cells = <2>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   660  			interrupt-controller;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   661  			#interrupt-cells = <2>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   662  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   663  			blsp1_uart1_default: blsp1-uart1-default-state {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   664  				pins = "gpio0", "gpio1", "gpio2", "gpio3";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   665  				function = "blsp_uart1";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   666  				drive-strength = <16>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   667  				bias-disable;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   668  			};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   669  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   670  			blsp1_uart1_sleep: blsp1-uart1-sleep-state {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   671  				pins = "gpio0", "gpio1", "gpio2", "gpio3";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   672  				function = "gpio";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   673  				drive-strength = <2>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   674  				bias-pull-down;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   675  			};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   676  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   677  			blsp1_uart2_default: blsp1-uart2-default-state {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   678  				pins = "gpio4", "gpio5";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   679  				function = "blsp_uart2";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   680  				drive-strength = <16>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   681  				bias-disable;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   682  			};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   683  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   684  			blsp1_uart2_sleep: blsp1-uart2-sleep-state {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   685  				pins = "gpio4", "gpio5";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   686  				function = "gpio";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   687  				drive-strength = <2>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   688  				bias-pull-down;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   689  			};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   690  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   691  			camera_front_default: camera-front-default-state {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   692  				pwdn-pins {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   693  					pins = "gpio33";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   694  					function = "gpio";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   695  					drive-strength = <16>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   696  					bias-disable;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   697  				};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   698  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   699  				rst-pins {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   700  					pins = "gpio28";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   701  					function = "gpio";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   702  					drive-strength = <16>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   703  					bias-disable;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   704  				};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   705  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   706  				mclk1-pins {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   707  					pins = "gpio27";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   708  					function = "cam_mclk1";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   709  					drive-strength = <16>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   710  					bias-disable;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   711  				};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   712  			};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   713  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   714  			camera_rear_default: camera-rear-default-state {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   715  				pwdn-pins {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   716  					pins = "gpio34";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   717  					function = "gpio";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   718  					drive-strength = <16>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   719  					bias-disable;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   720  				};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   721  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   722  				rst-pins {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   723  					pins = "gpio35";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   724  					function = "gpio";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   725  					drive-strength = <16>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   726  					bias-disable;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   727  				};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   728  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   729  				mclk0-pins {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   730  					pins = "gpio26";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   731  					function = "cam_mclk0";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   732  					drive-strength = <16>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   733  					bias-disable;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   734  				};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   735  			};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   736  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   737  			cci0_default: cci0-default-state {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   738  				pins = "gpio29", "gpio30";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   739  				function = "cci_i2c";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   740  				drive-strength = <16>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   741  				bias-disable;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   742  			};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   743  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   744  			cdc_pdm_lines_default: pdm-lines-default-state {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   745  				pins = "gpio63", "gpio64", "gpio65", "gpio66",
61550c6c156c37 Bryan O'Donoghue 2023-04-07   746  				       "gpio67", "gpio68";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   747  				function = "cdc_pdm0";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   748  				drive-strength = <8>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   749  				bias-disable;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   750  			};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   751  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   752  			cdc_pdm_lines_sleep: pdm-lines-suspend-state {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   753  				pins = "gpio63", "gpio64", "gpio65", "gpio66",
61550c6c156c37 Bryan O'Donoghue 2023-04-07   754  				       "gpio67", "gpio68";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   755  				function = "cdc_pdm0";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   756  				drive-strength = <2>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   757  				bias-pull-down;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   758  			};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   759  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   760  			cdc_dmic_lines_act: cdc-dmic-lines-on-state {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   761  				clk-pins {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   762  					pins = "gpio0";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   763  					function = "dmic0_clk";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   764  					drive-strength = <8>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   765  				};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   766  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   767  				data-pins {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   768  					pins = "gpio1";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   769  					function = "dmic0_data";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   770  					drive-strength = <8>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   771  				};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   772  			};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   773  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   774  			cdc_dmic_lines_sus: cdc-dmic-lines-off-state {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   775  				clk-pins {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   776  					pins = "gpio0";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   777  					function = "dmic0_clk";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   778  					drive-strength = <2>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   779  					bias-disable;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   780  				};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   781  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   782  				data-pins {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   783  					pins = "gpio1";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   784  					function = "dmic0_data";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   785  					drive-strength = <2>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   786  					bias-disable;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   787  				};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   788  			};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   789  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   790  			ext-mclk-tlmm-lines-state {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   791  				ext_mclk_tlmm_lines_act: mclk-lines-on-pins {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   792  					pins = "gpio116";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   793  					function = "pri_mi2s";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   794  					drive-strength = <8>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   795  					bias-disable;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   796  				};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   797  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   798  				ext_mclk_tlmm_lines_sus: mclk-lines-off-pins {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   799  					pins = "gpio116";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   800  					function = "pri_mi2s";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   801  					drive-strength = <2>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   802  					bias-disable;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   803  				};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   804  			};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   805  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   806  			ext-pri-tlmm-lines-state {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   807  				ext_pri_tlmm_lines_act: ext-pa-on-pins {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   808  					pins = "gpio113", "gpio114", "gpio115", "gpio116";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   809  					function = "pri_mi2s";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   810  					drive-strength = <8>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   811  					bias-disable;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   812  				};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   813  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   814  				ext_pri_tlmm_lines_sus: ext-pa-off-pins {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   815  					pins = "gpio113", "gpio114", "gpio115", "gpio116";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   816  					function = "pri_mi2s";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   817  					drive-strength = <2>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   818  					bias-disable;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   819  				};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   820  			};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   821  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   822  			ext-pri-ws-line-state {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   823  				ext_pri_ws_act: ext-pa-on-pins {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   824  					pins = "gpio110";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   825  					function = "pri_mi2s_ws";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   826  					drive-strength = <8>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   827  					bias-disable;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   828  				};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   829  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   830  				ext_pri_ws_sus: ext-pa-off-pins {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   831  					pins = "gpio110";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   832  					function = "pri_mi2s_ws";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   833  					drive-strength = <2>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   834  					bias-disable;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   835  				};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   836  			};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   837  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   838  			/* secondary Mi2S */
61550c6c156c37 Bryan O'Donoghue 2023-04-07   839  			ext-sec-tlmm-lines-state {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   840  				ext_sec_tlmm_lines_act: tlmm-lines-on-pins {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   841  					pins = "gpio112", "gpio117", "gpio118", "gpio119";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   842  					function = "sec_mi2s";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   843  					drive-strength = <8>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   844  					bias-disable;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   845  				};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   846  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   847  				ext_sec_tlmm_lines_sus: tlmm-lines-off-pins {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   848  					pins = "gpio112", "gpio117", "gpio118", "gpio119";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   849  					function = "sec_mi2s";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   850  					drive-strength = <2>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   851  					bias-disable;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   852  				};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   853  			};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   854  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   855  			i2c1_default: i2c1-default-state {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   856  				pins = "gpio2", "gpio3";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   857  				function = "blsp_i2c1";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   858  				drive-strength = <2>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   859  				bias-disable;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   860  			};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   861  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   862  			i2c1_sleep: i2c1-sleep-state {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   863  				pins = "gpio2", "gpio3";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   864  				function = "gpio";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   865  				drive-strength = <2>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   866  				bias-disable;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   867  			};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   868  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   869  			i2c2_default: i2c2-default-state {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   870  				pins = "gpio6", "gpio7";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   871  				function = "blsp_i2c2";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   872  				drive-strength = <2>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   873  				bias-disable;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   874  			};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   875  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   876  			i2c2_sleep: i2c2-sleep-state {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   877  				pins = "gpio6", "gpio7";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   878  				function = "gpio";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   879  				drive-strength = <2>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   880  				bias-disable;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   881  			};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   882  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   883  			i2c3_default: i2c3-default-state {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   884  				pins = "gpio10", "gpio11";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   885  				function = "blsp_i2c3";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   886  				drive-strength = <2>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   887  				bias-disable;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   888  			};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   889  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   890  			i2c3_sleep: i2c3-sleep-state {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   891  				pins = "gpio10", "gpio11";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   892  				function = "gpio";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   893  				drive-strength = <2>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   894  				bias-disable;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   895  			};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   896  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   897  			i2c4_default: i2c4-default-state {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   898  				pins = "gpio14", "gpio15";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   899  				function = "blsp_i2c4";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   900  				drive-strength = <2>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   901  				bias-disable;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   902  			};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   903  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   904  			i2c4_sleep: i2c4-sleep-state {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   905  				pins = "gpio14", "gpio15";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   906  				function = "gpio";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   907  				drive-strength = <2>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   908  				bias-disable;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   909  			};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   910  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   911  			i2c5_default: i2c5-default-state {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   912  				pins = "gpio18", "gpio19";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   913  				function = "blsp_i2c5";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   914  				drive-strength = <2>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   915  				bias-disable;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   916  			};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   917  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   918  			i2c5_sleep: i2c5-sleep-state {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   919  				pins = "gpio18", "gpio19";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   920  				function = "gpio";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   921  				drive-strength = <2>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   922  				bias-disable;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   923  			};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   924  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   925  			i2c6_default: i2c6-default-state {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   926  				pins = "gpio22", "gpio23";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   927  				function = "blsp_i2c6";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   928  				drive-strength = <2>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   929  				bias-disable;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   930  			};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   931  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   932  			i2c6_sleep: i2c6-sleep-state {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   933  				pins = "gpio22", "gpio23";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   934  				function = "gpio";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   935  				drive-strength = <2>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   936  				bias-disable;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   937  			};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   938  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   939  			sdc1_default_state: sdc1-default-state {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   940  				clk-pins {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   941  					pins = "sdc1_clk";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   942  					bias-disable;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   943  					drive-strength = <16>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   944  				};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   945  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   946  				cmd-pins {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   947  					pins = "sdc1_cmd";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   948  					bias-pull-up;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   949  					drive-strength = <10>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   950  				};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   951  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   952  				data-pins {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   953  					pins = "sdc1_data";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   954  					bias-pull-up;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   955  					drive-strength = <10>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   956  				};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   957  			};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   958  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   959  			sdc1_sleep_state: sdc1-sleep-state {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   960  				clk-pins {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   961  					pins = "sdc1_clk";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   962  					bias-disable;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   963  					drive-strength = <2>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   964  				};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   965  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   966  				cmd-pins {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   967  					pins = "sdc1_cmd";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   968  					bias-pull-up;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   969  					drive-strength = <2>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   970  				};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   971  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   972  				data-pins {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   973  					pins = "sdc1_data";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   974  					bias-pull-up;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   975  					drive-strength = <2>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   976  				};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   977  			};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   978  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   979  			sdc2_default_state: sdc2-default-state {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   980  				clk-pins {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   981  					pins = "sdc2_clk";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   982  					bias-disable;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   983  					drive-strength = <16>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   984  				};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   985  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   986  				cmd-pins {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   987  					pins = "sdc2_cmd";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   988  					bias-pull-up;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   989  					drive-strength = <10>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   990  				};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   991  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   992  				data-pins {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   993  					pins = "sdc2_data";
61550c6c156c37 Bryan O'Donoghue 2023-04-07   994  					bias-pull-up;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   995  					drive-strength = <10>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07   996  				};
61550c6c156c37 Bryan O'Donoghue 2023-04-07   997  
61550c6c156c37 Bryan O'Donoghue 2023-04-07   998  				cd-pins {
61550c6c156c37 Bryan O'Donoghue 2023-04-07   999  					pins = "gpio38";
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1000  					function = "gpio";
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1001  					drive-strength = <2>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1002  					bias-pull-up;
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1003  				};
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1004  			};
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1005  
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1006  			sdc2_sleep_state: sdc2-sleep-state {
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1007  				clk-pins {
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1008  					pins = "sdc2_clk";
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1009  					bias-disable;
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1010  					drive-strength = <2>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1011  				};
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1012  
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1013  				cmd-pins {
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1014  					pins = "sdc2_cmd";
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1015  					bias-pull-up;
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1016  					drive-strength = <2>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1017  				};
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1018  
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1019  				data-pins {
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1020  					pins = "sdc2_data";
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1021  					bias-pull-up;
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1022  					drive-strength = <2>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1023  				};
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1024  
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1025  				cd-pins {
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1026  					pins = "gpio38";
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1027  					function = "gpio";
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1028  					drive-strength = <2>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1029  					bias-disable;
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1030  				};
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1031  			};
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1032  
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1033  			spi1_default: spi1-default-state {
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1034  				spi-pins {
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1035  					pins = "gpio0", "gpio1", "gpio3";
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1036  					function = "blsp_spi1";
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1037  					drive-strength = <12>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1038  					bias-disable;
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1039  				};
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1040  
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1041  				cs-pins {
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1042  					pins = "gpio2";
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1043  					function = "gpio";
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1044  					drive-strength = <16>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1045  					bias-disable;
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1046  					output-high;
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1047  				};
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1048  			};
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1049  
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1050  			spi1_sleep: spi1-sleep-state {
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1051  				pins = "gpio0", "gpio1", "gpio2", "gpio3";
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1052  				function = "gpio";
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1053  				drive-strength = <2>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1054  				bias-pull-down;
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1055  			};
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1056  
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1057  			spi2_default: spi2-default-state {
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1058  				spi-pins {
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1059  					pins = "gpio4", "gpio5", "gpio7";
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1060  					function = "blsp_spi2";
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1061  					drive-strength = <12>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1062  					bias-disable;
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1063  				};
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1064  
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1065  				cs-pins {
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1066  					pins = "gpio6";
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1067  					function = "gpio";
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1068  					drive-strength = <16>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1069  					bias-disable;
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1070  					output-high;
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1071  				};
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1072  			};
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1073  
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1074  			spi2_sleep: spi2-sleep-state {
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1075  				pins = "gpio4", "gpio5", "gpio6", "gpio7";
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1076  				function = "gpio";
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1077  				drive-strength = <2>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1078  				bias-pull-down;
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1079  			};
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1080  
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1081  			spi3_default: spi3-default-state {
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1082  				spi-pins {
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1083  					pins = "gpio8", "gpio9", "gpio11";
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1084  					function = "blsp_spi3";
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1085  					drive-strength = <12>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1086  					bias-disable;
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1087  				};
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1088  
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1089  				cs-pins {
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1090  					pins = "gpio10";
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1091  					function = "gpio";
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1092  					drive-strength = <16>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1093  					bias-disable;
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1094  					output-high;
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1095  				};
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1096  			};
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1097  
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1098  			spi3_sleep: spi3-sleep-state {
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1099  				pins = "gpio8", "gpio9", "gpio10", "gpio11";
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1100  				function = "gpio";
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1101  				drive-strength = <2>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1102  				bias-pull-down;
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1103  			};
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1104  
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1105  			spi4_default: spi4-default-state {
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1106  				spi-pins {
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1107  					pins = "gpio12", "gpio13", "gpio15";
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1108  					function = "blsp_spi4";
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1109  					drive-strength = <12>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1110  					bias-disable;
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1111  				};
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1112  
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1113  				cs-pins {
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1114  					pins = "gpio14";
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1115  					function = "gpio";
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1116  					drive-strength = <16>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1117  					bias-disable;
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1118  					output-high;
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1119  				};
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1120  			};
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1121  
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1122  			spi4_sleep: spi4-sleep-state {
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1123  				pins = "gpio12", "gpio13", "gpio14", "gpio15";
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1124  				function = "gpio";
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1125  				drive-strength = <2>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1126  				bias-pull-down;
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1127  			};
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1128  
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1129  			spi5_default: spi5-default-state {
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1130  				spi-pins {
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1131  					pins = "gpio16", "gpio17", "gpio19";
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1132  					function = "blsp_spi5";
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1133  					drive-strength = <12>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1134  					bias-disable;
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1135  				};
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1136  
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1137  				cs-pins {
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1138  					pins = "gpio18";
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1139  					function = "gpio";
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1140  					drive-strength = <16>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1141  					bias-disable;
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1142  					output-high;
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1143  				};
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1144  			};
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1145  
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1146  			spi5_sleep: spi5-sleep-state {
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1147  				pins = "gpio16", "gpio17", "gpio18", "gpio19";
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1148  				function = "gpio";
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1149  				drive-strength = <2>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1150  				bias-pull-down;
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1151  			};
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1152  
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1153  			spi6_default: spi6-default-state {
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1154  				spi-pins {
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1155  					pins = "gpio20", "gpio21", "gpio23";
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1156  					function = "blsp_spi6";
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1157  					drive-strength = <12>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1158  					bias-disable;
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1159  				};
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1160  
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1161  				cs-pins {
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1162  					pins = "gpio22";
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1163  					function = "gpio";
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1164  					drive-strength = <16>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1165  					bias-disable;
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1166  					output-high;
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1167  				};
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1168  			};
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1169  
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1170  			spi6_sleep: spi6-sleep-state {
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1171  				pins = "gpio20", "gpio21", "gpio22", "gpio23";
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1172  				function = "gpio";
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1173  				drive-strength = <2>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1174  				bias-pull-down;
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1175  			};
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1176  
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1177  			wcnss_pin_a: wcnss-active-state {
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1178  				pins = "gpio40", "gpio41", "gpio42", "gpio43", "gpio44";
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1179  				function = "wcss_wlan";
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1180  				drive-strength = <6>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1181  				bias-pull-up;
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1182  			};
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1183  		};
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1184  
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1185  		gcc: clock-controller@1800000 {
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1186  			compatible = "qcom,gcc-msm8939";
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1187  			reg = <0x01800000 0x80000>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1188  			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1189  				 <&sleep_clk>,
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1190  				 <&dsi_phy0 1>,
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1191  				 <&dsi_phy0 0>,
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1192  				 <0>,
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1193  				 <0>,
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1194  				 <0>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1195  			clock-names = "xo",
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1196  				      "sleep_clk",
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1197  				      "dsi0pll",
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1198  				      "dsi0pllbyte",
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1199  				      "ext_mclk",
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1200  				      "ext_pri_i2s",
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1201  				      "ext_sec_i2s";
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1202  			#clock-cells = <1>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1203  			#reset-cells = <1>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1204  			#power-domain-cells = <1>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1205  		};
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1206  
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1207  		tcsr_mutex: hwlock@1905000 {
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1208  			compatible = "qcom,tcsr-mutex";
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1209  			reg = <0x01905000 0x20000>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1210  			#hwlock-cells = <1>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1211  		};
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1212  
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1213  		tcsr: syscon@1937000 {
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1214  			compatible = "qcom,tcsr-msm8916", "syscon";
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1215  			reg = <0x01937000 0x30000>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1216  		};
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1217  
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1218  		mdss: display-subsystem@1a00000 {
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1219  			compatible = "qcom,mdss";
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1220  			reg = <0x01a00000 0x1000>,
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1221  			      <0x01ac8000 0x3000>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1222  			reg-names = "mdss_phys", "vbif_phys";
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1223  
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1224  			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1225  			interrupt-controller;
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1226  
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1227  			clocks = <&gcc GCC_MDSS_AHB_CLK>,
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1228  				 <&gcc GCC_MDSS_AXI_CLK>,
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1229  				 <&gcc GCC_MDSS_VSYNC_CLK>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1230  			clock-names = "iface",
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1231  				      "bus",
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1232  				      "vsync";
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1233  
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1234  			power-domains = <&gcc MDSS_GDSC>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1235  
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1236  			#address-cells = <1>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1237  			#size-cells = <1>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1238  			#interrupt-cells = <1>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1239  			ranges;
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1240  
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1241  			status = "disabled";
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1242  
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1243  			mdp: display-controller@1a01000 {
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1244  				compatible = "qcom,mdp5";
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1245  				reg = <0x01a01000 0x89000>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1246  				reg-names = "mdp_phys";
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1247  
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1248  				interrupt-parent = <&mdss>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1249  				interrupts = <0>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1250  
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1251  				clocks = <&gcc GCC_MDSS_AHB_CLK>,
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1252  					 <&gcc GCC_MDSS_AXI_CLK>,
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1253  					 <&gcc GCC_MDSS_MDP_CLK>,
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1254  					 <&gcc GCC_MDSS_VSYNC_CLK>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1255  				clock-names = "iface",
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1256  					      "bus",
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1257  					      "core",
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1258  					      "vsync";
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1259  
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1260  				iommus = <&apps_iommu 4>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1261  
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1262  				interconnects = <&snoc_mm MASTER_MDP_PORT0 &bimc SLAVE_EBI_CH0>,
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1263  						<&snoc_mm MASTER_MDP_PORT1 &bimc SLAVE_EBI_CH0>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1264  				interconnect-names = "mdp0-mem", "mdp1-mem";
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1265  
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1266  				ports {
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1267  					#address-cells = <1>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1268  					#size-cells = <0>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1269  
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1270  					port@0 {
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1271  						reg = <0>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1272  						mdp5_intf1_out: endpoint {
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1273  							remote-endpoint = <&dsi0_in>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1274  						};
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1275  					};
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1276  
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1277  					port@1 {
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1278  						reg = <1>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1279  						mdp5_intf2_out: endpoint {
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1280  							remote-endpoint = <&dsi1_in>;
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1281  						};
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1282  					};
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1283  				};
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1284  			};
61550c6c156c37 Bryan O'Donoghue 2023-04-07  1285  
61550c6c156c37 Bryan O'Donoghue 2023-04-07 @1286  			dsi0: dsi@1a98000 {

:::::: The code at line 1286 was first introduced by commit
:::::: 61550c6c156c3715baf54ab2cdd678c8c35b3803 arm64: dts: qcom: Add msm8939 SoC

:::::: TO: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
:::::: CC: Bjorn Andersson <andersson@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

