Return-Path: <linux-kernel+bounces-535504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D844A473AF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 04:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC8BA188D874
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 03:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEC61D63DB;
	Thu, 27 Feb 2025 03:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AbB02A4+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1201581E5
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 03:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740627772; cv=none; b=u0Szj+cOoz31B6G5b+LcmfK+YKTFYjJ6G1udOdwplBU+NTestOF6X8P8zCLr8Is3dlNio8qyzFegEZfZxHoqpyP8x7YIfB/MDOV+F+9M1OR2UkosgTGz2uaWL9RoNuFYMq6rYoFs3lD+trqd+LbMLUq4gSxqSVQDKU0XcGhNatM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740627772; c=relaxed/simple;
	bh=vUtZ5ExOfgAFEZiX5IgAJt/hwaXQyF2ea/FIBsljuDo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=l6Ec9VQlB3p13fndwK34GC/k3w3UZlsthVukh18ZpywaGw/54daRlyT5uJVIJ3ibPyw2SrJhL1soI4MY7BcPuNKts+7TaYd4t7ggEL8H/WgRut4yeakRy704ZvjNJRtsj440aH2jFsylwzEN0d4+U+xsLpZQbFCX//V5BySNVvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AbB02A4+; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740627771; x=1772163771;
  h=date:from:to:cc:subject:message-id;
  bh=vUtZ5ExOfgAFEZiX5IgAJt/hwaXQyF2ea/FIBsljuDo=;
  b=AbB02A4+V315YPz3U95cFtvJ2NRfSGvEqeS7XPYR3xNADmmiDn1fUBw/
   q9ZPDsIq8a4BjUudHK+ecou4Kox9b1s+IKTlq9Wq9rgE7IUVGtcwGotB5
   PrY+49HJ/SVCLj82EqVPTY3OF2tgRTTo1go+Pf79okofeBdcuBUnxC4DY
   Zzx0csErO8bIyLwWZECombb0guim4hgEzuRXRf8b3pe5M+3p//GhHWb7o
   IjMM4CHBYnGMAqXd6HSyXdzVm0oNvd/LBVgMRoZXbNxVX4too005MLFau
   TO5I0YGatCipWlE4a5WaKbJl0RBqXb6ZAFJbDOqoWii53gAnR7MXxFoyQ
   w==;
X-CSE-ConnectionGUID: uMQ8sreLSESPQY9jXq9iYw==
X-CSE-MsgGUID: /PiBK3CEQDmBsQZZS15l5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="45282750"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="45282750"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 19:42:51 -0800
X-CSE-ConnectionGUID: QUnLOzhiSn6waT5C5dF5bQ==
X-CSE-MsgGUID: spJao1xAQcqPchXOTJurrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="121834160"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 26 Feb 2025 19:42:49 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tnUnO-000CoA-37;
	Thu, 27 Feb 2025 03:42:46 +0000
Date: Thu, 27 Feb 2025 11:42:04 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/wfamnae-next20250210-2] BUILD SUCCESS
 925bb303db8db58fbb91ca51490ef27dea820080
Message-ID: <202502271159.wXhOLbAF-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/wfamnae-next20250210-2
branch HEAD: 925bb303db8db58fbb91ca51490ef27dea820080  net/mlx5e: Avoid a hundred -Wflex-array-member-not-at-end warnings

elapsed time: 1467m

