Return-Path: <linux-kernel+bounces-378708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A729AD43A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 20:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32985B22A60
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 18:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39AD1CACE2;
	Wed, 23 Oct 2024 18:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ILdkhiB3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1D3D2FA
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 18:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729709221; cv=none; b=uvGpkRy5RoX2yg4BmRn3+DjSSrZNhCahR5fgmUPgBjgX9vjkUuMMRsFokOSeQ8XczjsV/TSM26a+XZ4BP3TdvktWllrafgmpGDPo+GKEc1CZSl3pqG7gJ+Z8a7fxX1jZ/s4s7Gd8zNA0D4nEoPtJrs+PV9OqO5b1sWXFl1FQe1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729709221; c=relaxed/simple;
	bh=qNBa4ljW6Kdfgr7X0NwxD/8Vr6Ojw2cAMt0RoFpJjP0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=sVo9NoPExtdghKTsRZ0ZNxJtCcCIkS73N6AWpKX0D2h1Y3Mn2hIA6fGbjyIlIA6/7L0myOFdDndjsVhr5atpVYLkavhzRNVYpFKrih4S4N2K3+MgFZAUejMjufp7pWPYEyBGQZXxlu9wnrKH0TQNbaqCS0eoyerABnEvx8oY9Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ILdkhiB3; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729709219; x=1761245219;
  h=date:from:to:cc:subject:message-id;
  bh=qNBa4ljW6Kdfgr7X0NwxD/8Vr6Ojw2cAMt0RoFpJjP0=;
  b=ILdkhiB3RyJBvSh+uE9K6Pu98V45VOiqT97tRQg89xW3kgOkEh6JRk0O
   Ha8tK/kqqnIhrqsAE67/Z/FNjsGOMg2nZcy7zyBikPJF8UhpD88yzcAgT
   hAvOeVU/nCbcs/882wJyaDXXkiGloBUP2Ob/uaPWK6cY/1prpXlaGxBeN
   +WDS0RTnB7NQKzSQYt4l5TLQiabbkHIauiujN9HNAHuY1gLyJ5s6Uielx
   rSeOjn17XdeDqXN1OE84fa6Gp9gdG2SydLnrnpRFWg2K95LYDKLvJzKip
   DaN2Kheo3BvIvnWVh30DrVPUCj0f36PJfOF9CGGzMwLNWAVoYEcO1F0M2
   g==;
X-CSE-ConnectionGUID: XeNtgIrgR3+cNoP5dxKvow==
X-CSE-MsgGUID: 62x8y9KgRGKokLqjFSp1zQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="33008010"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="33008010"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 11:46:59 -0700
X-CSE-ConnectionGUID: KDfsE1xiRsq9/wYC1T7uoA==
X-CSE-MsgGUID: RNeMf6Y6S96qPDyEiiQ+Og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,226,1725346800"; 
   d="scan'208";a="84313411"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 23 Oct 2024 11:46:57 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t3gNi-000VIY-22;
	Wed, 23 Oct 2024 18:46:54 +0000
Date: Thu, 24 Oct 2024 02:46:06 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 94559bac4d403b1575b32a863f5c0429cdd33eaa
Message-ID: <202410240259.P4MXJDin-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 94559bac4d403b1575b32a863f5c0429cdd33eaa  Merge branch into tip/master: 'x86/sev'

elapsed time: 1483m

