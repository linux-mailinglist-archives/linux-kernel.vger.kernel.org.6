Return-Path: <linux-kernel+bounces-269970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82985943970
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 01:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E410CB22107
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 23:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D7816D9CB;
	Wed, 31 Jul 2024 23:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MRt/pVRt"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643971BC4E
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 23:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722469209; cv=none; b=OnAnKQP5pZyj1bz8WxQQtniIGC98ahaP95IR2/v5z50XNUePTnt5ebaQDDf+JiouobJpt2BbQcCeDiwpMu70fpb8hK0TGbvy7D+W4HIdLUiHklrSMWEZKDIpO7Q2uw8mEfHSKL+iygR6mMofO2W62vs/+iPxA+RstXKtx6dtnaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722469209; c=relaxed/simple;
	bh=yvshHr3Hz+OavFdRQFkPzo0yOYjTja7rL82rshH74+A=;
	h=Date:From:To:Cc:Subject:Message-ID; b=VK60sO28VWn3k0CYg2gWMXz4y4HnQKCXJvqcQZTh+XHa9DWDC3U2flgabjkZsjSVJyhbDIKL0jFrIZwib/6fquiFC/++xwgl7uXcw7hxlfvZiL6/1ywt3RMginZfjxBsQWb8Mzk4O+BBrUIbOrZY5POhkN4RiInTi1I17fjNUJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MRt/pVRt; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722469208; x=1754005208;
  h=date:from:to:cc:subject:message-id;
  bh=yvshHr3Hz+OavFdRQFkPzo0yOYjTja7rL82rshH74+A=;
  b=MRt/pVRtBLVuTK9DNJW/u/Zz/54weWbOg1UNWYapMJM3tPNdEAjbn4NO
   ihCqiNinI28fu164wVAFznnC0rQqMU7Vy5e+Boh4HMB3JB2uLITj7fs6w
   Aspy5wMnBQ5q9HGCdgPc56meDMY3QshcGitjvKcNbUVuMqU3PXw4cKDru
   3bEdl5NMMuvzBrL1JckFCvcKqthzb2remygeZoGVweOAzMcmBclHF9o5t
   6k5jcdo2ECJDO/WVNR+4ldBBzpUZT3vn0q3adfqTwVlGiLecJzvbXyEAx
   Y8alfMduXdFC/2bI3LAEAqrpdF64Oye+qOV/dNV1Ywaa9kRZYadxgr7mv
   g==;
X-CSE-ConnectionGUID: TrXFFaBiShOVjrNLNL/usw==
X-CSE-MsgGUID: 9RYHOq4pSCmKI70MwW/OZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11150"; a="31775200"
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="31775200"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 16:40:07 -0700
X-CSE-ConnectionGUID: C2xEcVncREq5+4lgb63yIQ==
X-CSE-MsgGUID: sFPhh7beRqWmSzvFBM8PkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="54753743"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 31 Jul 2024 16:40:05 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sZIvL-000uwI-0L;
	Wed, 31 Jul 2024 23:40:03 +0000
Date: Thu, 01 Aug 2024 07:39:49 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2024.07.26a] BUILD SUCCESS
 5cd816c95ea8338d603cdbe75549cf2e406aa70c
Message-ID: <202408010746.t1LsNvXa-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2024.07.26a
branch HEAD: 5cd816c95ea8338d603cdbe75549cf2e406aa70c  refscale: Add test for sched_clock()

elapsed time: 3049m

