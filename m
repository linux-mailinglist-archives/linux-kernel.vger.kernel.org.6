Return-Path: <linux-kernel+bounces-291264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A00956006
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 00:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B98A281AF7
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 22:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F69F15572C;
	Sun, 18 Aug 2024 22:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JMD+G7aQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4163D531
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 22:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724021238; cv=none; b=luFMtfjqSSVQuuvhtlo94Sqz4gLmagwcdnIDW3XEIKYQnirEbVWX0PGrgnDAEmP+GFpxAe1Mc766du4dhyAYDyStYCAvFosjp4bTIF6U/ZmpT1Kt3yYAGOxzQbAiJH/CgjMuJjJbe63Lw91igk+6mqq8dlApay0exnhfB9BICXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724021238; c=relaxed/simple;
	bh=0gQqbJreQs8kLk9SpRkg9KTRGP59uNCc/p268B/sPQ4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=EbbL63RLo4ZBGm8IuR5Yz6hhaWm/qUyewyL00KbG3WHoeEVMFndvEXOB6lxUZbZyXDxYslZ70jegYeaDuP+NM/oaMBmHCJ9/vAlCyUBgYgNnnbO3GEGlePIG0og0nA3Me5ykTrIYLSxg0NLOaj4KvBGE48Zj1G5450DZnBn2Pgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JMD+G7aQ; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724021236; x=1755557236;
  h=date:from:to:cc:subject:message-id;
  bh=0gQqbJreQs8kLk9SpRkg9KTRGP59uNCc/p268B/sPQ4=;
  b=JMD+G7aQ3b/Bcx7m75W4xJvRHhaEffJadj0PCuEugM0E0e+iKQAuv/4t
   +IN2k4C9/3+FtIjnuNOMKsyNCgrD2uPYeoueKjPrKPhooCh+ct23z6c47
   4sSBG49SSefgqQTO7AQ+5V5yHxLlHK9n3jv4oiYJs1VpUCXi4ole0fTrf
   9bCvi2Zo3Fa79tZXqv3T8WSv73KHO2CZ1V3KHzIUSlKtgzXia7mLasHYC
   cYqjb3XSYHLeWpHUd/np75GkJV9SwgJg3kmwQln7V70yMH3DvHk+ZlxS2
   dMzS2L8jb+pYrpkx0tH2IVqJebCF4MdprdwEci+yRl4d3BNtyX+fxCYXa
   w==;
X-CSE-ConnectionGUID: VOt6SBhpS62FnRfC4PnrLA==
X-CSE-MsgGUID: wgK/Y/C6RF2+pNy0fUCvsQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="33630116"
X-IronPort-AV: E=Sophos;i="6.10,157,1719903600"; 
   d="scan'208";a="33630116"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2024 15:47:14 -0700
X-CSE-ConnectionGUID: cCGhso8rSnKxjPE9gX9/0g==
X-CSE-MsgGUID: 4pxaAQ0xR1eqYlB4adNhtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,157,1719903600"; 
   d="scan'208";a="83412092"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 18 Aug 2024 15:47:13 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sfog2-0008Uk-2x;
	Sun, 18 Aug 2024 22:47:10 +0000
Date: Mon, 19 Aug 2024 06:46:51 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 81b6ef7427cb4b90c913488c665414ba21bbe46d
Message-ID: <202408190649.wnS1Yip6-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 81b6ef7427cb4b90c913488c665414ba21bbe46d  Merge branch into tip/master: 'x86/timers'

elapsed time: 727m

