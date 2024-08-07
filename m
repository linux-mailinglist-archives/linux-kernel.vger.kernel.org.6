Return-Path: <linux-kernel+bounces-277176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE711949D7B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 03:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6183C1F21707
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 01:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8474918FC98;
	Wed,  7 Aug 2024 01:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c1XxsQuE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E512D17C200
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 01:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722995440; cv=none; b=bsanBxyIm2RXDZsaTzYbBgVoSRy0Fh5PyaOfrqvFZ2tpC3n1lNOpJJek7DxU3y4PURJOUIC21wQHonLCAjrSB+QTgcTiCU0llX+REDjmL3Ab1zo2UFBWqYQtmlCLA1tRF3vP0Uc6dkbiCxFhrUA1ZyltmMEPi6v3OaOBqeT4lPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722995440; c=relaxed/simple;
	bh=zRWO6r0En2RKwIyQ6tkhscI6Cbb73FLa5bArNqKXGPc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=HORjaVocTuQbv6h9S/NUbWlsDqiR8vNYex9quIyIuvKwaXYuwYc7C1978T00EpmbOsN6ARGREoK5QgynOo9DiYzjhCHstrViy6i+b3yAMDSSKtt1vAwRZ+hCesanYMOXLDVJiojiHv+h1DJaaGOSkuCx7oHBPJIMiFU4CE7yOS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c1XxsQuE; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722995438; x=1754531438;
  h=date:from:to:cc:subject:message-id;
  bh=zRWO6r0En2RKwIyQ6tkhscI6Cbb73FLa5bArNqKXGPc=;
  b=c1XxsQuED47hpNu02C5/3I6pwijwoTAcG6Ic0D+ZoL5n6iQkdo7eAbp7
   GrH1KyK5WE5SajzZPzeHcCwWJonbsLI8i8L6ahhoPpFtuKoWI/VKVymf2
   HtZ/QVNOdqWPHLImULO3dcgfUre/LCtN4QeDKm+6GaKssjWaexbEe9UqK
   JZ6MZwQnTWKansIADIm4/JqinWqK3gEJpEXISvskexQ6J1OcqCyuby1Uq
   e1Wu1BPLXo5vDoazA8JYW0r0Q8jIKMDm8lhMEF4cerMRaNyH6HEOaEFWS
   0ozYwu+okTGd3aiievR5pPCeRpSKjhQk8MYgcGCTTyf4nyUv3YVMDg2Vp
   Q==;
X-CSE-ConnectionGUID: j9nKTC5wRMuXG6335N3QJA==
X-CSE-MsgGUID: FOp2P76AR3udsWPNznG89g==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="31673899"
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="31673899"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 18:50:37 -0700
X-CSE-ConnectionGUID: 7nNS2casS8CdJmv8gOSR4w==
X-CSE-MsgGUID: CjS1Ai1eTCCOw9xgcBkqug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="87368311"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 06 Aug 2024 18:50:36 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sbVov-00052w-2b;
	Wed, 07 Aug 2024 01:50:33 +0000
Date: Wed, 07 Aug 2024 09:49:36 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/core] BUILD SUCCESS
 7424fc6b86c8980a87169e005f5cd4438d18efe6
Message-ID: <202408070934.qJQhYSKD-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/core
branch HEAD: 7424fc6b86c8980a87169e005f5cd4438d18efe6  x86/traps: Enable UBSAN traps on x86

elapsed time: 770m

