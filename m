Return-Path: <linux-kernel+bounces-397673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 034CC9BDEDE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 07:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 804671F2466F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 06:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76FD81917FA;
	Wed,  6 Nov 2024 06:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U4exdgwR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5444824A3
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 06:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730874675; cv=none; b=nrsGLPP8xwW6014bE+TP2VJCg/hfA/UUyIwk4ewRxmiUKMY4tCladBfHUdZCCS4sDVe1wqkWAE46GAY/RdOFyy7wfuoDk03ATa2RyAMPRtWcfSj0C+2fSZC+KWIc2rh46aU//v1ax6GNxaw42I6+7Ba6DqVzMcv0UeWcJ1QXgvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730874675; c=relaxed/simple;
	bh=RxH/0cyoTSPFY0aUfNFt08sj9M6qKOt6fMAQs3FF1aw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=XwpyRx2POR9xGRtig8BGSRVBlX3AD07zWohyMyAh2DzvNMC/1MlqwOP8yuhMNqPBb9PVay0wPO94OYFD1SXG5r3Ik+2eU+46Aa9JNb6BuK/mCd8LLFGWcAw9pwu7GKH3YLuI8cwgmSbf++TCy6y09o/rDAfgDBv7LMz5gfHjbq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U4exdgwR; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730874673; x=1762410673;
  h=date:from:to:cc:subject:message-id;
  bh=RxH/0cyoTSPFY0aUfNFt08sj9M6qKOt6fMAQs3FF1aw=;
  b=U4exdgwRymFCl8/pxWLMDh+o4eEW/2ZqczHR6W3kEoQIMWFg7quOs9sU
   gdKaq9jeD2O2vdTymPhG/+kVKHZ2U4igmPqI9fIMkD/N1kdWxKRdSIor0
   1kE2zGbr/fkgWXoQ12gnGeG6Qf7vSgnMvra1gFxWfkuT17xtmQFSljlDG
   XVNk4+p7tbFg2aONvrqwzT7hIcZpVU4lsW/8HMfDanJinZ3wSy6TFPaiT
   Qbu9fa40bX2PW2mBl/I2uir8zInn7XiCMCfGE+L0sj+u2Q3lDXZF1H2oM
   RBzCMl9f+Q1ZBYHwza7ydzwIiIpU86GJU8UWMgOwrDXH5T0+mYmQYE3eq
   w==;
X-CSE-ConnectionGUID: 7s79vJkFSW+gOMjucwzFMA==
X-CSE-MsgGUID: zWGkJ3G+TPOwDRdGRnOVaQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="41758357"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="41758357"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 22:31:13 -0800
X-CSE-ConnectionGUID: H2C6pc5VSeus6TxvjvlONA==
X-CSE-MsgGUID: kN84FulnQomUzwyeZoFUGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,262,1725346800"; 
   d="scan'208";a="83897523"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 05 Nov 2024 22:31:11 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t8ZZM-000mzO-3A;
	Wed, 06 Nov 2024 06:31:08 +0000
Date: Wed, 06 Nov 2024 14:30:33 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:core/merge] BUILD SUCCESS
 2d4cdd3ab714474b8debab73fd5bb47ceea45fea
Message-ID: <202411061423.ipwzGy0K-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core/merge
branch HEAD: 2d4cdd3ab714474b8debab73fd5bb47ceea45fea  Merge branch 'perf/core' into core/merge, to resolve conflict

elapsed time: 1299m

