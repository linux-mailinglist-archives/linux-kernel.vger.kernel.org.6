Return-Path: <linux-kernel+bounces-435930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0699E7EBC
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 08:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CFA316C0D5
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 07:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CAF4137742;
	Sat,  7 Dec 2024 07:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bC9PUkAy"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05D182C7E
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 07:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733557513; cv=none; b=r+TjLlk/OUBs92WFdV19Hvmf5HFmgtUHwnzdr0PyB4x81bAiQwXUhLSN8B1c/a++O94+AQwtsaK/Y8myye8ZRoz1dpdp845nCDvGm07gFRH48vzn19sOCZqOswXyOWLQR2gKY3oT0PgC/mw498yc4cIjjuYlOtDsDlCWekf9mqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733557513; c=relaxed/simple;
	bh=UqDnAOOsuGcN9NDFjO3ni6Eq/dcsa4zJzDprYrLB7yo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=PSa/m9OAQLw/sn+m32k9N2674NIi3w8QyBaHfBeQW9ko1ALXelCBz2oku0OqkdplnzZF2q/w+ylkajFh5xfQhrLVTLkXDYBCSz8as5L8uWq7RdMWP4pIwodRDbG2/VTLFV9iiE4I0uwzKr9MLSXbGd0tkZ6H8YxfZfjD9/9tOLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bC9PUkAy; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733557512; x=1765093512;
  h=date:from:to:cc:subject:message-id;
  bh=UqDnAOOsuGcN9NDFjO3ni6Eq/dcsa4zJzDprYrLB7yo=;
  b=bC9PUkAy7Pvu3a7ES/R4tVTDoPzV8yl+G0B7fY2V2fmDZ13xUSP19z36
   yzCBTLKvZBVdJq88GD/7Bt+/l+Uk6jOOADP2OkQSr+A+NnalwbywHZwZb
   JmLlvDkyMkLaQeXSa4GNLxlF4aKqaeSVXcuaCQSfxAtT5w9WeMqc7G5LB
   Yme+K8SGbXn+7+Xz906bO18MbabifEAffMS9YKOU6btgg8DfQ0d0/agK8
   fkZW8RHbDrvMSRWrBlEwsZ9Y2Yy4bT4BJ2cO22AZ7WaFPP4nHKD4eoi76
   qSWUkFXLaBvOhs2SB0Qqpret1W/g5t5zBOE5MSQ1frzNCrGeuup9bJnEG
   A==;
X-CSE-ConnectionGUID: LgvdREQTTZSgAoCccqWthg==
X-CSE-MsgGUID: ZFgEwd4mQnqZRfAPYZj5QA==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="51333444"
X-IronPort-AV: E=Sophos;i="6.12,215,1728975600"; 
   d="scan'208";a="51333444"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 23:45:11 -0800
X-CSE-ConnectionGUID: 9KJU54qDRICnDo9bXIzdZA==
X-CSE-MsgGUID: dtzEK+r2S++ZC/mD0aMvCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,215,1728975600"; 
   d="scan'208";a="95056048"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 06 Dec 2024 23:45:10 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tJpUy-0002Yq-05;
	Sat, 07 Dec 2024 07:45:08 +0000
Date: Sat, 07 Dec 2024 15:42:03 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 492077668fb453b8b16c842fcf3fafc2ebc190e9
Message-ID: <202412071553.jShqtujd-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 492077668fb453b8b16c842fcf3fafc2ebc190e9  x86/CPU/AMD: WARN when setting EFER.AUTOIBRS if and only if the WRMSR fails

elapsed time: 729m