configs tested: 169
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.3.0
arc                              alldefconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                          axs103_defconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                        nsim_700_defconfig   gcc-13.2.0
arc                   randconfig-001-20240818   gcc-13.2.0
arc                   randconfig-002-20240818   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-20
arm                              allyesconfig   gcc-14.1.0
arm                                 defconfig   clang-14
arm                      footbridge_defconfig   clang-20
arm                   randconfig-001-20240818   clang-15
arm                   randconfig-002-20240818   gcc-14.1.0
arm                   randconfig-003-20240818   clang-20
arm                   randconfig-004-20240818   clang-20
arm                             rpc_defconfig   clang-20
arm                         s3c6400_defconfig   gcc-14.1.0
arm64                            allmodconfig   clang-20
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-14.1.0
arm64                 randconfig-001-20240818   gcc-14.1.0
arm64                 randconfig-002-20240818   gcc-14.1.0
arm64                 randconfig-003-20240818   gcc-14.1.0
arm64                 randconfig-004-20240818   gcc-14.1.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-14.1.0
csky                  randconfig-001-20240818   gcc-14.1.0
csky                  randconfig-002-20240818   gcc-14.1.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   clang-20
hexagon                          allyesconfig   clang-20
hexagon                             defconfig   clang-20
hexagon               randconfig-001-20240818   clang-20
hexagon               randconfig-002-20240818   clang-20
i386                             allmodconfig   gcc-12
i386                              allnoconfig   gcc-12
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240818   gcc-12
i386         buildonly-randconfig-002-20240818   clang-18
i386         buildonly-randconfig-003-20240818   clang-18
i386         buildonly-randconfig-004-20240818   clang-18
i386         buildonly-randconfig-005-20240818   gcc-12
i386         buildonly-randconfig-006-20240818   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240818   clang-18
i386                  randconfig-002-20240818   gcc-12
i386                  randconfig-003-20240818   clang-18
i386                  randconfig-004-20240818   clang-18
i386                  randconfig-005-20240818   clang-18
i386                  randconfig-006-20240818   gcc-12
i386                  randconfig-011-20240818   gcc-12
i386                  randconfig-012-20240818   gcc-12
i386                  randconfig-013-20240818   gcc-12
i386                  randconfig-014-20240818   clang-18
i386                  randconfig-015-20240818   clang-18
i386                  randconfig-016-20240818   gcc-11
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-14.1.0
loongarch             randconfig-001-20240818   gcc-14.1.0
loongarch             randconfig-002-20240818   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
mips                           ip22_defconfig   gcc-14.1.0
mips                      maltaaprp_defconfig   clang-14
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-14.1.0
nios2                 randconfig-001-20240818   gcc-14.1.0
nios2                 randconfig-002-20240818   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240818   gcc-14.1.0
parisc                randconfig-002-20240818   gcc-14.1.0
parisc64                            defconfig   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-20
powerpc                 mpc8315_rdb_defconfig   clang-20
powerpc                 mpc837x_rdb_defconfig   gcc-14.1.0
powerpc                  mpc885_ads_defconfig   clang-20
powerpc               randconfig-001-20240818   clang-20
powerpc               randconfig-002-20240818   clang-20
powerpc64             randconfig-001-20240818   gcc-14.1.0
powerpc64             randconfig-002-20240818   gcc-14.1.0
powerpc64             randconfig-003-20240818   gcc-14.1.0
riscv                            allmodconfig   clang-20
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-20
riscv                               defconfig   clang-20
riscv                 randconfig-001-20240818   clang-15
riscv                 randconfig-002-20240818   clang-20
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   clang-20
s390                  randconfig-001-20240818   gcc-14.1.0
s390                  randconfig-002-20240818   clang-20
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                             espt_defconfig   gcc-14.1.0
sh                          lboxre2_defconfig   gcc-14.1.0
sh                     magicpanelr2_defconfig   gcc-14.1.0
sh                    randconfig-001-20240818   gcc-14.1.0
sh                    randconfig-002-20240818   gcc-14.1.0
sh                           se7724_defconfig   gcc-14.1.0
sh                            titan_defconfig   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240818   gcc-14.1.0
sparc64               randconfig-002-20240818   gcc-14.1.0
um                               allmodconfig   clang-20
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-12
um                                  defconfig   clang-20
um                             i386_defconfig   gcc-12
um                    randconfig-001-20240818   clang-20
um                    randconfig-002-20240818   gcc-12
um                           x86_64_defconfig   clang-15
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240818   clang-18
x86_64       buildonly-randconfig-002-20240818   gcc-12
x86_64       buildonly-randconfig-003-20240818   clang-18
x86_64       buildonly-randconfig-004-20240818   gcc-12
x86_64       buildonly-randconfig-005-20240818   gcc-12
x86_64       buildonly-randconfig-006-20240818   gcc-12
x86_64                              defconfig   gcc-11
x86_64                randconfig-001-20240818   clang-18
x86_64                randconfig-002-20240818   gcc-12
x86_64                randconfig-003-20240818   gcc-12
x86_64                randconfig-004-20240818   clang-18
x86_64                randconfig-005-20240818   gcc-12
x86_64                randconfig-006-20240818   clang-18
x86_64                randconfig-011-20240818   clang-18
x86_64                randconfig-012-20240818   clang-18
x86_64                randconfig-013-20240818   clang-18
x86_64                randconfig-014-20240818   clang-18
x86_64                randconfig-015-20240818   clang-18
x86_64                randconfig-016-20240818   gcc-12
x86_64                randconfig-071-20240818   clang-18
x86_64                randconfig-072-20240818   clang-18
x86_64                randconfig-073-20240818   clang-18
x86_64                randconfig-074-20240818   clang-18
x86_64                randconfig-075-20240818   gcc-12
x86_64                randconfig-076-20240818   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240818   gcc-14.1.0
xtensa                randconfig-002-20240818   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

