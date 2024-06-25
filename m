Return-Path: <linux-kernel+bounces-228145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49200915B71
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 03:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB9701F2145F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 01:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CF515491;
	Tue, 25 Jun 2024 01:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JEcEvPgr"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA02B125BA
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 01:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719277238; cv=none; b=PVD71NCkBXae52mGro9p96oY9ec8wQoUa2WaNECqbVDzCGUw6fMjRnGI83EQ+7ABOZ0HAqNK/fakx2heQn78bhDfNIKhZ+16x07o74PRZ+2nW0XOG/Vlkip46JWYDDAS0AB2nyoQdU78l2C1trNBBlAsq6PLX0uPmH71XcSbcr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719277238; c=relaxed/simple;
	bh=s/HSMzXJC0RMWrzEzWWjXCj/yh27174ih1neqYlQD78=;
	h=Date:From:To:Cc:Subject:Message-ID; b=EKSxwDJnzKQKkXaLM5A7Kbt/h3hdcR/qabyzuorHrRQapoWNv0iB2uT7sGb06GUbyXHCuTpHZLsBE/A8BYIwbg4yp9+6mpwsW1ElQZUpmj8ebMdAI3/qReLmuSaeViS7MvQfhhp8SVmDA9i+p7xVSYeJkqKzXql7IpRDnbfokzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JEcEvPgr; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719277238; x=1750813238;
  h=date:from:to:cc:subject:message-id;
  bh=s/HSMzXJC0RMWrzEzWWjXCj/yh27174ih1neqYlQD78=;
  b=JEcEvPgrn9NKNth7Emi6SLqK/towXQnDe8RUv3t0V2QW0ZnWSER1LJZD
   Cqjc9backGnARxqoOluS4Xx4hnpESfBwD+iWSoRg+AuO+zu5Gq65gzD31
   lS5i7AcWvSE+MNyIkl8Vipt+KxcEhYzZji23zZKim6wHYhRXNvUXjG6ht
   Y2K7Se6ILTZWl9svUljStXevSxfokBoykLt0vKAB2DCgOP9JBwMDta4og
   dMbtHXdgL1KfCfLYyEDy5D2v+JnYKUcOdv+yNlJlk6rq5Gpo3J/QfCfce
   cEQ8zQ4+UGM7lU8BtJ6imiw1DIyVfVxOCv4uHR0GGJmM0nprkShQ55zNP
   g==;
X-CSE-ConnectionGUID: ZowsEnCsQzOT+pBgI/Xwjg==
X-CSE-MsgGUID: VKadQpDMQjqVkVqJfMj/Fg==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="16398872"
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="16398872"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 18:00:37 -0700
X-CSE-ConnectionGUID: AyE5z3GlTj6LukrWKm+AuA==
X-CSE-MsgGUID: ng4LOuFKQ5atc9VqYnlkzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="43543938"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 24 Jun 2024 18:00:35 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sLuXx-000Dsq-0r;
	Tue, 25 Jun 2024 01:00:33 +0000
Date: Tue, 25 Jun 2024 09:00:08 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:non-rcu/next] BUILD SUCCESS
 5bdd17ab5a7259d2da562eab63abab3a6d95adcd
Message-ID: <202406250906.3E4LKkRD-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git non-rcu/next
branch HEAD: 5bdd17ab5a7259d2da562eab63abab3a6d95adcd  rcutorture: Add CFcommon.arch for arch-specific Kconfig options

elapsed time: 1496m

