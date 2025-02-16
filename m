Return-Path: <linux-kernel+bounces-516496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 470BCA3728F
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 09:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19BEB16C155
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 08:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8567B1519A3;
	Sun, 16 Feb 2025 08:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fG8FmbDl"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BCF63D
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 08:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739694283; cv=none; b=CVkr+HayVaJdBLBZ6iYSJaDTovZZ9FayCVC0UiK1rwnng1c+b/l4um+7tveac9wi+yROqqNoLE5mCYSI51TxrMDnQ4IijQdXPv4yimRaNyxn9acaG3QUz3vjUNuP0WPH6BCdke7Mq6hiD/q5zxaRDtQ2xCySbCdxrzJkMno90uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739694283; c=relaxed/simple;
	bh=HRJkmeFsKLLjp5vHGAsq2S0FduBQS1/ec73P8XGpKws=;
	h=Date:From:To:Cc:Subject:Message-ID; b=n2tBW6Yi/OYrO2mwg/36bbRa28v+b9FC0OAoDD/yNFk6/ELu7uRyBwC2SmbvI3aev91KZNUtLvbo1jU9cNphuIGlIWs+RLF/sS7sOPioLOO3jj8KYBcR8Ocn9CO9bwtFg3XeHmEJ7caJE0SPs5hsAmOxdGhgiAI9WaCDD7RrEYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fG8FmbDl; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739694281; x=1771230281;
  h=date:from:to:cc:subject:message-id;
  bh=HRJkmeFsKLLjp5vHGAsq2S0FduBQS1/ec73P8XGpKws=;
  b=fG8FmbDlgkiRMjLbgBGh1sy+OBF4KZUNIfurkMYKUewbCk5+xyqhk/wL
   mBsI9SgUhD52WT3DyMDh/jC1U7buKaI0bxqZxFtRo44Ozc7hWdBEUmkGJ
   rbEZEElqJmWsFQdXorMNZtyyJE7+u+YC6ljs5dZ+e0QpOXJQp8xQpdrgP
   xLTeBpXU2P3uxmrqmJTgqBXUpt+Yrwv3/Hx/k3Ne/SK0LN6NUJ7zWkMe9
   H2PQeQWZ4OfC6eGbZ1voKK8iA9vuzOwuhtfdQKjQP1qeDyeVNYL41/Dqd
   dB6/XKJASoFfOOPHr8dU4zwA+1mSAo9sbxeggTikOr6jEq2hU1kdWZ7NQ
   Q==;
X-CSE-ConnectionGUID: pGaAGVQoSTKmoKMKDbjokA==
X-CSE-MsgGUID: NgwD1S4eRtK2TR7N/XeTDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="51821794"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="51821794"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 00:24:41 -0800
X-CSE-ConnectionGUID: l5NO0TDyTHiMXwKzVV5f0Q==
X-CSE-MsgGUID: SFH6IyxETQiDrBC6A7mKSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,290,1732608000"; 
   d="scan'208";a="118860100"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 16 Feb 2025 00:24:39 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tjZx7-001Bhv-0j;
	Sun, 16 Feb 2025 08:24:37 +0000
Date: Sun, 16 Feb 2025 16:23:37 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:perf/core] BUILD SUCCESS
 1623ced247f7cb1b48a27cca6b0f17fe5ab5942b
Message-ID: <202502161628.SS7KZh52-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core
branch HEAD: 1623ced247f7cb1b48a27cca6b0f17fe5ab5942b  x86/events/amd/iommu: Increase IOMMU_NAME_SIZE

elapsed time: 1265m

