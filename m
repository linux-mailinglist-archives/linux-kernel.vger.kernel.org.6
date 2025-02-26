Return-Path: <linux-kernel+bounces-533005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22495A454BD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 06:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93C901896061
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 05:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E488189BB0;
	Wed, 26 Feb 2025 05:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aUvxEnxy"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF61F137E
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 05:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740546082; cv=none; b=ReQsgVji6uRXg8mvp4uk+0Ni2VJUjrY6DxxuWR+UCiOw5RaH8Mqfx2VlsBl+c11MUHy2JMAXcVa+wtdOfPFPkJkOcamI+w+Br6YXT89YLO3l8vQAfAfw68feNHmVnqI5oYBJ+X5WChyzd4DF9yim8TgGrvTDkuNnNWPQIpMRJOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740546082; c=relaxed/simple;
	bh=eL1jgGsCKQBM27kcAea4rTdGKcwuGmnVUE14WU3md3g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NingJPgLU1TcJgLsfnXoVcQ94hY3FUG5XEtame8FDyL6Gl7eDwBjrbFWTMmYzmEHB+o+x7WUMb56/nDRenkCCPsyT5x3tgZZbfsCBAITnUw5EvmV9r2gAOgPApRNlYy62hIHk2yFuvylOOsroq6Qj1OQJFQ9rHquKgTId+Ykrm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aUvxEnxy; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740546080; x=1772082080;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eL1jgGsCKQBM27kcAea4rTdGKcwuGmnVUE14WU3md3g=;
  b=aUvxEnxyupD4BrXwpq/IR1f1nK4ESgKJPT/ivpxb6zJp12hnZS9VS5Sf
   ToRVd9OhRtwUSbhftQYNAVKq2BRn/aB72ugCZpgJWydLCDz3doCb0I3r8
   ZUdFM92m8rO8BXr0mdfsbHaDHA9ESf3abde/SnkvNU76ASFV9KlO5wwIk
   FKtTFMU8pVFPHjcT3QqNua2LyQpXMeBp/6UtgVHpXjdcek9DrCLgcCoaU
   gv2LBXXSI3zpgZt3zvbunobfcJbKMAbbzoZBx1rwvuItJOddXElU4H5X1
   GDon93fJeM1zW3G+WPEOTxomgOUW0kJcXTm+DzsbQk4lyb6RM5lht72zb
   A==;
X-CSE-ConnectionGUID: Jk/mLZKnTFmKDEOHi1BLMg==
X-CSE-MsgGUID: bm+NlshnRcO+pc+PBxupmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="41396659"
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="41396659"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 21:01:20 -0800
X-CSE-ConnectionGUID: lGPs2XPaRfqnhzcXkslitw==
X-CSE-MsgGUID: Xxhv3RJ9SXaGlPngDJ3Aig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="116385349"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 25 Feb 2025 21:01:18 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tn9Xn-000BBB-1y;
	Wed, 26 Feb 2025 05:01:15 +0000
Date: Wed, 26 Feb 2025 12:59:53 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Richard Weinberger <richard@nod.at>
Subject: drivers/devfreq/tegra30-devfreq.c:100: warning: Function parameter
 or struct member 'irq_mask' not described in 'tegra_devfreq_device_config'
