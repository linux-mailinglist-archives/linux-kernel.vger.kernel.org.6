Return-Path: <linux-kernel+bounces-180362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 229938C6D73
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 22:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A32C91F21237
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 20:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FABE15B103;
	Wed, 15 May 2024 20:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UBe2uWL/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33EA15ADA7
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 20:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715806570; cv=none; b=aDiRBN+ZD22TiZvYdrs7ygfOnks2Os6ovh4NFlJ799zQL4bVPEAeHI/Q0/NiC26dwJEwfeZWrimBhLarhDGJq49d7UAwJ67ml6ZoOSHH9NfHKwTwxAjbnqvXeMgiRHNGt6stQqf0yVLe76NS3/dMwRtOGYXNj3Hh2HxttpqRqII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715806570; c=relaxed/simple;
	bh=0hZHNS9xos4r/qY4+XeOaPL/fwG3DIeBRjFzyruacnM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=AmGbr47zWxAa4WNfOiiJab2c5a2ezKnIhsjgJIpbg3XJUcj70Gy7w5Gs8v67kZ0TiyYjG7d88DlFSk4AfdrnxrSuWvud2Qjy8YrvVJUiVCh8CsEkTB0VAPftikx5k3Fnoqyw1LBQ0wZaOQddDjLyiavxjdnDXIVmROk1TKiFpTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UBe2uWL/; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715806569; x=1747342569;
  h=date:from:to:cc:subject:message-id;
  bh=0hZHNS9xos4r/qY4+XeOaPL/fwG3DIeBRjFzyruacnM=;
  b=UBe2uWL/3lI1sGqCmFRz2hOWu0y0hM0ANMc3JctwWdG4JLcgQJIZ/XQ6
   J8h67o3u2jhgFk/DHnmGqr9MLQQF/mzH3PJvcCx/aqz6MOGdtOSRbNBhj
   DmFznp4QvJ03xM66gW0+0CpecUtcW4gy2ybp+cZ6dKh1UTETDXZATYe35
   N2m9hdiS3x8CgHcjEAJ2WPVAlJyKKfWhnHphqAvch8TmI6IPlBdcCJfW2
   RszDxgCpvWgBBJVPdd1xnC+10JpzgAEDrzTgiGAiiwvYneOiYIkv3Jzmm
   do6Sa9i4N+EqabTuB39BaDj0uzQ1/48gL6f2BmCHobjHPG41VQKdr9rv/
   A==;
X-CSE-ConnectionGUID: 5gNUSazoQH6gEWkYJj9W5A==
X-CSE-MsgGUID: spaRmMGgT86x+aqcKrQB2Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="22486954"
X-IronPort-AV: E=Sophos;i="6.08,162,1712646000"; 
   d="scan'208";a="22486954"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 13:56:07 -0700
X-CSE-ConnectionGUID: 6wRLPL8RRUyt8xdbnc9mug==
X-CSE-MsgGUID: eO932HQFRKSnkFPuNcyJiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,162,1712646000"; 
   d="scan'208";a="35741332"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 15 May 2024 13:56:06 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s7LfP-000DGK-2D;
	Wed, 15 May 2024 20:56:03 +0000
Date: Thu, 16 May 2024 04:55:05 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 367b87459d918efb1d117f560a82cf8de7f1048b
Message-ID: <202405160403.5efsjH8i-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 367b87459d918efb1d117f560a82cf8de7f1048b  Merge branch into tip/master: 'sched/urgent'

elapsed time: 724m

configs tested: 153
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240515   gcc  
arc                   randconfig-002-20240515   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                          pxa3xx_defconfig   clang
arm                             pxa_defconfig   gcc  
arm                   randconfig-001-20240515   clang
arm                   randconfig-002-20240515   gcc  
arm                   randconfig-003-20240515   clang
arm                   randconfig-004-20240515   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240515   gcc  
arm64                 randconfig-002-20240515   clang
arm64                 randconfig-003-20240515   clang
arm64                 randconfig-004-20240515   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240515   gcc  
csky                  randconfig-002-20240515   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240515   clang
hexagon               randconfig-002-20240515   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240515   gcc  
i386         buildonly-randconfig-002-20240515   gcc  
i386         buildonly-randconfig-003-20240515   gcc  
i386         buildonly-randconfig-004-20240515   gcc  
i386         buildonly-randconfig-005-20240515   gcc  
i386         buildonly-randconfig-006-20240515   clang
i386                                defconfig   clang
i386                  randconfig-001-20240515   clang
i386                  randconfig-002-20240515   gcc  
i386                  randconfig-003-20240515   gcc  
i386                  randconfig-004-20240515   gcc  
i386                  randconfig-005-20240515   clang
i386                  randconfig-006-20240515   gcc  
i386                  randconfig-011-20240515   clang
i386                  randconfig-012-20240515   gcc  
i386                  randconfig-013-20240515   clang
i386                  randconfig-014-20240515   gcc  
i386                  randconfig-015-20240515   gcc  
i386                  randconfig-016-20240515   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240515   gcc  
loongarch             randconfig-002-20240515   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5407c3_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                  cavium_octeon_defconfig   gcc  
mips                           ip32_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240515   gcc  
nios2                 randconfig-002-20240515   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                  or1klitex_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240515   gcc  
parisc                randconfig-002-20240515   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                       maple_defconfig   clang
powerpc                   microwatt_defconfig   gcc  
powerpc                 mpc837x_rdb_defconfig   gcc  
powerpc                      ppc64e_defconfig   gcc  
powerpc               randconfig-001-20240515   clang
powerpc               randconfig-002-20240515   clang
powerpc               randconfig-003-20240515   gcc  
powerpc                    socrates_defconfig   gcc  
powerpc64             randconfig-001-20240515   gcc  
powerpc64             randconfig-002-20240515   clang
powerpc64             randconfig-003-20240515   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                    nommu_virt_defconfig   clang
riscv                 randconfig-001-20240515   clang
riscv                 randconfig-002-20240515   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240515   clang
s390                  randconfig-002-20240515   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240515   gcc  
sh                    randconfig-002-20240515   gcc  
sh                          rsk7201_defconfig   gcc  
sh                           se7780_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240515   gcc  
sparc64               randconfig-002-20240515   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240515   gcc  
um                    randconfig-002-20240515   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240515   gcc  
xtensa                randconfig-002-20240515   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

