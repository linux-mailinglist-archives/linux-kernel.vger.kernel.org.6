Return-Path: <linux-kernel+bounces-372877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DED749A4EAC
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 16:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CF10286A24
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 14:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E51219F3;
	Sat, 19 Oct 2024 14:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cxnnXIq2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4BE7462
	for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 14:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729348359; cv=none; b=Knz0hiqy/vwQdmccHo8PFbmdt1EVUk4TgHMzucehWdeNc3oXYbOMAeZpObCIn7YzKrD4YWiKQZfK9P3+4q6iFuEzYdot4xiDy8to2hPe2vRgQRYwGgLM+22K0UOaJPbivj4aCN5TDcZuzgjG0d35aNjct2ItV7sU0N18DO7vmzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729348359; c=relaxed/simple;
	bh=gtk3fqcWNTkkQqclt2vZRBCQjR6+H4NnqbdvAZST6/s=;
	h=Date:From:To:Cc:Subject:Message-ID; b=pbdXReZ+QMuMkJE/EDK/j4Rh48mD3XG8TMaOD0hNOhbkqKiidKSKLJiGzvaM7vNyCg6NnA8MM/GPvSxBw4UTbX8Tq0ys0QSqbYleXq8BQlJ07mEBc6jHEnf9Ts86M8xi0/RebJmjp6+e/SL0kJfwlUBOWdciSE7Ab+gavWNNOSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cxnnXIq2; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729348357; x=1760884357;
  h=date:from:to:cc:subject:message-id;
  bh=gtk3fqcWNTkkQqclt2vZRBCQjR6+H4NnqbdvAZST6/s=;
  b=cxnnXIq2hSPZhH5jyntQshvLbfDy7mvNdHx//hyK4cveKOXcpyGe6Mt4
   HQEyTe0q7+Lpbhk/wQiZAcutCDFNxqQdrYTSb7kc/R49for/PG7T+0YLk
   KWns/IjP4/8W8KTQ7G00fphA/QysNPoWAgA51Nso6L2wqjf2KwYyiwwj5
   1JBY7nxvijX4fNFT/7cVX+QPzaWDtNYrwbOMIOSksX7k7QnHIozTZU7HF
   imBto9ZJHRSzTkbV1CXAUj8jgWE7gZPSQM6YH2YC1wi0hms5OeJuzQo97
   nhC6AA0v40FIekVucn8/Q1CVUzG/rbFuckhBlMKka6s1hEpzCS+GE/5Lp
   w==;
X-CSE-ConnectionGUID: nYSH339iTE+Vb9zE5ALM3A==
X-CSE-MsgGUID: yJBgfpGxQBuNwCh+hFgCyg==
X-IronPort-AV: E=McAfee;i="6700,10204,11230"; a="46369210"
X-IronPort-AV: E=Sophos;i="6.11,216,1725346800"; 
   d="scan'208";a="46369210"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2024 07:32:36 -0700
X-CSE-ConnectionGUID: lOEtBvPTSjy8wPSDGUO1KQ==
X-CSE-MsgGUID: csL4x8pHSLeK6jMFs2UbEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,216,1725346800"; 
   d="scan'208";a="78778607"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 19 Oct 2024 07:32:35 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t2AVM-000P4T-2f;
	Sat, 19 Oct 2024 14:32:32 +0000
Date: Sat, 19 Oct 2024 22:31:56 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:sched/urgent] BUILD SUCCESS
 5ec36fe24bd2d529ba415b9eaed44a689ab543ed
Message-ID: <202410192249.EMcarpM0-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/urgent
branch HEAD: 5ec36fe24bd2d529ba415b9eaed44a689ab543ed  MAINTAINERS: Add an entry for PREEMPT_RT.

elapsed time: 2557m

