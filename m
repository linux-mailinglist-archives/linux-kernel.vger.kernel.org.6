Return-Path: <linux-kernel+bounces-380468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF019AEF20
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 20:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E9981C21C82
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 18:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149DC1FF7D1;
	Thu, 24 Oct 2024 18:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DDZd5iFN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062211FE0E4
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 18:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729793000; cv=none; b=OZhlRJVY/vmcnAZ5p+nLmedcwWnMj9V1unRHzu8cx3QLIPwfJm35ssMTKtlAI3+8yXiYmS/ZXMXCzKDQ2N3xlVTsz2TltVkipYqRJfUYBZlzsthUU7ZcVO9SWQ8gFQp/oI3Qy5B22RChaBp5h/N3dQkNw0BmCXT8u4igc+aNy28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729793000; c=relaxed/simple;
	bh=wKT9Go/G9mVUw6sMPcqBkHwOdzNfRKQlddqT9FOB86U=;
	h=Date:From:To:Cc:Subject:Message-ID; b=qoMzdkUYfB8Y4WYMo6fTGWEyLdOKO1PQFSiWYHFwpDLjSKnYEvj7At8nOpZ2sZsglbF0/DvqUcE6A0KDEc2KKF4iMvBQLX+Gd5Ruf/IalrFLFS866rJn7PtC7AuZMQ7vmE1eK5IEpyjM2m9x91yrOsa6eMlfO/utuQEog8kASU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DDZd5iFN; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729792999; x=1761328999;
  h=date:from:to:cc:subject:message-id;
  bh=wKT9Go/G9mVUw6sMPcqBkHwOdzNfRKQlddqT9FOB86U=;
  b=DDZd5iFNN6bZ2gUUsoL8h98j58QQ5dhV2p/7HZrkGAQ8X270oqfsR+NL
   V7Aw/CUgPpV/bcMZBxQPzhqsr28ek81+9X9vjKXfJxNJ9CrkoRn+XU0y6
   Prf9Us87qGQFv0mivmuRiJWwvAGLv6SNHwVTSAlBfd95p99TJqDfeN676
   E8lxMG375rrhtJTfEn8B4IzoyzSzzZlQgFr/lVGci+DitXrWLeQucPvV/
   LH9kTmCGcKJaP40fVbzP3Us+imJ0VJYh/pSLtkCG+5vnEdLEkHMYxEoya
   z6yaLucCTUmpVntWQNJVSL0nCqKhMV8cftlMCNtpcFNpFj7vOmL8wa2jh
   g==;
X-CSE-ConnectionGUID: vXyvfLbaQRaeCmVNZ/sxkA==
X-CSE-MsgGUID: P0dB5+NrR6u75KlbM+gR5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="29549130"
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="29549130"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 11:03:12 -0700
X-CSE-ConnectionGUID: 3XCEmt+ISzaobyBnVybElQ==
X-CSE-MsgGUID: A8tTls41RqKzWQbgPvwCqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="111521693"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 24 Oct 2024 11:03:11 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t42Au-000WpM-0p;
	Thu, 24 Oct 2024 18:03:08 +0000
Date: Fri, 25 Oct 2024 02:02:54 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2024.10.21a] BUILD SUCCESS
 cd0116387b1c87106f4868928c8720aa53275a66
Message-ID: <202410250247.iJdfS6bf-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2024.10.21a
branch HEAD: cd0116387b1c87106f4868928c8720aa53275a66  rcutorture: Add ->cond_sync_exp_full function to rcu_ops structure

elapsed time: 2663m

