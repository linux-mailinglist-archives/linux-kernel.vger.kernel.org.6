Return-Path: <linux-kernel+bounces-220501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F21690E295
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 07:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBE1E1C21BA3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 05:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10DD75466B;
	Wed, 19 Jun 2024 05:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fx1zwz01"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C82428EC
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 05:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718774148; cv=none; b=EY8PGyWrQ1zpVjx7N/XtSF4b8BuSH7NfmDwNWKo/GdbhrtoA05FKAVjg8u8TslJZix8Q3a6zdOClpaQvp5giUW1WQH3ZRVhyy/5dUhtuAxXbOhDS3eOwfUyTbV62k+JSIomwmkgd2fqbz5eUUkfSXiFX8lFyHiZxIIpjbyyL+Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718774148; c=relaxed/simple;
	bh=TL1LD2iCTY2phX4axZb2rSAcIuxvrdQ6F7zmXGItjHE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=W96N82+FAnxRFSoUHOfBS4JSORAsErhj3AkCeB+LodtHja3lBLct6MxvjBbTpxxjbYMBrwlCsC00XEhvntozXg9nRQMzGmO+hptibERF93Tz4ELbnMjhCDBV1hpNsETP2TV1p6obvMtRQfGNUecWuIA1ZtXbP/83cj9h14rnVeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fx1zwz01; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718774145; x=1750310145;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TL1LD2iCTY2phX4axZb2rSAcIuxvrdQ6F7zmXGItjHE=;
  b=Fx1zwz01h6LeLeHeLXVX4k2div8tVZbUSWZyWhOk6M/h67fCFy8zqy08
   SWPYE8/MKB/TaA7H/8uNuOG0ZrrJlqqtFfkgBuTiKUBb4TnpPWKgKSdqO
   jVhUoH6tzaOU0cpopfNmtsEQ8r4LogORcLsAxlzf2Kgv2lxBJTDOvQCdz
   HUTpgsOFolM8NjSdvo/808cbjLyYVJAOBULxguvNySfP0dA1T6lxD/o3I
   GYdzadmiPRRx1PJn4we9dzOuXAIQNJ3yQam7DhLtnqkCbub3+cdxMHhaZ
   syucTDctXC4oGeGluvQj/yCuSM/tZn4v4SN5d12q6eYk7CeL7r/0qSNMO
   Q==;
X-CSE-ConnectionGUID: b4L9cIXmSlmFbG8P9hDVdA==
X-CSE-MsgGUID: wJEBKGbKStGMrly149kWag==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="19563865"
X-IronPort-AV: E=Sophos;i="6.08,249,1712646000"; 
   d="scan'208";a="19563865"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 22:15:44 -0700
X-CSE-ConnectionGUID: +NIkGp8LQR2PpvdyxUNVGg==
X-CSE-MsgGUID: w+e0CqctSNu7OyoRcudklQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,249,1712646000"; 
   d="scan'208";a="72536611"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 18 Jun 2024 22:15:42 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sJnfY-0006JO-2G;
	Wed, 19 Jun 2024 05:15:40 +0000
Date: Wed, 19 Jun 2024 13:15:29 +0800
From: kernel test robot <lkp@intel.com>
To: =?iso-8859-1?Q?Andr=E9?= Apitzsch <git@apitzsch.eu>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: arch/arm64/boot/dts/qcom/msm8939-longcheer-l9100.dts:127.20-161.4:
 Warning (avoid_unnecessary_addr_size): /soc@0/i2c@78b6000/led-controller@30:
 unnecessary #address-cells/#size-cells without "ranges" or child "reg"
 property
Message-ID: <202406191339.vptigQww-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   92e5605a199efbaee59fb19e15d6cc2103a04ec2
commit: a21796c631734ea5cf62507e63a2479261880514 arm64: dts: qcom: msm8939-longcheer-l9100: Enable RGB LED
date:   8 months ago
config: arm64-randconfig-r113-20240606 (https://download.01.org/0day-ci/archive/20240619/202406191339.vptigQww-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project d7d2d4f53fc79b4b58e8d8d08151b577c3699d4a)
reproduce: (https://download.01.org/0day-ci/archive/20240619/202406191339.vptigQww-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406191339.vptigQww-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
   arch/arm64/boot/dts/qcom/msm8939.dtsi:1284.27-1333.6: Warning (avoid_unnecessary_addr_size): /soc@0/display-subsystem@1a00000/dsi@1a98000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
>> arch/arm64/boot/dts/qcom/msm8939-longcheer-l9100.dts:127.20-161.4: Warning (avoid_unnecessary_addr_size): /soc@0/i2c@78b6000/led-controller@30: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
   arch/arm64/boot/dts/qcom/msm8939.dtsi:496.26-499.6: Warning (unique_unit_address_if_enabled): /soc@0/qfprom@5c000/s6-p1@a1: duplicate unit-address (also used in node /soc@0/qfprom@5c000/s6-p2@a1)
   arch/arm64/boot/dts/qcom/msm8939.dtsi:516.26-519.6: Warning (unique_unit_address_if_enabled): /soc@0/qfprom@5c000/s8-p1@a4: duplicate unit-address (also used in node /soc@0/qfprom@5c000/s8-p2@a4)
   arch/arm64/boot/dts/qcom/msm8939.dtsi:541.24-544.6: Warning (unique_unit_address_if_enabled): /soc@0/qfprom@5c000/mode@d0: duplicate unit-address (also used in node /soc@0/qfprom@5c000/s0-p1@d0)
   arch/arm64/boot/dts/qcom/msm8939.dtsi:551.26-554.6: Warning (unique_unit_address_if_enabled): /soc@0/qfprom@5c000/s0-p1@d1: duplicate unit-address (also used in node /soc@0/qfprom@5c000/s1-p1@d1)
   arch/arm64/boot/dts/qcom/msm8939.dtsi:571.26-574.6: Warning (unique_unit_address_if_enabled): /soc@0/qfprom@5c000/s2-p2@d4: duplicate unit-address (also used in node /soc@0/qfprom@5c000/s3-p1@d4)

vim +127 arch/arm64/boot/dts/qcom/msm8939-longcheer-l9100.dts

   123	
   124	&blsp_i2c2 {
   125		status = "okay";
   126	
 > 127		led-controller@30 {
   128			compatible = "kinetic,ktd2026";
   129			reg = <0x30>;
   130			#address-cells = <1>;
   131			#size-cells = <0>;
   132	
   133			vin-supply = <&pm8916_l17>;
   134			vio-supply = <&pm8916_l6>;
   135	
   136			pinctrl-0 = <&status_led_default>;
   137			pinctrl-names = "default";
   138	
   139			multi-led {
   140				color = <LED_COLOR_ID_RGB>;
   141				function = LED_FUNCTION_STATUS;
   142	
   143				#address-cells = <1>;
   144				#size-cells = <0>;
   145	
   146				led@0 {
   147					reg = <0>;
   148					color = <LED_COLOR_ID_RED>;
   149				};
   150	
   151				led@1 {
   152					reg = <1>;
   153					color = <LED_COLOR_ID_GREEN>;
   154				};
   155	
   156				led@2 {
   157					reg = <2>;
   158					color = <LED_COLOR_ID_BLUE>;
   159				};
   160			};
   161		};
   162	};
   163	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

