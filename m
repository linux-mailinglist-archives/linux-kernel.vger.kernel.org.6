Return-Path: <linux-kernel+bounces-243671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE44929918
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 19:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A67DF2838CB
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 17:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95B055886;
	Sun,  7 Jul 2024 17:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h+Halglh"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF813CF51
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jul 2024 17:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720372134; cv=none; b=RhObSZBhWUXu50pgvpqK/7WL+pYN9YQfK7wu8vO75pYauNt5k1U9aL5RccEgJQBsgVkiEbPgK0a5T2F+yKcOGtJl7NYaESxtYSgJS2IbHX4fghyzHHV954SIzgrlHBKRVxB26JrVRiLoNof3BvcGLRZ6XcFNFsQWX0Qovt2PcoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720372134; c=relaxed/simple;
	bh=Zr6bua9n7jlIaSXgaDXA6wjeBUO1POkWipgoQyxZBSM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=HjkEyvwRHIr0iGEutxZfYcUGOIB8uGXd9lh6Lrdyg2Y5CTgSZO9wavLXNPLdK9Ll5Kn4z8YILsZr6QWuz0BLncqGevq+5LC4JJ7nwXTFqtOct+Q172F9D28JaqnHi80/Jhod3n9/f2dKIVVpFxBvNXPzEol2tSXZZU4B18cBzfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h+Halglh; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720372133; x=1751908133;
  h=date:from:to:cc:subject:message-id;
  bh=Zr6bua9n7jlIaSXgaDXA6wjeBUO1POkWipgoQyxZBSM=;
  b=h+HalglhQL5BdzkhPZlBlFZ+Y1NJmcRk/gebMgSEIVH+RZZZeGfMCyZz
   fkORA4QEuvabsgWKtZY22+UrdTwz/bUU9UAJL2C5vVCtYFmdAsB34+2+F
   aAWY5RYzckPbKxtNLxz+RsWMm5NyeoSBph7dWqdX3rP6KarfJ9NjNaR73
   JsvJzWuSiEg5F6igdnKt3zH8lDUPQbu2n/YZsUiu3n9ut9ThRX9c2FCNh
   c2jaYtrmUHQ3pSRo0VcpOXIhMc+V/aWgcSmfHJavUQ50ttJ5vRGb1O19d
   32/ypT3r60GZtVAvREidRIHKdLpzWFf1KNQwmGtVdC5oS3hpRJB56hRf9
   A==;
X-CSE-ConnectionGUID: rIL2W93jTB2bwCsLceX5Fw==
X-CSE-MsgGUID: C0eQfk3RTMCSEPq7T7RP7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11126"; a="17531396"
X-IronPort-AV: E=Sophos;i="6.09,190,1716274800"; 
   d="scan'208";a="17531396"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2024 10:08:52 -0700
X-CSE-ConnectionGUID: r0h1p3jVR3q0ughNL/ma+A==
X-CSE-MsgGUID: KNSz5DytTxy/0OdhEbMp7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,190,1716274800"; 
   d="scan'208";a="51726100"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 07 Jul 2024 10:08:50 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sQVNY-000V8g-0e;
	Sun, 07 Jul 2024 17:08:48 +0000
Date: Mon, 08 Jul 2024 01:08:27 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:non-rcu/next] BUILD SUCCESS
 8122d6e11bd8d3536800b3ad0ea1fec2e2bb9edb
Message-ID: <202407080125.VYLESOG8-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git non-rcu/next
branch HEAD: 8122d6e11bd8d3536800b3ad0ea1fec2e2bb9edb  Merge branches 'cmpxchg.2024.07.04a', 'kcsan.2024.06.06a', 'lkmm.2024.06.06a', 'nolibc.2024.06.30a' and 'torture.2024.05.30b' into HEAD

elapsed time: 720m

