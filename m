Return-Path: <linux-kernel+bounces-516088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F889A36CD8
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 10:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D64BF1895014
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 09:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3977C19DFA5;
	Sat, 15 Feb 2025 09:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EZVW4oby"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9FF19CC3D
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 09:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739611348; cv=none; b=WBzcLqHZFfnYMG0yKJzOVXimb2+InRJIE8iks9bolzvoyhnRFaQJ/M3vsHBLWqTZ/EMkQ8qy0WZLzzOIUf2qTk5dBMgR//G4/oLOl5V4rCEXRGoxFLw20OZ4USNt9wGmbcNjg7H35Dd/wHip686fWcsJKg1wVOH2LmTFxPmq8oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739611348; c=relaxed/simple;
	bh=sLhWljl77kFulYgmKP/XNP8GseZdhJlpw0W5ambG1Xg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=lC/neL2C+1YRNn/DIIcgto/7OqaLOcaYTN6Cw9mRIl3geaBfjnRvkl4A+jYThiv/+GW5A7SCwcHyeeouIxiNUj0RE/OUSpZ2T8ZsaD3mpfMKfIoloX0VTVR6/PYP0ze6zy+sHEPEpZBq5Fx1nAw2WRwSThB1CXQ/ga/sYStTqHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EZVW4oby; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739611347; x=1771147347;
  h=date:from:to:cc:subject:message-id;
  bh=sLhWljl77kFulYgmKP/XNP8GseZdhJlpw0W5ambG1Xg=;
  b=EZVW4obywcGSG4GUcB4Z1iE97L1gPxWwsNzjSHDB3qBA3nuwH8FJKK8Y
   T2UfeL0qeDsaAHLGcUtbSX1M9LMxqBuHRkcwprehHcmXX2LDaNGLu4MfQ
   CHAMjO3A+WtdkI9yy5Rdlz2V7W2sLxIsn5OMRdV6DbWUJA3MyJ97+Xk7r
   +TT7tASCkQGSn5XMpRuZrAeQBMkJpTy6gPdeUgVG1RXq752IHzxfcLSz8
   gcYg9hStTQUHdmyxXuCx8+kONfNlRwJjFKvOuXYRz4yR78jL8aexvPMQ7
   dIMwMdb34rNTqTz5f21ugTOG17oOiYSFinRKcYcTyTGdT+3oiqaQ8l15m
   w==;
X-CSE-ConnectionGUID: swMiQhEORHClb+OvhJ+30w==
X-CSE-MsgGUID: bUCXc1vuQ0yHiYoDhe/peQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="57886320"
X-IronPort-AV: E=Sophos;i="6.13,288,1732608000"; 
   d="scan'208";a="57886320"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2025 01:22:25 -0800
X-CSE-ConnectionGUID: F0yZyTofTjS1wKWe96b+rQ==
X-CSE-MsgGUID: uLT9HwBiTAy8a9A5FooAUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,288,1732608000"; 
   d="scan'208";a="113648578"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 15 Feb 2025 01:22:23 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tjENQ-001AgB-2Q;
	Sat, 15 Feb 2025 09:22:20 +0000
Date: Sat, 15 Feb 2025 17:21:43 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 e4cb98b9ef02fede832955307f569ca2855fe133
Message-ID: <202502151737.AWpyutuW-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: e4cb98b9ef02fede832955307f569ca2855fe133  Merge branch into tip/master: 'x86/mm'

elapsed time: 1451m

