Return-Path: <linux-kernel+bounces-282050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8931B94DF06
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 00:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFBC22828CF
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 22:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE2D13EFFB;
	Sat, 10 Aug 2024 22:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AO8NKlhD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3222822339
	for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 22:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723327524; cv=none; b=R4lD/9EIr0KD/w+r65fNKZcV3eSA2dG+neBLoZE7ADTtI4iWGLXlgHLM3R1b/xSiKBY0P5tV9i3IGmudcW9zhWwFH+vEahRElE68csEWzF4lHBYoj0GE6A5axqOdkc0LSRusaAaju4sCfyaYKcqy49siuulR3/wuWB0xpILxwL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723327524; c=relaxed/simple;
	bh=5xr8fv6PjCUwtppIKim6fR+nts2E+V0FbIbzsQQQe3k=;
	h=Date:From:To:Cc:Subject:Message-ID; b=KwSk3ghwNlNW6FQLJ55xAyJyg0xfcXcrt/Dd8sWUAadL37rO5J5R5f1bOG6Z9GkQ8MGzVCNyBFqOgsSFDnS7xU/aUBHg+k7WtkZNgxRpLRr7Jauif14hns1ZYapcpYieS/y4pJmASNddFrOmccnKvEaAKLKxd+FiEEQI9M5Zchc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AO8NKlhD; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723327523; x=1754863523;
  h=date:from:to:cc:subject:message-id;
  bh=5xr8fv6PjCUwtppIKim6fR+nts2E+V0FbIbzsQQQe3k=;
  b=AO8NKlhDsgTFBeafz7lu5SueHVGBJX7TiUV07faO1HpWdWsyhAdVnH9x
   PclkV9LeG/Up/wD/qpPFR9IYTdhwLABzm8p/VfuWdoAdFzNuntNtvSPL0
   lqWsRfI+cjE3jxwdmGBfThH7+pkepqJvc4BpT+YGE57hBQbcUBYnjfMY5
   t1tOB5YIYYUvXS4Au3/DjTPe4Azfs5YdYYoRkCRibZ4U8cb5gLh/mkPh8
   GmM8o8gkWquF6fU5DdIXm90GjehmO7Tc1muGkPTvLWtIGjHZz3tXKosk+
   yCOfeWAsrl9KUy84xeuImOsb8+51mQxK1benYAkROZ2eQVWMB0S65/efX
   A==;
X-CSE-ConnectionGUID: 7x1UTPc2RaGzlAa0kEe3xw==
X-CSE-MsgGUID: qV2v/OOwSBSBDiYE/lDweQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11160"; a="21449911"
X-IronPort-AV: E=Sophos;i="6.09,280,1716274800"; 
   d="scan'208";a="21449911"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2024 15:05:21 -0700
X-CSE-ConnectionGUID: Vv5wXhSPQxKN7jvVNGA0yA==
X-CSE-MsgGUID: HQ5tIfjpR+qPo1O7t//ufA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,280,1716274800"; 
   d="scan'208";a="57833253"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 10 Aug 2024 15:05:19 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1scuCk-000AKt-2O;
	Sat, 10 Aug 2024 22:04:59 +0000
Date: Sun, 11 Aug 2024 06:04:11 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:irq/core] BUILD SUCCESS
 46c3e31cb0f805f8329756b3d6fc2809839f172e
Message-ID: <202408110608.F8C91BKc-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
branch HEAD: 46c3e31cb0f805f8329756b3d6fc2809839f172e  Merge tag 'irq-domain-24-08-09' into irq/core

elapsed time: 1459m

