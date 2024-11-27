Return-Path: <linux-kernel+bounces-423482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 636689DA82E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 14:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C727E2829F7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 13:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1EC1FCD0A;
	Wed, 27 Nov 2024 13:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GCdC3b/g"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE001DFFB
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 13:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732712568; cv=none; b=u5IEqFrj4a1TuJB28B7s2rgEJ7MV+X70/mx/ioMDZviFUylF3hO6Di6P6MbLN4fhyeRe0bN9aW6PYM6d8/DPcvmF5KRKYUWgbP4lER8Z5eVi/B4T/DhNuwKDcMyNUGW6QgYJQ086Qga6WDNDmd59k2UqRmqyQ3i41a4LyHwbPoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732712568; c=relaxed/simple;
	bh=KWOvinKGQXS3XtnpWVBe089VeRd+MFGPfOCNgi+JT7k=;
	h=Date:From:To:Cc:Subject:Message-ID; b=fHtdDCVx9MKHibuAPlPs+ZhNRI8NA4YFuFnsH9J54Jvt0oI2KPuQaPBfmdcAhGvCXrE00MRp/YJthLzYP1avUufknzZekkYeiUf+kB++xpGCHnNlu+5lf8cZFzrOGmrA9yl8FatcWvmbrnKq4+wvQjM6/MeY/1mHPuLj19wcSXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GCdC3b/g; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732712566; x=1764248566;
  h=date:from:to:cc:subject:message-id;
  bh=KWOvinKGQXS3XtnpWVBe089VeRd+MFGPfOCNgi+JT7k=;
  b=GCdC3b/gaakZtXZLbLEi+6ukVwQ7GLlqKAUxAqKWw6A/X6klCArCBpDE
   C98DvB17Er+Y+8VwkkJRBqXsKEb9yKd7zewipF1f3FRQexFHAMaewrGYs
   oiwOKfIdIkWbLFJ6/ziU8PY4VdOf2egF+sllxOdEM5zWXixzOqZJPDGa6
   GShQAd84kHcjCIizwgeQK2FHjjedETvlUDNPmaMflgjLDme1f0h4V+cA0
   hKa7+1jItcFVIfcl/Vg2aBzaPGDPJjr5/ecDSaWoRK/R4cU9SQ8NOdcou
   0pGX7GEfej4aBWrU/ndusSof5gLLi38UGUUdM3yztyyrw7NpfQSWoLEYJ
   Q==;
X-CSE-ConnectionGUID: cIJ5+SAtTnKDSUJ65mAPQQ==
X-CSE-MsgGUID: QhHg5uQaQhqzg65oc+Zvuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11268"; a="36837863"
X-IronPort-AV: E=Sophos;i="6.12,189,1728975600"; 
   d="scan'208";a="36837863"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2024 05:02:45 -0800
X-CSE-ConnectionGUID: tJ21X9UoSnym9owL5Ub5nA==
X-CSE-MsgGUID: eUrk7a0eRuaU2/IxZblolw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,189,1728975600"; 
   d="scan'208";a="92025268"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 27 Nov 2024 05:02:44 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tGHgn-00080J-1e;
	Wed, 27 Nov 2024 13:02:41 +0000
Date: Wed, 27 Nov 2024 21:00:18 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:irq/urgent] BUILD SUCCESS
 cc47268cb4841c84d54f0ac73858986bcd515eb4
Message-ID: <202411272109.z3bPs7le-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/urgent
branch HEAD: cc47268cb4841c84d54f0ac73858986bcd515eb4  irqchip: Switch back to struct platform_driver::remove()

elapsed time: 998m

