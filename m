Return-Path: <linux-kernel+bounces-266473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFC894005E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 23:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 118F52837E8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 21:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9624618D4C2;
	Mon, 29 Jul 2024 21:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QZ3vdAfR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05665186E29
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 21:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722288487; cv=none; b=pmPgYzadWIVxW4hXo3UcL28R3BhJg4MVazHzZoaEQpBAqpJtK4wjgf8vqLuJiyg7RO/0bWVwNnRb3hAapctfMBC0eocUUul54prBxcG0S3OisICs85xsmPRU845NecQFV8VR7j+IE4mVhcLoKMHHXrinY8OYpBCW5m/n7qQVr8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722288487; c=relaxed/simple;
	bh=9HaANiUDvi/hnJacVsrl48ih/jw43RRvJVLgI6XB5Jc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=fyAG41Lfq8N+oc0USRILhOGwysS+QxNmVq24AA6iktTozwTMejtV7VmGT7tqsJRpEM74wGKBQTP/Rz7ROfS21gmZGSg1EhqHTR8IcKaqN8RFOVcaaThBYY9HjhVdOZfMdbz9FlF1WGpA5FKF2Ja6jneKtxAYpvhNpldtig6D6Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QZ3vdAfR; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722288485; x=1753824485;
  h=date:from:to:cc:subject:message-id;
  bh=9HaANiUDvi/hnJacVsrl48ih/jw43RRvJVLgI6XB5Jc=;
  b=QZ3vdAfRt79b+NL3V66uQCF3Z1EkmkD/GE36YLdCzQN6h52znSCw2ZuO
   C0cevGdK8noA2I8p2BosKRwMk8i+NbPRXuYCZnOMFGKD75fHW3uY1oeKt
   H2OPR/6U5WbQFvNDy9wHCg5gClYctHJdYrS4i59mlaj28is003Ket/GMa
   SKC/3hyRkrj+D/H0OvT3EE/cDYG3er8kDpKUeaw9bTfRMzJeqmdi+CxPl
   Nk9AXUnvUlV2VP6ZtYemimcP/JSk2BV/Ii5q6+QB1ntu7FDh4rRrkxIBu
   TlmlObyScLyvpP8zQ8pNf+ohTSMBj5hsH/lVNbpf4FHsWOKSyk99cIAhO
   A==;
X-CSE-ConnectionGUID: 0oP93ne/SLmDh5sx+38HWw==
X-CSE-MsgGUID: zgfgR3ZZR4mYWzqGRWBKLg==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="23827410"
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="23827410"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 14:28:04 -0700
X-CSE-ConnectionGUID: Mby+ZjS9R3OmCmDftRMymQ==
X-CSE-MsgGUID: Wuwq9EdoQnaR2bNX2tdehg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="53756173"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 29 Jul 2024 14:28:03 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sYXuT-000s5g-0x;
	Mon, 29 Jul 2024 21:28:01 +0000
Date: Tue, 30 Jul 2024 05:27:29 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/microcode] BUILD SUCCESS WITH WARNING
 94838d230a6c835ced1bad06b8759e0a5f19c1d3
Message-ID: <202407300526.uyAxSSD5-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/microcode
branch HEAD: 94838d230a6c835ced1bad06b8759e0a5f19c1d3  x86/microcode/AMD: Use the family,model,stepping encoded in the patch ID

Warning reports:

https://lore.kernel.org/oe-kbuild-all/202407291815.gJBST0P3-lkp@intel.com

Warning: (recently discovered and may have been fixed)

arch/x86/kernel/cpu/microcode/amd.c:714:6: warning: variable 'equiv_id' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]

Warning ids grouped by kconfigs:

