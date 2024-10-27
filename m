Return-Path: <linux-kernel+bounces-383873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29EE49B212F
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 23:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 877452813BE
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 22:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA12918871A;
	Sun, 27 Oct 2024 22:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l03RJJ5M"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FCD13C809
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 22:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730069943; cv=none; b=nYD3t8ymEk3emzN7Askpj5C2cT3fLnPH9/zWte5CQMMUVFvxjNJuLrM9O7ugx/1P4sRPQHMZ/3wwUikjIqSfkC1shwEO051xZaNf1eDDw9FoZSjIH1T44uZdTuMVNWRlmCs+YZQaZs9R9r2/tfVLfYZYgfKp4vYWibeKCukjWtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730069943; c=relaxed/simple;
	bh=s3QmnkYHUAXqUuf++6q1OPOHFyfS+4LKMxN0lP6uxWw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=iqaoAfyYnyFeBTQJupS5oEJcutMtMnIXhIZC8ZSYoXANvZ5lHUVKDaC+yId/J+mlgUoGL7Vh5hfHlvu73KBlzpo5/HZFoas2sC5UF7Z7njTKaD0ZGzbyqUpvuHbIllFWw7T+pkZyqpAcR8U00EQhaUYAFFWaG0M/AbuKm1LAAf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l03RJJ5M; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730069940; x=1761605940;
  h=date:from:to:cc:subject:message-id;
  bh=s3QmnkYHUAXqUuf++6q1OPOHFyfS+4LKMxN0lP6uxWw=;
  b=l03RJJ5Mw0OnYIg+Ma6lfwyLdbF1KNCu5A+ynBV8us23K4P67gzui7Zb
   kSumI/TXp0bT9WVPu3056WI8bALnBqK4AYOQv/E4PRSCqj7x7G/3zRY16
   jGus8KJMTkMRmmlyA657dS4zxFAI57y3lE/ReKShY2iBQEKHLl/8Vg1J/
   zqQrbBjqBFYgBds8GcjADwIzfeLC0JFUt9x3XUSS3UugTqLrmcgXUgs7s
   uM9kfRROxYLmtTRRTQ3vAej6ePQfJ0MZaL1MaIjeVZBE9KBSOpAABp5x4
   Agyk3Ky0WPQMgIGH3M6JJjDdqcqPrzkMpesoHei2M08MkpkTsjIENstCj
   w==;
X-CSE-ConnectionGUID: L7B9/okbRnaKea4m3O+nQw==
X-CSE-MsgGUID: f4+0LPHWTJi0mm8Qk8VYRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11238"; a="17297261"
X-IronPort-AV: E=Sophos;i="6.11,237,1725346800"; 
   d="scan'208";a="17297261"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2024 15:58:58 -0700
X-CSE-ConnectionGUID: JFqoXUeBTBK6kC/Pit4ooA==
X-CSE-MsgGUID: ADTMcwb8TruySX0ku9sr0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,237,1725346800"; 
   d="scan'208";a="82258925"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 27 Oct 2024 15:58:56 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t5CDm-000b3k-0r;
	Sun, 27 Oct 2024 22:58:54 +0000
Date: Mon, 28 Oct 2024 06:58:30 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:irq/core] BUILD SUCCESS
 d1a128bc3057a090b97ab5a9f938874df3d3f124
Message-ID: <202410280617.UOMoGPMU-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
branch HEAD: d1a128bc3057a090b97ab5a9f938874df3d3f124  genirq/irqdesc: Use str_enabled_disabled() helper in wakeup_show()

elapsed time: 723m

