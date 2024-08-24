Return-Path: <linux-kernel+bounces-300194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B11B295E02B
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 00:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D9961F21BF9
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 22:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E12813D510;
	Sat, 24 Aug 2024 22:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f9t1piiZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F30C1EA80
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 22:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724536820; cv=none; b=NeZWe2OJcNc9Qt1mCUYPW5hAgIfTUR21sVySrNK1CV1Dku1YgS6+X+KvBKGvfR9FFVqd5jOngJYQp9kqleHtqiH3aRb9aniXNNAZcauHks+RZeRmmwyOmuVo3CllK2uozNs7JaASPNz6LbQ4qViTwwgRAu4KQyDDRrzjiElNz1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724536820; c=relaxed/simple;
	bh=sK7c+mYaTT2xp8+RbYwE6odu850jPhRTPA8FFSsoDrc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Id5nUWs4+QSmSFXwfucDO8vwnmIbN+3YEaBEL8Lg1wLTP+3QSIdGRSVq0VSKxfZHgVdNt6VDWZ+x540H3ROazQM2ndP3l8swRv02OFBk0TPoYP5vgKAn0c8yvns4/wpZlXcPbjbzNu8uPYLTyHhwGlKMHEVBvm2urpiJoPWvOMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f9t1piiZ; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724536819; x=1756072819;
  h=date:from:to:cc:subject:message-id;
  bh=sK7c+mYaTT2xp8+RbYwE6odu850jPhRTPA8FFSsoDrc=;
  b=f9t1piiZ14w55LJ4sSIJjjykbNDZPO8S7kwZ5W0KMscF5cAj3eCpTK5M
   ESnESP09bMqc5MF8IkpEkRUkKi7wSvp/wJABesA6289og/HoS7qSOviOa
   41wsZtuX1hbdulxsOlV3loZGvpX2BKSrfjUlbLf8kA63E+dZg0lTJhf1j
   2q6449Lxebg2oTUdFHCPEDTqxHSW984dM0vARbbI+bsxTtzaGtvlxTE7v
   L9oldxURCs+w5GTO+bBZc492p/dYGkrhOBYsUVItZ1ilcAjt7zHlR2UgH
   OJXqIFG6Z6Ccc8PnceC6ATZS7wLSpOSW9JnGeQ8TxtD005/GIkqg4x8AG
   A==;
X-CSE-ConnectionGUID: tw3uCwO7Q/aTWcriIET51A==
X-CSE-MsgGUID: G8l6mz4xQLuKP6LoErvgNw==
X-IronPort-AV: E=McAfee;i="6700,10204,11173"; a="22959317"
X-IronPort-AV: E=Sophos;i="6.10,174,1719903600"; 
   d="scan'208";a="22959317"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2024 15:00:18 -0700
X-CSE-ConnectionGUID: PI3lz3M8SfeRFOCtuzkizw==
X-CSE-MsgGUID: 5EB3NX/GQgqcE8xe8XRp7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,174,1719903600"; 
   d="scan'208";a="66937967"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 24 Aug 2024 15:00:16 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1shynt-000ElP-1n;
	Sat, 24 Aug 2024 22:00:13 +0000
Date: Sun, 25 Aug 2024 05:59:36 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:timers/core] BUILD SUCCESS WITH WARNING
 42db2c2cb5ac3572380a9489b8f8bbe0e534dfc7
Message-ID: <202408250533.CNcbmAzI-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
branch HEAD: 42db2c2cb5ac3572380a9489b8f8bbe0e534dfc7  timekeeping: Use time_after() in timekeeping_check_update()

Warning reports:

https://lore.kernel.org/oe-kbuild-all/202408241701.NSEI3MOV-lkp@intel.com

Warning: (recently discovered and may have been fixed)

kernel/time/timekeeping.c:220:7: warning: comparison of distinct pointer types ('unsigned long *' and 'typeof (tk->last_warning + (100 * 300)) *' (aka 'long *')) [-Wcompare-distinct-pointer-types]

Warning ids grouped by kconfigs:

