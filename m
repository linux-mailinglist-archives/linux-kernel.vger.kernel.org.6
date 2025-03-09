Return-Path: <linux-kernel+bounces-553352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A605A587F4
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 20:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E24F188D8A8
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 19:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787EE217F42;
	Sun,  9 Mar 2025 19:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xl0aQjuw"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8542216E1D
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 19:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741549797; cv=none; b=EOLsckLApv7USG8QgX8AdKMB48XqtworIH2KtHHfrn9pviGzvqew/FT0CiGNtgL+aLF0zV3gUWyFolyQ5viNOXoz+YVPEUIT7e/XXrwJdlZtLjLJXls3mkioFODYEnykxH7/SmMBcIXnwdBjY7cMyN8WGvq5waeS7igjP94Bc4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741549797; c=relaxed/simple;
	bh=gj6AGtX1q2p8VAzzwOecfBd720acqQekxkWiB32r8Kc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=G4pnPzs7xenb327+1/ayk1s1yy+GhbtXvXTmTd3qd2UgnFjlktVT5lJ6t4Kn0sQTMQn29pxxeU1vCw795h25vhmXoIu5lxRQGg42bFdUm06IIZZFH8t7T8DuHKhRdmJBC2tAtcoZcrPRaOVohju0+9ntJJLmCUZJsFr+6BQtMWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xl0aQjuw; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741549796; x=1773085796;
  h=date:from:to:cc:subject:message-id;
  bh=gj6AGtX1q2p8VAzzwOecfBd720acqQekxkWiB32r8Kc=;
  b=Xl0aQjuw3JrjxkhAyttmvHq4rrRz6RaCKoT6kRu32GcK/CfSjv1yh3j0
   D05lDn+isngEGYpyavjSRuS1v5E7GT58gnjUgyN+kg7xBfUSlqFOr478J
   vpqNA2/J1La/QTIw+whMW1BpO4NJyM2qEHwlyp65vTgEExx9S883Ffwgh
   Bd/L/xx7rdq4hR4ViFg/A31eUfLIufNfXugVzsfyGeIt8skMvCmaB1Qh7
   93wfFrJj+4zBjjb3lDmyExgO/z9BGp4Kt49HNKFIgiULZvHx8uP4vPzsn
   YGWQHlGm2e7CZduzs4q4CQCa9dhcgPWu5NHubZ+9wzPdddJHq3z0RpjsJ
   w==;
X-CSE-ConnectionGUID: CfcwRNKjR7Wxl1gvbQhjhA==
X-CSE-MsgGUID: YZgcRNcNRqC5HswU2T286g==
X-IronPort-AV: E=McAfee;i="6700,10204,11368"; a="53920761"
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="53920761"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2025 12:49:55 -0700
X-CSE-ConnectionGUID: Ni/oajv8Qhu/wzapW2+Rjg==
X-CSE-MsgGUID: vFx4lWfKSdKvxiK0AAfC6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="120521652"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 09 Mar 2025 12:49:54 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1trMem-0003Q4-0G;
	Sun, 09 Mar 2025 19:49:52 +0000
Date: Mon, 10 Mar 2025 03:49:25 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 058a6bec37c6c3b826158f6d26b75de43816a880
Message-ID: <202503100319.sbHm0PIc-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 058a6bec37c6c3b826158f6d26b75de43816a880  x86/microcode/AMD: Add some forgotten models to the SHA check

elapsed time: 1448m

configs tested: 125
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                     haps_hs_smp_defconfig    gcc-13.2.0
arc                   randconfig-001-20250309    gcc-13.2.0
arc                   randconfig-002-20250309    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                   randconfig-001-20250309    clang-21
arm                   randconfig-002-20250309    gcc-14.2.0
arm                   randconfig-003-20250309    clang-21
arm                   randconfig-004-20250309    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250309    clang-15
arm64                 randconfig-002-20250309    clang-17
arm64                 randconfig-003-20250309    clang-15
arm64                 randconfig-004-20250309    gcc-14.2.0
csky                             alldefconfig    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250309    gcc-14.2.0
csky                  randconfig-002-20250309    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250309    clang-21
hexagon               randconfig-002-20250309    clang-21
i386                             alldefconfig    gcc-12
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250309    clang-19
i386        buildonly-randconfig-002-20250309    clang-19
i386        buildonly-randconfig-003-20250309    gcc-11
i386        buildonly-randconfig-004-20250309    gcc-12
i386        buildonly-randconfig-005-20250309    clang-19
i386        buildonly-randconfig-006-20250309    clang-19
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250309    gcc-14.2.0
loongarch             randconfig-002-20250309    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                       m5208evb_defconfig    gcc-14.2.0
m68k                        mvme16x_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                      bmips_stb_defconfig    clang-18
mips                         db1xxx_defconfig    clang-21
mips                           gcw0_defconfig    clang-15
mips                           ip30_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250309    gcc-14.2.0
nios2                 randconfig-002-20250309    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250309    gcc-14.2.0
parisc                randconfig-002-20250309    gcc-14.2.0
powerpc                     akebono_defconfig    clang-21
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                      ppc6xx_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250309    gcc-14.2.0
powerpc               randconfig-002-20250309    clang-21
powerpc               randconfig-003-20250309    clang-21
powerpc                        warp_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250309    clang-15
powerpc64             randconfig-002-20250309    gcc-14.2.0
riscv                             allnoconfig    gcc-14.2.0
riscv                               defconfig    clang-19
riscv                    nommu_k210_defconfig    clang-15
riscv                 randconfig-001-20250309    clang-15
riscv                 randconfig-002-20250309    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20250309    clang-16
s390                  randconfig-002-20250309    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                 kfr2r09-romimage_defconfig    gcc-14.2.0
sh                    randconfig-001-20250309    gcc-14.2.0
sh                    randconfig-002-20250309    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250309    gcc-14.2.0
sparc                 randconfig-002-20250309    gcc-14.2.0
sparc                       sparc32_defconfig    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250309    gcc-14.2.0
sparc64               randconfig-002-20250309    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250309    clang-21
um                    randconfig-002-20250309    clang-21
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250309    gcc-12
x86_64      buildonly-randconfig-002-20250309    gcc-11
x86_64      buildonly-randconfig-003-20250309    gcc-12
x86_64      buildonly-randconfig-004-20250309    gcc-12
x86_64      buildonly-randconfig-005-20250309    clang-19
x86_64      buildonly-randconfig-006-20250309    clang-19
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250309    gcc-14.2.0
xtensa                randconfig-002-20250309    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

