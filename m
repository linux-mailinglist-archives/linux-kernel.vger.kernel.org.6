Return-Path: <linux-kernel+bounces-234394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A9491C612
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 20:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9EAFB25E2C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 18:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECCC50280;
	Fri, 28 Jun 2024 18:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HMg6zWnx"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2564D8B2
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 18:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719600579; cv=none; b=Z/x06QA1SfriXHWMW8Y1wuijLORwolZQaX+3/bYDJ0bzls8Tvw66lT9dtibjyKJiRrT7vQDt2WbyhNsqI/nSMshH0ZlgKXjDQuq1SBlkKsZDGLv8VcQLqfOwcepIF0Q1ieU4Sx9w1ZSS7UfIYcH/BZ5WDKA+mDI9VzhMEjboWA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719600579; c=relaxed/simple;
	bh=FDCgokfDXfl4sYqbUiOjhV28boCoFBp6llgs8JTPdHg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=IfIwodXzcX8z/VrzUi81pmjYrO8drzEomDwSBxcm09lxks2Dr8d9iVOq53tpzrFWGvc/Msbp0YU/ZFccUoCDrQAhflnpjJrrM08ulpBjfAphvH9WOVvElea+cehDkwT+YejL53e62jcmJc8VgXoTU1MoRN322MH7/F1Qiin1jo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HMg6zWnx; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719600578; x=1751136578;
  h=date:from:to:cc:subject:message-id;
  bh=FDCgokfDXfl4sYqbUiOjhV28boCoFBp6llgs8JTPdHg=;
  b=HMg6zWnxA418WM7Eqy9KeVqMglJxodCKKvJ0a+75jdcSx3cDQuNlTPp4
   N39qZZ7XrgwDkXAFuRkkA8Y/QKlOyISxSShZc5Zo6KhFCaVBPrpfF3fdv
   3diD0nhDlxrHpWlY2Aw0y+R9ebB+HTtJhKCuk/FQXNFirYZ4oiuFaVpiQ
   TzyLPxQbq2ZYkC0DXuA2mB+ACY3ZtwvIQaThOdC5o2rxe2LRgcKZgQGZS
   d/l4SR2pX6JA1NLcDfWAsDmUsju4CH5Js72LoZOKppiGF+JwZLGooXlqu
   8nRwW9fsYi47I+/Pb2Qet9MWuDQ55FpzB1XT4es20lLWp9hwMQlT1b2W9
   A==;
X-CSE-ConnectionGUID: mCUlLXuUR8ySSvaVGnnvwA==
X-CSE-MsgGUID: cPJQKrXpSgSDUHh3XlF64w==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="19697951"
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="19697951"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 11:49:37 -0700
X-CSE-ConnectionGUID: Z0q99/MoRPONTtUpjh8HSQ==
X-CSE-MsgGUID: i/UE2oVEQCGmz8c/CERqGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="44937740"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 28 Jun 2024 11:49:36 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sNGf7-000Hmz-1S;
	Fri, 28 Jun 2024 18:49:33 +0000
Date: Sat, 29 Jun 2024 02:49:04 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/build] BUILD SUCCESS
 469169803d52a5d8f0dc781090638e851a7d22b1
Message-ID: <202406290203.STUUwON7-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/build
branch HEAD: 469169803d52a5d8f0dc781090638e851a7d22b1  x86/kconfig: Add as-instr64 macro to properly evaluate AS_WRUSS

elapsed time: 11557m

