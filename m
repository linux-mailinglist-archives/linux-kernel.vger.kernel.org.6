Return-Path: <linux-kernel+bounces-436253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0599D9E8348
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 04:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05D671883CD8
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 03:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675C81BC4E;
	Sun,  8 Dec 2024 03:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TRmNnf2c"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C28EED8
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 03:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733627530; cv=none; b=b1iOELirMP1XTrXgBcU5ovjbyxcMPXutXcYBwHV34/U8LXCf+0XyYOzzOsLvZFQESl5RmPTmqTuKZnnoSMP02XyUynT6oPC5ENaQlpsNhY/TAIWo5PFtTGGDKoxMza0tj/XmacoM0Dg3LBx3caH2i20svZMRX7lgtDnTDtUe/t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733627530; c=relaxed/simple;
	bh=meC6/j0KsW3JLnYvNWdBNQjmLz+GRr7jdgxqnXB/16Q=;
	h=Date:From:To:Cc:Subject:Message-ID; b=AQJiBszpkppuTp1ZCOSyxcboEoHaP2VlWl49jhx+LLbB3q/p853tMx7xxCJVtg6niob91Zn4M1tgScWdzWtp3EvocVGvU4jqfd8rO20SlhMJ4fVk+pCvUypr/P9Du4oJkQW1xXAqGm8r+offAhK5S3Eycr4uGFg4Ru/3rxsjdOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TRmNnf2c; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733627528; x=1765163528;
  h=date:from:to:cc:subject:message-id;
  bh=meC6/j0KsW3JLnYvNWdBNQjmLz+GRr7jdgxqnXB/16Q=;
  b=TRmNnf2c7AWi/sy4TR59dS/f1nllVIeYEE1YnClnxTsu28jgsnJQraHM
   uOfVAeWMubdgGYA8gpbsSseYIRzkuP/Tp7vomB0+DgFwWUUpnuq85wzul
   9xSDLXQMd7+MNG0LnbBs13NF/9lO/xcxuR2K0sA0pqA36ko9enDFthkaH
   rZoqjunV501qpTKFrelKoo6gvNIwILrUXxBOYhRUZFyMeNCEby5fADAbD
   siQanwLZfDQ+BWDvd8yHWU0ObQlHcMizIV3/3l7cWx/jaChTN+/oKAHYA
   IVA36Sc9d/ol8IY2k5rOHq5X1xrh5nALfDmXufRwVK8CoTxbZWZoC3mY3
   Q==;
X-CSE-ConnectionGUID: jVIuT1dxSDybw5xLg+9spg==
X-CSE-MsgGUID: 0ZhL644VRfWz82coxHhBMg==
X-IronPort-AV: E=McAfee;i="6700,10204,11279"; a="37727570"
X-IronPort-AV: E=Sophos;i="6.12,216,1728975600"; 
   d="scan'208";a="37727570"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2024 19:12:08 -0800
X-CSE-ConnectionGUID: nZjCfkS6RVWR/U360fMb1A==
X-CSE-MsgGUID: jV8+fN/cS/OZoRf5b1Xgag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,216,1728975600"; 
   d="scan'208";a="99205846"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 07 Dec 2024 19:12:06 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tK7iG-00036v-1E;
	Sun, 08 Dec 2024 03:12:04 +0000
Date: Sun, 08 Dec 2024 11:08:21 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:tip/urgent] BUILD SUCCESS
 b141b22e78e6d7a7bc7fc3f4c9f59c70e779a80e
Message-ID: <202412081111.XkEj1oaX-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tip/urgent
branch HEAD: b141b22e78e6d7a7bc7fc3f4c9f59c70e779a80e  Merge branch into tip/master: 'x86/urgent'

elapsed time: 946m

