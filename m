Return-Path: <linux-kernel+bounces-257980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F94B9381AD
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 16:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0929B280209
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 14:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE0C12F385;
	Sat, 20 Jul 2024 14:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CyKDNaft"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E2E1803D
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 14:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721485564; cv=none; b=OGZIrcTX8tuDY9rc5REe3xYFIo4kMjCeBfmQKigk8xSJy0gAw/CrhVGdvvKFI7OAG8tvRJNh338/jWwUV728pAxG5ipg/EEgWif6KU+8G6t6LgOd84nYwDN7+fVmPst6RL8whZ4SqEJ1k/ML1flil3Nio6Y/TfBj6aTEUE7p8Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721485564; c=relaxed/simple;
	bh=MY9RCVoDzFHkFhin9EvYjvu7DjACRzGHBG0RwGoVCR4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Wq/N0ttQhzMm1XsTjONjKRcH0x86L9P343Q+5yRH/S/Us706i0uRVAmbvXcLtFlt3aEN/XgdF/UwYBkQ+EeE4Ip0M0ZbHSRHPfSZzRPqgSgI6JpIJr+CAWsfui+1W/NLT68zP3Q2oMOxS37bY2oTfgj7GNoK1Y4nIONaoVxp1fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CyKDNaft; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721485563; x=1753021563;
  h=date:from:to:cc:subject:message-id;
  bh=MY9RCVoDzFHkFhin9EvYjvu7DjACRzGHBG0RwGoVCR4=;
  b=CyKDNaftuWaDU/2vtAp7gx/Teb+UjZshszyl8+IvveogIs3qYFgQMPs7
   MhHjBwaxdX7nwzfX6MFGpZR2wpi2io0uQSHe27G4mDTMeFHZRU3phoYtc
   QRT0Ds8teH6Aqb4CtV7W2AfmxPqWOF+CZgclSTo3vYl3bw0VainqLkrwM
   j+CER0aUwe0NuoBnbOhI6BSGG1ZX4FyJo5iNRTYLB/yn76N6ldVXXqthg
   kGGQMHkZtc3qNStPsoeQ7jrI6BBtTfMLNT9rbU9h2D8jBMYnocOF2bbWj
   bFY66Oy/aEdfz92mo1RC8/PmVgyrP7zQU4kAza0beHFEgCABTixxAkXjQ
   Q==;
X-CSE-ConnectionGUID: 7oispZaET9quBsdGqaZRIw==
X-CSE-MsgGUID: 2D6A01CyTyW8RzNu2b98pQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11139"; a="36536863"
X-IronPort-AV: E=Sophos;i="6.09,224,1716274800"; 
   d="scan'208";a="36536863"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2024 07:26:02 -0700
X-CSE-ConnectionGUID: fqzw7nDcT0qi3HAm1JZwJQ==
X-CSE-MsgGUID: LL4OV0xcTli9IBZyB2CMdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,224,1716274800"; 
   d="scan'208";a="55687208"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 20 Jul 2024 07:26:00 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sVB26-000jH7-0o;
	Sat, 20 Jul 2024 14:25:58 +0000
Date: Sat, 20 Jul 2024 22:23:30 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:timers/urgent] BUILD SUCCESS
 bfb05c7ccd03d2838342d23bbcd587f203a98b88
Message-ID: <202407202227.vZSjCdJ3-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/urgent
branch HEAD: bfb05c7ccd03d2838342d23bbcd587f203a98b88  timers/migration: Fix grammar in comment

elapsed time: 1178m