configs tested: 105
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-14.2.0
alpha                           allyesconfig    gcc-14.2.0
alpha                              defconfig    gcc-14.2.0
arc                             alldefconfig    gcc-13.2.0
arc                             allmodconfig    gcc-13.2.0
arc                              allnoconfig    gcc-13.2.0
arc                             allyesconfig    gcc-13.2.0
arc                                defconfig    gcc-13.2.0
arc                  randconfig-001-20250226    gcc-13.2.0
arc                  randconfig-002-20250226    gcc-13.2.0
arm                             allmodconfig    gcc-14.2.0
arm                              allnoconfig    clang-17
arm                             allyesconfig    gcc-14.2.0
arm                         pxa3xx_defconfig    clang-21
arm                  randconfig-001-20250226    gcc-14.2.0
arm                  randconfig-002-20250226    clang-21
arm                  randconfig-003-20250226    gcc-14.2.0
arm                  randconfig-004-20250226    gcc-14.2.0
arm                        socfpga_defconfig    gcc-14.2.0
arm                       spear6xx_defconfig    clang-19
arm64                           allmodconfig    clang-18
arm64                            allnoconfig    gcc-14.2.0
arm64                randconfig-001-20250226    gcc-14.2.0
arm64                randconfig-002-20250226    gcc-14.2.0
arm64                randconfig-003-20250226    clang-21
arm64                randconfig-004-20250226    gcc-14.2.0
csky                             allnoconfig    gcc-14.2.0
csky                               defconfig    gcc-14.2.0
csky                 randconfig-001-20250226    gcc-14.2.0
csky                 randconfig-002-20250226    gcc-14.2.0
hexagon                         allmodconfig    clang-21
hexagon                          allnoconfig    clang-21
hexagon                         allyesconfig    clang-18
hexagon              randconfig-001-20250226    clang-21
hexagon              randconfig-002-20250226    clang-21
i386                             allnoconfig    gcc-12
i386       buildonly-randconfig-001-20250226    gcc-12
i386       buildonly-randconfig-002-20250226    gcc-12
i386       buildonly-randconfig-003-20250226    gcc-12
i386       buildonly-randconfig-004-20250226    clang-19
i386       buildonly-randconfig-005-20250226    gcc-12
i386       buildonly-randconfig-006-20250226    gcc-12
loongarch                        allnoconfig    gcc-14.2.0
loongarch            randconfig-001-20250226    gcc-14.2.0
loongarch            randconfig-002-20250226    gcc-14.2.0
m68k                            allmodconfig    gcc-14.2.0
m68k                            allyesconfig    gcc-14.2.0
m68k                       mvme16x_defconfig    gcc-14.2.0
mips                       bcm63xx_defconfig    clang-21
mips                         eyeq5_defconfig    gcc-14.2.0
mips                      rbtx49xx_defconfig    gcc-14.2.0
nios2                randconfig-001-20250226    gcc-14.2.0
nios2                randconfig-002-20250226    gcc-14.2.0
openrisc                         allnoconfig    gcc-14.2.0
openrisc                        allyesconfig    gcc-14.2.0
openrisc                           defconfig    gcc-14.2.0
parisc                          allmodconfig    gcc-14.2.0
parisc                           allnoconfig    gcc-14.2.0
parisc                          allyesconfig    gcc-14.2.0
parisc                             defconfig    gcc-14.2.0
parisc               randconfig-001-20250226    gcc-14.2.0
parisc               randconfig-002-20250226    gcc-14.2.0
powerpc                         allmodconfig    gcc-14.2.0
powerpc                          allnoconfig    gcc-14.2.0
powerpc                     bamboo_defconfig    clang-21
powerpc              randconfig-001-20250226    gcc-14.2.0
powerpc              randconfig-002-20250226    clang-18
powerpc              randconfig-003-20250226    clang-21
powerpc64            randconfig-001-20250226    clang-18
powerpc64            randconfig-002-20250226    gcc-14.2.0
powerpc64            randconfig-003-20250226    gcc-14.2.0
riscv                            allnoconfig    gcc-14.2.0
riscv                randconfig-001-20250226    clang-18
riscv                randconfig-002-20250226    gcc-14.2.0
s390                            allmodconfig    clang-19
s390                             allnoconfig    clang-15
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20250226    gcc-14.2.0
s390                 randconfig-002-20250226    clang-15
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20250226    gcc-14.2.0
sh                   randconfig-002-20250226    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20250226    gcc-14.2.0
sparc                randconfig-002-20250226    gcc-14.2.0
sparc                      sparc32_defconfig    gcc-14.2.0
sparc64              randconfig-001-20250226    gcc-14.2.0
sparc64              randconfig-002-20250226    gcc-14.2.0
um                              allmodconfig    clang-21
um                               allnoconfig    clang-18
um                              allyesconfig    gcc-12
um                   randconfig-001-20250226    clang-18
um                   randconfig-002-20250226    gcc-12
x86_64                           allnoconfig    clang-19
x86_64     buildonly-randconfig-001-20250226    clang-19
x86_64     buildonly-randconfig-002-20250226    clang-19
x86_64     buildonly-randconfig-003-20250226    gcc-12
x86_64     buildonly-randconfig-004-20250226    clang-19
x86_64     buildonly-randconfig-005-20250226    gcc-12
x86_64     buildonly-randconfig-006-20250226    gcc-12
x86_64                             defconfig    gcc-11
xtensa                 nommu_kc705_defconfig    gcc-14.2.0
xtensa               randconfig-001-20250226    gcc-14.2.0
xtensa               randconfig-002-20250226    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

