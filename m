Return-Path: <linux-kernel+bounces-256650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44315935180
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 20:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C40FC284703
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 18:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97CF452F9B;
	Thu, 18 Jul 2024 18:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c1ao4cBu"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9797822EE5
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 18:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721326312; cv=none; b=NLLS78Ymn8jfMIX1hiD5LhO8Zt4z9x3IgUTzWuND4YxEFY+gKwhrDCnEyU7b81ZOU33Vyur7bLq9V3ccxBtSGZAm8iUs5qaXLB74A1nc19ehjCwFzjCrlNhZgkzfbNz7XfTF+x6fWyU7mk6KLIwNNNdxaqNIwsm5Uaa8d3NkKGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721326312; c=relaxed/simple;
	bh=e93xk5H2iAP+mOKvWY1slauixZ0lmo9KFz55CdQfLGA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=GM+QIo77pJO/kGNKtXKXznqZsF+UM2rydO8PTLAqMdxzhVwPatbW5r7CfpiLWfoj7wgFkBmIBfWPdrUd0rQXWZ6JnguKUmLCJKU8GVdqV1OqCH10ixFd4ZDnHFTfW/0LcuWcfxl6dG8NN2Bgo5QnoGZbFO3f5PQMjYgHlRec3cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c1ao4cBu; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721326311; x=1752862311;
  h=date:from:to:cc:subject:message-id;
  bh=e93xk5H2iAP+mOKvWY1slauixZ0lmo9KFz55CdQfLGA=;
  b=c1ao4cBugti6fdNC52rdCC2/VM7cx8JvFGPSOTttq4Kn8apuVvz8Tt+Y
   hU3YmnkDEHg9hLPGXEoS4tRHMSkGyAk1ITxtthAvV3Ehg0pHzk0PJ1p+B
   PzKnCEGAOyabiQRcGrpMCNQdHIR+dRq74Xint26VtuMIMhDRyVOxtLNAZ
   /pAX/2ENJXKsJYcpe1ohFwx6/38FIqA+3M3l4JpN5EZIylveOdN8k31Rq
   J7lSnwg/rsHdlmx3q1ao3XhQpxUerTRHPTTZ/MnPisWNFo5xmeuNRyHsT
   pXXEIzOwe0WXARykdlZ+M6APnW7iPLcAPDk3ACeEz7nh2IYjIn/ISTyk3
   g==;
X-CSE-ConnectionGUID: hSRgGw/TQOGZXcz+QizLeA==
X-CSE-MsgGUID: g4NnWKmHSsCiYwc74EJwcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11137"; a="18869407"
X-IronPort-AV: E=Sophos;i="6.09,218,1716274800"; 
   d="scan'208";a="18869407"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2024 11:11:51 -0700
X-CSE-ConnectionGUID: TElc5mO9SG2hReCF8C/GYQ==
X-CSE-MsgGUID: b/BcYmk9TsCgOHD9pAVpYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,218,1716274800"; 
   d="scan'208";a="55716922"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 18 Jul 2024 11:11:49 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sUVbW-000hV8-2m;
	Thu, 18 Jul 2024 18:11:46 +0000
Date: Fri, 19 Jul 2024 02:11:36 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2024.07.11a] BUILD REGRESSION
 2c5a7c46f900887cd4204d634896ed4fbb9aaafd
Message-ID: <202407190233.YP4t7qND-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2024.07.11a
branch HEAD: 2c5a7c46f900887cd4204d634896ed4fbb9aaafd  squash! EXP rcuscale: Dump debug info

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202407180545.iMSf0giu-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

