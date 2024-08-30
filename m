Return-Path: <linux-kernel+bounces-309413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA60966A1C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 21:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D4F91C218D0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 19:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858691BE24C;
	Fri, 30 Aug 2024 19:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e1MZEcvf"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52CE16DC27
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 19:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725047797; cv=none; b=ThiCyJ1Mq5LAzcg2mI9XQ2B71gLP5nQqDyUml9GM7ZcBQDOrQ7AHe1sAulc47TTF0uZ1BPD7jutJD9+q4+Q6CFHdUpv775n5mVKW0PbmY9O0ajvpoxkcr5acWDyrctwmF8GxQpT4tLc+AigSsFc9Ux/i1pJkuYB7WybPwvR5CoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725047797; c=relaxed/simple;
	bh=cw5ToHrz2SGRIzcmuUfsCNCnA5seAazBj3diV6AdyEM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=n+nwOu87jjJD0ZVSGzzCnR1ATO2tkiWSD2WPnApG2vATLF77wFUnJ9yVaFL6nr7BN24xHDtuZCdfpDUAa26CLa7gTDgZibOqEJRJzFx43T7QZKkXzw8vSsriaOgHqJdpHwSXBq7btWi5FzfebMBQXrendtRypAr0maLpC29JM6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e1MZEcvf; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725047796; x=1756583796;
  h=date:from:to:cc:subject:message-id;
  bh=cw5ToHrz2SGRIzcmuUfsCNCnA5seAazBj3diV6AdyEM=;
  b=e1MZEcvfGL+OBVZKOrttRBoBrDdbFSz6DrJ83jt3CDyqXpKjpg/ynbbV
   yOcJJ1xBipRUElUCSUW+MegCMVvkM0t8nOMYGlo1ap9LfPkWbQ3VvA9gv
   ODqK7CuoB+ojQSzuhmHSZs0JBoeLNLbqIIOeIspvNYafo7FbMxeq7JZNZ
   ygR8vlUkRloeb2hUybQb1mwlaGj+Z0dAeC6ZQnDBYybz7SxnrtWJTmEpL
   ta928pWM/XE+RvR3btbZYAhp9XsUY77uLs8aeKX8EHBMr33XZGiGyD+Rj
   csP00GLVSQpZIPsl+hzM9E3BWkDdO3UepRFfFp1r7RlfEDhvggl61Yt5a
   g==;
X-CSE-ConnectionGUID: a/G5gsXVRQWXmo9hUbBIUw==
X-CSE-MsgGUID: EvsRWrjZTuiNgpYveQgh5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="23858653"
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="23858653"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 12:56:35 -0700
X-CSE-ConnectionGUID: N37+nWn4TNa/kRRTTxDU0Q==
X-CSE-MsgGUID: oZQQdg3FRQGPDqtQNCMkTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="68884075"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 30 Aug 2024 12:56:34 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sk7jU-00022M-0g;
	Fri, 30 Aug 2024 19:56:32 +0000
Date: Sat, 31 Aug 2024 03:56:25 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:timers/core] BUILD SUCCESS
 4381b895f544bb84b8cfb34ada64df67c9b2a4f0
Message-ID: <202408310323.msz11O0f-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
branch HEAD: 4381b895f544bb84b8cfb34ada64df67c9b2a4f0  timers: Remove historical extra jiffie for timeout in msleep()

elapsed time: 1706m

