Return-Path: <linux-kernel+bounces-219760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB3C90D770
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 17:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 224C11C219E5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 15:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3541941A94;
	Tue, 18 Jun 2024 15:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kgUnDNoD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9E44A35
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 15:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718724965; cv=none; b=UdFuCEafG5nLc2CRVoNtn84mvtkd1QY/3i4fLIUbz4J2jS5eDKOiSfsAct0CqYl85DS9Q00paMWq1XwgoQmPheS0YblP4uv7L6YDfI9HycLDGLgDNS80FBDlKQVO3XExd22jtkcQ7TQdPOl8+AuiIhZWX6vbFJHu29PUkzj7LpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718724965; c=relaxed/simple;
	bh=9xitzs2XP+tmm+IuN0TS9nByjEfgmdiyBA9RBD7PxMc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=epk2yogTOMPJwLyBZoJkjjq8oxDa0Csr8eTI4G7ruZbje326qFOQaV2W7g0vTTw+S3MfYblUFY/N7+gWvACU3ocUKwKixqWk+kaS8b8vvELl9Ac0geiTiJif5ThX1Kl58y1B4i8vanRb4iBMLJ02JrUo2rrsJHJl6Hw0gyachl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kgUnDNoD; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718724963; x=1750260963;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9xitzs2XP+tmm+IuN0TS9nByjEfgmdiyBA9RBD7PxMc=;
  b=kgUnDNoDiaJm/QfyTCxDiChQqCtUGs8BIvG5ayckcMqOZxMYHlThj+fx
   wost3JBsJyCc9H3oHS3ZamIX3X/iwjjZQHRQg/V9aXHpmzOovvoghd1N9
   uzq9it3C5RB9ePmN/rITtTrLlXPhGXTF6aPsJxec5Prw1y1YAjFIoLliI
   5xJlPNZ2yi2HT45vZxA7GOE/nnZEa725fn31xNxppNRmW1xdRU5sUfB2K
   oCA7waGmvFhNc/zE1/3ZMTywAobOcWRqJ/JNiAdbu64QK7UsT0dybR8Sb
   xSHkZogJd9oZId0PcDxlfKsg8MlJ8NevfuCxtzr/8o1YY5sUQqLMCcWvU
   g==;
X-CSE-ConnectionGUID: 2FsjdG9UT0qcw3ZiwVbKag==
X-CSE-MsgGUID: lybRxsUSSTWK4pnkosA1KA==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="26196616"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="26196616"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 08:36:00 -0700
X-CSE-ConnectionGUID: 3+P37hqnRW+JgIqDhHMpNA==
X-CSE-MsgGUID: 1nGun8BAQ8erbKUipAGrYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="41460722"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 18 Jun 2024 08:35:59 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sJasG-0005dd-24;
	Tue, 18 Jun 2024 15:35:56 +0000
Date: Tue, 18 Jun 2024 23:35:16 +0800
From: kernel test robot <lkp@intel.com>
To: =?iso-8859-1?Q?Andr=E9?= Apitzsch <git@apitzsch.eu>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts:93.20-127.4:
 Warning (avoid_unnecessary_addr_size): /soc@0/i2c@78b6000/led-controller@30:
 unnecessary #address-cells/#size-cells without "ranges" or child "reg"
 property
Message-ID: <202406182328.xfDfqYOF-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3d54351c64e8f9794e8838196036a2de3d752fce
commit: 5017b8cdb7ebeb32d7f12a05b34d58662e137dbe arm64: dts: qcom: msm8916-longcheer-l8910: Enable RGB LED
date:   8 months ago
config: arm64-randconfig-r113-20240606 (https://download.01.org/0day-ci/archive/20240618/202406182328.xfDfqYOF-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project d7d2d4f53fc79b4b58e8d8d08151b577c3699d4a)
reproduce: (https://download.01.org/0day-ci/archive/20240618/202406182328.xfDfqYOF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406182328.xfDfqYOF-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
   arch/arm64/boot/dts/qcom/msm8916.dtsi:1592.27-1640.6: Warning (avoid_unnecessary_addr_size): /soc@0/display-subsystem@1a00000/dsi@1a98000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
>> arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts:93.20-127.4: Warning (avoid_unnecessary_addr_size): /soc@0/i2c@78b6000/led-controller@30: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
   arch/arm64/boot/dts/qcom/msm8916.dtsi:463.26-466.6: Warning (unique_unit_address_if_enabled): /soc@0/qfprom@5c000/base1@d0: duplicate unit-address (also used in node /soc@0/qfprom@5c000/s0-p1@d0)
   arch/arm64/boot/dts/qcom/msm8916.dtsi:478.26-481.6: Warning (unique_unit_address_if_enabled): /soc@0/qfprom@5c000/s1-p1@d2: duplicate unit-address (also used in node /soc@0/qfprom@5c000/s1-p2@d2)
   arch/arm64/boot/dts/qcom/msm8916.dtsi:491.26-494.6: Warning (unique_unit_address_if_enabled): /soc@0/qfprom@5c000/s2-p2@d4: duplicate unit-address (also used in node /soc@0/qfprom@5c000/s4-p1@d4)
   arch/arm64/boot/dts/qcom/msm8916.dtsi:503.26-506.6: Warning (unique_unit_address_if_enabled): /soc@0/qfprom@5c000/s4-p2@d5: duplicate unit-address (also used in node /soc@0/qfprom@5c000/s5-p1@d5)
   arch/arm64/boot/dts/qcom/msm8916.dtsi:1579.11-1589.7: Warning (graph_child_address): /soc@0/display-subsystem@1a00000/display-controller@1a01000/ports: graph node has single child node 'port@0', #address-cells/#size-cells are not necessary

vim +93 arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts

    89	
    90	&blsp_i2c2 {
    91		status = "okay";
    92	
  > 93		led-controller@30 {
    94			compatible = "kinetic,ktd2026";
    95			reg = <0x30>;
    96			#address-cells = <1>;
    97			#size-cells = <0>;
    98	
    99			vin-supply = <&pm8916_l17>;
   100			vio-supply = <&pm8916_l6>;
   101	
   102			pinctrl-0 = <&status_led_default>;
   103			pinctrl-names = "default";
   104	
   105			multi-led {
   106				color = <LED_COLOR_ID_RGB>;
   107				function = LED_FUNCTION_STATUS;
   108	
   109				#address-cells = <1>;
   110				#size-cells = <0>;
   111	
   112				led@0 {
   113					reg = <0>;
   114					color = <LED_COLOR_ID_RED>;
   115				};
   116	
   117				led@1 {
   118					reg = <1>;
   119					color = <LED_COLOR_ID_GREEN>;
   120				};
   121	
   122				led@2 {
   123					reg = <2>;
   124					color = <LED_COLOR_ID_BLUE>;
   125				};
   126			};
   127		};
   128	};
   129	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

