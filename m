Return-Path: <linux-kernel+bounces-359493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DBD998C58
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 17:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AA7A1F21973
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 15:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F210E1BDAA8;
	Thu, 10 Oct 2024 15:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ib0w1v2y"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F8F1CCEF4
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 15:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728575483; cv=none; b=S8Z9UXsuB5/qV/Sjjjq4YZ4HS0hE7jZtVWiTz32LEXScRcHQMYDWMQDn8urzbpmJ6hG2J0a5eKxAq8cNUdbGySbnX4Ltux7zA5lclclh/LaHbqPhB763mLbSTNBJRG/WJwgK0LnV0UzD4HbyoriM6gTUSnjkUfJPQtaZF2s1Hhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728575483; c=relaxed/simple;
	bh=56qoVXJ5mDghPdktLQW0VxOLUrgqn4wCBc7yVYn1PJI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Zyf2VGjK/V7pkmPnUIkcxMBQZKb7cM+rhKzKv0wBQzMuL9kQfJNBDgQcG0Fhcz2iJv0wHGYUDvtpl14y5SsL/r7JOgRmsOK2G2Fsz8fju/WRUdTUBDFbES3ZCRAcSIET5+9g8PurJsXo1hsSqkc6ieUgCINHrU+5MONmsD4WXtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ib0w1v2y; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728575481; x=1760111481;
  h=date:from:to:cc:subject:message-id;
  bh=56qoVXJ5mDghPdktLQW0VxOLUrgqn4wCBc7yVYn1PJI=;
  b=Ib0w1v2yr5MSxPI4/gUGj7dgYT0UrfIvFV7FVuICa8mlYZoE0ux6Scex
   ectuxwPEEhIo5B9cxbZlovDm/wG0XEA4u9cC6JAvmCCLeYHg/fNRvHGoh
   RLnRk7q/e3Yr3RK31AtGXBusZ6w5j/XI5MsAYQkgK7AsYFgjOS9Dsm3fM
   sqZ5LwgqcK03B7DrUBlkfE3vLemXiMsS6EgPfF9YxymYxGGw2hk8zFh2g
   vm3VTuAuTi9grHH+ovbCHAmtvhPLk3rNQjaGOHE8YNQYfv2TdiNgyjZOs
   DhPCogpX6zsPARBQ2qEFMmYjxplL7/rjd9In02F6Yo28TwPqllqf1JyEH
   A==;
X-CSE-ConnectionGUID: /W89hpaTSG2/ALeBM7nxbQ==
X-CSE-MsgGUID: Hbj5etFQSuy7s8EJCd6cqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="27392074"
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="27392074"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 08:51:20 -0700
X-CSE-ConnectionGUID: 46M9gh3cSxCc3EAknevp8A==
X-CSE-MsgGUID: 3+yl2sfURXi7hleYa4R3tA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="107356851"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 10 Oct 2024 08:51:18 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1syvRc-000AxB-1a;
	Thu, 10 Oct 2024 15:51:16 +0000
Date: Thu, 10 Oct 2024 23:50:52 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:timers/core] BUILD SUCCESS WITH WARNING
 5ce9bb4d5af2f5ef38f134e3cb400c873d357de7
Message-ID: <202410102346.4rhGoSIL-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
branch HEAD: 5ce9bb4d5af2f5ef38f134e3cb400c873d357de7  clocksource: Remove unused clocksource_change_rating

Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202410100903.emvWh4LZ-lkp@intel.com

    kernel/time/clocksource.c:1258:13: warning: '__clocksource_change_rating' defined but not used [-Wunused-function]

Warning ids grouped by kconfigs:

