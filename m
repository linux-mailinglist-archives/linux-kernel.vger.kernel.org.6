Return-Path: <linux-kernel+bounces-337680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA92984D72
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 00:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DDFA1C20955
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 22:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB38146A87;
	Tue, 24 Sep 2024 22:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RICPc7KC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838F113D8A3
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 22:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727215905; cv=none; b=N6zubQk0Y1Oka/PILVWnJOk9PZTRLR5YQKjUT0xz8vp8Ngw6KC8LSpf5li/x8BqWNtgAtr/JydHoZ6n0G4cNA9HzsC3oBMhI2alOFuMupg9mZOo0BABZopBUSWHc9G1z5qbZZ2mpAzoRpfRqTTIosr/j1vva0gFppgv7qYMOelk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727215905; c=relaxed/simple;
	bh=b5Y3fRI5lNKGzSZs6OraoqB7OFbY3CzZvCgi3yPNvI8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=k7wPgvWQz6z45RW7zqUBXJT2yMbjU94KwbVoBHZTeYk1FYrdEOJk29b3U0ylZfkxKA8VvHhIGAdunuILiIxug3IybCgDJ1hTsfQZriC6EW8rzPtbKrJj961j4pNwKZaaSrrZ+uAT4vfEm2cli4A0mRR49SO0tKTSkSsGctjn2Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RICPc7KC; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727215904; x=1758751904;
  h=date:from:to:cc:subject:message-id;
  bh=b5Y3fRI5lNKGzSZs6OraoqB7OFbY3CzZvCgi3yPNvI8=;
  b=RICPc7KCEMC/eWta7QXN0WSzFrfilvXD9qYFV6kXqK3KOR4umdjLWz/f
   tjeeByf7Zfo9iG681gYt4yM6v9fYJgwlsu1pkEJ9gR9tS2L4C3fXV7hxM
   Tjkp2TmuzLTkpdoKy8XrWYs4hMIKDLdH2SlxBbtM6TuRc2vANZdcPK2jH
   xEVsqxQ3qiLP/ixHqA0Jjfp/J7dLFwFON3VrMCPZhpbax48gHYnh3HlFe
   llnr270hRx4vfCzNaVBrRXEYhQgVS7K+aY0/XfSyByeJJmKmsbOpm2Kl0
   hDuITVC5NAUmqIcCUYXRorHnx4wS1y5chMxavptXQYEhUINDxjkAqpkwx
   A==;
X-CSE-ConnectionGUID: gmlFZQLpTSe52uCfVZJ4VQ==
X-CSE-MsgGUID: M9qUogqxRzOtO6gLEaEvJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="29127932"
X-IronPort-AV: E=Sophos;i="6.10,255,1719903600"; 
   d="scan'208";a="29127932"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 15:11:43 -0700
X-CSE-ConnectionGUID: by1TDT64SP2egrGteBK8nA==
X-CSE-MsgGUID: EgpjOSsUQya3r1ZyKFQ9Pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,255,1719903600"; 
   d="scan'208";a="76073107"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 24 Sep 2024 15:11:42 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1stDkx-000Isz-1S;
	Tue, 24 Sep 2024 22:11:39 +0000
Date: Wed, 25 Sep 2024 06:11:38 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 a6f489fee2633f8595934a850981bd4284abdbba
Message-ID: <202409250632.Mjhza48d-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: a6f489fee2633f8595934a850981bd4284abdbba  Merge branch into tip/master: 'x86/splitlock'

elapsed time: 779m

