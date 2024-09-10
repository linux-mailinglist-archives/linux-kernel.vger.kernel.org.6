Return-Path: <linux-kernel+bounces-322389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE15972856
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 06:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F39091C23A6F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 04:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0BF14037D;
	Tue, 10 Sep 2024 04:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d4HyFmcR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316C14F218
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 04:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725942570; cv=none; b=gSwXn+/PWdb2GTr7TBbtY8az78MM4zV393PBqWu6Ok3kG0GWwVPArHmU+s2mtaRNsdmlTYSHT9VoWZ93N7NsAgDU79XR7NDCppWQtZ+Uj9909NZ5vhD+bftqQ1UvbUs1U1Wp9fEKJaFCnWlg1UF9E+PeB2ENj4z1MX9sYWsdupA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725942570; c=relaxed/simple;
	bh=KMmaS8nnWTgZhBGo0aCz8QzdP3vGCfT/FcwbdFk/4Ts=;
	h=Date:From:To:Cc:Subject:Message-ID; b=i7+H+v2K7p2iJb3Hs7NqW8VBmnEX8PHmGeI0zFSTWI5SmO2Vx5dcQsO6rYi9kQ7EKG3T/SBgDroJSEyiiZXV9L3TkRVCDxMSsojqGphH9mjDe+h1cQS7mGTJN7nkKiXZeqBvsG4nZZhpxz0HcmdMMH3IGWFLDdunExigbZEBB3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d4HyFmcR; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725942568; x=1757478568;
  h=date:from:to:cc:subject:message-id;
  bh=KMmaS8nnWTgZhBGo0aCz8QzdP3vGCfT/FcwbdFk/4Ts=;
  b=d4HyFmcRgtd6TOhtlBd+19D8eY9TaNDdWUqn/iGrTiUtu2eXCe0JdBvw
   7OLuGhXmLoy5uJebdjqUxUWypZTh9ypIIraMK8ZsZOWfHlHQo9n9homvs
   9kfSVMBB3CEKGMZdtj9yzWWdoAp7tGWnaH5Q66SnsPjGq/wZbZdcjXSY5
   xaE1eenUmUCl0eyM3Z61K0sz4Ut+O14e/BHlgDsweRs5iz14z0mR6t9TO
   PiyqOO+OJhFAdgcBJ+6PJl1wfEoPtGQcFiGOoUKmZuClj7eHfLEcSqmV1
   7zyqqecNN74fDfOEflT3QFMgE4DZPoayidLj2ygNll7GrvuxbD3qUosCq
   w==;
X-CSE-ConnectionGUID: RWId0l4TQvmUSf8dDgj/Bg==
X-CSE-MsgGUID: 5s9LWka9Q0yjntIwF5vawg==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="35263776"
X-IronPort-AV: E=Sophos;i="6.10,216,1719903600"; 
   d="scan'208";a="35263776"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 21:29:28 -0700
X-CSE-ConnectionGUID: ChpXYoFFQiyfz2lFl4zXiw==
X-CSE-MsgGUID: nesgVjLYQsu19vsznq1jYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,216,1719903600"; 
   d="scan'208";a="66848289"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 09 Sep 2024 21:29:27 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1snsVH-00004k-2v;
	Tue, 10 Sep 2024 04:29:23 +0000
Date: Tue, 10 Sep 2024 12:28:30 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:timers/core] BUILD SUCCESS
 ad4890d40229151c3455b47d9c142def8105644c
Message-ID: <202409101228.cpwBuOCz-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
branch HEAD: ad4890d40229151c3455b47d9c142def8105644c  timers: Rename sleep_idle_range() to sleep_range_idle()

elapsed time: 1932m

