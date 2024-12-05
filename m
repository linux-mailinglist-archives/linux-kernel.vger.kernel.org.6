Return-Path: <linux-kernel+bounces-433027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 428B09E530B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F7841625AE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5057C1C3C06;
	Thu,  5 Dec 2024 10:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HQNYlHxB"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D164A2391A1
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 10:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733396063; cv=none; b=fLbpJ7td6KfM9cQljXDSD/hkG9HSG9Fae5B4uAMwfQ0kWqxKsFEvb2woZSaPBTkHwzm9HTgB8+Lsk+/ksEkP9Q9+LaaZ4k0JwyPAtjz395+dBtK5qoBwNg7sDRW/FHBTOY9UlSB673tSCgmxG5Fh605PNbttU/7aAzYxJHoKxPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733396063; c=relaxed/simple;
	bh=R+JSkvJGP68y8lVw0Y5FTl8Agh1EbBn84yR9b/CP4a0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=SBlryw40Vlagae8eO4M+IQshknzLI97axeQ9cOANdqb7OYqBe5ZbnL4UeyOp8zIPSkhZcMo2Io5K1psD0elWjjIAGbXpY2OpNNePSICK3jbVGbKSK/f0P6wYIwitLb+q6XkkqTyaF+wzXraTG/p/GaCBtw8vOZqe6RvuOY8TV80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HQNYlHxB; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733396059; x=1764932059;
  h=date:from:to:cc:subject:message-id;
  bh=R+JSkvJGP68y8lVw0Y5FTl8Agh1EbBn84yR9b/CP4a0=;
  b=HQNYlHxB24a1mwfV/ttFan9q7jd/8mKWL41JxftRvqOAgLJglhCf7vHB
   QSYPTzt7xuXPc0apDIpYkhw+++nzQKpzc0cTle2jwPumrYvRYunZucN8p
   vhRfdjj8q549NsL62AHxtoYj5DOgAVwx05ZUkduJZOga2kMTxJ7PlByhf
   d4WaDoFYbl9kTSgwnNKokZ7rslO/rhIYiV79TAylJ7mUdVpxge7J5nAcV
   fv+kMJuv7TqSmRQzPL57EirqLT+CIOe+ZDd4hJeb0u80fvX8/OkgHAEnV
   5VWx68pLUKyxPOFDA3u6+We+opjXyxoxietZivet3IAa/mlvK9a1bVaHC
   A==;
X-CSE-ConnectionGUID: dydzQDMIS7md6AUn4D5sfg==
X-CSE-MsgGUID: kE5LUOZeQVuGC6iaRMGgpg==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="59105460"
X-IronPort-AV: E=Sophos;i="6.12,210,1728975600"; 
   d="scan'208";a="59105460"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 02:54:18 -0800
X-CSE-ConnectionGUID: mTFRb8SESS+UKV5WsauGQQ==
X-CSE-MsgGUID: sj2aem4kSz+OeYZZ6TEn6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,210,1728975600"; 
   d="scan'208";a="93927755"
Received: from lkp-server02.sh.intel.com (HELO 1f5a171d57e2) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 05 Dec 2024 02:54:08 -0800
Received: from kbuild by 1f5a171d57e2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tJ9Ui-000462-15;
	Thu, 05 Dec 2024 10:54:05 +0000
Date: Thu, 05 Dec 2024 18:50:48 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/tdx] BUILD SUCCESS
 cd9ce8217345bd13035a0d3edaaecec4244d0ddd
Message-ID: <202412051838.vRTUlhZB-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/tdx
branch HEAD: cd9ce8217345bd13035a0d3edaaecec4244d0ddd  x86/tdx: Disable unnecessary virtualization exceptions

elapsed time: 723m

