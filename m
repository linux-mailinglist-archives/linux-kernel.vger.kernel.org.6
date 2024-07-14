Return-Path: <linux-kernel+bounces-251716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F2E9308C4
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 08:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 082CF1F21679
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 06:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C306911184;
	Sun, 14 Jul 2024 06:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dat+8xRg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DAFF4FB
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 06:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720937646; cv=none; b=Uonn+Yz1yaC49pqJ/0TRmt2WVS0HkngmsypJmuFfTJ9reuhgld+nfvI1Si6KGiLcWs3FsQ1aUB0Rr15USYHXDIye+MC/4Fxh0lPDzym84jcVnrwYjQ2Vo2RbvhmsTgis5PWhWz9vaFwfIb6gH/WUNSDkxZw8rbNYCZLoAuOBBXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720937646; c=relaxed/simple;
	bh=+2yhOYZiZKNBR8EZc9oJDq7mzQ3nvIKZyfkgInveQkw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=JdtMB3xQdJxaNr+cO6dtgWoAng5S8OVK+iCiXgt15Ulk+XNXS6jGsvNy3h3OVA+h9v1h9PrdIi2xWA1HmSfbEFrHSuLP4pL5glxgkX+VukbIHdg30wphGu48oRg2uLcldpT0zYAOEPU9jzuT+CbZPyUpokHiV6Dxb8OnGrHM7iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dat+8xRg; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720937645; x=1752473645;
  h=date:from:to:cc:subject:message-id;
  bh=+2yhOYZiZKNBR8EZc9oJDq7mzQ3nvIKZyfkgInveQkw=;
  b=dat+8xRgGoHfwtp03gz1kK+CLT+e8yc7BmcTrEP1D/1TmSG1Ewrfi9dM
   J+iS3dV+NRyzwskJCuMq0gdDwpwQmcO6GUfCK/tFRyKh8Ch0X9aWitK3q
   CPPBhNouEowoHe+9L0gyWMMuKpcVD3EaZl0LJBD4qwlv15vCr9ymcte+g
   RTObyshiw0jPnmKp6/kYd89s/qxduMw+uvrDAhNYFued3J5BCaS/apFLT
   CKGTIwCyvue6rNYFaJg77w3DfGibjA6+nsNRaG9kTyTHtmgQaGsvgLWMe
   34Z6FkJH3973LNeekgF2pGe8qzZsk88BGCxdqQpCqT2QhrQewz1XCLFIv
   Q==;
X-CSE-ConnectionGUID: nSXfdnHVReCtIXE1rgh3oQ==
X-CSE-MsgGUID: VZ+vPWNoTGuhNCunpBpwIw==
X-IronPort-AV: E=McAfee;i="6700,10204,11132"; a="29730841"
X-IronPort-AV: E=Sophos;i="6.09,207,1716274800"; 
   d="scan'208";a="29730841"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2024 23:14:04 -0700
X-CSE-ConnectionGUID: MjbKAEV5RAyfUHlY1NrDtQ==
X-CSE-MsgGUID: 5XgSfOW8RQKlJ7kPvfm3QQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,207,1716274800"; 
   d="scan'208";a="72521717"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 13 Jul 2024 23:14:03 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sSsUj-000d9S-0M;
	Sun, 14 Jul 2024 06:14:01 +0000
Date: Sun, 14 Jul 2024 14:13:18 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:timers/core] BUILD SUCCESS
 b7625d67eb1a63d33b0a2a4518ce4897d27f7465
Message-ID: <202407141416.IRgWd3gc-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
branch HEAD: b7625d67eb1a63d33b0a2a4518ce4897d27f7465  Merge tag 'timers-v6.11-rc1' of https://git.linaro.org/people/daniel.lezcano/linux into timers/core

elapsed time: 1157m