configs tested: 223
configs skipped: 9

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
arc                          axs101_defconfig   gcc-13.2.0
arc                          axs103_defconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                         haps_hs_defconfig   gcc-13.2.0
arc                   randconfig-001-20240810   gcc-13.2.0
arc                   randconfig-002-20240810   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                               allnoconfig   clang-20
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                                 defconfig   gcc-13.2.0
arm                            hisi_defconfig   gcc-13.2.0
arm                       imx_v4_v5_defconfig   gcc-14.1.0
arm                      integrator_defconfig   gcc-13.2.0
arm                            mps2_defconfig   gcc-13.2.0
arm                        mvebu_v7_defconfig   gcc-13.2.0
arm                             mxs_defconfig   gcc-14.1.0
arm                       omap2plus_defconfig   gcc-13.2.0
arm                          pxa168_defconfig   gcc-14.1.0
arm                   randconfig-001-20240810   gcc-13.2.0
arm                   randconfig-002-20240810   gcc-13.2.0
arm                   randconfig-003-20240810   gcc-13.2.0
arm                   randconfig-004-20240810   gcc-13.2.0
arm                        shmobile_defconfig   gcc-13.2.0
arm                    vt8500_v6_v7_defconfig   gcc-14.1.0
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240810   gcc-13.2.0
arm64                 randconfig-002-20240810   gcc-13.2.0
arm64                 randconfig-003-20240810   gcc-13.2.0
arm64                 randconfig-004-20240810   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240810   gcc-13.2.0
csky                  randconfig-002-20240810   gcc-13.2.0
hexagon                           allnoconfig   clang-20
hexagon                          allyesconfig   clang-20
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-12
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-12
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240810   clang-18
i386         buildonly-randconfig-002-20240810   clang-18
i386         buildonly-randconfig-003-20240810   clang-18
i386         buildonly-randconfig-004-20240810   clang-18
i386         buildonly-randconfig-005-20240810   clang-18
i386         buildonly-randconfig-005-20240810   gcc-12
i386         buildonly-randconfig-006-20240810   clang-18
i386         buildonly-randconfig-006-20240810   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240810   clang-18
i386                  randconfig-002-20240810   clang-18
i386                  randconfig-002-20240810   gcc-12
i386                  randconfig-003-20240810   clang-18
i386                  randconfig-004-20240810   clang-18
i386                  randconfig-004-20240810   gcc-12
i386                  randconfig-005-20240810   clang-18
i386                  randconfig-005-20240810   gcc-12
i386                  randconfig-006-20240810   clang-18
i386                  randconfig-011-20240810   clang-18
i386                  randconfig-011-20240810   gcc-12
i386                  randconfig-012-20240810   clang-18
i386                  randconfig-012-20240810   gcc-12
i386                  randconfig-013-20240810   clang-18
i386                  randconfig-014-20240810   clang-18
i386                  randconfig-014-20240810   gcc-12
i386                  randconfig-015-20240810   clang-18
i386                  randconfig-015-20240810   gcc-12
i386                  randconfig-016-20240810   clang-18
i386                  randconfig-016-20240810   gcc-12
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240810   gcc-13.2.0
loongarch             randconfig-002-20240810   gcc-13.2.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
m68k                           sun3_defconfig   gcc-13.2.0
m68k                          sun3x_defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-14.1.0
mips                          ath25_defconfig   gcc-14.1.0
mips                        bcm63xx_defconfig   gcc-14.1.0
mips                         bigsur_defconfig   gcc-13.2.0
mips                  cavium_octeon_defconfig   gcc-13.2.0
mips                     cu1830-neo_defconfig   gcc-14.1.0
mips                           ip27_defconfig   gcc-14.1.0
mips                  maltasmvp_eva_defconfig   gcc-13.2.0
mips                        qi_lb60_defconfig   gcc-13.2.0
mips                       rbtx49xx_defconfig   gcc-13.2.0
mips                         rt305x_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240810   gcc-13.2.0
nios2                 randconfig-002-20240810   gcc-13.2.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240810   gcc-13.2.0
parisc                randconfig-002-20240810   gcc-13.2.0
parisc64                         alldefconfig   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   gcc-14.1.0
powerpc                     ep8248e_defconfig   gcc-13.2.0
powerpc                     ep8248e_defconfig   gcc-14.1.0
powerpc                     ksi8560_defconfig   gcc-14.1.0
powerpc                 linkstation_defconfig   gcc-13.2.0
powerpc                 mpc834x_itx_defconfig   gcc-13.2.0
powerpc                     stx_gp3_defconfig   gcc-14.1.0
powerpc                     tqm8541_defconfig   gcc-13.2.0
powerpc                        warp_defconfig   gcc-14.1.0
powerpc64                        alldefconfig   gcc-13.2.0
powerpc64             randconfig-001-20240810   gcc-13.2.0
powerpc64             randconfig-002-20240810   gcc-13.2.0
powerpc64             randconfig-003-20240810   gcc-13.2.0
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-14.1.0
riscv                 randconfig-001-20240810   gcc-13.2.0
riscv                 randconfig-002-20240810   gcc-13.2.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240810   gcc-13.2.0
s390                  randconfig-002-20240810   gcc-13.2.0
s390                       zfcpdump_defconfig   gcc-13.2.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                        apsh4ad0a_defconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                         ecovec24_defconfig   gcc-13.2.0
sh                          kfr2r09_defconfig   gcc-13.2.0
sh                          lboxre2_defconfig   gcc-13.2.0
sh                     magicpanelr2_defconfig   gcc-13.2.0
sh                    randconfig-001-20240810   gcc-13.2.0
sh                    randconfig-002-20240810   gcc-13.2.0
sh                          rsk7269_defconfig   gcc-13.2.0
sh                             shx3_defconfig   gcc-13.2.0
sh                          urquell_defconfig   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc                       sparc32_defconfig   gcc-13.2.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240810   gcc-13.2.0
sparc64               randconfig-002-20240810   gcc-13.2.0
um                               allmodconfig   clang-20
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-12
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240810   gcc-13.2.0
um                    randconfig-002-20240810   gcc-13.2.0
um                           x86_64_defconfig   gcc-14.1.0
x86_64                           alldefconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240810   gcc-12
x86_64       buildonly-randconfig-002-20240810   gcc-12
x86_64       buildonly-randconfig-003-20240810   gcc-12
x86_64       buildonly-randconfig-004-20240810   gcc-12
x86_64       buildonly-randconfig-005-20240810   gcc-12
x86_64       buildonly-randconfig-006-20240810   gcc-12
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-11
x86_64                randconfig-001-20240810   gcc-12
x86_64                randconfig-002-20240810   gcc-12
x86_64                randconfig-003-20240810   gcc-12
x86_64                randconfig-004-20240810   gcc-12
x86_64                randconfig-005-20240810   gcc-12
x86_64                randconfig-006-20240810   gcc-12
x86_64                randconfig-011-20240810   gcc-12
x86_64                randconfig-012-20240810   gcc-12
x86_64                randconfig-013-20240810   gcc-12
x86_64                randconfig-014-20240810   gcc-12
x86_64                randconfig-015-20240810   gcc-12
x86_64                randconfig-016-20240810   gcc-12
x86_64                randconfig-071-20240810   gcc-12
x86_64                randconfig-072-20240810   gcc-12
x86_64                randconfig-073-20240810   gcc-12
x86_64                randconfig-074-20240810   gcc-12
x86_64                randconfig-075-20240810   gcc-12
x86_64                randconfig-076-20240810   gcc-12
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240810   gcc-13.2.0
xtensa                randconfig-002-20240810   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

