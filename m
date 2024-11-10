Return-Path: <linux-kernel+bounces-403407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 771929C3548
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 00:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B59D9B217AE
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 23:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04A215F330;
	Sun, 10 Nov 2024 23:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cjd2wBT9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B3515B135
	for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 23:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731281223; cv=none; b=sxMEMRG8A69jWttWGCtht1AlNUZ6BbOZx0kh/poxn2azQc7rP0fEqi474pWxWP54bfabumxoVBKmx9rYID5exGjvlu/LdCVgoQx56ArVhYlJ0NEEg6GLGOi9+cxz6aAkggfJTxPFvrRMjy9PM3Rwrmv+S5Jjez0GCLaptgttAj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731281223; c=relaxed/simple;
	bh=PTdOa0Q1/gHtgrzxhcjET4YFFjXvtNo73FTJSVGmzpM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=gl0/Rf9BN7pMXNWVDKRUrUONHdOjCRFXD1b4hmPgRSD4bfD0hJW5x86WHEQKN3NzyYNiHcIpaQ9kZCFUGZK79vt7wTmKKX54RWYWaB/xyF665I46szl+eUpHWVuL4cgendL7WWpbel9z0J9PmC77HVTj4+GKJbE4/vswwxhdNnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cjd2wBT9; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731281222; x=1762817222;
  h=date:from:to:cc:subject:message-id;
  bh=PTdOa0Q1/gHtgrzxhcjET4YFFjXvtNo73FTJSVGmzpM=;
  b=Cjd2wBT9kws9TFsikHvs3JUGLDMuZZ4SsptlPUQAihGvpyytKh+ZvtEc
   6VIffU91ij2PQG8kgAvIaeTqHhFB/bcxIhtbLn501xRvhRS+PLciKQ5gi
   L/FTfIw9gIu2IXtsvOMC4DPhhGRu4ogmGfNkyOOP6dvJ/UJN7A1KPhIPj
   Cf5KyNNUybyVUHfOpfU+HYUWc03VTuwwiGAoTjUmp0B142wWMyz8guylI
   mEb+3RetV9ePXXcOOv4p8z8XNsIu13m671SEwDP2cCs50jftYcIC3m0Hk
   X2sQSjNmBOEPQZ5TmDAGRSRXWizwZP7BvaojDIupr5KoHrcRcrmH4Ewm+
   A==;
X-CSE-ConnectionGUID: L+3HVRm+SqiAaxRDaPAL+g==
X-CSE-MsgGUID: gw3/DKLfTRSodv7EuqxuCw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31244735"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="31244735"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2024 15:26:59 -0800
X-CSE-ConnectionGUID: 8R2SvGv2R7Gijr7ejcT7sA==
X-CSE-MsgGUID: YH5E3RvhSCaaHFgqtmKRrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,144,1728975600"; 
   d="scan'208";a="86784003"
Received: from lkp-server01.sh.intel.com (HELO 7b17a4138caf) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 10 Nov 2024 15:26:59 -0800
Received: from kbuild by 7b17a4138caf with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tAHKZ-0000Tx-3A;
	Sun, 10 Nov 2024 23:26:55 +0000
Date: Mon, 11 Nov 2024 07:26:01 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:tip/urgent] BUILD SUCCESS
 8d34230d350479990becb59c2d61f61e37ee197e
Message-ID: <202411110756.xqjSK9BI-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tip/urgent
branch HEAD: 8d34230d350479990becb59c2d61f61e37ee197e  Merge branch into tip/master: 'x86/urgent'

elapsed time: 725m

