Return-Path: <linux-kernel+bounces-561385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E216A610B0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 13:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93E463BEE79
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 12:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A8D1F4276;
	Fri, 14 Mar 2025 12:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BoRDCgin"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE82C19F42D
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 12:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741954549; cv=none; b=LT3/SbpFw4vIkCbCF0S4Wd3Z8rlmjFqDPs6wMNNE2qDDNfr1aCCYpcuboO+3mheibFvWhrQeayiHHAZe//d9BG9FevmAupXuNvwTGNWh6Tz64jg5tCQuQODbhZyoA1hhbwMZ0ckgua+uTvuCaueIBnmjqP9/AOzZMsJM0pN27Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741954549; c=relaxed/simple;
	bh=sg0oXq6g61nRPIdtjU6nAdQmbdjaIAam3tl5PbvXi98=;
	h=Date:From:To:Cc:Subject:Message-ID; b=DxLRaXKYfqvyXivepR+7QROZHflxIflF0irp5bN92MuxEWKJB6GC5uWADNBqCSZk8Al5QLr2iLIS2TrF4reK+wG+cPoTYDI91u2SwMmemE/nGTjjUDN7JvN90UFeEAopBNg2G6qUHxY1bXLVl1ssMDl2PvJ4TfIA4wKwCbYJ4gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BoRDCgin; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741954548; x=1773490548;
  h=date:from:to:cc:subject:message-id;
  bh=sg0oXq6g61nRPIdtjU6nAdQmbdjaIAam3tl5PbvXi98=;
  b=BoRDCginuuPxPS1ToWOVKjYq4L5kmmqMPUNQZmPGfJpJKe43TfSRDx5C
   5OrQVB0q6t2Kmyt9/3i/sDFABej+LAr1Xsqfqq/KK3WvIRRVw5voWoKKA
   byTOyVNs2sH5FHZQO7EvQT3Hqk8Q/kVi8xa4i6oK7kmSoiXno4onI8Oa1
   30nH27dfnW4jEiRb4oVkZEDXqCPifylDhNhWkH0ABeKB9RzgqrJqdQka8
   3frbQ7o0At6+uIoqJemkCCm3n7hTflxPzpTOYdD6oToPtUe2alaTEBZ4R
   zHQ/42k6H1HxY2jKlXT0cJxhOoBTDWsZZ/tkmMK4P+3g81lB9TmVLneO7
   A==;
X-CSE-ConnectionGUID: 23VkvgFeSGSReYf7WTG2PA==
X-CSE-MsgGUID: abx3zvaPR/2j1S50r0BEVQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="53310148"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="53310148"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 05:15:47 -0700
X-CSE-ConnectionGUID: p6wao9N9QSuHoO51WaYkZg==
X-CSE-MsgGUID: UABQZR9gQru0ky3FssQP9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="121977129"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 14 Mar 2025 05:15:46 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tt3x1-000AR0-2b;
	Fri, 14 Mar 2025 12:15:43 +0000
Date: Fri, 14 Mar 2025 20:15:30 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:timers/core] BUILD SUCCESS
 8e63360d869913265e5e4b623dcd23feff9fd000
Message-ID: <202503142024.nJuPjwa3-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
branch HEAD: 8e63360d869913265e5e4b623dcd23feff9fd000  selftests/timers/posix-timers: Add a test for exact allocation mode

elapsed time: 1448m

