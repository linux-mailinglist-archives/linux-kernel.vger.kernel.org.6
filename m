Return-Path: <linux-kernel+bounces-403113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A2E9C312B
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 08:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D07D8B21084
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 07:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509CF14A605;
	Sun, 10 Nov 2024 07:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Iv9hhpNH"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75F22AD20
	for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 07:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731223360; cv=none; b=b9ix51CD0diogZkdnKY22rNCOgG71E8aMv8dgLwVxSVY3Qdp6vknLfS2iZ8roRhWtjMgx4a/cOfWDYdMOzqhpj+N+sZgMv8BunamD17U9+1BQhDM9FOlqUTy8IKASvHom82QdoNa/L7a8nc5AlfseBHuf9EKTKi94NbqcNqFzl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731223360; c=relaxed/simple;
	bh=MQ+E1wJCKhbOaij1ms4z30B4Z2Ne64sPY4A+gJorkwc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=GnM6Qr8P2n6Zq4rBdgAAY7xYx//wew0nx7ryOjyQoHNKYgcR2tiasS6gMG6HNrVSBKxqfdJWY/+LFIoJdnoC3MhSOW1oJECtHN9c54YS8e5JiT1n9fVGNC/wa0fqOB518AMLijARfY08saPytSa+6fk+n3wlVPFAkK466qyriNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Iv9hhpNH; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731223359; x=1762759359;
  h=date:from:to:cc:subject:message-id;
  bh=MQ+E1wJCKhbOaij1ms4z30B4Z2Ne64sPY4A+gJorkwc=;
  b=Iv9hhpNHJtyfuuW3X11lmF8TWUadbkDGFP3Web+2k2km06ckFU69ILZ+
   eJH3LLLHptxBuhS99GETAlZzdeyAU0NPM3FbPTOJzEftP5E/nNIRKAge1
   AyKvr+eq+jYQ0O3+ijxYvZhEvrvroboNexMkWm6oUhFBH+G74Sf+sBSsH
   dR8qunyuTuvK5F/+KS1kmWMwgRUIgBkWHy0+Mu/OlfVGP7vpkUrPYhfpE
   V5YDmtBaRlhqaXApAnS6eNA7eYGg/SzfoaFZWlx3FXy/SZG/bLzSs8Rsy
   iBdpY3SRPK7FBGWiLb8aqfeRx+beNhQoMtZYKCS1PWfH7/Mvrf30ebRh7
   A==;
X-CSE-ConnectionGUID: j7punqrmSKqUF1azht8zlg==
X-CSE-MsgGUID: TTJuRWJ5T/iCOW+Vwe716Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11251"; a="34842387"
X-IronPort-AV: E=Sophos;i="6.12,142,1728975600"; 
   d="scan'208";a="34842387"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2024 23:22:38 -0800
X-CSE-ConnectionGUID: E8vqdUWEStOeKCff6F7MNg==
X-CSE-MsgGUID: tUVtww7PR8C0dC+uEHmU9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,142,1728975600"; 
   d="scan'208";a="117164766"
Received: from lkp-server01.sh.intel.com (HELO 7b17a4138caf) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 09 Nov 2024 23:22:37 -0800
Received: from kbuild by 7b17a4138caf with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tA2HK-00001d-1w;
	Sun, 10 Nov 2024 07:22:34 +0000
Date: Sun, 10 Nov 2024 15:22:08 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:tip/urgent] BUILD SUCCESS
 ac510ee33a382fc03b7c3d24b199da0316c29f2d
Message-ID: <202411101503.KriF2vLi-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tip/urgent
branch HEAD: ac510ee33a382fc03b7c3d24b199da0316c29f2d  Merge branch into tip/master: 'x86/urgent'

elapsed time: 726m

