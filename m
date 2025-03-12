Return-Path: <linux-kernel+bounces-558254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F902A5E380
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 19:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EB2B17BF6A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 18:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9DCC254B02;
	Wed, 12 Mar 2025 18:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dYwhYlB2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BB91C84CE
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 18:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741803220; cv=none; b=ax69HUPuTsR69FAFMuv+6BvpBL/aWKHxt1s42xQdtSthV/5ZbhzKDt7hiIlfz6mZemnVmxOREoKATGTV7G4J4XzxVnYH99GHjzUVviJLrVlw+mcB7stjGaQLiAfpiLQRBN63ShKh4/7qJVp4+NQGRkNkaCeMyZeps9ySPXfiVW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741803220; c=relaxed/simple;
	bh=c2evfhIy59TEcaEVB2GjivzBM8t0Ghf2GV96PeQIQFI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ltM6OPC7InROXnk0LSsA/nOGRu80I1CQu/5v37pqtjaApr7OSqKxrVNz4bhjFwFUhPxZhbVTEA/QkXlNgt86JKft8A8SfyBP+NhZjWq7CpavM6+UCSw3haVk3cswBvnbCI0/7QYzG9niGWosUYsRWY6YaU/u3BEhnlUVIKzDk9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dYwhYlB2; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741803218; x=1773339218;
  h=date:from:to:cc:subject:message-id;
  bh=c2evfhIy59TEcaEVB2GjivzBM8t0Ghf2GV96PeQIQFI=;
  b=dYwhYlB2aR/VaHQ4LcuqAqmTHqf85SUORjfXVrPM4iUT3RqUiS5he0BX
   UzBV9pIwzOuCKyqWu+s8XGuH4Rcs1kSeUAtYHEaUEb9lp7nySAdfQKjAq
   2KrSPSh+mA6KqWN0pyyR6Tea24FDVoa6wZAmcLTxIJEPj3YHYDjfLX8O8
   miu8DqVyZZw7lr2fx+/WYCAlM0BPqvSMATwGbsbiIujrCfdtIIZvvYZmI
   y6n6Z0G395T3mc2urRRh5DndVl6b/2ItrVSD9QAyStytA/TjKPmJ2NcO3
   lzTel8z4TEDDVGey1Rwe+4TzjKd/zADuTjIYJe9vfB4HQx3gmFC4tl+Mb
   A==;
X-CSE-ConnectionGUID: yTtIAhKPQ1Gbo+4tNqOgnw==
X-CSE-MsgGUID: PlsAeejtRVOBtWaoAFhrbw==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="42808224"
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="42808224"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 11:13:38 -0700
X-CSE-ConnectionGUID: HNILGOkGQXeAisxjQAlk3A==
X-CSE-MsgGUID: FLuYIjveQ4q1qImsug+sdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="121211498"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 12 Mar 2025 11:13:37 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tsQaE-0008nG-0F;
	Wed, 12 Mar 2025 18:13:34 +0000
Date: Thu, 13 Mar 2025 02:12:57 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2025.03.09a] BUILD SUCCESS
 2f195a7653b697942f3c046a48c46f348bdd13ac
Message-ID: <202503130251.ydgNGinm-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2025.03.09a
branch HEAD: 2f195a7653b697942f3c046a48c46f348bdd13ac  torture: Add --do-{,no-}normal to torture.sh

elapsed time: 2827m

configs tested: 100
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                 nsimosci_hs_smp_defconfig    gcc-13.2.0
arc                   randconfig-001-20250312    gcc-13.2.0
arc                   randconfig-002-20250312    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                   randconfig-001-20250312    clang-19
arm                   randconfig-002-20250312    clang-21
arm                   randconfig-003-20250312    clang-19
arm                   randconfig-004-20250312    clang-21
arm64                            allmodconfig    clang-18
arm64                 randconfig-001-20250312    clang-21
arm64                 randconfig-002-20250312    gcc-14.2.0
arm64                 randconfig-003-20250312    gcc-14.2.0
arm64                 randconfig-004-20250312    gcc-14.2.0
csky                  randconfig-001-20250312    gcc-14.2.0
csky                  randconfig-002-20250312    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250312    clang-21
hexagon               randconfig-002-20250312    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250312    clang-19
i386        buildonly-randconfig-002-20250312    clang-19
i386        buildonly-randconfig-003-20250312    gcc-12
i386        buildonly-randconfig-004-20250312    gcc-12
i386        buildonly-randconfig-005-20250312    gcc-12
i386        buildonly-randconfig-006-20250312    clang-19
i386                                defconfig    clang-19
loongarch             randconfig-001-20250312    gcc-14.2.0
loongarch             randconfig-002-20250312    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                         apollo_defconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250312    gcc-14.2.0
nios2                 randconfig-002-20250312    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                randconfig-001-20250312    gcc-14.2.0
parisc                randconfig-002-20250312    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc               randconfig-001-20250312    clang-21
powerpc               randconfig-002-20250312    clang-21
powerpc               randconfig-003-20250312    clang-21
powerpc64             randconfig-001-20250312    clang-17
powerpc64             randconfig-002-20250312    clang-15
powerpc64             randconfig-003-20250312    clang-21
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-21
riscv                 randconfig-001-20250312    clang-21
riscv                 randconfig-002-20250312    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250312    clang-15
s390                  randconfig-002-20250312    clang-16
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                             espt_defconfig    gcc-14.2.0
sh                    randconfig-001-20250312    gcc-14.2.0
sh                    randconfig-002-20250312    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250312    gcc-14.2.0
sparc                 randconfig-002-20250312    gcc-14.2.0
sparc64               randconfig-001-20250312    gcc-14.2.0
sparc64               randconfig-002-20250312    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250312    gcc-12
um                    randconfig-002-20250312    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250312    clang-19
x86_64      buildonly-randconfig-002-20250312    clang-19
x86_64      buildonly-randconfig-003-20250312    gcc-12
x86_64      buildonly-randconfig-004-20250312    clang-19
x86_64      buildonly-randconfig-005-20250312    clang-19
x86_64      buildonly-randconfig-006-20250312    clang-19
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250312    gcc-14.2.0
xtensa                randconfig-002-20250312    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

