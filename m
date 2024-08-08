Return-Path: <linux-kernel+bounces-278735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A4D94B426
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 02:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0202A1F210E0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 00:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036762107;
	Thu,  8 Aug 2024 00:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="izlFPlTF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C83E10F9
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 00:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723076547; cv=none; b=JvvqqUaeeW/HeojikiQyATzpj91pyOhJUgAgw2uC1ydz9pHaGwg3BK5n+/3gJizS8eY57nCmmfLGfxT45Vg8VlkOp6clY78zneBDeNObiyo/5PUZPePgQ/6/KUOyVv3Nh8PivfmeVkGu1VzvECcp5oVp+M6Dcr9/+s+XlCeyyI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723076547; c=relaxed/simple;
	bh=H3cogk1LM4kF5xYVlMitUd2erx2BYREQYLxXVEuGTT8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OTT94D8qEz7MYVJ9T+4/n1UccIGpgY42ynSQeRoeFcmHnpBN63wiMXjDwgd78zMrCaCYzE39tQDHKl66KYZI0Jdvp2kl8vrbRUh1RERPcwmMNrE4CFm7HI6jsKr8NuL549TWNvXQ5cZ3Lc2PWQ+fAjurQrCsNdQJvuqo3eAVUBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=izlFPlTF; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723076546; x=1754612546;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=H3cogk1LM4kF5xYVlMitUd2erx2BYREQYLxXVEuGTT8=;
  b=izlFPlTFRaQqtwq+XtWKkhKriKpQR6/ACdo7g/SCTHllh+U0Cs1dO7aI
   6D6eaGUkV6kSaTRBCI1U6HHnCSCSm91RKzSMvQs65eONCk2V+fsKcU4bH
   PcQr68aJISteFu4f2h3pAnpe4I/SxP564cL0jwl+nQ6fcJ5SPocA8E4aF
   nh7QbKL929wy93e7AB/iTN7gCk1/o6X7Qj8vsYCGL9b4THu16rkTYY4eu
   fWh3xOeDh0UWa3kYdMINswpygt9rLMyn3OPlEqXYa26EYNfpSmX53spdR
   bDVfMSLByP1Ah/Zzs056Fgu5NoCY++Tt6cI0dTPRlVIghPEeM6IiN/d3S
   g==;
X-CSE-ConnectionGUID: I+phBL5CQqO+iQQuB2x8pA==
X-CSE-MsgGUID: 2qCmObXVQbSpROzfOMgTgw==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="31753917"
X-IronPort-AV: E=Sophos;i="6.09,271,1716274800"; 
   d="scan'208";a="31753917"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 17:22:25 -0700
X-CSE-ConnectionGUID: USfg1PVLQqmuuG9rHXKSGg==
X-CSE-MsgGUID: hAOLV4npQ/yooi7pH0+10g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,271,1716274800"; 
   d="scan'208";a="87947289"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 07 Aug 2024 17:22:22 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sbqv6-0005oW-1M;
	Thu, 08 Aug 2024 00:22:20 +0000
Date: Thu, 8 Aug 2024 08:21:53 +0800
From: kernel test robot <lkp@intel.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Dave Jiang <dave.jiang@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Ira Weiny <ira.weiny@intel.com>
Subject: ERROR: modpost: "__popcountsi2"
 [drivers/comedi/drivers/cb_pcidas.ko] undefined!
