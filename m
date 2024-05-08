Return-Path: <linux-kernel+bounces-172639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A83778BF4BB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 04:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F0A02825BF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 02:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DCB12E5E;
	Wed,  8 May 2024 02:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K70KIWiz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38AA8F4E
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 02:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715136664; cv=none; b=YCqPDFy2B0LdJAxllQnc2bOGeQPnKEtksU3ZdlhzeDAsu5mSF967piNRwHgfD5DZqn5/oHo+fT96c74IxH7dC3TF0LjqhqdDb4qsX6RbjJAHm4e08+f9CFZSjl/VH9aVtcMeiK3F1hRINrU6jgrVDFlAU7RDgkBO4Mgbaw4Za3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715136664; c=relaxed/simple;
	bh=E/a1dyPyuu3tUry8eJwwnps004vxwviwZd6kACoREWg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ZyOfCNQolW/T0AiaY3qen1UwA0GZZIAIuHz6+9VN0ylKcnp83qYB2EOinMFQJ40Qucb1nZhpZkc+lK8GQ3b85hGEqzi9lKSjOwtsAddx/BfxxGrr7fOxAsrQ6N7O7csm6UAGS5a4xDCOttad++GGV4fb8DA4i10Tt4mgAfQod3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K70KIWiz; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715136663; x=1746672663;
  h=date:from:to:cc:subject:message-id;
  bh=E/a1dyPyuu3tUry8eJwwnps004vxwviwZd6kACoREWg=;
  b=K70KIWizyQc/BNy0Kdr8cK/O78BiWiWnnYhB7BNhdmY4B7Q4pvL5U7E6
   YQr88s5jaSEMxLiA0gsMqYcbmvl9N5PKgqrBbDipbGP4410+B+8tbYIoZ
   +/Pb8OL0VGivRnDDWYBl6R2hgqr7rTZ73ixS2bDRqGkbk/7UB8gxlU44b
   2+vhshtVT3HBQ/ex+B+0ylkFz3MyjWcuRWUYmt2CaMYbFfXlCeWFDQ+aY
   1wvnE7Hy4UPkAUqf3uL9o+0A1H2miYyLucRdTKKKw4IoCOga7VlklCElL
   +Gp3wTTnrvGCj5Wukf1NiYmiBfzVd89D4baSnzTrhAvkX4cKQueYB9eT6
   g==;
X-CSE-ConnectionGUID: sTAEYHrMRVOu9V4BMjlL7g==
X-CSE-MsgGUID: nT3ciKtjT8OXROTs1KvVFw==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="11131363"
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="11131363"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 19:51:02 -0700
X-CSE-ConnectionGUID: V3cnHM6QT6CV3OiFzH2Wuw==
X-CSE-MsgGUID: 7ocD329rSQGKU8ljntzkLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="29139492"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 07 May 2024 19:51:01 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s4XOU-0002t6-2A;
	Wed, 08 May 2024 02:50:58 +0000
Date: Wed, 08 May 2024 10:50:41 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/merge] BUILD SUCCESS
 4be3c9105761038a62bf2e36e9a710209a0c1e84
Message-ID: <202405081040.5fjRaEX5-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/merge
branch HEAD: 4be3c9105761038a62bf2e36e9a710209a0c1e84  Merge branch 'x86/alternatives' into x86/merge, to resolve conflict

elapsed time: 1035m

configs tested: 151
configs skipped: 3

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
arc                   randconfig-001-20240508   gcc  
arc                   randconfig-002-20240508   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240508   gcc  
arm                   randconfig-002-20240508   clang
arm                   randconfig-003-20240508   clang
arm                   randconfig-004-20240508   clang
arm                           spitz_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240508   gcc  
arm64                 randconfig-002-20240508   clang
arm64                 randconfig-003-20240508   gcc  
arm64                 randconfig-004-20240508   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240508   gcc  
csky                  randconfig-002-20240508   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240508   clang
hexagon               randconfig-002-20240508   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240508   clang
i386         buildonly-randconfig-002-20240508   clang
i386         buildonly-randconfig-003-20240508   gcc  
i386         buildonly-randconfig-004-20240508   gcc  
i386         buildonly-randconfig-005-20240508   clang
i386         buildonly-randconfig-006-20240508   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240508   gcc  
i386                  randconfig-002-20240508   clang
i386                  randconfig-003-20240508   clang
i386                  randconfig-004-20240508   gcc  
i386                  randconfig-005-20240508   clang
i386                  randconfig-006-20240508   gcc  
i386                  randconfig-011-20240508   gcc  
i386                  randconfig-012-20240508   gcc  
i386                  randconfig-013-20240508   clang
i386                  randconfig-014-20240508   clang
i386                  randconfig-015-20240508   clang
i386                  randconfig-016-20240508   clang
loongarch                        alldefconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240508   gcc  
loongarch             randconfig-002-20240508   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                            mac_defconfig   gcc  
m68k                        mvme16x_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                     cu1000-neo_defconfig   gcc  
mips                     cu1830-neo_defconfig   gcc  
mips                      loongson3_defconfig   gcc  
mips                   sb1250_swarm_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240508   gcc  
nios2                 randconfig-002-20240508   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240508   gcc  
parisc                randconfig-002-20240508   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20240508   clang
powerpc               randconfig-002-20240508   gcc  
powerpc               randconfig-003-20240508   clang
powerpc                     tqm5200_defconfig   gcc  
powerpc64             randconfig-001-20240508   gcc  
powerpc64             randconfig-002-20240508   gcc  
powerpc64             randconfig-003-20240508   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240508   gcc  
riscv                 randconfig-002-20240508   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240508   clang
s390                  randconfig-002-20240508   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                          polaris_defconfig   gcc  
sh                    randconfig-001-20240508   gcc  
sh                    randconfig-002-20240508   gcc  
sh                        sh7785lcr_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc                       sparc32_defconfig   gcc  
sparc                       sparc64_defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240508   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240508   clang
x86_64       buildonly-randconfig-003-20240508   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                  audio_kc705_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

