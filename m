Return-Path: <linux-kernel+bounces-319688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FEE797009B
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 09:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB4501F22F60
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 07:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7434A14884C;
	Sat,  7 Sep 2024 07:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WjmtYOgX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CAD13C81B
	for <linux-kernel@vger.kernel.org>; Sat,  7 Sep 2024 07:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725694975; cv=none; b=H0dEk3jM9U5b54bmb9vmZv+Ficer+MC3v/n6VCgBGBDbNKK1sb9d47W/tDLM5184se+oBhb8XxdESQiEBgUrXVPyIjpJ+UNwOnflYVCIUCy5zIMft31x68AOemB9yAOGCXC51lksZD5KS2CHdq7Q90/vA+gjB1pzdFQfF9kUug8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725694975; c=relaxed/simple;
	bh=bbNlLkhC7VjgRHgqNiosqA/8+auffYyQgDJoAhuNR9s=;
	h=Date:From:To:Cc:Subject:Message-ID; b=b+8vqksEGpV61xupSEvi4ZlXH2td6YgR1uEZISw+y3xbWcXKvgPA9IoHufMwNQlKD0U3Eq/427ge6mvcTd5NyQSX8w+AaYpUMAL1nwXmuafPGOWRBaGkM0bt7c2WlT3/hfYqN26Y2/IJbPsteuhreeFKi0QSyBs6Cd+P65VGKX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WjmtYOgX; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725694974; x=1757230974;
  h=date:from:to:cc:subject:message-id;
  bh=bbNlLkhC7VjgRHgqNiosqA/8+auffYyQgDJoAhuNR9s=;
  b=WjmtYOgX9Qz5f6BFHqp+Tk0BhJPVaaW+/2N1gp6jgtIM0bIxVrAclbvk
   2VwenEhb11nQ7wJHLsBfA77kEjO2WdKgAtktET64vlBTplUec6HzrRurj
   kpfXeQlDjn1NJWnQegYA8HdFUULit/vwf2WeS/uOwPYQlCviid+trtjid
   W17Me3FMf5/gnvfC6N2QW89Jx7Pklv3Rb4l2KKID/upLYRGzZ1hzs0MMf
   YbNyoN+B4dTuGyWmEiKJzU3nQg8uv8PcV/L5aKUtR3VXywkDtuM3tzMtn
   EA/8O+LB0hL3KC7bm0dnHxVcsxhzTpNxUhqJoPzM7J34Lv3g73OgHVZkc
   w==;
X-CSE-ConnectionGUID: yotg2+FcRG2e1dZR75G4Ug==
X-CSE-MsgGUID: fiu+FW1jTsuz7he8+pSunA==
X-IronPort-AV: E=McAfee;i="6700,10204,11187"; a="35597666"
X-IronPort-AV: E=Sophos;i="6.10,210,1719903600"; 
   d="scan'208";a="35597666"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2024 00:42:54 -0700
X-CSE-ConnectionGUID: /tYurdn1TZCubq37aHlu0g==
X-CSE-MsgGUID: /eBCE6exSn2jISuYqtZ7tQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,210,1719903600"; 
   d="scan'208";a="70572410"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 07 Sep 2024 00:42:52 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1smq5q-000CI7-08;
	Sat, 07 Sep 2024 07:42:50 +0000
Date: Sat, 07 Sep 2024 15:42:37 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:perf/urgent] BUILD SUCCESS
 2ab9d830262c132ab5db2f571003d80850d56b2a
Message-ID: <202409071534.M9EIrFRe-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/urgent
branch HEAD: 2ab9d830262c132ab5db2f571003d80850d56b2a  perf/aux: Fix AUX buffer serialization

elapsed time: 1352m

