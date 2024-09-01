Return-Path: <linux-kernel+bounces-310115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 384E6967537
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 08:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4F5D1C2100F
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 06:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBBFA44C61;
	Sun,  1 Sep 2024 06:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GPPkpS86"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A792F28
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 06:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725170856; cv=none; b=k+vb0Na2M1B7yIketdQc+CVvl5g1YPKEYr6D3PO23xgTbzYPU8ye9/K0NXfhK7jillhHUuBBu7vQbLgxlpTXgPHQ1IijJA1E5UuJgPd8QyCOUaIXNJS33wtirkfBbxbebNbZxoEqQ45vTosbYP4R2V3fWKEE6jR7nfRTiOfatF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725170856; c=relaxed/simple;
	bh=T/XVrFplX9ohWAaavls/1e3eKMcwpMPK/3jB+r4I7WI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=pBznMpYc/T5bbsoHR2LbSgdL3w5DxSU/jF7ilongmICgNW6de1lsgGVWXzO+AwgDimZ47MbcRWMuqFLz7B3+MtY73Zwb2t2VKrJjkh4Ytyn7Ct2UE9heemTc5BFSCovhdb88rL1SPdPMj1yT6ERrl85kCMCTIstCIBOOJ7GPKk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GPPkpS86; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725170855; x=1756706855;
  h=date:from:to:cc:subject:message-id;
  bh=T/XVrFplX9ohWAaavls/1e3eKMcwpMPK/3jB+r4I7WI=;
  b=GPPkpS86SaKUbSGgtj0OkxVM/o/QpN90ZMphG3NeKtXfNSTJS7f152EH
   ET06QwjKwInUR7YLY6jIw7rmnVQUYfAmmOwvfqoEXPQaCaROzNpYRLKY3
   ZruDeiFj0kvp1KyBUM3Qn/e9+hwWR58qX69G/vrCRud2LqQN0go8sz77P
   H3On/Rq5Hk2t9+Q19uNPjpHtGn1JIyMH8q9UIc0RjQexgx2nrjfNI9UJU
   5+BtX55fH4Gka1WltNICNgfYmQhVppEU24p4s9Qhz+Q7+kkqtn1QxADO/
   gey2oE1/V9FwD3/Qk6/S1pQvyO545VUOelJ+H/xwWmx2HgCuNn/GpCwhG
   A==;
X-CSE-ConnectionGUID: 9kXExFrDT+6edmOzGk2FyA==
X-CSE-MsgGUID: Hw0oMRQvREujOib5ek04Aw==
X-IronPort-AV: E=McAfee;i="6700,10204,11181"; a="23635535"
X-IronPort-AV: E=Sophos;i="6.10,193,1719903600"; 
   d="scan'208";a="23635535"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2024 23:07:34 -0700
X-CSE-ConnectionGUID: vwh89n+xTW2XgpXgJ7dRGA==
X-CSE-MsgGUID: ZngEOaH1Q+W72Za2cqazaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,193,1719903600"; 
   d="scan'208";a="63895063"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 31 Aug 2024 23:07:32 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1skdkI-0003SA-2M;
	Sun, 01 Sep 2024 06:07:30 +0000
Date: Sun, 01 Sep 2024 14:07:21 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2024.08.30b] BUILD SUCCESS
 e97f0db697aef503a9363137dcfa7f3dc66573ac
Message-ID: <202409011418.10IZsKrq-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://github.com/paulmckrcu/linux dev.2024.08.30b
branch HEAD: e97f0db697aef503a9363137dcfa7f3dc66573ac  fixup! srcu: Add srcu_read_lock_lite() and srcu_read_unlock_lite()

elapsed time: 2088m

