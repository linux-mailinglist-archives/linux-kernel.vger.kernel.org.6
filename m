Return-Path: <linux-kernel+bounces-266936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E6F940A03
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 09:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94ED51C232AA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 07:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01536190042;
	Tue, 30 Jul 2024 07:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MCbxcAWp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F16915746E
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 07:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722325052; cv=none; b=NJx7bANtUO3h1W9VCIRjrFHHhl0f2IvMbdwJFG08MCn5+eFWxUdqFN7RhYyrk3MCfvb+5o56LblTr3aTBtBTk8Mv5TpOfALQu2yoQYpq/emyjQ0HUVINxQbcyZkz9d2GyEhhdsefZsNKNZnsOWGdjne8CG6YQJzttIa/JwifbLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722325052; c=relaxed/simple;
	bh=qJJP2h3w7hBwGmB1usjy0y4WQVnMuM8SlTyV9rQIo0Y=;
	h=Date:From:To:Cc:Subject:Message-ID; b=B4uk2osF2hTFgoIoLFs/TQK7a2ZoyqO0xL6R87dew/iaYBffmJga9//vw1HhkUsNAsShVlEbNDu2dkLcufXmKmHG0G12nxfnDW7majqp7zuQ7/9PG9lFwuqLaHg+MJwCMIUd79WW70otz+Pxjw1U10R+pydz3aagzVgV4SptMRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MCbxcAWp; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722325050; x=1753861050;
  h=date:from:to:cc:subject:message-id;
  bh=qJJP2h3w7hBwGmB1usjy0y4WQVnMuM8SlTyV9rQIo0Y=;
  b=MCbxcAWpCAzE2E8+suf37cmvltEGQkoBMr1IUGsOjBS0+Lgq6mlb5ZO8
   EGwW/zuXWkH/MWAS7NKIkFb1m+7YXd36vG1i7oI/8xI6jHrMT1aBUPwOT
   FAyN+bIs81J9BiKxLsQRq1s2jkcGV9cdowAQPYvx0KOxMvoF23z3DxGlP
   0sDZUqqaXPce8OJGI/aIa1+PloCuVNevfY0sM0oEjkB9BKR87YlbjegIE
   CF70swHBZszgSFAc8B1N8qlV1vEV/nAEqFdOHsbD7VrBLrTXynLgP/lIg
   SNLeVHLq1Ulo1xnPILKbDlgrNxmDERZj31Qv2wH1GibJKfGQSbybhgUds
   w==;
X-CSE-ConnectionGUID: zzB4qYM2S5KeYyPuBTtysw==
X-CSE-MsgGUID: CAOp4V75RqyDkdc85WxmIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="37633101"
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="37633101"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 00:37:29 -0700
X-CSE-ConnectionGUID: TCtRwAGBTQive34q1wvZVg==
X-CSE-MsgGUID: IuMwnDEcSL+F6l5vTi01Ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="84891845"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 30 Jul 2024 00:37:28 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sYhQE-000scb-15;
	Tue, 30 Jul 2024 07:37:26 +0000
Date: Tue, 30 Jul 2024 15:37:00 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:perf/core] BUILD SUCCESS
 6763ebdb4983f55ac1ded291d170046d029a7539
Message-ID: <202407301556.V1lOYFeo-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core
branch HEAD: 6763ebdb4983f55ac1ded291d170046d029a7539  perf/x86/intel: Do not enable large PEBS for events with aux actions or aux sampling

elapsed time: 1268m

