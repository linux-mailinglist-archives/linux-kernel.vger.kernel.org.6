Return-Path: <linux-kernel+bounces-282121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D1994DFCE
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 05:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F13CCB20E1A
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 03:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8312EE57D;
	Sun, 11 Aug 2024 03:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eOQle37m"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03D6DDA6
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 03:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723346859; cv=none; b=plvVFMBoxtEWFQnBsTOhBSVdGubckJjRck8SnWvILnJr5EX4ImeeMJYGKBCOjWWSWMWDP7jU+RtnlD08ce4OudUCo6nPqrARb7uSEUIA1f302BQkrq14TxFJh8ASV3bnfwM2+G337VTf4MHFwr5FnGzSzAQGZ629DQK+V4BaF74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723346859; c=relaxed/simple;
	bh=3gcdBgMbFcka/gu2Z2QfWLbkznCzMoBP0srwFF/xsYM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=SbSfr45ftCxBTgBdPDUWpR7RAlB+TKq9JYTEb6pB0L5Priv/RMPhnl3zycSFo3+vKAsTMw4TbnrRty1KXHXddTULZvjDur+nckoeWd1Vt/iYdEPmIpczxmJu0Ce1PAX/MbIQqd4M8qDnVQy4kuBY4lRRHdaRrm1Qs6sEbdCdXcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eOQle37m; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723346857; x=1754882857;
  h=date:from:to:cc:subject:message-id;
  bh=3gcdBgMbFcka/gu2Z2QfWLbkznCzMoBP0srwFF/xsYM=;
  b=eOQle37mDaL6XaVcVzRdV8rcSv8CtSPmKkCEBsVt+ExXYriqoIT9FLlD
   dMPIFPsn50n10fAxGuALNpg6QwN46tubpCwMCqERwwB36HimgIqvnBzPk
   lFxkqxlT2DjNjkDN9RuIXec/IJ+R2niwC9MzFoPsv9WzteQOJOwAIAYCq
   hUofmnnFxNeufuycG9PfdSIw66buHcDdHwzsjCMN4/buwm+C3X+1QWAqV
   9AsWWS45GM9d3bjKvWfQ+RCKWGMR3oAQ7d6pTJVwfVHdZ6fwL0Pe0w9i3
   5P7SCqPduXO83QUjWIvEgEz+k64c2MsU/JKyVCuWwTR+93Q/BTDisFuA2
   w==;
X-CSE-ConnectionGUID: lJuLJwbuTSG6ijqT9yoq8A==
X-CSE-MsgGUID: j+b9KMCaTau0aGPsRxxg4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11160"; a="32631411"
X-IronPort-AV: E=Sophos;i="6.09,280,1716274800"; 
   d="scan'208";a="32631411"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2024 20:27:35 -0700
X-CSE-ConnectionGUID: QYDzwBXATTmkyqJES+Dhdw==
X-CSE-MsgGUID: KziNlSKeSh2eqv7vYNJZJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,280,1716274800"; 
   d="scan'208";a="57895593"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 10 Aug 2024 20:27:33 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sczEx-000AXn-0i;
	Sun, 11 Aug 2024 03:27:31 +0000
Date: Sun, 11 Aug 2024 11:27:19 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:irq/urgent] BUILD SUCCESS
 03f9885c60adf73488fe32aab628ee3d4a39598e
Message-ID: <202408111116.MdtfctXj-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/urgent
branch HEAD: 03f9885c60adf73488fe32aab628ee3d4a39598e  irqchip/riscv-aplic: Retrigger MSI interrupt on source configuration

elapsed time: 1057m

