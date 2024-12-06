Return-Path: <linux-kernel+bounces-434500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB189E678C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 08:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08AC916B454
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 07:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CDE21DC1A2;
	Fri,  6 Dec 2024 07:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Udo834OO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A424145B38
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 07:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733468411; cv=none; b=DK1zZ2ZQ5CP1Uv4t3VJO2cPjvWWtZ680kVnDSH1OENmosNNKI6HNRh5P04sAjqx1/ehFsyIwsdy5J9w1zZG6PqbSpPyZSeC1o1z5udfFQ72yPW1KEKYbm5qT9XO4hDNZxo/H6kXnb8q5WVomMZ/3499VE6B4sBih5IZk87WGDRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733468411; c=relaxed/simple;
	bh=7qXz+mIpXSpICBbudyvyEI5NmbLOHvYd025mxMaQfI8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=PsC/KAuSaNb/SeIzT5u2D/gSZItusI9mD3qzCNHxscdM8YL/d4ry3GpWIoUSIWpSZs5DsRdgd460BBESSE2/8fXhlVC68clEPLXlP1/tLi814M5MFltLfMbKJk1Ko+1naul0y0tbm/wyoqTtPpGp8PJ6h/Eb3giPmdxKqbSSjHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Udo834OO; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733468401; x=1765004401;
  h=date:from:to:cc:subject:message-id;
  bh=7qXz+mIpXSpICBbudyvyEI5NmbLOHvYd025mxMaQfI8=;
  b=Udo834OO5hLfU72k7oxHIQ0WBM5hzWfHpWvgMEja086wB8ag8AoKwANb
   lR+v8NxswSToi8PYIPVdJn7DB3kHifkJdXxqDHTl+4OEV6QvDb1UkVaoM
   VEOUL54yuCFoVgdFrgfQowiYup/sy6SyXEPQC6HomcZhg+cZklOmZZpLx
   z/mhtL58EsGTC0xSM+NcdExf/RHiED6CMd8fD632vyu3Xuxrtfo6/jE9B
   16HLcKEtkV3CDsj/e+TFNesgyaKmFhViF+UFmIBmLj+8nZcPigyvm+dQs
   DbfhixbFhYNwfO7q3SjCKiPFaoW87VgsvLu98kU6h/9MFwgQ3Rr+24tQL
   Q==;
X-CSE-ConnectionGUID: xHRc15yIQci6HcqnxOdMtA==
X-CSE-MsgGUID: A10Nm7FcR8+PFdnpKxU8PA==
X-IronPort-AV: E=McAfee;i="6700,10204,11277"; a="44281926"
X-IronPort-AV: E=Sophos;i="6.12,212,1728975600"; 
   d="scan'208";a="44281926"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 22:59:59 -0800
X-CSE-ConnectionGUID: p3YXZX1MR0mfHBvgK7kkIQ==
X-CSE-MsgGUID: YLKIid65TzOEVRoddJIhRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,212,1728975600"; 
   d="scan'208";a="94186323"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 05 Dec 2024 22:59:57 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tJSJe-0000mw-2r;
	Fri, 06 Dec 2024 06:59:54 +0000
Date: Fri, 06 Dec 2024 14:56:35 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/tdx] BUILD SUCCESS
 564ea84c8c14b007d7838bfb1327295b873573be
Message-ID: <202412061425.3P4cYe8R-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/tdx
branch HEAD: 564ea84c8c14b007d7838bfb1327295b873573be  x86/tdx: Dump attributes and TD_CTLS on boot

elapsed time: 722m

