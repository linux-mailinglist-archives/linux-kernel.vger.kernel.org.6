Return-Path: <linux-kernel+bounces-243743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A549299F5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 00:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A79D52810D7
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 22:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018EB57CB0;
	Sun,  7 Jul 2024 22:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T32aptSV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEC012E55
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jul 2024 22:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720391052; cv=none; b=jFI83JMancBi/VNiP9Ia5cMxZLwVEgeEY4aRQcZETfMuNKGXBcZ1x/v0jSZrvJBknl6U4nybvkwNDKwwYr7kdNHCcNQWZBjvZSZ2zy/6LZsqSrIwDGy31haD66pIx4EHTJNfGsKOxVMljsu4+AborYnWpNNYcr+2hRz5wXljJvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720391052; c=relaxed/simple;
	bh=/ux7O/bgNeizvgczzgkpmbb3WKmyP8YTTGk9bAiuxeU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=HCf0v41cIEsNuVG2kzu09gzppVOKRn6FVKHa0Tmb8TOwCXugj+l2lLMTpAqfwbbSDj0wHXxBnocfOfmQ8G3OvTmk1oQYBi1XjBW1s1BfrSL2Vfg5IzTwlAhBk60S/XYf3mNgWo7CBFpbXYgcf8L2xIH5NxUvPjj9SXTXvVUNCF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T32aptSV; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720391051; x=1751927051;
  h=date:from:to:cc:subject:message-id;
  bh=/ux7O/bgNeizvgczzgkpmbb3WKmyP8YTTGk9bAiuxeU=;
  b=T32aptSVmVjOrDUNXizINOmvWWKh0ekSBxWjDxzyFuy4JjFKmeU4SyiU
   dpmZHXA2JP+89RG/0QaFaMQgq7PfMegjGsPsW/NfTYNv6LW168IcPlUDN
   rDhWoVY1/+9QXHZlxD91WZos8+ZxIQCzcUFX28XGkQuoxxNjh9BRs6/zi
   Jfl1O4QZiWUD90fidvLWAUCJSJp3OPBNhTolkQXfYaW7DwtB9ASrLNl6o
   xbN1myF201VRYf/FgOyTim2B3unvmKYHzqWkJp2gW8tyTvHASuY/b1cFL
   Lm/43V++8w9tF+LounlXnUl8gf7Sznj+jBEBKcp5bmmwpBW8rYg96xyTR
   w==;
X-CSE-ConnectionGUID: j3oQNp5CTbWunT9K5rPwrQ==
X-CSE-MsgGUID: xO+2luPMQu6Tnkug+mv0qQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11126"; a="21352568"
X-IronPort-AV: E=Sophos;i="6.09,190,1716274800"; 
   d="scan'208";a="21352568"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2024 15:24:10 -0700
X-CSE-ConnectionGUID: 1sNN0pAPRj26usdjJjUNOQ==
X-CSE-MsgGUID: LcX7yRK/QyesB+JU4WRrGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,190,1716274800"; 
   d="scan'208";a="48064285"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 07 Jul 2024 15:24:09 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sQaIg-000VJu-2g;
	Sun, 07 Jul 2024 22:24:06 +0000
Date: Mon, 08 Jul 2024 06:23:34 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2024.07.04b] BUILD SUCCESS
 1b4b924e7b89e264f7caef47a420bd5e895956d3
Message-ID: <202407080631.bLtjCxwX-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://github.com/paulmckrcu/linux dev.2024.07.04b
branch HEAD: 1b4b924e7b89e264f7caef47a420bd5e895956d3  refscale: Add TINY scenario

elapsed time: 1035m

