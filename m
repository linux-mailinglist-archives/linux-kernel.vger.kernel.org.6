Return-Path: <linux-kernel+bounces-371350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9926A9A39E7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 11:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5578D2832F7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 09:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA331EE030;
	Fri, 18 Oct 2024 09:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZO5G4gIS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1CB15666D
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 09:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729243465; cv=none; b=Yb/396Hao2iM8W4OdRxfY72JCMd6zOpdnVz49osxW0wj9cfX2Ekof+O3A4jfJYWFhztBHortSn5+DSXK6632OSLMT/XazEeN0czrjVUbyzdhHnoygakrtMJ7KenQGCGB14OsjLrNp+yxBLfjoN0mfFunzHAVvxOQcmkKP3zuY3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729243465; c=relaxed/simple;
	bh=EkG4dwDI4cY9qUX9+lIbVIMRj/UJZ/aaTDOEnv6OmNU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=eOTqXi6YsrPnKyrdE/O1bUDgLXDQZ5mpj2gmmaItnhCtWXb+zqoCclzXrGs5VLgkX1D569SP+KtZ4wp0Jceq5+RC6V0azjcsegf7R4vpTKDwjKOwu8FPWWTwIfhGGhVpO/OBIbWGNsiUBWELr59OVHoEParf08ZlEj/w6iPEGmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZO5G4gIS; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729243463; x=1760779463;
  h=date:from:to:cc:subject:message-id;
  bh=EkG4dwDI4cY9qUX9+lIbVIMRj/UJZ/aaTDOEnv6OmNU=;
  b=ZO5G4gISmB06sPDv2DbssYUgDCmiWjZQW/v66IJ72mzYfYLDG/1uYIPg
   4ZC5moQ+HdC/XYr2s0IOTCJojB9I+w6I9CvWBhjAt+5wItzfDIVyDEhZz
   FPRhJn0xyp7JZ82mP0ZA7UwRZuBChCX6TxcOcbumMOkRTmm7f298LV7rJ
   mqn35P0Kh1+g9GzWh46AIm+U8yw+j6fw/sI/03BIIRpPqxSJBoelfo6nP
   hs/Smf1yydUT0EtItGYXTvtUUYBaN0weiY//6NgfwRJAHHu+qoBVvf0EJ
   ALECp6o7FbdFdr1bD+z5TvgBy/EN3KlTjWv9rNQwb4DZN1u3LMEK8x3Ua
   w==;
X-CSE-ConnectionGUID: dj49ao3yRS6g9Jyl0YETAA==
X-CSE-MsgGUID: ZrgAPHhPRq2tqcXeTxlzKA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28643382"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28643382"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 02:24:23 -0700
X-CSE-ConnectionGUID: JMj/sBisTCKkqytE8tnF4w==
X-CSE-MsgGUID: C6ZLxh2gQRWTl0J5yVtk3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; 
   d="scan'208";a="79160787"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 18 Oct 2024 02:24:21 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t1jDX-000NY1-2i;
	Fri, 18 Oct 2024 09:24:19 +0000
Date: Fri, 18 Oct 2024 17:23:58 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 bb05949e0918cbe7ff51576563c81c924852e5b7
Message-ID: <202410181750.rZjBDdoJ-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: bb05949e0918cbe7ff51576563c81c924852e5b7  Merge branch into tip/master: 'x86/sev'

elapsed time: 1468m

