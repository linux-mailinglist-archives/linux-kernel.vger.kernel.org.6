Return-Path: <linux-kernel+bounces-300681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B6295E71B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 04:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16F4528199F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 02:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640336F2F8;
	Mon, 26 Aug 2024 02:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="efEgBRa7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D9D208C4
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 02:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724641026; cv=none; b=hdeCrMGgK0lubzNrnoiMJp6N08D3EGOpcA6nlnWOuPfhIE0gPrCg+dT4R95Je1RVkXHgwyTWHSrOC/1A1JkPz3eL4TjWpFxlCHjFkVCgR7+MpELFy1bv/JNs5jRau24tA3mPB1iKjN2zEtYAj3vfJe53vcMgQFfxA69lrECQGvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724641026; c=relaxed/simple;
	bh=zKb2QehVkb+5Jbeetpcuujupb3FtXamSsyHvBAry4Fc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=BdVG4ZHB7BKjroGUiZRnFyInwr4Mq2SSzFGgIIq+rTh3BlGgm2x1vC/Uvn36nRaOYYOaSyPPgVMFpqYvj5V7BVUu4vs7RDbnxzkTkJu6KsHnn79Eedye0SEBHibNviQHq9ISzA7ugmXGwXoNosjtJhsekWsECK8HWA6a4nY0JPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=efEgBRa7; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724641025; x=1756177025;
  h=date:from:to:cc:subject:message-id;
  bh=zKb2QehVkb+5Jbeetpcuujupb3FtXamSsyHvBAry4Fc=;
  b=efEgBRa74Nr3R4yJmZua6lIpZ/1T4nOAZwV1se4IM7LOjhC/g4+AHNog
   boG2xMQvnYgQJjJKKFsKDOts618u3vvOIomaxS2k7uEH0P6nJV2e515Dt
   cFFWz4ev2a/jWlJR2W7UuqbSUKwuGf5Pw4lH+ht2valJgcP6Bi4et7nCZ
   FC6BZYccXIdn/ZTm31mWgiFAEuXgO+04FHP1TVSqjfvMqTip7Ow7YyQPm
   ND4ftfsvJ4hh/JLEGu5SwJOMjKwpNnabJlvKQP4nSmPala3nGZBOghvNM
   5AQwaEzG/1iew+As6WS19l4yXMYTZ4RhOBX3/kmqYeqPRYEXIBC9eCKvT
   w==;
X-CSE-ConnectionGUID: j2sO2eiIR3WLjOfKoME/TA==
X-CSE-MsgGUID: oxS03ZCHR6yfrnHI1xxmRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11175"; a="34204286"
X-IronPort-AV: E=Sophos;i="6.10,176,1719903600"; 
   d="scan'208";a="34204286"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2024 19:57:02 -0700
X-CSE-ConnectionGUID: oAqKNvUATpKyY2KOFHY4Aw==
X-CSE-MsgGUID: eqVW81A9TO+3G4EiHOg6Og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,176,1719903600"; 
   d="scan'208";a="67300400"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 25 Aug 2024 19:57:01 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1siPuc-000Fbn-11;
	Mon, 26 Aug 2024 02:56:58 +0000
Date: Mon, 26 Aug 2024 10:56:14 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/misc] BUILD SUCCESS
 0f70fdd42559b4eed8f74bf7389656a8ae3eb5c3
Message-ID: <202408261012.kFfZemz7-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/misc
branch HEAD: 0f70fdd42559b4eed8f74bf7389656a8ae3eb5c3  x86/amd_nb: Add new PCI IDs for AMD family 1Ah model 60h-70h

elapsed time: 725m

configs tested: 96
configs skipped: 129

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                        nsimosci_defconfig   gcc-12.3.0
arm                               allnoconfig   gcc-13.2.0
arm                                 defconfig   gcc-13.2.0
arm                          ixp4xx_defconfig   gcc-12.3.0
arm                       netwinder_defconfig   gcc-12.3.0
arm                           stm32_defconfig   gcc-12.3.0
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
i386                             allmodconfig   gcc-12
i386                              allnoconfig   gcc-12
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240825   clang-18
i386         buildonly-randconfig-001-20240826   clang-18
i386         buildonly-randconfig-002-20240825   clang-18
i386         buildonly-randconfig-002-20240826   clang-18
i386         buildonly-randconfig-003-20240825   clang-18
i386         buildonly-randconfig-003-20240826   clang-18
i386         buildonly-randconfig-004-20240825   gcc-12
i386         buildonly-randconfig-004-20240826   clang-18
i386         buildonly-randconfig-005-20240825   clang-18
i386         buildonly-randconfig-005-20240826   clang-18
i386         buildonly-randconfig-006-20240825   gcc-12
i386         buildonly-randconfig-006-20240826   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240825   gcc-12
i386                  randconfig-001-20240826   clang-18
i386                  randconfig-002-20240825   gcc-12
i386                  randconfig-002-20240826   clang-18
i386                  randconfig-003-20240825   gcc-12
i386                  randconfig-003-20240826   clang-18
i386                  randconfig-004-20240825   gcc-12
i386                  randconfig-004-20240826   clang-18
i386                  randconfig-005-20240825   clang-18
i386                  randconfig-005-20240826   clang-18
i386                  randconfig-006-20240825   clang-18
i386                  randconfig-006-20240826   clang-18
i386                  randconfig-011-20240825   clang-18
i386                  randconfig-011-20240826   clang-18
i386                  randconfig-012-20240825   gcc-11
i386                  randconfig-012-20240826   clang-18
i386                  randconfig-013-20240825   clang-18
i386                  randconfig-013-20240826   clang-18
i386                  randconfig-014-20240825   clang-18
i386                  randconfig-014-20240826   clang-18
i386                  randconfig-015-20240825   clang-18
i386                  randconfig-015-20240826   clang-18
i386                  randconfig-016-20240825   clang-18
i386                  randconfig-016-20240826   clang-18
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
m68k                                defconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                      bmips_stb_defconfig   gcc-12.3.0
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
openrisc                            defconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc64                            defconfig   gcc-13.2.0
powerpc                 linkstation_defconfig   gcc-12.3.0
powerpc                  mpc866_ads_defconfig   gcc-12.3.0
powerpc                  mpc885_ads_defconfig   gcc-12.3.0
powerpc                      pcm030_defconfig   gcc-12.3.0
riscv                               defconfig   gcc-14.1.0
riscv                    nommu_virt_defconfig   gcc-12.3.0
s390                             allmodconfig   clang-20
s390                             allyesconfig   clang-20
s390                                defconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                                  defconfig   gcc-14.1.0
sh                      rts7751r2d1_defconfig   gcc-12.3.0
sh                   rts7751r2dplus_defconfig   gcc-12.3.0
sh                           se7724_defconfig   gcc-12.3.0
sh                           sh2007_defconfig   gcc-12.3.0
sh                             shx3_defconfig   gcc-12.3.0
sparc64                             defconfig   gcc-14.1.0
um                               allmodconfig   gcc-13.3.0
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-14.1.0
um                           x86_64_defconfig   gcc-14.1.0
x86_64                           alldefconfig   gcc-12.3.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64                              defconfig   gcc-11
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

