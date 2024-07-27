Return-Path: <linux-kernel+bounces-263973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FDFF93DD62
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 07:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27FF91C22BAF
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 05:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BD51864C;
	Sat, 27 Jul 2024 05:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a0dQ702b"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2460A14290
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 05:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722057079; cv=none; b=EFV/0B23Lq4cdY1mErDGAohoS8Mvx0+S6CxNGpVfhWxyZuRmavYX5cT8YJ3myijWOJetg/UeauQmZiZ1oL1rpBDfBvpTr8lyW59mzPWBqcUk4+uds/EmXPZJ6Av6XSAb0SbkHBMLh37ngKer1dJkLyS9LXW0A0tR12zAjP2UPP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722057079; c=relaxed/simple;
	bh=lQavUVb6oApSBOa8GJv8ygh5OV731TuZ6t2V0aUTZe4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Fruv3pfj48FErwMR7dWa6HNjdZOIgHEcsQPbXyIZ+06hIcuxtuhIpL7R1c7KycfuiUxkYjq4ru0EWCnAySwvFFGDKNdaFa6PsOjrr0d4Gt0SglhXCCVTVfCN+3WalDrOKtRlAROG4ZhY3TmY1cXzHzqvdW9cPIShUDAUa62joFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a0dQ702b; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722057078; x=1753593078;
  h=date:from:to:cc:subject:message-id;
  bh=lQavUVb6oApSBOa8GJv8ygh5OV731TuZ6t2V0aUTZe4=;
  b=a0dQ702bgx8+WvSIbURUDvFXb9Nji4gMGmr7G/KL9kaMKxbg99DjzYV5
   dnG6FSh+lhSqqfSt0yADNGjpfGbOjYoQTTQN7QyYqdtrAxyl/fDe9EMmP
   qetlcNSwV8S7VJFW5/pnNYMeVxM9BF9HA6F/MV1JRHaTLBT7nlc52LS1H
   vxnS6x/a68+siNbAiARJ9xnT8rCFh4LgVn34q7/fLfxxHnQDqW00iDms6
   j3P+kBOWOyQ5SZbmrEk+3tzuDk1CXXXC8T4slzDzwef5QP2YU55SPaL0k
   mOe+dN8g4Gp7hn7y8Kg7aiKqKQLImuyLb1+5ImNm1flTFqZHqpg66jD7C
   Q==;
X-CSE-ConnectionGUID: 0k6tnOVqSRGpTOSDKyIusw==
X-CSE-MsgGUID: nQZPQu+/R3ikVKsPIE9iyw==
X-IronPort-AV: E=McAfee;i="6700,10204,11145"; a="19822009"
X-IronPort-AV: E=Sophos;i="6.09,240,1716274800"; 
   d="scan'208";a="19822009"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2024 22:11:17 -0700
X-CSE-ConnectionGUID: BWJjC7NMRverGFSW7Wv1QQ==
X-CSE-MsgGUID: D4qFXFxOQgC3v+DWcanygA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,240,1716274800"; 
   d="scan'208";a="54056987"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 26 Jul 2024 22:11:16 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sXZi5-000pdw-0L;
	Sat, 27 Jul 2024 05:11:13 +0000
Date: Sat, 27 Jul 2024 13:10:41 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 a31e0e3804d8e18eaadbde47a46ffe0763d8b2d5
Message-ID: <202407271338.JK0ohdao-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: a31e0e3804d8e18eaadbde47a46ffe0763d8b2d5  Merge branch into tip/master: 'x86/mm'

elapsed time: 1239m