configs tested: 82
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                           allyesconfig    gcc-14.2.0
arc                             allmodconfig    gcc-13.2.0
arc                             allyesconfig    gcc-13.2.0
arc                  randconfig-001-20250214    gcc-13.2.0
arc                  randconfig-002-20250214    gcc-13.2.0
arm                             allyesconfig    gcc-14.2.0
arm                  randconfig-001-20250214    clang-16
arm                  randconfig-002-20250214    gcc-14.2.0
arm                  randconfig-003-20250214    clang-21
arm                  randconfig-004-20250214    gcc-14.2.0
arm64                           allmodconfig    clang-18
arm64                randconfig-001-20250214    gcc-14.2.0
arm64                randconfig-002-20250214    gcc-14.2.0
arm64                randconfig-003-20250214    gcc-14.2.0
arm64                randconfig-004-20250214    gcc-14.2.0
csky                 randconfig-001-20250214    gcc-14.2.0
csky                 randconfig-002-20250214    gcc-14.2.0
hexagon                         allmodconfig    clang-21
hexagon                         allyesconfig    clang-18
hexagon              randconfig-001-20250214    clang-21
hexagon              randconfig-002-20250214    clang-15
i386                            allmodconfig    gcc-12
i386                             allnoconfig    gcc-12
i386                            allyesconfig    gcc-12
i386       buildonly-randconfig-001-20250214    gcc-12
i386       buildonly-randconfig-002-20250214    gcc-12
i386       buildonly-randconfig-003-20250214    clang-19
i386       buildonly-randconfig-004-20250214    gcc-12
i386       buildonly-randconfig-005-20250214    gcc-12
i386       buildonly-randconfig-006-20250214    gcc-12
i386                               defconfig    clang-19
loongarch            randconfig-001-20250214    gcc-14.2.0
loongarch            randconfig-002-20250214    gcc-14.2.0
nios2                randconfig-001-20250214    gcc-14.2.0
nios2                randconfig-002-20250214    gcc-14.2.0
openrisc                         allnoconfig    gcc-14.2.0
openrisc                        allyesconfig    gcc-14.2.0
parisc                          allmodconfig    gcc-14.2.0
parisc                           allnoconfig    gcc-14.2.0
parisc                          allyesconfig    gcc-14.2.0
parisc               randconfig-001-20250214    gcc-14.2.0
parisc               randconfig-002-20250214    gcc-14.2.0
powerpc                          allnoconfig    gcc-14.2.0
powerpc              randconfig-001-20250214    gcc-14.2.0
powerpc              randconfig-002-20250214    clang-18
powerpc              randconfig-003-20250214    clang-21
powerpc64            randconfig-001-20250214    clang-18
powerpc64            randconfig-002-20250214    gcc-14.2.0
powerpc64            randconfig-003-20250214    gcc-14.2.0
riscv                            allnoconfig    gcc-14.2.0
riscv                randconfig-001-20250214    clang-18
riscv                randconfig-002-20250214    gcc-14.2.0
s390                            allmodconfig    clang-19
s390                             allnoconfig    clang-21
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20250214    gcc-14.2.0
s390                 randconfig-002-20250214    clang-19
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20250214    gcc-14.2.0
sh                   randconfig-002-20250214    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20250214    gcc-14.2.0
sparc                randconfig-002-20250214    gcc-14.2.0
sparc64              randconfig-001-20250214    gcc-14.2.0
sparc64              randconfig-002-20250214    gcc-14.2.0
um                              allmodconfig    clang-21
um                               allnoconfig    clang-18
um                              allyesconfig    gcc-12
um                   randconfig-001-20250214    gcc-12
um                   randconfig-002-20250214    clang-16
x86_64                           allnoconfig    clang-19
x86_64                          allyesconfig    clang-19
x86_64     buildonly-randconfig-001-20250214    clang-19
x86_64     buildonly-randconfig-002-20250214    clang-19
x86_64     buildonly-randconfig-003-20250214    gcc-12
x86_64     buildonly-randconfig-004-20250214    clang-19
x86_64     buildonly-randconfig-005-20250214    gcc-12
x86_64     buildonly-randconfig-006-20250214    gcc-12
x86_64                             defconfig    gcc-11
xtensa               randconfig-001-20250214    gcc-14.2.0
xtensa               randconfig-002-20250214    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