configs tested: 242
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-21
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-18
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-18
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-14.2.0
arc                         haps_hs_defconfig    gcc-14.2.0
arc                        nsim_700_defconfig    clang-15
arc                   randconfig-001-20250313    gcc-13.2.0
arc                   randconfig-001-20250314    gcc-14.2.0
arc                   randconfig-002-20250313    gcc-13.2.0
arc                   randconfig-002-20250314    gcc-14.2.0
arm                              alldefconfig    gcc-14.2.0
arm                              allmodconfig    clang-18
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-18
arm                              allyesconfig    gcc-14.2.0
arm                                 defconfig    gcc-14.2.0
arm                       imx_v6_v7_defconfig    gcc-14.2.0
arm                          ixp4xx_defconfig    gcc-14.2.0
arm                   randconfig-001-20250313    clang-16
arm                   randconfig-001-20250314    gcc-14.2.0
arm                   randconfig-002-20250313    clang-18
arm                   randconfig-002-20250314    gcc-14.2.0
arm                   randconfig-003-20250313    gcc-14.2.0
arm                   randconfig-003-20250314    gcc-14.2.0
arm                   randconfig-004-20250313    clang-21
arm                   randconfig-004-20250314    gcc-14.2.0
arm                           sama7_defconfig    clang-15
arm                           stm32_defconfig    gcc-14.2.0
arm                         wpcm450_defconfig    clang-15
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250313    clang-18
arm64                 randconfig-001-20250314    gcc-14.2.0
arm64                 randconfig-002-20250313    clang-16
arm64                 randconfig-002-20250314    gcc-14.2.0
arm64                 randconfig-003-20250313    gcc-14.2.0
arm64                 randconfig-003-20250314    gcc-14.2.0
arm64                 randconfig-004-20250313    clang-21
arm64                 randconfig-004-20250314    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250313    gcc-14.2.0
csky                  randconfig-001-20250314    gcc-14.2.0
csky                  randconfig-002-20250313    gcc-14.2.0
csky                  randconfig-002-20250314    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-18
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20250313    clang-17
hexagon               randconfig-001-20250314    gcc-14.2.0
hexagon               randconfig-002-20250313    clang-21
hexagon               randconfig-002-20250314    gcc-14.2.0
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250313    gcc-12
i386        buildonly-randconfig-001-20250314    gcc-12
i386        buildonly-randconfig-002-20250313    gcc-12
i386        buildonly-randconfig-002-20250314    gcc-12
i386        buildonly-randconfig-003-20250313    clang-19
i386        buildonly-randconfig-003-20250314    gcc-12
i386        buildonly-randconfig-004-20250313    gcc-12
i386        buildonly-randconfig-004-20250314    gcc-12
i386        buildonly-randconfig-005-20250313    clang-19
i386        buildonly-randconfig-005-20250314    gcc-12
i386        buildonly-randconfig-006-20250313    gcc-12
i386        buildonly-randconfig-006-20250314    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20250314    clang-19
i386                  randconfig-002-20250314    clang-19
i386                  randconfig-003-20250314    clang-19
i386                  randconfig-004-20250314    clang-19
i386                  randconfig-005-20250314    clang-19
i386                  randconfig-006-20250314    clang-19
i386                  randconfig-007-20250314    clang-19
i386                  randconfig-011-20250314    gcc-11
i386                  randconfig-012-20250314    gcc-11
i386                  randconfig-013-20250314    gcc-11
i386                  randconfig-014-20250314    gcc-11
i386                  randconfig-015-20250314    gcc-11
i386                  randconfig-016-20250314    gcc-11
i386                  randconfig-017-20250314    gcc-11
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250313    gcc-14.2.0
loongarch             randconfig-001-20250314    gcc-14.2.0
loongarch             randconfig-002-20250313    gcc-14.2.0
loongarch             randconfig-002-20250314    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                           ip22_defconfig    gcc-14.2.0
mips                          rb532_defconfig    gcc-14.2.0
mips                        vocore2_defconfig    clang-15
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250313    gcc-14.2.0
nios2                 randconfig-001-20250314    gcc-14.2.0
nios2                 randconfig-002-20250313    gcc-14.2.0
nios2                 randconfig-002-20250314    gcc-14.2.0
openrisc                          allnoconfig    clang-15
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-15
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250313    gcc-14.2.0
parisc                randconfig-001-20250314    gcc-14.2.0
parisc                randconfig-002-20250313    gcc-14.2.0
parisc                randconfig-002-20250314    gcc-14.2.0
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-15
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                          allyesconfig    gcc-14.2.0
powerpc               randconfig-001-20250313    clang-16
powerpc               randconfig-001-20250314    gcc-14.2.0
powerpc               randconfig-002-20250313    clang-18
powerpc               randconfig-002-20250314    gcc-14.2.0
powerpc               randconfig-003-20250313    gcc-14.2.0
powerpc               randconfig-003-20250314    gcc-14.2.0
powerpc                    socrates_defconfig    clang-15
powerpc64                        alldefconfig    clang-15
powerpc64             randconfig-001-20250313    gcc-14.2.0
powerpc64             randconfig-001-20250314    gcc-14.2.0
powerpc64             randconfig-002-20250313    gcc-14.2.0
powerpc64             randconfig-002-20250314    gcc-14.2.0
powerpc64             randconfig-003-20250313    gcc-14.2.0
powerpc64             randconfig-003-20250314    gcc-14.2.0
riscv                            allmodconfig    clang-21
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-15
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-21
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250313    clang-21
riscv                 randconfig-001-20250314    gcc-14.2.0
riscv                 randconfig-002-20250313    clang-21
riscv                 randconfig-002-20250314    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250313    clang-15
s390                  randconfig-001-20250314    gcc-14.2.0
s390                  randconfig-002-20250313    clang-15
s390                  randconfig-002-20250314    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250313    gcc-14.2.0
sh                    randconfig-001-20250314    gcc-14.2.0
sh                    randconfig-002-20250313    gcc-14.2.0
sh                    randconfig-002-20250314    gcc-14.2.0
sh                           se7619_defconfig    clang-15
sh                           se7780_defconfig    clang-15
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250313    gcc-14.2.0
sparc                 randconfig-001-20250314    gcc-14.2.0
sparc                 randconfig-002-20250313    gcc-14.2.0
sparc                 randconfig-002-20250314    gcc-14.2.0
sparc                       sparc64_defconfig    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250313    gcc-14.2.0
sparc64               randconfig-001-20250314    gcc-14.2.0
sparc64               randconfig-002-20250313    gcc-14.2.0
sparc64               randconfig-002-20250314    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-15
um                                allnoconfig    clang-18
um                               allyesconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250313    clang-21
um                    randconfig-001-20250314    gcc-14.2.0
um                    randconfig-002-20250313    clang-21
um                    randconfig-002-20250314    gcc-14.2.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250313    clang-19
x86_64      buildonly-randconfig-001-20250314    gcc-12
x86_64      buildonly-randconfig-002-20250313    clang-19
x86_64      buildonly-randconfig-002-20250314    gcc-12
x86_64      buildonly-randconfig-003-20250313    clang-19
x86_64      buildonly-randconfig-003-20250314    gcc-12
x86_64      buildonly-randconfig-004-20250313    gcc-12
x86_64      buildonly-randconfig-004-20250314    gcc-12
x86_64      buildonly-randconfig-005-20250313    clang-19
x86_64      buildonly-randconfig-005-20250314    gcc-12
x86_64      buildonly-randconfig-006-20250313    gcc-12
x86_64      buildonly-randconfig-006-20250314    gcc-12
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20250314    clang-19
x86_64                randconfig-002-20250314    clang-19
x86_64                randconfig-003-20250314    clang-19
x86_64                randconfig-004-20250314    clang-19
x86_64                randconfig-005-20250314    clang-19
x86_64                randconfig-006-20250314    clang-19
x86_64                randconfig-007-20250314    clang-19
x86_64                randconfig-008-20250314    clang-19
x86_64                randconfig-071-20250314    clang-19
x86_64                randconfig-072-20250314    clang-19
x86_64                randconfig-073-20250314    clang-19
x86_64                randconfig-074-20250314    clang-19
x86_64                randconfig-075-20250314    clang-19
x86_64                randconfig-076-20250314    clang-19
x86_64                randconfig-077-20250314    clang-19
x86_64                randconfig-078-20250314    clang-19
x86_64                               rhel-9.4    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250313    gcc-14.2.0
xtensa                randconfig-001-20250314    gcc-14.2.0
xtensa                randconfig-002-20250313    gcc-14.2.0
xtensa                randconfig-002-20250314    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