recent_errors
|-- alpha-allmodconfig
|   `-- kernel-time-clocksource.c:warning:__clocksource_change_rating-defined-but-not-used
|-- alpha-allnoconfig
|   `-- kernel-time-clocksource.c:warning:__clocksource_change_rating-defined-but-not-used
|-- alpha-allyesconfig
|   `-- kernel-time-clocksource.c:warning:__clocksource_change_rating-defined-but-not-used
|-- alpha-defconfig
|   `-- kernel-time-clocksource.c:warning:__clocksource_change_rating-defined-but-not-used
|-- arc-allmodconfig
|   `-- kernel-time-clocksource.c:warning:__clocksource_change_rating-defined-but-not-used
|-- arc-allnoconfig
|   `-- kernel-time-clocksource.c:warning:__clocksource_change_rating-defined-but-not-used
|-- arc-allyesconfig
|   `-- kernel-time-clocksource.c:warning:__clocksource_change_rating-defined-but-not-used
|-- arc-defconfig
|   `-- kernel-time-clocksource.c:warning:__clocksource_change_rating-defined-but-not-used
|-- arc-randconfig-001-20241010
|   `-- kernel-time-clocksource.c:warning:__clocksource_change_rating-defined-but-not-used
|-- arc-randconfig-002-20241010
|   `-- kernel-time-clocksource.c:warning:__clocksource_change_rating-defined-but-not-used
|-- arm-omap2plus_defconfig
|   `-- kernel-time-clocksource.c:warning:__clocksource_change_rating-defined-but-not-used
|-- arm-shmobile_defconfig
|   `-- kernel-time-clocksource.c:warning:__clocksource_change_rating-defined-but-not-used
|-- arm-socfpga_defconfig
|   `-- kernel-time-clocksource.c:warning:__clocksource_change_rating-defined-but-not-used
|-- arm-sp7021_defconfig
|   `-- kernel-time-clocksource.c:warning:__clocksource_change_rating-defined-but-not-used
|-- arm64-allnoconfig
|   `-- kernel-time-clocksource.c:warning:__clocksource_change_rating-defined-but-not-used
|-- csky-allnoconfig
|   `-- kernel-time-clocksource.c:warning:__clocksource_change_rating-defined-but-not-used
|-- loongarch-allmodconfig
|   `-- kernel-time-clocksource.c:warning:__clocksource_change_rating-defined-but-not-used
|-- loongarch-allnoconfig
|   `-- kernel-time-clocksource.c:warning:__clocksource_change_rating-defined-but-not-used
|-- loongarch-allyesconfig
|   `-- kernel-time-clocksource.c:warning:__clocksource_change_rating-defined-but-not-used
|-- m68k-allmodconfig
|   `-- kernel-time-clocksource.c:warning:__clocksource_change_rating-defined-but-not-used
|-- m68k-allnoconfig
|   `-- kernel-time-clocksource.c:warning:__clocksource_change_rating-defined-but-not-used
|-- m68k-allyesconfig
|   `-- kernel-time-clocksource.c:warning:__clocksource_change_rating-defined-but-not-used
|-- m68k-m5249evb_defconfig
|   `-- kernel-time-clocksource.c:warning:__clocksource_change_rating-defined-but-not-used
|-- m68k-m5407c3_defconfig
|   `-- kernel-time-clocksource.c:warning:__clocksource_change_rating-defined-but-not-used
|-- microblaze-allmodconfig
|   `-- kernel-time-clocksource.c:warning:__clocksource_change_rating-defined-but-not-used
|-- microblaze-allnoconfig
|   `-- kernel-time-clocksource.c:warning:__clocksource_change_rating-defined-but-not-used
|-- microblaze-allyesconfig
|   `-- kernel-time-clocksource.c:warning:__clocksource_change_rating-defined-but-not-used
|-- mips-cobalt_defconfig
|   `-- kernel-time-clocksource.c:warning:__clocksource_change_rating-defined-but-not-used
|-- mips-decstation_64_defconfig
|   `-- kernel-time-clocksource.c:warning:__clocksource_change_rating-defined-but-not-used
|-- mips-pic32mzda_defconfig
|   `-- kernel-time-clocksource.c:warning:__clocksource_change_rating-defined-but-not-used
|-- nios2-allnoconfig
|   `-- kernel-time-clocksource.c:warning:__clocksource_change_rating-defined-but-not-used
|-- openrisc-allnoconfig
|   `-- kernel-time-clocksource.c:warning:__clocksource_change_rating-defined-but-not-used
|-- openrisc-allyesconfig
|   `-- kernel-time-clocksource.c:warning:__clocksource_change_rating-defined-but-not-used
|-- openrisc-defconfig
|   `-- kernel-time-clocksource.c:warning:__clocksource_change_rating-defined-but-not-used
|-- parisc-allmodconfig
|   `-- kernel-time-clocksource.c:warning:__clocksource_change_rating-defined-but-not-used
|-- parisc-allnoconfig
|   `-- kernel-time-clocksource.c:warning:__clocksource_change_rating-defined-but-not-used
|-- parisc-allyesconfig
|   `-- kernel-time-clocksource.c:warning:__clocksource_change_rating-defined-but-not-used
|-- parisc-defconfig
|   `-- kernel-time-clocksource.c:warning:__clocksource_change_rating-defined-but-not-used
|-- powerpc-allmodconfig
|   `-- kernel-time-clocksource.c:warning:__clocksource_change_rating-defined-but-not-used
|-- powerpc-allnoconfig
|   `-- kernel-time-clocksource.c:warning:__clocksource_change_rating-defined-but-not-used
|-- powerpc-tqm8540_defconfig
|   `-- kernel-time-clocksource.c:warning:__clocksource_change_rating-defined-but-not-used
|-- riscv-allnoconfig
|   `-- kernel-time-clocksource.c:warning:__clocksource_change_rating-defined-but-not-used
|-- riscv-nommu_k210_sdcard_defconfig
|   `-- kernel-time-clocksource.c:warning:__clocksource_change_rating-defined-but-not-used
|-- s390-allyesconfig
|   `-- kernel-time-clocksource.c:warning:__clocksource_change_rating-defined-but-not-used
|-- sh-allmodconfig
|   `-- kernel-time-clocksource.c:warning:__clocksource_change_rating-defined-but-not-used
|-- sh-allnoconfig
|   `-- kernel-time-clocksource.c:warning:__clocksource_change_rating-defined-but-not-used
|-- sh-allyesconfig
|   `-- kernel-time-clocksource.c:warning:__clocksource_change_rating-defined-but-not-used
|-- sh-defconfig
|   `-- kernel-time-clocksource.c:warning:__clocksource_change_rating-defined-but-not-used
|-- sh-polaris_defconfig
|   `-- kernel-time-clocksource.c:warning:__clocksource_change_rating-defined-but-not-used
|-- sparc-allmodconfig
|   `-- kernel-time-clocksource.c:warning:__clocksource_change_rating-defined-but-not-used
|-- sparc-allnoconfig
|   `-- kernel-time-clocksource.c:warning:__clocksource_change_rating-defined-but-not-used
|-- sparc-allyesconfig
|   `-- kernel-time-clocksource.c:warning:__clocksource_change_rating-defined-but-not-used
|-- sparc64-defconfig
|   `-- kernel-time-clocksource.c:warning:__clocksource_change_rating-defined-but-not-used
|-- um-i386_defconfig
|   `-- kernel-time-clocksource.c:warning:__clocksource_change_rating-defined-but-not-used
|-- xtensa-allnoconfig
|   `-- kernel-time-clocksource.c:warning:__clocksource_change_rating-defined-but-not-used
|-- xtensa-allyesconfig
|   `-- kernel-time-clocksource.c:warning:__clocksource_change_rating-defined-but-not-used
`-- xtensa-randconfig-r071-20241010
    `-- kernel-time-clocksource.c:warning:__clocksource_change_rating-defined-but-not-used

