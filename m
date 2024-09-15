Return-Path: <linux-kernel+bounces-329859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EAC9796C2
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 15:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B45F1C20829
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 13:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8071C5791;
	Sun, 15 Sep 2024 13:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C+beXQHx"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EEE125DB
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 13:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726406207; cv=none; b=mCj/+vrYiWzR2EHOqd9zw1Cfwa/ExtkdLBtrND58KzOVODKzujqmlmUdzNVTuf2H0jwpAYRS81D2LMyYBTfqbWzuD7WjKDYThdPV9FR1Wg5P484VWYoukvkYMx6iJlyAakquVxFIIbiYam3I+1pmrzF04FgToE18YwjoIt5L7kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726406207; c=relaxed/simple;
	bh=l4Zyo6W7rBxx2jKf90MwZsaJba+ZoMr517owHdixvms=;
	h=Date:From:To:Cc:Subject:Message-ID; b=FBdR5KdLZ/VYdNg22Fu7OtrwbnXstsCYGmGeQvGAjRJsLn7Fz6hiYWBg/TO0mqxVV9qFTGAUFYvehLZ6liQ/JOPcd/+1MvgbnyXyOzX6u8wxylE3WojaHMwmJ36tT7BatBlaR9KL/Vae3Nx5vVA+p/1puGkOmY6RtXtrUMInqas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C+beXQHx; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726406205; x=1757942205;
  h=date:from:to:cc:subject:message-id;
  bh=l4Zyo6W7rBxx2jKf90MwZsaJba+ZoMr517owHdixvms=;
  b=C+beXQHxWRupL7U6BQcPIOkdBpnf652bFKlWX1ErxYOGpSYEmEtW/FuD
   07me3bXUd49ZMjUjESMKsISfOsnMRtJQHdeZGzEGaq5OKV8Soig8QSYEd
   bYezj4JI939o9v4MpUq9SGAOFgdrL/6Pf1Oa+tQL4Or78cfjuVPeHjd7T
   Dz3VfXYCTLKlb4n0W+ucGuJQJ/Bo6B2PgRxNX1eibajqupZyGELAlEP1I
   tBBr1AQFZnyO+P/D6r+99z1w2sRArwxrNBGB95iq/RcglRS67lk0CH5Ze
   C2R4m4WxqbNX6YAuteDoaTE6dBA4tx8WAmfFoPoGeiZqjq7fTnGRka5Lm
   w==;
X-CSE-ConnectionGUID: Xf/hUOQaRqSrfvIbdyBoCA==
X-CSE-MsgGUID: f2AL16H2RJGgLCK3dYTmlQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11196"; a="25349713"
X-IronPort-AV: E=Sophos;i="6.10,231,1719903600"; 
   d="scan'208";a="25349713"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2024 06:16:44 -0700
X-CSE-ConnectionGUID: byFUbM+CSDeV46MxlLBgCQ==
X-CSE-MsgGUID: z+DOtuHJTBOlKxKfYm++ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,231,1719903600"; 
   d="scan'208";a="73394940"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 15 Sep 2024 06:16:44 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1spp7J-0008hK-2f;
	Sun, 15 Sep 2024 13:16:41 +0000
Date: Sun, 15 Sep 2024 21:15:52 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:non-rcu/next] BUILD SUCCESS
 3b27dde7b75dd0e051369456bd6d6b4c42195ee7
Message-ID: <202409152148.pmnVme7t-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git non-rcu/next
branch HEAD: 3b27dde7b75dd0e051369456bd6d6b4c42195ee7  Merge branches 'cmpxchg.2024.09.13a', 'lkmm.2024.09.14a', 'kcsan.2024.08.01a' and 'misc.2024.08.02a' into HEAD

elapsed time: 1779m

configs tested: 100
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-13.3.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20240915    gcc-13.2.0
arc                   randconfig-002-20240915    gcc-13.2.0
arm                              allmodconfig    gcc-14.1.0
arm                               allnoconfig    clang-20
arm                              allyesconfig    gcc-14.1.0
arm                   randconfig-001-20240915    gcc-14.1.0
arm                   randconfig-002-20240915    clang-17
arm                   randconfig-003-20240915    clang-20
arm                   randconfig-004-20240915    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                 randconfig-001-20240915    clang-20
arm64                 randconfig-002-20240915    gcc-14.1.0
arm64                 randconfig-003-20240915    clang-20
arm64                 randconfig-004-20240915    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                  randconfig-001-20240915    gcc-14.1.0
csky                  randconfig-002-20240915    gcc-14.1.0
hexagon                           allnoconfig    clang-20
hexagon               randconfig-001-20240915    clang-20
hexagon               randconfig-002-20240915    clang-16
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20240915    gcc-12
i386        buildonly-randconfig-002-20240915    clang-18
i386        buildonly-randconfig-003-20240915    clang-18
i386        buildonly-randconfig-004-20240915    gcc-12
i386        buildonly-randconfig-005-20240915    clang-18
i386        buildonly-randconfig-006-20240915    gcc-12
i386                                defconfig    clang-18
i386                  randconfig-001-20240915    clang-18
i386                  randconfig-002-20240915    clang-18
i386                  randconfig-003-20240915    clang-18
i386                  randconfig-004-20240915    clang-18
i386                  randconfig-005-20240915    clang-18
i386                  randconfig-006-20240915    clang-18
i386                  randconfig-011-20240915    clang-18
i386                  randconfig-012-20240915    gcc-12
i386                  randconfig-013-20240915    gcc-12
i386                  randconfig-014-20240915    clang-18
i386                  randconfig-015-20240915    gcc-12
i386                  randconfig-016-20240915    gcc-12
loongarch                         allnoconfig    gcc-14.1.0
loongarch             randconfig-001-20240915    gcc-14.1.0
loongarch             randconfig-002-20240915    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                 randconfig-001-20240915    gcc-14.1.0
nios2                 randconfig-002-20240915    gcc-14.1.0
openrisc                          allnoconfig    gcc-14.1.0
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-14.1.0
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    gcc-14.1.0
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-14.1.0
parisc                randconfig-001-20240915    gcc-14.1.0
parisc                randconfig-002-20240915    gcc-14.1.0
powerpc                           allnoconfig    gcc-14.1.0
powerpc               randconfig-001-20240915    gcc-14.1.0
powerpc               randconfig-002-20240915    gcc-14.1.0
powerpc               randconfig-003-20240915    gcc-14.1.0
powerpc64             randconfig-001-20240915    clang-20
powerpc64             randconfig-002-20240915    clang-20
powerpc64             randconfig-003-20240915    gcc-14.1.0
riscv                             allnoconfig    gcc-14.1.0
riscv                 randconfig-001-20240915    clang-15
riscv                 randconfig-002-20240915    clang-20
s390                             allmodconfig    clang-20
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                  randconfig-001-20240915    clang-20
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-14.1.0
sparc                            allmodconfig    gcc-14.1.0
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64      buildonly-randconfig-001-20240915    gcc-12
x86_64      buildonly-randconfig-002-20240915    gcc-12
x86_64      buildonly-randconfig-003-20240915    clang-18
x86_64      buildonly-randconfig-004-20240915    clang-18
x86_64      buildonly-randconfig-005-20240915    clang-18
x86_64      buildonly-randconfig-006-20240915    gcc-12
x86_64                              defconfig    gcc-11
x86_64                randconfig-001-20240915    clang-18
x86_64                randconfig-002-20240915    gcc-12
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

