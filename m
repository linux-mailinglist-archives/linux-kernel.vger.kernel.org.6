Return-Path: <linux-kernel+bounces-248896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5979392E35F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 11:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 672D11C21484
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 09:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B9A155732;
	Thu, 11 Jul 2024 09:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dzu/IbaI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BBC15572D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 09:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720689813; cv=none; b=UnM67XPR6GYiFxm+yGUXUzKXT6joncleLm0T6ZFzR1FWwcbVkB++cHxjQ9DlqCJlwbs7KTNU2PrTmE+PMg/rBXX4XpmEvsxinM7NfbvWuIa4Oa8Mf+eAOlXRx5hptkZBEHHuXZH6YX2oAAiGiDCWPOLaS53363jtCfKCzzuTiTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720689813; c=relaxed/simple;
	bh=VSXA9mW780elAuWvlrlXrR9wuYf5rJmeKw8t9Oaa+Os=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cvl6AH6iDSlFDwQ3N6TDDwo2u4sxcKrXVq1NZNlTrnnKoP28Q01fAu2K+LoeCYCSyxsG7gDg/aH1vcj+uFb4fg6CWlIDA7oSNEsd0EizwRytabe+TvWDM0a3/D7nc47s88bU2xbxMMdoK3u+uAfXb7n7HT9FYUa53aMxSvbXN2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dzu/IbaI; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720689812; x=1752225812;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VSXA9mW780elAuWvlrlXrR9wuYf5rJmeKw8t9Oaa+Os=;
  b=dzu/IbaI8OOWw/G66YvdiPehD7+zMLPpGdNfcITYTTKfPi8aSCMpmRKw
   XwzvvBbeuIlbFZ3L4FKGYXwVh80WmvXSTUuZqD+tsqGE9aKU/feoLWwFy
   p9OVwbjdqgMHiUSTX1GG+TtF5rx4k0Guwn9MRDAXCF/9aAQrlRm06eDMz
   8i3J7wc66FvY7fVaSTF4oB3GOZ1QWhpQYGVpZ1hZPOCqenw1Y1mCKvVsN
   av+yE/i/8wSQqkVHMZ96Qcp7togBGdgltQbFtYej1ex86iDxENU/rg/WW
   GHqIP2lc3jjSnZ6vLtirJXjb2czU9876791Q7zh2bQuQEMg472FgQilIS
   g==;
X-CSE-ConnectionGUID: H0HtR1EaR9CYV421TDsbAw==
X-CSE-MsgGUID: tSwZCD8RSii99pp4uM01ZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="21820580"
X-IronPort-AV: E=Sophos;i="6.09,199,1716274800"; 
   d="scan'208";a="21820580"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 02:23:18 -0700
X-CSE-ConnectionGUID: C8qF4ahETAioVbbkTAG7ag==
X-CSE-MsgGUID: BdrE4VzuRIaKETgTb4oZLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,199,1716274800"; 
   d="scan'208";a="48579470"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 11 Jul 2024 02:23:17 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sRq1C-000Z4A-33;
	Thu, 11 Jul 2024 09:23:14 +0000
Date: Thu, 11 Jul 2024 17:22:18 +0800
From: kernel test robot <lkp@intel.com>
To: Zev Weiss <zev@bewilderbeest.net>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Joel Stanley <joel@jms.id.au>
Subject: arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c256d4i.dtb: fan@2:
 aspeed,fan-tach-ch: b'\x02' is not of type 'object', 'integer', 'array',
 'boolean', 'null'
Message-ID: <202407111732.tTj50kTi-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9d9a2f29aefdadc86e450308ff056017a209c755
commit: c44211af1aa9c6b93178a3993e18a7ebffab7488 ARM: dts: aspeed: Add ASRock E3C256D4I BMC
date:   2 months ago
config: arm-randconfig-051-20240711 (https://download.01.org/0day-ci/archive/20240711/202407111732.tTj50kTi-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.3.0
dtschema version: 2024.6.dev4+g23441a4
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240711/202407111732.tTj50kTi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407111732.tTj50kTi-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
   arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c256d4i.dtb: sram@1e720000: 'ranges' is a required property
   	from schema $id: http://devicetree.org/schemas/sram/sram.yaml#
   arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c256d4i.dtb: sgpio@1e780200: '#interrupt-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/gpio/aspeed,sgpio.yaml#
   arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c256d4i.dtb: /ahb/apb/rtc@1e781000: failed to match any schema with compatible: ['aspeed,ast2500-rtc']
   arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c256d4i.dtb: /ahb/apb/timer@1e782000: failed to match any schema with compatible: ['aspeed,ast2400-timer']
   arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c256d4i.dtb: /ahb/apb/watchdog@1e785000: failed to match any schema with compatible: ['aspeed,ast2500-wdt']
   arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c256d4i.dtb: /ahb/apb/watchdog@1e785020: failed to match any schema with compatible: ['aspeed,ast2500-wdt']
   arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c256d4i.dtb: /ahb/apb/watchdog@1e785040: failed to match any schema with compatible: ['aspeed,ast2500-wdt']
   arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c256d4i.dtb: /ahb/apb/pwm-tacho-controller@1e786000: failed to match any schema with compatible: ['aspeed,ast2500-pwm-tacho']
>> arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c256d4i.dtb: fan@2: aspeed,fan-tach-ch: b'\x02' is not of type 'object', 'integer', 'array', 'boolean', 'null'
   	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
>> arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c256d4i.dtb: fan@4: aspeed,fan-tach-ch: b'\x04' is not of type 'object', 'integer', 'array', 'boolean', 'null'
   	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
   arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c256d4i.dtb: lpc@1e789000: lpc-snoop@90: 'clocks' does not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/mfd/aspeed-lpc.yaml#
   arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c256d4i.dtb: lpc@1e789000: reg-io-width: 4 is not of type 'object'
   	from schema $id: http://devicetree.org/schemas/mfd/aspeed-lpc.yaml#
   arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c256d4i.dtb: kcs@24: 'clocks' does not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
   arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c256d4i.dtb: kcs@28: 'clocks' does not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
   arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c256d4i.dtb: kcs@2c: 'clocks' does not match any of the regexes: 'pinctrl-[0-9]+'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