configs tested: 189
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-14.1.0
alpha                            allyesconfig   clang-20
alpha                               defconfig   gcc-14.1.0
arc                              allmodconfig   clang-20
arc                               allnoconfig   gcc-14.1.0
arc                              allyesconfig   clang-20
arc                                 defconfig   gcc-14.1.0
arc                   randconfig-001-20240909   clang-20
arc                   randconfig-002-20240909   clang-20
arm                              alldefconfig   clang-20
arm                              allmodconfig   clang-20
arm                               allnoconfig   gcc-14.1.0
arm                              allyesconfig   clang-20
arm                         bcm2835_defconfig   clang-20
arm                                 defconfig   gcc-14.1.0
arm                      jornada720_defconfig   clang-20
arm                       multi_v4t_defconfig   clang-20
arm                        mvebu_v7_defconfig   clang-20
arm                   randconfig-001-20240909   clang-20
arm                   randconfig-002-20240909   clang-20
arm                   randconfig-003-20240909   clang-20
arm                   randconfig-004-20240909   clang-20
arm64                            allmodconfig   clang-20
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-14.1.0
arm64                 randconfig-001-20240909   clang-20
arm64                 randconfig-002-20240909   clang-20
arm64                 randconfig-003-20240909   clang-20
arm64                 randconfig-004-20240909   clang-20
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-14.1.0
csky                  randconfig-001-20240909   clang-20
csky                  randconfig-002-20240909   clang-20
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   gcc-14.1.0
hexagon                          allyesconfig   clang-20
hexagon                             defconfig   gcc-14.1.0
hexagon               randconfig-001-20240909   clang-20
hexagon               randconfig-002-20240909   clang-20
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-12
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-12
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240909   clang-18
i386         buildonly-randconfig-002-20240909   clang-18
i386         buildonly-randconfig-002-20240909   gcc-12
i386         buildonly-randconfig-003-20240909   clang-18
i386         buildonly-randconfig-003-20240909   gcc-12
i386         buildonly-randconfig-004-20240909   clang-18
i386         buildonly-randconfig-004-20240909   gcc-12
i386         buildonly-randconfig-005-20240909   clang-18
i386         buildonly-randconfig-006-20240909   clang-18
i386         buildonly-randconfig-006-20240909   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240909   clang-18
i386                  randconfig-002-20240909   clang-18
i386                  randconfig-002-20240909   gcc-12
i386                  randconfig-003-20240909   clang-18
i386                  randconfig-004-20240909   clang-18
i386                  randconfig-004-20240909   gcc-12
i386                  randconfig-005-20240909   clang-18
i386                  randconfig-006-20240909   clang-18
i386                  randconfig-011-20240909   clang-18
i386                  randconfig-012-20240909   clang-18
i386                  randconfig-013-20240909   clang-18
i386                  randconfig-013-20240909   gcc-12
i386                  randconfig-014-20240909   clang-18
i386                  randconfig-015-20240909   clang-18
i386                  randconfig-016-20240909   clang-18
i386                  randconfig-016-20240909   gcc-12
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-14.1.0
loongarch             randconfig-001-20240909   clang-20
loongarch             randconfig-002-20240909   clang-20
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                         amcore_defconfig   clang-20
m68k                                defconfig   gcc-14.1.0
m68k                        m5272c3_defconfig   clang-20
m68k                       m5475evb_defconfig   clang-20
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
mips                           gcw0_defconfig   clang-20
mips                      maltasmvp_defconfig   clang-20
mips                       rbtx49xx_defconfig   clang-20
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-14.1.0
nios2                 randconfig-001-20240909   clang-20
nios2                 randconfig-002-20240909   clang-20
openrisc                          allnoconfig   clang-20
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-12
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   clang-20
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-12
parisc                randconfig-001-20240909   clang-20
parisc                randconfig-002-20240909   clang-20
parisc64                            defconfig   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   clang-20
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   gcc-14.1.0
powerpc                     kmeter1_defconfig   clang-20
powerpc                       maple_defconfig   clang-20
powerpc               randconfig-001-20240909   clang-20
powerpc               randconfig-002-20240909   clang-20
powerpc                    socrates_defconfig   clang-20
powerpc64             randconfig-001-20240909   clang-20
powerpc64             randconfig-002-20240909   clang-20
powerpc64             randconfig-003-20240909   clang-20
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   clang-20
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-12
riscv                 randconfig-001-20240909   clang-20
riscv                 randconfig-002-20240909   clang-20
s390                             allmodconfig   gcc-14.1.0
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                          debug_defconfig   clang-20
s390                                defconfig   gcc-12
s390                  randconfig-001-20240909   clang-20
s390                  randconfig-002-20240909   clang-20
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-12
sh                    randconfig-001-20240909   clang-20
sh                    randconfig-002-20240909   clang-20
sh                           se7780_defconfig   clang-20
sh                              ul2_defconfig   clang-20
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-12
sparc64               randconfig-001-20240909   clang-20
sparc64               randconfig-002-20240909   clang-20
um                               allmodconfig   clang-20
um                                allnoconfig   clang-17
um                                allnoconfig   clang-20
um                               allyesconfig   clang-20
um                                  defconfig   gcc-12
um                             i386_defconfig   gcc-12
um                    randconfig-001-20240909   clang-20
um                    randconfig-002-20240909   clang-20
um                           x86_64_defconfig   gcc-12
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240909   gcc-12
x86_64       buildonly-randconfig-002-20240909   gcc-12
x86_64       buildonly-randconfig-003-20240909   gcc-12
x86_64       buildonly-randconfig-004-20240909   gcc-12
x86_64       buildonly-randconfig-005-20240909   gcc-12
x86_64       buildonly-randconfig-006-20240909   gcc-12
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-11
x86_64                                  kexec   gcc-12
x86_64                randconfig-001-20240909   gcc-12
x86_64                randconfig-002-20240909   gcc-12
x86_64                randconfig-003-20240909   gcc-12
x86_64                randconfig-004-20240909   gcc-12
x86_64                randconfig-005-20240909   gcc-12
x86_64                randconfig-006-20240909   gcc-12
x86_64                randconfig-011-20240909   gcc-12
x86_64                randconfig-012-20240909   gcc-12
x86_64                randconfig-013-20240909   gcc-12
x86_64                randconfig-014-20240909   gcc-12
x86_64                randconfig-015-20240909   gcc-12
x86_64                randconfig-016-20240909   gcc-12
x86_64                randconfig-071-20240909   gcc-12
x86_64                randconfig-072-20240909   gcc-12
x86_64                randconfig-073-20240909   gcc-12
x86_64                randconfig-074-20240909   gcc-12
x86_64                randconfig-075-20240909   gcc-12
x86_64                randconfig-076-20240909   gcc-12
x86_64                          rhel-8.3-rust   clang-18
x86_64                               rhel-8.3   gcc-12
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240909   clang-20
xtensa                randconfig-002-20240909   clang-20

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