configs tested: 259
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                            allyesconfig   gcc-13.2.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                          axs101_defconfig   gcc-13.2.0
arc                          axs103_defconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                     haps_hs_smp_defconfig   gcc-13.2.0
arc                   randconfig-001-20240707   gcc-13.2.0
arc                   randconfig-002-20240707   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                               allnoconfig   clang-19
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                        clps711x_defconfig   clang-19
arm                                 defconfig   clang-14
arm                                 defconfig   gcc-13.2.0
arm                          exynos_defconfig   gcc-13.2.0
arm                          gemini_defconfig   clang-19
arm                            hisi_defconfig   gcc-13.2.0
arm                       netwinder_defconfig   gcc-13.2.0
arm                         nhk8815_defconfig   clang-19
arm                       omap2plus_defconfig   gcc-13.2.0
arm                   randconfig-001-20240707   gcc-13.2.0
arm                   randconfig-002-20240707   clang-19
arm                   randconfig-002-20240707   gcc-13.2.0
arm                   randconfig-003-20240707   clang-19
arm                   randconfig-003-20240707   gcc-13.2.0
arm                   randconfig-004-20240707   clang-19
arm                   randconfig-004-20240707   gcc-13.2.0
arm                        realview_defconfig   gcc-13.2.0
arm64                            alldefconfig   gcc-13.2.0
arm64                            allmodconfig   clang-19
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240707   clang-19
arm64                 randconfig-001-20240707   gcc-13.2.0
arm64                 randconfig-002-20240707   gcc-13.2.0
arm64                 randconfig-003-20240707   gcc-13.2.0
arm64                 randconfig-004-20240707   clang-19
arm64                 randconfig-004-20240707   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240707   gcc-13.2.0
csky                  randconfig-002-20240707   gcc-13.2.0
hexagon                          allmodconfig   clang-19
hexagon                           allnoconfig   clang-19
hexagon                          allyesconfig   clang-19
hexagon                             defconfig   clang-19
hexagon               randconfig-001-20240707   clang-14
hexagon               randconfig-002-20240707   clang-19
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-13
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-13
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240707   gcc-13
i386         buildonly-randconfig-002-20240707   clang-18
i386         buildonly-randconfig-002-20240707   gcc-13
i386         buildonly-randconfig-003-20240707   clang-18
i386         buildonly-randconfig-003-20240707   gcc-13
i386         buildonly-randconfig-004-20240707   gcc-13
i386         buildonly-randconfig-005-20240707   gcc-11
i386         buildonly-randconfig-005-20240707   gcc-13
i386         buildonly-randconfig-006-20240707   gcc-13
i386         buildonly-randconfig-006-20240707   gcc-9
i386                                defconfig   clang-18
i386                  randconfig-001-20240707   gcc-13
i386                  randconfig-001-20240707   gcc-7
i386                  randconfig-002-20240707   clang-18
i386                  randconfig-002-20240707   gcc-13
i386                  randconfig-003-20240707   clang-18
i386                  randconfig-003-20240707   gcc-13
i386                  randconfig-004-20240707   clang-18
i386                  randconfig-004-20240707   gcc-13
i386                  randconfig-005-20240707   clang-18
i386                  randconfig-005-20240707   gcc-13
i386                  randconfig-006-20240707   clang-18
i386                  randconfig-006-20240707   gcc-13
i386                  randconfig-011-20240707   gcc-13
i386                  randconfig-012-20240707   gcc-13
i386                  randconfig-012-20240707   gcc-8
i386                  randconfig-013-20240707   gcc-13
i386                  randconfig-014-20240707   clang-18
i386                  randconfig-014-20240707   gcc-13
i386                  randconfig-015-20240707   clang-18
i386                  randconfig-015-20240707   gcc-13
i386                  randconfig-016-20240707   gcc-13
loongarch                        allmodconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240707   gcc-13.2.0
loongarch             randconfig-002-20240707   gcc-13.2.0
m68k                             alldefconfig   gcc-13.2.0
m68k                             allmodconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-13.2.0
m68k                                defconfig   gcc-13.2.0
m68k                       m5275evb_defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-13.2.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                          ath25_defconfig   gcc-13.2.0
mips                     cu1830-neo_defconfig   gcc-13.2.0
mips                            gpr_defconfig   gcc-13.2.0
mips                           ip27_defconfig   gcc-13.2.0
mips                           ip28_defconfig   gcc-13.2.0
mips                       lemote2f_defconfig   gcc-13.2.0
mips                      loongson3_defconfig   gcc-13.2.0
mips                  maltasmvp_eva_defconfig   gcc-13.2.0
mips                        vocore2_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240707   gcc-13.2.0
nios2                 randconfig-002-20240707   gcc-13.2.0
openrisc                         alldefconfig   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                         allyesconfig   gcc-13.2.0
openrisc                            defconfig   gcc-13.2.0
parisc                           allmodconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                           allyesconfig   gcc-13.2.0
parisc                              defconfig   gcc-13.2.0
parisc                generic-64bit_defconfig   gcc-13.2.0
parisc                randconfig-001-20240707   gcc-13.2.0
parisc                randconfig-002-20240707   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc                          allyesconfig   gcc-13.2.0
powerpc                  iss476-smp_defconfig   gcc-13.2.0
powerpc                      katmai_defconfig   gcc-13.2.0
powerpc                     ksi8560_defconfig   gcc-13.2.0
powerpc                   microwatt_defconfig   gcc-13.2.0
powerpc                 mpc8315_rdb_defconfig   gcc-13.2.0
powerpc                     mpc83xx_defconfig   clang-19
powerpc                  mpc866_ads_defconfig   gcc-13.2.0
powerpc                      ppc6xx_defconfig   gcc-13.2.0
powerpc                     rainier_defconfig   gcc-13.2.0
powerpc               randconfig-001-20240707   clang-19
powerpc               randconfig-001-20240707   gcc-13.2.0
powerpc               randconfig-002-20240707   gcc-13.2.0
powerpc               randconfig-003-20240707   clang-19
powerpc               randconfig-003-20240707   gcc-13.2.0
powerpc                     taishan_defconfig   clang-19
powerpc                     tqm8541_defconfig   gcc-13.2.0
powerpc64             randconfig-001-20240707   clang-17
powerpc64             randconfig-001-20240707   gcc-13.2.0
powerpc64             randconfig-002-20240707   clang-19
powerpc64             randconfig-002-20240707   gcc-13.2.0
powerpc64             randconfig-003-20240707   clang-19
powerpc64             randconfig-003-20240707   gcc-13.2.0
riscv                            allmodconfig   gcc-13.2.0
riscv                             allnoconfig   gcc-13.2.0
riscv                            allyesconfig   gcc-13.2.0
riscv                               defconfig   clang-19
riscv                               defconfig   gcc-13.2.0
riscv                 randconfig-001-20240707   clang-15
riscv                 randconfig-001-20240707   gcc-13.2.0
riscv                 randconfig-002-20240707   clang-19
riscv                 randconfig-002-20240707   gcc-13.2.0
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                             allyesconfig   clang-19
s390                             allyesconfig   gcc-13.2.0
s390                                defconfig   clang-19
s390                                defconfig   gcc-13.2.0
s390                  randconfig-001-20240707   gcc-13.2.0
s390                  randconfig-002-20240707   clang-19
s390                  randconfig-002-20240707   gcc-13.2.0
sh                               allmodconfig   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                               allyesconfig   gcc-13.2.0
sh                                  defconfig   gcc-13.2.0
sh                        edosk7705_defconfig   gcc-13.2.0
sh                             espt_defconfig   gcc-13.2.0
sh                    randconfig-001-20240707   gcc-13.2.0
sh                    randconfig-002-20240707   gcc-13.2.0
sh                           se7619_defconfig   gcc-13.2.0
sh                           se7705_defconfig   gcc-13.2.0
sh                        sh7757lcr_defconfig   gcc-13.2.0
sh                        sh7785lcr_defconfig   gcc-13.2.0
sh                              ul2_defconfig   gcc-13.2.0
sparc                            allmodconfig   gcc-13.2.0
sparc64                             defconfig   gcc-13.2.0
sparc64               randconfig-001-20240707   gcc-13.2.0
sparc64               randconfig-002-20240707   gcc-13.2.0
um                               allmodconfig   clang-19
um                               allmodconfig   gcc-13.2.0
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-13
um                               allyesconfig   gcc-13.2.0
um                                  defconfig   clang-19
um                                  defconfig   gcc-13.2.0
um                             i386_defconfig   gcc-13
um                             i386_defconfig   gcc-13.2.0
um                    randconfig-001-20240707   clang-19
um                    randconfig-001-20240707   gcc-13.2.0
um                    randconfig-002-20240707   gcc-11
um                    randconfig-002-20240707   gcc-13.2.0
um                           x86_64_defconfig   clang-15
um                           x86_64_defconfig   gcc-13.2.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240707   gcc-13
x86_64       buildonly-randconfig-002-20240707   gcc-13
x86_64       buildonly-randconfig-003-20240707   clang-18
x86_64       buildonly-randconfig-003-20240707   gcc-13
x86_64       buildonly-randconfig-004-20240707   gcc-13
x86_64       buildonly-randconfig-005-20240707   clang-18
x86_64       buildonly-randconfig-005-20240707   gcc-13
x86_64       buildonly-randconfig-006-20240707   clang-18
x86_64       buildonly-randconfig-006-20240707   gcc-13
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240707   clang-18
x86_64                randconfig-001-20240707   gcc-13
x86_64                randconfig-002-20240707   clang-18
x86_64                randconfig-002-20240707   gcc-13
x86_64                randconfig-003-20240707   clang-18
x86_64                randconfig-003-20240707   gcc-13
x86_64                randconfig-004-20240707   clang-18
x86_64                randconfig-004-20240707   gcc-13
x86_64                randconfig-005-20240707   gcc-13
x86_64                randconfig-006-20240707   gcc-12
x86_64                randconfig-006-20240707   gcc-13
x86_64                randconfig-011-20240707   clang-18
x86_64                randconfig-011-20240707   gcc-13
x86_64                randconfig-012-20240707   gcc-13
x86_64                randconfig-012-20240707   gcc-7
x86_64                randconfig-013-20240707   clang-18
x86_64                randconfig-013-20240707   gcc-13
x86_64                randconfig-014-20240707   gcc-13
x86_64                randconfig-015-20240707   gcc-13
x86_64                randconfig-015-20240707   gcc-7
x86_64                randconfig-016-20240707   clang-18
x86_64                randconfig-016-20240707   gcc-13
x86_64                randconfig-071-20240707   gcc-13
x86_64                randconfig-072-20240707   gcc-13
x86_64                randconfig-072-20240707   gcc-7
x86_64                randconfig-073-20240707   clang-18
x86_64                randconfig-073-20240707   gcc-13
x86_64                randconfig-074-20240707   clang-18
x86_64                randconfig-074-20240707   gcc-13
x86_64                randconfig-075-20240707   clang-18
x86_64                randconfig-075-20240707   gcc-13
x86_64                randconfig-076-20240707   gcc-13
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                  cadence_csp_defconfig   gcc-13.2.0
xtensa                randconfig-001-20240707   gcc-13.2.0
xtensa                randconfig-002-20240707   gcc-13.2.0
xtensa                    smp_lx200_defconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