configs tested: 194
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240807   gcc-13.2.0
arc                   randconfig-002-20240807   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-20
arm                              allyesconfig   gcc-14.1.0
arm                                 defconfig   gcc-13.2.0
arm                           h3600_defconfig   gcc-14.1.0
arm                         mv78xx0_defconfig   gcc-14.1.0
arm                           omap1_defconfig   gcc-14.1.0
arm                             pxa_defconfig   gcc-14.1.0
arm                   randconfig-001-20240807   clang-20
arm                   randconfig-002-20240807   gcc-14.1.0
arm                   randconfig-003-20240807   gcc-14.1.0
arm                   randconfig-004-20240807   gcc-14.1.0
arm64                            allmodconfig   clang-20
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-13.2.0
arm64                               defconfig   gcc-14.1.0
arm64                 randconfig-001-20240807   gcc-14.1.0
arm64                 randconfig-002-20240807   clang-17
arm64                 randconfig-003-20240807   clang-15
arm64                 randconfig-004-20240807   clang-20
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240807   gcc-14.1.0
csky                  randconfig-002-20240807   gcc-14.1.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   clang-20
hexagon                          allyesconfig   clang-20
hexagon               randconfig-001-20240807   clang-14
hexagon               randconfig-002-20240807   clang-20
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-12
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-12
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240806   gcc-11
i386         buildonly-randconfig-001-20240807   clang-18
i386         buildonly-randconfig-002-20240806   gcc-12
i386         buildonly-randconfig-002-20240807   clang-18
i386         buildonly-randconfig-003-20240806   gcc-12
i386         buildonly-randconfig-003-20240807   clang-18
i386         buildonly-randconfig-004-20240806   gcc-12
i386         buildonly-randconfig-004-20240807   clang-18
i386         buildonly-randconfig-005-20240806   clang-18
i386         buildonly-randconfig-005-20240807   clang-18
i386         buildonly-randconfig-006-20240806   gcc-12
i386         buildonly-randconfig-006-20240807   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240806   clang-18
i386                  randconfig-001-20240807   clang-18
i386                  randconfig-002-20240806   gcc-12
i386                  randconfig-002-20240807   clang-18
i386                  randconfig-003-20240806   gcc-12
i386                  randconfig-003-20240807   clang-18
i386                  randconfig-004-20240806   gcc-12
i386                  randconfig-004-20240807   clang-18
i386                  randconfig-005-20240806   clang-18
i386                  randconfig-005-20240807   clang-18
i386                  randconfig-006-20240806   clang-18
i386                  randconfig-006-20240807   clang-18
i386                  randconfig-011-20240806   clang-18
i386                  randconfig-011-20240807   clang-18
i386                  randconfig-012-20240806   gcc-12
i386                  randconfig-012-20240807   clang-18
i386                  randconfig-013-20240806   clang-18
i386                  randconfig-013-20240807   clang-18
i386                  randconfig-014-20240806   clang-18
i386                  randconfig-014-20240807   clang-18
i386                  randconfig-015-20240806   clang-18
i386                  randconfig-015-20240807   clang-18
i386                  randconfig-016-20240806   clang-18
i386                  randconfig-016-20240807   clang-18
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240807   gcc-14.1.0
loongarch             randconfig-002-20240807   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-14.1.0
mips                          eyeq5_defconfig   gcc-14.1.0
mips                           gcw0_defconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240807   gcc-14.1.0
nios2                 randconfig-002-20240807   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240807   gcc-14.1.0
parisc                randconfig-002-20240807   gcc-14.1.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-20
powerpc                   bluestone_defconfig   gcc-14.1.0
powerpc                       eiger_defconfig   gcc-14.1.0
powerpc                     mpc5200_defconfig   gcc-14.1.0
powerpc               randconfig-001-20240807   clang-20
powerpc               randconfig-003-20240807   gcc-14.1.0
powerpc64             randconfig-001-20240807   clang-15
powerpc64             randconfig-002-20240807   gcc-14.1.0
powerpc64             randconfig-003-20240807   gcc-14.1.0
riscv                            allmodconfig   clang-20
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-20
riscv                               defconfig   clang-20
riscv                               defconfig   gcc-14.1.0
riscv                 randconfig-001-20240807   clang-20
riscv                 randconfig-002-20240807   clang-20
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   clang-20
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240807   gcc-14.1.0
s390                  randconfig-002-20240807   gcc-14.1.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                     magicpanelr2_defconfig   gcc-14.1.0
sh                    randconfig-001-20240807   gcc-14.1.0
sh                    randconfig-002-20240807   gcc-14.1.0
sh                          sdk7786_defconfig   gcc-14.1.0
sh                           se7705_defconfig   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240807   gcc-14.1.0
um                               allmodconfig   clang-20
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-12
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   clang-20
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-12
um                             i386_defconfig   gcc-14.1.0
um                           x86_64_defconfig   clang-15
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240807   clang-18
x86_64       buildonly-randconfig-002-20240807   clang-18
x86_64       buildonly-randconfig-003-20240807   clang-18
x86_64       buildonly-randconfig-004-20240807   clang-18
x86_64       buildonly-randconfig-005-20240807   clang-18
x86_64       buildonly-randconfig-006-20240807   clang-18
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-11
x86_64                randconfig-001-20240807   clang-18
x86_64                randconfig-002-20240807   gcc-12
x86_64                randconfig-003-20240807   clang-18
x86_64                randconfig-004-20240807   gcc-12
x86_64                randconfig-005-20240807   gcc-12
x86_64                randconfig-006-20240807   gcc-12
x86_64                randconfig-011-20240807   clang-18
x86_64                randconfig-012-20240807   gcc-12
x86_64                randconfig-013-20240807   gcc-12
x86_64                randconfig-014-20240807   gcc-12
x86_64                randconfig-015-20240807   clang-18
x86_64                randconfig-016-20240807   clang-18
x86_64                randconfig-071-20240807   clang-18
x86_64                randconfig-072-20240807   clang-18
x86_64                randconfig-073-20240807   gcc-12
x86_64                randconfig-074-20240807   clang-18
x86_64                randconfig-075-20240807   gcc-12
x86_64                randconfig-076-20240807   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-14.1.0
xtensa                  cadence_csp_defconfig   gcc-14.1.0
xtensa                         virt_defconfig   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

