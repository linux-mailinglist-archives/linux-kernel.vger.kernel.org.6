Return-Path: <linux-kernel+bounces-346716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D252598C7CC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 23:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DB171F2297A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 21:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4272B1CEAC5;
	Tue,  1 Oct 2024 21:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HylDdZzL"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFC519B5B1
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 21:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727819892; cv=none; b=Q2htT7Ja+9iFR5rJcsQEBnFUupqsambz6UiIRdoMVT9rGw/rqmYJ9S6z6FVvkFH2QQEkeU35h3CU+Cgu1FUfDlzHO72XZIvdyuX+t4IA0KC+TahFJynUqjLUXTAFmfOVoVPHbgkim5EXBFU5fB2i50h5qBBucT0zIUR9PaYBtz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727819892; c=relaxed/simple;
	bh=3h3XTEJoyhNSAzL2HliLvzAPzgXo4OdwX1F4QJ6YiXE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jB2/64ZS9DpurY4TruXoeOQziLPeuKTtUNPNMNwVw1Hst1zhB4cfrWSR0yrZep5SJckEusWxonGzoWWO8zB+IXdEGPzeboUdIM6yi0OC1O5eG173M6VKpE+7Ldttp1yeefl/7muSZP1oqv6wYt/LZIKi5WW4bmitZzWLEt4Mmfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HylDdZzL; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727819890; x=1759355890;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=3h3XTEJoyhNSAzL2HliLvzAPzgXo4OdwX1F4QJ6YiXE=;
  b=HylDdZzLwD3oDSfNaV3hAMdWVK709m9W6u/UVupF/TvYzmeSo+lW+fIl
   HPO5QPTQ19mT5Ihw04ejjSB994Du2lmTqPqquXtkHRMaVQQVmJ0LmzYtt
   lkRFOC8jDDFbhTpZO2fIXmADyv8bJKLlgr7L3gDUg3hVgpiuznXJN8opI
   /tRhrctSvhrQ//3di59/LpiX2NONMYZYPgV2xn9qASsomh4I5nrD3vVCt
   KYVg+Sc9sDJLKra5DKT+zoMYXJTZh7ILTeaqtU2jtvvJUFDMuHOtrtNac
   nmj/S0J8C8T9R/vMbb4BO1GAodKS+Bw4oPBEO8opxF58nNpmlthbbw0kF
   w==;
X-CSE-ConnectionGUID: JYFnDYX+S+qALXTqYvJPeQ==
X-CSE-MsgGUID: bFkq1fXtRgqFI2lXd55aBQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="27154547"
X-IronPort-AV: E=Sophos;i="6.11,169,1725346800"; 
   d="scan'208";a="27154547"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 14:58:10 -0700
X-CSE-ConnectionGUID: yxmB+VMUTMmvofbBkHMOGQ==
X-CSE-MsgGUID: QKv+rDVLQa6UKFmhaZZe2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,169,1725346800"; 
   d="scan'208";a="111280137"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 01 Oct 2024 14:58:09 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1svksf-000RDZ-2U;
	Tue, 01 Oct 2024 21:58:05 +0000
Date: Wed, 2 Oct 2024 05:57:34 +0800
From: kernel test robot <lkp@intel.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>
Subject: drivers/mfd/intel-m10-bmc-spi.c:28:10: error: 'const struct
 regmap_config' has no member named 'reg_bits'
