Return-Path: <linux-kernel+bounces-281296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F022E94D535
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 19:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DBF728249D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 17:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9EB33B1A2;
	Fri,  9 Aug 2024 17:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lpqveCW8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E91A39FC5
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 17:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723223274; cv=none; b=f4H6HoD0ynVY7v5TCntrY5VCHKnhaoqQ062IPPo5MFegO90quirvhZeOjvguL25dGDAM3oq/uGttYQPzbH+ENaspNHXXGl+HJTvGQMkWuyuq1HaYryxwDPg8AvetZuuXZaoTAkN5MnKOKd+OI5llFhAM4W+4soe6pnc+V5iXkX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723223274; c=relaxed/simple;
	bh=a8h/d1A9PM7Aa+WIrBT63rujmInXXrIpgqsneUqYR1M=;
	h=Date:From:To:Cc:Subject:Message-ID; b=CzQaiXDTNvCngE90xxHUkqxyC2nPa9q3DnkyAumZCSqh8biO1WCyoTAyl2AsK6B1KeGEADbKu8r3gT5puGI5+ov1K1J/0/D26ubZYkPYJ1pL5KWMdHJdpdlYN5HXdSHYw8PMY45PP+5TUzgmz/AQxabLe/6trtu2Nyc4lFwybv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lpqveCW8; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723223272; x=1754759272;
  h=date:from:to:cc:subject:message-id;
  bh=a8h/d1A9PM7Aa+WIrBT63rujmInXXrIpgqsneUqYR1M=;
  b=lpqveCW8srQHGgaRHexWoG6dacHV1hABwp8eMrYZd6c3z9JDLdbyowEA
   L95rqVbXvihEtj7wKQAUNoR2QcZkkNoEjL18fv0LFJO/SFdoWFpEUX9rm
   7CN0ggYKGgDB/vYB6dQ+EKzmgBH+MrIUkWKQtrvTCUS7tFE25V4N24eHk
   iVOVtShKKRw/i4+q76c6O+LsX9167VMvu+e9HdDE+rbbJyK1vBYZeWM9e
   kuat57ZzTd3Dzx2aiYh8fGs8afVHQ7YBckWTRBpR6NQeoxHz5j4W8hxhG
   lGE7o+feeY9CQ0cut/au34+d5jrySFWNLhqOBdEvjYiJZ7q3ZWLPLHdro
   g==;
X-CSE-ConnectionGUID: C2fmnCifQnqzbBr/MGlcBA==
X-CSE-MsgGUID: r+wuS9CNSd20sFgwauKVCQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11159"; a="12938355"
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="12938355"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 10:07:51 -0700
X-CSE-ConnectionGUID: GgsGwzx6TeGh+uQglJHe3Q==
X-CSE-MsgGUID: 8SEQeoGdRbiPPQoaVMtZOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="62464587"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 09 Aug 2024 10:07:49 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1scT5f-0008rA-2I;
	Fri, 09 Aug 2024 17:07:47 +0000
Date: Sat, 10 Aug 2024 01:07:11 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/splitlock] BUILD SUCCESS
 408eb7417a92c5354c7be34f7425b305dfe30ad9
Message-ID: <202408100109.vUv4Xfbg-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/splitlock
branch HEAD: 408eb7417a92c5354c7be34f7425b305dfe30ad9  x86/bus_lock: Add support for AMD

elapsed time: 1453m