configs tested: 323
configs skipped: 12

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig   gcc-13.3.0
alpha                             allnoconfig   gcc-13.2.0
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
alpha                               defconfig   gcc-13.3.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                        nsimosci_defconfig   gcc-13.2.0
arc                   randconfig-001-20240730   gcc-13.2.0
arc                   randconfig-002-20240730   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-20
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                              allyesconfig   gcc-14.1.0
arm                         bcm2835_defconfig   clang-20
arm                                 defconfig   clang-14
arm                                 defconfig   gcc-13.2.0
arm                            dove_defconfig   gcc-13.3.0
arm                      footbridge_defconfig   clang-20
arm                            hisi_defconfig   gcc-13.2.0
arm                       imx_v4_v5_defconfig   clang-16
arm                      integrator_defconfig   gcc-13.3.0
arm                        keystone_defconfig   clang-20
arm                        keystone_defconfig   gcc-13.2.0
arm                            mmp2_defconfig   gcc-14.1.0
arm                        multi_v7_defconfig   gcc-14.1.0
arm                         nhk8815_defconfig   gcc-13.3.0
arm                             pxa_defconfig   gcc-13.2.0
arm                   randconfig-001-20240730   gcc-13.2.0
arm                   randconfig-001-20240730   gcc-14.1.0
arm                   randconfig-002-20240730   gcc-13.2.0
arm                   randconfig-002-20240730   gcc-14.1.0
arm                   randconfig-003-20240730   gcc-13.2.0
arm                   randconfig-003-20240730   gcc-14.1.0
arm                   randconfig-004-20240730   gcc-13.2.0
arm                   randconfig-004-20240730   gcc-14.1.0
arm                           sama7_defconfig   clang-20
arm                        shmobile_defconfig   gcc-13.3.0
arm                       spear13xx_defconfig   gcc-13.3.0
arm64                            allmodconfig   clang-20
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-13.2.0
arm64                               defconfig   gcc-14.1.0
arm64                 randconfig-001-20240730   gcc-13.2.0
arm64                 randconfig-001-20240730   gcc-14.1.0
arm64                 randconfig-002-20240730   clang-20
arm64                 randconfig-002-20240730   gcc-13.2.0
arm64                 randconfig-003-20240730   clang-20
arm64                 randconfig-003-20240730   gcc-13.2.0
arm64                 randconfig-004-20240730   gcc-13.2.0
arm64                 randconfig-004-20240730   gcc-14.1.0
csky                              allnoconfig   gcc-13.2.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-13.2.0
csky                                defconfig   gcc-14.1.0
csky                  randconfig-001-20240730   gcc-13.2.0
csky                  randconfig-001-20240730   gcc-14.1.0
csky                  randconfig-002-20240730   gcc-13.2.0
csky                  randconfig-002-20240730   gcc-14.1.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   clang-20
hexagon                          allyesconfig   clang-20
hexagon                             defconfig   clang-20
hexagon               randconfig-001-20240730   clang-20
hexagon               randconfig-002-20240730   clang-20
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-13
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-13
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240729   clang-18
i386         buildonly-randconfig-001-20240730   gcc-13
i386         buildonly-randconfig-002-20240729   gcc-13
i386         buildonly-randconfig-002-20240730   gcc-13
i386         buildonly-randconfig-003-20240729   clang-18
i386         buildonly-randconfig-003-20240730   gcc-13
i386         buildonly-randconfig-004-20240729   gcc-10
i386         buildonly-randconfig-004-20240730   gcc-13
i386         buildonly-randconfig-005-20240729   clang-18
i386         buildonly-randconfig-005-20240730   gcc-13
i386         buildonly-randconfig-006-20240729   gcc-8
i386         buildonly-randconfig-006-20240730   gcc-13
i386                                defconfig   clang-18
i386                  randconfig-001-20240729   gcc-12
i386                  randconfig-001-20240730   gcc-13
i386                  randconfig-002-20240729   clang-18
i386                  randconfig-002-20240730   gcc-13
i386                  randconfig-003-20240729   gcc-10
i386                  randconfig-003-20240730   gcc-13
i386                  randconfig-004-20240729   gcc-13
i386                  randconfig-004-20240730   gcc-13
i386                  randconfig-005-20240729   gcc-8
i386                  randconfig-005-20240730   gcc-13
i386                  randconfig-006-20240729   gcc-13
i386                  randconfig-006-20240730   gcc-13
i386                  randconfig-011-20240729   gcc-13
i386                  randconfig-011-20240730   gcc-13
i386                  randconfig-012-20240729   clang-18
i386                  randconfig-012-20240730   gcc-13
i386                  randconfig-013-20240729   gcc-9
i386                  randconfig-013-20240730   gcc-13
i386                  randconfig-014-20240729   clang-18
i386                  randconfig-014-20240730   gcc-13
i386                  randconfig-015-20240729   gcc-13
i386                  randconfig-015-20240730   gcc-13
i386                  randconfig-016-20240729   clang-18
i386                  randconfig-016-20240730   gcc-13
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-13.2.0
loongarch                           defconfig   gcc-14.1.0
loongarch             randconfig-001-20240730   gcc-13.2.0
loongarch             randconfig-001-20240730   gcc-14.1.0
loongarch             randconfig-002-20240730   gcc-13.2.0
loongarch             randconfig-002-20240730   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
m68k                                defconfig   gcc-14.1.0
m68k                        m5272c3_defconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
microblaze                          defconfig   gcc-14.1.0
mips                              allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-14.1.0
mips                          ath25_defconfig   clang-20
mips                  cavium_octeon_defconfig   gcc-14.1.0
mips                     cu1000-neo_defconfig   gcc-13.2.0
mips                           gcw0_defconfig   gcc-13.2.0
mips                            gpr_defconfig   gcc-13.2.0
mips                malta_qemu_32r6_defconfig   clang-20
mips                      maltaaprp_defconfig   gcc-13.2.0
mips                        qi_lb60_defconfig   gcc-13.3.0
nios2                         10m50_defconfig   gcc-13.3.0
nios2                         10m50_defconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-13.2.0
nios2                               defconfig   gcc-14.1.0
nios2                 randconfig-001-20240730   gcc-13.2.0
nios2                 randconfig-001-20240730   gcc-14.1.0
nios2                 randconfig-002-20240730   gcc-13.2.0
nios2                 randconfig-002-20240730   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                generic-64bit_defconfig   gcc-13.2.0
parisc                generic-64bit_defconfig   gcc-13.3.0
parisc                generic-64bit_defconfig   gcc-14.1.0
parisc                randconfig-001-20240730   gcc-13.2.0
parisc                randconfig-001-20240730   gcc-14.1.0
parisc                randconfig-002-20240730   gcc-13.2.0
parisc                randconfig-002-20240730   gcc-14.1.0
parisc64                            defconfig   gcc-13.2.0
parisc64                            defconfig   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-20
powerpc                          allyesconfig   gcc-14.1.0
powerpc                 canyonlands_defconfig   clang-20
powerpc                 canyonlands_defconfig   gcc-13.2.0
powerpc                      cm5200_defconfig   clang-20
powerpc                       ebony_defconfig   clang-20
powerpc                       eiger_defconfig   gcc-13.3.0
powerpc                     ep8248e_defconfig   clang-20
powerpc                 mpc834x_itx_defconfig   gcc-13.3.0
powerpc               mpc834x_itxgp_defconfig   clang-14
powerpc                      pmac32_defconfig   clang-20
powerpc                     rainier_defconfig   gcc-13.3.0
powerpc               randconfig-002-20240730   clang-16
powerpc               randconfig-002-20240730   gcc-13.2.0
powerpc               randconfig-003-20240730   gcc-13.2.0
powerpc                    sam440ep_defconfig   gcc-13.2.0
powerpc                     taishan_defconfig   clang-20
powerpc                     tqm5200_defconfig   gcc-13.3.0
powerpc                     tqm8541_defconfig   gcc-13.3.0
powerpc                     tqm8555_defconfig   clang-20
powerpc                      tqm8xx_defconfig   clang-20
powerpc64             randconfig-001-20240730   gcc-13.2.0
powerpc64             randconfig-001-20240730   gcc-14.1.0
powerpc64             randconfig-002-20240730   clang-20
powerpc64             randconfig-002-20240730   gcc-13.2.0
powerpc64             randconfig-003-20240730   gcc-13.2.0
powerpc64             randconfig-003-20240730   gcc-14.1.0
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-20
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   clang-20
riscv                               defconfig   gcc-14.1.0
riscv             nommu_k210_sdcard_defconfig   gcc-14.1.0
riscv                 randconfig-001-20240730   clang-14
riscv                 randconfig-001-20240730   gcc-13.2.0
riscv                 randconfig-002-20240730   gcc-13.2.0
riscv                 randconfig-002-20240730   gcc-14.1.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   clang-20
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240730   gcc-13.2.0
s390                  randconfig-001-20240730   gcc-14.1.0
s390                  randconfig-002-20240730   clang-20
s390                  randconfig-002-20240730   gcc-13.2.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                             espt_defconfig   gcc-13.2.0
sh                          polaris_defconfig   gcc-13.2.0
sh                          r7780mp_defconfig   gcc-13.2.0
sh                    randconfig-001-20240730   gcc-13.2.0
sh                    randconfig-001-20240730   gcc-14.1.0
sh                    randconfig-002-20240730   gcc-13.2.0
sh                    randconfig-002-20240730   gcc-14.1.0
sh                          rsk7269_defconfig   gcc-13.2.0
sh                          rsk7269_defconfig   gcc-13.3.0
sh                          rsk7269_defconfig   gcc-14.1.0
sh                           se7721_defconfig   gcc-13.2.0
sh                             shx3_defconfig   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240730   gcc-13.2.0
sparc64               randconfig-001-20240730   gcc-14.1.0
sparc64               randconfig-002-20240730   gcc-13.2.0
sparc64               randconfig-002-20240730   gcc-14.1.0
um                               allmodconfig   clang-20
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-13
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   clang-20
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-13
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240730   gcc-13
um                    randconfig-001-20240730   gcc-13.2.0
um                    randconfig-002-20240730   clang-20
um                    randconfig-002-20240730   gcc-13.2.0
um                           x86_64_defconfig   clang-15
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240729   clang-18
x86_64       buildonly-randconfig-001-20240730   clang-18
x86_64       buildonly-randconfig-002-20240729   gcc-13
x86_64       buildonly-randconfig-002-20240730   clang-18
x86_64       buildonly-randconfig-003-20240729   gcc-10
x86_64       buildonly-randconfig-003-20240730   clang-18
x86_64       buildonly-randconfig-004-20240729   gcc-10
x86_64       buildonly-randconfig-004-20240730   clang-18
x86_64       buildonly-randconfig-005-20240729   gcc-10
x86_64       buildonly-randconfig-005-20240730   clang-18
x86_64       buildonly-randconfig-006-20240729   gcc-10
x86_64       buildonly-randconfig-006-20240730   clang-18
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240729   gcc-13
x86_64                randconfig-001-20240730   clang-18
x86_64                randconfig-002-20240729   clang-18
x86_64                randconfig-002-20240730   clang-18
x86_64                randconfig-003-20240729   clang-18
x86_64                randconfig-003-20240730   clang-18
x86_64                randconfig-004-20240729   clang-18
x86_64                randconfig-004-20240730   clang-18
x86_64                randconfig-005-20240729   clang-18
x86_64                randconfig-005-20240730   clang-18
x86_64                randconfig-006-20240729   clang-18
x86_64                randconfig-006-20240730   clang-18
x86_64                randconfig-011-20240729   gcc-8
x86_64                randconfig-011-20240730   clang-18
x86_64                randconfig-012-20240729   gcc-8
x86_64                randconfig-012-20240730   clang-18
x86_64                randconfig-013-20240729   gcc-13
x86_64                randconfig-013-20240730   clang-18
x86_64                randconfig-014-20240729   clang-18
x86_64                randconfig-014-20240730   clang-18
x86_64                randconfig-015-20240729   gcc-13
x86_64                randconfig-015-20240730   clang-18
x86_64                randconfig-016-20240729   clang-18
x86_64                randconfig-016-20240730   clang-18
x86_64                randconfig-071-20240729   gcc-13
x86_64                randconfig-071-20240730   clang-18
x86_64                randconfig-072-20240729   gcc-13
x86_64                randconfig-072-20240730   clang-18
x86_64                randconfig-073-20240729   clang-18
x86_64                randconfig-073-20240730   clang-18
x86_64                randconfig-074-20240729   gcc-8
x86_64                randconfig-074-20240730   clang-18
x86_64                randconfig-075-20240729   gcc-12
x86_64                randconfig-075-20240730   clang-18
x86_64                randconfig-076-20240729   gcc-13
x86_64                randconfig-076-20240730   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240730   gcc-13.2.0
xtensa                randconfig-001-20240730   gcc-14.1.0
xtensa                randconfig-002-20240730   gcc-13.2.0
xtensa                randconfig-002-20240730   gcc-14.1.0
xtensa                    smp_lx200_defconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

