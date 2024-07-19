Return-Path: <linux-kernel+bounces-257639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B79937CEB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 21:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A77A21C210C9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 19:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C7A148307;
	Fri, 19 Jul 2024 19:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iD37bt5k"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B94383AE
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 19:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721416906; cv=none; b=XWhc5zUoKDLkGB8fS7FbmmpnD1SSYncHhOih9VAclT0LQUvNDvxWN4Xg9QLEkhZ3oaIrtgxrORR50Zeji0TIWJfzWiwpntD0Hlw3JJjYtLwW1uNEmmPEBvQ7EMFQPcrmTKwYK54I5DRKf04aTaF+QGEp0z+s30atNx8sWJ6jDKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721416906; c=relaxed/simple;
	bh=fttys4UjUruzSp1S1pm1WtigWFC4MfU2cuFYKjdhqwo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=THElLDZK7U+IjE6R2fpbyq+u/0pxvvHoeDMpQL1R66fSj40A3WWsLo5IFW7Vzq/+RhrSCQZ/llEvQNZ5Uj/tvhpw+hbRVHvVxCFd92rbcgGeEL9uthRMel2o4EHEcClQ6uZ9IN6u212N8PPOMsEQpAZ5A0OTD5KMDsMBq5vvHSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iD37bt5k; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721416904; x=1752952904;
  h=date:from:to:cc:subject:message-id;
  bh=fttys4UjUruzSp1S1pm1WtigWFC4MfU2cuFYKjdhqwo=;
  b=iD37bt5kR26vfBQDCLkN1MNiCyUGJa+StXvJPY9XEoOyksaxLAikkYLp
   qhhBdMZRJ3gB2uIqZxNpeIFPW8DElgnB2ymPdpQZaAyMQUUWlAB+fuEMf
   7sstFDJhQfT+8RCyYS9Hcnu8ohWt5MAO3sSt8JvQHfPG8qYMRosEqwgz/
   tdug6GijQeS/6txUEVoXhiCGpsBM9UwV7GAFISwQoz6EnmyHlrdAzqyKr
   rCM0V5Tdr6k+RixuOnl0ME30LkrXG5odZkuCBEMM/CmeBEC+cdEweYWEv
   GLZ4LYcCNebx3Q5reT4Qa4bYurzM23HAVE2zRwWzT8Rt4dvQa0zovswBk
   Q==;
X-CSE-ConnectionGUID: EXN8DMcLTseArRV1zBZohA==
X-CSE-MsgGUID: rVGHohkqTjKdEhemlz6pQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11138"; a="30439368"
X-IronPort-AV: E=Sophos;i="6.09,221,1716274800"; 
   d="scan'208";a="30439368"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2024 12:21:44 -0700
X-CSE-ConnectionGUID: y1q5suyuRy6pc3663VyzNQ==
X-CSE-MsgGUID: sraYK3oAQgqRnnmeIjssLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,221,1716274800"; 
   d="scan'208";a="51841565"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 19 Jul 2024 12:21:42 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sUtAi-000iW8-00;
	Fri, 19 Jul 2024 19:21:40 +0000
Date: Sat, 20 Jul 2024 03:21:14 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:irq/msi] BUILD SUCCESS
 c9b4f313f6b83ac80e9d51845d092c32513efdb4
Message-ID: <202407200310.h3QFAbDP-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/msi
branch HEAD: c9b4f313f6b83ac80e9d51845d092c32513efdb4  irqchip/gic-v3-its: Correctly fish out the DID for platform MSI

elapsed time: 1448m