configs tested: 163
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-13.3.0
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                            allyesconfig    gcc-13.3.0
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-14.1.0
arc                            hsdk_defconfig    clang-20
arm                              allmodconfig    clang-20
arm                              allmodconfig    gcc-14.1.0
arm                               allnoconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                              allyesconfig    gcc-14.1.0
arm                        clps711x_defconfig    clang-20
arm                                 defconfig    gcc-14.1.0
arm                      integrator_defconfig    clang-20
arm                        mvebu_v7_defconfig    clang-20
arm                         nhk8815_defconfig    clang-20
arm                           sama7_defconfig    clang-20
arm                           sunxi_defconfig    clang-20
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
i386                             allmodconfig    clang-19
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-19
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-19
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241027    gcc-12
i386        buildonly-randconfig-002-20241027    gcc-12
i386        buildonly-randconfig-003-20241027    clang-19
i386        buildonly-randconfig-003-20241027    gcc-12
i386        buildonly-randconfig-004-20241027    gcc-12
i386        buildonly-randconfig-005-20241027    clang-19
i386        buildonly-randconfig-005-20241027    gcc-12
i386        buildonly-randconfig-006-20241027    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20241027    gcc-12
i386                  randconfig-002-20241027    clang-19
i386                  randconfig-002-20241027    gcc-12
i386                  randconfig-003-20241027    gcc-12
i386                  randconfig-004-20241027    gcc-12
i386                  randconfig-005-20241027    gcc-12
i386                  randconfig-006-20241027    gcc-12
i386                  randconfig-011-20241027    clang-19
i386                  randconfig-011-20241027    gcc-12
i386                  randconfig-012-20241027    clang-19
i386                  randconfig-012-20241027    gcc-12
i386                  randconfig-013-20241027    clang-19
i386                  randconfig-013-20241027    gcc-12
i386                  randconfig-014-20241027    gcc-12
i386                  randconfig-015-20241027    clang-19
i386                  randconfig-015-20241027    gcc-12
i386                  randconfig-016-20241027    clang-19
i386                  randconfig-016-20241027    gcc-12
loongarch                        alldefconfig    clang-20
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
openrisc                          allnoconfig    gcc-14.1.0
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
openrisc                       virt_defconfig    clang-20
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    gcc-14.1.0
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    gcc-14.1.0
powerpc                          allyesconfig    clang-20
powerpc                          allyesconfig    gcc-14.1.0
powerpc                      arches_defconfig    clang-20
powerpc                      ep88xc_defconfig    clang-20
powerpc                       maple_defconfig    clang-20
powerpc                      pasemi_defconfig    clang-20
riscv                            allmodconfig    clang-20
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    gcc-14.1.0
riscv                            allyesconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
s390                             allmodconfig    clang-20
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                          r7780mp_defconfig    clang-20
sh                           se7722_defconfig    clang-20
sparc                            allmodconfig    gcc-14.1.0
sparc                       sparc64_defconfig    clang-20
sparc64                             defconfig    gcc-12
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                               allyesconfig    clang-20
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241027    gcc-12
x86_64      buildonly-randconfig-002-20241027    gcc-12
x86_64      buildonly-randconfig-003-20241027    gcc-12
x86_64      buildonly-randconfig-004-20241027    gcc-12
x86_64      buildonly-randconfig-005-20241027    gcc-12
x86_64      buildonly-randconfig-006-20241027    gcc-12
x86_64                              defconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20241027    gcc-12
x86_64                randconfig-002-20241027    gcc-12
x86_64                randconfig-003-20241027    gcc-12
x86_64                randconfig-004-20241027    gcc-12
x86_64                randconfig-005-20241027    gcc-12
x86_64                randconfig-006-20241027    gcc-12
x86_64                randconfig-011-20241027    gcc-12
x86_64                randconfig-012-20241027    gcc-12
x86_64                randconfig-013-20241027    gcc-12
x86_64                randconfig-014-20241027    gcc-12
x86_64                randconfig-015-20241027    gcc-12
x86_64                randconfig-016-20241027    gcc-12
x86_64                randconfig-071-20241027    gcc-12
x86_64                randconfig-072-20241027    gcc-12
x86_64                randconfig-073-20241027    gcc-12
x86_64                randconfig-074-20241027    gcc-12
x86_64                randconfig-075-20241027    gcc-12
x86_64                randconfig-076-20241027    gcc-12
x86_64                               rhel-8.3    gcc-12
x86_64                           rhel-8.3-bpf    clang-19
x86_64                         rhel-8.3-kunit    clang-19
x86_64                           rhel-8.3-ltp    clang-19
x86_64                          rhel-8.3-rust    clang-19
xtensa                            allnoconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

