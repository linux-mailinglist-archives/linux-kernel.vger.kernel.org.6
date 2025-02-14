Return-Path: <linux-kernel+bounces-514367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DFC6A355FD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 06:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6176188D1C1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 05:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A2E152E02;
	Fri, 14 Feb 2025 05:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SzUWYY3N"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BC227540F
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 05:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739509400; cv=none; b=J+Z/eC3iNlzN1JSCaR4otv8YtC+GWTOwzdxu7zCDnYF47LHnjZTjgLPYGTteykaRp1Iw7GdxwwQ3lQyvPn4Y0Hk7rQuyrKSsVO3dOKXcuSAv4WrCg29JsgXfx9/p3bFf/ElX0fjJKqxGiGfilZOkPSDNFhZDgPj6pgF+Auci2EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739509400; c=relaxed/simple;
	bh=v8Wo8ZAR+qUI0Q/gqLVZ5OtGZ37XkHxQLbb3pMglYMo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=T+MUgmobRHGaCNfI1Bg501fwTwubXgW3fgyDNBygQZYmp0VSx0pzyw9q+aAKWo+6GUOOmsWi/W94heRcmk0B6lz8lMNuP0O7OwMPJFz+Hxvv1q0I1gIPnWpX7ACrBQ9bWk28DCm09/VEiWI+5VUGDf2O+gBK5Orv8qoiXJMZCk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SzUWYY3N; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739509398; x=1771045398;
  h=date:from:to:cc:subject:message-id;
  bh=v8Wo8ZAR+qUI0Q/gqLVZ5OtGZ37XkHxQLbb3pMglYMo=;
  b=SzUWYY3Nfo9U8SKNm2b0YZww9FSTe6IjLLZ9zT+ghZadQB33O9H7Qgdi
   EMkyr5LX+kvoGRGFEQuB4LS4bbZCPhe/Q5fcvnDVfwr0uPQw+LepW7S5O
   ZFqNWOpMR9K0oI8Sy3twz4HC6cGpHCgZsjzO5XGFIcNYAm3QGs8QSoZ7r
   xUVWKpvuExok7XmqZIwFchy16W+ErCEx0RYX+5ajE5AU6TxCl88DSFRor
   iDs9YQ2IfGwFxX1UqVsONrbgyEotgzatl9LyunqfTJ0EQpEPBSLLKRrYp
   Hq3ppUT1FeG3hUWCGvbGqI8vohb+WEvd1Sk2czE5qNa58jSCi7dRyMqPb
   Q==;
X-CSE-ConnectionGUID: MJk51cBPT5q1swqgGDnlXQ==
X-CSE-MsgGUID: wzagVFWHRT2EFYv8EnXybw==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="65599068"
X-IronPort-AV: E=Sophos;i="6.13,284,1732608000"; 
   d="scan'208";a="65599068"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 21:03:17 -0800
X-CSE-ConnectionGUID: 9KbxffTjQqS2pBvcUt6CUg==
X-CSE-MsgGUID: 5trA6vp0QEKg1oa6HmLMCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117494507"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 13 Feb 2025 21:03:16 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tinr8-00194r-0L;
	Fri, 14 Feb 2025 05:03:14 +0000
Date: Fri, 14 Feb 2025 13:02:45 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/wfamnae-next20250212] BUILD REGRESSION
 513cdf5e772efc6cb8a92344b0f436e77c2b42f7
Message-ID: <202502141337.JhhdRJWh-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/wfamnae-next20250212
branch HEAD: 513cdf5e772efc6cb8a92344b0f436e77c2b42f7  drm/amd/pm: Avoid multiple -Wflex-array-member-not-at-end warnings

