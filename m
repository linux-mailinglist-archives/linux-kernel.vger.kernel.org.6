Return-Path: <linux-kernel+bounces-290506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A0C9554C9
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 04:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A79961F22BF6
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 02:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4604479CC;
	Sat, 17 Aug 2024 02:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cLegU7e1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847AE4C6C
	for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 02:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723860447; cv=none; b=jYrZR3Oq0HFc5v5r4AYooyRf8XTuV2f5w5boucPdV5c8U+hU4V7gUT8WZ2b7eb5oP0pvTu5MT/tnD9pp+YjOEvwSwzbmuUW2z+NqL3UbANoHzq6IhMdy+eEpNndCSyo0MMIRq4e/fZYsbTX0TG/wpYWpLYMbr0LZNfcfLVeNoqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723860447; c=relaxed/simple;
	bh=/1ZI7wAeZiXrkHHabeS8Ji+3itbx2ZJ+v+TJkdObWz0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=fdXbi2BNON4Pk6vxdMkbI2gMn7ZOnm/FSQXA4H3APv8em0BO2Ouss+7jD8p1l8Cy8XJa+RwQXMbSL93IpCne2tqx1UqfGnfTPwKWM75/auVleVyUsBLkeDngNcsqSayUVVN0NTdyW7V6bg3m1f/88g1YCopOnv/Nd+3eBujJ+A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cLegU7e1; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723860446; x=1755396446;
  h=date:from:to:cc:subject:message-id;
  bh=/1ZI7wAeZiXrkHHabeS8Ji+3itbx2ZJ+v+TJkdObWz0=;
  b=cLegU7e1bLfpFqFar+8G2o9RUQjrb49/+LNXRV7q8ftPA+NsdmJ8jn8F
   D6wWJFYk6Qj+kU/Ldz8yYIQc+NZcYBcmP7iaXGLiJ07tPr6lZwIyjaZYD
   im1yrCKp7JEzoyWIoWx3BhYg5EhUEHL6r9hAGwoIaZjpPVFNNziANbozc
   d5h7c2zSzjnbim7KUusoD/6zWqyozFP9/LPDdyVQyQaDwyU9kWSniIT9G
   Q+3FODkRczWSqpMx782gxyohcddX77C7EwL9H2Ka3Aa2sV1+HwDgq8oGo
   dN5KHp+yjx3rFlkaasOnNEu3H4R1WL26lwN+xubMMjwrw2XNyjrbo9ZXW
   A==;
X-CSE-ConnectionGUID: emmLgn+wTEyb0e2G7pUXUA==
X-CSE-MsgGUID: 8RamYlM0R6ODNrV2vHFG7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="22046090"
X-IronPort-AV: E=Sophos;i="6.10,153,1719903600"; 
   d="scan'208";a="22046090"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 19:07:25 -0700
X-CSE-ConnectionGUID: 9kkREWQuQuS5UssHNz4UyQ==
X-CSE-MsgGUID: XT4eZDIdTVqpLYnyCyl6vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,153,1719903600"; 
   d="scan'208";a="59685028"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 16 Aug 2024 19:07:24 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sf8qf-000774-23;
	Sat, 17 Aug 2024 02:07:21 +0000
Date: Sat, 17 Aug 2024 10:06:29 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:irq/core] BUILD SUCCESS
 7874673ee43f5e44d3cf4bf5e8e1df9e9aa5dffa
Message-ID: <202408171027.FPS8jmIF-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
branch HEAD: 7874673ee43f5e44d3cf4bf5e8e1df9e9aa5dffa  softirq: Remove unused 'action' parameter from action callback

elapsed time: 959m

