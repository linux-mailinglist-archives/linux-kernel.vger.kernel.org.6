Return-Path: <linux-kernel+bounces-179625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D248C627F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 10:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0356B1C20F0A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 08:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34B44A9B0;
	Wed, 15 May 2024 08:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JOx750UP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1599482E2
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 08:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715760395; cv=none; b=hgxCaRsYE0v+w6JXdwW9mfsP13pd6TzzzAfmzk/bEgYhEB0JK7mBpWAbm4DFs5mAFRvNobFTuZxNY3g1c0gDebhFS+dtHWc0sQQwfSf3K9tfLk0je6jtixHZ4cuFc/0R8kQKQ1v4LQ3OtzeaVUnNWyAC8CzUpv966OO5vuoRPG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715760395; c=relaxed/simple;
	bh=8TEZnE7WTbCwNYaVReSh+zDJq6bUMG18a220RPIgjYg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=XyucRZhJDnXlzmdbOJ+u8qannGxqaAS5FOcWI5p0lZzXoBYAGuJaguor5DjAClvTyVRvT+AqvLWlzvyffreLY6kDYrJhMdI7Ch+RP0s87n0N1WJOZdGA4nbrcSFAOlo191+066CdYTU5feqstzVP5NfFSrT2DGb5Z+nNn6pUbpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JOx750UP; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715760394; x=1747296394;
  h=date:from:to:cc:subject:message-id;
  bh=8TEZnE7WTbCwNYaVReSh+zDJq6bUMG18a220RPIgjYg=;
  b=JOx750UPCEgEay5MWc9ONWNd7/cdswTY88dh9ic9y3GWlTyOB1sEn5Ii
   Faxhw5VHsM48qMlalpc2cyrH3PXxiLxBZDotKmpxeL4tpTsd96BeIHJv3
   5GpqqKlxePWUFF5TxVCatp5cY7uyEBTXtfJLHgd9htP+tcIKOO1vwytaY
   IPHQ4CeJurc1RE52NUI8DyjOVjtbLeNQqabhXjgNI1hZDuprCyH/ro+MR
   O87sAHAwFvdPan111tSj1yzF5NIkAvNBiCja3a+gm2xqT7bBMdGs+g6n9
   sPxMJVie7gzV+GPpoZ2cYI6f7jKG7pKrL0M5nn+YgTR2s10Z8ddVWRlnf
   A==;
X-CSE-ConnectionGUID: BXwEKGaOQMmsIBwzGdu+6g==
X-CSE-MsgGUID: LgQBdArNQwiL2P6WqO7sdw==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="15616161"
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; 
   d="scan'208";a="15616161"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 01:06:33 -0700
X-CSE-ConnectionGUID: EtK60DveROSqYVGJirw1Lg==
X-CSE-MsgGUID: fLvw+V6qQxqX1zPaXB/fbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; 
   d="scan'208";a="35514026"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 15 May 2024 01:06:32 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s79eg-000Cbz-0r;
	Wed, 15 May 2024 08:06:30 +0000
Date: Wed, 15 May 2024 16:06:28 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2024.05.11a] BUILD SUCCESS
 f842f3076c93f9a97f1aeabcea6e568f33929892
Message-ID: <202405151625.luPFi94S-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2024.05.11a
branch HEAD: f842f3076c93f9a97f1aeabcea6e568f33929892  rcu-tasks: Remove open-coded one-byte cmpxchg() emulation

elapsed time: 727m

configs tested: 181
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
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                           h3600_defconfig   gcc  
arm                       netwinder_defconfig   gcc  
arm                   randconfig-001-20240515   clang
arm                   randconfig-002-20240515   gcc  
arm                   randconfig-003-20240515   clang
arm                   randconfig-004-20240515   gcc  
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
m68k                        m5407c3_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                           gcw0_defconfig   clang
mips                            gpr_defconfig   clang
mips                      maltasmvp_defconfig   gcc  
mips                          rm200_defconfig   gcc  
mips                        vocore2_defconfig   clang
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
powerpc                    gamecube_defconfig   clang
powerpc                  mpc866_ads_defconfig   clang
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
sh                          kfr2r09_defconfig   gcc  
sh                    randconfig-001-20240515   gcc  
sh                    randconfig-002-20240515   gcc  
sh                          rsk7201_defconfig   gcc  
sh                      rts7751r2d1_defconfig   gcc  
sh                           se7705_defconfig   gcc  
sh                        sh7763rdp_defconfig   gcc  
sh                              ul2_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc                       sparc64_defconfig   gcc  
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
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240515   gcc  
xtensa                randconfig-002-20240515   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