configs tested: 187
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                            allyesconfig    gcc-13.3.0
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                                 defconfig    gcc-14.1.0
arc                   randconfig-001-20240924    gcc-13.2.0
arc                   randconfig-001-20240924    gcc-14.1.0
arc                   randconfig-002-20240924    gcc-13.2.0
arc                   randconfig-002-20240924    gcc-14.1.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                                 defconfig    gcc-14.1.0
arm                      footbridge_defconfig    gcc-14.1.0
arm                   randconfig-001-20240924    clang-20
arm                   randconfig-001-20240924    gcc-14.1.0
arm                   randconfig-002-20240924    gcc-14.1.0
arm                   randconfig-003-20240924    gcc-14.1.0
arm                   randconfig-004-20240924    gcc-14.1.0
arm                         s3c6400_defconfig    gcc-14.1.0
arm                         s5pv210_defconfig    gcc-14.1.0
arm                        spear3xx_defconfig    gcc-14.1.0
arm                        vexpress_defconfig    gcc-14.1.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
arm64                 randconfig-001-20240924    gcc-14.1.0
arm64                 randconfig-002-20240924    gcc-14.1.0
arm64                 randconfig-003-20240924    gcc-14.1.0
arm64                 randconfig-004-20240924    clang-14
arm64                 randconfig-004-20240924    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
csky                  randconfig-001-20240924    gcc-14.1.0
csky                  randconfig-002-20240924    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
hexagon               randconfig-001-20240924    clang-20
hexagon               randconfig-001-20240924    gcc-14.1.0
hexagon               randconfig-002-20240924    clang-20
hexagon               randconfig-002-20240924    gcc-14.1.0
i386                             allmodconfig    clang-18
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-18
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-18
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20240924    gcc-12
i386        buildonly-randconfig-002-20240924    gcc-12
i386        buildonly-randconfig-003-20240924    gcc-12
i386        buildonly-randconfig-004-20240924    gcc-12
i386        buildonly-randconfig-005-20240924    gcc-12
i386        buildonly-randconfig-006-20240924    gcc-12
i386                                defconfig    clang-18
i386                  randconfig-001-20240924    gcc-12
i386                  randconfig-002-20240924    gcc-12
i386                  randconfig-003-20240924    gcc-12
i386                  randconfig-004-20240924    gcc-12
i386                  randconfig-005-20240924    gcc-12
i386                  randconfig-006-20240924    gcc-12
i386                  randconfig-011-20240924    gcc-12
i386                  randconfig-012-20240924    gcc-12
i386                  randconfig-013-20240924    gcc-12
i386                  randconfig-014-20240924    gcc-12
i386                  randconfig-015-20240924    gcc-12
i386                  randconfig-016-20240924    gcc-12
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
loongarch             randconfig-001-20240924    gcc-14.1.0
loongarch             randconfig-002-20240924    gcc-14.1.0
m68k                             alldefconfig    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                        qi_lb60_defconfig    gcc-14.1.0
mips                   sb1250_swarm_defconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
nios2                 randconfig-001-20240924    gcc-14.1.0
nios2                 randconfig-002-20240924    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20240924    gcc-14.1.0
parisc                randconfig-002-20240924    gcc-14.1.0
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.1.0
powerpc                        icon_defconfig    gcc-14.1.0
powerpc                 linkstation_defconfig    gcc-14.1.0
powerpc                     skiroot_defconfig    gcc-14.1.0
powerpc                     tqm8540_defconfig    gcc-14.1.0
powerpc64             randconfig-001-20240924    gcc-14.1.0
powerpc64             randconfig-002-20240924    gcc-14.1.0
powerpc64             randconfig-003-20240924    gcc-14.1.0
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20240924    gcc-14.1.0
riscv                 randconfig-002-20240924    gcc-14.1.0
s390                             allmodconfig    clang-20
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20240924    clang-20
s390                  randconfig-001-20240924    gcc-14.1.0
s390                  randconfig-002-20240924    clang-20
s390                  randconfig-002-20240924    gcc-14.1.0
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                         ap325rxa_defconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20240924    gcc-14.1.0
sh                    randconfig-002-20240924    gcc-14.1.0
sh                      rts7751r2d1_defconfig    gcc-14.1.0
sh                            titan_defconfig    gcc-14.1.0
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20240924    gcc-14.1.0
sparc64               randconfig-002-20240924    gcc-14.1.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20240924    gcc-12
um                    randconfig-001-20240924    gcc-14.1.0
um                    randconfig-002-20240924    gcc-12
um                    randconfig-002-20240924    gcc-14.1.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64      buildonly-randconfig-001-20240924    clang-18
x86_64      buildonly-randconfig-002-20240924    clang-18
x86_64      buildonly-randconfig-003-20240924    clang-18
x86_64      buildonly-randconfig-004-20240924    clang-18
x86_64      buildonly-randconfig-005-20240924    clang-18
x86_64      buildonly-randconfig-006-20240924    clang-18
x86_64                              defconfig    clang-18
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-18
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20240924    clang-18
x86_64                randconfig-002-20240924    clang-18
x86_64                randconfig-003-20240924    clang-18
x86_64                randconfig-004-20240924    clang-18
x86_64                randconfig-005-20240924    clang-18
x86_64                randconfig-006-20240924    clang-18
x86_64                randconfig-011-20240924    clang-18
x86_64                randconfig-012-20240924    clang-18
x86_64                randconfig-013-20240924    clang-18
x86_64                randconfig-014-20240924    clang-18
x86_64                randconfig-015-20240924    clang-18
x86_64                randconfig-016-20240924    clang-18
x86_64                randconfig-071-20240924    clang-18
x86_64                randconfig-072-20240924    clang-18
x86_64                randconfig-073-20240924    clang-18
x86_64                randconfig-074-20240924    clang-18
x86_64                randconfig-075-20240924    clang-18
x86_64                randconfig-076-20240924    clang-18
x86_64                               rhel-8.3    gcc-12
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0
xtensa                  nommu_kc705_defconfig    gcc-14.1.0
xtensa                randconfig-001-20240924    gcc-14.1.0
xtensa                randconfig-002-20240924    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

