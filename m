Return-Path: <linux-kernel+bounces-435782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 799919E7C34
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 00:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DC8216A4D2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 23:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D64F1FFC7C;
	Fri,  6 Dec 2024 23:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iKFIDy6j"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B991EF090
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 23:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733526392; cv=none; b=OpSKKq3v7apsr6ErDdSKkbD7P2bQ3xmY/QjrmFK7BVJypGnJLWoYIk2L+9z3k35SygGz2XNUoe6BxSFu6ldtvK62mNKxr7WT0r9Ph1c2eEUHMVjLII/zIje3pvCMsafEc00wNzNSsBUoKBAMMbdpxc/CJwbyFTKDouuk7yyalPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733526392; c=relaxed/simple;
	bh=3351oLkaglwMPexUE0wuRjl1ubIDdKuURIQXBo9EoPs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=nR+6yUxCpWsMkNZKNySD/eXHgC3ISLCx+z5L+4TgUxBmarHCyuWVePk3YdmrvySHulN+UlzBDiKiJV2HaM21BP7BXW7d4hme0DRDac2MypcrQlBk0M3IhWGNu8fLomZ/vG1gnT5VXE9m34JA21COJ4+3fg2rsj5joSBpTWUIM7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iKFIDy6j; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733526390; x=1765062390;
  h=date:from:to:cc:subject:message-id;
  bh=3351oLkaglwMPexUE0wuRjl1ubIDdKuURIQXBo9EoPs=;
  b=iKFIDy6j0O17Usn/5y+rGKKyD91Egomjf4w+xiueolwrOrQRBZ4aS/qc
   ++oAJndI5fEgnj/fWJFi2+s3UguGuvDmjrXPEXxSgfLe1Lgbv+THsHNz6
   uiii1FLugVi5FWni7hx1pirMrAXSK3M76A7wrwRvc5TrAGOc8F1VXtQJ8
   ACtjGyua6cFJeLfBzFiEH5YpgV5u1B5sNEWOOv1OeZtuYg8OwTfqAMl0z
   uTRdFhACYwBZapKJG0BB+RgfdYu4sLpSHc20yDGMjD/j/IcGCiCWgvkYb
   zc6xOTcg9ZEaAgjK89XKJQYVyUoVU/cd+nxGeuaYC00AiigGhqyHoREHm
   A==;
X-CSE-ConnectionGUID: A3qD8uURRty9NgajdLVAZQ==
X-CSE-MsgGUID: TJb80XHXShGT75fcnKCRhA==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="37677287"
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="37677287"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 15:06:30 -0800
X-CSE-ConnectionGUID: OvVq8b1HSrejiYMNnKckcQ==
X-CSE-MsgGUID: 6kWgTxURSB2gvRRx2E7yCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="99473302"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 06 Dec 2024 15:06:29 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tJhP0-0002L2-1p;
	Fri, 06 Dec 2024 23:06:26 +0000
Date: Sat, 07 Dec 2024 07:03:24 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/cpu] BUILD SUCCESS
 29188c16006176caee6cb6729103be51a29c1a93
Message-ID: <202412070714.sytCuGyZ-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cpu
branch HEAD: 29188c16006176caee6cb6729103be51a29c1a93  x86/paravirt: Remove the WBINVD callback

elapsed time: 722m