elapsed time: 1746m

configs tested: 114
configs skipped: 3

tested configs:
alpha                             allnoconfig    gcc-13.3.0
alpha                            allyesconfig    gcc-13.3.0
alpha                               defconfig    gcc-13.3.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-13.2.0
arc                   randconfig-001-20241010    gcc-13.2.0
arc                   randconfig-002-20241010    gcc-13.2.0
arm                               allnoconfig    clang-20
arm                              allyesconfig    gcc-14.1.0
arm                       omap2plus_defconfig    gcc-14.1.0
arm                   randconfig-001-20241010    clang-20
arm                   randconfig-002-20241010    clang-20
arm                   randconfig-003-20241010    clang-20
arm                        shmobile_defconfig    gcc-14.1.0
arm                         socfpga_defconfig    gcc-14.1.0
arm                          sp7021_defconfig    gcc-14.1.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                 randconfig-001-20241010    clang-20
arm64                 randconfig-002-20241010    clang-20
csky                              allnoconfig    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                          allyesconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241010    clang-18
i386        buildonly-randconfig-002-20241010    clang-18
i386        buildonly-randconfig-003-20241010    clang-18
i386        buildonly-randconfig-004-20241010    gcc-12
i386        buildonly-randconfig-005-20241010    clang-18
i386        buildonly-randconfig-006-20241010    clang-18
i386                                defconfig    clang-18
i386                  randconfig-001-20241010    clang-18
i386                  randconfig-002-20241010    clang-18
i386                  randconfig-003-20241010    gcc-12
i386                  randconfig-004-20241010    clang-18
i386                  randconfig-005-20241010    clang-18
i386                  randconfig-006-20241010    clang-18
i386                  randconfig-011-20241010    gcc-12
i386                  randconfig-012-20241010    clang-18
i386                  randconfig-013-20241010    gcc-12
i386                  randconfig-014-20241010    clang-18
i386                  randconfig-015-20241010    clang-18
i386                  randconfig-016-20241010    clang-18
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                       m5249evb_defconfig    gcc-14.1.0
m68k                        m5407c3_defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                         cobalt_defconfig    gcc-13.2.0
mips                  decstation_64_defconfig    gcc-13.2.0
mips                      pic32mzda_defconfig    gcc-13.2.0
nios2                             allnoconfig    gcc-14.1.0
openrisc                          allnoconfig    gcc-14.1.0
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-14.1.0
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    gcc-14.1.0
parisc                              defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    gcc-14.1.0
powerpc                          allyesconfig    clang-20
powerpc                      cm5200_defconfig    clang-20
powerpc                     tqm8540_defconfig    gcc-14.1.0
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    gcc-14.1.0
riscv                            allyesconfig    clang-20
riscv                               defconfig    clang-20
riscv             nommu_k210_sdcard_defconfig    gcc-14.1.0
s390                             allmodconfig    clang-20
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    clang-20
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-14.1.0
sh                          polaris_defconfig    gcc-14.1.0
sh                   sh7724_generic_defconfig    gcc-14.1.0
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-14.1.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                               allyesconfig    gcc-12
um                                  defconfig    clang-20
um                             i386_defconfig    gcc-12
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64      buildonly-randconfig-001-20241010    gcc-12
x86_64      buildonly-randconfig-002-20241010    clang-18
x86_64      buildonly-randconfig-004-20241010    gcc-12
x86_64      buildonly-randconfig-005-20241010    clang-18
x86_64      buildonly-randconfig-006-20241010    clang-18
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-18
x86_64                randconfig-001-20241010    clang-18
x86_64                randconfig-002-20241010    gcc-12
x86_64                randconfig-003-20241010    clang-18
x86_64                randconfig-004-20241010    gcc-12
x86_64                randconfig-005-20241010    clang-18
x86_64                               rhel-8.3    gcc-12
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

