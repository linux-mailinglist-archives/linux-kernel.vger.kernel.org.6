Return-Path: <linux-kernel+bounces-436252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 778B89E8347
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 04:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51E10165641
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 03:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99FCB171A7;
	Sun,  8 Dec 2024 03:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mFrnc8K8"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF1956446
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 03:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733627050; cv=none; b=gQgdazeysKCEFu6w1mROwMnSmYaCD81G1VD695KprPp7v0mOmnl+fg7lshOjQXuMSToR81tG9oGCLuFqPtzGrj7jGhPh8wo2wmUtgAcC01pm4u3ymLFziC6wdDATarjbZl+vSrqrzZXzGOVPty+CihaIZGOzV0AyStaVyMQ/ne8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733627050; c=relaxed/simple;
	bh=jxfRgSXLibC/js8OF5+rSs+sBV811ZlvoyNJeBDJuL8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=PQht4Ql776nHyQQyo4t+P1yvGJTUXBwuZzKOQ443P7nJN74j1NtBpneOuV/SmWn/0lxEkgczxq3vsNa7NMlkAY3KyJdL946F+uOYJuyRmN+CY41wo6ObWFtQMFyccXDRPv/FEg5PDEwQWfy2OYoZ8uJ1I6XE4GzNjxzzHWEFkjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mFrnc8K8; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733627048; x=1765163048;
  h=date:from:to:cc:subject:message-id;
  bh=jxfRgSXLibC/js8OF5+rSs+sBV811ZlvoyNJeBDJuL8=;
  b=mFrnc8K8q6X3mMGdcJQWrVBfbrS2yJGp8zdHVLMJJGA83YQm17xWn/YI
   wUA8qj588/ciECF3u81Z6ZW8CDHcpUzFXfbS3vVlDz4Z4VQq7sj8hoHEY
   FxwZckob5owlEoRTuh03V7zalgyyhzkV4pJzPMDyElHPTl3YORuI0pQ76
   0pbqRTYcEo8+GdiHFGDEEQDwY45+xiOtMU37ldS4zNuyn50BAR7FnaCX6
   BuD6r4dQ4AG78LrMT0d5R7Vpew2TLofxnPyqvdnkUK942lMZQZcOBjENg
   INTigwJJMI0qkzWwMFtlQ/ZwUJ/6DhpxJa50tnvAQKZwVa2NkJET8tchN
   w==;
X-CSE-ConnectionGUID: iHVydcChRXWvYBUP3fNd/g==
X-CSE-MsgGUID: k7+bNKkoT2ehR04vgEqYgA==
X-IronPort-AV: E=McAfee;i="6700,10204,11279"; a="34093208"
X-IronPort-AV: E=Sophos;i="6.12,216,1728975600"; 
   d="scan'208";a="34093208"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2024 19:04:08 -0800
X-CSE-ConnectionGUID: 0Je2KJjPQY2n75QencD4gA==
X-CSE-MsgGUID: dBUttoT4QdidI6IhI/s5yQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="99790953"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 07 Dec 2024 19:04:06 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tK7aV-00036P-1C;
	Sun, 08 Dec 2024 03:04:03 +0000
Date: Sun, 08 Dec 2024 11:00:36 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:locking/urgent] BUILD SUCCESS
 b4d83c8323b0c4a899a996fed919cfe10720d289
Message-ID: <202412081126.MGtxTWG9-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/urgent
branch HEAD: b4d83c8323b0c4a899a996fed919cfe10720d289  headers/cleanup.h: Remove the if_not_guard() facility

elapsed time: 939m

