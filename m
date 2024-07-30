Return-Path: <linux-kernel+bounces-266975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8926A940A9B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 10:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9A76B248C2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 08:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885351922FC;
	Tue, 30 Jul 2024 07:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Seis5nxX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D441922FF
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 07:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722326373; cv=none; b=GMwZOdkvtjk0GkZ1NVLJbafc0jKW9PBSdjLO/jgj+0AOGGW8AA7lK2te57f8nvbz8mkhfJasks+JFM9ZH/uMvNNEtco1a7LTu2TYJKXM7uXfUMq/EHJz/Wxj4GbjhND8Cy5kN31Yc/9WbbpF9GygYhA4NQKMSGaaJZo5uGld0cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722326373; c=relaxed/simple;
	bh=1e3HpDqaCZqII5aEQ9ZI/Fl8d92SiWhtcPwvYHqpx2Q=;
	h=Date:From:To:Cc:Subject:Message-ID; b=qeYTj87ofUoFSi9A+5O7D6FOJipKMdYZmHKBln0CZrgQcFqZeil0uVrmmTC85TySfxHz20jJWR2ZjVv4wrIQ5apHBLNJ9rLdzTm6By+wSYNai1jJh9KtqLWlWhbP+FgVfmh0Q9ZYxhb/DYlnPe7AdczzBG3hKAHxELEaMAdl6Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Seis5nxX; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722326372; x=1753862372;
  h=date:from:to:cc:subject:message-id;
  bh=1e3HpDqaCZqII5aEQ9ZI/Fl8d92SiWhtcPwvYHqpx2Q=;
  b=Seis5nxX7YHycRMBBTMurk8oRdaGZ+rWvvw7zZGhQJkACNkOMcdBwHHu
   x0nhTLuVWa8xFN4H7A6qBAJeABJGM3897A/YeZgZHp/FIXpqxiXujB4po
   0/COBGgfgTZlLXlK+Ov/LBvfvSokc4PZPoKBjUppsw/KeF3pB4vDTZeXq
   Shre2VsgtjaanAQdGryf6dS4QNnoPY/l6tljslVdVpKjeC7qC1reEWTpO
   Co0yGCUVue+/wIxIVQFT3c0shgCpTvEq6CRAYiNqUsn+faXjxv38flQ9D
   zgDyJn/uS4m2A7+66tTvMLzKFVrp3LD57Nm5yIUmK1jRPyesbc0lt4sY+
   A==;
X-CSE-ConnectionGUID: 7zsSS8HtSlGlYCqsRYjzsg==
X-CSE-MsgGUID: 0UM0KI71QuW6QLp3X1XViw==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="30789519"
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="30789519"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 00:59:31 -0700
X-CSE-ConnectionGUID: P1xljsFlSgyRSPNoYoJl+g==
X-CSE-MsgGUID: ydDE2bZBSGOxwATWNUIcww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="54503885"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 30 Jul 2024 00:59:29 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sYhlX-000sdu-0n;
	Tue, 30 Jul 2024 07:59:27 +0000
Date: Tue, 30 Jul 2024 15:58:53 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 0f7ced7d620ecc7a986843d6aeec41cce3116f41
Message-ID: <202407301550.islmSZtH-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 0f7ced7d620ecc7a986843d6aeec41cce3116f41  x86/aperfmperf: Fix deadlock on cpu_hotplug_lock

elapsed time: 1058m

