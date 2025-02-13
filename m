Return-Path: <linux-kernel+bounces-513435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28829A34A48
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 484E117329F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C375624A04D;
	Thu, 13 Feb 2025 16:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wh56/45F"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83A024A040
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 16:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739463781; cv=none; b=h4Xn132VeKKBALCl+N9XpL7VRUUf5jww7PWMQfL3Rnh9VnHVMSFkbPJOUE7OuLT/1hL+p1WDVre+e+1k5dL9YBEceEvqUiTdTWIEqnbAYyxI4lQhGzP7kKhYt0grXjgmK8HRn3TkhWP9L/lIZR7CYIJH8f+xK4aLrHa/bYMcgD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739463781; c=relaxed/simple;
	bh=Bnyl5LtFtQR9/EzIuPGJzG2d59pl6dtmSlp6/rOZn3k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mppwU8vUZ5ta54j4cQ1nMc+cwChceNzQKAXgVp8aTnyjKL2gGWuePrEWVz8mcC1lDhS1HHr7cGOAyUyHVjX4d2dQkN3WDTq6byH1+mH7yvrGFCbdVnMNTi/buKtL3dYlwqUDZre3A4esFTDmN/ts5rmHPElkSRrDvx4lg6eB0+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wh56/45F; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739463780; x=1770999780;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Bnyl5LtFtQR9/EzIuPGJzG2d59pl6dtmSlp6/rOZn3k=;
  b=Wh56/45FwBdqMVTHsjgyMNTnOWIWFL8aWduZc2KxQ60h9H5I7Vs3MQuN
   wUvdBQ6buVaL5Qj2xV5ecXyhlAi+Z56BkT7hhQ5xgnP0j5didfvo0Gksy
   2BF4TMMMsJW3UUjYgqpJvwBvtSX6yReYMZ/i3Pejf/6zRNye2t7610Eti
   +EiRezrRekRZc91D1zfGuERLZ7BCV93g6hC9LnXFblgQTK7xovuoTOOO8
   xoUUvxqS8RGlxQ4G97P+waFi+8rAPOnkGku+GRiyBK4m812irPQHuqh0X
   N2DFLmVUUegE9I10DvELvTekgndxWX39Y9sq6+pxNQf8ZraGRQXyt3Yc3
   g==;
X-CSE-ConnectionGUID: Dh0WmMuHTNizc8sj0zSoxg==
X-CSE-MsgGUID: cJcZ6oQZTq6MhzZixLy2/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="43941185"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="43941185"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 08:22:59 -0800
X-CSE-ConnectionGUID: VwyDn76jQn6/xtpVvyKDqg==
X-CSE-MsgGUID: z4mrvoy1TIShsijOOWLlkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="113157050"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 13 Feb 2025 08:22:57 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tibzL-0018Q1-0V;
	Thu, 13 Feb 2025 16:22:55 +0000
Date: Fri, 14 Feb 2025 00:22:17 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/wfamnae-next20250212 12/12]
 drivers/gpu/drm/amd/amdgpu/../pm/legacy-dpm/si_dpm.c:5237:21: error: no
 member named 'levels' in 'struct SISLANDS_SMC_SWSTATE_HDR'
Message-ID: <202502140000.KIQUxLr5-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/wfamnae-next20250212
head:   513cdf5e772efc6cb8a92344b0f436e77c2b42f7
commit: 513cdf5e772efc6cb8a92344b0f436e77c2b42f7 [12/12] drm/amd/pm: Avoid multiple -Wflex-array-member-not-at-end warnings
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20250214/202502140000.KIQUxLr5-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250214/202502140000.KIQUxLr5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502140000.KIQUxLr5-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/gpu/drm/amd/amdgpu/../pm/legacy-dpm/si_dpm.c:24:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:181:
   In file included from arch/s390/include/asm/mmu_context.h:11:
   In file included from arch/s390/include/asm/pgalloc.h:18:
   In file included from include/linux/mm.h:2193:
   include/linux/vmstat.h:493:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     493 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     494 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:500:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     500 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     501 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:513:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     513 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     514 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../pm/legacy-dpm/si_dpm.c:5237:21: error: no member named 'levels' in 'struct SISLANDS_SMC_SWSTATE_HDR'
    5237 |         table->driverState.levels[0] = table->initialState.level;
         |         ~~~~~~~~~~~~~~~~~~ ^
>> drivers/gpu/drm/amd/amdgpu/../pm/legacy-dpm/si_dpm.c:5758:24: error: incompatible pointer types initializing 'SISLANDS_SMC_SWSTATE *' (aka 'struct SISLANDS_SMC_SWSTATE *') with an expression of type 'struct SISLANDS_SMC_SWSTATE_HDR *' [-Werror,-Wincompatible-pointer-types]
    5758 |         SISLANDS_SMC_SWSTATE *smc_state = &si_pi->smc_statetable.driverState;
         |                               ^           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   3 warnings and 2 errors generated.


vim +5237 drivers/gpu/drm/amd/amdgpu/../pm/legacy-dpm/si_dpm.c