recent_errors
|-- i386-buildonly-randconfig-001-20240729
|   `-- arch-x86-kernel-cpu-microcode-amd.c:warning:variable-equiv_id-is-used-uninitialized-whenever-if-condition-is-false
|-- i386-buildonly-randconfig-003-20240729
|   `-- arch-x86-kernel-cpu-microcode-amd.c:warning:variable-equiv_id-is-used-uninitialized-whenever-if-condition-is-false
|-- i386-buildonly-randconfig-003-20240730
|   `-- arch-x86-kernel-cpu-microcode-amd.c:warning:variable-equiv_id-is-used-uninitialized-whenever-if-condition-is-false
|-- i386-buildonly-randconfig-004-20240730
|   `-- arch-x86-kernel-cpu-microcode-amd.c:warning:variable-equiv_id-is-used-uninitialized-whenever-if-condition-is-false
|-- i386-buildonly-randconfig-005-20240729
|   `-- arch-x86-kernel-cpu-microcode-amd.c:warning:variable-equiv_id-is-used-uninitialized-whenever-if-condition-is-false
|-- i386-buildonly-randconfig-006-20240730
|   `-- arch-x86-kernel-cpu-microcode-amd.c:warning:variable-equiv_id-is-used-uninitialized-whenever-if-condition-is-false
|-- i386-defconfig
|   `-- arch-x86-kernel-cpu-microcode-amd.c:warning:variable-equiv_id-is-used-uninitialized-whenever-if-condition-is-false
|-- i386-randconfig-002-20240729
|   `-- arch-x86-kernel-cpu-microcode-amd.c:warning:variable-equiv_id-is-used-uninitialized-whenever-if-condition-is-false
|-- i386-randconfig-012-20240729
|   `-- arch-x86-kernel-cpu-microcode-amd.c:warning:variable-equiv_id-is-used-uninitialized-whenever-if-condition-is-false
|-- i386-randconfig-014-20240729
|   `-- arch-x86-kernel-cpu-microcode-amd.c:warning:variable-equiv_id-is-used-uninitialized-whenever-if-condition-is-false
|-- i386-randconfig-016-20240729
|   `-- arch-x86-kernel-cpu-microcode-amd.c:warning:variable-equiv_id-is-used-uninitialized-whenever-if-condition-is-false
|-- i386-randconfig-141-20240729
|   `-- arch-x86-kernel-cpu-microcode-amd.c:warning:variable-equiv_id-is-used-uninitialized-whenever-if-condition-is-false
|-- x86_64-allmodconfig
|   `-- arch-x86-kernel-cpu-microcode-amd.c:warning:variable-equiv_id-is-used-uninitialized-whenever-if-condition-is-false
|-- x86_64-allnoconfig
|   `-- arch-x86-kernel-cpu-microcode-amd.c:warning:variable-equiv_id-is-used-uninitialized-whenever-if-condition-is-false
|-- x86_64-allyesconfig
|   `-- arch-x86-kernel-cpu-microcode-amd.c:warning:variable-equiv_id-is-used-uninitialized-whenever-if-condition-is-false
|-- x86_64-buildonly-randconfig-001-20240729
|   `-- arch-x86-kernel-cpu-microcode-amd.c:warning:variable-equiv_id-is-used-uninitialized-whenever-if-condition-is-false
|-- x86_64-buildonly-randconfig-001-20240730
|   `-- arch-x86-kernel-cpu-microcode-amd.c:warning:variable-equiv_id-is-used-uninitialized-whenever-if-condition-is-false
|-- x86_64-buildonly-randconfig-003-20240730
|   `-- arch-x86-kernel-cpu-microcode-amd.c:warning:variable-equiv_id-is-used-uninitialized-whenever-if-condition-is-false
|-- x86_64-buildonly-randconfig-006-20240730
|   `-- arch-x86-kernel-cpu-microcode-amd.c:warning:variable-equiv_id-is-used-uninitialized-whenever-if-condition-is-false
|-- x86_64-randconfig-001-20240730
|   `-- arch-x86-kernel-cpu-microcode-amd.c:warning:variable-equiv_id-is-used-uninitialized-whenever-if-condition-is-false
|-- x86_64-randconfig-003-20240729
|   `-- arch-x86-kernel-cpu-microcode-amd.c:warning:variable-equiv_id-is-used-uninitialized-whenever-if-condition-is-false
|-- x86_64-randconfig-004-20240729
|   `-- arch-x86-kernel-cpu-microcode-amd.c:warning:variable-equiv_id-is-used-uninitialized-whenever-if-condition-is-false
|-- x86_64-randconfig-005-20240729
|   `-- arch-x86-kernel-cpu-microcode-amd.c:warning:variable-equiv_id-is-used-uninitialized-whenever-if-condition-is-false
|-- x86_64-randconfig-006-20240729
|   `-- arch-x86-kernel-cpu-microcode-amd.c:warning:variable-equiv_id-is-used-uninitialized-whenever-if-condition-is-false
|-- x86_64-randconfig-014-20240729
|   `-- arch-x86-kernel-cpu-microcode-amd.c:warning:variable-equiv_id-is-used-uninitialized-whenever-if-condition-is-false
|-- x86_64-randconfig-016-20240729
|   `-- arch-x86-kernel-cpu-microcode-amd.c:warning:variable-equiv_id-is-used-uninitialized-whenever-if-condition-is-false
|-- x86_64-randconfig-161-20240729
|   `-- arch-x86-kernel-cpu-microcode-amd.c:warning:variable-equiv_id-is-used-uninitialized-whenever-if-condition-is-false
`-- x86_64-rhel-8.3-rust
    `-- arch-x86-kernel-cpu-microcode-amd.c:warning:variable-equiv_id-is-used-uninitialized-whenever-if-condition-is-false

elapsed time: 737m

configs tested: 160
configs skipped: 131

tested configs:
alpha                             allnoconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                     nsimosci_hs_defconfig   gcc-13.2.0
arc                   randconfig-001-20240729   gcc-13.2.0
arc                   randconfig-002-20240729   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                      footbridge_defconfig   gcc-13.2.0
arm                       imx_v4_v5_defconfig   gcc-13.2.0
arm                          ixp4xx_defconfig   gcc-13.2.0
arm                   randconfig-001-20240729   gcc-13.2.0
arm                   randconfig-002-20240729   gcc-13.2.0
arm                   randconfig-003-20240729   gcc-13.2.0
arm                   randconfig-004-20240729   gcc-13.2.0
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                 randconfig-001-20240729   gcc-13.2.0
arm64                 randconfig-002-20240729   gcc-13.2.0
arm64                 randconfig-003-20240729   gcc-13.2.0
arm64                 randconfig-004-20240729   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                  randconfig-001-20240729   gcc-13.2.0
csky                  randconfig-002-20240729   gcc-13.2.0
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-13
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-13
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240729   clang-18
i386         buildonly-randconfig-002-20240729   clang-18
i386         buildonly-randconfig-002-20240729   gcc-13
i386         buildonly-randconfig-003-20240729   clang-18
i386         buildonly-randconfig-004-20240729   clang-18
i386         buildonly-randconfig-004-20240729   gcc-10
i386         buildonly-randconfig-005-20240729   clang-18
i386         buildonly-randconfig-006-20240729   clang-18
i386         buildonly-randconfig-006-20240729   gcc-8
i386                                defconfig   clang-18
i386                  randconfig-001-20240729   clang-18
i386                  randconfig-001-20240729   gcc-12
i386                  randconfig-002-20240729   clang-18
i386                  randconfig-003-20240729   clang-18
i386                  randconfig-003-20240729   gcc-10
i386                  randconfig-004-20240729   clang-18
i386                  randconfig-004-20240729   gcc-13
i386                  randconfig-005-20240729   clang-18
i386                  randconfig-005-20240729   gcc-8
i386                  randconfig-006-20240729   clang-18
i386                  randconfig-006-20240729   gcc-13
i386                  randconfig-011-20240729   clang-18
i386                  randconfig-011-20240729   gcc-13
i386                  randconfig-012-20240729   clang-18
i386                  randconfig-013-20240729   clang-18
i386                  randconfig-013-20240729   gcc-9
i386                  randconfig-014-20240729   clang-18
i386                  randconfig-015-20240729   clang-18
i386                  randconfig-015-20240729   gcc-13
i386                  randconfig-016-20240729   clang-18
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch             randconfig-001-20240729   gcc-13.2.0
loongarch             randconfig-002-20240729   gcc-13.2.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-14.1.0
m68k                       m5475evb_defconfig   gcc-13.2.0
m68k                            mac_defconfig   gcc-13.2.0
m68k                        mvme147_defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-14.1.0
mips                              allnoconfig   gcc-13.2.0
mips                      malta_kvm_defconfig   gcc-13.2.0
mips                           xway_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                 randconfig-001-20240729   gcc-13.2.0
nios2                 randconfig-002-20240729   gcc-13.2.0
openrisc                          allnoconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                randconfig-001-20240729   gcc-13.2.0
parisc                randconfig-002-20240729   gcc-13.2.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                      katmai_defconfig   gcc-13.2.0
powerpc                 mpc8313_rdb_defconfig   gcc-13.2.0
powerpc                 mpc8315_rdb_defconfig   gcc-13.2.0
powerpc                     ppa8548_defconfig   gcc-13.2.0
powerpc                     tqm8548_defconfig   gcc-13.2.0
powerpc64             randconfig-001-20240729   gcc-13.2.0
powerpc64             randconfig-002-20240729   gcc-13.2.0
powerpc64             randconfig-003-20240729   gcc-13.2.0
riscv                             allnoconfig   gcc-14.1.0
riscv                 randconfig-001-20240729   gcc-13.2.0
riscv                 randconfig-002-20240729   gcc-13.2.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-20
s390                  randconfig-001-20240729   gcc-13.2.0
s390                  randconfig-002-20240729   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                               j2_defconfig   gcc-13.2.0
sh                    randconfig-001-20240729   gcc-13.2.0
sh                    randconfig-002-20240729   gcc-13.2.0
sh                          sdk7786_defconfig   gcc-13.2.0
sh                           se7206_defconfig   gcc-13.2.0
sparc64               randconfig-001-20240729   gcc-13.2.0
sparc64               randconfig-002-20240729   gcc-13.2.0
um                                allnoconfig   gcc-14.1.0
um                    randconfig-001-20240729   gcc-13.2.0
um                    randconfig-002-20240729   gcc-13.2.0
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
xtensa                randconfig-001-20240729   gcc-13.2.0
xtensa                randconfig-002-20240729   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