configs tested: 119
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                               defconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240624   gcc-13.2.0
arc                   randconfig-002-20240624   gcc-13.2.0
arm                               allnoconfig   clang-19
arm                                 defconfig   clang-14
arm                   randconfig-001-20240624   clang-17
arm                   randconfig-002-20240624   gcc-13.2.0
arm                   randconfig-003-20240624   gcc-13.2.0
arm                   randconfig-004-20240624   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240624   clang-19
arm64                 randconfig-002-20240624   gcc-13.2.0
arm64                 randconfig-003-20240624   gcc-13.2.0
arm64                 randconfig-004-20240624   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240624   gcc-13.2.0
csky                  randconfig-002-20240624   gcc-13.2.0
hexagon                           allnoconfig   clang-19
hexagon                             defconfig   clang-19
hexagon               randconfig-001-20240624   clang-19
hexagon               randconfig-002-20240624   clang-19
i386         buildonly-randconfig-001-20240624   gcc-8
i386         buildonly-randconfig-002-20240624   gcc-13
i386         buildonly-randconfig-003-20240624   clang-18
i386         buildonly-randconfig-004-20240624   gcc-10
i386         buildonly-randconfig-005-20240624   clang-18
i386         buildonly-randconfig-006-20240624   clang-18
i386                  randconfig-001-20240624   clang-18
i386                  randconfig-002-20240624   clang-18
i386                  randconfig-003-20240624   gcc-13
i386                  randconfig-004-20240624   gcc-13
i386                  randconfig-005-20240624   gcc-13
i386                  randconfig-006-20240624   clang-18
i386                  randconfig-011-20240624   clang-18
i386                  randconfig-012-20240624   clang-18
i386                  randconfig-013-20240624   gcc-9
i386                  randconfig-014-20240624   clang-18
i386                  randconfig-015-20240624   clang-18
i386                  randconfig-016-20240624   gcc-9
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240624   gcc-13.2.0
loongarch             randconfig-002-20240624   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
m68k                                defconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240624   gcc-13.2.0
nios2                 randconfig-002-20240624   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                            defconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                              defconfig   gcc-13.2.0
parisc                randconfig-001-20240624   gcc-13.2.0
parisc                randconfig-002-20240624   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc               randconfig-001-20240624   clang-19
powerpc               randconfig-002-20240624   gcc-13.2.0
powerpc               randconfig-003-20240624   clang-16
powerpc64             randconfig-001-20240624   clang-17
powerpc64             randconfig-002-20240624   clang-19
powerpc64             randconfig-003-20240624   clang-19
riscv                             allnoconfig   gcc-13.2.0
riscv                               defconfig   clang-19
riscv                 randconfig-001-20240624   clang-19
riscv                 randconfig-002-20240624   gcc-13.2.0
s390                              allnoconfig   clang-19
s390                                defconfig   clang-19
s390                  randconfig-001-20240624   clang-15
s390                  randconfig-002-20240624   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                                  defconfig   gcc-13.2.0
sh                    randconfig-001-20240624   gcc-13.2.0
sh                    randconfig-002-20240624   gcc-13.2.0
sparc64                             defconfig   gcc-13.2.0
sparc64               randconfig-001-20240624   gcc-13.2.0
sparc64               randconfig-002-20240624   gcc-13.2.0
um                                allnoconfig   clang-17
um                                  defconfig   clang-19
um                             i386_defconfig   gcc-13
um                    randconfig-001-20240624   clang-19
um                    randconfig-002-20240624   clang-19
um                           x86_64_defconfig   clang-15
x86_64       buildonly-randconfig-001-20240624   gcc-13
x86_64       buildonly-randconfig-002-20240624   gcc-13
x86_64       buildonly-randconfig-003-20240624   clang-18
x86_64       buildonly-randconfig-004-20240624   clang-18
x86_64       buildonly-randconfig-005-20240624   clang-18
x86_64       buildonly-randconfig-006-20240624   clang-18
x86_64                randconfig-001-20240624   clang-18
x86_64                randconfig-002-20240624   clang-18
x86_64                randconfig-003-20240624   clang-18
x86_64                randconfig-004-20240624   clang-18
x86_64                randconfig-005-20240624   gcc-11
x86_64                randconfig-006-20240624   gcc-13
x86_64                randconfig-011-20240624   clang-18
x86_64                randconfig-012-20240624   gcc-8
x86_64                randconfig-013-20240624   clang-18
x86_64                randconfig-014-20240624   gcc-8
x86_64                randconfig-015-20240624   gcc-13
x86_64                randconfig-016-20240624   clang-18
x86_64                randconfig-071-20240624   gcc-10
x86_64                randconfig-072-20240624   gcc-10
x86_64                randconfig-073-20240624   gcc-13
x86_64                randconfig-074-20240624   gcc-13
x86_64                randconfig-075-20240624   gcc-13
x86_64                randconfig-076-20240624   gcc-8
xtensa                            allnoconfig   gcc-13.2.0
xtensa                randconfig-001-20240624   gcc-13.2.0
xtensa                randconfig-002-20240624   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

