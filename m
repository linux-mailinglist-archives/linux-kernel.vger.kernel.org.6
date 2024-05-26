Return-Path: <linux-kernel+bounces-189601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 995B18CF2BB
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 09:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15FF91F21293
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 07:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458C879F9;
	Sun, 26 May 2024 07:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xk86Q/Y8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADBA3D62
	for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 07:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716708062; cv=none; b=OpnQr1/CJGkV/W4UybMxooNhkWk1qDaBMvA+G9daVkDpBsv1Wt6/huFwNcZ/LwFyXHg597XM9IPoY9Hs52qukv6+pAGTB4k+4KgcdIA16FmKsQ0pLxE5O9UfXcuVVoLNxowplIHcmtDUyPiNoiwMCRoxt5ILM5LuMbQ2pGGTkHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716708062; c=relaxed/simple;
	bh=Fygl82woBAyPwXZdkZicDEXoE9M8CDc2Gv0Vlhv9yVo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=hN5G5jY/f/E/TVHydcXo+0pXTCUhCPeXHWrxuVpkRQjug/Dn6u7cYWWGbRTH4nfo5KD9x/rtzLnhueFuVz5cijA+LBBs5WiKWZss9gZL74xMZwTT/nSgMisaoeLi0jLkEq8cU16uWKo65DZpiB3aiGb3jcRiFotildRhqsuraFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xk86Q/Y8; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716708060; x=1748244060;
  h=date:from:to:cc:subject:message-id;
  bh=Fygl82woBAyPwXZdkZicDEXoE9M8CDc2Gv0Vlhv9yVo=;
  b=Xk86Q/Y8jO5pdxfXNHkxN6PdX5rq4YZx5jAcu9UEIH62esUHvY40wG0w
   qaOCY6H0DkLhk+yJK28vP0y9f/Ja5XEKy9RjiI+IE8nbNAyA9heQo5+wh
   oDvqetKJX5xrw1Y+N/HzgxESOTzFsv4MU6lrsEXBe0xLW3vKH5l7bmcT7
   zRYZcso8ef/QYrcs3ptxZC0khkOdKna3TroXL/uNPEk5he/mRUyJOtlWh
   thvog/UFcNWSSxjFCGlwTDf6fhgOvRfcA5OqpRz6boq6GJGcqOZAQQOzb
   QdL7bJEHhLGZdVwbiqP5TMiINL62vViGtot+uMsUlxE0a0xw9NPZhBpld
   A==;
X-CSE-ConnectionGUID: fm0dtODPQ0iKH1R6aq5Zog==
X-CSE-MsgGUID: 7Ijwb9YVQDOILieGPfwjig==
X-IronPort-AV: E=McAfee;i="6600,9927,11083"; a="13262103"
X-IronPort-AV: E=Sophos;i="6.08,189,1712646000"; 
   d="scan'208";a="13262103"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2024 00:20:59 -0700
X-CSE-ConnectionGUID: SZhq9XewSlST1JjNJxq6lA==
X-CSE-MsgGUID: kAB9OYUPSw6eWUV4Yvqv3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,189,1712646000"; 
   d="scan'208";a="34348151"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 26 May 2024 00:20:58 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sB8BJ-0007rP-26;
	Sun, 26 May 2024 07:20:54 +0000
Date: Sun, 26 May 2024 15:18:42 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:locking/urgent] BUILD SUCCESS
 fda570c8796f8fbb3285fb7ac007ace9aabbbb68
Message-ID: <202405261540.f3XlofbS-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/urgent
branch HEAD: fda570c8796f8fbb3285fb7ac007ace9aabbbb68  cleanup: Standardize the header guard define's name

elapsed time: 1116m

