Return-Path: <linux-kernel+bounces-265045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A5693EBDC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 05:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B54B1C21811
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 03:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9E27E782;
	Mon, 29 Jul 2024 03:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qr0XXebC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F631E519
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 03:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722223775; cv=none; b=BxYA5aBrtu/DpGOU8t7sfaw/j2+jw8Jh+wCNCJt63mpEFIZr93gH2vhhUQyFdViBXq70YzM87XqH/wshtdZTt1/9IANjqVSPgtKNk3BDGVDXDpWvtPSa7mkxRFkVn46Q6SsAlQzDE5NYUgFjN1dLzOS9mi8tYmE4QzrY8CntOIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722223775; c=relaxed/simple;
	bh=01BNjubsQhCHzC3QpwRqklZ7efzN6lZt7tl1cJ4qvZ8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=pWGYL0Dt78i3+jYmwNpYQtWjMXKxm+z17U9eOLMWjzMaR0KY8tpqsojtWx3oUgRCMMpzwvF0+5OkCHWbFPt31+lLyA3jq5UoE09S1VLsuoP7z8/de4ztmJfNN9BHstVoqIhOUI5p1wfmnfkxuFvQqaD5FKamxNAE/0yLLbqwFeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qr0XXebC; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722223773; x=1753759773;
  h=date:from:to:cc:subject:message-id;
  bh=01BNjubsQhCHzC3QpwRqklZ7efzN6lZt7tl1cJ4qvZ8=;
  b=Qr0XXebCt7k6Av0tJsPtU9cjsxM3VLMXjBY02XYi1PMMZwuWquapzitf
   zDgXGPkdsPTGQmF/wc1y3NvC2si1SHKcDkL7K1O9Yv+uBQ5SH1OR3z83W
   U24cVygh3OgKF0fDVM/v8gPe54dlxG9K65VJff/IRT6lFutnZ06dUf6vT
   Ufi3UC7KD1LU3SCzV6QkKQ2O2sLgO3XIJG4is6yX0J5Ln0q2rb6IPH4vp
   96SxERUipE+e8hadVtqfxobWsdsTXm80gQV9LiuFms9jmBSgC2vYl2fXc
   eYtDuN5Nd/PbnSqYd8ZWQcSPcIY9yn2a/voWdPuDRICsLaTvlffrAt0KS
   A==;
X-CSE-ConnectionGUID: tmw6Rp/lRQa2IECoxxwsEQ==
X-CSE-MsgGUID: JOd1/DDCRMyR3B0P7zRkvA==
X-IronPort-AV: E=McAfee;i="6700,10204,11147"; a="20074956"
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="20074956"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2024 20:29:32 -0700
X-CSE-ConnectionGUID: wmJ+vtkfSQ6bo1DGoW6fkw==
X-CSE-MsgGUID: jiR5m2lJTa+eLMx0t1n4PA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="58920882"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 28 Jul 2024 20:29:32 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sYH4i-000rMq-3A;
	Mon, 29 Jul 2024 03:29:28 +0000
Date: Mon, 29 Jul 2024 11:29:19 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 adc1e22c8d21679b4edeabc256741a317f6be43e
Message-ID: <202407291116.o0Uat7YX-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: adc1e22c8d21679b4edeabc256741a317f6be43e  Merge branch into tip/master: 'x86/mm'

elapsed time: 1058m