configs tested: 173
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240628   gcc-13.2.0
arc                   randconfig-002-20240628   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                     am200epdkit_defconfig   gcc-13.2.0
arm                         bcm2835_defconfig   gcc-13.2.0
arm                     davinci_all_defconfig   gcc-13.2.0
arm                                 defconfig   gcc-13.2.0
arm                        multi_v5_defconfig   gcc-13.2.0
arm                         mv78xx0_defconfig   gcc-13.2.0
arm                        mvebu_v7_defconfig   gcc-13.2.0
arm                           omap1_defconfig   gcc-13.2.0
arm                   randconfig-001-20240628   gcc-13.2.0
arm                   randconfig-002-20240628   gcc-13.2.0
arm                   randconfig-003-20240628   gcc-13.2.0
arm                   randconfig-004-20240628   gcc-13.2.0
arm                           tegra_defconfig   gcc-13.2.0
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                            allyesconfig   clang-19
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240628   gcc-13.2.0
arm64                 randconfig-002-20240628   gcc-13.2.0
arm64                 randconfig-003-20240628   gcc-13.2.0
arm64                 randconfig-004-20240628   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240628   gcc-13.2.0
csky                  randconfig-002-20240628   gcc-13.2.0
i386                             allmodconfig   clang-18
i386                              allnoconfig   clang-18
i386                             allyesconfig   clang-18
i386         buildonly-randconfig-001-20240628   gcc-10
i386         buildonly-randconfig-002-20240628   gcc-10
i386         buildonly-randconfig-003-20240628   gcc-10
i386         buildonly-randconfig-004-20240628   gcc-10
i386         buildonly-randconfig-005-20240628   gcc-10
i386         buildonly-randconfig-006-20240628   gcc-10
i386                                defconfig   clang-18
i386                  randconfig-001-20240628   gcc-10
i386                  randconfig-002-20240628   gcc-10
i386                  randconfig-003-20240628   gcc-10
i386                  randconfig-004-20240628   gcc-10
i386                  randconfig-005-20240628   gcc-10
i386                  randconfig-006-20240628   gcc-10
i386                  randconfig-011-20240628   gcc-10
i386                  randconfig-012-20240628   gcc-10
i386                  randconfig-013-20240628   gcc-10
i386                  randconfig-014-20240628   gcc-10
i386                  randconfig-015-20240628   gcc-10
i386                  randconfig-016-20240628   gcc-10
loongarch                        allmodconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240628   gcc-13.2.0
loongarch             randconfig-002-20240628   gcc-13.2.0
m68k                             allmodconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-13.2.0
m68k                                defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-13.2.0
microblaze                          defconfig   gcc-13.2.0
mips                             allmodconfig   clang-19
mips                              allnoconfig   gcc-13.2.0
mips                             allyesconfig   clang-19
mips                          ath79_defconfig   gcc-13.2.0
mips                        qi_lb60_defconfig   gcc-13.2.0
nios2                            allmodconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                            allyesconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240628   gcc-13.2.0
nios2                 randconfig-002-20240628   gcc-13.2.0
openrisc                         allmodconfig   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                         allyesconfig   gcc-13.2.0
openrisc                            defconfig   gcc-13.2.0
parisc                           allmodconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                           allyesconfig   gcc-13.2.0
parisc                              defconfig   gcc-13.2.0
parisc                randconfig-001-20240628   gcc-13.2.0
parisc                randconfig-002-20240628   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc                          allyesconfig   gcc-13.2.0
powerpc                    amigaone_defconfig   gcc-13.2.0
powerpc                    klondike_defconfig   gcc-13.2.0
powerpc                    mvme5100_defconfig   gcc-13.2.0
powerpc                      ppc44x_defconfig   gcc-13.2.0
powerpc               randconfig-001-20240628   gcc-13.2.0
powerpc               randconfig-002-20240628   gcc-13.2.0
powerpc               randconfig-003-20240628   gcc-13.2.0
powerpc64             randconfig-001-20240628   gcc-13.2.0
powerpc64             randconfig-002-20240628   gcc-13.2.0
powerpc64             randconfig-003-20240628   gcc-13.2.0
riscv                            allmodconfig   gcc-13.2.0
riscv                             allnoconfig   gcc-13.2.0
riscv                            allyesconfig   gcc-13.2.0
riscv                               defconfig   gcc-13.2.0
riscv                 randconfig-001-20240628   gcc-13.2.0
riscv                 randconfig-002-20240628   gcc-13.2.0
s390                              allnoconfig   gcc-13.2.0
s390                                defconfig   gcc-13.2.0
s390                  randconfig-001-20240628   gcc-13.2.0
s390                  randconfig-002-20240628   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                                  defconfig   gcc-13.2.0
sh                          lboxre2_defconfig   gcc-13.2.0
sh                    randconfig-001-20240628   gcc-13.2.0
sh                    randconfig-002-20240628   gcc-13.2.0
sh                          rsk7264_defconfig   gcc-13.2.0
sh                        sh7785lcr_defconfig   gcc-13.2.0
sparc                             allnoconfig   gcc-13.2.0
sparc                            allyesconfig   gcc-13.2.0
sparc                               defconfig   gcc-13.2.0
sparc64                          allmodconfig   gcc-13.2.0
sparc64                          allyesconfig   gcc-13.2.0
sparc64                             defconfig   gcc-13.2.0
sparc64               randconfig-001-20240628   gcc-13.2.0
sparc64               randconfig-002-20240628   gcc-13.2.0
um                                allnoconfig   gcc-13.2.0
um                                  defconfig   gcc-13.2.0
um                             i386_defconfig   gcc-13
um                             i386_defconfig   gcc-13.2.0
um                    randconfig-001-20240628   gcc-13.2.0
um                    randconfig-002-20240628   gcc-13.2.0
um                           x86_64_defconfig   gcc-13.2.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240628   gcc-13
x86_64       buildonly-randconfig-002-20240628   gcc-13
x86_64       buildonly-randconfig-003-20240628   gcc-13
x86_64       buildonly-randconfig-004-20240628   gcc-13
x86_64       buildonly-randconfig-005-20240628   gcc-13
x86_64       buildonly-randconfig-006-20240628   gcc-13
x86_64                              defconfig   clang-18
x86_64                                  kexec   clang-18
x86_64                randconfig-001-20240628   gcc-13
x86_64                randconfig-002-20240628   gcc-13
x86_64                randconfig-003-20240628   gcc-13
x86_64                randconfig-004-20240628   gcc-13
x86_64                randconfig-005-20240628   gcc-13
x86_64                randconfig-006-20240628   gcc-13
x86_64                randconfig-011-20240628   gcc-13
x86_64                randconfig-012-20240628   gcc-13
x86_64                randconfig-013-20240628   gcc-13
x86_64                randconfig-014-20240628   gcc-13
x86_64                randconfig-015-20240628   gcc-13
x86_64                randconfig-016-20240628   gcc-13
x86_64                randconfig-071-20240628   gcc-13
x86_64                randconfig-072-20240628   gcc-13
x86_64                randconfig-073-20240628   gcc-13
x86_64                randconfig-074-20240628   gcc-13
x86_64                randconfig-075-20240628   gcc-13
x86_64                randconfig-076-20240628   gcc-13
x86_64                          rhel-8.3-func   clang-18
x86_64                          rhel-8.3-rust   clang-18
x86_64                               rhel-8.3   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                           allyesconfig   gcc-13.2.0
xtensa                randconfig-001-20240628   gcc-13.2.0
xtensa                randconfig-002-20240628   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