configs tested: 187
configs skipped: 131

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              alldefconfig    clang-20
arc                              allmodconfig    clang-18
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-18
arc                                 defconfig    gcc-14.2.0
arc                            hsdk_defconfig    gcc-14.2.0
arc                     nsimosci_hs_defconfig    gcc-13.2.0
arc                   randconfig-001-20241207    clang-19
arc                   randconfig-002-20241207    clang-19
arm                              allmodconfig    clang-18
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-18
arm                       aspeed_g5_defconfig    gcc-14.2.0
arm                         axm55xx_defconfig    clang-20
arm                          collie_defconfig    gcc-14.2.0
arm                     davinci_all_defconfig    clang-20
arm                                 defconfig    gcc-14.2.0
arm                            dove_defconfig    gcc-14.2.0
arm                           imxrt_defconfig    gcc-13.2.0
arm                         lpc18xx_defconfig    gcc-14.2.0
arm                        multi_v5_defconfig    gcc-14.2.0
arm                         orion5x_defconfig    clang-20
arm                   randconfig-001-20241207    clang-19
arm                   randconfig-002-20241207    clang-19
arm                   randconfig-003-20241207    clang-19
arm                   randconfig-004-20241207    clang-19
arm                           sama7_defconfig    clang-20
arm                        shmobile_defconfig    gcc-14.2.0
arm                           stm32_defconfig    gcc-14.2.0
arm64                            alldefconfig    clang-20
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20241207    clang-19
arm64                 randconfig-002-20241207    clang-19
arm64                 randconfig-003-20241207    clang-19
arm64                 randconfig-004-20241207    clang-19
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20241206    gcc-14.2.0
csky                  randconfig-001-20241207    clang-19
csky                  randconfig-002-20241206    gcc-14.2.0
csky                  randconfig-002-20241207    clang-19
hexagon                           allnoconfig    gcc-14.2.0
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20241206    gcc-14.2.0
hexagon               randconfig-001-20241207    clang-19
hexagon               randconfig-002-20241206    gcc-14.2.0
hexagon               randconfig-002-20241207    clang-19
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                             allyesconfig    clang-19
i386                 buildonly-randconfig-001    gcc-12
i386        buildonly-randconfig-001-20241207    clang-19
i386                 buildonly-randconfig-002    clang-19
i386                 buildonly-randconfig-002    gcc-12
i386        buildonly-randconfig-002-20241207    clang-19
i386                 buildonly-randconfig-003    clang-19
i386                 buildonly-randconfig-003    gcc-12
i386        buildonly-randconfig-003-20241207    clang-19
i386                 buildonly-randconfig-004    gcc-12
i386        buildonly-randconfig-004-20241207    clang-19
i386                 buildonly-randconfig-005    gcc-12
i386        buildonly-randconfig-005-20241207    clang-19
i386                 buildonly-randconfig-006    gcc-12
i386        buildonly-randconfig-006-20241207    clang-19
i386                                defconfig    clang-19
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20241206    gcc-14.2.0
loongarch             randconfig-001-20241207    clang-19
loongarch             randconfig-002-20241206    gcc-14.2.0
loongarch             randconfig-002-20241207    clang-19
m68k                              allnoconfig    gcc-14.2.0
m68k                          atari_defconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                          multi_defconfig    gcc-13.2.0
m68k                        mvme16x_defconfig    gcc-14.2.0
m68k                            q40_defconfig    clang-20
microblaze                        allnoconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
microblaze                      mmu_defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          ath79_defconfig    gcc-14.2.0
mips                        bcm47xx_defconfig    gcc-14.2.0
mips                   sb1250_swarm_defconfig    gcc-14.2.0
nios2                         3c120_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20241206    gcc-14.2.0
nios2                 randconfig-001-20241207    clang-19
nios2                 randconfig-002-20241206    gcc-14.2.0
nios2                 randconfig-002-20241207    clang-19
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
openrisc                  or1klitex_defconfig    gcc-14.2.0
openrisc                 simple_smp_defconfig    gcc-13.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20241206    gcc-14.2.0
parisc                randconfig-001-20241207    clang-19
parisc                randconfig-002-20241206    gcc-14.2.0
parisc                randconfig-002-20241207    clang-19
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.2.0
powerpc                      arches_defconfig    clang-20
powerpc                      bamboo_defconfig    gcc-14.2.0
powerpc                   currituck_defconfig    gcc-14.2.0
powerpc                    ge_imp3a_defconfig    clang-20
powerpc                       holly_defconfig    clang-20
powerpc                      mgcoge_defconfig    gcc-14.2.0
powerpc                 mpc8315_rdb_defconfig    gcc-14.2.0
powerpc                 mpc832x_rdb_defconfig    clang-20
powerpc                 mpc832x_rdb_defconfig    gcc-13.2.0
powerpc                  mpc866_ads_defconfig    clang-20
powerpc                     rainier_defconfig    gcc-14.2.0
powerpc               randconfig-001-20241206    gcc-14.2.0
powerpc               randconfig-001-20241207    clang-19
powerpc               randconfig-002-20241206    gcc-14.2.0
powerpc               randconfig-002-20241207    clang-19
powerpc               randconfig-003-20241206    gcc-14.2.0
powerpc               randconfig-003-20241207    clang-19
powerpc                     redwood_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20241207    clang-19
powerpc64             randconfig-002-20241206    gcc-14.2.0
powerpc64             randconfig-002-20241207    clang-19
powerpc64             randconfig-003-20241206    gcc-14.2.0
powerpc64             randconfig-003-20241207    clang-19
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                                defconfig    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                        edosk7760_defconfig    gcc-14.2.0
sh                          lboxre2_defconfig    gcc-14.2.0
sh                          polaris_defconfig    gcc-14.2.0
sh                      rts7751r2d1_defconfig    clang-20
sh                          sdk7786_defconfig    gcc-14.2.0
sh                           se7724_defconfig    gcc-14.2.0
sh                   secureedge5410_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc64                          alldefconfig    gcc-14.2.0
sparc64                             defconfig    gcc-12
um                               alldefconfig    gcc-14.2.0
um                                allnoconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241206    clang-19
x86_64      buildonly-randconfig-001-20241206    gcc-12
x86_64      buildonly-randconfig-001-20241207    clang-19
x86_64      buildonly-randconfig-002-20241206    clang-19
x86_64      buildonly-randconfig-002-20241206    gcc-12
x86_64      buildonly-randconfig-002-20241207    clang-19
x86_64      buildonly-randconfig-003-20241206    clang-19
x86_64      buildonly-randconfig-003-20241206    gcc-12
x86_64      buildonly-randconfig-003-20241207    clang-19
x86_64      buildonly-randconfig-004-20241206    clang-19
x86_64      buildonly-randconfig-004-20241207    clang-19
x86_64      buildonly-randconfig-005-20241206    clang-19
x86_64      buildonly-randconfig-005-20241206    gcc-11
x86_64      buildonly-randconfig-005-20241207    clang-19
x86_64      buildonly-randconfig-006-20241206    clang-19
x86_64      buildonly-randconfig-006-20241207    clang-19
x86_64                              defconfig    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                       common_defconfig    gcc-13.2.0
xtensa                generic_kc705_defconfig    clang-20
xtensa                  nommu_kc705_defconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