configs tested: 171
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                                 defconfig    gcc-14.1.0
arc                   randconfig-001-20241024    gcc-14.1.0
arc                   randconfig-002-20241024    gcc-14.1.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                                 defconfig    gcc-14.1.0
arm                             pxa_defconfig    clang-20
arm                   randconfig-001-20241024    gcc-14.1.0
arm                   randconfig-002-20241024    gcc-14.1.0
arm                   randconfig-003-20241024    gcc-14.1.0
arm                   randconfig-004-20241024    gcc-14.1.0
arm                        realview_defconfig    clang-20
arm                           spitz_defconfig    clang-20
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    clang-20
arm64                               defconfig    gcc-14.1.0
arm64                 randconfig-001-20241024    gcc-14.1.0
arm64                 randconfig-002-20241024    gcc-14.1.0
arm64                 randconfig-003-20241024    gcc-14.1.0
arm64                 randconfig-004-20241024    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
csky                  randconfig-001-20241024    gcc-14.1.0
csky                  randconfig-002-20241024    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
hexagon               randconfig-001-20241024    gcc-14.1.0
hexagon               randconfig-002-20241024    gcc-14.1.0
i386                             alldefconfig    clang-20
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                             allyesconfig    clang-19
i386        buildonly-randconfig-001-20241024    clang-19
i386        buildonly-randconfig-002-20241024    clang-19
i386        buildonly-randconfig-003-20241024    clang-19
i386        buildonly-randconfig-004-20241024    clang-19
i386        buildonly-randconfig-005-20241024    clang-19
i386        buildonly-randconfig-006-20241024    clang-19
i386                                defconfig    clang-19
i386                  randconfig-001-20241024    clang-19
i386                  randconfig-002-20241024    clang-19
i386                  randconfig-003-20241024    clang-19
i386                  randconfig-004-20241024    clang-19
i386                  randconfig-005-20241024    clang-19
i386                  randconfig-006-20241024    clang-19
i386                  randconfig-011-20241024    clang-19
i386                  randconfig-012-20241024    clang-19
i386                  randconfig-013-20241024    clang-19
i386                  randconfig-014-20241024    clang-19
i386                  randconfig-015-20241024    clang-19
i386                  randconfig-016-20241024    clang-19
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
loongarch             randconfig-001-20241024    gcc-14.1.0
loongarch             randconfig-002-20241024    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                         apollo_defconfig    clang-20
m68k                       bvme6000_defconfig    clang-20
m68k                                defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                            gpr_defconfig    clang-20
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
nios2                 randconfig-001-20241024    gcc-14.1.0
nios2                 randconfig-002-20241024    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20241024    gcc-14.1.0
parisc                randconfig-002-20241024    gcc-14.1.0
parisc64                            defconfig    gcc-14.1.0
powerpc                     akebono_defconfig    clang-20
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.1.0
powerpc                     ep8248e_defconfig    clang-20
powerpc                    gamecube_defconfig    clang-20
powerpc                     mpc83xx_defconfig    clang-20
powerpc               randconfig-001-20241024    gcc-14.1.0
powerpc               randconfig-002-20241024    gcc-14.1.0
powerpc               randconfig-003-20241024    gcc-14.1.0
powerpc                     redwood_defconfig    clang-20
powerpc64             randconfig-001-20241024    gcc-14.1.0
powerpc64             randconfig-002-20241024    gcc-14.1.0
powerpc64             randconfig-003-20241024    gcc-14.1.0
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20241024    gcc-14.1.0
riscv                 randconfig-002-20241024    gcc-14.1.0
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20241024    gcc-14.1.0
s390                  randconfig-002-20241024    gcc-14.1.0
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                          kfr2r09_defconfig    clang-20
sh                          r7780mp_defconfig    clang-20
sh                    randconfig-001-20241024    gcc-14.1.0
sh                    randconfig-002-20241024    gcc-14.1.0
sh                           se7712_defconfig    clang-20
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20241024    gcc-14.1.0
sparc64               randconfig-002-20241024    gcc-14.1.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241024    gcc-14.1.0
um                    randconfig-002-20241024    gcc-14.1.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241024    gcc-12
x86_64      buildonly-randconfig-002-20241024    gcc-12
x86_64      buildonly-randconfig-003-20241024    gcc-12
x86_64      buildonly-randconfig-004-20241024    gcc-12
x86_64      buildonly-randconfig-005-20241024    gcc-12
x86_64      buildonly-randconfig-006-20241024    gcc-12
x86_64                              defconfig    clang-19
x86_64                                  kexec    clang-18
x86_64                randconfig-001-20241024    gcc-12
x86_64                randconfig-002-20241024    gcc-12
x86_64                randconfig-003-20241024    gcc-12
x86_64                randconfig-004-20241024    gcc-12
x86_64                randconfig-005-20241024    gcc-12
x86_64                randconfig-006-20241024    gcc-12
x86_64                randconfig-011-20241024    gcc-12
x86_64                randconfig-012-20241024    gcc-12
x86_64                randconfig-013-20241024    gcc-12
x86_64                randconfig-014-20241024    gcc-12
x86_64                randconfig-015-20241024    gcc-12
x86_64                randconfig-016-20241024    gcc-12
x86_64                randconfig-071-20241024    gcc-12
x86_64                randconfig-072-20241024    gcc-12
x86_64                randconfig-073-20241024    gcc-12
x86_64                randconfig-074-20241024    gcc-12
x86_64                randconfig-075-20241024    gcc-12
x86_64                randconfig-076-20241024    gcc-12
x86_64                               rhel-8.3    gcc-12
xtensa                            allnoconfig    gcc-14.1.0
xtensa                randconfig-001-20241024    gcc-14.1.0
xtensa                randconfig-002-20241024    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

