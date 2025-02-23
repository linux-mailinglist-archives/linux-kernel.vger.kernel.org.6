Return-Path: <linux-kernel+bounces-527768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B373A40F40
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 15:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1724B1712AD
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 14:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07928204F85;
	Sun, 23 Feb 2025 14:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MPrvzUxc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4857518EA2
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 14:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740320701; cv=none; b=dHcFMhOvBxW/sdAJ1nLgyJzc66kZKQ+6TcWuDp4/utMiD5LNaURCdBzMnIozlcGoDrCBzgB0Afty7fGvUbQVZCn9fpkDb0YISOjcvBcNnHpXQiv+Fb6La+C+qeEt4VFBiLOrpV0CYHfkZzZkLnOgzwixkpVrAUBcAcsjU+OELPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740320701; c=relaxed/simple;
	bh=vQHwj6sYRaA/AM8kbRvDnupGmFdI4AN3T/2IwTJcIh4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=NnVXhiMb73AuTSlRb50jKE0h4VY/n70jVbcoMcuHoPIv9ueqfvsLJYAyqi0y7FQEh5W8wvgs84cVihUvl7NWgE4N2nKbbszueUwqDJn5Ai5cBAAodGubQgWQDpbdv+Yxogo/KYANG+ZXksqNQFHiRsym+gy60hukdgBTJMd/6Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MPrvzUxc; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740320700; x=1771856700;
  h=date:from:to:cc:subject:message-id;
  bh=vQHwj6sYRaA/AM8kbRvDnupGmFdI4AN3T/2IwTJcIh4=;
  b=MPrvzUxcRoNN5nfJFzUYNPBwW6augsU2jaLZc5MKEL2kVzH7qFAyYgOb
   xT5Mx84Bthh78xC2o8OIo49A67jYbilE24+tiasGS1PhLPtiTRRpFAk1g
   +h9gXLrgXUJ8m/Rio71O/TSlram3V/IxnplyXQl2/p72f8Vw/uobPPl1n
   MCsuYFBCvoR9TTbpZAawItwbtyT1P1lJKzQB9xUbQhRPTifIz/xPh6Bka
   vCQtzJG6KosCagW1HO6vlDV2bXx0+XyLJ7sFWnuDL4WzCGjm3GQ4XJcpW
   CF1oi0IJNjMUlFb1/R38CyDEmYlnmcUhL8nvy906v9rPDl4bjsS1/4+Ct
   g==;
X-CSE-ConnectionGUID: K9Bbt1dAQn2CkVPuL2lyog==
X-CSE-MsgGUID: EH9WYkYhQA+d6OnbPg6dXA==
X-IronPort-AV: E=McAfee;i="6700,10204,11354"; a="63551669"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="63551669"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2025 06:24:59 -0800
X-CSE-ConnectionGUID: T4iKDhDxSDS4MglI30c/rA==
X-CSE-MsgGUID: 7SckzD+KRRax9qzo6urrhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119940216"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 23 Feb 2025 06:24:57 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tmCud-0007Nr-29;
	Sun, 23 Feb 2025 14:24:55 +0000
Date: Sun, 23 Feb 2025 22:23:24 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD SUCCESS
 3c27b40830cad0917c92fecf0c9cb1ec41de17cc
Message-ID: <202502232218.EuIXLH4k-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
branch HEAD: 3c27b40830cad0917c92fecf0c9cb1ec41de17cc  selftests/rseq: Add rseq syscall errors test

elapsed time: 1449m

