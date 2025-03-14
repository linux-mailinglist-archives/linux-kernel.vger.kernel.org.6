Return-Path: <linux-kernel+bounces-561976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50FF3A6199C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 19:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8637D1753FC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 18:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3C6204C20;
	Fri, 14 Mar 2025 18:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NT6pFdoO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B601F3BAE
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 18:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741977425; cv=none; b=VbuaiX3MzqIl/w82O6Q+rmt+A9Hb/+uZfgGzItEu3dLgbE+Hj2KKTuBjJ1KW8+kXdKPEYeU+u2Ag3Fw/itCuZPKEn9JNoqe6E5sf4JZx20s3FiQTiBvX1K/HkCQWe8GBAjmzvtuNtZ2272Zsiz9ILH5X5EFqZL4f04dOSVYXIlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741977425; c=relaxed/simple;
	bh=gGjnehE79EwVbZmtu+ygVi03xKqX8gTkTcXvfkXxfFM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Jba4CF8qKZGGX8cGZr5wZMV4aBLrtcEfKlZZfgjMe6MT9860eYQMm8SD+oVTHSAQdQqCq4buE7G46VPAulrmQ4T8omouW3mzmbqnTl/u6uKh0DK+xlzHtNqKbsTsjoc+BjAj7lVXRs2cx6lqX5SWAdX9zgZUzlLTfIwzPlfepdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NT6pFdoO; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741977423; x=1773513423;
  h=date:from:to:cc:subject:message-id;
  bh=gGjnehE79EwVbZmtu+ygVi03xKqX8gTkTcXvfkXxfFM=;
  b=NT6pFdoOG/4iFZI55RIxzG3O7qwwPExA+Huo8eOgIkUG9W/590x3lAUC
   uQ3P7EfE0Ene1Q7cztVNJY0zigxhlzBL0lqP0uRqcPIjM8pMYww0L2/Am
   MrXbKsenWYMhcikfWsF899f7QFbT4ylo7Ai0SbgNA1eHJg44NcUSJhMln
   3Qy4U6QrQxHIFal6nVL60V+d6ysmYbo8PqRUY+CzRpBcslBLPkw8mriZh
   +5YwSymE5dZjrOXrQnpvWE1larsTbGaYZqNo/FGlGD8QBpNXPK5qVlYNh
   9jylHXwd06yypR+P/qfLmeIPhMF/s0+ac0n/9iyToqiIcoE8YORpEHAcJ
   g==;
X-CSE-ConnectionGUID: pqmSNcyIQJOEXbV4gOgBpw==
X-CSE-MsgGUID: tFPSeZGXQSyndUAoZJWgXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11373"; a="42871865"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="42871865"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 11:36:58 -0700
X-CSE-ConnectionGUID: rpRDxQZ8Q/Sk0irMFf0c5w==
X-CSE-MsgGUID: WLWg0BlZRDSmXlFR2hLoaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="121083175"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 14 Mar 2025 11:36:57 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tt9tv-000Ajz-1E;
	Fri, 14 Mar 2025 18:36:55 +0000
Date: Sat, 15 Mar 2025 02:36:14 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/fpu] BUILD SUCCESS
 2883b4c2169a435488f7845e1b6fdc6f3438c7c6
Message-ID: <202503150204.gFqSowLP-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/fpu
branch HEAD: 2883b4c2169a435488f7845e1b6fdc6f3438c7c6  x86/fpu: Use XSAVE{,OPT,C,S} and XRSTOR{,S} mnemonics in xstate.h

elapsed time: 1454m

configs tested: 94
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250314    gcc-13.2.0
arc                   randconfig-002-20250314    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                           h3600_defconfig    gcc-14.2.0
arm                   randconfig-001-20250314    clang-21
arm                   randconfig-002-20250314    gcc-14.2.0
arm                   randconfig-003-20250314    gcc-14.2.0
arm                   randconfig-004-20250314    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250314    gcc-14.2.0
arm64                 randconfig-002-20250314    clang-21
arm64                 randconfig-003-20250314    clang-15
arm64                 randconfig-004-20250314    clang-21
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250314    gcc-14.2.0
csky                  randconfig-002-20250314    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250314    clang-21
hexagon               randconfig-002-20250314    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250314    clang-19
i386        buildonly-randconfig-002-20250314    clang-19
i386        buildonly-randconfig-003-20250314    gcc-12
i386        buildonly-randconfig-004-20250314    gcc-12
i386        buildonly-randconfig-005-20250314    gcc-12
i386        buildonly-randconfig-006-20250314    gcc-12
i386                                defconfig    clang-19
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250314    gcc-14.2.0
loongarch             randconfig-002-20250314    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250314    gcc-14.2.0
nios2                 randconfig-002-20250314    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                randconfig-001-20250314    gcc-14.2.0
parisc                randconfig-002-20250314    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc               randconfig-001-20250314    clang-21
powerpc               randconfig-002-20250314    gcc-14.2.0
powerpc               randconfig-003-20250314    gcc-14.2.0
powerpc64             randconfig-001-20250314    gcc-14.2.0
powerpc64             randconfig-002-20250314    clang-17
powerpc64             randconfig-003-20250314    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                 randconfig-001-20250314    clang-19
riscv                 randconfig-002-20250314    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250314    gcc-14.2.0
s390                  randconfig-002-20250314    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250314    gcc-14.2.0
sh                    randconfig-002-20250314    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250314    gcc-14.2.0
sparc                 randconfig-002-20250314    gcc-14.2.0
sparc64               randconfig-001-20250314    gcc-14.2.0
sparc64               randconfig-002-20250314    gcc-14.2.0
um                               allmodconfig    clang-21
um                               allyesconfig    gcc-12
um                    randconfig-001-20250314    gcc-12
um                    randconfig-002-20250314    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250314    clang-19
x86_64      buildonly-randconfig-002-20250314    clang-19
x86_64      buildonly-randconfig-003-20250314    gcc-12
x86_64      buildonly-randconfig-004-20250314    clang-19
x86_64      buildonly-randconfig-005-20250314    gcc-12
x86_64      buildonly-randconfig-006-20250314    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250314    gcc-14.2.0
xtensa                randconfig-002-20250314    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

