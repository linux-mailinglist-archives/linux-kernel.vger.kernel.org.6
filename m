Return-Path: <linux-kernel+bounces-527493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA078A40BD1
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 23:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41D913AE290
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 21:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BCA2202C24;
	Sat, 22 Feb 2025 22:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SKn9r4N0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413511DC184
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 21:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740261599; cv=none; b=i5HkrlTJl4vtVgPwwRQywQ2UBwSh/dBI8Bmv6OxzM/CAc/8WMCIuienZ35XnL8LZCDZq+q7C0rWvzMDRb7xj5bogCC3oHIxPG1Rz0EnXqK1h+8T97WmFkeT82xwTOcWEijIHfIlLX3KKwzZgkkKqWqn7HEVmpJzft5SAQ7pFcDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740261599; c=relaxed/simple;
	bh=XpbcOW9r7w2sF+nKb2B1vn5StYFxoDLaGWq5x3GX29A=;
	h=Date:From:To:Cc:Subject:Message-ID; b=oaLGXL/PUnsfa23xSDwnzZO2VVpF9xLTIjehCnGSMllcfbcNECF4PScpFGR2+DZoYF8I0FxFJA2U3Zp0IZYthRm4aJHZrVpJnA8t60dTW1OmzPdSOrTct62Bxp3/fGZy4ZmleHYE8vTYvRWlKSQXx1CUmSIAMNb5KD4+h48TkFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SKn9r4N0; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740261598; x=1771797598;
  h=date:from:to:cc:subject:message-id;
  bh=XpbcOW9r7w2sF+nKb2B1vn5StYFxoDLaGWq5x3GX29A=;
  b=SKn9r4N0dOQaGngqTR6o7Hiz6JQt+avRVoevrUnPoYCYbszLKYIF1OMa
   LCF9XeYpm54J6iAqv+hTnHRVWixxyXSWbjzdvjvCHmxKIEJwwcw+yb7VA
   6dW00CuF9Ha9QUb05lPis8RUWBk7oenxHtd44Ih47PTE8laNuZxdxImYO
   72fRBoge0h1kjvYUhKor592T1alsRSdyeUP/JB7dCE6PtHTCc7/wUOM69
   atTuZJgdUfFliRpZamAG6BFQwF7IpNRpTho7WMAG3QdD4sr9S2Icxc0+N
   /Rakh76PHAQJxNDGnuyBP63gZdfMgZoogp2Mj/HQeHmt/0WpjvRxVm81b
   w==;
X-CSE-ConnectionGUID: 16WNvst3Qjy823B5+aiZCQ==
X-CSE-MsgGUID: Iq2udQbnQ9CXLajcDv+pbg==
X-IronPort-AV: E=McAfee;i="6700,10204,11353"; a="41199135"
X-IronPort-AV: E=Sophos;i="6.13,308,1732608000"; 
   d="scan'208";a="41199135"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2025 13:59:56 -0800
X-CSE-ConnectionGUID: KopNVdExTzyBe0oOhN/N0A==
X-CSE-MsgGUID: kLlBrQV8SEWJ+/IUy3gcAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,308,1732608000"; 
   d="scan'208";a="120318003"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 22 Feb 2025 13:59:55 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tlxXN-0006wX-1P;
	Sat, 22 Feb 2025 21:59:53 +0000
Date: Sun, 23 Feb 2025 05:59:08 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/core] BUILD SUCCESS
 684b12916a107157633311f07bb74307221eff92
Message-ID: <202502230502.sB7HqF9l-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/core
branch HEAD: 684b12916a107157633311f07bb74307221eff92  x86/arch_prctl/64: Clean up ARCH_MAP_VDSO_32

elapsed time: 1449m

