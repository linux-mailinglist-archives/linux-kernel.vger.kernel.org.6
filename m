Return-Path: <linux-kernel+bounces-556301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F53A5C3CC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 15:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34C5A3A5761
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 14:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3700525BAAA;
	Tue, 11 Mar 2025 14:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AIbBhNI+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5E61E9901
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 14:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741703336; cv=none; b=Ab10mp1TwlG18zb1Uk4zQ9qnqJFqMNTaZGdQq85tEefj4fQJ1HTpxPgEsuUa3cZPJL2WYMbHK98HyJ4XpJL9j3PzUK6TcUpj2bVMC7EzmoH3jOEKt+tb6HYxtzsZoM9F7koVgF8GaOwjbLQF9rgqCff2uQPV1PAAdm7gvWAAppc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741703336; c=relaxed/simple;
	bh=lkyVRIu5ouCGbXfdZyiBnyGCC1JlvbwE4CVFYFOpAio=;
	h=Date:From:To:Cc:Subject:Message-ID; b=PHhP5nGzCFhM3TYQ9MOG4K/8+6jWAavzh+3w2vhaspb4ucBhKAXfOD0AfKJaMPffXo96gKrupGCgHS3P4lsiD7LF5uaKrfUBZ24sDvH2E88E6KycNgVyK0V76l8tzTw1Eaw2ACXMZAAQgzs8dJPbiAgZ+ks4DIZgHSgDODeCYpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AIbBhNI+; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741703335; x=1773239335;
  h=date:from:to:cc:subject:message-id;
  bh=lkyVRIu5ouCGbXfdZyiBnyGCC1JlvbwE4CVFYFOpAio=;
  b=AIbBhNI+1KGnijfnW1D3c64UPj87to/WC+t/DMl9Ph3r0WTs2JeVotHq
   tSMQXYLxvY8gl1qTvnyPrbOn71IXsfj3XIlgj2ccQWPu/gx2+OUCFhm4N
   QDqBlu8v0BxoZIlfOogM0/BRAZEhfmAm+1DLl7m+qnXc0oIgrIHZPxKkz
   HveuLHkTxXYBHPK2m6PTWhbB14Uv0ytzYPh4nLk/dMJLyc3o00BjTnJER
   pMKo4CaqRaoAaHnhm3GRn/GMkhJTEvJoH5+Y8MqlH7bmxsUErWXw2oLNV
   Wrvx/6ek9aKdq3YwysunFJLb6ZA4ezBk92mXNv2XPW5zCoZ6rMAWN/Hwn
   A==;
X-CSE-ConnectionGUID: E02iw/E0SyGDuvnpmGk+mw==
X-CSE-MsgGUID: GtaSKQGxRkmqOpelMjl8wQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="41912294"
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; 
   d="scan'208";a="41912294"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 07:28:54 -0700
X-CSE-ConnectionGUID: 2dsG/bV8Qo2qjBDcpk7pug==
X-CSE-MsgGUID: YJ+wDAZLRJiviAd0vrRmJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; 
   d="scan'208";a="120052132"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 11 Mar 2025 07:28:53 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ts0bC-0006ia-1K;
	Tue, 11 Mar 2025 14:28:50 +0000
Date: Tue, 11 Mar 2025 22:28:45 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:sched/urgent] BUILD SUCCESS
 f3fa0e40df175acd60b71036b9a1fd62310aec03
Message-ID: <202503112239.lc8EMuxt-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/urgent
branch HEAD: f3fa0e40df175acd60b71036b9a1fd62310aec03  sched/clock: Don't define sched_clock_irqtime as static key

elapsed time: 1463m

configs tested: 116
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                         haps_hs_defconfig    gcc-13.2.0
arc                   randconfig-001-20250311    gcc-13.2.0
arc                   randconfig-002-20250311    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                   randconfig-001-20250311    gcc-14.2.0
arm                   randconfig-002-20250311    clang-16
arm                   randconfig-003-20250311    gcc-14.2.0
arm                   randconfig-004-20250311    gcc-14.2.0
arm                        shmobile_defconfig    gcc-14.2.0
arm                          sp7021_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250311    gcc-14.2.0
arm64                 randconfig-002-20250311    gcc-14.2.0
arm64                 randconfig-003-20250311    gcc-14.2.0
arm64                 randconfig-004-20250311    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250311    gcc-14.2.0
csky                  randconfig-002-20250311    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250311    clang-21
hexagon               randconfig-002-20250311    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250311    gcc-12
i386        buildonly-randconfig-002-20250311    clang-19
i386        buildonly-randconfig-003-20250311    clang-19
i386        buildonly-randconfig-004-20250311    clang-19
i386        buildonly-randconfig-005-20250311    clang-19
i386        buildonly-randconfig-006-20250311    gcc-11
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250311    gcc-14.2.0
loongarch             randconfig-002-20250311    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                       m5275evb_defconfig    gcc-14.2.0
m68k                       m5475evb_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                           xway_defconfig    clang-21
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250311    gcc-14.2.0
nios2                 randconfig-002-20250311    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                randconfig-001-20250311    gcc-14.2.0
parisc                randconfig-002-20250311    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                 mpc834x_itx_defconfig    clang-21
powerpc                       ppc64_defconfig    clang-19
powerpc               randconfig-001-20250311    clang-21
powerpc               randconfig-002-20250311    clang-16
powerpc               randconfig-003-20250311    gcc-14.2.0
powerpc64             randconfig-001-20250311    gcc-14.2.0
powerpc64             randconfig-002-20250311    clang-18
powerpc64             randconfig-003-20250311    gcc-14.2.0
riscv                             allnoconfig    gcc-14.2.0
riscv                 randconfig-001-20250311    gcc-14.2.0
riscv                 randconfig-002-20250311    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250311    clang-15
s390                  randconfig-002-20250311    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                         ecovec24_defconfig    gcc-14.2.0
sh                            hp6xx_defconfig    gcc-14.2.0
sh                          landisk_defconfig    gcc-14.2.0
sh                    randconfig-001-20250311    gcc-14.2.0
sh                    randconfig-002-20250311    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250311    gcc-14.2.0
sparc                 randconfig-002-20250311    gcc-14.2.0
sparc64               randconfig-001-20250311    gcc-14.2.0
sparc64               randconfig-002-20250311    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                    randconfig-001-20250311    gcc-12
um                    randconfig-002-20250311    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250311    gcc-12
x86_64      buildonly-randconfig-002-20250311    gcc-12
x86_64      buildonly-randconfig-003-20250311    clang-19
x86_64      buildonly-randconfig-004-20250311    clang-19
x86_64      buildonly-randconfig-005-20250311    gcc-12
x86_64      buildonly-randconfig-006-20250311    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250311    gcc-14.2.0
xtensa                randconfig-002-20250311    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