configs tested: 203
configs skipped: 14

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    clang-20
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-18
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-18
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-14.2.0
arc                            hsdk_defconfig    gcc-13.2.0
arc                     nsimosci_hs_defconfig    gcc-13.2.0
arc                   randconfig-001-20241207    gcc-13.2.0
arc                   randconfig-002-20241207    gcc-13.2.0
arm                              allmodconfig    clang-18
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-18
arm                              allyesconfig    gcc-14.2.0
arm                                 defconfig    gcc-14.2.0
arm                          ep93xx_defconfig    clang-20
arm                           imxrt_defconfig    clang-19
arm                       multi_v4t_defconfig    clang-18
arm                       multi_v4t_defconfig    clang-20
arm                        multi_v5_defconfig    clang-18
arm                            qcom_defconfig    clang-15
arm                   randconfig-001-20241207    gcc-14.2.0
arm                   randconfig-002-20241207    gcc-14.2.0
arm                   randconfig-003-20241207    clang-19
arm                   randconfig-004-20241207    clang-20
arm                       versatile_defconfig    clang-18
arm                         wpcm450_defconfig    clang-20
arm64                            alldefconfig    clang-20
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20241207    gcc-14.2.0
arm64                 randconfig-002-20241207    gcc-14.2.0
arm64                 randconfig-003-20241207    clang-20
arm64                 randconfig-004-20241207    clang-15
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20241207    gcc-14.2.0
csky                  randconfig-002-20241207    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-18
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20241207    clang-14
hexagon               randconfig-002-20241207    clang-16
i386                             allmodconfig    clang-19
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-19
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-19
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241207    clang-19
i386        buildonly-randconfig-002-20241207    clang-19
i386        buildonly-randconfig-003-20241207    gcc-12
i386        buildonly-randconfig-004-20241207    clang-19
i386        buildonly-randconfig-005-20241207    clang-19
i386        buildonly-randconfig-006-20241207    clang-19
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20241207    gcc-14.2.0
loongarch             randconfig-002-20241207    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                          atari_defconfig    clang-20
m68k                                defconfig    gcc-14.2.0
m68k                          multi_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          ath79_defconfig    gcc-14.2.0
mips                        bcm47xx_defconfig    clang-20
mips                      bmips_stb_defconfig    clang-18
mips                            gpr_defconfig    clang-20
mips                           ip22_defconfig    clang-15
mips                           ip22_defconfig    clang-18
mips                           ip28_defconfig    clang-18
mips                           jazz_defconfig    clang-18
mips                        vocore2_defconfig    clang-15
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20241207    gcc-14.2.0
nios2                 randconfig-002-20241207    gcc-14.2.0
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
openrisc                            defconfig    gcc-14.2.0
openrisc                 simple_smp_defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20241207    gcc-14.2.0
parisc                randconfig-002-20241207    gcc-14.2.0
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                          allyesconfig    gcc-14.2.0
powerpc                      bamboo_defconfig    clang-20
powerpc                 canyonlands_defconfig    clang-18
powerpc                       holly_defconfig    clang-20
powerpc                      mgcoge_defconfig    clang-18
powerpc                      mgcoge_defconfig    clang-20
powerpc                 mpc832x_rdb_defconfig    gcc-14.2.0
powerpc                  mpc885_ads_defconfig    clang-20
powerpc                    mvme5100_defconfig    clang-15
powerpc               randconfig-001-20241207    gcc-14.2.0
powerpc               randconfig-002-20241207    clang-20
powerpc               randconfig-003-20241207    clang-15
powerpc                     stx_gp3_defconfig    clang-20
powerpc                     tqm8555_defconfig    clang-15
powerpc64                        alldefconfig    clang-18
powerpc64             randconfig-001-20241207    gcc-14.2.0
powerpc64             randconfig-002-20241207    clang-19
powerpc64             randconfig-003-20241207    clang-17
riscv                            allmodconfig    clang-20
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    clang-19
riscv                               defconfig    clang-20
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20241208    gcc-14.2.0
riscv                 randconfig-002-20241208    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                                defconfig    gcc-12
s390                  randconfig-001-20241208    gcc-14.2.0
s390                  randconfig-002-20241208    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                                  defconfig    gcc-14.2.0
sh                        edosk7760_defconfig    gcc-14.2.0
sh                             espt_defconfig    clang-18
sh                          r7780mp_defconfig    clang-15
sh                    randconfig-001-20241208    gcc-14.2.0
sh                    randconfig-002-20241208    gcc-14.2.0
sh                          sdk7780_defconfig    clang-18
sh                           se7712_defconfig    clang-20
sh                           se7724_defconfig    gcc-14.2.0
sparc                            alldefconfig    clang-18
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20241208    gcc-14.2.0
sparc                 randconfig-002-20241208    gcc-14.2.0
sparc64                          alldefconfig    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20241208    gcc-14.2.0
sparc64               randconfig-002-20241208    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-18
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                               allyesconfig    gcc-12
um                                  defconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241208    gcc-14.2.0
um                    randconfig-002-20241208    gcc-14.2.0
um                           x86_64_defconfig    clang-15
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241207    clang-19
x86_64      buildonly-randconfig-002-20241207    clang-19
x86_64      buildonly-randconfig-003-20241207    gcc-11
x86_64      buildonly-randconfig-004-20241207    clang-19
x86_64      buildonly-randconfig-005-20241207    clang-19
x86_64      buildonly-randconfig-006-20241207    gcc-12
x86_64                              defconfig    clang-19
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                       common_defconfig    clang-20
xtensa                       common_defconfig    gcc-14.2.0
xtensa                generic_kc705_defconfig    clang-18
xtensa                randconfig-001-20241208    gcc-14.2.0
xtensa                randconfig-002-20241208    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