configs tested: 200
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                        nsim_700_defconfig   gcc-13.2.0
arc                   randconfig-001-20240714   gcc-13.2.0
arc                   randconfig-002-20240714   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                         at91_dt_defconfig   clang-19
arm                                 defconfig   gcc-13.2.0
arm                            dove_defconfig   clang-19
arm                            hisi_defconfig   clang-19
arm                      jornada720_defconfig   clang-19
arm                         lpc18xx_defconfig   gcc-13.2.0
arm                        multi_v5_defconfig   gcc-13.2.0
arm                         orion5x_defconfig   clang-19
arm                   randconfig-001-20240714   gcc-13.2.0
arm                   randconfig-002-20240714   gcc-13.2.0
arm                   randconfig-003-20240714   gcc-13.2.0
arm                   randconfig-004-20240714   gcc-13.2.0
arm                        shmobile_defconfig   clang-19
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240714   gcc-13.2.0
arm64                 randconfig-002-20240714   gcc-13.2.0
arm64                 randconfig-003-20240714   gcc-13.2.0
arm64                 randconfig-004-20240714   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240714   gcc-13.2.0
csky                  randconfig-002-20240714   gcc-13.2.0
hexagon                          allmodconfig   clang-19
hexagon                          allyesconfig   clang-19
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-13
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-13
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240713   clang-18
i386         buildonly-randconfig-001-20240714   gcc-13
i386         buildonly-randconfig-002-20240713   clang-18
i386         buildonly-randconfig-002-20240714   gcc-13
i386         buildonly-randconfig-003-20240713   gcc-8
i386         buildonly-randconfig-003-20240714   gcc-13
i386         buildonly-randconfig-004-20240713   clang-18
i386         buildonly-randconfig-004-20240714   gcc-13
i386         buildonly-randconfig-005-20240713   gcc-13
i386         buildonly-randconfig-005-20240714   gcc-13
i386         buildonly-randconfig-006-20240713   clang-18
i386         buildonly-randconfig-006-20240714   gcc-13
i386                                defconfig   clang-18
i386                  randconfig-001-20240713   gcc-10
i386                  randconfig-001-20240714   gcc-13
i386                  randconfig-002-20240713   gcc-13
i386                  randconfig-002-20240714   gcc-13
i386                  randconfig-003-20240713   gcc-13
i386                  randconfig-003-20240714   gcc-13
i386                  randconfig-004-20240713   clang-18
i386                  randconfig-004-20240714   gcc-13
i386                  randconfig-005-20240713   gcc-10
i386                  randconfig-005-20240714   gcc-13
i386                  randconfig-006-20240713   gcc-12
i386                  randconfig-006-20240714   gcc-13
i386                  randconfig-011-20240713   clang-18
i386                  randconfig-011-20240714   gcc-13
i386                  randconfig-012-20240713   gcc-7
i386                  randconfig-012-20240714   gcc-13
i386                  randconfig-013-20240713   gcc-13
i386                  randconfig-013-20240714   gcc-13
i386                  randconfig-014-20240713   gcc-13
i386                  randconfig-014-20240714   gcc-13
i386                  randconfig-015-20240713   gcc-11
i386                  randconfig-015-20240714   gcc-13
i386                  randconfig-016-20240713   clang-18
i386                  randconfig-016-20240714   gcc-13
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240714   gcc-13.2.0
loongarch             randconfig-002-20240714   gcc-13.2.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
m68k                          multi_defconfig   gcc-13.2.0
microblaze                       alldefconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                         db1xxx_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240714   gcc-13.2.0
nios2                 randconfig-002-20240714   gcc-13.2.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240714   gcc-13.2.0
parisc                randconfig-002-20240714   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   gcc-14.1.0
powerpc                   bluestone_defconfig   gcc-13.2.0
powerpc                      chrp32_defconfig   gcc-13.2.0
powerpc                     kmeter1_defconfig   gcc-13.2.0
powerpc                   lite5200b_defconfig   gcc-13.2.0
powerpc                      pcm030_defconfig   gcc-13.2.0
powerpc                      ppc44x_defconfig   gcc-13.2.0
powerpc               randconfig-001-20240714   gcc-13.2.0
powerpc               randconfig-002-20240714   gcc-13.2.0
powerpc               randconfig-003-20240714   gcc-13.2.0
powerpc                     skiroot_defconfig   clang-19
powerpc                  storcenter_defconfig   clang-19
powerpc64             randconfig-001-20240714   gcc-13.2.0
powerpc64             randconfig-002-20240714   gcc-13.2.0
powerpc64             randconfig-003-20240714   gcc-13.2.0
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-14.1.0
riscv                 randconfig-001-20240714   gcc-13.2.0
riscv                 randconfig-002-20240714   gcc-13.2.0
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                             allyesconfig   clang-19
s390                             allyesconfig   gcc-14.1.0
s390                          debug_defconfig   gcc-13.2.0
s390                                defconfig   clang-19
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240714   gcc-13.2.0
s390                  randconfig-002-20240714   gcc-13.2.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                    randconfig-001-20240714   gcc-13.2.0
sh                    randconfig-002-20240714   gcc-13.2.0
sh                          rsk7264_defconfig   gcc-13.2.0
sh                           se7619_defconfig   gcc-13.2.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240714   gcc-13.2.0
sparc64               randconfig-002-20240714   gcc-13.2.0
um                               allmodconfig   clang-19
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-13
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240714   gcc-13.2.0
um                    randconfig-002-20240714   gcc-13.2.0
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240714   clang-18
x86_64       buildonly-randconfig-002-20240714   clang-18
x86_64       buildonly-randconfig-003-20240714   clang-18
x86_64       buildonly-randconfig-004-20240714   clang-18
x86_64       buildonly-randconfig-005-20240714   clang-18
x86_64       buildonly-randconfig-006-20240714   clang-18
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240714   clang-18
x86_64                randconfig-002-20240714   clang-18
x86_64                randconfig-003-20240714   clang-18
x86_64                randconfig-004-20240714   clang-18
x86_64                randconfig-005-20240714   clang-18
x86_64                randconfig-006-20240714   clang-18
x86_64                randconfig-011-20240714   clang-18
x86_64                randconfig-012-20240714   clang-18
x86_64                randconfig-013-20240714   clang-18
x86_64                randconfig-014-20240714   clang-18
x86_64                randconfig-015-20240714   clang-18
x86_64                randconfig-016-20240714   clang-18
x86_64                randconfig-071-20240714   clang-18
x86_64                randconfig-072-20240714   clang-18
x86_64                randconfig-073-20240714   clang-18
x86_64                randconfig-074-20240714   clang-18
x86_64                randconfig-075-20240714   clang-18
x86_64                randconfig-076-20240714   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                  audio_kc705_defconfig   gcc-13.2.0
xtensa                randconfig-001-20240714   gcc-13.2.0
xtensa                randconfig-002-20240714   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

