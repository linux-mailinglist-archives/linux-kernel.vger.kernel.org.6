Return-Path: <linux-kernel+bounces-301000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40EA195EB6B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF6731F2124B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC18613C673;
	Mon, 26 Aug 2024 08:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R7+ZfOj8"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6078837
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 08:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724659666; cv=none; b=nn17Mc4dlWOxEGa1zWFH0d7b3PYi8qYL8eMyKR6w1nPt6IAQ4PNbt5grlTbX31c9XUhFJTcUc3y6XmdZITweg3gJ8CsogEmDRFtYBLrCDbttXC87uKL+65vmxwaL4r6ajV0AWYxiJVS6Ucoh0m6efFqA3Sn0MiNkJCl3ca8CkLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724659666; c=relaxed/simple;
	bh=TDItoQdpvKhZq645R1os/1w/N1EFbDqz+H2KKic2OAg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Rjfvib+tLcmcvCoLT6Hr+uEk3v4xIkKdEkFkn6vVxITlzqxfHr7FhvbofpjEV5elaH7gt7UiE/UL4L9OU6/cpNWrPbw+MFChyKmd+LEqR2PdOwDzgruPgbSCxbpHDxnmycfxr1VVIL+WIQiuDUS+0FKUL1xj0qZB4x5JvIAMS5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R7+ZfOj8; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724659665; x=1756195665;
  h=date:from:to:cc:subject:message-id;
  bh=TDItoQdpvKhZq645R1os/1w/N1EFbDqz+H2KKic2OAg=;
  b=R7+ZfOj8Spq4mMXoIgTgty75zpbu17DDiE/BYKeG+/Cz8Y1uU42FStN4
   YH4Nqr3ykWASK7JCea53eKSXIT2TohXrvSQ5qb7aZiJrXC/1EUKB97I4H
   2i/K2z6fKm9sGf2cuPe7vDmI9V0cf7uCcirfE2oBcHjy4J/lT85yQqvSi
   3IPp3T9zaYsIRn9qOQsGWStBkNi0TtdXigr8TmB36sc0si6AaAovg3tb0
   CdARkSUoJCqE+FmqCYurFTJ51Mau/ZUq+hVTiI3/rSc/NZ9H9cMutf2TP
   F2+8oYGXWSAF+zPFTn4P6AodiLIg8hq4K3X1087yOHmzayb7NPotbGnO5
   w==;
X-CSE-ConnectionGUID: 33AAyw5YQKq4tx5PEvEV3g==
X-CSE-MsgGUID: fK1p5sqqSQarNv78wkqp4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11175"; a="23220990"
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="23220990"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 01:07:44 -0700
X-CSE-ConnectionGUID: B6XPqzolQI6VTob6SaLbRg==
X-CSE-MsgGUID: Zwm5C7UERM+4Ho4EF7ZiMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="67130254"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 26 Aug 2024 01:07:42 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1siUlI-000GbM-1W;
	Mon, 26 Aug 2024 08:07:40 +0000
Date: Mon, 26 Aug 2024 16:07:39 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:timers/core] BUILD SUCCESS
 ed4fb6d7ef68111bb539283561953e5c6e9a6e38
Message-ID: <202408261636.GmePQTe7-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
branch HEAD: ed4fb6d7ef68111bb539283561953e5c6e9a6e38  hrtimer: Use and report correct timerslack values for realtime tasks

elapsed time: 819m

