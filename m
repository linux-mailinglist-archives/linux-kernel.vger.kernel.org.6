Return-Path: <linux-kernel+bounces-432887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E16FB9E5186
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CB92280FC5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 09:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17BF1D5CC2;
	Thu,  5 Dec 2024 09:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZjVoDxAJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022C618FC70
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 09:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733391566; cv=none; b=ThWSjsmS+W7V9HSfQh66yBWzZkaLdP4htlHTi866FEFViY3lVMUcyZEYRlCIPpZhJrqp4E8SiKbeP2VHZc9IICAdZILUdr376jTFUZhomT70wVeq7a1oqAWo8Sv0BemYNcXkRFcE0A1FTaohAuN57mlmSGdpJGGBQQpWSM034oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733391566; c=relaxed/simple;
	bh=m5nkMaU/pPsfT2eKSX3IrynFvV6NxEIHOFCKQM8JxW4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=e+82EpER9ptKUqQ5sWOdgm389Fspwsx1ZQc1ljfsQ8fmcc9VBPNOJvsvVF9XgQGmtu/TvzufzriM2lHyt2UOzuL/yVBJbhCau1bzrMMzr0tLXq5pW2Sy2DrVGPNfDDLdO7gWeYAPFKgAmOggkXaSvHl3uifgp/D/PwnymrikfKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZjVoDxAJ; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733391565; x=1764927565;
  h=date:from:to:cc:subject:message-id;
  bh=m5nkMaU/pPsfT2eKSX3IrynFvV6NxEIHOFCKQM8JxW4=;
  b=ZjVoDxAJWzI7twc62P/v7QUwETAp9Lu0rdN3fpFpMG/jXGFbTy5BCE9Z
   PDqxPJ2M6KBmI+DyjtYzTc8B1010aXqSwnuQsNuH/2FEn88/TC8Th4dTB
   /ko22rN2GfaSouM6Q7y3np7qfOyUnr/2j233X3swmkEJY94vvThG1P7ei
   Ygj4JWJDcvF3qM+5Av+wXcnfoCal4EWTtZRhUuZPuCBJowJbk6rhydOLU
   OUJEGe0s1KHLE3hkc80ESN74gaT0z6ma4NdNMMMgU1LSi3WQshD04M77n
   loKZExEZQxFUlh8lrMX9jgUeyPF7pJCzLIA9U/GBIVf0LFjP+VRwAzIUk
   A==;
X-CSE-ConnectionGUID: Eu3Z0+8uQrGAn6SlbuJ2MQ==
X-CSE-MsgGUID: zHtVhkV8RNqp9AamxOhAzA==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="44363402"
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; 
   d="scan'208";a="44363402"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 01:39:24 -0800
X-CSE-ConnectionGUID: c0YjrvFvS82XgNzsqpIVdQ==
X-CSE-MsgGUID: ofxJ8jbCT+O3N58Co5XDvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; 
   d="scan'208";a="124860742"
Received: from lkp-server02.sh.intel.com (HELO 1f5a171d57e2) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 05 Dec 2024 01:39:23 -0800
Received: from kbuild by 1f5a171d57e2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tJ8KO-00042N-2p;
	Thu, 05 Dec 2024 09:39:20 +0000
Date: Thu, 05 Dec 2024 17:36:19 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 c9a4b55431e5220347881e148725bed69c84e037
Message-ID: <202412051709.emxRcQx1-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: c9a4b55431e5220347881e148725bed69c84e037  x86/cpu: Add Lunar Lake to list of CPUs with a broken MONITOR implementation

elapsed time: 721m

