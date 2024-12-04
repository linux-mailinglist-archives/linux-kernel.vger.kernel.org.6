Return-Path: <linux-kernel+bounces-431136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7FA9E3986
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 13:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7E6AB3977B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83001B3958;
	Wed,  4 Dec 2024 11:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QhnnH8GO"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D70B1B3950
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 11:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733313412; cv=none; b=ca6qHEGVyOib5ntheqn+mF3ITXh3PtLdqkDidwt0ke5OW3r6C/KSuK8REPaNO4Z3kmWHyfMbdLE31s3RSP+fyaRsxsRkgNa/fEkifVmcy8GP6F8GPjwAICfc5L/LduutEp2I79jwrcpmSazl6CwJfh8dvl/QW7HbHI9r7h71ikM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733313412; c=relaxed/simple;
	bh=b1D0PB0HhggO34PeV7bdAXx9PhuKS+gbKQ7DNCbmObM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=N9j+1O9M6zZlwwsrZLuNa3Ap6bsF5YLYNHAXgkq4W6/YkWkhefeMHk+UcAMTP9vib1E7DGNA+sb63Rum+kbM++zstgsRgbU8AjJu9jYbLjvx887TyHCngTYUiN+pNsIDz2SHNsh7tT13TzlPnW0qGMqYc1kn9XOKXIa4IWVG0vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QhnnH8GO; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733313411; x=1764849411;
  h=date:from:to:cc:subject:message-id;
  bh=b1D0PB0HhggO34PeV7bdAXx9PhuKS+gbKQ7DNCbmObM=;
  b=QhnnH8GOyFNv/a58Ffi+U9npBBTIXvPTXPzYZ4sUDX2bho7iQys4y65u
   XxIJML5YXuaAXCzqvO+7X7tldj4V3nuRmEWPx2qbWeps0wXGU8bVn9eE3
   CxVTrc5b5tcJrxKGLwf+4LUvmuWdD9Wlp11/VcTixLcUixSJAWH+HroxO
   7wr8eXEoNAVLEjIV7+U8x8jhVlPoMi+Il2phqH/INkt7JZE9EXFSltTcY
   wQxn+SoS4bsAVi6ZtUjh/U8jKq0zLiSXiGG3m97Pe6Rm4F1gWJGQxXK7N
   gsz0A15EDIWTJF/QywQDzL4vV96HFiXZWQ6m7zL9cyJrQ+0nbEnjgv4AI
   A==;
X-CSE-ConnectionGUID: Lf688FYTT1q08y1sWq6owg==
X-CSE-MsgGUID: zJMqtr9SQmmyx9x8idxUPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="44967357"
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="44967357"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 03:56:51 -0800
X-CSE-ConnectionGUID: zO4qaCBtSFG+I4+Ccnxqpg==
X-CSE-MsgGUID: 8RPdUxj1RMSmPt+h1ybGYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="94201735"
Received: from lkp-server02.sh.intel.com (HELO 1f5a171d57e2) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 04 Dec 2024 03:56:50 -0800
Received: from kbuild by 1f5a171d57e2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tInzr-0002zX-1W;
	Wed, 04 Dec 2024 11:56:47 +0000
Date: Wed, 04 Dec 2024 19:53:24 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:irq/core] BUILD SUCCESS
 429f49ad361cd999ca221d8b562ae2552b7c3e2c
Message-ID: <202412041914.GMk2s70X-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
branch HEAD: 429f49ad361cd999ca221d8b562ae2552b7c3e2c  genirq: Reuse irq_thread_fn() for forced thread case

elapsed time: 1423m

