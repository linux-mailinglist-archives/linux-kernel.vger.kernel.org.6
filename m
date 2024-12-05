Return-Path: <linux-kernel+bounces-432802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4889E507D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3B35286265
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 09:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A37A1D5150;
	Thu,  5 Dec 2024 09:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V6Bb32bo"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B69D1D4610
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 09:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733389321; cv=none; b=t1SNtN15J3P/ZDoDDqXGaYXMZJFMMys28EClKu2633RXhTLewi5HAbdLv56Fg8b6yTWooSkjY1MOlVEGgcenlRTA64Y8ryfLjz3UC1e49gN3GxqbOk+i7SOLAiZsZxDOJHj+v4+rEgCjSOBvvj28lDyiBeBSXhdB/EvIM5LJWAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733389321; c=relaxed/simple;
	bh=m8/jTXjLlFmOPBPsO0dC3J3w1fBPGdG7EoVDCrLEk6Y=;
	h=Date:From:To:Cc:Subject:Message-ID; b=A11fdGUALaZOO4OY0oY5qIhEUH+NpR5WsN6+crgDJMn2baFwQNQ9YEnN1p+7IXpxR44TaTiC018I1l9EGh1xSLuAkJrMF36yxeg/P6uNTbRmJ+BkxpNkdZ//VpjJ/fXu8BnqfvWxgQmPAoyxJi1XmnnTHkMTqM9Y6SiAgyF4568=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V6Bb32bo; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733389319; x=1764925319;
  h=date:from:to:cc:subject:message-id;
  bh=m8/jTXjLlFmOPBPsO0dC3J3w1fBPGdG7EoVDCrLEk6Y=;
  b=V6Bb32boqaiMGHSWi87tvyTh1FHaZOZH2FNdvdKPm6EusYdac7Zk7Gy9
   BoqR2IO+2Nh8xBJv8L7Bisk5IzdRZO7qMp4BzbxRj2McpdTQgI45T2OKV
   FLNH49dR++oV8uhW6odz7yN7jhdxtzpGgB35lqYJ4zu4X8tuuHCmZN+ty
   1l4xO5MCyEl3Ec9Cjoq2s/xycY3h0TtvBpbMY+FAFCle6hg3m1xetTY4/
   U7R+ygOubxEFlCRFmRwJyOJp7AuzOS72zsoDNmxIJ9ZRy/aIwIPorvn9L
   opmtyNzbReySfFU1MFcQ1uyfvaq/baK3lmXaiStkbN8xkjlr7f5jmlB1X
   g==;
X-CSE-ConnectionGUID: wGdfL4qMSPCv6/1eKqtblw==
X-CSE-MsgGUID: X1Hq5/HGTlK1tg0yi/MIoQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="45064174"
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; 
   d="scan'208";a="45064174"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 01:01:58 -0800
X-CSE-ConnectionGUID: jz3F1UdfRAiCnlY/2Ws3qQ==
X-CSE-MsgGUID: 0oryY/0kQx+4zrRUQDfYFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; 
   d="scan'208";a="99000164"
Received: from lkp-server02.sh.intel.com (HELO 1f5a171d57e2) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 05 Dec 2024 01:01:57 -0800
Received: from kbuild by 1f5a171d57e2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tJ7kB-000403-0A;
	Thu, 05 Dec 2024 09:01:55 +0000
Date: Thu, 05 Dec 2024 16:59:12 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 58d92b30bca56c72b0ecb1f86e1af612d52899d9
Message-ID: <202412051602.dk6qVBOH-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 58d92b30bca56c72b0ecb1f86e1af612d52899d9  Merge branch into tip/master: 'x86/tdx'

elapsed time: 755m