configs tested: 178
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
arc                   randconfig-001-20240526   gcc  
arc                   randconfig-002-20240526   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                        clps711x_defconfig   clang
arm                                 defconfig   clang
arm                      integrator_defconfig   clang
arm                        neponset_defconfig   gcc  
arm                       netwinder_defconfig   gcc  
arm                   randconfig-002-20240526   gcc  
arm                   randconfig-004-20240526   gcc  
arm                           sama7_defconfig   clang
arm64                            alldefconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   clang
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240526   gcc  
arm64                 randconfig-003-20240526   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240526   gcc  
csky                  randconfig-002-20240526   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240525   gcc  
i386         buildonly-randconfig-002-20240525   gcc  
i386         buildonly-randconfig-002-20240526   gcc  
i386         buildonly-randconfig-003-20240525   gcc  
i386         buildonly-randconfig-003-20240526   gcc  
i386         buildonly-randconfig-004-20240525   clang
i386         buildonly-randconfig-005-20240525   gcc  
i386         buildonly-randconfig-006-20240525   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240525   clang
i386                  randconfig-002-20240525   gcc  
i386                  randconfig-003-20240525   clang
i386                  randconfig-004-20240525   clang
i386                  randconfig-005-20240525   gcc  
i386                  randconfig-005-20240526   gcc  
i386                  randconfig-006-20240525   gcc  
i386                  randconfig-011-20240525   clang
i386                  randconfig-012-20240525   clang
i386                  randconfig-012-20240526   gcc  
i386                  randconfig-013-20240525   clang
i386                  randconfig-013-20240526   gcc  
i386                  randconfig-014-20240525   gcc  
i386                  randconfig-014-20240526   gcc  
i386                  randconfig-015-20240525   clang
i386                  randconfig-015-20240526   gcc  
i386                  randconfig-016-20240525   gcc  
i386                  randconfig-016-20240526   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch                 loongson3_defconfig   gcc  
loongarch             randconfig-001-20240526   gcc  
loongarch             randconfig-002-20240526   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          atari_defconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                     cu1830-neo_defconfig   gcc  
mips                           xway_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240526   gcc  
nios2                 randconfig-002-20240526   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                    or1ksim_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-32bit_defconfig   gcc  
parisc                randconfig-001-20240526   gcc  
parisc                randconfig-002-20240526   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      arches_defconfig   gcc  
powerpc               randconfig-003-20240526   gcc  
powerpc                     skiroot_defconfig   clang
powerpc64             randconfig-002-20240526   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-002-20240526   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-002-20240526   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                         apsh4a3a_defconfig   gcc  
sh                                  defconfig   gcc  
sh                          lboxre2_defconfig   gcc  
sh                    randconfig-001-20240526   gcc  
sh                    randconfig-002-20240526   gcc  
sh                           se7751_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240526   gcc  
sparc64               randconfig-002-20240526   gcc  
um                               alldefconfig   clang
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240526   clang
x86_64       buildonly-randconfig-002-20240526   clang
x86_64       buildonly-randconfig-003-20240526   gcc  
x86_64       buildonly-randconfig-004-20240526   clang
x86_64       buildonly-randconfig-005-20240526   clang
x86_64       buildonly-randconfig-006-20240526   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240526   clang
x86_64                randconfig-002-20240526   clang
x86_64                randconfig-003-20240526   clang
x86_64                randconfig-004-20240526   gcc  
x86_64                randconfig-005-20240526   gcc  
x86_64                randconfig-006-20240526   clang
x86_64                randconfig-011-20240526   gcc  
x86_64                randconfig-012-20240526   gcc  
x86_64                randconfig-013-20240526   gcc  
x86_64                randconfig-014-20240526   gcc  
x86_64                randconfig-015-20240526   gcc  
x86_64                randconfig-016-20240526   clang
x86_64                randconfig-071-20240526   gcc  
x86_64                randconfig-072-20240526   clang
x86_64                randconfig-073-20240526   clang
x86_64                randconfig-074-20240526   clang
x86_64                randconfig-075-20240526   clang
x86_64                randconfig-076-20240526   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240526   gcc  
xtensa                randconfig-002-20240526   gcc  
xtensa                         virt_defconfig   gcc  
xtensa                    xip_kc705_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

