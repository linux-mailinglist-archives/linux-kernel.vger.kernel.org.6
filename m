Return-Path: <linux-kernel+bounces-180360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCB58C6D6E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 22:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E975283ED4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 20:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC37615B0EA;
	Wed, 15 May 2024 20:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nNRtIV7d"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E013BBEA
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 20:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715806510; cv=none; b=lhc4MHa1QlcZI6c6IN+EhiU5NDCsT5NzhHb0a3TVZZXy0BPq2ouTkTZ5Zn+o5PxrHgcLA+NOjWjFjWvF3OwZwo1h9moDQzU8OdQhNu87HIXD47shVUkbVvJ2S/wxnDaOUEEsYZ7eK7BlBZYbGGuDsHHLwLmzaadfKYcIxpV0uxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715806510; c=relaxed/simple;
	bh=A1iyLn9KO+A4gGfOcq+/F+lKzEft5zuQ6Rog9nWIJF4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=YCt09io3y0QX9Hc0zqNp3SNnqham600DugCktBv1sN5gvYkrPvtIcW5HkMuq7hWGOHo+f+7IDQO2WPfig9DpON8U+HQVgrgIBa9k8k4LSk9n6GslFHjrMJ+0gevqzkW2ioZlUylk24Izts+L/BUS0A6EX5ftTs1q7xHTBVtZ6j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nNRtIV7d; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715806508; x=1747342508;
  h=date:from:to:cc:subject:message-id;
  bh=A1iyLn9KO+A4gGfOcq+/F+lKzEft5zuQ6Rog9nWIJF4=;
  b=nNRtIV7dX98BR2xazt2F0U/6vhv3nufHg8u5wfY7W3PLoniA3fHSoGtr
   dfSFYJzAbPrzUi/LdkCyH9Uvbkh3P31c5q0sODma76DgErnTyu7OlTg11
   zDbjHRuZcdgl2eQdanq7IcHSakuh7bc4TdMx2IylQExpMbW4PcWLgEqIp
   9xznIxV6Ojd6E8cvzhgl0HXH6Cvp0i2Q1yORJKUk5hoPRKBmu9roTgqu1
   xbpJJWf+hOQ34T89vl6E6kNHpTfrFFe5up+O/RgWJR3s6shCqvye91BwM
   2DuB09MrNa1ETl3Ji8dZQpHLm978xFQ52oIyZ8UiRbEQrA1BPqbb2YIl6
   Q==;
X-CSE-ConnectionGUID: a63a1bejTzOQq03t8Bz5wg==
X-CSE-MsgGUID: 9trr73hyTOOP/kzEy0U+5A==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="11753489"
X-IronPort-AV: E=Sophos;i="6.08,162,1712646000"; 
   d="scan'208";a="11753489"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 13:55:07 -0700
X-CSE-ConnectionGUID: VxsXJl3IQteLoggfszgt2A==
X-CSE-MsgGUID: 75w5mRHDQ5Wmzym5LZvxsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,162,1712646000"; 
   d="scan'208";a="31760513"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 15 May 2024 13:55:06 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s7LeR-000DG9-1o;
	Wed, 15 May 2024 20:55:03 +0000
Date: Thu, 16 May 2024 04:54:44 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:sched/urgent] BUILD SUCCESS
 e5bc44e47c531860be96ac615314b1ab23d5aa2b
Message-ID: <202405160442.x3ARq5LI-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/urgent
branch HEAD: e5bc44e47c531860be96ac615314b1ab23d5aa2b  arch/topology: Fix variable naming to avoid shadowing

elapsed time: 723m

