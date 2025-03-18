Return-Path: <linux-kernel+bounces-566042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA68A67274
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 12:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 008513B1550
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918F62080FC;
	Tue, 18 Mar 2025 11:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="khlV7325"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D4C1922FD
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 11:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742296788; cv=none; b=A5QRScxaMhgOyudfPpjr82POyGL5RH6QNesMkD9aRu4oj9vtci2O6rFYwNIfhMTaffQXglXgIPEPPoxjE30r164E4wocFwDCeixAk6HdGRnd/5mWW8YYN1AtTwURybPkg+JXcsoUroTXpyKk9DYvxpV9LB+Gy91dKpL8uR6VyLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742296788; c=relaxed/simple;
	bh=d+AKe++BlzhCHJkuUq1obYiXlcCsY3q1AUrBL2R9Zq4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=fEqm4rdsZy2mzRWeWku7abVDy5Oxo50cgcvM/F0bjmJd1a0Op9cyWLLldWVKgfLTKl5cEidTkcNdBCYShoI4Ra6y1tT0B9RQtMLJIUEggALwiioR8qavjHJW54in6qxfMXw2zZ0cjlS7uE55Ko7p8RQq9b4mM6BOyz/1l8HMD+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=khlV7325; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742296787; x=1773832787;
  h=date:from:to:cc:subject:message-id;
  bh=d+AKe++BlzhCHJkuUq1obYiXlcCsY3q1AUrBL2R9Zq4=;
  b=khlV73259vkiJFChgRshu+p64kDx/BSQbYKIswHL4PMmtdnbEtTmB3Ok
   +LCYScZPCQ9oLLTBK++hixc2CjNDyVSQHQ5gvDF4roNmyUMq+5ZgRmTAR
   A5SjNsUmnmue6QcLAJAfvyKP2iS1SDdHGMP0UIJ1qrFOsZkRrOKV/g4Ka
   RolN6YHJtZUvULipwa//MdvOVFVJORj21QME5b5L86SLkUVIqej1MRfL3
   Criiyj+ybCQDVtIa/iEMo8fBXyEhQTuBAT9D3/iSCB/06e76JBkVJINGT
   3LPrC+A4PLjmyAu3KR3LIPMfc7j/3rcM5sCbEbTBbRiLGSh++qBy/ZXNO
   w==;
X-CSE-ConnectionGUID: Klv3ze2xSu+yBNoiqgzseQ==
X-CSE-MsgGUID: ++XZKh6bSWKJr8wJYIOUFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="60824025"
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; 
   d="scan'208";a="60824025"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 04:19:47 -0700
X-CSE-ConnectionGUID: z1TYLWsBTs6wYJmHWMiRlA==
X-CSE-MsgGUID: rq0IyEkMRl2coobMRpKm0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; 
   d="scan'208";a="127265822"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 18 Mar 2025 04:19:45 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tuUz1-000Dhu-0y;
	Tue, 18 Mar 2025 11:19:43 +0000
Date: Tue, 18 Mar 2025 19:18:52 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:timers/core] BUILD SUCCESS
 d1c3a3f1c9a1dfc2b41696b7903972f4b3fbcd02
Message-ID: <202503181937.PVaAmwg7-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
branch HEAD: d1c3a3f1c9a1dfc2b41696b7903972f4b3fbcd02  posix-timers: Drop redundant memset() invocation

elapsed time: 1466m