841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  5177  
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  5178  static int si_init_smc_table(struct amdgpu_device *adev)
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  5179  {
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  5180  	struct si_power_info *si_pi = si_get_pi(adev);
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  5181  	struct amdgpu_ps *amdgpu_boot_state = adev->pm.dpm.boot_ps;
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  5182  	const struct si_ulv_param *ulv = &si_pi->ulv;
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  5183  	SISLANDS_SMC_STATETABLE  *table = &si_pi->smc_statetable;
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  5184  	int ret;
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  5185  	u32 lane_width;
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  5186  	u32 vr_hot_gpio;
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  5187  
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  5188  	si_populate_smc_voltage_tables(adev, table);
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  5189  
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  5190  	switch (adev->pm.int_thermal_type) {
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  5191  	case THERMAL_TYPE_SI:
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  5192  	case THERMAL_TYPE_EMC2103_WITH_INTERNAL:
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  5193  		table->thermalProtectType = PPSMC_THERMAL_PROTECT_TYPE_INTERNAL;
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  5194  		break;
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  5195  	case THERMAL_TYPE_NONE:
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  5196  		table->thermalProtectType = PPSMC_THERMAL_PROTECT_TYPE_NONE;
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  5197  		break;
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  5198  	default:
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  5199  		table->thermalProtectType = PPSMC_THERMAL_PROTECT_TYPE_EXTERNAL;
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  5200  		break;
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  5201  	}
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  5202  
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  5203  	if (adev->pm.dpm.platform_caps & ATOM_PP_PLATFORM_CAP_HARDWAREDC)
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  5204  		table->systemFlags |= PPSMC_SYSTEMFLAG_GPIO_DC;
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  5205  
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  5206  	if (adev->pm.dpm.platform_caps & ATOM_PP_PLATFORM_CAP_REGULATOR_HOT) {
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  5207  		if ((adev->pdev->device != 0x6818) && (adev->pdev->device != 0x6819))
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  5208  			table->systemFlags |= PPSMC_SYSTEMFLAG_REGULATOR_HOT;
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  5209  	}
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  5210  
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  5211  	if (adev->pm.dpm.platform_caps & ATOM_PP_PLATFORM_CAP_STEPVDDC)
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  5212  		table->systemFlags |= PPSMC_SYSTEMFLAG_STEPVDDC;
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  5213  
770d13b19fdf36 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Christian König     2018-01-12  5214  	if (adev->gmc.vram_type == AMDGPU_VRAM_TYPE_GDDR5)
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  5215  		table->systemFlags |= PPSMC_SYSTEMFLAG_GDDR5;
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  5216  
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  5217  	if (adev->pm.dpm.platform_caps & ATOM_PP_PLATFORM_CAP_REVERT_GPIO5_POLARITY)
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  5218  		table->extraFlags |= PPSMC_EXTRAFLAGS_AC2DC_GPIO5_POLARITY_HIGH;
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  5219  
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  5220  	if (adev->pm.dpm.platform_caps & ATOM_PP_PLATFORM_CAP_VRHOT_GPIO_CONFIGURABLE) {
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  5221  		table->systemFlags |= PPSMC_SYSTEMFLAG_REGULATOR_HOT_PROG_GPIO;
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  5222  		vr_hot_gpio = adev->pm.dpm.backbias_response_time;
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  5223  		si_write_smc_soft_register(adev, SI_SMC_SOFT_REGISTER_vr_hot_gpio,
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  5224  					   vr_hot_gpio);
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  5225  	}
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  5226  
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  5227  	ret = si_populate_smc_initial_state(adev, amdgpu_boot_state, table);
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  5228  	if (ret)
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  5229  		return ret;
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  5230  
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  5231  	ret = si_populate_smc_acpi_state(adev, table);
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  5232  	if (ret)
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  5233  		return ret;
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  5234  
939baec9e895e7 drivers/gpu/drm/amd/pm/powerplay/si_dpm.c Gustavo A. R. Silva 2021-05-10  5235  	table->driverState.flags = table->initialState.flags;
939baec9e895e7 drivers/gpu/drm/amd/pm/powerplay/si_dpm.c Gustavo A. R. Silva 2021-05-10  5236  	table->driverState.levelCount = table->initialState.levelCount;
939baec9e895e7 drivers/gpu/drm/amd/pm/powerplay/si_dpm.c Gustavo A. R. Silva 2021-05-10 @5237  	table->driverState.levels[0] = table->initialState.level;
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  5238  
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  5239  	ret = si_do_program_memory_timing_parameters(adev, amdgpu_boot_state,
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  5240  						     SISLANDS_INITIAL_STATE_ARB_INDEX);
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  5241  	if (ret)
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  5242  		return ret;
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  5243  
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  5244  	if (ulv->supported && ulv->pl.vddc) {
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  5245  		ret = si_populate_ulv_state(adev, &table->ULVState);
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  5246  		if (ret)
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  5247  			return ret;
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  5248  
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  5249  		ret = si_program_ulv_memory_timing_parameters(adev);
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  5250  		if (ret)
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  5251  			return ret;
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  5252  
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  5253  		WREG32(CG_ULV_CONTROL, ulv->cg_ulv_control);
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  5254  		WREG32(CG_ULV_PARAMETER, ulv->cg_ulv_parameter);
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  5255  
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  5256  		lane_width = amdgpu_get_pcie_lanes(adev);
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  5257  		si_write_smc_soft_register(adev, SI_SMC_SOFT_REGISTER_non_ulv_pcie_link_width, lane_width);
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  5258  	} else {
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  5259  		table->ULVState = table->initialState;
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  5260  	}
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  5261  
6861c837e28e1b drivers/gpu/drm/amd/amdgpu/si_dpm.c       Alex Deucher        2016-09-13  5262  	return amdgpu_si_copy_bytes_to_smc(adev, si_pi->state_table_start,
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  5263  					   (u8 *)table, sizeof(SISLANDS_SMC_STATETABLE),
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  5264  					   si_pi->sram_end);
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  5265  }
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  5266  

:::::: The code at line 5237 was first introduced by commit
:::::: 939baec9e895e75149327c01b775f46c21e12be5 drm/amd/pm: Fix out-of-bounds bug

:::::: TO: Gustavo A. R. Silva <gustavoars@kernel.org>
:::::: CC: Alex Deucher <alexander.deucher@amd.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