configs tested: 210
configs skipped: 13

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    clang-20
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-18
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-18
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-14.2.0
arc                            hsdk_defconfig    gcc-13.2.0
arc                   randconfig-001-20241207    gcc-13.2.0
arc                   randconfig-002-20241207    gcc-13.2.0
arm                              allmodconfig    clang-18
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-18
arm                              allyesconfig    gcc-14.2.0
arm                                 defconfig    gcc-14.2.0
arm                          ep93xx_defconfig    clang-20
arm                       multi_v4t_defconfig    clang-18
arm                       multi_v4t_defconfig    clang-20
arm                        multi_v5_defconfig    clang-18
arm                        multi_v7_defconfig    gcc-14.2.0
arm                            qcom_defconfig    clang-15
arm                   randconfig-001-20241207    gcc-14.2.0
arm                   randconfig-002-20241207    gcc-14.2.0
arm                   randconfig-003-20241207    clang-19
arm                   randconfig-004-20241207    clang-20
arm                         socfpga_defconfig    gcc-14.2.0
arm                       versatile_defconfig    clang-18
arm                         vf610m4_defconfig    clang-17
arm                         wpcm450_defconfig    clang-20
arm64                            alldefconfig    clang-20
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20241207    gcc-14.2.0
arm64                 randconfig-002-20241207    gcc-14.2.0
arm64                 randconfig-003-20241207    clang-20
arm64                 randconfig-004-20241207    clang-15
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20241207    gcc-14.2.0
csky                  randconfig-002-20241207    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-18
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20241207    clang-14
hexagon               randconfig-002-20241207    clang-16
i386                             allmodconfig    clang-19
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-19
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-19
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241207    clang-19
i386        buildonly-randconfig-002-20241207    clang-19
i386        buildonly-randconfig-003-20241207    gcc-12
i386        buildonly-randconfig-004-20241207    clang-19
i386        buildonly-randconfig-005-20241207    clang-19
i386        buildonly-randconfig-006-20241207    clang-19
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch                 loongson3_defconfig    gcc-14.2.0
loongarch             randconfig-001-20241207    gcc-14.2.0
loongarch             randconfig-002-20241207    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                          atari_defconfig    clang-20
m68k                                defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          ath79_defconfig    gcc-14.2.0
mips                        bcm47xx_defconfig    clang-20
mips                      bmips_stb_defconfig    clang-18
mips                            gpr_defconfig    clang-20
mips                           ip22_defconfig    clang-15
mips                           ip22_defconfig    clang-18
mips                           ip28_defconfig    clang-18
mips                           jazz_defconfig    clang-18
mips                        maltaup_defconfig    clang-17
mips                          rb532_defconfig    clang-17
mips                        vocore2_defconfig    clang-15
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20241207    gcc-14.2.0
nios2                 randconfig-002-20241207    gcc-14.2.0
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20241207    gcc-14.2.0
parisc                randconfig-002-20241207    gcc-14.2.0
parisc64                            defconfig    gcc-14.2.0
powerpc                     akebono_defconfig    clang-17
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                          allyesconfig    gcc-14.2.0
powerpc                      bamboo_defconfig    clang-20
powerpc                 canyonlands_defconfig    clang-18
powerpc                        cell_defconfig    gcc-14.2.0
powerpc                      cm5200_defconfig    clang-20
powerpc                       holly_defconfig    clang-20
powerpc                      mgcoge_defconfig    clang-18
powerpc                      mgcoge_defconfig    clang-20
powerpc                 mpc8315_rdb_defconfig    clang-20
powerpc                  mpc885_ads_defconfig    clang-20
powerpc                    mvme5100_defconfig    clang-15
powerpc                      pasemi_defconfig    clang-20
powerpc               randconfig-001-20241207    gcc-14.2.0
powerpc               randconfig-002-20241207    clang-20
powerpc               randconfig-003-20241207    clang-15
powerpc                     stx_gp3_defconfig    clang-20
powerpc                     tqm8555_defconfig    clang-15
powerpc64                        alldefconfig    clang-18
powerpc64             randconfig-001-20241207    gcc-14.2.0
powerpc64             randconfig-002-20241207    clang-19
powerpc64             randconfig-003-20241207    clang-17
riscv                            allmodconfig    clang-20
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    clang-19
riscv                               defconfig    clang-20
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20241208    gcc-14.2.0
riscv                 randconfig-002-20241208    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                                defconfig    gcc-12
s390                  randconfig-001-20241208    gcc-14.2.0
s390                  randconfig-002-20241208    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                         ap325rxa_defconfig    clang-17
sh                                  defconfig    gcc-12
sh                                  defconfig    gcc-14.2.0
sh                        edosk7760_defconfig    gcc-14.2.0
sh                             espt_defconfig    clang-18
sh                          r7780mp_defconfig    clang-15
sh                    randconfig-001-20241208    gcc-14.2.0
sh                    randconfig-002-20241208    gcc-14.2.0
sh                          sdk7780_defconfig    clang-18
sh                           se7712_defconfig    clang-20
sh                           se7724_defconfig    gcc-14.2.0
sh                   sh7724_generic_defconfig    gcc-14.2.0
sparc                            alldefconfig    clang-18
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20241208    gcc-14.2.0
sparc                 randconfig-002-20241208    gcc-14.2.0
sparc64                          alldefconfig    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20241208    gcc-14.2.0
sparc64               randconfig-002-20241208    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-18
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                               allyesconfig    gcc-12
um                                  defconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241208    gcc-14.2.0
um                    randconfig-002-20241208    gcc-14.2.0
um                           x86_64_defconfig    clang-15
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241207    clang-19
x86_64      buildonly-randconfig-002-20241207    clang-19
x86_64      buildonly-randconfig-003-20241207    gcc-11
x86_64      buildonly-randconfig-004-20241207    clang-19
x86_64      buildonly-randconfig-005-20241207    clang-19
x86_64      buildonly-randconfig-006-20241207    gcc-12
x86_64                              defconfig    clang-19
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                       common_defconfig    clang-20
xtensa                generic_kc705_defconfig    clang-18
xtensa                randconfig-001-20241208    gcc-14.2.0
xtensa                randconfig-002-20241208    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

