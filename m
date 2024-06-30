Return-Path: <linux-kernel+bounces-235140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C75891D0AA
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 10:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0214E1F2154B
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 08:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3030E12C7F9;
	Sun, 30 Jun 2024 08:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GREpndse"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35771EA80
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 08:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719737334; cv=none; b=BHwUsvY129FcHb26AUoXRygpfUDJdPV4KiRpJ+LfXed1vJOUqBTVi3J+ajY9V7qEgxmwuZSk1K9ThhU7qWn1hstUEViutCBnOR4YXKnH0x5LVKOOlr1rXAIt/8P2jgfJqSbtGK2lvnro7U9KPePHYypler0NvU51yk1Bgu1Q67U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719737334; c=relaxed/simple;
	bh=sDLDLt6j5ye4ip8/EhIV2eKWDlzP5d54wwt2Kps03so=;
	h=Date:From:To:Cc:Subject:Message-ID; b=XYe5NsNFoprIVSaxOBfuyryOh1mmvg9BcAQYAafi7IqN3XD0qXao/Iv4+hT/jYFySPgP1aQGmGsQ1hUP2RcFunz1ynDrniDv4AstyIYPWr4r2pK6KMtu05SZnko0FKejKKGw49WIDogUsl+Av7X98L6SpP11OJ5zDw/4E3ADQaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GREpndse; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719737333; x=1751273333;
  h=date:from:to:cc:subject:message-id;
  bh=sDLDLt6j5ye4ip8/EhIV2eKWDlzP5d54wwt2Kps03so=;
  b=GREpndsenNOX9D1AdeCUDd+j9GcErgywJ3VqDeN0+2qKJFj78RjXZ+po
   E/DnwI7t6atjebI3JKGcS3a6Saw5upIAOtkIaIiGz16UvxpLm6LbcgMzM
   xbZKdTZC1MhMmz/qve4ZHh05Lryje4p9glgEd2Todc2Q/otXI4ks95OJm
   kKAqq2ROoEGqlIhLMex7HSFHvceDvzYBcwGnb4FIr+NrbdH6KLZ0lujOt
   t9AEKBAdtI++kibwAtajMd/xCZZVCLvxQegaO0BAoW2e6WCp08Pgghwl5
   nJna4wnxDuWT2Z0HlNp5fi97pwKY19sPLEsHIeI/bKAHEp4zFF+qONDXU
   Q==;
X-CSE-ConnectionGUID: IphIlboaTNavp0yD7UWyog==
X-CSE-MsgGUID: D8eCvXiyQj+o6OAYY2Q0Qw==
X-IronPort-AV: E=McAfee;i="6700,10204,11118"; a="27998329"
X-IronPort-AV: E=Sophos;i="6.09,173,1716274800"; 
   d="scan'208";a="27998329"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2024 01:48:53 -0700
X-CSE-ConnectionGUID: TODiIub2SU6cvrAaevSg3g==
X-CSE-MsgGUID: X5dOyWfvSNyLMMIXEfMuIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,173,1716274800"; 
   d="scan'208";a="45863567"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 30 Jun 2024 01:48:51 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sNqEq-000LLO-2I;
	Sun, 30 Jun 2024 08:48:48 +0000
Date: Sun, 30 Jun 2024 16:47:56 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/bugs] BUILD SUCCESS
 42c141fbb651b64db492aab35bc1d96eb4c20261
Message-ID: <202406301654.btnn5I9i-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/bugs
branch HEAD: 42c141fbb651b64db492aab35bc1d96eb4c20261  x86/bugs: Add 'spectre_bhi=vmexit' cmdline option

elapsed time: 1614m