configs tested: 243
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                          axs101_defconfig   gcc-13.2.0
arc                      axs103_smp_defconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                     nsimosci_hs_defconfig   gcc-13.2.0
arc                   randconfig-001-20240720   gcc-13.2.0
arc                   randconfig-002-20240720   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-19
arm                              allyesconfig   gcc-13.2.0
arm                              allyesconfig   gcc-14.1.0
arm                       aspeed_g5_defconfig   gcc-13.2.0
arm                                 defconfig   gcc-13.2.0
arm                       omap2plus_defconfig   gcc-13.2.0
arm                          pxa168_defconfig   gcc-13.2.0
arm                   randconfig-001-20240720   clang-15
arm                   randconfig-001-20240720   gcc-13.2.0
arm                   randconfig-002-20240720   gcc-13.2.0
arm                   randconfig-002-20240720   gcc-14.1.0
arm                   randconfig-003-20240720   gcc-13.2.0
arm                   randconfig-003-20240720   gcc-14.1.0
arm                   randconfig-004-20240720   gcc-13.2.0
arm                   randconfig-004-20240720   gcc-14.1.0
arm                        shmobile_defconfig   gcc-13.2.0
arm                           stm32_defconfig   gcc-13.2.0
arm                        vexpress_defconfig   gcc-13.2.0
arm64                            allmodconfig   clang-19
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240720   gcc-13.2.0
arm64                 randconfig-001-20240720   gcc-14.1.0
arm64                 randconfig-002-20240720   clang-17
arm64                 randconfig-002-20240720   gcc-13.2.0
arm64                 randconfig-003-20240720   gcc-13.2.0
arm64                 randconfig-003-20240720   gcc-14.1.0
arm64                 randconfig-004-20240720   clang-19
arm64                 randconfig-004-20240720   gcc-13.2.0
csky                             alldefconfig   gcc-13.2.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240720   gcc-13.2.0
csky                  randconfig-001-20240720   gcc-14.1.0
csky                  randconfig-002-20240720   gcc-13.2.0
csky                  randconfig-002-20240720   gcc-14.1.0
hexagon                          allmodconfig   clang-19
hexagon                           allnoconfig   clang-19
hexagon                          allyesconfig   clang-19
hexagon               randconfig-001-20240720   clang-16
hexagon               randconfig-002-20240720   clang-19
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-13
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-13
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240720   clang-18
i386         buildonly-randconfig-002-20240720   clang-18
i386         buildonly-randconfig-002-20240720   gcc-13
i386         buildonly-randconfig-003-20240720   clang-18
i386         buildonly-randconfig-003-20240720   gcc-13
i386         buildonly-randconfig-004-20240720   clang-18
i386         buildonly-randconfig-005-20240720   clang-18
i386         buildonly-randconfig-006-20240720   clang-18
i386         buildonly-randconfig-006-20240720   gcc-11
i386                                defconfig   clang-18
i386                  randconfig-001-20240720   clang-18
i386                  randconfig-001-20240720   gcc-7
i386                  randconfig-002-20240720   clang-18
i386                  randconfig-003-20240720   clang-18
i386                  randconfig-004-20240720   clang-18
i386                  randconfig-005-20240720   clang-18
i386                  randconfig-005-20240720   gcc-13
i386                  randconfig-006-20240720   clang-18
i386                  randconfig-006-20240720   gcc-11
i386                  randconfig-011-20240720   clang-18
i386                  randconfig-011-20240720   gcc-13
i386                  randconfig-012-20240720   clang-18
i386                  randconfig-012-20240720   gcc-13
i386                  randconfig-013-20240720   clang-18
i386                  randconfig-013-20240720   gcc-13
i386                  randconfig-014-20240720   clang-18
i386                  randconfig-014-20240720   gcc-13
i386                  randconfig-015-20240720   clang-18
i386                  randconfig-015-20240720   gcc-12
i386                  randconfig-016-20240720   clang-18
i386                  randconfig-016-20240720   gcc-13
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240720   gcc-13.2.0
loongarch             randconfig-001-20240720   gcc-14.1.0
loongarch             randconfig-002-20240720   gcc-13.2.0
loongarch             randconfig-002-20240720   gcc-14.1.0
m68k                             alldefconfig   gcc-13.2.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
m68k                       m5249evb_defconfig   gcc-13.2.0
m68k                        m5407c3_defconfig   gcc-13.2.0
m68k                        mvme147_defconfig   gcc-13.2.0
m68k                           sun3_defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-14.1.0
mips                     decstation_defconfig   gcc-13.2.0
mips                           gcw0_defconfig   gcc-13.2.0
mips                           ip32_defconfig   gcc-13.2.0
mips                       lemote2f_defconfig   gcc-13.2.0
mips                      maltaaprp_defconfig   gcc-13.2.0
mips                          rb532_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240720   gcc-13.2.0
nios2                 randconfig-001-20240720   gcc-14.1.0
nios2                 randconfig-002-20240720   gcc-13.2.0
nios2                 randconfig-002-20240720   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240720   gcc-13.2.0
parisc                randconfig-001-20240720   gcc-14.1.0
parisc                randconfig-002-20240720   gcc-13.2.0
parisc                randconfig-002-20240720   gcc-14.1.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-19
powerpc                          allyesconfig   gcc-14.1.0
powerpc                     asp8347_defconfig   gcc-13.2.0
powerpc                 mpc832x_rdb_defconfig   gcc-13.2.0
powerpc                      pmac32_defconfig   gcc-13.2.0
powerpc                         ps3_defconfig   gcc-13.2.0
powerpc               randconfig-001-20240720   clang-19
powerpc               randconfig-001-20240720   gcc-13.2.0
powerpc               randconfig-002-20240720   clang-19
powerpc               randconfig-003-20240720   gcc-14.1.0
powerpc                     redwood_defconfig   gcc-13.2.0
powerpc64             randconfig-001-20240720   clang-19
powerpc64             randconfig-001-20240720   gcc-13.2.0
powerpc64             randconfig-002-20240720   clang-19
powerpc64             randconfig-002-20240720   gcc-13.2.0
powerpc64             randconfig-003-20240720   gcc-13.2.0
powerpc64             randconfig-003-20240720   gcc-14.1.0
riscv                            allmodconfig   clang-19
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-19
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-14.1.0
riscv                 randconfig-001-20240720   clang-19
riscv                 randconfig-001-20240720   gcc-13.2.0
riscv                 randconfig-002-20240720   gcc-13.2.0
riscv                 randconfig-002-20240720   gcc-14.1.0
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                             allyesconfig   clang-19
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240720   gcc-13.2.0
s390                  randconfig-001-20240720   gcc-14.1.0
s390                  randconfig-002-20240720   clang-15
s390                  randconfig-002-20240720   gcc-13.2.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                        apsh4ad0a_defconfig   gcc-13.2.0
sh                                  defconfig   gcc-14.1.0
sh                               j2_defconfig   gcc-13.2.0
sh                     magicpanelr2_defconfig   gcc-13.2.0
sh                    randconfig-001-20240720   gcc-13.2.0
sh                    randconfig-001-20240720   gcc-14.1.0
sh                    randconfig-002-20240720   gcc-13.2.0
sh                    randconfig-002-20240720   gcc-14.1.0
sh                   rts7751r2dplus_defconfig   gcc-13.2.0
sh                             sh03_defconfig   gcc-13.2.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240720   gcc-13.2.0
sparc64               randconfig-001-20240720   gcc-14.1.0
sparc64               randconfig-002-20240720   gcc-13.2.0
sparc64               randconfig-002-20240720   gcc-14.1.0
um                               allmodconfig   clang-19
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-13
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-13.2.0
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240720   gcc-13
um                    randconfig-001-20240720   gcc-13.2.0
um                    randconfig-002-20240720   clang-15
um                    randconfig-002-20240720   gcc-13.2.0
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240720   clang-18
x86_64       buildonly-randconfig-002-20240720   clang-18
x86_64       buildonly-randconfig-003-20240720   clang-18
x86_64       buildonly-randconfig-004-20240720   clang-18
x86_64       buildonly-randconfig-005-20240720   clang-18
x86_64       buildonly-randconfig-006-20240720   clang-18
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240720   clang-18
x86_64                randconfig-002-20240720   clang-18
x86_64                randconfig-003-20240720   clang-18
x86_64                randconfig-004-20240720   clang-18
x86_64                randconfig-005-20240720   clang-18
x86_64                randconfig-006-20240720   clang-18
x86_64                randconfig-011-20240720   clang-18
x86_64                randconfig-012-20240720   clang-18
x86_64                randconfig-013-20240720   clang-18
x86_64                randconfig-014-20240720   clang-18
x86_64                randconfig-015-20240720   clang-18
x86_64                randconfig-016-20240720   clang-18
x86_64                randconfig-071-20240720   clang-18
x86_64                randconfig-072-20240720   clang-18
x86_64                randconfig-073-20240720   clang-18
x86_64                randconfig-074-20240720   clang-18
x86_64                randconfig-075-20240720   clang-18
x86_64                randconfig-076-20240720   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240720   gcc-13.2.0
xtensa                randconfig-001-20240720   gcc-14.1.0
xtensa                randconfig-002-20240720   gcc-13.2.0
xtensa                randconfig-002-20240720   gcc-14.1.0
xtensa                         virt_defconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