configs tested: 177
configs skipped: 117

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-20
arc                          axs101_defconfig    clang-18
arc                          axs101_defconfig    clang-20
arc                          axs103_defconfig    clang-20
arc                      axs103_smp_defconfig    gcc-14.2.0
arc                            randconfig-001    clang-20
arc                   randconfig-001-20241205    clang-20
arc                            randconfig-002    clang-20
arc                   randconfig-002-20241205    clang-20
arc                        vdk_hs38_defconfig    gcc-14.2.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-20
arm                       aspeed_g4_defconfig    gcc-14.2.0
arm                         assabet_defconfig    gcc-14.2.0
arm                          collie_defconfig    gcc-14.2.0
arm                            dove_defconfig    gcc-14.2.0
arm                          exynos_defconfig    gcc-14.2.0
arm                            hisi_defconfig    gcc-14.2.0
arm                       imx_v4_v5_defconfig    clang-18
arm                      integrator_defconfig    clang-20
arm                            mps2_defconfig    clang-20
arm                       multi_v4t_defconfig    clang-20
arm                        multi_v7_defconfig    gcc-14.2.0
arm                         mv78xx0_defconfig    clang-17
arm                           omap1_defconfig    clang-20
arm                          pxa910_defconfig    gcc-14.2.0
arm                            randconfig-001    clang-20
arm                   randconfig-001-20241205    clang-20
arm                            randconfig-002    clang-20
arm                   randconfig-002-20241205    clang-20
arm                            randconfig-003    clang-20
arm                   randconfig-003-20241205    clang-20
arm                            randconfig-004    clang-20
arm                   randconfig-004-20241205    clang-20
arm                           sama7_defconfig    clang-20
arm                          sp7021_defconfig    clang-20
arm                        spear3xx_defconfig    clang-20
arm                           spitz_defconfig    gcc-14.2.0
arm                         wpcm450_defconfig    gcc-14.2.0
arm64                            alldefconfig    gcc-14.2.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.2.0
arm64                          randconfig-001    clang-20
arm64                 randconfig-001-20241205    clang-20
arm64                          randconfig-002    clang-20
arm64                 randconfig-002-20241205    clang-20
arm64                          randconfig-003    clang-20
arm64                 randconfig-003-20241205    clang-20
arm64                          randconfig-004    clang-20
arm64                 randconfig-004-20241205    clang-20
csky                              allnoconfig    gcc-14.2.0
hexagon                          alldefconfig    clang-20
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-20
i386                 buildonly-randconfig-001    gcc-12
i386        buildonly-randconfig-001-20241205    clang-19
i386                 buildonly-randconfig-002    gcc-12
i386        buildonly-randconfig-002-20241205    clang-19
i386                 buildonly-randconfig-003    gcc-12
i386        buildonly-randconfig-003-20241205    clang-19
i386                 buildonly-randconfig-004    gcc-12
i386        buildonly-randconfig-004-20241205    clang-19
i386                 buildonly-randconfig-005    gcc-12
i386        buildonly-randconfig-005-20241205    clang-19
i386                 buildonly-randconfig-006    gcc-12
i386        buildonly-randconfig-006-20241205    clang-19
loongarch                        alldefconfig    gcc-14.2.0
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                       m5249evb_defconfig    gcc-14.2.0
m68k                            mac_defconfig    gcc-14.2.0
m68k                          multi_defconfig    gcc-14.2.0
m68k                        mvme147_defconfig    gcc-14.2.0
m68k                           virt_defconfig    clang-20
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          ath25_defconfig    gcc-14.2.0
mips                         bigsur_defconfig    clang-17
mips                           jazz_defconfig    clang-20
mips                     loongson1b_defconfig    gcc-14.2.0
mips                          rb532_defconfig    clang-17
mips                   sb1250_swarm_defconfig    clang-20
nios2                         3c120_defconfig    clang-20
nios2                             allnoconfig    gcc-14.2.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.2.0
parisc                           alldefconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.2.0
parisc                generic-32bit_defconfig    clang-20
powerpc                    adder875_defconfig    clang-20
powerpc                     akebono_defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.2.0
powerpc                      chrp32_defconfig    gcc-14.2.0
powerpc                      cm5200_defconfig    clang-20
powerpc                   currituck_defconfig    clang-20
powerpc                       ebony_defconfig    clang-18
powerpc                          g5_defconfig    gcc-14.2.0
powerpc                    ge_imp3a_defconfig    clang-18
powerpc                        icon_defconfig    gcc-14.2.0
powerpc                  iss476-smp_defconfig    clang-20
powerpc                 linkstation_defconfig    clang-18
powerpc                      mgcoge_defconfig    clang-20
powerpc                     mpc5200_defconfig    gcc-14.2.0
powerpc                 mpc8313_rdb_defconfig    gcc-14.2.0
powerpc                 mpc834x_itx_defconfig    gcc-14.2.0
powerpc                 mpc837x_rdb_defconfig    clang-20
powerpc                    mvme5100_defconfig    gcc-14.2.0
powerpc                     skiroot_defconfig    clang-20
powerpc                     tqm5200_defconfig    gcc-14.2.0
powerpc                        warp_defconfig    clang-17
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.2.0
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                        dreamcast_defconfig    clang-17
sh                        dreamcast_defconfig    gcc-14.2.0
sh                ecovec24-romimage_defconfig    clang-18
sh                          landisk_defconfig    gcc-14.2.0
sh                     magicpanelr2_defconfig    gcc-14.2.0
sh                            migor_defconfig    gcc-14.2.0
sh                          polaris_defconfig    gcc-14.2.0
sh                          r7780mp_defconfig    gcc-14.2.0
sh                          rsk7264_defconfig    gcc-14.2.0
sh                           se7206_defconfig    clang-17
sh                           se7343_defconfig    gcc-14.2.0
sh                           se7721_defconfig    gcc-14.2.0
sh                           se7722_defconfig    clang-17
sh                             sh03_defconfig    clang-20
sh                   sh7724_generic_defconfig    clang-20
sh                   sh7724_generic_defconfig    gcc-14.2.0
sh                        sh7757lcr_defconfig    gcc-14.2.0
sh                             shx3_defconfig    clang-20
sh                            titan_defconfig    clang-20
sh                          urquell_defconfig    gcc-14.2.0
sparc                            alldefconfig    clang-18
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
x86_64               buildonly-randconfig-001    gcc-12
x86_64      buildonly-randconfig-001-20241205    clang-19
x86_64               buildonly-randconfig-002    gcc-12
x86_64      buildonly-randconfig-002-20241205    clang-19
x86_64               buildonly-randconfig-003    gcc-12
x86_64      buildonly-randconfig-003-20241205    clang-19
x86_64               buildonly-randconfig-004    gcc-12
x86_64      buildonly-randconfig-004-20241205    clang-19
x86_64               buildonly-randconfig-005    gcc-12
x86_64      buildonly-randconfig-005-20241205    clang-19
x86_64      buildonly-randconfig-005-20241205    gcc-12
x86_64               buildonly-randconfig-006    gcc-12
x86_64      buildonly-randconfig-006-20241205    clang-19
x86_64      buildonly-randconfig-006-20241205    gcc-12
xtensa                            allnoconfig    gcc-14.2.0
xtensa                  cadence_csp_defconfig    gcc-14.2.0
xtensa                          iss_defconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

