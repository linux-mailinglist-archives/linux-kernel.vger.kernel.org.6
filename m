Return-Path: <linux-kernel+bounces-423006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FBB39DA123
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 04:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E710F168234
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 03:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED40433A0;
	Wed, 27 Nov 2024 03:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EjyF18Im"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF531DFFC
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 03:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732678307; cv=none; b=bcsEMniRJbmBI9FKlyOuQjgnA01O2UeW/GANIrMPifCPLeXseXGLS1zQvqrHitYdUomxD1ASBLhq7WV49vZDtqY0wzwz7ykKGUjBOutaiM0RUpa7/+OdVIqUU9kbEO7MdowDSatLAHSb7qT78GBn6gthiSOFNCDGLYLv5+X783o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732678307; c=relaxed/simple;
	bh=FrudejxBgx2EoHqV8Oxdd5g8VznV7cvY3Z9Ew4C+9g0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Mkc85XA5i7wOcGVMNqd+d2kAKhQnFBF2fiaNyjcIYhueQEyIPyCTUNXIEdftn4qObGN5AwadaavijOfJvnnElHSPB+1bREOy72h4kWYmR4mS8NpofT5zVFaWMzfORHQ23kfaPtC5PhRbCr+tDCvG2ZUbRp0C5xH2GyRoSybCtV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EjyF18Im; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732678305; x=1764214305;
  h=date:from:to:cc:subject:message-id;
  bh=FrudejxBgx2EoHqV8Oxdd5g8VznV7cvY3Z9Ew4C+9g0=;
  b=EjyF18ImhzFY9IBwJXx+jt6qBUOFZX4mUqA05kWnEYfA8Frcg/u/ZyYj
   vMQV76IHaLh23uo4nnQZHdAD4IcF8sofJENAj7toSjUtrZzgaY6ieQ8+V
   6J5F92NbX1jZNry05l8KakBsg4ROh87nuV338KE3NKxccOCkectH/78YC
   B4B+E0I49TMpGbTuup5v0sKkAjxeuXucTP2CHZ7efH/2LC7kbqCj7nKyE
   l8CJfuUCV9hvrKk1pz6N8PQkgFPvK9IV57dRpbTKVAV5dHTsdQBk39FHv
   0ownxlNsVve4YXpbd58aYMuLpqv4jzltN6Nbc0ibgkPN45RFL3h1sN3k9
   g==;
X-CSE-ConnectionGUID: Ofo9F+6BSc6jOQ3jB/5big==
X-CSE-MsgGUID: c7kdhyv1SOyVIfLkfJ3osA==
X-IronPort-AV: E=McAfee;i="6700,10204,11268"; a="36791924"
X-IronPort-AV: E=Sophos;i="6.12,188,1728975600"; 
   d="scan'208";a="36791924"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 19:31:44 -0800
X-CSE-ConnectionGUID: WbmP/As3TBaMuEF27OFkIg==
X-CSE-MsgGUID: Ysim8172STWINHWzaCvWVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,188,1728975600"; 
   d="scan'208";a="96882495"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 26 Nov 2024 19:31:43 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tG8mD-0007hG-0g;
	Wed, 27 Nov 2024 03:31:41 +0000
Date: Wed, 27 Nov 2024 11:30:09 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 ff6cdc407f4179748f4673c39b0921503199a0ad
Message-ID: <202411271158.O8aJK06r-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: ff6cdc407f4179748f4673c39b0921503199a0ad  x86/CPU/AMD: Terminate the erratum_1386_microcode array

elapsed time: 721m

