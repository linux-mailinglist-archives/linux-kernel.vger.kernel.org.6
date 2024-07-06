Return-Path: <linux-kernel+bounces-243391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3569295AE
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 00:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 658221F2177E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 22:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55653AC01;
	Sat,  6 Jul 2024 22:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cuJ8TGSa"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0932557F
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 22:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720305802; cv=none; b=FckUOKB28lL5xLwsHslGKBs/lGX7rl6f1jjf5e+leN05/XOqCB0o3tRYQxkTwCfLrEu9V5g0g8i48a+cFWMlKgxTcSLnrJ+fhCtfjVcKVnIJ4qh6E1esAvEqO1vMk0wpGwPorl2vrh1JTN+fsgau2g/virVmbuwaBZEVWGMdWvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720305802; c=relaxed/simple;
	bh=Y92XAk/7VzjHizNWUh1DHVlLR2cJgeOhtAqBGhQjeMw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=CSFBXJV2glDK6Lqj97HPMv0jZY8pTuUuET2CGYKhmxn9urTD7Mn7SqzsGVnEQQWAT56KXx7kb9JvkLHmKt1Rk0E1X4MEjZC5erFyHSWRaqjl8rRZHPzT9M1AEwBQrtmH0V3xHkbvatGyUfiLpUGK+7J1jH9jAPflHI5qBakx6hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cuJ8TGSa; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720305800; x=1751841800;
  h=date:from:to:cc:subject:message-id;
  bh=Y92XAk/7VzjHizNWUh1DHVlLR2cJgeOhtAqBGhQjeMw=;
  b=cuJ8TGSau28yGItdyjN+cqlXUs7jKPfS3I3gK3U7G/1HhFZAdZ5tgP6y
   xDmZbVQPDF8F+kuqKWY+BTUqPi9SJlgBe0Fsv7vcKjGN7p204mms0d1My
   qSFDQKfoekP2ppyRUsaqqS+FXFkHp/RIQGYDb1XR5zY8LXNxbb2LoLIsX
   cj2wfO/80Gpv+OBQih6dx4eiJbqOxiHAtFXrSPc9SCZ4SsERC8/3Wu04/
   0bPO4qW26BCVhtqwh38jVwtH1E3EszjS+38PDT1jrzoVdW1lUlCtkDWx9
   8GAqjqcL/iy0sJlmnbDaszONmJT5ZNsA1xXtLuYXM5ZtSRxI9LTF7Jzw2
   g==;
X-CSE-ConnectionGUID: PGRkh1XKSIOcDUCDNKQuFA==
X-CSE-MsgGUID: 9L3rTVTQSrS+vRIWGqdxXw==
X-IronPort-AV: E=McAfee;i="6700,10204,11125"; a="17262583"
X-IronPort-AV: E=Sophos;i="6.09,188,1716274800"; 
   d="scan'208";a="17262583"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2024 15:43:19 -0700
X-CSE-ConnectionGUID: RqRgsUYZSeKXllc1FmGDOw==
X-CSE-MsgGUID: 6JDO7sc/TxetRR0Au23S0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,188,1716274800"; 
   d="scan'208";a="47264842"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 06 Jul 2024 15:43:18 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sQE7g-000UMC-17;
	Sat, 06 Jul 2024 22:43:16 +0000
Date: Sun, 07 Jul 2024 06:42:40 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 7a368a53e7a149bce3e7d48f2e54023762e6c7b8
Message-ID: <202407070638.zHdtzsS6-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 7a368a53e7a149bce3e7d48f2e54023762e6c7b8  Merge branch into tip/master: 'x86/vmware'

elapsed time: 872m

