Return-Path: <linux-kernel+bounces-281737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 034EF94DA95
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 06:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53099B21420
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 04:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B3A13A24E;
	Sat, 10 Aug 2024 04:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jV/jrNBC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873EA17991
	for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 04:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723262636; cv=none; b=NsWW+5etynUv3GD/BM4+8OjAnJ78mIHKgC6lG3+cz3p5LhbnA+fh9JHxWnG9lNUxuMdvlLMcWYokVq/Q4tTFG/7Cwq+tzJDDBe5rtW0P0Dr8iz47K4WLCyw0doQ0eCI+k2OPoc7oFj731NWU6N8unVE1WtYcJ+XQlbOXarEE4HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723262636; c=relaxed/simple;
	bh=IHRePJ5pZWj40qQAflgN8kNVUSH3qflpC1kV5vOrChQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=n251ePnestZQ0yruG2vPh06Fa3jYhaNuGdjYkyUgnBDkU/BedopoEA+Hbwgk4ggobGZsMc/piwIHFTOaxtZHpN9m9idYPz1dp857caqDlOc4gIIXX003DigWpTgpMkkEAUuxIFXgia2WGn4b+y6wbUO/CNZdRpzoLHMvQ3SwLss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jV/jrNBC; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723262634; x=1754798634;
  h=date:from:to:cc:subject:message-id;
  bh=IHRePJ5pZWj40qQAflgN8kNVUSH3qflpC1kV5vOrChQ=;
  b=jV/jrNBCLoNt2HbJxBAXPmn5XY5m1RjvJC/i8Cjr6ifg7sXfbqxxge0u
   gMjKm3CcGHl9JUVRTRsktANhTebC6CHLj0y7qAqRyLK8pKoOI15NRQnmp
   paJuAFq0B+2w5Xe8yidJuLM+6u+tphpcxWtT1l0UNcKa5D0iS4pPRjn/e
   /+alKVQebbcm9WsMqT5bljYr9OY+He/1IHU7GTjQoBUo1+a7B3vt4Wku/
   BDJfnoPrkLmjYmZ7lkmpTMRp64qOB+bi6ydl+Ib88I0nELkTYWpO4GkM+
   jU7/eHdJIR/5/wuxsyGc4kUb406R0vV5HqhuXOoiUIxHjeaOau4HJ/kSj
   A==;
X-CSE-ConnectionGUID: FzoOgYVAS4yimhzsUBBtqQ==
X-CSE-MsgGUID: ufSsbBWxTCakfQyCXg4N8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11159"; a="25215269"
X-IronPort-AV: E=Sophos;i="6.09,278,1716274800"; 
   d="scan'208";a="25215269"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 21:03:53 -0700
X-CSE-ConnectionGUID: yuegWHE7Se+kCNWPdo1vFA==
X-CSE-MsgGUID: Q3ctv/i3ToC6ZIySmFPdhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,278,1716274800"; 
   d="scan'208";a="57720015"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 09 Aug 2024 21:03:53 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1scdKY-0009a7-1n;
	Sat, 10 Aug 2024 04:03:50 +0000
Date: Sat, 10 Aug 2024 12:03:10 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 f5b1803d9d2cfabdd732df77729c9958393f27b4
Message-ID: <202408101208.RFZQkG60-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: f5b1803d9d2cfabdd732df77729c9958393f27b4  Merge branch into tip/master: 'x86/timers'

elapsed time: 1135m

configs tested: 131
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.3.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240810   gcc-13.2.0
arc                   randconfig-002-20240810   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-20
arm                              allyesconfig   gcc-14.1.0
arm                   randconfig-001-20240810   gcc-14.1.0
arm                   randconfig-002-20240810   clang-20
arm                   randconfig-003-20240810   gcc-14.1.0
arm                   randconfig-004-20240810   gcc-14.1.0
arm64                            allmodconfig   clang-20
arm64                             allnoconfig   gcc-14.1.0
arm64                 randconfig-001-20240810   gcc-14.1.0
arm64                 randconfig-002-20240810   clang-20
arm64                 randconfig-003-20240810   clang-20
arm64                 randconfig-004-20240810   gcc-14.1.0
csky                              allnoconfig   gcc-14.1.0
csky                  randconfig-001-20240810   gcc-14.1.0
csky                  randconfig-002-20240810   gcc-14.1.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   clang-20
hexagon                          allyesconfig   clang-20
hexagon               randconfig-001-20240810   clang-20
hexagon               randconfig-002-20240810   clang-14
i386                             allmodconfig   gcc-12
i386                              allnoconfig   gcc-12
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240809   gcc-12
i386         buildonly-randconfig-002-20240809   clang-18
i386         buildonly-randconfig-003-20240809   gcc-11
i386         buildonly-randconfig-004-20240809   clang-18
i386         buildonly-randconfig-005-20240809   clang-18
i386         buildonly-randconfig-006-20240809   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240809   gcc-12
i386                  randconfig-002-20240809   clang-18
i386                  randconfig-003-20240809   clang-18
i386                  randconfig-004-20240809   gcc-12
i386                  randconfig-005-20240809   clang-18
i386                  randconfig-006-20240809   gcc-12
i386                  randconfig-011-20240809   gcc-12
i386                  randconfig-012-20240809   gcc-12
i386                  randconfig-013-20240809   gcc-12
i386                  randconfig-014-20240809   gcc-12
i386                  randconfig-015-20240809   gcc-11
i386                  randconfig-016-20240809   gcc-12
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch             randconfig-001-20240810   gcc-14.1.0
loongarch             randconfig-002-20240810   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-14.1.0
nios2                 randconfig-001-20240810   gcc-14.1.0
nios2                 randconfig-002-20240810   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240810   gcc-14.1.0
parisc                randconfig-002-20240810   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-20
powerpc64             randconfig-001-20240810   gcc-14.1.0
powerpc64             randconfig-002-20240810   clang-20
powerpc64             randconfig-003-20240810   gcc-14.1.0
riscv                            allmodconfig   clang-20
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-20
riscv                               defconfig   clang-20
riscv                 randconfig-001-20240810   clang-20
riscv                 randconfig-002-20240810   gcc-14.1.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   clang-20
s390                  randconfig-001-20240810   gcc-14.1.0
s390                  randconfig-002-20240810   clang-15
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                    randconfig-001-20240810   gcc-14.1.0
sh                    randconfig-002-20240810   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240810   gcc-14.1.0
sparc64               randconfig-002-20240810   gcc-14.1.0
um                               allmodconfig   clang-20
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-12
um                                  defconfig   clang-20
um                             i386_defconfig   gcc-12
um                    randconfig-001-20240810   gcc-12
um                    randconfig-002-20240810   gcc-12
um                           x86_64_defconfig   clang-15
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240810   gcc-12
x86_64       buildonly-randconfig-002-20240810   clang-18
x86_64       buildonly-randconfig-003-20240810   clang-18
x86_64       buildonly-randconfig-004-20240810   clang-18
x86_64       buildonly-randconfig-005-20240810   clang-18
x86_64       buildonly-randconfig-006-20240810   clang-18
x86_64                              defconfig   gcc-11
x86_64                randconfig-001-20240810   clang-18
x86_64                randconfig-002-20240810   clang-18
x86_64                randconfig-003-20240810   gcc-12
x86_64                randconfig-004-20240810   clang-18
x86_64                randconfig-006-20240810   gcc-12
x86_64                randconfig-011-20240810   clang-18
x86_64                randconfig-012-20240810   gcc-12
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240810   gcc-14.1.0
xtensa                randconfig-002-20240810   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

