Return-Path: <linux-kernel+bounces-205755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA848FFFD5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 11:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80F0F282E4D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 09:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD4B15CD60;
	Fri,  7 Jun 2024 09:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JNywxByP"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D1415B122;
	Fri,  7 Jun 2024 09:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717753492; cv=none; b=aKDTWULNlmeGBGWqE72uRHQHIaXF3SilPQLom39KapIrok+hPm3nIR0FDYFkGMJpMzRqvBLxmk3Oc5UI71qzrND7KfXNDWu4Dhzn4rxFPqojV/B60hadq4JLmdQXLY9Uh9YrNnwwanTxwfv6KilysIyCBqQlVBG5HLjXd2uEwtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717753492; c=relaxed/simple;
	bh=voo+058tPlgVMfI1TZTTzr4t/Aowjlk+5Zt2NGckp00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IfMjVSa/vt/HlW1ITPt5qMZlw5/iW9MDMGs2wjxGkd14V+4EO+8XAxTGfrzaIN4bfljqX10bVKFl+Cht4mLY6ccg4iyVCnygX9LPQALObGPDmMgOOsHEB8e8sejnMd3w42tVGlh1/uTda9HklZLkVbESRmLSUhS4DeO2tk9HL0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JNywxByP; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717753491; x=1749289491;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=voo+058tPlgVMfI1TZTTzr4t/Aowjlk+5Zt2NGckp00=;
  b=JNywxByP4NAkGVT66WtDTTWqBF4HYp+lLsKCYfL+AxghellOSM+iYQd3
   lZUZG0gFC8p48MevClOXH9JQbz/LMVyLL05krRysXFNtlaVp1MZIcWT74
   63f2xDfZitAi1EUQyK/9bsgO1mTCf002HBEqqWXB7S3/+te5z39f4j3f0
   rSxNGOKOh0j5yHyxvipBI2LJS5TLc1FUBua/1gGlqsroLBkPaaWxlj9LF
   IXZXGSsLwplRpP5cA+g/8g5Kjj5Gt7ltMa+Z3Wfb9W2ASc0DckQb+b9Up
   Axe+BbhWeI8Eun38H/TnI3+u9VPMebtSWiG8HWptBzEisGk3x8/xYAzDb
   A==;
X-CSE-ConnectionGUID: tfdbHHTtSCSef3/i0ayuig==
X-CSE-MsgGUID: A2QAH5TvRbGz9Y89VhfbOA==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="18294757"
X-IronPort-AV: E=Sophos;i="6.08,220,1712646000"; 
   d="scan'208";a="18294757"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 02:44:50 -0700
X-CSE-ConnectionGUID: 8ZQlJrjIRZii1uvJWoEVGA==
X-CSE-MsgGUID: UsrlsgBJRDKUnLDBbEx3qA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,220,1712646000"; 
   d="scan'208";a="61472308"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 07 Jun 2024 02:44:47 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sFW9M-0004Z5-1b;
	Fri, 07 Jun 2024 09:44:44 +0000
Date: Fri, 7 Jun 2024 17:44:36 +0800
From: kernel test robot <lkp@intel.com>
To: "Rob Herring (Arm)" <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm: dts: aspeed: Use standard 'i2c' bus node name
Message-ID: <202406071717.2B7aM49z-lkp@intel.com>
References: <20240531193115.3814887-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531193115.3814887-1-robh@kernel.org>

Hi Rob,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on krzk/for-next linus/master v6.10-rc2 next-20240607]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Rob-Herring-Arm/arm-dts-aspeed-Use-standard-i2c-bus-node-name/20240601-033514
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20240531193115.3814887-1-robh%40kernel.org
patch subject: [PATCH] arm: dts: aspeed: Use standard 'i2c' bus node name
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240607/202406071717.2B7aM49z-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406071717.2B7aM49z-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
>> arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts:541.10-555.4: Warning (avoid_unnecessary_addr_size): /ahb/apb/bus@1e78a000/i2c@480/gpio@77: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property

vim +541 arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts

36d96827f480e9 arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts        Quan Nguyen  2022-08-17  532  
695cb117ac2a36 arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts        Chanh Nguyen 2023-02-28  533  &i2c8 {
695cb117ac2a36 arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts        Chanh Nguyen 2023-02-28  534  	status = "okay";
695cb117ac2a36 arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts        Chanh Nguyen 2023-02-28  535  
e998856086a41d arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts Chanh Nguyen 2023-10-05  536  	temperature-sensor@48 {
e998856086a41d arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts Chanh Nguyen 2023-10-05  537  		compatible = "ti,tmp112";
e998856086a41d arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts Chanh Nguyen 2023-10-05  538  		reg = <0x48>;
e998856086a41d arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts Chanh Nguyen 2023-10-05  539  	};
e998856086a41d arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts Chanh Nguyen 2023-10-05  540  
695cb117ac2a36 arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts        Chanh Nguyen 2023-02-28 @541  	gpio@77 {
695cb117ac2a36 arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts        Chanh Nguyen 2023-02-28  542  		compatible = "nxp,pca9539";
695cb117ac2a36 arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts        Chanh Nguyen 2023-02-28  543  		reg = <0x77>;
695cb117ac2a36 arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts        Chanh Nguyen 2023-02-28  544  		gpio-controller;
695cb117ac2a36 arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts        Chanh Nguyen 2023-02-28  545  		#address-cells = <1>;
695cb117ac2a36 arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts        Chanh Nguyen 2023-02-28  546  		#size-cells = <0>;
695cb117ac2a36 arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts        Chanh Nguyen 2023-02-28  547  		#gpio-cells = <2>;
695cb117ac2a36 arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts        Chanh Nguyen 2023-02-28  548  
695cb117ac2a36 arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts        Chanh Nguyen 2023-02-28  549  		bmc-ocp0-en-hog {
695cb117ac2a36 arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts        Chanh Nguyen 2023-02-28  550  			gpio-hog;
695cb117ac2a36 arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts        Chanh Nguyen 2023-02-28  551  			gpios = <7 GPIO_ACTIVE_LOW>;
695cb117ac2a36 arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts        Chanh Nguyen 2023-02-28  552  			output-high;
695cb117ac2a36 arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts        Chanh Nguyen 2023-02-28  553  			line-name = "bmc-ocp0-en-n";
695cb117ac2a36 arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts        Chanh Nguyen 2023-02-28  554  		};
695cb117ac2a36 arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts        Chanh Nguyen 2023-02-28  555  	};
695cb117ac2a36 arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts        Chanh Nguyen 2023-02-28  556  };
695cb117ac2a36 arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts        Chanh Nguyen 2023-02-28  557  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