configs tested: 269
configs skipped: 7

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
arm                               allnoconfig   clang-19
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                        clps711x_defconfig   gcc-13.2.0
arm                                 defconfig   gcc-13.2.0
arm                            dove_defconfig   gcc-13.2.0
arm                          exynos_defconfig   gcc-13.2.0
arm                          gemini_defconfig   gcc-13.2.0
arm                            hisi_defconfig   gcc-13.2.0
arm                       netwinder_defconfig   gcc-13.2.0
arm                         nhk8815_defconfig   gcc-13.2.0
arm                       omap2plus_defconfig   gcc-13.2.0
arm                   randconfig-001-20240707   gcc-13.2.0
arm                   randconfig-002-20240707   clang-19
arm                   randconfig-002-20240707   gcc-13.2.0
arm                   randconfig-003-20240707   clang-19
arm                   randconfig-003-20240707   gcc-13.2.0
arm                   randconfig-004-20240707   clang-19
arm                   randconfig-004-20240707   gcc-13.2.0
arm                        realview_defconfig   gcc-13.2.0
arm                           sama5_defconfig   gcc-13.2.0
arm64                            alldefconfig   gcc-13.2.0
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240707   clang-19
arm64                 randconfig-001-20240707   gcc-13.2.0
arm64                 randconfig-002-20240707   gcc-13.2.0
arm64                 randconfig-003-20240707   gcc-13.2.0
arm64                 randconfig-004-20240707   clang-19
arm64                 randconfig-004-20240707   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240707   gcc-13.2.0
csky                  randconfig-002-20240707   gcc-13.2.0
hexagon                          allmodconfig   clang-19
hexagon                           allnoconfig   clang-19
hexagon                          allyesconfig   clang-19
hexagon               randconfig-001-20240707   clang-14
hexagon               randconfig-002-20240707   clang-19
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-13
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-13
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240707   gcc-13
i386         buildonly-randconfig-002-20240707   clang-18
i386         buildonly-randconfig-002-20240707   gcc-13
i386         buildonly-randconfig-003-20240707   clang-18
i386         buildonly-randconfig-003-20240707   gcc-13
i386         buildonly-randconfig-004-20240707   gcc-13
i386         buildonly-randconfig-005-20240707   gcc-11
i386         buildonly-randconfig-005-20240707   gcc-13
i386         buildonly-randconfig-006-20240707   gcc-13
i386         buildonly-randconfig-006-20240707   gcc-9
i386                                defconfig   clang-18
i386                  randconfig-001-20240707   gcc-13
i386                  randconfig-001-20240707   gcc-7
i386                  randconfig-002-20240707   clang-18
i386                  randconfig-002-20240707   gcc-13
i386                  randconfig-003-20240707   clang-18
i386                  randconfig-003-20240707   gcc-13
i386                  randconfig-004-20240707   clang-18
i386                  randconfig-004-20240707   gcc-13
i386                  randconfig-005-20240707   clang-18
i386                  randconfig-005-20240707   gcc-13
i386                  randconfig-006-20240707   clang-18
i386                  randconfig-006-20240707   gcc-13
i386                  randconfig-011-20240707   gcc-13
i386                  randconfig-012-20240707   gcc-13
i386                  randconfig-012-20240707   gcc-8
i386                  randconfig-013-20240707   gcc-13
i386                  randconfig-014-20240707   clang-18
i386                  randconfig-014-20240707   gcc-13
i386                  randconfig-015-20240707   clang-18
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
mips                      loongson3_defconfig   gcc-13.2.0
mips                  maltasmvp_eva_defconfig   gcc-13.2.0
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
powerpc                          allyesconfig   clang-19
powerpc                          allyesconfig   gcc-13.2.0
powerpc                  iss476-smp_defconfig   gcc-13.2.0
powerpc                      katmai_defconfig   gcc-13.2.0
powerpc                     ksi8560_defconfig   gcc-13.2.0
powerpc                   microwatt_defconfig   gcc-13.2.0
powerpc                 mpc8315_rdb_defconfig   gcc-13.2.0
powerpc                     mpc83xx_defconfig   gcc-13.2.0
powerpc                  mpc866_ads_defconfig   gcc-13.2.0
powerpc                      ppc6xx_defconfig   gcc-13.2.0
powerpc                     rainier_defconfig   gcc-13.2.0
powerpc               randconfig-001-20240707   clang-19
powerpc               randconfig-001-20240707   gcc-13.2.0
powerpc               randconfig-002-20240707   gcc-13.2.0
powerpc               randconfig-003-20240707   clang-19
powerpc               randconfig-003-20240707   gcc-13.2.0
powerpc                     taishan_defconfig   gcc-13.2.0
powerpc                     tqm5200_defconfig   gcc-13.2.0
powerpc                     tqm8541_defconfig   gcc-13.2.0
powerpc64             randconfig-001-20240707   clang-17
powerpc64             randconfig-001-20240707   gcc-13.2.0
powerpc64             randconfig-002-20240707   clang-19
powerpc64             randconfig-002-20240707   gcc-13.2.0
powerpc64             randconfig-003-20240707   clang-19
powerpc64             randconfig-003-20240707   gcc-13.2.0
riscv                            allmodconfig   clang-19
riscv                            allmodconfig   gcc-13.2.0
riscv                             allnoconfig   gcc-13.2.0
riscv                            allyesconfig   clang-19
riscv                            allyesconfig   gcc-13.2.0
riscv                               defconfig   clang-19
riscv                               defconfig   gcc-13.2.0
riscv                 randconfig-001-20240707   clang-15
riscv                 randconfig-001-20240707   gcc-13.2.0
riscv                 randconfig-002-20240707   clang-19
riscv                 randconfig-002-20240707   gcc-13.2.0
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                             allyesconfig   clang-19
s390                             allyesconfig   gcc-13.2.0
s390                                defconfig   clang-19
s390                                defconfig   gcc-13.2.0
s390                  randconfig-001-20240707   gcc-13.2.0
s390                  randconfig-002-20240707   clang-19
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
um                               allmodconfig   clang-19
um                               allmodconfig   gcc-13.2.0
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-13
um                               allyesconfig   gcc-13.2.0
um                                  defconfig   clang-19
um                                  defconfig   gcc-13.2.0
um                             i386_defconfig   gcc-13
um                             i386_defconfig   gcc-13.2.0
um                    randconfig-001-20240707   clang-19
um                    randconfig-001-20240707   gcc-13.2.0
um                    randconfig-002-20240707   gcc-11
um                    randconfig-002-20240707   gcc-13.2.0
um                           x86_64_defconfig   clang-15
um                           x86_64_defconfig   gcc-13.2.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240707   gcc-13
x86_64       buildonly-randconfig-002-20240707   gcc-13
x86_64       buildonly-randconfig-003-20240707   clang-18
x86_64       buildonly-randconfig-003-20240707   gcc-13
x86_64       buildonly-randconfig-004-20240707   gcc-13
x86_64       buildonly-randconfig-005-20240707   clang-18
x86_64       buildonly-randconfig-005-20240707   gcc-13
x86_64       buildonly-randconfig-006-20240707   clang-18
x86_64       buildonly-randconfig-006-20240707   gcc-13
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240707   clang-18
x86_64                randconfig-001-20240707   gcc-13
x86_64                randconfig-002-20240707   clang-18
x86_64                randconfig-002-20240707   gcc-13
x86_64                randconfig-003-20240707   clang-18
x86_64                randconfig-003-20240707   gcc-13
x86_64                randconfig-004-20240707   clang-18
x86_64                randconfig-004-20240707   gcc-13
x86_64                randconfig-005-20240707   gcc-13
x86_64                randconfig-006-20240707   gcc-12
x86_64                randconfig-006-20240707   gcc-13
x86_64                randconfig-011-20240707   clang-18
x86_64                randconfig-011-20240707   gcc-13
x86_64                randconfig-012-20240707   gcc-13
x86_64                randconfig-012-20240707   gcc-7
x86_64                randconfig-013-20240707   clang-18
x86_64                randconfig-013-20240707   gcc-13
x86_64                randconfig-014-20240707   gcc-13
x86_64                randconfig-015-20240707   gcc-13
x86_64                randconfig-015-20240707   gcc-7
x86_64                randconfig-016-20240707   clang-18
x86_64                randconfig-016-20240707   gcc-13
x86_64                randconfig-071-20240707   gcc-13
x86_64                randconfig-072-20240707   gcc-13
x86_64                randconfig-072-20240707   gcc-7
x86_64                randconfig-073-20240707   clang-18
x86_64                randconfig-073-20240707   gcc-13
x86_64                randconfig-074-20240707   clang-18
x86_64                randconfig-074-20240707   gcc-13
x86_64                randconfig-075-20240707   clang-18
x86_64                randconfig-075-20240707   gcc-13
x86_64                randconfig-076-20240707   gcc-13
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

