Return-Path: <linux-kernel+bounces-280778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7013C94CF0D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 12:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 287B928461C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 10:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F928191F9F;
	Fri,  9 Aug 2024 10:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hXsYNMju"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBC917993
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 10:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723201075; cv=none; b=XkdivWxFXI7J8J71/p/oBClc2mXb0VIcfu5vwk4PFWKAvkFgoqviI6SG81T+QTsB4Wky3Bzveghw9ZKCMPRu3/e0qGMHZh0aZn/ZaxmkobvVzpE368x3xHKhrc5QqAuWULbt5glIILZ866n64ddt4DtP84apwKuixR26SzuhhyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723201075; c=relaxed/simple;
	bh=YhOKLTwMCfHFUKmf6dTJFdeBwKLqcOZW3XVC6fUQ/y8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=He0MG84vGy+YFGhFtrHvOBjdbyoXjsBB/bw3JGFVpK8jbHQasaiRNNx88JKbo6XVztIfsCICMcDQTBRTM5RrVhKvawS8JljmvBamHyBrEeC6glMc28JbZoLAOZHyVhp0Qm8H5Jy1LdJ880vZGMdZQ8FTPCj/roHVjxhjWAUrN34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hXsYNMju; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723201073; x=1754737073;
  h=date:from:to:cc:subject:message-id;
  bh=YhOKLTwMCfHFUKmf6dTJFdeBwKLqcOZW3XVC6fUQ/y8=;
  b=hXsYNMjuZzcsidJcXbyXzXQxm7XQwvsIwr5SE3SIgJaA1pjIRAdNvw5e
   Ryp3hZLesm5AUz60DXGPa74sxJZLbiY1jEYqmZjlABwzryORWMcHdq84y
   5HTfyOU5lWRf3Ts99pR5rzpbCJPm+37f2eOBM8U1AIeomtkYDQFxaPkhe
   jWf34Xh8H1TH9FbS+urJ1Cgm1+NrCSQ/F8vLYHFjxSHa13QfqFnMYYEfW
   gte1fuymjyjZK9dyEg9GA87DR8j7zT7r/duy+PjSzHnbPUFv40HsL4XTa
   R7zeOymTivVCrDgFA2jj2g85Kzq8lAoqndkVXvUbWk6IfSwk1J+sXq76n
   Q==;
X-CSE-ConnectionGUID: 7NbmAPLtQLOVypKhly8JSA==
X-CSE-MsgGUID: xyiHPaFoRTCyVxriWkffmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="21544421"
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="21544421"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 03:57:52 -0700
X-CSE-ConnectionGUID: 6zgwZUX3QiO737yqB+hIBQ==
X-CSE-MsgGUID: 60EQe2RrQM2ieoUwI5Va8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="57195010"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 09 Aug 2024 03:57:51 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1scNJd-0007ps-2P;
	Fri, 09 Aug 2024 10:57:49 +0000
Date: Fri, 09 Aug 2024 18:57:46 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:perf/core] BUILD SUCCESS
 3e15a3fe3a2a170c5be52783667706875c088f96
Message-ID: <202408091843.SJsPqp4w-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core
branch HEAD: 3e15a3fe3a2a170c5be52783667706875c088f96  perf: Optimize __pmu_ctx_sched_out()

elapsed time: 1451m

configs tested: 187
configs skipped: 7

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
arm                            mmp2_defconfig   clang-15
arm                          moxart_defconfig   clang-15
arm                   randconfig-001-20240809   gcc-13.2.0
arm                   randconfig-002-20240809   gcc-13.2.0
arm                   randconfig-003-20240809   gcc-13.2.0
arm                   randconfig-004-20240809   gcc-13.2.0
arm                         s3c6400_defconfig   clang-15
arm                       spear13xx_defconfig   clang-15
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
mips                           ip32_defconfig   clang-15
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
riscv                 randconfig-001-20240809   gcc-13.2.0
riscv                 randconfig-002-20240809   gcc-13.2.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240809   gcc-13.2.0
s390                  randconfig-002-20240809   gcc-13.2.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                    randconfig-001-20240809   gcc-13.2.0
sh                    randconfig-002-20240809   gcc-13.2.0
sparc                            allmodconfig   gcc-14.1.0
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