configs tested: 233
configs skipped: 10

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-20
arc                          axs103_defconfig    gcc-14.2.0
arc                                 defconfig    gcc-14.2.0
arc                 nsimosci_hs_smp_defconfig    clang-15
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-20
arm                     am200epdkit_defconfig    gcc-14.2.0
arm                                 defconfig    gcc-14.2.0
arm                            dove_defconfig    gcc-14.2.0
arm                          ep93xx_defconfig    gcc-14.2.0
arm                       imx_v6_v7_defconfig    gcc-14.2.0
arm                          ixp4xx_defconfig    gcc-14.2.0
arm                        keystone_defconfig    clang-20
arm                         lpc18xx_defconfig    clang-15
arm                       netwinder_defconfig    gcc-14.2.0
arm                         socfpga_defconfig    clang-20
arm                          sp7021_defconfig    clang-20
arm                           stm32_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
csky                             alldefconfig    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.2.0
i386                             alldefconfig    gcc-14.2.0
i386                             allmodconfig    clang-19
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-19
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-19
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241110    gcc-11
i386        buildonly-randconfig-001-20241111    gcc-11
i386        buildonly-randconfig-002-20241110    gcc-11
i386        buildonly-randconfig-002-20241110    gcc-12
i386        buildonly-randconfig-002-20241111    gcc-11
i386        buildonly-randconfig-003-20241110    clang-19
i386        buildonly-randconfig-003-20241110    gcc-11
i386        buildonly-randconfig-003-20241111    gcc-11
i386        buildonly-randconfig-004-20241110    gcc-11
i386        buildonly-randconfig-004-20241111    gcc-11
i386        buildonly-randconfig-005-20241110    gcc-11
i386        buildonly-randconfig-005-20241110    gcc-12
i386        buildonly-randconfig-005-20241111    gcc-11
i386        buildonly-randconfig-006-20241110    gcc-11
i386        buildonly-randconfig-006-20241110    gcc-12
i386        buildonly-randconfig-006-20241111    gcc-11
i386                                defconfig    clang-19
i386                  randconfig-001-20241110    gcc-11
i386                  randconfig-001-20241110    gcc-12
i386                  randconfig-001-20241111    gcc-11
i386                  randconfig-002-20241110    clang-19
i386                  randconfig-002-20241110    gcc-11
i386                  randconfig-002-20241111    gcc-11
i386                  randconfig-003-20241110    gcc-11
i386                  randconfig-003-20241110    gcc-12
i386                  randconfig-003-20241111    gcc-11
i386                  randconfig-004-20241110    clang-19
i386                  randconfig-004-20241110    gcc-11
i386                  randconfig-004-20241111    gcc-11
i386                  randconfig-005-20241110    gcc-11
i386                  randconfig-005-20241110    gcc-12
i386                  randconfig-005-20241111    gcc-11
i386                  randconfig-006-20241110    gcc-11
i386                  randconfig-006-20241110    gcc-12
i386                  randconfig-006-20241111    gcc-11
i386                  randconfig-011-20241110    clang-19
i386                  randconfig-011-20241110    gcc-11
i386                  randconfig-011-20241111    gcc-11
i386                  randconfig-012-20241110    gcc-11
i386                  randconfig-012-20241110    gcc-12
i386                  randconfig-012-20241111    gcc-11
i386                  randconfig-013-20241110    gcc-11
i386                  randconfig-013-20241110    gcc-12
i386                  randconfig-013-20241111    gcc-11
i386                  randconfig-014-20241110    gcc-11
i386                  randconfig-014-20241110    gcc-12
i386                  randconfig-014-20241111    gcc-11
i386                  randconfig-015-20241110    gcc-11
i386                  randconfig-015-20241110    gcc-12
i386                  randconfig-015-20241111    gcc-11
i386                  randconfig-016-20241110    clang-19
i386                  randconfig-016-20241110    gcc-11
i386                  randconfig-016-20241111    gcc-11
loongarch                        alldefconfig    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                         amcore_defconfig    clang-20
m68k                       bvme6000_defconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                       m5208evb_defconfig    clang-20
m68k                        m5272c3_defconfig    gcc-14.2.0
m68k                        m5407c3_defconfig    clang-15
m68k                           sun3_defconfig    gcc-14.2.0
m68k                          sun3x_defconfig    gcc-14.2.0
m68k                           virt_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
microblaze                      mmu_defconfig    clang-15
mips                              allnoconfig    gcc-14.2.0
mips                        bcm63xx_defconfig    gcc-14.2.0
mips                       bmips_be_defconfig    clang-15
mips                         db1xxx_defconfig    clang-20
mips                           ip22_defconfig    gcc-14.2.0
mips                           ip32_defconfig    clang-15
mips                     loongson1b_defconfig    clang-15
mips                      maltaaprp_defconfig    gcc-14.2.0
mips                        maltaup_defconfig    clang-15
mips                       rbtx49xx_defconfig    clang-20
mips                        vocore2_defconfig    clang-15
mips                           xway_defconfig    clang-20
nios2                         3c120_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
openrisc                    or1ksim_defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                generic-32bit_defconfig    gcc-14.2.0
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.2.0
powerpc                    amigaone_defconfig    clang-20
powerpc                     asp8347_defconfig    gcc-14.2.0
powerpc                        cell_defconfig    gcc-14.2.0
powerpc                      chrp32_defconfig    clang-15
powerpc                     ep8248e_defconfig    gcc-14.2.0
powerpc                    gamecube_defconfig    clang-15
powerpc                 mpc834x_itx_defconfig    clang-15
powerpc                 mpc834x_itx_defconfig    gcc-14.2.0
powerpc                 mpc837x_rdb_defconfig    clang-20
powerpc                  mpc885_ads_defconfig    gcc-14.2.0
powerpc                      pcm030_defconfig    clang-20
powerpc                      ppc6xx_defconfig    gcc-14.2.0
powerpc                  storcenter_defconfig    clang-15
powerpc                     stx_gp3_defconfig    gcc-14.2.0
powerpc                     taishan_defconfig    gcc-14.2.0
powerpc                     tqm8540_defconfig    gcc-14.2.0
powerpc                         wii_defconfig    gcc-14.2.0
powerpc                 xes_mpc85xx_defconfig    gcc-14.2.0
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
riscv                    nommu_k210_defconfig    clang-20
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                          debug_defconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                       zfcpdump_defconfig    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                          lboxre2_defconfig    gcc-14.2.0
sh                          polaris_defconfig    clang-15
sh                          rsk7264_defconfig    gcc-14.2.0
sh                           se7705_defconfig    clang-20
sh                           se7705_defconfig    gcc-14.2.0
sh                           se7751_defconfig    clang-15
sh                           sh2007_defconfig    gcc-14.2.0
sh                  sh7785lcr_32bit_defconfig    clang-20
sparc                            allmodconfig    gcc-14.2.0
sparc                       sparc32_defconfig    gcc-14.2.0
sparc64                             defconfig    gcc-12
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                           x86_64_defconfig    gcc-12
um                           x86_64_defconfig    gcc-14.2.0
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241110    gcc-12
x86_64      buildonly-randconfig-002-20241110    gcc-12
x86_64      buildonly-randconfig-003-20241110    gcc-12
x86_64      buildonly-randconfig-004-20241110    gcc-12
x86_64      buildonly-randconfig-005-20241110    gcc-12
x86_64      buildonly-randconfig-006-20241110    gcc-12
x86_64                              defconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20241110    gcc-12
x86_64                randconfig-002-20241110    gcc-12
x86_64                randconfig-003-20241110    gcc-12
x86_64                randconfig-004-20241110    gcc-12
x86_64                randconfig-005-20241110    gcc-12
x86_64                randconfig-006-20241110    gcc-12
x86_64                randconfig-011-20241110    gcc-12
x86_64                randconfig-012-20241110    gcc-12
x86_64                randconfig-013-20241110    gcc-12
x86_64                randconfig-014-20241110    gcc-12
x86_64                randconfig-015-20241110    gcc-12
x86_64                randconfig-016-20241110    gcc-12
x86_64                randconfig-071-20241110    gcc-12
x86_64                randconfig-072-20241110    gcc-12
x86_64                randconfig-073-20241110    gcc-12
x86_64                randconfig-074-20241110    gcc-12
x86_64                randconfig-075-20241110    gcc-12
x86_64                randconfig-076-20241110    gcc-12
x86_64                               rhel-8.3    gcc-12
x86_64                           rhel-8.3-bpf    clang-19
x86_64                         rhel-8.3-kunit    clang-19
x86_64                           rhel-8.3-ltp    clang-19
x86_64                          rhel-8.3-rust    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                  cadence_csp_defconfig    gcc-14.2.0
xtensa                       common_defconfig    gcc-14.2.0
xtensa                          iss_defconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

