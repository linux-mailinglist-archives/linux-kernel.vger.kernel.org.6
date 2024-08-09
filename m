Return-Path: <linux-kernel+bounces-280890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B70F094D084
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 14:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F6251F22D59
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 12:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6D4194A40;
	Fri,  9 Aug 2024 12:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lmwhS6PZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA1015AD86
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 12:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723207775; cv=none; b=Gi4mIO4YZB2TpVprMx1u+2AEmmtTQWOrsNXWhPx508emKiVyK4Pxu47gVcBlTgwGXyD6NAv1D2Cl7S2H58D0k1vMOlXKcswrRtQPiycOmLQ786AvPnPeEW0lKdHaLXg+ePEG7GEJxIS8jJIQPB6OlEqMU5W3/bx3rYREcBUHNyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723207775; c=relaxed/simple;
	bh=4ZjgQvxyd6ojPOOmFntYIW19hgu/62tYmXiykXOv2I0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ULb+Ncn5kEBZyrazNPaab8LFb2a5xmuBwoVKlI9y8nD77g+0f4obKZR5AXH10XB1UFJXoLTCXbC8Q/lyaYkZKFpydVC1oPppf+tDlatL5w2K7jZJIAnaNQG6WUJ9Z/PzD4A2sgX+/JyU+41gi/NiuT65YcD0kwaAmiB2ZZeeR+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lmwhS6PZ; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723207774; x=1754743774;
  h=date:from:to:cc:subject:message-id;
  bh=4ZjgQvxyd6ojPOOmFntYIW19hgu/62tYmXiykXOv2I0=;
  b=lmwhS6PZmpoc5/XYvaEkTitpjWU6mxiajpFcat6255UGQImgPeUizu5Y
   41qXeUxirmh0keIqUGFDdRz0YvCntT3+PX3uREojBsRBLrULplq1NgxK7
   bwQFk4g87vQerDiyG32xOjP6P+u0flkD/jDdet7/CDz1e1xfO/w/W7BTZ
   n6Z7DarEB9bMg+4lUB+UU+1MDBDH8kHWZ926b1BD55bdWpkkGeQbVjzy7
   gqEuAtwSwYXYV2kq6iG9cwRvEL4vsq2wv/q7rOyez6gG4bEGPgKk5f1H5
   MtyX9XsTpQbftO6Y+hwYJoWjAxTM0/uRfwR4kJCs5KuoROrKEsSW8mZM1
   g==;
X-CSE-ConnectionGUID: QLH+KuG4RqaUsw4YcJbi4w==
X-CSE-MsgGUID: cEtNv4+yTh+x5tCHBuGLZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="21521381"
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="21521381"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 05:49:33 -0700
X-CSE-ConnectionGUID: HoHdETNkQluvlL2ln316xQ==
X-CSE-MsgGUID: AI0htbRbQMGBzHfKFn5Ubg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="62400061"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 09 Aug 2024 05:49:31 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1scP3d-0007y0-0d;
	Fri, 09 Aug 2024 12:49:26 +0000
Date: Fri, 09 Aug 2024 20:48:18 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:irq/core] BUILD SUCCESS
 60029162a0458832ab2bcfc6fd4986bfd9ca0f55
Message-ID: <202408092015.TjO3E7bh-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
branch HEAD: 60029162a0458832ab2bcfc6fd4986bfd9ca0f55  genirq: Remove irq_chip_regs:: Polarity

elapsed time: 1274m

