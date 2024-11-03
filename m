Return-Path: <linux-kernel+bounces-393767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B70F9BA4FD
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 10:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BABBB1F21977
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 09:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB51139D1B;
	Sun,  3 Nov 2024 09:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n4dZO6xd"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9A68614E
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 09:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730627304; cv=none; b=r6Mj+7V24ySlwRODzsAwaML9sN3FHNY93vBr5ExkhNtDI34BYWTNNQpoFy8AmaYYjX5H23wZBd/c37a9RisU4wk6UjiUcEZoxVmkmsGVKemHtGhWiADHotSOk9K15qAcaoMX/qB90GePK6tiIrwLxMfF6dJ4LZC3trzrfDDRUvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730627304; c=relaxed/simple;
	bh=6gZ4rnlDjo/NgHpY5/f/9JYeYJ8kOCZmXVBbDUNrZOM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=OOGgzAhvpjRyMf+2i/cJg5fy0wFXMzpGf5ULsTnh7H65BU1OMWy8vHPuC3qvbc6h+9qvJZ5KCeZgVRudMBQS+japJvZYJ/nmXXU1qiNtB/S8/hx0QPfPnpGpign88T44LWWKO6ySchIQfH4hO8R+sGs4/1yJicRdK0pPzu5I11c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n4dZO6xd; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730627303; x=1762163303;
  h=date:from:to:cc:subject:message-id;
  bh=6gZ4rnlDjo/NgHpY5/f/9JYeYJ8kOCZmXVBbDUNrZOM=;
  b=n4dZO6xdFY7bDNVbn/iV2A4pDLmGYr28tKfZWyGKHaGtaj2JbdoCtiXG
   DVTHKbmX4TKENsm5F4+6nPdtYMhUwBoIGnQUnIJi7sPIf0AFjsb1JYJfr
   fpGrWBMPC/zW/OMsUlksdUz12hOj3sGLPVcdig7d6Vb9HnXvE2jKt5hQ+
   lbX4nVgn6zHUd+OAX2I4Rf1mNziFJTHC8HUCP9RY+KzpA3TK2b5vQOnVX
   2tyojaQqlnUK/DFR9GXJuiMk2O4DJVYQ7tTBu3+ANonv5vcmr/8RKs8+D
   soZf/1DWm8iO7YY4oPjEkVo8Rz9mjqu5ErCPnhIKJuzF5fdeXbo41h8Tn
   A==;
X-CSE-ConnectionGUID: Q66m6O1XRDO2IFarn7sslA==
X-CSE-MsgGUID: 085fVb1nQDS6UX86yV1Ecw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30116713"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30116713"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2024 01:48:22 -0800
X-CSE-ConnectionGUID: k6V+AEIsSt+7F6kPoLkWyA==
X-CSE-MsgGUID: wDJn4tbcQj2zXScuzjnzOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,254,1725346800"; 
   d="scan'208";a="87302831"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 03 Nov 2024 01:48:21 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t7XDW-000jrh-2H;
	Sun, 03 Nov 2024 09:48:18 +0000
Date: Sun, 03 Nov 2024 17:47:42 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:timers/vdso] BUILD SUCCESS
 7fa3c36ea2707c495cf31ccab733ac8bf3f9d0c2
Message-ID: <202411031728.NEsA5wbp-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/vdso
branch HEAD: 7fa3c36ea2707c495cf31ccab733ac8bf3f9d0c2  x86/vdso: Add missing brackets in switch case

elapsed time: 739m

