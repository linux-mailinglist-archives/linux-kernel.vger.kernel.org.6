Return-Path: <linux-kernel+bounces-204049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 388E98FE382
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C868B26C50
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2744C17DE2C;
	Thu,  6 Jun 2024 09:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WaIOD9c4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A3F17D8B3
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 09:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717667282; cv=none; b=VN08ctuZlfuu3jjg3vFAQLcP2lupzr8PXgFrjuonk3h3Gp6VZtHxGxDUVI+itx/JxjxhFgnQ899CMLUZESpQHaOKfmZ87RXpM8dDZQ1hwxGlanSGTupW0Jn0iy50LihQ3+d2VsKlyZpjM3CsHmFvNVhCZB4IZ1Sv9qxxwWSBUfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717667282; c=relaxed/simple;
	bh=P44SCqXnYAqILQZ490dhmqYQRC4UMBNNcXx9kKgUxUc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=QTeeanDMxwonWuf6VkIiK7XVrqo2flENAgqUobnQbqH5XqXu0tFFePIDM6GEX1uD/L8JbCvDZUCWbmddnVRZAgthaJeBlThID8YBnGtHin0EtUeWSmux1AoW/wHFzEr5dFjm9VcDD2I3vLATT8qrmXXvy6AAI0dOTq8mNkABBWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WaIOD9c4; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717667280; x=1749203280;
  h=date:from:to:cc:subject:message-id;
  bh=P44SCqXnYAqILQZ490dhmqYQRC4UMBNNcXx9kKgUxUc=;
  b=WaIOD9c4y4FwvWRyaosrBf7Sfvr/aAWR4a6kP5EGMzGfBc1iH1/GEsPf
   avQ2IH7XJMJbUaLgsG6G3r9UTWTuK0kUV6nS4BkbZC0KsZ6h5Ge2IEqxf
   ZC473JdW8qbjOfdlDFXuYjrgwh8JV4K1HNkLY+K0JnsqQ2BQo5hhynfF5
   1EGSXqdyqNfbe549WmCR294jsyX10MO+VR6GThtaLtDqWXn0cwwiEd1Ls
   ckYikm/GfdNV/dQN1DUIwZ2uyPWfL6bAc0Wu1p32k9gryHr2Dk75qaT+4
   NrUbzvAP6c1MmLkqpj+ASLsWZ/AbjOePS7QI2aZJSBcfkZ81FfftncNjh
   w==;
X-CSE-ConnectionGUID: +qIlff+xRg2vlPKHKXJmew==
X-CSE-MsgGUID: gDNpNg/lRImqfcB9duu0gQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="25722451"
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; 
   d="scan'208";a="25722451"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 02:47:59 -0700
X-CSE-ConnectionGUID: CruRuyzrQ5atf6ndanXxBg==
X-CSE-MsgGUID: 7C8KdmoISrK8Ku12pT7eXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; 
   d="scan'208";a="75380054"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 06 Jun 2024 02:47:59 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sF9iu-0002w8-1L;
	Thu, 06 Jun 2024 09:47:56 +0000
Date: Thu, 06 Jun 2024 17:47:36 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:WIP.fixes] BUILD SUCCESS
 38fd7f0d3fae7e9c62c5f4e88db52bcb392249fc
Message-ID: <202406061733.aX64OrqX-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git WIP.fixes
branch HEAD: 38fd7f0d3fae7e9c62c5f4e88db52bcb392249fc  tools/perf: Fix build race

elapsed time: 1484m

