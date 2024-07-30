Return-Path: <linux-kernel+bounces-266620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C6D940376
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 03:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22504283158
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 01:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA56179E1;
	Tue, 30 Jul 2024 01:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I6Y8rYxs"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1A26FD3
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 01:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722302596; cv=none; b=oIoTJ+gGPZgTGkuLATZfzhqoKU69xGMzlgGUNHSRxwnGWdlINWGfeGAtaWSAa6D20ILtC4eC1fVf24msBE+etqJpAfkKKBEWvXPaeFzADAXh+r3TfOdxkQR6yo8/scUoQmbkQF2xMPR4DKn8tW/3Iycm53ahqYUI7l2pEhn9ZoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722302596; c=relaxed/simple;
	bh=ybTFoXoymcQLMDqmPeltfdlqvtqnUenRkuggUgq3rX0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=p/zDKxxuAZUwb6T53/eLV7ToUfdobRh0tPCC8CXxb0Cck8H+/bpDV8lj40WrmV10WeU8wG9g7CLfaXo8Fyl37nD5GoHEFfjIP7OXXah+f/EdwfO3Se3nQROqAiFr+G2zNr34C7nomguW+guBDG0cWfuWmJ81PgmHDdBfz7XSVzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I6Y8rYxs; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722302595; x=1753838595;
  h=date:from:to:cc:subject:message-id;
  bh=ybTFoXoymcQLMDqmPeltfdlqvtqnUenRkuggUgq3rX0=;
  b=I6Y8rYxsGxN06SrRr+aqNq776nOfOgnhGWP3xQagxo7fLFEDoTXOhwXy
   dMlqHENraxWkbSw7vlBV77nerihpcGmX6TzhDI84tmkNAwGHR+jp52Tjd
   QzeoieFhakUzwv0+R3SvpyiynP56FkZ0k9zSg8/jz3Q14ILhXxCvmlkWt
   91DxkpEXvaWPKHuT1xk/RG0mNdnfzcJwBDfvdmlwP9N0I7Q6yVS6cA6Nw
   NZF/nWVw9fzItl00QQfDTv/xYlP5VpkZzpLK6c4zmACgmzV5k2TvqSePs
   mMKZktGSb+yx3oUlFvTHaBajZhxCXVyxvclAvFg3z9XHTgQxlw6SPbJuz
   A==;
X-CSE-ConnectionGUID: jA9PtPC1Rny8iRMmw5NJNQ==
X-CSE-MsgGUID: oXg23R+cRciQk59YlbLmxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="30680744"
X-IronPort-AV: E=Sophos;i="6.09,247,1716274800"; 
   d="scan'208";a="30680744"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 18:23:14 -0700
X-CSE-ConnectionGUID: G/Z21oABRumMg2LLQziO6A==
X-CSE-MsgGUID: ZCiSayBnTFWL6OA9j4aVWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,247,1716274800"; 
   d="scan'208";a="91655548"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 29 Jul 2024 18:23:13 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sYba2-000sIH-2F;
	Tue, 30 Jul 2024 01:23:10 +0000
Date: Tue, 30 Jul 2024 09:22:50 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD SUCCESS
 cea5a3472ac43f18590e1bd6b842f808347a810c
Message-ID: <202407300947.3simm4ik-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
branch HEAD: cea5a3472ac43f18590e1bd6b842f808347a810c  sched/fair: Cleanup fair_server

elapsed time: 893m

