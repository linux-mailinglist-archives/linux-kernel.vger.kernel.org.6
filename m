Return-Path: <linux-kernel+bounces-192094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F748D1851
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 12:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AC321C24B62
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 10:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9351667FE;
	Tue, 28 May 2024 10:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e5K6agjQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FA213C80E
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 10:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716891441; cv=none; b=axpW6zJMoQVfS/Mu9VQuhnDQ4OMoHfPBEWdAS9zIq1o+/1ghoUwLMiMdJogacrBqFJ3cNid0257krx/CzztGFA0FLYCfSvZTwK4MXuLA+ZPF08f0b6mCuCvvDY/GHS1I09jI5BUr0Xd0tfbeWAWGgr30gX2TeuZmGBivZOP6KgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716891441; c=relaxed/simple;
	bh=+OaWaEelS/QqcWhMq3DXLbSQNskSVzo+raH1O8jTCO8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=mOjB4CxAVCrLa9fFatCZzBEi0vslka0Kz6BtEXqU1S5MDxdUDCLCHpJR6kNMjvT72nBKeqnu33aCloouiEfiVVd40bp3jLbfT5+1JOoFs4AgrF/xHsQByR8cK3mRq+KXxsw3hZJzVA/FyJCfhDjti3z/rFdnr0yD7kB/misWLj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e5K6agjQ; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716891440; x=1748427440;
  h=date:from:to:cc:subject:message-id;
  bh=+OaWaEelS/QqcWhMq3DXLbSQNskSVzo+raH1O8jTCO8=;
  b=e5K6agjQQT7yIP0G5ThDQxZHKIAjmWOJMQ/qOeJRFrsyBcXBrhH7gYPp
   4Pn3rE4LxsB/GJwNIV0bKka8izTB22G/k3G4BZvg5l4xC0nQ+jX6ZBba0
   l12/XOZaFq3wiXa5TW9CCgfJ+xEFACYW5Whn437uhhop6h+cD4WFkN4Tm
   XbZSqsCuWY9+c5yTgkNKfJ/WTfznHvm3jZenDFQZsmj74VoQtAEuxqiB9
   WjDOxgkKbywRLz4RYuAw1D1IT7nI5K130bF0QebKyt8IbngyjNH3ZDOww
   N/s0EZX4PfEZSLqUK4xhutACcO8TzGzDie2Uj+ScZgbuNyLGeoRrX2PZd
   g==;
X-CSE-ConnectionGUID: SETPDKLKS2GcmPxqa2waFw==
X-CSE-MsgGUID: 5aS4EnNGQIaDx4CwF+G/Ng==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="17060244"
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="17060244"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 03:17:19 -0700
X-CSE-ConnectionGUID: X7Zx6wUqSi+VfbAIg6/5xw==
X-CSE-MsgGUID: CSKgHENVT3q939fPtAcXVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="35522415"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 28 May 2024 03:17:17 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sBttL-000C2Z-1T;
	Tue, 28 May 2024 10:17:15 +0000
Date: Tue, 28 May 2024 18:17:04 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 f8441cd55885e43eb0d4e8eedc6c5ab15d2dabf1
Message-ID: <202405281802.PQTCh1Lr-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: f8441cd55885e43eb0d4e8eedc6c5ab15d2dabf1  Merge branch into tip/master: 'x86/percpu'

elapsed time: 1150m

