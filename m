Return-Path: <linux-kernel+bounces-439017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3A49EA98A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 08:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5860E28885A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 07:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E4422CBFF;
	Tue, 10 Dec 2024 07:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CMSQ45nR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FCE1FCCE6
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 07:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733815695; cv=none; b=hwVUDjsKox9Nfy2xp1ZULusrTvxHP2auwbFTJIeCeDyHGH3sID7MUpnud6FCyoHc/u+YQjZwVmuJwC04KvWqRQnRxLlDVibr9WV6n7NP1Ul6MTx8V8Bq/TNOia9XR7nIzX9eejYKYvPOQS5n12acweMsDqA5A0gH/TxDAsZpzW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733815695; c=relaxed/simple;
	bh=7tDFAmaUYsNiXAIRm4e/Pci29wrtWTjoOhlTP/FpKAg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=GNdFud9DnMGSudQ9uJ4EJJ+35A6aY2oPXfHLgRFqcfvPjXCIPQmseFgyVAKcipcg/QnB/fayXbTpcQPC9LRfe/kYJUkhr6xclQzNmf5XvmgRUsFvqSj76CM5K6fTCKiMCAEhEyRwajE9zWdv8IinFMSr/MCdeRfNiNAdatJS/UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CMSQ45nR; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733815693; x=1765351693;
  h=date:from:to:cc:subject:message-id;
  bh=7tDFAmaUYsNiXAIRm4e/Pci29wrtWTjoOhlTP/FpKAg=;
  b=CMSQ45nRxiwowsLt1VMZa2OF1TGjep0udyeGQTp8EMRo6tAa5yCYPmvd
   YebDov+d+itEYz/sT+T+2MsXs8SfP5oRX13AepMu+dQOjS6Gb5kJ1PHxj
   jFz4/SyM9r4FR+W0nKiFQ5clb6QdMzwOFFRfnHo9vHeghu7B5Ww5iGbpp
   bFtv00AFD25dfmXxH9x0Xcgl9zRiF4IegK9sEfRdxhD/hF92g5NgRylcH
   WiZ2+MQ69cW6efG1O0v7Etnf9RFb8DKnYmeQPYdklLEQVItmu+cfyb2Ko
   p88DjaV23DGC2nuPpXygrkq6IxlHXMbQ+s8MJy2xzhvyAAGHJyNjj2jti
   Q==;
X-CSE-ConnectionGUID: v2yL3Q8QRV+tgRSWwm90LA==
X-CSE-MsgGUID: 09AHtGeuQumV5lFzMuJR4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="33875659"
X-IronPort-AV: E=Sophos;i="6.12,221,1728975600"; 
   d="scan'208";a="33875659"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 23:28:13 -0800
X-CSE-ConnectionGUID: 6JeOsc7aSvCKeM/QQsVZLw==
X-CSE-MsgGUID: vcSB0NI4Qpy3PZpdxt6t8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,221,1728975600"; 
   d="scan'208";a="96124524"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 09 Dec 2024 23:28:12 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tKufB-0005F1-1X;
	Tue, 10 Dec 2024 07:28:09 +0000
Date: Tue, 10 Dec 2024 15:27:26 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD SUCCESS
 2a77e4be12cb58bbf774e7c717c8bb80e128b7a4
Message-ID: <202412101520.2QmJPJRF-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
branch HEAD: 2a77e4be12cb58bbf774e7c717c8bb80e128b7a4  sched/fair: Untangle NEXT_BUDDY and pick_next_task()

elapsed time: 1211m