configs tested: 225
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-20
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-20
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-14.2.0
arc                 nsimosci_hs_smp_defconfig    clang-15
arc                   randconfig-001-20241110    gcc-14.2.0
arc                   randconfig-002-20241110    gcc-14.2.0
arm                              allmodconfig    clang-20
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-20
arm                              allyesconfig    gcc-14.2.0
arm                         at91_dt_defconfig    clang-20
arm                                 defconfig    gcc-14.2.0
arm                          gemini_defconfig    clang-20
arm                           imxrt_defconfig    clang-20
arm                         lpc18xx_defconfig    clang-15
arm                          pxa910_defconfig    clang-20
arm                   randconfig-001-20241110    gcc-14.2.0
arm                   randconfig-002-20241110    gcc-14.2.0
arm                   randconfig-003-20241110    gcc-14.2.0
arm                   randconfig-004-20241110    gcc-14.2.0
arm                           sama5_defconfig    clang-20
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20241110    gcc-14.2.0
arm64                 randconfig-002-20241110    gcc-14.2.0
arm64                 randconfig-003-20241110    gcc-14.2.0
arm64                 randconfig-004-20241110    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20241110    gcc-14.2.0
csky                  randconfig-002-20241110    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20241110    gcc-14.2.0
hexagon               randconfig-002-20241110    gcc-14.2.0
i386                             allmodconfig    clang-19
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-19
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-19
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241110    gcc-11
i386        buildonly-randconfig-002-20241110    gcc-11
i386        buildonly-randconfig-002-20241110    gcc-12
i386        buildonly-randconfig-003-20241110    clang-19
i386        buildonly-randconfig-003-20241110    gcc-11
i386        buildonly-randconfig-004-20241110    gcc-11
i386        buildonly-randconfig-005-20241110    gcc-11
i386        buildonly-randconfig-005-20241110    gcc-12
i386        buildonly-randconfig-006-20241110    gcc-11
i386        buildonly-randconfig-006-20241110    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20241110    gcc-11
i386                  randconfig-001-20241110    gcc-12
i386                  randconfig-002-20241110    clang-19
i386                  randconfig-002-20241110    gcc-11
i386                  randconfig-003-20241110    gcc-11
i386                  randconfig-003-20241110    gcc-12
i386                  randconfig-004-20241110    clang-19
i386                  randconfig-004-20241110    gcc-11
i386                  randconfig-005-20241110    gcc-11
i386                  randconfig-005-20241110    gcc-12
i386                  randconfig-006-20241110    gcc-11
i386                  randconfig-006-20241110    gcc-12
i386                  randconfig-011-20241110    clang-19
i386                  randconfig-011-20241110    gcc-11
i386                  randconfig-012-20241110    gcc-11
i386                  randconfig-012-20241110    gcc-12
i386                  randconfig-013-20241110    gcc-11
i386                  randconfig-013-20241110    gcc-12
i386                  randconfig-014-20241110    gcc-11
i386                  randconfig-014-20241110    gcc-12
i386                  randconfig-015-20241110    gcc-11
i386                  randconfig-015-20241110    gcc-12
i386                  randconfig-016-20241110    clang-19
i386                  randconfig-016-20241110    gcc-11
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20241110    gcc-14.2.0
loongarch             randconfig-002-20241110    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                        m5407c3_defconfig    clang-15
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
microblaze                      mmu_defconfig    clang-15
mips                              allnoconfig    gcc-14.2.0
mips                       bmips_be_defconfig    clang-15
mips                           ip32_defconfig    clang-15
mips                     loongson1b_defconfig    clang-15
mips                        maltaup_defconfig    clang-15
mips                           mtx1_defconfig    clang-20
mips                          rb532_defconfig    clang-20
mips                        vocore2_defconfig    clang-15
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20241110    gcc-14.2.0
nios2                 randconfig-002-20241110    gcc-14.2.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
openrisc                       virt_defconfig    clang-20
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20241110    gcc-14.2.0
parisc                randconfig-002-20241110    gcc-14.2.0
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    clang-20
powerpc                          allyesconfig    gcc-14.2.0
powerpc                      chrp32_defconfig    clang-15
powerpc                      chrp32_defconfig    clang-20
powerpc                    gamecube_defconfig    clang-15
powerpc                    ge_imp3a_defconfig    clang-20
powerpc                 mpc834x_itx_defconfig    clang-15
powerpc               randconfig-001-20241110    gcc-14.2.0
powerpc               randconfig-002-20241110    gcc-14.2.0
powerpc               randconfig-003-20241110    gcc-14.2.0
powerpc                  storcenter_defconfig    clang-15
powerpc64             randconfig-001-20241110    gcc-14.2.0
powerpc64             randconfig-002-20241110    gcc-14.2.0
powerpc64             randconfig-003-20241110    gcc-14.2.0
riscv                            alldefconfig    clang-20
riscv                            allmodconfig    clang-20
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    clang-20
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20241110    gcc-14.2.0
riscv                 randconfig-002-20241110    gcc-14.2.0
s390                             allmodconfig    clang-20
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                          debug_defconfig    clang-20
s390                                defconfig    clang-20
s390                                defconfig    gcc-12
s390                  randconfig-001-20241110    gcc-14.2.0
s390                  randconfig-002-20241110    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                          polaris_defconfig    clang-15
sh                    randconfig-001-20241110    gcc-14.2.0
sh                    randconfig-002-20241110    gcc-14.2.0
sh                          rsk7264_defconfig    clang-20
sh                           se7751_defconfig    clang-15
sparc                            allmodconfig    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20241110    gcc-14.2.0
sparc64               randconfig-002-20241110    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241110    gcc-14.2.0
um                    randconfig-002-20241110    gcc-14.2.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241110    clang-19
x86_64      buildonly-randconfig-001-20241110    gcc-12
x86_64      buildonly-randconfig-002-20241110    gcc-12
x86_64      buildonly-randconfig-003-20241110    clang-19
x86_64      buildonly-randconfig-003-20241110    gcc-12
x86_64      buildonly-randconfig-004-20241110    gcc-12
x86_64      buildonly-randconfig-005-20241110    gcc-12
x86_64      buildonly-randconfig-006-20241110    clang-19
x86_64      buildonly-randconfig-006-20241110    gcc-12
x86_64                              defconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20241110    gcc-12
x86_64                randconfig-002-20241110    clang-19
x86_64                randconfig-002-20241110    gcc-12
x86_64                randconfig-003-20241110    gcc-12
x86_64                randconfig-004-20241110    gcc-12
x86_64                randconfig-005-20241110    clang-19
x86_64                randconfig-005-20241110    gcc-12
x86_64                randconfig-006-20241110    clang-19
x86_64                randconfig-006-20241110    gcc-12
x86_64                randconfig-011-20241110    gcc-12
x86_64                randconfig-012-20241110    gcc-12
x86_64                randconfig-013-20241110    gcc-12
x86_64                randconfig-014-20241110    clang-19
x86_64                randconfig-014-20241110    gcc-12
x86_64                randconfig-015-20241110    gcc-12
x86_64                randconfig-016-20241110    gcc-12
x86_64                randconfig-071-20241110    clang-19
x86_64                randconfig-071-20241110    gcc-12
x86_64                randconfig-072-20241110    gcc-12
x86_64                randconfig-073-20241110    gcc-12
x86_64                randconfig-074-20241110    gcc-12
x86_64                randconfig-075-20241110    gcc-11
x86_64                randconfig-075-20241110    gcc-12
x86_64                randconfig-076-20241110    clang-19
x86_64                randconfig-076-20241110    gcc-12
x86_64                               rhel-8.3    gcc-12
xtensa                            allnoconfig    gcc-14.2.0
xtensa                          iss_defconfig    clang-20
xtensa                randconfig-001-20241110    gcc-14.2.0
xtensa                randconfig-002-20241110    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

