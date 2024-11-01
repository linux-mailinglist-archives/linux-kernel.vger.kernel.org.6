Return-Path: <linux-kernel+bounces-393026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CAF9B9B14
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 00:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB69F282A7C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 23:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A491E2846;
	Fri,  1 Nov 2024 23:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KQtJHEca"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C74F1607B4
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 23:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730502186; cv=none; b=E0ZpA73olrOjHWEXkpUJ3RNA8sXps9SqAP/5bbW3tt6jtXhTDlmZolvFRFxE9ZT3r8cMET6zcP+CdUqk/aTCErX1grFNIzQNgs4IedQhFaZjgYFK9/x+LXErJCh5TwmIF5veeSlwo0iDlpTEgLhnYFm3KOMml8WtzCZHN/rFtDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730502186; c=relaxed/simple;
	bh=H5CGnMSmbpS6najbSvwt+7FYkT4a+b9mB0BmNKEfVY0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=RKQcym2iwvVJ08BcnSuBFIQ9YXqPKl/M3vOw9+og/tkyF1FI0ALZGDW8lP3aJ3yAM6r11OQtkenqV0bIYlADYe28yzjPelfHh/txmlxxfKdvcE6Da4xAvWsteGukZiNXKkFcW/5kW4/lEeua5aCNwY/Et4u54liLvn+3rCsN4Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KQtJHEca; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730502185; x=1762038185;
  h=date:from:to:cc:subject:message-id;
  bh=H5CGnMSmbpS6najbSvwt+7FYkT4a+b9mB0BmNKEfVY0=;
  b=KQtJHEcabiftULSU0eKqdjUGujoulTuZZj6ekETeasKPtReIXIC6t2jb
   t6QOXKYq1had51r9106SA3yJAnSD7QXO/7mdE2zu2AAx440sIuDd8Hp3G
   5GRtnp1uE2c7XuWqFBk0UZi3GG3ZvMNF3D3UPvq01smpAEBU2z7C7qlct
   HPh+dGBQmnmGUJ+UirOhqCAwtuDS0g9L+qSKFcPpSoMwNP/EDSbATS9TD
   frnti/FBYT4TOrFQAR8RWy8JdI2Ti0z99wdNaUxbUiU75zBFVc9Sx4p4A
   /bN8NdeQmrgA1rvt/4wVXy+a1BORapSKK8/KP+LsoqkW8Nzz5KH38evl/
   Q==;
X-CSE-ConnectionGUID: nsIWonyVRRCQRPoQVOAdEg==
X-CSE-MsgGUID: Q9KY1qjEReiQH9GrTLaqqw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="52844325"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="52844325"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 16:03:05 -0700
X-CSE-ConnectionGUID: 3PAIG/zPTJe9ZNV8zhJKqQ==
X-CSE-MsgGUID: jhj6isymT+WAahMUtXWMEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,251,1725346800"; 
   d="scan'208";a="87036055"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 01 Nov 2024 16:03:03 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t70fV-000i8e-1U;
	Fri, 01 Nov 2024 23:03:01 +0000
Date: Sat, 02 Nov 2024 07:02:59 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 c958c9225bddd9c8e7624aa8ad1235195d4f3d4d
Message-ID: <202411020744.0DmflmPR-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: c958c9225bddd9c8e7624aa8ad1235195d4f3d4d  Merge branch into tip/master: 'x86/sev'

elapsed time: 969m

