Return-Path: <linux-kernel+bounces-516486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB567A3725A
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 08:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 529F618906F9
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 07:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC6814BFA2;
	Sun, 16 Feb 2025 07:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lSkGxRgy"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C89B672
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 07:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739690379; cv=none; b=iJ683iEBkBU4dheCGFWhcgQeFWsfZHv2B0kV+EyqqxHJccc9e3VhddvSOwADxqEJzfY67+oZxlej6YXlwcFtbEKd/iFVfsBzXnmA5Nkuj8ZAcb3ZSZG9LLVAbQfD5zibHywYR0Vqung+W5lMjd7/6o2USRUYUGyAJLd93wqe3UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739690379; c=relaxed/simple;
	bh=89P8pqEplothGZ7DSJ71cyNQ7MOr6pxfyIc31iSpErs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=RCu9McqaXxvZyJE3hQZE/vu1KskDfdpFKrJmWMn5tkKw/tO4GSj9RyM9UUSin4C2BJ5xLXr0NkZlVyhuxwoXGRz1vGufNe5eiP8rCwmcFIQ4rj4BuXkYgEsFI+aoM7zzcOmNHwwf275meU7Y04Qxz6AR0j2dn+xSCgMXn9F5oaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lSkGxRgy; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739690377; x=1771226377;
  h=date:from:to:cc:subject:message-id;
  bh=89P8pqEplothGZ7DSJ71cyNQ7MOr6pxfyIc31iSpErs=;
  b=lSkGxRgy0uqi5UHlrFL+ml1Ls4UVd3nrNTm+pOTOvHq4sN/AiWB3YMtB
   MC5b4iJFIOL3Yl/bbMMfgH6wRo8lgQrLVZi+wcfQJtcNIJrji6k8XAe8b
   EWWrPuBPyE7eiNEbBUg6nB3B0tY9Xn/hQnzrzLIWhh90Ddysj42aKPJqT
   2SfUNKi8oiPxJYv9m3APYo9advcT23thM+MC8GrW2iaGRQ8KI5efHGfPZ
   Kws1fbZs5gmEAv8TkMxClEKsAFPyzosR+gB56jUKLOYfLqMsd+Bw7hZlJ
   LsE0nb4jiqAsRag4vjpDqnEYLN4BGmaZSCjqGnBGQ84i4tPAsrOsacK+e
   g==;
X-CSE-ConnectionGUID: 3HEXswnZTFuhs8vBHfkLvQ==
X-CSE-MsgGUID: lCiE3Y5BQKuMpUVstALFhg==
X-IronPort-AV: E=McAfee;i="6700,10204,11346"; a="40532856"
X-IronPort-AV: E=Sophos;i="6.13,290,1732608000"; 
   d="scan'208";a="40532856"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2025 23:19:36 -0800
X-CSE-ConnectionGUID: oZGXc2H9QJ6Z5IGuuc7LDA==
X-CSE-MsgGUID: o/0HEW/nQD6HyCQojU+Upw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,290,1732608000"; 
   d="scan'208";a="114023482"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 15 Feb 2025 23:19:35 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tjYw8-001Bg7-2C;
	Sun, 16 Feb 2025 07:19:32 +0000
Date: Sun, 16 Feb 2025 15:19:19 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD SUCCESS
 d34e798094ca7be935b629a42f8b237d4d5b7f1d
Message-ID: <202502161512.4sDKhiKd-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
branch HEAD: d34e798094ca7be935b629a42f8b237d4d5b7f1d  sched/fair: Refactor can_migrate_task() to elimate looping

elapsed time: 1200m

