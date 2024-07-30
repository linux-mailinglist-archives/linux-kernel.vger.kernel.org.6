Return-Path: <linux-kernel+bounces-267328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 712B994103E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 13:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F4BB1C226A5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 11:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C59F198858;
	Tue, 30 Jul 2024 11:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bmuXz1JA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DA518EFE0
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 11:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722337841; cv=none; b=I/dLaDqWhviSJzQpPxxsiLCe9vkz87Pocwq5qoe/DdcBKe43v0gJfltrAx99EBHJjrxvkMPpqO4F48Ki12cgAfMwx6QckXweqD3hAeQa8AEl7TI4L9OpNX7BPyHBKSYlCprAmxH0vwPymflMgzNBndIdavEe8mkT2+lE+YRLdiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722337841; c=relaxed/simple;
	bh=JPhtziPbV9zZzjTUfSZZMlgy9DI6oaJUBSoPCHMbnFU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=hZGkM7QDQ1cBCva/PdOGzwTFJ4l0L3omH6+ulYxNnqVSwjn17YsCJe/lZKlkVr/BQFBVWz71kQtMrGnUKFmsldnPT5gSLMZJ2w1tQsy630OrvgaloRDDn5xaY9uOvl6VHtY1grtPbb4hPGkjK6OafqJ7vrv14fmEHvrQ79qkaTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bmuXz1JA; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722337839; x=1753873839;
  h=date:from:to:cc:subject:message-id;
  bh=JPhtziPbV9zZzjTUfSZZMlgy9DI6oaJUBSoPCHMbnFU=;
  b=bmuXz1JAF5AjqGBLih8CAG8uhcYOdHwIUWuKgVM3frSgK261iY837e/1
   ZGp9nG1OTCEAX/t4mRoI2SA1tBZbsy7uPpJB35w4SkI0tGOKL1JnGv9ln
   8PZsRcZ5qKPvCZBffo+/sn2MOX0rH5zj/cFuthKWtfKZUVKBFKr2PVnqW
   5m3EcqXWH3bkX9rKdgw3/IS6grF8qU/r42LKx45ROtiW3RmbyCk1QwMK9
   wq9JZqfRBF30HdJy+IoCAcf/wMwoJFQOyOarrin7TSdy1VRHkd/WD9eLT
   oQppzBnCsTMugBZuI3+4r/MToCQYWqNaC9FiH6N+hAvlYoZaimog2OVl8
   A==;
X-CSE-ConnectionGUID: VSdt8lzIQTiHg8CVMS6Gjg==
X-CSE-MsgGUID: EI609NuqRuiiLMkAmsT6Bw==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="31540116"
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="31540116"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 04:10:38 -0700
X-CSE-ConnectionGUID: lLzZd/EbRpaSUAb3RzS7vQ==
X-CSE-MsgGUID: tFL+QQwtQDKiqcRwmemAwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="53971321"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 30 Jul 2024 04:10:36 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sYkkS-000smo-0W;
	Tue, 30 Jul 2024 11:10:32 +0000
Date: Tue, 30 Jul 2024 19:09:40 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:irq/core] BUILD REGRESSION
 e626fcbaa9b67e4488ea437e0e8a5657e707d5f8
Message-ID: <202407301936.1X9oHOAs-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
branch HEAD: e626fcbaa9b67e4488ea437e0e8a5657e707d5f8  irqchip: Remove asmlinkage for handlers registered with set_handle_irq()

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202407300645.8EAO5dys-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202407300832.j5i0hRhx-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

drivers/irqchip/irq-armada-370-xp.c:263:37: error: use of undeclared identifier 'd'
drivers/irqchip/irq-armada-370-xp.c:263:44: error: 'd' undeclared (first use in this function)

Error/Warning ids grouped by kconfigs:

recent_errors
|-- arm-allyesconfig
|   `-- drivers-irqchip-irq-armada-xp.c:error:d-undeclared-(first-use-in-this-function)
`-- arm-defconfig
    `-- drivers-irqchip-irq-armada-xp.c:error:use-of-undeclared-identifier-d

elapsed time: 1403m

configs tested: 225
configs skipped: 8

tested configs:
alpha                            alldefconfig   gcc-13.3.0
alpha                             allnoconfig   gcc-13.2.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                        nsimosci_defconfig   gcc-13.2.0
arc                   randconfig-001-20240730   gcc-13.2.0
arc                   randconfig-002-20240730   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                              allyesconfig   gcc-14.1.0
arm                         bcm2835_defconfig   clang-20
arm                                 defconfig   gcc-13.2.0
arm                            dove_defconfig   gcc-13.3.0
arm                            hisi_defconfig   gcc-13.2.0
arm                      integrator_defconfig   gcc-13.3.0
arm                        keystone_defconfig   clang-20
arm                        keystone_defconfig   gcc-13.2.0
arm                         nhk8815_defconfig   gcc-13.3.0
arm                             pxa_defconfig   gcc-13.2.0
arm                   randconfig-001-20240730   gcc-13.2.0
arm                   randconfig-002-20240730   gcc-13.2.0
arm                   randconfig-003-20240730   gcc-13.2.0
arm                   randconfig-004-20240730   gcc-13.2.0
arm                        shmobile_defconfig   gcc-13.3.0
arm                       spear13xx_defconfig   gcc-13.3.0
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240730   gcc-13.2.0
arm64                 randconfig-002-20240730   gcc-13.2.0
arm64                 randconfig-003-20240730   gcc-13.2.0
arm64                 randconfig-004-20240730   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240730   gcc-13.2.0
csky                  randconfig-002-20240730   gcc-13.2.0
hexagon                          allmodconfig   clang-20
hexagon                          allyesconfig   clang-20
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-13
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-13
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240729   clang-18
i386         buildonly-randconfig-001-20240730   gcc-13
i386         buildonly-randconfig-002-20240729   gcc-13
i386         buildonly-randconfig-002-20240730   gcc-13
i386         buildonly-randconfig-003-20240729   clang-18
i386         buildonly-randconfig-003-20240730   gcc-13
i386         buildonly-randconfig-004-20240729   gcc-10
i386         buildonly-randconfig-004-20240730   gcc-13
i386         buildonly-randconfig-005-20240729   clang-18
i386         buildonly-randconfig-005-20240730   gcc-13
i386         buildonly-randconfig-006-20240729   gcc-8
i386         buildonly-randconfig-006-20240730   gcc-13
i386                                defconfig   clang-18
i386                  randconfig-001-20240729   gcc-12
i386                  randconfig-001-20240730   gcc-13
i386                  randconfig-002-20240729   clang-18
i386                  randconfig-002-20240730   gcc-13
i386                  randconfig-003-20240729   gcc-10
i386                  randconfig-003-20240730   gcc-13
i386                  randconfig-004-20240729   gcc-13
i386                  randconfig-004-20240730   gcc-13
i386                  randconfig-005-20240729   gcc-8
i386                  randconfig-005-20240730   gcc-13
i386                  randconfig-006-20240729   gcc-13
i386                  randconfig-006-20240730   gcc-13
i386                  randconfig-011-20240729   gcc-13
i386                  randconfig-011-20240730   gcc-13
i386                  randconfig-012-20240729   clang-18
i386                  randconfig-012-20240730   gcc-13
i386                  randconfig-013-20240729   gcc-9
i386                  randconfig-013-20240730   gcc-13
i386                  randconfig-014-20240729   clang-18
i386                  randconfig-014-20240730   gcc-13
i386                  randconfig-015-20240729   gcc-13
i386                  randconfig-015-20240730   gcc-13
i386                  randconfig-016-20240729   clang-18
i386                  randconfig-016-20240730   gcc-13
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240730   gcc-13.2.0
loongarch             randconfig-002-20240730   gcc-13.2.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                     cu1000-neo_defconfig   gcc-13.2.0
mips                           gcw0_defconfig   gcc-13.2.0
mips                            gpr_defconfig   gcc-13.2.0
mips                malta_qemu_32r6_defconfig   clang-20
mips                      maltaaprp_defconfig   gcc-13.2.0
mips                        qi_lb60_defconfig   gcc-13.3.0
nios2                         10m50_defconfig   gcc-13.3.0
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240730   gcc-13.2.0
nios2                 randconfig-002-20240730   gcc-13.2.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                generic-64bit_defconfig   gcc-13.2.0
parisc                generic-64bit_defconfig   gcc-13.3.0
parisc                randconfig-001-20240730   gcc-13.2.0
parisc                randconfig-002-20240730   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-20
powerpc                          allyesconfig   gcc-14.1.0
powerpc                 canyonlands_defconfig   clang-20
powerpc                 canyonlands_defconfig   gcc-13.2.0
powerpc                       ebony_defconfig   clang-20
powerpc                       eiger_defconfig   gcc-13.3.0
powerpc                     ep8248e_defconfig   clang-20
powerpc                 mpc834x_itx_defconfig   gcc-13.3.0
powerpc                      pmac32_defconfig   clang-20
powerpc                     rainier_defconfig   gcc-13.3.0
powerpc               randconfig-002-20240730   gcc-13.2.0
powerpc               randconfig-003-20240730   gcc-13.2.0
powerpc                    sam440ep_defconfig   gcc-13.2.0
powerpc                     taishan_defconfig   clang-20
powerpc                     tqm5200_defconfig   gcc-13.3.0
powerpc                     tqm8541_defconfig   gcc-13.3.0
powerpc                     tqm8555_defconfig   clang-20
powerpc                      tqm8xx_defconfig   clang-20
powerpc64             randconfig-001-20240730   gcc-13.2.0
powerpc64             randconfig-002-20240730   gcc-13.2.0
powerpc64             randconfig-003-20240730   gcc-13.2.0
riscv                            allmodconfig   clang-20
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-20
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-14.1.0
riscv                 randconfig-001-20240730   gcc-13.2.0
riscv                 randconfig-002-20240730   gcc-13.2.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240730   gcc-13.2.0
s390                  randconfig-002-20240730   gcc-13.2.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                             espt_defconfig   gcc-13.2.0
sh                          polaris_defconfig   gcc-13.2.0
sh                          r7780mp_defconfig   gcc-13.2.0
sh                    randconfig-001-20240730   gcc-13.2.0
sh                    randconfig-002-20240730   gcc-13.2.0
sh                          rsk7269_defconfig   gcc-13.2.0
sh                          rsk7269_defconfig   gcc-13.3.0
sh                           se7721_defconfig   gcc-13.2.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240730   gcc-13.2.0
sparc64               randconfig-002-20240730   gcc-13.2.0
um                               allmodconfig   clang-20
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-13
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240730   gcc-13.2.0
um                    randconfig-002-20240730   gcc-13.2.0
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240730   clang-18
x86_64       buildonly-randconfig-002-20240730   clang-18
x86_64       buildonly-randconfig-003-20240730   clang-18
x86_64       buildonly-randconfig-004-20240730   clang-18
x86_64       buildonly-randconfig-005-20240730   clang-18
x86_64       buildonly-randconfig-006-20240730   clang-18
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-13
x86_64                                  kexec   clang-18
x86_64                randconfig-001-20240730   clang-18
x86_64                randconfig-002-20240730   clang-18
x86_64                randconfig-003-20240730   clang-18
x86_64                randconfig-004-20240730   clang-18
x86_64                randconfig-005-20240730   clang-18
x86_64                randconfig-006-20240730   clang-18
x86_64                randconfig-011-20240730   clang-18
x86_64                randconfig-012-20240730   clang-18
x86_64                randconfig-013-20240730   clang-18
x86_64                randconfig-014-20240730   clang-18
x86_64                randconfig-015-20240730   clang-18
x86_64                randconfig-016-20240730   clang-18
x86_64                randconfig-071-20240730   clang-18
x86_64                randconfig-072-20240730   clang-18
x86_64                randconfig-073-20240730   clang-18
x86_64                randconfig-074-20240730   clang-18
x86_64                randconfig-075-20240730   clang-18
x86_64                randconfig-076-20240730   clang-18
x86_64                          rhel-8.3-rust   clang-18
x86_64                               rhel-8.3   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                randconfig-001-20240730   gcc-13.2.0
xtensa                randconfig-002-20240730   gcc-13.2.0
xtensa                    smp_lx200_defconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