configs tested: 200
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                      axs103_smp_defconfig   gcc  
arc                                 defconfig   gcc  
arc                            hsdk_defconfig   gcc  
arc                   randconfig-001-20240528   gcc  
arc                   randconfig-002-20240528   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                     davinci_all_defconfig   clang
arm                                 defconfig   clang
arm                      footbridge_defconfig   clang
arm                      jornada720_defconfig   clang
arm                        multi_v7_defconfig   gcc  
arm                       omap2plus_defconfig   gcc  
arm                   randconfig-001-20240528   gcc  
arm                   randconfig-002-20240528   gcc  
arm                   randconfig-003-20240528   clang
arm                   randconfig-004-20240528   clang
arm                           spitz_defconfig   gcc  
arm64                            alldefconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240528   clang
arm64                 randconfig-002-20240528   clang
arm64                 randconfig-003-20240528   gcc  
arm64                 randconfig-004-20240528   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240528   gcc  
csky                  randconfig-002-20240528   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240528   clang
hexagon               randconfig-002-20240528   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240528   gcc  
i386         buildonly-randconfig-002-20240528   clang
i386         buildonly-randconfig-003-20240528   clang
i386         buildonly-randconfig-004-20240528   clang
i386         buildonly-randconfig-005-20240528   clang
i386         buildonly-randconfig-006-20240528   clang
i386                                defconfig   clang
i386                  randconfig-001-20240528   clang
i386                  randconfig-002-20240528   clang
i386                  randconfig-003-20240528   gcc  
i386                  randconfig-004-20240528   gcc  
i386                  randconfig-005-20240528   gcc  
i386                  randconfig-006-20240528   gcc  
i386                  randconfig-011-20240528   clang
i386                  randconfig-012-20240528   gcc  
i386                  randconfig-013-20240528   gcc  
i386                  randconfig-014-20240528   clang
i386                  randconfig-015-20240528   gcc  
i386                  randconfig-016-20240528   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240528   gcc  
loongarch             randconfig-002-20240528   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5307c3_defconfig   gcc  
m68k                          multi_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                         bigsur_defconfig   gcc  
mips                       bmips_be_defconfig   gcc  
mips                          malta_defconfig   gcc  
nios2                         3c120_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240528   gcc  
nios2                 randconfig-002-20240528   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240528   gcc  
parisc                randconfig-002-20240528   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      arches_defconfig   gcc  
powerpc                     ep8248e_defconfig   gcc  
powerpc                  iss476-smp_defconfig   gcc  
powerpc                      ppc40x_defconfig   clang
powerpc               randconfig-001-20240528   gcc  
powerpc               randconfig-002-20240528   clang
powerpc               randconfig-003-20240528   clang
powerpc                     tqm8555_defconfig   clang
powerpc                     tqm8560_defconfig   gcc  
powerpc                        warp_defconfig   gcc  
powerpc64             randconfig-001-20240528   clang
powerpc64             randconfig-002-20240528   gcc  
powerpc64             randconfig-003-20240528   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv             nommu_k210_sdcard_defconfig   gcc  
riscv                 randconfig-001-20240528   clang
riscv                 randconfig-002-20240528   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240528   gcc  
s390                  randconfig-002-20240528   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                ecovec24-romimage_defconfig   gcc  
sh                         ecovec24_defconfig   gcc  
sh                 kfr2r09-romimage_defconfig   gcc  
sh                            migor_defconfig   gcc  
sh                          polaris_defconfig   gcc  
sh                    randconfig-001-20240528   gcc  
sh                    randconfig-002-20240528   gcc  
sh                          rsk7264_defconfig   gcc  
sh                          sdk7786_defconfig   gcc  
sh                             sh03_defconfig   gcc  
sh                     sh7710voipgw_defconfig   gcc  
sh                             shx3_defconfig   gcc  
sh                            titan_defconfig   gcc  
sh                          urquell_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240528   gcc  
sparc64               randconfig-002-20240528   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240528   gcc  
um                    randconfig-002-20240528   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240528   clang
x86_64       buildonly-randconfig-002-20240528   clang
x86_64       buildonly-randconfig-003-20240528   clang
x86_64       buildonly-randconfig-004-20240528   gcc  
x86_64       buildonly-randconfig-005-20240528   clang
x86_64       buildonly-randconfig-006-20240528   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240528   clang
x86_64                randconfig-002-20240528   clang
x86_64                randconfig-003-20240528   clang
x86_64                randconfig-004-20240528   gcc  
x86_64                randconfig-005-20240528   clang
x86_64                randconfig-006-20240528   gcc  
x86_64                randconfig-011-20240528   gcc  
x86_64                randconfig-012-20240528   gcc  
x86_64                randconfig-013-20240528   clang
x86_64                randconfig-014-20240528   clang
x86_64                randconfig-015-20240528   clang
x86_64                randconfig-016-20240528   gcc  
x86_64                randconfig-071-20240528   clang
x86_64                randconfig-072-20240528   gcc  
x86_64                randconfig-073-20240528   gcc  
x86_64                randconfig-074-20240528   gcc  
x86_64                randconfig-075-20240528   clang
x86_64                randconfig-076-20240528   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                  cadence_csp_defconfig   gcc  
xtensa                          iss_defconfig   gcc  
xtensa                randconfig-001-20240528   gcc  
xtensa                randconfig-002-20240528   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