configs tested: 167
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-14.1.0
alpha                            allyesconfig   clang-20
alpha                               defconfig   gcc-14.1.0
arc                              allmodconfig   clang-20
arc                               allnoconfig   gcc-14.1.0
arc                              allyesconfig   clang-20
arc                                 defconfig   gcc-14.1.0
arc                 nsimosci_hs_smp_defconfig   gcc-14.1.0
arc                        vdk_hs38_defconfig   gcc-14.1.0
arm                              allmodconfig   clang-20
arm                               allnoconfig   gcc-14.1.0
arm                              allyesconfig   clang-20
arm                                 defconfig   gcc-14.1.0
arm                        neponset_defconfig   clang-15
arm                          pxa168_defconfig   clang-15
arm                       spear13xx_defconfig   gcc-14.1.0
arm64                            allmodconfig   clang-20
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-14.1.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-14.1.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   gcc-14.1.0
hexagon                          allyesconfig   clang-20
hexagon                             defconfig   gcc-14.1.0
i386                             allmodconfig   clang-18
i386                              allnoconfig   clang-18
i386                             allyesconfig   clang-18
i386         buildonly-randconfig-001-20240906   clang-18
i386         buildonly-randconfig-001-20240907   gcc-12
i386         buildonly-randconfig-002-20240906   gcc-12
i386         buildonly-randconfig-002-20240907   gcc-12
i386         buildonly-randconfig-003-20240906   clang-18
i386         buildonly-randconfig-003-20240907   gcc-12
i386         buildonly-randconfig-004-20240906   gcc-12
i386         buildonly-randconfig-004-20240907   gcc-12
i386         buildonly-randconfig-005-20240906   clang-18
i386         buildonly-randconfig-005-20240907   gcc-12
i386         buildonly-randconfig-006-20240906   clang-18
i386         buildonly-randconfig-006-20240907   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240906   gcc-12
i386                  randconfig-001-20240907   gcc-12
i386                  randconfig-002-20240906   clang-18
i386                  randconfig-002-20240907   gcc-12
i386                  randconfig-003-20240906   gcc-12
i386                  randconfig-003-20240907   gcc-12
i386                  randconfig-004-20240906   clang-18
i386                  randconfig-004-20240907   gcc-12
i386                  randconfig-005-20240906   clang-18
i386                  randconfig-005-20240907   gcc-12
i386                  randconfig-006-20240906   gcc-12
i386                  randconfig-006-20240907   gcc-12
i386                  randconfig-011-20240906   gcc-12
i386                  randconfig-011-20240907   gcc-12
i386                  randconfig-012-20240906   clang-18
i386                  randconfig-012-20240907   gcc-12
i386                  randconfig-013-20240906   gcc-12
i386                  randconfig-013-20240907   gcc-12
i386                  randconfig-014-20240906   gcc-12
i386                  randconfig-014-20240907   gcc-12
i386                  randconfig-015-20240906   gcc-12
i386                  randconfig-015-20240907   gcc-12
i386                  randconfig-016-20240906   gcc-12
i386                  randconfig-016-20240907   gcc-12
loongarch                        alldefconfig   clang-15
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                          atari_defconfig   clang-15
m68k                                defconfig   gcc-14.1.0
m68k                        m5307c3_defconfig   gcc-14.1.0
m68k                        m5407c3_defconfig   clang-15
m68k                       m5475evb_defconfig   clang-15
m68k                          multi_defconfig   gcc-14.1.0
m68k                        mvme147_defconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
mips                        vocore2_defconfig   clang-15
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-14.1.0
openrisc                          allnoconfig   clang-20
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-12
openrisc                 simple_smp_defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   clang-20
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-12
parisc64                            defconfig   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   clang-20
powerpc                          allyesconfig   gcc-14.1.0
powerpc                      cm5200_defconfig   clang-15
powerpc                       eiger_defconfig   clang-15
powerpc                        fsp2_defconfig   gcc-14.1.0
powerpc                  iss476-smp_defconfig   clang-15
powerpc                     ksi8560_defconfig   gcc-14.1.0
powerpc                      ppc6xx_defconfig   gcc-14.1.0
powerpc                         ps3_defconfig   clang-15
powerpc                     tqm8555_defconfig   clang-15
powerpc                         wii_defconfig   gcc-14.1.0
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   clang-20
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-12
riscv             nommu_k210_sdcard_defconfig   clang-15
s390                             allmodconfig   gcc-14.1.0
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-12
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-12
sh                               j2_defconfig   clang-15
sh                           se7206_defconfig   gcc-14.1.0
sh                           se7724_defconfig   gcc-14.1.0
sh                           se7750_defconfig   clang-15
sh                   secureedge5410_defconfig   gcc-14.1.0
sh                   sh7724_generic_defconfig   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-12
um                               allmodconfig   clang-20
um                                allnoconfig   clang-20
um                               allyesconfig   clang-20
um                                  defconfig   gcc-12
um                             i386_defconfig   clang-15
um                             i386_defconfig   gcc-12
um                           x86_64_defconfig   gcc-12
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240907   gcc-12
x86_64       buildonly-randconfig-002-20240907   gcc-12
x86_64       buildonly-randconfig-003-20240907   gcc-12
x86_64       buildonly-randconfig-004-20240907   gcc-12
x86_64       buildonly-randconfig-005-20240907   gcc-12
x86_64       buildonly-randconfig-006-20240907   gcc-12
x86_64                              defconfig   clang-18
x86_64                                  kexec   gcc-12
x86_64                randconfig-001-20240907   gcc-12
x86_64                randconfig-002-20240907   gcc-12
x86_64                randconfig-003-20240907   gcc-12
x86_64                randconfig-004-20240907   gcc-12
x86_64                randconfig-005-20240907   gcc-12
x86_64                randconfig-006-20240907   gcc-12
x86_64                randconfig-011-20240907   gcc-12
x86_64                randconfig-012-20240907   gcc-12
x86_64                randconfig-013-20240907   gcc-12
x86_64                randconfig-014-20240907   gcc-12
x86_64                randconfig-015-20240907   gcc-12
x86_64                randconfig-016-20240907   gcc-12
x86_64                randconfig-071-20240907   gcc-12
x86_64                randconfig-072-20240907   gcc-12
x86_64                randconfig-073-20240907   gcc-12
x86_64                randconfig-074-20240907   gcc-12
x86_64                randconfig-075-20240907   gcc-12
x86_64                randconfig-076-20240907   gcc-12
x86_64                          rhel-8.3-rust   clang-18
x86_64                               rhel-8.3   gcc-12
xtensa                            allnoconfig   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