configs tested: 158
configs skipped: 107

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
arc                               allnoconfig    gcc-14.2.0
arc                          axs101_defconfig    clang-18
arc                          axs101_defconfig    clang-20
arc                          axs103_defconfig    clang-20
arc                      axs103_smp_defconfig    gcc-14.2.0
arc                         haps_hs_defconfig    clang-19
arc                        nsimosci_defconfig    clang-20
arc                   randconfig-001-20241205    clang-20
arc                   randconfig-002-20241205    clang-20
arc                           tb10x_defconfig    clang-20
arc                        vdk_hs38_defconfig    gcc-14.2.0
arc                    vdk_hs38_smp_defconfig    clang-19
arm                               allnoconfig    gcc-14.2.0
arm                       aspeed_g4_defconfig    gcc-14.2.0
arm                         assabet_defconfig    gcc-14.2.0
arm                          collie_defconfig    gcc-14.2.0
arm                            dove_defconfig    gcc-14.2.0
arm                          exynos_defconfig    gcc-14.2.0
arm                            hisi_defconfig    gcc-14.2.0
arm                       imx_v4_v5_defconfig    clang-18
arm                           imxrt_defconfig    clang-20
arm                      integrator_defconfig    clang-20
arm                        keystone_defconfig    clang-20
arm                            mps2_defconfig    clang-20
arm                       multi_v4t_defconfig    clang-20
arm                           omap1_defconfig    clang-20
arm                   randconfig-001-20241205    clang-20
arm                   randconfig-002-20241205    clang-20
arm                   randconfig-003-20241205    clang-20
arm                   randconfig-004-20241205    clang-20
arm                           sama7_defconfig    clang-20
arm                          sp7021_defconfig    clang-19
arm                          sp7021_defconfig    clang-20
arm                        spear3xx_defconfig    clang-20
arm                         wpcm450_defconfig    gcc-14.2.0
arm64                            alldefconfig    gcc-14.2.0
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20241205    clang-20
arm64                 randconfig-002-20241205    clang-20
arm64                 randconfig-003-20241205    clang-20
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
loongarch                         allnoconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                       m5249evb_defconfig    gcc-14.2.0
m68k                          multi_defconfig    gcc-14.2.0
m68k                        mvme147_defconfig    gcc-14.2.0
m68k                           virt_defconfig    clang-20
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          ath25_defconfig    gcc-14.2.0
mips                          ath79_defconfig    clang-20
mips                          eyeq6_defconfig    clang-20
mips                           jazz_defconfig    clang-20
mips                     loongson1b_defconfig    gcc-14.2.0
mips                   sb1250_swarm_defconfig    clang-20
nios2                         3c120_defconfig    clang-20
nios2                             allnoconfig    gcc-14.2.0
openrisc                         alldefconfig    clang-20
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.2.0
openrisc                       virt_defconfig    clang-19
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
powerpc                 canyonlands_defconfig    clang-19
powerpc                      chrp32_defconfig    gcc-14.2.0
powerpc                      cm5200_defconfig    clang-20
powerpc                   currituck_defconfig    clang-20
powerpc                       ebony_defconfig    clang-18
powerpc                        fsp2_defconfig    clang-19
powerpc                          g5_defconfig    gcc-14.2.0
powerpc                    ge_imp3a_defconfig    clang-18
powerpc                       holly_defconfig    clang-20
powerpc                        icon_defconfig    gcc-14.2.0
powerpc                  iss476-smp_defconfig    clang-20
powerpc                 linkstation_defconfig    clang-18
powerpc                      mgcoge_defconfig    clang-20
powerpc                     mpc5200_defconfig    gcc-14.2.0
powerpc                 mpc8313_rdb_defconfig    gcc-14.2.0
powerpc                 mpc834x_itx_defconfig    gcc-14.2.0
powerpc                 mpc837x_rdb_defconfig    clang-20
powerpc                     redwood_defconfig    gcc-14.2.0
powerpc                     skiroot_defconfig    clang-20
powerpc                    socrates_defconfig    clang-19
powerpc                     tqm5200_defconfig    gcc-14.2.0
powerpc                     tqm8548_defconfig    clang-20
powerpc                     tqm8555_defconfig    clang-20
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.2.0
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                        dreamcast_defconfig    gcc-14.2.0
sh                ecovec24-romimage_defconfig    clang-18
sh                          landisk_defconfig    gcc-14.2.0
sh                     magicpanelr2_defconfig    gcc-14.2.0
sh                            migor_defconfig    gcc-14.2.0
sh                          polaris_defconfig    gcc-14.2.0
sh                          r7780mp_defconfig    gcc-14.2.0
sh                          rsk7264_defconfig    gcc-14.2.0
sh                           se7343_defconfig    gcc-14.2.0
sh                           se7721_defconfig    gcc-14.2.0
sh                             sh03_defconfig    clang-20
sh                   sh7724_generic_defconfig    clang-20
sh                        sh7757lcr_defconfig    gcc-14.2.0
sh                             shx3_defconfig    clang-20
sh                            titan_defconfig    clang-20
sparc                            alldefconfig    clang-18
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20241205    clang-19
x86_64      buildonly-randconfig-002-20241205    clang-19
x86_64      buildonly-randconfig-003-20241205    clang-19
x86_64      buildonly-randconfig-004-20241205    clang-19
x86_64      buildonly-randconfig-005-20241205    clang-19
x86_64      buildonly-randconfig-005-20241205    gcc-12
x86_64      buildonly-randconfig-006-20241205    clang-19
x86_64      buildonly-randconfig-006-20241205    gcc-12
xtensa                            allnoconfig    gcc-14.2.0
xtensa                  cadence_csp_defconfig    gcc-14.2.0
xtensa                generic_kc705_defconfig    clang-20
xtensa                          iss_defconfig    gcc-14.2.0
xtensa                    xip_kc705_defconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