configs tested: 130
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                            allyesconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                          axs103_defconfig   gcc-13.2.0
arc                   randconfig-001-20240706   gcc-13.2.0
arc                   randconfig-002-20240706   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                               allnoconfig   clang-19
arm                              allyesconfig   gcc-13.2.0
arm                        clps711x_defconfig   clang-19
arm                          gemini_defconfig   clang-19
arm                       netwinder_defconfig   gcc-13.2.0
arm                         nhk8815_defconfig   clang-19
arm                       omap2plus_defconfig   gcc-13.2.0
arm                   randconfig-001-20240706   gcc-13.2.0
arm                   randconfig-002-20240706   gcc-13.2.0
arm                   randconfig-003-20240706   gcc-13.2.0
arm                   randconfig-004-20240706   gcc-13.2.0
arm64                            allmodconfig   clang-19
arm64                             allnoconfig   gcc-13.2.0
arm64                 randconfig-001-20240706   gcc-13.2.0
arm64                 randconfig-002-20240706   gcc-13.2.0
arm64                 randconfig-003-20240706   clang-16
arm64                 randconfig-004-20240706   clang-19
csky                              allnoconfig   gcc-13.2.0
csky                  randconfig-001-20240706   gcc-13.2.0
csky                  randconfig-002-20240706   gcc-13.2.0
hexagon                          allmodconfig   clang-19
hexagon                           allnoconfig   clang-19
hexagon                          allyesconfig   clang-19
hexagon               randconfig-001-20240706   clang-19
hexagon               randconfig-002-20240706   clang-15
i386                             allmodconfig   gcc-13
i386                              allnoconfig   gcc-13
i386                             allyesconfig   gcc-13
i386                                defconfig   clang-18
loongarch                        allmodconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch             randconfig-001-20240706   gcc-13.2.0
loongarch             randconfig-002-20240706   gcc-13.2.0
m68k                             alldefconfig   gcc-13.2.0
m68k                             allmodconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                      loongson3_defconfig   gcc-13.2.0
mips                  maltasmvp_eva_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                 randconfig-001-20240706   gcc-13.2.0
nios2                 randconfig-002-20240706   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                         allyesconfig   gcc-13.2.0
openrisc                            defconfig   gcc-13.2.0
parisc                           allmodconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                           allyesconfig   gcc-13.2.0
parisc                              defconfig   gcc-13.2.0
parisc                randconfig-001-20240706   gcc-13.2.0
parisc                randconfig-002-20240706   gcc-13.2.0
powerpc                          allmodconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc                          allyesconfig   clang-19
powerpc                     ksi8560_defconfig   gcc-13.2.0
powerpc                   microwatt_defconfig   gcc-13.2.0
powerpc                     mpc83xx_defconfig   clang-19
powerpc               randconfig-001-20240706   gcc-13.2.0
powerpc               randconfig-002-20240706   gcc-13.2.0
powerpc               randconfig-003-20240706   clang-19
powerpc                     taishan_defconfig   clang-19
powerpc64             randconfig-001-20240706   gcc-13.2.0
powerpc64             randconfig-002-20240706   gcc-13.2.0
powerpc64             randconfig-003-20240706   clang-19
riscv                            allmodconfig   clang-19
riscv                             allnoconfig   gcc-13.2.0
riscv                            allyesconfig   clang-19
riscv                               defconfig   clang-19
riscv                 randconfig-001-20240706   gcc-13.2.0
riscv                 randconfig-002-20240706   gcc-13.2.0
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                             allyesconfig   gcc-13.2.0
s390                                defconfig   clang-19
s390                  randconfig-001-20240706   gcc-13.2.0
s390                  randconfig-002-20240706   clang-19
sh                               allmodconfig   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                               allyesconfig   gcc-13.2.0
sh                                  defconfig   gcc-13.2.0
sh                    randconfig-001-20240706   gcc-13.2.0
sh                    randconfig-002-20240706   gcc-13.2.0
sh                           se7619_defconfig   gcc-13.2.0
sh                        sh7785lcr_defconfig   gcc-13.2.0
sh                              ul2_defconfig   gcc-13.2.0
sparc                            allmodconfig   gcc-13.2.0
sparc64                             defconfig   gcc-13.2.0
sparc64               randconfig-001-20240706   gcc-13.2.0
sparc64               randconfig-002-20240706   gcc-13.2.0
um                               allmodconfig   clang-19
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-13
um                                  defconfig   clang-19
um                             i386_defconfig   gcc-13
um                    randconfig-001-20240706   clang-19
um                    randconfig-002-20240706   gcc-13
um                           x86_64_defconfig   clang-15
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240706   clang-18
x86_64       buildonly-randconfig-002-20240706   clang-18
x86_64       buildonly-randconfig-003-20240706   clang-18
x86_64       buildonly-randconfig-004-20240706   clang-18
x86_64       buildonly-randconfig-005-20240706   gcc-13
x86_64       buildonly-randconfig-006-20240706   clang-18
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240706   gcc-9
x86_64                randconfig-002-20240706   clang-18
x86_64                randconfig-003-20240706   clang-18
x86_64                randconfig-004-20240706   clang-18
x86_64                randconfig-005-20240706   clang-18
x86_64                randconfig-006-20240706   clang-18
x86_64                randconfig-011-20240706   gcc-12
x86_64                randconfig-012-20240706   gcc-12
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                randconfig-002-20240706   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