configs tested: 154
configs skipped: 132

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-20
arc                          axs103_defconfig    gcc-14.2.0
arc                   randconfig-001-20241127    gcc-14.2.0
arc                   randconfig-002-20241127    gcc-14.2.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-20
arm                       aspeed_g5_defconfig    gcc-14.2.0
arm                          ep93xx_defconfig    clang-14
arm                      integrator_defconfig    clang-20
arm                        multi_v5_defconfig    clang-20
arm                         mv78xx0_defconfig    gcc-14.2.0
arm                       omap2plus_defconfig    gcc-14.2.0
arm                          pxa3xx_defconfig    gcc-14.2.0
arm                   randconfig-001-20241127    gcc-14.2.0
arm                   randconfig-002-20241127    gcc-14.2.0
arm                   randconfig-003-20241127    gcc-14.2.0
arm                   randconfig-004-20241127    gcc-14.2.0
arm                        realview_defconfig    gcc-14.2.0
arm                        shmobile_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20241127    gcc-14.2.0
arm64                 randconfig-002-20241127    gcc-14.2.0
arm64                 randconfig-003-20241127    gcc-14.2.0
arm64                 randconfig-004-20241127    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20241127    gcc-14.2.0
csky                  randconfig-002-20241127    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-20
hexagon               randconfig-001-20241127    gcc-14.2.0
hexagon               randconfig-002-20241127    gcc-14.2.0
i386        buildonly-randconfig-001-20241127    clang-19
i386        buildonly-randconfig-002-20241127    clang-19
i386        buildonly-randconfig-003-20241127    clang-19
i386        buildonly-randconfig-004-20241127    clang-19
i386        buildonly-randconfig-005-20241127    clang-19
i386        buildonly-randconfig-006-20241127    clang-19
i386                  randconfig-001-20241127    clang-19
i386                  randconfig-002-20241127    clang-19
i386                  randconfig-003-20241127    clang-19
i386                  randconfig-004-20241127    clang-19
i386                  randconfig-005-20241127    clang-19
i386                  randconfig-006-20241127    clang-19
i386                  randconfig-011-20241127    clang-19
i386                  randconfig-012-20241127    clang-19
i386                  randconfig-013-20241127    clang-19
i386                  randconfig-014-20241127    clang-19
i386                  randconfig-015-20241127    clang-19
i386                  randconfig-016-20241127    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20241127    gcc-14.2.0
loongarch             randconfig-002-20241127    gcc-14.2.0
m68k                             alldefconfig    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                          atari_defconfig    gcc-14.2.0
m68k                       m5275evb_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          ath25_defconfig    gcc-14.2.0
nios2                            allmodconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                            allyesconfig    gcc-14.2.0
nios2                 randconfig-001-20241127    gcc-14.2.0
nios2                 randconfig-002-20241127    gcc-14.2.0
openrisc                         alldefconfig    gcc-14.2.0
openrisc                         allmodconfig    gcc-14.2.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.2.0
openrisc                 simple_smp_defconfig    gcc-14.2.0
parisc                           alldefconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.2.0
parisc                randconfig-001-20241127    gcc-14.2.0
parisc                randconfig-002-20241127    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.2.0
powerpc                     ep8248e_defconfig    gcc-14.2.0
powerpc                      katmai_defconfig    gcc-14.2.0
powerpc                     mpc5200_defconfig    gcc-14.2.0
powerpc                     ppa8548_defconfig    gcc-14.2.0
powerpc                       ppc64_defconfig    gcc-14.2.0
powerpc               randconfig-001-20241127    gcc-14.2.0
powerpc               randconfig-002-20241127    gcc-14.2.0
powerpc               randconfig-003-20241127    gcc-14.2.0
powerpc                    sam440ep_defconfig    gcc-14.2.0
powerpc                     tqm8548_defconfig    gcc-14.2.0
powerpc                         wii_defconfig    gcc-14.2.0
powerpc                 xes_mpc85xx_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20241127    gcc-14.2.0
powerpc64             randconfig-002-20241127    gcc-14.2.0
powerpc64             randconfig-003-20241127    gcc-14.2.0
riscv                            alldefconfig    gcc-14.2.0
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.2.0
riscv             nommu_k210_sdcard_defconfig    gcc-14.2.0
riscv                 randconfig-001-20241127    gcc-14.2.0
riscv                 randconfig-002-20241127    gcc-14.2.0
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20241127    gcc-14.2.0
s390                  randconfig-002-20241127    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                        edosk7705_defconfig    gcc-14.2.0
sh                          landisk_defconfig    gcc-14.2.0
sh                    randconfig-001-20241127    gcc-14.2.0
sh                    randconfig-002-20241127    gcc-14.2.0
sh                      rts7751r2d1_defconfig    clang-14
sh                   secureedge5410_defconfig    gcc-14.2.0
sh                        sh7757lcr_defconfig    gcc-14.2.0
sh                             shx3_defconfig    gcc-14.2.0
sh                              ul2_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                            allyesconfig    gcc-14.2.0
sparc                       sparc32_defconfig    gcc-14.2.0
sparc64                          allmodconfig    gcc-14.2.0
sparc64                          allyesconfig    gcc-14.2.0
sparc64               randconfig-001-20241127    gcc-14.2.0
sparc64               randconfig-002-20241127    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                    randconfig-001-20241127    gcc-14.2.0
um                    randconfig-002-20241127    gcc-14.2.0
x86_64                                  kexec    clang-19
x86_64                               rhel-9.4    clang-19
x86_64                               rhel-9.4    gcc-12
x86_64                           rhel-9.4-bpf    clang-19
x86_64                          rhel-9.4-func    clang-19
x86_64                         rhel-9.4-kunit    clang-19
x86_64                           rhel-9.4-ltp    clang-19
x86_64                          rhel-9.4-rust    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                           allyesconfig    gcc-14.2.0
xtensa                       common_defconfig    gcc-14.2.0
xtensa                randconfig-001-20241127    gcc-14.2.0
xtensa                randconfig-002-20241127    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

