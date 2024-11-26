Return-Path: <linux-kernel+bounces-422484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28ADD9D9A31
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 16:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBD2DB26233
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 15:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552451D619F;
	Tue, 26 Nov 2024 15:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Khlp0DLt"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F471D6199
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 15:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732633706; cv=none; b=GsNK34SIy1//AhQCsYGkSWvE9hZHYDk4HwSxy4rtrhUr/9Xx7e5HWem/h39ZggQeT41etPI7nTB2bdsNbpV/9Pt37ahFRHI/XpozYgidzdc16i9rVpahCP+shkGVjBty5pv2booMagpDHkZQQcbCYxDi6xLkW6Of1ItxrKUDiGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732633706; c=relaxed/simple;
	bh=G2kTCSAuPZahn6188nP12kBMHaX0KTT0GIc9AgAjBGo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ce02hTqmZIvRDz8ogNPpafS773QxqyhPb9OeM6YoV+rLt8Y03kwNkq33i8+JB81WiXGRluKCRNjz4w5ELb1RtvEnyHRB+fRgvF+ua4/Geuv2ApuzEPuuw9+KtnKr1edBTwl1DB8MtFLE7yoz7ezc2xN/no9g841EmftARwYMALs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Khlp0DLt; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732633705; x=1764169705;
  h=date:from:to:cc:subject:message-id;
  bh=G2kTCSAuPZahn6188nP12kBMHaX0KTT0GIc9AgAjBGo=;
  b=Khlp0DLt7+tBIZabrYDQGntUsoLc1HOn2mCLZTDvvJWnqPR0azmKLQGO
   KDkGacD7kb6TMNf1v45xSkR2uVCbm9WiWMEelXY9XtYB7bxIZArgrqxgi
   AAhVAzJF0cX7yXkBpQzZRlSj8+Dnmf+tMOU1qzkNrAEUoEBtRGMOPE4Yq
   y+NXixmXqmme7NEj0SOPgumKK7EjmjWKIq5WZV2Uj7aBdREfKWG32ZWhj
   8OAFLV3etRJUT+G5lw/pru3Eaz5FToZq4I3zlOn0og/jO45UBillKKm6D
   0grEMJJ2ZlMDmCCl2eo+zfrcasBJxRU+lkQEr6v/wqoPxj8QbpVcYGoo5
   A==;
X-CSE-ConnectionGUID: r1f4MdWoQRq8s4jmNHetDQ==
X-CSE-MsgGUID: NVXq8vR1RMCiOKWafxLIZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11268"; a="32173646"
X-IronPort-AV: E=Sophos;i="6.12,186,1728975600"; 
   d="scan'208";a="32173646"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 07:08:23 -0800
X-CSE-ConnectionGUID: 8tnGkzjHSRqkYCRpVWPzOg==
X-CSE-MsgGUID: 6wAkeN05RDqztlppvkygVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,186,1728975600"; 
   d="scan'208";a="91578270"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 26 Nov 2024 07:08:22 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tFxAp-0007Lp-1k;
	Tue, 26 Nov 2024 15:08:19 +0000
Date: Tue, 26 Nov 2024 23:06:47 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 be4ca6c53e66cb275cf0d71f32dac0c4606b9dc0
Message-ID: <202411262337.WR1h01sY-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: be4ca6c53e66cb275cf0d71f32dac0c4606b9dc0  x86/Documentation: Update algo in init_size description of boot protocol

elapsed time: 1075m

configs tested: 130
configs skipped: 19

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    clang-20
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-20
arc                              allyesconfig    gcc-13.2.0
arc                          axs101_defconfig    gcc-14.2.0
arc                      axs103_smp_defconfig    gcc-13.2.0
arc                            hsdk_defconfig    gcc-14.2.0
arm                              allmodconfig    clang-20
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-20
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-20
arm                              allyesconfig    gcc-14.2.0
arm                       aspeed_g5_defconfig    gcc-13.2.0
arm                          ep93xx_defconfig    clang-14
arm                       multi_v4t_defconfig    gcc-13.2.0
arm                       multi_v4t_defconfig    gcc-14.2.0
arm                        mvebu_v5_defconfig    gcc-13.2.0
arm                             mxs_defconfig    gcc-14.2.0
arm                             pxa_defconfig    clang-14
arm                         vf610m4_defconfig    gcc-14.2.0
arm                    vt8500_v6_v7_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-20
i386        buildonly-randconfig-001-20241126    gcc-12
i386        buildonly-randconfig-002-20241126    gcc-12
i386        buildonly-randconfig-003-20241126    clang-19
i386        buildonly-randconfig-003-20241126    gcc-12
i386        buildonly-randconfig-004-20241126    gcc-12
i386        buildonly-randconfig-005-20241126    clang-19
i386        buildonly-randconfig-005-20241126    gcc-12
i386        buildonly-randconfig-006-20241126    gcc-12
i386                  randconfig-001-20241126    gcc-12
i386                  randconfig-002-20241126    gcc-12
i386                  randconfig-003-20241126    gcc-12
i386                  randconfig-004-20241126    gcc-11
i386                  randconfig-004-20241126    gcc-12
i386                  randconfig-005-20241126    clang-19
i386                  randconfig-005-20241126    gcc-12
i386                  randconfig-006-20241126    clang-19
i386                  randconfig-006-20241126    gcc-12
i386                  randconfig-011-20241126    clang-19
i386                  randconfig-011-20241126    gcc-12
i386                  randconfig-012-20241126    clang-19
i386                  randconfig-012-20241126    gcc-12
i386                  randconfig-013-20241126    clang-19
i386                  randconfig-013-20241126    gcc-12
i386                  randconfig-014-20241126    gcc-12
i386                  randconfig-015-20241126    clang-19
i386                  randconfig-015-20241126    gcc-12
i386                  randconfig-016-20241126    clang-19
i386                  randconfig-016-20241126    gcc-12
loongarch                        alldefconfig    gcc-14.2.0
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
m68k                             alldefconfig    clang-14
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                       bvme6000_defconfig    gcc-14.2.0
m68k                        stmark2_defconfig    gcc-13.2.0
m68k                           sun3_defconfig    clang-20
m68k                          sun3x_defconfig    clang-14
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                      mmu_defconfig    gcc-13.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          ath79_defconfig    clang-14
mips                           xway_defconfig    clang-14
nios2                             allnoconfig    gcc-14.2.0
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-20
powerpc                          allyesconfig    gcc-14.2.0
powerpc                      pcm030_defconfig    gcc-14.2.0
powerpc                      pmac32_defconfig    clang-14
powerpc                      ppc6xx_defconfig    gcc-14.2.0
powerpc                     redwood_defconfig    clang-20
powerpc                    socrates_defconfig    gcc-13.2.0
powerpc                     tqm8541_defconfig    gcc-14.2.0
riscv                            allmodconfig    clang-20
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                            allyesconfig    gcc-14.2.0
s390                             allmodconfig    clang-20
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
sh                               alldefconfig    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                         ap325rxa_defconfig    gcc-13.2.0
sh                            hp6xx_defconfig    clang-14
sh                          kfr2r09_defconfig    gcc-13.2.0
sh                          landisk_defconfig    gcc-13.2.0
sh                          landisk_defconfig    gcc-14.2.0
sh                     magicpanelr2_defconfig    gcc-13.2.0
sh                          rsk7203_defconfig    gcc-13.2.0
sh                        sh7763rdp_defconfig    gcc-13.2.0
sparc                            allmodconfig    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                               allyesconfig    gcc-12
x86_64                                  kexec    clang-19
x86_64                               rhel-9.4    gcc-12
xtensa                            allnoconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

