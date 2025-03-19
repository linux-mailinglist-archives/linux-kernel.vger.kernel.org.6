Return-Path: <linux-kernel+bounces-567111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D30A68161
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 01:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F7E219C818D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 00:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AEF117BD9;
	Wed, 19 Mar 2025 00:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TiM++P21"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B1417BA6
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 00:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742343535; cv=none; b=uHMLKkRe/wS+CUYMuR0WEHF332Drifqrzchxveb7El+vxNjkFGDN7qgZW4/A4yJfEnGtCl+LBPWpS9hdrYN3ux2LbzjzcYGSAbjh8nWCjquyIUVmMiF3HxS0oqua96teupG73qLdCnz3d/Cjx8JdfPyJ15nnWxDwCG95aLjD7Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742343535; c=relaxed/simple;
	bh=JZi7sgUOQyQ2pk8kHIw2ak668VxGLGpOGwnmn/Sc5y8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=QdjJwQnElPypA/wPEkIUxx/GiOKAOnx5/+KQOAj5B7brWLAgSc6IbfMzpxyn+wyrE7DsqNhvEui/6+ZKk3heoRALwjEGNhD092leU3Ni5PVPTWAzbuRjA/wjlp8zWmcGg8YxYB5gmkUkKtUOuT8+vZ0BRb3Rivf0Fj9CCSSFgAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TiM++P21; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742343534; x=1773879534;
  h=date:from:to:cc:subject:message-id;
  bh=JZi7sgUOQyQ2pk8kHIw2ak668VxGLGpOGwnmn/Sc5y8=;
  b=TiM++P21qqLOC3Nl0qLZV9YRpodufpeEGp08DU11QjM7z5Y5SbHfjhDE
   quT7n6GJuGRGrWK7ZZTWFdwhGgjxJeXAGlrysLMpgMSLiUTrmD8PmAfK4
   CTsdHTLkPtUNW1gKYb9++aJmW1dMfLMvT9zeNFHU2i3wx3+zaKX2QsANg
   c5qJvl/1QSzvgNNBhAYh1h7zXeW8AZb0CETj51AGRRf6yzBQMO2Y2TCPr
   aR7396VHSoSKQMXlY+4zr7leyyJPwCXYN3Hajxn0pdUmGqiE5nE7WfKhk
   mVBJ2faxKZC2s/xVXvfXuQDeW/DG2xqUtF52VNLIvKtIoXI1UzN64EabI
   A==;
X-CSE-ConnectionGUID: TR2Y/ooPR7qqGSz54MVA9g==
X-CSE-MsgGUID: My9OiVeVS/OEcGF/nGvo9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="61038749"
X-IronPort-AV: E=Sophos;i="6.14,258,1736841600"; 
   d="scan'208";a="61038749"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 17:18:53 -0700
X-CSE-ConnectionGUID: jvnL285IRs6l7AWYqXLUKA==
X-CSE-MsgGUID: psk5xiVGSoK2barZXY/bDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,258,1736841600"; 
   d="scan'208";a="122410178"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 18 Mar 2025 17:18:51 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tuh8z-000EFa-1w;
	Wed, 19 Mar 2025 00:18:49 +0000
Date: Wed, 19 Mar 2025 08:18:27 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:WIP.sched/core] BUILD SUCCESS
 4a1349854b0e02c4e40764bdedf3734877ce7c35
Message-ID: <202503190820.iqwZmyNM-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git WIP.sched/core
branch HEAD: 4a1349854b0e02c4e40764bdedf3734877ce7c35  sched/debug: Remove CONFIG_SCHED_DEBUG

elapsed time: 1457m

