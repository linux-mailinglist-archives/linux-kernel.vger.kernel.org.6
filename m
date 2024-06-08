Return-Path: <linux-kernel+bounces-207036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37344901180
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 14:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60568B2178D
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 12:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F94A178365;
	Sat,  8 Jun 2024 12:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hFxQwKLG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B02354670;
	Sat,  8 Jun 2024 12:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717850925; cv=none; b=X1VboFRa5rPbtl+8R91L29kfpTUF0M8aCocpWAhlaQivhP20VvP+ti6AlAK4/5WDnLjzaF5DM6eveRM4DghCUfkVCXIFyXbM4lSZZsokcUeZvBC0v1xDF8FxDzosR3SXvWIY/7ZsalfYgDhLxLOd71nPsAu436wERM7n+5+7K+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717850925; c=relaxed/simple;
	bh=0uhVK2EDPWadg2sGtuaFhDUBT8Bj6aEIPf+2ui1CAww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=evo3IoQr3Qyn/Mza5mbMZwLcF/Bt5udkUpqUZgFrdVYZ71I19dYguXRghZNz/Vr0Vwsj2kzyolLykMfg83Mx51dtkjQ8i2ij1dtyXxaAfvmrj/JPXr1QpjmI/Vac0QBttMrhKA3EIByx/7qhNGN+CcjBbpZe4gkrOp8pBpOSLKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hFxQwKLG; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717850924; x=1749386924;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0uhVK2EDPWadg2sGtuaFhDUBT8Bj6aEIPf+2ui1CAww=;
  b=hFxQwKLGqrakMYjGCvAmcRAzAbpOxphDfYpX5bjZQZNl1UBiV01np95V
   8ua6sgizIm+a2tsH2yCj/eaxPa4limLJP5B2FkSalFCX7+RaWGl4ewbCv
   5PUtLpt9/Ywe7MH/r/Mw74SVjQrSSnLCEVC8T16WttEX4dwXpMLNYQWSJ
   obKUSrWO33asQHxB+l5c87RNjhPTzuyRmApgVdMvsF8IOw+olyRj63S39
   7D8FEOqGZbpAR9MR3TA/izYesMESErjuf9O47hC8Db8YWOOneQhVvQ91/
   WLMsKFDNs49LrjtJAehKmRMfZA1eUpE2hEY0No/U1CcbHcDPLJHVjOU2N
   A==;
X-CSE-ConnectionGUID: cItk/jJwQgqeKwV/PKTrRA==
X-CSE-MsgGUID: sGK6CpaOTaekgcAXwCh4gA==
X-IronPort-AV: E=McAfee;i="6600,9927,11096"; a="14522924"
X-IronPort-AV: E=Sophos;i="6.08,223,1712646000"; 
   d="scan'208";a="14522924"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2024 05:48:43 -0700
X-CSE-ConnectionGUID: sMv28rYnSumtbuouiucdDw==
X-CSE-MsgGUID: j0UkYyPzQa6XDrMOEKBWbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,223,1712646000"; 
   d="scan'208";a="38669003"
Received: from lkp-server01.sh.intel.com (HELO 472b94a103a1) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 08 Jun 2024 05:48:40 -0700
Received: from kbuild by 472b94a103a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sFvUr-0001aW-1Y;
	Sat, 08 Jun 2024 12:48:37 +0000
Date: Sat, 8 Jun 2024 20:48:28 +0800
From: kernel test robot <lkp@intel.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, shawnguo@kernel.org,
	s.hauer@pengutronix.de
Cc: oe-kbuild-all@lists.linux.dev, kernel@pengutronix.de,
	festevam@gmail.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 2/2] arm64: dts: freescale: Support i.MX93 9x9 Quick
 Start Board
Message-ID: <202406082200.sVJmF5id-lkp@intel.com>
References: <20240605094812.1074027-2-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605094812.1074027-2-peng.fan@oss.nxp.com>

Hi Peng,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linus/master v6.10-rc2 next-20240607]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Peng-Fan-OSS/arm64-dts-freescale-Support-i-MX93-9x9-Quick-Start-Board/20240605-174602
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20240605094812.1074027-2-peng.fan%40oss.nxp.com
patch subject: [PATCH 2/2] arm64: dts: freescale: Support i.MX93 9x9 Quick Start Board
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240608/202406082200.sVJmF5id-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406082200.sVJmF5id-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
>> arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts:160.10-171.6: Warning (graph_child_address): /soc@0/bus@44000000/i2c@44340000/tcpc@50/connector/ports: graph node has single child node 'port@0', #address-cells/#size-cells are not necessary

vim +160 arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts

   132	
   133	&lpi2c1 {
   134		#address-cells = <1>;
   135		#size-cells = <0>;
   136		clock-frequency = <400000>;
   137		pinctrl-names = "default";
   138		pinctrl-0 = <&pinctrl_lpi2c1>;
   139		status = "okay";
   140	
   141		ptn5110: tcpc@50 {
   142			compatible = "nxp,ptn5110", "tcpci";
   143			reg = <0x50>;
   144			interrupt-parent = <&gpio3>;
   145			interrupts = <26 IRQ_TYPE_LEVEL_LOW>;
   146			status = "okay";
   147	
   148			typec1_con: connector {
   149				compatible = "usb-c-connector";
   150				label = "USB-C";
   151				power-role = "dual";
   152				data-role = "dual";
   153				try-power-role = "sink";
   154				source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
   155				sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
   156					     PDO_VAR(5000, 20000, 3000)>;
   157				op-sink-microwatt = <15000000>;
   158				self-powered;
   159	
 > 160				ports {
   161					#address-cells = <1>;
   162					#size-cells = <0>;
   163	
   164					port@0 {
   165						reg = <0>;
   166	
   167						typec1_dr_sw: endpoint {
   168							remote-endpoint = <&usb1_drd_sw>;
   169						};
   170					};
   171				};
   172			};
   173		};
   174	
   175		rtc@53 {
   176			compatible = "nxp,pcf2131";
   177			reg = <0x53>;
   178			interrupt-parent = <&pcal6524>;
   179			interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
   180			status = "okay";
   181		};
   182	};
   183	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

