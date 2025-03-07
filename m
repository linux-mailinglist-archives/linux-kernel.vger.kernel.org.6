Return-Path: <linux-kernel+bounces-551017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2AFA566FE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 12:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2675916F2BC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 11:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD49121771B;
	Fri,  7 Mar 2025 11:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k5xC/u3F"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA4825771
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 11:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741347872; cv=none; b=PZQluZ3Rj6Xwjv6QJqKpxq+EQimr0ZQwsBqIu90Sqr/t6bfdbFimreUrnpKUplLrl0Z/lvFMoy/BEv2T1CT6EOuTzOYDSp4DlUgViBQ4Zr3wNS27cuBnl8mT1/eJmHVBhsPcQBmJInLTDbFazzpZrcJGzHVR/U20JCA+SW3VNpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741347872; c=relaxed/simple;
	bh=GK5ukede9d4NjZGp9Ii7w0NbTvO6VHlJ4uSU7dsl9xE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=BQeIHeTYzQPA8tAIHpbPCuzyECtwzXvxccU6UOc+0PdrP3x9pou5zO0j9W2NIypF91ApIn+WI50GT5UhzuX7mLIqSBwcy0sqv79bEcC1vySAEWBUqC8PSWqXJwFkXK1hwswjKtqnDMCAiczG9cF4iex7Zjwlue5QTNfMQUWbbqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k5xC/u3F; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741347868; x=1772883868;
  h=date:from:to:cc:subject:message-id;
  bh=GK5ukede9d4NjZGp9Ii7w0NbTvO6VHlJ4uSU7dsl9xE=;
  b=k5xC/u3F1IK1SxKUrm7swghz9wf4288pkCzpyGSWJnOU0OsEf0etrhPT
   8Sx9k8RGgFL6TE/PHoLftIY7EWz1qKtah7ctSKg3HzHvyGbUGwVUp896p
   Pd6DWQQBGlwTrsS/uNa6UOF6/AgDwG/q6adn1ASTezr22LETiKZY/M8uJ
   5b65QEEfZu9tG1dcHb2yal/X8jTi8LbW+m3b52RjlUB3QmrtZKQpfcQiN
   hPxyUUgT6mx6C4+kCzyMW8spN3y4MAhXv/l7jN+PzZdzkt9d61lsl1iGg
   AdOXl1fAnX+fmh5QhGxT528PUBAlRrtOBGbENNrDO9Oy+l2BV5PgMYNBP
   w==;
X-CSE-ConnectionGUID: RDMCw2LXROmfDg3gmVqH2A==
X-CSE-MsgGUID: DbL/iv8MRViG1h3FKQEKnQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="53381540"
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="53381540"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 03:44:28 -0800
X-CSE-ConnectionGUID: I9EOpmc8R3mBeJ7S+55YcQ==
X-CSE-MsgGUID: z/1G2vVoTeaeqvia7bJxsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="150101963"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 07 Mar 2025 03:44:26 -0800
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tqW7s-0000P0-0R;
	Fri, 07 Mar 2025 11:44:24 +0000
Date: Fri, 07 Mar 2025 19:42:13 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:sched/urgent] BUILD SUCCESS
 b1536481c81fb604074da799e4f2d2038a1663f7
Message-ID: <202503071907.fThtZajz-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/urgent
branch HEAD: b1536481c81fb604074da799e4f2d2038a1663f7  sched/rt: Update limit of sched_rt sysctl in documentation

elapsed time: 1474m

configs tested: 80
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                   randconfig-001-20250306    gcc-13.2.0
arc                   randconfig-002-20250306    gcc-13.2.0
arm                               allnoconfig    clang-17
arm                   randconfig-001-20250306    gcc-14.2.0
arm                   randconfig-002-20250306    gcc-14.2.0
arm                   randconfig-003-20250306    gcc-14.2.0
arm                   randconfig-004-20250306    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250306    gcc-14.2.0
arm64                 randconfig-002-20250306    gcc-14.2.0
arm64                 randconfig-003-20250306    gcc-14.2.0
arm64                 randconfig-004-20250306    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250307    gcc-14.2.0
csky                  randconfig-002-20250307    gcc-14.2.0
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250307    clang-21
hexagon               randconfig-002-20250307    clang-21
i386        buildonly-randconfig-001-20250306    clang-19
i386        buildonly-randconfig-002-20250306    clang-19
i386        buildonly-randconfig-003-20250306    clang-19
i386        buildonly-randconfig-004-20250306    gcc-12
i386        buildonly-randconfig-005-20250306    gcc-12
i386        buildonly-randconfig-006-20250306    clang-19
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250307    gcc-14.2.0
loongarch             randconfig-002-20250307    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250307    gcc-14.2.0
nios2                 randconfig-002-20250307    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                randconfig-001-20250307    gcc-14.2.0
parisc                randconfig-002-20250307    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc               randconfig-001-20250307    gcc-14.2.0
powerpc               randconfig-002-20250307    clang-21
powerpc               randconfig-003-20250307    clang-19
powerpc64             randconfig-001-20250307    clang-21
powerpc64             randconfig-002-20250307    gcc-14.2.0
powerpc64             randconfig-003-20250307    gcc-14.2.0
riscv                             allnoconfig    gcc-14.2.0
riscv                 randconfig-001-20250306    clang-18
riscv                 randconfig-002-20250306    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250306    gcc-14.2.0
s390                  randconfig-002-20250306    clang-19
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250306    gcc-14.2.0
sh                    randconfig-002-20250306    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250306    gcc-14.2.0
sparc                 randconfig-002-20250306    gcc-14.2.0
sparc64               randconfig-001-20250306    gcc-14.2.0
sparc64               randconfig-002-20250306    gcc-14.2.0
um                                allnoconfig    clang-18
um                    randconfig-001-20250306    gcc-12
um                    randconfig-002-20250306    clang-16
x86_64                            allnoconfig    clang-19
x86_64      buildonly-randconfig-001-20250306    gcc-11
x86_64      buildonly-randconfig-002-20250306    clang-19
x86_64      buildonly-randconfig-003-20250306    clang-19
x86_64      buildonly-randconfig-004-20250306    clang-19
x86_64      buildonly-randconfig-005-20250306    clang-19
x86_64      buildonly-randconfig-006-20250306    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250306    gcc-14.2.0
xtensa                randconfig-002-20250306    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