configs tested: 233
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-18
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-18
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-14.2.0
arc                   randconfig-001-20241209    gcc-13.2.0
arc                   randconfig-001-20241210    gcc-14.2.0
arc                   randconfig-002-20241209    gcc-13.2.0
arc                   randconfig-002-20241210    gcc-14.2.0
arm                              allmodconfig    clang-18
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-18
arm                              allyesconfig    gcc-14.2.0
arm                         bcm2835_defconfig    clang-16
arm                                 defconfig    gcc-14.2.0
arm                           omap1_defconfig    clang-16
arm                          pxa3xx_defconfig    clang-16
arm                   randconfig-001-20241209    clang-20
arm                   randconfig-001-20241210    gcc-14.2.0
arm                   randconfig-002-20241209    clang-20
arm                   randconfig-002-20241210    gcc-14.2.0
arm                   randconfig-003-20241209    clang-20
arm                   randconfig-003-20241210    gcc-14.2.0
arm                   randconfig-004-20241209    clang-20
arm                   randconfig-004-20241210    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20241209    gcc-14.2.0
arm64                 randconfig-001-20241210    gcc-14.2.0
arm64                 randconfig-002-20241209    clang-20
arm64                 randconfig-002-20241210    gcc-14.2.0
arm64                 randconfig-003-20241209    clang-19
arm64                 randconfig-003-20241210    gcc-14.2.0
arm64                 randconfig-004-20241209    gcc-14.2.0
arm64                 randconfig-004-20241210    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20241210    gcc-14.2.0
csky                  randconfig-002-20241210    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20241210    gcc-14.2.0
hexagon               randconfig-002-20241210    gcc-14.2.0
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-19
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241209    clang-19
i386        buildonly-randconfig-001-20241210    gcc-12
i386        buildonly-randconfig-002-20241209    clang-19
i386        buildonly-randconfig-002-20241210    gcc-12
i386        buildonly-randconfig-003-20241209    clang-19
i386        buildonly-randconfig-003-20241210    gcc-12
i386        buildonly-randconfig-004-20241209    clang-19
i386        buildonly-randconfig-004-20241210    gcc-12
i386        buildonly-randconfig-005-20241209    clang-19
i386        buildonly-randconfig-005-20241210    gcc-12
i386        buildonly-randconfig-006-20241209    clang-19
i386        buildonly-randconfig-006-20241210    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20241210    clang-19
i386                  randconfig-002-20241210    clang-19
i386                  randconfig-003-20241210    clang-19
i386                  randconfig-004-20241210    clang-19
i386                  randconfig-005-20241210    clang-19
i386                  randconfig-006-20241210    clang-19
i386                  randconfig-007-20241210    clang-19
i386                  randconfig-011-20241210    clang-19
i386                  randconfig-012-20241210    clang-19
i386                  randconfig-013-20241210    clang-19
i386                  randconfig-014-20241210    clang-19
i386                  randconfig-015-20241210    clang-19
i386                  randconfig-016-20241210    clang-19
i386                  randconfig-017-20241210    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20241210    gcc-14.2.0
loongarch             randconfig-002-20241210    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                       m5275evb_defconfig    gcc-14.2.0
m68k                       m5475evb_defconfig    gcc-14.2.0
m68k                        stmark2_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                         db1xxx_defconfig    clang-16
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20241210    gcc-14.2.0
nios2                 randconfig-002-20241210    gcc-14.2.0
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20241210    gcc-14.2.0
parisc                randconfig-002-20241210    gcc-14.2.0
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                  iss476-smp_defconfig    gcc-14.2.0
powerpc                   lite5200b_defconfig    clang-16
powerpc                   motionpro_defconfig    clang-16
powerpc                     mpc83xx_defconfig    gcc-14.2.0
powerpc                      pmac32_defconfig    gcc-14.2.0
powerpc               randconfig-001-20241210    gcc-14.2.0
powerpc               randconfig-002-20241210    gcc-14.2.0
powerpc               randconfig-003-20241210    gcc-14.2.0
powerpc64             randconfig-001-20241210    gcc-14.2.0
powerpc64             randconfig-002-20241210    gcc-14.2.0
powerpc64             randconfig-003-20241210    gcc-14.2.0
riscv                            alldefconfig    clang-16
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                               defconfig    clang-19
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20241209    clang-19
riscv                 randconfig-001-20241210    gcc-14.2.0
riscv                 randconfig-002-20241209    clang-20
riscv                 randconfig-002-20241210    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                                defconfig    gcc-12
s390                  randconfig-001-20241209    clang-16
s390                  randconfig-001-20241210    gcc-14.2.0
s390                  randconfig-002-20241209    gcc-14.2.0
s390                  randconfig-002-20241210    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                                  defconfig    gcc-14.2.0
sh                    randconfig-001-20241209    gcc-14.2.0
sh                    randconfig-001-20241210    gcc-14.2.0
sh                    randconfig-002-20241209    gcc-14.2.0
sh                    randconfig-002-20241210    gcc-14.2.0
sh                   rts7751r2dplus_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20241209    gcc-14.2.0
sparc                 randconfig-001-20241210    gcc-14.2.0
sparc                 randconfig-002-20241209    gcc-14.2.0
sparc                 randconfig-002-20241210    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20241209    gcc-14.2.0
sparc64               randconfig-001-20241210    gcc-14.2.0
sparc64               randconfig-002-20241209    gcc-14.2.0
sparc64               randconfig-002-20241210    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-18
um                                allnoconfig    clang-20
um                               allyesconfig    gcc-12
um                                  defconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241209    clang-19
um                    randconfig-001-20241210    gcc-14.2.0
um                    randconfig-002-20241209    gcc-12
um                    randconfig-002-20241210    gcc-14.2.0
um                           x86_64_defconfig    clang-15
um                           x86_64_defconfig    gcc-12
um                           x86_64_defconfig    gcc-14.2.0
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241209    gcc-12
x86_64      buildonly-randconfig-001-20241210    clang-19
x86_64      buildonly-randconfig-002-20241209    gcc-12
x86_64      buildonly-randconfig-002-20241210    clang-19
x86_64      buildonly-randconfig-003-20241209    clang-19
x86_64      buildonly-randconfig-003-20241210    clang-19
x86_64      buildonly-randconfig-004-20241209    gcc-12
x86_64      buildonly-randconfig-004-20241210    clang-19
x86_64      buildonly-randconfig-005-20241209    clang-19
x86_64      buildonly-randconfig-005-20241210    clang-19
x86_64      buildonly-randconfig-006-20241209    clang-19
x86_64      buildonly-randconfig-006-20241210    clang-19
x86_64                              defconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20241210    gcc-12
x86_64                randconfig-002-20241210    gcc-12
x86_64                randconfig-003-20241210    gcc-12
x86_64                randconfig-004-20241210    gcc-12
x86_64                randconfig-005-20241210    gcc-12
x86_64                randconfig-006-20241210    gcc-12
x86_64                randconfig-007-20241210    gcc-12
x86_64                randconfig-008-20241210    gcc-12
x86_64                randconfig-071-20241210    gcc-12
x86_64                randconfig-072-20241210    gcc-12
x86_64                randconfig-073-20241210    gcc-12
x86_64                randconfig-074-20241210    gcc-12
x86_64                randconfig-075-20241210    gcc-12
x86_64                randconfig-076-20241210    gcc-12
x86_64                randconfig-077-20241210    gcc-12
x86_64                randconfig-078-20241210    gcc-12
x86_64                               rhel-9.4    clang-19
x86_64                           rhel-9.4-bpf    clang-19
x86_64                         rhel-9.4-kunit    clang-19
x86_64                           rhel-9.4-ltp    clang-19
x86_64                          rhel-9.4-rust    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20241209    gcc-14.2.0
xtensa                randconfig-001-20241210    gcc-14.2.0
xtensa                randconfig-002-20241209    gcc-14.2.0
xtensa                randconfig-002-20241210    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