configs tested: 229
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                        nsimosci_defconfig   gcc-12.3.0
arc                   randconfig-001-20240826   gcc-13.2.0
arc                   randconfig-002-20240826   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-20
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-14.1.0
arm                                 defconfig   gcc-13.2.0
arm                          ixp4xx_defconfig   gcc-12.3.0
arm                       netwinder_defconfig   gcc-12.3.0
arm                   randconfig-001-20240826   clang-20
arm                   randconfig-002-20240826   clang-20
arm                   randconfig-003-20240826   clang-20
arm                   randconfig-004-20240826   gcc-14.1.0
arm                         s3c6400_defconfig   gcc-14.1.0
arm                        spear3xx_defconfig   clang-16
arm                           stm32_defconfig   gcc-12.3.0
arm64                            allmodconfig   clang-20
arm64                             allnoconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240826   clang-20
arm64                 randconfig-002-20240826   gcc-14.1.0
arm64                 randconfig-003-20240826   gcc-14.1.0
arm64                 randconfig-004-20240826   clang-15
csky                              allnoconfig   gcc-13.2.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240826   gcc-14.1.0
csky                  randconfig-002-20240826   gcc-14.1.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   clang-20
hexagon                          allyesconfig   clang-20
hexagon               randconfig-001-20240826   clang-16
hexagon               randconfig-002-20240826   clang-20
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-12
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-12
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240826   clang-18
i386         buildonly-randconfig-002-20240826   clang-18
i386         buildonly-randconfig-002-20240826   gcc-12
i386         buildonly-randconfig-003-20240826   clang-18
i386         buildonly-randconfig-004-20240826   clang-18
i386         buildonly-randconfig-005-20240826   clang-18
i386         buildonly-randconfig-006-20240826   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240826   clang-18
i386                  randconfig-001-20240826   gcc-12
i386                  randconfig-002-20240826   clang-18
i386                  randconfig-002-20240826   gcc-12
i386                  randconfig-003-20240826   clang-18
i386                  randconfig-004-20240826   clang-18
i386                  randconfig-004-20240826   gcc-12
i386                  randconfig-005-20240826   clang-18
i386                  randconfig-005-20240826   gcc-12
i386                  randconfig-006-20240826   clang-18
i386                  randconfig-011-20240826   clang-18
i386                  randconfig-011-20240826   gcc-12
i386                  randconfig-012-20240826   clang-18
i386                  randconfig-012-20240826   gcc-12
i386                  randconfig-013-20240826   clang-18
i386                  randconfig-013-20240826   gcc-12
i386                  randconfig-014-20240826   clang-18
i386                  randconfig-014-20240826   gcc-12
i386                  randconfig-015-20240826   clang-18
i386                  randconfig-015-20240826   gcc-12
i386                  randconfig-016-20240826   clang-18
i386                  randconfig-016-20240826   gcc-12
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240826   gcc-14.1.0
loongarch             randconfig-002-20240826   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
m68k                        m5307c3_defconfig   gcc-14.1.0
m68k                          sun3x_defconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-14.1.0
mips                      bmips_stb_defconfig   gcc-12.3.0
mips                 decstation_r4k_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240826   gcc-14.1.0
nios2                 randconfig-002-20240826   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240826   gcc-14.1.0
parisc                randconfig-002-20240826   gcc-14.1.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-20
powerpc                      arches_defconfig   gcc-14.1.0
powerpc                 linkstation_defconfig   gcc-12.3.0
powerpc                     mpc512x_defconfig   clang-20
powerpc                  mpc866_ads_defconfig   gcc-12.3.0
powerpc                  mpc885_ads_defconfig   gcc-12.3.0
powerpc                      pcm030_defconfig   gcc-12.3.0
powerpc                      pmac32_defconfig   clang-20
powerpc               randconfig-001-20240826   clang-20
powerpc                     stx_gp3_defconfig   clang-20
powerpc                     tqm5200_defconfig   gcc-14.1.0
powerpc64             randconfig-001-20240826   clang-20
powerpc64             randconfig-002-20240826   clang-20
powerpc64             randconfig-003-20240826   gcc-13.2.0
riscv                            allmodconfig   clang-20
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-20
riscv                               defconfig   clang-20
riscv                               defconfig   gcc-14.1.0
riscv                    nommu_virt_defconfig   gcc-12.3.0
riscv                 randconfig-001-20240826   clang-20
riscv                 randconfig-002-20240826   gcc-14.1.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                          debug_defconfig   gcc-14.1.0
s390                                defconfig   clang-20
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240826   clang-20
s390                  randconfig-002-20240826   clang-20
sh                               alldefconfig   gcc-14.1.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                             espt_defconfig   gcc-14.1.0
sh                    randconfig-001-20240826   gcc-14.1.0
sh                    randconfig-002-20240826   gcc-14.1.0
sh                      rts7751r2d1_defconfig   gcc-12.3.0
sh                   rts7751r2dplus_defconfig   gcc-12.3.0
sh                           se7724_defconfig   gcc-12.3.0
sh                           se7751_defconfig   gcc-14.1.0
sh                           sh2007_defconfig   gcc-12.3.0
sh                  sh7785lcr_32bit_defconfig   gcc-14.1.0
sh                             shx3_defconfig   gcc-12.3.0
sparc                            allmodconfig   gcc-14.1.0
sparc                       sparc32_defconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240826   gcc-14.1.0
sparc64               randconfig-002-20240826   gcc-14.1.0
um                               allmodconfig   clang-20
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-12
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   clang-20
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-12
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240826   clang-20
um                    randconfig-002-20240826   clang-15
um                           x86_64_defconfig   clang-15
um                           x86_64_defconfig   gcc-14.1.0
x86_64                           alldefconfig   gcc-12.3.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240826   clang-18
x86_64       buildonly-randconfig-002-20240826   clang-18
x86_64       buildonly-randconfig-002-20240826   gcc-12
x86_64       buildonly-randconfig-003-20240826   clang-18
x86_64       buildonly-randconfig-003-20240826   gcc-12
x86_64       buildonly-randconfig-004-20240826   clang-18
x86_64       buildonly-randconfig-004-20240826   gcc-12
x86_64       buildonly-randconfig-005-20240826   clang-18
x86_64       buildonly-randconfig-006-20240826   clang-18
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-11
x86_64                randconfig-001-20240826   clang-18
x86_64                randconfig-001-20240826   gcc-12
x86_64                randconfig-002-20240826   clang-18
x86_64                randconfig-003-20240826   clang-18
x86_64                randconfig-004-20240826   clang-18
x86_64                randconfig-005-20240826   clang-18
x86_64                randconfig-005-20240826   gcc-12
x86_64                randconfig-006-20240826   clang-18
x86_64                randconfig-011-20240826   clang-18
x86_64                randconfig-012-20240826   clang-18
x86_64                randconfig-013-20240826   clang-18
x86_64                randconfig-013-20240826   gcc-12
x86_64                randconfig-014-20240826   clang-18
x86_64                randconfig-014-20240826   gcc-12
x86_64                randconfig-015-20240826   clang-18
x86_64                randconfig-016-20240826   clang-18
x86_64                randconfig-071-20240826   clang-18
x86_64                randconfig-072-20240826   clang-18
x86_64                randconfig-073-20240826   clang-18
x86_64                randconfig-074-20240826   clang-18
x86_64                randconfig-074-20240826   gcc-12
x86_64                randconfig-075-20240826   clang-18
x86_64                randconfig-075-20240826   gcc-12
x86_64                randconfig-076-20240826   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                            allnoconfig   gcc-14.1.0
xtensa                  cadence_csp_defconfig   gcc-14.1.0
xtensa                randconfig-001-20240826   gcc-14.1.0
xtensa                randconfig-002-20240826   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

