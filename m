Return-Path: <linux-kernel+bounces-416710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF7B9D4918
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 09:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFA5CB23F69
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 08:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CFD91CC175;
	Thu, 21 Nov 2024 08:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NTZWDGn5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D7E1BE84B
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 08:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732178612; cv=none; b=AD379M5G5MmmJNobEiLCGR1OMF/coptXmJ2oY0Sxi/GcUPv/KmAh5dcBB33UlU/1Bu7eVnr8UEDY+82QXOycR3zPVx4mjZbm2GSDSQwKtVIxbmkx0DPZ8z/icXvKhxCh8tlOQSYnzgrkgr8x+U7bVdExI6P9XcdJPyYt3sVNslI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732178612; c=relaxed/simple;
	bh=vPyR9FSYgaoIC4yKDBQj+O6b4VenaUnBJcDrVIIoBH0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=esyzlOxY1shVLjoZRikcCfEg6xdlUrF7CGv10kthhENhKp8BAr1hAT3KgOhPVeN6423zfYzSjaj5uC/r9zE0R4J8dXykoVw/F/1kRlaMallT7Y10tfAeSmZXyTgNwLPqpfJeOOnUjYmBhdlvfOZykdMUlwnFDDrQU/pncvakx6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NTZWDGn5; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732178611; x=1763714611;
  h=date:from:to:cc:subject:message-id;
  bh=vPyR9FSYgaoIC4yKDBQj+O6b4VenaUnBJcDrVIIoBH0=;
  b=NTZWDGn55qRo+3IOYtYrnTT2a9SGTjGrc/mtgXGf1wK/ap2rN/jKZcQn
   QqDtN/djRrfUGrUZ3BZHlR6qWSdwtpF/1Ys4mRNPiq/Gd4g+M8BSLlSMG
   espKe6i7pk4+mlIlt6tvTEufY9nFc4SATQJMg/ZDW1OJfbk6yFF+EhFXv
   5UndCr2OL4GtW5uIBuur028+87mqS9N5emDXPvLWuqqLpGNXccM9bbe/0
   l8t4JYH95MbfhfAt53Hzub3EAnZs5ILS4NW7H7KTTBbHKWr9rw2HWkd7E
   TrE752S6BGnum1Fkgl8wFBCMCiP4DePOe1ULHfXMpe6zsJZ2cJOOzlubp
   Q==;
X-CSE-ConnectionGUID: WddZEOHOQqOq/p0aBskSVA==
X-CSE-MsgGUID: Cq1BKsLsQEyer51PBWMV6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11262"; a="32129668"
X-IronPort-AV: E=Sophos;i="6.12,172,1728975600"; 
   d="scan'208";a="32129668"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 00:43:30 -0800
X-CSE-ConnectionGUID: wT8yyuVyQxeoSJAiiP5v4A==
X-CSE-MsgGUID: aSguvNpbRjOkTv32/dVz1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,172,1728975600"; 
   d="scan'208";a="90164294"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 21 Nov 2024 00:43:30 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tE2mc-0002l1-30;
	Thu, 21 Nov 2024 08:43:26 +0000
Date: Thu, 21 Nov 2024 16:42:45 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 25f324dbc68cd6ff972f5ab3bb07f1bf6200f0e0
Message-ID: <202411211639.twntbuL4-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 25f324dbc68cd6ff972f5ab3bb07f1bf6200f0e0  Merge branch into tip/master: 'x86/tdx'

elapsed time: 1443m

configs tested: 124
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20241121    gcc-13.2.0
arc                   randconfig-002-20241121    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-20
arm                              allyesconfig    gcc-14.2.0
arm                       aspeed_g5_defconfig    gcc-14.2.0
arm                        clps711x_defconfig    clang-20
arm                            hisi_defconfig    gcc-14.2.0
arm                   randconfig-001-20241121    clang-20
arm                   randconfig-002-20241121    gcc-14.2.0
arm                   randconfig-003-20241121    clang-20
arm                   randconfig-004-20241121    gcc-14.2.0
arm                         s3c6400_defconfig    gcc-14.2.0
arm                         s5pv210_defconfig    gcc-14.2.0
arm64                            alldefconfig    gcc-14.2.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20241121    clang-20
arm64                 randconfig-002-20241121    clang-20
arm64                 randconfig-003-20241121    gcc-14.2.0
arm64                 randconfig-004-20241121    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20241121    gcc-14.2.0
csky                  randconfig-002-20241121    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                          allyesconfig    clang-20
hexagon               randconfig-001-20241121    clang-20
hexagon               randconfig-002-20241121    clang-15
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241121    gcc-11
i386        buildonly-randconfig-002-20241121    gcc-12
i386        buildonly-randconfig-003-20241121    clang-19
i386        buildonly-randconfig-004-20241121    clang-19
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20241121    gcc-14.2.0
loongarch             randconfig-002-20241121    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                          sun3x_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                           ci20_defconfig    clang-20
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20241121    gcc-14.2.0
nios2                 randconfig-002-20241121    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20241121    gcc-14.2.0
parisc                randconfig-002-20241121    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-20
powerpc                   lite5200b_defconfig    clang-14
powerpc                       maple_defconfig    clang-20
powerpc                      pcm030_defconfig    clang-20
powerpc               randconfig-001-20241121    clang-15
powerpc               randconfig-002-20241121    gcc-14.2.0
powerpc               randconfig-003-20241121    clang-20
powerpc64             randconfig-001-20241121    gcc-14.2.0
powerpc64             randconfig-002-20241121    clang-20
powerpc64             randconfig-003-20241121    clang-20
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                               defconfig    clang-20
riscv                 randconfig-001-20241121    gcc-14.2.0
riscv                 randconfig-002-20241121    gcc-14.2.0
s390                             allmodconfig    clang-20
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                          debug_defconfig    gcc-14.2.0
s390                                defconfig    clang-20
s390                  randconfig-001-20241121    gcc-14.2.0
s390                  randconfig-002-20241121    clang-20
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                          polaris_defconfig    gcc-14.2.0
sh                    randconfig-001-20241121    gcc-14.2.0
sh                    randconfig-002-20241121    gcc-14.2.0
sh                           se7722_defconfig    gcc-14.2.0
sh                   secureedge5410_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                       sparc64_defconfig    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20241121    gcc-14.2.0
sparc64               randconfig-002-20241121    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                               allyesconfig    gcc-12
um                                  defconfig    clang-20
um                             i386_defconfig    gcc-12
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241121    clang-19
x86_64      buildonly-randconfig-002-20241121    gcc-12
x86_64      buildonly-randconfig-003-20241121    clang-19
x86_64      buildonly-randconfig-004-20241121    clang-19
x86_64      buildonly-randconfig-005-20241121    clang-19
x86_64      buildonly-randconfig-006-20241121    gcc-12
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                               rhel-9.4    gcc-12
xtensa                            allnoconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

