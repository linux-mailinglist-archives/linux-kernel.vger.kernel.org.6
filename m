Return-Path: <linux-kernel+bounces-576725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03865A713A8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 10:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFA333BCEAE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 09:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB2E1AB52F;
	Wed, 26 Mar 2025 09:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MMHCI/4I"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84344DF59
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 09:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742981089; cv=none; b=dv3GoCzgwQy8o2shkUt+8Yw51aOteL3y/q+KEvbq+CUGAGahE2RbBrl21wrZBwRGH5+o/64BUMio+HWbFvuWQuI03GMsVo4JzHhKiBn71XUYvrto9h99sKaqJoXDVOAah7OOI9VJxLTAPniSMnEIwYNqyv7lX+bsCjHFGf19cvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742981089; c=relaxed/simple;
	bh=jFr0NTgYtftg1mdJz0bNa/qzYOo8skjuDDRfiqBoX/A=;
	h=Date:From:To:Cc:Subject:Message-ID; b=a+BStUYYqW/6U3hUgiWqfKm0PGkeMTTkr+fTM2y5EezRz3HuDNTo+9gc2O0UYwEU33JlzxiBWGp77Fkjydpjd5q6T34fyMRTtzy88wQzP8RayywCYVDFuwTrptJHLAk/djcs2AJ5gPxDVq8xqmLiFly1Zjb7qlX/NePEP9wIcrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MMHCI/4I; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742981088; x=1774517088;
  h=date:from:to:cc:subject:message-id;
  bh=jFr0NTgYtftg1mdJz0bNa/qzYOo8skjuDDRfiqBoX/A=;
  b=MMHCI/4IQUJc6E6G/TfO6fC8/ykPHMy1xZRqWI5KhIHC8zdT4bMK4GqZ
   9lcuB0VoeRSfJkgLJsWG9+FjzzltQMMPn3bpVtoypignEklNc9JAMKdAt
   O8ZMQU0ZbfIaByusUnujEPqJwSzbfBmyngWzeYBtASri+YeGDcGn+Lqnr
   DcgGsW91OcOk9d6GFFEzYhzMxpY3BUMJFCEI3DYWTuvr5NM9v1ttvddU3
   UBQEaUOIvLYylu9F8jbUbVSM75nrBxAusWyniW7Jvk0ib4OfNwOPkeiob
   8OJIT++KKApaSbYROEtQRqHI5Go/sI6msIFyX5R8fFuBxuXOz6NbxQdSH
   A==;
X-CSE-ConnectionGUID: K0n6Hkt0TeieBrvTFZJCiA==
X-CSE-MsgGUID: A3D8Vm+lQOaYziSnjFr58w==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="69620761"
X-IronPort-AV: E=Sophos;i="6.14,277,1736841600"; 
   d="scan'208";a="69620761"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 02:24:45 -0700
X-CSE-ConnectionGUID: 7N6MFCdhTwqg5o99JyqqXQ==
X-CSE-MsgGUID: WgWLcnqcSHC2mMaB5QvTOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,277,1736841600"; 
   d="scan'208";a="124442546"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 26 Mar 2025 02:24:45 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1txMzh-0005cH-0Q;
	Wed, 26 Mar 2025 09:24:26 +0000
Date: Wed, 26 Mar 2025 17:23:29 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:timers/clocksource] BUILD SUCCESS
 abfa6d6fe2e9539a6e080088a6e5762f4651017b
Message-ID: <202503261716.Cd4beVBh-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/clocksource
branch HEAD: abfa6d6fe2e9539a6e080088a6e5762f4651017b  Merge tag 'timers-v6.15-rc1' of https://git.linaro.org/people/daniel.lezcano/linux into timers/clocksource

elapsed time: 1456m

configs tested: 123
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-14.2.0
arc                   randconfig-001-20250325    gcc-14.2.0
arc                   randconfig-002-20250325    gcc-13.3.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-14.2.0
arm                   randconfig-001-20250325    gcc-5.5.0
arm                   randconfig-002-20250325    gcc-5.5.0
arm                   randconfig-003-20250325    gcc-5.5.0
arm                   randconfig-004-20250325    clang-21
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250325    gcc-9.5.0
arm64                 randconfig-002-20250325    clang-18
arm64                 randconfig-003-20250325    gcc-7.5.0
arm64                 randconfig-004-20250325    clang-20
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250325    gcc-13.3.0
csky                  randconfig-002-20250325    gcc-14.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250325    clang-16
hexagon               randconfig-002-20250325    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250325    gcc-12
i386        buildonly-randconfig-002-20250325    clang-20
i386        buildonly-randconfig-003-20250325    gcc-12
i386        buildonly-randconfig-004-20250325    clang-20
i386        buildonly-randconfig-005-20250325    gcc-12
i386        buildonly-randconfig-006-20250325    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250325    gcc-14.2.0
loongarch             randconfig-002-20250325    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                       bvme6000_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                   sb1250_swarm_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250325    gcc-7.5.0
nios2                 randconfig-002-20250325    gcc-9.3.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
openrisc                  or1klitex_defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250325    gcc-12.4.0
parisc                randconfig-002-20250325    gcc-12.4.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                        fsp2_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250325    clang-21
powerpc               randconfig-002-20250325    clang-21
powerpc               randconfig-003-20250325    gcc-9.3.0
powerpc                  storcenter_defconfig    gcc-14.2.0
powerpc                 xes_mpc85xx_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250325    clang-15
powerpc64             randconfig-002-20250325    clang-21
powerpc64             randconfig-003-20250325    gcc-9.3.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                 randconfig-001-20250325    gcc-9.3.0
riscv                 randconfig-002-20250325    gcc-14.2.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20250325    clang-18
s390                  randconfig-002-20250325    clang-15
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                    randconfig-001-20250325    gcc-5.5.0
sh                    randconfig-002-20250325    gcc-11.5.0
sh                           se7206_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250325    gcc-8.5.0
sparc                 randconfig-002-20250325    gcc-6.5.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250325    gcc-8.5.0
sparc64               randconfig-002-20250325    gcc-10.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250325    clang-21
um                    randconfig-002-20250325    clang-21
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250325    gcc-12
x86_64      buildonly-randconfig-002-20250325    clang-20
x86_64      buildonly-randconfig-003-20250325    gcc-12
x86_64      buildonly-randconfig-004-20250325    gcc-12
x86_64      buildonly-randconfig-005-20250325    clang-20
x86_64      buildonly-randconfig-006-20250325    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250325    gcc-8.5.0
xtensa                randconfig-002-20250325    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