configs tested: 223
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240731   gcc-13.2.0
arc                   randconfig-002-20240731   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-20
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                              allyesconfig   gcc-14.1.0
arm                        clps711x_defconfig   clang-20
arm                                 defconfig   gcc-13.2.0
arm                       imx_v4_v5_defconfig   clang-16
arm                         nhk8815_defconfig   clang-20
arm                   randconfig-001-20240731   gcc-14.1.0
arm                   randconfig-002-20240731   clang-20
arm                   randconfig-003-20240731   clang-20
arm                   randconfig-004-20240731   gcc-14.1.0
arm                        spear3xx_defconfig   clang-16
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240731   clang-15
arm64                 randconfig-002-20240731   clang-20
arm64                 randconfig-003-20240731   gcc-14.1.0
arm64                 randconfig-004-20240731   clang-20
csky                              allnoconfig   gcc-13.2.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240731   gcc-14.1.0
csky                  randconfig-002-20240731   gcc-14.1.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   clang-20
hexagon                          allyesconfig   clang-20
hexagon               randconfig-001-20240731   clang-16
hexagon               randconfig-002-20240731   clang-20
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-13
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-13
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240731   clang-18
i386         buildonly-randconfig-001-20240801   gcc-9
i386         buildonly-randconfig-002-20240731   clang-18
i386         buildonly-randconfig-002-20240801   gcc-9
i386         buildonly-randconfig-003-20240731   clang-18
i386         buildonly-randconfig-003-20240801   gcc-9
i386         buildonly-randconfig-004-20240731   gcc-13
i386         buildonly-randconfig-004-20240801   gcc-9
i386         buildonly-randconfig-005-20240731   clang-18
i386         buildonly-randconfig-005-20240801   gcc-9
i386         buildonly-randconfig-006-20240731   clang-18
i386         buildonly-randconfig-006-20240801   gcc-9
i386                                defconfig   clang-18
i386                  randconfig-001-20240731   gcc-13
i386                  randconfig-001-20240801   gcc-9
i386                  randconfig-002-20240731   clang-18
i386                  randconfig-002-20240801   gcc-9
i386                  randconfig-003-20240731   clang-18
i386                  randconfig-003-20240801   gcc-9
i386                  randconfig-004-20240731   clang-18
i386                  randconfig-004-20240801   gcc-9
i386                  randconfig-005-20240731   gcc-13
i386                  randconfig-005-20240801   gcc-9
i386                  randconfig-006-20240731   clang-18
i386                  randconfig-006-20240801   gcc-9
i386                  randconfig-011-20240731   gcc-12
i386                  randconfig-011-20240801   gcc-9
i386                  randconfig-012-20240731   gcc-13
i386                  randconfig-012-20240801   gcc-9
i386                  randconfig-013-20240731   clang-18
i386                  randconfig-013-20240801   gcc-9
i386                  randconfig-014-20240731   gcc-8
i386                  randconfig-014-20240801   gcc-9
i386                  randconfig-015-20240731   gcc-10
i386                  randconfig-015-20240801   gcc-9
i386                  randconfig-016-20240731   gcc-13
i386                  randconfig-016-20240801   gcc-9
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240731   gcc-14.1.0
loongarch             randconfig-002-20240731   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
m68k                        mvme147_defconfig   gcc-14.1.0
m68k                        stmark2_defconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-14.1.0
mips                        bcm47xx_defconfig   clang-16
mips                        bcm63xx_defconfig   clang-17
mips                     loongson1b_defconfig   clang-16
mips                      maltaaprp_defconfig   clang-14
mips                           mtx1_defconfig   clang-16
nios2                             allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240731   gcc-14.1.0
nios2                 randconfig-002-20240731   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240731   gcc-14.1.0
parisc                randconfig-002-20240731   gcc-14.1.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-20
powerpc                        fsp2_defconfig   gcc-14.1.0
powerpc                     kmeter1_defconfig   gcc-14.1.0
powerpc               mpc834x_itxgp_defconfig   clang-14
powerpc                 mpc836x_rdk_defconfig   clang-16
powerpc                  mpc866_ads_defconfig   clang-16
powerpc                      pcm030_defconfig   clang-16
powerpc                         ps3_defconfig   clang-16
powerpc               randconfig-001-20240731   clang-20
powerpc               randconfig-002-20240731   gcc-14.1.0
powerpc               randconfig-003-20240731   clang-20
powerpc                  storcenter_defconfig   clang-16
powerpc                         wii_defconfig   clang-16
powerpc64             randconfig-001-20240731   clang-20
powerpc64             randconfig-002-20240731   clang-15
powerpc64             randconfig-003-20240731   clang-20
riscv                            allmodconfig   clang-20
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-20
riscv                               defconfig   clang-20
riscv                               defconfig   gcc-14.1.0
riscv                    nommu_k210_defconfig   clang-16
riscv                    nommu_virt_defconfig   clang-16
riscv                 randconfig-001-20240731   clang-20
riscv                 randconfig-002-20240731   clang-15
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                             allyesconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   clang-20
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240731   gcc-14.1.0
s390                  randconfig-002-20240731   gcc-14.1.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                            hp6xx_defconfig   gcc-14.1.0
sh                    randconfig-001-20240731   gcc-14.1.0
sh                    randconfig-002-20240731   gcc-14.1.0
sh                   rts7751r2dplus_defconfig   gcc-14.1.0
sh                     sh7710voipgw_defconfig   gcc-14.1.0
sh                   sh7770_generic_defconfig   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240731   gcc-14.1.0
sparc64               randconfig-002-20240731   gcc-14.1.0
um                               allmodconfig   clang-20
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-13
um                                  defconfig   clang-20
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-13
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240731   clang-20
um                    randconfig-002-20240731   clang-20
um                           x86_64_defconfig   clang-15
um                           x86_64_defconfig   gcc-14.1.0
x86_64                           alldefconfig   gcc-13
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240731   gcc-13
x86_64       buildonly-randconfig-002-20240731   gcc-13
x86_64       buildonly-randconfig-003-20240731   clang-18
x86_64       buildonly-randconfig-004-20240731   gcc-13
x86_64       buildonly-randconfig-005-20240731   gcc-13
x86_64       buildonly-randconfig-006-20240731   clang-18
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-13
x86_64                                  kexec   clang-18
x86_64                randconfig-001-20240731   gcc-12
x86_64                randconfig-002-20240731   gcc-12
x86_64                randconfig-003-20240731   clang-18
x86_64                randconfig-004-20240731   gcc-10
x86_64                randconfig-005-20240731   gcc-13
x86_64                randconfig-006-20240731   clang-18
x86_64                randconfig-011-20240731   clang-18
x86_64                randconfig-012-20240731   clang-18
x86_64                randconfig-013-20240731   gcc-7
x86_64                randconfig-014-20240731   clang-18
x86_64                randconfig-015-20240731   clang-18
x86_64                randconfig-016-20240731   clang-18
x86_64                randconfig-071-20240731   clang-18
x86_64                randconfig-072-20240731   gcc-13
x86_64                randconfig-073-20240731   clang-18
x86_64                randconfig-074-20240731   clang-18
x86_64                randconfig-075-20240731   clang-18
x86_64                randconfig-076-20240731   clang-18
x86_64                          rhel-8.3-rust   clang-18
x86_64                               rhel-8.3   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240731   gcc-14.1.0
xtensa                randconfig-002-20240731   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

