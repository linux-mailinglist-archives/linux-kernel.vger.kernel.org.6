Return-Path: <linux-kernel+bounces-436254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C60E69E8349
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 04:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81DDD281C46
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 03:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271F81B960;
	Sun,  8 Dec 2024 03:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MCEdZ+pZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952F454738
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 03:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733627590; cv=none; b=L+Prn3skBD1GtUi1MjXVyUQQIFGngXzTNpN0VQKCD5IA/8G9txIy5mThLy/sU0WLGqh36rhcP+wAJnrtHpnMq+LerPZZ7Z43tc5J7/nsXbtwWQ3JaqqFAsSJga9b/Uyu9J3XOTN7qle3RbTPQBK6YJYoHSq9wDYSnFLIhcNmSAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733627590; c=relaxed/simple;
	bh=jz/t0pPMi5bWp4WBX+9SwF+NfW0y78eCbGbFVr1fasc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=CAdtZgdIrmka110fuYAUj1cJNy9V6Hu33VSZkY5hvcgN8AeejEYrt68MB+mBYi9aqjrZNgpQpSo2Y9/BIMzKbRDnxDaJ+lw05qU+n7cbZu0hzy1UMzJVI5EebbZw0bAvhdb9oW+9/Fo8PQHscoTz/BLk11kflo3TbD52w2gObqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MCEdZ+pZ; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733627589; x=1765163589;
  h=date:from:to:cc:subject:message-id;
  bh=jz/t0pPMi5bWp4WBX+9SwF+NfW0y78eCbGbFVr1fasc=;
  b=MCEdZ+pZH5aJD7A6b0Hb9f7/Ef6uDNjMF6JHlyfRSXh+RJD3yx1F4+ME
   t/Ds3RYrWNawgsHtAg4M82mikwvW1jxMxQxPMQmy9PhWcFeSIeaTWG3ty
   Go1D2X6onVc3CSpQ2HFcTkAqDgFNZLCGfD3wvvb/iIssmLWlC/DLpzP5F
   +3G2QBVefvFXykEXWWMlvKW8bR1Cg20wEuD9nGPoon0xaFS55X90bSiQ4
   cIAF0dPOKz7KvGPepg105CXT4YBS8+8/7JSn7JG3Hgz5MV7ZX4Zqzpvea
   2cz/bYHXVdg8d3zT9puw9TPyls/j3i4B2T65yZd/lJEwsgFt4nrPJfJyV
   A==;
X-CSE-ConnectionGUID: QHwO7HvvRSSajogAMLtSJQ==
X-CSE-MsgGUID: HBBtFh1AQZS8KT9LdEu/HQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="45325483"
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="45325483"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2024 19:13:08 -0800
X-CSE-ConnectionGUID: aI/dyG4hS1ScKwRdOc+Yhg==
X-CSE-MsgGUID: VLNd6NxPQvqOrmn0UcMWnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,216,1728975600"; 
   d="scan'208";a="99819297"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 07 Dec 2024 19:13:07 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tK7jE-000373-1X;
	Sun, 08 Dec 2024 03:13:04 +0000
Date: Sun, 08 Dec 2024 11:09:11 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 9adedea2d605d3114c3e22e00bfbbd6ac2b3dfeb
Message-ID: <202412081101.UvASMCrS-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 9adedea2d605d3114c3e22e00bfbbd6ac2b3dfeb  Merge branch into tip/master: 'x86/tdx'

elapsed time: 947m

