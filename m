Return-Path: <linux-kernel+bounces-422433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B50969D999F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 15:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 116D0281787
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 14:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F07B1C4A13;
	Tue, 26 Nov 2024 14:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A5gIw5l6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE351799F
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 14:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732631415; cv=none; b=kwOejOamzgnkpEIsxGWabS4Yjh1ZvJHKrjvEN+z9kjDFZIJblP+iPO2qP/GKxVuL/3SDy5d869x6q3I2qFQOKsRkoeMHxDeV0rcVjZbtPKHItv1Ooz8FpesausVQCCrf/vn9W0P4NOCq79yD1l5WOAgLOC2OCRh/KF36fp7gXjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732631415; c=relaxed/simple;
	bh=7I9e3c69UYyr2kizkV8pGJXbu9dfCCDJLYm9G98kNWI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=PytbL/yTEx3MOyDw3WMmwlgSuifwjTu1Uy+dpdaJ3OSvNcxpzvhRP+Kt+mYXtzRa0HSE3Rs58eMYRRf1cN9WEYZuscRtT3TcgBmbTsn51cfoE+An2IiG5c+2qoc9BPq6lU3lYgfjI3EKZnYMsDbYMSu9Nqs3xuXyuisnxXKCsGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A5gIw5l6; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732631414; x=1764167414;
  h=date:from:to:cc:subject:message-id;
  bh=7I9e3c69UYyr2kizkV8pGJXbu9dfCCDJLYm9G98kNWI=;
  b=A5gIw5l6rTKLpW+/gxtM2xHuPOHqWLjPT9CCXhJmnNEhkvv6225VFj4Z
   qsGSM7CiEbdbaNI86O+DaYPstl6UT6/GyqQr0tU1OiiZo3rDj25fN1TXt
   EmPBMhcxeMdzyq3a1JpIzFZlogLYqsK5q8pPVD1cJQgKMVGLcE5fVNciV
   +5RwA9olE95PXmxqxaCHk2AKH4jqyay0EZRKTEfvMD0XTkiRyJ52BpSwo
   G95UXvFaxDiDbYYQZzgAB3iHpJ9le7lUi1BIxDdp6vkcyJvnga3HMDs23
   UPUPcgyGlrDbBafDczwPJhDmVLdu+/Yndzx1GDOWDnz1il/XV/qgCXdDF
   g==;
X-CSE-ConnectionGUID: tMS5D+cwSXKXOI0pET3juw==
X-CSE-MsgGUID: tkc3XvcZR0KOkFmuEx6yOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11268"; a="33046062"
X-IronPort-AV: E=Sophos;i="6.12,186,1728975600"; 
   d="scan'208";a="33046062"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 06:30:13 -0800
X-CSE-ConnectionGUID: k+1V3eqZTTCRXcIHiTFhEQ==
X-CSE-MsgGUID: 8qne4syYQm6nSC+b5eP6LA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,186,1728975600"; 
   d="scan'208";a="91570145"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 26 Nov 2024 06:30:13 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tFwZu-0007L3-0h;
	Tue, 26 Nov 2024 14:30:10 +0000
Date: Tue, 26 Nov 2024 22:28:19 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 d319ed2d7105ddbe7da21a5386e9220e5af8dfec
Message-ID: <202411262210.BLWSp6h0-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: d319ed2d7105ddbe7da21a5386e9220e5af8dfec  Merge branch into tip/master: 'x86/mm'

elapsed time: 1037m

configs tested: 120
configs skipped: 19

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
arc                          axs101_defconfig    gcc-14.2.0
arc                      axs103_smp_defconfig    gcc-13.2.0
arc                            hsdk_defconfig    gcc-14.2.0
arm                              allmodconfig    clang-20
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-20
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-20
arm                              allyesconfig    gcc-14.2.0
arm                       aspeed_g5_defconfig    gcc-13.2.0
arm                         at91_dt_defconfig    clang-20
arm                          ep93xx_defconfig    clang-14
arm                       multi_v4t_defconfig    gcc-13.2.0
arm                       multi_v4t_defconfig    gcc-14.2.0
arm                        mvebu_v5_defconfig    gcc-13.2.0
arm                             mxs_defconfig    gcc-14.2.0
arm                             pxa_defconfig    clang-14
arm                    vt8500_v6_v7_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-20
i386        buildonly-randconfig-001-20241126    gcc-12
i386        buildonly-randconfig-002-20241126    gcc-12
i386        buildonly-randconfig-003-20241126    clang-19
i386        buildonly-randconfig-004-20241126    gcc-12
i386        buildonly-randconfig-005-20241126    clang-19
i386        buildonly-randconfig-006-20241126    gcc-12
i386                  randconfig-001-20241126    gcc-12
i386                  randconfig-002-20241126    gcc-12
i386                  randconfig-003-20241126    gcc-12
i386                  randconfig-004-20241126    gcc-11
i386                  randconfig-005-20241126    clang-19
i386                  randconfig-006-20241126    clang-19
i386                  randconfig-011-20241126    clang-19
i386                  randconfig-012-20241126    clang-19
i386                  randconfig-013-20241126    clang-19
i386                  randconfig-014-20241126    gcc-12
i386                  randconfig-015-20241126    clang-19
i386                  randconfig-016-20241126    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
m68k                             alldefconfig    clang-14
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                       bvme6000_defconfig    gcc-14.2.0
m68k                        stmark2_defconfig    gcc-13.2.0
m68k                           sun3_defconfig    clang-20
m68k                          sun3x_defconfig    clang-14
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                      mmu_defconfig    gcc-13.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          ath79_defconfig    clang-14
mips                           xway_defconfig    clang-14
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
powerpc                          allyesconfig    clang-20
powerpc                          allyesconfig    gcc-14.2.0
powerpc                      pcm030_defconfig    gcc-14.2.0
powerpc                      pmac32_defconfig    clang-14
powerpc                      ppc6xx_defconfig    gcc-14.2.0
powerpc                     redwood_defconfig    clang-20
powerpc                    socrates_defconfig    gcc-13.2.0
powerpc                     tqm8541_defconfig    gcc-14.2.0
riscv                            allmodconfig    clang-20
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                            allyesconfig    gcc-14.2.0
s390                             allmodconfig    clang-20
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
sh                               alldefconfig    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                         ap325rxa_defconfig    gcc-13.2.0
sh                            hp6xx_defconfig    clang-14
sh                               j2_defconfig    gcc-14.2.0
sh                          kfr2r09_defconfig    gcc-13.2.0
sh                          landisk_defconfig    gcc-13.2.0
sh                          landisk_defconfig    gcc-14.2.0
sh                     magicpanelr2_defconfig    gcc-13.2.0
sh                          rsk7203_defconfig    gcc-13.2.0
sh                        sh7763rdp_defconfig    gcc-13.2.0
sparc                            allmodconfig    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                               allyesconfig    gcc-12
x86_64                                  kexec    clang-19
x86_64                               rhel-9.4    gcc-12
xtensa                            allnoconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