recent_errors
|-- arm-randconfig-001-20240825
|   `-- kernel-time-timekeeping.c:warning:comparison-of-distinct-pointer-types-(-unsigned-long-and-typeof-(tk-last_warning-(-))-(aka-long-))
|-- arm64-randconfig-003-20240825
|   `-- kernel-time-timekeeping.c:warning:comparison-of-distinct-pointer-types-(-unsigned-long-and-typeof-(tk-last_warning-(-))-(aka-long-))
|-- hexagon-randconfig-r063-20240825
|   `-- kernel-time-timekeeping.c:warning:comparison-of-distinct-pointer-types-(-unsigned-long-and-typeof-(tk-last_warning-(-))-(aka-long-))
|-- i386-buildonly-randconfig-002-20240824
|   `-- kernel-time-timekeeping.c:warning:comparison-of-distinct-pointer-types-(-unsigned-long-and-typeof-(tk-last_warning-(-))-(aka-long-))
|-- i386-randconfig-002-20240824
|   `-- kernel-time-timekeeping.c:warning:comparison-of-distinct-pointer-types-(-unsigned-long-and-typeof-(tk-last_warning-(-))-(aka-long-))
|-- powerpc-allyesconfig
|   `-- kernel-time-timekeeping.c:warning:comparison-of-distinct-pointer-types-(-unsigned-long-and-typeof-(tk-last_warning-(-))-(aka-long-))
|-- riscv-allmodconfig
|   `-- kernel-time-timekeeping.c:warning:comparison-of-distinct-pointer-types-(-unsigned-long-and-typeof-(tk-last_warning-(-))-(aka-long-))
|-- riscv-allyesconfig
|   `-- kernel-time-timekeeping.c:warning:comparison-of-distinct-pointer-types-(-unsigned-long-and-typeof-(tk-last_warning-(-))-(aka-long-))
|-- riscv-defconfig
|   `-- kernel-time-timekeeping.c:warning:comparison-of-distinct-pointer-types-(-unsigned-long-and-typeof-(tk-last_warning-(-))-(aka-long-))
|-- s390-allmodconfig
|   `-- kernel-time-timekeeping.c:warning:comparison-of-distinct-pointer-types-(-unsigned-long-and-typeof-(tk-last_warning-(-))-(aka-long-))
|-- x86_64-allmodconfig
|   `-- kernel-time-timekeeping.c:warning:comparison-of-distinct-pointer-types-(-unsigned-long-and-typeof-(tk-last_warning-(-))-(aka-long-))
`-- x86_64-allyesconfig
    `-- kernel-time-timekeeping.c:warning:comparison-of-distinct-pointer-types-(-unsigned-long-and-typeof-(tk-last_warning-(-))-(aka-long-))

elapsed time: 1598m

configs tested: 99
configs skipped: 2

tested configs:
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                   randconfig-001-20240825   gcc-13.2.0
arc                   randconfig-002-20240825   gcc-13.2.0
arm                               allnoconfig   clang-20
arm                              allyesconfig   gcc-14.1.0
arm                          ep93xx_defconfig   clang-14
arm                   randconfig-001-20240825   clang-20
arm                   randconfig-002-20240825   gcc-14.1.0
arm                   randconfig-003-20240825   gcc-14.1.0
arm                   randconfig-004-20240825   gcc-14.1.0
arm64                            allmodconfig   clang-20
arm64                             allnoconfig   gcc-14.1.0
arm64                 randconfig-001-20240825   clang-20
arm64                 randconfig-002-20240825   gcc-14.1.0
arm64                 randconfig-003-20240825   clang-20
arm64                 randconfig-004-20240825   gcc-14.1.0
csky                              allnoconfig   gcc-14.1.0
csky                  randconfig-001-20240825   gcc-14.1.0
csky                  randconfig-002-20240825   gcc-14.1.0
hexagon                           allnoconfig   clang-20
hexagon                          allyesconfig   clang-20
hexagon               randconfig-001-20240825   clang-20
hexagon               randconfig-002-20240825   clang-20
i386                             allmodconfig   gcc-12
i386                              allnoconfig   gcc-12
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240824   clang-18
i386         buildonly-randconfig-002-20240824   clang-18
i386         buildonly-randconfig-003-20240824   clang-18
i386         buildonly-randconfig-004-20240824   clang-18
i386         buildonly-randconfig-005-20240824   gcc-12
i386         buildonly-randconfig-006-20240824   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240824   clang-18
i386                  randconfig-002-20240824   clang-18
i386                  randconfig-003-20240824   gcc-12
i386                  randconfig-004-20240824   gcc-11
i386                  randconfig-005-20240824   gcc-12
i386                  randconfig-006-20240824   clang-18
i386                  randconfig-011-20240824   clang-18
i386                  randconfig-012-20240824   gcc-12
i386                  randconfig-013-20240824   gcc-12
i386                  randconfig-014-20240824   gcc-12
i386                  randconfig-015-20240824   gcc-12
i386                  randconfig-016-20240824   gcc-12
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch             randconfig-001-20240825   gcc-14.1.0
loongarch             randconfig-002-20240825   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-14.1.0
nios2                 randconfig-001-20240825   gcc-14.1.0
nios2                 randconfig-002-20240825   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240825   gcc-14.1.0
parisc                randconfig-002-20240825   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc               randconfig-001-20240825   gcc-14.1.0
powerpc               randconfig-002-20240825   gcc-14.1.0
riscv                            allmodconfig   clang-20
riscv                             allnoconfig   gcc-14.1.0
riscv                               defconfig   clang-20
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   clang-20
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
um                               allmodconfig   clang-20
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-12
um                                  defconfig   clang-20
um                             i386_defconfig   gcc-12
um                           x86_64_defconfig   clang-15
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64                              defconfig   gcc-11
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