configs tested: 229
configs skipped: 7

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
arm                              allmodconfig   gcc-13.2.0
arm                               allnoconfig   clang-20
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                              allyesconfig   gcc-14.1.0
arm                                 defconfig   gcc-13.2.0
arm                          gemini_defconfig   clang-20
arm                        keystone_defconfig   clang-20
arm                            mmp2_defconfig   gcc-13.2.0
arm                          pxa168_defconfig   clang-20
arm                          pxa910_defconfig   gcc-13.2.0
arm                         s3c6400_defconfig   clang-20
arm                        vexpress_defconfig   gcc-13.2.0
arm64                            allmodconfig   clang-20
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-13.2.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   clang-20
hexagon                          allyesconfig   clang-20
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-13
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-13
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240726   gcc-13
i386         buildonly-randconfig-001-20240727   gcc-13
i386         buildonly-randconfig-002-20240726   clang-18
i386         buildonly-randconfig-002-20240726   gcc-13
i386         buildonly-randconfig-002-20240727   gcc-13
i386         buildonly-randconfig-003-20240726   gcc-13
i386         buildonly-randconfig-003-20240727   gcc-13
i386         buildonly-randconfig-004-20240726   clang-18
i386         buildonly-randconfig-004-20240726   gcc-13
i386         buildonly-randconfig-004-20240727   gcc-13
i386         buildonly-randconfig-005-20240726   gcc-13
i386         buildonly-randconfig-005-20240726   gcc-7
i386         buildonly-randconfig-005-20240727   gcc-13
i386         buildonly-randconfig-006-20240726   clang-18
i386         buildonly-randconfig-006-20240726   gcc-13
i386         buildonly-randconfig-006-20240727   gcc-13
i386                                defconfig   clang-18
i386                  randconfig-001-20240726   gcc-13
i386                  randconfig-001-20240727   gcc-13
i386                  randconfig-002-20240726   gcc-13
i386                  randconfig-002-20240727   gcc-13
i386                  randconfig-003-20240726   clang-18
i386                  randconfig-003-20240726   gcc-13
i386                  randconfig-003-20240727   gcc-13
i386                  randconfig-004-20240726   gcc-13
i386                  randconfig-004-20240727   gcc-13
i386                  randconfig-005-20240726   clang-18
i386                  randconfig-005-20240726   gcc-13
i386                  randconfig-005-20240727   gcc-13
i386                  randconfig-006-20240726   clang-18
i386                  randconfig-006-20240726   gcc-13
i386                  randconfig-006-20240727   gcc-13
i386                  randconfig-011-20240726   gcc-13
i386                  randconfig-011-20240727   gcc-13
i386                  randconfig-012-20240726   gcc-13
i386                  randconfig-012-20240726   gcc-8
i386                  randconfig-012-20240727   gcc-13
i386                  randconfig-013-20240726   gcc-10
i386                  randconfig-013-20240726   gcc-13
i386                  randconfig-013-20240727   gcc-13
i386                  randconfig-014-20240726   gcc-13
i386                  randconfig-014-20240727   gcc-13
i386                  randconfig-015-20240726   clang-18
i386                  randconfig-015-20240726   gcc-13
i386                  randconfig-015-20240727   gcc-13
i386                  randconfig-016-20240726   gcc-13
i386                  randconfig-016-20240727   gcc-13
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-13.2.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
m68k                       m5475evb_defconfig   gcc-14.1.0
m68k                            q40_defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-14.1.0
mips                          ath79_defconfig   gcc-14.1.0
mips                         bigsur_defconfig   gcc-14.1.0
mips                       bmips_be_defconfig   gcc-13.2.0
mips                           ci20_defconfig   gcc-13.2.0
mips                          eyeq5_defconfig   clang-20
mips                           ip28_defconfig   gcc-13.2.0
mips                     loongson1c_defconfig   gcc-13.2.0
mips                           xway_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-13.2.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-20
powerpc                          allyesconfig   gcc-14.1.0
powerpc                      bamboo_defconfig   clang-20
powerpc                       ebony_defconfig   clang-20
powerpc                       ebony_defconfig   gcc-13.2.0
powerpc                    ge_imp3a_defconfig   gcc-14.1.0
powerpc                       holly_defconfig   gcc-14.1.0
powerpc                        icon_defconfig   gcc-13.2.0
powerpc                     mpc5200_defconfig   gcc-14.1.0
powerpc                 mpc832x_rdb_defconfig   clang-20
powerpc                  mpc866_ads_defconfig   gcc-13.2.0
powerpc                  mpc885_ads_defconfig   clang-20
powerpc                  mpc885_ads_defconfig   gcc-14.1.0
powerpc                         ps3_defconfig   gcc-14.1.0
powerpc                    sam440ep_defconfig   gcc-14.1.0
riscv                            allmodconfig   clang-20
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-20
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-14.1.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-14.1.0
sh                               alldefconfig   gcc-14.1.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                        edosk7705_defconfig   gcc-14.1.0
sh                        edosk7760_defconfig   gcc-14.1.0
sh                            migor_defconfig   gcc-14.1.0
sh                          rsk7264_defconfig   gcc-13.2.0
sh                           sh2007_defconfig   gcc-14.1.0
sh                              ul2_defconfig   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
um                               allmodconfig   clang-20
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-13
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-14.1.0
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240726   gcc-13
x86_64       buildonly-randconfig-001-20240727   gcc-8
x86_64       buildonly-randconfig-002-20240726   gcc-13
x86_64       buildonly-randconfig-002-20240727   gcc-8
x86_64       buildonly-randconfig-003-20240726   gcc-13
x86_64       buildonly-randconfig-003-20240727   gcc-8
x86_64       buildonly-randconfig-004-20240726   gcc-13
x86_64       buildonly-randconfig-004-20240727   gcc-8
x86_64       buildonly-randconfig-005-20240726   gcc-13
x86_64       buildonly-randconfig-005-20240727   gcc-8
x86_64       buildonly-randconfig-006-20240726   gcc-13
x86_64       buildonly-randconfig-006-20240727   gcc-8
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240726   gcc-13
x86_64                randconfig-001-20240727   gcc-8
x86_64                randconfig-002-20240726   gcc-13
x86_64                randconfig-002-20240727   gcc-8
x86_64                randconfig-003-20240726   gcc-13
x86_64                randconfig-003-20240727   gcc-8
x86_64                randconfig-004-20240726   gcc-13
x86_64                randconfig-004-20240727   gcc-8
x86_64                randconfig-005-20240726   gcc-13
x86_64                randconfig-005-20240727   gcc-8
x86_64                randconfig-006-20240726   gcc-13
x86_64                randconfig-006-20240727   gcc-8
x86_64                randconfig-011-20240726   gcc-13
x86_64                randconfig-011-20240727   gcc-8
x86_64                randconfig-012-20240726   gcc-13
x86_64                randconfig-012-20240727   gcc-8
x86_64                randconfig-013-20240726   gcc-13
x86_64                randconfig-013-20240727   gcc-8
x86_64                randconfig-014-20240726   gcc-13
x86_64                randconfig-014-20240727   gcc-8
x86_64                randconfig-015-20240726   gcc-13
x86_64                randconfig-015-20240727   gcc-8
x86_64                randconfig-016-20240726   gcc-13
x86_64                randconfig-016-20240727   gcc-8
x86_64                randconfig-071-20240726   gcc-13
x86_64                randconfig-071-20240727   gcc-8
x86_64                randconfig-072-20240726   gcc-13
x86_64                randconfig-072-20240727   gcc-8
x86_64                randconfig-073-20240726   gcc-13
x86_64                randconfig-073-20240727   gcc-8
x86_64                randconfig-074-20240726   gcc-13
x86_64                randconfig-074-20240727   gcc-8
x86_64                randconfig-075-20240726   gcc-13
x86_64                randconfig-075-20240727   gcc-8
x86_64                randconfig-076-20240726   gcc-13
x86_64                randconfig-076-20240727   gcc-8
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                            allnoconfig   gcc-14.1.0
xtensa                    smp_lx200_defconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

