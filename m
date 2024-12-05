Return-Path: <linux-kernel+bounces-432628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 624B69E4DEA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 08:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF3F4188151A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 07:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30ED9194C92;
	Thu,  5 Dec 2024 07:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="luCDAQUi"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354FA2F56
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 07:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733382290; cv=none; b=r6XCw9cUJKCaI/wFx+y8+ZWecieviUXuUSq48i5HwIL7szeQum12IdM1/e7WMse/jOqZEIf8KYF7bJScTU7G3Rs4E2qpgPqfMaOAYWfwpSxeBKry/lxOT8y1oNTJe55p88gZwB3/g+Sp0B5Z6gck+UZa8/8ZJ4wZNKIgv8FoQn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733382290; c=relaxed/simple;
	bh=dYJPFtQgCG5XAgFbB9Vh0s7zcMSWDeUWK+MFvZM/GHw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=YBC5Bdv2WVhPrUtO33ND5MAjB8zRVqy/bQaZsP4xTQQCsN9hwf4PoD0uVyqO8d5GRR7pFPnF13rseKlILhsvmJ5bQGDHluoHpbDs2jvEdoLO/QI2GR2eoQ0ZXZWeQGKH7vPRxg0cGktASLdJWK0K7O26qXKAANBFXu85ytwj380=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=luCDAQUi; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733382289; x=1764918289;
  h=date:from:to:cc:subject:message-id;
  bh=dYJPFtQgCG5XAgFbB9Vh0s7zcMSWDeUWK+MFvZM/GHw=;
  b=luCDAQUii5abj1yWXw6LzC0Jnq94/PHu6Zr7/vp5btTuOAXxvVlWO5fA
   prY7soRd8rg+ZnvN6jeyDG/rwLZj5rg3QIEnXnG8sAS/9wUmZeirP16vF
   sFdOApvqynETPDh761LuvFFhm9CqngYVO7tnq14OnrFt/nXh2/VRVLmSf
   ueJFJyLlDa2LOWuIlsc5/hiPal5li0N5JCQqUvIPYmopNwx1XwZuAvC4N
   sBYKVvt07AVHsMQ9XJ8ydVLvSIcJHn7JsvKiTxNYvF/oR/5khrDXEHbat
   l4vaCEJ7FI7Hn1S18VeTOXjbCsHs9foMLfUgtdgbuGeVdtKEdQQOe73J0
   A==;
X-CSE-ConnectionGUID: IxfRBrPuSfut8v7GBeOTJw==
X-CSE-MsgGUID: c7L17upwTJ6Q3BlfQ9hCZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="33809502"
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; 
   d="scan'208";a="33809502"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 23:04:48 -0800
X-CSE-ConnectionGUID: GK3Pu3qLTtaqqI7wIor28w==
X-CSE-MsgGUID: Y3A+V9vIQfyq2EgIVcYNOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; 
   d="scan'208";a="98972764"
Received: from lkp-server02.sh.intel.com (HELO 1f5a171d57e2) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 04 Dec 2024 23:04:47 -0800
Received: from kbuild by 1f5a171d57e2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tJ5um-0003vR-1A;
	Thu, 05 Dec 2024 07:04:44 +0000
Date: Thu, 05 Dec 2024 15:01:21 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/misc] BUILD SUCCESS
 6a5abeea9c72e1d2c538622b4cf66c80cc816fd3
Message-ID: <202412051511.3eanKtBu-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/misc
branch HEAD: 6a5abeea9c72e1d2c538622b4cf66c80cc816fd3  x86/mtrr: Rename mtrr_overwrite_state() to guest_force_mtrr_state()

elapsed time: 721m

configs tested: 131
configs skipped: 117

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-20
arc                          axs101_defconfig    clang-20
arc                          axs103_defconfig    clang-20
arc                            randconfig-001    clang-20
arc                   randconfig-001-20241205    clang-20
arc                            randconfig-002    clang-20
arc                   randconfig-002-20241205    clang-20
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-20
arm                         assabet_defconfig    gcc-14.2.0
arm                          exynos_defconfig    gcc-14.2.0
arm                          ixp4xx_defconfig    clang-20
arm                            mps2_defconfig    clang-20
arm                       multi_v4t_defconfig    clang-20
arm                         mv78xx0_defconfig    clang-17
arm                            randconfig-001    clang-20
arm                   randconfig-001-20241205    clang-20
arm                            randconfig-002    clang-20
arm                   randconfig-002-20241205    clang-20
arm                            randconfig-003    clang-20
arm                   randconfig-003-20241205    clang-20
arm                            randconfig-004    clang-20
arm                   randconfig-004-20241205    clang-20
arm                           stm32_defconfig    clang-20
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    clang-20
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
i386                 buildonly-randconfig-002    clang-19
i386                 buildonly-randconfig-002    gcc-12
i386        buildonly-randconfig-002-20241205    clang-19
i386                 buildonly-randconfig-003    clang-19
i386                 buildonly-randconfig-003    gcc-12
i386        buildonly-randconfig-003-20241205    clang-19
i386                 buildonly-randconfig-004    gcc-12
i386        buildonly-randconfig-004-20241205    clang-19
i386                 buildonly-randconfig-005    gcc-12
i386        buildonly-randconfig-005-20241205    clang-19
i386                 buildonly-randconfig-006    gcc-12
i386        buildonly-randconfig-006-20241205    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                       m5249evb_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                         bigsur_defconfig    clang-17
mips                            gpr_defconfig    clang-20
mips                          rb532_defconfig    clang-17
mips                   sb1250_swarm_defconfig    clang-20
nios2                         3c120_defconfig    clang-20
nios2                             allnoconfig    gcc-14.2.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.2.0
powerpc                      cm5200_defconfig    clang-20
powerpc                   currituck_defconfig    clang-20
powerpc                          g5_defconfig    gcc-14.2.0
powerpc                        icon_defconfig    clang-20
powerpc                  iss476-smp_defconfig    clang-20
powerpc                   lite5200b_defconfig    clang-20
powerpc                 mpc837x_rdb_defconfig    clang-20
powerpc                    mvme5100_defconfig    clang-20
powerpc                      ppc44x_defconfig    clang-20
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
sh                          landisk_defconfig    gcc-14.2.0
sh                            migor_defconfig    gcc-14.2.0
sh                          sdk7780_defconfig    clang-20
sh                           se7206_defconfig    clang-17
sh                           se7722_defconfig    clang-17
sh                             sh03_defconfig    clang-20
sh                            titan_defconfig    clang-20
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                           x86_64_defconfig    clang-20
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
x86_64               buildonly-randconfig-006    gcc-12
x86_64      buildonly-randconfig-006-20241205    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                  cadence_csp_defconfig    gcc-14.2.0
xtensa                          iss_defconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