configs tested: 179
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240515   gcc  
arc                   randconfig-002-20240515   gcc  
arc                        vdk_hs38_defconfig   gcc  
arm                              alldefconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                        clps711x_defconfig   clang
arm                                 defconfig   clang
arm                       multi_v4t_defconfig   clang
arm                             pxa_defconfig   gcc  
arm                   randconfig-001-20240515   clang
arm                   randconfig-002-20240515   gcc  
arm                   randconfig-003-20240515   clang
arm                   randconfig-004-20240515   gcc  
arm                           sama7_defconfig   clang
arm                         vf610m4_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240515   gcc  
arm64                 randconfig-002-20240515   clang
arm64                 randconfig-003-20240515   clang
arm64                 randconfig-004-20240515   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240515   gcc  
csky                  randconfig-002-20240515   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240515   clang
hexagon               randconfig-002-20240515   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240515   gcc  
i386         buildonly-randconfig-002-20240515   gcc  
i386         buildonly-randconfig-003-20240515   gcc  
i386         buildonly-randconfig-004-20240515   gcc  
i386         buildonly-randconfig-005-20240515   gcc  
i386         buildonly-randconfig-006-20240515   clang
i386                                defconfig   clang
i386                  randconfig-001-20240515   clang
i386                  randconfig-002-20240515   gcc  
i386                  randconfig-003-20240515   gcc  
i386                  randconfig-004-20240515   gcc  
i386                  randconfig-005-20240515   clang
i386                  randconfig-006-20240515   gcc  
i386                  randconfig-011-20240515   clang
i386                  randconfig-012-20240515   gcc  
i386                  randconfig-013-20240515   clang
i386                  randconfig-014-20240515   gcc  
i386                  randconfig-015-20240515   gcc  
i386                  randconfig-016-20240515   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240515   gcc  
loongarch             randconfig-002-20240515   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                  decstation_64_defconfig   gcc  
mips                     loongson1b_defconfig   clang
mips                        qi_lb60_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240515   gcc  
nios2                 randconfig-002-20240515   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240515   gcc  
parisc                randconfig-002-20240515   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      arches_defconfig   gcc  
powerpc                       holly_defconfig   clang
powerpc                 mpc837x_rdb_defconfig   gcc  
powerpc               randconfig-001-20240515   clang
powerpc               randconfig-002-20240515   clang
powerpc               randconfig-003-20240515   gcc  
powerpc64             randconfig-001-20240515   gcc  
powerpc64             randconfig-002-20240515   clang
powerpc64             randconfig-003-20240515   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                    nommu_virt_defconfig   clang
riscv                 randconfig-001-20240515   clang
riscv                 randconfig-002-20240515   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240515   clang
s390                  randconfig-002-20240515   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                               j2_defconfig   gcc  
sh                          lboxre2_defconfig   gcc  
sh                    randconfig-001-20240515   gcc  
sh                    randconfig-002-20240515   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240515   gcc  
sparc64               randconfig-002-20240515   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240515   gcc  
um                    randconfig-002-20240515   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240515   gcc  
x86_64       buildonly-randconfig-002-20240515   gcc  
x86_64       buildonly-randconfig-003-20240515   clang
x86_64       buildonly-randconfig-004-20240515   clang
x86_64       buildonly-randconfig-005-20240515   clang
x86_64       buildonly-randconfig-006-20240515   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240515   gcc  
x86_64                randconfig-002-20240515   clang
x86_64                randconfig-003-20240515   clang
x86_64                randconfig-004-20240515   clang
x86_64                randconfig-005-20240515   clang
x86_64                randconfig-006-20240515   clang
x86_64                randconfig-011-20240515   clang
x86_64                randconfig-012-20240515   clang
x86_64                randconfig-013-20240515   gcc  
x86_64                randconfig-014-20240515   gcc  
x86_64                randconfig-015-20240515   clang
x86_64                randconfig-016-20240515   clang
x86_64                randconfig-071-20240515   gcc  
x86_64                randconfig-072-20240515   gcc  
x86_64                randconfig-073-20240515   gcc  
x86_64                randconfig-074-20240515   clang
x86_64                randconfig-075-20240515   clang
x86_64                randconfig-076-20240515   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240515   gcc  
xtensa                randconfig-002-20240515   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

