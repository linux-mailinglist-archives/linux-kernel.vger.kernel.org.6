Return-Path: <linux-kernel+bounces-514183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A139A353B0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 02:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DCC0188FE39
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 01:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B926F7081C;
	Fri, 14 Feb 2025 01:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TFIYFQyl"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715B03BBC9
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 01:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739496483; cv=none; b=g2XMmfwiDmITxmSw2tUosU+u802/pYAwdmnoukrceI1pAXfO1FuTDZGKIka9Y+NKKrZWtg3Pptk48LbUIPVmI67dY9Ou7Inim2oqUndQeJJixpZpMSpLWYv7bC7H34Bj0NMFlTi7tZWh/X/FhB6WBb5RJYlajPJ2f2ZQb8CGEd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739496483; c=relaxed/simple;
	bh=cYLZCWklGExqnb4XYd4m4Dohj9r1gsVO6r752NlH7A0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qxVWVhTvMbXavWelEWns641dAYnNzBxuC/BlYeRu6QAEZzo2xcqHR5Qc6PojvKBUkS/2IcNLMgSXX5KYE2Of7m/juaAhRPCoaYPscI3EAnKaO0/aHbTMGfzxU3lIKDb/p3mN6uzmChi/Qbhr1q/9hie7rL740wXh+SYp/OZPPeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TFIYFQyl; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739496477; x=1771032477;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cYLZCWklGExqnb4XYd4m4Dohj9r1gsVO6r752NlH7A0=;
  b=TFIYFQylWcRLwL3YSlOjZgXMSKB+4uABiMIkjBgQgB7J4bfwq8zoWdLm
   6HiXNOQpWDKuzIm4OG99wqzH19cV5vow9hmbRicx2uH1jeEV4ByowCtqH
   tlui6dSQjWKLL1cViKZqeo8Om+PCZqxOqVZnfvcBi9rT4+oxWS1sZg0MU
   p57hQNGN1PRsufi/BJojkas69wGe+0meWi/UEzLacdHBv/WcBtsAcT0+G
   W+GtZFnB7+2pPUWIm726uNMkCmVN1PjZ3lbs5RkJqSEE4KHETEI43gvxD
   I4hY39w309WEI7ymZHF+iVogzPR7ae+Nw6PrOlV3u/dO0cSh2Oesq6+mm
   A==;
X-CSE-ConnectionGUID: 9xfWEmHiRqCESx0IT+4Oew==
X-CSE-MsgGUID: 9Xi+9aDqSXmOGXmJ2dHHDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="39936820"
X-IronPort-AV: E=Sophos;i="6.13,284,1732608000"; 
   d="scan'208";a="39936820"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 17:27:56 -0800
X-CSE-ConnectionGUID: sD5kU1gXQVKXEDd/aSteAw==
X-CSE-MsgGUID: rq/tCPqSR8qLNv9L6x6/zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117447076"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 13 Feb 2025 17:27:55 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tikUj-0018ut-0U;
	Fri, 14 Feb 2025 01:27:53 +0000
Date: Fri, 14 Feb 2025 09:27:15 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: arch/arm/mach-omap2/sdrc.c:129: warning: Function parameter or
 struct member 'sdrc_cs0' not described in 'omap2_sdrc_init'