configs tested: 184
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-13.2.0
arc                   randconfig-001-20250215    gcc-13.2.0
arc                   randconfig-002-20250215    gcc-13.2.0
arc                        vdk_hs38_defconfig    gcc-13.2.0
arm                              alldefconfig    gcc-14.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    gcc-14.2.0
arm                     am200epdkit_defconfig    gcc-14.2.0
arm                         bcm2835_defconfig    clang-16
arm                                 defconfig    clang-21
arm                      integrator_defconfig    clang-15
arm                         lpc32xx_defconfig    clang-21
arm                   randconfig-001-20250215    clang-15
arm                   randconfig-002-20250215    clang-17
arm                   randconfig-003-20250215    gcc-14.2.0
arm                   randconfig-004-20250215    gcc-14.2.0
arm                         s5pv210_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250215    clang-21
arm64                 randconfig-002-20250215    gcc-14.2.0
arm64                 randconfig-003-20250215    clang-17
arm64                 randconfig-004-20250215    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250215    gcc-14.2.0
csky                  randconfig-002-20250215    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-21
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-18
hexagon                             defconfig    clang-21
hexagon               randconfig-001-20250215    clang-21
hexagon               randconfig-002-20250215    clang-21
i386                             allmodconfig    clang-19
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-19
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-19
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250215    gcc-12
i386        buildonly-randconfig-002-20250215    clang-19
i386        buildonly-randconfig-003-20250215    clang-19
i386        buildonly-randconfig-004-20250215    gcc-12
i386        buildonly-randconfig-005-20250215    clang-19
i386        buildonly-randconfig-006-20250215    clang-19
i386                                defconfig    clang-19
i386                  randconfig-001-20250216    gcc-12
i386                  randconfig-002-20250216    gcc-12
i386                  randconfig-003-20250216    gcc-12
i386                  randconfig-004-20250216    gcc-12
i386                  randconfig-005-20250216    gcc-12
i386                  randconfig-006-20250216    gcc-12
i386                  randconfig-007-20250216    gcc-12
i386                  randconfig-011-20250216    gcc-12
i386                  randconfig-012-20250216    gcc-12
i386                  randconfig-013-20250216    gcc-12
i386                  randconfig-014-20250216    gcc-12
i386                  randconfig-015-20250216    gcc-12
i386                  randconfig-016-20250216    gcc-12
i386                  randconfig-017-20250216    gcc-12
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250215    gcc-14.2.0
loongarch             randconfig-002-20250215    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                         amcore_defconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                        m5407c3_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250215    gcc-14.2.0
nios2                 randconfig-002-20250215    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250215    gcc-14.2.0
parisc                randconfig-002-20250215    gcc-14.2.0
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                    amigaone_defconfig    gcc-14.2.0
powerpc                       holly_defconfig    clang-21
powerpc                 mpc836x_rdk_defconfig    clang-18
powerpc               randconfig-001-20250215    gcc-14.2.0
powerpc               randconfig-002-20250215    clang-21
powerpc               randconfig-003-20250215    clang-19
powerpc                     taishan_defconfig    clang-17
powerpc64             randconfig-001-20250215    gcc-14.2.0
powerpc64             randconfig-002-20250215    clang-21
powerpc64             randconfig-003-20250215    gcc-14.2.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-21
riscv                               defconfig    clang-19
riscv                 randconfig-001-20250215    clang-17
riscv                 randconfig-002-20250215    clang-19
s390                             allmodconfig    clang-19
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20250215    gcc-14.2.0
s390                  randconfig-002-20250215    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                    randconfig-001-20250215    gcc-14.2.0
sh                    randconfig-002-20250215    gcc-14.2.0
sh                      rts7751r2d1_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250215    gcc-14.2.0
sparc                 randconfig-002-20250215    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250215    gcc-14.2.0
sparc64               randconfig-002-20250215    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250215    clang-21
um                    randconfig-002-20250215    clang-19
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250215    gcc-12
x86_64      buildonly-randconfig-002-20250215    clang-19
x86_64      buildonly-randconfig-003-20250215    gcc-12
x86_64      buildonly-randconfig-004-20250215    clang-19
x86_64      buildonly-randconfig-005-20250215    clang-19
x86_64      buildonly-randconfig-006-20250215    clang-19
x86_64                              defconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20250216    clang-19
x86_64                randconfig-002-20250216    clang-19
x86_64                randconfig-003-20250216    clang-19
x86_64                randconfig-004-20250216    clang-19
x86_64                randconfig-005-20250216    clang-19
x86_64                randconfig-006-20250216    clang-19
x86_64                randconfig-007-20250216    clang-19
x86_64                randconfig-008-20250216    clang-19
x86_64                randconfig-071-20250216    gcc-12
x86_64                randconfig-072-20250216    gcc-12
x86_64                randconfig-073-20250216    gcc-12
x86_64                randconfig-074-20250216    gcc-12
x86_64                randconfig-075-20250216    gcc-12
x86_64                randconfig-076-20250216    gcc-12
x86_64                randconfig-077-20250216    gcc-12
x86_64                randconfig-078-20250216    gcc-12
x86_64                               rhel-9.4    clang-19
x86_64                           rhel-9.4-bpf    clang-19
x86_64                         rhel-9.4-kunit    clang-19
x86_64                           rhel-9.4-ltp    clang-19
x86_64                          rhel-9.4-rust    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250215    gcc-14.2.0
xtensa                randconfig-002-20250215    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