configs tested: 138
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                   randconfig-001-20240817   gcc-13.2.0
arc                   randconfig-002-20240817   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-20
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-14.1.0
arm                   randconfig-001-20240817   gcc-14.1.0
arm                   randconfig-002-20240817   clang-20
arm                   randconfig-003-20240817   clang-20
arm                   randconfig-004-20240817   gcc-14.1.0
arm64                            allmodconfig   clang-20
arm64                             allnoconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-14.1.0
arm64                 randconfig-001-20240817   clang-20
arm64                 randconfig-002-20240817   gcc-14.1.0
arm64                 randconfig-003-20240817   gcc-14.1.0
arm64                 randconfig-004-20240817   gcc-14.1.0
csky                              allnoconfig   gcc-13.2.0
csky                              allnoconfig   gcc-14.1.0
csky                  randconfig-001-20240817   gcc-14.1.0
csky                  randconfig-002-20240817   gcc-14.1.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   clang-20
hexagon                          allyesconfig   clang-20
hexagon               randconfig-001-20240817   clang-20
hexagon               randconfig-002-20240817   clang-20
i386                             allmodconfig   gcc-12
i386                              allnoconfig   gcc-12
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240816   gcc-12
i386         buildonly-randconfig-002-20240816   clang-18
i386         buildonly-randconfig-003-20240816   clang-18
i386         buildonly-randconfig-004-20240816   clang-18
i386         buildonly-randconfig-005-20240816   gcc-11
i386         buildonly-randconfig-006-20240816   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240816   clang-18
i386                  randconfig-002-20240816   gcc-12
i386                  randconfig-003-20240816   gcc-11
i386                  randconfig-004-20240816   gcc-12
i386                  randconfig-005-20240816   clang-18
i386                  randconfig-006-20240816   gcc-11
i386                  randconfig-011-20240816   gcc-12
i386                  randconfig-012-20240816   clang-18
i386                  randconfig-013-20240816   clang-18
i386                  randconfig-014-20240816   gcc-12
i386                  randconfig-015-20240816   gcc-12
i386                  randconfig-016-20240816   gcc-12
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch             randconfig-001-20240817   gcc-14.1.0
loongarch             randconfig-002-20240817   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
mips                              allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-14.1.0
nios2                 randconfig-001-20240817   gcc-14.1.0
nios2                 randconfig-002-20240817   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                randconfig-001-20240817   gcc-14.1.0
parisc                randconfig-002-20240817   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-20
powerpc               randconfig-001-20240817   clang-14
powerpc               randconfig-002-20240817   gcc-14.1.0
powerpc64             randconfig-001-20240817   gcc-14.1.0
powerpc64             randconfig-002-20240817   clang-16
powerpc64             randconfig-003-20240817   clang-20
riscv                            allmodconfig   clang-20
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-20
riscv                 randconfig-001-20240817   gcc-14.1.0
riscv                 randconfig-002-20240817   clang-17
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                  randconfig-001-20240817   gcc-14.1.0
s390                  randconfig-002-20240817   clang-20
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                    randconfig-001-20240817   gcc-14.1.0
sh                    randconfig-002-20240817   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64               randconfig-001-20240817   gcc-14.1.0
sparc64               randconfig-002-20240817   gcc-14.1.0
um                               allmodconfig   clang-20
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-12
um                    randconfig-001-20240817   gcc-12
um                    randconfig-002-20240817   gcc-12
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240817   gcc-12
x86_64       buildonly-randconfig-002-20240817   gcc-12
x86_64       buildonly-randconfig-003-20240817   gcc-11
x86_64       buildonly-randconfig-004-20240817   gcc-12
x86_64       buildonly-randconfig-005-20240817   gcc-12
x86_64       buildonly-randconfig-006-20240817   clang-18
x86_64                              defconfig   gcc-11
x86_64                randconfig-001-20240817   clang-18
x86_64                randconfig-002-20240817   clang-18
x86_64                randconfig-003-20240817   gcc-12
x86_64                randconfig-004-20240817   gcc-12
x86_64                randconfig-005-20240817   clang-18
x86_64                randconfig-006-20240817   clang-18
x86_64                randconfig-011-20240817   clang-18
x86_64                randconfig-012-20240817   clang-18
x86_64                randconfig-013-20240817   gcc-12
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240817   gcc-14.1.0
xtensa                randconfig-002-20240817   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