configs tested: 136
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250222    gcc-13.2.0
arc                   randconfig-002-20250222    gcc-13.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                     am200epdkit_defconfig    gcc-14.2.0
arm                   randconfig-001-20250222    gcc-14.2.0
arm                   randconfig-002-20250222    gcc-14.2.0
arm                   randconfig-003-20250222    clang-16
arm                   randconfig-004-20250222    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250222    gcc-14.2.0
arm64                 randconfig-002-20250222    clang-21
arm64                 randconfig-003-20250222    clang-18
arm64                 randconfig-004-20250222    clang-21
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250222    gcc-14.2.0
csky                  randconfig-002-20250222    gcc-14.2.0
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250222    clang-17
hexagon               randconfig-002-20250222    clang-19
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386        buildonly-randconfig-001-20250223    clang-19
i386        buildonly-randconfig-002-20250223    gcc-11
i386        buildonly-randconfig-003-20250223    gcc-12
i386        buildonly-randconfig-004-20250223    clang-19
i386        buildonly-randconfig-005-20250223    gcc-12
i386        buildonly-randconfig-006-20250223    gcc-11
i386                  randconfig-001-20250223    clang-19
i386                  randconfig-002-20250223    clang-19
i386                  randconfig-003-20250223    clang-19
i386                  randconfig-004-20250223    clang-19
i386                  randconfig-005-20250223    clang-19
i386                  randconfig-006-20250223    clang-19
i386                  randconfig-007-20250223    clang-19
i386                  randconfig-011-20250223    gcc-12
i386                  randconfig-012-20250223    gcc-12
i386                  randconfig-013-20250223    gcc-12
i386                  randconfig-014-20250223    gcc-12
i386                  randconfig-015-20250223    gcc-12
i386                  randconfig-016-20250223    gcc-12
i386                  randconfig-017-20250223    gcc-12
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250222    gcc-14.2.0
loongarch             randconfig-002-20250222    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                           ip27_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250222    gcc-14.2.0
nios2                 randconfig-002-20250222    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                randconfig-001-20250222    gcc-14.2.0
parisc                randconfig-002-20250222    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                   bluestone_defconfig    clang-21
powerpc                      chrp32_defconfig    clang-21
powerpc                   motionpro_defconfig    clang-17
powerpc               randconfig-001-20250222    gcc-14.2.0
powerpc               randconfig-002-20250222    gcc-14.2.0
powerpc               randconfig-003-20250222    gcc-14.2.0
powerpc64             randconfig-001-20250222    gcc-14.2.0
powerpc64             randconfig-002-20250222    clang-16
powerpc64             randconfig-003-20250222    clang-18
riscv                             allnoconfig    gcc-14.2.0
riscv                 randconfig-001-20250222    clang-21
riscv                 randconfig-002-20250222    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250222    gcc-14.2.0
s390                  randconfig-002-20250222    clang-15
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                         ap325rxa_defconfig    gcc-14.2.0
sh                         ecovec24_defconfig    gcc-14.2.0
sh                    randconfig-001-20250222    gcc-14.2.0
sh                    randconfig-002-20250222    gcc-14.2.0
sh                             shx3_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250222    gcc-14.2.0
sparc                 randconfig-002-20250222    gcc-14.2.0
sparc64               randconfig-001-20250222    gcc-14.2.0
sparc64               randconfig-002-20250222    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                    randconfig-001-20250222    gcc-12
um                    randconfig-002-20250222    gcc-12
x86_64                            allnoconfig    clang-19
x86_64      buildonly-randconfig-001-20250222    clang-19
x86_64      buildonly-randconfig-002-20250222    gcc-12
x86_64      buildonly-randconfig-003-20250222    gcc-12
x86_64      buildonly-randconfig-004-20250222    clang-19
x86_64      buildonly-randconfig-005-20250222    clang-19
x86_64      buildonly-randconfig-006-20250222    gcc-12
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20250223    gcc-11
x86_64                randconfig-002-20250223    gcc-11
x86_64                randconfig-003-20250223    gcc-11
x86_64                randconfig-004-20250223    gcc-11
x86_64                randconfig-005-20250223    gcc-11
x86_64                randconfig-006-20250223    gcc-11
x86_64                randconfig-007-20250223    gcc-11
x86_64                randconfig-008-20250223    gcc-11
x86_64                randconfig-071-20250223    gcc-12
x86_64                randconfig-072-20250223    gcc-12
x86_64                randconfig-073-20250223    gcc-12
x86_64                randconfig-074-20250223    gcc-12
x86_64                randconfig-075-20250223    gcc-12
x86_64                randconfig-076-20250223    gcc-12
x86_64                randconfig-077-20250223    gcc-12
x86_64                randconfig-078-20250223    gcc-12
x86_64                               rhel-9.4    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250222    gcc-14.2.0
xtensa                randconfig-002-20250222    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

