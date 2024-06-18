Return-Path: <linux-kernel+bounces-218521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B4590C147
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 03:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 307F21F21FFD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 01:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967524C6D;
	Tue, 18 Jun 2024 01:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iXFdZ8XQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520784C79
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 01:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718674238; cv=none; b=Tpd6nt1Nu33Ip62tRA2s8zRYzxNw0rUrb0qtYYCqalHwPlxS3ZIxr42Ofm4OW+VfvrD0xjR7GzSgkMQTbPfI1QQR+V7qduc30JqG1MFPpQO6eSqRg/w+Q+sbmWQgM0YQy2Vz5qHePZhozIS2/g7wp559jBIN9mpFfkMjrP+rJO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718674238; c=relaxed/simple;
	bh=dgg/reHW3bwGOIZqufAWjxXeMhFxzW5niGFmHajYjnw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IIaHUJFV9X88RrMNp4BS7xvm0DxNzHhkC7/cYBicxfvPntDmMrSwalEVWdGMZjh5QNiXv1Spk98kJrksyTZIPJi/8MGaS4NoWRTx747QD4dLI0Mc+XUzhS2LcQ+u3RbVWGk7zvpEEeNf0Df0HqSOCXfNREC5HJz0gSpMybKPsyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iXFdZ8XQ; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718674227; x=1750210227;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dgg/reHW3bwGOIZqufAWjxXeMhFxzW5niGFmHajYjnw=;
  b=iXFdZ8XQscbT5uwwxgFRyU+Z8GSi9R0BSJs3xvDg7Y5TchHfa6OTEKHb
   eRR/6KxKSkdLOzz91zVzWCmj/bDuB65pts2dqvvqxaG2KR4cqJiE90LZI
   0gVXt5F8xSHnFdVbSYBGPTq5Lz9dFXoUuqTNT2tZhIAYF2IbbbXTZu5Hl
   NcSnGxPps/JHZrDfH0NtI5p7zSBZO1cAujhm+fzmh4cdz3h3vXDtqLbvt
   AkXol64yFLyZEPKss7Y88w/18ZduyCoG5RDYd72lgE6fKYE27suNOvtyB
   neRhicLcFUNaz5SK/3/WUYwbQE0J4NkhSKiDjkWYZCtukhtwQzfGiqjbf
   Q==;
X-CSE-ConnectionGUID: GNguSHB1TjCDTrwGNVXD+Q==
X-CSE-MsgGUID: 41Qk86qeQXCLs5PfHF9BoA==
X-IronPort-AV: E=McAfee;i="6700,10204,11106"; a="15399108"
X-IronPort-AV: E=Sophos;i="6.08,246,1712646000"; 
   d="scan'208";a="15399108"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 18:30:26 -0700
X-CSE-ConnectionGUID: fkyQaKATRe+hNHV/EULIbQ==
X-CSE-MsgGUID: X7cGtMRhRg+mOKYLZnMZMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,246,1712646000"; 
   d="scan'208";a="41246136"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 17 Jun 2024 18:30:23 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sJNfx-00056D-27;
	Tue, 18 Jun 2024 01:30:21 +0000
Date: Tue, 18 Jun 2024 09:29:44 +0800
From: kernel test robot <lkp@intel.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Douglas Anderson <dianders@chromium.org>
Subject: arch/arm64/boot/dts/qcom/sc7280.dtsi:3643.10-3653.6: Warning
 (graph_child_address): /soc@0/eud@88e0000/ports: graph node has single child
 node 'port@0', #address-cells/#size-cells are not necessary