configs tested: 183
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-20
arc                          axs103_defconfig    gcc-14.2.0
arc                        nsim_700_defconfig    clang-20
arc                   randconfig-001-20241127    gcc-14.2.0
arc                   randconfig-002-20241127    gcc-14.2.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-20
arm                       aspeed_g5_defconfig    gcc-14.2.0
arm                       imx_v6_v7_defconfig    clang-20
arm                      integrator_defconfig    clang-20
arm                      jornada720_defconfig    clang-20
arm                        multi_v5_defconfig    gcc-14.2.0
arm                         mv78xx0_defconfig    clang-20
arm                         mv78xx0_defconfig    gcc-14.2.0
arm                       omap2plus_defconfig    gcc-14.2.0
arm                          pxa3xx_defconfig    clang-20
arm                          pxa3xx_defconfig    gcc-14.2.0
arm                   randconfig-001-20241127    gcc-14.2.0
arm                   randconfig-002-20241127    gcc-14.2.0
arm                   randconfig-003-20241127    gcc-14.2.0
arm                   randconfig-004-20241127    gcc-14.2.0
arm                        realview_defconfig    gcc-14.2.0
arm                        shmobile_defconfig    gcc-14.2.0
arm                         socfpga_defconfig    gcc-14.2.0
arm                        spear3xx_defconfig    gcc-14.2.0
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
m68k                         amcore_defconfig    clang-20
m68k                          atari_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          ath25_defconfig    gcc-14.2.0
mips                          ath79_defconfig    clang-20
mips                          eyeq6_defconfig    clang-20
mips                        maltaup_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20241127    gcc-14.2.0
nios2                 randconfig-002-20241127    gcc-14.2.0
openrisc                         alldefconfig    gcc-14.2.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.2.0
parisc                           alldefconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.2.0
parisc                randconfig-001-20241127    gcc-14.2.0
parisc                randconfig-002-20241127    gcc-14.2.0
powerpc                     akebono_defconfig    clang-20
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    clang-20
powerpc                          allyesconfig    gcc-14.2.0
powerpc                     ep8248e_defconfig    gcc-14.2.0
powerpc                      katmai_defconfig    gcc-14.2.0
powerpc                     mpc5200_defconfig    gcc-14.2.0
powerpc                     ppa8548_defconfig    gcc-14.2.0
powerpc                       ppc64_defconfig    gcc-14.2.0
powerpc                         ps3_defconfig    gcc-14.2.0
powerpc               randconfig-001-20241127    gcc-14.2.0
powerpc               randconfig-002-20241127    gcc-14.2.0
powerpc               randconfig-003-20241127    gcc-14.2.0
powerpc                    sam440ep_defconfig    gcc-14.2.0
powerpc                     tqm8548_defconfig    gcc-14.2.0
powerpc                         wii_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20241127    gcc-14.2.0
powerpc64             randconfig-002-20241127    gcc-14.2.0
powerpc64             randconfig-003-20241127    gcc-14.2.0
riscv                            alldefconfig    clang-20
riscv                            allmodconfig    clang-20
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    clang-20
riscv                            allyesconfig    gcc-14.2.0
riscv             nommu_k210_sdcard_defconfig    gcc-14.2.0
riscv                 randconfig-001-20241127    gcc-14.2.0
riscv                 randconfig-002-20241127    gcc-14.2.0
s390                             allmodconfig    clang-20
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20241127    gcc-14.2.0
s390                  randconfig-002-20241127    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                             espt_defconfig    gcc-14.2.0
sh                          landisk_defconfig    gcc-14.2.0
sh                    randconfig-001-20241127    gcc-14.2.0
sh                    randconfig-002-20241127    gcc-14.2.0
sh                   secureedge5410_defconfig    gcc-14.2.0
sh                        sh7757lcr_defconfig    gcc-14.2.0
sh                             shx3_defconfig    gcc-14.2.0
sh                              ul2_defconfig    gcc-14.2.0
sh                          urquell_defconfig    clang-20
sparc                            allmodconfig    gcc-14.2.0
sparc                       sparc32_defconfig    gcc-14.2.0
sparc64               randconfig-001-20241127    gcc-14.2.0
sparc64               randconfig-002-20241127    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                               allyesconfig    gcc-12
um                    randconfig-001-20241127    gcc-14.2.0
um                    randconfig-002-20241127    gcc-14.2.0
x86_64      buildonly-randconfig-001-20241127    clang-19
x86_64      buildonly-randconfig-002-20241127    clang-19
x86_64      buildonly-randconfig-003-20241127    clang-19
x86_64      buildonly-randconfig-004-20241127    clang-19
x86_64      buildonly-randconfig-005-20241127    clang-19
x86_64      buildonly-randconfig-006-20241127    clang-19
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20241127    clang-19
x86_64                randconfig-002-20241127    clang-19
x86_64                randconfig-003-20241127    clang-19
x86_64                randconfig-004-20241127    clang-19
x86_64                randconfig-005-20241127    clang-19
x86_64                randconfig-006-20241127    clang-19
x86_64                randconfig-011-20241127    clang-19
x86_64                randconfig-012-20241127    clang-19
x86_64                randconfig-013-20241127    clang-19
x86_64                randconfig-014-20241127    clang-19
x86_64                randconfig-015-20241127    clang-19
x86_64                randconfig-016-20241127    clang-19
x86_64                randconfig-071-20241127    clang-19
x86_64                randconfig-072-20241127    clang-19
x86_64                randconfig-073-20241127    clang-19
x86_64                randconfig-074-20241127    clang-19
x86_64                randconfig-075-20241127    clang-19
x86_64                randconfig-076-20241127    clang-19
x86_64                               rhel-9.4    clang-19
xtensa                           alldefconfig    gcc-14.2.0
xtensa                            allnoconfig    gcc-14.2.0
xtensa                       common_defconfig    clang-20
xtensa                       common_defconfig    gcc-14.2.0
xtensa                randconfig-001-20241127    gcc-14.2.0
xtensa                randconfig-002-20241127    gcc-14.2.0
xtensa                    smp_lx200_defconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