configs tested: 203
configs skipped: 6

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
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240809   gcc-13.2.0
arc                   randconfig-002-20240809   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                               allnoconfig   clang-20
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                         assabet_defconfig   clang-15
arm                          collie_defconfig   clang-15
arm                                 defconfig   gcc-13.2.0
arm                           h3600_defconfig   gcc-14.1.0
arm                       imx_v6_v7_defconfig   gcc-14.1.0
arm                            mmp2_defconfig   clang-15
arm                          moxart_defconfig   clang-15
arm                        mvebu_v7_defconfig   gcc-14.1.0
arm                   randconfig-001-20240809   gcc-13.2.0
arm                   randconfig-002-20240809   gcc-13.2.0
arm                   randconfig-003-20240809   gcc-13.2.0
arm                   randconfig-004-20240809   gcc-13.2.0
arm                         s3c6400_defconfig   clang-15
arm                       spear13xx_defconfig   clang-15
arm                        spear6xx_defconfig   clang-15
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240809   gcc-13.2.0
arm64                 randconfig-002-20240809   gcc-13.2.0
arm64                 randconfig-003-20240809   gcc-13.2.0
arm64                 randconfig-004-20240809   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240809   gcc-13.2.0
csky                  randconfig-002-20240809   gcc-13.2.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   clang-20
hexagon                          allyesconfig   clang-20
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-12
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-12
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240809   gcc-12
i386         buildonly-randconfig-002-20240809   clang-18
i386         buildonly-randconfig-002-20240809   gcc-12
i386         buildonly-randconfig-003-20240809   gcc-11
i386         buildonly-randconfig-003-20240809   gcc-12
i386         buildonly-randconfig-004-20240809   clang-18
i386         buildonly-randconfig-004-20240809   gcc-12
i386         buildonly-randconfig-005-20240809   clang-18
i386         buildonly-randconfig-005-20240809   gcc-12
i386         buildonly-randconfig-006-20240809   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240809   gcc-12
i386                  randconfig-002-20240809   clang-18
i386                  randconfig-002-20240809   gcc-12
i386                  randconfig-003-20240809   clang-18
i386                  randconfig-003-20240809   gcc-12
i386                  randconfig-004-20240809   gcc-12
i386                  randconfig-005-20240809   clang-18
i386                  randconfig-005-20240809   gcc-12
i386                  randconfig-006-20240809   gcc-12
i386                  randconfig-011-20240809   gcc-12
i386                  randconfig-012-20240809   gcc-12
i386                  randconfig-013-20240809   gcc-12
i386                  randconfig-014-20240809   gcc-12
i386                  randconfig-015-20240809   gcc-11
i386                  randconfig-015-20240809   gcc-12
i386                  randconfig-016-20240809   gcc-12
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240809   gcc-13.2.0
loongarch             randconfig-002-20240809   gcc-13.2.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-14.1.0
mips                     cu1830-neo_defconfig   gcc-14.1.0
mips                          eyeq5_defconfig   gcc-14.1.0
mips                      fuloong2e_defconfig   gcc-14.1.0
mips                           gcw0_defconfig   gcc-14.1.0
mips                           ip32_defconfig   clang-15
mips                     loongson1b_defconfig   gcc-14.1.0
mips                        maltaup_defconfig   gcc-14.1.0
mips                          rm200_defconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240809   gcc-13.2.0
nios2                 randconfig-002-20240809   gcc-13.2.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240809   gcc-13.2.0
parisc                randconfig-002-20240809   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   gcc-14.1.0
powerpc                   bluestone_defconfig   clang-15
powerpc               randconfig-001-20240809   gcc-13.2.0
powerpc64                        alldefconfig   clang-15
powerpc64             randconfig-001-20240809   gcc-13.2.0
powerpc64             randconfig-002-20240809   gcc-13.2.0
powerpc64             randconfig-003-20240809   gcc-13.2.0
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-14.1.0
riscv             nommu_k210_sdcard_defconfig   clang-15
riscv             nommu_k210_sdcard_defconfig   gcc-14.1.0
riscv                 randconfig-001-20240809   gcc-13.2.0
riscv                 randconfig-002-20240809   gcc-13.2.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-20
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240809   gcc-13.2.0
s390                  randconfig-002-20240809   gcc-13.2.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                         apsh4a3a_defconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                    randconfig-001-20240809   gcc-13.2.0
sh                    randconfig-002-20240809   gcc-13.2.0
sh                           se7705_defconfig   gcc-14.1.0
sh                   secureedge5410_defconfig   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc                       sparc64_defconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240809   gcc-13.2.0
sparc64               randconfig-002-20240809   gcc-13.2.0
um                               allmodconfig   clang-20
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-12
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240809   gcc-13.2.0
um                    randconfig-002-20240809   gcc-13.2.0
um                           x86_64_defconfig   gcc-14.1.0
x86_64                           alldefconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240809   clang-18
x86_64       buildonly-randconfig-002-20240809   clang-18
x86_64       buildonly-randconfig-003-20240809   clang-18
x86_64       buildonly-randconfig-004-20240809   clang-18
x86_64       buildonly-randconfig-005-20240809   clang-18
x86_64       buildonly-randconfig-006-20240809   clang-18
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-11
x86_64                randconfig-001-20240809   clang-18
x86_64                randconfig-002-20240809   clang-18
x86_64                randconfig-003-20240809   clang-18
x86_64                randconfig-004-20240809   clang-18
x86_64                randconfig-005-20240809   clang-18
x86_64                randconfig-006-20240809   clang-18
x86_64                randconfig-011-20240809   clang-18
x86_64                randconfig-012-20240809   clang-18
x86_64                randconfig-013-20240809   clang-18
x86_64                randconfig-014-20240809   clang-18
x86_64                randconfig-015-20240809   clang-18
x86_64                randconfig-016-20240809   clang-18
x86_64                randconfig-071-20240809   clang-18
x86_64                randconfig-072-20240809   clang-18
x86_64                randconfig-073-20240809   clang-18
x86_64                randconfig-074-20240809   clang-18
x86_64                randconfig-075-20240809   clang-18
x86_64                randconfig-076-20240809   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240809   gcc-13.2.0
xtensa                randconfig-002-20240809   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

