Return-Path: <linux-kernel+bounces-300039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81DDA95DE03
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 15:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06B131F22252
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 13:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3E71714C3;
	Sat, 24 Aug 2024 13:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dp4jW30+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BB3157A6C
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 13:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724505487; cv=none; b=UW84fegv3fB9//U85d3JVRr96ZmxPYcyhwkmnWQTDr0KMr1K+3zyAva5Sj295W7wkCvA1Qs0zkK1T8prT6hJg6gRAWV/P1N2Gg6WLHvUZNtrm6e0HSijXvBaZPOwhTbPkLjJGO6NnZAOBGJZZQ/wGrCsG7q6ZTL2bg5xJ064BLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724505487; c=relaxed/simple;
	bh=BI8iZz2TXFQLlqQj+ncjAIZk5qB2fG8bzX8HijAe544=;
	h=Date:From:To:Cc:Subject:Message-ID; b=TpgvdB1yVjUQOZRjjiiB6fWl+85Ptp2K+yJZVsc1Jb0GeEuvsmFSnO8deVp0we3rq7LNFrBtB55lvNELN08tbvWSsG3zg4XKLzdxkyL1zOrlfZwnzvjNsHBdgqXblckexfaR9y4Kzfquc4+QwdDv8TsLdaZdqR56Nfl0KTjo+RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dp4jW30+; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724505486; x=1756041486;
  h=date:from:to:cc:subject:message-id;
  bh=BI8iZz2TXFQLlqQj+ncjAIZk5qB2fG8bzX8HijAe544=;
  b=Dp4jW30+A8YolPCuccGj8JO96R7TXBFv04HLg03EktxKo8ZAe7E67HuN
   KMIkspBX8d0DZrZQU5H9FcfiQzCa1BRVqR1Vga4Xfwtl65P9Byds7TDQU
   2ko/w6C8brvhFM+OVFRQ9fQNgLMgKKn89b2RXQMsEq9t12511f85cGuSW
   nean9/h21MWnzHjxLcFwgk+FDyG2TxcZkBm1wjvMcKwRer7yBJ5R89vn3
   7WkWmh78sMJYtv81kef9JwsXAJMrBLMulZMvNYKcStvGdqeoPFs9trB8F
   r9A57+Bh2rsslDV4EYu1NP4cyuxM6tU7dCzq5xEtDyiFSYg1dmm4d1mwm
   w==;
X-CSE-ConnectionGUID: Ciew5l9lRDCwW+j9a0WEBA==
X-CSE-MsgGUID: j68fdzZQRcWrYf3tP6HKhA==
X-IronPort-AV: E=McAfee;i="6700,10204,11173"; a="45496697"
X-IronPort-AV: E=Sophos;i="6.10,173,1719903600"; 
   d="scan'208";a="45496697"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2024 06:18:05 -0700
X-CSE-ConnectionGUID: 2c97dDquS8WjlV9lR+BHaQ==
X-CSE-MsgGUID: po4AVZ8iQ/KrRRKEWCn6QQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,173,1719903600"; 
   d="scan'208";a="66267002"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 24 Aug 2024 06:18:04 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1shqeX-000EU5-10;
	Sat, 24 Aug 2024 13:18:01 +0000
Date: Sat, 24 Aug 2024 21:17:10 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:irq/urgent] BUILD SUCCESS
 880799fc7a3a127c43143935c1a8767d77c19cae
Message-ID: <202408242108.biGXiX1c-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/urgent
branch HEAD: 880799fc7a3a127c43143935c1a8767d77c19cae  irqchip/irq-msi-lib: Check for NULL ops in msi_lib_irq_domain_select()

elapsed time: 1450m