Message-ID: <202406180936.sAOaAf81-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   14d7c92f8df9c0964ae6f8b813c1b3ac38120825
commit: 39c8af78cbefb8c71a5ad1fa088e761ef418f0a0 arm64: dts: qcom: sc7280: drop incorrect EUD port on SoC side
date:   9 months ago
config: arm64-randconfig-r113-20240606 (https://download.01.org/0day-ci/archive/20240618/202406180936.sAOaAf81-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project d7d2d4f53fc79b4b58e8d8d08151b577c3699d4a)
reproduce: (https://download.01.org/0day-ci/archive/20240618/202406180936.sAOaAf81-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406180936.sAOaAf81-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
   arch/arm64/boot/dts/qcom/sc7280.dtsi:3944.26-4015.6: Warning (avoid_unnecessary_addr_size): /soc@0/display-subsystem@ae00000/dsi@ae94000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
>> arch/arm64/boot/dts/qcom/sc7280.dtsi:3643.10-3653.6: Warning (graph_child_address): /soc@0/eud@88e0000/ports: graph node has single child node 'port@0', #address-cells/#size-cells are not necessary

vim +3643 arch/arm64/boot/dts/qcom/sc7280.dtsi

7a1f4e7f740de9 Rajendra Nayak                   2021-03-11    29  
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11    30  / {
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11    31  	interrupt-parent = <&intc>;
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11    32  
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11    33  	#address-cells = <2>;
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11    34  	#size-cells = <2>;
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11    35  
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11    36  	chosen { };
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11    37  
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13    38  	aliases {
5f65408d9bfcc4 Rajesh Patil                     2021-09-23    39  		i2c0 = &i2c0;
5f65408d9bfcc4 Rajesh Patil                     2021-09-23    40  		i2c1 = &i2c1;
5f65408d9bfcc4 Rajesh Patil                     2021-09-23    41  		i2c2 = &i2c2;
5f65408d9bfcc4 Rajesh Patil                     2021-09-23    42  		i2c3 = &i2c3;
5f65408d9bfcc4 Rajesh Patil                     2021-09-23    43  		i2c4 = &i2c4;
5f65408d9bfcc4 Rajesh Patil                     2021-09-23    44  		i2c5 = &i2c5;
5f65408d9bfcc4 Rajesh Patil                     2021-09-23    45  		i2c6 = &i2c6;
5f65408d9bfcc4 Rajesh Patil                     2021-09-23    46  		i2c7 = &i2c7;
5f65408d9bfcc4 Rajesh Patil                     2021-09-23    47  		i2c8 = &i2c8;
5f65408d9bfcc4 Rajesh Patil                     2021-09-23    48  		i2c9 = &i2c9;
5f65408d9bfcc4 Rajesh Patil                     2021-09-23    49  		i2c10 = &i2c10;
5f65408d9bfcc4 Rajesh Patil                     2021-09-23    50  		i2c11 = &i2c11;
5f65408d9bfcc4 Rajesh Patil                     2021-09-23    51  		i2c12 = &i2c12;
5f65408d9bfcc4 Rajesh Patil                     2021-09-23    52  		i2c13 = &i2c13;
5f65408d9bfcc4 Rajesh Patil                     2021-09-23    53  		i2c14 = &i2c14;
5f65408d9bfcc4 Rajesh Patil                     2021-09-23    54  		i2c15 = &i2c15;
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13    55  		mmc1 = &sdhc_1;
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13    56  		mmc2 = &sdhc_2;
5f65408d9bfcc4 Rajesh Patil                     2021-09-23    57  		spi0 = &spi0;
5f65408d9bfcc4 Rajesh Patil                     2021-09-23    58  		spi1 = &spi1;
5f65408d9bfcc4 Rajesh Patil                     2021-09-23    59  		spi2 = &spi2;
5f65408d9bfcc4 Rajesh Patil                     2021-09-23    60  		spi3 = &spi3;
5f65408d9bfcc4 Rajesh Patil                     2021-09-23    61  		spi4 = &spi4;
5f65408d9bfcc4 Rajesh Patil                     2021-09-23    62  		spi5 = &spi5;
5f65408d9bfcc4 Rajesh Patil                     2021-09-23    63  		spi6 = &spi6;
5f65408d9bfcc4 Rajesh Patil                     2021-09-23    64  		spi7 = &spi7;
5f65408d9bfcc4 Rajesh Patil                     2021-09-23    65  		spi8 = &spi8;
5f65408d9bfcc4 Rajesh Patil                     2021-09-23    66  		spi9 = &spi9;
5f65408d9bfcc4 Rajesh Patil                     2021-09-23    67  		spi10 = &spi10;
5f65408d9bfcc4 Rajesh Patil                     2021-09-23    68  		spi11 = &spi11;
5f65408d9bfcc4 Rajesh Patil                     2021-09-23    69  		spi12 = &spi12;
5f65408d9bfcc4 Rajesh Patil                     2021-09-23    70  		spi13 = &spi13;
5f65408d9bfcc4 Rajesh Patil                     2021-09-23    71  		spi14 = &spi14;
5f65408d9bfcc4 Rajesh Patil                     2021-09-23    72  		spi15 = &spi15;
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13    73  	};
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13    74  
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11    75  	clocks {
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11    76  		xo_board: xo-board {
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11    77  			compatible = "fixed-clock";
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11    78  			clock-frequency = <76800000>;
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11    79  			#clock-cells = <0>;
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11    80  		};
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11    81  
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11    82  		sleep_clk: sleep-clk {
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11    83  			compatible = "fixed-clock";
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11    84  			clock-frequency = <32000>;
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11    85  			#clock-cells = <0>;
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11    86  		};
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11    87  	};
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11    88  
3450bb5b9570a2 Maulik Shah                      2021-03-11    89  	reserved-memory {
3450bb5b9570a2 Maulik Shah                      2021-03-11    90  		#address-cells = <2>;
3450bb5b9570a2 Maulik Shah                      2021-03-11    91  		#size-cells = <2>;
3450bb5b9570a2 Maulik Shah                      2021-03-11    92  		ranges;
3450bb5b9570a2 Maulik Shah                      2021-03-11    93  
cdbfb815d63a79 Manikanta Pubbisetty             2022-04-06    94  		wlan_ce_mem: memory@4cd000 {
cdbfb815d63a79 Manikanta Pubbisetty             2022-04-06    95  			no-map;
cdbfb815d63a79 Manikanta Pubbisetty             2022-04-06    96  			reg = <0x0 0x004cd000 0x0 0x1000>;
cdbfb815d63a79 Manikanta Pubbisetty             2022-04-06    97  		};
cdbfb815d63a79 Manikanta Pubbisetty             2022-04-06    98  
eca7d3a366b3ab Sibi Sankar                      2021-09-17    99  		hyp_mem: memory@80000000 {
eca7d3a366b3ab Sibi Sankar                      2021-09-17   100  			reg = <0x0 0x80000000 0x0 0x600000>;
eca7d3a366b3ab Sibi Sankar                      2021-09-17   101  			no-map;
eca7d3a366b3ab Sibi Sankar                      2021-09-17   102  		};
eca7d3a366b3ab Sibi Sankar                      2021-09-17   103  
eca7d3a366b3ab Sibi Sankar                      2021-09-17   104  		xbl_mem: memory@80600000 {
eca7d3a366b3ab Sibi Sankar                      2021-09-17   105  			reg = <0x0 0x80600000 0x0 0x200000>;
eca7d3a366b3ab Sibi Sankar                      2021-09-17   106  			no-map;
eca7d3a366b3ab Sibi Sankar                      2021-09-17   107  		};
eca7d3a366b3ab Sibi Sankar                      2021-09-17   108  
e9d7397467885a Maulik Shah                      2021-03-11   109  		aop_mem: memory@80800000 {
e9d7397467885a Maulik Shah                      2021-03-11   110  			reg = <0x0 0x80800000 0x0 0x60000>;
e9d7397467885a Maulik Shah                      2021-03-11   111  			no-map;
e9d7397467885a Maulik Shah                      2021-03-11   112  		};
e9d7397467885a Maulik Shah                      2021-03-11   113  
3450bb5b9570a2 Maulik Shah                      2021-03-11   114  		aop_cmd_db_mem: memory@80860000 {
3450bb5b9570a2 Maulik Shah                      2021-03-11   115  			reg = <0x0 0x80860000 0x0 0x20000>;
3450bb5b9570a2 Maulik Shah                      2021-03-11   116  			compatible = "qcom,cmd-db";
3450bb5b9570a2 Maulik Shah                      2021-03-11   117  			no-map;
3450bb5b9570a2 Maulik Shah                      2021-03-11   118  		};
e9d7397467885a Maulik Shah                      2021-03-11   119  
eca7d3a366b3ab Sibi Sankar                      2021-09-17   120  		reserved_xbl_uefi_log: memory@80880000 {
eca7d3a366b3ab Sibi Sankar                      2021-09-17   121  			reg = <0x0 0x80884000 0x0 0x10000>;
eca7d3a366b3ab Sibi Sankar                      2021-09-17   122  			no-map;
eca7d3a366b3ab Sibi Sankar                      2021-09-17   123  		};
eca7d3a366b3ab Sibi Sankar                      2021-09-17   124  
eca7d3a366b3ab Sibi Sankar                      2021-09-17   125  		sec_apps_mem: memory@808ff000 {
eca7d3a366b3ab Sibi Sankar                      2021-09-17   126  			reg = <0x0 0x808ff000 0x0 0x1000>;
eca7d3a366b3ab Sibi Sankar                      2021-09-17   127  			no-map;
eca7d3a366b3ab Sibi Sankar                      2021-09-17   128  		};
eca7d3a366b3ab Sibi Sankar                      2021-09-17   129  
c3bbe55c942d2a Sibi Sankar                      2021-04-27   130  		smem_mem: memory@80900000 {
c3bbe55c942d2a Sibi Sankar                      2021-04-27   131  			reg = <0x0 0x80900000 0x0 0x200000>;
c3bbe55c942d2a Sibi Sankar                      2021-04-27   132  			no-map;
c3bbe55c942d2a Sibi Sankar                      2021-04-27   133  		};
c3bbe55c942d2a Sibi Sankar                      2021-04-27   134  
e9d7397467885a Maulik Shah                      2021-03-11   135  		cpucp_mem: memory@80b00000 {
e9d7397467885a Maulik Shah                      2021-03-11   136  			no-map;
e9d7397467885a Maulik Shah                      2021-03-11   137  			reg = <0x0 0x80b00000 0x0 0x100000>;
e9d7397467885a Maulik Shah                      2021-03-11   138  		};
fc4f0273d4fba2 Alex Elder                       2021-08-04   139  
eca7d3a366b3ab Sibi Sankar                      2021-09-17   140  		wlan_fw_mem: memory@80c00000 {
eca7d3a366b3ab Sibi Sankar                      2021-09-17   141  			reg = <0x0 0x80c00000 0x0 0xc00000>;
eca7d3a366b3ab Sibi Sankar                      2021-09-17   142  			no-map;
eca7d3a366b3ab Sibi Sankar                      2021-09-17   143  		};
eca7d3a366b3ab Sibi Sankar                      2021-09-17   144  
37613aee217928 Dikshita Agarwal                 2021-10-26   145  		video_mem: memory@8b200000 {
37613aee217928 Dikshita Agarwal                 2021-10-26   146  			reg = <0x0 0x8b200000 0x0 0x500000>;
37613aee217928 Dikshita Agarwal                 2021-10-26   147  			no-map;
37613aee217928 Dikshita Agarwal                 2021-10-26   148  		};
37613aee217928 Dikshita Agarwal                 2021-10-26   149  
fc4f0273d4fba2 Alex Elder                       2021-08-04   150  		ipa_fw_mem: memory@8b700000 {
fc4f0273d4fba2 Alex Elder                       2021-08-04   151  			reg = <0 0x8b700000 0 0x10000>;
fc4f0273d4fba2 Alex Elder                       2021-08-04   152  			no-map;
fc4f0273d4fba2 Alex Elder                       2021-08-04   153  		};
eca7d3a366b3ab Sibi Sankar                      2021-09-17   154  
eca7d3a366b3ab Sibi Sankar                      2021-09-17   155  		rmtfs_mem: memory@9c900000 {
eca7d3a366b3ab Sibi Sankar                      2021-09-17   156  			compatible = "qcom,rmtfs-mem";
eca7d3a366b3ab Sibi Sankar                      2021-09-17   157  			reg = <0x0 0x9c900000 0x0 0x280000>;
eca7d3a366b3ab Sibi Sankar                      2021-09-17   158  			no-map;
eca7d3a366b3ab Sibi Sankar                      2021-09-17   159  
eca7d3a366b3ab Sibi Sankar                      2021-09-17   160  			qcom,client-id = <1>;
018c949b32df9f Luca Weiss                       2023-08-18   161  			qcom,vmid = <QCOM_SCM_VMID_MSS_MSA>;
eca7d3a366b3ab Sibi Sankar                      2021-09-17   162  		};
3450bb5b9570a2 Maulik Shah                      2021-03-11   163  	};
3450bb5b9570a2 Maulik Shah                      2021-03-11   164  
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   165  	cpus {
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   166  		#address-cells = <2>;
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   167  		#size-cells = <0>;
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   168  
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   169  		CPU0: cpu@0 {
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   170  			device_type = "cpu";
9293c3e85a200d Rob Herring                      2022-12-07   171  			compatible = "qcom,kryo";
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   172  			reg = <0x0 0x0>;
667d8a2039608c Manivannan Sadhasivam            2023-02-15   173  			clocks = <&cpufreq_hw 0>;
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   174  			enable-method = "psci";
7925ca85e95619 Maulik Shah                      2023-07-03   175  			power-domains = <&CPU_PD0>;
7925ca85e95619 Maulik Shah                      2023-07-03   176  			power-domain-names = "psci";
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   177  			next-level-cache = <&L2_0>;
1e8853c698276d Sibi Sankar                      2022-02-09   178  			operating-points-v2 = <&cpu0_opp_table>;
1e8853c698276d Sibi Sankar                      2022-02-09   179  			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
1e8853c698276d Sibi Sankar                      2022-02-09   180  					<&epss_l3 MASTER_EPSS_L3_APPS &epss_l3 SLAVE_EPSS_L3_SHARED>;
7dbd121a2c587c Taniya Das                       2021-04-10   181  			qcom,freq-domain = <&cpufreq_hw 0>;
9ec1c5867c0269 Rajeshwari Ravindra Kamble       2021-05-07   182  			#cooling-cells = <2>;
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   183  			L2_0: l2-cache {
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   184  				compatible = "cache";
9435294c6517dc Pierre Gondois                   2022-11-07   185  				cache-level = <2>;
9c6e72fb2058dc Krzysztof Kozlowski              2023-04-16   186  				cache-unified;
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   187  				next-level-cache = <&L3_0>;
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   188  				L3_0: l3-cache {
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   189  					compatible = "cache";
9435294c6517dc Pierre Gondois                   2022-11-07   190  					cache-level = <3>;
9c6e72fb2058dc Krzysztof Kozlowski              2023-04-16   191  					cache-unified;
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   192  				};
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   193  			};
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   194  		};
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   195  
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   196  		CPU1: cpu@100 {
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   197  			device_type = "cpu";
9293c3e85a200d Rob Herring                      2022-12-07   198  			compatible = "qcom,kryo";
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   199  			reg = <0x0 0x100>;
667d8a2039608c Manivannan Sadhasivam            2023-02-15   200  			clocks = <&cpufreq_hw 0>;
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   201  			enable-method = "psci";
7925ca85e95619 Maulik Shah                      2023-07-03   202  			power-domains = <&CPU_PD1>;
7925ca85e95619 Maulik Shah                      2023-07-03   203  			power-domain-names = "psci";
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   204  			next-level-cache = <&L2_100>;
1e8853c698276d Sibi Sankar                      2022-02-09   205  			operating-points-v2 = <&cpu0_opp_table>;
1e8853c698276d Sibi Sankar                      2022-02-09   206  			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
1e8853c698276d Sibi Sankar                      2022-02-09   207  					<&epss_l3 MASTER_EPSS_L3_APPS &epss_l3 SLAVE_EPSS_L3_SHARED>;
7dbd121a2c587c Taniya Das                       2021-04-10   208  			qcom,freq-domain = <&cpufreq_hw 0>;
9ec1c5867c0269 Rajeshwari Ravindra Kamble       2021-05-07   209  			#cooling-cells = <2>;
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   210  			L2_100: l2-cache {
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   211  				compatible = "cache";
9435294c6517dc Pierre Gondois                   2022-11-07   212  				cache-level = <2>;
9c6e72fb2058dc Krzysztof Kozlowski              2023-04-16   213  				cache-unified;
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   214  				next-level-cache = <&L3_0>;
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   215  			};
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   216  		};
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   217  
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   218  		CPU2: cpu@200 {
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   219  			device_type = "cpu";
9293c3e85a200d Rob Herring                      2022-12-07   220  			compatible = "qcom,kryo";
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   221  			reg = <0x0 0x200>;
667d8a2039608c Manivannan Sadhasivam            2023-02-15   222  			clocks = <&cpufreq_hw 0>;
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   223  			enable-method = "psci";
7925ca85e95619 Maulik Shah                      2023-07-03   224  			power-domains = <&CPU_PD2>;
7925ca85e95619 Maulik Shah                      2023-07-03   225  			power-domain-names = "psci";
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   226  			next-level-cache = <&L2_200>;
1e8853c698276d Sibi Sankar                      2022-02-09   227  			operating-points-v2 = <&cpu0_opp_table>;
1e8853c698276d Sibi Sankar                      2022-02-09   228  			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
1e8853c698276d Sibi Sankar                      2022-02-09   229  					<&epss_l3 MASTER_EPSS_L3_APPS &epss_l3 SLAVE_EPSS_L3_SHARED>;
7dbd121a2c587c Taniya Das                       2021-04-10   230  			qcom,freq-domain = <&cpufreq_hw 0>;
9ec1c5867c0269 Rajeshwari Ravindra Kamble       2021-05-07   231  			#cooling-cells = <2>;
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   232  			L2_200: l2-cache {
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   233  				compatible = "cache";
9435294c6517dc Pierre Gondois                   2022-11-07   234  				cache-level = <2>;
9c6e72fb2058dc Krzysztof Kozlowski              2023-04-16   235  				cache-unified;
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   236  				next-level-cache = <&L3_0>;
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   237  			};
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   238  		};
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   239  
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   240  		CPU3: cpu@300 {
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   241  			device_type = "cpu";
9293c3e85a200d Rob Herring                      2022-12-07   242  			compatible = "qcom,kryo";
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   243  			reg = <0x0 0x300>;
667d8a2039608c Manivannan Sadhasivam            2023-02-15   244  			clocks = <&cpufreq_hw 0>;
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   245  			enable-method = "psci";
7925ca85e95619 Maulik Shah                      2023-07-03   246  			power-domains = <&CPU_PD3>;
7925ca85e95619 Maulik Shah                      2023-07-03   247  			power-domain-names = "psci";
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   248  			next-level-cache = <&L2_300>;
1e8853c698276d Sibi Sankar                      2022-02-09   249  			operating-points-v2 = <&cpu0_opp_table>;
1e8853c698276d Sibi Sankar                      2022-02-09   250  			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
1e8853c698276d Sibi Sankar                      2022-02-09   251  					<&epss_l3 MASTER_EPSS_L3_APPS &epss_l3 SLAVE_EPSS_L3_SHARED>;
7dbd121a2c587c Taniya Das                       2021-04-10   252  			qcom,freq-domain = <&cpufreq_hw 0>;
9ec1c5867c0269 Rajeshwari Ravindra Kamble       2021-05-07   253  			#cooling-cells = <2>;
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   254  			L2_300: l2-cache {
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   255  				compatible = "cache";
9435294c6517dc Pierre Gondois                   2022-11-07   256  				cache-level = <2>;
9c6e72fb2058dc Krzysztof Kozlowski              2023-04-16   257  				cache-unified;
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   258  				next-level-cache = <&L3_0>;
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   259  			};
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   260  		};
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   261  
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   262  		CPU4: cpu@400 {
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   263  			device_type = "cpu";
9293c3e85a200d Rob Herring                      2022-12-07   264  			compatible = "qcom,kryo";
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   265  			reg = <0x0 0x400>;
667d8a2039608c Manivannan Sadhasivam            2023-02-15   266  			clocks = <&cpufreq_hw 1>;
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   267  			enable-method = "psci";
7925ca85e95619 Maulik Shah                      2023-07-03   268  			power-domains = <&CPU_PD4>;
7925ca85e95619 Maulik Shah                      2023-07-03   269  			power-domain-names = "psci";
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   270  			next-level-cache = <&L2_400>;
1e8853c698276d Sibi Sankar                      2022-02-09   271  			operating-points-v2 = <&cpu4_opp_table>;
1e8853c698276d Sibi Sankar                      2022-02-09   272  			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
1e8853c698276d Sibi Sankar                      2022-02-09   273  					<&epss_l3 MASTER_EPSS_L3_APPS &epss_l3 SLAVE_EPSS_L3_SHARED>;
7dbd121a2c587c Taniya Das                       2021-04-10   274  			qcom,freq-domain = <&cpufreq_hw 1>;
9ec1c5867c0269 Rajeshwari Ravindra Kamble       2021-05-07   275  			#cooling-cells = <2>;
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   276  			L2_400: l2-cache {
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   277  				compatible = "cache";
9435294c6517dc Pierre Gondois                   2022-11-07   278  				cache-level = <2>;
9c6e72fb2058dc Krzysztof Kozlowski              2023-04-16   279  				cache-unified;
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   280  				next-level-cache = <&L3_0>;
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   281  			};
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   282  		};
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   283  
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   284  		CPU5: cpu@500 {
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   285  			device_type = "cpu";
9293c3e85a200d Rob Herring                      2022-12-07   286  			compatible = "qcom,kryo";
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   287  			reg = <0x0 0x500>;
667d8a2039608c Manivannan Sadhasivam            2023-02-15   288  			clocks = <&cpufreq_hw 1>;
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   289  			enable-method = "psci";
7925ca85e95619 Maulik Shah                      2023-07-03   290  			power-domains = <&CPU_PD5>;
7925ca85e95619 Maulik Shah                      2023-07-03   291  			power-domain-names = "psci";
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   292  			next-level-cache = <&L2_500>;
1e8853c698276d Sibi Sankar                      2022-02-09   293  			operating-points-v2 = <&cpu4_opp_table>;
1e8853c698276d Sibi Sankar                      2022-02-09   294  			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
1e8853c698276d Sibi Sankar                      2022-02-09   295  					<&epss_l3 MASTER_EPSS_L3_APPS &epss_l3 SLAVE_EPSS_L3_SHARED>;
7dbd121a2c587c Taniya Das                       2021-04-10   296  			qcom,freq-domain = <&cpufreq_hw 1>;
9ec1c5867c0269 Rajeshwari Ravindra Kamble       2021-05-07   297  			#cooling-cells = <2>;
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   298  			L2_500: l2-cache {
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   299  				compatible = "cache";
9435294c6517dc Pierre Gondois                   2022-11-07   300  				cache-level = <2>;
9c6e72fb2058dc Krzysztof Kozlowski              2023-04-16   301  				cache-unified;
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   302  				next-level-cache = <&L3_0>;
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   303  			};
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   304  		};
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   305  
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   306  		CPU6: cpu@600 {
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   307  			device_type = "cpu";
9293c3e85a200d Rob Herring                      2022-12-07   308  			compatible = "qcom,kryo";
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   309  			reg = <0x0 0x600>;
667d8a2039608c Manivannan Sadhasivam            2023-02-15   310  			clocks = <&cpufreq_hw 1>;
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   311  			enable-method = "psci";
7925ca85e95619 Maulik Shah                      2023-07-03   312  			power-domains = <&CPU_PD6>;
7925ca85e95619 Maulik Shah                      2023-07-03   313  			power-domain-names = "psci";
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   314  			next-level-cache = <&L2_600>;
1e8853c698276d Sibi Sankar                      2022-02-09   315  			operating-points-v2 = <&cpu4_opp_table>;
1e8853c698276d Sibi Sankar                      2022-02-09   316  			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
1e8853c698276d Sibi Sankar                      2022-02-09   317  					<&epss_l3 MASTER_EPSS_L3_APPS &epss_l3 SLAVE_EPSS_L3_SHARED>;
7dbd121a2c587c Taniya Das                       2021-04-10   318  			qcom,freq-domain = <&cpufreq_hw 1>;
9ec1c5867c0269 Rajeshwari Ravindra Kamble       2021-05-07   319  			#cooling-cells = <2>;
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   320  			L2_600: l2-cache {
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   321  				compatible = "cache";
9435294c6517dc Pierre Gondois                   2022-11-07   322  				cache-level = <2>;
9c6e72fb2058dc Krzysztof Kozlowski              2023-04-16   323  				cache-unified;
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   324  				next-level-cache = <&L3_0>;
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   325  			};
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   326  		};
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   327  
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   328  		CPU7: cpu@700 {
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   329  			device_type = "cpu";
9293c3e85a200d Rob Herring                      2022-12-07   330  			compatible = "qcom,kryo";
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   331  			reg = <0x0 0x700>;
667d8a2039608c Manivannan Sadhasivam            2023-02-15   332  			clocks = <&cpufreq_hw 2>;
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   333  			enable-method = "psci";
7925ca85e95619 Maulik Shah                      2023-07-03   334  			power-domains = <&CPU_PD7>;
7925ca85e95619 Maulik Shah                      2023-07-03   335  			power-domain-names = "psci";
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   336  			next-level-cache = <&L2_700>;
1e8853c698276d Sibi Sankar                      2022-02-09   337  			operating-points-v2 = <&cpu7_opp_table>;
1e8853c698276d Sibi Sankar                      2022-02-09   338  			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
1e8853c698276d Sibi Sankar                      2022-02-09   339  					<&epss_l3 MASTER_EPSS_L3_APPS &epss_l3 SLAVE_EPSS_L3_SHARED>;
4cbb02fa76de4b Sibi Sankar                      2021-07-20   340  			qcom,freq-domain = <&cpufreq_hw 2>;
9ec1c5867c0269 Rajeshwari Ravindra Kamble       2021-05-07   341  			#cooling-cells = <2>;
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   342  			L2_700: l2-cache {
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   343  				compatible = "cache";
9435294c6517dc Pierre Gondois                   2022-11-07   344  				cache-level = <2>;
9c6e72fb2058dc Krzysztof Kozlowski              2023-04-16   345  				cache-unified;
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   346  				next-level-cache = <&L3_0>;
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   347  			};
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   348  		};
0ef5463c7a5648 Maulik Shah                      2021-03-11   349  
ec04b0ebef7c5a Rajendra Nayak                   2021-08-25   350  		cpu-map {
ec04b0ebef7c5a Rajendra Nayak                   2021-08-25   351  			cluster0 {
ec04b0ebef7c5a Rajendra Nayak                   2021-08-25   352  				core0 {
ec04b0ebef7c5a Rajendra Nayak                   2021-08-25   353  					cpu = <&CPU0>;
ec04b0ebef7c5a Rajendra Nayak                   2021-08-25   354  				};
ec04b0ebef7c5a Rajendra Nayak                   2021-08-25   355  
ec04b0ebef7c5a Rajendra Nayak                   2021-08-25   356  				core1 {
ec04b0ebef7c5a Rajendra Nayak                   2021-08-25   357  					cpu = <&CPU1>;
ec04b0ebef7c5a Rajendra Nayak                   2021-08-25   358  				};
ec04b0ebef7c5a Rajendra Nayak                   2021-08-25   359  
ec04b0ebef7c5a Rajendra Nayak                   2021-08-25   360  				core2 {
ec04b0ebef7c5a Rajendra Nayak                   2021-08-25   361  					cpu = <&CPU2>;
ec04b0ebef7c5a Rajendra Nayak                   2021-08-25   362  				};
ec04b0ebef7c5a Rajendra Nayak                   2021-08-25   363  
ec04b0ebef7c5a Rajendra Nayak                   2021-08-25   364  				core3 {
ec04b0ebef7c5a Rajendra Nayak                   2021-08-25   365  					cpu = <&CPU3>;
ec04b0ebef7c5a Rajendra Nayak                   2021-08-25   366  				};
ec04b0ebef7c5a Rajendra Nayak                   2021-08-25   367  
ec04b0ebef7c5a Rajendra Nayak                   2021-08-25   368  				core4 {
ec04b0ebef7c5a Rajendra Nayak                   2021-08-25   369  					cpu = <&CPU4>;
ec04b0ebef7c5a Rajendra Nayak                   2021-08-25   370  				};
ec04b0ebef7c5a Rajendra Nayak                   2021-08-25   371  
ec04b0ebef7c5a Rajendra Nayak                   2021-08-25   372  				core5 {
ec04b0ebef7c5a Rajendra Nayak                   2021-08-25   373  					cpu = <&CPU5>;
ec04b0ebef7c5a Rajendra Nayak                   2021-08-25   374  				};
ec04b0ebef7c5a Rajendra Nayak                   2021-08-25   375  
ec04b0ebef7c5a Rajendra Nayak                   2021-08-25   376  				core6 {
ec04b0ebef7c5a Rajendra Nayak                   2021-08-25   377  					cpu = <&CPU6>;
ec04b0ebef7c5a Rajendra Nayak                   2021-08-25   378  				};
ec04b0ebef7c5a Rajendra Nayak                   2021-08-25   379  
ec04b0ebef7c5a Rajendra Nayak                   2021-08-25   380  				core7 {
ec04b0ebef7c5a Rajendra Nayak                   2021-08-25   381  					cpu = <&CPU7>;
ec04b0ebef7c5a Rajendra Nayak                   2021-08-25   382  				};
ec04b0ebef7c5a Rajendra Nayak                   2021-08-25   383  			};
ec04b0ebef7c5a Rajendra Nayak                   2021-08-25   384  		};
ec04b0ebef7c5a Rajendra Nayak                   2021-08-25   385  
0ef5463c7a5648 Maulik Shah                      2021-03-11   386  		idle-states {
0ef5463c7a5648 Maulik Shah                      2021-03-11   387  			entry-method = "psci";
0ef5463c7a5648 Maulik Shah                      2021-03-11   388  
0ef5463c7a5648 Maulik Shah                      2021-03-11   389  			LITTLE_CPU_SLEEP_0: cpu-sleep-0-0 {
0ef5463c7a5648 Maulik Shah                      2021-03-11   390  				compatible = "arm,idle-state";
0ef5463c7a5648 Maulik Shah                      2021-03-11   391  				idle-state-name = "little-power-down";
0ef5463c7a5648 Maulik Shah                      2021-03-11   392  				arm,psci-suspend-param = <0x40000003>;
0ef5463c7a5648 Maulik Shah                      2021-03-11   393  				entry-latency-us = <549>;
0ef5463c7a5648 Maulik Shah                      2021-03-11   394  				exit-latency-us = <901>;
0ef5463c7a5648 Maulik Shah                      2021-03-11   395  				min-residency-us = <1774>;
0ef5463c7a5648 Maulik Shah                      2021-03-11   396  				local-timer-stop;
0ef5463c7a5648 Maulik Shah                      2021-03-11   397  			};
0ef5463c7a5648 Maulik Shah                      2021-03-11   398  
0ef5463c7a5648 Maulik Shah                      2021-03-11   399  			LITTLE_CPU_SLEEP_1: cpu-sleep-0-1 {
0ef5463c7a5648 Maulik Shah                      2021-03-11   400  				compatible = "arm,idle-state";
0ef5463c7a5648 Maulik Shah                      2021-03-11   401  				idle-state-name = "little-rail-power-down";
0ef5463c7a5648 Maulik Shah                      2021-03-11   402  				arm,psci-suspend-param = <0x40000004>;
0ef5463c7a5648 Maulik Shah                      2021-03-11   403  				entry-latency-us = <702>;
0ef5463c7a5648 Maulik Shah                      2021-03-11   404  				exit-latency-us = <915>;
0ef5463c7a5648 Maulik Shah                      2021-03-11   405  				min-residency-us = <4001>;
0ef5463c7a5648 Maulik Shah                      2021-03-11   406  				local-timer-stop;
0ef5463c7a5648 Maulik Shah                      2021-03-11   407  			};
0ef5463c7a5648 Maulik Shah                      2021-03-11   408  
0ef5463c7a5648 Maulik Shah                      2021-03-11   409  			BIG_CPU_SLEEP_0: cpu-sleep-1-0 {
0ef5463c7a5648 Maulik Shah                      2021-03-11   410  				compatible = "arm,idle-state";
0ef5463c7a5648 Maulik Shah                      2021-03-11   411  				idle-state-name = "big-power-down";
0ef5463c7a5648 Maulik Shah                      2021-03-11   412  				arm,psci-suspend-param = <0x40000003>;
0ef5463c7a5648 Maulik Shah                      2021-03-11   413  				entry-latency-us = <523>;
0ef5463c7a5648 Maulik Shah                      2021-03-11   414  				exit-latency-us = <1244>;
0ef5463c7a5648 Maulik Shah                      2021-03-11   415  				min-residency-us = <2207>;
0ef5463c7a5648 Maulik Shah                      2021-03-11   416  				local-timer-stop;
0ef5463c7a5648 Maulik Shah                      2021-03-11   417  			};
0ef5463c7a5648 Maulik Shah                      2021-03-11   418  
0ef5463c7a5648 Maulik Shah                      2021-03-11   419  			BIG_CPU_SLEEP_1: cpu-sleep-1-1 {
0ef5463c7a5648 Maulik Shah                      2021-03-11   420  				compatible = "arm,idle-state";
0ef5463c7a5648 Maulik Shah                      2021-03-11   421  				idle-state-name = "big-rail-power-down";
0ef5463c7a5648 Maulik Shah                      2021-03-11   422  				arm,psci-suspend-param = <0x40000004>;
0ef5463c7a5648 Maulik Shah                      2021-03-11   423  				entry-latency-us = <526>;
0ef5463c7a5648 Maulik Shah                      2021-03-11   424  				exit-latency-us = <1854>;
0ef5463c7a5648 Maulik Shah                      2021-03-11   425  				min-residency-us = <5555>;
0ef5463c7a5648 Maulik Shah                      2021-03-11   426  				local-timer-stop;
0ef5463c7a5648 Maulik Shah                      2021-03-11   427  			};
7925ca85e95619 Maulik Shah                      2023-07-03   428  		};
0ef5463c7a5648 Maulik Shah                      2021-03-11   429  
7925ca85e95619 Maulik Shah                      2023-07-03   430  		domain-idle-states {
0ef5463c7a5648 Maulik Shah                      2021-03-11   431  			CLUSTER_SLEEP_0: cluster-sleep-0 {
7925ca85e95619 Maulik Shah                      2023-07-03   432  				compatible = "domain-idle-state";
0ef5463c7a5648 Maulik Shah                      2021-03-11   433  				idle-state-name = "cluster-power-down";
0ef5463c7a5648 Maulik Shah                      2021-03-11   434  				arm,psci-suspend-param = <0x40003444>;
0ef5463c7a5648 Maulik Shah                      2021-03-11   435  				entry-latency-us = <3263>;
0ef5463c7a5648 Maulik Shah                      2021-03-11   436  				exit-latency-us = <6562>;
0ef5463c7a5648 Maulik Shah                      2021-03-11   437  				min-residency-us = <9926>;
0ef5463c7a5648 Maulik Shah                      2021-03-11   438  				local-timer-stop;
0ef5463c7a5648 Maulik Shah                      2021-03-11   439  			};
0ef5463c7a5648 Maulik Shah                      2021-03-11   440  		};
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   441  	};
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   442  
0e3e654696074b Krzysztof Kozlowski              2022-06-27   443  	cpu0_opp_table: opp-table-cpu0 {
1e8853c698276d Sibi Sankar                      2022-02-09   444  		compatible = "operating-points-v2";
1e8853c698276d Sibi Sankar                      2022-02-09   445  		opp-shared;
1e8853c698276d Sibi Sankar                      2022-02-09   446  
1e8853c698276d Sibi Sankar                      2022-02-09   447  		cpu0_opp_300mhz: opp-300000000 {
1e8853c698276d Sibi Sankar                      2022-02-09   448  			opp-hz = /bits/ 64 <300000000>;
1e8853c698276d Sibi Sankar                      2022-02-09   449  			opp-peak-kBps = <800000 9600000>;
1e8853c698276d Sibi Sankar                      2022-02-09   450  		};
1e8853c698276d Sibi Sankar                      2022-02-09   451  
1e8853c698276d Sibi Sankar                      2022-02-09   452  		cpu0_opp_691mhz: opp-691200000 {
1e8853c698276d Sibi Sankar                      2022-02-09   453  			opp-hz = /bits/ 64 <691200000>;
1e8853c698276d Sibi Sankar                      2022-02-09   454  			opp-peak-kBps = <800000 17817600>;
1e8853c698276d Sibi Sankar                      2022-02-09   455  		};
1e8853c698276d Sibi Sankar                      2022-02-09   456  
1e8853c698276d Sibi Sankar                      2022-02-09   457  		cpu0_opp_806mhz: opp-806400000 {
1e8853c698276d Sibi Sankar                      2022-02-09   458  			opp-hz = /bits/ 64 <806400000>;
1e8853c698276d Sibi Sankar                      2022-02-09   459  			opp-peak-kBps = <800000 20889600>;
1e8853c698276d Sibi Sankar                      2022-02-09   460  		};
1e8853c698276d Sibi Sankar                      2022-02-09   461  
1e8853c698276d Sibi Sankar                      2022-02-09   462  		cpu0_opp_941mhz: opp-940800000 {
1e8853c698276d Sibi Sankar                      2022-02-09   463  			opp-hz = /bits/ 64 <940800000>;
1e8853c698276d Sibi Sankar                      2022-02-09   464  			opp-peak-kBps = <1804000 24576000>;
1e8853c698276d Sibi Sankar                      2022-02-09   465  		};
1e8853c698276d Sibi Sankar                      2022-02-09   466  
1e8853c698276d Sibi Sankar                      2022-02-09   467  		cpu0_opp_1152mhz: opp-1152000000 {
1e8853c698276d Sibi Sankar                      2022-02-09   468  			opp-hz = /bits/ 64 <1152000000>;
1e8853c698276d Sibi Sankar                      2022-02-09   469  			opp-peak-kBps = <2188000 27033600>;
1e8853c698276d Sibi Sankar                      2022-02-09   470  		};
1e8853c698276d Sibi Sankar                      2022-02-09   471  
1e8853c698276d Sibi Sankar                      2022-02-09   472  		cpu0_opp_1325mhz: opp-1324800000 {
1e8853c698276d Sibi Sankar                      2022-02-09   473  			opp-hz = /bits/ 64 <1324800000>;
1e8853c698276d Sibi Sankar                      2022-02-09   474  			opp-peak-kBps = <2188000 33792000>;
1e8853c698276d Sibi Sankar                      2022-02-09   475  		};
1e8853c698276d Sibi Sankar                      2022-02-09   476  
1e8853c698276d Sibi Sankar                      2022-02-09   477  		cpu0_opp_1517mhz: opp-1516800000 {
1e8853c698276d Sibi Sankar                      2022-02-09   478  			opp-hz = /bits/ 64 <1516800000>;
1e8853c698276d Sibi Sankar                      2022-02-09   479  			opp-peak-kBps = <3072000 38092800>;
1e8853c698276d Sibi Sankar                      2022-02-09   480  		};
1e8853c698276d Sibi Sankar                      2022-02-09   481  
1e8853c698276d Sibi Sankar                      2022-02-09   482  		cpu0_opp_1651mhz: opp-1651200000 {
1e8853c698276d Sibi Sankar                      2022-02-09   483  			opp-hz = /bits/ 64 <1651200000>;
1e8853c698276d Sibi Sankar                      2022-02-09   484  			opp-peak-kBps = <3072000 41779200>;
1e8853c698276d Sibi Sankar                      2022-02-09   485  		};
1e8853c698276d Sibi Sankar                      2022-02-09   486  
1e8853c698276d Sibi Sankar                      2022-02-09   487  		cpu0_opp_1805mhz: opp-1804800000 {
1e8853c698276d Sibi Sankar                      2022-02-09   488  			opp-hz = /bits/ 64 <1804800000>;
1e8853c698276d Sibi Sankar                      2022-02-09   489  			opp-peak-kBps = <4068000 48537600>;
1e8853c698276d Sibi Sankar                      2022-02-09   490  		};
1e8853c698276d Sibi Sankar                      2022-02-09   491  
1e8853c698276d Sibi Sankar                      2022-02-09   492  		cpu0_opp_1958mhz: opp-1958400000 {
1e8853c698276d Sibi Sankar                      2022-02-09   493  			opp-hz = /bits/ 64 <1958400000>;
1e8853c698276d Sibi Sankar                      2022-02-09   494  			opp-peak-kBps = <4068000 48537600>;
1e8853c698276d Sibi Sankar                      2022-02-09   495  		};
1e8853c698276d Sibi Sankar                      2022-02-09   496  
1e8853c698276d Sibi Sankar                      2022-02-09   497  		cpu0_opp_2016mhz: opp-2016000000 {
1e8853c698276d Sibi Sankar                      2022-02-09   498  			opp-hz = /bits/ 64 <2016000000>;
1e8853c698276d Sibi Sankar                      2022-02-09   499  			opp-peak-kBps = <6220000 48537600>;
1e8853c698276d Sibi Sankar                      2022-02-09   500  		};
1e8853c698276d Sibi Sankar                      2022-02-09   501  	};
1e8853c698276d Sibi Sankar                      2022-02-09   502  
0e3e654696074b Krzysztof Kozlowski              2022-06-27   503  	cpu4_opp_table: opp-table-cpu4 {
1e8853c698276d Sibi Sankar                      2022-02-09   504  		compatible = "operating-points-v2";
1e8853c698276d Sibi Sankar                      2022-02-09   505  		opp-shared;
1e8853c698276d Sibi Sankar                      2022-02-09   506  
1e8853c698276d Sibi Sankar                      2022-02-09   507  		cpu4_opp_691mhz: opp-691200000 {
1e8853c698276d Sibi Sankar                      2022-02-09   508  			opp-hz = /bits/ 64 <691200000>;
1e8853c698276d Sibi Sankar                      2022-02-09   509  			opp-peak-kBps = <1804000 9600000>;
1e8853c698276d Sibi Sankar                      2022-02-09   510  		};
1e8853c698276d Sibi Sankar                      2022-02-09   511  
1e8853c698276d Sibi Sankar                      2022-02-09   512  		cpu4_opp_941mhz: opp-940800000 {
1e8853c698276d Sibi Sankar                      2022-02-09   513  			opp-hz = /bits/ 64 <940800000>;
1e8853c698276d Sibi Sankar                      2022-02-09   514  			opp-peak-kBps = <2188000 17817600>;
1e8853c698276d Sibi Sankar                      2022-02-09   515  		};
1e8853c698276d Sibi Sankar                      2022-02-09   516  
1e8853c698276d Sibi Sankar                      2022-02-09   517  		cpu4_opp_1229mhz: opp-1228800000 {
1e8853c698276d Sibi Sankar                      2022-02-09   518  			opp-hz = /bits/ 64 <1228800000>;
1e8853c698276d Sibi Sankar                      2022-02-09   519  			opp-peak-kBps = <4068000 24576000>;
1e8853c698276d Sibi Sankar                      2022-02-09   520  		};
1e8853c698276d Sibi Sankar                      2022-02-09   521  
1e8853c698276d Sibi Sankar                      2022-02-09   522  		cpu4_opp_1344mhz: opp-1344000000 {
1e8853c698276d Sibi Sankar                      2022-02-09   523  			opp-hz = /bits/ 64 <1344000000>;
1e8853c698276d Sibi Sankar                      2022-02-09   524  			opp-peak-kBps = <4068000 24576000>;
1e8853c698276d Sibi Sankar                      2022-02-09   525  		};
1e8853c698276d Sibi Sankar                      2022-02-09   526  
1e8853c698276d Sibi Sankar                      2022-02-09   527  		cpu4_opp_1517mhz: opp-1516800000 {
1e8853c698276d Sibi Sankar                      2022-02-09   528  			opp-hz = /bits/ 64 <1516800000>;
1e8853c698276d Sibi Sankar                      2022-02-09   529  			opp-peak-kBps = <4068000 24576000>;
1e8853c698276d Sibi Sankar                      2022-02-09   530  		};
1e8853c698276d Sibi Sankar                      2022-02-09   531  
1e8853c698276d Sibi Sankar                      2022-02-09   532  		cpu4_opp_1651mhz: opp-1651200000 {
1e8853c698276d Sibi Sankar                      2022-02-09   533  			opp-hz = /bits/ 64 <1651200000>;
1e8853c698276d Sibi Sankar                      2022-02-09   534  			opp-peak-kBps = <6220000 38092800>;
1e8853c698276d Sibi Sankar                      2022-02-09   535  		};
1e8853c698276d Sibi Sankar                      2022-02-09   536  
1e8853c698276d Sibi Sankar                      2022-02-09   537  		cpu4_opp_1901mhz: opp-1900800000 {
1e8853c698276d Sibi Sankar                      2022-02-09   538  			opp-hz = /bits/ 64 <1900800000>;
1e8853c698276d Sibi Sankar                      2022-02-09   539  			opp-peak-kBps = <6220000 44851200>;
1e8853c698276d Sibi Sankar                      2022-02-09   540  		};
1e8853c698276d Sibi Sankar                      2022-02-09   541  
1e8853c698276d Sibi Sankar                      2022-02-09   542  		cpu4_opp_2054mhz: opp-2054400000 {
1e8853c698276d Sibi Sankar                      2022-02-09   543  			opp-hz = /bits/ 64 <2054400000>;
1e8853c698276d Sibi Sankar                      2022-02-09   544  			opp-peak-kBps = <6220000 44851200>;
1e8853c698276d Sibi Sankar                      2022-02-09   545  		};
1e8853c698276d Sibi Sankar                      2022-02-09   546  
1e8853c698276d Sibi Sankar                      2022-02-09   547  		cpu4_opp_2112mhz: opp-2112000000 {
1e8853c698276d Sibi Sankar                      2022-02-09   548  			opp-hz = /bits/ 64 <2112000000>;
1e8853c698276d Sibi Sankar                      2022-02-09   549  			opp-peak-kBps = <6220000 44851200>;
1e8853c698276d Sibi Sankar                      2022-02-09   550  		};
1e8853c698276d Sibi Sankar                      2022-02-09   551  
1e8853c698276d Sibi Sankar                      2022-02-09   552  		cpu4_opp_2131mhz: opp-2131200000 {
1e8853c698276d Sibi Sankar                      2022-02-09   553  			opp-hz = /bits/ 64 <2131200000>;
1e8853c698276d Sibi Sankar                      2022-02-09   554  			opp-peak-kBps = <6220000 44851200>;
1e8853c698276d Sibi Sankar                      2022-02-09   555  		};
1e8853c698276d Sibi Sankar                      2022-02-09   556  
1e8853c698276d Sibi Sankar                      2022-02-09   557  		cpu4_opp_2208mhz: opp-2208000000 {
1e8853c698276d Sibi Sankar                      2022-02-09   558  			opp-hz = /bits/ 64 <2208000000>;
1e8853c698276d Sibi Sankar                      2022-02-09   559  			opp-peak-kBps = <6220000 44851200>;
1e8853c698276d Sibi Sankar                      2022-02-09   560  		};
1e8853c698276d Sibi Sankar                      2022-02-09   561  
1e8853c698276d Sibi Sankar                      2022-02-09   562  		cpu4_opp_2400mhz: opp-2400000000 {
1e8853c698276d Sibi Sankar                      2022-02-09   563  			opp-hz = /bits/ 64 <2400000000>;
1e8853c698276d Sibi Sankar                      2022-02-09   564  			opp-peak-kBps = <8532000 48537600>;
1e8853c698276d Sibi Sankar                      2022-02-09   565  		};
1e8853c698276d Sibi Sankar                      2022-02-09   566  
1e8853c698276d Sibi Sankar                      2022-02-09   567  		cpu4_opp_2611mhz: opp-2611200000 {
1e8853c698276d Sibi Sankar                      2022-02-09   568  			opp-hz = /bits/ 64 <2611200000>;
1e8853c698276d Sibi Sankar                      2022-02-09   569  			opp-peak-kBps = <8532000 48537600>;
1e8853c698276d Sibi Sankar                      2022-02-09   570  		};
1e8853c698276d Sibi Sankar                      2022-02-09   571  	};
1e8853c698276d Sibi Sankar                      2022-02-09   572  
0e3e654696074b Krzysztof Kozlowski              2022-06-27   573  	cpu7_opp_table: opp-table-cpu7 {
1e8853c698276d Sibi Sankar                      2022-02-09   574  		compatible = "operating-points-v2";
1e8853c698276d Sibi Sankar                      2022-02-09   575  		opp-shared;
1e8853c698276d Sibi Sankar                      2022-02-09   576  
1e8853c698276d Sibi Sankar                      2022-02-09   577  		cpu7_opp_806mhz: opp-806400000 {
1e8853c698276d Sibi Sankar                      2022-02-09   578  			opp-hz = /bits/ 64 <806400000>;
1e8853c698276d Sibi Sankar                      2022-02-09   579  			opp-peak-kBps = <1804000 9600000>;
1e8853c698276d Sibi Sankar                      2022-02-09   580  		};
1e8853c698276d Sibi Sankar                      2022-02-09   581  
1e8853c698276d Sibi Sankar                      2022-02-09   582  		cpu7_opp_1056mhz: opp-1056000000 {
1e8853c698276d Sibi Sankar                      2022-02-09   583  			opp-hz = /bits/ 64 <1056000000>;
1e8853c698276d Sibi Sankar                      2022-02-09   584  			opp-peak-kBps = <2188000 17817600>;
1e8853c698276d Sibi Sankar                      2022-02-09   585  		};
1e8853c698276d Sibi Sankar                      2022-02-09   586  
1e8853c698276d Sibi Sankar                      2022-02-09   587  		cpu7_opp_1325mhz: opp-1324800000 {
1e8853c698276d Sibi Sankar                      2022-02-09   588  			opp-hz = /bits/ 64 <1324800000>;
1e8853c698276d Sibi Sankar                      2022-02-09   589  			opp-peak-kBps = <4068000 24576000>;
1e8853c698276d Sibi Sankar                      2022-02-09   590  		};
1e8853c698276d Sibi Sankar                      2022-02-09   591  
1e8853c698276d Sibi Sankar                      2022-02-09   592  		cpu7_opp_1517mhz: opp-1516800000 {
1e8853c698276d Sibi Sankar                      2022-02-09   593  			opp-hz = /bits/ 64 <1516800000>;
1e8853c698276d Sibi Sankar                      2022-02-09   594  			opp-peak-kBps = <4068000 24576000>;
1e8853c698276d Sibi Sankar                      2022-02-09   595  		};
1e8853c698276d Sibi Sankar                      2022-02-09   596  
1e8853c698276d Sibi Sankar                      2022-02-09   597  		cpu7_opp_1766mhz: opp-1766400000 {
1e8853c698276d Sibi Sankar                      2022-02-09   598  			opp-hz = /bits/ 64 <1766400000>;
1e8853c698276d Sibi Sankar                      2022-02-09   599  			opp-peak-kBps = <6220000 38092800>;
1e8853c698276d Sibi Sankar                      2022-02-09   600  		};
1e8853c698276d Sibi Sankar                      2022-02-09   601  
1e8853c698276d Sibi Sankar                      2022-02-09   602  		cpu7_opp_1862mhz: opp-1862400000 {
1e8853c698276d Sibi Sankar                      2022-02-09   603  			opp-hz = /bits/ 64 <1862400000>;
1e8853c698276d Sibi Sankar                      2022-02-09   604  			opp-peak-kBps = <6220000 38092800>;
1e8853c698276d Sibi Sankar                      2022-02-09   605  		};
1e8853c698276d Sibi Sankar                      2022-02-09   606  
1e8853c698276d Sibi Sankar                      2022-02-09   607  		cpu7_opp_2035mhz: opp-2035200000 {
1e8853c698276d Sibi Sankar                      2022-02-09   608  			opp-hz = /bits/ 64 <2035200000>;
1e8853c698276d Sibi Sankar                      2022-02-09   609  			opp-peak-kBps = <6220000 38092800>;
1e8853c698276d Sibi Sankar                      2022-02-09   610  		};
1e8853c698276d Sibi Sankar                      2022-02-09   611  
1e8853c698276d Sibi Sankar                      2022-02-09   612  		cpu7_opp_2112mhz: opp-2112000000 {
1e8853c698276d Sibi Sankar                      2022-02-09   613  			opp-hz = /bits/ 64 <2112000000>;
1e8853c698276d Sibi Sankar                      2022-02-09   614  			opp-peak-kBps = <6220000 44851200>;
1e8853c698276d Sibi Sankar                      2022-02-09   615  		};
1e8853c698276d Sibi Sankar                      2022-02-09   616  
1e8853c698276d Sibi Sankar                      2022-02-09   617  		cpu7_opp_2208mhz: opp-2208000000 {
1e8853c698276d Sibi Sankar                      2022-02-09   618  			opp-hz = /bits/ 64 <2208000000>;
1e8853c698276d Sibi Sankar                      2022-02-09   619  			opp-peak-kBps = <6220000 44851200>;
1e8853c698276d Sibi Sankar                      2022-02-09   620  		};
1e8853c698276d Sibi Sankar                      2022-02-09   621  
1e8853c698276d Sibi Sankar                      2022-02-09   622  		cpu7_opp_2381mhz: opp-2380800000 {
1e8853c698276d Sibi Sankar                      2022-02-09   623  			opp-hz = /bits/ 64 <2380800000>;
1e8853c698276d Sibi Sankar                      2022-02-09   624  			opp-peak-kBps = <6832000 44851200>;
1e8853c698276d Sibi Sankar                      2022-02-09   625  		};
1e8853c698276d Sibi Sankar                      2022-02-09   626  
1e8853c698276d Sibi Sankar                      2022-02-09   627  		cpu7_opp_2400mhz: opp-2400000000 {
1e8853c698276d Sibi Sankar                      2022-02-09   628  			opp-hz = /bits/ 64 <2400000000>;
1e8853c698276d Sibi Sankar                      2022-02-09   629  			opp-peak-kBps = <8532000 48537600>;
1e8853c698276d Sibi Sankar                      2022-02-09   630  		};
1e8853c698276d Sibi Sankar                      2022-02-09   631  
1e8853c698276d Sibi Sankar                      2022-02-09   632  		cpu7_opp_2515mhz: opp-2515200000 {
1e8853c698276d Sibi Sankar                      2022-02-09   633  			opp-hz = /bits/ 64 <2515200000>;
1e8853c698276d Sibi Sankar                      2022-02-09   634  			opp-peak-kBps = <8532000 48537600>;
1e8853c698276d Sibi Sankar                      2022-02-09   635  		};
1e8853c698276d Sibi Sankar                      2022-02-09   636  
1e8853c698276d Sibi Sankar                      2022-02-09   637  		cpu7_opp_2707mhz: opp-2707200000 {
1e8853c698276d Sibi Sankar                      2022-02-09   638  			opp-hz = /bits/ 64 <2707200000>;
1e8853c698276d Sibi Sankar                      2022-02-09   639  			opp-peak-kBps = <8532000 48537600>;
1e8853c698276d Sibi Sankar                      2022-02-09   640  		};
1e8853c698276d Sibi Sankar                      2022-02-09   641  
1e8853c698276d Sibi Sankar                      2022-02-09   642  		cpu7_opp_3014mhz: opp-3014400000 {
1e8853c698276d Sibi Sankar                      2022-02-09   643  			opp-hz = /bits/ 64 <3014400000>;
1e8853c698276d Sibi Sankar                      2022-02-09   644  			opp-peak-kBps = <8532000 48537600>;
1e8853c698276d Sibi Sankar                      2022-02-09   645  		};
1e8853c698276d Sibi Sankar                      2022-02-09   646  	};
1e8853c698276d Sibi Sankar                      2022-02-09   647  
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   648  	memory@80000000 {
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   649  		device_type = "memory";
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   650  		/* We expect the bootloader to fill in the size */
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   651  		reg = <0 0x80000000 0 0>;
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   652  	};
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   653  
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   654  	firmware {
7b59e8ae92fe08 Douglas Anderson                 2023-06-16   655  		scm: scm {
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   656  			compatible = "qcom,scm-sc7280", "qcom,scm";
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   657  		};
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   658  	};
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   659  
297e6e38320f32 Odelu Kukatla                    2021-04-27   660  	clk_virt: interconnect {
297e6e38320f32 Odelu Kukatla                    2021-04-27   661  		compatible = "qcom,sc7280-clk-virt";
297e6e38320f32 Odelu Kukatla                    2021-04-27   662  		#interconnect-cells = <2>;
297e6e38320f32 Odelu Kukatla                    2021-04-27   663  		qcom,bcm-voters = <&apps_bcm_voter>;
297e6e38320f32 Odelu Kukatla                    2021-04-27   664  	};
297e6e38320f32 Odelu Kukatla                    2021-04-27   665  
c3bbe55c942d2a Sibi Sankar                      2021-04-27   666  	smem {
c3bbe55c942d2a Sibi Sankar                      2021-04-27   667  		compatible = "qcom,smem";
c3bbe55c942d2a Sibi Sankar                      2021-04-27   668  		memory-region = <&smem_mem>;
c3bbe55c942d2a Sibi Sankar                      2021-04-27   669  		hwlocks = <&tcsr_mutex 3>;
c3bbe55c942d2a Sibi Sankar                      2021-04-27   670  	};
c3bbe55c942d2a Sibi Sankar                      2021-04-27   671  
c3bbe55c942d2a Sibi Sankar                      2021-04-27   672  	smp2p-adsp {
c3bbe55c942d2a Sibi Sankar                      2021-04-27   673  		compatible = "qcom,smp2p";
c3bbe55c942d2a Sibi Sankar                      2021-04-27   674  		qcom,smem = <443>, <429>;
c3bbe55c942d2a Sibi Sankar                      2021-04-27   675  		interrupts-extended = <&ipcc IPCC_CLIENT_LPASS
c3bbe55c942d2a Sibi Sankar                      2021-04-27   676  					     IPCC_MPROC_SIGNAL_SMP2P
c3bbe55c942d2a Sibi Sankar                      2021-04-27   677  					     IRQ_TYPE_EDGE_RISING>;
c3bbe55c942d2a Sibi Sankar                      2021-04-27   678  		mboxes = <&ipcc IPCC_CLIENT_LPASS
c3bbe55c942d2a Sibi Sankar                      2021-04-27   679  				IPCC_MPROC_SIGNAL_SMP2P>;
c3bbe55c942d2a Sibi Sankar                      2021-04-27   680  
c3bbe55c942d2a Sibi Sankar                      2021-04-27   681  		qcom,local-pid = <0>;
c3bbe55c942d2a Sibi Sankar                      2021-04-27   682  		qcom,remote-pid = <2>;
c3bbe55c942d2a Sibi Sankar                      2021-04-27   683  
c3bbe55c942d2a Sibi Sankar                      2021-04-27   684  		adsp_smp2p_out: master-kernel {
c3bbe55c942d2a Sibi Sankar                      2021-04-27   685  			qcom,entry-name = "master-kernel";
c3bbe55c942d2a Sibi Sankar                      2021-04-27   686  			#qcom,smem-state-cells = <1>;
c3bbe55c942d2a Sibi Sankar                      2021-04-27   687  		};
c3bbe55c942d2a Sibi Sankar                      2021-04-27   688  
c3bbe55c942d2a Sibi Sankar                      2021-04-27   689  		adsp_smp2p_in: slave-kernel {
c3bbe55c942d2a Sibi Sankar                      2021-04-27   690  			qcom,entry-name = "slave-kernel";
c3bbe55c942d2a Sibi Sankar                      2021-04-27   691  			interrupt-controller;
c3bbe55c942d2a Sibi Sankar                      2021-04-27   692  			#interrupt-cells = <2>;
c3bbe55c942d2a Sibi Sankar                      2021-04-27   693  		};
c3bbe55c942d2a Sibi Sankar                      2021-04-27   694  	};
c3bbe55c942d2a Sibi Sankar                      2021-04-27   695  
c3bbe55c942d2a Sibi Sankar                      2021-04-27   696  	smp2p-cdsp {
c3bbe55c942d2a Sibi Sankar                      2021-04-27   697  		compatible = "qcom,smp2p";
c3bbe55c942d2a Sibi Sankar                      2021-04-27   698  		qcom,smem = <94>, <432>;
c3bbe55c942d2a Sibi Sankar                      2021-04-27   699  		interrupts-extended = <&ipcc IPCC_CLIENT_CDSP
c3bbe55c942d2a Sibi Sankar                      2021-04-27   700  					     IPCC_MPROC_SIGNAL_SMP2P
c3bbe55c942d2a Sibi Sankar                      2021-04-27   701  					     IRQ_TYPE_EDGE_RISING>;
c3bbe55c942d2a Sibi Sankar                      2021-04-27   702  		mboxes = <&ipcc IPCC_CLIENT_CDSP
c3bbe55c942d2a Sibi Sankar                      2021-04-27   703  				IPCC_MPROC_SIGNAL_SMP2P>;
c3bbe55c942d2a Sibi Sankar                      2021-04-27   704  
c3bbe55c942d2a Sibi Sankar                      2021-04-27   705  		qcom,local-pid = <0>;
c3bbe55c942d2a Sibi Sankar                      2021-04-27   706  		qcom,remote-pid = <5>;
c3bbe55c942d2a Sibi Sankar                      2021-04-27   707  
c3bbe55c942d2a Sibi Sankar                      2021-04-27   708  		cdsp_smp2p_out: master-kernel {
c3bbe55c942d2a Sibi Sankar                      2021-04-27   709  			qcom,entry-name = "master-kernel";
c3bbe55c942d2a Sibi Sankar                      2021-04-27   710  			#qcom,smem-state-cells = <1>;
c3bbe55c942d2a Sibi Sankar                      2021-04-27   711  		};
c3bbe55c942d2a Sibi Sankar                      2021-04-27   712  
c3bbe55c942d2a Sibi Sankar                      2021-04-27   713  		cdsp_smp2p_in: slave-kernel {
c3bbe55c942d2a Sibi Sankar                      2021-04-27   714  			qcom,entry-name = "slave-kernel";
c3bbe55c942d2a Sibi Sankar                      2021-04-27   715  			interrupt-controller;
c3bbe55c942d2a Sibi Sankar                      2021-04-27   716  			#interrupt-cells = <2>;
c3bbe55c942d2a Sibi Sankar                      2021-04-27   717  		};
c3bbe55c942d2a Sibi Sankar                      2021-04-27   718  	};
c3bbe55c942d2a Sibi Sankar                      2021-04-27   719  
c3bbe55c942d2a Sibi Sankar                      2021-04-27   720  	smp2p-mpss {
c3bbe55c942d2a Sibi Sankar                      2021-04-27   721  		compatible = "qcom,smp2p";
c3bbe55c942d2a Sibi Sankar                      2021-04-27   722  		qcom,smem = <435>, <428>;
c3bbe55c942d2a Sibi Sankar                      2021-04-27   723  		interrupts-extended = <&ipcc IPCC_CLIENT_MPSS
c3bbe55c942d2a Sibi Sankar                      2021-04-27   724  					     IPCC_MPROC_SIGNAL_SMP2P
c3bbe55c942d2a Sibi Sankar                      2021-04-27   725  					     IRQ_TYPE_EDGE_RISING>;
c3bbe55c942d2a Sibi Sankar                      2021-04-27   726  		mboxes = <&ipcc IPCC_CLIENT_MPSS
c3bbe55c942d2a Sibi Sankar                      2021-04-27   727  				IPCC_MPROC_SIGNAL_SMP2P>;
c3bbe55c942d2a Sibi Sankar                      2021-04-27   728  
c3bbe55c942d2a Sibi Sankar                      2021-04-27   729  		qcom,local-pid = <0>;
c3bbe55c942d2a Sibi Sankar                      2021-04-27   730  		qcom,remote-pid = <1>;
c3bbe55c942d2a Sibi Sankar                      2021-04-27   731  
c3bbe55c942d2a Sibi Sankar                      2021-04-27   732  		modem_smp2p_out: master-kernel {
c3bbe55c942d2a Sibi Sankar                      2021-04-27   733  			qcom,entry-name = "master-kernel";
c3bbe55c942d2a Sibi Sankar                      2021-04-27   734  			#qcom,smem-state-cells = <1>;
c3bbe55c942d2a Sibi Sankar                      2021-04-27   735  		};
c3bbe55c942d2a Sibi Sankar                      2021-04-27   736  
c3bbe55c942d2a Sibi Sankar                      2021-04-27   737  		modem_smp2p_in: slave-kernel {
c3bbe55c942d2a Sibi Sankar                      2021-04-27   738  			qcom,entry-name = "slave-kernel";
c3bbe55c942d2a Sibi Sankar                      2021-04-27   739  			interrupt-controller;
c3bbe55c942d2a Sibi Sankar                      2021-04-27   740  			#interrupt-cells = <2>;
c3bbe55c942d2a Sibi Sankar                      2021-04-27   741  		};
c3bbe55c942d2a Sibi Sankar                      2021-04-27   742  
c3bbe55c942d2a Sibi Sankar                      2021-04-27   743  		ipa_smp2p_out: ipa-ap-to-modem {
c3bbe55c942d2a Sibi Sankar                      2021-04-27   744  			qcom,entry-name = "ipa";
c3bbe55c942d2a Sibi Sankar                      2021-04-27   745  			#qcom,smem-state-cells = <1>;
c3bbe55c942d2a Sibi Sankar                      2021-04-27   746  		};
c3bbe55c942d2a Sibi Sankar                      2021-04-27   747  
c3bbe55c942d2a Sibi Sankar                      2021-04-27   748  		ipa_smp2p_in: ipa-modem-to-ap {
c3bbe55c942d2a Sibi Sankar                      2021-04-27   749  			qcom,entry-name = "ipa";
c3bbe55c942d2a Sibi Sankar                      2021-04-27   750  			interrupt-controller;
c3bbe55c942d2a Sibi Sankar                      2021-04-27   751  			#interrupt-cells = <2>;
c3bbe55c942d2a Sibi Sankar                      2021-04-27   752  		};
c3bbe55c942d2a Sibi Sankar                      2021-04-27   753  	};
c3bbe55c942d2a Sibi Sankar                      2021-04-27   754  
c3bbe55c942d2a Sibi Sankar                      2021-04-27   755  	smp2p-wpss {
c3bbe55c942d2a Sibi Sankar                      2021-04-27   756  		compatible = "qcom,smp2p";
c3bbe55c942d2a Sibi Sankar                      2021-04-27   757  		qcom,smem = <617>, <616>;
c3bbe55c942d2a Sibi Sankar                      2021-04-27   758  		interrupts-extended = <&ipcc IPCC_CLIENT_WPSS
c3bbe55c942d2a Sibi Sankar                      2021-04-27   759  					     IPCC_MPROC_SIGNAL_SMP2P
c3bbe55c942d2a Sibi Sankar                      2021-04-27   760  					     IRQ_TYPE_EDGE_RISING>;
c3bbe55c942d2a Sibi Sankar                      2021-04-27   761  		mboxes = <&ipcc IPCC_CLIENT_WPSS
c3bbe55c942d2a Sibi Sankar                      2021-04-27   762  				IPCC_MPROC_SIGNAL_SMP2P>;
c3bbe55c942d2a Sibi Sankar                      2021-04-27   763  
c3bbe55c942d2a Sibi Sankar                      2021-04-27   764  		qcom,local-pid = <0>;
c3bbe55c942d2a Sibi Sankar                      2021-04-27   765  		qcom,remote-pid = <13>;
c3bbe55c942d2a Sibi Sankar                      2021-04-27   766  
c3bbe55c942d2a Sibi Sankar                      2021-04-27   767  		wpss_smp2p_out: master-kernel {
c3bbe55c942d2a Sibi Sankar                      2021-04-27   768  			qcom,entry-name = "master-kernel";
c3bbe55c942d2a Sibi Sankar                      2021-04-27   769  			#qcom,smem-state-cells = <1>;
c3bbe55c942d2a Sibi Sankar                      2021-04-27   770  		};
c3bbe55c942d2a Sibi Sankar                      2021-04-27   771  
c3bbe55c942d2a Sibi Sankar                      2021-04-27   772  		wpss_smp2p_in: slave-kernel {
c3bbe55c942d2a Sibi Sankar                      2021-04-27   773  			qcom,entry-name = "slave-kernel";
c3bbe55c942d2a Sibi Sankar                      2021-04-27   774  			interrupt-controller;
c3bbe55c942d2a Sibi Sankar                      2021-04-27   775  			#interrupt-cells = <2>;
c3bbe55c942d2a Sibi Sankar                      2021-04-27   776  		};
42582b27dcb1cb Manikanta Pubbisetty             2022-10-17   777  
42582b27dcb1cb Manikanta Pubbisetty             2022-10-17   778  		wlan_smp2p_out: wlan-ap-to-wpss {
42582b27dcb1cb Manikanta Pubbisetty             2022-10-17   779  			qcom,entry-name = "wlan";
42582b27dcb1cb Manikanta Pubbisetty             2022-10-17   780  			#qcom,smem-state-cells = <1>;
42582b27dcb1cb Manikanta Pubbisetty             2022-10-17   781  		};
42582b27dcb1cb Manikanta Pubbisetty             2022-10-17   782  
42582b27dcb1cb Manikanta Pubbisetty             2022-10-17   783  		wlan_smp2p_in: wlan-wpss-to-ap {
42582b27dcb1cb Manikanta Pubbisetty             2022-10-17   784  			qcom,entry-name = "wlan";
42582b27dcb1cb Manikanta Pubbisetty             2022-10-17   785  			interrupt-controller;
42582b27dcb1cb Manikanta Pubbisetty             2022-10-17   786  			#interrupt-cells = <2>;
42582b27dcb1cb Manikanta Pubbisetty             2022-10-17   787  		};
c3bbe55c942d2a Sibi Sankar                      2021-04-27   788  	};
c3bbe55c942d2a Sibi Sankar                      2021-04-27   789  
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   790  	pmu {
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   791  		compatible = "arm,armv8-pmuv3";
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   792  		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   793  	};
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   794  
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   795  	psci {
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   796  		compatible = "arm,psci-1.0";
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   797  		method = "smc";
7925ca85e95619 Maulik Shah                      2023-07-03   798  
7925ca85e95619 Maulik Shah                      2023-07-03   799  		CPU_PD0: power-domain-cpu0 {
7925ca85e95619 Maulik Shah                      2023-07-03   800  			#power-domain-cells = <0>;
7925ca85e95619 Maulik Shah                      2023-07-03   801  			power-domains = <&CLUSTER_PD>;
7925ca85e95619 Maulik Shah                      2023-07-03   802  			domain-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
7925ca85e95619 Maulik Shah                      2023-07-03   803  		};
7925ca85e95619 Maulik Shah                      2023-07-03   804  
7925ca85e95619 Maulik Shah                      2023-07-03   805  		CPU_PD1: power-domain-cpu1 {
7925ca85e95619 Maulik Shah                      2023-07-03   806  			#power-domain-cells = <0>;
7925ca85e95619 Maulik Shah                      2023-07-03   807  			power-domains = <&CLUSTER_PD>;
7925ca85e95619 Maulik Shah                      2023-07-03   808  			domain-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
7925ca85e95619 Maulik Shah                      2023-07-03   809  		};
7925ca85e95619 Maulik Shah                      2023-07-03   810  
7925ca85e95619 Maulik Shah                      2023-07-03   811  		CPU_PD2: power-domain-cpu2 {
7925ca85e95619 Maulik Shah                      2023-07-03   812  			#power-domain-cells = <0>;
7925ca85e95619 Maulik Shah                      2023-07-03   813  			power-domains = <&CLUSTER_PD>;
7925ca85e95619 Maulik Shah                      2023-07-03   814  			domain-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
7925ca85e95619 Maulik Shah                      2023-07-03   815  		};
7925ca85e95619 Maulik Shah                      2023-07-03   816  
7925ca85e95619 Maulik Shah                      2023-07-03   817  		CPU_PD3: power-domain-cpu3 {
7925ca85e95619 Maulik Shah                      2023-07-03   818  			#power-domain-cells = <0>;
7925ca85e95619 Maulik Shah                      2023-07-03   819  			power-domains = <&CLUSTER_PD>;
7925ca85e95619 Maulik Shah                      2023-07-03   820  			domain-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
7925ca85e95619 Maulik Shah                      2023-07-03   821  		};
7925ca85e95619 Maulik Shah                      2023-07-03   822  
7925ca85e95619 Maulik Shah                      2023-07-03   823  		CPU_PD4: power-domain-cpu4 {
7925ca85e95619 Maulik Shah                      2023-07-03   824  			#power-domain-cells = <0>;
7925ca85e95619 Maulik Shah                      2023-07-03   825  			power-domains = <&CLUSTER_PD>;
7925ca85e95619 Maulik Shah                      2023-07-03   826  			domain-idle-states = <&BIG_CPU_SLEEP_0 &BIG_CPU_SLEEP_1>;
7925ca85e95619 Maulik Shah                      2023-07-03   827  		};
7925ca85e95619 Maulik Shah                      2023-07-03   828  
7925ca85e95619 Maulik Shah                      2023-07-03   829  		CPU_PD5: power-domain-cpu5 {
7925ca85e95619 Maulik Shah                      2023-07-03   830  			#power-domain-cells = <0>;
7925ca85e95619 Maulik Shah                      2023-07-03   831  			power-domains = <&CLUSTER_PD>;
7925ca85e95619 Maulik Shah                      2023-07-03   832  			domain-idle-states = <&BIG_CPU_SLEEP_0 &BIG_CPU_SLEEP_1>;
7925ca85e95619 Maulik Shah                      2023-07-03   833  		};
7925ca85e95619 Maulik Shah                      2023-07-03   834  
7925ca85e95619 Maulik Shah                      2023-07-03   835  		CPU_PD6: power-domain-cpu6 {
7925ca85e95619 Maulik Shah                      2023-07-03   836  			#power-domain-cells = <0>;
7925ca85e95619 Maulik Shah                      2023-07-03   837  			power-domains = <&CLUSTER_PD>;
7925ca85e95619 Maulik Shah                      2023-07-03   838  			domain-idle-states = <&BIG_CPU_SLEEP_0 &BIG_CPU_SLEEP_1>;
7925ca85e95619 Maulik Shah                      2023-07-03   839  		};
7925ca85e95619 Maulik Shah                      2023-07-03   840  
7925ca85e95619 Maulik Shah                      2023-07-03   841  		CPU_PD7: power-domain-cpu7 {
7925ca85e95619 Maulik Shah                      2023-07-03   842  			#power-domain-cells = <0>;
7925ca85e95619 Maulik Shah                      2023-07-03   843  			power-domains = <&CLUSTER_PD>;
7925ca85e95619 Maulik Shah                      2023-07-03   844  			domain-idle-states = <&BIG_CPU_SLEEP_0 &BIG_CPU_SLEEP_1>;
7925ca85e95619 Maulik Shah                      2023-07-03   845  		};
7925ca85e95619 Maulik Shah                      2023-07-03   846  
7925ca85e95619 Maulik Shah                      2023-07-03   847  		CLUSTER_PD: power-domain-cluster {
7925ca85e95619 Maulik Shah                      2023-07-03   848  			#power-domain-cells = <0>;
7925ca85e95619 Maulik Shah                      2023-07-03   849  			domain-idle-states = <&CLUSTER_SLEEP_0>;
7925ca85e95619 Maulik Shah                      2023-07-03   850  		};
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   851  	};
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   852  
0e3e654696074b Krzysztof Kozlowski              2022-06-27   853  	qspi_opp_table: opp-table-qspi {
7720ea001b528d Roja Rani Yarubandi              2021-09-23   854  		compatible = "operating-points-v2";
7720ea001b528d Roja Rani Yarubandi              2021-09-23   855  
7720ea001b528d Roja Rani Yarubandi              2021-09-23   856  		opp-75000000 {
7720ea001b528d Roja Rani Yarubandi              2021-09-23   857  			opp-hz = /bits/ 64 <75000000>;
7720ea001b528d Roja Rani Yarubandi              2021-09-23   858  			required-opps = <&rpmhpd_opp_low_svs>;
7720ea001b528d Roja Rani Yarubandi              2021-09-23   859  		};
7720ea001b528d Roja Rani Yarubandi              2021-09-23   860  
7720ea001b528d Roja Rani Yarubandi              2021-09-23   861  		opp-150000000 {
7720ea001b528d Roja Rani Yarubandi              2021-09-23   862  			opp-hz = /bits/ 64 <150000000>;
7720ea001b528d Roja Rani Yarubandi              2021-09-23   863  			required-opps = <&rpmhpd_opp_svs>;
7720ea001b528d Roja Rani Yarubandi              2021-09-23   864  		};
7720ea001b528d Roja Rani Yarubandi              2021-09-23   865  
6ea15b5065e554 Rajesh Patil                     2021-09-29   866  		opp-200000000 {
6ea15b5065e554 Rajesh Patil                     2021-09-29   867  			opp-hz = /bits/ 64 <200000000>;
6ea15b5065e554 Rajesh Patil                     2021-09-29   868  			required-opps = <&rpmhpd_opp_svs_l1>;
6ea15b5065e554 Rajesh Patil                     2021-09-29   869  		};
6ea15b5065e554 Rajesh Patil                     2021-09-29   870  
7720ea001b528d Roja Rani Yarubandi              2021-09-23   871  		opp-300000000 {
7720ea001b528d Roja Rani Yarubandi              2021-09-23   872  			opp-hz = /bits/ 64 <300000000>;
7720ea001b528d Roja Rani Yarubandi              2021-09-23   873  			required-opps = <&rpmhpd_opp_nom>;
7720ea001b528d Roja Rani Yarubandi              2021-09-23   874  		};
7720ea001b528d Roja Rani Yarubandi              2021-09-23   875  	};
7720ea001b528d Roja Rani Yarubandi              2021-09-23   876  
0e3e654696074b Krzysztof Kozlowski              2022-06-27   877  	qup_opp_table: opp-table-qup {
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23   878  		compatible = "operating-points-v2";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23   879  
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23   880  		opp-75000000 {
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23   881  			opp-hz = /bits/ 64 <75000000>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23   882  			required-opps = <&rpmhpd_opp_low_svs>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23   883  		};
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23   884  
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23   885  		opp-100000000 {
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23   886  			opp-hz = /bits/ 64 <100000000>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23   887  			required-opps = <&rpmhpd_opp_svs>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23   888  		};
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23   889  
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23   890  		opp-128000000 {
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23   891  			opp-hz = /bits/ 64 <128000000>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23   892  			required-opps = <&rpmhpd_opp_nom>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23   893  		};
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23   894  	};
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23   895  
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   896  	soc: soc@0 {
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   897  		#address-cells = <2>;
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   898  		#size-cells = <2>;
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   899  		ranges = <0 0 0 0 0x10 0>;
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   900  		dma-ranges = <0 0 0 0 0x10 0>;
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   901  		compatible = "simple-bus";
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   902  
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   903  		gcc: clock-controller@100000 {
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   904  			compatible = "qcom,gcc-sc7280";
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   905  			reg = <0 0x00100000 0 0x1f0000>;
ab7772de861200 Rajendra Nayak                   2021-03-11   906  			clocks = <&rpmhcc RPMH_CXO_CLK>,
ab7772de861200 Rajendra Nayak                   2021-03-11   907  				 <&rpmhcc RPMH_CXO_CLK_A>, <&sleep_clk>,
531c738fb36069 Johan Hovold                     2022-07-05   908  				 <0>, <&pcie1_lane>,
70c4a1ca13b333 Dmitry Baryshkov                 2023-07-11   909  				 <0>, <0>, <0>,
36888ed83f998c Dmitry Baryshkov                 2023-07-11   910  				 <&usb_1_qmpphy QMP_USB43DP_USB3_PIPE_CLK>;
ab7772de861200 Rajendra Nayak                   2021-03-11   911  			clock-names = "bi_tcxo", "bi_tcxo_ao", "sleep_clk",
fa09b2248714c6 Prasad Malisetty                 2021-11-16   912  				      "pcie_0_pipe_clk", "pcie_1_pipe_clk",
ab7772de861200 Rajendra Nayak                   2021-03-11   913  				      "ufs_phy_rx_symbol_0_clk", "ufs_phy_rx_symbol_1_clk",
ab7772de861200 Rajendra Nayak                   2021-03-11   914  				      "ufs_phy_tx_symbol_0_clk",
ab7772de861200 Rajendra Nayak                   2021-03-11   915  				      "usb3_phy_wrapper_gcc_usb30_pipe_clk";
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   916  			#clock-cells = <1>;
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   917  			#reset-cells = <1>;
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   918  			#power-domain-cells = <1>;
3d59187efc982b Rajendra Nayak                   2022-09-16   919  			power-domains = <&rpmhpd SC7280_CX>;
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   920  		};
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11   921  
2257fac94bc24d Sai Prakash Ranjan               2021-03-16   922  		ipcc: mailbox@408000 {
2257fac94bc24d Sai Prakash Ranjan               2021-03-16   923  			compatible = "qcom,sc7280-ipcc", "qcom,ipcc";
2257fac94bc24d Sai Prakash Ranjan               2021-03-16   924  			reg = <0 0x00408000 0 0x1000>;
2257fac94bc24d Sai Prakash Ranjan               2021-03-16   925  			interrupts = <GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>;
2257fac94bc24d Sai Prakash Ranjan               2021-03-16   926  			interrupt-controller;
2257fac94bc24d Sai Prakash Ranjan               2021-03-16   927  			#interrupt-cells = <3>;
2257fac94bc24d Sai Prakash Ranjan               2021-03-16   928  			#mbox-cells = <2>;
2257fac94bc24d Sai Prakash Ranjan               2021-03-16   929  		};
2257fac94bc24d Sai Prakash Ranjan               2021-03-16   930  
c1b2189a19cf2a Rajendra Nayak                   2021-07-30   931  		qfprom: efuse@784000 {
c1b2189a19cf2a Rajendra Nayak                   2021-07-30   932  			compatible = "qcom,sc7280-qfprom", "qcom,qfprom";
c1b2189a19cf2a Rajendra Nayak                   2021-07-30   933  			reg = <0 0x00784000 0 0xa20>,
c1b2189a19cf2a Rajendra Nayak                   2021-07-30   934  			      <0 0x00780000 0 0xa20>,
c1b2189a19cf2a Rajendra Nayak                   2021-07-30   935  			      <0 0x00782000 0 0x120>,
c1b2189a19cf2a Rajendra Nayak                   2021-07-30   936  			      <0 0x00786000 0 0x1fff>;
c1b2189a19cf2a Rajendra Nayak                   2021-07-30   937  			clocks = <&gcc GCC_SEC_CTRL_CLK_SRC>;
c1b2189a19cf2a Rajendra Nayak                   2021-07-30   938  			clock-names = "core";
c1b2189a19cf2a Rajendra Nayak                   2021-07-30   939  			power-domains = <&rpmhpd SC7280_MX>;
c1b2189a19cf2a Rajendra Nayak                   2021-07-30   940  			#address-cells = <1>;
c1b2189a19cf2a Rajendra Nayak                   2021-07-30   941  			#size-cells = <1>;
3bfef00d767124 Akhil P Oommen                   2022-02-26   942  
3bfef00d767124 Akhil P Oommen                   2022-02-26   943  			gpu_speed_bin: gpu_speed_bin@1e9 {
3bfef00d767124 Akhil P Oommen                   2022-02-26   944  				reg = <0x1e9 0x2>;
3bfef00d767124 Akhil P Oommen                   2022-02-26   945  				bits = <5 8>;
3bfef00d767124 Akhil P Oommen                   2022-02-26   946  			};
c1b2189a19cf2a Rajendra Nayak                   2021-07-30   947  		};
c1b2189a19cf2a Rajendra Nayak                   2021-07-30   948  
96bb736f05d156 Bhupesh Sharma                   2022-05-15   949  		sdhc_1: mmc@7c4000 {
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13   950  			compatible = "qcom,sc7280-sdhci", "qcom,sdhci-msm-v5";
f9800dde34e678 Douglas Anderson                 2022-02-02   951  			pinctrl-names = "default", "sleep";
f9800dde34e678 Douglas Anderson                 2022-02-02   952  			pinctrl-0 = <&sdc1_clk>, <&sdc1_cmd>, <&sdc1_data>, <&sdc1_rclk>;
f9800dde34e678 Douglas Anderson                 2022-02-02   953  			pinctrl-1 = <&sdc1_clk_sleep>, <&sdc1_cmd_sleep>, <&sdc1_data_sleep>, <&sdc1_rclk_sleep>;
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13   954  			status = "disabled";
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13   955  
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13   956  			reg = <0 0x007c4000 0 0x1000>,
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13   957  			      <0 0x007c5000 0 0x1000>;
21857088fa2747 Douglas Anderson                 2022-07-06   958  			reg-names = "hc", "cqhci";
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13   959  
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13   960  			iommus = <&apps_smmu 0xc0 0x0>;
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13   961  			interrupts = <GIC_SPI 652 IRQ_TYPE_LEVEL_HIGH>,
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13   962  				     <GIC_SPI 656 IRQ_TYPE_LEVEL_HIGH>;
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13   963  			interrupt-names = "hc_irq", "pwr_irq";
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13   964  
4ff12270dbbe24 Bhupesh Sharma                   2022-05-15   965  			clocks = <&gcc GCC_SDCC1_AHB_CLK>,
4ff12270dbbe24 Bhupesh Sharma                   2022-05-15   966  				 <&gcc GCC_SDCC1_APPS_CLK>,
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13   967  				 <&rpmhcc RPMH_CXO_CLK>;
4ff12270dbbe24 Bhupesh Sharma                   2022-05-15   968  			clock-names = "iface", "core", "xo";
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13   969  			interconnects = <&aggre1_noc MASTER_SDCC_1 0 &mc_virt SLAVE_EBI1 0>,
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13   970  					<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_SDCC_1 0>;
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13   971  			interconnect-names = "sdhc-ddr","cpu-sdhc";
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13   972  			power-domains = <&rpmhpd SC7280_CX>;
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13   973  			operating-points-v2 = <&sdhc1_opp_table>;
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13   974  
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13   975  			bus-width = <8>;
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13   976  			supports-cqe;
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13   977  
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13   978  			qcom,dll-config = <0x0007642c>;
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13   979  			qcom,ddr-config = <0x80040868>;
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13   980  
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13   981  			mmc-ddr-1_8v;
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13   982  			mmc-hs200-1_8v;
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13   983  			mmc-hs400-1_8v;
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13   984  			mmc-hs400-enhanced-strobe;
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13   985  
959cb513074386 Shaik Sajida Bhanu               2022-04-12   986  			resets = <&gcc GCC_SDCC1_BCR>;
959cb513074386 Shaik Sajida Bhanu               2022-04-12   987  
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13   988  			sdhc1_opp_table: opp-table {
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13   989  				compatible = "operating-points-v2";
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13   990  
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13   991  				opp-100000000 {
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13   992  					opp-hz = /bits/ 64 <100000000>;
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13   993  					required-opps = <&rpmhpd_opp_low_svs>;
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13   994  					opp-peak-kBps = <1800000 400000>;
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13   995  					opp-avg-kBps = <100000 0>;
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13   996  				};
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13   997  
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13   998  				opp-384000000 {
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13   999  					opp-hz = /bits/ 64 <384000000>;
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13  1000  					required-opps = <&rpmhpd_opp_nom>;
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13  1001  					opp-peak-kBps = <5400000 1600000>;
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13  1002  					opp-avg-kBps = <390000 0>;
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13  1003  				};
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13  1004  			};
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13  1005  		};
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13  1006  
c11e239f6aee32 Vinod Koul                       2022-04-21  1007  		gpi_dma0: dma-controller@900000 {
c11e239f6aee32 Vinod Koul                       2022-04-21  1008  			#dma-cells = <3>;
e9f2053b7866ac Krzysztof Kozlowski              2022-10-18  1009  			compatible = "qcom,sc7280-gpi-dma", "qcom,sm6350-gpi-dma";
c11e239f6aee32 Vinod Koul                       2022-04-21  1010  			reg = <0 0x00900000 0 0x60000>;
c11e239f6aee32 Vinod Koul                       2022-04-21  1011  			interrupts = <GIC_SPI 244 IRQ_TYPE_LEVEL_HIGH>,
c11e239f6aee32 Vinod Koul                       2022-04-21  1012  				     <GIC_SPI 245 IRQ_TYPE_LEVEL_HIGH>,
c11e239f6aee32 Vinod Koul                       2022-04-21  1013  				     <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>,
c11e239f6aee32 Vinod Koul                       2022-04-21  1014  				     <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>,
c11e239f6aee32 Vinod Koul                       2022-04-21  1015  				     <GIC_SPI 248 IRQ_TYPE_LEVEL_HIGH>,
c11e239f6aee32 Vinod Koul                       2022-04-21  1016  				     <GIC_SPI 249 IRQ_TYPE_LEVEL_HIGH>,
c11e239f6aee32 Vinod Koul                       2022-04-21  1017  				     <GIC_SPI 250 IRQ_TYPE_LEVEL_HIGH>,
c11e239f6aee32 Vinod Koul                       2022-04-21  1018  				     <GIC_SPI 251 IRQ_TYPE_LEVEL_HIGH>,
c11e239f6aee32 Vinod Koul                       2022-04-21  1019  				     <GIC_SPI 252 IRQ_TYPE_LEVEL_HIGH>,
c11e239f6aee32 Vinod Koul                       2022-04-21  1020  				     <GIC_SPI 253 IRQ_TYPE_LEVEL_HIGH>,
c11e239f6aee32 Vinod Koul                       2022-04-21  1021  				     <GIC_SPI 254 IRQ_TYPE_LEVEL_HIGH>,
c11e239f6aee32 Vinod Koul                       2022-04-21  1022  				     <GIC_SPI 255 IRQ_TYPE_LEVEL_HIGH>;
c11e239f6aee32 Vinod Koul                       2022-04-21  1023  			dma-channels = <12>;
c11e239f6aee32 Vinod Koul                       2022-04-21  1024  			dma-channel-mask = <0x7f>;
c11e239f6aee32 Vinod Koul                       2022-04-21  1025  			iommus = <&apps_smmu 0x0136 0x0>;
c11e239f6aee32 Vinod Koul                       2022-04-21  1026  			status = "disabled";
c11e239f6aee32 Vinod Koul                       2022-04-21  1027  		};
c11e239f6aee32 Vinod Koul                       2022-04-21  1028  
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11  1029  		qupv3_id_0: geniqup@9c0000 {
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11  1030  			compatible = "qcom,geni-se-qup";
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11  1031  			reg = <0 0x009c0000 0 0x2000>;
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11  1032  			clocks = <&gcc GCC_QUPV3_WRAP_0_M_AHB_CLK>,
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11  1033  				 <&gcc GCC_QUPV3_WRAP_0_S_AHB_CLK>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1034  			clock-names = "m-ahb", "s-ahb";
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11  1035  			#address-cells = <2>;
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11  1036  			#size-cells = <2>;
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11  1037  			ranges;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1038  			iommus = <&apps_smmu 0x123 0x0>;
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11  1039  			status = "disabled";
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11  1040  
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1041  			i2c0: i2c@980000 {
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1042  				compatible = "qcom,geni-i2c";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1043  				reg = <0 0x00980000 0 0x4000>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1044  				clocks = <&gcc GCC_QUPV3_WRAP0_S0_CLK>;
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11  1045  				clock-names = "se";
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11  1046  				pinctrl-names = "default";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1047  				pinctrl-0 = <&qup_i2c0_data_clk>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1048  				interrupts = <GIC_SPI 601 IRQ_TYPE_LEVEL_HIGH>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1049  				#address-cells = <1>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1050  				#size-cells = <0>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1051  				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1052  						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_0 0>,
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1053  						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1054  				interconnect-names = "qup-core", "qup-config",
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1055  							"qup-memory";
e3e9a580380730 Rajendra Nayak                   2022-09-27  1056  				power-domains = <&rpmhpd SC7280_CX>;
e3e9a580380730 Rajendra Nayak                   2022-09-27  1057  				required-opps = <&rpmhpd_opp_low_svs>;
18bec7f725c518 Vinod Koul                       2022-04-21  1058  				dmas = <&gpi_dma0 0 0 QCOM_GPI_I2C>,
18bec7f725c518 Vinod Koul                       2022-04-21  1059  				       <&gpi_dma0 1 0 QCOM_GPI_I2C>;
18bec7f725c518 Vinod Koul                       2022-04-21  1060  				dma-names = "tx", "rx";
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11  1061  				status = "disabled";
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11  1062  			};
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11  1063  
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1064  			spi0: spi@980000 {
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1065  				compatible = "qcom,geni-spi";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1066  				reg = <0 0x00980000 0 0x4000>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1067  				clocks = <&gcc GCC_QUPV3_WRAP0_S0_CLK>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1068  				clock-names = "se";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1069  				pinctrl-names = "default";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1070  				pinctrl-0 = <&qup_spi0_data_clk>, <&qup_spi0_cs>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1071  				interrupts = <GIC_SPI 601 IRQ_TYPE_LEVEL_HIGH>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1072  				#address-cells = <1>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1073  				#size-cells = <0>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1074  				power-domains = <&rpmhpd SC7280_CX>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1075  				operating-points-v2 = <&qup_opp_table>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1076  				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1077  						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_0 0>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1078  				interconnect-names = "qup-core", "qup-config";
18bec7f725c518 Vinod Koul                       2022-04-21  1079  				dmas = <&gpi_dma0 0 0 QCOM_GPI_SPI>,
18bec7f725c518 Vinod Koul                       2022-04-21  1080  				       <&gpi_dma0 1 0 QCOM_GPI_SPI>;
18bec7f725c518 Vinod Koul                       2022-04-21  1081  				dma-names = "tx", "rx";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1082  				status = "disabled";
297e6e38320f32 Odelu Kukatla                    2021-04-27  1083  			};
297e6e38320f32 Odelu Kukatla                    2021-04-27  1084  
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1085  			uart0: serial@980000 {
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1086  				compatible = "qcom,geni-uart";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1087  				reg = <0 0x00980000 0 0x4000>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1088  				clocks = <&gcc GCC_QUPV3_WRAP0_S0_CLK>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1089  				clock-names = "se";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1090  				pinctrl-names = "default";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1091  				pinctrl-0 = <&qup_uart0_cts>, <&qup_uart0_rts>, <&qup_uart0_tx>, <&qup_uart0_rx>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1092  				interrupts = <GIC_SPI 601 IRQ_TYPE_LEVEL_HIGH>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1093  				power-domains = <&rpmhpd SC7280_CX>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1094  				operating-points-v2 = <&qup_opp_table>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1095  				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1096  						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_0 0>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1097  				interconnect-names = "qup-core", "qup-config";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1098  				status = "disabled";
297e6e38320f32 Odelu Kukatla                    2021-04-27  1099  			};
297e6e38320f32 Odelu Kukatla                    2021-04-27  1100  
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1101  			i2c1: i2c@984000 {
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1102  				compatible = "qcom,geni-i2c";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1103  				reg = <0 0x00984000 0 0x4000>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1104  				clocks = <&gcc GCC_QUPV3_WRAP0_S1_CLK>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1105  				clock-names = "se";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1106  				pinctrl-names = "default";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1107  				pinctrl-0 = <&qup_i2c1_data_clk>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1108  				interrupts = <GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1109  				#address-cells = <1>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1110  				#size-cells = <0>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1111  				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1112  						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_0 0>,
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1113  						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1114  				interconnect-names = "qup-core", "qup-config",
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1115  							"qup-memory";
e3e9a580380730 Rajendra Nayak                   2022-09-27  1116  				power-domains = <&rpmhpd SC7280_CX>;
e3e9a580380730 Rajendra Nayak                   2022-09-27  1117  				required-opps = <&rpmhpd_opp_low_svs>;
18bec7f725c518 Vinod Koul                       2022-04-21  1118  				dmas = <&gpi_dma0 0 1 QCOM_GPI_I2C>,
18bec7f725c518 Vinod Koul                       2022-04-21  1119  				       <&gpi_dma0 1 1 QCOM_GPI_I2C>;
18bec7f725c518 Vinod Koul                       2022-04-21  1120  				dma-names = "tx", "rx";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1121  				status = "disabled";
297e6e38320f32 Odelu Kukatla                    2021-04-27  1122  			};
297e6e38320f32 Odelu Kukatla                    2021-04-27  1123  
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1124  			spi1: spi@984000 {
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1125  				compatible = "qcom,geni-spi";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1126  				reg = <0 0x00984000 0 0x4000>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1127  				clocks = <&gcc GCC_QUPV3_WRAP0_S1_CLK>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1128  				clock-names = "se";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1129  				pinctrl-names = "default";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1130  				pinctrl-0 = <&qup_spi1_data_clk>, <&qup_spi1_cs>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1131  				interrupts = <GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1132  				#address-cells = <1>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1133  				#size-cells = <0>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1134  				power-domains = <&rpmhpd SC7280_CX>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1135  				operating-points-v2 = <&qup_opp_table>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1136  				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1137  						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_0 0>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1138  				interconnect-names = "qup-core", "qup-config";
18bec7f725c518 Vinod Koul                       2022-04-21  1139  				dmas = <&gpi_dma0 0 1 QCOM_GPI_SPI>,
18bec7f725c518 Vinod Koul                       2022-04-21  1140  				       <&gpi_dma0 1 1 QCOM_GPI_SPI>;
18bec7f725c518 Vinod Koul                       2022-04-21  1141  				dma-names = "tx", "rx";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1142  				status = "disabled";
297e6e38320f32 Odelu Kukatla                    2021-04-27  1143  			};
297e6e38320f32 Odelu Kukatla                    2021-04-27  1144  
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1145  			uart1: serial@984000 {
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1146  				compatible = "qcom,geni-uart";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1147  				reg = <0 0x00984000 0 0x4000>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1148  				clocks = <&gcc GCC_QUPV3_WRAP0_S1_CLK>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1149  				clock-names = "se";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1150  				pinctrl-names = "default";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1151  				pinctrl-0 = <&qup_uart1_cts>, <&qup_uart1_rts>, <&qup_uart1_tx>, <&qup_uart1_rx>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1152  				interrupts = <GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1153  				power-domains = <&rpmhpd SC7280_CX>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1154  				operating-points-v2 = <&qup_opp_table>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1155  				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1156  						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_0 0>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1157  				interconnect-names = "qup-core", "qup-config";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1158  				status = "disabled";
297e6e38320f32 Odelu Kukatla                    2021-04-27  1159  			};
297e6e38320f32 Odelu Kukatla                    2021-04-27  1160  
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1161  			i2c2: i2c@988000 {
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1162  				compatible = "qcom,geni-i2c";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1163  				reg = <0 0x00988000 0 0x4000>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1164  				clocks = <&gcc GCC_QUPV3_WRAP0_S2_CLK>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1165  				clock-names = "se";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1166  				pinctrl-names = "default";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1167  				pinctrl-0 = <&qup_i2c2_data_clk>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1168  				interrupts = <GIC_SPI 603 IRQ_TYPE_LEVEL_HIGH>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1169  				#address-cells = <1>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1170  				#size-cells = <0>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1171  				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1172  						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_0 0>,
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1173  						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1174  				interconnect-names = "qup-core", "qup-config",
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1175  							"qup-memory";
e3e9a580380730 Rajendra Nayak                   2022-09-27  1176  				power-domains = <&rpmhpd SC7280_CX>;
e3e9a580380730 Rajendra Nayak                   2022-09-27  1177  				required-opps = <&rpmhpd_opp_low_svs>;
18bec7f725c518 Vinod Koul                       2022-04-21  1178  				dmas = <&gpi_dma0 0 2 QCOM_GPI_I2C>,
18bec7f725c518 Vinod Koul                       2022-04-21  1179  				       <&gpi_dma0 1 2 QCOM_GPI_I2C>;
18bec7f725c518 Vinod Koul                       2022-04-21  1180  				dma-names = "tx", "rx";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1181  				status = "disabled";
297e6e38320f32 Odelu Kukatla                    2021-04-27  1182  			};
297e6e38320f32 Odelu Kukatla                    2021-04-27  1183  
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1184  			spi2: spi@988000 {
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1185  				compatible = "qcom,geni-spi";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1186  				reg = <0 0x00988000 0 0x4000>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1187  				clocks = <&gcc GCC_QUPV3_WRAP0_S2_CLK>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1188  				clock-names = "se";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1189  				pinctrl-names = "default";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1190  				pinctrl-0 = <&qup_spi2_data_clk>, <&qup_spi2_cs>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1191  				interrupts = <GIC_SPI 603 IRQ_TYPE_LEVEL_HIGH>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1192  				#address-cells = <1>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1193  				#size-cells = <0>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1194  				power-domains = <&rpmhpd SC7280_CX>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1195  				operating-points-v2 = <&qup_opp_table>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1196  				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1197  						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_0 0>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1198  				interconnect-names = "qup-core", "qup-config";
18bec7f725c518 Vinod Koul                       2022-04-21  1199  				dmas = <&gpi_dma0 0 2 QCOM_GPI_SPI>,
18bec7f725c518 Vinod Koul                       2022-04-21  1200  				       <&gpi_dma0 1 2 QCOM_GPI_SPI>;
18bec7f725c518 Vinod Koul                       2022-04-21  1201  				dma-names = "tx", "rx";
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11  1202  				status = "disabled";
297e6e38320f32 Odelu Kukatla                    2021-04-27  1203  			};
297e6e38320f32 Odelu Kukatla                    2021-04-27  1204  
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1205  			uart2: serial@988000 {
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1206  				compatible = "qcom,geni-uart";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1207  				reg = <0 0x00988000 0 0x4000>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1208  				clocks = <&gcc GCC_QUPV3_WRAP0_S2_CLK>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1209  				clock-names = "se";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1210  				pinctrl-names = "default";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1211  				pinctrl-0 = <&qup_uart2_cts>, <&qup_uart2_rts>, <&qup_uart2_tx>, <&qup_uart2_rx>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1212  				interrupts = <GIC_SPI 603 IRQ_TYPE_LEVEL_HIGH>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1213  				power-domains = <&rpmhpd SC7280_CX>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1214  				operating-points-v2 = <&qup_opp_table>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1215  				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1216  						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_0 0>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1217  				interconnect-names = "qup-core", "qup-config";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1218  				status = "disabled";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1219  			};
fc4f0273d4fba2 Alex Elder                       2021-08-04  1220  
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1221  			i2c3: i2c@98c000 {
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1222  				compatible = "qcom,geni-i2c";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1223  				reg = <0 0x0098c000 0 0x4000>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1224  				clocks = <&gcc GCC_QUPV3_WRAP0_S3_CLK>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1225  				clock-names = "se";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1226  				pinctrl-names = "default";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1227  				pinctrl-0 = <&qup_i2c3_data_clk>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1228  				interrupts = <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1229  				#address-cells = <1>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1230  				#size-cells = <0>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1231  				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1232  						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_0 0>,
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1233  						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1234  				interconnect-names = "qup-core", "qup-config",
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1235  							"qup-memory";
e3e9a580380730 Rajendra Nayak                   2022-09-27  1236  				power-domains = <&rpmhpd SC7280_CX>;
e3e9a580380730 Rajendra Nayak                   2022-09-27  1237  				required-opps = <&rpmhpd_opp_low_svs>;
18bec7f725c518 Vinod Koul                       2022-04-21  1238  				dmas = <&gpi_dma0 0 3 QCOM_GPI_I2C>,
18bec7f725c518 Vinod Koul                       2022-04-21  1239  				       <&gpi_dma0 1 3 QCOM_GPI_I2C>;
18bec7f725c518 Vinod Koul                       2022-04-21  1240  				dma-names = "tx", "rx";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1241  				status = "disabled";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1242  			};
fc4f0273d4fba2 Alex Elder                       2021-08-04  1243  
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1244  			spi3: spi@98c000 {
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1245  				compatible = "qcom,geni-spi";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1246  				reg = <0 0x0098c000 0 0x4000>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1247  				clocks = <&gcc GCC_QUPV3_WRAP0_S3_CLK>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1248  				clock-names = "se";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1249  				pinctrl-names = "default";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1250  				pinctrl-0 = <&qup_spi3_data_clk>, <&qup_spi3_cs>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1251  				interrupts = <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1252  				#address-cells = <1>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1253  				#size-cells = <0>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1254  				power-domains = <&rpmhpd SC7280_CX>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1255  				operating-points-v2 = <&qup_opp_table>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1256  				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1257  						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_0 0>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1258  				interconnect-names = "qup-core", "qup-config";
18bec7f725c518 Vinod Koul                       2022-04-21  1259  				dmas = <&gpi_dma0 0 3 QCOM_GPI_SPI>,
18bec7f725c518 Vinod Koul                       2022-04-21  1260  				       <&gpi_dma0 1 3 QCOM_GPI_SPI>;
18bec7f725c518 Vinod Koul                       2022-04-21  1261  				dma-names = "tx", "rx";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1262  				status = "disabled";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1263  			};
fc4f0273d4fba2 Alex Elder                       2021-08-04  1264  
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1265  			uart3: serial@98c000 {
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1266  				compatible = "qcom,geni-uart";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1267  				reg = <0 0x0098c000 0 0x4000>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1268  				clocks = <&gcc GCC_QUPV3_WRAP0_S3_CLK>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1269  				clock-names = "se";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1270  				pinctrl-names = "default";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1271  				pinctrl-0 = <&qup_uart3_cts>, <&qup_uart3_rts>, <&qup_uart3_tx>, <&qup_uart3_rx>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1272  				interrupts = <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1273  				power-domains = <&rpmhpd SC7280_CX>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1274  				operating-points-v2 = <&qup_opp_table>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1275  				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1276  						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_0 0>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1277  				interconnect-names = "qup-core", "qup-config";
fc4f0273d4fba2 Alex Elder                       2021-08-04  1278  				status = "disabled";
fc4f0273d4fba2 Alex Elder                       2021-08-04  1279  			};
fc4f0273d4fba2 Alex Elder                       2021-08-04  1280  
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1281  			i2c4: i2c@990000 {
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1282  				compatible = "qcom,geni-i2c";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1283  				reg = <0 0x00990000 0 0x4000>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1284  				clocks = <&gcc GCC_QUPV3_WRAP0_S4_CLK>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1285  				clock-names = "se";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1286  				pinctrl-names = "default";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1287  				pinctrl-0 = <&qup_i2c4_data_clk>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1288  				interrupts = <GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1289  				#address-cells = <1>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1290  				#size-cells = <0>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1291  				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1292  						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_0 0>,
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1293  						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1294  				interconnect-names = "qup-core", "qup-config",
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1295  							"qup-memory";
e3e9a580380730 Rajendra Nayak                   2022-09-27  1296  				power-domains = <&rpmhpd SC7280_CX>;
e3e9a580380730 Rajendra Nayak                   2022-09-27  1297  				required-opps = <&rpmhpd_opp_low_svs>;
18bec7f725c518 Vinod Koul                       2022-04-21  1298  				dmas = <&gpi_dma0 0 4 QCOM_GPI_I2C>,
18bec7f725c518 Vinod Koul                       2022-04-21  1299  				       <&gpi_dma0 1 4 QCOM_GPI_I2C>;
18bec7f725c518 Vinod Koul                       2022-04-21  1300  				dma-names = "tx", "rx";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1301  				status = "disabled";
c3bbe55c942d2a Sibi Sankar                      2021-04-27  1302  			};
c3bbe55c942d2a Sibi Sankar                      2021-04-27  1303  
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1304  			spi4: spi@990000 {
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1305  				compatible = "qcom,geni-spi";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1306  				reg = <0 0x00990000 0 0x4000>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1307  				clocks = <&gcc GCC_QUPV3_WRAP0_S4_CLK>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1308  				clock-names = "se";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1309  				pinctrl-names = "default";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1310  				pinctrl-0 = <&qup_spi4_data_clk>, <&qup_spi4_cs>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1311  				interrupts = <GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1312  				#address-cells = <1>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1313  				#size-cells = <0>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1314  				power-domains = <&rpmhpd SC7280_CX>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1315  				operating-points-v2 = <&qup_opp_table>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1316  				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1317  						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_0 0>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1318  				interconnect-names = "qup-core", "qup-config";
18bec7f725c518 Vinod Koul                       2022-04-21  1319  				dmas = <&gpi_dma0 0 4 QCOM_GPI_SPI>,
18bec7f725c518 Vinod Koul                       2022-04-21  1320  				       <&gpi_dma0 1 4 QCOM_GPI_SPI>;
18bec7f725c518 Vinod Koul                       2022-04-21  1321  				dma-names = "tx", "rx";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1322  				status = "disabled";
422a295221bba8 Taniya Das                       2021-04-10  1323  			};
422a295221bba8 Taniya Das                       2021-04-10  1324  
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1325  			uart4: serial@990000 {
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1326  				compatible = "qcom,geni-uart";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1327  				reg = <0 0x00990000 0 0x4000>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1328  				clocks = <&gcc GCC_QUPV3_WRAP0_S4_CLK>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1329  				clock-names = "se";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1330  				pinctrl-names = "default";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1331  				pinctrl-0 = <&qup_uart4_cts>, <&qup_uart4_rts>, <&qup_uart4_tx>, <&qup_uart4_rx>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1332  				interrupts = <GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1333  				power-domains = <&rpmhpd SC7280_CX>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1334  				operating-points-v2 = <&qup_opp_table>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1335  				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1336  						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_0 0>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1337  				interconnect-names = "qup-core", "qup-config";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1338  				status = "disabled";
297e6e38320f32 Odelu Kukatla                    2021-04-27  1339  			};
297e6e38320f32 Odelu Kukatla                    2021-04-27  1340  
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1341  			i2c5: i2c@994000 {
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1342  				compatible = "qcom,geni-i2c";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1343  				reg = <0 0x00994000 0 0x4000>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1344  				clocks = <&gcc GCC_QUPV3_WRAP0_S5_CLK>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1345  				clock-names = "se";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1346  				pinctrl-names = "default";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1347  				pinctrl-0 = <&qup_i2c5_data_clk>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1348  				interrupts = <GIC_SPI 606 IRQ_TYPE_LEVEL_HIGH>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1349  				#address-cells = <1>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1350  				#size-cells = <0>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1351  				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1352  						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_0 0>,
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1353  						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1354  				interconnect-names = "qup-core", "qup-config",
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1355  							"qup-memory";
e3e9a580380730 Rajendra Nayak                   2022-09-27  1356  				power-domains = <&rpmhpd SC7280_CX>;
e3e9a580380730 Rajendra Nayak                   2022-09-27  1357  				required-opps = <&rpmhpd_opp_low_svs>;
18bec7f725c518 Vinod Koul                       2022-04-21  1358  				dmas = <&gpi_dma0 0 5 QCOM_GPI_I2C>,
18bec7f725c518 Vinod Koul                       2022-04-21  1359  				       <&gpi_dma0 1 5 QCOM_GPI_I2C>;
18bec7f725c518 Vinod Koul                       2022-04-21  1360  				dma-names = "tx", "rx";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1361  				status = "disabled";
422a295221bba8 Taniya Das                       2021-04-10  1362  			};
422a295221bba8 Taniya Das                       2021-04-10  1363  
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1364  			spi5: spi@994000 {
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1365  				compatible = "qcom,geni-spi";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1366  				reg = <0 0x00994000 0 0x4000>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1367  				clocks = <&gcc GCC_QUPV3_WRAP0_S5_CLK>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1368  				clock-names = "se";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1369  				pinctrl-names = "default";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1370  				pinctrl-0 = <&qup_spi5_data_clk>, <&qup_spi5_cs>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1371  				interrupts = <GIC_SPI 606 IRQ_TYPE_LEVEL_HIGH>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1372  				#address-cells = <1>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1373  				#size-cells = <0>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1374  				power-domains = <&rpmhpd SC7280_CX>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1375  				operating-points-v2 = <&qup_opp_table>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1376  				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1377  						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_0 0>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1378  				interconnect-names = "qup-core", "qup-config";
18bec7f725c518 Vinod Koul                       2022-04-21  1379  				dmas = <&gpi_dma0 0 5 QCOM_GPI_SPI>,
18bec7f725c518 Vinod Koul                       2022-04-21  1380  				       <&gpi_dma0 1 5 QCOM_GPI_SPI>;
18bec7f725c518 Vinod Koul                       2022-04-21  1381  				dma-names = "tx", "rx";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1382  				status = "disabled";
544cebe1895638 Sai Prakash Ranjan               2021-03-16  1383  			};
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11  1384  
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11  1385  			uart5: serial@994000 {
38cd93f413fd94 Roja Rani Yarubandi              2021-09-23  1386  				compatible = "qcom,geni-uart";
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11  1387  				reg = <0 0x00994000 0 0x4000>;
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11  1388  				clocks = <&gcc GCC_QUPV3_WRAP0_S5_CLK>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1389  				clock-names = "se";
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11  1390  				pinctrl-names = "default";
38cd93f413fd94 Roja Rani Yarubandi              2021-09-23  1391  				pinctrl-0 = <&qup_uart5_cts>, <&qup_uart5_rts>, <&qup_uart5_tx>, <&qup_uart5_rx>;
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11  1392  				interrupts = <GIC_SPI 606 IRQ_TYPE_LEVEL_HIGH>;
38cd93f413fd94 Roja Rani Yarubandi              2021-09-23  1393  				power-domains = <&rpmhpd SC7280_CX>;
38cd93f413fd94 Roja Rani Yarubandi              2021-09-23  1394  				operating-points-v2 = <&qup_opp_table>;
38cd93f413fd94 Roja Rani Yarubandi              2021-09-23  1395  				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
38cd93f413fd94 Roja Rani Yarubandi              2021-09-23  1396  						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_0 0>;
38cd93f413fd94 Roja Rani Yarubandi              2021-09-23  1397  				interconnect-names = "qup-core", "qup-config";
7a1f4e7f740de9 Rajendra Nayak                   2021-03-11  1398  				status = "disabled";
544cebe1895638 Sai Prakash Ranjan               2021-03-16  1399  			};
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1400  
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1401  			i2c6: i2c@998000 {
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1402  				compatible = "qcom,geni-i2c";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1403  				reg = <0 0x00998000 0 0x4000>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1404  				clocks = <&gcc GCC_QUPV3_WRAP0_S6_CLK>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1405  				clock-names = "se";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1406  				pinctrl-names = "default";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1407  				pinctrl-0 = <&qup_i2c6_data_clk>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1408  				interrupts = <GIC_SPI 607 IRQ_TYPE_LEVEL_HIGH>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1409  				#address-cells = <1>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1410  				#size-cells = <0>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1411  				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1412  						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_0 0>,
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1413  						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1414  				interconnect-names = "qup-core", "qup-config",
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1415  							"qup-memory";
e3e9a580380730 Rajendra Nayak                   2022-09-27  1416  				power-domains = <&rpmhpd SC7280_CX>;
e3e9a580380730 Rajendra Nayak                   2022-09-27  1417  				required-opps = <&rpmhpd_opp_low_svs>;
18bec7f725c518 Vinod Koul                       2022-04-21  1418  				dmas = <&gpi_dma0 0 6 QCOM_GPI_I2C>,
18bec7f725c518 Vinod Koul                       2022-04-21  1419  				       <&gpi_dma0 1 6 QCOM_GPI_I2C>;
18bec7f725c518 Vinod Koul                       2022-04-21  1420  				dma-names = "tx", "rx";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1421  				status = "disabled";
544cebe1895638 Sai Prakash Ranjan               2021-03-16  1422  			};
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1423  
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1424  			spi6: spi@998000 {
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1425  				compatible = "qcom,geni-spi";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1426  				reg = <0 0x00998000 0 0x4000>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1427  				clocks = <&gcc GCC_QUPV3_WRAP0_S6_CLK>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1428  				clock-names = "se";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1429  				pinctrl-names = "default";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1430  				pinctrl-0 = <&qup_spi6_data_clk>, <&qup_spi6_cs>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1431  				interrupts = <GIC_SPI 607 IRQ_TYPE_LEVEL_HIGH>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1432  				#address-cells = <1>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1433  				#size-cells = <0>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1434  				power-domains = <&rpmhpd SC7280_CX>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1435  				operating-points-v2 = <&qup_opp_table>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1436  				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1437  						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_0 0>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1438  				interconnect-names = "qup-core", "qup-config";
18bec7f725c518 Vinod Koul                       2022-04-21  1439  				dmas = <&gpi_dma0 0 6 QCOM_GPI_SPI>,
18bec7f725c518 Vinod Koul                       2022-04-21  1440  				       <&gpi_dma0 1 6 QCOM_GPI_SPI>;
18bec7f725c518 Vinod Koul                       2022-04-21  1441  				dma-names = "tx", "rx";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1442  				status = "disabled";
544cebe1895638 Sai Prakash Ranjan               2021-03-16  1443  			};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  1444  
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1445  			uart6: serial@998000 {
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1446  				compatible = "qcom,geni-uart";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1447  				reg = <0 0x00998000 0 0x4000>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1448  				clocks = <&gcc GCC_QUPV3_WRAP0_S6_CLK>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1449  				clock-names = "se";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1450  				pinctrl-names = "default";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1451  				pinctrl-0 = <&qup_uart6_cts>, <&qup_uart6_rts>, <&qup_uart6_tx>, <&qup_uart6_rx>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1452  				interrupts = <GIC_SPI 607 IRQ_TYPE_LEVEL_HIGH>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1453  				power-domains = <&rpmhpd SC7280_CX>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1454  				operating-points-v2 = <&qup_opp_table>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1455  				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1456  						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_0 0>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1457  				interconnect-names = "qup-core", "qup-config";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1458  				status = "disabled";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1459  			};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  1460  
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1461  			i2c7: i2c@99c000 {
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1462  				compatible = "qcom,geni-i2c";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1463  				reg = <0 0x0099c000 0 0x4000>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1464  				clocks = <&gcc GCC_QUPV3_WRAP0_S7_CLK>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1465  				clock-names = "se";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1466  				pinctrl-names = "default";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1467  				pinctrl-0 = <&qup_i2c7_data_clk>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1468  				interrupts = <GIC_SPI 608 IRQ_TYPE_LEVEL_HIGH>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1469  				#address-cells = <1>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1470  				#size-cells = <0>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1471  				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1472  						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_0 0>,
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1473  						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1474  				interconnect-names = "qup-core", "qup-config",
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1475  							"qup-memory";
e3e9a580380730 Rajendra Nayak                   2022-09-27  1476  				power-domains = <&rpmhpd SC7280_CX>;
e3e9a580380730 Rajendra Nayak                   2022-09-27  1477  				required-opps = <&rpmhpd_opp_low_svs>;
18bec7f725c518 Vinod Koul                       2022-04-21  1478  				dmas = <&gpi_dma0 0 7 QCOM_GPI_I2C>,
18bec7f725c518 Vinod Koul                       2022-04-21  1479  				       <&gpi_dma0 1 7 QCOM_GPI_I2C>;
18bec7f725c518 Vinod Koul                       2022-04-21  1480  				dma-names = "tx", "rx";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1481  				status = "disabled";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1482  			};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  1483  
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1484  			spi7: spi@99c000 {
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1485  				compatible = "qcom,geni-spi";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1486  				reg = <0 0x0099c000 0 0x4000>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1487  				clocks = <&gcc GCC_QUPV3_WRAP0_S7_CLK>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1488  				clock-names = "se";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1489  				pinctrl-names = "default";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1490  				pinctrl-0 = <&qup_spi7_data_clk>, <&qup_spi7_cs>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1491  				interrupts = <GIC_SPI 608 IRQ_TYPE_LEVEL_HIGH>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1492  				#address-cells = <1>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1493  				#size-cells = <0>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1494  				power-domains = <&rpmhpd SC7280_CX>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1495  				operating-points-v2 = <&qup_opp_table>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1496  				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1497  						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_0 0>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1498  				interconnect-names = "qup-core", "qup-config";
18bec7f725c518 Vinod Koul                       2022-04-21  1499  				dmas = <&gpi_dma0 0 7 QCOM_GPI_SPI>,
18bec7f725c518 Vinod Koul                       2022-04-21  1500  				       <&gpi_dma0 1 7 QCOM_GPI_SPI>;
18bec7f725c518 Vinod Koul                       2022-04-21  1501  				dma-names = "tx", "rx";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1502  				status = "disabled";
544cebe1895638 Sai Prakash Ranjan               2021-03-16  1503  			};
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1504  
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1505  			uart7: serial@99c000 {
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1506  				compatible = "qcom,geni-uart";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1507  				reg = <0 0x0099c000 0 0x4000>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1508  				clocks = <&gcc GCC_QUPV3_WRAP0_S7_CLK>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1509  				clock-names = "se";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1510  				pinctrl-names = "default";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1511  				pinctrl-0 = <&qup_uart7_cts>, <&qup_uart7_rts>, <&qup_uart7_tx>, <&qup_uart7_rx>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1512  				interrupts = <GIC_SPI 608 IRQ_TYPE_LEVEL_HIGH>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1513  				power-domains = <&rpmhpd SC7280_CX>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1514  				operating-points-v2 = <&qup_opp_table>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1515  				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1516  						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_0 0>;
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1517  				interconnect-names = "qup-core", "qup-config";
bf6f37a3086bec Roja Rani Yarubandi              2021-09-23  1518  				status = "disabled";
544cebe1895638 Sai Prakash Ranjan               2021-03-16  1519  			};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  1520  		};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  1521  
c11e239f6aee32 Vinod Koul                       2022-04-21  1522  		gpi_dma1: dma-controller@a00000 {
c11e239f6aee32 Vinod Koul                       2022-04-21  1523  			#dma-cells = <3>;
e9f2053b7866ac Krzysztof Kozlowski              2022-10-18  1524  			compatible = "qcom,sc7280-gpi-dma", "qcom,sm6350-gpi-dma";
c11e239f6aee32 Vinod Koul                       2022-04-21  1525  			reg = <0 0x00a00000 0 0x60000>;
c11e239f6aee32 Vinod Koul                       2022-04-21  1526  			interrupts = <GIC_SPI 279 IRQ_TYPE_LEVEL_HIGH>,
c11e239f6aee32 Vinod Koul                       2022-04-21  1527  				     <GIC_SPI 280 IRQ_TYPE_LEVEL_HIGH>,
c11e239f6aee32 Vinod Koul                       2022-04-21  1528  				     <GIC_SPI 281 IRQ_TYPE_LEVEL_HIGH>,
c11e239f6aee32 Vinod Koul                       2022-04-21  1529  				     <GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>,
c11e239f6aee32 Vinod Koul                       2022-04-21  1530  				     <GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>,
c11e239f6aee32 Vinod Koul                       2022-04-21  1531  				     <GIC_SPI 284 IRQ_TYPE_LEVEL_HIGH>,
c11e239f6aee32 Vinod Koul                       2022-04-21  1532  				     <GIC_SPI 293 IRQ_TYPE_LEVEL_HIGH>,
c11e239f6aee32 Vinod Koul                       2022-04-21  1533  				     <GIC_SPI 294 IRQ_TYPE_LEVEL_HIGH>,
c11e239f6aee32 Vinod Koul                       2022-04-21  1534  				     <GIC_SPI 295 IRQ_TYPE_LEVEL_HIGH>,
c11e239f6aee32 Vinod Koul                       2022-04-21  1535  				     <GIC_SPI 296 IRQ_TYPE_LEVEL_HIGH>,
c11e239f6aee32 Vinod Koul                       2022-04-21  1536  				     <GIC_SPI 297 IRQ_TYPE_LEVEL_HIGH>,
c11e239f6aee32 Vinod Koul                       2022-04-21  1537  				     <GIC_SPI 298 IRQ_TYPE_LEVEL_HIGH>;
c11e239f6aee32 Vinod Koul                       2022-04-21  1538  			dma-channels = <12>;
c11e239f6aee32 Vinod Koul                       2022-04-21  1539  			dma-channel-mask = <0x1e>;
c11e239f6aee32 Vinod Koul                       2022-04-21  1540  			iommus = <&apps_smmu 0x56 0x0>;
c11e239f6aee32 Vinod Koul                       2022-04-21  1541  			status = "disabled";
c11e239f6aee32 Vinod Koul                       2022-04-21  1542  		};
c11e239f6aee32 Vinod Koul                       2022-04-21  1543  
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1544  		qupv3_id_1: geniqup@ac0000 {
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1545  			compatible = "qcom,geni-se-qup";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1546  			reg = <0 0x00ac0000 0 0x2000>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1547  			clocks = <&gcc GCC_QUPV3_WRAP_1_M_AHB_CLK>,
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1548  				 <&gcc GCC_QUPV3_WRAP_1_S_AHB_CLK>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1549  			clock-names = "m-ahb", "s-ahb";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1550  			#address-cells = <2>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1551  			#size-cells = <2>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1552  			ranges;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1553  			iommus = <&apps_smmu 0x43 0x0>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1554  			status = "disabled";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1555  
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1556  			i2c8: i2c@a80000 {
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1557  				compatible = "qcom,geni-i2c";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1558  				reg = <0 0x00a80000 0 0x4000>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1559  				clocks = <&gcc GCC_QUPV3_WRAP1_S0_CLK>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1560  				clock-names = "se";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1561  				pinctrl-names = "default";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1562  				pinctrl-0 = <&qup_i2c8_data_clk>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1563  				interrupts = <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  1564  				#address-cells = <1>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  1565  				#size-cells = <0>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1566  				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1567  						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_1 0>,
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1568  						<&aggre2_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1569  				interconnect-names = "qup-core", "qup-config",
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1570  							"qup-memory";
e3e9a580380730 Rajendra Nayak                   2022-09-27  1571  				power-domains = <&rpmhpd SC7280_CX>;
e3e9a580380730 Rajendra Nayak                   2022-09-27  1572  				required-opps = <&rpmhpd_opp_low_svs>;
18bec7f725c518 Vinod Koul                       2022-04-21  1573  				dmas = <&gpi_dma1 0 0 QCOM_GPI_I2C>,
18bec7f725c518 Vinod Koul                       2022-04-21  1574  				       <&gpi_dma1 1 0 QCOM_GPI_I2C>;
18bec7f725c518 Vinod Koul                       2022-04-21  1575  				dma-names = "tx", "rx";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1576  				status = "disabled";
544cebe1895638 Sai Prakash Ranjan               2021-03-16  1577  			};
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1578  
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1579  			spi8: spi@a80000 {
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1580  				compatible = "qcom,geni-spi";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1581  				reg = <0 0x00a80000 0 0x4000>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1582  				clocks = <&gcc GCC_QUPV3_WRAP1_S0_CLK>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1583  				clock-names = "se";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1584  				pinctrl-names = "default";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1585  				pinctrl-0 = <&qup_spi8_data_clk>, <&qup_spi8_cs>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1586  				interrupts = <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1587  				#address-cells = <1>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1588  				#size-cells = <0>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1589  				power-domains = <&rpmhpd SC7280_CX>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1590  				operating-points-v2 = <&qup_opp_table>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1591  				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1592  						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_1 0>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1593  				interconnect-names = "qup-core", "qup-config";
18bec7f725c518 Vinod Koul                       2022-04-21  1594  				dmas = <&gpi_dma1 0 0 QCOM_GPI_SPI>,
18bec7f725c518 Vinod Koul                       2022-04-21  1595  				       <&gpi_dma1 1 0 QCOM_GPI_SPI>;
18bec7f725c518 Vinod Koul                       2022-04-21  1596  				dma-names = "tx", "rx";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1597  				status = "disabled";
544cebe1895638 Sai Prakash Ranjan               2021-03-16  1598  			};
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1599  
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1600  			uart8: serial@a80000 {
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1601  				compatible = "qcom,geni-uart";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1602  				reg = <0 0x00a80000 0 0x4000>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1603  				clocks = <&gcc GCC_QUPV3_WRAP1_S0_CLK>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1604  				clock-names = "se";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1605  				pinctrl-names = "default";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1606  				pinctrl-0 = <&qup_uart8_cts>, <&qup_uart8_rts>, <&qup_uart8_tx>, <&qup_uart8_rx>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1607  				interrupts = <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1608  				power-domains = <&rpmhpd SC7280_CX>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1609  				operating-points-v2 = <&qup_opp_table>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1610  				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1611  						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_1 0>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1612  				interconnect-names = "qup-core", "qup-config";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1613  				status = "disabled";
544cebe1895638 Sai Prakash Ranjan               2021-03-16  1614  			};
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1615  
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1616  			i2c9: i2c@a84000 {
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1617  				compatible = "qcom,geni-i2c";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1618  				reg = <0 0x00a84000 0 0x4000>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1619  				clocks = <&gcc GCC_QUPV3_WRAP1_S1_CLK>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1620  				clock-names = "se";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1621  				pinctrl-names = "default";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1622  				pinctrl-0 = <&qup_i2c9_data_clk>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1623  				interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1624  				#address-cells = <1>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1625  				#size-cells = <0>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1626  				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1627  						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_1 0>,
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1628  						<&aggre2_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1629  				interconnect-names = "qup-core", "qup-config",
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1630  							"qup-memory";
e3e9a580380730 Rajendra Nayak                   2022-09-27  1631  				power-domains = <&rpmhpd SC7280_CX>;
e3e9a580380730 Rajendra Nayak                   2022-09-27  1632  				required-opps = <&rpmhpd_opp_low_svs>;
18bec7f725c518 Vinod Koul                       2022-04-21  1633  				dmas = <&gpi_dma1 0 1 QCOM_GPI_I2C>,
18bec7f725c518 Vinod Koul                       2022-04-21  1634  				       <&gpi_dma1 1 1 QCOM_GPI_I2C>;
18bec7f725c518 Vinod Koul                       2022-04-21  1635  				dma-names = "tx", "rx";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1636  				status = "disabled";
544cebe1895638 Sai Prakash Ranjan               2021-03-16  1637  			};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  1638  
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1639  			spi9: spi@a84000 {
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1640  				compatible = "qcom,geni-spi";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1641  				reg = <0 0x00a84000 0 0x4000>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1642  				clocks = <&gcc GCC_QUPV3_WRAP1_S1_CLK>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1643  				clock-names = "se";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1644  				pinctrl-names = "default";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1645  				pinctrl-0 = <&qup_spi9_data_clk>, <&qup_spi9_cs>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1646  				interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1647  				#address-cells = <1>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1648  				#size-cells = <0>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1649  				power-domains = <&rpmhpd SC7280_CX>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1650  				operating-points-v2 = <&qup_opp_table>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1651  				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1652  						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_1 0>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1653  				interconnect-names = "qup-core", "qup-config";
18bec7f725c518 Vinod Koul                       2022-04-21  1654  				dmas = <&gpi_dma1 0 1 QCOM_GPI_SPI>,
18bec7f725c518 Vinod Koul                       2022-04-21  1655  				       <&gpi_dma1 1 1 QCOM_GPI_SPI>;
18bec7f725c518 Vinod Koul                       2022-04-21  1656  				dma-names = "tx", "rx";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1657  				status = "disabled";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1658  			};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  1659  
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1660  			uart9: serial@a84000 {
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1661  				compatible = "qcom,geni-uart";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1662  				reg = <0 0x00a84000 0 0x4000>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1663  				clocks = <&gcc GCC_QUPV3_WRAP1_S1_CLK>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1664  				clock-names = "se";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1665  				pinctrl-names = "default";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1666  				pinctrl-0 = <&qup_uart9_cts>, <&qup_uart9_rts>, <&qup_uart9_tx>, <&qup_uart9_rx>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1667  				interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1668  				power-domains = <&rpmhpd SC7280_CX>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1669  				operating-points-v2 = <&qup_opp_table>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1670  				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1671  						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_1 0>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1672  				interconnect-names = "qup-core", "qup-config";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1673  				status = "disabled";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1674  			};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  1675  
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1676  			i2c10: i2c@a88000 {
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1677  				compatible = "qcom,geni-i2c";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1678  				reg = <0 0x00a88000 0 0x4000>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1679  				clocks = <&gcc GCC_QUPV3_WRAP1_S2_CLK>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1680  				clock-names = "se";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1681  				pinctrl-names = "default";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1682  				pinctrl-0 = <&qup_i2c10_data_clk>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1683  				interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1684  				#address-cells = <1>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1685  				#size-cells = <0>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1686  				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1687  						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_1 0>,
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1688  						<&aggre2_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1689  				interconnect-names = "qup-core", "qup-config",
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1690  							"qup-memory";
e3e9a580380730 Rajendra Nayak                   2022-09-27  1691  				power-domains = <&rpmhpd SC7280_CX>;
e3e9a580380730 Rajendra Nayak                   2022-09-27  1692  				required-opps = <&rpmhpd_opp_low_svs>;
18bec7f725c518 Vinod Koul                       2022-04-21  1693  				dmas = <&gpi_dma1 0 2 QCOM_GPI_I2C>,
18bec7f725c518 Vinod Koul                       2022-04-21  1694  				       <&gpi_dma1 1 2 QCOM_GPI_I2C>;
18bec7f725c518 Vinod Koul                       2022-04-21  1695  				dma-names = "tx", "rx";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1696  				status = "disabled";
544cebe1895638 Sai Prakash Ranjan               2021-03-16  1697  			};
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1698  
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1699  			spi10: spi@a88000 {
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1700  				compatible = "qcom,geni-spi";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1701  				reg = <0 0x00a88000 0 0x4000>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1702  				clocks = <&gcc GCC_QUPV3_WRAP1_S2_CLK>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1703  				clock-names = "se";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1704  				pinctrl-names = "default";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1705  				pinctrl-0 = <&qup_spi10_data_clk>, <&qup_spi10_cs>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1706  				interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1707  				#address-cells = <1>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1708  				#size-cells = <0>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1709  				power-domains = <&rpmhpd SC7280_CX>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1710  				operating-points-v2 = <&qup_opp_table>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1711  				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1712  						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_1 0>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1713  				interconnect-names = "qup-core", "qup-config";
18bec7f725c518 Vinod Koul                       2022-04-21  1714  				dmas = <&gpi_dma1 0 2 QCOM_GPI_SPI>,
18bec7f725c518 Vinod Koul                       2022-04-21  1715  				       <&gpi_dma1 1 2 QCOM_GPI_SPI>;
18bec7f725c518 Vinod Koul                       2022-04-21  1716  				dma-names = "tx", "rx";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1717  				status = "disabled";
544cebe1895638 Sai Prakash Ranjan               2021-03-16  1718  			};
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1719  
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1720  			uart10: serial@a88000 {
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1721  				compatible = "qcom,geni-uart";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1722  				reg = <0 0x00a88000 0 0x4000>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1723  				clocks = <&gcc GCC_QUPV3_WRAP1_S2_CLK>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1724  				clock-names = "se";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1725  				pinctrl-names = "default";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1726  				pinctrl-0 = <&qup_uart10_cts>, <&qup_uart10_rts>, <&qup_uart10_tx>, <&qup_uart10_rx>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1727  				interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1728  				power-domains = <&rpmhpd SC7280_CX>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1729  				operating-points-v2 = <&qup_opp_table>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1730  				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1731  						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_1 0>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1732  				interconnect-names = "qup-core", "qup-config";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1733  				status = "disabled";
544cebe1895638 Sai Prakash Ranjan               2021-03-16  1734  			};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  1735  
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1736  			i2c11: i2c@a8c000 {
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1737  				compatible = "qcom,geni-i2c";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1738  				reg = <0 0x00a8c000 0 0x4000>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1739  				clocks = <&gcc GCC_QUPV3_WRAP1_S3_CLK>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1740  				clock-names = "se";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1741  				pinctrl-names = "default";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1742  				pinctrl-0 = <&qup_i2c11_data_clk>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1743  				interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  1744  				#address-cells = <1>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  1745  				#size-cells = <0>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1746  				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1747  						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_1 0>,
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1748  						<&aggre2_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1749  				interconnect-names = "qup-core", "qup-config",
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1750  							"qup-memory";
e3e9a580380730 Rajendra Nayak                   2022-09-27  1751  				power-domains = <&rpmhpd SC7280_CX>;
e3e9a580380730 Rajendra Nayak                   2022-09-27  1752  				required-opps = <&rpmhpd_opp_low_svs>;
18bec7f725c518 Vinod Koul                       2022-04-21  1753  				dmas = <&gpi_dma1 0 3 QCOM_GPI_I2C>,
18bec7f725c518 Vinod Koul                       2022-04-21  1754  				       <&gpi_dma1 1 3 QCOM_GPI_I2C>;
18bec7f725c518 Vinod Koul                       2022-04-21  1755  				dma-names = "tx", "rx";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1756  				status = "disabled";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1757  			};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  1758  
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1759  			spi11: spi@a8c000 {
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1760  				compatible = "qcom,geni-spi";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1761  				reg = <0 0x00a8c000 0 0x4000>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1762  				clocks = <&gcc GCC_QUPV3_WRAP1_S3_CLK>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1763  				clock-names = "se";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1764  				pinctrl-names = "default";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1765  				pinctrl-0 = <&qup_spi11_data_clk>, <&qup_spi11_cs>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1766  				interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1767  				#address-cells = <1>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1768  				#size-cells = <0>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1769  				power-domains = <&rpmhpd SC7280_CX>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1770  				operating-points-v2 = <&qup_opp_table>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1771  				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1772  						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_1 0>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1773  				interconnect-names = "qup-core", "qup-config";
18bec7f725c518 Vinod Koul                       2022-04-21  1774  				dmas = <&gpi_dma1 0 3 QCOM_GPI_SPI>,
18bec7f725c518 Vinod Koul                       2022-04-21  1775  				       <&gpi_dma1 1 3 QCOM_GPI_SPI>;
18bec7f725c518 Vinod Koul                       2022-04-21  1776  				dma-names = "tx", "rx";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1777  				status = "disabled";
544cebe1895638 Sai Prakash Ranjan               2021-03-16  1778  			};
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1779  
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1780  			uart11: serial@a8c000 {
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1781  				compatible = "qcom,geni-uart";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1782  				reg = <0 0x00a8c000 0 0x4000>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1783  				clocks = <&gcc GCC_QUPV3_WRAP1_S3_CLK>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1784  				clock-names = "se";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1785  				pinctrl-names = "default";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1786  				pinctrl-0 = <&qup_uart11_cts>, <&qup_uart11_rts>, <&qup_uart11_tx>, <&qup_uart11_rx>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1787  				interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1788  				power-domains = <&rpmhpd SC7280_CX>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1789  				operating-points-v2 = <&qup_opp_table>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1790  				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1791  						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_1 0>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1792  				interconnect-names = "qup-core", "qup-config";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1793  				status = "disabled";
544cebe1895638 Sai Prakash Ranjan               2021-03-16  1794  			};
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1795  
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1796  			i2c12: i2c@a90000 {
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1797  				compatible = "qcom,geni-i2c";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1798  				reg = <0 0x00a90000 0 0x4000>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1799  				clocks = <&gcc GCC_QUPV3_WRAP1_S4_CLK>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1800  				clock-names = "se";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1801  				pinctrl-names = "default";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1802  				pinctrl-0 = <&qup_i2c12_data_clk>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1803  				interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1804  				#address-cells = <1>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1805  				#size-cells = <0>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1806  				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1807  						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_1 0>,
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1808  						<&aggre2_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1809  				interconnect-names = "qup-core", "qup-config",
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1810  							"qup-memory";
e3e9a580380730 Rajendra Nayak                   2022-09-27  1811  				power-domains = <&rpmhpd SC7280_CX>;
e3e9a580380730 Rajendra Nayak                   2022-09-27  1812  				required-opps = <&rpmhpd_opp_low_svs>;
18bec7f725c518 Vinod Koul                       2022-04-21  1813  				dmas = <&gpi_dma1 0 4 QCOM_GPI_I2C>,
18bec7f725c518 Vinod Koul                       2022-04-21  1814  				       <&gpi_dma1 1 4 QCOM_GPI_I2C>;
18bec7f725c518 Vinod Koul                       2022-04-21  1815  				dma-names = "tx", "rx";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1816  				status = "disabled";
544cebe1895638 Sai Prakash Ranjan               2021-03-16  1817  			};
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1818  
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1819  			spi12: spi@a90000 {
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1820  				compatible = "qcom,geni-spi";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1821  				reg = <0 0x00a90000 0 0x4000>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1822  				clocks = <&gcc GCC_QUPV3_WRAP1_S4_CLK>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1823  				clock-names = "se";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1824  				pinctrl-names = "default";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1825  				pinctrl-0 = <&qup_spi12_data_clk>, <&qup_spi12_cs>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1826  				interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1827  				#address-cells = <1>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1828  				#size-cells = <0>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1829  				power-domains = <&rpmhpd SC7280_CX>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1830  				operating-points-v2 = <&qup_opp_table>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1831  				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1832  						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_1 0>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1833  				interconnect-names = "qup-core", "qup-config";
18bec7f725c518 Vinod Koul                       2022-04-21  1834  				dmas = <&gpi_dma1 0 4 QCOM_GPI_SPI>,
18bec7f725c518 Vinod Koul                       2022-04-21  1835  				       <&gpi_dma1 1 4 QCOM_GPI_SPI>;
18bec7f725c518 Vinod Koul                       2022-04-21  1836  				dma-names = "tx", "rx";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1837  				status = "disabled";
544cebe1895638 Sai Prakash Ranjan               2021-03-16  1838  			};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  1839  
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1840  			uart12: serial@a90000 {
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1841  				compatible = "qcom,geni-uart";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1842  				reg = <0 0x00a90000 0 0x4000>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1843  				clocks = <&gcc GCC_QUPV3_WRAP1_S4_CLK>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1844  				clock-names = "se";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1845  				pinctrl-names = "default";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1846  				pinctrl-0 = <&qup_uart12_cts>, <&qup_uart12_rts>, <&qup_uart12_tx>, <&qup_uart12_rx>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1847  				interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1848  				power-domains = <&rpmhpd SC7280_CX>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1849  				operating-points-v2 = <&qup_opp_table>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1850  				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1851  						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_1 0>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1852  				interconnect-names = "qup-core", "qup-config";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1853  				status = "disabled";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1854  			};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  1855  
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1856  			i2c13: i2c@a94000 {
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1857  				compatible = "qcom,geni-i2c";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1858  				reg = <0 0x00a94000 0 0x4000>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1859  				clocks = <&gcc GCC_QUPV3_WRAP1_S5_CLK>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1860  				clock-names = "se";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1861  				pinctrl-names = "default";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1862  				pinctrl-0 = <&qup_i2c13_data_clk>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1863  				interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1864  				#address-cells = <1>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1865  				#size-cells = <0>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1866  				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1867  						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_1 0>,
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1868  						<&aggre2_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1869  				interconnect-names = "qup-core", "qup-config",
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1870  							"qup-memory";
e3e9a580380730 Rajendra Nayak                   2022-09-27  1871  				power-domains = <&rpmhpd SC7280_CX>;
e3e9a580380730 Rajendra Nayak                   2022-09-27  1872  				required-opps = <&rpmhpd_opp_low_svs>;
18bec7f725c518 Vinod Koul                       2022-04-21  1873  				dmas = <&gpi_dma1 0 5 QCOM_GPI_I2C>,
18bec7f725c518 Vinod Koul                       2022-04-21  1874  				       <&gpi_dma1 1 5 QCOM_GPI_I2C>;
18bec7f725c518 Vinod Koul                       2022-04-21  1875  				dma-names = "tx", "rx";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1876  				status = "disabled";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1877  			};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  1878  
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1879  			spi13: spi@a94000 {
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1880  				compatible = "qcom,geni-spi";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1881  				reg = <0 0x00a94000 0 0x4000>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1882  				clocks = <&gcc GCC_QUPV3_WRAP1_S5_CLK>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1883  				clock-names = "se";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1884  				pinctrl-names = "default";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1885  				pinctrl-0 = <&qup_spi13_data_clk>, <&qup_spi13_cs>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1886  				interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1887  				#address-cells = <1>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1888  				#size-cells = <0>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1889  				power-domains = <&rpmhpd SC7280_CX>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1890  				operating-points-v2 = <&qup_opp_table>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1891  				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1892  						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_1 0>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1893  				interconnect-names = "qup-core", "qup-config";
18bec7f725c518 Vinod Koul                       2022-04-21  1894  				dmas = <&gpi_dma1 0 5 QCOM_GPI_SPI>,
18bec7f725c518 Vinod Koul                       2022-04-21  1895  				       <&gpi_dma1 1 5 QCOM_GPI_SPI>;
18bec7f725c518 Vinod Koul                       2022-04-21  1896  				dma-names = "tx", "rx";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1897  				status = "disabled";
544cebe1895638 Sai Prakash Ranjan               2021-03-16  1898  			};
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1899  
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1900  			uart13: serial@a94000 {
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1901  				compatible = "qcom,geni-uart";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1902  				reg = <0 0x00a94000 0 0x4000>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1903  				clocks = <&gcc GCC_QUPV3_WRAP1_S5_CLK>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1904  				clock-names = "se";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1905  				pinctrl-names = "default";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1906  				pinctrl-0 = <&qup_uart13_cts>, <&qup_uart13_rts>, <&qup_uart13_tx>, <&qup_uart13_rx>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1907  				interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1908  				power-domains = <&rpmhpd SC7280_CX>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1909  				operating-points-v2 = <&qup_opp_table>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1910  				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1911  						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_1 0>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1912  				interconnect-names = "qup-core", "qup-config";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1913  				status = "disabled";
544cebe1895638 Sai Prakash Ranjan               2021-03-16  1914  			};
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1915  
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1916  			i2c14: i2c@a98000 {
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1917  				compatible = "qcom,geni-i2c";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1918  				reg = <0 0x00a98000 0 0x4000>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1919  				clocks = <&gcc GCC_QUPV3_WRAP1_S6_CLK>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1920  				clock-names = "se";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1921  				pinctrl-names = "default";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1922  				pinctrl-0 = <&qup_i2c14_data_clk>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1923  				interrupts = <GIC_SPI 368 IRQ_TYPE_LEVEL_HIGH>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1924  				#address-cells = <1>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1925  				#size-cells = <0>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1926  				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1927  						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_1 0>,
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1928  						<&aggre2_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1929  				interconnect-names = "qup-core", "qup-config",
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1930  							"qup-memory";
e3e9a580380730 Rajendra Nayak                   2022-09-27  1931  				power-domains = <&rpmhpd SC7280_CX>;
e3e9a580380730 Rajendra Nayak                   2022-09-27  1932  				required-opps = <&rpmhpd_opp_low_svs>;
18bec7f725c518 Vinod Koul                       2022-04-21  1933  				dmas = <&gpi_dma1 0 6 QCOM_GPI_I2C>,
18bec7f725c518 Vinod Koul                       2022-04-21  1934  				       <&gpi_dma1 1 6 QCOM_GPI_I2C>;
18bec7f725c518 Vinod Koul                       2022-04-21  1935  				dma-names = "tx", "rx";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1936  				status = "disabled";
544cebe1895638 Sai Prakash Ranjan               2021-03-16  1937  			};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  1938  
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1939  			spi14: spi@a98000 {
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1940  				compatible = "qcom,geni-spi";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1941  				reg = <0 0x00a98000 0 0x4000>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1942  				clocks = <&gcc GCC_QUPV3_WRAP1_S6_CLK>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1943  				clock-names = "se";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1944  				pinctrl-names = "default";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1945  				pinctrl-0 = <&qup_spi14_data_clk>, <&qup_spi14_cs>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1946  				interrupts = <GIC_SPI 368 IRQ_TYPE_LEVEL_HIGH>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  1947  				#address-cells = <1>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  1948  				#size-cells = <0>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1949  				power-domains = <&rpmhpd SC7280_CX>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1950  				operating-points-v2 = <&qup_opp_table>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1951  				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1952  						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_1 0>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1953  				interconnect-names = "qup-core", "qup-config";
18bec7f725c518 Vinod Koul                       2022-04-21  1954  				dmas = <&gpi_dma1 0 6 QCOM_GPI_SPI>,
18bec7f725c518 Vinod Koul                       2022-04-21  1955  				       <&gpi_dma1 1 6 QCOM_GPI_SPI>;
18bec7f725c518 Vinod Koul                       2022-04-21  1956  				dma-names = "tx", "rx";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1957  				status = "disabled";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1958  			};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  1959  
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1960  			uart14: serial@a98000 {
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1961  				compatible = "qcom,geni-uart";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1962  				reg = <0 0x00a98000 0 0x4000>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1963  				clocks = <&gcc GCC_QUPV3_WRAP1_S6_CLK>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1964  				clock-names = "se";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1965  				pinctrl-names = "default";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1966  				pinctrl-0 = <&qup_uart14_cts>, <&qup_uart14_rts>, <&qup_uart14_tx>, <&qup_uart14_rx>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1967  				interrupts = <GIC_SPI 368 IRQ_TYPE_LEVEL_HIGH>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1968  				power-domains = <&rpmhpd SC7280_CX>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1969  				operating-points-v2 = <&qup_opp_table>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1970  				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1971  						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_1 0>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1972  				interconnect-names = "qup-core", "qup-config";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1973  				status = "disabled";
544cebe1895638 Sai Prakash Ranjan               2021-03-16  1974  			};
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1975  
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1976  			i2c15: i2c@a9c000 {
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1977  				compatible = "qcom,geni-i2c";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1978  				reg = <0 0x00a9c000 0 0x4000>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1979  				clocks = <&gcc GCC_QUPV3_WRAP1_S7_CLK>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1980  				clock-names = "se";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1981  				pinctrl-names = "default";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1982  				pinctrl-0 = <&qup_i2c15_data_clk>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1983  				interrupts = <GIC_SPI 369 IRQ_TYPE_LEVEL_HIGH>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1984  				#address-cells = <1>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1985  				#size-cells = <0>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1986  				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1987  						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_1 0>,
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1988  						<&aggre2_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1989  				interconnect-names = "qup-core", "qup-config",
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1990  							"qup-memory";
e3e9a580380730 Rajendra Nayak                   2022-09-27  1991  				power-domains = <&rpmhpd SC7280_CX>;
e3e9a580380730 Rajendra Nayak                   2022-09-27  1992  				required-opps = <&rpmhpd_opp_low_svs>;
18bec7f725c518 Vinod Koul                       2022-04-21  1993  				dmas = <&gpi_dma1 0 7 QCOM_GPI_I2C>,
18bec7f725c518 Vinod Koul                       2022-04-21  1994  				       <&gpi_dma1 1 7 QCOM_GPI_I2C>;
18bec7f725c518 Vinod Koul                       2022-04-21  1995  				dma-names = "tx", "rx";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1996  				status = "disabled";
544cebe1895638 Sai Prakash Ranjan               2021-03-16  1997  			};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  1998  
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  1999  			spi15: spi@a9c000 {
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  2000  				compatible = "qcom,geni-spi";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  2001  				reg = <0 0x00a9c000 0 0x4000>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  2002  				clocks = <&gcc GCC_QUPV3_WRAP1_S7_CLK>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  2003  				clock-names = "se";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  2004  				pinctrl-names = "default";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  2005  				pinctrl-0 = <&qup_spi15_data_clk>, <&qup_spi15_cs>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  2006  				interrupts = <GIC_SPI 369 IRQ_TYPE_LEVEL_HIGH>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  2007  				#address-cells = <1>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  2008  				#size-cells = <0>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  2009  				power-domains = <&rpmhpd SC7280_CX>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  2010  				operating-points-v2 = <&qup_opp_table>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  2011  				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  2012  						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_1 0>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  2013  				interconnect-names = "qup-core", "qup-config";
18bec7f725c518 Vinod Koul                       2022-04-21  2014  				dmas = <&gpi_dma1 0 7 QCOM_GPI_SPI>,
18bec7f725c518 Vinod Koul                       2022-04-21  2015  				       <&gpi_dma1 1 7 QCOM_GPI_SPI>;
18bec7f725c518 Vinod Koul                       2022-04-21  2016  				dma-names = "tx", "rx";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  2017  				status = "disabled";
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2018  			};
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  2019  
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  2020  			uart15: serial@a9c000 {
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  2021  				compatible = "qcom,geni-uart";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  2022  				reg = <0 0x00a9c000 0 0x4000>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  2023  				clocks = <&gcc GCC_QUPV3_WRAP1_S7_CLK>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  2024  				clock-names = "se";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  2025  				pinctrl-names = "default";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  2026  				pinctrl-0 = <&qup_uart15_cts>, <&qup_uart15_rts>, <&qup_uart15_tx>, <&qup_uart15_rx>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  2027  				interrupts = <GIC_SPI 369 IRQ_TYPE_LEVEL_HIGH>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  2028  				power-domains = <&rpmhpd SC7280_CX>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  2029  				operating-points-v2 = <&qup_opp_table>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  2030  				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  2031  						<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QUP_1 0>;
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  2032  				interconnect-names = "qup-core", "qup-config";
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  2033  				status = "disabled";
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2034  			};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2035  		};
4e8e7648ae645d Roja Rani Yarubandi              2021-09-23  2036  
297e6e38320f32 Odelu Kukatla                    2021-04-27  2037  		cnoc2: interconnect@1500000 {
297e6e38320f32 Odelu Kukatla                    2021-04-27  2038  			reg = <0 0x01500000 0 0x1000>;
297e6e38320f32 Odelu Kukatla                    2021-04-27  2039  			compatible = "qcom,sc7280-cnoc2";
297e6e38320f32 Odelu Kukatla                    2021-04-27  2040  			#interconnect-cells = <2>;
297e6e38320f32 Odelu Kukatla                    2021-04-27  2041  			qcom,bcm-voters = <&apps_bcm_voter>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2042  		};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2043  
297e6e38320f32 Odelu Kukatla                    2021-04-27  2044  		cnoc3: interconnect@1502000 {
297e6e38320f32 Odelu Kukatla                    2021-04-27  2045  			reg = <0 0x01502000 0 0x1000>;
297e6e38320f32 Odelu Kukatla                    2021-04-27  2046  			compatible = "qcom,sc7280-cnoc3";
297e6e38320f32 Odelu Kukatla                    2021-04-27  2047  			#interconnect-cells = <2>;
297e6e38320f32 Odelu Kukatla                    2021-04-27  2048  			qcom,bcm-voters = <&apps_bcm_voter>;
297e6e38320f32 Odelu Kukatla                    2021-04-27  2049  		};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2050  
297e6e38320f32 Odelu Kukatla                    2021-04-27  2051  		mc_virt: interconnect@1580000 {
297e6e38320f32 Odelu Kukatla                    2021-04-27  2052  			reg = <0 0x01580000 0 0x4>;
297e6e38320f32 Odelu Kukatla                    2021-04-27  2053  			compatible = "qcom,sc7280-mc-virt";
297e6e38320f32 Odelu Kukatla                    2021-04-27  2054  			#interconnect-cells = <2>;
297e6e38320f32 Odelu Kukatla                    2021-04-27  2055  			qcom,bcm-voters = <&apps_bcm_voter>;
297e6e38320f32 Odelu Kukatla                    2021-04-27  2056  		};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2057  
297e6e38320f32 Odelu Kukatla                    2021-04-27  2058  		system_noc: interconnect@1680000 {
297e6e38320f32 Odelu Kukatla                    2021-04-27  2059  			reg = <0 0x01680000 0 0x15480>;
297e6e38320f32 Odelu Kukatla                    2021-04-27  2060  			compatible = "qcom,sc7280-system-noc";
297e6e38320f32 Odelu Kukatla                    2021-04-27  2061  			#interconnect-cells = <2>;
297e6e38320f32 Odelu Kukatla                    2021-04-27  2062  			qcom,bcm-voters = <&apps_bcm_voter>;
297e6e38320f32 Odelu Kukatla                    2021-04-27  2063  		};
297e6e38320f32 Odelu Kukatla                    2021-04-27  2064  
297e6e38320f32 Odelu Kukatla                    2021-04-27  2065  		aggre1_noc: interconnect@16e0000 {
297e6e38320f32 Odelu Kukatla                    2021-04-27  2066  			compatible = "qcom,sc7280-aggre1-noc";
297e6e38320f32 Odelu Kukatla                    2021-04-27  2067  			reg = <0 0x016e0000 0 0x1c080>;
297e6e38320f32 Odelu Kukatla                    2021-04-27  2068  			#interconnect-cells = <2>;
297e6e38320f32 Odelu Kukatla                    2021-04-27  2069  			qcom,bcm-voters = <&apps_bcm_voter>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2070  		};
297e6e38320f32 Odelu Kukatla                    2021-04-27  2071  
297e6e38320f32 Odelu Kukatla                    2021-04-27  2072  		aggre2_noc: interconnect@1700000 {
297e6e38320f32 Odelu Kukatla                    2021-04-27  2073  			reg = <0 0x01700000 0 0x2b080>;
297e6e38320f32 Odelu Kukatla                    2021-04-27  2074  			compatible = "qcom,sc7280-aggre2-noc";
297e6e38320f32 Odelu Kukatla                    2021-04-27  2075  			#interconnect-cells = <2>;
297e6e38320f32 Odelu Kukatla                    2021-04-27  2076  			qcom,bcm-voters = <&apps_bcm_voter>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2077  		};
297e6e38320f32 Odelu Kukatla                    2021-04-27  2078  
297e6e38320f32 Odelu Kukatla                    2021-04-27  2079  		mmss_noc: interconnect@1740000 {
297e6e38320f32 Odelu Kukatla                    2021-04-27  2080  			reg = <0 0x01740000 0 0x1e080>;
297e6e38320f32 Odelu Kukatla                    2021-04-27  2081  			compatible = "qcom,sc7280-mmss-noc";
297e6e38320f32 Odelu Kukatla                    2021-04-27  2082  			#interconnect-cells = <2>;
297e6e38320f32 Odelu Kukatla                    2021-04-27  2083  			qcom,bcm-voters = <&apps_bcm_voter>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2084  		};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2085  
cdbfb815d63a79 Manikanta Pubbisetty             2022-04-06  2086  		wifi: wifi@17a10040 {
cdbfb815d63a79 Manikanta Pubbisetty             2022-04-06  2087  			compatible = "qcom,wcn6750-wifi";
cdbfb815d63a79 Manikanta Pubbisetty             2022-04-06  2088  			reg = <0 0x17a10040 0 0x0>;
cdbfb815d63a79 Manikanta Pubbisetty             2022-04-06  2089  			iommus = <&apps_smmu 0x1c00 0x1>;
cdbfb815d63a79 Manikanta Pubbisetty             2022-04-06  2090  			interrupts = <GIC_SPI 768 IRQ_TYPE_EDGE_RISING>,
cdbfb815d63a79 Manikanta Pubbisetty             2022-04-06  2091  				     <GIC_SPI 769 IRQ_TYPE_EDGE_RISING>,
cdbfb815d63a79 Manikanta Pubbisetty             2022-04-06  2092  				     <GIC_SPI 770 IRQ_TYPE_EDGE_RISING>,
cdbfb815d63a79 Manikanta Pubbisetty             2022-04-06  2093  				     <GIC_SPI 771 IRQ_TYPE_EDGE_RISING>,
cdbfb815d63a79 Manikanta Pubbisetty             2022-04-06  2094  				     <GIC_SPI 772 IRQ_TYPE_EDGE_RISING>,
cdbfb815d63a79 Manikanta Pubbisetty             2022-04-06  2095  				     <GIC_SPI 773 IRQ_TYPE_EDGE_RISING>,
cdbfb815d63a79 Manikanta Pubbisetty             2022-04-06  2096  				     <GIC_SPI 774 IRQ_TYPE_EDGE_RISING>,
cdbfb815d63a79 Manikanta Pubbisetty             2022-04-06  2097  				     <GIC_SPI 775 IRQ_TYPE_EDGE_RISING>,
cdbfb815d63a79 Manikanta Pubbisetty             2022-04-06  2098  				     <GIC_SPI 776 IRQ_TYPE_EDGE_RISING>,
cdbfb815d63a79 Manikanta Pubbisetty             2022-04-06  2099  				     <GIC_SPI 777 IRQ_TYPE_EDGE_RISING>,
cdbfb815d63a79 Manikanta Pubbisetty             2022-04-06  2100  				     <GIC_SPI 778 IRQ_TYPE_EDGE_RISING>,
cdbfb815d63a79 Manikanta Pubbisetty             2022-04-06  2101  				     <GIC_SPI 779 IRQ_TYPE_EDGE_RISING>,
cdbfb815d63a79 Manikanta Pubbisetty             2022-04-06  2102  				     <GIC_SPI 780 IRQ_TYPE_EDGE_RISING>,
cdbfb815d63a79 Manikanta Pubbisetty             2022-04-06  2103  				     <GIC_SPI 781 IRQ_TYPE_EDGE_RISING>,
cdbfb815d63a79 Manikanta Pubbisetty             2022-04-06  2104  				     <GIC_SPI 782 IRQ_TYPE_EDGE_RISING>,
cdbfb815d63a79 Manikanta Pubbisetty             2022-04-06  2105  				     <GIC_SPI 783 IRQ_TYPE_EDGE_RISING>,
cdbfb815d63a79 Manikanta Pubbisetty             2022-04-06  2106  				     <GIC_SPI 784 IRQ_TYPE_EDGE_RISING>,
cdbfb815d63a79 Manikanta Pubbisetty             2022-04-06  2107  				     <GIC_SPI 785 IRQ_TYPE_EDGE_RISING>,
cdbfb815d63a79 Manikanta Pubbisetty             2022-04-06  2108  				     <GIC_SPI 786 IRQ_TYPE_EDGE_RISING>,
cdbfb815d63a79 Manikanta Pubbisetty             2022-04-06  2109  				     <GIC_SPI 787 IRQ_TYPE_EDGE_RISING>,
cdbfb815d63a79 Manikanta Pubbisetty             2022-04-06  2110  				     <GIC_SPI 788 IRQ_TYPE_EDGE_RISING>,
cdbfb815d63a79 Manikanta Pubbisetty             2022-04-06  2111  				     <GIC_SPI 789 IRQ_TYPE_EDGE_RISING>,
cdbfb815d63a79 Manikanta Pubbisetty             2022-04-06  2112  				     <GIC_SPI 790 IRQ_TYPE_EDGE_RISING>,
cdbfb815d63a79 Manikanta Pubbisetty             2022-04-06  2113  				     <GIC_SPI 791 IRQ_TYPE_EDGE_RISING>,
cdbfb815d63a79 Manikanta Pubbisetty             2022-04-06  2114  				     <GIC_SPI 792 IRQ_TYPE_EDGE_RISING>,
cdbfb815d63a79 Manikanta Pubbisetty             2022-04-06  2115  				     <GIC_SPI 793 IRQ_TYPE_EDGE_RISING>,
cdbfb815d63a79 Manikanta Pubbisetty             2022-04-06  2116  				     <GIC_SPI 794 IRQ_TYPE_EDGE_RISING>,
cdbfb815d63a79 Manikanta Pubbisetty             2022-04-06  2117  				     <GIC_SPI 795 IRQ_TYPE_EDGE_RISING>,
cdbfb815d63a79 Manikanta Pubbisetty             2022-04-06  2118  				     <GIC_SPI 796 IRQ_TYPE_EDGE_RISING>,
cdbfb815d63a79 Manikanta Pubbisetty             2022-04-06  2119  				     <GIC_SPI 797 IRQ_TYPE_EDGE_RISING>,
cdbfb815d63a79 Manikanta Pubbisetty             2022-04-06  2120  				     <GIC_SPI 798 IRQ_TYPE_EDGE_RISING>,
cdbfb815d63a79 Manikanta Pubbisetty             2022-04-06  2121  				     <GIC_SPI 799 IRQ_TYPE_EDGE_RISING>;
cdbfb815d63a79 Manikanta Pubbisetty             2022-04-06  2122  			qcom,rproc = <&remoteproc_wpss>;
cdbfb815d63a79 Manikanta Pubbisetty             2022-04-06  2123  			memory-region = <&wlan_fw_mem>, <&wlan_ce_mem>;
cdbfb815d63a79 Manikanta Pubbisetty             2022-04-06  2124  			status = "disabled";
42582b27dcb1cb Manikanta Pubbisetty             2022-10-17  2125  			qcom,smem-states = <&wlan_smp2p_out 0>;
42582b27dcb1cb Manikanta Pubbisetty             2022-10-17  2126  			qcom,smem-state-names = "wlan-smp2p-out";
cdbfb815d63a79 Manikanta Pubbisetty             2022-04-06  2127  		};
cdbfb815d63a79 Manikanta Pubbisetty             2022-04-06  2128  
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2129  		pcie1: pci@1c08000 {
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2130  			compatible = "qcom,pcie-sc7280";
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2131  			reg = <0 0x01c08000 0 0x3000>,
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2132  			      <0 0x40000000 0 0xf1d>,
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2133  			      <0 0x40000f20 0 0xa8>,
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2134  			      <0 0x40001000 0 0x1000>,
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2135  			      <0 0x40100000 0 0x100000>;
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2136  
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2137  			reg-names = "parf", "dbi", "elbi", "atu", "config";
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2138  			device_type = "pci";
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2139  			linux,pci-domain = <1>;
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2140  			bus-range = <0x00 0xff>;
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2141  			num-lanes = <2>;
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2142  
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2143  			#address-cells = <3>;
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2144  			#size-cells = <2>;
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2145  
1d4743d6312582 Manivannan Sadhasivam            2023-02-28  2146  			ranges = <0x01000000 0x0 0x00000000 0x0 0x40200000 0x0 0x100000>,
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2147  				 <0x02000000 0x0 0x40300000 0x0 0x40300000 0x0 0x1fd00000>;
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2148  
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2149  			interrupts = <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>;
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2150  			interrupt-names = "msi";
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2151  			#interrupt-cells = <1>;
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2152  			interrupt-map-mask = <0 0 0 0x7>;
66b788133030f0 Prasad Malisetty                 2021-11-16  2153  			interrupt-map = <0 0 0 1 &intc 0 0 0 434 IRQ_TYPE_LEVEL_HIGH>,
66b788133030f0 Prasad Malisetty                 2021-11-16  2154  					<0 0 0 2 &intc 0 0 0 435 IRQ_TYPE_LEVEL_HIGH>,
66b788133030f0 Prasad Malisetty                 2021-11-16  2155  					<0 0 0 3 &intc 0 0 0 438 IRQ_TYPE_LEVEL_HIGH>,
66b788133030f0 Prasad Malisetty                 2021-11-16  2156  					<0 0 0 4 &intc 0 0 0 439 IRQ_TYPE_LEVEL_HIGH>;
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2157  
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2158  			clocks = <&gcc GCC_PCIE_1_PIPE_CLK>,
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2159  				 <&gcc GCC_PCIE_1_PIPE_CLK_SRC>,
330fc08dbdd913 Johan Hovold                     2022-07-07  2160  				 <&pcie1_lane>,
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2161  				 <&rpmhcc RPMH_CXO_CLK>,
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2162  				 <&gcc GCC_PCIE_1_AUX_CLK>,
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2163  				 <&gcc GCC_PCIE_1_CFG_AHB_CLK>,
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2164  				 <&gcc GCC_PCIE_1_MSTR_AXI_CLK>,
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2165  				 <&gcc GCC_PCIE_1_SLV_AXI_CLK>,
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2166  				 <&gcc GCC_PCIE_1_SLV_Q2A_AXI_CLK>,
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2167  				 <&gcc GCC_AGGRE_NOC_PCIE_TBU_CLK>,
aaf85b46aa4145 Krishna chaitanya chundru        2022-09-08  2168  				 <&gcc GCC_DDRSS_PCIE_SF_CLK>,
aaf85b46aa4145 Krishna chaitanya chundru        2022-09-08  2169  				 <&gcc GCC_AGGRE_NOC_PCIE_CENTER_SF_AXI_CLK>,
aaf85b46aa4145 Krishna chaitanya chundru        2022-09-08  2170  				 <&gcc GCC_AGGRE_NOC_PCIE_1_AXI_CLK>;
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2171  
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2172  			clock-names = "pipe",
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2173  				      "pipe_mux",
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2174  				      "phy_pipe",
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2175  				      "ref",
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2176  				      "aux",
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2177  				      "cfg",
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2178  				      "bus_master",
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2179  				      "bus_slave",
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2180  				      "slave_q2a",
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2181  				      "tbu",
aaf85b46aa4145 Krishna chaitanya chundru        2022-09-08  2182  				      "ddrss_sf_tbu",
aaf85b46aa4145 Krishna chaitanya chundru        2022-09-08  2183  				      "aggre0",
aaf85b46aa4145 Krishna chaitanya chundru        2022-09-08  2184  				      "aggre1";
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2185  
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2186  			assigned-clocks = <&gcc GCC_PCIE_1_AUX_CLK>;
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2187  			assigned-clock-rates = <19200000>;
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2188  
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2189  			resets = <&gcc GCC_PCIE_1_BCR>;
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2190  			reset-names = "pci";
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2191  
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2192  			power-domains = <&gcc GCC_PCIE_1_GDSC>;
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2193  
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2194  			phys = <&pcie1_lane>;
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2195  			phy-names = "pciephy";
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2196  
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2197  			pinctrl-names = "default";
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2198  			pinctrl-0 = <&pcie1_clkreq_n>;
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2199  
8a63441e83724f Krishna chaitanya chundru        2023-02-28  2200  			dma-coherent;
8a63441e83724f Krishna chaitanya chundru        2023-02-28  2201  
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2202  			iommu-map = <0x0 &apps_smmu 0x1c80 0x1>,
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2203  				    <0x100 &apps_smmu 0x1c81 0x1>;
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2204  
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2205  			status = "disabled";
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2206  		};
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2207  
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2208  		pcie1_phy: phy@1c0e000 {
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2209  			compatible = "qcom,sm8250-qmp-gen3x2-pcie-phy";
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2210  			reg = <0 0x01c0e000 0 0x1c0>;
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2211  			#address-cells = <2>;
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2212  			#size-cells = <2>;
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2213  			ranges;
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2214  			clocks = <&gcc GCC_PCIE_1_AUX_CLK>,
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2215  				 <&gcc GCC_PCIE_1_CFG_AHB_CLK>,
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2216  				 <&gcc GCC_PCIE_CLKREF_EN>,
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2217  				 <&gcc GCC_PCIE1_PHY_RCHNG_CLK>;
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2218  			clock-names = "aux", "cfg_ahb", "ref", "refgen";
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2219  
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2220  			resets = <&gcc GCC_PCIE_1_PHY_BCR>;
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2221  			reset-names = "phy";
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2222  
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2223  			assigned-clocks = <&gcc GCC_PCIE1_PHY_RCHNG_CLK>;
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2224  			assigned-clock-rates = <100000000>;
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2225  
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2226  			status = "disabled";
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2227  
56205c56ea2a05 Bhupesh Sharma                   2022-02-28  2228  			pcie1_lane: phy@1c0e200 {
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2229  				reg = <0 0x01c0e200 0 0x170>,
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2230  				      <0 0x01c0e400 0 0x200>,
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2231  				      <0 0x01c0ea00 0 0x1f0>,
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2232  				      <0 0x01c0e600 0 0x170>,
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2233  				      <0 0x01c0e800 0 0x200>,
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2234  				      <0 0x01c0ee00 0 0xf4>;
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2235  				clocks = <&gcc GCC_PCIE_1_PIPE_CLK>;
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2236  				clock-names = "pipe0";
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2237  
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2238  				#phy-cells = <0>;
531c738fb36069 Johan Hovold                     2022-07-05  2239  				#clock-cells = <0>;
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2240  				clock-output-names = "pcie_1_pipe_clk";
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2241  			};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2242  		};
92e0ee9f83b3bc Prasad Malisetty                 2021-10-07  2243  
fc4f0273d4fba2 Alex Elder                       2021-08-04  2244  		ipa: ipa@1e40000 {
fc4f0273d4fba2 Alex Elder                       2021-08-04  2245  			compatible = "qcom,sc7280-ipa";
fc4f0273d4fba2 Alex Elder                       2021-08-04  2246  
fc4f0273d4fba2 Alex Elder                       2021-08-04  2247  			iommus = <&apps_smmu 0x480 0x0>,
fc4f0273d4fba2 Alex Elder                       2021-08-04  2248  				 <&apps_smmu 0x482 0x0>;
94ca994d7e932c Konrad Dybcio                    2023-01-02  2249  			reg = <0 0x01e40000 0 0x8000>,
94ca994d7e932c Konrad Dybcio                    2023-01-02  2250  			      <0 0x01e50000 0 0x4ad0>,
94ca994d7e932c Konrad Dybcio                    2023-01-02  2251  			      <0 0x01e04000 0 0x23000>;
fc4f0273d4fba2 Alex Elder                       2021-08-04  2252  			reg-names = "ipa-reg",
fc4f0273d4fba2 Alex Elder                       2021-08-04  2253  				    "ipa-shared",
fc4f0273d4fba2 Alex Elder                       2021-08-04  2254  				    "gsi";
fc4f0273d4fba2 Alex Elder                       2021-08-04  2255  
33b89923d02153 Stephen Boyd                     2021-08-11  2256  			interrupts-extended = <&intc GIC_SPI 654 IRQ_TYPE_EDGE_RISING>,
33b89923d02153 Stephen Boyd                     2021-08-11  2257  					      <&intc GIC_SPI 432 IRQ_TYPE_LEVEL_HIGH>,
fc4f0273d4fba2 Alex Elder                       2021-08-04  2258  					      <&ipa_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
fc4f0273d4fba2 Alex Elder                       2021-08-04  2259  					      <&ipa_smp2p_in 1 IRQ_TYPE_EDGE_RISING>;
fc4f0273d4fba2 Alex Elder                       2021-08-04  2260  			interrupt-names = "ipa",
fc4f0273d4fba2 Alex Elder                       2021-08-04  2261  					  "gsi",
fc4f0273d4fba2 Alex Elder                       2021-08-04  2262  					  "ipa-clock-query",
fc4f0273d4fba2 Alex Elder                       2021-08-04  2263  					  "ipa-setup-ready";
fc4f0273d4fba2 Alex Elder                       2021-08-04  2264  
fc4f0273d4fba2 Alex Elder                       2021-08-04  2265  			clocks = <&rpmhcc RPMH_IPA_CLK>;
fc4f0273d4fba2 Alex Elder                       2021-08-04  2266  			clock-names = "core";
fc4f0273d4fba2 Alex Elder                       2021-08-04  2267  
fc4f0273d4fba2 Alex Elder                       2021-08-04  2268  			interconnects = <&aggre2_noc MASTER_IPA 0 &mc_virt SLAVE_EBI1 0>,
fc4f0273d4fba2 Alex Elder                       2021-08-04  2269  					<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_IPA_CFG 0>;
fc4f0273d4fba2 Alex Elder                       2021-08-04  2270  			interconnect-names = "memory",
fc4f0273d4fba2 Alex Elder                       2021-08-04  2271  					     "config";
fc4f0273d4fba2 Alex Elder                       2021-08-04  2272  
73419e4d2fd1b8 Alex Elder                       2022-02-01  2273  			qcom,qmp = <&aoss_qmp>;
73419e4d2fd1b8 Alex Elder                       2022-02-01  2274  
fc4f0273d4fba2 Alex Elder                       2021-08-04  2275  			qcom,smem-states = <&ipa_smp2p_out 0>,
fc4f0273d4fba2 Alex Elder                       2021-08-04  2276  					   <&ipa_smp2p_out 1>;
fc4f0273d4fba2 Alex Elder                       2021-08-04  2277  			qcom,smem-state-names = "ipa-clock-enabled-valid",
fc4f0273d4fba2 Alex Elder                       2021-08-04  2278  						"ipa-clock-enabled";
fc4f0273d4fba2 Alex Elder                       2021-08-04  2279  
fc4f0273d4fba2 Alex Elder                       2021-08-04  2280  			status = "disabled";
fc4f0273d4fba2 Alex Elder                       2021-08-04  2281  		};
fc4f0273d4fba2 Alex Elder                       2021-08-04  2282  
c3bbe55c942d2a Sibi Sankar                      2021-04-27  2283  		tcsr_mutex: hwlock@1f40000 {
d9a2214d6ba5b6 Krzysztof Kozlowski              2022-08-19  2284  			compatible = "qcom,tcsr-mutex";
d9a2214d6ba5b6 Krzysztof Kozlowski              2022-08-19  2285  			reg = <0 0x01f40000 0 0x20000>;
c3bbe55c942d2a Sibi Sankar                      2021-04-27  2286  			#hwlock-cells = <1>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2287  		};
c3bbe55c942d2a Sibi Sankar                      2021-04-27  2288  
d0909bf4fa0fd7 Johan Hovold                     2022-09-05  2289  		tcsr_1: syscon@1f60000 {
d9a2214d6ba5b6 Krzysztof Kozlowski              2022-08-19  2290  			compatible = "qcom,sc7280-tcsr", "syscon";
d9a2214d6ba5b6 Krzysztof Kozlowski              2022-08-19  2291  			reg = <0 0x01f60000 0 0x20000>;
d9a2214d6ba5b6 Krzysztof Kozlowski              2022-08-19  2292  		};
d9a2214d6ba5b6 Krzysztof Kozlowski              2022-08-19  2293  
d9a2214d6ba5b6 Krzysztof Kozlowski              2022-08-19  2294  		tcsr_2: syscon@1fc0000 {
dddf4b0621d61b Sibi Sankar                      2021-09-17  2295  			compatible = "qcom,sc7280-tcsr", "syscon";
dddf4b0621d61b Sibi Sankar                      2021-09-17  2296  			reg = <0 0x01fc0000 0 0x30000>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2297  		};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2298  
422a295221bba8 Taniya Das                       2021-04-10  2299  		lpasscc: lpasscc@3000000 {
422a295221bba8 Taniya Das                       2021-04-10  2300  			compatible = "qcom,sc7280-lpasscc";
422a295221bba8 Taniya Das                       2021-04-10  2301  			reg = <0 0x03000000 0 0x40>,
8c7ebabd2e3f33 Satya Priya                      2022-08-10  2302  			      <0 0x03c04000 0 0x4>;
8c7ebabd2e3f33 Satya Priya                      2022-08-10  2303  			reg-names = "qdsp6ss", "top_cc";
422a295221bba8 Taniya Das                       2021-04-10  2304  			clocks = <&gcc GCC_CFG_NOC_LPASS_CLK>;
422a295221bba8 Taniya Das                       2021-04-10  2305  			clock-names = "iface";
422a295221bba8 Taniya Das                       2021-04-10  2306  			#clock-cells = <1>;
422a295221bba8 Taniya Das                       2021-04-10  2307  		};
422a295221bba8 Taniya Das                       2021-04-10  2308  
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2309  		lpass_rx_macro: codec@3200000 {
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2310  			compatible = "qcom,sc7280-lpass-rx-macro";
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2311  			reg = <0 0x03200000 0 0x1000>;
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2312  
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2313  			pinctrl-names = "default";
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2314  			pinctrl-0 = <&lpass_rx_swr_clk>, <&lpass_rx_swr_data>;
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2315  
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2316  			clocks = <&lpass_aon LPASS_AON_CC_TX_MCLK_CLK>,
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2317  				 <&lpass_aon LPASS_AON_CC_TX_MCLK_2X_CLK>,
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2318  				 <&lpass_va_macro>;
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2319  			clock-names = "mclk", "npl", "fsgen";
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2320  
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2321  			power-domains = <&lpass_hm LPASS_CORE_CC_LPASS_CORE_HM_GDSC>,
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2322  					<&lpass_aon LPASS_AON_CC_LPASS_AUDIO_HM_GDSC>;
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2323  			power-domain-names = "macro", "dcodec";
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2324  
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2325  			#clock-cells = <0>;
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2326  			#sound-dai-cells = <1>;
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2327  
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2328  			status = "disabled";
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2329  		};
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2330  
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2331  		swr0: soundwire@3210000 {
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2332  			compatible = "qcom,soundwire-v1.6.0";
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2333  			reg = <0 0x03210000 0 0x2000>;
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2334  
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2335  			interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2336  			clocks = <&lpass_rx_macro>;
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2337  			clock-names = "iface";
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2338  
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2339  			qcom,din-ports = <0>;
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2340  			qcom,dout-ports = <5>;
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2341  
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2342  			resets = <&lpass_audiocc LPASS_AUDIO_SWR_RX_CGCR>;
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2343  			reset-names = "swr_audio_cgcr";
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2344  
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2345  			qcom,ports-word-length =	/bits/ 8 <0x01 0x07 0x04 0xff 0xff>;
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2346  			qcom,ports-sinterval-low =	/bits/ 8 <0x03 0x3f 0x1f 0x03 0x03>;
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2347  			qcom,ports-offset1 =		/bits/ 8 <0x00 0x00 0x0b 0x01 0x01>;
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2348  			qcom,ports-offset2 =		/bits/ 8 <0x00 0x00 0x0b 0x00 0x00>;
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2349  			qcom,ports-lane-control =	/bits/ 8 <0x01 0x00 0x00 0x00 0x00>;
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2350  			qcom,ports-block-pack-mode =	/bits/ 8 <0xff 0x00 0x01 0xff 0xff>;
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2351  			qcom,ports-hstart =		/bits/ 8 <0xff 0x03 0xff 0xff 0xff>;
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2352  			qcom,ports-hstop =		/bits/ 8 <0xff 0x06 0xff 0xff 0xff>;
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2353  			qcom,ports-block-group-count =	/bits/ 8 <0xff 0xff 0xff 0xff 0x00>;
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2354  
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2355  			#sound-dai-cells = <1>;
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2356  			#address-cells = <2>;
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2357  			#size-cells = <0>;
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2358  
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2359  			status = "disabled";
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2360  		};
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2361  
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2362  		lpass_tx_macro: codec@3220000 {
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2363  			compatible = "qcom,sc7280-lpass-tx-macro";
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2364  			reg = <0 0x03220000 0 0x1000>;
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2365  
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2366  			pinctrl-names = "default";
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2367  			pinctrl-0 = <&lpass_tx_swr_clk>, <&lpass_tx_swr_data>;
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2368  
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2369  			clocks = <&lpass_aon LPASS_AON_CC_TX_MCLK_CLK>,
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2370  				 <&lpass_aon LPASS_AON_CC_TX_MCLK_2X_CLK>,
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2371  				 <&lpass_va_macro>;
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2372  			clock-names = "mclk", "npl", "fsgen";
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2373  
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2374  			power-domains = <&lpass_hm LPASS_CORE_CC_LPASS_CORE_HM_GDSC>,
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2375  					<&lpass_aon LPASS_AON_CC_LPASS_AUDIO_HM_GDSC>;
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2376  			power-domain-names = "macro", "dcodec";
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2377  
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2378  			#clock-cells = <0>;
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2379  			#sound-dai-cells = <1>;
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2380  
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2381  			status = "disabled";
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2382  		};
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2383  
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2384  		swr1: soundwire@3230000 {
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2385  			compatible = "qcom,soundwire-v1.6.0";
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2386  			reg = <0 0x03230000 0 0x2000>;
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2387  
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2388  			interrupts-extended = <&intc GIC_SPI 496 IRQ_TYPE_LEVEL_HIGH>,
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2389  					      <&pdc 130 IRQ_TYPE_LEVEL_HIGH>;
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2390  			clocks = <&lpass_tx_macro>;
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2391  			clock-names = "iface";
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2392  
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2393  			qcom,din-ports = <3>;
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2394  			qcom,dout-ports = <0>;
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2395  
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2396  			resets = <&lpass_audiocc LPASS_AUDIO_SWR_TX_CGCR>;
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2397  			reset-names = "swr_audio_cgcr";
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2398  
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2399  			qcom,ports-sinterval-low =	/bits/ 8 <0x01 0x03 0x03>;
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2400  			qcom,ports-offset1 =		/bits/ 8 <0x01 0x00 0x02>;
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2401  			qcom,ports-offset2 =		/bits/ 8 <0x00 0x00 0x00>;
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2402  			qcom,ports-hstart =		/bits/ 8 <0xff 0xff 0xff>;
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2403  			qcom,ports-hstop =		/bits/ 8 <0xff 0xff 0xff>;
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2404  			qcom,ports-word-length =	/bits/ 8 <0xff 0x00 0xff>;
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2405  			qcom,ports-block-pack-mode =	/bits/ 8 <0xff 0xff 0xff>;
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2406  			qcom,ports-block-group-count =	/bits/ 8 <0xff 0xff 0xff>;
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2407  			qcom,ports-lane-control =	/bits/ 8 <0x00 0x01 0x00>;
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2408  
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2409  			#sound-dai-cells = <1>;
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2410  			#address-cells = <2>;
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2411  			#size-cells = <0>;
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2412  
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2413  			status = "disabled";
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2414  		};
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2415  
9499240d15f297 Taniya Das                       2022-02-02  2416  		lpass_audiocc: clock-controller@3300000 {
9499240d15f297 Taniya Das                       2022-02-02  2417  			compatible = "qcom,sc7280-lpassaudiocc";
cb1d0aaa674e99 Satya Priya                      2022-09-20  2418  			reg = <0 0x03300000 0 0x30000>,
cb1d0aaa674e99 Satya Priya                      2022-09-20  2419  			      <0 0x032a9000 0 0x1000>;
9499240d15f297 Taniya Das                       2022-02-02  2420  			clocks = <&rpmhcc RPMH_CXO_CLK>,
9499240d15f297 Taniya Das                       2022-02-02  2421  			       <&lpass_aon LPASS_AON_CC_MAIN_RCG_CLK_SRC>;
9499240d15f297 Taniya Das                       2022-02-02  2422  			clock-names = "bi_tcxo", "lpass_aon_cc_main_rcg_clk_src";
9499240d15f297 Taniya Das                       2022-02-02  2423  			power-domains = <&lpass_aon LPASS_AON_CC_LPASS_AUDIO_HM_GDSC>;
9499240d15f297 Taniya Das                       2022-02-02  2424  			#clock-cells = <1>;
9499240d15f297 Taniya Das                       2022-02-02  2425  			#power-domain-cells = <1>;
e02a16c23410a1 Taniya Das                       2022-08-10  2426  			#reset-cells = <1>;
9499240d15f297 Taniya Das                       2022-02-02  2427  		};
9499240d15f297 Taniya Das                       2022-02-02  2428  
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2429  		lpass_va_macro: codec@3370000 {
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2430  			compatible = "qcom,sc7280-lpass-va-macro";
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2431  			reg = <0 0x03370000 0 0x1000>;
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2432  
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2433  			pinctrl-names = "default";
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2434  			pinctrl-0 = <&lpass_dmic01_clk>, <&lpass_dmic01_data>;
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2435  
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2436  			clocks = <&lpass_aon LPASS_AON_CC_TX_MCLK_CLK>;
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2437  			clock-names = "mclk";
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2438  
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2439  			power-domains = <&lpass_hm LPASS_CORE_CC_LPASS_CORE_HM_GDSC>,
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2440  					<&lpass_aon LPASS_AON_CC_LPASS_AUDIO_HM_GDSC>;
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2441  			power-domain-names = "macro", "dcodec";
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2442  
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2443  			#clock-cells = <0>;
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2444  			#sound-dai-cells = <1>;
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2445  
12ef689f09abb5 Srinivasa Rao Mandadapu          2022-07-07  2446  			status = "disabled";
9499240d15f297 Taniya Das                       2022-02-02  2447  		};
9499240d15f297 Taniya Das                       2022-02-02  2448  
9499240d15f297 Taniya Das                       2022-02-02  2449  		lpass_aon: clock-controller@3380000 {
9499240d15f297 Taniya Das                       2022-02-02  2450  			compatible = "qcom,sc7280-lpassaoncc";
9499240d15f297 Taniya Das                       2022-02-02  2451  			reg = <0 0x03380000 0 0x30000>;
9499240d15f297 Taniya Das                       2022-02-02  2452  			clocks = <&rpmhcc RPMH_CXO_CLK>,
9499240d15f297 Taniya Das                       2022-02-02  2453  			       <&rpmhcc RPMH_CXO_CLK_A>,
d9a1e922730389 Satya Priya                      2022-08-10  2454  			       <&lpass_core LPASS_CORE_CC_CORE_CLK>;
9499240d15f297 Taniya Das                       2022-02-02  2455  			clock-names = "bi_tcxo", "bi_tcxo_ao", "iface";
9499240d15f297 Taniya Das                       2022-02-02  2456  			#clock-cells = <1>;
9499240d15f297 Taniya Das                       2022-02-02  2457  			#power-domain-cells = <1>;
9499240d15f297 Taniya Das                       2022-02-02  2458  		};
9499240d15f297 Taniya Das                       2022-02-02  2459  
d9a1e922730389 Satya Priya                      2022-08-10  2460  		lpass_core: clock-controller@3900000 {
9499240d15f297 Taniya Das                       2022-02-02  2461  			compatible = "qcom,sc7280-lpasscorecc";
9499240d15f297 Taniya Das                       2022-02-02  2462  			reg = <0 0x03900000 0 0x50000>;
9499240d15f297 Taniya Das                       2022-02-02  2463  			clocks = <&rpmhcc RPMH_CXO_CLK>;
9499240d15f297 Taniya Das                       2022-02-02  2464  			clock-names = "bi_tcxo";
9499240d15f297 Taniya Das                       2022-02-02  2465  			power-domains = <&lpass_hm LPASS_CORE_CC_LPASS_CORE_HM_GDSC>;
9499240d15f297 Taniya Das                       2022-02-02  2466  			#clock-cells = <1>;
9499240d15f297 Taniya Das                       2022-02-02  2467  			#power-domain-cells = <1>;
9499240d15f297 Taniya Das                       2022-02-02  2468  		};
9499240d15f297 Taniya Das                       2022-02-02  2469  
aee6873edb93a3 Srinivasa Rao Mandadapu          2022-07-07  2470  		lpass_cpu: audio@3987000 {
aee6873edb93a3 Srinivasa Rao Mandadapu          2022-07-07  2471  			compatible = "qcom,sc7280-lpass-cpu";
aee6873edb93a3 Srinivasa Rao Mandadapu          2022-07-07  2472  
aee6873edb93a3 Srinivasa Rao Mandadapu          2022-07-07  2473  			reg = <0 0x03987000 0 0x68000>,
aee6873edb93a3 Srinivasa Rao Mandadapu          2022-07-07  2474  			      <0 0x03b00000 0 0x29000>,
aee6873edb93a3 Srinivasa Rao Mandadapu          2022-07-07  2475  			      <0 0x03260000 0 0xc000>,
aee6873edb93a3 Srinivasa Rao Mandadapu          2022-07-07  2476  			      <0 0x03280000 0 0x29000>,
aee6873edb93a3 Srinivasa Rao Mandadapu          2022-07-07  2477  			      <0 0x03340000 0 0x29000>,
aee6873edb93a3 Srinivasa Rao Mandadapu          2022-07-07  2478  			      <0 0x0336c000 0 0x3000>;
aee6873edb93a3 Srinivasa Rao Mandadapu          2022-07-07  2479  			reg-names = "lpass-hdmiif",
aee6873edb93a3 Srinivasa Rao Mandadapu          2022-07-07  2480  				    "lpass-lpaif",
aee6873edb93a3 Srinivasa Rao Mandadapu          2022-07-07  2481  				    "lpass-rxtx-cdc-dma-lpm",
aee6873edb93a3 Srinivasa Rao Mandadapu          2022-07-07  2482  				    "lpass-rxtx-lpaif",
aee6873edb93a3 Srinivasa Rao Mandadapu          2022-07-07  2483  				    "lpass-va-lpaif",
aee6873edb93a3 Srinivasa Rao Mandadapu          2022-07-07  2484  				    "lpass-va-cdc-dma-lpm";
aee6873edb93a3 Srinivasa Rao Mandadapu          2022-07-07  2485  
aee6873edb93a3 Srinivasa Rao Mandadapu          2022-07-07  2486  			iommus = <&apps_smmu 0x1820 0>,
aee6873edb93a3 Srinivasa Rao Mandadapu          2022-07-07  2487  				 <&apps_smmu 0x1821 0>,
aee6873edb93a3 Srinivasa Rao Mandadapu          2022-07-07  2488  				 <&apps_smmu 0x1832 0>;
aee6873edb93a3 Srinivasa Rao Mandadapu          2022-07-07  2489  
aee6873edb93a3 Srinivasa Rao Mandadapu          2022-07-07  2490  			power-domains = <&rpmhpd SC7280_LCX>;
aee6873edb93a3 Srinivasa Rao Mandadapu          2022-07-07  2491  			power-domain-names = "lcx";
aee6873edb93a3 Srinivasa Rao Mandadapu          2022-07-07  2492  			required-opps = <&rpmhpd_opp_nom>;
aee6873edb93a3 Srinivasa Rao Mandadapu          2022-07-07  2493  
aee6873edb93a3 Srinivasa Rao Mandadapu          2022-07-07  2494  			clocks = <&lpass_aon LPASS_AON_CC_AUDIO_HM_H_CLK>,
aee6873edb93a3 Srinivasa Rao Mandadapu          2022-07-07  2495  				 <&lpass_core LPASS_CORE_CC_EXT_MCLK0_CLK>,
aee6873edb93a3 Srinivasa Rao Mandadapu          2022-07-07  2496  				 <&lpass_core LPASS_CORE_CC_SYSNOC_MPORT_CORE_CLK>,
aee6873edb93a3 Srinivasa Rao Mandadapu          2022-07-07  2497  				 <&lpass_core LPASS_CORE_CC_EXT_IF0_IBIT_CLK>,
aee6873edb93a3 Srinivasa Rao Mandadapu          2022-07-07  2498  				 <&lpass_core LPASS_CORE_CC_EXT_IF1_IBIT_CLK>,
aee6873edb93a3 Srinivasa Rao Mandadapu          2022-07-07  2499  				 <&lpass_audiocc LPASS_AUDIO_CC_CODEC_MEM_CLK>,
aee6873edb93a3 Srinivasa Rao Mandadapu          2022-07-07  2500  				 <&lpass_audiocc LPASS_AUDIO_CC_CODEC_MEM0_CLK>,
aee6873edb93a3 Srinivasa Rao Mandadapu          2022-07-07  2501  				 <&lpass_audiocc LPASS_AUDIO_CC_CODEC_MEM1_CLK>,
aee6873edb93a3 Srinivasa Rao Mandadapu          2022-07-07  2502  				 <&lpass_audiocc LPASS_AUDIO_CC_CODEC_MEM2_CLK>,
aee6873edb93a3 Srinivasa Rao Mandadapu          2022-07-07  2503  				 <&lpass_aon LPASS_AON_CC_VA_MEM0_CLK>;
aee6873edb93a3 Srinivasa Rao Mandadapu          2022-07-07  2504  			clock-names = "aon_cc_audio_hm_h",
aee6873edb93a3 Srinivasa Rao Mandadapu          2022-07-07  2505  				      "audio_cc_ext_mclk0",
aee6873edb93a3 Srinivasa Rao Mandadapu          2022-07-07  2506  				      "core_cc_sysnoc_mport_core",
aee6873edb93a3 Srinivasa Rao Mandadapu          2022-07-07  2507  				      "core_cc_ext_if0_ibit",
aee6873edb93a3 Srinivasa Rao Mandadapu          2022-07-07  2508  				      "core_cc_ext_if1_ibit",
aee6873edb93a3 Srinivasa Rao Mandadapu          2022-07-07  2509  				      "audio_cc_codec_mem",
aee6873edb93a3 Srinivasa Rao Mandadapu          2022-07-07  2510  				      "audio_cc_codec_mem0",
aee6873edb93a3 Srinivasa Rao Mandadapu          2022-07-07  2511  				      "audio_cc_codec_mem1",
aee6873edb93a3 Srinivasa Rao Mandadapu          2022-07-07  2512  				      "audio_cc_codec_mem2",
aee6873edb93a3 Srinivasa Rao Mandadapu          2022-07-07  2513  				      "aon_cc_va_mem0";
aee6873edb93a3 Srinivasa Rao Mandadapu          2022-07-07  2514  
aee6873edb93a3 Srinivasa Rao Mandadapu          2022-07-07  2515  			#sound-dai-cells = <1>;
aee6873edb93a3 Srinivasa Rao Mandadapu          2022-07-07  2516  			#address-cells = <1>;
aee6873edb93a3 Srinivasa Rao Mandadapu          2022-07-07  2517  			#size-cells = <0>;
aee6873edb93a3 Srinivasa Rao Mandadapu          2022-07-07  2518  
aee6873edb93a3 Srinivasa Rao Mandadapu          2022-07-07  2519  			interrupts = <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>,
aee6873edb93a3 Srinivasa Rao Mandadapu          2022-07-07  2520  				     <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>,
aee6873edb93a3 Srinivasa Rao Mandadapu          2022-07-07  2521  				     <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>,
aee6873edb93a3 Srinivasa Rao Mandadapu          2022-07-07  2522  				     <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>;
aee6873edb93a3 Srinivasa Rao Mandadapu          2022-07-07  2523  			interrupt-names = "lpass-irq-lpaif",
aee6873edb93a3 Srinivasa Rao Mandadapu          2022-07-07  2524  					  "lpass-irq-hdmi",
aee6873edb93a3 Srinivasa Rao Mandadapu          2022-07-07  2525  					  "lpass-irq-vaif",
aee6873edb93a3 Srinivasa Rao Mandadapu          2022-07-07  2526  					  "lpass-irq-rxtxif";
aee6873edb93a3 Srinivasa Rao Mandadapu          2022-07-07  2527  
aee6873edb93a3 Srinivasa Rao Mandadapu          2022-07-07  2528  			status = "disabled";
aee6873edb93a3 Srinivasa Rao Mandadapu          2022-07-07  2529  		};
aee6873edb93a3 Srinivasa Rao Mandadapu          2022-07-07  2530  
9499240d15f297 Taniya Das                       2022-02-02  2531  		lpass_hm: clock-controller@3c00000 {
9499240d15f297 Taniya Das                       2022-02-02  2532  			compatible = "qcom,sc7280-lpasshm";
94ca994d7e932c Konrad Dybcio                    2023-01-02  2533  			reg = <0 0x03c00000 0 0x28>;
9499240d15f297 Taniya Das                       2022-02-02  2534  			clocks = <&rpmhcc RPMH_CXO_CLK>;
9499240d15f297 Taniya Das                       2022-02-02  2535  			clock-names = "bi_tcxo";
9499240d15f297 Taniya Das                       2022-02-02  2536  			#clock-cells = <1>;
9499240d15f297 Taniya Das                       2022-02-02  2537  			#power-domain-cells = <1>;
9499240d15f297 Taniya Das                       2022-02-02  2538  		};
9499240d15f297 Taniya Das                       2022-02-02  2539  
297e6e38320f32 Odelu Kukatla                    2021-04-27  2540  		lpass_ag_noc: interconnect@3c40000 {
297e6e38320f32 Odelu Kukatla                    2021-04-27  2541  			reg = <0 0x03c40000 0 0xf080>;
297e6e38320f32 Odelu Kukatla                    2021-04-27  2542  			compatible = "qcom,sc7280-lpass-ag-noc";
297e6e38320f32 Odelu Kukatla                    2021-04-27  2543  			#interconnect-cells = <2>;
297e6e38320f32 Odelu Kukatla                    2021-04-27  2544  			qcom,bcm-voters = <&apps_bcm_voter>;
297e6e38320f32 Odelu Kukatla                    2021-04-27  2545  		};
297e6e38320f32 Odelu Kukatla                    2021-04-27  2546  
32d4541abe0f98 Srinivasa Rao Mandadapu          2022-06-13  2547  		lpass_tlmm: pinctrl@33c0000 {
32d4541abe0f98 Srinivasa Rao Mandadapu          2022-06-13  2548  			compatible = "qcom,sc7280-lpass-lpi-pinctrl";
32d4541abe0f98 Srinivasa Rao Mandadapu          2022-06-13  2549  			reg = <0 0x033c0000 0x0 0x20000>,
32d4541abe0f98 Srinivasa Rao Mandadapu          2022-06-13  2550  				<0 0x03550000 0x0 0x10000>;
32d4541abe0f98 Srinivasa Rao Mandadapu          2022-06-13  2551  			gpio-controller;
32d4541abe0f98 Srinivasa Rao Mandadapu          2022-06-13  2552  			#gpio-cells = <2>;
32d4541abe0f98 Srinivasa Rao Mandadapu          2022-06-13  2553  			gpio-ranges = <&lpass_tlmm 0 0 15>;
32d4541abe0f98 Srinivasa Rao Mandadapu          2022-06-13  2554  
886a50bd031aae Krzysztof Kozlowski              2022-09-27  2555  			lpass_dmic01_clk: dmic01-clk-state {
32d4541abe0f98 Srinivasa Rao Mandadapu          2022-06-13  2556  				pins = "gpio6";
32d4541abe0f98 Srinivasa Rao Mandadapu          2022-06-13  2557  				function = "dmic1_clk";
32d4541abe0f98 Srinivasa Rao Mandadapu          2022-06-13  2558  			};
32d4541abe0f98 Srinivasa Rao Mandadapu          2022-06-13  2559  
886a50bd031aae Krzysztof Kozlowski              2022-09-27  2560  			lpass_dmic01_data: dmic01-data-state {
32d4541abe0f98 Srinivasa Rao Mandadapu          2022-06-13  2561  				pins = "gpio7";
32d4541abe0f98 Srinivasa Rao Mandadapu          2022-06-13  2562  				function = "dmic1_data";
32d4541abe0f98 Srinivasa Rao Mandadapu          2022-06-13  2563  			};
32d4541abe0f98 Srinivasa Rao Mandadapu          2022-06-13  2564  
886a50bd031aae Krzysztof Kozlowski              2022-09-27  2565  			lpass_dmic23_clk: dmic23-clk-state {
32d4541abe0f98 Srinivasa Rao Mandadapu          2022-06-13  2566  				pins = "gpio8";
32d4541abe0f98 Srinivasa Rao Mandadapu          2022-06-13  2567  				function = "dmic2_clk";
32d4541abe0f98 Srinivasa Rao Mandadapu          2022-06-13  2568  			};
32d4541abe0f98 Srinivasa Rao Mandadapu          2022-06-13  2569  
886a50bd031aae Krzysztof Kozlowski              2022-09-27  2570  			lpass_dmic23_data: dmic23-data-state {
32d4541abe0f98 Srinivasa Rao Mandadapu          2022-06-13  2571  				pins = "gpio9";
32d4541abe0f98 Srinivasa Rao Mandadapu          2022-06-13  2572  				function = "dmic2_data";
32d4541abe0f98 Srinivasa Rao Mandadapu          2022-06-13  2573  			};
32d4541abe0f98 Srinivasa Rao Mandadapu          2022-06-13  2574  
886a50bd031aae Krzysztof Kozlowski              2022-09-27  2575  			lpass_rx_swr_clk: rx-swr-clk-state {
32d4541abe0f98 Srinivasa Rao Mandadapu          2022-06-13  2576  				pins = "gpio3";
32d4541abe0f98 Srinivasa Rao Mandadapu          2022-06-13  2577  				function = "swr_rx_clk";
32d4541abe0f98 Srinivasa Rao Mandadapu          2022-06-13  2578  			};
32d4541abe0f98 Srinivasa Rao Mandadapu          2022-06-13  2579  
886a50bd031aae Krzysztof Kozlowski              2022-09-27  2580  			lpass_rx_swr_data: rx-swr-data-state {
32d4541abe0f98 Srinivasa Rao Mandadapu          2022-06-13  2581  				pins = "gpio4", "gpio5";
32d4541abe0f98 Srinivasa Rao Mandadapu          2022-06-13  2582  				function = "swr_rx_data";
32d4541abe0f98 Srinivasa Rao Mandadapu          2022-06-13  2583  			};
32d4541abe0f98 Srinivasa Rao Mandadapu          2022-06-13  2584  
886a50bd031aae Krzysztof Kozlowski              2022-09-27  2585  			lpass_tx_swr_clk: tx-swr-clk-state {
32d4541abe0f98 Srinivasa Rao Mandadapu          2022-06-13  2586  				pins = "gpio0";
32d4541abe0f98 Srinivasa Rao Mandadapu          2022-06-13  2587  				function = "swr_tx_clk";
32d4541abe0f98 Srinivasa Rao Mandadapu          2022-06-13  2588  			};
32d4541abe0f98 Srinivasa Rao Mandadapu          2022-06-13  2589  
886a50bd031aae Krzysztof Kozlowski              2022-09-27  2590  			lpass_tx_swr_data: tx-swr-data-state {
32d4541abe0f98 Srinivasa Rao Mandadapu          2022-06-13  2591  				pins = "gpio1", "gpio2", "gpio14";
32d4541abe0f98 Srinivasa Rao Mandadapu          2022-06-13  2592  				function = "swr_tx_data";
32d4541abe0f98 Srinivasa Rao Mandadapu          2022-06-13  2593  			};
32d4541abe0f98 Srinivasa Rao Mandadapu          2022-06-13  2594  		};
32d4541abe0f98 Srinivasa Rao Mandadapu          2022-06-13  2595  
b39f266c19f02c Manaf Meethalavalappu Pallikunhi 2021-08-11  2596  		gpu: gpu@3d00000 {
96c471970b7bcb Akhil P Oommen                   2021-08-11  2597  			compatible = "qcom,adreno-635.0", "qcom,adreno";
96c471970b7bcb Akhil P Oommen                   2021-08-11  2598  			reg = <0 0x03d00000 0 0x40000>,
96c471970b7bcb Akhil P Oommen                   2021-08-11  2599  			      <0 0x03d9e000 0 0x1000>,
96c471970b7bcb Akhil P Oommen                   2021-08-11  2600  			      <0 0x03d61000 0 0x800>;
96c471970b7bcb Akhil P Oommen                   2021-08-11  2601  			reg-names = "kgsl_3d0_reg_memory",
96c471970b7bcb Akhil P Oommen                   2021-08-11  2602  				    "cx_mem",
96c471970b7bcb Akhil P Oommen                   2021-08-11  2603  				    "cx_dbgc";
96c471970b7bcb Akhil P Oommen                   2021-08-11  2604  			interrupts = <GIC_SPI 300 IRQ_TYPE_LEVEL_HIGH>;
96c471970b7bcb Akhil P Oommen                   2021-08-11  2605  			iommus = <&adreno_smmu 0 0x401>;
96c471970b7bcb Akhil P Oommen                   2021-08-11  2606  			operating-points-v2 = <&gpu_opp_table>;
96c471970b7bcb Akhil P Oommen                   2021-08-11  2607  			qcom,gmu = <&gmu>;
96c471970b7bcb Akhil P Oommen                   2021-08-11  2608  			interconnects = <&gem_noc MASTER_GFX3D 0 &mc_virt SLAVE_EBI1 0>;
96c471970b7bcb Akhil P Oommen                   2021-08-11  2609  			interconnect-names = "gfx-mem";
b39f266c19f02c Manaf Meethalavalappu Pallikunhi 2021-08-11  2610  			#cooling-cells = <2>;
96c471970b7bcb Akhil P Oommen                   2021-08-11  2611  
3bfef00d767124 Akhil P Oommen                   2022-02-26  2612  			nvmem-cells = <&gpu_speed_bin>;
3bfef00d767124 Akhil P Oommen                   2022-02-26  2613  			nvmem-cell-names = "speed_bin";
3bfef00d767124 Akhil P Oommen                   2022-02-26  2614  
96c471970b7bcb Akhil P Oommen                   2021-08-11  2615  			gpu_opp_table: opp-table {
96c471970b7bcb Akhil P Oommen                   2021-08-11  2616  				compatible = "operating-points-v2";
96c471970b7bcb Akhil P Oommen                   2021-08-11  2617  
96c471970b7bcb Akhil P Oommen                   2021-08-11  2618  				opp-315000000 {
96c471970b7bcb Akhil P Oommen                   2021-08-11  2619  					opp-hz = /bits/ 64 <315000000>;
96c471970b7bcb Akhil P Oommen                   2021-08-11  2620  					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
96c471970b7bcb Akhil P Oommen                   2021-08-11  2621  					opp-peak-kBps = <1804000>;
3bfef00d767124 Akhil P Oommen                   2022-02-26  2622  					opp-supported-hw = <0x03>;
96c471970b7bcb Akhil P Oommen                   2021-08-11  2623  				};
96c471970b7bcb Akhil P Oommen                   2021-08-11  2624  
96c471970b7bcb Akhil P Oommen                   2021-08-11  2625  				opp-450000000 {
96c471970b7bcb Akhil P Oommen                   2021-08-11  2626  					opp-hz = /bits/ 64 <450000000>;
96c471970b7bcb Akhil P Oommen                   2021-08-11  2627  					opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
96c471970b7bcb Akhil P Oommen                   2021-08-11  2628  					opp-peak-kBps = <4068000>;
3bfef00d767124 Akhil P Oommen                   2022-02-26  2629  					opp-supported-hw = <0x03>;
96c471970b7bcb Akhil P Oommen                   2021-08-11  2630  				};
96c471970b7bcb Akhil P Oommen                   2021-08-11  2631  
ad3b0f33fa54b4 Akhil P Oommen                   2022-08-29  2632  				/* Only applicable for SKUs which has 550Mhz as Fmax */
ad3b0f33fa54b4 Akhil P Oommen                   2022-08-29  2633  				opp-550000000-0 {
ad3b0f33fa54b4 Akhil P Oommen                   2022-08-29  2634  					opp-hz = /bits/ 64 <550000000>;
ad3b0f33fa54b4 Akhil P Oommen                   2022-08-29  2635  					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
ad3b0f33fa54b4 Akhil P Oommen                   2022-08-29  2636  					opp-peak-kBps = <8368000>;
ad3b0f33fa54b4 Akhil P Oommen                   2022-08-29  2637  					opp-supported-hw = <0x01>;
ad3b0f33fa54b4 Akhil P Oommen                   2022-08-29  2638  				};
ad3b0f33fa54b4 Akhil P Oommen                   2022-08-29  2639  
ad3b0f33fa54b4 Akhil P Oommen                   2022-08-29  2640  				opp-550000000-1 {
96c471970b7bcb Akhil P Oommen                   2021-08-11  2641  					opp-hz = /bits/ 64 <550000000>;
96c471970b7bcb Akhil P Oommen                   2021-08-11  2642  					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
96c471970b7bcb Akhil P Oommen                   2021-08-11  2643  					opp-peak-kBps = <6832000>;
ad3b0f33fa54b4 Akhil P Oommen                   2022-08-29  2644  					opp-supported-hw = <0x02>;
3bfef00d767124 Akhil P Oommen                   2022-02-26  2645  				};
3bfef00d767124 Akhil P Oommen                   2022-02-26  2646  
3bfef00d767124 Akhil P Oommen                   2022-02-26  2647  				opp-608000000 {
3bfef00d767124 Akhil P Oommen                   2022-02-26  2648  					opp-hz = /bits/ 64 <608000000>;
3bfef00d767124 Akhil P Oommen                   2022-02-26  2649  					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L2>;
3bfef00d767124 Akhil P Oommen                   2022-02-26  2650  					opp-peak-kBps = <8368000>;
3bfef00d767124 Akhil P Oommen                   2022-02-26  2651  					opp-supported-hw = <0x02>;
3bfef00d767124 Akhil P Oommen                   2022-02-26  2652  				};
3bfef00d767124 Akhil P Oommen                   2022-02-26  2653  
3bfef00d767124 Akhil P Oommen                   2022-02-26  2654  				opp-700000000 {
3bfef00d767124 Akhil P Oommen                   2022-02-26  2655  					opp-hz = /bits/ 64 <700000000>;
3bfef00d767124 Akhil P Oommen                   2022-02-26  2656  					opp-level = <RPMH_REGULATOR_LEVEL_NOM>;
3bfef00d767124 Akhil P Oommen                   2022-02-26  2657  					opp-peak-kBps = <8532000>;
3bfef00d767124 Akhil P Oommen                   2022-02-26  2658  					opp-supported-hw = <0x02>;
3bfef00d767124 Akhil P Oommen                   2022-02-26  2659  				};
3bfef00d767124 Akhil P Oommen                   2022-02-26  2660  
3bfef00d767124 Akhil P Oommen                   2022-02-26  2661  				opp-812000000 {
3bfef00d767124 Akhil P Oommen                   2022-02-26  2662  					opp-hz = /bits/ 64 <812000000>;
3bfef00d767124 Akhil P Oommen                   2022-02-26  2663  					opp-level = <RPMH_REGULATOR_LEVEL_NOM_L1>;
3bfef00d767124 Akhil P Oommen                   2022-02-26  2664  					opp-peak-kBps = <8532000>;
3bfef00d767124 Akhil P Oommen                   2022-02-26  2665  					opp-supported-hw = <0x02>;
3bfef00d767124 Akhil P Oommen                   2022-02-26  2666  				};
3bfef00d767124 Akhil P Oommen                   2022-02-26  2667  
3bfef00d767124 Akhil P Oommen                   2022-02-26  2668  				opp-840000000 {
3bfef00d767124 Akhil P Oommen                   2022-02-26  2669  					opp-hz = /bits/ 64 <840000000>;
3bfef00d767124 Akhil P Oommen                   2022-02-26  2670  					opp-level = <RPMH_REGULATOR_LEVEL_TURBO>;
3bfef00d767124 Akhil P Oommen                   2022-02-26  2671  					opp-peak-kBps = <8532000>;
3bfef00d767124 Akhil P Oommen                   2022-02-26  2672  					opp-supported-hw = <0x02>;
3bfef00d767124 Akhil P Oommen                   2022-02-26  2673  				};
3bfef00d767124 Akhil P Oommen                   2022-02-26  2674  
3bfef00d767124 Akhil P Oommen                   2022-02-26  2675  				opp-900000000 {
3bfef00d767124 Akhil P Oommen                   2022-02-26  2676  					opp-hz = /bits/ 64 <900000000>;
3bfef00d767124 Akhil P Oommen                   2022-02-26  2677  					opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L1>;
3bfef00d767124 Akhil P Oommen                   2022-02-26  2678  					opp-peak-kBps = <8532000>;
3bfef00d767124 Akhil P Oommen                   2022-02-26  2679  					opp-supported-hw = <0x02>;
96c471970b7bcb Akhil P Oommen                   2021-08-11  2680  				};
96c471970b7bcb Akhil P Oommen                   2021-08-11  2681  			};
96c471970b7bcb Akhil P Oommen                   2021-08-11  2682  		};
96c471970b7bcb Akhil P Oommen                   2021-08-11  2683  
142a4d995c6adb Douglas Anderson                 2022-01-25  2684  		gmu: gmu@3d6a000 {
96c471970b7bcb Akhil P Oommen                   2021-08-11  2685  			compatible = "qcom,adreno-gmu-635.0", "qcom,adreno-gmu";
96c471970b7bcb Akhil P Oommen                   2021-08-11  2686  			reg = <0 0x03d6a000 0 0x34000>,
96c471970b7bcb Akhil P Oommen                   2021-08-11  2687  				<0 0x3de0000 0 0x10000>,
96c471970b7bcb Akhil P Oommen                   2021-08-11  2688  				<0 0x0b290000 0 0x10000>;
96c471970b7bcb Akhil P Oommen                   2021-08-11  2689  			reg-names = "gmu", "rscc", "gmu_pdc";
96c471970b7bcb Akhil P Oommen                   2021-08-11  2690  			interrupts = <GIC_SPI 304 IRQ_TYPE_LEVEL_HIGH>,
96c471970b7bcb Akhil P Oommen                   2021-08-11  2691  					<GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>;
96c471970b7bcb Akhil P Oommen                   2021-08-11  2692  			interrupt-names = "hfi", "gmu";
63162b473e3ae0 Dmitry Baryshkov                 2022-07-06  2693  			clocks = <&gpucc GPU_CC_CX_GMU_CLK>,
63162b473e3ae0 Dmitry Baryshkov                 2022-07-06  2694  				 <&gpucc GPU_CC_CXO_CLK>,
96c471970b7bcb Akhil P Oommen                   2021-08-11  2695  				 <&gcc GCC_DDRSS_GPU_AXI_CLK>,
96c471970b7bcb Akhil P Oommen                   2021-08-11  2696  				 <&gcc GCC_GPU_MEMNOC_GFX_CLK>,
63162b473e3ae0 Dmitry Baryshkov                 2022-07-06  2697  				 <&gpucc GPU_CC_AHB_CLK>,
63162b473e3ae0 Dmitry Baryshkov                 2022-07-06  2698  				 <&gpucc GPU_CC_HUB_CX_INT_CLK>,
63162b473e3ae0 Dmitry Baryshkov                 2022-07-06  2699  				 <&gpucc GPU_CC_HLOS1_VOTE_GPU_SMMU_CLK>;
96c471970b7bcb Akhil P Oommen                   2021-08-11  2700  			clock-names = "gmu",
96c471970b7bcb Akhil P Oommen                   2021-08-11  2701  				      "cxo",
96c471970b7bcb Akhil P Oommen                   2021-08-11  2702  				      "axi",
96c471970b7bcb Akhil P Oommen                   2021-08-11  2703  				      "memnoc",
96c471970b7bcb Akhil P Oommen                   2021-08-11  2704  				      "ahb",
96c471970b7bcb Akhil P Oommen                   2021-08-11  2705  				      "hub",
96c471970b7bcb Akhil P Oommen                   2021-08-11  2706  				      "smmu_vote";
63162b473e3ae0 Dmitry Baryshkov                 2022-07-06  2707  			power-domains = <&gpucc GPU_CC_CX_GDSC>,
63162b473e3ae0 Dmitry Baryshkov                 2022-07-06  2708  					<&gpucc GPU_CC_GX_GDSC>;
96c471970b7bcb Akhil P Oommen                   2021-08-11  2709  			power-domain-names = "cx",
96c471970b7bcb Akhil P Oommen                   2021-08-11  2710  					     "gx";
96c471970b7bcb Akhil P Oommen                   2021-08-11  2711  			iommus = <&adreno_smmu 5 0x400>;
96c471970b7bcb Akhil P Oommen                   2021-08-11  2712  			operating-points-v2 = <&gmu_opp_table>;
96c471970b7bcb Akhil P Oommen                   2021-08-11  2713  
96c471970b7bcb Akhil P Oommen                   2021-08-11  2714  			gmu_opp_table: opp-table {
96c471970b7bcb Akhil P Oommen                   2021-08-11  2715  				compatible = "operating-points-v2";
96c471970b7bcb Akhil P Oommen                   2021-08-11  2716  
96c471970b7bcb Akhil P Oommen                   2021-08-11  2717  				opp-200000000 {
96c471970b7bcb Akhil P Oommen                   2021-08-11  2718  					opp-hz = /bits/ 64 <200000000>;
96c471970b7bcb Akhil P Oommen                   2021-08-11  2719  					opp-level = <RPMH_REGULATOR_LEVEL_MIN_SVS>;
96c471970b7bcb Akhil P Oommen                   2021-08-11  2720  				};
96c471970b7bcb Akhil P Oommen                   2021-08-11  2721  			};
96c471970b7bcb Akhil P Oommen                   2021-08-11  2722  		};
96c471970b7bcb Akhil P Oommen                   2021-08-11  2723  
422a295221bba8 Taniya Das                       2021-04-10  2724  		gpucc: clock-controller@3d90000 {
422a295221bba8 Taniya Das                       2021-04-10  2725  			compatible = "qcom,sc7280-gpucc";
422a295221bba8 Taniya Das                       2021-04-10  2726  			reg = <0 0x03d90000 0 0x9000>;
422a295221bba8 Taniya Das                       2021-04-10  2727  			clocks = <&rpmhcc RPMH_CXO_CLK>,
422a295221bba8 Taniya Das                       2021-04-10  2728  				 <&gcc GCC_GPU_GPLL0_CLK_SRC>,
422a295221bba8 Taniya Das                       2021-04-10  2729  				 <&gcc GCC_GPU_GPLL0_DIV_CLK_SRC>;
422a295221bba8 Taniya Das                       2021-04-10  2730  			clock-names = "bi_tcxo",
422a295221bba8 Taniya Das                       2021-04-10  2731  				      "gcc_gpu_gpll0_clk_src",
422a295221bba8 Taniya Das                       2021-04-10  2732  				      "gcc_gpu_gpll0_div_clk_src";
422a295221bba8 Taniya Das                       2021-04-10  2733  			#clock-cells = <1>;
422a295221bba8 Taniya Das                       2021-04-10  2734  			#reset-cells = <1>;
422a295221bba8 Taniya Das                       2021-04-10  2735  			#power-domain-cells = <1>;
422a295221bba8 Taniya Das                       2021-04-10  2736  		};
422a295221bba8 Taniya Das                       2021-04-10  2737  
029d6586dc2d1d Souradeep Chowdhury              2022-12-27  2738  		dma@117f000 {
029d6586dc2d1d Souradeep Chowdhury              2022-12-27  2739  			compatible = "qcom,sc7280-dcc", "qcom,dcc";
029d6586dc2d1d Souradeep Chowdhury              2022-12-27  2740  			reg = <0x0 0x0117f000 0x0 0x1000>,
029d6586dc2d1d Souradeep Chowdhury              2022-12-27  2741  			      <0x0 0x01112000 0x0 0x6000>;
029d6586dc2d1d Souradeep Chowdhury              2022-12-27  2742  		};
029d6586dc2d1d Souradeep Chowdhury              2022-12-27  2743  
96c471970b7bcb Akhil P Oommen                   2021-08-11  2744  		adreno_smmu: iommu@3da0000 {
c564b69984a78c Konrad Dybcio                    2023-02-16  2745  			compatible = "qcom,sc7280-smmu-500", "qcom,adreno-smmu",
c564b69984a78c Konrad Dybcio                    2023-02-16  2746  				     "qcom,smmu-500", "arm,mmu-500";
96c471970b7bcb Akhil P Oommen                   2021-08-11  2747  			reg = <0 0x03da0000 0 0x20000>;
96c471970b7bcb Akhil P Oommen                   2021-08-11  2748  			#iommu-cells = <2>;
96c471970b7bcb Akhil P Oommen                   2021-08-11  2749  			#global-interrupts = <2>;
96c471970b7bcb Akhil P Oommen                   2021-08-11  2750  			interrupts = <GIC_SPI 673 IRQ_TYPE_LEVEL_HIGH>,
96c471970b7bcb Akhil P Oommen                   2021-08-11  2751  					<GIC_SPI 675 IRQ_TYPE_LEVEL_HIGH>,
96c471970b7bcb Akhil P Oommen                   2021-08-11  2752  					<GIC_SPI 678 IRQ_TYPE_LEVEL_HIGH>,
96c471970b7bcb Akhil P Oommen                   2021-08-11  2753  					<GIC_SPI 679 IRQ_TYPE_LEVEL_HIGH>,
96c471970b7bcb Akhil P Oommen                   2021-08-11  2754  					<GIC_SPI 680 IRQ_TYPE_LEVEL_HIGH>,
96c471970b7bcb Akhil P Oommen                   2021-08-11  2755  					<GIC_SPI 681 IRQ_TYPE_LEVEL_HIGH>,
96c471970b7bcb Akhil P Oommen                   2021-08-11  2756  					<GIC_SPI 682 IRQ_TYPE_LEVEL_HIGH>,
96c471970b7bcb Akhil P Oommen                   2021-08-11  2757  					<GIC_SPI 683 IRQ_TYPE_LEVEL_HIGH>,
96c471970b7bcb Akhil P Oommen                   2021-08-11  2758  					<GIC_SPI 684 IRQ_TYPE_LEVEL_HIGH>,
96c471970b7bcb Akhil P Oommen                   2021-08-11  2759  					<GIC_SPI 685 IRQ_TYPE_LEVEL_HIGH>,
96c471970b7bcb Akhil P Oommen                   2021-08-11  2760  					<GIC_SPI 686 IRQ_TYPE_LEVEL_HIGH>,
96c471970b7bcb Akhil P Oommen                   2021-08-11  2761  					<GIC_SPI 687 IRQ_TYPE_LEVEL_HIGH>;
96c471970b7bcb Akhil P Oommen                   2021-08-11  2762  
96c471970b7bcb Akhil P Oommen                   2021-08-11  2763  			clocks = <&gcc GCC_GPU_MEMNOC_GFX_CLK>,
96c471970b7bcb Akhil P Oommen                   2021-08-11  2764  				 <&gcc GCC_GPU_SNOC_DVM_GFX_CLK>,
63162b473e3ae0 Dmitry Baryshkov                 2022-07-06  2765  				 <&gpucc GPU_CC_AHB_CLK>,
63162b473e3ae0 Dmitry Baryshkov                 2022-07-06  2766  				 <&gpucc GPU_CC_HLOS1_VOTE_GPU_SMMU_CLK>,
63162b473e3ae0 Dmitry Baryshkov                 2022-07-06  2767  				 <&gpucc GPU_CC_CX_GMU_CLK>,
63162b473e3ae0 Dmitry Baryshkov                 2022-07-06  2768  				 <&gpucc GPU_CC_HUB_CX_INT_CLK>,
63162b473e3ae0 Dmitry Baryshkov                 2022-07-06  2769  				 <&gpucc GPU_CC_HUB_AON_CLK>;
96c471970b7bcb Akhil P Oommen                   2021-08-11  2770  			clock-names = "gcc_gpu_memnoc_gfx_clk",
96c471970b7bcb Akhil P Oommen                   2021-08-11  2771  					"gcc_gpu_snoc_dvm_gfx_clk",
96c471970b7bcb Akhil P Oommen                   2021-08-11  2772  					"gpu_cc_ahb_clk",
96c471970b7bcb Akhil P Oommen                   2021-08-11  2773  					"gpu_cc_hlos1_vote_gpu_smmu_clk",
96c471970b7bcb Akhil P Oommen                   2021-08-11  2774  					"gpu_cc_cx_gmu_clk",
96c471970b7bcb Akhil P Oommen                   2021-08-11  2775  					"gpu_cc_hub_cx_int_clk",
96c471970b7bcb Akhil P Oommen                   2021-08-11  2776  					"gpu_cc_hub_aon_clk";
96c471970b7bcb Akhil P Oommen                   2021-08-11  2777  
63162b473e3ae0 Dmitry Baryshkov                 2022-07-06  2778  			power-domains = <&gpucc GPU_CC_CX_GDSC>;
96c471970b7bcb Akhil P Oommen                   2021-08-11  2779  		};
96c471970b7bcb Akhil P Oommen                   2021-08-11  2780  
4882cafb99c2b0 Sibi Sankar                      2021-09-17  2781  		remoteproc_mpss: remoteproc@4080000 {
4882cafb99c2b0 Sibi Sankar                      2021-09-17  2782  			compatible = "qcom,sc7280-mpss-pas";
0025fac17b313c Sibi Sankar                      2021-09-17  2783  			reg = <0 0x04080000 0 0x10000>, <0 0x04180000 0 0x48>;
0025fac17b313c Sibi Sankar                      2021-09-17  2784  			reg-names = "qdsp6", "rmb";
4882cafb99c2b0 Sibi Sankar                      2021-09-17  2785  
4882cafb99c2b0 Sibi Sankar                      2021-09-17  2786  			interrupts-extended = <&intc GIC_SPI 264 IRQ_TYPE_EDGE_RISING>,
4882cafb99c2b0 Sibi Sankar                      2021-09-17  2787  					      <&modem_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
4882cafb99c2b0 Sibi Sankar                      2021-09-17  2788  					      <&modem_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
4882cafb99c2b0 Sibi Sankar                      2021-09-17  2789  					      <&modem_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
4882cafb99c2b0 Sibi Sankar                      2021-09-17  2790  					      <&modem_smp2p_in 3 IRQ_TYPE_EDGE_RISING>,
4882cafb99c2b0 Sibi Sankar                      2021-09-17  2791  					      <&modem_smp2p_in 7 IRQ_TYPE_EDGE_RISING>;
4882cafb99c2b0 Sibi Sankar                      2021-09-17  2792  			interrupt-names = "wdog", "fatal", "ready", "handover",
4882cafb99c2b0 Sibi Sankar                      2021-09-17  2793  					  "stop-ack", "shutdown-ack";
4882cafb99c2b0 Sibi Sankar                      2021-09-17  2794  
92476ddf02b566 Krzysztof Kozlowski              2022-11-24  2795  			clocks = <&rpmhcc RPMH_CXO_CLK>;
92476ddf02b566 Krzysztof Kozlowski              2022-11-24  2796  			clock-names = "xo";
4882cafb99c2b0 Sibi Sankar                      2021-09-17  2797  
4882cafb99c2b0 Sibi Sankar                      2021-09-17  2798  			power-domains = <&rpmhpd SC7280_CX>,
4882cafb99c2b0 Sibi Sankar                      2021-09-17  2799  					<&rpmhpd SC7280_MSS>;
4882cafb99c2b0 Sibi Sankar                      2021-09-17  2800  			power-domain-names = "cx", "mss";
4882cafb99c2b0 Sibi Sankar                      2021-09-17  2801  
4882cafb99c2b0 Sibi Sankar                      2021-09-17  2802  			memory-region = <&mpss_mem>;
4882cafb99c2b0 Sibi Sankar                      2021-09-17  2803  
4882cafb99c2b0 Sibi Sankar                      2021-09-17  2804  			qcom,qmp = <&aoss_qmp>;
4882cafb99c2b0 Sibi Sankar                      2021-09-17  2805  
4882cafb99c2b0 Sibi Sankar                      2021-09-17  2806  			qcom,smem-states = <&modem_smp2p_out 0>;
4882cafb99c2b0 Sibi Sankar                      2021-09-17  2807  			qcom,smem-state-names = "stop";
4882cafb99c2b0 Sibi Sankar                      2021-09-17  2808  
4882cafb99c2b0 Sibi Sankar                      2021-09-17  2809  			status = "disabled";
4882cafb99c2b0 Sibi Sankar                      2021-09-17  2810  
4882cafb99c2b0 Sibi Sankar                      2021-09-17  2811  			glink-edge {
4882cafb99c2b0 Sibi Sankar                      2021-09-17  2812  				interrupts-extended = <&ipcc IPCC_CLIENT_MPSS
4882cafb99c2b0 Sibi Sankar                      2021-09-17  2813  							     IPCC_MPROC_SIGNAL_GLINK_QMP
4882cafb99c2b0 Sibi Sankar                      2021-09-17  2814  							     IRQ_TYPE_EDGE_RISING>;
4882cafb99c2b0 Sibi Sankar                      2021-09-17  2815  				mboxes = <&ipcc IPCC_CLIENT_MPSS
4882cafb99c2b0 Sibi Sankar                      2021-09-17  2816  						IPCC_MPROC_SIGNAL_GLINK_QMP>;
4882cafb99c2b0 Sibi Sankar                      2021-09-17  2817  				label = "modem";
4882cafb99c2b0 Sibi Sankar                      2021-09-17  2818  				qcom,remote-pid = <1>;
4882cafb99c2b0 Sibi Sankar                      2021-09-17  2819  			};
4882cafb99c2b0 Sibi Sankar                      2021-09-17  2820  		};
4882cafb99c2b0 Sibi Sankar                      2021-09-17  2821  
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2822  		stm@6002000 {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2823  			compatible = "arm,coresight-stm", "arm,primecell";
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2824  			reg = <0 0x06002000 0 0x1000>,
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2825  			      <0 0x16280000 0 0x180000>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2826  			reg-names = "stm-base", "stm-stimulus-base";
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2827  
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2828  			clocks = <&aoss_qmp>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2829  			clock-names = "apb_pclk";
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2830  
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2831  			out-ports {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2832  				port {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2833  					stm_out: endpoint {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2834  						remote-endpoint = <&funnel0_in7>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2835  					};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2836  				};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2837  			};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2838  		};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2839  
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2840  		funnel@6041000 {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2841  			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2842  			reg = <0 0x06041000 0 0x1000>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2843  
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2844  			clocks = <&aoss_qmp>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2845  			clock-names = "apb_pclk";
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2846  
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2847  			out-ports {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2848  				port {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2849  					funnel0_out: endpoint {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2850  						remote-endpoint = <&merge_funnel_in0>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2851  					};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2852  				};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2853  			};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2854  
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2855  			in-ports {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2856  				#address-cells = <1>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2857  				#size-cells = <0>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2858  
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2859  				port@7 {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2860  					reg = <7>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2861  					funnel0_in7: endpoint {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2862  						remote-endpoint = <&stm_out>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2863  					};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2864  				};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2865  			};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2866  		};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2867  
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2868  		funnel@6042000 {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2869  			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2870  			reg = <0 0x06042000 0 0x1000>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2871  
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2872  			clocks = <&aoss_qmp>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2873  			clock-names = "apb_pclk";
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2874  
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2875  			out-ports {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2876  				port {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2877  					funnel1_out: endpoint {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2878  						remote-endpoint = <&merge_funnel_in1>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2879  					};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2880  				};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2881  			};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2882  
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2883  			in-ports {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2884  				#address-cells = <1>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2885  				#size-cells = <0>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2886  
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2887  				port@4 {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2888  					reg = <4>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2889  					funnel1_in4: endpoint {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2890  						remote-endpoint = <&apss_merge_funnel_out>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2891  					};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2892  				};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2893  			};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2894  		};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2895  
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2896  		funnel@6045000 {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2897  			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2898  			reg = <0 0x06045000 0 0x1000>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2899  
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2900  			clocks = <&aoss_qmp>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2901  			clock-names = "apb_pclk";
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2902  
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2903  			out-ports {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2904  				port {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2905  					merge_funnel_out: endpoint {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2906  						remote-endpoint = <&swao_funnel_in>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2907  					};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2908  				};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2909  			};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2910  
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2911  			in-ports {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2912  				#address-cells = <1>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2913  				#size-cells = <0>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2914  
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2915  				port@0 {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2916  					reg = <0>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2917  					merge_funnel_in0: endpoint {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2918  						remote-endpoint = <&funnel0_out>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2919  					};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2920  				};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2921  
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2922  				port@1 {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2923  					reg = <1>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2924  					merge_funnel_in1: endpoint {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2925  						remote-endpoint = <&funnel1_out>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2926  					};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2927  				};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2928  			};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2929  		};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2930  
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2931  		replicator@6046000 {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2932  			compatible = "arm,coresight-dynamic-replicator", "arm,primecell";
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2933  			reg = <0 0x06046000 0 0x1000>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2934  
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2935  			clocks = <&aoss_qmp>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2936  			clock-names = "apb_pclk";
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2937  
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2938  			out-ports {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2939  				port {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2940  					replicator_out: endpoint {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2941  						remote-endpoint = <&etr_in>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2942  					};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2943  				};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2944  			};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2945  
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2946  			in-ports {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2947  				port {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2948  					replicator_in: endpoint {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2949  						remote-endpoint = <&swao_replicator_out>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2950  					};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2951  				};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2952  			};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2953  		};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2954  
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2955  		etr@6048000 {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2956  			compatible = "arm,coresight-tmc", "arm,primecell";
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2957  			reg = <0 0x06048000 0 0x1000>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2958  			iommus = <&apps_smmu 0x04c0 0>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2959  
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2960  			clocks = <&aoss_qmp>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2961  			clock-names = "apb_pclk";
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2962  			arm,scatter-gather;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2963  
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2964  			in-ports {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2965  				port {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2966  					etr_in: endpoint {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2967  						remote-endpoint = <&replicator_out>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2968  					};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2969  				};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2970  			};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2971  		};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2972  
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2973  		funnel@6b04000 {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2974  			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2975  			reg = <0 0x06b04000 0 0x1000>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2976  
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2977  			clocks = <&aoss_qmp>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2978  			clock-names = "apb_pclk";
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2979  
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2980  			out-ports {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2981  				port {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2982  					swao_funnel_out: endpoint {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2983  						remote-endpoint = <&etf_in>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2984  					};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2985  				};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2986  			};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2987  
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2988  			in-ports {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2989  				#address-cells = <1>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2990  				#size-cells = <0>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2991  
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2992  				port@7 {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2993  					reg = <7>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2994  					swao_funnel_in: endpoint {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2995  						remote-endpoint = <&merge_funnel_out>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2996  					};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2997  				};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2998  			};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  2999  		};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3000  
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3001  		etf@6b05000 {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3002  			compatible = "arm,coresight-tmc", "arm,primecell";
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3003  			reg = <0 0x06b05000 0 0x1000>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3004  
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3005  			clocks = <&aoss_qmp>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3006  			clock-names = "apb_pclk";
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3007  
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3008  			out-ports {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3009  				port {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3010  					etf_out: endpoint {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3011  						remote-endpoint = <&swao_replicator_in>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3012  					};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3013  				};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3014  			};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3015  
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3016  			in-ports {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3017  				port {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3018  					etf_in: endpoint {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3019  						remote-endpoint = <&swao_funnel_out>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3020  					};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3021  				};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3022  			};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3023  		};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3024  
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3025  		replicator@6b06000 {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3026  			compatible = "arm,coresight-dynamic-replicator", "arm,primecell";
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3027  			reg = <0 0x06b06000 0 0x1000>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3028  
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3029  			clocks = <&aoss_qmp>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3030  			clock-names = "apb_pclk";
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3031  			qcom,replicator-loses-context;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3032  
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3033  			out-ports {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3034  				port {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3035  					swao_replicator_out: endpoint {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3036  						remote-endpoint = <&replicator_in>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3037  					};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3038  				};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3039  			};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3040  
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3041  			in-ports {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3042  				port {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3043  					swao_replicator_in: endpoint {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3044  						remote-endpoint = <&etf_out>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3045  					};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3046  				};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3047  			};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3048  		};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3049  
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3050  		etm@7040000 {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3051  			compatible = "arm,coresight-etm4x", "arm,primecell";
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3052  			reg = <0 0x07040000 0 0x1000>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3053  
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3054  			cpu = <&CPU0>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3055  
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3056  			clocks = <&aoss_qmp>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3057  			clock-names = "apb_pclk";
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3058  			arm,coresight-loses-context-with-cpu;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3059  			qcom,skip-power-up;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3060  
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3061  			out-ports {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3062  				port {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3063  					etm0_out: endpoint {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3064  						remote-endpoint = <&apss_funnel_in0>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3065  					};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3066  				};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3067  			};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3068  		};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3069  
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3070  		etm@7140000 {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3071  			compatible = "arm,coresight-etm4x", "arm,primecell";
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3072  			reg = <0 0x07140000 0 0x1000>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3073  
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3074  			cpu = <&CPU1>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3075  
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3076  			clocks = <&aoss_qmp>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3077  			clock-names = "apb_pclk";
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3078  			arm,coresight-loses-context-with-cpu;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3079  			qcom,skip-power-up;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3080  
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3081  			out-ports {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3082  				port {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3083  					etm1_out: endpoint {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3084  						remote-endpoint = <&apss_funnel_in1>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3085  					};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3086  				};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3087  			};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3088  		};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3089  
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3090  		etm@7240000 {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3091  			compatible = "arm,coresight-etm4x", "arm,primecell";
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3092  			reg = <0 0x07240000 0 0x1000>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3093  
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3094  			cpu = <&CPU2>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3095  
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3096  			clocks = <&aoss_qmp>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3097  			clock-names = "apb_pclk";
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3098  			arm,coresight-loses-context-with-cpu;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3099  			qcom,skip-power-up;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3100  
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3101  			out-ports {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3102  				port {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3103  					etm2_out: endpoint {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3104  						remote-endpoint = <&apss_funnel_in2>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3105  					};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3106  				};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3107  			};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3108  		};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3109  
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3110  		etm@7340000 {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3111  			compatible = "arm,coresight-etm4x", "arm,primecell";
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3112  			reg = <0 0x07340000 0 0x1000>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3113  
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3114  			cpu = <&CPU3>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3115  
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3116  			clocks = <&aoss_qmp>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3117  			clock-names = "apb_pclk";
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3118  			arm,coresight-loses-context-with-cpu;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3119  			qcom,skip-power-up;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3120  
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3121  			out-ports {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3122  				port {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3123  					etm3_out: endpoint {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3124  						remote-endpoint = <&apss_funnel_in3>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3125  					};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3126  				};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3127  			};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3128  		};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3129  
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3130  		etm@7440000 {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3131  			compatible = "arm,coresight-etm4x", "arm,primecell";
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3132  			reg = <0 0x07440000 0 0x1000>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3133  
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3134  			cpu = <&CPU4>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3135  
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3136  			clocks = <&aoss_qmp>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3137  			clock-names = "apb_pclk";
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3138  			arm,coresight-loses-context-with-cpu;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3139  			qcom,skip-power-up;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3140  
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3141  			out-ports {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3142  				port {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3143  					etm4_out: endpoint {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3144  						remote-endpoint = <&apss_funnel_in4>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3145  					};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3146  				};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3147  			};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3148  		};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3149  
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3150  		etm@7540000 {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3151  			compatible = "arm,coresight-etm4x", "arm,primecell";
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3152  			reg = <0 0x07540000 0 0x1000>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3153  
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3154  			cpu = <&CPU5>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3155  
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3156  			clocks = <&aoss_qmp>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3157  			clock-names = "apb_pclk";
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3158  			arm,coresight-loses-context-with-cpu;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3159  			qcom,skip-power-up;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3160  
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3161  			out-ports {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3162  				port {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3163  					etm5_out: endpoint {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3164  						remote-endpoint = <&apss_funnel_in5>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3165  					};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3166  				};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3167  			};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3168  		};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3169  
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3170  		etm@7640000 {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3171  			compatible = "arm,coresight-etm4x", "arm,primecell";
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3172  			reg = <0 0x07640000 0 0x1000>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3173  
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3174  			cpu = <&CPU6>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3175  
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3176  			clocks = <&aoss_qmp>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3177  			clock-names = "apb_pclk";
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3178  			arm,coresight-loses-context-with-cpu;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3179  			qcom,skip-power-up;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3180  
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3181  			out-ports {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3182  				port {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3183  					etm6_out: endpoint {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3184  						remote-endpoint = <&apss_funnel_in6>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3185  					};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3186  				};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3187  			};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3188  		};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3189  
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3190  		etm@7740000 {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3191  			compatible = "arm,coresight-etm4x", "arm,primecell";
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3192  			reg = <0 0x07740000 0 0x1000>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3193  
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3194  			cpu = <&CPU7>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3195  
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3196  			clocks = <&aoss_qmp>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3197  			clock-names = "apb_pclk";
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3198  			arm,coresight-loses-context-with-cpu;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3199  			qcom,skip-power-up;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3200  
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3201  			out-ports {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3202  				port {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3203  					etm7_out: endpoint {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3204  						remote-endpoint = <&apss_funnel_in7>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3205  					};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3206  				};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3207  			};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3208  		};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3209  
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3210  		funnel@7800000 { /* APSS Funnel */
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3211  			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3212  			reg = <0 0x07800000 0 0x1000>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3213  
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3214  			clocks = <&aoss_qmp>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3215  			clock-names = "apb_pclk";
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3216  
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3217  			out-ports {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3218  				port {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3219  					apss_funnel_out: endpoint {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3220  						remote-endpoint = <&apss_merge_funnel_in>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3221  					};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3222  				};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3223  			};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3224  
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3225  			in-ports {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3226  				#address-cells = <1>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3227  				#size-cells = <0>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3228  
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3229  				port@0 {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3230  					reg = <0>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3231  					apss_funnel_in0: endpoint {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3232  						remote-endpoint = <&etm0_out>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3233  					};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3234  				};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3235  
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3236  				port@1 {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3237  					reg = <1>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3238  					apss_funnel_in1: endpoint {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3239  						remote-endpoint = <&etm1_out>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3240  					};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3241  				};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3242  
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3243  				port@2 {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3244  					reg = <2>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3245  					apss_funnel_in2: endpoint {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3246  						remote-endpoint = <&etm2_out>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3247  					};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3248  				};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3249  
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3250  				port@3 {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3251  					reg = <3>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3252  					apss_funnel_in3: endpoint {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3253  						remote-endpoint = <&etm3_out>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3254  					};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3255  				};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3256  
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3257  				port@4 {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3258  					reg = <4>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3259  					apss_funnel_in4: endpoint {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3260  						remote-endpoint = <&etm4_out>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3261  					};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3262  				};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3263  
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3264  				port@5 {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3265  					reg = <5>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3266  					apss_funnel_in5: endpoint {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3267  						remote-endpoint = <&etm5_out>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3268  					};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3269  				};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3270  
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3271  				port@6 {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3272  					reg = <6>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3273  					apss_funnel_in6: endpoint {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3274  						remote-endpoint = <&etm6_out>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3275  					};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3276  				};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3277  
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3278  				port@7 {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3279  					reg = <7>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3280  					apss_funnel_in7: endpoint {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3281  						remote-endpoint = <&etm7_out>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3282  					};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3283  				};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3284  			};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3285  		};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3286  
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3287  		funnel@7810000 {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3288  			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3289  			reg = <0 0x07810000 0 0x1000>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3290  
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3291  			clocks = <&aoss_qmp>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3292  			clock-names = "apb_pclk";
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3293  
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3294  			out-ports {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3295  				port {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3296  					apss_merge_funnel_out: endpoint {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3297  						remote-endpoint = <&funnel1_in4>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3298  					};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3299  				};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3300  			};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3301  
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3302  			in-ports {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3303  				port {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3304  					apss_merge_funnel_in: endpoint {
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3305  						remote-endpoint = <&apss_funnel_out>;
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3306  					};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3307  				};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3308  			};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3309  		};
544cebe1895638 Sai Prakash Ranjan               2021-03-16  3310  
96bb736f05d156 Bhupesh Sharma                   2022-05-15  3311  		sdhc_2: mmc@8804000 {
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13  3312  			compatible = "qcom,sc7280-sdhci", "qcom,sdhci-msm-v5";
f9800dde34e678 Douglas Anderson                 2022-02-02  3313  			pinctrl-names = "default", "sleep";
f9800dde34e678 Douglas Anderson                 2022-02-02  3314  			pinctrl-0 = <&sdc2_clk>, <&sdc2_cmd>, <&sdc2_data>;
f9800dde34e678 Douglas Anderson                 2022-02-02  3315  			pinctrl-1 = <&sdc2_clk_sleep>, <&sdc2_cmd_sleep>, <&sdc2_data_sleep>;
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13  3316  			status = "disabled";
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13  3317  
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13  3318  			reg = <0 0x08804000 0 0x1000>;
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13  3319  
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13  3320  			iommus = <&apps_smmu 0x100 0x0>;
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13  3321  			interrupts = <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>,
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13  3322  				     <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13  3323  			interrupt-names = "hc_irq", "pwr_irq";
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13  3324  
4ff12270dbbe24 Bhupesh Sharma                   2022-05-15  3325  			clocks = <&gcc GCC_SDCC2_AHB_CLK>,
4ff12270dbbe24 Bhupesh Sharma                   2022-05-15  3326  				 <&gcc GCC_SDCC2_APPS_CLK>,
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13  3327  				 <&rpmhcc RPMH_CXO_CLK>;
4ff12270dbbe24 Bhupesh Sharma                   2022-05-15  3328  			clock-names = "iface", "core", "xo";
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13  3329  			interconnects = <&aggre1_noc MASTER_SDCC_2 0 &mc_virt SLAVE_EBI1 0>,
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13  3330  					<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_SDCC_2 0>;
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13  3331  			interconnect-names = "sdhc-ddr","cpu-sdhc";
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13  3332  			power-domains = <&rpmhpd SC7280_CX>;
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13  3333  			operating-points-v2 = <&sdhc2_opp_table>;
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13  3334  
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13  3335  			bus-width = <4>;
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13  3336  
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13  3337  			qcom,dll-config = <0x0007642c>;
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13  3338  
959cb513074386 Shaik Sajida Bhanu               2022-04-12  3339  			resets = <&gcc GCC_SDCC2_BCR>;
959cb513074386 Shaik Sajida Bhanu               2022-04-12  3340  
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13  3341  			sdhc2_opp_table: opp-table {
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13  3342  				compatible = "operating-points-v2";
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13  3343  
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13  3344  				opp-100000000 {
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13  3345  					opp-hz = /bits/ 64 <100000000>;
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13  3346  					required-opps = <&rpmhpd_opp_low_svs>;
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13  3347  					opp-peak-kBps = <1800000 400000>;
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13  3348  					opp-avg-kBps = <100000 0>;
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13  3349  				};
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13  3350  
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13  3351  				opp-202000000 {
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13  3352  					opp-hz = /bits/ 64 <202000000>;
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13  3353  					required-opps = <&rpmhpd_opp_nom>;
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13  3354  					opp-peak-kBps = <5400000 1600000>;
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13  3355  					opp-avg-kBps = <200000 0>;
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13  3356  				};
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13  3357  			};
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13  3358  		};
298c81a7d44fe0 Shaik Sajida Bhanu               2021-07-13  3359  
bb9efa59c6656f Sandeep Maheswaram               2021-07-06  3360  		usb_1_hsphy: phy@88e3000 {
bb9efa59c6656f Sandeep Maheswaram               2021-07-06  3361  			compatible = "qcom,sc7280-usb-hs-phy",
bb9efa59c6656f Sandeep Maheswaram               2021-07-06  3362  				     "qcom,usb-snps-hs-7nm-phy";
bb9efa59c6656f Sandeep Maheswaram               2021-07-06  3363  			reg = <0 0x088e3000 0 0x400>;
bb9efa59c6656f Sandeep Maheswaram               2021-07-06  3364  			status = "disabled";
bb9efa59c6656f Sandeep Maheswaram               2021-07-06  3365  			#phy-cells = <0>;
bb9efa59c6656f Sandeep Maheswaram               2021-07-06  3366  
bb9efa59c6656f Sandeep Maheswaram               2021-07-06  3367  			clocks = <&rpmhcc RPMH_CXO_CLK>;
bb9efa59c6656f Sandeep Maheswaram               2021-07-06  3368  			clock-names = "ref";
bb9efa59c6656f Sandeep Maheswaram               2021-07-06  3369  
bb9efa59c6656f Sandeep Maheswaram               2021-07-06  3370  			resets = <&gcc GCC_QUSB2PHY_PRIM_BCR>;
bb9efa59c6656f Sandeep Maheswaram               2021-07-06  3371  		};
bb9efa59c6656f Sandeep Maheswaram               2021-07-06  3372  
bb9efa59c6656f Sandeep Maheswaram               2021-07-06  3373  		usb_2_hsphy: phy@88e4000 {
bb9efa59c6656f Sandeep Maheswaram               2021-07-06  3374  			compatible = "qcom,sc7280-usb-hs-phy",
bb9efa59c6656f Sandeep Maheswaram               2021-07-06  3375  				     "qcom,usb-snps-hs-7nm-phy";
bb9efa59c6656f Sandeep Maheswaram               2021-07-06  3376  			reg = <0 0x088e4000 0 0x400>;
bb9efa59c6656f Sandeep Maheswaram               2021-07-06  3377  			status = "disabled";
bb9efa59c6656f Sandeep Maheswaram               2021-07-06  3378  			#phy-cells = <0>;
bb9efa59c6656f Sandeep Maheswaram               2021-07-06  3379  
bb9efa59c6656f Sandeep Maheswaram               2021-07-06  3380  			clocks = <&rpmhcc RPMH_CXO_CLK>;
bb9efa59c6656f Sandeep Maheswaram               2021-07-06  3381  			clock-names = "ref";
bb9efa59c6656f Sandeep Maheswaram               2021-07-06  3382  
bb9efa59c6656f Sandeep Maheswaram               2021-07-06  3383  			resets = <&gcc GCC_QUSB2PHY_SEC_BCR>;
bb9efa59c6656f Sandeep Maheswaram               2021-07-06  3384  		};
bb9efa59c6656f Sandeep Maheswaram               2021-07-06  3385  
36888ed83f998c Dmitry Baryshkov                 2023-07-11  3386  		usb_1_qmpphy: phy@88e8000 {
36888ed83f998c Dmitry Baryshkov                 2023-07-11  3387  			compatible = "qcom,sc7280-qmp-usb3-dp-phy";
36888ed83f998c Dmitry Baryshkov                 2023-07-11  3388  			reg = <0 0x088e8000 0 0x3000>;
bb9efa59c6656f Sandeep Maheswaram               2021-07-06  3389  			status = "disabled";
bb9efa59c6656f Sandeep Maheswaram               2021-07-06  3390  
bb9efa59c6656f Sandeep Maheswaram               2021-07-06  3391  			clocks = <&gcc GCC_USB3_PRIM_PHY_AUX_CLK>,
bb9efa59c6656f Sandeep Maheswaram               2021-07-06  3392  				 <&rpmhcc RPMH_CXO_CLK>,
36888ed83f998c Dmitry Baryshkov                 2023-07-11  3393  				 <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>,
36888ed83f998c Dmitry Baryshkov                 2023-07-11  3394  				 <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
36888ed83f998c Dmitry Baryshkov                 2023-07-11  3395  			clock-names = "aux",
36888ed83f998c Dmitry Baryshkov                 2023-07-11  3396  				      "ref",
36888ed83f998c Dmitry Baryshkov                 2023-07-11  3397  				      "com_aux",
36888ed83f998c Dmitry Baryshkov                 2023-07-11  3398  				      "usb3_pipe";
bb9efa59c6656f Sandeep Maheswaram               2021-07-06  3399  
bb9efa59c6656f Sandeep Maheswaram               2021-07-06  3400  			resets = <&gcc GCC_USB3_DP_PHY_PRIM_BCR>,
bb9efa59c6656f Sandeep Maheswaram               2021-07-06  3401  				 <&gcc GCC_USB3_PHY_PRIM_BCR>;
bb9efa59c6656f Sandeep Maheswaram               2021-07-06  3402  			reset-names = "phy", "common";
bb9efa59c6656f Sandeep Maheswaram               2021-07-06  3403  
bb9efa59c6656f Sandeep Maheswaram               2021-07-06  3404  			#clock-cells = <1>;
36888ed83f998c Dmitry Baryshkov                 2023-07-11  3405  			#phy-cells = <1>;
bb9efa59c6656f Sandeep Maheswaram               2021-07-06  3406  		};
bb9efa59c6656f Sandeep Maheswaram               2021-07-06  3407  
bb9efa59c6656f Sandeep Maheswaram               2021-07-06  3408  		usb_2: usb@8cf8800 {
bb9efa59c6656f Sandeep Maheswaram               2021-07-06  3409  			compatible = "qcom,sc7280-dwc3", "qcom,dwc3";
bb9efa59c6656f Sandeep Maheswaram               2021-07-06  3410  			reg = <0 0x08cf8800 0 0x400>;
bb9efa59c6656f Sandeep Maheswaram               2021-07-06  3411  			status = "disabled";
bb9efa59c6656f Sandeep Maheswaram               2021-07-06  3412  			#address-cells = <2>;
bb9efa59c6656f Sandeep Maheswaram               2021-07-06  3413  			#size-cells = <2>;
bb9efa59c6656f Sandeep Maheswaram               2021-07-06  3414  			ranges;
bb9efa59c6656f Sandeep Maheswaram               2021-07-06  3415  			dma-ranges;
bb9efa59c6656f Sandeep Maheswaram               2021-07-06  3416  
bb9efa59c6656f Sandeep Maheswaram               2021-07-06  3417  			clocks = <&gcc GCC_CFG_NOC_USB3_SEC_AXI_CLK>,
bb9efa59c6656f Sandeep Maheswaram               2021-07-06  3418  				 <&gcc GCC_USB30_SEC_MASTER_CLK>,
bb9efa59c6656f Sandeep Maheswaram               2021-07-06  3419  				 <&gcc GCC_AGGRE_USB3_SEC_AXI_CLK>,
8d5fd4e4d4e3c1 Krzysztof Kozlowski              2022-05-04  3420  				 <&gcc GCC_USB30_SEC_SLEEP_CLK>,
8d5fd4e4d4e3c1 Krzysztof Kozlowski              2022-05-04  3421  				 <&gcc GCC_USB30_SEC_MOCK_UTMI_CLK>;
8d5fd4e4d4e3c1 Krzysztof Kozlowski              2022-05-04  3422  			clock-names = "cfg_noc",
8d5fd4e4d4e3c1 Krzysztof Kozlowski              2022-05-04  3423  				      "core",
8d5fd4e4d4e3c1 Krzysztof Kozlowski              2022-05-04  3424  				      "iface",
8d5fd4e4d4e3c1 Krzysztof Kozlowski              2022-05-04  3425  				      "sleep",
8d5fd4e4d4e3c1 Krzysztof Kozlowski              2022-05-04  3426  				      "mock_utmi";
bb9efa59c6656f Sandeep Maheswaram               2021-07-06  3427  
bb9efa59c6656f Sandeep Maheswaram               2021-07-06  3428  			assigned-clocks = <&gcc GCC_USB30_SEC_MOCK_UTMI_CLK>,
bb9efa59c6656f Sandeep Maheswaram               2021-07-06  3429  					  <&gcc GCC_USB30_SEC_MASTER_CLK>;
bb9efa59c6656f Sandeep Maheswaram               2021-07-06  3430  			assigned-clock-rates = <19200000>, <200000000>;
bb9efa59c6656f Sandeep Maheswaram               2021-07-06  3431  
bb9efa59c6656f Sandeep Maheswaram               2021-07-06  3432  			interrupts-extended = <&intc GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>,
2a8d28b8af7906 Johan Hovold                     2022-07-15  3433  					      <&pdc 12 IRQ_TYPE_EDGE_RISING>,
2a8d28b8af7906 Johan Hovold                     2022-07-15  3434  					      <&pdc 13 IRQ_TYPE_EDGE_RISING>;
bb9efa59c6656f Sandeep Maheswaram               2021-07-06  3435  			interrupt-names = "hs_phy_irq",
2a8d28b8af7906 Johan Hovold                     2022-07-15  3436  					  "dp_hs_phy_irq",
2a8d28b8af7906 Johan Hovold                     2022-07-15  3437  					  "dm_hs_phy_irq";
bb9efa59c6656f Sandeep Maheswaram               2021-07-06  3438  
bb9efa59c6656f Sandeep Maheswaram               2021-07-06  3439  			power-domains = <&gcc GCC_USB30_SEC_GDSC>;
3d59187efc982b Rajendra Nayak                   2022-09-16  3440  			required-opps = <&rpmhpd_opp_nom>;
bb9efa59c6656f Sandeep Maheswaram               2021-07-06  3441  
bb9efa59c6656f Sandeep Maheswaram               2021-07-06  3442  			resets = <&gcc GCC_USB30_SEC_BCR>;
bb9efa59c6656f Sandeep Maheswaram               2021-07-06  3443  
6493367f8031b1 Sandeep Maheswaram               2021-08-02  3444  			interconnects = <&aggre1_noc MASTER_USB2 0 &mc_virt SLAVE_EBI1 0>,
6493367f8031b1 Sandeep Maheswaram               2021-08-02  3445  					<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_USB2 0>;
6493367f8031b1 Sandeep Maheswaram               2021-08-02  3446  			interconnect-names = "usb-ddr", "apps-usb";
6493367f8031b1 Sandeep Maheswaram               2021-08-02  3447  
bb9efa59c6656f Sandeep Maheswaram               2021-07-06  3448  			usb_2_dwc3: usb@8c00000 {
bb9efa59c6656f Sandeep Maheswaram               2021-07-06  3449  				compatible = "snps,dwc3";
bb9efa59c6656f Sandeep Maheswaram               2021-07-06  3450  				reg = <0 0x08c00000 0 0xe000>;
bb9efa59c6656f Sandeep Maheswaram               2021-07-06  3451  				interrupts = <GIC_SPI 242 IRQ_TYPE_LEVEL_HIGH>;
bb9efa59c6656f Sandeep Maheswaram               2021-07-06  3452  				iommus = <&apps_smmu 0xa0 0x0>;
bb9efa59c6656f Sandeep Maheswaram               2021-07-06  3453  				snps,dis_u2_susphy_quirk;
bb9efa59c6656f Sandeep Maheswaram               2021-07-06  3454  				snps,dis_enblslpm_quirk;
bb9efa59c6656f Sandeep Maheswaram               2021-07-06  3455  				phys = <&usb_2_hsphy>;
bb9efa59c6656f Sandeep Maheswaram               2021-07-06  3456  				phy-names = "usb2-phy";
bb9efa59c6656f Sandeep Maheswaram               2021-07-06  3457  				maximum-speed = "high-speed";
0b059979090d72 Souradeep Chowdhury              2022-04-06  3458  				usb-role-switch;
9ee402ccfeb163 Bhupesh Sharma                   2023-05-02  3459  
0b059979090d72 Souradeep Chowdhury              2022-04-06  3460  				port {
0b059979090d72 Souradeep Chowdhury              2022-04-06  3461  					usb2_role_switch: endpoint {
0b059979090d72 Souradeep Chowdhury              2022-04-06  3462  						remote-endpoint = <&eud_ep>;
0b059979090d72 Souradeep Chowdhury              2022-04-06  3463  					};
0b059979090d72 Souradeep Chowdhury              2022-04-06  3464  				};
bb9efa59c6656f Sandeep Maheswaram               2021-07-06  3465  			};
bb9efa59c6656f Sandeep Maheswaram               2021-07-06  3466  		};
bb9efa59c6656f Sandeep Maheswaram               2021-07-06  3467  
7720ea001b528d Roja Rani Yarubandi              2021-09-23  3468  		qspi: spi@88dc000 {
7720ea001b528d Roja Rani Yarubandi              2021-09-23  3469  			compatible = "qcom,sc7280-qspi", "qcom,qspi-v1";
7720ea001b528d Roja Rani Yarubandi              2021-09-23  3470  			reg = <0 0x088dc000 0 0x1000>;
cc406006126e89 Vijaya Krishna Nivarthi          2023-04-24  3471  			iommus = <&apps_smmu 0x20 0x0>;
7720ea001b528d Roja Rani Yarubandi              2021-09-23  3472  			#address-cells = <1>;
7720ea001b528d Roja Rani Yarubandi              2021-09-23  3473  			#size-cells = <0>;
7720ea001b528d Roja Rani Yarubandi              2021-09-23  3474  			interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
7720ea001b528d Roja Rani Yarubandi              2021-09-23  3475  			clocks = <&gcc GCC_QSPI_CNOC_PERIPH_AHB_CLK>,
7720ea001b528d Roja Rani Yarubandi              2021-09-23  3476  				 <&gcc GCC_QSPI_CORE_CLK>;
7720ea001b528d Roja Rani Yarubandi              2021-09-23  3477  			clock-names = "iface", "core";
7720ea001b528d Roja Rani Yarubandi              2021-09-23  3478  			interconnects = <&gem_noc MASTER_APPSS_PROC 0
7720ea001b528d Roja Rani Yarubandi              2021-09-23  3479  					&cnoc2 SLAVE_QSPI_0 0>;
7720ea001b528d Roja Rani Yarubandi              2021-09-23  3480  			interconnect-names = "qspi-config";
7720ea001b528d Roja Rani Yarubandi              2021-09-23  3481  			power-domains = <&rpmhpd SC7280_CX>;
7720ea001b528d Roja Rani Yarubandi              2021-09-23  3482  			operating-points-v2 = <&qspi_opp_table>;
7720ea001b528d Roja Rani Yarubandi              2021-09-23  3483  			status = "disabled";
7720ea001b528d Roja Rani Yarubandi              2021-09-23  3484  		};
7720ea001b528d Roja Rani Yarubandi              2021-09-23  3485  
476dce6e50bb21 Rakesh Pillai                    2022-03-28  3486  		remoteproc_wpss: remoteproc@8a00000 {
476dce6e50bb21 Rakesh Pillai                    2022-03-28  3487  			compatible = "qcom,sc7280-wpss-pil";
476dce6e50bb21 Rakesh Pillai                    2022-03-28  3488  			reg = <0 0x08a00000 0 0x10000>;
476dce6e50bb21 Rakesh Pillai                    2022-03-28  3489  
476dce6e50bb21 Rakesh Pillai                    2022-03-28  3490  			interrupts-extended = <&intc GIC_SPI 587 IRQ_TYPE_EDGE_RISING>,
476dce6e50bb21 Rakesh Pillai                    2022-03-28  3491  					      <&wpss_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
476dce6e50bb21 Rakesh Pillai                    2022-03-28  3492  					      <&wpss_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
476dce6e50bb21 Rakesh Pillai                    2022-03-28  3493  					      <&wpss_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
476dce6e50bb21 Rakesh Pillai                    2022-03-28  3494  					      <&wpss_smp2p_in 3 IRQ_TYPE_EDGE_RISING>,
476dce6e50bb21 Rakesh Pillai                    2022-03-28  3495  					      <&wpss_smp2p_in 7 IRQ_TYPE_EDGE_RISING>;
476dce6e50bb21 Rakesh Pillai                    2022-03-28  3496  			interrupt-names = "wdog", "fatal", "ready", "handover",
476dce6e50bb21 Rakesh Pillai                    2022-03-28  3497  					  "stop-ack", "shutdown-ack";
476dce6e50bb21 Rakesh Pillai                    2022-03-28  3498  
476dce6e50bb21 Rakesh Pillai                    2022-03-28  3499  			clocks = <&gcc GCC_WPSS_AHB_BDG_MST_CLK>,
476dce6e50bb21 Rakesh Pillai                    2022-03-28  3500  				 <&gcc GCC_WPSS_AHB_CLK>,
476dce6e50bb21 Rakesh Pillai                    2022-03-28  3501  				 <&gcc GCC_WPSS_RSCP_CLK>,
476dce6e50bb21 Rakesh Pillai                    2022-03-28  3502  				 <&rpmhcc RPMH_CXO_CLK>;
476dce6e50bb21 Rakesh Pillai                    2022-03-28  3503  			clock-names = "ahb_bdg", "ahb",
476dce6e50bb21 Rakesh Pillai                    2022-03-28  3504  				      "rscp", "xo";
476dce6e50bb21 Rakesh Pillai                    2022-03-28  3505  
476dce6e50bb21 Rakesh Pillai                    2022-03-28  3506  			power-domains = <&rpmhpd SC7280_CX>,
476dce6e50bb21 Rakesh Pillai                    2022-03-28  3507  					<&rpmhpd SC7280_MX>;
476dce6e50bb21 Rakesh Pillai                    2022-03-28  3508  			power-domain-names = "cx", "mx";
476dce6e50bb21 Rakesh Pillai                    2022-03-28  3509  
476dce6e50bb21 Rakesh Pillai                    2022-03-28  3510  			memory-region = <&wpss_mem>;
476dce6e50bb21 Rakesh Pillai                    2022-03-28  3511  
476dce6e50bb21 Rakesh Pillai                    2022-03-28  3512  			qcom,qmp = <&aoss_qmp>;
476dce6e50bb21 Rakesh Pillai                    2022-03-28  3513  
476dce6e50bb21 Rakesh Pillai                    2022-03-28  3514  			qcom,smem-states = <&wpss_smp2p_out 0>;
476dce6e50bb21 Rakesh Pillai                    2022-03-28  3515  			qcom,smem-state-names = "stop";
476dce6e50bb21 Rakesh Pillai                    2022-03-28  3516  
476dce6e50bb21 Rakesh Pillai                    2022-03-28  3517  			resets = <&aoss_reset AOSS_CC_WCSS_RESTART>,
476dce6e50bb21 Rakesh Pillai                    2022-03-28  3518  				 <&pdc_reset PDC_WPSS_SYNC_RESET>;
476dce6e50bb21 Rakesh Pillai                    2022-03-28  3519  			reset-names = "restart", "pdc_sync";
476dce6e50bb21 Rakesh Pillai                    2022-03-28  3520  
d9a2214d6ba5b6 Krzysztof Kozlowski              2022-08-19  3521  			qcom,halt-regs = <&tcsr_1 0x17000>;
476dce6e50bb21 Rakesh Pillai                    2022-03-28  3522  
476dce6e50bb21 Rakesh Pillai                    2022-03-28  3523  			status = "disabled";
476dce6e50bb21 Rakesh Pillai                    2022-03-28  3524  
476dce6e50bb21 Rakesh Pillai                    2022-03-28  3525  			glink-edge {
476dce6e50bb21 Rakesh Pillai                    2022-03-28  3526  				interrupts-extended = <&ipcc IPCC_CLIENT_WPSS
476dce6e50bb21 Rakesh Pillai                    2022-03-28  3527  							     IPCC_MPROC_SIGNAL_GLINK_QMP
476dce6e50bb21 Rakesh Pillai                    2022-03-28  3528  							     IRQ_TYPE_EDGE_RISING>;
476dce6e50bb21 Rakesh Pillai                    2022-03-28  3529  				mboxes = <&ipcc IPCC_CLIENT_WPSS
476dce6e50bb21 Rakesh Pillai                    2022-03-28  3530  						IPCC_MPROC_SIGNAL_GLINK_QMP>;
476dce6e50bb21 Rakesh Pillai                    2022-03-28  3531  
476dce6e50bb21 Rakesh Pillai                    2022-03-28  3532  				label = "wpss";
476dce6e50bb21 Rakesh Pillai                    2022-03-28  3533  				qcom,remote-pid = <13>;
476dce6e50bb21 Rakesh Pillai                    2022-03-28  3534  			};
476dce6e50bb21 Rakesh Pillai                    2022-03-28  3535  		};
476dce6e50bb21 Rakesh Pillai                    2022-03-28  3536  
b2f3eac1b77c6f Rajendra Nayak                   2022-09-02  3537  		pmu@9091000 {
b2f3eac1b77c6f Rajendra Nayak                   2022-09-02  3538  			compatible = "qcom,sc7280-llcc-bwmon";
94ca994d7e932c Konrad Dybcio                    2023-01-02  3539  			reg = <0 0x09091000 0 0x1000>;
b2f3eac1b77c6f Rajendra Nayak                   2022-09-02  3540  
b2f3eac1b77c6f Rajendra Nayak                   2022-09-02  3541  			interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
b2f3eac1b77c6f Rajendra Nayak                   2022-09-02  3542  
b2f3eac1b77c6f Rajendra Nayak                   2022-09-02  3543  			interconnects = <&mc_virt MASTER_LLCC 3 &mc_virt SLAVE_EBI1 3>;
b2f3eac1b77c6f Rajendra Nayak                   2022-09-02  3544  
b2f3eac1b77c6f Rajendra Nayak                   2022-09-02  3545  			operating-points-v2 = <&llcc_bwmon_opp_table>;
b2f3eac1b77c6f Rajendra Nayak                   2022-09-02  3546  
b2f3eac1b77c6f Rajendra Nayak                   2022-09-02  3547  			llcc_bwmon_opp_table: opp-table {
b2f3eac1b77c6f Rajendra Nayak                   2022-09-02  3548  				compatible = "operating-points-v2";
b2f3eac1b77c6f Rajendra Nayak                   2022-09-02  3549  
b2f3eac1b77c6f Rajendra Nayak                   2022-09-02  3550  				opp-0 {
b2f3eac1b77c6f Rajendra Nayak                   2022-09-02  3551  					opp-peak-kBps = <800000>;
b2f3eac1b77c6f Rajendra Nayak                   2022-09-02  3552  				};
b2f3eac1b77c6f Rajendra Nayak                   2022-09-02  3553  				opp-1 {
b2f3eac1b77c6f Rajendra Nayak                   2022-09-02  3554  					opp-peak-kBps = <1804000>;
b2f3eac1b77c6f Rajendra Nayak                   2022-09-02  3555  				};
b2f3eac1b77c6f Rajendra Nayak                   2022-09-02  3556  				opp-2 {
b2f3eac1b77c6f Rajendra Nayak                   2022-09-02  3557  					opp-peak-kBps = <2188000>;
b2f3eac1b77c6f Rajendra Nayak                   2022-09-02  3558  				};
b2f3eac1b77c6f Rajendra Nayak                   2022-09-02  3559  				opp-3 {
b2f3eac1b77c6f Rajendra Nayak                   2022-09-02  3560  					opp-peak-kBps = <3072000>;
b2f3eac1b77c6f Rajendra Nayak                   2022-09-02  3561  				};
b2f3eac1b77c6f Rajendra Nayak                   2022-09-02  3562  				opp-4 {
b2f3eac1b77c6f Rajendra Nayak                   2022-09-02  3563  					opp-peak-kBps = <4068000>;
b2f3eac1b77c6f Rajendra Nayak                   2022-09-02  3564  				};
b2f3eac1b77c6f Rajendra Nayak                   2022-09-02  3565  				opp-5 {
b2f3eac1b77c6f Rajendra Nayak                   2022-09-02  3566  					opp-peak-kBps = <6220000>;
b2f3eac1b77c6f Rajendra Nayak                   2022-09-02  3567  				};
b2f3eac1b77c6f Rajendra Nayak                   2022-09-02  3568  				opp-6 {
b2f3eac1b77c6f Rajendra Nayak                   2022-09-02  3569  					opp-peak-kBps = <6832000>;
b2f3eac1b77c6f Rajendra Nayak                   2022-09-02  3570  				};
b2f3eac1b77c6f Rajendra Nayak                   2022-09-02  3571  				opp-7 {
b2f3eac1b77c6f Rajendra Nayak                   2022-09-02  3572  					opp-peak-kBps = <8532000>;
b2f3eac1b77c6f Rajendra Nayak                   2022-09-02  3573  				};
b2f3eac1b77c6f Rajendra Nayak                   2022-09-02  3574  			};
b2f3eac1b77c6f Rajendra Nayak                   2022-09-02  3575  		};
b2f3eac1b77c6f Rajendra Nayak                   2022-09-02  3576  
b626ac159e5e2c Krzysztof Kozlowski              2022-09-08  3577  		pmu@90b6400 {
bad26511c4cb54 Konrad Dybcio                    2023-03-15  3578  			compatible = "qcom,sc7280-cpu-bwmon", "qcom,sdm845-bwmon";
b2f3eac1b77c6f Rajendra Nayak                   2022-09-02  3579  			reg = <0 0x090b6400 0 0x600>;
b2f3eac1b77c6f Rajendra Nayak                   2022-09-02  3580  
b2f3eac1b77c6f Rajendra Nayak                   2022-09-02  3581  			interrupts = <GIC_SPI 581 IRQ_TYPE_LEVEL_HIGH>;
b2f3eac1b77c6f Rajendra Nayak                   2022-09-02  3582  
b2f3eac1b77c6f Rajendra Nayak                   2022-09-02  3583  			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &gem_noc SLAVE_LLCC 3>;
b2f3eac1b77c6f Rajendra Nayak                   2022-09-02  3584  			operating-points-v2 = <&cpu_bwmon_opp_table>;
b2f3eac1b77c6f Rajendra Nayak                   2022-09-02  3585  
b2f3eac1b77c6f Rajendra Nayak                   2022-09-02  3586  			cpu_bwmon_opp_table: opp-table {
b2f3eac1b77c6f Rajendra Nayak                   2022-09-02  3587  				compatible = "operating-points-v2";
b2f3eac1b77c6f Rajendra Nayak                   2022-09-02  3588  
b2f3eac1b77c6f Rajendra Nayak                   2022-09-02  3589  				opp-0 {
b2f3eac1b77c6f Rajendra Nayak                   2022-09-02  3590  					opp-peak-kBps = <2400000>;
b2f3eac1b77c6f Rajendra Nayak                   2022-09-02  3591  				};
b2f3eac1b77c6f Rajendra Nayak                   2022-09-02  3592  				opp-1 {
b2f3eac1b77c6f Rajendra Nayak                   2022-09-02  3593  					opp-peak-kBps = <4800000>;
b2f3eac1b77c6f Rajendra Nayak                   2022-09-02  3594  				};
b2f3eac1b77c6f Rajendra Nayak                   2022-09-02  3595  				opp-2 {
b2f3eac1b77c6f Rajendra Nayak                   2022-09-02  3596  					opp-peak-kBps = <7456000>;
b2f3eac1b77c6f Rajendra Nayak                   2022-09-02  3597  				};
b2f3eac1b77c6f Rajendra Nayak                   2022-09-02  3598  				opp-3 {
b2f3eac1b77c6f Rajendra Nayak                   2022-09-02  3599  					opp-peak-kBps = <9600000>;
b2f3eac1b77c6f Rajendra Nayak                   2022-09-02  3600  				};
b2f3eac1b77c6f Rajendra Nayak                   2022-09-02  3601  				opp-4 {
b2f3eac1b77c6f Rajendra Nayak                   2022-09-02  3602  					opp-peak-kBps = <12896000>;
b2f3eac1b77c6f Rajendra Nayak                   2022-09-02  3603  				};
b2f3eac1b77c6f Rajendra Nayak                   2022-09-02  3604  				opp-5 {
b2f3eac1b77c6f Rajendra Nayak                   2022-09-02  3605  					opp-peak-kBps = <14928000>;
b2f3eac1b77c6f Rajendra Nayak                   2022-09-02  3606  				};
b2f3eac1b77c6f Rajendra Nayak                   2022-09-02  3607  				opp-6 {
b2f3eac1b77c6f Rajendra Nayak                   2022-09-02  3608  					opp-peak-kBps = <17056000>;
b2f3eac1b77c6f Rajendra Nayak                   2022-09-02  3609  				};
b2f3eac1b77c6f Rajendra Nayak                   2022-09-02  3610  			};
b2f3eac1b77c6f Rajendra Nayak                   2022-09-02  3611  		};
b2f3eac1b77c6f Rajendra Nayak                   2022-09-02  3612  
297e6e38320f32 Odelu Kukatla                    2021-04-27  3613  		dc_noc: interconnect@90e0000 {
297e6e38320f32 Odelu Kukatla                    2021-04-27  3614  			reg = <0 0x090e0000 0 0x5080>;
297e6e38320f32 Odelu Kukatla                    2021-04-27  3615  			compatible = "qcom,sc7280-dc-noc";
297e6e38320f32 Odelu Kukatla                    2021-04-27  3616  			#interconnect-cells = <2>;
297e6e38320f32 Odelu Kukatla                    2021-04-27  3617  			qcom,bcm-voters = <&apps_bcm_voter>;
297e6e38320f32 Odelu Kukatla                    2021-04-27  3618  		};
297e6e38320f32 Odelu Kukatla                    2021-04-27  3619  
297e6e38320f32 Odelu Kukatla                    2021-04-27  3620  		gem_noc: interconnect@9100000 {
94ca994d7e932c Konrad Dybcio                    2023-01-02  3621  			reg = <0 0x09100000 0 0xe2200>;
297e6e38320f32 Odelu Kukatla                    2021-04-27  3622  			compatible = "qcom,sc7280-gem-noc";
297e6e38320f32 Odelu Kukatla                    2021-04-27  3623  			#interconnect-cells = <2>;
297e6e38320f32 Odelu Kukatla                    2021-04-27  3624  			qcom,bcm-voters = <&apps_bcm_voter>;
297e6e38320f32 Odelu Kukatla                    2021-04-27  3625  		};
297e6e38320f32 Odelu Kukatla                    2021-04-27  3626  
0392968dbe099d Sai Prakash Ranjan               2021-03-16  3627  		system-cache-controller@9200000 {
0392968dbe099d Sai Prakash Ranjan               2021-03-16  3628  			compatible = "qcom,sc7280-llcc";
62e5ee9db98ed6 Manivannan Sadhasivam            2023-03-14  3629  			reg = <0 0x09200000 0 0x58000>, <0 0x09280000 0 0x58000>,
62e5ee9db98ed6 Manivannan Sadhasivam            2023-03-14  3630  			      <0 0x09600000 0 0x58000>;
62e5ee9db98ed6 Manivannan Sadhasivam            2023-03-14  3631  			reg-names = "llcc0_base", "llcc1_base", "llcc_broadcast_base";
0392968dbe099d Sai Prakash Ranjan               2021-03-16  3632  			interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
0392968dbe099d Sai Prakash Ranjan               2021-03-16  3633  		};
0392968dbe099d Sai Prakash Ranjan               2021-03-16  3634  
0b059979090d72 Souradeep Chowdhury              2022-04-06  3635  		eud: eud@88e0000 {
0b059979090d72 Souradeep Chowdhury              2022-04-06  3636  			compatible = "qcom,sc7280-eud", "qcom,eud";
9ee402ccfeb163 Bhupesh Sharma                   2023-05-02  3637  			reg = <0 0x88e0000 0 0x2000>,
9ee402ccfeb163 Bhupesh Sharma                   2023-05-02  3638  			      <0 0x88e2000 0 0x1000>;
0b059979090d72 Souradeep Chowdhury              2022-04-06  3639  			interrupts-extended = <&pdc 11 IRQ_TYPE_LEVEL_HIGH>;
9ee402ccfeb163 Bhupesh Sharma                   2023-05-02  3640  
39c8af78cbefb8 Krzysztof Kozlowski              2023-08-20  3641  			status = "disabled";
39c8af78cbefb8 Krzysztof Kozlowski              2023-08-20  3642  
0b059979090d72 Souradeep Chowdhury              2022-04-06 @3643  			ports {

:::::: The code at line 3643 was first introduced by commit
:::::: 0b059979090d72b3e8eca1cb18daa8da70400211 arm64: dts: qcom: sc7280: Add EUD dt node and dwc3 connector

:::::: TO: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

