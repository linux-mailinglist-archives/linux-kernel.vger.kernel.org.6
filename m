Return-Path: <linux-kernel+bounces-544305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DAC1A4DFF7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29FDD189062B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 13:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32B720485D;
	Tue,  4 Mar 2025 13:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mZsCoSvD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FC6204594
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 13:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741096644; cv=none; b=J441DYhggB7C4y6zsUa4DFdu+vSWWEi5zswsHu48OL723U84WrNGlnC0nKVmNt0/l6hpSd7J7ARSL9tWujeojS6BAWjzATtKuvSTCT5ER6GZIgeEtSsX5y/Ahs4WVZfLW0qX4TQpMlbs5atGuO7d6ZF4BXrSo0MDNsojWjLu5jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741096644; c=relaxed/simple;
	bh=/wWw1SW/t4kU27Bk8uTvzVKjqKLxKNP1Aac8aA0xtVY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=HL3ZO5xiCajnKfqBsd1s7GJhOYk1/roZDmSe2RxOHiLI3D8nSyIhMmQUy4mS2M2rxne4yrMPIiSuc0MIQUyqBZwnCxx2TL6iuf4PEfrERGqHrWax8Wq8TIjPubMB82Ab0Z3snvoYs7si9KVlu9aZy9eNRoue4TVkNXHwSuYi5MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mZsCoSvD; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741096642; x=1772632642;
  h=date:from:to:cc:subject:message-id;
  bh=/wWw1SW/t4kU27Bk8uTvzVKjqKLxKNP1Aac8aA0xtVY=;
  b=mZsCoSvDT9LRQ67nPwkq2X/8HOS3p08A+qdJ/nKUdRdPcJt9iJVMo+Um
   2mCOoyiwSV/pxwlRStfwOuEiAWyhprtJzQpg9/HVTKRF1cXdF2RgP63c0
   6d8dGXH3sdZVw2nlnK4Nj7kJdRyFuq9rC+JNqbaQwXYbbqBJq6sWdCgJ7
   XEoaluB5pHbFZyLnwH73n8Q8SWinef2rS+WBPulVL+NzNgvNTL/n64nSP
   1UAYSlicWsfWzKFfFHRY8o9dqq9VuJ1P9a21AVc90w0Eu+Tg6WhKklGA8
   NEdQmd0pkT+SAtJfLHd6KoOjePBmBo6ERH4fU2TkcCgRQxhvLWpQLa3F1
   A==;
X-CSE-ConnectionGUID: jwp6jqzHRBqpLybkHfKEfA==
X-CSE-MsgGUID: nw9EaZn1TPCm4NIOEE7BgQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="41870773"
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="41870773"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 05:57:22 -0800
X-CSE-ConnectionGUID: 2T+/PcA7Tp6/9J9upS3iQw==
X-CSE-MsgGUID: 4BC5QVHnSpeBZJJI0FtCTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="123384552"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 04 Mar 2025 05:57:21 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tpSlh-000Jpw-2a;
	Tue, 04 Mar 2025 13:57:12 +0000
Date: Tue, 04 Mar 2025 21:56:40 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/mm] BUILD SUCCESS
 4e1c520c95849e16f8dfbcacbfd37be5330447b9
Message-ID: <202503042133.zfSmlLvl-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/mm
branch HEAD: 4e1c520c95849e16f8dfbcacbfd37be5330447b9  x86/mm/pat: Fix VM_PAT handling when fork() fails in copy_page_range()

elapsed time: 1449m

configs tested: 127
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250303    gcc-13.2.0
arc                   randconfig-002-20250303    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                          ixp4xx_defconfig    gcc-14.2.0
arm                   milbeaut_m10v_defconfig    clang-21
arm                        multi_v7_defconfig    gcc-14.2.0
arm                   randconfig-001-20250303    clang-15
arm                   randconfig-002-20250303    gcc-14.2.0
arm                   randconfig-003-20250303    gcc-14.2.0
arm                   randconfig-004-20250303    clang-17
arm                         s5pv210_defconfig    gcc-14.2.0
arm                          sp7021_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250303    clang-21
arm64                 randconfig-002-20250303    clang-19
arm64                 randconfig-003-20250303    gcc-14.2.0
arm64                 randconfig-004-20250303    clang-19
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250304    gcc-14.2.0
csky                  randconfig-002-20250304    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250304    clang-21
hexagon               randconfig-002-20250304    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250303    gcc-12
i386        buildonly-randconfig-002-20250303    clang-19
i386        buildonly-randconfig-003-20250303    clang-19
i386        buildonly-randconfig-004-20250303    gcc-12
i386        buildonly-randconfig-005-20250303    gcc-12
i386        buildonly-randconfig-006-20250303    clang-19
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250304    gcc-14.2.0
loongarch             randconfig-002-20250304    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                       m5208evb_defconfig    gcc-14.2.0
m68k                        m5307c3_defconfig    gcc-14.2.0
m68k                        mvme147_defconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                         db1xxx_defconfig    clang-21
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250304    gcc-14.2.0
nios2                 randconfig-002-20250304    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
openrisc                       virt_defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250304    gcc-14.2.0
parisc                randconfig-002-20250304    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                   lite5200b_defconfig    clang-21
powerpc                 mpc837x_rdb_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250304    gcc-14.2.0
powerpc               randconfig-002-20250304    gcc-14.2.0
powerpc               randconfig-003-20250304    clang-21
powerpc64             randconfig-001-20250304    gcc-14.2.0
powerpc64             randconfig-002-20250304    gcc-14.2.0
powerpc64             randconfig-003-20250304    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-21
riscv                               defconfig    clang-19
riscv                 randconfig-001-20250303    gcc-14.2.0
riscv                 randconfig-002-20250303    gcc-14.2.0
s390                             alldefconfig    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20250303    clang-18
s390                  randconfig-002-20250303    clang-16
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                    randconfig-001-20250303    gcc-14.2.0
sh                    randconfig-002-20250303    gcc-14.2.0
sh                           se7619_defconfig    gcc-14.2.0
sh                           sh2007_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250303    gcc-14.2.0
sparc                 randconfig-002-20250303    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250303    gcc-14.2.0
sparc64               randconfig-002-20250303    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250303    gcc-12
um                    randconfig-002-20250303    clang-21
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250303    clang-19
x86_64      buildonly-randconfig-002-20250303    gcc-12
x86_64      buildonly-randconfig-003-20250303    clang-19
x86_64      buildonly-randconfig-004-20250303    gcc-12
x86_64      buildonly-randconfig-005-20250303    gcc-12
x86_64      buildonly-randconfig-006-20250303    clang-19
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250303    gcc-14.2.0
xtensa                randconfig-002-20250303    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