Message-ID: <202410020505.B2WRKx9B-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e32cde8d2bd7d251a8f9b434143977ddf13dcec6
commit: 9842c62162858c7b0625dd3e00085b68167257d3 mfd: intel-m10-bmc: Constify struct regmap_config
date:   5 weeks ago
config: x86_64-randconfig-001-20231120 (https://download.01.org/0day-ci/archive/20241002/202410020505.B2WRKx9B-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241002/202410020505.B2WRKx9B-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410020505.B2WRKx9B-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/sched.h:38,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from drivers/mfd/intel-m10-bmc-spi.c:8:
   include/linux/mm_types_task.h:19:45: warning: "CONFIG_SPLIT_PTLOCK_CPUS" is not defined, evaluates to 0 [-Wundef]
      19 | #define USE_SPLIT_PTE_PTLOCKS   (NR_CPUS >= CONFIG_SPLIT_PTLOCK_CPUS)
         |                                             ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/mm.h:2888:5: note: in expansion of macro 'USE_SPLIT_PTE_PTLOCKS'
    2888 | #if USE_SPLIT_PTE_PTLOCKS
         |     ^~~~~~~~~~~~~~~~~~~~~
   include/linux/mm_types_task.h:19:45: warning: "CONFIG_SPLIT_PTLOCK_CPUS" is not defined, evaluates to 0 [-Wundef]
      19 | #define USE_SPLIT_PTE_PTLOCKS   (NR_CPUS >= CONFIG_SPLIT_PTLOCK_CPUS)
         |                                             ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/mm_types_task.h:20:34: note: in expansion of macro 'USE_SPLIT_PTE_PTLOCKS'
      20 | #define USE_SPLIT_PMD_PTLOCKS   (USE_SPLIT_PTE_PTLOCKS && \
         |                                  ^~~~~~~~~~~~~~~~~~~~~
   include/linux/mm.h:3010:5: note: in expansion of macro 'USE_SPLIT_PMD_PTLOCKS'
    3010 | #if USE_SPLIT_PMD_PTLOCKS
         |     ^~~~~~~~~~~~~~~~~~~~~
   drivers/mfd/intel-m10-bmc-spi.c:16:34: error: array type has incomplete element type 'struct regmap_range'
      16 | static const struct regmap_range m10bmc_regmap_range[] = {
         |                                  ^~~~~~~~~~~~~~~~~~~
   drivers/mfd/intel-m10-bmc-spi.c:17:9: error: implicit declaration of function 'regmap_reg_range'; did you mean 'remap_pfn_range'? [-Werror=implicit-function-declaration]
      17 |         regmap_reg_range(M10BMC_N3000_LEGACY_BUILD_VER, M10BMC_N3000_LEGACY_BUILD_VER),
         |         ^~~~~~~~~~~~~~~~
         |         remap_pfn_range
   drivers/mfd/intel-m10-bmc-spi.c:22:21: error: variable 'm10bmc_access_table' has initializer but incomplete type
      22 | static const struct regmap_access_table m10bmc_access_table = {
         |                     ^~~~~~~~~~~~~~~~~~~
   drivers/mfd/intel-m10-bmc-spi.c:23:10: error: 'const struct regmap_access_table' has no member named 'yes_ranges'
      23 |         .yes_ranges     = m10bmc_regmap_range,
         |          ^~~~~~~~~~
   drivers/mfd/intel-m10-bmc-spi.c:23:27: warning: excess elements in struct initializer
      23 |         .yes_ranges     = m10bmc_regmap_range,
         |                           ^~~~~~~~~~~~~~~~~~~
   drivers/mfd/intel-m10-bmc-spi.c:23:27: note: (near initialization for 'm10bmc_access_table')
   drivers/mfd/intel-m10-bmc-spi.c:24:10: error: 'const struct regmap_access_table' has no member named 'n_yes_ranges'
      24 |         .n_yes_ranges   = ARRAY_SIZE(m10bmc_regmap_range),
         |          ^~~~~~~~~~~~
   In file included from include/linux/bitfield.h:10,
                    from drivers/mfd/intel-m10-bmc-spi.c:7:
   include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/compiler.h:243:33: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     243 | #define __must_be_array(a)      BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
         |                                 ^~~~~~~~~~~~~~~~~
   include/linux/array_size.h:11:59: note: in expansion of macro '__must_be_array'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                           ^~~~~~~~~~~~~~~
   drivers/mfd/intel-m10-bmc-spi.c:24:27: note: in expansion of macro 'ARRAY_SIZE'
      24 |         .n_yes_ranges   = ARRAY_SIZE(m10bmc_regmap_range),
         |                           ^~~~~~~~~~
   In file included from include/linux/kernel.h:16,
                    from include/linux/cpumask.h:11,
                    from arch/x86/include/asm/tlbbatch.h:5,
                    from include/linux/mm_types_task.h:16:
   include/linux/array_size.h:11:25: warning: excess elements in struct initializer
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                         ^
   drivers/mfd/intel-m10-bmc-spi.c:24:27: note: in expansion of macro 'ARRAY_SIZE'
      24 |         .n_yes_ranges   = ARRAY_SIZE(m10bmc_regmap_range),
         |                           ^~~~~~~~~~
   include/linux/array_size.h:11:25: note: (near initialization for 'm10bmc_access_table')
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                         ^
   drivers/mfd/intel-m10-bmc-spi.c:24:27: note: in expansion of macro 'ARRAY_SIZE'
      24 |         .n_yes_ranges   = ARRAY_SIZE(m10bmc_regmap_range),
         |                           ^~~~~~~~~~
   drivers/mfd/intel-m10-bmc-spi.c:27:21: error: variable 'intel_m10bmc_regmap_config' has initializer but incomplete type
      27 | static const struct regmap_config intel_m10bmc_regmap_config = {
         |                     ^~~~~~~~~~~~~
>> drivers/mfd/intel-m10-bmc-spi.c:28:10: error: 'const struct regmap_config' has no member named 'reg_bits'
      28 |         .reg_bits = 32,
         |          ^~~~~~~~
   drivers/mfd/intel-m10-bmc-spi.c:28:21: warning: excess elements in struct initializer
      28 |         .reg_bits = 32,
         |                     ^~
   drivers/mfd/intel-m10-bmc-spi.c:28:21: note: (near initialization for 'intel_m10bmc_regmap_config')
>> drivers/mfd/intel-m10-bmc-spi.c:29:10: error: 'const struct regmap_config' has no member named 'val_bits'
      29 |         .val_bits = 32,
         |          ^~~~~~~~
   drivers/mfd/intel-m10-bmc-spi.c:29:21: warning: excess elements in struct initializer
      29 |         .val_bits = 32,
         |                     ^~
   drivers/mfd/intel-m10-bmc-spi.c:29:21: note: (near initialization for 'intel_m10bmc_regmap_config')
>> drivers/mfd/intel-m10-bmc-spi.c:30:10: error: 'const struct regmap_config' has no member named 'reg_stride'
      30 |         .reg_stride = 4,
         |          ^~~~~~~~~~
   drivers/mfd/intel-m10-bmc-spi.c:30:23: warning: excess elements in struct initializer
      30 |         .reg_stride = 4,
         |                       ^
   drivers/mfd/intel-m10-bmc-spi.c:30:23: note: (near initialization for 'intel_m10bmc_regmap_config')
>> drivers/mfd/intel-m10-bmc-spi.c:31:10: error: 'const struct regmap_config' has no member named 'wr_table'
      31 |         .wr_table = &m10bmc_access_table,
         |          ^~~~~~~~
   drivers/mfd/intel-m10-bmc-spi.c:31:21: warning: excess elements in struct initializer
      31 |         .wr_table = &m10bmc_access_table,
         |                     ^
   drivers/mfd/intel-m10-bmc-spi.c:31:21: note: (near initialization for 'intel_m10bmc_regmap_config')
>> drivers/mfd/intel-m10-bmc-spi.c:32:10: error: 'const struct regmap_config' has no member named 'rd_table'
      32 |         .rd_table = &m10bmc_access_table,
         |          ^~~~~~~~
   drivers/mfd/intel-m10-bmc-spi.c:32:21: warning: excess elements in struct initializer
      32 |         .rd_table = &m10bmc_access_table,
         |                     ^
   drivers/mfd/intel-m10-bmc-spi.c:32:21: note: (near initialization for 'intel_m10bmc_regmap_config')
>> drivers/mfd/intel-m10-bmc-spi.c:33:10: error: 'const struct regmap_config' has no member named 'max_register'
      33 |         .max_register = M10BMC_N3000_MEM_END,
         |          ^~~~~~~~~~~~
   In file included from drivers/mfd/intel-m10-bmc-spi.c:11:
   include/linux/mfd/intel-m10-bmc.h:20:41: warning: excess elements in struct initializer
      20 | #define M10BMC_N3000_FLASH_END          0x1fffffff
         |                                         ^~~~~~~~~~
   include/linux/mfd/intel-m10-bmc.h:21:41: note: in expansion of macro 'M10BMC_N3000_FLASH_END'
      21 | #define M10BMC_N3000_MEM_END            M10BMC_N3000_FLASH_END
         |                                         ^~~~~~~~~~~~~~~~~~~~~~
   drivers/mfd/intel-m10-bmc-spi.c:33:25: note: in expansion of macro 'M10BMC_N3000_MEM_END'
      33 |         .max_register = M10BMC_N3000_MEM_END,
         |                         ^~~~~~~~~~~~~~~~~~~~
   include/linux/mfd/intel-m10-bmc.h:20:41: note: (near initialization for 'intel_m10bmc_regmap_config')
      20 | #define M10BMC_N3000_FLASH_END          0x1fffffff
         |                                         ^~~~~~~~~~
   include/linux/mfd/intel-m10-bmc.h:21:41: note: in expansion of macro 'M10BMC_N3000_FLASH_END'
      21 | #define M10BMC_N3000_MEM_END            M10BMC_N3000_FLASH_END
         |                                         ^~~~~~~~~~~~~~~~~~~~~~
   drivers/mfd/intel-m10-bmc-spi.c:33:25: note: in expansion of macro 'M10BMC_N3000_MEM_END'
      33 |         .max_register = M10BMC_N3000_MEM_END,
         |                         ^~~~~~~~~~~~~~~~~~~~
   drivers/mfd/intel-m10-bmc-spi.c: In function 'intel_m10_bmc_spi_probe':
   drivers/mfd/intel-m10-bmc-spi.c:76:25: error: implicit declaration of function 'devm_regmap_init_spi_avmm' [-Werror=implicit-function-declaration]
      76 |         ddata->regmap = devm_regmap_init_spi_avmm(spi, &intel_m10bmc_regmap_config);
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/mfd/intel-m10-bmc-spi.c:76:23: warning: assignment to 'struct regmap *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
      76 |         ddata->regmap = devm_regmap_init_spi_avmm(spi, &intel_m10bmc_regmap_config);
         |                       ^
   drivers/mfd/intel-m10-bmc-spi.c: At top level:
   drivers/mfd/intel-m10-bmc-spi.c:120:34: error: array type has incomplete element type 'struct regmap_range'
     120 | static const struct regmap_range m10bmc_d5005_fw_handshake_regs[] = {
         |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/mfd/intel-m10-bmc-spi.c:130:34: error: array type has incomplete element type 'struct regmap_range'
     130 | static const struct regmap_range m10bmc_n3000_fw_handshake_regs[] = {
         |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/compiler.h:243:33: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     243 | #define __must_be_array(a)      BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
         |                                 ^~~~~~~~~~~~~~~~~
   include/linux/array_size.h:11:59: note: in expansion of macro '__must_be_array'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                           ^~~~~~~~~~~~~~~
   drivers/mfd/intel-m10-bmc-spi.c:142:38: note: in expansion of macro 'ARRAY_SIZE'
     142 |         .handshake_sys_reg_nranges = ARRAY_SIZE(m10bmc_n3000_fw_handshake_regs),
         |                                      ^~~~~~~~~~
   include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/compiler.h:243:33: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     243 | #define __must_be_array(a)      BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
         |                                 ^~~~~~~~~~~~~~~~~
   include/linux/array_size.h:11:59: note: in expansion of macro '__must_be_array'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                           ^~~~~~~~~~~~~~~
   drivers/mfd/intel-m10-bmc-spi.c:150:38: note: in expansion of macro 'ARRAY_SIZE'
     150 |         .handshake_sys_reg_nranges = ARRAY_SIZE(m10bmc_d5005_fw_handshake_regs),
         |                                      ^~~~~~~~~~
   include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/compiler.h:243:33: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     243 | #define __must_be_array(a)      BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
         |                                 ^~~~~~~~~~~~~~~~~
   include/linux/array_size.h:11:59: note: in expansion of macro '__must_be_array'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                           ^~~~~~~~~~~~~~~
   drivers/mfd/intel-m10-bmc-spi.c:158:38: note: in expansion of macro 'ARRAY_SIZE'
     158 |         .handshake_sys_reg_nranges = ARRAY_SIZE(m10bmc_n3000_fw_handshake_regs),
         |                                      ^~~~~~~~~~
   drivers/mfd/intel-m10-bmc-spi.c:22:41: error: storage size of 'm10bmc_access_table' isn't known
      22 | static const struct regmap_access_table m10bmc_access_table = {
         |                                         ^~~~~~~~~~~~~~~~~~~
   drivers/mfd/intel-m10-bmc-spi.c:27:35: error: storage size of 'intel_m10bmc_regmap_config' isn't known
      27 | static const struct regmap_config intel_m10bmc_regmap_config = {
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/mfd/intel-m10-bmc-spi.c:130:34: warning: 'm10bmc_n3000_fw_handshake_regs' defined but not used [-Wunused-variable]
     130 | static const struct regmap_range m10bmc_n3000_fw_handshake_regs[] = {
         |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/mfd/intel-m10-bmc-spi.c:120:34: warning: 'm10bmc_d5005_fw_handshake_regs' defined but not used [-Wunused-variable]
     120 | static const struct regmap_range m10bmc_d5005_fw_handshake_regs[] = {
         |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/mfd/intel-m10-bmc-spi.c:16:34: warning: 'm10bmc_regmap_range' defined but not used [-Wunused-variable]
      16 | static const struct regmap_range m10bmc_regmap_range[] = {
         |                                  ^~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +28 drivers/mfd/intel-m10-bmc-spi.c

8169f74ca6f318 drivers/mfd/intel-m10-bmc.c     Matthew Gerlach 2021-03-10  26  
9842c62162858c drivers/mfd/intel-m10-bmc-spi.c Javier Carrasco 2024-07-04  27  static const struct regmap_config intel_m10bmc_regmap_config = {
876611c493b10c drivers/mfd/intel-m10-bmc.c     Xu Yilun        2020-09-15 @28  	.reg_bits = 32,
876611c493b10c drivers/mfd/intel-m10-bmc.c     Xu Yilun        2020-09-15 @29  	.val_bits = 32,
876611c493b10c drivers/mfd/intel-m10-bmc.c     Xu Yilun        2020-09-15 @30  	.reg_stride = 4,
8169f74ca6f318 drivers/mfd/intel-m10-bmc.c     Matthew Gerlach 2021-03-10 @31  	.wr_table = &m10bmc_access_table,
8169f74ca6f318 drivers/mfd/intel-m10-bmc.c     Matthew Gerlach 2021-03-10 @32  	.rd_table = &m10bmc_access_table,
bcababfc60ccc6 drivers/mfd/intel-m10-bmc-spi.c Ilpo Järvinen   2023-01-16 @33  	.max_register = M10BMC_N3000_MEM_END,
876611c493b10c drivers/mfd/intel-m10-bmc.c     Xu Yilun        2020-09-15  34  };
876611c493b10c drivers/mfd/intel-m10-bmc.c     Xu Yilun        2020-09-15  35  

:::::: The code at line 28 was first introduced by commit
:::::: 876611c493b10cbb59e0e2143d3e744d0442de63 mfd: intel-m10-bmc: Add Intel MAX 10 BMC chip support for Intel FPGA PAC

:::::: TO: Xu Yilun <yilun.xu@intel.com>
:::::: CC: Lee Jones <lee.jones@linaro.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