configs tested: 140
configs skipped: 99

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
arc                              alldefconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                        nsimosci_defconfig    gcc-14.2.0
arc                   randconfig-001-20241206    gcc-14.2.0
arc                   randconfig-002-20241206    gcc-14.2.0
arc                        vdk_hs38_defconfig    gcc-14.2.0
arm                               allnoconfig    gcc-14.2.0
arm                     am200epdkit_defconfig    gcc-14.2.0
arm                       aspeed_g5_defconfig    gcc-14.2.0
arm                          exynos_defconfig    clang-20
arm                            mps2_defconfig    clang-20
arm                         mv78xx0_defconfig    gcc-14.2.0
arm                        mvebu_v7_defconfig    gcc-14.2.0
arm                           omap1_defconfig    clang-20
arm                          pxa910_defconfig    gcc-14.2.0
arm                   randconfig-001-20241206    gcc-14.2.0
arm                   randconfig-002-20241206    gcc-14.2.0
arm                   randconfig-003-20241206    gcc-14.2.0
arm                   randconfig-004-20241206    gcc-14.2.0
arm                        realview_defconfig    clang-20
arm                         s5pv210_defconfig    gcc-14.2.0
arm                           spitz_defconfig    gcc-14.2.0
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20241206    gcc-14.2.0
arm64                 randconfig-002-20241206    gcc-14.2.0
arm64                 randconfig-003-20241206    gcc-14.2.0
arm64                 randconfig-004-20241206    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-20
i386                             alldefconfig    clang-20
i386                 buildonly-randconfig-001    gcc-12
i386        buildonly-randconfig-001-20241206    clang-19
i386                 buildonly-randconfig-002    gcc-12
i386        buildonly-randconfig-002-20241206    clang-19
i386        buildonly-randconfig-002-20241206    gcc-12
i386                 buildonly-randconfig-003    gcc-12
i386        buildonly-randconfig-003-20241206    clang-19
i386        buildonly-randconfig-003-20241206    gcc-12
i386                 buildonly-randconfig-004    gcc-12
i386        buildonly-randconfig-004-20241206    clang-19
i386        buildonly-randconfig-004-20241206    gcc-12
i386                 buildonly-randconfig-005    gcc-12
i386        buildonly-randconfig-005-20241206    clang-19
i386                 buildonly-randconfig-006    gcc-12
i386        buildonly-randconfig-006-20241206    clang-19
i386        buildonly-randconfig-006-20241206    gcc-12
loongarch                         allnoconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                       m5249evb_defconfig    gcc-14.2.0
m68k                        m5307c3_defconfig    clang-20
m68k                        mvme147_defconfig    clang-20
m68k                           sun3_defconfig    clang-20
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                         bigsur_defconfig    gcc-14.2.0
mips                           ci20_defconfig    gcc-14.2.0
mips                            gpr_defconfig    clang-20
mips                           ip28_defconfig    clang-20
mips                           ip30_defconfig    gcc-14.2.0
mips                           jazz_defconfig    clang-20
mips                     loongson1b_defconfig    clang-15
mips                      maltaaprp_defconfig    clang-20
mips                           xway_defconfig    clang-20
nios2                         10m50_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
openrisc                          allnoconfig    clang-20
openrisc                 simple_smp_defconfig    clang-20
parisc                           alldefconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc64                         alldefconfig    clang-20
powerpc                           allnoconfig    clang-20
powerpc                     asp8347_defconfig    gcc-14.2.0
powerpc                      cm5200_defconfig    gcc-14.2.0
powerpc                   currituck_defconfig    gcc-14.2.0
powerpc                     ep8248e_defconfig    clang-20
powerpc                      ep88xc_defconfig    gcc-14.2.0
powerpc                       holly_defconfig    clang-20
powerpc                       holly_defconfig    gcc-14.2.0
powerpc                        icon_defconfig    clang-20
powerpc                      katmai_defconfig    gcc-14.2.0
powerpc                 linkstation_defconfig    clang-20
powerpc                   lite5200b_defconfig    gcc-14.2.0
powerpc                   motionpro_defconfig    gcc-14.2.0
powerpc                 mpc8313_rdb_defconfig    clang-20
powerpc               mpc834x_itxgp_defconfig    gcc-14.2.0
powerpc                 mpc836x_rdk_defconfig    gcc-14.2.0
powerpc                 mpc837x_rdb_defconfig    clang-20
powerpc                  mpc885_ads_defconfig    gcc-14.2.0
powerpc                     ppa8548_defconfig    clang-20
powerpc                     tqm8540_defconfig    clang-20
powerpc                     tqm8560_defconfig    clang-20
powerpc                        warp_defconfig    gcc-14.2.0
riscv                             allnoconfig    clang-20
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                         apsh4a3a_defconfig    gcc-14.2.0
sh                         ecovec24_defconfig    clang-20
sh                        edosk7705_defconfig    gcc-14.2.0
sh                        edosk7760_defconfig    clang-20
sh                            hp6xx_defconfig    gcc-14.2.0
sh                          landisk_defconfig    clang-20
sh                            migor_defconfig    gcc-14.2.0
sh                          rsk7264_defconfig    gcc-14.2.0
sh                          sdk7786_defconfig    clang-20
sh                           se7206_defconfig    clang-20
sh                           se7343_defconfig    clang-20
sh                           se7721_defconfig    gcc-14.2.0
sh                           se7750_defconfig    gcc-14.2.0
sh                             sh03_defconfig    clang-20
sh                     sh7710voipgw_defconfig    clang-20
sh                        sh7757lcr_defconfig    clang-20
sh                        sh7763rdp_defconfig    clang-20
sh                        sh7763rdp_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                       sparc32_defconfig    clang-15
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20241206    clang-19
x86_64      buildonly-randconfig-001-20241206    gcc-12
x86_64      buildonly-randconfig-002-20241206    clang-19
x86_64      buildonly-randconfig-002-20241206    gcc-12
x86_64      buildonly-randconfig-003-20241206    clang-19
x86_64      buildonly-randconfig-003-20241206    gcc-12
x86_64      buildonly-randconfig-004-20241206    clang-19
x86_64      buildonly-randconfig-005-20241206    clang-19
x86_64      buildonly-randconfig-005-20241206    gcc-11
x86_64      buildonly-randconfig-006-20241206    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                generic_kc705_defconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