configs tested: 178
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arc                 nsimosci_hs_smp_defconfig   gcc  
arc                   randconfig-001-20240606   gcc  
arc                   randconfig-002-20240606   gcc  
arm                               allnoconfig   clang
arm                                 defconfig   clang
arm                           omap1_defconfig   gcc  
arm                           sama5_defconfig   gcc  
arm                           stm32_defconfig   gcc  
arm                           tegra_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-002-20240606   gcc  
csky                             alldefconfig   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240606   gcc  
csky                  randconfig-002-20240606   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240605   gcc  
i386         buildonly-randconfig-002-20240605   gcc  
i386         buildonly-randconfig-003-20240605   gcc  
i386         buildonly-randconfig-004-20240605   gcc  
i386         buildonly-randconfig-004-20240606   gcc  
i386         buildonly-randconfig-005-20240605   gcc  
i386         buildonly-randconfig-006-20240605   gcc  
i386         buildonly-randconfig-006-20240606   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240605   gcc  
i386                  randconfig-002-20240605   clang
i386                  randconfig-003-20240605   gcc  
i386                  randconfig-004-20240605   gcc  
i386                  randconfig-005-20240605   gcc  
i386                  randconfig-006-20240605   gcc  
i386                  randconfig-011-20240605   gcc  
i386                  randconfig-012-20240605   gcc  
i386                  randconfig-012-20240606   gcc  
i386                  randconfig-013-20240605   clang
i386                  randconfig-013-20240606   gcc  
i386                  randconfig-014-20240605   clang
i386                  randconfig-014-20240606   gcc  
i386                  randconfig-015-20240605   gcc  
i386                  randconfig-015-20240606   gcc  
i386                  randconfig-016-20240605   clang
i386                  randconfig-016-20240606   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240606   gcc  
loongarch             randconfig-002-20240606   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          amiga_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                          hp300_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                      maltasmvp_defconfig   gcc  
mips                    maltaup_xpa_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240606   gcc  
nios2                 randconfig-002-20240606   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240606   gcc  
parisc                randconfig-002-20240606   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      arches_defconfig   gcc  
powerpc                        icon_defconfig   gcc  
powerpc               randconfig-001-20240606   gcc  
powerpc               randconfig-002-20240606   gcc  
powerpc               randconfig-003-20240606   gcc  
powerpc64             randconfig-003-20240606   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240606   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240606   gcc  
s390                  randconfig-002-20240606   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                     magicpanelr2_defconfig   gcc  
sh                          r7785rp_defconfig   gcc  
sh                    randconfig-001-20240606   gcc  
sh                    randconfig-002-20240606   gcc  
sh                      rts7751r2d1_defconfig   gcc  
sh                          sdk7786_defconfig   gcc  
sh                           se7712_defconfig   gcc  
sh                           se7721_defconfig   gcc  
sh                  sh7785lcr_32bit_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240606   gcc  
sparc64               randconfig-002-20240606   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-002-20240606   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240606   gcc  
x86_64       buildonly-randconfig-002-20240606   clang
x86_64       buildonly-randconfig-003-20240606   gcc  
x86_64       buildonly-randconfig-004-20240606   gcc  
x86_64       buildonly-randconfig-005-20240606   gcc  
x86_64       buildonly-randconfig-006-20240606   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240606   gcc  
x86_64                randconfig-002-20240606   gcc  
x86_64                randconfig-003-20240606   gcc  
x86_64                randconfig-004-20240606   clang
x86_64                randconfig-005-20240606   gcc  
x86_64                randconfig-006-20240606   gcc  
x86_64                randconfig-011-20240606   clang
x86_64                randconfig-012-20240606   gcc  
x86_64                randconfig-013-20240606   clang
x86_64                randconfig-014-20240606   clang
x86_64                randconfig-015-20240606   clang
x86_64                randconfig-016-20240606   clang
x86_64                randconfig-071-20240606   clang
x86_64                randconfig-072-20240606   gcc  
x86_64                randconfig-073-20240606   clang
x86_64                randconfig-074-20240606   clang
x86_64                randconfig-075-20240606   gcc  
x86_64                randconfig-076-20240606   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                  nommu_kc705_defconfig   gcc  
xtensa                randconfig-001-20240606   gcc  
xtensa                randconfig-002-20240606   gcc  
xtensa                    xip_kc705_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