Message-ID: <202408080822.j66QlMph-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Alison,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6a0e38264012809afa24113ee2162dc07f4ed22b
commit: 86954ff5032d9d60a5458334001ab3ae3b2c45e8 cxl/region: Move cxl_trace_hpa() work to the region driver
date:   3 months ago
config: arm-randconfig-r133-20240807 (https://download.01.org/0day-ci/archive/20240808/202408080822.j66QlMph-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 423aec6573df4424f90555468128e17073ddc69e)
reproduce: (https://download.01.org/0day-ci/archive/20240808/202408080822.j66QlMph-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408080822.j66QlMph-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in vmlinux.o
WARNING: modpost: missing MODULE_DESCRIPTION() in kernel/locking/locktorture.o
WARNING: modpost: missing MODULE_DESCRIPTION() in kernel/rcu/rcutorture.o
WARNING: modpost: missing MODULE_DESCRIPTION() in kernel/rcu/refscale.o
WARNING: modpost: missing MODULE_DESCRIPTION() in kernel/time/time_test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in kernel/trace/preemptirq_delay_test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in kernel/torture.o
WARNING: modpost: missing MODULE_DESCRIPTION() in mm/kfence/kfence_test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/nls_cp850.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/nls_cp855.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/nls_cp863.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/nls_cp865.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/nls_cp866.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/nls_cp874.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/nls_cp950.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/nls_cp1251.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/nls_iso8859-4.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/nls_iso8859-6.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/nls_cp1255.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/nls_iso8859-14.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/nls_iso8859-15.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/mac-celtic.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/mac-croatian.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/mac-cyrillic.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/mac-gaelic.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/mac-romanian.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/mac-turkish.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/binfmt_script.o
WARNING: modpost: missing MODULE_DESCRIPTION() in crypto/ecc.o
WARNING: modpost: missing MODULE_DESCRIPTION() in crypto/curve25519-generic.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/kunit/kunit.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/kunit/kunit-test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/kunit/kunit-example-test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/math/prime_numbers.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pinctrl/pinctrl-mcp23s08_i2c.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pinctrl/pinctrl-mcp23s08_spi.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pinctrl/pinctrl-mcp23s08.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pci/controller/pci-host-common.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pci/controller/pci-host-generic.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pci/pci-stub.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/video/backlight/platform_lcd.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/versatile/clk-vexpress-osc.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/clk_test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/clk-gate_test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/clk-fractional-divider_test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/regulator/max20411-regulator.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/regulator/rt4831-regulator.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/reset/hisilicon/hi6220_reset.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/base/regmap/regmap-sccb.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/misc/open-dice.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mfd/rt4831.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cxl/core/cxl_core.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cxl/cxl_pci.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cxl/cxl_mem.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cxl/cxl_port.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/spmi/hisi-spmi-controller.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/auxdisplay/line-display.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/i2c/busses/i2c-ccgx-ucsi.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/radio/si470x/radio-si470x-common.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hwmon/mr75203.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mmc/host/of_mmc_spi.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/leds/flash/leds-rt4505.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/of/of_test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/nvmem/nvmem_u-boot-env.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mtd/chips/cfi_util.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mtd/maps/map_funcs.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pcmcia/pcmcia_rsrc.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pcmcia/yenta_socket.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pcmcia/i82092.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/siox/siox-bus-gpio.o
ERROR: modpost: "__popcountsi2" [drivers/hwmon/adt7462.ko] undefined!
ERROR: modpost: "__popcountsi2" [drivers/comedi/drivers/addi_apci_2032.ko] undefined!
ERROR: modpost: "__popcountsi2" [drivers/comedi/drivers/addi_apci_3120.ko] undefined!
ERROR: modpost: "__popcountsi2" [drivers/comedi/drivers/addi_apci_3xxx.ko] undefined!
ERROR: modpost: "__popcountsi2" [drivers/comedi/drivers/adl_pci9111.ko] undefined!
ERROR: modpost: "__popcountsi2" [drivers/comedi/drivers/adl_pci9118.ko] undefined!
ERROR: modpost: "__popcountsi2" [drivers/comedi/drivers/adv_pci1710.ko] undefined!
ERROR: modpost: "__popcountsi2" [drivers/comedi/drivers/amplc_pci224.ko] undefined!
ERROR: modpost: "__popcountsi2" [drivers/comedi/drivers/cb_pcidas64.ko] undefined!
>> ERROR: modpost: "__popcountsi2" [drivers/comedi/drivers/cb_pcidas.ko] undefined!
WARNING: modpost: suppressed 12 unresolved symbol warnings because there were too many)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