configs tested: 122
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-9.3.0
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-13.3.0
arc                              allyesconfig    gcc-10.5.0
arc                          axs101_defconfig    gcc-14.2.0
arc                   randconfig-001-20250318    gcc-13.2.0
arc                   randconfig-002-20250318    gcc-13.2.0
arc                           tb10x_defconfig    gcc-11.5.0
arm                              allmodconfig    gcc-13.3.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-14.2.0
arm                   randconfig-001-20250318    gcc-14.2.0
arm                   randconfig-002-20250318    clang-21
arm                   randconfig-003-20250318    gcc-14.2.0
arm                   randconfig-004-20250318    clang-21
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-8.5.0
arm64                 randconfig-001-20250318    clang-21
arm64                 randconfig-002-20250318    clang-14
arm64                 randconfig-003-20250318    gcc-13.3.0
arm64                 randconfig-004-20250318    gcc-6.5.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250318    gcc-14.2.0
csky                  randconfig-002-20250318    gcc-14.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250318    clang-21
hexagon               randconfig-002-20250318    clang-17
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250318    clang-20
i386        buildonly-randconfig-002-20250318    clang-20
i386        buildonly-randconfig-003-20250318    clang-20
i386        buildonly-randconfig-004-20250318    clang-20
i386        buildonly-randconfig-005-20250318    clang-20
i386        buildonly-randconfig-006-20250318    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250318    gcc-14.2.0
loongarch             randconfig-002-20250318    gcc-14.2.0
m68k                             allmodconfig    gcc-8.5.0
m68k                              allnoconfig    gcc-5.5.0
m68k                             allyesconfig    gcc-6.5.0
m68k                        mvme16x_defconfig    gcc-11.5.0
microblaze                       allmodconfig    gcc-9.3.0
microblaze                        allnoconfig    gcc-11.5.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                        bcm47xx_defconfig    clang-18
nios2                         10m50_defconfig    gcc-9.3.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250318    gcc-9.3.0
nios2                 randconfig-002-20250318    gcc-5.5.0
openrisc                         alldefconfig    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-5.5.0
parisc                            allnoconfig    gcc-5.5.0
parisc                           allyesconfig    gcc-9.3.0
parisc                              defconfig    gcc-14.2.0
parisc                generic-64bit_defconfig    gcc-14.2.0
parisc                randconfig-001-20250318    gcc-8.5.0
parisc                randconfig-002-20250318    gcc-14.2.0
powerpc                          allmodconfig    gcc-10.5.0
powerpc                           allnoconfig    gcc-8.5.0
powerpc                          allyesconfig    clang-21
powerpc                     kmeter1_defconfig    gcc-7.5.0
powerpc                     mpc5200_defconfig    clang-21
powerpc                      pcm030_defconfig    clang-15
powerpc                      ppc64e_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250318    clang-21
powerpc               randconfig-002-20250318    clang-21
powerpc               randconfig-003-20250318    gcc-14.2.0
powerpc64             randconfig-001-20250318    clang-21
powerpc64             randconfig-002-20250318    gcc-14.2.0
powerpc64             randconfig-003-20250318    gcc-8.5.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-7.5.0
riscv                            allyesconfig    clang-16
riscv                 randconfig-001-20250318    clang-21
riscv                 randconfig-002-20250318    clang-21
s390                             alldefconfig    gcc-14.2.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-13.2.0
s390                  randconfig-001-20250318    clang-15
s390                  randconfig-002-20250318    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-10.5.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250318    gcc-14.2.0
sh                    randconfig-002-20250318    gcc-7.5.0
sh                          rsk7269_defconfig    gcc-14.2.0
sh                             shx3_defconfig    gcc-5.5.0
sparc                            allmodconfig    gcc-6.5.0
sparc                             allnoconfig    gcc-6.5.0
sparc                 randconfig-001-20250318    gcc-14.2.0
sparc                 randconfig-002-20250318    gcc-14.2.0
sparc64               randconfig-001-20250318    gcc-11.5.0
sparc64               randconfig-002-20250318    gcc-11.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                    randconfig-001-20250318    clang-21
um                    randconfig-002-20250318    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250318    clang-20
x86_64      buildonly-randconfig-002-20250318    clang-20
x86_64      buildonly-randconfig-003-20250318    clang-20
x86_64      buildonly-randconfig-004-20250318    clang-20
x86_64      buildonly-randconfig-005-20250318    gcc-12
x86_64      buildonly-randconfig-006-20250318    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250318    gcc-14.2.0
xtensa                randconfig-002-20250318    gcc-7.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