configs tested: 296
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-14.1.0
alpha                            allyesconfig   clang-20
alpha                               defconfig   gcc-14.1.0
arc                              allmodconfig   clang-20
arc                               allnoconfig   gcc-14.1.0
arc                              allyesconfig   clang-20
arc                                 defconfig   gcc-14.1.0
arc                            hsdk_defconfig   gcc-14.1.0
arc                   randconfig-001-20240831   gcc-14.1.0
arc                   randconfig-001-20240901   clang-20
arc                   randconfig-002-20240831   gcc-14.1.0
arc                   randconfig-002-20240901   clang-20
arm                              allmodconfig   clang-20
arm                               allnoconfig   gcc-14.1.0
arm                              allyesconfig   clang-20
arm                       aspeed_g5_defconfig   clang-20
arm                         at91_dt_defconfig   clang-20
arm                        clps711x_defconfig   clang-20
arm                     davinci_all_defconfig   clang-20
arm                                 defconfig   gcc-14.1.0
arm                            dove_defconfig   gcc-14.1.0
arm                          ep93xx_defconfig   clang-20
arm                          exynos_defconfig   clang-20
arm                       multi_v4t_defconfig   gcc-14.1.0
arm                             mxs_defconfig   clang-20
arm                         nhk8815_defconfig   clang-20
arm                          pxa3xx_defconfig   clang-20
arm                   randconfig-001-20240831   gcc-14.1.0
arm                   randconfig-001-20240901   clang-20
arm                   randconfig-002-20240831   gcc-14.1.0
arm                   randconfig-002-20240901   clang-20
arm                   randconfig-003-20240831   gcc-14.1.0
arm                   randconfig-003-20240901   clang-20
arm                   randconfig-004-20240831   gcc-14.1.0
arm                   randconfig-004-20240901   clang-20
arm                        realview_defconfig   clang-20
arm                           sama5_defconfig   gcc-14.1.0
arm                           stm32_defconfig   gcc-14.1.0
arm64                            alldefconfig   clang-20
arm64                            allmodconfig   clang-20
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   clang-20
arm64                               defconfig   gcc-14.1.0
arm64                 randconfig-001-20240831   gcc-14.1.0
arm64                 randconfig-001-20240901   clang-20
arm64                 randconfig-002-20240831   gcc-14.1.0
arm64                 randconfig-002-20240901   clang-20
arm64                 randconfig-003-20240831   gcc-14.1.0
arm64                 randconfig-003-20240901   clang-20
arm64                 randconfig-004-20240831   gcc-14.1.0
arm64                 randconfig-004-20240901   clang-20
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-14.1.0
csky                  randconfig-001-20240831   gcc-14.1.0
csky                  randconfig-001-20240901   clang-20
csky                  randconfig-002-20240831   gcc-14.1.0
csky                  randconfig-002-20240901   clang-20
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   gcc-14.1.0
hexagon                          allyesconfig   clang-20
hexagon                             defconfig   gcc-14.1.0
hexagon               randconfig-001-20240831   gcc-14.1.0
hexagon               randconfig-001-20240901   clang-20
hexagon               randconfig-002-20240831   gcc-14.1.0
hexagon               randconfig-002-20240901   clang-20
i386                             allmodconfig   clang-18
i386                              allnoconfig   clang-18
i386                             allyesconfig   clang-18
i386         buildonly-randconfig-001-20240831   clang-18
i386         buildonly-randconfig-001-20240901   clang-18
i386         buildonly-randconfig-002-20240831   clang-18
i386         buildonly-randconfig-002-20240901   clang-18
i386         buildonly-randconfig-003-20240831   clang-18
i386         buildonly-randconfig-003-20240901   clang-18
i386         buildonly-randconfig-004-20240831   clang-18
i386         buildonly-randconfig-004-20240901   clang-18
i386         buildonly-randconfig-005-20240831   clang-18
i386         buildonly-randconfig-005-20240901   clang-18
i386         buildonly-randconfig-006-20240831   clang-18
i386         buildonly-randconfig-006-20240901   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240831   clang-18
i386                  randconfig-001-20240901   clang-18
i386                  randconfig-002-20240831   clang-18
i386                  randconfig-002-20240901   clang-18
i386                  randconfig-003-20240831   clang-18
i386                  randconfig-003-20240901   clang-18
i386                  randconfig-004-20240831   clang-18
i386                  randconfig-004-20240901   clang-18
i386                  randconfig-005-20240831   clang-18
i386                  randconfig-005-20240901   clang-18
i386                  randconfig-006-20240831   clang-18
i386                  randconfig-006-20240901   clang-18
i386                  randconfig-011-20240831   clang-18
i386                  randconfig-011-20240901   clang-18
i386                  randconfig-012-20240831   clang-18
i386                  randconfig-012-20240901   clang-18
i386                  randconfig-013-20240831   clang-18
i386                  randconfig-013-20240901   clang-18
i386                  randconfig-014-20240831   clang-18
i386                  randconfig-014-20240901   clang-18
i386                  randconfig-015-20240831   clang-18
i386                  randconfig-015-20240901   clang-18
i386                  randconfig-016-20240831   clang-18
i386                  randconfig-016-20240901   clang-18
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-14.1.0
loongarch             randconfig-001-20240831   gcc-14.1.0
loongarch             randconfig-001-20240901   clang-20
loongarch             randconfig-002-20240831   gcc-14.1.0
loongarch             randconfig-002-20240901   clang-20
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                          amiga_defconfig   clang-20
m68k                                defconfig   gcc-14.1.0
m68k                          hp300_defconfig   clang-20
m68k                        m5272c3_defconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
mips                       bmips_be_defconfig   gcc-14.1.0
mips                      bmips_stb_defconfig   clang-20
mips                           ci20_defconfig   clang-20
mips                          eyeq5_defconfig   clang-20
mips                           gcw0_defconfig   clang-20
mips                            gpr_defconfig   clang-20
mips                           ip28_defconfig   clang-20
mips                      malta_kvm_defconfig   clang-20
mips                         rt305x_defconfig   clang-20
nios2                         10m50_defconfig   clang-20
nios2                            alldefconfig   clang-20
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-14.1.0
nios2                 randconfig-001-20240831   gcc-14.1.0
nios2                 randconfig-001-20240901   clang-20
nios2                 randconfig-002-20240831   gcc-14.1.0
nios2                 randconfig-002-20240901   clang-20
openrisc                          allnoconfig   clang-20
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-12
openrisc                  or1klitex_defconfig   clang-20
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   clang-20
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-12
parisc                generic-64bit_defconfig   clang-20
parisc                randconfig-001-20240831   gcc-14.1.0
parisc                randconfig-001-20240901   clang-20
parisc                randconfig-002-20240831   gcc-14.1.0
parisc                randconfig-002-20240901   clang-20
parisc64                            defconfig   gcc-14.1.0
powerpc                    adder875_defconfig   clang-20
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   clang-20
powerpc                          allyesconfig   gcc-14.1.0
powerpc                 canyonlands_defconfig   gcc-14.1.0
powerpc                       eiger_defconfig   clang-20
powerpc                        fsp2_defconfig   clang-20
powerpc                    gamecube_defconfig   clang-20
powerpc                    gamecube_defconfig   gcc-14.1.0
powerpc                       maple_defconfig   clang-20
powerpc                   motionpro_defconfig   gcc-14.1.0
powerpc                     mpc512x_defconfig   clang-20
powerpc                 mpc832x_rdb_defconfig   clang-20
powerpc                 mpc834x_itx_defconfig   clang-20
powerpc               randconfig-001-20240831   gcc-14.1.0
powerpc               randconfig-001-20240901   clang-20
powerpc               randconfig-002-20240901   clang-20
powerpc                     sequoia_defconfig   clang-20
powerpc                     skiroot_defconfig   clang-20
powerpc                     tqm8540_defconfig   clang-20
powerpc                     tqm8555_defconfig   gcc-14.1.0
powerpc                         wii_defconfig   clang-20
powerpc64             randconfig-001-20240831   gcc-14.1.0
powerpc64             randconfig-001-20240901   clang-20
powerpc64             randconfig-002-20240831   gcc-14.1.0
powerpc64             randconfig-002-20240901   clang-20
powerpc64             randconfig-003-20240831   gcc-14.1.0
riscv                            alldefconfig   gcc-14.1.0
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   clang-20
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-12
riscv                               defconfig   gcc-14.1.0
riscv                    nommu_k210_defconfig   clang-20
riscv                 randconfig-001-20240831   gcc-14.1.0
riscv                 randconfig-001-20240901   clang-20
riscv                 randconfig-002-20240831   gcc-14.1.0
riscv                 randconfig-002-20240901   clang-20
s390                             alldefconfig   clang-20
s390                             allmodconfig   gcc-14.1.0
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-12
s390                  randconfig-001-20240831   gcc-14.1.0
s390                  randconfig-001-20240901   clang-20
s390                  randconfig-002-20240831   gcc-14.1.0
s390                  randconfig-002-20240901   clang-20
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-12
sh                         ecovec24_defconfig   clang-20
sh                               j2_defconfig   clang-20
sh                          kfr2r09_defconfig   clang-20
sh                    randconfig-001-20240831   gcc-14.1.0
sh                    randconfig-001-20240901   clang-20
sh                    randconfig-002-20240831   gcc-14.1.0
sh                    randconfig-002-20240901   clang-20
sh                           se7780_defconfig   clang-20
sh                   secureedge5410_defconfig   clang-20
sh                  sh7785lcr_32bit_defconfig   gcc-14.1.0
sh                        sh7785lcr_defconfig   gcc-14.1.0
sh                             shx3_defconfig   clang-20
sh                          urquell_defconfig   clang-20
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-12
sparc64               randconfig-001-20240831   gcc-14.1.0
sparc64               randconfig-001-20240901   clang-20
sparc64               randconfig-002-20240831   gcc-14.1.0
sparc64               randconfig-002-20240901   clang-20
um                               allmodconfig   clang-20
um                                allnoconfig   clang-20
um                               allyesconfig   clang-20
um                                  defconfig   gcc-12
um                             i386_defconfig   gcc-12
um                    randconfig-001-20240831   gcc-14.1.0
um                    randconfig-001-20240901   clang-20
um                    randconfig-002-20240831   gcc-14.1.0
um                    randconfig-002-20240901   clang-20
um                           x86_64_defconfig   gcc-12
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240831   clang-18
x86_64       buildonly-randconfig-001-20240901   gcc-12
x86_64       buildonly-randconfig-002-20240831   clang-18
x86_64       buildonly-randconfig-002-20240901   gcc-12
x86_64       buildonly-randconfig-003-20240831   clang-18
x86_64       buildonly-randconfig-003-20240901   gcc-12
x86_64       buildonly-randconfig-004-20240831   clang-18
x86_64       buildonly-randconfig-004-20240901   gcc-12
x86_64       buildonly-randconfig-005-20240831   clang-18
x86_64       buildonly-randconfig-005-20240901   gcc-12
x86_64       buildonly-randconfig-006-20240831   clang-18
x86_64       buildonly-randconfig-006-20240901   gcc-12
x86_64                              defconfig   clang-18
x86_64                                  kexec   gcc-12
x86_64                randconfig-001-20240831   clang-18
x86_64                randconfig-001-20240901   gcc-12
x86_64                randconfig-002-20240831   clang-18
x86_64                randconfig-002-20240901   gcc-12
x86_64                randconfig-003-20240831   clang-18
x86_64                randconfig-003-20240901   gcc-12
x86_64                randconfig-004-20240831   clang-18
x86_64                randconfig-004-20240901   gcc-12
x86_64                randconfig-005-20240831   clang-18
x86_64                randconfig-005-20240901   gcc-12
x86_64                randconfig-006-20240831   clang-18
x86_64                randconfig-006-20240901   gcc-12
x86_64                randconfig-011-20240831   clang-18
x86_64                randconfig-011-20240901   gcc-12
x86_64                randconfig-012-20240831   clang-18
x86_64                randconfig-012-20240901   gcc-12
x86_64                randconfig-013-20240831   clang-18
x86_64                randconfig-013-20240901   gcc-12
x86_64                randconfig-014-20240831   clang-18
x86_64                randconfig-014-20240901   gcc-12
x86_64                randconfig-015-20240831   clang-18
x86_64                randconfig-015-20240901   gcc-12
x86_64                randconfig-016-20240831   clang-18
x86_64                randconfig-016-20240901   gcc-12
x86_64                randconfig-071-20240831   clang-18
x86_64                randconfig-071-20240901   gcc-12
x86_64                randconfig-072-20240831   clang-18
x86_64                randconfig-072-20240901   gcc-12
x86_64                randconfig-073-20240831   clang-18
x86_64                randconfig-073-20240901   gcc-12
x86_64                randconfig-074-20240831   clang-18
x86_64                randconfig-074-20240901   gcc-12
x86_64                randconfig-075-20240831   clang-18
x86_64                randconfig-075-20240901   gcc-12
x86_64                randconfig-076-20240831   clang-18
x86_64                randconfig-076-20240901   gcc-12
x86_64                          rhel-8.3-rust   clang-18
x86_64                               rhel-8.3   gcc-12
xtensa                            allnoconfig   gcc-14.1.0
xtensa                       common_defconfig   gcc-14.1.0
xtensa                          iss_defconfig   clang-20
xtensa                randconfig-001-20240831   gcc-14.1.0
xtensa                randconfig-001-20240901   clang-20
xtensa                randconfig-002-20240831   gcc-14.1.0
xtensa                randconfig-002-20240901   clang-20

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