configs tested: 162
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-13.3.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.1.0
arc                              alldefconfig    clang-20
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    clang-20
arc                                 defconfig    gcc-14.1.0
arc                   randconfig-001-20241023    gcc-14.1.0
arc                   randconfig-002-20241023    gcc-14.1.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    clang-20
arm                              allyesconfig    clang-20
arm                                 defconfig    gcc-14.1.0
arm                      footbridge_defconfig    clang-20
arm                      jornada720_defconfig    clang-20
arm                       multi_v4t_defconfig    clang-20
arm                         mv78xx0_defconfig    clang-20
arm                   randconfig-001-20241023    gcc-14.1.0
arm                   randconfig-002-20241023    gcc-14.1.0
arm                   randconfig-003-20241023    gcc-14.1.0
arm                   randconfig-004-20241023    gcc-14.1.0
arm                           sunxi_defconfig    clang-20
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
arm64                 randconfig-001-20241023    gcc-14.1.0
arm64                 randconfig-002-20241023    gcc-14.1.0
arm64                 randconfig-003-20241023    gcc-14.1.0
arm64                 randconfig-004-20241023    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
csky                  randconfig-001-20241023    gcc-14.1.0
csky                  randconfig-002-20241023    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
hexagon               randconfig-001-20241023    gcc-14.1.0
hexagon               randconfig-002-20241023    gcc-14.1.0
i386                             allmodconfig    clang-18
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-18
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-18
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241023    clang-18
i386        buildonly-randconfig-002-20241023    clang-18
i386        buildonly-randconfig-003-20241023    clang-18
i386        buildonly-randconfig-003-20241023    gcc-12
i386        buildonly-randconfig-004-20241023    clang-18
i386        buildonly-randconfig-004-20241023    gcc-12
i386        buildonly-randconfig-005-20241023    clang-18
i386        buildonly-randconfig-006-20241023    clang-18
i386                                defconfig    clang-18
i386                  randconfig-001-20241023    clang-18
i386                  randconfig-001-20241023    gcc-12
i386                  randconfig-002-20241023    clang-18
i386                  randconfig-003-20241023    clang-18
i386                  randconfig-004-20241023    clang-18
i386                  randconfig-005-20241023    clang-18
i386                  randconfig-006-20241023    clang-18
i386                  randconfig-006-20241023    gcc-12
i386                  randconfig-011-20241023    clang-18
i386                  randconfig-012-20241023    clang-18
i386                  randconfig-012-20241023    gcc-12
i386                  randconfig-013-20241023    clang-18
i386                  randconfig-013-20241023    gcc-12
i386                  randconfig-014-20241023    clang-18
i386                  randconfig-015-20241023    clang-18
i386                  randconfig-016-20241023    clang-18
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
loongarch             randconfig-001-20241023    gcc-14.1.0
loongarch             randconfig-002-20241023    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                           ip30_defconfig    clang-20
mips                           jazz_defconfig    clang-20
nios2                         3c120_defconfig    clang-20
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
nios2                 randconfig-001-20241023    gcc-14.1.0
nios2                 randconfig-002-20241023    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.1.0
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.1.0
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20241023    gcc-14.1.0
parisc                randconfig-002-20241023    gcc-14.1.0
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.1.0
powerpc                          allyesconfig    gcc-14.1.0
powerpc                    gamecube_defconfig    clang-20
powerpc                      ppc44x_defconfig    clang-20
powerpc               randconfig-001-20241023    gcc-14.1.0
powerpc               randconfig-002-20241023    gcc-14.1.0
powerpc               randconfig-003-20241023    gcc-14.1.0
powerpc                     redwood_defconfig    clang-20
powerpc64             randconfig-001-20241023    gcc-14.1.0
powerpc64             randconfig-002-20241023    gcc-14.1.0
powerpc64             randconfig-003-20241023    gcc-14.1.0
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.1.0
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20241023    gcc-14.1.0
riscv                 randconfig-002-20241023    gcc-14.1.0
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20241023    gcc-14.1.0
s390                  randconfig-002-20241023    gcc-14.1.0
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20241023    gcc-14.1.0
sh                    randconfig-002-20241023    gcc-14.1.0
sh                           se7722_defconfig    clang-20
sh                           se7724_defconfig    clang-20
sh                        sh7785lcr_defconfig    clang-20
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20241023    gcc-14.1.0
sparc64               randconfig-002-20241023    gcc-14.1.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241023    gcc-14.1.0
um                    randconfig-002-20241023    gcc-14.1.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64                              defconfig    clang-18
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-18
x86_64                                  kexec    gcc-12
x86_64                               rhel-8.3    gcc-12
xtensa                            allnoconfig    gcc-14.1.0
xtensa                randconfig-001-20241023    gcc-14.1.0
xtensa                randconfig-002-20241023    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

