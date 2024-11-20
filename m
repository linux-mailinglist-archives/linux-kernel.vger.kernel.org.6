Return-Path: <linux-kernel+bounces-415787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B79B9D3C70
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 14:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4EA81F21C31
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 13:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B7D1A0B13;
	Wed, 20 Nov 2024 13:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dWR9kZDh"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B5E19F487
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 13:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732108651; cv=none; b=iCBHu3DD+QeA5dY8vz4uk4TsOflidFrmVX+oA3Q+dDE3Gv92wTlf7raFAb7tTcbPsbklLIVeqq85rELD5+EXHeMsaC5EDh9WzAnk4AWx5iQhHQEiK/+ImFJogzuuJcXsHNCc2tkVPWBw0lOykwf4H1G6esEfsJSr8oqcVda0CAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732108651; c=relaxed/simple;
	bh=T3WtOUxQhoVRYnYa4sWWrHwEs/w2Cnwd5wxF2JP2EcY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=GxejN5mFzX352aXLFXqXCuddRs2KoOOUuKuxAAIQePhY4M/Zm9pUVDci5MtKb+titB7Nn1mqxGH3z251USCiX1icYfZ0kBvYwtSkzjLMbG7tjrjknKzbxX5OH/9NdjjReM5B7h7R1/JttRP3uEpbCk1K1xVNvY9BHPkGubQ5Hbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dWR9kZDh; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732108650; x=1763644650;
  h=date:from:to:cc:subject:message-id;
  bh=T3WtOUxQhoVRYnYa4sWWrHwEs/w2Cnwd5wxF2JP2EcY=;
  b=dWR9kZDh6tpfqB5gAe4EoXQr8/p8Pc4hQYFGZv5dGZkbkEd/1OSGADbo
   1oFoLOxgcD0iOTErCWWLvUl3lKqDFp3aUwQT5VzL5Jl3R8uXhxohdXyDD
   maZ61Cq4H2los+pkPO22paSNbF7vaTJ34clewwb3f8GVKo5dNrZNdDIkk
   tZqC8qEdgAWrZWB8+lfquQXgpV7f4DvjMGtcyKYbV8/wvY75QTf+KNQjn
   x/vADWZd+7ZqUJsp8lriNUkReB4aOnfHAM6SsmNSRAyqb+x5NRogkPqLF
   Yl4NMKGgrtlYiJiep8ISPxsogpIkcfOLnjNaL7CVUV1vstMbf/ZjVOBBN
   g==;
X-CSE-ConnectionGUID: 6z2TenymTDOwJPqX591LbQ==
X-CSE-MsgGUID: ZQc8uzHGTrKEWVzBdREA2g==
X-IronPort-AV: E=McAfee;i="6700,10204,11262"; a="49592735"
X-IronPort-AV: E=Sophos;i="6.12,169,1728975600"; 
   d="scan'208";a="49592735"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2024 05:17:29 -0800
X-CSE-ConnectionGUID: H+dpVCJ4RmuHcdBLauSiEw==
X-CSE-MsgGUID: Cs/AeNq9TD2SJMXOnijDLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,169,1728975600"; 
   d="scan'208";a="89864597"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 20 Nov 2024 05:14:50 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tDkXf-0000sr-2A;
	Wed, 20 Nov 2024 13:14:47 +0000
Date: Wed, 20 Nov 2024 21:13:44 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:perf/core] BUILD SUCCESS
 faac6f105ef169e2e5678c14e1ffebf2a7d780b6
Message-ID: <202411202128.Pk1ByGGy-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core
branch HEAD: faac6f105ef169e2e5678c14e1ffebf2a7d780b6  perf/core: Check sample_type in perf_sample_save_brstack

elapsed time: 726m