Error/Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202502132042.V5SUV9zZ-lkp@intel.com
    https://lore.kernel.org/oe-kbuild-all/202502140000.KIQUxLr5-lkp@intel.com

    drivers/gpu/drm/amd/amdgpu/../pm/legacy-dpm/si_dpm.c:5237:21: error: no member named 'levels' in 'struct SISLANDS_SMC_SWSTATE_HDR'
    drivers/gpu/drm/amd/amdgpu/../pm/legacy-dpm/si_dpm.c:5237:27: error: 'struct SISLANDS_SMC_SWSTATE_HDR' has no member named 'levels'
    drivers/gpu/drm/amd/amdgpu/../pm/legacy-dpm/si_dpm.c:5758:24: error: incompatible pointer types initializing 'SISLANDS_SMC_SWSTATE *' (aka 'struct SISLANDS_SMC_SWSTATE *') with an expression of type 'struct SISLANDS_SMC_SWSTATE_HDR *' [-Werror,-Wincompatible-pointer-types]
    drivers/gpu/drm/amd/amdgpu/../pm/legacy-dpm/si_dpm.c:5758:43: error: initialization of 'SISLANDS_SMC_SWSTATE *' from incompatible pointer type 'struct SISLANDS_SMC_SWSTATE_HDR *' [-Werror=incompatible-pointer-types]

Error/Warning ids grouped by kconfigs:

recent_errors
|-- arc-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-pm-legacy-dpm-si_dpm.c:error:initialization-of-SISLANDS_SMC_SWSTATE-from-incompatible-pointer-type-struct-SISLANDS_SMC_SWSTATE_HDR
|   `-- drivers-gpu-drm-amd-amdgpu-..-pm-legacy-dpm-si_dpm.c:error:struct-SISLANDS_SMC_SWSTATE_HDR-has-no-member-named-levels
|-- arc-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-pm-legacy-dpm-si_dpm.c:error:initialization-of-SISLANDS_SMC_SWSTATE-from-incompatible-pointer-type-struct-SISLANDS_SMC_SWSTATE_HDR
|   `-- drivers-gpu-drm-amd-amdgpu-..-pm-legacy-dpm-si_dpm.c:error:struct-SISLANDS_SMC_SWSTATE_HDR-has-no-member-named-levels
|-- arm-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-pm-legacy-dpm-si_dpm.c:error:initialization-of-SISLANDS_SMC_SWSTATE-from-incompatible-pointer-type-struct-SISLANDS_SMC_SWSTATE_HDR
|   `-- drivers-gpu-drm-amd-amdgpu-..-pm-legacy-dpm-si_dpm.c:error:struct-SISLANDS_SMC_SWSTATE_HDR-has-no-member-named-levels
|-- arm-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-pm-legacy-dpm-si_dpm.c:error:initialization-of-SISLANDS_SMC_SWSTATE-from-incompatible-pointer-type-struct-SISLANDS_SMC_SWSTATE_HDR
|   `-- drivers-gpu-drm-amd-amdgpu-..-pm-legacy-dpm-si_dpm.c:error:struct-SISLANDS_SMC_SWSTATE_HDR-has-no-member-named-levels
|-- arm64-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-pm-legacy-dpm-si_dpm.c:error:incompatible-pointer-types-initializing-SISLANDS_SMC_SWSTATE-(aka-struct-SISLANDS_SMC_SWSTATE-)-with-an-expression-of-type-struct-SISLANDS_SM
|   `-- drivers-gpu-drm-amd-amdgpu-..-pm-legacy-dpm-si_dpm.c:error:no-member-named-levels-in-struct-SISLANDS_SMC_SWSTATE_HDR
|-- i386-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-pm-legacy-dpm-si_dpm.c:error:initialization-of-SISLANDS_SMC_SWSTATE-from-incompatible-pointer-type-struct-SISLANDS_SMC_SWSTATE_HDR
|   `-- drivers-gpu-drm-amd-amdgpu-..-pm-legacy-dpm-si_dpm.c:error:struct-SISLANDS_SMC_SWSTATE_HDR-has-no-member-named-levels
|-- i386-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-pm-legacy-dpm-si_dpm.c:error:initialization-of-SISLANDS_SMC_SWSTATE-from-incompatible-pointer-type-struct-SISLANDS_SMC_SWSTATE_HDR
|   `-- drivers-gpu-drm-amd-amdgpu-..-pm-legacy-dpm-si_dpm.c:error:struct-SISLANDS_SMC_SWSTATE_HDR-has-no-member-named-levels
|-- loongarch-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-pm-legacy-dpm-si_dpm.c:error:initialization-of-SISLANDS_SMC_SWSTATE-from-incompatible-pointer-type-struct-SISLANDS_SMC_SWSTATE_HDR
|   `-- drivers-gpu-drm-amd-amdgpu-..-pm-legacy-dpm-si_dpm.c:error:struct-SISLANDS_SMC_SWSTATE_HDR-has-no-member-named-levels
|-- loongarch-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-pm-legacy-dpm-si_dpm.c:error:initialization-of-SISLANDS_SMC_SWSTATE-from-incompatible-pointer-type-struct-SISLANDS_SMC_SWSTATE_HDR
|   `-- drivers-gpu-drm-amd-amdgpu-..-pm-legacy-dpm-si_dpm.c:error:struct-SISLANDS_SMC_SWSTATE_HDR-has-no-member-named-levels
|-- powerpc-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-pm-legacy-dpm-si_dpm.c:error:initialization-of-SISLANDS_SMC_SWSTATE-from-incompatible-pointer-type-struct-SISLANDS_SMC_SWSTATE_HDR
|   `-- drivers-gpu-drm-amd-amdgpu-..-pm-legacy-dpm-si_dpm.c:error:struct-SISLANDS_SMC_SWSTATE_HDR-has-no-member-named-levels
|-- powerpc-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-pm-legacy-dpm-si_dpm.c:error:incompatible-pointer-types-initializing-SISLANDS_SMC_SWSTATE-(aka-struct-SISLANDS_SMC_SWSTATE-)-with-an-expression-of-type-struct-SISLANDS_SM
|   `-- drivers-gpu-drm-amd-amdgpu-..-pm-legacy-dpm-si_dpm.c:error:no-member-named-levels-in-struct-SISLANDS_SMC_SWSTATE_HDR
|-- riscv-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-pm-legacy-dpm-si_dpm.c:error:incompatible-pointer-types-initializing-SISLANDS_SMC_SWSTATE-(aka-struct-SISLANDS_SMC_SWSTATE-)-with-an-expression-of-type-struct-SISLANDS_SM
|   `-- drivers-gpu-drm-amd-amdgpu-..-pm-legacy-dpm-si_dpm.c:error:no-member-named-levels-in-struct-SISLANDS_SMC_SWSTATE_HDR
|-- riscv-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-pm-legacy-dpm-si_dpm.c:error:incompatible-pointer-types-initializing-SISLANDS_SMC_SWSTATE-(aka-struct-SISLANDS_SMC_SWSTATE-)-with-an-expression-of-type-struct-SISLANDS_SM
|   `-- drivers-gpu-drm-amd-amdgpu-..-pm-legacy-dpm-si_dpm.c:error:no-member-named-levels-in-struct-SISLANDS_SMC_SWSTATE_HDR
|-- s390-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-pm-legacy-dpm-si_dpm.c:error:incompatible-pointer-types-initializing-SISLANDS_SMC_SWSTATE-(aka-struct-SISLANDS_SMC_SWSTATE-)-with-an-expression-of-type-struct-SISLANDS_SM
|   `-- drivers-gpu-drm-amd-amdgpu-..-pm-legacy-dpm-si_dpm.c:error:no-member-named-levels-in-struct-SISLANDS_SMC_SWSTATE_HDR
|-- sparc-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-pm-legacy-dpm-si_dpm.c:error:initialization-of-SISLANDS_SMC_SWSTATE-from-incompatible-pointer-type-struct-SISLANDS_SMC_SWSTATE_HDR
|   `-- drivers-gpu-drm-amd-amdgpu-..-pm-legacy-dpm-si_dpm.c:error:struct-SISLANDS_SMC_SWSTATE_HDR-has-no-member-named-levels
|-- x86_64-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-pm-legacy-dpm-si_dpm.c:error:incompatible-pointer-types-initializing-SISLANDS_SMC_SWSTATE-(aka-struct-SISLANDS_SMC_SWSTATE-)-with-an-expression-of-type-struct-SISLANDS_SM
|   `-- drivers-gpu-drm-amd-amdgpu-..-pm-legacy-dpm-si_dpm.c:error:no-member-named-levels-in-struct-SISLANDS_SMC_SWSTATE_HDR
`-- x86_64-buildonly-randconfig-004-20250213
    |-- drivers-gpu-drm-amd-amdgpu-..-pm-legacy-dpm-si_dpm.c:error:initialization-of-SISLANDS_SMC_SWSTATE-from-incompatible-pointer-type-struct-SISLANDS_SMC_SWSTATE_HDR
    `-- drivers-gpu-drm-amd-amdgpu-..-pm-legacy-dpm-si_dpm.c:error:struct-SISLANDS_SMC_SWSTATE_HDR-has-no-member-named-levels