configs tested: 83
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-14.2.0
alpha                           allyesconfig    gcc-14.2.0
arc                             alldefconfig    gcc-13.2.0
arc                              allnoconfig    gcc-13.2.0
arc                  randconfig-001-20250222    gcc-13.2.0
arc                  randconfig-002-20250222    gcc-13.2.0
arm                              allnoconfig    clang-17
arm                  randconfig-001-20250222    gcc-14.2.0
arm                  randconfig-002-20250222    gcc-14.2.0
arm                  randconfig-003-20250222    clang-16
arm                  randconfig-004-20250222    gcc-14.2.0
arm64                            allnoconfig    gcc-14.2.0
arm64                randconfig-001-20250222    gcc-14.2.0
arm64                randconfig-002-20250222    clang-21
arm64                randconfig-003-20250222    clang-18
arm64                randconfig-004-20250222    clang-21
csky                             allnoconfig    gcc-14.2.0
csky                 randconfig-001-20250222    gcc-14.2.0
csky                 randconfig-002-20250222    gcc-14.2.0
hexagon                         allmodconfig    clang-21
hexagon                          allnoconfig    clang-21
hexagon                         allyesconfig    clang-18
hexagon              randconfig-001-20250222    clang-17
hexagon              randconfig-002-20250222    clang-19
i386       buildonly-randconfig-001-20250222    clang-19
i386       buildonly-randconfig-002-20250222    gcc-12
i386       buildonly-randconfig-003-20250222    gcc-12
i386       buildonly-randconfig-004-20250222    clang-19
i386       buildonly-randconfig-005-20250222    gcc-12
i386       buildonly-randconfig-006-20250222    clang-19
loongarch                        allnoconfig    gcc-14.2.0
loongarch            randconfig-001-20250222    gcc-14.2.0
loongarch            randconfig-002-20250222    gcc-14.2.0
m68k                             allnoconfig    gcc-14.2.0
m68k                       mvme147_defconfig    gcc-14.2.0
mips                             allnoconfig    gcc-14.2.0
nios2                            allnoconfig    gcc-14.2.0
nios2                randconfig-001-20250222    gcc-14.2.0
nios2                randconfig-002-20250222    gcc-14.2.0
openrisc                         allnoconfig    gcc-14.2.0
parisc                           allnoconfig    gcc-14.2.0
parisc               randconfig-001-20250222    gcc-14.2.0
parisc               randconfig-002-20250222    gcc-14.2.0
powerpc                          allnoconfig    gcc-14.2.0
powerpc                  bluestone_defconfig    clang-21
powerpc              randconfig-001-20250222    gcc-14.2.0
powerpc              randconfig-002-20250222    gcc-14.2.0
powerpc              randconfig-003-20250222    gcc-14.2.0
powerpc64            randconfig-001-20250222    gcc-14.2.0
powerpc64            randconfig-002-20250222    clang-16
powerpc64            randconfig-003-20250222    clang-18
riscv                            allnoconfig    gcc-14.2.0
riscv                randconfig-001-20250222    clang-21
riscv                randconfig-002-20250222    gcc-14.2.0
s390                            allmodconfig    clang-19
s390                             allnoconfig    clang-15
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20250222    gcc-14.2.0
s390                 randconfig-002-20250222    clang-15
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20250222    gcc-14.2.0
sh                   randconfig-002-20250222    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20250222    gcc-14.2.0
sparc                randconfig-002-20250222    gcc-14.2.0
sparc64              randconfig-001-20250222    gcc-14.2.0
sparc64              randconfig-002-20250222    gcc-14.2.0
um                              allmodconfig    clang-21
um                               allnoconfig    clang-18
um                              allyesconfig    gcc-12
um                   randconfig-001-20250222    gcc-12
um                   randconfig-002-20250222    gcc-12
x86_64                           allnoconfig    clang-19
x86_64     buildonly-randconfig-001-20250222    clang-19
x86_64     buildonly-randconfig-002-20250222    gcc-12
x86_64     buildonly-randconfig-003-20250222    gcc-12
x86_64     buildonly-randconfig-004-20250222    clang-19
x86_64     buildonly-randconfig-005-20250222    clang-19
x86_64     buildonly-randconfig-006-20250222    gcc-12
x86_64                             defconfig    gcc-11
xtensa               randconfig-001-20250222    gcc-14.2.0
xtensa               randconfig-002-20250222    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

