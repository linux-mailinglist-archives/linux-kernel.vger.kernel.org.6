Return-Path: <linux-kernel+bounces-540790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7E2A4B4E0
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 22:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BE853AF1B4
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 21:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48AAA1E9B33;
	Sun,  2 Mar 2025 21:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aqjH3dOS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9413A1D6DDA
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 21:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740949640; cv=none; b=Ek7YBBXe9hLRAjIUt0BdsCLygbVz+vFTwBcKZ7G5sthU9sxza3abuDBG0ylyS7dsjPob/+frE9G5fCRymn4mCwNza8l2d3yqV6g6/jSMJO4RXpuNKLIYO/F1rSe6omE6otL4cx82VnAvJLOkEhjOpbOY0JaOTLsSp9Adrp33Wro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740949640; c=relaxed/simple;
	bh=eDO6PVjjb+ejLSwNF8zRnHSrcjtDrWSjChE+qGqYVhc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=PaajRCOj+NfbyDRDS8Dv3GyLFTLG4R66t664A1yHpGRhtNSiENQLSLzBO7qocekMP4AR8+A9fuMclGJQGc1Q9yAeoBojlYhaq4mTQ9CDSeBJR1ed+b/oDyROSmXsdOFjaqSCjmSEuOx3aEwJj2NhKjqZ2fjd6rnvM0fdlybYu0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aqjH3dOS; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740949639; x=1772485639;
  h=date:from:to:cc:subject:message-id;
  bh=eDO6PVjjb+ejLSwNF8zRnHSrcjtDrWSjChE+qGqYVhc=;
  b=aqjH3dOSR29kJrrnY8U5BDtKvxSxUjz8Md46KcUxqDK05hsum86DVDzI
   g5glYUdZWv6B2qFrUR95KpAfhVXLDz3dSdys52rOtG5m8N+XahC+v9hrQ
   7XUDlJOUmN6QogHfDQvvymT+ZGbpSeG3BxaZsqwj6ARbAXjrAiYWgvm8+
   gFYhw+hTYZt4MVSfv1ecY9J9pS27kJZbaXZdn+oNJ9oeOm3w5KNZTluk/
   PAxCUwAYcEFFW6p7wD3JL6c83yGVjFH+dOrN6dP9UKXZdGbsLx3Ahmpi6
   CJ7Aj+N/ftikr2YguxkTafP9OgQjo45k8wF2DZPpT5hDw8e44QBHoveuO
   A==;
X-CSE-ConnectionGUID: xzbxHRqcR6i/n2GVe5wxXQ==
X-CSE-MsgGUID: KjBBkjLdTj6DhiZ/Wmr/ig==
X-IronPort-AV: E=McAfee;i="6700,10204,11361"; a="41942569"
X-IronPort-AV: E=Sophos;i="6.13,328,1732608000"; 
   d="scan'208";a="41942569"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2025 13:07:15 -0800
X-CSE-ConnectionGUID: djOTJbS6Rly0Uw5fJuQ/xg==
X-CSE-MsgGUID: keZrfQCISluyfkP/LPdTlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,328,1732608000"; 
   d="scan'208";a="148632325"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 02 Mar 2025 13:07:14 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1toqWl-000HdI-0c;
	Sun, 02 Mar 2025 21:07:11 +0000
Date: Mon, 03 Mar 2025 05:06:51 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:locking/core] BUILD SUCCESS
 a1b65f3f7c6f7f0a08a7dba8be458c6415236487
Message-ID: <202503030543.i8jE9b1b-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
branch HEAD: a1b65f3f7c6f7f0a08a7dba8be458c6415236487  lockdep/mm: Fix might_fault() lockdep check of current->mm->mmap_lock

elapsed time: 1448m

configs tested: 114
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                 nsimosci_hs_smp_defconfig    gcc-13.2.0
arc                   randconfig-001-20250302    gcc-13.2.0
arc                   randconfig-002-20250302    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                     davinci_all_defconfig    clang-21
arm                          ep93xx_defconfig    clang-21
arm                        mvebu_v5_defconfig    gcc-14.2.0
arm                   randconfig-001-20250302    gcc-14.2.0
arm                   randconfig-002-20250302    clang-21
arm                   randconfig-003-20250302    gcc-14.2.0
arm                   randconfig-004-20250302    clang-21
arm                        shmobile_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250302    clang-18
arm64                 randconfig-002-20250302    gcc-14.2.0
arm64                 randconfig-003-20250302    gcc-14.2.0
arm64                 randconfig-004-20250302    clang-16
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250302    gcc-14.2.0
csky                  randconfig-002-20250302    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250302    clang-21
hexagon               randconfig-002-20250302    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250302    gcc-12
i386        buildonly-randconfig-002-20250302    clang-19
i386        buildonly-randconfig-003-20250302    gcc-12
i386        buildonly-randconfig-004-20250302    gcc-12
i386        buildonly-randconfig-005-20250302    gcc-12
i386        buildonly-randconfig-006-20250302    gcc-12
i386                                defconfig    clang-19
loongarch                        alldefconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250302    gcc-14.2.0
loongarch             randconfig-002-20250302    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          ath25_defconfig    clang-16
mips                   sb1250_swarm_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250302    gcc-14.2.0
nios2                 randconfig-002-20250302    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                randconfig-001-20250302    gcc-14.2.0
parisc                randconfig-002-20250302    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                       ebony_defconfig    clang-18
powerpc                    gamecube_defconfig    clang-16
powerpc               randconfig-001-20250302    gcc-14.2.0
powerpc               randconfig-002-20250302    gcc-14.2.0
powerpc               randconfig-003-20250302    clang-16
powerpc64             randconfig-001-20250302    gcc-14.2.0
powerpc64             randconfig-003-20250302    gcc-14.2.0
riscv                             allnoconfig    gcc-14.2.0
riscv                 randconfig-001-20250302    clang-21
riscv                 randconfig-002-20250302    clang-16
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250302    clang-17
s390                  randconfig-002-20250302    clang-19
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                     magicpanelr2_defconfig    gcc-14.2.0
sh                    randconfig-001-20250302    gcc-14.2.0
sh                    randconfig-002-20250302    gcc-14.2.0
sh                           se7721_defconfig    gcc-14.2.0
sh                             sh03_defconfig    gcc-14.2.0
sh                  sh7785lcr_32bit_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250302    gcc-14.2.0
sparc                 randconfig-002-20250302    gcc-14.2.0
sparc                       sparc32_defconfig    gcc-14.2.0
sparc64               randconfig-001-20250302    gcc-14.2.0
sparc64               randconfig-002-20250302    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                    randconfig-001-20250302    gcc-12
um                    randconfig-002-20250302    clang-16
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250302    clang-19
x86_64      buildonly-randconfig-002-20250302    clang-19
x86_64      buildonly-randconfig-003-20250302    gcc-12
x86_64      buildonly-randconfig-004-20250302    gcc-12
x86_64      buildonly-randconfig-005-20250302    gcc-12
x86_64      buildonly-randconfig-006-20250302    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250302    gcc-14.2.0
xtensa                randconfig-002-20250302    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

