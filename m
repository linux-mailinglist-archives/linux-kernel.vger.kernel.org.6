Return-Path: <linux-kernel+bounces-243787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16232929A8F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 03:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7910D1F21268
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 01:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F751109;
	Mon,  8 Jul 2024 01:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q5iIZdbc"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18871639
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 01:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720402531; cv=none; b=cMRywpqqXrpOx0HSLD9Jxrhq7scZtPe+k6CbxZTHtKOUthVVRj98s3xRdBvxKVRzmoc6nm+/TJ8jY2kqMzVdzzi1ofRF/Pr71WLlv8abpGX5K7N/bqph0KSJpdQfNygvX6WEgukAD2clGjNjMc5K4sVasGCXxVGtaNlZlweZZt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720402531; c=relaxed/simple;
	bh=hZyUECLEZ0zfBVVziMARtIqD2AclC9cviUBwYm0TFcI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=BKDWtOB7plaSOIIo0Oiq23bbkDx/bqr+yuj7yQh6LRhcebFRFVP0vohl1KXC4iE8p0xInP8rsVK6UD5zoqP3dP6IXpnAP7iGlke1R61XGf2gUR0eBqRzfS0z9aLhhg3jH6hLbmrzU/LXu1LPHei1Jdry1LnsZS6xcb3ak33/3fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q5iIZdbc; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720402529; x=1751938529;
  h=date:from:to:cc:subject:message-id;
  bh=hZyUECLEZ0zfBVVziMARtIqD2AclC9cviUBwYm0TFcI=;
  b=Q5iIZdbcIG+MurltuB6pXFCXjk7wAJE06uuK10JKEt5MudR7EnMhM2n5
   dauZNWmu6eekDZe8zNu0xazfe1J9MJWAomHV4v5UpLqa2Sly+T9mZ6KE5
   Ro7LFA8/KhDlYMpQKF/FDyz+rZJGteM4HfL9M+an+tCeaJQ/E5wHJ3NhE
   MKMeWQroralOHJy8A78PseSVXwI2zxarlDqJKr+1rfSa5RGYv/gPkx1Yh
   Jp/z5pcUe8Wyb77a7JXeVHlmtCbRGGybtA9v+a7SNLvNSU6YMwiNpH++L
   S8tY0Ug9ZyZKUcrKdnyDbwfX9rLkugwlNxHUQMSbWWe9JYnKYrhqo/2zs
   g==;
X-CSE-ConnectionGUID: /gOqXlfqT7Ckx8M8WnkB6A==
X-CSE-MsgGUID: Rh48/sHqRCKcUx+qGy6Kqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11126"; a="12427259"
X-IronPort-AV: E=Sophos;i="6.09,191,1716274800"; 
   d="scan'208";a="12427259"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2024 18:35:28 -0700
X-CSE-ConnectionGUID: CrymAMaiSIKvidJM01tQuA==
X-CSE-MsgGUID: VpmoAcYHQ/OGqRaeT0n/vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,191,1716274800"; 
   d="scan'208";a="52547793"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 07 Jul 2024 18:35:27 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sQdHo-000VR0-18;
	Mon, 08 Jul 2024 01:35:24 +0000
Date: Mon, 08 Jul 2024 09:34:34 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev] BUILD SUCCESS
 f3f481a1a39b188e0e7913f85fbf4f724339581f
Message-ID: <202407080932.DsOUbMlr-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://github.com/paulmckrcu/linux dev
branch HEAD: f3f481a1a39b188e0e7913f85fbf4f724339581f  rcu-tasks: Remove RCU Tasks Rude asynchronous APIs

elapsed time: 1225m