configs tested: 198
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                         haps_hs_defconfig   gcc-13.2.0
arc                   randconfig-001-20240811   gcc-13.2.0
arc                   randconfig-002-20240811   gcc-13.2.0
arc                           tb10x_defconfig   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-20
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                              allyesconfig   gcc-14.1.0
arm                         axm55xx_defconfig   gcc-13.2.0
arm                                 defconfig   gcc-13.2.0
arm                            hisi_defconfig   gcc-13.2.0
arm                      integrator_defconfig   gcc-13.2.0
arm                        mvebu_v7_defconfig   gcc-13.2.0
arm                       omap2plus_defconfig   gcc-13.2.0
arm                   randconfig-001-20240811   gcc-13.2.0
arm                   randconfig-002-20240811   gcc-13.2.0
arm                   randconfig-003-20240811   gcc-13.2.0
arm                   randconfig-004-20240811   gcc-13.2.0
arm                        shmobile_defconfig   gcc-13.2.0
arm64                            allmodconfig   clang-20
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240811   gcc-13.2.0
arm64                 randconfig-002-20240811   gcc-13.2.0
arm64                 randconfig-003-20240811   gcc-13.2.0
arm64                 randconfig-004-20240811   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240811   gcc-13.2.0
csky                  randconfig-002-20240811   gcc-13.2.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   clang-20
hexagon                          allyesconfig   clang-20
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-12
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-12
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240810   clang-18
i386         buildonly-randconfig-001-20240811   gcc-12
i386         buildonly-randconfig-002-20240810   clang-18
i386         buildonly-randconfig-002-20240811   gcc-12
i386         buildonly-randconfig-003-20240810   clang-18
i386         buildonly-randconfig-003-20240811   gcc-12
i386         buildonly-randconfig-004-20240810   clang-18
i386         buildonly-randconfig-004-20240811   gcc-12
i386         buildonly-randconfig-005-20240810   gcc-12
i386         buildonly-randconfig-005-20240811   gcc-12
i386         buildonly-randconfig-006-20240810   gcc-12
i386         buildonly-randconfig-006-20240811   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240810   clang-18
i386                  randconfig-001-20240811   gcc-12
i386                  randconfig-002-20240810   gcc-12
i386                  randconfig-002-20240811   gcc-12
i386                  randconfig-003-20240810   clang-18
i386                  randconfig-003-20240811   gcc-12
i386                  randconfig-004-20240810   gcc-12
i386                  randconfig-004-20240811   gcc-12
i386                  randconfig-005-20240810   gcc-12
i386                  randconfig-005-20240811   gcc-12
i386                  randconfig-006-20240810   clang-18
i386                  randconfig-006-20240811   gcc-12
i386                  randconfig-011-20240810   gcc-12
i386                  randconfig-011-20240811   gcc-12
i386                  randconfig-012-20240810   gcc-12
i386                  randconfig-012-20240811   gcc-12
i386                  randconfig-013-20240810   clang-18
i386                  randconfig-013-20240811   gcc-12
i386                  randconfig-014-20240810   gcc-12
i386                  randconfig-014-20240811   gcc-12
i386                  randconfig-015-20240810   gcc-12
i386                  randconfig-015-20240811   gcc-12
i386                  randconfig-016-20240810   gcc-12
i386                  randconfig-016-20240811   gcc-12
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240811   gcc-13.2.0
loongarch             randconfig-002-20240811   gcc-13.2.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
m68k                        mvme147_defconfig   gcc-13.2.0
m68k                           sun3_defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-14.1.0
mips                         bigsur_defconfig   gcc-13.2.0
mips                      bmips_stb_defconfig   gcc-13.2.0
mips                          eyeq6_defconfig   gcc-13.2.0
mips                           ip28_defconfig   gcc-13.2.0
mips                        vocore2_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240811   gcc-13.2.0
nios2                 randconfig-002-20240811   gcc-13.2.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240811   gcc-13.2.0
parisc                randconfig-002-20240811   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-20
powerpc                          allyesconfig   gcc-14.1.0
powerpc                   bluestone_defconfig   gcc-13.2.0
powerpc                     ep8248e_defconfig   gcc-13.2.0
powerpc                 mpc834x_itx_defconfig   gcc-13.2.0
powerpc                      pmac32_defconfig   gcc-13.2.0
powerpc                     rainier_defconfig   gcc-13.2.0
powerpc               randconfig-001-20240811   gcc-13.2.0
powerpc               randconfig-003-20240811   gcc-13.2.0
powerpc                     redwood_defconfig   gcc-13.2.0
powerpc                     tqm8541_defconfig   gcc-13.2.0
powerpc64                        alldefconfig   gcc-13.2.0
powerpc64             randconfig-001-20240811   gcc-13.2.0
powerpc64             randconfig-002-20240811   gcc-13.2.0
powerpc64             randconfig-003-20240811   gcc-13.2.0
riscv                            allmodconfig   clang-20
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-20
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-14.1.0
riscv                 randconfig-001-20240811   gcc-13.2.0
riscv                 randconfig-002-20240811   gcc-13.2.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240811   gcc-13.2.0
s390                  randconfig-002-20240811   gcc-13.2.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                          kfr2r09_defconfig   gcc-13.2.0
sh                    randconfig-001-20240811   gcc-13.2.0
sh                    randconfig-002-20240811   gcc-13.2.0
sh                          rsk7269_defconfig   gcc-13.2.0
sh                             shx3_defconfig   gcc-13.2.0
sparc                            allmodconfig   gcc-14.1.0
sparc                       sparc32_defconfig   gcc-13.2.0
sparc64                          alldefconfig   gcc-13.2.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240811   gcc-13.2.0
sparc64               randconfig-002-20240811   gcc-13.2.0
um                               allmodconfig   clang-20
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-12
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240811   gcc-13.2.0
um                    randconfig-002-20240811   gcc-13.2.0
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-11
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240811   gcc-13.2.0
xtensa                randconfig-002-20240811   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