Message-ID: <202502140909.al1w1xsR-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Arnd,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   68763b29e0a6441f57f9ee652bbf8e7bc59183e5
commit: 09f6b27d5ddd9ad0ec096d1b0f8decdacc70f0f8 ARM: dove: multiplatform support
date:   2 years, 10 months ago
config: arm-randconfig-r016-20221216 (https://download.01.org/0day-ci/archive/20250214/202502140909.al1w1xsR-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250214/202502140909.al1w1xsR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502140909.al1w1xsR-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/arm/mach-omap2/sdrc.c:129: warning: Function parameter or struct member 'sdrc_cs0' not described in 'omap2_sdrc_init'
>> arch/arm/mach-omap2/sdrc.c:129: warning: Function parameter or struct member 'sdrc_cs1' not described in 'omap2_sdrc_init'
--
>> arch/arm/mach-omap2/omap2-restart.c:32: warning: Function parameter or struct member 'mode' not described in 'omap2xxx_restart'
>> arch/arm/mach-omap2/omap2-restart.c:32: warning: Function parameter or struct member 'cmd' not described in 'omap2xxx_restart'
--
>> arch/arm/mach-omap2/omap-secure.c:61: warning: Function parameter or struct member 'arg1' not described in 'omap_secure_dispatcher'
>> arch/arm/mach-omap2/omap-secure.c:61: warning: Function parameter or struct member 'arg2' not described in 'omap_secure_dispatcher'
>> arch/arm/mach-omap2/omap-secure.c:61: warning: Function parameter or struct member 'arg3' not described in 'omap_secure_dispatcher'
>> arch/arm/mach-omap2/omap-secure.c:61: warning: Function parameter or struct member 'arg4' not described in 'omap_secure_dispatcher'
   arch/arm/mach-omap2/omap-secure.c:61: warning: expecting prototype for omap_sec_dispatcher(). Prototype was for omap_secure_dispatcher() instead
>> arch/arm/mach-omap2/omap-secure.c:162: warning: Function parameter or struct member 'arg1' not described in 'rx51_secure_dispatcher'
>> arch/arm/mach-omap2/omap-secure.c:162: warning: Function parameter or struct member 'arg2' not described in 'rx51_secure_dispatcher'
>> arch/arm/mach-omap2/omap-secure.c:162: warning: Function parameter or struct member 'arg3' not described in 'rx51_secure_dispatcher'
>> arch/arm/mach-omap2/omap-secure.c:162: warning: Function parameter or struct member 'arg4' not described in 'rx51_secure_dispatcher'
   arch/arm/mach-omap2/omap-secure.c:196: warning: Function parameter or struct member 'clear_bits' not described in 'rx51_secure_update_aux_cr'
   arch/arm/mach-omap2/omap-secure.c:196: warning: Excess function parameter 'clr_bits' description in 'rx51_secure_update_aux_cr'
>> arch/arm/mach-omap2/omap-secure.c:214: warning: Function parameter or struct member 'ptr' not described in 'rx51_secure_rng_call'
>> arch/arm/mach-omap2/omap-secure.c:214: warning: Function parameter or struct member 'count' not described in 'rx51_secure_rng_call'
>> arch/arm/mach-omap2/omap-secure.c:214: warning: Function parameter or struct member 'flag' not described in 'rx51_secure_rng_call'
--
>> arch/arm/mach-omap2/prm33xx.c:95: warning: Function parameter or struct member 'rstctrl_offs' not described in 'am33xx_prm_assert_hardreset'
>> arch/arm/mach-omap2/prm33xx.c:95: warning: Excess function parameter 'rstctrl_reg' description in 'am33xx_prm_assert_hardreset'
>> arch/arm/mach-omap2/prm33xx.c:125: warning: Function parameter or struct member 'rstctrl_offs' not described in 'am33xx_prm_deassert_hardreset'
>> arch/arm/mach-omap2/prm33xx.c:125: warning: Function parameter or struct member 'rstst_offs' not described in 'am33xx_prm_deassert_hardreset'
>> arch/arm/mach-omap2/prm33xx.c:125: warning: Excess function parameter 'rstctrl_reg' description in 'am33xx_prm_deassert_hardreset'
>> arch/arm/mach-omap2/prm33xx.c:125: warning: Excess function parameter 'rstst_reg' description in 'am33xx_prm_deassert_hardreset'
--
>> arch/arm/mach-omap2/prminst44xx.c:101: warning: Function parameter or struct member 'part' not described in 'omap4_prminst_is_hardreset_asserted'
>> arch/arm/mach-omap2/prminst44xx.c:101: warning: Function parameter or struct member 'inst' not described in 'omap4_prminst_is_hardreset_asserted'
>> arch/arm/mach-omap2/prminst44xx.c:101: warning: Function parameter or struct member 'rstctrl_offs' not described in 'omap4_prminst_is_hardreset_asserted'
>> arch/arm/mach-omap2/prminst44xx.c:101: warning: Excess function parameter 'rstctrl_reg' description in 'omap4_prminst_is_hardreset_asserted'
>> arch/arm/mach-omap2/prminst44xx.c:125: warning: Function parameter or struct member 'part' not described in 'omap4_prminst_assert_hardreset'
>> arch/arm/mach-omap2/prminst44xx.c:125: warning: Function parameter or struct member 'inst' not described in 'omap4_prminst_assert_hardreset'
>> arch/arm/mach-omap2/prminst44xx.c:125: warning: Function parameter or struct member 'rstctrl_offs' not described in 'omap4_prminst_assert_hardreset'
>> arch/arm/mach-omap2/prminst44xx.c:125: warning: Excess function parameter 'rstctrl_reg' description in 'omap4_prminst_assert_hardreset'
--
>> arch/arm/mach-omap2/vc.c:404: warning: Excess function parameter 'off_mode' description in 'omap3_set_i2c_timings'
--
>> arch/arm/mach-omap2/voltage.c:332: warning: Function parameter or struct member 'voltdms' not described in 'voltdm_init'
>> arch/arm/mach-omap2/voltage.c:332: warning: Excess function parameter 'voltdm_list' description in 'voltdm_init'
--
>> arch/arm/mach-omap2/clockdomain.c:546: warning: Function parameter or struct member 'user' not described in 'clkdm_for_each'
   arch/arm/mach-omap2/clockdomain.c:1003: warning: expecting prototype for clkdm_deny_idle(). Prototype was for clkdm_deny_idle_nolock() instead
   arch/arm/mach-omap2/clockdomain.c:1165: warning: Function parameter or struct member 'unused' not described in 'clkdm_clk_enable'
   arch/arm/mach-omap2/clockdomain.c:1165: warning: Excess function parameter 'clk' description in 'clkdm_clk_enable'
>> arch/arm/mach-omap2/clockdomain.c:1303: warning: Function parameter or struct member 'clkdm' not described in '_clkdm_save_context'
>> arch/arm/mach-omap2/clockdomain.c:1303: warning: Function parameter or struct member 'unused' not described in '_clkdm_save_context'
>> arch/arm/mach-omap2/clockdomain.c:1316: warning: Function parameter or struct member 'clkdm' not described in '_clkdm_restore_context'
>> arch/arm/mach-omap2/clockdomain.c:1316: warning: Function parameter or struct member 'unused' not described in '_clkdm_restore_context'
--
>> arch/arm/mach-omap2/powerdomain.c:439: warning: Function parameter or struct member 'user' not described in 'pwrdm_for_each'
>> arch/arm/mach-omap2/powerdomain.c:1234: warning: Function parameter or struct member 'pwrdm' not described in 'pwrdm_save_context'
>> arch/arm/mach-omap2/powerdomain.c:1234: warning: Function parameter or struct member 'unused' not described in 'pwrdm_save_context'
>> arch/arm/mach-omap2/powerdomain.c:1247: warning: Function parameter or struct member 'pwrdm' not described in 'pwrdm_restore_context'
>> arch/arm/mach-omap2/powerdomain.c:1247: warning: Function parameter or struct member 'unused' not described in 'pwrdm_restore_context'
   arch/arm/mach-omap2/powerdomain.c:1247: warning: expecting prototype for pwrdm_save_context(). Prototype was for pwrdm_restore_context() instead
--
>> arch/arm/mach-omap2/clkt2xxx_dpllcore.c:190: warning: Function parameter or struct member 'hw' not described in 'omap2xxx_clkt_dpllcore_init'
>> arch/arm/mach-omap2/clkt2xxx_dpllcore.c:190: warning: Excess function parameter 'clk' description in 'omap2xxx_clkt_dpllcore_init'
--
>> arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c:60: warning: Function parameter or struct member 'parent_rate' not described in 'omap2_table_mpu_recalc'
   arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c:171: warning: expecting prototype for omap2xxx_clkt_vps_check_bootloader_rate(). Prototype was for omap2xxx_clkt_vps_check_bootloader_rates() instead
..


vim +129 arch/arm/mach-omap2/sdrc.c

f2ab99778a1a04 Paul Walmsley 2009-01-28  117  
98cfe5abf24c6d Paul Walmsley 2009-05-12  118  /**
98cfe5abf24c6d Paul Walmsley 2009-05-12  119   * omap2_sdrc_init - initialize SMS, SDRC devices on boot
58cda884ecc87d Jean Pihet    2009-07-24  120   * @sdrc_cs[01]: pointers to a null-terminated list of struct omap_sdrc_params
58cda884ecc87d Jean Pihet    2009-07-24  121   *  Support for 2 chip selects timings
98cfe5abf24c6d Paul Walmsley 2009-05-12  122   *
98cfe5abf24c6d Paul Walmsley 2009-05-12  123   * Turn on smart idle modes for SDRAM scheduler and controller.
98cfe5abf24c6d Paul Walmsley 2009-05-12  124   * Program a known-good configuration for the SDRC to deal with buggy
98cfe5abf24c6d Paul Walmsley 2009-05-12  125   * bootloaders.
98cfe5abf24c6d Paul Walmsley 2009-05-12  126   */
58cda884ecc87d Jean Pihet    2009-07-24  127  void __init omap2_sdrc_init(struct omap_sdrc_params *sdrc_cs0,
58cda884ecc87d Jean Pihet    2009-07-24  128  			    struct omap_sdrc_params *sdrc_cs1)
f2ab99778a1a04 Paul Walmsley 2009-01-28 @129  {

:::::: The code at line 129 was first introduced by commit
:::::: f2ab99778a1a04ddbae38f4de4ef40f2edb92080 [ARM] OMAP2 SDRC: separate common OMAP2/3 code from OMAP2xxx code

:::::: TO: Paul Walmsley <paul@pwsan.com>
:::::: CC: Russell King <rmk+kernel@arm.linux.org.uk>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