configs tested: 178
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.3.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                     haps_hs_smp_defconfig   gcc-13.2.0
arc                   randconfig-001-20240728   gcc-13.2.0
arc                   randconfig-002-20240728   gcc-13.2.0
arc                           tb10x_defconfig   gcc-13.2.0
arm                               allnoconfig   clang-20
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-14.1.0
arm                                 defconfig   clang-14
arm                   randconfig-001-20240728   clang-20
arm                   randconfig-002-20240728   clang-20
arm                   randconfig-003-20240728   gcc-14.1.0
arm                   randconfig-004-20240728   gcc-14.1.0
arm                             rpc_defconfig   clang-20
arm                         s5pv210_defconfig   gcc-14.1.0
arm                        spear3xx_defconfig   clang-16
arm64                            allmodconfig   clang-20
arm64                             allnoconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-14.1.0
arm64                 randconfig-001-20240728   gcc-14.1.0
arm64                 randconfig-002-20240728   clang-20
arm64                 randconfig-003-20240728   gcc-14.1.0
arm64                 randconfig-004-20240728   gcc-14.1.0
csky                              allnoconfig   gcc-13.2.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-14.1.0
csky                  randconfig-001-20240728   gcc-14.1.0
csky                  randconfig-002-20240728   gcc-14.1.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   clang-20
hexagon                          allyesconfig   clang-20
hexagon                             defconfig   clang-20
hexagon               randconfig-001-20240728   clang-15
hexagon               randconfig-002-20240728   clang-17
i386                             allmodconfig   gcc-13
i386                              allnoconfig   gcc-13
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240728   clang-18
i386         buildonly-randconfig-002-20240728   gcc-13
i386         buildonly-randconfig-003-20240728   gcc-11
i386         buildonly-randconfig-004-20240728   gcc-13
i386         buildonly-randconfig-005-20240728   gcc-11
i386         buildonly-randconfig-006-20240728   gcc-9
i386                                defconfig   clang-18
i386                  randconfig-001-20240728   gcc-13
i386                  randconfig-002-20240728   gcc-13
i386                  randconfig-003-20240728   gcc-7
i386                  randconfig-004-20240728   gcc-13
i386                  randconfig-005-20240728   clang-18
i386                  randconfig-006-20240728   gcc-13
i386                  randconfig-011-20240728   gcc-13
i386                  randconfig-012-20240728   gcc-12
i386                  randconfig-013-20240728   clang-18
i386                  randconfig-014-20240728   gcc-13
i386                  randconfig-015-20240728   gcc-13
i386                  randconfig-016-20240728   clang-18
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-14.1.0
loongarch             randconfig-001-20240728   gcc-14.1.0
loongarch             randconfig-002-20240728   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-14.1.0
m68k                          multi_defconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-14.1.0
mips                              allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-14.1.0
mips                           ip30_defconfig   gcc-14.1.0
mips                     loongson1c_defconfig   gcc-13.2.0
mips                      pic32mzda_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-14.1.0
nios2                 randconfig-001-20240728   gcc-14.1.0
nios2                 randconfig-002-20240728   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240728   gcc-14.1.0
parisc                randconfig-002-20240728   gcc-14.1.0
parisc64                            defconfig   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-20
powerpc                    amigaone_defconfig   gcc-14.1.0
powerpc                      bamboo_defconfig   clang-20
powerpc                      cm5200_defconfig   clang-20
powerpc                    ge_imp3a_defconfig   gcc-14.1.0
powerpc                     rainier_defconfig   gcc-14.1.0
powerpc                  storcenter_defconfig   gcc-14.1.0
powerpc64             randconfig-001-20240728   clang-20
powerpc64             randconfig-002-20240728   gcc-14.1.0
powerpc64             randconfig-003-20240728   clang-17
riscv                            allmodconfig   clang-20
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-20
riscv                               defconfig   clang-20
riscv                 randconfig-001-20240728   clang-20
riscv                 randconfig-002-20240728   clang-15
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                             allyesconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   clang-20
s390                  randconfig-001-20240728   clang-16
s390                  randconfig-002-20240728   gcc-14.1.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                 kfr2r09-romimage_defconfig   gcc-14.1.0
sh                    randconfig-001-20240728   gcc-14.1.0
sh                    randconfig-002-20240728   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240728   gcc-14.1.0
sparc64               randconfig-002-20240728   gcc-14.1.0
um                               allmodconfig   clang-20
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-13
um                                  defconfig   clang-20
um                             i386_defconfig   gcc-13
um                    randconfig-001-20240728   gcc-11
um                    randconfig-002-20240728   gcc-13
um                           x86_64_defconfig   clang-15
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240728   gcc-13
x86_64       buildonly-randconfig-002-20240728   clang-18
x86_64       buildonly-randconfig-003-20240728   clang-18
x86_64       buildonly-randconfig-004-20240728   gcc-13
x86_64       buildonly-randconfig-005-20240728   clang-18
x86_64       buildonly-randconfig-006-20240728   clang-18
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240728   clang-18
x86_64                randconfig-002-20240728   gcc-13
x86_64                randconfig-003-20240728   gcc-13
x86_64                randconfig-004-20240728   gcc-8
x86_64                randconfig-005-20240728   gcc-12
x86_64                randconfig-006-20240728   gcc-13
x86_64                randconfig-011-20240728   clang-18
x86_64                randconfig-012-20240728   clang-18
x86_64                randconfig-013-20240728   gcc-13
x86_64                randconfig-014-20240728   clang-18
x86_64                randconfig-015-20240728   gcc-11
x86_64                randconfig-016-20240728   clang-18
x86_64                randconfig-071-20240728   clang-18
x86_64                randconfig-072-20240728   gcc-13
x86_64                randconfig-073-20240728   clang-18
x86_64                randconfig-074-20240728   clang-18
x86_64                randconfig-075-20240728   clang-18
x86_64                randconfig-076-20240728   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240728   gcc-14.1.0
xtensa                randconfig-002-20240728   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

