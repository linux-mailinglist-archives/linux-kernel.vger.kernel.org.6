Return-Path: <linux-kernel+bounces-251770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10AFE93098E
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 12:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 866C71F211D2
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 10:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C024E4AECB;
	Sun, 14 Jul 2024 10:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U9kU5z1x"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31A226AE6
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 10:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720952593; cv=none; b=j4pSPvzg+ReStr3bGAT/Y51yq/oV8huRnBMvH2FKkdglfkKcqlLHPrm4s3FEYFoE3JqPtlB30Np4UytOmofrsDuJyiucoM78ljbmunR4hfM0JvlGKnfT6kFojkkqI4q2gdeEtS89+HDoeDlfOQp01mx+SrsbOqgTqiN/+b2l5h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720952593; c=relaxed/simple;
	bh=DrK+sFkNxhsloKdLTBDOjsh0AGK/q3cN4UAXOv1Jwek=;
	h=Date:From:To:Cc:Subject:Message-ID; b=iumzeddXBJfl+4mHCN+LrTuYBW9k8Ry6UcJDSzsjwpbO6kIyFynm8hTV9buaDlRfRVEKshwmMYf1S99sLnt19s8Sl1xSHqP829lnY/tOOOaM+yyzksxvVlGv79RJ8WxIqW0TH65APeNK/VawJ8CMRkIDKVgqcBatp5GN3TGkq6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U9kU5z1x; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720952591; x=1752488591;
  h=date:from:to:cc:subject:message-id;
  bh=DrK+sFkNxhsloKdLTBDOjsh0AGK/q3cN4UAXOv1Jwek=;
  b=U9kU5z1xl8ssrEnYDyqwGHbDVk6XjjBi6I2zwGW+LXiXD6iHUb5bI2oY
   7pJqX/jdl0ecoLj/w6eMqrrhp/3mRs7Eh7+68PIzC3H/QrUVKryFaML1g
   M8YbFc462PM1KGnIx0qXXUNvBcmXb5vbQHvne0LDelrIFWKpr/oLpnIna
   OoPVpA8xDW36/NT3jZRJPoQ/S846897n1ucejLYKwH4fj3Hs2tr1OiveH
   MS74X3NkoYMCUes0by/fTuCmSYxDQ26dyQXd1vV/QWBnxR/xVy6Mt5mJF
   8ye/gCRObZjG0OVbQG/0ZD1bzGSGu52bQtR7Bydda09b3tFpHM7YWsCim
   A==;
X-CSE-ConnectionGUID: QWP9Q82LS4KPh93EX/KLYA==
X-CSE-MsgGUID: vvutpWbdT0Si5erzUOCmcg==
X-IronPort-AV: E=McAfee;i="6700,10204,11132"; a="18474688"
X-IronPort-AV: E=Sophos;i="6.09,207,1716274800"; 
   d="scan'208";a="18474688"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2024 03:23:11 -0700
X-CSE-ConnectionGUID: qgO4hED4TX2WRm9vdn2wHQ==
X-CSE-MsgGUID: OTo58MQ4TbKH1M14GTZgRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,207,1716274800"; 
   d="scan'208";a="53635977"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 14 Jul 2024 03:23:09 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sSwNn-000dKz-2y;
	Sun, 14 Jul 2024 10:23:07 +0000
Date: Sun, 14 Jul 2024 18:22:16 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:irq/core] BUILD SUCCESS
 8ca1d93bba1fde64236fc44eecb80ce6993be115
Message-ID: <202407141814.hiB5l5y5-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
branch HEAD: 8ca1d93bba1fde64236fc44eecb80ce6993be115  irqdomain: Fix the kernel-doc and plug it into Documentation

elapsed time: 1406m