configs tested: 161
configs skipped: 8

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
arc                   randconfig-001-20240824   gcc-13.2.0
arc                   randconfig-002-20240824   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                       aspeed_g4_defconfig   clang-20
arm                                 defconfig   gcc-13.2.0
arm                          gemini_defconfig   clang-20
arm                      integrator_defconfig   clang-20
arm                        mvebu_v5_defconfig   clang-20
arm                   randconfig-001-20240824   gcc-13.2.0
arm                   randconfig-002-20240824   gcc-13.2.0
arm                   randconfig-003-20240824   gcc-13.2.0
arm                   randconfig-004-20240824   gcc-13.2.0
arm                           spitz_defconfig   clang-20
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240824   gcc-13.2.0
arm64                 randconfig-002-20240824   gcc-13.2.0
arm64                 randconfig-003-20240824   gcc-13.2.0
arm64                 randconfig-004-20240824   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240824   gcc-13.2.0
csky                  randconfig-002-20240824   gcc-13.2.0
i386                             allmodconfig   clang-18
i386                              allnoconfig   clang-18
i386                             allyesconfig   clang-18
i386         buildonly-randconfig-001-20240824   clang-18
i386         buildonly-randconfig-002-20240824   clang-18
i386         buildonly-randconfig-003-20240824   clang-18
i386         buildonly-randconfig-004-20240824   clang-18
i386         buildonly-randconfig-005-20240824   clang-18
i386         buildonly-randconfig-006-20240824   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240824   clang-18
i386                  randconfig-002-20240824   clang-18
i386                  randconfig-003-20240824   clang-18
i386                  randconfig-004-20240824   clang-18
i386                  randconfig-005-20240824   clang-18
i386                  randconfig-006-20240824   clang-18
i386                  randconfig-011-20240824   clang-18
i386                  randconfig-012-20240824   clang-18
i386                  randconfig-013-20240824   clang-18
i386                  randconfig-014-20240824   clang-18
i386                  randconfig-015-20240824   clang-18
i386                  randconfig-016-20240824   clang-18
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240824   gcc-13.2.0
loongarch             randconfig-002-20240824   gcc-13.2.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                         cobalt_defconfig   clang-20
mips                          rb532_defconfig   clang-20
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240824   gcc-13.2.0
nios2                 randconfig-002-20240824   gcc-13.2.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240824   gcc-13.2.0
parisc                randconfig-002-20240824   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   gcc-14.1.0
powerpc                      cm5200_defconfig   clang-20
powerpc                     ep8248e_defconfig   clang-20
powerpc                    gamecube_defconfig   clang-20
powerpc                      katmai_defconfig   clang-20
powerpc                      pasemi_defconfig   clang-20
powerpc                      pcm030_defconfig   clang-20
powerpc                      ppc64e_defconfig   clang-20
powerpc               randconfig-001-20240824   gcc-13.2.0
powerpc                     tqm8548_defconfig   clang-20
powerpc                     tqm8555_defconfig   clang-20
powerpc                         wii_defconfig   clang-20
powerpc64             randconfig-001-20240824   gcc-13.2.0
powerpc64             randconfig-002-20240824   gcc-13.2.0
powerpc64             randconfig-003-20240824   gcc-13.2.0
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-14.1.0
riscv                 randconfig-001-20240824   gcc-13.2.0
riscv                 randconfig-002-20240824   gcc-13.2.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-20
s390                          debug_defconfig   clang-20
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240824   gcc-13.2.0
s390                  randconfig-002-20240824   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                                  defconfig   gcc-14.1.0
sh                    randconfig-001-20240824   gcc-13.2.0
sh                    randconfig-002-20240824   gcc-13.2.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240824   gcc-13.2.0
sparc64               randconfig-002-20240824   gcc-13.2.0
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240824   gcc-13.2.0
um                    randconfig-002-20240824   gcc-13.2.0
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240824   clang-18
x86_64       buildonly-randconfig-002-20240824   clang-18
x86_64       buildonly-randconfig-003-20240824   clang-18
x86_64       buildonly-randconfig-004-20240824   clang-18
x86_64       buildonly-randconfig-005-20240824   clang-18
x86_64       buildonly-randconfig-006-20240824   clang-18
x86_64                              defconfig   clang-18
x86_64                randconfig-001-20240824   clang-18
x86_64                randconfig-002-20240824   clang-18
x86_64                randconfig-003-20240824   clang-18
x86_64                randconfig-004-20240824   clang-18
x86_64                randconfig-005-20240824   clang-18
x86_64                randconfig-006-20240824   clang-18
x86_64                randconfig-011-20240824   clang-18
x86_64                randconfig-012-20240824   clang-18
x86_64                randconfig-013-20240824   clang-18
x86_64                randconfig-014-20240824   clang-18
x86_64                randconfig-015-20240824   clang-18
x86_64                randconfig-016-20240824   clang-18
x86_64                randconfig-071-20240824   clang-18
x86_64                randconfig-072-20240824   clang-18
x86_64                randconfig-073-20240824   clang-18
x86_64                randconfig-074-20240824   clang-18
x86_64                randconfig-075-20240824   clang-18
x86_64                randconfig-076-20240824   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                randconfig-001-20240824   gcc-13.2.0
xtensa                randconfig-002-20240824   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

