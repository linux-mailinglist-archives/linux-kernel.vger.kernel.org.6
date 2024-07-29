Return-Path: <linux-kernel+bounces-266567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A699401BA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 01:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B77631F2323E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 23:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E190818EFF1;
	Mon, 29 Jul 2024 23:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="djLRXYdn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE8381AD2
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 23:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722295511; cv=none; b=NSOv0E9EnFonMYVEbY62Vd3AC1hw8iwZpJ9yXkEZcRhFKVxjHOn/nx7UDb5AWqzy9o6pvf2I/J02tlfhwS5K2jPn3cMmGDVbhqqbJxGVBCwvWnjL1kDvifm9udpZIiiy2dRY4ZG7vQzAyn+U/yceq47/jGI+x73dqPZNdVU0FjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722295511; c=relaxed/simple;
	bh=paTOs1gve/dliQJR+NYO9YpRcT2duEADkhFTliDuxfk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ZE4mnJt/o8cuNxJccMzTEUN0WSQOzT33RSyX6fk8DfTJP5htQpLfhXdmlLGcijnUzQp55Yvhw1X2iHzGznOnx9ALZJvqVnXSO462yegglbKFiX6xMGofG2s1yfgA3JIuKo4e5yK4dTSRGCkcqF/MqVYIKOY4jVFGjjn/EKHmjHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=djLRXYdn; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722295509; x=1753831509;
  h=date:from:to:cc:subject:message-id;
  bh=paTOs1gve/dliQJR+NYO9YpRcT2duEADkhFTliDuxfk=;
  b=djLRXYdnJoT359kcHsa0V2LC/U2hHA5PxbidFQKuSPaM/kcrWq1Iy/S+
   zSo578jnZ5Afv1Ko+wl0U4ZEsDe0txgCjei8XXnet63qyy5enknkN5m+r
   wGzqXbcBnyDH2MTpVhjX1jVuNrAua6dyehnLI+b0pCRi/MPAl3XDCBioS
   ZMxEWH5gPXGxnI7+Yn0OsyxqcphyMMgTPWZisG19TlHmjGo1Gg7Di3Zfq
   0fHtcPO2gBoquXjLb8SQedqkTkMz9u4jbhPgS/SaPoEa/nmGOgMc69D1P
   0APIskNIUphE0gVixXPYa4HqHFbf0hb+r5WoM/WgQ1y/iKBN1MetXdZ/P
   g==;
X-CSE-ConnectionGUID: WEJqDoNxQieOa5M7p/68xg==
X-CSE-MsgGUID: aCE4A7rHSmKEWskebE0WXA==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="12779367"
X-IronPort-AV: E=Sophos;i="6.09,247,1716274800"; 
   d="scan'208";a="12779367"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 16:25:08 -0700
X-CSE-ConnectionGUID: U/NWmdSKQDCNj7h57WwCvg==
X-CSE-MsgGUID: PgFVly0VTBKfQV9HWPHDAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,247,1716274800"; 
   d="scan'208";a="59216615"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 29 Jul 2024 16:25:07 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sYZjk-000sB0-1z;
	Mon, 29 Jul 2024 23:25:04 +0000
Date: Tue, 30 Jul 2024 07:24:31 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/misc] BUILD SUCCESS
 59c34008d3bdeef4c8ebc0ed2426109b474334d4
Message-ID: <202407300728.hCtGCNz4-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/misc
branch HEAD: 59c34008d3bdeef4c8ebc0ed2426109b474334d4  x86/amd_nb: Add new PCI IDs for AMD family 1Ah model 60h

elapsed time: 928m