configs tested: 202
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
arc                              alldefconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                          axs101_defconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240719   gcc-13.2.0
arc                   randconfig-002-20240719   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                              allyesconfig   gcc-14.1.0
arm                                 defconfig   gcc-13.2.0
arm                   randconfig-001-20240719   gcc-13.2.0
arm                   randconfig-002-20240719   gcc-13.2.0
arm                   randconfig-003-20240719   gcc-13.2.0
arm                   randconfig-004-20240719   gcc-13.2.0
arm                         s3c6400_defconfig   gcc-13.2.0
arm64                            allmodconfig   clang-19
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240719   gcc-13.2.0
arm64                 randconfig-002-20240719   gcc-13.2.0
arm64                 randconfig-003-20240719   gcc-13.2.0
arm64                 randconfig-004-20240719   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240719   gcc-13.2.0
csky                  randconfig-002-20240719   gcc-13.2.0
hexagon                          allmodconfig   clang-19
hexagon                          allyesconfig   clang-19
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-13
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-13
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240719   clang-18
i386         buildonly-randconfig-002-20240719   clang-18
i386         buildonly-randconfig-003-20240719   clang-18
i386         buildonly-randconfig-003-20240719   gcc-10
i386         buildonly-randconfig-004-20240719   clang-18
i386         buildonly-randconfig-005-20240719   clang-18
i386         buildonly-randconfig-005-20240719   gcc-10
i386         buildonly-randconfig-006-20240719   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240719   clang-18
i386                  randconfig-002-20240719   clang-18
i386                  randconfig-003-20240719   clang-18
i386                  randconfig-004-20240719   clang-18
i386                  randconfig-004-20240719   gcc-13
i386                  randconfig-005-20240719   clang-18
i386                  randconfig-006-20240719   clang-18
i386                  randconfig-011-20240719   clang-18
i386                  randconfig-012-20240719   clang-18
i386                  randconfig-013-20240719   clang-18
i386                  randconfig-014-20240719   clang-18
i386                  randconfig-015-20240719   clang-18
i386                  randconfig-015-20240719   gcc-13
i386                  randconfig-016-20240719   clang-18
i386                  randconfig-016-20240719   gcc-13
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240719   gcc-13.2.0
loongarch             randconfig-002-20240719   gcc-13.2.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-14.1.0
m68k                         amcore_defconfig   gcc-13.2.0
m68k                                defconfig   gcc-13.2.0
m68k                          sun3x_defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                         bigsur_defconfig   gcc-13.2.0
mips                       bmips_be_defconfig   gcc-13.2.0
mips                      fuloong2e_defconfig   gcc-13.2.0
mips                           ip28_defconfig   gcc-13.2.0
mips                      maltaaprp_defconfig   gcc-13.2.0
mips                        maltaup_defconfig   gcc-13.2.0
mips                   sb1250_swarm_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240719   gcc-13.2.0
nios2                 randconfig-002-20240719   gcc-13.2.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                generic-32bit_defconfig   gcc-13.2.0
parisc                randconfig-001-20240719   gcc-13.2.0
parisc                randconfig-002-20240719   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-19
powerpc                          allyesconfig   gcc-14.1.0
powerpc                    amigaone_defconfig   gcc-13.2.0
powerpc                    gamecube_defconfig   gcc-13.2.0
powerpc                   lite5200b_defconfig   gcc-13.2.0
powerpc                 mpc837x_rdb_defconfig   gcc-13.2.0
powerpc                     powernv_defconfig   gcc-13.2.0
powerpc                      ppc64e_defconfig   gcc-13.2.0
powerpc               randconfig-001-20240719   gcc-13.2.0
powerpc               randconfig-002-20240719   gcc-13.2.0
powerpc               randconfig-003-20240719   gcc-13.2.0
powerpc64             randconfig-001-20240719   gcc-13.2.0
powerpc64             randconfig-002-20240719   gcc-13.2.0
powerpc64             randconfig-003-20240719   gcc-13.2.0
riscv                            allmodconfig   clang-19
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-19
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-14.1.0
riscv             nommu_k210_sdcard_defconfig   gcc-13.2.0
riscv                 randconfig-001-20240719   gcc-13.2.0
riscv                 randconfig-002-20240719   gcc-13.2.0
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-19
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240719   gcc-13.2.0
s390                  randconfig-002-20240719   gcc-13.2.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                ecovec24-romimage_defconfig   gcc-13.2.0
sh                     magicpanelr2_defconfig   gcc-13.2.0
sh                          r7785rp_defconfig   gcc-13.2.0
sh                    randconfig-001-20240719   gcc-13.2.0
sh                    randconfig-002-20240719   gcc-13.2.0
sh                           se7705_defconfig   gcc-13.2.0
sh                           se7712_defconfig   gcc-13.2.0
sh                        sh7763rdp_defconfig   gcc-13.2.0
sh                   sh7770_generic_defconfig   gcc-13.2.0
sh                             shx3_defconfig   gcc-13.2.0
sh                              ul2_defconfig   gcc-13.2.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240719   gcc-13.2.0
sparc64               randconfig-002-20240719   gcc-13.2.0
um                               allmodconfig   clang-19
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-13
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240719   gcc-13.2.0
um                    randconfig-002-20240719   gcc-13.2.0
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240719   gcc-13
x86_64       buildonly-randconfig-002-20240719   gcc-13
x86_64       buildonly-randconfig-003-20240719   gcc-13
x86_64       buildonly-randconfig-004-20240719   gcc-13
x86_64       buildonly-randconfig-005-20240719   gcc-13
x86_64       buildonly-randconfig-006-20240719   gcc-13
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-13
x86_64                                  kexec   clang-18
x86_64                randconfig-001-20240719   gcc-13
x86_64                randconfig-002-20240719   gcc-13
x86_64                randconfig-003-20240719   gcc-13
x86_64                randconfig-004-20240719   gcc-13
x86_64                randconfig-005-20240719   gcc-13
x86_64                randconfig-006-20240719   gcc-13
x86_64                randconfig-011-20240719   gcc-13
x86_64                randconfig-012-20240719   gcc-13
x86_64                randconfig-013-20240719   gcc-13
x86_64                randconfig-014-20240719   gcc-13
x86_64                randconfig-015-20240719   gcc-13
x86_64                randconfig-016-20240719   gcc-13
x86_64                randconfig-071-20240719   gcc-13
x86_64                randconfig-072-20240719   gcc-13
x86_64                randconfig-073-20240719   gcc-13
x86_64                randconfig-074-20240719   gcc-13
x86_64                randconfig-075-20240719   gcc-13
x86_64                randconfig-076-20240719   gcc-13
x86_64                          rhel-8.3-rust   clang-18
x86_64                               rhel-8.3   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                randconfig-001-20240719   gcc-13.2.0
xtensa                randconfig-002-20240719   gcc-13.2.0
xtensa                         virt_defconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