configs tested: 190
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-18
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    clang-18
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-13.2.0
arc                   randconfig-001-20250215    gcc-13.2.0
arc                   randconfig-002-20250215    gcc-13.2.0
arm                              allmodconfig    clang-18
arm                               allnoconfig    clang-17
arm                              allyesconfig    clang-18
arm                              allyesconfig    gcc-14.2.0
arm                                 defconfig    clang-21
arm                           imxrt_defconfig    clang-19
arm                          pxa168_defconfig    clang-16
arm                   randconfig-001-20250215    clang-15
arm                   randconfig-002-20250215    clang-17
arm                   randconfig-003-20250215    gcc-14.2.0
arm                   randconfig-004-20250215    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250215    clang-21
arm64                 randconfig-002-20250215    gcc-14.2.0
arm64                 randconfig-003-20250215    clang-17
arm64                 randconfig-004-20250215    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250215    gcc-14.2.0
csky                  randconfig-002-20250215    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon                             defconfig    clang-21
hexagon               randconfig-001-20250215    clang-21
hexagon               randconfig-002-20250215    clang-21
i386                             allmodconfig    clang-19
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-19
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-19
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250215    gcc-12
i386        buildonly-randconfig-002-20250215    clang-19
i386        buildonly-randconfig-003-20250215    clang-19
i386        buildonly-randconfig-004-20250215    gcc-12
i386        buildonly-randconfig-005-20250215    clang-19
i386        buildonly-randconfig-006-20250215    clang-19
i386                                defconfig    clang-19
i386                  randconfig-001-20250216    gcc-12
i386                  randconfig-002-20250216    gcc-12
i386                  randconfig-003-20250216    gcc-12
i386                  randconfig-004-20250216    gcc-12
i386                  randconfig-005-20250216    gcc-12
i386                  randconfig-006-20250216    gcc-12
i386                  randconfig-007-20250216    gcc-12
i386                  randconfig-011-20250216    gcc-12
i386                  randconfig-012-20250216    gcc-12
i386                  randconfig-013-20250216    gcc-12
i386                  randconfig-014-20250216    gcc-12
i386                  randconfig-015-20250216    gcc-12
i386                  randconfig-016-20250216    gcc-12
i386                  randconfig-017-20250216    gcc-12
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250215    gcc-14.2.0
loongarch             randconfig-002-20250215    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250215    gcc-14.2.0
nios2                 randconfig-002-20250215    gcc-14.2.0
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250215    gcc-14.2.0
parisc                randconfig-002-20250215    gcc-14.2.0
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                      arches_defconfig    gcc-14.2.0
powerpc                     rainier_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250215    gcc-14.2.0
powerpc               randconfig-002-20250215    clang-21
powerpc               randconfig-003-20250215    clang-19
powerpc64             randconfig-001-20250215    gcc-14.2.0
powerpc64             randconfig-002-20250215    clang-21
powerpc64             randconfig-003-20250215    gcc-14.2.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-21
riscv                               defconfig    clang-19
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250215    clang-17
riscv                 randconfig-002-20250215    clang-19
s390                             allmodconfig    clang-19
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                                defconfig    gcc-12
s390                  randconfig-001-20250215    gcc-14.2.0
s390                  randconfig-002-20250215    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                                  defconfig    gcc-14.2.0
sh                     magicpanelr2_defconfig    gcc-14.2.0
sh                          r7780mp_defconfig    gcc-14.2.0
sh                    randconfig-001-20250215    gcc-14.2.0
sh                    randconfig-002-20250215    gcc-14.2.0
sh                           se7705_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250215    gcc-14.2.0
sparc                 randconfig-002-20250215    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250215    gcc-14.2.0
sparc64               randconfig-002-20250215    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250215    clang-21
um                    randconfig-002-20250215    clang-19
um                           x86_64_defconfig    clang-15
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250215    gcc-12
x86_64      buildonly-randconfig-002-20250215    clang-19
x86_64      buildonly-randconfig-003-20250215    gcc-12
x86_64      buildonly-randconfig-004-20250215    clang-19
x86_64      buildonly-randconfig-005-20250215    clang-19
x86_64      buildonly-randconfig-006-20250215    clang-19
x86_64                              defconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20250216    clang-19
x86_64                randconfig-002-20250216    clang-19
x86_64                randconfig-003-20250216    clang-19
x86_64                randconfig-004-20250216    clang-19
x86_64                randconfig-005-20250216    clang-19
x86_64                randconfig-006-20250216    clang-19
x86_64                randconfig-007-20250216    clang-19
x86_64                randconfig-008-20250216    clang-19
x86_64                randconfig-071-20250216    gcc-12
x86_64                randconfig-072-20250216    gcc-12
x86_64                randconfig-073-20250216    gcc-12
x86_64                randconfig-074-20250216    gcc-12
x86_64                randconfig-075-20250216    gcc-12
x86_64                randconfig-076-20250216    gcc-12
x86_64                randconfig-077-20250216    gcc-12
x86_64                randconfig-078-20250216    gcc-12
x86_64                               rhel-9.4    clang-19
x86_64                           rhel-9.4-bpf    clang-19
x86_64                         rhel-9.4-kunit    clang-19
x86_64                           rhel-9.4-ltp    clang-19
x86_64                          rhel-9.4-rust    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250215    gcc-14.2.0
xtensa                randconfig-002-20250215    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