configs tested: 150
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                                 defconfig    gcc-14.1.0
arc                     nsimosci_hs_defconfig    gcc-13.2.0
arc                   randconfig-001-20241101    gcc-14.1.0
arc                   randconfig-002-20241101    gcc-14.1.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                         bcm2835_defconfig    gcc-13.2.0
arm                                 defconfig    gcc-14.1.0
arm                   randconfig-001-20241101    gcc-14.1.0
arm                   randconfig-002-20241101    gcc-14.1.0
arm                   randconfig-003-20241101    gcc-14.1.0
arm                   randconfig-004-20241101    gcc-14.1.0
arm                         s5pv210_defconfig    gcc-13.2.0
arm                           tegra_defconfig    gcc-13.2.0
arm                           u8500_defconfig    gcc-13.2.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
arm64                 randconfig-001-20241101    gcc-14.1.0
arm64                 randconfig-002-20241101    gcc-14.1.0
arm64                 randconfig-003-20241101    gcc-14.1.0
arm64                 randconfig-004-20241101    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
csky                  randconfig-001-20241101    gcc-14.1.0
csky                  randconfig-002-20241101    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
hexagon               randconfig-001-20241101    gcc-14.1.0
hexagon               randconfig-002-20241101    gcc-14.1.0
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                             allyesconfig    clang-19
i386        buildonly-randconfig-001-20241101    gcc-12
i386        buildonly-randconfig-002-20241101    gcc-12
i386        buildonly-randconfig-003-20241101    gcc-12
i386        buildonly-randconfig-004-20241101    gcc-12
i386        buildonly-randconfig-005-20241101    gcc-12
i386        buildonly-randconfig-006-20241101    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20241101    gcc-12
i386                  randconfig-002-20241101    gcc-12
i386                  randconfig-003-20241101    gcc-12
i386                  randconfig-004-20241101    gcc-12
i386                  randconfig-005-20241101    gcc-12
i386                  randconfig-006-20241101    gcc-12
i386                  randconfig-011-20241101    gcc-12
i386                  randconfig-012-20241101    gcc-12
i386                  randconfig-013-20241101    gcc-12
i386                  randconfig-014-20241101    gcc-12
i386                  randconfig-015-20241101    gcc-12
i386                  randconfig-016-20241101    gcc-12
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
loongarch             randconfig-001-20241101    gcc-14.1.0
loongarch             randconfig-002-20241101    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
m68k                       m5475evb_defconfig    gcc-13.2.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                        bcm47xx_defconfig    gcc-13.2.0
mips                           ip22_defconfig    gcc-13.2.0
mips                       rbtx49xx_defconfig    gcc-13.2.0
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
nios2                 randconfig-001-20241101    gcc-14.1.0
nios2                 randconfig-002-20241101    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20241101    gcc-14.1.0
parisc                randconfig-002-20241101    gcc-14.1.0
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.1.0
powerpc                      arches_defconfig    gcc-13.2.0
powerpc                        fsp2_defconfig    gcc-13.2.0
powerpc               randconfig-001-20241101    gcc-14.1.0
powerpc               randconfig-002-20241101    gcc-14.1.0
powerpc               randconfig-003-20241101    gcc-14.1.0
powerpc64             randconfig-001-20241101    gcc-14.1.0
powerpc64             randconfig-002-20241101    gcc-14.1.0
powerpc64             randconfig-003-20241101    gcc-14.1.0
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20241101    gcc-14.1.0
riscv                 randconfig-002-20241101    gcc-14.1.0
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20241101    gcc-14.1.0
s390                  randconfig-002-20241101    gcc-14.1.0
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20241101    gcc-14.1.0
sh                    randconfig-002-20241101    gcc-14.1.0
sh                           se7712_defconfig    gcc-13.2.0
sh                        sh7757lcr_defconfig    gcc-13.2.0
sparc                            allmodconfig    gcc-14.1.0
sparc                       sparc64_defconfig    gcc-13.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20241101    gcc-14.1.0
sparc64               randconfig-002-20241101    gcc-14.1.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241101    gcc-14.1.0
um                    randconfig-002-20241101    gcc-14.1.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64                              defconfig    clang-19
x86_64                                  kexec    clang-19
x86_64                               rhel-8.3    gcc-12
x86_64                           rhel-8.3-bpf    clang-19
x86_64                         rhel-8.3-kunit    clang-19
x86_64                           rhel-8.3-ltp    clang-19
x86_64                          rhel-8.3-rust    clang-19
xtensa                            allnoconfig    gcc-14.1.0
xtensa                randconfig-001-20241101    gcc-14.1.0
xtensa                randconfig-002-20241101    gcc-14.1.0
xtensa                         virt_defconfig    gcc-13.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