configs tested: 171
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    clang-20
arc                          axs101_defconfig    clang-18
arc                          axs101_defconfig    clang-20
arc                          axs103_defconfig    clang-20
arc                            randconfig-001    clang-20
arc                            randconfig-001    gcc-13.2.0
arc                   randconfig-001-20241205    clang-20
arc                            randconfig-002    clang-20
arc                            randconfig-002    gcc-13.2.0
arc                   randconfig-002-20241205    clang-20
arm                              allmodconfig    clang-20
arm                               allnoconfig    clang-20
arm                              allyesconfig    clang-20
arm                         assabet_defconfig    gcc-14.2.0
arm                         at91_dt_defconfig    clang-20
arm                          exynos_defconfig    gcc-14.2.0
arm                       imx_v4_v5_defconfig    clang-18
arm                          ixp4xx_defconfig    clang-20
arm                            mps2_defconfig    clang-20
arm                       multi_v4t_defconfig    clang-20
arm                        multi_v7_defconfig    gcc-14.2.0
arm                         mv78xx0_defconfig    clang-17
arm                          pxa910_defconfig    clang-20
arm                          pxa910_defconfig    gcc-14.2.0
arm                            randconfig-001    clang-20
arm                            randconfig-001    gcc-14.2.0
arm                   randconfig-001-20241205    clang-20
arm                            randconfig-002    clang-20
arm                            randconfig-002    gcc-14.2.0
arm                   randconfig-002-20241205    clang-20
arm                            randconfig-003    clang-20
arm                   randconfig-003-20241205    clang-20
arm                            randconfig-004    clang-20
arm                            randconfig-004    gcc-14.2.0
arm                   randconfig-004-20241205    clang-20
arm                        realview_defconfig    clang-20
arm                           spitz_defconfig    gcc-14.2.0
arm                           stm32_defconfig    clang-20
arm                    vt8500_v6_v7_defconfig    clang-20
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    clang-20
arm64                          randconfig-001    clang-20
arm64                          randconfig-001    gcc-14.2.0
arm64                 randconfig-001-20241205    clang-20
arm64                          randconfig-002    clang-20
arm64                          randconfig-002    gcc-14.2.0
arm64                 randconfig-002-20241205    clang-20
arm64                          randconfig-003    clang-15
arm64                          randconfig-003    clang-20
arm64                 randconfig-003-20241205    clang-20
arm64                          randconfig-004    clang-20
arm64                 randconfig-004-20241205    clang-20
csky                              allnoconfig    gcc-14.2.0
hexagon                          alldefconfig    clang-20
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
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
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    gcc-14.2.0
powerpc                      cm5200_defconfig    clang-20
powerpc                   currituck_defconfig    clang-20
powerpc                       ebony_defconfig    clang-18
powerpc                          g5_defconfig    gcc-14.2.0
powerpc                    ge_imp3a_defconfig    clang-18
powerpc                    ge_imp3a_defconfig    clang-20
powerpc                        icon_defconfig    clang-20
powerpc                  iss476-smp_defconfig    clang-20
powerpc                 linkstation_defconfig    clang-18
powerpc                   lite5200b_defconfig    clang-20
powerpc                 mpc8313_rdb_defconfig    clang-20
powerpc                 mpc834x_itx_defconfig    clang-20
powerpc                 mpc837x_rdb_defconfig    clang-20
powerpc                    mvme5100_defconfig    clang-20
powerpc                    mvme5100_defconfig    gcc-14.2.0
powerpc                      ppc44x_defconfig    clang-20
powerpc                     tqm8548_defconfig    clang-20
powerpc                        warp_defconfig    clang-17
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    gcc-14.2.0
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                        dreamcast_defconfig    clang-17
sh                ecovec24-romimage_defconfig    clang-18
sh                          landisk_defconfig    gcc-14.2.0
sh                            migor_defconfig    gcc-14.2.0
sh                          rsk7201_defconfig    clang-20
sh                          sdk7780_defconfig    clang-20
sh                           se7206_defconfig    clang-17
sh                           se7722_defconfig    clang-17
sh                             sh03_defconfig    clang-20
sh                   sh7724_generic_defconfig    gcc-14.2.0
sh                            titan_defconfig    clang-20
sh                          urquell_defconfig    gcc-14.2.0
sparc                            alldefconfig    clang-18
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                               allyesconfig    gcc-12
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
x86_64      buildonly-randconfig-005-20241205    gcc-12
x86_64               buildonly-randconfig-006    gcc-12
x86_64      buildonly-randconfig-006-20241205    clang-19
x86_64      buildonly-randconfig-006-20241205    gcc-12
xtensa                            allnoconfig    gcc-14.2.0
xtensa                  audio_kc705_defconfig    clang-20
xtensa                  cadence_csp_defconfig    gcc-14.2.0
xtensa                          iss_defconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