configs tested: 238
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                            allyesconfig   gcc-13.2.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                          axs101_defconfig   gcc-13.2.0
arc                          axs103_defconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                     haps_hs_smp_defconfig   gcc-13.2.0
arc                        nsimosci_defconfig   gcc-13.2.0
arc                   randconfig-001-20240707   gcc-13.2.0
arc                   randconfig-002-20240707   gcc-13.2.0
arc                           tb10x_defconfig   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                        clps711x_defconfig   clang-19
arm                        clps711x_defconfig   gcc-13.2.0
arm                                 defconfig   gcc-13.2.0
arm                            dove_defconfig   gcc-13.2.0
arm                          exynos_defconfig   gcc-13.2.0
arm                          gemini_defconfig   gcc-13.2.0
arm                            hisi_defconfig   gcc-13.2.0
arm                       netwinder_defconfig   gcc-13.2.0
arm                         nhk8815_defconfig   clang-19
arm                         nhk8815_defconfig   gcc-13.2.0
arm                       omap2plus_defconfig   gcc-13.2.0
arm                   randconfig-001-20240707   gcc-13.2.0
arm                   randconfig-002-20240707   gcc-13.2.0
arm                   randconfig-003-20240707   gcc-13.2.0
arm                   randconfig-004-20240707   gcc-13.2.0
arm                        realview_defconfig   gcc-13.2.0
arm                           sama5_defconfig   gcc-13.2.0
arm64                            alldefconfig   gcc-13.2.0
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240707   gcc-13.2.0
arm64                 randconfig-002-20240707   gcc-13.2.0
arm64                 randconfig-003-20240707   gcc-13.2.0
arm64                 randconfig-004-20240707   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240707   gcc-13.2.0
csky                  randconfig-002-20240707   gcc-13.2.0
hexagon                          allmodconfig   clang-19
hexagon                          allyesconfig   clang-19
i386                             allmodconfig   clang-18
i386                              allnoconfig   clang-18
i386                             allyesconfig   clang-18
i386         buildonly-randconfig-001-20240707   gcc-13
i386         buildonly-randconfig-002-20240707   gcc-13
i386         buildonly-randconfig-003-20240707   gcc-13
i386         buildonly-randconfig-004-20240707   gcc-13
i386         buildonly-randconfig-005-20240707   gcc-13
i386         buildonly-randconfig-006-20240707   gcc-13
i386                                defconfig   clang-18
i386                  randconfig-001-20240707   gcc-13
i386                  randconfig-002-20240707   gcc-13
i386                  randconfig-003-20240707   gcc-13
i386                  randconfig-004-20240707   gcc-13
i386                  randconfig-005-20240707   gcc-13
i386                  randconfig-006-20240707   gcc-13
i386                  randconfig-011-20240707   gcc-13
i386                  randconfig-012-20240707   gcc-13
i386                  randconfig-013-20240707   gcc-13
i386                  randconfig-014-20240707   gcc-13
i386                  randconfig-015-20240707   gcc-13
i386                  randconfig-016-20240707   gcc-13
loongarch                        allmodconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240707   gcc-13.2.0
loongarch             randconfig-002-20240707   gcc-13.2.0
m68k                             alldefconfig   gcc-13.2.0
m68k                             allmodconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-13.2.0
m68k                                defconfig   gcc-13.2.0
m68k                       m5275evb_defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-13.2.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                          ath25_defconfig   gcc-13.2.0
mips                     cu1830-neo_defconfig   gcc-13.2.0
mips                            gpr_defconfig   gcc-13.2.0
mips                           ip27_defconfig   gcc-13.2.0
mips                           ip28_defconfig   gcc-13.2.0
mips                       lemote2f_defconfig   gcc-13.2.0
mips                     loongson1c_defconfig   clang-19
mips                      loongson3_defconfig   gcc-13.2.0
mips                  maltasmvp_eva_defconfig   gcc-13.2.0
mips                      pic32mzda_defconfig   clang-19
mips                          rb532_defconfig   clang-19
mips                        vocore2_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240707   gcc-13.2.0
nios2                 randconfig-002-20240707   gcc-13.2.0
openrisc                         alldefconfig   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                         allyesconfig   gcc-13.2.0
openrisc                            defconfig   gcc-13.2.0
parisc                           allmodconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                           allyesconfig   gcc-13.2.0
parisc                              defconfig   gcc-13.2.0
parisc                generic-64bit_defconfig   gcc-13.2.0
parisc                randconfig-001-20240707   gcc-13.2.0
parisc                randconfig-002-20240707   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc                          allyesconfig   gcc-13.2.0
powerpc                        cell_defconfig   clang-19
powerpc                   currituck_defconfig   clang-19
powerpc                  iss476-smp_defconfig   gcc-13.2.0
powerpc                      katmai_defconfig   gcc-13.2.0
powerpc                     ksi8560_defconfig   gcc-13.2.0
powerpc                   microwatt_defconfig   gcc-13.2.0
powerpc                 mpc8315_rdb_defconfig   gcc-13.2.0
powerpc                     mpc83xx_defconfig   clang-19
powerpc                     mpc83xx_defconfig   gcc-13.2.0
powerpc                  mpc866_ads_defconfig   gcc-13.2.0
powerpc                      ppc6xx_defconfig   gcc-13.2.0
powerpc                     rainier_defconfig   gcc-13.2.0
powerpc               randconfig-001-20240707   gcc-13.2.0
powerpc               randconfig-002-20240707   gcc-13.2.0
powerpc               randconfig-003-20240707   gcc-13.2.0
powerpc                     taishan_defconfig   gcc-13.2.0
powerpc                     tqm5200_defconfig   gcc-13.2.0
powerpc                     tqm8541_defconfig   gcc-13.2.0
powerpc64             randconfig-001-20240707   gcc-13.2.0
powerpc64             randconfig-002-20240707   gcc-13.2.0
powerpc64             randconfig-003-20240707   gcc-13.2.0
riscv                            allmodconfig   gcc-13.2.0
riscv                             allnoconfig   gcc-13.2.0
riscv                            allyesconfig   gcc-13.2.0
riscv                               defconfig   gcc-13.2.0
riscv                 randconfig-001-20240707   gcc-13.2.0
riscv                 randconfig-002-20240707   gcc-13.2.0
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                             allyesconfig   clang-19
s390                             allyesconfig   gcc-13.2.0
s390                                defconfig   gcc-13.2.0
s390                  randconfig-001-20240707   gcc-13.2.0
s390                  randconfig-002-20240707   gcc-13.2.0
sh                               allmodconfig   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                               allyesconfig   gcc-13.2.0
sh                                  defconfig   gcc-13.2.0
sh                         ecovec24_defconfig   gcc-13.2.0
sh                        edosk7705_defconfig   gcc-13.2.0
sh                             espt_defconfig   gcc-13.2.0
sh                    randconfig-001-20240707   gcc-13.2.0
sh                    randconfig-002-20240707   gcc-13.2.0
sh                      rts7751r2d1_defconfig   gcc-13.2.0
sh                           se7619_defconfig   gcc-13.2.0
sh                           se7705_defconfig   gcc-13.2.0
sh                   secureedge5410_defconfig   gcc-13.2.0
sh                        sh7757lcr_defconfig   gcc-13.2.0
sh                        sh7785lcr_defconfig   gcc-13.2.0
sh                              ul2_defconfig   gcc-13.2.0
sparc                            allmodconfig   gcc-13.2.0
sparc64                             defconfig   gcc-13.2.0
sparc64               randconfig-001-20240707   gcc-13.2.0
sparc64               randconfig-002-20240707   gcc-13.2.0
um                               alldefconfig   gcc-13.2.0
um                               allmodconfig   gcc-13.2.0
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-13.2.0
um                                  defconfig   gcc-13.2.0
um                             i386_defconfig   gcc-13.2.0
um                    randconfig-001-20240707   gcc-13.2.0
um                    randconfig-002-20240707   gcc-13.2.0
um                           x86_64_defconfig   gcc-13.2.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240707   gcc-13
x86_64       buildonly-randconfig-001-20240708   gcc-13
x86_64       buildonly-randconfig-002-20240707   gcc-13
x86_64       buildonly-randconfig-002-20240708   gcc-13
x86_64       buildonly-randconfig-003-20240707   gcc-13
x86_64       buildonly-randconfig-003-20240708   gcc-13
x86_64       buildonly-randconfig-004-20240707   gcc-13
x86_64       buildonly-randconfig-004-20240708   gcc-13
x86_64       buildonly-randconfig-005-20240707   gcc-13
x86_64       buildonly-randconfig-005-20240708   gcc-13
x86_64       buildonly-randconfig-006-20240707   gcc-13
x86_64       buildonly-randconfig-006-20240708   gcc-13
x86_64                              defconfig   clang-18
x86_64                randconfig-001-20240707   gcc-13
x86_64                randconfig-001-20240708   gcc-13
x86_64                randconfig-002-20240707   gcc-13
x86_64                randconfig-002-20240708   gcc-13
x86_64                randconfig-003-20240707   gcc-13
x86_64                randconfig-003-20240708   gcc-13
x86_64                randconfig-004-20240707   gcc-13
x86_64                randconfig-004-20240708   gcc-13
x86_64                randconfig-005-20240707   gcc-13
x86_64                randconfig-005-20240708   gcc-13
x86_64                randconfig-006-20240707   gcc-13
x86_64                randconfig-006-20240708   gcc-13
x86_64                randconfig-011-20240707   gcc-13
x86_64                randconfig-011-20240708   gcc-13
x86_64                randconfig-012-20240707   gcc-13
x86_64                randconfig-012-20240708   gcc-13
x86_64                randconfig-013-20240707   gcc-13
x86_64                randconfig-013-20240708   gcc-13
x86_64                randconfig-014-20240707   gcc-13
x86_64                randconfig-014-20240708   gcc-13
x86_64                randconfig-015-20240707   gcc-13
x86_64                randconfig-015-20240708   gcc-13
x86_64                randconfig-016-20240707   gcc-13
x86_64                randconfig-016-20240708   gcc-13
x86_64                randconfig-071-20240707   gcc-13
x86_64                randconfig-071-20240708   gcc-13
x86_64                randconfig-072-20240707   gcc-13
x86_64                randconfig-072-20240708   gcc-13
x86_64                randconfig-073-20240707   gcc-13
x86_64                randconfig-073-20240708   gcc-13
x86_64                randconfig-074-20240707   gcc-13
x86_64                randconfig-074-20240708   gcc-13
x86_64                randconfig-075-20240707   gcc-13
x86_64                randconfig-075-20240708   gcc-13
x86_64                randconfig-076-20240707   gcc-13
x86_64                randconfig-076-20240708   gcc-13
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                  cadence_csp_defconfig   gcc-13.2.0
xtensa                randconfig-001-20240707   gcc-13.2.0
xtensa                randconfig-002-20240707   gcc-13.2.0
xtensa                    smp_lx200_defconfig   gcc-13.2.0
xtensa                    xip_kc705_defconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