configs tested: 315
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-13.3.0
alpha                             allnoconfig    gcc-14.1.0
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
alpha                            allyesconfig    gcc-13.3.0
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.1.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-20
arc                              allyesconfig    gcc-13.2.0
arc                        nsim_700_defconfig    gcc-14.1.0
arc                   randconfig-001-20241105    gcc-13.2.0
arc                   randconfig-001-20241106    gcc-14.2.0
arc                   randconfig-002-20241105    gcc-13.2.0
arc                   randconfig-002-20241106    gcc-14.2.0
arm                              allmodconfig    clang-20
arm                              allmodconfig    gcc-14.1.0
arm                               allnoconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-20
arm                              allyesconfig    gcc-14.1.0
arm                        clps711x_defconfig    clang-20
arm                           imxrt_defconfig    gcc-14.2.0
arm                          ixp4xx_defconfig    clang-20
arm                             mxs_defconfig    gcc-14.2.0
arm                           omap1_defconfig    gcc-14.2.0
arm                   randconfig-001-20241105    gcc-14.1.0
arm                   randconfig-001-20241106    gcc-14.2.0
arm                   randconfig-002-20241105    clang-20
arm                   randconfig-002-20241106    gcc-14.2.0
arm                   randconfig-003-20241105    gcc-14.1.0
arm                   randconfig-003-20241106    gcc-14.2.0
arm                   randconfig-004-20241105    clang-16
arm                   randconfig-004-20241106    gcc-14.2.0
arm                         socfpga_defconfig    gcc-14.2.0
arm                          sp7021_defconfig    gcc-14.1.0
arm                        spear6xx_defconfig    gcc-14.1.0
arm                           spitz_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20241105    gcc-14.1.0
arm64                 randconfig-001-20241106    gcc-14.2.0
arm64                 randconfig-002-20241105    gcc-14.1.0
arm64                 randconfig-002-20241106    gcc-14.2.0
arm64                 randconfig-003-20241105    gcc-14.1.0
arm64                 randconfig-003-20241106    gcc-14.2.0
arm64                 randconfig-004-20241105    gcc-14.1.0
arm64                 randconfig-004-20241106    gcc-14.2.0
csky                              allnoconfig    gcc-14.1.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20241105    gcc-14.1.0
csky                  randconfig-001-20241106    gcc-14.2.0
csky                  randconfig-002-20241105    gcc-14.1.0
csky                  randconfig-002-20241106    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-20
hexagon               randconfig-001-20241105    clang-20
hexagon               randconfig-001-20241106    gcc-14.2.0
hexagon               randconfig-002-20241105    clang-20
hexagon               randconfig-002-20241106    gcc-14.2.0
i386                             allmodconfig    clang-19
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-19
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-19
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241105    clang-19
i386        buildonly-randconfig-001-20241106    gcc-12
i386        buildonly-randconfig-002-20241105    gcc-12
i386        buildonly-randconfig-002-20241106    gcc-12
i386        buildonly-randconfig-003-20241105    clang-19
i386        buildonly-randconfig-003-20241106    gcc-12
i386        buildonly-randconfig-004-20241105    gcc-12
i386        buildonly-randconfig-004-20241106    gcc-12
i386        buildonly-randconfig-005-20241105    clang-19
i386        buildonly-randconfig-005-20241106    gcc-12
i386        buildonly-randconfig-006-20241105    gcc-12
i386        buildonly-randconfig-006-20241106    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20241105    gcc-12
i386                  randconfig-001-20241106    gcc-12
i386                  randconfig-002-20241105    clang-19
i386                  randconfig-002-20241106    gcc-12
i386                  randconfig-003-20241105    gcc-12
i386                  randconfig-003-20241106    gcc-12
i386                  randconfig-004-20241105    clang-19
i386                  randconfig-004-20241106    gcc-12
i386                  randconfig-005-20241105    clang-19
i386                  randconfig-005-20241106    gcc-12
i386                  randconfig-006-20241105    gcc-12
i386                  randconfig-006-20241106    gcc-12
i386                  randconfig-011-20241105    clang-19
i386                  randconfig-011-20241106    gcc-12
i386                  randconfig-012-20241105    clang-19
i386                  randconfig-012-20241106    gcc-12
i386                  randconfig-013-20241105    gcc-12
i386                  randconfig-013-20241106    gcc-12
i386                  randconfig-014-20241105    gcc-12
i386                  randconfig-014-20241106    gcc-12
i386                  randconfig-015-20241105    gcc-12
i386                  randconfig-015-20241106    gcc-12
i386                  randconfig-016-20241105    gcc-12
i386                  randconfig-016-20241106    gcc-12
loongarch                        allmodconfig    gcc-14.1.0
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20241105    gcc-14.1.0
loongarch             randconfig-001-20241106    gcc-14.2.0
loongarch             randconfig-002-20241105    gcc-14.1.0
loongarch             randconfig-002-20241106    gcc-14.2.0
m68k                             allmodconfig    gcc-14.1.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.2.0
m68k                         amcore_defconfig    gcc-14.1.0
m68k                       m5275evb_defconfig    clang-20
m68k                        mvme147_defconfig    clang-20
m68k                        mvme16x_defconfig    clang-20
m68k                           sun3_defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.2.0
mips                           gcw0_defconfig    gcc-14.2.0
mips                        maltaup_defconfig    clang-20
nios2                         10m50_defconfig    clang-20
nios2                             allnoconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20241105    gcc-14.1.0
nios2                 randconfig-001-20241106    gcc-14.2.0
nios2                 randconfig-002-20241105    gcc-14.1.0
nios2                 randconfig-002-20241106    gcc-14.2.0
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.1.0
openrisc                         allyesconfig    gcc-14.1.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
openrisc                       virt_defconfig    clang-20
parisc                           allmodconfig    gcc-14.1.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.1.0
parisc                           allyesconfig    gcc-14.1.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20241105    gcc-14.1.0
parisc                randconfig-001-20241106    gcc-14.2.0
parisc                randconfig-002-20241105    gcc-14.1.0
parisc                randconfig-002-20241106    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.1.0
powerpc                          allyesconfig    clang-20
powerpc                          allyesconfig    gcc-14.2.0
powerpc                      cm5200_defconfig    gcc-14.2.0
powerpc                        fsp2_defconfig    clang-20
powerpc                       holly_defconfig    clang-20
powerpc                      mgcoge_defconfig    gcc-14.2.0
powerpc                   motionpro_defconfig    gcc-14.1.0
powerpc                 mpc8315_rdb_defconfig    gcc-14.1.0
powerpc                 mpc832x_rdb_defconfig    gcc-14.2.0
powerpc                 mpc837x_rdb_defconfig    gcc-14.1.0
powerpc                      ppc44x_defconfig    gcc-14.2.0
powerpc                      ppc64e_defconfig    gcc-14.1.0
powerpc               randconfig-001-20241105    gcc-14.1.0
powerpc               randconfig-001-20241106    gcc-14.2.0
powerpc               randconfig-002-20241105    gcc-14.1.0
powerpc               randconfig-002-20241106    gcc-14.2.0
powerpc               randconfig-003-20241105    gcc-14.1.0
powerpc               randconfig-003-20241106    gcc-14.2.0
powerpc                     sequoia_defconfig    gcc-14.1.0
powerpc                     skiroot_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20241105    gcc-14.1.0
powerpc64             randconfig-001-20241106    gcc-14.2.0
powerpc64             randconfig-002-20241105    clang-14
powerpc64             randconfig-002-20241106    gcc-14.2.0
powerpc64             randconfig-003-20241105    gcc-14.1.0
powerpc64             randconfig-003-20241106    gcc-14.2.0
riscv                            allmodconfig    clang-20
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.1.0
riscv                            allyesconfig    clang-20
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
riscv             nommu_k210_sdcard_defconfig    clang-20
riscv                 randconfig-001-20241105    gcc-14.1.0
riscv                 randconfig-001-20241106    gcc-14.2.0
riscv                 randconfig-002-20241105    clang-20
riscv                 randconfig-002-20241106    gcc-14.2.0
s390                             allmodconfig    clang-20
s390                             allmodconfig    gcc-14.1.0
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20241105    clang-20
s390                  randconfig-001-20241106    gcc-14.2.0
s390                  randconfig-002-20241105    clang-20
s390                  randconfig-002-20241106    gcc-14.2.0
s390                       zfcpdump_defconfig    gcc-14.1.0
sh                               allmodconfig    gcc-14.1.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.2.0
sh                        apsh4ad0a_defconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                        edosk7705_defconfig    gcc-14.2.0
sh                    randconfig-001-20241105    gcc-14.1.0
sh                    randconfig-001-20241106    gcc-14.2.0
sh                    randconfig-002-20241105    gcc-14.1.0
sh                    randconfig-002-20241106    gcc-14.2.0
sh                           se7724_defconfig    gcc-14.2.0
sh                           se7750_defconfig    gcc-14.1.0
sh                           sh2007_defconfig    gcc-14.1.0
sh                   sh7724_generic_defconfig    gcc-14.2.0
sh                        sh7763rdp_defconfig    gcc-14.1.0
sparc                            allmodconfig    gcc-14.1.0
sparc                            allmodconfig    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20241105    gcc-14.1.0
sparc64               randconfig-001-20241106    gcc-14.2.0
sparc64               randconfig-002-20241105    gcc-14.1.0
sparc64               randconfig-002-20241106    gcc-14.2.0
um                               alldefconfig    clang-20
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241105    gcc-12
um                    randconfig-001-20241106    gcc-14.2.0
um                    randconfig-002-20241105    gcc-12
um                    randconfig-002-20241106    gcc-14.2.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241106    clang-19
x86_64      buildonly-randconfig-001-20241106    gcc-11
x86_64      buildonly-randconfig-002-20241106    clang-19
x86_64      buildonly-randconfig-002-20241106    gcc-11
x86_64      buildonly-randconfig-003-20241106    clang-19
x86_64      buildonly-randconfig-003-20241106    gcc-11
x86_64      buildonly-randconfig-004-20241106    gcc-11
x86_64      buildonly-randconfig-004-20241106    gcc-12
x86_64      buildonly-randconfig-005-20241106    gcc-11
x86_64      buildonly-randconfig-005-20241106    gcc-12
x86_64      buildonly-randconfig-006-20241106    clang-19
x86_64      buildonly-randconfig-006-20241106    gcc-11
x86_64                              defconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20241106    clang-19
x86_64                randconfig-001-20241106    gcc-11
x86_64                randconfig-002-20241106    gcc-11
x86_64                randconfig-003-20241106    gcc-11
x86_64                randconfig-003-20241106    gcc-12
x86_64                randconfig-004-20241106    gcc-11
x86_64                randconfig-004-20241106    gcc-12
x86_64                randconfig-005-20241106    clang-19
x86_64                randconfig-005-20241106    gcc-11
x86_64                randconfig-006-20241106    gcc-11
x86_64                randconfig-011-20241106    gcc-11
x86_64                randconfig-012-20241106    gcc-11
x86_64                randconfig-012-20241106    gcc-12
x86_64                randconfig-013-20241106    clang-19
x86_64                randconfig-013-20241106    gcc-11
x86_64                randconfig-014-20241106    gcc-11
x86_64                randconfig-014-20241106    gcc-12
x86_64                randconfig-015-20241106    gcc-11
x86_64                randconfig-015-20241106    gcc-12
x86_64                randconfig-016-20241106    gcc-11
x86_64                randconfig-016-20241106    gcc-12
x86_64                randconfig-071-20241106    gcc-11
x86_64                randconfig-071-20241106    gcc-12
x86_64                randconfig-072-20241106    gcc-11
x86_64                randconfig-072-20241106    gcc-12
x86_64                randconfig-073-20241106    clang-19
x86_64                randconfig-073-20241106    gcc-11
x86_64                randconfig-074-20241106    gcc-11
x86_64                randconfig-074-20241106    gcc-12
x86_64                randconfig-075-20241106    clang-19
x86_64                randconfig-075-20241106    gcc-11
x86_64                randconfig-076-20241106    gcc-11
x86_64                randconfig-076-20241106    gcc-12
x86_64                               rhel-8.3    gcc-12
xtensa                            allnoconfig    gcc-14.1.0
xtensa                            allnoconfig    gcc-14.2.0
xtensa                       common_defconfig    clang-20
xtensa                randconfig-001-20241105    gcc-14.1.0
xtensa                randconfig-001-20241106    gcc-14.2.0
xtensa                randconfig-002-20241105    gcc-14.1.0
xtensa                randconfig-002-20241106    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