configs tested: 204
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                      axs103_smp_defconfig    gcc-13.2.0
arc                                 defconfig    gcc-14.1.0
arc                   randconfig-001-20241103    gcc-14.1.0
arc                   randconfig-002-20241103    gcc-14.1.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                         assabet_defconfig    gcc-14.1.0
arm                         bcm2835_defconfig    gcc-14.1.0
arm                     davinci_all_defconfig    gcc-14.1.0
arm                                 defconfig    gcc-14.1.0
arm                         lpc32xx_defconfig    gcc-14.1.0
arm                       netwinder_defconfig    gcc-14.1.0
arm                          pxa168_defconfig    gcc-13.2.0
arm                   randconfig-001-20241103    gcc-14.1.0
arm                   randconfig-002-20241103    gcc-14.1.0
arm                   randconfig-003-20241103    gcc-14.1.0
arm                   randconfig-004-20241103    gcc-14.1.0
arm                         s3c6400_defconfig    gcc-14.1.0
arm                           sama5_defconfig    gcc-13.2.0
arm                        spear6xx_defconfig    gcc-14.1.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
arm64                 randconfig-001-20241103    gcc-14.1.0
arm64                 randconfig-002-20241103    gcc-14.1.0
arm64                 randconfig-003-20241103    gcc-14.1.0
arm64                 randconfig-004-20241103    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
csky                  randconfig-001-20241103    gcc-14.1.0
csky                  randconfig-002-20241103    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
hexagon               randconfig-001-20241103    gcc-14.1.0
hexagon               randconfig-002-20241103    gcc-14.1.0
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                             allyesconfig    clang-19
i386        buildonly-randconfig-001-20241103    clang-19
i386        buildonly-randconfig-002-20241103    clang-19
i386        buildonly-randconfig-003-20241103    clang-19
i386        buildonly-randconfig-004-20241103    clang-19
i386        buildonly-randconfig-005-20241103    clang-19
i386        buildonly-randconfig-006-20241103    clang-19
i386                                defconfig    clang-19
i386                  randconfig-001-20241103    clang-19
i386                  randconfig-002-20241103    clang-19
i386                  randconfig-003-20241103    clang-19
i386                  randconfig-004-20241103    clang-19
i386                  randconfig-005-20241103    clang-19
i386                  randconfig-006-20241103    clang-19
i386                  randconfig-011-20241103    clang-19
i386                  randconfig-012-20241103    clang-19
i386                  randconfig-013-20241103    clang-19
i386                  randconfig-014-20241103    clang-19
i386                  randconfig-015-20241103    clang-19
i386                  randconfig-016-20241103    clang-19
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
loongarch             randconfig-001-20241103    gcc-14.1.0
loongarch             randconfig-002-20241103    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
m68k                          hp300_defconfig    gcc-14.1.0
m68k                            mac_defconfig    gcc-14.1.0
m68k                        stmark2_defconfig    gcc-13.2.0
m68k                           virt_defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                        bcm63xx_defconfig    gcc-13.2.0
mips                          eyeq5_defconfig    gcc-14.1.0
mips                           ip27_defconfig    gcc-13.2.0
mips                           mtx1_defconfig    gcc-13.2.0
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
nios2                 randconfig-001-20241103    gcc-14.1.0
nios2                 randconfig-002-20241103    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
openrisc                 simple_smp_defconfig    gcc-14.1.0
openrisc                       virt_defconfig    gcc-13.2.0
openrisc                       virt_defconfig    gcc-14.1.0
parisc                           alldefconfig    gcc-14.1.0
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20241103    gcc-14.1.0
parisc                randconfig-002-20241103    gcc-14.1.0
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.1.0
powerpc                        fsp2_defconfig    gcc-13.2.0
powerpc                    gamecube_defconfig    gcc-14.1.0
powerpc                      pasemi_defconfig    gcc-14.1.0
powerpc                      pmac32_defconfig    gcc-14.1.0
powerpc                       ppc64_defconfig    gcc-14.1.0
powerpc                      ppc6xx_defconfig    gcc-14.1.0
powerpc               randconfig-001-20241103    gcc-14.1.0
powerpc               randconfig-002-20241103    gcc-14.1.0
powerpc               randconfig-003-20241103    gcc-14.1.0
powerpc                     redwood_defconfig    gcc-13.2.0
powerpc                     redwood_defconfig    gcc-14.1.0
powerpc                 xes_mpc85xx_defconfig    gcc-14.1.0
powerpc64                        alldefconfig    gcc-14.1.0
powerpc64             randconfig-001-20241103    gcc-14.1.0
powerpc64             randconfig-002-20241103    gcc-14.1.0
powerpc64             randconfig-003-20241103    gcc-14.1.0
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
riscv             nommu_k210_sdcard_defconfig    gcc-14.1.0
riscv                 randconfig-001-20241103    gcc-14.1.0
riscv                 randconfig-002-20241103    gcc-14.1.0
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20241103    gcc-14.1.0
s390                  randconfig-002-20241103    gcc-14.1.0
sh                               alldefconfig    gcc-13.2.0
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                ecovec24-romimage_defconfig    gcc-14.1.0
sh                     magicpanelr2_defconfig    gcc-13.2.0
sh                    randconfig-001-20241103    gcc-14.1.0
sh                    randconfig-002-20241103    gcc-14.1.0
sh                          rsk7269_defconfig    gcc-14.1.0
sh                           se7705_defconfig    gcc-13.2.0
sh                            shmin_defconfig    gcc-13.2.0
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20241103    gcc-14.1.0
sparc64               randconfig-002-20241103    gcc-14.1.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                             i386_defconfig    gcc-14.1.0
um                    randconfig-001-20241103    gcc-14.1.0
um                    randconfig-002-20241103    gcc-14.1.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241103    clang-19
x86_64      buildonly-randconfig-002-20241103    clang-19
x86_64      buildonly-randconfig-003-20241103    clang-19
x86_64      buildonly-randconfig-004-20241103    clang-19
x86_64      buildonly-randconfig-005-20241103    clang-19
x86_64      buildonly-randconfig-006-20241103    clang-19
x86_64                              defconfig    clang-19
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20241103    clang-19
x86_64                randconfig-002-20241103    clang-19
x86_64                randconfig-003-20241103    clang-19
x86_64                randconfig-004-20241103    clang-19
x86_64                randconfig-005-20241103    clang-19
x86_64                randconfig-006-20241103    clang-19
x86_64                randconfig-011-20241103    clang-19
x86_64                randconfig-012-20241103    clang-19
x86_64                randconfig-013-20241103    clang-19
x86_64                randconfig-014-20241103    clang-19
x86_64                randconfig-015-20241103    clang-19
x86_64                randconfig-016-20241103    clang-19
x86_64                randconfig-071-20241103    clang-19
x86_64                randconfig-072-20241103    clang-19
x86_64                randconfig-073-20241103    clang-19
x86_64                randconfig-074-20241103    clang-19
x86_64                randconfig-075-20241103    clang-19
x86_64                randconfig-076-20241103    clang-19
x86_64                               rhel-8.3    gcc-12
x86_64                           rhel-8.3-bpf    clang-19
x86_64                         rhel-8.3-kunit    clang-19
x86_64                           rhel-8.3-ltp    clang-19
x86_64                          rhel-8.3-rust    clang-19
xtensa                            allnoconfig    gcc-14.1.0
xtensa                  cadence_csp_defconfig    gcc-13.2.0
xtensa                  cadence_csp_defconfig    gcc-14.1.0
xtensa                randconfig-001-20241103    gcc-14.1.0
xtensa                randconfig-002-20241103    gcc-14.1.0
xtensa                    smp_lx200_defconfig    gcc-13.2.0
xtensa                    smp_lx200_defconfig    gcc-14.1.0
xtensa                    xip_kc705_defconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

