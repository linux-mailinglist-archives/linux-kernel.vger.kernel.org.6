Return-Path: <linux-kernel+bounces-383874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C39B9B213C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 00:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B69D1C21402
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 23:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90629166F1A;
	Sun, 27 Oct 2024 23:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rhj1jR7T"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0941057C9F
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 23:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730070061; cv=none; b=to4j3O1j5ZTTHQxdp4Qa9FoAf9pmTw5bPGBO7dh6vZWzyhtXX1/9bC3ReYTCLNg4KsKakJshyKoOLop93oC32nko0lto11ELDJ48tu8xiY5uR+iLQet3con+qhoTQf9xxw4nO80TZWtTC8MUR7HbopDPlhEPtW27mbY0410/ON4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730070061; c=relaxed/simple;
	bh=5/WNSFY+wR2nqml/+Pd1Ghi1CYg+oDkns03yQoqcU3c=;
	h=Date:From:To:Cc:Subject:Message-ID; b=qNMrN0rW978Wn1XRxaYAkJ+bXKn2L8rByoFAx3QXHg47+xoWB0kkyFLTjTr69EMI9YQQNxkSfRH4vrh9oWNjyw9fUlFqQjMBSo947tRj2GXh+jBswjGMH+yhC4Bp+184EOnxpcc+WJde96Jp5bow9EQ2/oKk4GtTOFJU4NltV00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rhj1jR7T; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730070059; x=1761606059;
  h=date:from:to:cc:subject:message-id;
  bh=5/WNSFY+wR2nqml/+Pd1Ghi1CYg+oDkns03yQoqcU3c=;
  b=Rhj1jR7TRyIR0Opb/YVwV7gzSbidfGHO9vJHjDEihf1YRMkQkZBVJEAw
   gZqzoF6QG6i2sZCijILV3+jXnowDE6LhT+MUeWq4bdbJZaMn6IAxxxA0P
   4N5MhqK7F3T/jw7mpuJwXY8VMB8WZ6Ud4OJAAcoojkwGF+UP9+l0bukPX
   ab2lfUp3BHPaBoHzoUUgoNKLpaud2Vy1rZXp/QSFFpciodZqjQWLCKo2Y
   Z9cl1RJuwMj8IeeZ2FqNJkW+5oAmgupAfIgnRg2cZwtg/Hc8r8ZKEGABa
   cGkVfBRQ8gv+Sru+wVWTCOfraIRhmkLzlAgA8NAw2SwrAAsh9+Yw5guHz
   w==;
X-CSE-ConnectionGUID: 0F5/1u1OTvqZT8UDRpJBYQ==
X-CSE-MsgGUID: 71sFtc/rQH+XiZT6bbVArw==
X-IronPort-AV: E=McAfee;i="6700,10204,11238"; a="41029966"
X-IronPort-AV: E=Sophos;i="6.11,237,1725346800"; 
   d="scan'208";a="41029966"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2024 16:00:59 -0700
X-CSE-ConnectionGUID: 369bQv27QrWyigPKRQat+g==
X-CSE-MsgGUID: 0eXN6qUCRmOti9FqM8q3cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,237,1725346800"; 
   d="scan'208";a="86550044"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 27 Oct 2024 16:00:57 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t5CFi-000b3w-2y;
	Sun, 27 Oct 2024 23:00:54 +0000
Date: Mon, 28 Oct 2024 07:00:17 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:timers/urgent] BUILD SUCCESS
 b5413156bad91dc2995a5c4eab1b05e56914638a
Message-ID: <202410280705.LdZxVTDG-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/urgent
branch HEAD: b5413156bad91dc2995a5c4eab1b05e56914638a  posix-cpu-timers: Clear TICK_DEP_BIT_POSIX_TIMER on clone

elapsed time: 725m

