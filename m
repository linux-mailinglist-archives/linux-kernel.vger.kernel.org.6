Return-Path: <linux-kernel+bounces-182682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C538C8E66
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 01:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DBB9283A4C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 23:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B716E4596B;
	Fri, 17 May 2024 23:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P2YyUabb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2096BA29
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 23:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715987093; cv=none; b=PG13L91epQUJY3bCrcfCF9/Knh0yuVyGUvc/fV8BWrVNg41G53ZjInEfHLxb/eEEn2LX3R5/hH3KCKmAjkOY93/u/KzCJ7zKj6NvVRjNpLVeu9LfB2rifyPvhxf0M29LJjCSBF6M4mREh/n6uOQA1usneMdgx0IToSs9fm2uILo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715987093; c=relaxed/simple;
	bh=fmf704qmmjUrgUwolwHhW2GBWdDFybLBPJXTPs8OL4Q=;
	h=Date:From:To:Cc:Subject:Message-ID; b=uvn9mwkh8pglbEx4cLMG85zqGcCBBMKRWSfUzAhdjByjJGZ5YIg7z7nc5N4rmxxrThsapEHQhP7dX8uPB+MIRxfC8tBQS1GzI+lIv85pd2n9B0EZoFtvfwtOW1pFA+nHqEbZmGLkJdp46m9iVh2RWA+fVw84AHNOmA4ULUxVPYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P2YyUabb; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715987092; x=1747523092;
  h=date:from:to:cc:subject:message-id;
  bh=fmf704qmmjUrgUwolwHhW2GBWdDFybLBPJXTPs8OL4Q=;
  b=P2YyUabb8LfyYuwumhYSQe1fi+ofqCFLZa5GrFN8if3/nl/Ts90fJ6yB
   1GnQqWpjQNej3stKIUep08T4yZPUK2j/1U5eKwwDjJQaszz2FGQ92MLTM
   YvgPkXrokXDYQMzppDM3nGpfIgCwoKuroYqRCtwWitAsXhOleyqUORvPS
   lHMNBUe9bw0kKb88QPovqTVVt7eFiIejLt4cx37yXrjUwDTVCMXe3qd/6
   9FbADI49Lk91XsORIoVbbgiTJzuGYZxZSOMz1fMRr1xg6L9conOOpnpES
   hJyhMqXV8PkouZh9lpYxY4h6Rl4c7ssVRE+jlobCy3JklT1sfuc/EFrlH
   Q==;
X-CSE-ConnectionGUID: uxrKKWjzQnSeaBQ6v4ytKA==
X-CSE-MsgGUID: 9r0yVtNiQh+3TozJeJjt3A==
X-IronPort-AV: E=McAfee;i="6600,9927,11075"; a="12361600"
X-IronPort-AV: E=Sophos;i="6.08,169,1712646000"; 
   d="scan'208";a="12361600"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 16:04:48 -0700
X-CSE-ConnectionGUID: ijh1bFfsSb62+RVcG3Kk2Q==
X-CSE-MsgGUID: /3MonUscSG6SqDKDYAg2gQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,169,1712646000"; 
   d="scan'208";a="31924280"
Received: from unknown (HELO 108735ec233b) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 17 May 2024 16:04:46 -0700
Received: from kbuild by 108735ec233b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s86c6-0001DH-2m;
	Fri, 17 May 2024 23:04:00 +0000
Date: Sat, 18 May 2024 07:02:34 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:sched/urgent] BUILD SUCCESS
 49217ea147df7647cb89161b805c797487783fc0
Message-ID: <202405180732.h4RxBPEc-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/urgent
branch HEAD: 49217ea147df7647cb89161b805c797487783fc0  sched/core: Fix incorrect initialization of the 'burst' parameter in cpu_max_write()

elapsed time: 898m

configs tested: 155
configs skipped: 4

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
arc                   randconfig-001-20240517   gcc  
arc                   randconfig-002-20240517   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                          exynos_defconfig   clang
arm                          moxart_defconfig   gcc  
arm                        neponset_defconfig   gcc  
arm                   randconfig-001-20240517   clang
arm                   randconfig-002-20240517   clang
arm                   randconfig-003-20240517   clang
arm                   randconfig-004-20240517   clang
arm                    vt8500_v6_v7_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240517   clang
arm64                 randconfig-002-20240517   gcc  
arm64                 randconfig-003-20240517   clang
arm64                 randconfig-004-20240517   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240517   gcc  
csky                  randconfig-002-20240517   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240517   clang
hexagon               randconfig-002-20240517   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240517   clang
i386         buildonly-randconfig-002-20240517   clang
i386         buildonly-randconfig-003-20240517   gcc  
i386         buildonly-randconfig-004-20240517   clang
i386         buildonly-randconfig-005-20240517   clang
i386         buildonly-randconfig-006-20240517   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240517   gcc  
i386                  randconfig-002-20240517   gcc  
i386                  randconfig-003-20240517   gcc  
i386                  randconfig-004-20240517   gcc  
i386                  randconfig-005-20240517   gcc  
i386                  randconfig-006-20240517   gcc  
i386                  randconfig-011-20240517   gcc  
i386                  randconfig-012-20240517   clang
i386                  randconfig-013-20240517   gcc  
i386                  randconfig-014-20240517   gcc  
i386                  randconfig-015-20240517   clang
i386                  randconfig-016-20240517   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240517   gcc  
loongarch             randconfig-002-20240517   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5272c3_defconfig   gcc  
m68k                            mac_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                        bcm47xx_defconfig   clang
mips                  cavium_octeon_defconfig   gcc  
mips                           jazz_defconfig   clang
nios2                         10m50_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240517   gcc  
nios2                 randconfig-002-20240517   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240517   gcc  
parisc                randconfig-002-20240517   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                     mpc512x_defconfig   clang
powerpc                      ppc64e_defconfig   gcc  
powerpc               randconfig-001-20240517   clang
powerpc               randconfig-002-20240517   clang
powerpc               randconfig-003-20240517   gcc  
powerpc64             randconfig-001-20240517   gcc  
powerpc64             randconfig-002-20240517   gcc  
powerpc64             randconfig-003-20240517   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240517   clang
riscv                 randconfig-002-20240517   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240517   clang
s390                  randconfig-002-20240517   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                            hp6xx_defconfig   gcc  
sh                    randconfig-001-20240517   gcc  
sh                    randconfig-002-20240517   gcc  
sh                          rsk7201_defconfig   gcc  
sh                          rsk7203_defconfig   gcc  
sh                           se7722_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240517   gcc  
sparc64               randconfig-002-20240517   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240517   clang
um                    randconfig-002-20240517   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                generic_kc705_defconfig   gcc  
xtensa                randconfig-001-20240517   gcc  
xtensa                randconfig-002-20240517   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