configs tested: 195
configs skipped: 133

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                        nsimosci_defconfig   gcc-13.2.0
arc                   randconfig-001-20240730   gcc-13.2.0
arc                   randconfig-002-20240730   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                         bcm2835_defconfig   clang-20
arm                                 defconfig   gcc-13.2.0
arm                            hisi_defconfig   gcc-13.2.0
arm                        keystone_defconfig   clang-20
arm                        keystone_defconfig   gcc-13.2.0
arm                             pxa_defconfig   gcc-13.2.0
arm                   randconfig-001-20240730   gcc-13.2.0
arm                   randconfig-002-20240730   gcc-13.2.0
arm                   randconfig-003-20240730   gcc-13.2.0
arm                   randconfig-004-20240730   gcc-13.2.0
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240730   gcc-13.2.0
arm64                 randconfig-002-20240730   gcc-13.2.0
arm64                 randconfig-003-20240730   gcc-13.2.0
arm64                 randconfig-004-20240730   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240730   gcc-13.2.0
csky                  randconfig-002-20240730   gcc-13.2.0
i386                             allmodconfig   clang-18
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-13
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240730   gcc-13
i386         buildonly-randconfig-002-20240730   gcc-13
i386         buildonly-randconfig-003-20240730   clang-18
i386         buildonly-randconfig-003-20240730   gcc-13
i386         buildonly-randconfig-004-20240730   clang-18
i386         buildonly-randconfig-004-20240730   gcc-13
i386         buildonly-randconfig-005-20240730   gcc-13
i386         buildonly-randconfig-006-20240730   clang-18
i386         buildonly-randconfig-006-20240730   gcc-13
i386                                defconfig   clang-18
i386                  randconfig-001-20240730   gcc-13
i386                  randconfig-001-20240730   gcc-8
i386                  randconfig-002-20240730   gcc-13
i386                  randconfig-003-20240730   gcc-13
i386                  randconfig-004-20240730   gcc-13
i386                  randconfig-005-20240730   gcc-10
i386                  randconfig-005-20240730   gcc-13
i386                  randconfig-006-20240730   gcc-10
i386                  randconfig-006-20240730   gcc-13
i386                  randconfig-011-20240730   gcc-11
i386                  randconfig-011-20240730   gcc-13
i386                  randconfig-012-20240730   clang-18
i386                  randconfig-012-20240730   gcc-13
i386                  randconfig-013-20240730   clang-18
i386                  randconfig-013-20240730   gcc-13
i386                  randconfig-014-20240730   gcc-13
i386                  randconfig-014-20240730   gcc-9
i386                  randconfig-015-20240730   gcc-13
i386                  randconfig-015-20240730   gcc-9
i386                  randconfig-016-20240730   clang-18
i386                  randconfig-016-20240730   gcc-13
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240730   gcc-13.2.0
loongarch             randconfig-002-20240730   gcc-13.2.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                     cu1000-neo_defconfig   gcc-13.2.0
mips                           gcw0_defconfig   gcc-13.2.0
mips                            gpr_defconfig   gcc-13.2.0
mips                malta_qemu_32r6_defconfig   clang-20
mips                      maltaaprp_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240730   gcc-13.2.0
nios2                 randconfig-002-20240730   gcc-13.2.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                generic-64bit_defconfig   gcc-13.2.0
parisc                randconfig-001-20240730   gcc-13.2.0
parisc                randconfig-002-20240730   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   gcc-14.1.0
powerpc                 canyonlands_defconfig   clang-20
powerpc                 canyonlands_defconfig   gcc-13.2.0
powerpc                       ebony_defconfig   clang-20
powerpc                     ep8248e_defconfig   clang-20
powerpc                      pmac32_defconfig   clang-20
powerpc               randconfig-002-20240730   gcc-13.2.0
powerpc               randconfig-003-20240730   gcc-13.2.0
powerpc                    sam440ep_defconfig   gcc-13.2.0
powerpc                     taishan_defconfig   clang-20
powerpc                     tqm8555_defconfig   clang-20
powerpc                      tqm8xx_defconfig   clang-20
powerpc64             randconfig-001-20240730   gcc-13.2.0
powerpc64             randconfig-002-20240730   gcc-13.2.0
powerpc64             randconfig-003-20240730   gcc-13.2.0
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-14.1.0
riscv                 randconfig-001-20240730   gcc-13.2.0
riscv                 randconfig-002-20240730   gcc-13.2.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-20
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240730   gcc-13.2.0
s390                  randconfig-002-20240730   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                                  defconfig   gcc-14.1.0
sh                             espt_defconfig   gcc-13.2.0
sh                          polaris_defconfig   gcc-13.2.0
sh                          r7780mp_defconfig   gcc-13.2.0
sh                    randconfig-001-20240730   gcc-13.2.0
sh                    randconfig-002-20240730   gcc-13.2.0
sh                          rsk7269_defconfig   gcc-13.2.0
sh                           se7721_defconfig   gcc-13.2.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240730   gcc-13.2.0
sparc64               randconfig-002-20240730   gcc-13.2.0
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240730   gcc-13.2.0
um                    randconfig-002-20240730   gcc-13.2.0
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240730   clang-18
x86_64       buildonly-randconfig-002-20240730   clang-18
x86_64       buildonly-randconfig-002-20240730   gcc-12
x86_64       buildonly-randconfig-003-20240730   clang-18
x86_64       buildonly-randconfig-004-20240730   clang-18
x86_64       buildonly-randconfig-004-20240730   gcc-13
x86_64       buildonly-randconfig-005-20240730   clang-18
x86_64       buildonly-randconfig-005-20240730   gcc-12
x86_64       buildonly-randconfig-006-20240730   clang-18
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240730   clang-18
x86_64                randconfig-002-20240730   clang-18
x86_64                randconfig-002-20240730   gcc-13
x86_64                randconfig-003-20240730   clang-18
x86_64                randconfig-004-20240730   clang-18
x86_64                randconfig-005-20240730   clang-18
x86_64                randconfig-006-20240730   clang-18
x86_64                randconfig-011-20240730   clang-18
x86_64                randconfig-011-20240730   gcc-13
x86_64                randconfig-012-20240730   clang-18
x86_64                randconfig-013-20240730   clang-18
x86_64                randconfig-014-20240730   clang-18
x86_64                randconfig-015-20240730   clang-18
x86_64                randconfig-015-20240730   gcc-8
x86_64                randconfig-016-20240730   clang-18
x86_64                randconfig-016-20240730   gcc-13
x86_64                randconfig-071-20240730   clang-18
x86_64                randconfig-071-20240730   gcc-8
x86_64                randconfig-072-20240730   clang-18
x86_64                randconfig-073-20240730   clang-18
x86_64                randconfig-073-20240730   gcc-12
x86_64                randconfig-074-20240730   clang-18
x86_64                randconfig-075-20240730   clang-18
x86_64                randconfig-076-20240730   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                randconfig-001-20240730   gcc-13.2.0
xtensa                randconfig-002-20240730   gcc-13.2.0
xtensa                    smp_lx200_defconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