configs tested: 231
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                          axs101_defconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                     nsimosci_hs_defconfig   gcc-13.2.0
arc                   randconfig-001-20240629   gcc-13.2.0
arc                   randconfig-001-20240630   gcc-13.2.0
arc                   randconfig-002-20240629   gcc-13.2.0
arc                   randconfig-002-20240630   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                     am200epdkit_defconfig   gcc-13.2.0
arm                                 defconfig   gcc-13.2.0
arm                      footbridge_defconfig   gcc-13.2.0
arm                        mvebu_v5_defconfig   gcc-13.2.0
arm                         nhk8815_defconfig   gcc-13.2.0
arm                       omap2plus_defconfig   gcc-13.2.0
arm                   randconfig-001-20240629   gcc-13.2.0
arm                   randconfig-001-20240630   gcc-13.2.0
arm                   randconfig-002-20240629   gcc-13.2.0
arm                   randconfig-002-20240630   gcc-13.2.0
arm                   randconfig-003-20240629   gcc-13.2.0
arm                   randconfig-003-20240630   gcc-13.2.0
arm                   randconfig-004-20240629   gcc-13.2.0
arm                   randconfig-004-20240630   gcc-13.2.0
arm                             rpc_defconfig   gcc-13.2.0
arm                         s5pv210_defconfig   gcc-13.2.0
arm                         socfpga_defconfig   gcc-13.2.0
arm                           sunxi_defconfig   gcc-13.2.0
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240629   gcc-13.2.0
arm64                 randconfig-001-20240630   gcc-13.2.0
arm64                 randconfig-002-20240629   gcc-13.2.0
arm64                 randconfig-002-20240630   gcc-13.2.0
arm64                 randconfig-003-20240629   gcc-13.2.0
arm64                 randconfig-003-20240630   gcc-13.2.0
arm64                 randconfig-004-20240629   gcc-13.2.0
arm64                 randconfig-004-20240630   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240629   gcc-13.2.0
csky                  randconfig-001-20240630   gcc-13.2.0
csky                  randconfig-002-20240629   gcc-13.2.0
csky                  randconfig-002-20240630   gcc-13.2.0
i386                             allmodconfig   clang-18
i386                              allnoconfig   clang-18
i386                             allyesconfig   clang-18
i386         buildonly-randconfig-001-20240629   gcc-7
i386         buildonly-randconfig-001-20240630   clang-18
i386         buildonly-randconfig-002-20240629   gcc-7
i386         buildonly-randconfig-002-20240630   clang-18
i386         buildonly-randconfig-003-20240629   gcc-7
i386         buildonly-randconfig-003-20240630   clang-18
i386         buildonly-randconfig-004-20240629   gcc-7
i386         buildonly-randconfig-004-20240630   clang-18
i386         buildonly-randconfig-005-20240629   gcc-7
i386         buildonly-randconfig-005-20240630   clang-18
i386         buildonly-randconfig-006-20240629   gcc-7
i386         buildonly-randconfig-006-20240630   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240629   gcc-7
i386                  randconfig-001-20240630   clang-18
i386                  randconfig-002-20240629   gcc-7
i386                  randconfig-002-20240630   clang-18
i386                  randconfig-003-20240629   gcc-7
i386                  randconfig-003-20240630   clang-18
i386                  randconfig-004-20240629   gcc-7
i386                  randconfig-004-20240630   clang-18
i386                  randconfig-005-20240629   gcc-7
i386                  randconfig-005-20240630   clang-18
i386                  randconfig-006-20240629   gcc-7
i386                  randconfig-006-20240630   clang-18
i386                  randconfig-011-20240629   gcc-7
i386                  randconfig-011-20240630   clang-18
i386                  randconfig-012-20240629   gcc-7
i386                  randconfig-012-20240630   clang-18
i386                  randconfig-013-20240629   gcc-7
i386                  randconfig-013-20240630   clang-18
i386                  randconfig-014-20240629   gcc-7
i386                  randconfig-014-20240630   clang-18
i386                  randconfig-015-20240629   gcc-7
i386                  randconfig-015-20240630   clang-18
i386                  randconfig-016-20240629   gcc-7
i386                  randconfig-016-20240630   clang-18
loongarch                        allmodconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240629   gcc-13.2.0
loongarch             randconfig-001-20240630   gcc-13.2.0
loongarch             randconfig-002-20240629   gcc-13.2.0
loongarch             randconfig-002-20240630   gcc-13.2.0
m68k                             allmodconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-13.2.0
m68k                                defconfig   gcc-13.2.0
m68k                          hp300_defconfig   gcc-13.2.0
m68k                       m5249evb_defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-13.2.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                           ci20_defconfig   gcc-13.2.0
mips                        maltaup_defconfig   gcc-13.2.0
mips                      pic32mzda_defconfig   gcc-13.2.0
mips                         rt305x_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240629   gcc-13.2.0
nios2                 randconfig-001-20240630   gcc-13.2.0
nios2                 randconfig-002-20240629   gcc-13.2.0
nios2                 randconfig-002-20240630   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                         allyesconfig   gcc-13.2.0
openrisc                            defconfig   gcc-13.2.0
openrisc                  or1klitex_defconfig   gcc-13.2.0
parisc                           allmodconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                           allyesconfig   gcc-13.2.0
parisc                              defconfig   gcc-13.2.0
parisc                randconfig-001-20240629   gcc-13.2.0
parisc                randconfig-001-20240630   gcc-13.2.0
parisc                randconfig-002-20240629   gcc-13.2.0
parisc                randconfig-002-20240630   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                     akebono_defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc                          allyesconfig   gcc-13.2.0
powerpc                       holly_defconfig   gcc-13.2.0
powerpc                      katmai_defconfig   gcc-13.2.0
powerpc                      obs600_defconfig   gcc-13.2.0
powerpc                      pmac32_defconfig   gcc-13.2.0
powerpc               randconfig-001-20240629   gcc-13.2.0
powerpc               randconfig-001-20240630   gcc-13.2.0
powerpc               randconfig-002-20240629   gcc-13.2.0
powerpc               randconfig-002-20240630   gcc-13.2.0
powerpc               randconfig-003-20240629   gcc-13.2.0
powerpc               randconfig-003-20240630   gcc-13.2.0
powerpc                     tqm8541_defconfig   gcc-13.2.0
powerpc64             randconfig-001-20240629   gcc-13.2.0
powerpc64             randconfig-001-20240630   gcc-13.2.0
powerpc64             randconfig-002-20240629   gcc-13.2.0
powerpc64             randconfig-002-20240630   gcc-13.2.0
powerpc64             randconfig-003-20240629   gcc-13.2.0
powerpc64             randconfig-003-20240630   gcc-13.2.0
riscv                            allmodconfig   gcc-13.2.0
riscv                             allnoconfig   gcc-13.2.0
riscv                            allyesconfig   gcc-13.2.0
riscv                               defconfig   gcc-13.2.0
riscv                 randconfig-001-20240629   gcc-13.2.0
riscv                 randconfig-001-20240630   gcc-13.2.0
riscv                 randconfig-002-20240629   gcc-13.2.0
riscv                 randconfig-002-20240630   gcc-13.2.0
s390                              allnoconfig   gcc-13.2.0
s390                                defconfig   gcc-13.2.0
s390                  randconfig-001-20240629   gcc-13.2.0
s390                  randconfig-001-20240630   gcc-13.2.0
s390                  randconfig-002-20240629   gcc-13.2.0
s390                  randconfig-002-20240630   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                         apsh4a3a_defconfig   gcc-13.2.0
sh                                  defconfig   gcc-13.2.0
sh                             espt_defconfig   gcc-13.2.0
sh                               j2_defconfig   gcc-13.2.0
sh                     magicpanelr2_defconfig   gcc-13.2.0
sh                    randconfig-001-20240629   gcc-13.2.0
sh                    randconfig-001-20240630   gcc-13.2.0
sh                    randconfig-002-20240629   gcc-13.2.0
sh                    randconfig-002-20240630   gcc-13.2.0
sh                          rsk7203_defconfig   gcc-13.2.0
sh                           se7206_defconfig   gcc-13.2.0
sh                           se7343_defconfig   gcc-13.2.0
sh                           se7780_defconfig   gcc-13.2.0
sh                            titan_defconfig   gcc-13.2.0
sparc64                             defconfig   gcc-13.2.0
sparc64               randconfig-001-20240629   gcc-13.2.0
sparc64               randconfig-001-20240630   gcc-13.2.0
sparc64               randconfig-002-20240629   gcc-13.2.0
sparc64               randconfig-002-20240630   gcc-13.2.0
um                                allnoconfig   gcc-13.2.0
um                                  defconfig   gcc-13.2.0
um                             i386_defconfig   gcc-13.2.0
um                    randconfig-001-20240629   gcc-13.2.0
um                    randconfig-001-20240630   gcc-13.2.0
um                    randconfig-002-20240629   gcc-13.2.0
um                    randconfig-002-20240630   gcc-13.2.0
um                           x86_64_defconfig   gcc-13.2.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240630   gcc-13
x86_64       buildonly-randconfig-002-20240630   gcc-13
x86_64       buildonly-randconfig-003-20240630   gcc-13
x86_64       buildonly-randconfig-004-20240630   gcc-13
x86_64       buildonly-randconfig-005-20240630   gcc-13
x86_64       buildonly-randconfig-006-20240630   gcc-13
x86_64                              defconfig   clang-18
x86_64                                  kexec   clang-18
x86_64                randconfig-001-20240630   gcc-13
x86_64                randconfig-002-20240630   gcc-13
x86_64                randconfig-003-20240630   gcc-13
x86_64                randconfig-004-20240630   gcc-13
x86_64                randconfig-005-20240630   gcc-13
x86_64                randconfig-006-20240630   gcc-13
x86_64                randconfig-011-20240630   gcc-13
x86_64                randconfig-012-20240630   gcc-13
x86_64                randconfig-013-20240630   gcc-13
x86_64                randconfig-014-20240630   gcc-13
x86_64                randconfig-015-20240630   gcc-13
x86_64                randconfig-016-20240630   gcc-13
x86_64                randconfig-071-20240630   gcc-13
x86_64                randconfig-072-20240630   gcc-13
x86_64                randconfig-073-20240630   gcc-13
x86_64                randconfig-074-20240630   gcc-13
x86_64                randconfig-075-20240630   gcc-13
x86_64                randconfig-076-20240630   gcc-13
x86_64                          rhel-8.3-func   clang-18
x86_64                          rhel-8.3-rust   clang-18
x86_64                               rhel-8.3   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                randconfig-001-20240629   gcc-13.2.0
xtensa                randconfig-001-20240630   gcc-13.2.0
xtensa                randconfig-002-20240629   gcc-13.2.0
xtensa                randconfig-002-20240630   gcc-13.2.0
xtensa                    smp_lx200_defconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