rcuscale.c:(.text+0x77b): undefined reference to `rcu_tasks_trace_torture_stats_print'
rcuscale.c:(.text+0x8c3): undefined reference to `rcu_tasks_rude_torture_stats_print'
rcuscale.c:(.text+0x8e3): undefined reference to `rcu_tasks_torture_stats_print'

Error/Warning ids grouped by kconfigs:

recent_errors
`-- i386-buildonly-randconfig-003-20240718
    |-- rcuscale.c:(.text):undefined-reference-to-rcu_tasks_rude_torture_stats_print
    |-- rcuscale.c:(.text):undefined-reference-to-rcu_tasks_torture_stats_print
    `-- rcuscale.c:(.text):undefined-reference-to-rcu_tasks_trace_torture_stats_print

elapsed time: 1458m

configs tested: 204
configs skipped: 7

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240718   gcc-13.2.0
arc                   randconfig-002-20240718   gcc-13.2.0
arc                           tb10x_defconfig   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                               allnoconfig   clang-19
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                         bcm2835_defconfig   gcc-13.2.0
arm                                 defconfig   gcc-13.2.0
arm                          gemini_defconfig   gcc-13.2.0
arm                   randconfig-001-20240718   gcc-13.2.0
arm                   randconfig-002-20240718   gcc-13.2.0
arm                   randconfig-003-20240718   gcc-13.2.0
arm                   randconfig-004-20240718   gcc-13.2.0
arm                         s3c6400_defconfig   gcc-13.2.0
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240718   gcc-13.2.0
arm64                 randconfig-002-20240718   gcc-13.2.0
arm64                 randconfig-003-20240718   gcc-13.2.0
arm64                 randconfig-004-20240718   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240718   gcc-13.2.0
csky                  randconfig-002-20240718   gcc-13.2.0
hexagon                          allmodconfig   clang-19
hexagon                           allnoconfig   clang-19
hexagon                          allyesconfig   clang-19
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-13
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-13
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240718   gcc-11
i386         buildonly-randconfig-002-20240718   gcc-11
i386         buildonly-randconfig-002-20240718   gcc-7
i386         buildonly-randconfig-003-20240718   gcc-11
i386         buildonly-randconfig-003-20240718   gcc-13
i386         buildonly-randconfig-004-20240718   clang-18
i386         buildonly-randconfig-004-20240718   gcc-11
i386         buildonly-randconfig-005-20240718   gcc-11
i386         buildonly-randconfig-005-20240718   gcc-9
i386         buildonly-randconfig-006-20240718   gcc-11
i386         buildonly-randconfig-006-20240718   gcc-13
i386                                defconfig   clang-18
i386                  randconfig-001-20240718   gcc-11
i386                  randconfig-001-20240718   gcc-13
i386                  randconfig-002-20240718   gcc-11
i386                  randconfig-002-20240718   gcc-13
i386                  randconfig-003-20240718   clang-18
i386                  randconfig-003-20240718   gcc-11
i386                  randconfig-004-20240718   clang-18
i386                  randconfig-004-20240718   gcc-11
i386                  randconfig-005-20240718   clang-18
i386                  randconfig-005-20240718   gcc-11
i386                  randconfig-006-20240718   clang-18
i386                  randconfig-006-20240718   gcc-11
i386                  randconfig-011-20240718   gcc-11
i386                  randconfig-011-20240718   gcc-13
i386                  randconfig-012-20240718   gcc-11
i386                  randconfig-012-20240718   gcc-13
i386                  randconfig-013-20240718   gcc-10
i386                  randconfig-013-20240718   gcc-11
i386                  randconfig-014-20240718   clang-18
i386                  randconfig-014-20240718   gcc-11
i386                  randconfig-015-20240718   clang-18
i386                  randconfig-015-20240718   gcc-11
i386                  randconfig-016-20240718   gcc-11
i386                  randconfig-016-20240718   gcc-13
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240718   gcc-13.2.0
loongarch             randconfig-002-20240718   gcc-13.2.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-14.1.0
mips                           xway_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240718   gcc-13.2.0
nios2                 randconfig-002-20240718   gcc-13.2.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240718   gcc-13.2.0
parisc                randconfig-002-20240718   gcc-13.2.0
parisc64                         alldefconfig   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-19
powerpc                          allyesconfig   gcc-14.1.0
powerpc                       ebony_defconfig   gcc-13.2.0
powerpc                    gamecube_defconfig   gcc-13.2.0
powerpc                 mpc834x_itx_defconfig   gcc-13.2.0
powerpc               randconfig-001-20240718   gcc-13.2.0
powerpc               randconfig-002-20240718   gcc-13.2.0
powerpc               randconfig-003-20240718   gcc-13.2.0
powerpc64             randconfig-001-20240718   gcc-13.2.0
powerpc64             randconfig-002-20240718   gcc-13.2.0
powerpc64             randconfig-003-20240718   gcc-13.2.0
riscv                            allmodconfig   clang-19
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-19
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-14.1.0
riscv                 randconfig-001-20240718   gcc-13.2.0
riscv                 randconfig-002-20240718   gcc-13.2.0
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-19
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240718   gcc-13.2.0
s390                  randconfig-002-20240718   gcc-13.2.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                        dreamcast_defconfig   gcc-13.2.0
sh                            migor_defconfig   gcc-13.2.0
sh                    randconfig-001-20240718   gcc-13.2.0
sh                    randconfig-002-20240718   gcc-13.2.0
sh                   rts7751r2dplus_defconfig   gcc-13.2.0
sh                  sh7785lcr_32bit_defconfig   gcc-13.2.0
sparc                       sparc32_defconfig   gcc-13.2.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240718   gcc-13.2.0
sparc64               randconfig-002-20240718   gcc-13.2.0
um                               allmodconfig   clang-19
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-13
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240718   gcc-13.2.0
um                    randconfig-002-20240718   gcc-13.2.0
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240718   gcc-11
x86_64       buildonly-randconfig-002-20240718   gcc-11
x86_64       buildonly-randconfig-003-20240718   gcc-11
x86_64       buildonly-randconfig-004-20240718   gcc-11
x86_64       buildonly-randconfig-005-20240718   gcc-11
x86_64       buildonly-randconfig-006-20240718   gcc-11
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240718   gcc-11
x86_64                randconfig-002-20240718   gcc-11
x86_64                randconfig-003-20240718   gcc-11
x86_64                randconfig-004-20240718   gcc-11
x86_64                randconfig-005-20240718   gcc-11
x86_64                randconfig-006-20240718   gcc-11
x86_64                randconfig-011-20240718   gcc-11
x86_64                randconfig-012-20240718   gcc-11
x86_64                randconfig-013-20240718   gcc-11
x86_64                randconfig-014-20240718   gcc-11
x86_64                randconfig-015-20240718   gcc-11
x86_64                randconfig-016-20240718   gcc-11
x86_64                randconfig-071-20240718   gcc-11
x86_64                randconfig-072-20240718   gcc-11
x86_64                randconfig-073-20240718   gcc-11
x86_64                randconfig-074-20240718   gcc-11
x86_64                randconfig-075-20240718   gcc-11
x86_64                randconfig-076-20240718   gcc-11
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240718   gcc-13.2.0
xtensa                randconfig-002-20240718   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