configs tested: 210
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250317    gcc-13.2.0
arc                   randconfig-002-20250317    gcc-13.2.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-14.2.0
arm                      integrator_defconfig    gcc-14.2.0
arm                            mmp2_defconfig    gcc-14.2.0
arm                          pxa168_defconfig    clang-19
arm                          pxa3xx_defconfig    gcc-14.2.0
arm                   randconfig-001-20250317    gcc-14.2.0
arm                   randconfig-002-20250317    gcc-14.2.0
arm                   randconfig-003-20250317    gcc-14.2.0
arm                   randconfig-004-20250317    clang-21
arm                         s3c6400_defconfig    gcc-11.5.0
arm                           sama5_defconfig    gcc-8.5.0
arm                         socfpga_defconfig    gcc-14.2.0
arm                       spear13xx_defconfig    gcc-14.2.0
arm                           stm32_defconfig    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250317    gcc-14.2.0
arm64                 randconfig-002-20250317    gcc-14.2.0
arm64                 randconfig-003-20250317    gcc-14.2.0
arm64                 randconfig-004-20250317    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250317    gcc-14.2.0
csky                  randconfig-001-20250318    gcc-8.5.0
csky                  randconfig-002-20250317    gcc-14.2.0
csky                  randconfig-002-20250318    gcc-8.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250317    clang-21
hexagon               randconfig-001-20250318    gcc-8.5.0
hexagon               randconfig-002-20250317    clang-21
hexagon               randconfig-002-20250318    gcc-8.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250317    gcc-12
i386        buildonly-randconfig-002-20250317    clang-20
i386        buildonly-randconfig-003-20250317    clang-20
i386        buildonly-randconfig-004-20250317    clang-20
i386        buildonly-randconfig-005-20250317    gcc-12
i386        buildonly-randconfig-006-20250317    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250318    clang-20
i386                  randconfig-002-20250318    clang-20
i386                  randconfig-003-20250318    clang-20
i386                  randconfig-004-20250318    clang-20
i386                  randconfig-005-20250318    clang-20
i386                  randconfig-006-20250318    clang-20
i386                  randconfig-007-20250318    clang-20
i386                  randconfig-011-20250318    clang-20
i386                  randconfig-012-20250318    clang-20
i386                  randconfig-013-20250318    clang-20
i386                  randconfig-014-20250318    clang-20
i386                  randconfig-015-20250318    clang-20
i386                  randconfig-016-20250318    clang-20
i386                  randconfig-017-20250318    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250317    gcc-14.2.0
loongarch             randconfig-001-20250318    gcc-8.5.0
loongarch             randconfig-002-20250317    gcc-14.2.0
loongarch             randconfig-002-20250318    gcc-8.5.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-11.5.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                          hp300_defconfig    gcc-14.2.0
m68k                            mac_defconfig    gcc-5.5.0
m68k                        mvme147_defconfig    gcc-14.2.0
m68k                           virt_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-11.5.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-11.5.0
mips                              allnoconfig    gcc-14.2.0
mips                         bigsur_defconfig    gcc-14.2.0
mips                        maltaup_defconfig    clang-21
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250317    gcc-14.2.0
nios2                 randconfig-001-20250318    gcc-8.5.0
nios2                 randconfig-002-20250317    gcc-14.2.0
nios2                 randconfig-002-20250318    gcc-8.5.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-5.5.0
openrisc                            defconfig    gcc-12
openrisc                       virt_defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-5.5.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-5.5.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250317    gcc-14.2.0
parisc                randconfig-001-20250318    gcc-8.5.0
parisc                randconfig-002-20250317    gcc-14.2.0
parisc                randconfig-002-20250318    gcc-8.5.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-5.5.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                          allyesconfig    gcc-5.5.0
powerpc                        cell_defconfig    gcc-14.2.0
powerpc                      pmac32_defconfig    clang-21
powerpc                     ppa8548_defconfig    gcc-8.5.0
powerpc                      ppc44x_defconfig    clang-21
powerpc                      ppc44x_defconfig    gcc-14.2.0
powerpc                     rainier_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250317    clang-15
powerpc               randconfig-001-20250318    gcc-8.5.0
powerpc               randconfig-002-20250317    clang-21
powerpc               randconfig-002-20250318    gcc-8.5.0
powerpc               randconfig-003-20250317    gcc-14.2.0
powerpc               randconfig-003-20250318    gcc-8.5.0
powerpc64             randconfig-001-20250317    gcc-14.2.0
powerpc64             randconfig-001-20250318    gcc-8.5.0
powerpc64             randconfig-002-20250317    gcc-14.2.0
powerpc64             randconfig-002-20250318    gcc-8.5.0
powerpc64             randconfig-003-20250317    clang-21
powerpc64             randconfig-003-20250318    gcc-8.5.0
riscv                            allmodconfig    clang-21
riscv                            allmodconfig    gcc-5.5.0
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-5.5.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250317    gcc-14.2.0
riscv                 randconfig-002-20250317    gcc-14.2.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250317    clang-15
s390                  randconfig-002-20250317    clang-15
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-11.5.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                         ecovec24_defconfig    gcc-14.2.0
sh                          kfr2r09_defconfig    gcc-5.5.0
sh                          lboxre2_defconfig    gcc-14.2.0
sh                    randconfig-001-20250317    gcc-14.2.0
sh                    randconfig-002-20250317    gcc-14.2.0
sh                      rts7751r2d1_defconfig    gcc-14.2.0
sh                     sh7710voipgw_defconfig    gcc-14.2.0
sh                        sh7785lcr_defconfig    gcc-14.2.0
sh                              ul2_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-11.5.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250317    gcc-14.2.0
sparc                 randconfig-002-20250317    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250317    gcc-14.2.0
sparc64               randconfig-002-20250317    gcc-14.2.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250317    gcc-12
um                    randconfig-002-20250317    clang-21
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250317    gcc-12
x86_64      buildonly-randconfig-002-20250317    clang-20
x86_64      buildonly-randconfig-003-20250317    gcc-12
x86_64      buildonly-randconfig-004-20250317    gcc-12
x86_64      buildonly-randconfig-005-20250317    gcc-12
x86_64      buildonly-randconfig-006-20250317    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250318    gcc-12
x86_64                randconfig-002-20250318    gcc-12
x86_64                randconfig-003-20250318    gcc-12
x86_64                randconfig-004-20250318    gcc-12
x86_64                randconfig-005-20250318    gcc-12
x86_64                randconfig-006-20250318    gcc-12
x86_64                randconfig-007-20250318    gcc-12
x86_64                randconfig-008-20250318    gcc-12
x86_64                randconfig-071-20250318    gcc-12
x86_64                randconfig-072-20250318    gcc-12
x86_64                randconfig-073-20250318    gcc-12
x86_64                randconfig-074-20250318    gcc-12
x86_64                randconfig-075-20250318    gcc-12
x86_64                randconfig-076-20250318    gcc-12
x86_64                randconfig-077-20250318    gcc-12
x86_64                randconfig-078-20250318    gcc-12
x86_64                               rhel-9.4    clang-20
xtensa                            allnoconfig    gcc-11.5.0
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250317    gcc-14.2.0
xtensa                randconfig-002-20250317    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