configs tested: 147
configs skipped: 129

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig    clang-15
alpha                             allnoconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-18
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-18
arc                                 defconfig    gcc-14.2.0
arc                            hsdk_defconfig    gcc-14.2.0
arc                   randconfig-001-20241207    clang-19
arc                   randconfig-002-20241207    clang-19
arc                        vdk_hs38_defconfig    clang-20
arm                              allmodconfig    clang-18
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-18
arm                       aspeed_g5_defconfig    gcc-14.2.0
arm                                 defconfig    gcc-14.2.0
arm                          gemini_defconfig    clang-15
arm                            hisi_defconfig    gcc-14.2.0
arm                            mps2_defconfig    clang-15
arm                        multi_v5_defconfig    clang-20
arm                   randconfig-001-20241207    clang-19
arm                   randconfig-002-20241207    clang-19
arm                   randconfig-003-20241207    clang-19
arm                   randconfig-004-20241207    clang-19
arm                        realview_defconfig    clang-20
arm                        shmobile_defconfig    gcc-14.2.0
arm                           stm32_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20241207    clang-19
arm64                 randconfig-002-20241207    clang-19
arm64                 randconfig-003-20241207    clang-19
arm64                 randconfig-004-20241207    clang-19
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20241207    clang-19
csky                  randconfig-002-20241207    clang-19
hexagon                           allnoconfig    gcc-14.2.0
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20241207    clang-19
hexagon               randconfig-002-20241207    clang-19
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                             allyesconfig    clang-19
i386        buildonly-randconfig-001-20241207    clang-19
i386        buildonly-randconfig-002-20241207    clang-19
i386        buildonly-randconfig-003-20241207    clang-19
i386        buildonly-randconfig-003-20241207    gcc-12
i386        buildonly-randconfig-004-20241207    clang-19
i386        buildonly-randconfig-005-20241207    clang-19
i386        buildonly-randconfig-006-20241207    clang-19
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20241207    clang-19
loongarch             randconfig-002-20241207    clang-19
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                        stmark2_defconfig    clang-20
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          ath79_defconfig    gcc-14.2.0
mips                        bcm47xx_defconfig    gcc-14.2.0
mips                           mtx1_defconfig    gcc-14.2.0
mips                   sb1250_swarm_defconfig    clang-20
nios2                         3c120_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20241207    clang-19
nios2                 randconfig-002-20241207    clang-19
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20241207    clang-19
parisc                randconfig-002-20241207    clang-19
parisc64                            defconfig    gcc-14.2.0
powerpc                    adder875_defconfig    clang-15
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.2.0
powerpc                      bamboo_defconfig    gcc-14.2.0
powerpc                   currituck_defconfig    clang-15
powerpc                   currituck_defconfig    gcc-14.2.0
powerpc                    ge_imp3a_defconfig    gcc-14.2.0
powerpc                       holly_defconfig    clang-20
powerpc                      mgcoge_defconfig    gcc-14.2.0
powerpc                      pmac32_defconfig    clang-15
powerpc               randconfig-001-20241207    clang-19
powerpc               randconfig-002-20241207    clang-19
powerpc               randconfig-003-20241207    clang-19
powerpc                     redwood_defconfig    gcc-14.2.0
powerpc                    sam440ep_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20241207    clang-19
powerpc64             randconfig-002-20241207    clang-19
powerpc64             randconfig-003-20241207    clang-19
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                                defconfig    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                        edosk7760_defconfig    gcc-14.2.0
sh                          kfr2r09_defconfig    clang-20
sh                          landisk_defconfig    clang-20
sh                          polaris_defconfig    gcc-14.2.0
sh                           se7343_defconfig    clang-15
sh                           se7724_defconfig    gcc-14.2.0
sh                  sh7785lcr_32bit_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc64                          alldefconfig    gcc-14.2.0
sparc64                             defconfig    gcc-12
um                               alldefconfig    gcc-14.2.0
um                                allnoconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241207    clang-19
x86_64      buildonly-randconfig-002-20241207    clang-19
x86_64      buildonly-randconfig-003-20241207    clang-19
x86_64      buildonly-randconfig-003-20241207    gcc-11
x86_64      buildonly-randconfig-004-20241207    clang-19
x86_64      buildonly-randconfig-005-20241207    clang-19
x86_64      buildonly-randconfig-006-20241207    clang-19
x86_64      buildonly-randconfig-006-20241207    gcc-12
x86_64                              defconfig    clang-19
xtensa                            allnoconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

