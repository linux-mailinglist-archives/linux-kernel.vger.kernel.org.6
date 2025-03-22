Return-Path: <linux-kernel+bounces-572595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 706B1A6CBFA
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 20:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEA22462A46
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 19:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47185204584;
	Sat, 22 Mar 2025 19:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c//He83t"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD54A4C6C
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 19:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742670800; cv=none; b=aq9NfXPKs1Jm4iD6XbOyQoMfsa1rRkbI6qMis9FKWFe3XdDaC9FdTYMBDDyxEpPD/MtGlsfxfWexcA92kpy2/t6+nkDhDVyJqgPTU0D6tQnMst5HAlUgAE/LcY/PCftshRZT2eY0tSKeuXohCESQywR4oWtSBgH6KPKcGQJOCEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742670800; c=relaxed/simple;
	bh=/VYCh2z+M9uqZGO2z6Eutoe6NLYf208teXmt3R0zrzE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=tIFPtJXIP6Lv7F5lPARnWi//H4MltEDmwgijyRjsy930+4Wj73ZXUP14cMBGvHbx0fs74qzoWrwGkzIKQg0X00pt3s2pV98Iy+dinB+PgyLmTYjEGbXkPJrJ8knLNkUVSwSc/ifmdKUOONQwCkzTuJTw+7xW+fAQUfU/R+YOoaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c//He83t; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742670798; x=1774206798;
  h=date:from:to:cc:subject:message-id;
  bh=/VYCh2z+M9uqZGO2z6Eutoe6NLYf208teXmt3R0zrzE=;
  b=c//He83t//yx4NuwiKZ+K3e29xxM2gjMzQV8s5lu2IRoYlaKuaVMDt2y
   MJSuolljpCZH6WprXhBxLC2ADQw+/448YVgzP9LOKDxv9Q9pdQ/gKwT1x
   ANOvohlVO89phB2T1BCJj1KPAaN5FeJU89comAy1Vi8rXLCiN/eR8HoiL
   0CuWe0pPq5ERQkD1BxxmOvLvRBs179ZRNOs04fZ14U8VudBl0NhXcU//a
   TPUorUzUi7Iwu9tW78rGPLJZCHjhC99t9IWMQT4rwBbydIMTbPEsgwn9y
   BCoJB9AsQ5j/8dJLpHllANsv4biIEufiMu42v0dOHfcsmYJoJcW/cG1z0
   w==;
X-CSE-ConnectionGUID: qjVGIYx4QEeHt7SxUcGdlw==
X-CSE-MsgGUID: gHLsxQAyQEOglzRQ6WiTug==
X-IronPort-AV: E=McAfee;i="6700,10204,11381"; a="46659581"
X-IronPort-AV: E=Sophos;i="6.14,268,1736841600"; 
   d="scan'208";a="46659581"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2025 12:13:18 -0700
X-CSE-ConnectionGUID: JDHg6AZNRYGyUZzY1d+Z6Q==
X-CSE-MsgGUID: HtLQBk7qTTWSQMn7sLFPSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,268,1736841600"; 
   d="scan'208";a="127824034"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 22 Mar 2025 12:13:17 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tw4HN-0002Lx-0N;
	Sat, 22 Mar 2025 19:13:10 +0000
Date: Sun, 23 Mar 2025 03:12:05 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:timers/core] BUILD SUCCESS
 e40d3709c0225f5f681fd300f65a65ac63b10f83
Message-ID: <202503230359.hstWBcn6-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
branch HEAD: e40d3709c0225f5f681fd300f65a65ac63b10f83  selftests/timers: Improve skew_consistency by testing with other clockids

elapsed time: 1443m

configs tested: 117
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-14.2.0
arc                   randconfig-001-20250322    gcc-10.5.0
arc                   randconfig-002-20250322    gcc-8.5.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-14.2.0
arm                   randconfig-001-20250322    gcc-7.5.0
arm                   randconfig-002-20250322    gcc-7.5.0
arm                   randconfig-003-20250322    clang-21
arm                   randconfig-004-20250322    clang-19
arm                           sama7_defconfig    clang-21
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250322    clang-21
arm64                 randconfig-002-20250322    clang-21
arm64                 randconfig-003-20250322    gcc-8.5.0
arm64                 randconfig-004-20250322    clang-21
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250322    gcc-14.2.0
csky                  randconfig-002-20250322    gcc-14.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250322    clang-21
hexagon               randconfig-002-20250322    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250322    clang-20
i386        buildonly-randconfig-002-20250322    gcc-12
i386        buildonly-randconfig-003-20250322    gcc-12
i386        buildonly-randconfig-004-20250322    clang-20
i386        buildonly-randconfig-005-20250322    clang-20
i386        buildonly-randconfig-006-20250322    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250322    gcc-14.2.0
loongarch             randconfig-002-20250322    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                        m5307c3_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                           jazz_defconfig    clang-17
mips                           xway_defconfig    clang-21
nios2                         10m50_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250322    gcc-6.5.0
nios2                 randconfig-002-20250322    gcc-10.5.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250322    gcc-5.5.0
parisc                randconfig-002-20250322    gcc-13.3.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                   bluestone_defconfig    clang-21
powerpc                      ep88xc_defconfig    gcc-14.2.0
powerpc                    ge_imp3a_defconfig    gcc-14.2.0
powerpc                      katmai_defconfig    clang-21
powerpc               randconfig-001-20250322    clang-21
powerpc               randconfig-002-20250322    gcc-8.5.0
powerpc               randconfig-003-20250322    clang-21
powerpc64             randconfig-001-20250322    clang-21
powerpc64             randconfig-002-20250322    gcc-8.5.0
powerpc64             randconfig-003-20250322    gcc-8.5.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                 randconfig-001-20250322    gcc-8.5.0
riscv                 randconfig-002-20250322    clang-21
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250322    gcc-9.3.0
s390                  randconfig-002-20250322    gcc-6.5.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250322    gcc-10.5.0
sh                    randconfig-002-20250322    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250322    gcc-9.3.0
sparc                 randconfig-002-20250322    gcc-9.3.0
sparc64               randconfig-001-20250322    gcc-5.5.0
sparc64               randconfig-002-20250322    gcc-5.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                    randconfig-001-20250322    clang-21
um                    randconfig-002-20250322    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250322    clang-20
x86_64      buildonly-randconfig-002-20250322    clang-20
x86_64      buildonly-randconfig-003-20250322    clang-20
x86_64      buildonly-randconfig-004-20250322    gcc-12
x86_64      buildonly-randconfig-005-20250322    clang-20
x86_64      buildonly-randconfig-006-20250322    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250322    gcc-14.2.0
xtensa                randconfig-002-20250322    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