configs tested: 166
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.3.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                        nsimosci_defconfig   gcc-13.2.0
arc                   randconfig-001-20240730   gcc-13.2.0
arc                   randconfig-002-20240730   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-20
arm                              allyesconfig   gcc-14.1.0
arm                                 defconfig   clang-14
arm                            hisi_defconfig   gcc-14.1.0
arm                        keystone_defconfig   gcc-14.1.0
arm                             pxa_defconfig   gcc-14.1.0
arm                   randconfig-001-20240730   gcc-14.1.0
arm                   randconfig-002-20240730   gcc-14.1.0
arm                   randconfig-003-20240730   gcc-14.1.0
arm                   randconfig-004-20240730   gcc-14.1.0
arm64                            allmodconfig   clang-20
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-14.1.0
arm64                 randconfig-001-20240730   gcc-14.1.0
arm64                 randconfig-002-20240730   clang-20
arm64                 randconfig-003-20240730   clang-20
arm64                 randconfig-004-20240730   gcc-14.1.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-14.1.0
csky                  randconfig-001-20240730   gcc-14.1.0
csky                  randconfig-002-20240730   gcc-14.1.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   clang-20
hexagon                          allyesconfig   clang-20
hexagon                             defconfig   clang-20
hexagon               randconfig-001-20240730   clang-20
hexagon               randconfig-002-20240730   clang-20
i386                             allmodconfig   gcc-13
i386                              allnoconfig   gcc-13
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240729   clang-18
i386         buildonly-randconfig-002-20240729   gcc-13
i386         buildonly-randconfig-003-20240729   clang-18
i386         buildonly-randconfig-004-20240729   gcc-10
i386         buildonly-randconfig-005-20240729   clang-18
i386         buildonly-randconfig-006-20240729   gcc-8
i386                                defconfig   clang-18
i386                  randconfig-001-20240729   gcc-12
i386                  randconfig-002-20240729   clang-18
i386                  randconfig-003-20240729   gcc-10
i386                  randconfig-004-20240729   gcc-13
i386                  randconfig-005-20240729   gcc-8
i386                  randconfig-006-20240729   gcc-13
i386                  randconfig-011-20240729   gcc-13
i386                  randconfig-012-20240729   clang-18
i386                  randconfig-013-20240729   gcc-9
i386                  randconfig-014-20240729   clang-18
i386                  randconfig-015-20240729   gcc-13
i386                  randconfig-016-20240729   clang-18
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-14.1.0
loongarch             randconfig-001-20240730   gcc-14.1.0
loongarch             randconfig-002-20240730   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
mips                           gcw0_defconfig   clang-20
mips                            gpr_defconfig   clang-20
mips                      maltaaprp_defconfig   clang-14
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-14.1.0
nios2                 randconfig-001-20240730   gcc-14.1.0
nios2                 randconfig-002-20240730   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                generic-64bit_defconfig   gcc-14.1.0
parisc                randconfig-001-20240730   gcc-14.1.0
parisc                randconfig-002-20240730   gcc-14.1.0
parisc64                            defconfig   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-20
powerpc                 canyonlands_defconfig   clang-20
powerpc               randconfig-002-20240730   clang-16
powerpc                    sam440ep_defconfig   gcc-14.1.0
powerpc64             randconfig-001-20240730   gcc-14.1.0
powerpc64             randconfig-003-20240730   gcc-14.1.0
riscv                            allmodconfig   clang-20
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-20
riscv                               defconfig   clang-20
riscv                 randconfig-001-20240730   clang-14
riscv                 randconfig-002-20240730   gcc-14.1.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   clang-20
s390                  randconfig-001-20240730   gcc-14.1.0
s390                  randconfig-002-20240730   clang-20
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                             espt_defconfig   gcc-14.1.0
sh                          polaris_defconfig   gcc-14.1.0
sh                          r7780mp_defconfig   gcc-14.1.0
sh                    randconfig-001-20240730   gcc-14.1.0
sh                    randconfig-002-20240730   gcc-14.1.0
sh                          rsk7269_defconfig   gcc-14.1.0
sh                           se7721_defconfig   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240730   gcc-14.1.0
sparc64               randconfig-002-20240730   gcc-14.1.0
um                               allmodconfig   clang-20
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-13
um                                  defconfig   clang-20
um                             i386_defconfig   gcc-13
um                    randconfig-001-20240730   gcc-13
um                    randconfig-002-20240730   clang-20
um                           x86_64_defconfig   clang-15
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240729   clang-18
x86_64       buildonly-randconfig-002-20240729   gcc-13
x86_64       buildonly-randconfig-003-20240729   gcc-10
x86_64       buildonly-randconfig-004-20240729   gcc-10
x86_64       buildonly-randconfig-005-20240729   gcc-10
x86_64       buildonly-randconfig-006-20240729   gcc-10
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240729   gcc-13
x86_64                randconfig-002-20240729   clang-18
x86_64                randconfig-003-20240729   clang-18
x86_64                randconfig-004-20240729   clang-18
x86_64                randconfig-005-20240729   clang-18
x86_64                randconfig-006-20240729   clang-18
x86_64                randconfig-011-20240729   gcc-8
x86_64                randconfig-012-20240729   gcc-8
x86_64                randconfig-013-20240729   gcc-13
x86_64                randconfig-014-20240729   clang-18
x86_64                randconfig-015-20240729   gcc-13
x86_64                randconfig-016-20240729   clang-18
x86_64                randconfig-071-20240729   gcc-13
x86_64                randconfig-072-20240729   gcc-13
x86_64                randconfig-073-20240729   clang-18
x86_64                randconfig-074-20240729   gcc-8
x86_64                randconfig-075-20240729   gcc-12
x86_64                randconfig-076-20240729   gcc-13
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240730   gcc-14.1.0
xtensa                randconfig-002-20240730   gcc-14.1.0
xtensa                    smp_lx200_defconfig   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