configs tested: 266
configs skipped: 11

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
arc                     nsimosci_hs_defconfig   gcc-13.2.0
arc                   randconfig-001-20240729   gcc-13.2.0
arc                   randconfig-002-20240729   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-20
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                              allyesconfig   gcc-14.1.0
arm                                 defconfig   gcc-13.2.0
arm                      footbridge_defconfig   gcc-13.2.0
arm                       imx_v4_v5_defconfig   gcc-13.2.0
arm                          ixp4xx_defconfig   gcc-13.2.0
arm                   randconfig-001-20240729   gcc-13.2.0
arm                   randconfig-001-20240729   gcc-14.1.0
arm                   randconfig-002-20240729   gcc-13.2.0
arm                   randconfig-002-20240729   gcc-14.1.0
arm                   randconfig-003-20240729   gcc-13.2.0
arm                   randconfig-003-20240729   gcc-14.1.0
arm                   randconfig-004-20240729   clang-20
arm                   randconfig-004-20240729   gcc-13.2.0
arm64                            allmodconfig   clang-20
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240729   clang-17
arm64                 randconfig-001-20240729   gcc-13.2.0
arm64                 randconfig-002-20240729   clang-20
arm64                 randconfig-002-20240729   gcc-13.2.0
arm64                 randconfig-003-20240729   gcc-13.2.0
arm64                 randconfig-003-20240729   gcc-14.1.0
arm64                 randconfig-004-20240729   clang-20
arm64                 randconfig-004-20240729   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240729   gcc-13.2.0
csky                  randconfig-001-20240729   gcc-14.1.0
csky                  randconfig-002-20240729   gcc-13.2.0
csky                  randconfig-002-20240729   gcc-14.1.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   clang-20
hexagon                          allyesconfig   clang-20
hexagon               randconfig-001-20240729   clang-20
hexagon               randconfig-002-20240729   clang-20
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-13
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-13
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240729   clang-18
i386         buildonly-randconfig-001-20240730   gcc-13
i386         buildonly-randconfig-002-20240729   clang-18
i386         buildonly-randconfig-002-20240729   gcc-13
i386         buildonly-randconfig-002-20240730   gcc-13
i386         buildonly-randconfig-003-20240729   clang-18
i386         buildonly-randconfig-003-20240730   gcc-13
i386         buildonly-randconfig-004-20240729   clang-18
i386         buildonly-randconfig-004-20240729   gcc-10
i386         buildonly-randconfig-004-20240730   gcc-13
i386         buildonly-randconfig-005-20240729   clang-18
i386         buildonly-randconfig-005-20240730   gcc-13
i386         buildonly-randconfig-006-20240729   clang-18
i386         buildonly-randconfig-006-20240729   gcc-8
i386         buildonly-randconfig-006-20240730   gcc-13
i386                                defconfig   clang-18
i386                  randconfig-001-20240729   clang-18
i386                  randconfig-001-20240729   gcc-12
i386                  randconfig-001-20240730   gcc-13
i386                  randconfig-002-20240729   clang-18
i386                  randconfig-002-20240730   gcc-13
i386                  randconfig-003-20240729   clang-18
i386                  randconfig-003-20240729   gcc-10
i386                  randconfig-003-20240730   gcc-13
i386                  randconfig-004-20240729   clang-18
i386                  randconfig-004-20240729   gcc-13
i386                  randconfig-004-20240730   gcc-13
i386                  randconfig-005-20240729   clang-18
i386                  randconfig-005-20240729   gcc-8
i386                  randconfig-005-20240730   gcc-13
i386                  randconfig-006-20240729   clang-18
i386                  randconfig-006-20240729   gcc-13
i386                  randconfig-006-20240730   gcc-13
i386                  randconfig-011-20240729   clang-18
i386                  randconfig-011-20240729   gcc-13
i386                  randconfig-011-20240730   gcc-13
i386                  randconfig-012-20240729   clang-18
i386                  randconfig-012-20240730   gcc-13
i386                  randconfig-013-20240729   clang-18
i386                  randconfig-013-20240729   gcc-9
i386                  randconfig-013-20240730   gcc-13
i386                  randconfig-014-20240729   clang-18
i386                  randconfig-014-20240730   gcc-13
i386                  randconfig-015-20240729   clang-18
i386                  randconfig-015-20240729   gcc-13
i386                  randconfig-015-20240730   gcc-13
i386                  randconfig-016-20240729   clang-18
i386                  randconfig-016-20240730   gcc-13
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240729   gcc-13.2.0
loongarch             randconfig-001-20240729   gcc-14.1.0
loongarch             randconfig-002-20240729   gcc-13.2.0
loongarch             randconfig-002-20240729   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
m68k                       m5475evb_defconfig   gcc-13.2.0
m68k                            mac_defconfig   gcc-13.2.0
m68k                        mvme147_defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-14.1.0
mips                      malta_kvm_defconfig   gcc-13.2.0
mips                           xway_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240729   gcc-13.2.0
nios2                 randconfig-001-20240729   gcc-14.1.0
nios2                 randconfig-002-20240729   gcc-13.2.0
nios2                 randconfig-002-20240729   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240729   gcc-13.2.0
parisc                randconfig-001-20240729   gcc-14.1.0
parisc                randconfig-002-20240729   gcc-13.2.0
parisc                randconfig-002-20240729   gcc-14.1.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-20
powerpc                          allyesconfig   gcc-14.1.0
powerpc                      katmai_defconfig   gcc-13.2.0
powerpc                 mpc8313_rdb_defconfig   gcc-13.2.0
powerpc                 mpc8315_rdb_defconfig   gcc-13.2.0
powerpc                     ppa8548_defconfig   gcc-13.2.0
powerpc                     tqm8548_defconfig   gcc-13.2.0
powerpc64             randconfig-001-20240729   gcc-13.2.0
powerpc64             randconfig-001-20240729   gcc-14.1.0
powerpc64             randconfig-002-20240729   gcc-13.2.0
powerpc64             randconfig-002-20240729   gcc-14.1.0
powerpc64             randconfig-003-20240729   gcc-13.2.0
powerpc64             randconfig-003-20240729   gcc-14.1.0
riscv                            allmodconfig   clang-20
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-20
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-14.1.0
riscv                 randconfig-001-20240729   clang-16
riscv                 randconfig-001-20240729   gcc-13.2.0
riscv                 randconfig-002-20240729   clang-20
riscv                 randconfig-002-20240729   gcc-13.2.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240729   clang-20
s390                  randconfig-001-20240729   gcc-13.2.0
s390                  randconfig-002-20240729   gcc-13.2.0
s390                  randconfig-002-20240729   gcc-14.1.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                               j2_defconfig   gcc-13.2.0
sh                    randconfig-001-20240729   gcc-13.2.0
sh                    randconfig-001-20240729   gcc-14.1.0
sh                    randconfig-002-20240729   gcc-13.2.0
sh                    randconfig-002-20240729   gcc-14.1.0
sh                          sdk7786_defconfig   gcc-13.2.0
sh                           se7206_defconfig   gcc-13.2.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240729   gcc-13.2.0
sparc64               randconfig-001-20240729   gcc-14.1.0
sparc64               randconfig-002-20240729   gcc-13.2.0
sparc64               randconfig-002-20240729   gcc-14.1.0
um                               allmodconfig   clang-20
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-13
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240729   clang-14
um                    randconfig-001-20240729   gcc-13.2.0
um                    randconfig-002-20240729   gcc-13.2.0
um                    randconfig-002-20240729   gcc-8
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240729   clang-18
x86_64       buildonly-randconfig-002-20240729   clang-18
x86_64       buildonly-randconfig-002-20240729   gcc-13
x86_64       buildonly-randconfig-003-20240729   clang-18
x86_64       buildonly-randconfig-003-20240729   gcc-10
x86_64       buildonly-randconfig-004-20240729   clang-18
x86_64       buildonly-randconfig-004-20240729   gcc-10
x86_64       buildonly-randconfig-005-20240729   clang-18
x86_64       buildonly-randconfig-005-20240729   gcc-10
x86_64       buildonly-randconfig-006-20240729   clang-18
x86_64       buildonly-randconfig-006-20240729   gcc-10
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240729   clang-18
x86_64                randconfig-001-20240729   gcc-13
x86_64                randconfig-002-20240729   clang-18
x86_64                randconfig-003-20240729   clang-18
x86_64                randconfig-004-20240729   clang-18
x86_64                randconfig-005-20240729   clang-18
x86_64                randconfig-006-20240729   clang-18
x86_64                randconfig-011-20240729   clang-18
x86_64                randconfig-011-20240729   gcc-8
x86_64                randconfig-012-20240729   clang-18
x86_64                randconfig-012-20240729   gcc-8
x86_64                randconfig-013-20240729   clang-18
x86_64                randconfig-013-20240729   gcc-13
x86_64                randconfig-014-20240729   clang-18
x86_64                randconfig-015-20240729   clang-18
x86_64                randconfig-015-20240729   gcc-13
x86_64                randconfig-016-20240729   clang-18
x86_64                randconfig-071-20240729   clang-18
x86_64                randconfig-071-20240729   gcc-13
x86_64                randconfig-072-20240729   clang-18
x86_64                randconfig-072-20240729   gcc-13
x86_64                randconfig-073-20240729   clang-18
x86_64                randconfig-074-20240729   clang-18
x86_64                randconfig-074-20240729   gcc-8
x86_64                randconfig-075-20240729   clang-18
x86_64                randconfig-075-20240729   gcc-12
x86_64                randconfig-076-20240729   clang-18
x86_64                randconfig-076-20240729   gcc-13
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240729   gcc-13.2.0
xtensa                randconfig-001-20240729   gcc-14.1.0
xtensa                randconfig-002-20240729   gcc-13.2.0
xtensa                randconfig-002-20240729   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