configs tested: 149
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                                 defconfig    gcc-14.1.0
arc                        nsim_700_defconfig    clang-15
arc                 nsimosci_hs_smp_defconfig    clang-15
arc                 nsimosci_hs_smp_defconfig    gcc-14.1.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                                 defconfig    gcc-14.1.0
arm                          exynos_defconfig    gcc-14.1.0
arm                         mv78xx0_defconfig    clang-15
arm                       versatile_defconfig    gcc-14.1.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
i386                             allmodconfig    clang-18
i386                              allnoconfig    clang-18
i386                             allyesconfig    clang-18
i386        buildonly-randconfig-001-20241018    gcc-11
i386        buildonly-randconfig-002-20241018    gcc-11
i386        buildonly-randconfig-003-20241018    gcc-11
i386        buildonly-randconfig-004-20241018    gcc-11
i386        buildonly-randconfig-005-20241018    gcc-11
i386        buildonly-randconfig-006-20241018    gcc-11
i386                                defconfig    clang-18
i386                  randconfig-001-20241018    gcc-11
i386                  randconfig-002-20241018    gcc-11
i386                  randconfig-003-20241018    gcc-11
i386                  randconfig-004-20241018    gcc-11
i386                  randconfig-005-20241018    gcc-11
i386                  randconfig-006-20241018    gcc-11
i386                  randconfig-011-20241018    gcc-11
i386                  randconfig-012-20241018    gcc-11
i386                  randconfig-013-20241018    gcc-11
i386                  randconfig-014-20241018    gcc-11
i386                  randconfig-015-20241018    gcc-11
i386                  randconfig-016-20241018    gcc-11
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
m68k                        m5272c3_defconfig    gcc-14.1.0
m68k                        stmark2_defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
microblaze                      mmu_defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                  cavium_octeon_defconfig    gcc-14.1.0
mips                           ip30_defconfig    gcc-14.1.0
mips                     loongson1b_defconfig    clang-15
mips                        maltaup_defconfig    clang-15
nios2                            alldefconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.1.0
powerpc                     ep8248e_defconfig    clang-15
powerpc                  iss476-smp_defconfig    gcc-14.1.0
powerpc                     kmeter1_defconfig    clang-15
powerpc                 mpc832x_rdb_defconfig    clang-15
powerpc                      pcm030_defconfig    gcc-14.1.0
powerpc                     redwood_defconfig    gcc-14.1.0
powerpc                     tqm8540_defconfig    clang-15
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                         apsh4a3a_defconfig    clang-15
sh                                  defconfig    gcc-12
sh                            hp6xx_defconfig    gcc-14.1.0
sh                               j2_defconfig    clang-15
sh                     magicpanelr2_defconfig    clang-15
sh                            migor_defconfig    clang-15
sh                          sdk7786_defconfig    clang-15
sh                          sdk7786_defconfig    gcc-14.1.0
sh                           se7751_defconfig    gcc-14.1.0
sh                             sh03_defconfig    clang-15
sh                            shmin_defconfig    clang-15
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64      buildonly-randconfig-001-20241018    clang-18
x86_64      buildonly-randconfig-002-20241018    clang-18
x86_64      buildonly-randconfig-003-20241018    clang-18
x86_64      buildonly-randconfig-004-20241018    clang-18
x86_64      buildonly-randconfig-005-20241018    clang-18
x86_64      buildonly-randconfig-006-20241018    clang-18
x86_64                              defconfig    clang-18
x86_64                                  kexec    clang-18
x86_64                randconfig-001-20241018    clang-18
x86_64                randconfig-002-20241018    clang-18
x86_64                randconfig-003-20241018    clang-18
x86_64                randconfig-004-20241018    clang-18
x86_64                randconfig-005-20241018    clang-18
x86_64                randconfig-006-20241018    clang-18
x86_64                randconfig-011-20241018    clang-18
x86_64                randconfig-012-20241018    clang-18
x86_64                randconfig-013-20241018    clang-18
x86_64                randconfig-014-20241018    clang-18
x86_64                randconfig-015-20241018    clang-18
x86_64                randconfig-016-20241018    clang-18
x86_64                randconfig-071-20241018    clang-18
x86_64                randconfig-072-20241018    clang-18
x86_64                randconfig-073-20241018    clang-18
x86_64                randconfig-074-20241018    clang-18
x86_64                randconfig-075-20241018    clang-18
x86_64                randconfig-076-20241018    clang-18
x86_64                               rhel-8.3    gcc-12
xtensa                            allnoconfig    gcc-14.1.0
xtensa                       common_defconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