elapsed time: 1162m

configs tested: 106
configs skipped: 1

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250213    gcc-13.2.0
arc                   randconfig-002-20250213    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                   randconfig-001-20250213    clang-17
arm                   randconfig-002-20250213    clang-15
arm                   randconfig-003-20250213    clang-21
arm                   randconfig-004-20250213    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250213    clang-19
arm64                 randconfig-002-20250213    gcc-14.2.0
arm64                 randconfig-003-20250213    gcc-14.2.0
arm64                 randconfig-004-20250213    clang-21
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250213    gcc-14.2.0
csky                  randconfig-002-20250213    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250213    clang-21
hexagon               randconfig-002-20250213    clang-18
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250213    gcc-12
i386        buildonly-randconfig-002-20250213    clang-19
i386        buildonly-randconfig-003-20250213    clang-19
i386        buildonly-randconfig-004-20250213    clang-19
i386        buildonly-randconfig-005-20250213    clang-19
i386        buildonly-randconfig-006-20250213    clang-19
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250213    gcc-14.2.0
loongarch             randconfig-002-20250213    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250213    gcc-14.2.0
nios2                 randconfig-002-20250213    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                randconfig-001-20250213    gcc-14.2.0
parisc                randconfig-002-20250213    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc               randconfig-001-20250213    clang-17
powerpc               randconfig-002-20250213    gcc-14.2.0
powerpc               randconfig-003-20250213    gcc-14.2.0
powerpc64             randconfig-001-20250213    clang-19
powerpc64             randconfig-002-20250213    clang-21
powerpc64             randconfig-003-20250213    gcc-14.2.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-21
riscv                 randconfig-001-20250213    clang-19
riscv                 randconfig-002-20250213    clang-17
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250213    gcc-14.2.0
s390                  randconfig-002-20250213    clang-21
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250213    gcc-14.2.0
sh                    randconfig-002-20250213    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250213    gcc-14.2.0
sparc                 randconfig-002-20250213    gcc-14.2.0
sparc64               randconfig-001-20250213    gcc-14.2.0
sparc64               randconfig-002-20250213    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                    randconfig-001-20250213    clang-19
um                    randconfig-002-20250213    clang-21
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250213    gcc-11
x86_64      buildonly-randconfig-002-20250213    gcc-12
x86_64      buildonly-randconfig-003-20250213    clang-19
x86_64      buildonly-randconfig-004-20250213    gcc-12
x86_64      buildonly-randconfig-005-20250213    gcc-12
x86_64      buildonly-randconfig-006-20250213    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250213    gcc-14.2.0
xtensa                randconfig-002-20250213    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