configs tested: 205
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    clang-20
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-20
arc                              allyesconfig    gcc-13.2.0
arc                      axs103_smp_defconfig    gcc-14.2.0
arc                     haps_hs_smp_defconfig    gcc-14.2.0
arc                 nsimosci_hs_smp_defconfig    clang-20
arc                            randconfig-001    clang-20
arc                   randconfig-001-20241203    gcc-13.2.0
arc                            randconfig-002    clang-20
arc                   randconfig-002-20241203    gcc-13.2.0
arc                    vdk_hs38_smp_defconfig    gcc-14.2.0
arm                              allmodconfig    clang-20
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-20
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-20
arm                              allyesconfig    gcc-14.2.0
arm                       aspeed_g4_defconfig    clang-20
arm                       aspeed_g5_defconfig    gcc-14.2.0
arm                         assabet_defconfig    clang-20
arm                         at91_dt_defconfig    clang-20
arm                     davinci_all_defconfig    clang-20
arm                     davinci_all_defconfig    gcc-14.2.0
arm                           h3600_defconfig    clang-20
arm                       imx_v6_v7_defconfig    clang-20
arm                          ixp4xx_defconfig    gcc-14.2.0
arm                        keystone_defconfig    gcc-14.2.0
arm                         lpc18xx_defconfig    clang-20
arm                        mvebu_v5_defconfig    gcc-14.2.0
arm                          pxa3xx_defconfig    gcc-14.2.0
arm                          pxa910_defconfig    clang-20
arm                            qcom_defconfig    clang-20
arm                            randconfig-001    clang-20
arm                   randconfig-001-20241203    clang-20
arm                            randconfig-002    clang-20
arm                   randconfig-002-20241203    gcc-14.2.0
arm                            randconfig-003    clang-20
arm                   randconfig-003-20241203    clang-20
arm                            randconfig-004    clang-20
arm                   randconfig-004-20241203    clang-20
arm                             rpc_defconfig    gcc-14.2.0
arm                        shmobile_defconfig    clang-18
arm                        shmobile_defconfig    gcc-14.2.0
arm                         socfpga_defconfig    gcc-14.2.0
arm                          sp7021_defconfig    clang-20
arm                        spear3xx_defconfig    clang-20
arm                           spitz_defconfig    gcc-14.2.0
arm                           stm32_defconfig    clang-20
arm                         wpcm450_defconfig    clang-20
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.2.0
arm64                          randconfig-001    clang-20
arm64                 randconfig-001-20241203    gcc-14.2.0
arm64                          randconfig-002    clang-20
arm64                 randconfig-002-20241203    gcc-14.2.0
arm64                          randconfig-003    clang-20
arm64                 randconfig-003-20241203    gcc-14.2.0
arm64                          randconfig-004    clang-20
arm64                 randconfig-004-20241203    clang-20
csky                             alldefconfig    clang-20
csky                             alldefconfig    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-20
i386                 buildonly-randconfig-001    gcc-12
i386        buildonly-randconfig-001-20241203    gcc-12
i386                 buildonly-randconfig-002    gcc-12
i386        buildonly-randconfig-002-20241203    gcc-12
i386                 buildonly-randconfig-003    gcc-12
i386        buildonly-randconfig-003-20241203    clang-19
i386                 buildonly-randconfig-004    gcc-12
i386        buildonly-randconfig-004-20241203    clang-19
i386                 buildonly-randconfig-005    gcc-12
i386        buildonly-randconfig-005-20241203    clang-19
i386                 buildonly-randconfig-006    gcc-12
i386        buildonly-randconfig-006-20241203    gcc-12
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                 loongson3_defconfig    clang-18
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                          atari_defconfig    clang-18
m68k                          atari_defconfig    gcc-14.2.0
m68k                       bvme6000_defconfig    gcc-14.2.0
m68k                        m5272c3_defconfig    gcc-14.2.0
m68k                        m5407c3_defconfig    gcc-14.2.0
m68k                          sun3x_defconfig    gcc-14.2.0
microblaze                       alldefconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          ath25_defconfig    clang-20
mips                          ath79_defconfig    gcc-14.2.0
mips                      bmips_stb_defconfig    clang-18
mips                           ci20_defconfig    clang-18
mips                          eyeq6_defconfig    clang-14
mips                           ip22_defconfig    gcc-14.2.0
mips                           ip32_defconfig    gcc-14.2.0
mips                           jazz_defconfig    clang-20
mips                          rb532_defconfig    clang-18
mips                         rt305x_defconfig    clang-20
mips                           xway_defconfig    clang-20
nios2                         10m50_defconfig    gcc-14.2.0
nios2                         3c120_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
openrisc                         alldefconfig    gcc-14.2.0
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                       virt_defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
powerpc                     akebono_defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-20
powerpc                          allyesconfig    gcc-14.2.0
powerpc                      cm5200_defconfig    clang-20
powerpc                  iss476-smp_defconfig    clang-20
powerpc                  iss476-smp_defconfig    gcc-14.2.0
powerpc                 linkstation_defconfig    clang-20
powerpc                 linkstation_defconfig    gcc-14.2.0
powerpc                   motionpro_defconfig    clang-18
powerpc                 mpc8313_rdb_defconfig    clang-20
powerpc                  mpc866_ads_defconfig    clang-20
powerpc                    mvme5100_defconfig    gcc-14.2.0
powerpc                      pmac32_defconfig    clang-20
powerpc                      pmac32_defconfig    gcc-14.2.0
powerpc                     ppa8548_defconfig    clang-20
powerpc                     stx_gp3_defconfig    clang-20
powerpc                     tqm5200_defconfig    gcc-14.2.0
powerpc                      tqm8xx_defconfig    clang-20
powerpc                         wii_defconfig    gcc-14.2.0
riscv                            allmodconfig    clang-20
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                            allyesconfig    gcc-14.2.0
riscv                    nommu_k210_defconfig    clang-20
riscv                    nommu_k210_defconfig    gcc-14.2.0
s390                             allmodconfig    clang-20
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                        apsh4ad0a_defconfig    gcc-14.2.0
sh                        dreamcast_defconfig    gcc-14.2.0
sh                ecovec24-romimage_defconfig    gcc-14.2.0
sh                            hp6xx_defconfig    gcc-14.2.0
sh                          landisk_defconfig    clang-20
sh                   rts7751r2dplus_defconfig    clang-20
sh                          sdk7780_defconfig    gcc-14.2.0
sh                          sdk7786_defconfig    gcc-14.2.0
sh                           se7343_defconfig    gcc-14.2.0
sh                           se7619_defconfig    clang-20
sh                           se7712_defconfig    gcc-14.2.0
sh                           se7722_defconfig    gcc-14.2.0
sh                           se7750_defconfig    gcc-14.2.0
sh                           se7751_defconfig    clang-20
sh                           se7780_defconfig    gcc-14.2.0
sh                   secureedge5410_defconfig    clang-20
sh                             sh03_defconfig    clang-20
sh                            shmin_defconfig    clang-20
sh                            shmin_defconfig    gcc-14.2.0
sh                            titan_defconfig    clang-20
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                       sparc32_defconfig    gcc-14.2.0
um                               alldefconfig    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                               allyesconfig    gcc-12
um                             i386_defconfig    gcc-14.2.0
x86_64      buildonly-randconfig-001-20241203    clang-19
x86_64      buildonly-randconfig-001-20241204    clang-19
x86_64      buildonly-randconfig-002-20241203    clang-19
x86_64      buildonly-randconfig-002-20241204    clang-19
x86_64      buildonly-randconfig-003-20241203    clang-19
x86_64      buildonly-randconfig-003-20241204    clang-19
x86_64      buildonly-randconfig-004-20241203    gcc-11
x86_64      buildonly-randconfig-004-20241204    clang-19
x86_64      buildonly-randconfig-005-20241203    gcc-12
x86_64      buildonly-randconfig-005-20241204    clang-19
x86_64      buildonly-randconfig-006-20241203    clang-19
x86_64      buildonly-randconfig-006-20241204    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                  nommu_kc705_defconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