configs tested: 207
configs skipped: 13

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    clang-20
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-18
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-18
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-14.2.0
arc                   randconfig-001-20241207    gcc-13.2.0
arc                   randconfig-002-20241207    gcc-13.2.0
arm                              allmodconfig    clang-18
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-18
arm                              allyesconfig    gcc-14.2.0
arm                       aspeed_g5_defconfig    gcc-14.2.0
arm                                 defconfig    gcc-14.2.0
arm                          ep93xx_defconfig    clang-20
arm                       multi_v4t_defconfig    clang-18
arm                       multi_v4t_defconfig    clang-20
arm                        multi_v5_defconfig    clang-18
arm                            qcom_defconfig    clang-15
arm                   randconfig-001-20241207    gcc-14.2.0
arm                   randconfig-002-20241207    gcc-14.2.0
arm                   randconfig-003-20241207    clang-19
arm                   randconfig-004-20241207    clang-20
arm                        shmobile_defconfig    gcc-14.2.0
arm                           stm32_defconfig    gcc-14.2.0
arm                       versatile_defconfig    clang-18
arm                         vf610m4_defconfig    gcc-14.2.0
arm                         wpcm450_defconfig    clang-20
arm64                            alldefconfig    clang-20
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20241207    gcc-14.2.0
arm64                 randconfig-002-20241207    gcc-14.2.0
arm64                 randconfig-003-20241207    clang-20
arm64                 randconfig-004-20241207    clang-15
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20241207    gcc-14.2.0
csky                  randconfig-002-20241207    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-18
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20241207    clang-14
hexagon               randconfig-002-20241207    clang-16
i386                             allmodconfig    clang-19
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-19
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-19
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241207    clang-19
i386        buildonly-randconfig-002-20241207    clang-19
i386        buildonly-randconfig-003-20241207    gcc-12
i386        buildonly-randconfig-004-20241207    clang-19
i386        buildonly-randconfig-005-20241207    clang-19
i386        buildonly-randconfig-006-20241207    clang-19
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20241207    gcc-14.2.0
loongarch             randconfig-002-20241207    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                          atari_defconfig    clang-20
m68k                                defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                      bmips_stb_defconfig    clang-18
mips                            gpr_defconfig    clang-20
mips                           ip22_defconfig    clang-15
mips                           ip22_defconfig    clang-18
mips                           ip28_defconfig    clang-18
mips                           jazz_defconfig    clang-18
mips                        maltaup_defconfig    clang-20
mips                          rb532_defconfig    clang-17
mips                        vocore2_defconfig    clang-15
nios2                         3c120_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20241207    gcc-14.2.0
nios2                 randconfig-002-20241207    gcc-14.2.0
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20241207    gcc-14.2.0
parisc                randconfig-002-20241207    gcc-14.2.0
parisc64                            defconfig    gcc-14.2.0
powerpc                     akebono_defconfig    clang-20
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                          allyesconfig    gcc-14.2.0
powerpc                 canyonlands_defconfig    clang-18
powerpc                   currituck_defconfig    clang-17
powerpc                       holly_defconfig    clang-20
powerpc                      mgcoge_defconfig    clang-18
powerpc                  mpc885_ads_defconfig    clang-20
powerpc                    mvme5100_defconfig    clang-15
powerpc               randconfig-001-20241207    gcc-14.2.0
powerpc               randconfig-002-20241207    clang-20
powerpc               randconfig-003-20241207    clang-15
powerpc                     redwood_defconfig    clang-20
powerpc                     stx_gp3_defconfig    clang-20
powerpc                     tqm8555_defconfig    clang-15
powerpc64                        alldefconfig    clang-18
powerpc64             randconfig-001-20241207    gcc-14.2.0
powerpc64             randconfig-002-20241207    clang-19
powerpc64             randconfig-003-20241207    clang-17
riscv                            allmodconfig    clang-20
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    clang-19
riscv                               defconfig    clang-20
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20241208    clang-20
riscv                 randconfig-001-20241208    gcc-14.2.0
riscv                 randconfig-002-20241208    clang-20
riscv                 randconfig-002-20241208    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                                defconfig    gcc-12
s390                  randconfig-001-20241208    clang-15
s390                  randconfig-001-20241208    gcc-14.2.0
s390                  randconfig-002-20241208    clang-17
s390                  randconfig-002-20241208    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                         ap325rxa_defconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                                  defconfig    gcc-14.2.0
sh                             espt_defconfig    clang-18
sh                          r7780mp_defconfig    clang-15
sh                    randconfig-001-20241208    gcc-14.2.0
sh                    randconfig-002-20241208    gcc-14.2.0
sh                          sdk7780_defconfig    clang-18
sh                           se7712_defconfig    clang-20
sparc                            alldefconfig    clang-18
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20241208    gcc-14.2.0
sparc                 randconfig-002-20241208    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20241208    gcc-14.2.0
sparc64               randconfig-002-20241208    gcc-14.2.0
um                               alldefconfig    clang-19
um                               allmodconfig    clang-20
um                                allnoconfig    clang-18
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                               allyesconfig    gcc-12
um                                  defconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241208    clang-16
um                    randconfig-001-20241208    gcc-14.2.0
um                    randconfig-002-20241208    gcc-12
um                    randconfig-002-20241208    gcc-14.2.0
um                           x86_64_defconfig    clang-15
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241207    clang-19
x86_64      buildonly-randconfig-002-20241207    clang-19
x86_64      buildonly-randconfig-003-20241207    gcc-11
x86_64      buildonly-randconfig-004-20241207    clang-19
x86_64      buildonly-randconfig-005-20241207    clang-19
x86_64      buildonly-randconfig-006-20241207    gcc-12
x86_64                              defconfig    clang-19
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                       common_defconfig    clang-20
xtensa                generic_kc705_defconfig    clang-18
xtensa                randconfig-001-20241208    gcc-14.2.0
xtensa                randconfig-002-20241208    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