configs tested: 146
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-13.2.0
arc                   randconfig-001-20241120    gcc-13.2.0
arc                   randconfig-002-20241120    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-20
arm                              allyesconfig    gcc-14.2.0
arm                                 defconfig    clang-14
arm                        neponset_defconfig    gcc-14.2.0
arm                       omap2plus_defconfig    gcc-14.2.0
arm                            qcom_defconfig    clang-20
arm                   randconfig-001-20241120    clang-20
arm                   randconfig-002-20241120    clang-20
arm                   randconfig-003-20241120    gcc-14.2.0
arm                   randconfig-004-20241120    gcc-14.2.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20241120    gcc-14.2.0
arm64                 randconfig-002-20241120    clang-17
arm64                 randconfig-003-20241120    gcc-14.2.0
arm64                 randconfig-004-20241120    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20241120    gcc-14.2.0
csky                  randconfig-002-20241120    gcc-14.2.0
hexagon                          alldefconfig    clang-15
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    clang-20
hexagon               randconfig-001-20241120    clang-20
hexagon               randconfig-002-20241120    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241120    clang-19
i386        buildonly-randconfig-002-20241120    gcc-12
i386        buildonly-randconfig-003-20241120    gcc-12
i386        buildonly-randconfig-004-20241120    gcc-12
i386        buildonly-randconfig-005-20241120    clang-19
i386        buildonly-randconfig-006-20241120    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20241120    gcc-12
i386                  randconfig-002-20241120    gcc-12
i386                  randconfig-003-20241120    gcc-12
i386                  randconfig-004-20241120    gcc-12
i386                  randconfig-005-20241120    gcc-12
i386                  randconfig-006-20241120    gcc-12
i386                  randconfig-011-20241120    clang-19
i386                  randconfig-012-20241120    clang-19
i386                  randconfig-013-20241120    clang-19
i386                  randconfig-014-20241120    gcc-11
i386                  randconfig-015-20241120    gcc-12
i386                  randconfig-016-20241120    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20241120    gcc-14.2.0
loongarch             randconfig-002-20241120    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                      bmips_stb_defconfig    clang-20
mips                          eyeq6_defconfig    clang-14
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20241120    gcc-14.2.0
nios2                 randconfig-002-20241120    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20241120    gcc-14.2.0
parisc                randconfig-002-20241120    gcc-14.2.0
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-20
powerpc                    gamecube_defconfig    clang-20
powerpc                 mpc8313_rdb_defconfig    gcc-14.2.0
powerpc               randconfig-001-20241120    gcc-14.2.0
powerpc               randconfig-002-20241120    gcc-14.2.0
powerpc               randconfig-003-20241120    gcc-14.2.0
powerpc                      tqm8xx_defconfig    clang-20
powerpc64             randconfig-001-20241120    clang-20
powerpc64             randconfig-002-20241120    clang-20
powerpc64             randconfig-003-20241120    clang-20
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                               defconfig    clang-20
riscv             nommu_k210_sdcard_defconfig    gcc-14.2.0
riscv                 randconfig-001-20241120    gcc-14.2.0
riscv                 randconfig-002-20241120    gcc-14.2.0
s390                             allmodconfig    clang-20
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-20
s390                  randconfig-001-20241120    clang-20
s390                  randconfig-002-20241120    clang-20
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                         apsh4a3a_defconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                          polaris_defconfig    gcc-14.2.0
sh                    randconfig-001-20241120    gcc-14.2.0
sh                    randconfig-002-20241120    gcc-14.2.0
sh                          rsk7269_defconfig    gcc-14.2.0
sh                   sh7724_generic_defconfig    gcc-14.2.0
sh                  sh7785lcr_32bit_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                       sparc64_defconfig    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20241120    gcc-14.2.0
sparc64               randconfig-002-20241120    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                               allyesconfig    gcc-12
um                                  defconfig    clang-20
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241120    gcc-12
um                    randconfig-002-20241120    clang-20
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                               rhel-9.4    gcc-12
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20241120    gcc-14.2.0
xtensa                randconfig-002-20241120    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

