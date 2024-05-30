Return-Path: <linux-kernel+bounces-194841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F2B8D42D5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 03:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBCAC1F22353
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 01:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF8D134AC;
	Thu, 30 May 2024 01:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h8QLueQ9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4EE6AB8
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 01:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717032222; cv=none; b=mFei1YXGgtDi8YkB8gTGBGRgtLXV5u8rD3H9luYkDNqqLErvJnK9TgkN4gCeY8PU0KIm6NB3WD8ECDS8wIOBzzUFpEyWVMOgtxYISZ//kq3rDY9rXtc3s89BQk+ET+EDIDMGQnCSrNCZ4Lhcu5aK9r70lX3QbGCoeRbPiBmlXcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717032222; c=relaxed/simple;
	bh=r17vl0EMybqA5Vhyrp1x//PXknNownAfBkAYntb8XAg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=BLNBbSuF1lBNyZmjT30zDZ+w/qaK1UoFCsphdC6zsxTUfWMuYxkBORJHYujT7KymiGzDQmRjvCGE6UiVq2WvXPkhEod37o3wppw/IJ1HKTokjz9kBs8OGGpwVp9zzC0KaZ7WYMAZ3i7pmuUnlbf0kkaRrgZjDoUI/ITjI6hKyps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h8QLueQ9; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717032220; x=1748568220;
  h=date:from:to:cc:subject:message-id;
  bh=r17vl0EMybqA5Vhyrp1x//PXknNownAfBkAYntb8XAg=;
  b=h8QLueQ9RllBYOfFL/b6PliqCAxZTLebJDa7IMUf+6LIstGpVu3bRaFS
   cRhlhOjui0CIMlFZvGE5vi8aXpdxzpt0XvlRQfnoES9XaqDttpw2vdleb
   +juC3t9QWLUrrZmLjB/pSgPuSyXa0e5PPUIUVMFluiRuuDdKgduZUCrg2
   1cpTUMQvIYSHHk3ZsHp+Etoq2oF4OU+ZiLBHOO6ap9Z5MnQ4s9I1Bdfvo
   Fb7mdu/QggD7v53Kt8b3tfUFHLFLIkQrFBNRLn+lSyqcft1ohoG7egBzv
   XO6QtUqA/hFAX79V35YXK4BuaTklvZa3g6dk1hefJfUFSQfRWAXUorIrz
   Q==;
X-CSE-ConnectionGUID: hAjy6cfgTn+nds1soufxaw==
X-CSE-MsgGUID: uzgMeC96Sc6GOBGLqhRWgg==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="13601104"
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="13601104"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 18:23:39 -0700
X-CSE-ConnectionGUID: Owoic4N1SqaPA/nzv7q6Tg==
X-CSE-MsgGUID: V+6sHd/mQMm/k8bLQWd2Wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="36178062"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 29 May 2024 18:23:38 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sCUW0-000EPJ-0f;
	Thu, 30 May 2024 01:23:36 +0000
Date: Thu, 30 May 2024 09:22:52 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 76357cc192acd78b85d4c3380d07f139d906dfe8
Message-ID: <202405300949.cYmqqQsW-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 76357cc192acd78b85d4c3380d07f139d906dfe8  x86/topology/amd: Evaluate SMT in CPUID leaf 0x8000001e only on family 0x17 and greater

elapsed time: 940m

configs tested: 116
configs skipped: 136

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240530   gcc  
arc                   randconfig-002-20240530   gcc  
arm                            hisi_defconfig   gcc  
arm                   randconfig-002-20240530   gcc  
arm                   randconfig-004-20240530   gcc  
arm                    vt8500_v6_v7_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-002-20240530   gcc  
arm64                 randconfig-003-20240530   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240530   gcc  
csky                  randconfig-002-20240530   gcc  
hexagon                          allmodconfig   clang
hexagon                          allyesconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240529   clang
i386         buildonly-randconfig-002-20240529   gcc  
i386         buildonly-randconfig-003-20240529   gcc  
i386         buildonly-randconfig-004-20240529   clang
i386         buildonly-randconfig-005-20240529   gcc  
i386         buildonly-randconfig-006-20240529   clang
i386                                defconfig   clang
i386                  randconfig-001-20240529   clang
i386                  randconfig-002-20240529   gcc  
i386                  randconfig-003-20240529   gcc  
i386                  randconfig-004-20240529   gcc  
i386                  randconfig-005-20240529   clang
i386                  randconfig-006-20240529   clang
i386                  randconfig-011-20240529   clang
i386                  randconfig-012-20240529   clang
i386                  randconfig-013-20240529   clang
i386                  randconfig-014-20240529   gcc  
i386                  randconfig-015-20240529   clang
i386                  randconfig-016-20240529   gcc  
loongarch                        alldefconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240530   gcc  
loongarch             randconfig-002-20240530   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240530   gcc  
nios2                 randconfig-002-20240530   gcc  
openrisc                          allnoconfig   gcc  
openrisc                            defconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240530   gcc  
parisc                randconfig-002-20240530   gcc  
parisc64                            defconfig   gcc  
powerpc                    adder875_defconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc               randconfig-001-20240530   gcc  
powerpc               randconfig-003-20240530   gcc  
powerpc                         wii_defconfig   gcc  
powerpc64             randconfig-001-20240530   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   clang
riscv                 randconfig-002-20240530   gcc  
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240530   gcc  
sh                    randconfig-002-20240530   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240530   gcc  
sparc64               randconfig-002-20240530   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240530   gcc  
um                    randconfig-002-20240530   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                       common_defconfig   gcc  
xtensa                randconfig-001-20240530   gcc  
xtensa                randconfig-002-20240530   gcc  
xtensa                         virt_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