configs tested: 164
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.3.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240714   gcc-13.2.0
arc                   randconfig-002-20240714   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-19
arm                              allyesconfig   gcc-14.1.0
arm                                 defconfig   clang-14
arm                        multi_v7_defconfig   gcc-14.1.0
arm                           omap1_defconfig   gcc-14.1.0
arm                   randconfig-001-20240714   clang-19
arm                   randconfig-002-20240714   clang-15
arm                   randconfig-003-20240714   clang-17
arm                   randconfig-004-20240714   clang-15
arm                             rpc_defconfig   clang-19
arm                       versatile_defconfig   gcc-14.1.0
arm64                            allmodconfig   clang-19
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-14.1.0
arm64                 randconfig-001-20240714   clang-15
arm64                 randconfig-002-20240714   clang-19
arm64                 randconfig-003-20240714   clang-19
arm64                 randconfig-004-20240714   gcc-14.1.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-14.1.0
csky                  randconfig-001-20240714   gcc-14.1.0
csky                  randconfig-002-20240714   gcc-14.1.0
hexagon                          alldefconfig   clang-15
hexagon                          allmodconfig   clang-19
hexagon                           allnoconfig   clang-19
hexagon                          allyesconfig   clang-19
hexagon                             defconfig   clang-19
hexagon               randconfig-001-20240714   clang-19
hexagon               randconfig-002-20240714   clang-19
i386                             allmodconfig   gcc-13
i386                              allnoconfig   gcc-13
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240713   clang-18
i386         buildonly-randconfig-002-20240713   clang-18
i386         buildonly-randconfig-003-20240713   gcc-8
i386         buildonly-randconfig-004-20240713   clang-18
i386         buildonly-randconfig-005-20240713   gcc-13
i386         buildonly-randconfig-006-20240713   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240713   gcc-10
i386                  randconfig-002-20240713   gcc-13
i386                  randconfig-003-20240713   gcc-13
i386                  randconfig-004-20240713   clang-18
i386                  randconfig-005-20240713   gcc-10
i386                  randconfig-006-20240713   gcc-12
i386                  randconfig-011-20240713   clang-18
i386                  randconfig-012-20240713   gcc-7
i386                  randconfig-013-20240713   gcc-13
i386                  randconfig-014-20240713   gcc-13
i386                  randconfig-015-20240713   gcc-11
i386                  randconfig-016-20240713   clang-18
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-14.1.0
loongarch             randconfig-001-20240714   gcc-14.1.0
loongarch             randconfig-002-20240714   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-14.1.0
m68k                        mvme16x_defconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
mips                     loongson1b_defconfig   clang-15
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-14.1.0
nios2                 randconfig-001-20240714   gcc-14.1.0
nios2                 randconfig-002-20240714   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
openrisc                    or1ksim_defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240714   gcc-14.1.0
parisc                randconfig-002-20240714   gcc-14.1.0
parisc64                            defconfig   gcc-14.1.0
powerpc                     akebono_defconfig   clang-19
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-19
powerpc                      bamboo_defconfig   clang-19
powerpc                   bluestone_defconfig   clang-19
powerpc                      ep88xc_defconfig   gcc-14.1.0
powerpc                      pmac32_defconfig   clang-19
powerpc               randconfig-001-20240714   clang-19
powerpc               randconfig-002-20240714   clang-19
powerpc               randconfig-003-20240714   gcc-14.1.0
powerpc64             randconfig-001-20240714   gcc-14.1.0
powerpc64             randconfig-002-20240714   gcc-14.1.0
powerpc64             randconfig-003-20240714   gcc-14.1.0
riscv                            allmodconfig   clang-19
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-19
riscv                               defconfig   clang-19
riscv                 randconfig-001-20240714   clang-19
riscv                 randconfig-002-20240714   clang-15
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   clang-19
s390                  randconfig-001-20240714   clang-19
s390                  randconfig-002-20240714   gcc-14.1.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                    randconfig-001-20240714   gcc-14.1.0
sh                    randconfig-002-20240714   gcc-14.1.0
sh                   sh7724_generic_defconfig   gcc-14.1.0
sh                   sh7770_generic_defconfig   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
um                               allmodconfig   clang-19
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-13
um                                  defconfig   clang-19
um                             i386_defconfig   gcc-13
um                           x86_64_defconfig   clang-15
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240714   clang-18
x86_64       buildonly-randconfig-002-20240714   gcc-13
x86_64       buildonly-randconfig-003-20240714   gcc-13
x86_64       buildonly-randconfig-004-20240714   clang-18
x86_64       buildonly-randconfig-005-20240714   clang-18
x86_64       buildonly-randconfig-006-20240714   clang-18
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240714   gcc-13
x86_64                randconfig-002-20240714   clang-18
x86_64                randconfig-003-20240714   gcc-13
x86_64                randconfig-004-20240714   clang-18
x86_64                randconfig-005-20240714   gcc-10
x86_64                randconfig-006-20240714   gcc-10
x86_64                randconfig-011-20240714   clang-18
x86_64                randconfig-012-20240714   gcc-7
x86_64                randconfig-013-20240714   clang-18
x86_64                randconfig-014-20240714   clang-18
x86_64                randconfig-015-20240714   gcc-13
x86_64                randconfig-016-20240714   clang-18
x86_64                randconfig-071-20240714   clang-18
x86_64                randconfig-072-20240714   gcc-13
x86_64                randconfig-073-20240714   clang-18
x86_64                randconfig-074-20240714   clang-18
x86_64                randconfig-075-20240714   clang-18
x86_64                randconfig-076-20240714   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-14.1.0
xtensa                generic_kc705_defconfig   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