Message-ID: <202502261254.nyRjWic9-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Johannes,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ac9c34d1e45a4c25174ced4fc0cfc33ff3ed08c7
commit: 68f5d3f3b6543266b29e047cfaf9842333019b4c um: add PCI over virtio emulation driver
date:   3 years, 8 months ago
config: um-randconfig-r052-20240430 (https://download.01.org/0day-ci/archive/20250226/202502261254.nyRjWic9-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250226/202502261254.nyRjWic9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502261254.nyRjWic9-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/char/applicom.c: In function 'ac_register_board':
>> drivers/char/applicom.c:131:32: warning: variable 'byte_reset_it' set but not used [-Wunused-but-set-variable]
     131 |         volatile unsigned char byte_reset_it;
         |                                ^~~~~~~~~~~~~
   drivers/char/applicom.c: In function 'ac_read':
>> drivers/char/applicom.c:540:13: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
     540 |         int ret = 0;
         |             ^~~
   drivers/char/applicom.c: In function 'ac_ioctl':
   drivers/char/applicom.c:703:32: warning: variable 'byte_reset_it' set but not used [-Wunused-but-set-variable]
     703 |         volatile unsigned char byte_reset_it;
         |                                ^~~~~~~~~~~~~
--
   drivers/char/sonypi.c: In function 'sonypi_call1':
>> drivers/char/sonypi.c:637:12: warning: variable 'v1' set but not used [-Wunused-but-set-variable]
     637 |         u8 v1, v2;
         |            ^~
--
>> drivers/devfreq/tegra30-devfreq.c:100: warning: Function parameter or struct member 'offset' not described in 'tegra_devfreq_device_config'
>> drivers/devfreq/tegra30-devfreq.c:100: warning: Function parameter or struct member 'irq_mask' not described in 'tegra_devfreq_device_config'
>> drivers/devfreq/tegra30-devfreq.c:100: warning: Function parameter or struct member 'boost_up_coeff' not described in 'tegra_devfreq_device_config'
>> drivers/devfreq/tegra30-devfreq.c:100: warning: Function parameter or struct member 'boost_down_coeff' not described in 'tegra_devfreq_device_config'
>> drivers/devfreq/tegra30-devfreq.c:100: warning: Function parameter or struct member 'boost_up_threshold' not described in 'tegra_devfreq_device_config'
>> drivers/devfreq/tegra30-devfreq.c:100: warning: Function parameter or struct member 'boost_down_threshold' not described in 'tegra_devfreq_device_config'
>> drivers/devfreq/tegra30-devfreq.c:100: warning: Function parameter or struct member 'avg_dependency_threshold' not described in 'tegra_devfreq_device_config'
>> drivers/devfreq/tegra30-devfreq.c:171: warning: Function parameter or struct member 'config' not described in 'tegra_devfreq_device'
>> drivers/devfreq/tegra30-devfreq.c:171: warning: Function parameter or struct member 'regs' not described in 'tegra_devfreq_device'
>> drivers/devfreq/tegra30-devfreq.c:171: warning: Function parameter or struct member 'avg_count' not described in 'tegra_devfreq_device'
>> drivers/devfreq/tegra30-devfreq.c:171: warning: Function parameter or struct member 'boost_freq' not described in 'tegra_devfreq_device'
>> drivers/devfreq/tegra30-devfreq.c:171: warning: Function parameter or struct member 'target_freq' not described in 'tegra_devfreq_device'
--
   drivers/hwmon/aht10.c:87: warning: Excess function parameter 'client' description in 'aht10_init'
   drivers/hwmon/aht10.c:131: warning: Function parameter or struct member 'data' not described in 'aht10_read_values'
   drivers/hwmon/aht10.c:131: warning: Excess function parameter 'aht10_data' description in 'aht10_read_values'
>> drivers/hwmon/aht10.c:184: warning: Function parameter or struct member 'data' not described in 'aht10_interval_write'
>> drivers/hwmon/aht10.c:184: warning: Function parameter or struct member 'val' not described in 'aht10_interval_write'
>> drivers/hwmon/aht10.c:195: warning: Function parameter or struct member 'data' not described in 'aht10_interval_read'
>> drivers/hwmon/aht10.c:195: warning: Function parameter or struct member 'val' not described in 'aht10_interval_read'
>> drivers/hwmon/aht10.c:204: warning: Function parameter or struct member 'data' not described in 'aht10_temperature1_read'
>> drivers/hwmon/aht10.c:204: warning: Function parameter or struct member 'val' not described in 'aht10_temperature1_read'
>> drivers/hwmon/aht10.c:219: warning: Function parameter or struct member 'data' not described in 'aht10_humidity1_read'
>> drivers/hwmon/aht10.c:219: warning: Function parameter or struct member 'val' not described in 'aht10_humidity1_read'
--
>> drivers/i2c/busses/i2c-mxs.c:131: warning: Function parameter or struct member 'timing0' not described in 'mxs_i2c_dev'
>> drivers/i2c/busses/i2c-mxs.c:131: warning: Function parameter or struct member 'timing1' not described in 'mxs_i2c_dev'
>> drivers/i2c/busses/i2c-mxs.c:131: warning: Function parameter or struct member 'timing2' not described in 'mxs_i2c_dev'
>> drivers/i2c/busses/i2c-mxs.c:131: warning: Function parameter or struct member 'dmach' not described in 'mxs_i2c_dev'
>> drivers/i2c/busses/i2c-mxs.c:131: warning: Function parameter or struct member 'pio_data' not described in 'mxs_i2c_dev'
>> drivers/i2c/busses/i2c-mxs.c:131: warning: Function parameter or struct member 'addr_data' not described in 'mxs_i2c_dev'
>> drivers/i2c/busses/i2c-mxs.c:131: warning: Function parameter or struct member 'sg_io' not described in 'mxs_i2c_dev'
>> drivers/i2c/busses/i2c-mxs.c:131: warning: Function parameter or struct member 'dma_read' not described in 'mxs_i2c_dev'
--
   drivers/net/ethernet/broadcom/bnx2.c: In function 'bnx2_tx_int':
>> drivers/net/ethernet/broadcom/bnx2.c:2890:47: warning: variable 'tx_buf' set but not used [-Wunused-but-set-variable]
    2890 |                         struct bnx2_sw_tx_bd *tx_buf;
         |                                               ^~~~~~
   drivers/net/ethernet/broadcom/bnx2.c: In function 'bnx2_reuse_rx_data':
>> drivers/net/ethernet/broadcom/bnx2.c:2998:28: warning: variable 'cons_rx_buf' set but not used [-Wunused-but-set-variable]
    2998 |         struct bnx2_sw_bd *cons_rx_buf, *prod_rx_buf;
         |                            ^~~~~~~~~~~
--
>> drivers/ntb/msi.c:33: warning: Function parameter or struct member 'desc_changed' not described in 'ntb_msi_init'
   drivers/ntb/msi.c:283: warning: Function parameter or struct member 'name' not described in 'ntbm_msi_request_threaded_irq'
   drivers/ntb/msi.c:283: warning: Function parameter or struct member 'msi_desc' not described in 'ntbm_msi_request_threaded_irq'
   drivers/ntb/msi.c:283: warning: Excess function parameter 'devname' description in 'ntbm_msi_request_threaded_irq'
--
   drivers/rapidio/rio_cm.c: In function 'rio_txcq_handler':
>> drivers/rapidio/rio_cm.c:673:21: warning: variable 'rc' set but not used [-Wunused-but-set-variable]
     673 |                 int rc;
         |                     ^~
--
>> drivers/rtc/rtc-omap.c:411: warning: Function parameter or struct member 'dev' not described in 'omap_rtc_power_off_program'
--
>> drivers/rtc/rtc-fsl-ftm-alarm.c:315:36: warning: 'ftm_imx_acpi_ids' defined but not used [-Wunused-const-variable=]
     315 | static const struct acpi_device_id ftm_imx_acpi_ids[] = {
         |                                    ^~~~~~~~~~~~~~~~

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for FRAMEBUFFER_CONSOLE
   Depends on [n]: VT [=n] && FB [=y] && !UML [=y]
   Selected by [y]:
   - DRM_KMS_FB_HELPER [=y] && HAS_IOMEM [=y] && DRM_KMS_HELPER [=y] && !EXPERT [=n]
   WARNING: unmet direct dependencies detected for FRAMEBUFFER_CONSOLE_DETECT_PRIMARY
   Depends on [n]: VT [=n] && FRAMEBUFFER_CONSOLE [=y]
   Selected by [y]:
   - DRM_KMS_FB_HELPER [=y] && HAS_IOMEM [=y] && DRM_KMS_HELPER [=y] && FRAMEBUFFER_CONSOLE [=y]
   WARNING: unmet direct dependencies detected for VT_HW_CONSOLE_BINDING
   Depends on [n]: TTY [=y] && HW_CONSOLE [=n]
   Selected by [y]:
   - DRM_TVE200 [=y] && HAS_IOMEM [=y] && DRM [=y] && CMA [=y] && (ARM || COMPILE_TEST [=y]) && OF [=y] && FRAMEBUFFER_CONSOLE [=y]
   Selected by [m]:
   - DRM_INGENIC [=m] && HAS_IOMEM [=y] && (MIPS || COMPILE_TEST [=y]) && DRM [=y] && CMA [=y] && OF [=y] && COMMON_CLK [=y] && FRAMEBUFFER_CONSOLE [=y]
   - DRM_PL111 [=m] && HAS_IOMEM [=y] && DRM [=y] && (ARM || ARM64 || COMPILE_TEST [=y]) && COMMON_CLK [=y] && FRAMEBUFFER_CONSOLE [=y]
   - DRM_MCDE [=m] && HAS_IOMEM [=y] && DRM [=y] && CMA [=y] && (ARM || COMPILE_TEST [=y]) && OF [=y] && COMMON_CLK [=y] && FRAMEBUFFER_CONSOLE [=y]


vim +100 drivers/devfreq/tegra30-devfreq.c

6234f38016ad56 drivers/devfreq/tegra-devfreq.c   Tomeu Vizoso    2014-11-24   74  
6234f38016ad56 drivers/devfreq/tegra-devfreq.c   Tomeu Vizoso    2014-11-24   75  /**
6234f38016ad56 drivers/devfreq/tegra-devfreq.c   Tomeu Vizoso    2014-11-24   76   * struct tegra_devfreq_device_config - configuration specific to an ACTMON
6234f38016ad56 drivers/devfreq/tegra-devfreq.c   Tomeu Vizoso    2014-11-24   77   * device
6234f38016ad56 drivers/devfreq/tegra-devfreq.c   Tomeu Vizoso    2014-11-24   78   *
11573e9132ae40 drivers/devfreq/tegra-devfreq.c   Tomeu Vizoso    2015-03-17   79   * Coefficients and thresholds are percentages unless otherwise noted
6234f38016ad56 drivers/devfreq/tegra-devfreq.c   Tomeu Vizoso    2014-11-24   80   */
6234f38016ad56 drivers/devfreq/tegra-devfreq.c   Tomeu Vizoso    2014-11-24   81  struct tegra_devfreq_device_config {
6234f38016ad56 drivers/devfreq/tegra-devfreq.c   Tomeu Vizoso    2014-11-24   82  	u32		offset;
6234f38016ad56 drivers/devfreq/tegra-devfreq.c   Tomeu Vizoso    2014-11-24   83  	u32		irq_mask;
6234f38016ad56 drivers/devfreq/tegra-devfreq.c   Tomeu Vizoso    2014-11-24   84  
11573e9132ae40 drivers/devfreq/tegra-devfreq.c   Tomeu Vizoso    2015-03-17   85  	/* Factors applied to boost_freq every consecutive watermark breach */
6234f38016ad56 drivers/devfreq/tegra-devfreq.c   Tomeu Vizoso    2014-11-24   86  	unsigned int	boost_up_coeff;
6234f38016ad56 drivers/devfreq/tegra-devfreq.c   Tomeu Vizoso    2014-11-24   87  	unsigned int	boost_down_coeff;
11573e9132ae40 drivers/devfreq/tegra-devfreq.c   Tomeu Vizoso    2015-03-17   88  
11573e9132ae40 drivers/devfreq/tegra-devfreq.c   Tomeu Vizoso    2015-03-17   89  	/* Define the watermark bounds when applied to the current avg */
6234f38016ad56 drivers/devfreq/tegra-devfreq.c   Tomeu Vizoso    2014-11-24   90  	unsigned int	boost_up_threshold;
6234f38016ad56 drivers/devfreq/tegra-devfreq.c   Tomeu Vizoso    2014-11-24   91  	unsigned int	boost_down_threshold;
11573e9132ae40 drivers/devfreq/tegra-devfreq.c   Tomeu Vizoso    2015-03-17   92  
11573e9132ae40 drivers/devfreq/tegra-devfreq.c   Tomeu Vizoso    2015-03-17   93  	/*
28615e37be9687 drivers/devfreq/tegra30-devfreq.c Dmitry Osipenko 2019-11-05   94  	 * Threshold of activity (cycles translated to kHz) below which the
28615e37be9687 drivers/devfreq/tegra30-devfreq.c Dmitry Osipenko 2019-11-05   95  	 * CPU frequency isn't to be taken into account. This is to avoid
28615e37be9687 drivers/devfreq/tegra30-devfreq.c Dmitry Osipenko 2019-11-05   96  	 * increasing the EMC frequency when the CPU is very busy but not
28615e37be9687 drivers/devfreq/tegra30-devfreq.c Dmitry Osipenko 2019-11-05   97  	 * accessing the bus often.
11573e9132ae40 drivers/devfreq/tegra-devfreq.c   Tomeu Vizoso    2015-03-17   98  	 */
6234f38016ad56 drivers/devfreq/tegra-devfreq.c   Tomeu Vizoso    2014-11-24   99  	u32		avg_dependency_threshold;
6234f38016ad56 drivers/devfreq/tegra-devfreq.c   Tomeu Vizoso    2014-11-24 @100  };
6234f38016ad56 drivers/devfreq/tegra-devfreq.c   Tomeu Vizoso    2014-11-24  101  
6234f38016ad56 drivers/devfreq/tegra-devfreq.c   Tomeu Vizoso    2014-11-24  102  enum tegra_actmon_device {
6234f38016ad56 drivers/devfreq/tegra-devfreq.c   Tomeu Vizoso    2014-11-24  103  	MCALL = 0,
6234f38016ad56 drivers/devfreq/tegra-devfreq.c   Tomeu Vizoso    2014-11-24  104  	MCCPU,
6234f38016ad56 drivers/devfreq/tegra-devfreq.c   Tomeu Vizoso    2014-11-24  105  };
6234f38016ad56 drivers/devfreq/tegra-devfreq.c   Tomeu Vizoso    2014-11-24  106  
6a575e84f11e15 drivers/devfreq/tegra30-devfreq.c Dmitry Osipenko 2020-12-03  107  static const struct tegra_devfreq_device_config tegra124_device_configs[] = {
6234f38016ad56 drivers/devfreq/tegra-devfreq.c   Tomeu Vizoso    2014-11-24  108  	{
11573e9132ae40 drivers/devfreq/tegra-devfreq.c   Tomeu Vizoso    2015-03-17  109  		/* MCALL: All memory accesses (including from the CPUs) */
6234f38016ad56 drivers/devfreq/tegra-devfreq.c   Tomeu Vizoso    2014-11-24  110  		.offset = 0x1c0,
6234f38016ad56 drivers/devfreq/tegra-devfreq.c   Tomeu Vizoso    2014-11-24  111  		.irq_mask = 1 << 26,
6234f38016ad56 drivers/devfreq/tegra-devfreq.c   Tomeu Vizoso    2014-11-24  112  		.boost_up_coeff = 200,
6234f38016ad56 drivers/devfreq/tegra-devfreq.c   Tomeu Vizoso    2014-11-24  113  		.boost_down_coeff = 50,
6234f38016ad56 drivers/devfreq/tegra-devfreq.c   Tomeu Vizoso    2014-11-24  114  		.boost_up_threshold = 60,
6234f38016ad56 drivers/devfreq/tegra-devfreq.c   Tomeu Vizoso    2014-11-24  115  		.boost_down_threshold = 40,
6234f38016ad56 drivers/devfreq/tegra-devfreq.c   Tomeu Vizoso    2014-11-24  116  	},
6234f38016ad56 drivers/devfreq/tegra-devfreq.c   Tomeu Vizoso    2014-11-24  117  	{
11573e9132ae40 drivers/devfreq/tegra-devfreq.c   Tomeu Vizoso    2015-03-17  118  		/* MCCPU: memory accesses from the CPUs */
6234f38016ad56 drivers/devfreq/tegra-devfreq.c   Tomeu Vizoso    2014-11-24  119  		.offset = 0x200,
6234f38016ad56 drivers/devfreq/tegra-devfreq.c   Tomeu Vizoso    2014-11-24  120  		.irq_mask = 1 << 25,
6234f38016ad56 drivers/devfreq/tegra-devfreq.c   Tomeu Vizoso    2014-11-24  121  		.boost_up_coeff = 800,
fee22854c02735 drivers/devfreq/tegra30-devfreq.c Dmitry Osipenko 2019-11-05  122  		.boost_down_coeff = 40,
6234f38016ad56 drivers/devfreq/tegra-devfreq.c   Tomeu Vizoso    2014-11-24  123  		.boost_up_threshold = 27,
6234f38016ad56 drivers/devfreq/tegra-devfreq.c   Tomeu Vizoso    2014-11-24  124  		.boost_down_threshold = 10,
28615e37be9687 drivers/devfreq/tegra30-devfreq.c Dmitry Osipenko 2019-11-05  125  		.avg_dependency_threshold = 16000, /* 16MHz in kHz units */
6234f38016ad56 drivers/devfreq/tegra-devfreq.c   Tomeu Vizoso    2014-11-24  126  	},
6234f38016ad56 drivers/devfreq/tegra-devfreq.c   Tomeu Vizoso    2014-11-24  127  };
6234f38016ad56 drivers/devfreq/tegra-devfreq.c   Tomeu Vizoso    2014-11-24  128  
6a575e84f11e15 drivers/devfreq/tegra30-devfreq.c Dmitry Osipenko 2020-12-03  129  static const struct tegra_devfreq_device_config tegra30_device_configs[] = {
6a575e84f11e15 drivers/devfreq/tegra30-devfreq.c Dmitry Osipenko 2020-12-03  130  	{
6a575e84f11e15 drivers/devfreq/tegra30-devfreq.c Dmitry Osipenko 2020-12-03  131  		/* MCALL: All memory accesses (including from the CPUs) */
6a575e84f11e15 drivers/devfreq/tegra30-devfreq.c Dmitry Osipenko 2020-12-03  132  		.offset = 0x1c0,
6a575e84f11e15 drivers/devfreq/tegra30-devfreq.c Dmitry Osipenko 2020-12-03  133  		.irq_mask = 1 << 26,
6a575e84f11e15 drivers/devfreq/tegra30-devfreq.c Dmitry Osipenko 2020-12-03  134  		.boost_up_coeff = 200,
6a575e84f11e15 drivers/devfreq/tegra30-devfreq.c Dmitry Osipenko 2020-12-03  135  		.boost_down_coeff = 50,
6a575e84f11e15 drivers/devfreq/tegra30-devfreq.c Dmitry Osipenko 2020-12-03  136  		.boost_up_threshold = 20,
6a575e84f11e15 drivers/devfreq/tegra30-devfreq.c Dmitry Osipenko 2020-12-03  137  		.boost_down_threshold = 10,
6a575e84f11e15 drivers/devfreq/tegra30-devfreq.c Dmitry Osipenko 2020-12-03  138  	},
6a575e84f11e15 drivers/devfreq/tegra30-devfreq.c Dmitry Osipenko 2020-12-03  139  	{
6a575e84f11e15 drivers/devfreq/tegra30-devfreq.c Dmitry Osipenko 2020-12-03  140  		/* MCCPU: memory accesses from the CPUs */
6a575e84f11e15 drivers/devfreq/tegra30-devfreq.c Dmitry Osipenko 2020-12-03  141  		.offset = 0x200,
6a575e84f11e15 drivers/devfreq/tegra30-devfreq.c Dmitry Osipenko 2020-12-03  142  		.irq_mask = 1 << 25,
6a575e84f11e15 drivers/devfreq/tegra30-devfreq.c Dmitry Osipenko 2020-12-03  143  		.boost_up_coeff = 800,
6a575e84f11e15 drivers/devfreq/tegra30-devfreq.c Dmitry Osipenko 2020-12-03  144  		.boost_down_coeff = 40,
6a575e84f11e15 drivers/devfreq/tegra30-devfreq.c Dmitry Osipenko 2020-12-03  145  		.boost_up_threshold = 27,
6a575e84f11e15 drivers/devfreq/tegra30-devfreq.c Dmitry Osipenko 2020-12-03  146  		.boost_down_threshold = 10,
6a575e84f11e15 drivers/devfreq/tegra30-devfreq.c Dmitry Osipenko 2020-12-03  147  		.avg_dependency_threshold = 16000, /* 16MHz in kHz units */
6a575e84f11e15 drivers/devfreq/tegra30-devfreq.c Dmitry Osipenko 2020-12-03  148  	},
6a575e84f11e15 drivers/devfreq/tegra30-devfreq.c Dmitry Osipenko 2020-12-03  149  };
6a575e84f11e15 drivers/devfreq/tegra30-devfreq.c Dmitry Osipenko 2020-12-03  150  
6234f38016ad56 drivers/devfreq/tegra-devfreq.c   Tomeu Vizoso    2014-11-24  151  /**
6234f38016ad56 drivers/devfreq/tegra-devfreq.c   Tomeu Vizoso    2014-11-24  152   * struct tegra_devfreq_device - state specific to an ACTMON device
6234f38016ad56 drivers/devfreq/tegra-devfreq.c   Tomeu Vizoso    2014-11-24  153   *
6234f38016ad56 drivers/devfreq/tegra-devfreq.c   Tomeu Vizoso    2014-11-24  154   * Frequencies are in kHz.
6234f38016ad56 drivers/devfreq/tegra-devfreq.c   Tomeu Vizoso    2014-11-24  155   */
6234f38016ad56 drivers/devfreq/tegra-devfreq.c   Tomeu Vizoso    2014-11-24  156  struct tegra_devfreq_device {
6234f38016ad56 drivers/devfreq/tegra-devfreq.c   Tomeu Vizoso    2014-11-24  157  	const struct tegra_devfreq_device_config *config;
6234f38016ad56 drivers/devfreq/tegra-devfreq.c   Tomeu Vizoso    2014-11-24  158  	void __iomem *regs;
11573e9132ae40 drivers/devfreq/tegra-devfreq.c   Tomeu Vizoso    2015-03-17  159  
11573e9132ae40 drivers/devfreq/tegra-devfreq.c   Tomeu Vizoso    2015-03-17  160  	/* Average event count sampled in the last interrupt */
6234f38016ad56 drivers/devfreq/tegra-devfreq.c   Tomeu Vizoso    2014-11-24  161  	u32 avg_count;
6234f38016ad56 drivers/devfreq/tegra-devfreq.c   Tomeu Vizoso    2014-11-24  162  
11573e9132ae40 drivers/devfreq/tegra-devfreq.c   Tomeu Vizoso    2015-03-17  163  	/*
11573e9132ae40 drivers/devfreq/tegra-devfreq.c   Tomeu Vizoso    2015-03-17  164  	 * Extra frequency to increase the target by due to consecutive
11573e9132ae40 drivers/devfreq/tegra-devfreq.c   Tomeu Vizoso    2015-03-17  165  	 * watermark breaches.
11573e9132ae40 drivers/devfreq/tegra-devfreq.c   Tomeu Vizoso    2015-03-17  166  	 */
6234f38016ad56 drivers/devfreq/tegra-devfreq.c   Tomeu Vizoso    2014-11-24  167  	unsigned long boost_freq;
11573e9132ae40 drivers/devfreq/tegra-devfreq.c   Tomeu Vizoso    2015-03-17  168  
11573e9132ae40 drivers/devfreq/tegra-devfreq.c   Tomeu Vizoso    2015-03-17  169  	/* Optimal frequency calculated from the stats for this device */
11573e9132ae40 drivers/devfreq/tegra-devfreq.c   Tomeu Vizoso    2015-03-17  170  	unsigned long target_freq;
6234f38016ad56 drivers/devfreq/tegra-devfreq.c   Tomeu Vizoso    2014-11-24 @171  };
6234f38016ad56 drivers/devfreq/tegra-devfreq.c   Tomeu Vizoso    2014-11-24  172  

:::::: The code at line 100 was first introduced by commit
:::::: 6234f38016ad56321ad0e4bfb57a10a3d940380a PM / devfreq: tegra: add devfreq driver for Tegra Activity Monitor

:::::: TO: Tomeu Vizoso <tomeu.vizoso@collabora.com>
:::::: CC: MyungJoo Ham <myungjoo.ham@samsung.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