configs tested: 167
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                   randconfig-001-20241019    clang-16
arc                   randconfig-002-20241019    clang-16
arc                        vdk_hs38_defconfig    clang-20
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                         nhk8815_defconfig    clang-20
arm                       omap2plus_defconfig    clang-20
arm                   randconfig-001-20241019    clang-16
arm                   randconfig-002-20241019    clang-16
arm                   randconfig-003-20241019    clang-16
arm                   randconfig-004-20241019    clang-16
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                 randconfig-001-20241019    clang-16
arm64                 randconfig-002-20241019    clang-16
arm64                 randconfig-003-20241019    clang-16
arm64                 randconfig-004-20241019    clang-16
csky                              allnoconfig    gcc-14.1.0
csky                  randconfig-001-20241019    clang-16
csky                  randconfig-002-20241019    clang-16
hexagon                          alldefconfig    clang-20
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon               randconfig-001-20241019    clang-16
hexagon               randconfig-002-20241019    clang-16
i386                             allmodconfig    clang-18
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-18
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-18
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241019    clang-18
i386        buildonly-randconfig-002-20241019    clang-18
i386        buildonly-randconfig-003-20241019    clang-18
i386        buildonly-randconfig-004-20241019    clang-18
i386        buildonly-randconfig-005-20241019    clang-18
i386        buildonly-randconfig-006-20241019    clang-18
i386                                defconfig    clang-18
i386                  randconfig-001-20241019    clang-18
i386                  randconfig-002-20241019    clang-18
i386                  randconfig-003-20241019    clang-18
i386                  randconfig-004-20241019    clang-18
i386                  randconfig-005-20241019    clang-18
i386                  randconfig-006-20241019    clang-18
i386                  randconfig-011-20241019    clang-18
i386                  randconfig-012-20241019    clang-18
i386                  randconfig-013-20241019    clang-18
i386                  randconfig-014-20241019    clang-18
i386                  randconfig-015-20241019    clang-18
i386                  randconfig-016-20241019    clang-18
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch             randconfig-001-20241019    clang-16
loongarch             randconfig-002-20241019    clang-16
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                        m5307c3_defconfig    clang-20
m68k                          sun3x_defconfig    clang-20
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                          eyeq5_defconfig    clang-20
mips                         rt305x_defconfig    clang-20
nios2                             allnoconfig    gcc-14.1.0
nios2                 randconfig-001-20241019    clang-16
nios2                 randconfig-002-20241019    clang-16
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc                generic-32bit_defconfig    clang-20
parisc                randconfig-001-20241019    clang-16
parisc                randconfig-002-20241019    clang-16
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.1.0
powerpc                   currituck_defconfig    clang-20
powerpc                       holly_defconfig    clang-20
powerpc                    mvme5100_defconfig    clang-20
powerpc               randconfig-001-20241019    clang-16
powerpc               randconfig-002-20241019    clang-16
powerpc               randconfig-003-20241019    clang-16
powerpc                     tqm8541_defconfig    clang-20
powerpc64             randconfig-001-20241019    clang-16
powerpc64             randconfig-002-20241019    clang-16
powerpc64             randconfig-003-20241019    clang-16
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20241019    clang-16
riscv                 randconfig-002-20241019    clang-16
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20241019    clang-16
s390                  randconfig-002-20241019    clang-16
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20241019    clang-16
sh                    randconfig-002-20241019    clang-16
sh                      rts7751r2d1_defconfig    clang-20
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20241019    clang-16
sparc64               randconfig-002-20241019    clang-16
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241019    clang-16
um                    randconfig-002-20241019    clang-16
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64      buildonly-randconfig-001-20241019    clang-18
x86_64      buildonly-randconfig-002-20241019    clang-18
x86_64      buildonly-randconfig-003-20241019    clang-18
x86_64      buildonly-randconfig-004-20241019    clang-18
x86_64      buildonly-randconfig-005-20241019    clang-18
x86_64      buildonly-randconfig-006-20241019    clang-18
x86_64                              defconfig    clang-18
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-18
x86_64                randconfig-001-20241019    clang-18
x86_64                randconfig-002-20241019    clang-18
x86_64                randconfig-003-20241019    clang-18
x86_64                randconfig-004-20241019    clang-18
x86_64                randconfig-005-20241019    clang-18
x86_64                randconfig-006-20241019    clang-18
x86_64                randconfig-011-20241019    clang-18
x86_64                randconfig-012-20241019    clang-18
x86_64                randconfig-013-20241019    clang-18
x86_64                randconfig-014-20241019    clang-18
x86_64                randconfig-015-20241019    clang-18
x86_64                randconfig-016-20241019    clang-18
x86_64                randconfig-071-20241019    clang-18
x86_64                randconfig-072-20241019    clang-18
x86_64                randconfig-073-20241019    clang-18
x86_64                randconfig-074-20241019    clang-18
x86_64                randconfig-075-20241019    clang-18
x86_64                randconfig-076-20241019    clang-18
x86_64                               rhel-8.3    gcc-12
x86_64                           rhel-8.3-bpf    clang-18
x86_64                         rhel-8.3-kunit    clang-18
x86_64                           rhel-8.3-ltp    clang-18
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0
xtensa                  cadence_csp_defconfig    clang-20
xtensa                randconfig-001-20241019    clang-16
xtensa                randconfig-002-20241019    clang-16

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

