Return-Path: <linux-kernel+bounces-386592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E479B458D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 10:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1EFBB22486
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 09:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8BA20409F;
	Tue, 29 Oct 2024 09:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="loG+l857"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629A61E0DB4
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 09:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730193596; cv=none; b=PR6nZKmQCcliq7PC54ybtxEHc7rlVZ+qOJQWcGUNayTiyT0KBcPqIKAmJo+a0DVeUqgaDX13luMyHdDZDDdRZtD8gtItNbrpAgdSaRnPgkmn2GW42b+YBJNcsukolBFcI1uNjzNmhyDOdiuB+gnUkx4HZwoPiDZChO8BP/kNQns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730193596; c=relaxed/simple;
	bh=LtvKrUmU66OME8u/+Cj2UZTAhcn5TqxkDFORYKBnI6s=;
	h=Date:From:To:Cc:Subject:Message-ID; b=QKRKJrHHPjmZa4GlY3jchqJlafYV45gM3gcYklL8yepIFYpkL5H4O6Ra3NHSTat1+06hIiiubqyxTqU5vdlF4yVoYG78TWQ3/Zc0kKhcLVOIS/IVmUola6BI9WYXqcNdxoEcGJ1H+vQoTxVjgpvY9HpPoPJrD66B4chBA+y5chg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=loG+l857; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730193593; x=1761729593;
  h=date:from:to:cc:subject:message-id;
  bh=LtvKrUmU66OME8u/+Cj2UZTAhcn5TqxkDFORYKBnI6s=;
  b=loG+l857yFmOSs5ygzabHtUKrs1nsPzuvsIF0bnZjv1Qgd/Vu3hnoMC3
   DFy7akpS1DnL0G/IvWatU/aoJRi/5QHaqaacjeE3dK5wmGhn4Gb8z2Pb9
   QBTT4zyWNuUImCFcM+z+zM0cyx2TafGOWJ4R7d+qvrfLkxl8Bhw591H9J
   loNrbIfGCOVyOFJ4XeNCjdm4tFTXUUuQGR48wNtDrwRTvtszjjp93mnTZ
   xU9VmA4//n3wxHGUs4jNxwrhWKufBGG9Cy81lAkWpaiq3jS6THlDtX3x4
   2joiZJtScF9Q2BONLrGgmFmUL6oW6dGkH4wAF84l7MnWCJvCCDOLq6XF0
   Q==;
X-CSE-ConnectionGUID: AuHu3MosTF2BAP5v4JbEEg==
X-CSE-MsgGUID: Lc3rpNNLTOaXfFpj8V3dGA==
X-IronPort-AV: E=McAfee;i="6700,10204,11239"; a="40402960"
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="40402960"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 02:19:53 -0700
X-CSE-ConnectionGUID: 4Pom+CXDRTKWBZPO+DZtRw==
X-CSE-MsgGUID: Ah6uzT3nRieXZj2Ts1J+Jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="81802027"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 29 Oct 2024 02:19:51 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t5iOD-000dU4-1U;
	Tue, 29 Oct 2024 09:19:49 +0000
Date: Tue, 29 Oct 2024 17:19:47 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:sched/urgent] BUILD SUCCESS
 b4f5f4934b58c3729e83b13d44c9cb7cbe66efdb
Message-ID: <202410291734.V8AYS3kq-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/urgent
branch HEAD: b4f5f4934b58c3729e83b13d44c9cb7cbe66efdb  sched: Pass correct scheduling policy to __setscheduler_class

elapsed time: 1176m

