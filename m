Return-Path: <linux-kernel+bounces-182989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 874AA8C929D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 23:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E68F21F2150A
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 21:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820726CDD5;
	Sat, 18 May 2024 21:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="icmtNSFj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F34DDA6
	for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 21:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716069187; cv=none; b=GEC0enbgcFZaylRgnLNYOuK90+fLXMKzBHu58SPcNXtX3XNf34DEOo8ay7UPURm8QI/duspW/IdvSBlnGxW2YNPoCN5rpQkkLwWTax3FK+aVzr0+dGjj7Sp3ut/fgVhKv83x6S5RhnUkCid0PcjaFz4TdDxkHDhpEae5vHd0OI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716069187; c=relaxed/simple;
	bh=yVYpF02VN59z0QyNmqkn8aaSYz8uocH1ag8XMEvKJyg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Rdz7YR6muadvp4IZjjxjRa9ccfXdFMg1t07kRSTANcy30EdB2YTsrRqC3MizDwuUV1OI5N4hVxKR9buiFHCX4pBdOOP8LAyobvWBm7/AORBHbQJu/gS42/Dx8R2PxJ3uDeEgwgKKgWTuGIYcbbeD7vYkAYYzd/blOa6Jr0n2EzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=icmtNSFj; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716069185; x=1747605185;
  h=date:from:to:cc:subject:message-id;
  bh=yVYpF02VN59z0QyNmqkn8aaSYz8uocH1ag8XMEvKJyg=;
  b=icmtNSFjLqirMKdxUUo+VjPwh1ML7hAFRQ6tUNBiIVMUSoMlyJZS0aq5
   kr4Twm0tarDPh5FK6WDrLiwmx70O7fRyR6bAK3b6W+DAs/YtcA1BIGSO+
   TNozL7nEoOTPFMg46o+rLURMd0Hn+ZZckmi9doCWkp2ltq7tJ1JSJgw+G
   8cPzQ8Dm5dTwDoByuli7RPTmNTKhergzsiC6iMa4H5bDNKrPOKVfKfrev
   0Yx7hpg2HGXXJbkW9REuq+xaXe0so8OJ/M4BsuhymLtMRWlZ+Q6zYoRkC
   EK0FyhgkBB31nhY4YwINUnnjqA4nMh6JQR81+PW7Jb9VLldqmWSzMCS5V
   g==;
X-CSE-ConnectionGUID: +VxR66ZoQL6S7Yh/UwXmcw==
X-CSE-MsgGUID: Xe4fEjG+QnKM8dN+YevHWA==
X-IronPort-AV: E=McAfee;i="6600,9927,11076"; a="29742628"
X-IronPort-AV: E=Sophos;i="6.08,171,1712646000"; 
   d="scan'208";a="29742628"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2024 14:53:05 -0700
X-CSE-ConnectionGUID: KLYNIATRTO6yWucMnKVJsA==
X-CSE-MsgGUID: bmURewMpRLmQVnCKD6Pkcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,171,1712646000"; 
   d="scan'208";a="32157396"
Received: from unknown (HELO 108735ec233b) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 18 May 2024 14:53:03 -0700
Received: from kbuild by 108735ec233b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s8RzB-0002f8-1L;
	Sat, 18 May 2024 21:53:01 +0000
Date: Sun, 19 May 2024 05:52:56 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:perf/urgent] BUILD SUCCESS
 cd84351c8c1baec86342d784feb884ace007d51c
Message-ID: <202405190554.K9mcneCA-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/urgent
branch HEAD: cd84351c8c1baec86342d784feb884ace007d51c  perf/x86/amd: Use try_cmpxchg() in events/amd/{un,}core.c

elapsed time: 725m

configs tested: 158
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
arc                     haps_hs_smp_defconfig   gcc  
arc                   randconfig-001-20240518   gcc  
arc                   randconfig-002-20240518   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                            mps2_defconfig   clang
arm                   randconfig-001-20240518   gcc  
arm                   randconfig-002-20240518   clang
arm                   randconfig-003-20240518   gcc  
arm                   randconfig-004-20240518   gcc  
arm                         vf610m4_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240518   clang
arm64                 randconfig-002-20240518   gcc  
arm64                 randconfig-003-20240518   clang
arm64                 randconfig-004-20240518   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240518   gcc  
csky                  randconfig-002-20240518   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240518   clang
hexagon               randconfig-002-20240518   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386                                defconfig   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240518   gcc  
loongarch             randconfig-002-20240518   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                            mac_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                           gcw0_defconfig   clang
mips                           ip28_defconfig   gcc  
mips                      loongson3_defconfig   gcc  
mips                           mtx1_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240518   gcc  
nios2                 randconfig-002-20240518   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240518   gcc  
parisc                randconfig-002-20240518   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                       eiger_defconfig   clang
powerpc               mpc834x_itxgp_defconfig   clang
powerpc                    mvme5100_defconfig   gcc  
powerpc               randconfig-001-20240518   clang
powerpc               randconfig-002-20240518   clang
powerpc               randconfig-003-20240518   clang
powerpc                     sequoia_defconfig   clang
powerpc64             randconfig-001-20240518   gcc  
powerpc64             randconfig-002-20240518   gcc  
powerpc64             randconfig-003-20240518   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240518   gcc  
riscv                 randconfig-002-20240518   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240518   clang
s390                  randconfig-002-20240518   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                        apsh4ad0a_defconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240518   gcc  
sh                    randconfig-002-20240518   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240518   gcc  
sparc64               randconfig-002-20240518   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240518   clang
um                    randconfig-002-20240518   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240518   gcc  
x86_64       buildonly-randconfig-002-20240518   clang
x86_64       buildonly-randconfig-003-20240518   clang
x86_64       buildonly-randconfig-004-20240518   clang
x86_64       buildonly-randconfig-005-20240518   clang
x86_64       buildonly-randconfig-006-20240518   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240518   clang
x86_64                randconfig-002-20240518   clang
x86_64                randconfig-003-20240518   gcc  
x86_64                randconfig-004-20240518   gcc  
x86_64                randconfig-005-20240518   gcc  
x86_64                randconfig-006-20240518   clang
x86_64                randconfig-011-20240518   gcc  
x86_64                randconfig-012-20240518   gcc  
x86_64                randconfig-013-20240518   clang
x86_64                randconfig-014-20240518   gcc  
x86_64                randconfig-015-20240518   clang
x86_64                randconfig-016-20240518   clang
x86_64                randconfig-071-20240518   clang
x86_64                randconfig-072-20240518   clang
x86_64                randconfig-073-20240518   gcc  
x86_64                randconfig-074-20240518   clang
x86_64                randconfig-075-20240518   gcc  
x86_64                randconfig-076-20240518   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240518   gcc  
xtensa                randconfig-002-20240518   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