configs tested: 145
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-14.1.0
alpha                               defconfig   gcc-14.1.0
arc                              allmodconfig   clang-20
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-14.1.0
arc                              allyesconfig   clang-20
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-14.1.0
arc                   randconfig-001-20240830   gcc-14.1.0
arc                   randconfig-002-20240830   gcc-14.1.0
arm                              allmodconfig   clang-20
arm                              allmodconfig   gcc-13.2.0
arm                               allnoconfig   gcc-14.1.0
arm                              allyesconfig   clang-20
arm                              allyesconfig   gcc-13.2.0
arm                                 defconfig   gcc-14.1.0
arm                   randconfig-001-20240830   gcc-14.1.0
arm                   randconfig-002-20240830   gcc-14.1.0
arm                   randconfig-003-20240830   gcc-14.1.0
arm                   randconfig-004-20240830   gcc-14.1.0
arm64                            allmodconfig   clang-20
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-14.1.0
arm64                 randconfig-001-20240830   gcc-14.1.0
arm64                 randconfig-002-20240830   gcc-14.1.0
arm64                 randconfig-003-20240830   gcc-14.1.0
arm64                 randconfig-004-20240830   gcc-14.1.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-14.1.0
csky                  randconfig-001-20240830   gcc-14.1.0
csky                  randconfig-002-20240830   gcc-14.1.0
hexagon                           allnoconfig   gcc-14.1.0
hexagon                             defconfig   gcc-14.1.0
hexagon               randconfig-001-20240830   gcc-14.1.0
hexagon               randconfig-002-20240830   gcc-14.1.0
i386                             allmodconfig   clang-18
i386                              allnoconfig   clang-18
i386                             allyesconfig   clang-18
i386         buildonly-randconfig-001-20240830   gcc-12
i386         buildonly-randconfig-002-20240830   gcc-12
i386         buildonly-randconfig-003-20240830   gcc-12
i386         buildonly-randconfig-004-20240830   gcc-12
i386         buildonly-randconfig-005-20240830   gcc-12
i386         buildonly-randconfig-006-20240830   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240830   gcc-12
i386                  randconfig-002-20240830   gcc-12
i386                  randconfig-003-20240830   gcc-12
i386                  randconfig-004-20240830   gcc-12
i386                  randconfig-005-20240830   gcc-12
i386                  randconfig-006-20240830   gcc-12
i386                  randconfig-011-20240830   gcc-12
i386                  randconfig-012-20240830   gcc-12
i386                  randconfig-013-20240830   gcc-12
i386                  randconfig-014-20240830   gcc-12
i386                  randconfig-015-20240830   gcc-12
i386                  randconfig-016-20240830   gcc-12
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-14.1.0
loongarch             randconfig-001-20240830   gcc-14.1.0
loongarch             randconfig-002-20240830   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-14.1.0
nios2                 randconfig-001-20240830   gcc-14.1.0
nios2                 randconfig-002-20240830   gcc-14.1.0
openrisc                          allnoconfig   clang-20
openrisc                            defconfig   gcc-12
parisc                            allnoconfig   clang-20
parisc                              defconfig   gcc-12
parisc                randconfig-001-20240830   gcc-14.1.0
parisc                randconfig-002-20240830   gcc-14.1.0
parisc64                            defconfig   gcc-14.1.0
powerpc                           allnoconfig   clang-20
powerpc               randconfig-001-20240830   gcc-14.1.0
powerpc               randconfig-002-20240830   gcc-14.1.0
powerpc64             randconfig-001-20240830   gcc-14.1.0
powerpc64             randconfig-002-20240830   gcc-14.1.0
powerpc64             randconfig-003-20240830   gcc-14.1.0
riscv                             allnoconfig   clang-20
riscv                               defconfig   gcc-12
riscv                 randconfig-001-20240830   gcc-14.1.0
riscv                 randconfig-002-20240830   gcc-14.1.0
s390                             allmodconfig   gcc-14.1.0
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-12
s390                  randconfig-001-20240830   gcc-14.1.0
s390                  randconfig-002-20240830   gcc-14.1.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-12
sh                    randconfig-001-20240830   gcc-14.1.0
sh                    randconfig-002-20240830   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-12
sparc64               randconfig-001-20240830   gcc-14.1.0
sparc64               randconfig-002-20240830   gcc-14.1.0
um                                allnoconfig   clang-20
um                                  defconfig   gcc-12
um                             i386_defconfig   gcc-12
um                    randconfig-001-20240830   gcc-14.1.0
um                    randconfig-002-20240830   gcc-14.1.0
um                           x86_64_defconfig   gcc-12
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240830   clang-18
x86_64       buildonly-randconfig-002-20240830   clang-18
x86_64       buildonly-randconfig-003-20240830   clang-18
x86_64       buildonly-randconfig-004-20240830   clang-18
x86_64       buildonly-randconfig-005-20240830   clang-18
x86_64       buildonly-randconfig-006-20240830   clang-18
x86_64                              defconfig   clang-18
x86_64                randconfig-001-20240830   clang-18
x86_64                randconfig-002-20240830   clang-18
x86_64                randconfig-003-20240830   clang-18
x86_64                randconfig-004-20240830   clang-18
x86_64                randconfig-005-20240830   clang-18
x86_64                randconfig-006-20240830   clang-18
x86_64                randconfig-011-20240830   clang-18
x86_64                randconfig-012-20240830   clang-18
x86_64                randconfig-013-20240830   clang-18
x86_64                randconfig-014-20240830   clang-18
x86_64                randconfig-015-20240830   clang-18
x86_64                randconfig-016-20240830   clang-18
x86_64                randconfig-071-20240830   clang-18
x86_64                randconfig-072-20240830   clang-18
x86_64                randconfig-073-20240830   clang-18
x86_64                randconfig-074-20240830   clang-18
x86_64                randconfig-075-20240830   clang-18
x86_64                randconfig-076-20240830   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240830   gcc-14.1.0
xtensa                randconfig-002-20240830   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