configs tested: 202
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-13.3.0
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                            allyesconfig    gcc-13.3.0
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-14.1.0
arc                   randconfig-001-20241027    gcc-13.2.0
arc                   randconfig-002-20241027    gcc-13.2.0
arc                           tb10x_defconfig    clang-20
arm                              allmodconfig    gcc-14.1.0
arm                               allnoconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    gcc-14.1.0
arm                                 defconfig    gcc-14.1.0
arm                          ep93xx_defconfig    clang-20
arm                         nhk8815_defconfig    clang-20
arm                   randconfig-001-20241027    clang-20
arm                   randconfig-002-20241027    clang-20
arm                   randconfig-003-20241027    gcc-14.1.0
arm                   randconfig-004-20241027    clang-20
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
arm64                 randconfig-001-20241027    gcc-14.1.0
arm64                 randconfig-002-20241027    clang-20
arm64                 randconfig-003-20241027    gcc-14.1.0
arm64                 randconfig-004-20241027    clang-16
csky                             alldefconfig    clang-20
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
csky                  randconfig-001-20241027    gcc-14.1.0
csky                  randconfig-002-20241027    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
hexagon               randconfig-001-20241027    clang-20
hexagon               randconfig-002-20241027    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241027    gcc-12
i386        buildonly-randconfig-001-20241028    clang-19
i386        buildonly-randconfig-002-20241027    gcc-12
i386        buildonly-randconfig-002-20241028    clang-19
i386        buildonly-randconfig-003-20241027    clang-19
i386        buildonly-randconfig-003-20241028    clang-19
i386        buildonly-randconfig-004-20241027    gcc-12
i386        buildonly-randconfig-004-20241028    clang-19
i386        buildonly-randconfig-005-20241027    clang-19
i386        buildonly-randconfig-005-20241028    clang-19
i386        buildonly-randconfig-006-20241027    gcc-12
i386        buildonly-randconfig-006-20241028    clang-19
i386                                defconfig    clang-19
i386                  randconfig-001-20241027    gcc-12
i386                  randconfig-001-20241028    clang-19
i386                  randconfig-002-20241027    clang-19
i386                  randconfig-002-20241028    clang-19
i386                  randconfig-003-20241027    gcc-12
i386                  randconfig-003-20241028    clang-19
i386                  randconfig-004-20241027    gcc-12
i386                  randconfig-004-20241028    clang-19
i386                  randconfig-005-20241027    gcc-12
i386                  randconfig-005-20241028    clang-19
i386                  randconfig-006-20241027    gcc-12
i386                  randconfig-006-20241028    clang-19
i386                  randconfig-011-20241027    clang-19
i386                  randconfig-011-20241028    clang-19
i386                  randconfig-012-20241028    clang-19
i386                  randconfig-013-20241028    clang-19
i386                  randconfig-014-20241027    gcc-12
i386                  randconfig-014-20241028    clang-19
i386                  randconfig-015-20241028    clang-19
i386                  randconfig-016-20241028    clang-19
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
loongarch             randconfig-001-20241027    gcc-14.1.0
loongarch             randconfig-002-20241027    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
m68k                        m5307c3_defconfig    clang-20
m68k                        m5407c3_defconfig    clang-20
m68k                            q40_defconfig    clang-20
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                          ath79_defconfig    clang-20
mips                        bcm63xx_defconfig    clang-20
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
nios2                 randconfig-001-20241027    gcc-14.1.0
nios2                 randconfig-002-20241027    gcc-14.1.0
openrisc                          allnoconfig    gcc-14.1.0
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
openrisc                            defconfig    gcc-14.1.0
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    gcc-14.1.0
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc                              defconfig    gcc-14.1.0
parisc                generic-32bit_defconfig    clang-20
parisc                randconfig-001-20241027    gcc-14.1.0
parisc                randconfig-002-20241027    gcc-14.1.0
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    gcc-14.1.0
powerpc                          allyesconfig    clang-20
powerpc                          allyesconfig    gcc-14.1.0
powerpc               randconfig-001-20241027    clang-20
powerpc               randconfig-002-20241027    gcc-14.1.0
powerpc               randconfig-003-20241027    clang-20
powerpc64             randconfig-001-20241027    clang-20
powerpc64             randconfig-002-20241027    gcc-14.1.0
powerpc64             randconfig-003-20241027    gcc-14.1.0
riscv                            allmodconfig    clang-20
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    gcc-14.1.0
riscv                            allyesconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    clang-20
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20241027    clang-14
riscv                 randconfig-002-20241027    gcc-14.1.0
s390                             allmodconfig    clang-20
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    clang-20
s390                                defconfig    gcc-12
s390                  randconfig-001-20241027    gcc-14.1.0
s390                  randconfig-002-20241027    gcc-14.1.0
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                                  defconfig    gcc-14.1.0
sh                               j2_defconfig    clang-20
sh                            migor_defconfig    clang-20
sh                    randconfig-001-20241027    gcc-14.1.0
sh                    randconfig-002-20241027    gcc-14.1.0
sh                          rsk7264_defconfig    clang-20
sh                          sdk7780_defconfig    clang-20
sh                           se7343_defconfig    clang-20
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
sparc64                             defconfig    gcc-14.1.0
sparc64               randconfig-001-20241027    gcc-14.1.0
sparc64               randconfig-002-20241027    gcc-14.1.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                               allyesconfig    clang-20
um                               allyesconfig    gcc-12
um                                  defconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241027    clang-14
um                    randconfig-002-20241027    gcc-12
um                           x86_64_defconfig    clang-15
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241027    clang-19
x86_64      buildonly-randconfig-002-20241027    gcc-12
x86_64      buildonly-randconfig-003-20241027    gcc-12
x86_64      buildonly-randconfig-004-20241027    gcc-12
x86_64      buildonly-randconfig-005-20241027    clang-19
x86_64      buildonly-randconfig-006-20241027    gcc-12
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20241027    clang-19
x86_64                randconfig-002-20241027    clang-19
x86_64                randconfig-003-20241027    gcc-12
x86_64                randconfig-004-20241027    gcc-12
x86_64                randconfig-005-20241027    gcc-12
x86_64                randconfig-006-20241027    clang-19
x86_64                randconfig-011-20241027    gcc-12
x86_64                randconfig-012-20241027    gcc-12
x86_64                randconfig-013-20241027    gcc-12
x86_64                randconfig-014-20241027    clang-19
x86_64                randconfig-015-20241027    clang-19
x86_64                randconfig-016-20241027    clang-19
x86_64                randconfig-071-20241027    clang-19
x86_64                randconfig-072-20241027    gcc-12
x86_64                randconfig-073-20241027    clang-19
x86_64                randconfig-074-20241027    gcc-12
x86_64                randconfig-075-20241027    gcc-12
x86_64                randconfig-076-20241027    gcc-12
x86_64                               rhel-8.3    gcc-12
xtensa                            allnoconfig    gcc-14.1.0
xtensa                generic_kc705_defconfig    clang-20
xtensa                randconfig-001-20241027    gcc-14.1.0
xtensa                randconfig-002-20241027    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

