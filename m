Return-Path: <linux-kernel+bounces-553599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E164AA58C43
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 07:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 979C03A550F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 06:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4EA71C7013;
	Mon, 10 Mar 2025 06:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I5rkHACt"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1607C29406
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 06:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741589202; cv=none; b=iuc+t8MuWDgclHY96/zsUdKDfWIC8R31yRSHGp7c5WWNJzkzfT222Ez3oHlkQbDXQ4SHbv9q07UgVmX3gy5sDaPj25NPcxMARp2HaDA5TN3/jyl1fDQ4GDzMYvQAk/ejhARh6Hg9tBUXFH3lzPEb8YAWgrUncAHtDOOwQf/jm/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741589202; c=relaxed/simple;
	bh=vDNjQfMgS8TVDeI+HNYAQHt/f21gW1SyL0JnLHt4f6k=;
	h=Date:From:To:Cc:Subject:Message-ID; b=gBZkEjbsovB+cyv5/+RlD28EWMB8bVfzSxyBBGBJoKQEOpbdHB6UAhO3bNipljlKHRLPiit1RnKM7Ez3fAMwCaF1/uW9fZcgeNloUoD9vWEfJjruZpBF9Ci4SkAGnXkFvAyp8fJugKaUp2jYyPQAmG+hJcfhB1tpvHw4y2bR1yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I5rkHACt; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741589201; x=1773125201;
  h=date:from:to:cc:subject:message-id;
  bh=vDNjQfMgS8TVDeI+HNYAQHt/f21gW1SyL0JnLHt4f6k=;
  b=I5rkHACtNkbSbpwfR3rTi6Pr3ZyhwW46ILNrlWRX7fE5Q2wbGIKzDGVo
   KnIA973gdYfG+iSIxTpOYi6AKXGD9enUw/0hYYm9s+FEo8OzmOjVzrzEd
   Lx8G0IFoQu4UezPw73Xa+vlSSfS3elmawFAzTCDIGxrTbUM2fRZYk6niG
   faqBIYZZJBNW0ka9g5jEqp7Up+uY3q6kJXqwUzqcleRMbfjRGMVJlRNEM
   92X8M5zccB0ZlNzf1TQjzApAhWMCv+axtWzi6s1r9aTiMAr2dRmFEZmMS
   22GQweUza1ntroWApi/PoSqj9gqDhzLrM2pHZzYW7Ggh8Y6CVndCJlrdZ
   A==;
X-CSE-ConnectionGUID: 9qwCNawsThWbaak4nti6GA==
X-CSE-MsgGUID: dykgXuIuTLuNXJuNzBq+Lw==
X-IronPort-AV: E=McAfee;i="6700,10204,11368"; a="53949972"
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="53949972"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2025 23:46:40 -0700
X-CSE-ConnectionGUID: 89gXovbhSP+tVeYRcrI3Aw==
X-CSE-MsgGUID: ZSN2FZRdSqWWko8T6eJ0ZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="124894476"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 09 Mar 2025 23:46:23 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1trWu4-0003tO-0D;
	Mon, 10 Mar 2025 06:46:20 +0000
Date: Mon, 10 Mar 2025 14:45:23 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:tip/urgent] BUILD SUCCESS
 e23cef3eefb61030e31c4d89a8b3423dfaca1114
Message-ID: <202503101418.hdyKIn4y-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tip/urgent
branch HEAD: e23cef3eefb61030e31c4d89a8b3423dfaca1114  Merge branch into tip/master: 'locking/urgent'

elapsed time: 1242m

configs tested: 132
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-13.2.0
arc                     haps_hs_smp_defconfig    gcc-13.2.0
arc                        nsim_700_defconfig    gcc-13.2.0
arc                   randconfig-001-20250309    gcc-13.2.0
arc                   randconfig-002-20250309    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                         lpc32xx_defconfig    clang-21
arm                   randconfig-001-20250309    clang-21
arm                   randconfig-002-20250309    gcc-14.2.0
arm                   randconfig-003-20250309    clang-21
arm                   randconfig-004-20250309    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250309    clang-15
arm64                 randconfig-002-20250309    clang-17
arm64                 randconfig-003-20250309    clang-15
arm64                 randconfig-004-20250309    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250309    gcc-14.2.0
csky                  randconfig-002-20250309    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250309    clang-21
hexagon               randconfig-002-20250309    clang-21
i386                             alldefconfig    gcc-12
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250309    clang-19
i386        buildonly-randconfig-002-20250309    clang-19
i386        buildonly-randconfig-003-20250309    gcc-11
i386        buildonly-randconfig-004-20250309    gcc-12
i386        buildonly-randconfig-005-20250309    clang-19
i386        buildonly-randconfig-006-20250309    clang-19
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250309    gcc-14.2.0
loongarch             randconfig-002-20250309    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                        mvme16x_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                           gcw0_defconfig    clang-15
mips                           ip30_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250309    gcc-14.2.0
nios2                 randconfig-002-20250309    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250309    gcc-14.2.0
parisc                randconfig-002-20250309    gcc-14.2.0
powerpc                     akebono_defconfig    clang-21
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                       eiger_defconfig    clang-17
powerpc                     ksi8560_defconfig    gcc-14.2.0
powerpc                   motionpro_defconfig    clang-17
powerpc                  mpc866_ads_defconfig    clang-21
powerpc               randconfig-001-20250309    gcc-14.2.0
powerpc               randconfig-002-20250309    clang-21
powerpc               randconfig-003-20250309    clang-21
powerpc                     stx_gp3_defconfig    gcc-14.2.0
powerpc                        warp_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250309    clang-15
powerpc64             randconfig-002-20250309    gcc-14.2.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-21
riscv                               defconfig    clang-19
riscv                 randconfig-001-20250309    clang-15
riscv                 randconfig-002-20250309    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20250309    clang-16
s390                  randconfig-002-20250309    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                            migor_defconfig    gcc-14.2.0
sh                    randconfig-001-20250309    gcc-14.2.0
sh                    randconfig-002-20250309    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250309    gcc-14.2.0
sparc                 randconfig-002-20250309    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250309    gcc-14.2.0
sparc64               randconfig-002-20250309    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250309    clang-21
um                    randconfig-002-20250309    clang-21
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250309    gcc-12
x86_64      buildonly-randconfig-002-20250309    gcc-11
x86_64      buildonly-randconfig-003-20250309    gcc-12
x86_64      buildonly-randconfig-004-20250309    gcc-12
x86_64      buildonly-randconfig-005-20250309    clang-19
x86_64      buildonly-randconfig-006-20250309    clang-19
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250309    gcc-14.2.0
xtensa                randconfig-002-20250309    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