configs tested: 214
configs skipped: 13

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-13.3.0
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                            allyesconfig    gcc-13.3.0
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                                 defconfig    gcc-14.1.0
arc                         haps_hs_defconfig    gcc-13.2.0
arc                         haps_hs_defconfig    gcc-14.1.0
arc                   randconfig-001-20241029    gcc-14.1.0
arc                   randconfig-002-20241029    gcc-14.1.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                         assabet_defconfig    gcc-14.1.0
arm                                 defconfig    gcc-14.1.0
arm                            hisi_defconfig    gcc-14.1.0
arm                   milbeaut_m10v_defconfig    gcc-13.2.0
arm                          moxart_defconfig    clang-14
arm                        mvebu_v7_defconfig    gcc-13.2.0
arm                       netwinder_defconfig    gcc-14.1.0
arm                           omap1_defconfig    clang-14
arm                   randconfig-001-20241029    gcc-14.1.0
arm                   randconfig-002-20241029    gcc-14.1.0
arm                   randconfig-003-20241029    gcc-14.1.0
arm                   randconfig-004-20241029    gcc-14.1.0
arm                         vf610m4_defconfig    gcc-14.1.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
arm64                 randconfig-001-20241029    gcc-14.1.0
arm64                 randconfig-002-20241029    gcc-14.1.0
arm64                 randconfig-003-20241029    gcc-14.1.0
arm64                 randconfig-004-20241029    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
csky                  randconfig-001-20241029    gcc-14.1.0
csky                  randconfig-002-20241029    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
hexagon               randconfig-001-20241029    gcc-14.1.0
hexagon               randconfig-002-20241029    gcc-14.1.0
i386                             allmodconfig    clang-19
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-19
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-19
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241029    clang-19
i386        buildonly-randconfig-002-20241029    clang-19
i386        buildonly-randconfig-003-20241029    clang-19
i386        buildonly-randconfig-004-20241029    clang-19
i386        buildonly-randconfig-005-20241029    clang-19
i386        buildonly-randconfig-006-20241029    clang-19
i386                                defconfig    clang-19
i386                  randconfig-001-20241029    clang-19
i386                  randconfig-002-20241029    clang-19
i386                  randconfig-003-20241029    clang-19
i386                  randconfig-004-20241029    clang-19
i386                  randconfig-005-20241029    clang-19
i386                  randconfig-006-20241029    clang-19
i386                  randconfig-011-20241029    clang-19
i386                  randconfig-012-20241029    clang-19
i386                  randconfig-013-20241029    clang-19
i386                  randconfig-014-20241029    clang-19
i386                  randconfig-015-20241029    clang-19
i386                  randconfig-016-20241029    clang-19
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
loongarch             randconfig-001-20241029    gcc-14.1.0
loongarch             randconfig-002-20241029    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
m68k                        mvme147_defconfig    gcc-13.2.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                      maltaaprp_defconfig    clang-14
mips                        omega2p_defconfig    gcc-14.1.0
mips                       rbtx49xx_defconfig    gcc-13.2.0
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
nios2                 randconfig-001-20241029    gcc-14.1.0
nios2                 randconfig-002-20241029    gcc-14.1.0
openrisc                          allnoconfig    gcc-14.1.0
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
openrisc                  or1klitex_defconfig    gcc-14.1.0
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    gcc-14.1.0
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20241029    gcc-14.1.0
parisc                randconfig-002-20241029    gcc-14.1.0
parisc64                            defconfig    gcc-14.1.0
powerpc                    adder875_defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    gcc-14.1.0
powerpc                          allyesconfig    clang-20
powerpc                          allyesconfig    gcc-14.1.0
powerpc                        cell_defconfig    gcc-14.1.0
powerpc                        fsp2_defconfig    gcc-13.2.0
powerpc                       holly_defconfig    clang-14
powerpc                       maple_defconfig    clang-14
powerpc                  mpc866_ads_defconfig    gcc-14.1.0
powerpc                  mpc885_ads_defconfig    clang-14
powerpc                      pcm030_defconfig    gcc-13.2.0
powerpc                      pmac32_defconfig    gcc-13.2.0
powerpc                     ppa8548_defconfig    gcc-13.2.0
powerpc                       ppc64_defconfig    gcc-14.1.0
powerpc               randconfig-001-20241029    gcc-14.1.0
powerpc               randconfig-002-20241029    gcc-14.1.0
powerpc               randconfig-003-20241029    gcc-14.1.0
powerpc64             randconfig-001-20241029    gcc-14.1.0
powerpc64             randconfig-002-20241029    gcc-14.1.0
riscv                            allmodconfig    clang-20
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    gcc-14.1.0
riscv                            allyesconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
riscv                    nommu_k210_defconfig    gcc-13.2.0
riscv                 randconfig-001-20241029    gcc-14.1.0
riscv                 randconfig-002-20241029    gcc-14.1.0
s390                             allmodconfig    clang-20
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                          debug_defconfig    clang-14
s390                                defconfig    gcc-12
s390                                defconfig    gcc-14.1.0
s390                  randconfig-001-20241029    gcc-14.1.0
s390                  randconfig-002-20241029    gcc-14.1.0
s390                       zfcpdump_defconfig    clang-14
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                               j2_defconfig    gcc-13.2.0
sh                 kfr2r09-romimage_defconfig    clang-14
sh                    randconfig-001-20241029    gcc-14.1.0
sh                    randconfig-002-20241029    gcc-14.1.0
sh                          sdk7780_defconfig    gcc-13.2.0
sh                           se7780_defconfig    gcc-13.2.0
sh                             sh03_defconfig    clang-14
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20241029    gcc-14.1.0
sparc64               randconfig-002-20241029    gcc-14.1.0
um                               alldefconfig    clang-14
um                               alldefconfig    gcc-13.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                               allyesconfig    clang-20
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241029    gcc-14.1.0
um                    randconfig-002-20241029    gcc-14.1.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241029    clang-19
x86_64      buildonly-randconfig-002-20241029    clang-19
x86_64      buildonly-randconfig-003-20241029    clang-19
x86_64      buildonly-randconfig-004-20241029    clang-19
x86_64      buildonly-randconfig-005-20241029    clang-19
x86_64      buildonly-randconfig-006-20241029    clang-19
x86_64                              defconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20241029    clang-19
x86_64                randconfig-002-20241029    clang-19
x86_64                randconfig-003-20241029    clang-19
x86_64                randconfig-004-20241029    clang-19
x86_64                randconfig-005-20241029    clang-19
x86_64                randconfig-006-20241029    clang-19
x86_64                randconfig-011-20241029    clang-19
x86_64                randconfig-012-20241029    clang-19
x86_64                randconfig-013-20241029    clang-19
x86_64                randconfig-014-20241029    clang-19
x86_64                randconfig-015-20241029    clang-19
x86_64                randconfig-016-20241029    clang-19
x86_64                randconfig-071-20241029    clang-19
x86_64                randconfig-072-20241029    clang-19
x86_64                randconfig-073-20241029    clang-19
x86_64                randconfig-074-20241029    clang-19
x86_64                randconfig-075-20241029    clang-19
x86_64                randconfig-076-20241029    clang-19
x86_64                               rhel-8.3    gcc-12
x86_64                           rhel-8.3-bpf    clang-19
x86_64                         rhel-8.3-kunit    clang-19
x86_64                           rhel-8.3-ltp    clang-19
x86_64                          rhel-8.3-rust    clang-19
xtensa                            allnoconfig    gcc-14.1.0
xtensa                  audio_kc705_defconfig    gcc-13.2.0
xtensa                  audio_kc705_defconfig    gcc-14.1.0
xtensa                       common_defconfig    clang-14
xtensa                randconfig-001-20241029    gcc-14.1.0
xtensa                randconfig-002-20241029    gcc-14.1.0
xtensa                    xip_kc705_defconfig    clang-14

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