configs tested: 196
configs skipped: 5

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
arc                   randconfig-001-20240809   gcc-13.2.0
arc                   randconfig-002-20240809   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-20
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                              allyesconfig   gcc-14.1.0
arm                                 defconfig   gcc-13.2.0
arm                           h3600_defconfig   gcc-14.1.0
arm                       imx_v6_v7_defconfig   gcc-14.1.0
arm                        mvebu_v7_defconfig   gcc-14.1.0
arm                   randconfig-001-20240809   gcc-13.2.0
arm                   randconfig-002-20240809   gcc-13.2.0
arm                   randconfig-003-20240809   gcc-13.2.0
arm                   randconfig-004-20240809   gcc-13.2.0
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240809   gcc-13.2.0
arm64                 randconfig-002-20240809   gcc-13.2.0
arm64                 randconfig-003-20240809   gcc-13.2.0
arm64                 randconfig-004-20240809   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240809   gcc-13.2.0
csky                  randconfig-002-20240809   gcc-13.2.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   clang-20
hexagon                          allyesconfig   clang-20
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-12
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-12
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240809   gcc-12
i386         buildonly-randconfig-002-20240809   clang-18
i386         buildonly-randconfig-002-20240809   gcc-12
i386         buildonly-randconfig-003-20240809   gcc-11
i386         buildonly-randconfig-003-20240809   gcc-12
i386         buildonly-randconfig-004-20240809   clang-18
i386         buildonly-randconfig-004-20240809   gcc-12
i386         buildonly-randconfig-005-20240809   clang-18
i386         buildonly-randconfig-005-20240809   gcc-12
i386         buildonly-randconfig-006-20240809   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240809   gcc-12
i386                  randconfig-002-20240809   clang-18
i386                  randconfig-002-20240809   gcc-12
i386                  randconfig-003-20240809   clang-18
i386                  randconfig-003-20240809   gcc-12
i386                  randconfig-004-20240809   gcc-12
i386                  randconfig-005-20240809   clang-18
i386                  randconfig-005-20240809   gcc-12
i386                  randconfig-006-20240809   gcc-12
i386                  randconfig-011-20240809   gcc-12
i386                  randconfig-012-20240809   gcc-12
i386                  randconfig-013-20240809   gcc-12
i386                  randconfig-014-20240809   gcc-12
i386                  randconfig-015-20240809   gcc-11
i386                  randconfig-015-20240809   gcc-12
i386                  randconfig-016-20240809   gcc-12
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240809   gcc-13.2.0
loongarch             randconfig-002-20240809   gcc-13.2.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-14.1.0
mips                     cu1830-neo_defconfig   gcc-14.1.0
mips                          eyeq5_defconfig   gcc-14.1.0
mips                      fuloong2e_defconfig   gcc-14.1.0
mips                           gcw0_defconfig   gcc-14.1.0
mips                     loongson1b_defconfig   gcc-14.1.0
mips                        maltaup_defconfig   gcc-14.1.0
mips                          rm200_defconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240809   gcc-13.2.0
nios2                 randconfig-002-20240809   gcc-13.2.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240809   gcc-13.2.0
parisc                randconfig-002-20240809   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-20
powerpc                          allyesconfig   gcc-14.1.0
powerpc               randconfig-001-20240809   gcc-13.2.0
powerpc64             randconfig-001-20240809   gcc-13.2.0
powerpc64             randconfig-002-20240809   gcc-13.2.0
powerpc64             randconfig-003-20240809   gcc-13.2.0
riscv                            allmodconfig   clang-20
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-20
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-14.1.0
riscv             nommu_k210_sdcard_defconfig   gcc-14.1.0
riscv                 randconfig-001-20240809   gcc-13.2.0
riscv                 randconfig-002-20240809   gcc-13.2.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240809   gcc-13.2.0
s390                  randconfig-002-20240809   gcc-13.2.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                         apsh4a3a_defconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                    randconfig-001-20240809   gcc-13.2.0
sh                    randconfig-002-20240809   gcc-13.2.0
sh                           se7705_defconfig   gcc-14.1.0
sh                   secureedge5410_defconfig   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc                       sparc64_defconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240809   gcc-13.2.0
sparc64               randconfig-002-20240809   gcc-13.2.0
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240809   gcc-13.2.0
um                    randconfig-002-20240809   gcc-13.2.0
um                           x86_64_defconfig   gcc-14.1.0
x86_64                           alldefconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240809   clang-18
x86_64       buildonly-randconfig-002-20240809   clang-18
x86_64       buildonly-randconfig-003-20240809   clang-18
x86_64       buildonly-randconfig-004-20240809   clang-18
x86_64       buildonly-randconfig-005-20240809   clang-18
x86_64       buildonly-randconfig-006-20240809   clang-18
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-11
x86_64                randconfig-001-20240809   clang-18
x86_64                randconfig-002-20240809   clang-18
x86_64                randconfig-003-20240809   clang-18
x86_64                randconfig-004-20240809   clang-18
x86_64                randconfig-005-20240809   clang-18
x86_64                randconfig-006-20240809   clang-18
x86_64                randconfig-011-20240809   clang-18
x86_64                randconfig-012-20240809   clang-18
x86_64                randconfig-013-20240809   clang-18
x86_64                randconfig-014-20240809   clang-18
x86_64                randconfig-015-20240809   clang-18
x86_64                randconfig-016-20240809   clang-18
x86_64                randconfig-071-20240809   clang-18
x86_64                randconfig-072-20240809   clang-18
x86_64                randconfig-073-20240809   clang-18
x86_64                randconfig-074-20240809   clang-18
x86_64                randconfig-075-20240809   clang-18
x86_64                randconfig-076-20240809   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240809   gcc-13.2.0
xtensa                randconfig-002-20240809   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

