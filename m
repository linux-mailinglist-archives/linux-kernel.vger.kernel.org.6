Return-Path: <linux-kernel+bounces-404977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 845E19C4B43
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 01:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15C951F232CE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 00:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8CE201266;
	Tue, 12 Nov 2024 00:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O+d5pOFc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690521F76A0
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 00:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731372731; cv=none; b=Eo4TFOoDBC17jM0oz7N6GeU/8Bu8li7OQ2BgUsXBqKZNFEqztsnl4vv1WbCfLAnLQTZzdpP/vLaFOdWiw9HRPeh9RclXkSOXJXTsU4U0YJgMOZJ85GWoftuw4gwjzMPnSIaoZ+gIw+rFlTjjDC1wzh/z/qBjggU0rmeDjrc47qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731372731; c=relaxed/simple;
	bh=KIhKyM+uG7FoYD0mC8UynzHa4MYhrCPmBI3GeXbqU24=;
	h=Date:From:To:Cc:Subject:Message-ID; b=sVw/zFnSfvJvLmmQ6v78P4LuxlwLDEwF7uLPnw66atr3QHYz5LTdgU5alHd282NDV8Um0/a1+mrNVlQeUK96FvtbbbncKe/z+WlpaarbPiiyTIePWNlhjULv08U0VN3jerBA7C726n71d15OuslWUSqKABNlomkbwi306+kSiT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O+d5pOFc; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731372730; x=1762908730;
  h=date:from:to:cc:subject:message-id;
  bh=KIhKyM+uG7FoYD0mC8UynzHa4MYhrCPmBI3GeXbqU24=;
  b=O+d5pOFcm+B/kyBCg4nTauBOBpHKfsDLtyjBK/przji4JO+WRT3t1ann
   ETgnCohgOv6sMbwzDRg0dwJk54+lr//s7VhYrwd7YyhI6vSlYaWmoE1A/
   XCdB4JgSiIYFkHS9PCAmCTFaDIxp5oaqmD/FWNXwDE7T64hD/8Zcdeb3L
   ij8nPNsRcPhhNG7N+4vOu+W645Hddt1dGBtZNJrTqj0pPdijt0tCrbhSJ
   FmCFMuzy198XpZBNaLtXfVvRKIugtefEl290QVd2p/izaEh5xf4DvBLE0
   WtH5wIcXqXX/A9KbQT5oEwMW24z55Frfa1B0m1g6+Q9tGKSkoZyGXTrK3
   w==;
X-CSE-ConnectionGUID: f3GAuwt6TAeCDJzLJoeBXA==
X-CSE-MsgGUID: mZcps1WcSAKBwEKJentCXw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="34894639"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="34894639"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2024 16:52:09 -0800
X-CSE-ConnectionGUID: euGF6eRbTk6veuLdgcH8MQ==
X-CSE-MsgGUID: YmrDdQxBQX+U86KswMEm7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,146,1728975600"; 
   d="scan'208";a="91176085"
Received: from lkp-server01.sh.intel.com (HELO bcfed0da017c) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 11 Nov 2024 16:52:07 -0800
Received: from kbuild by bcfed0da017c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tAf8X-0000Iz-0s;
	Tue, 12 Nov 2024 00:52:05 +0000
Date: Tue, 12 Nov 2024 08:52:03 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:objtool/core] BUILD SUCCESS
 d5173f7537505315557d8580e3a648f07f17deda
Message-ID: <202411120857.1T2MiweC-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool/core
branch HEAD: d5173f7537505315557d8580e3a648f07f17deda  objtool: Exclude __tracepoints data from ENDBR checks

elapsed time: 785m

configs tested: 260
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-20
arc                                 defconfig    gcc-14.2.0
arc                   randconfig-001-20241111    gcc-14.2.0
arc                   randconfig-001-20241112    gcc-14.2.0
arc                   randconfig-002-20241111    gcc-14.2.0
arc                   randconfig-002-20241112    gcc-14.2.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-20
arm                         assabet_defconfig    gcc-14.2.0
arm                         at91_dt_defconfig    gcc-14.2.0
arm                                 defconfig    gcc-14.2.0
arm                            dove_defconfig    gcc-14.2.0
arm                      footbridge_defconfig    gcc-14.2.0
arm                           imxrt_defconfig    gcc-14.2.0
arm                   milbeaut_m10v_defconfig    gcc-14.2.0
arm                        multi_v7_defconfig    clang-15
arm                            qcom_defconfig    clang-15
arm                   randconfig-001-20241111    gcc-14.2.0
arm                   randconfig-001-20241112    gcc-14.2.0
arm                   randconfig-002-20241111    gcc-14.2.0
arm                   randconfig-002-20241112    gcc-14.2.0
arm                   randconfig-003-20241111    gcc-14.2.0
arm                   randconfig-003-20241112    gcc-14.2.0
arm                   randconfig-004-20241111    gcc-14.2.0
arm                   randconfig-004-20241112    gcc-14.2.0
arm                           u8500_defconfig    gcc-14.2.0
arm                         vf610m4_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20241111    gcc-14.2.0
arm64                 randconfig-001-20241112    gcc-14.2.0
arm64                 randconfig-002-20241111    gcc-14.2.0
arm64                 randconfig-002-20241112    gcc-14.2.0
arm64                 randconfig-003-20241111    gcc-14.2.0
arm64                 randconfig-003-20241112    gcc-14.2.0
arm64                 randconfig-004-20241111    gcc-14.2.0
arm64                 randconfig-004-20241112    gcc-14.2.0
csky                             alldefconfig    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20241111    gcc-14.2.0
csky                  randconfig-001-20241112    gcc-14.2.0
csky                  randconfig-002-20241111    gcc-14.2.0
csky                  randconfig-002-20241112    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20241111    gcc-14.2.0
hexagon               randconfig-001-20241112    gcc-14.2.0
hexagon               randconfig-002-20241111    gcc-14.2.0
hexagon               randconfig-002-20241112    gcc-14.2.0
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-19
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241111    gcc-11
i386        buildonly-randconfig-001-20241112    clang-19
i386        buildonly-randconfig-002-20241111    gcc-11
i386        buildonly-randconfig-002-20241112    clang-19
i386        buildonly-randconfig-003-20241111    gcc-11
i386        buildonly-randconfig-003-20241112    clang-19
i386        buildonly-randconfig-004-20241111    gcc-11
i386        buildonly-randconfig-004-20241112    clang-19
i386        buildonly-randconfig-005-20241111    gcc-11
i386        buildonly-randconfig-005-20241112    clang-19
i386        buildonly-randconfig-006-20241111    gcc-11
i386        buildonly-randconfig-006-20241112    clang-19
i386                                defconfig    clang-19
i386                  randconfig-001-20241111    gcc-11
i386                  randconfig-001-20241112    clang-19
i386                  randconfig-002-20241111    gcc-11
i386                  randconfig-002-20241112    clang-19
i386                  randconfig-003-20241111    gcc-11
i386                  randconfig-003-20241112    clang-19
i386                  randconfig-004-20241111    gcc-11
i386                  randconfig-004-20241112    clang-19
i386                  randconfig-005-20241111    gcc-11
i386                  randconfig-005-20241112    clang-19
i386                  randconfig-006-20241111    gcc-11
i386                  randconfig-006-20241112    clang-19
i386                  randconfig-011-20241111    gcc-11
i386                  randconfig-011-20241112    clang-19
i386                  randconfig-012-20241111    gcc-11
i386                  randconfig-012-20241112    clang-19
i386                  randconfig-013-20241111    gcc-11
i386                  randconfig-013-20241112    clang-19
i386                  randconfig-014-20241111    gcc-11
i386                  randconfig-014-20241112    clang-19
i386                  randconfig-015-20241111    gcc-11
i386                  randconfig-015-20241112    clang-19
i386                  randconfig-016-20241111    gcc-11
i386                  randconfig-016-20241112    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20241111    gcc-14.2.0
loongarch             randconfig-001-20241112    gcc-14.2.0
loongarch             randconfig-002-20241111    gcc-14.2.0
loongarch             randconfig-002-20241112    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                            mac_defconfig    gcc-14.2.0
m68k                        mvme16x_defconfig    gcc-14.2.0
m68k                        stmark2_defconfig    clang-15
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                           jazz_defconfig    clang-15
mips                           mtx1_defconfig    clang-15
mips                        vocore2_defconfig    clang-15
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20241111    gcc-14.2.0
nios2                 randconfig-001-20241112    gcc-14.2.0
nios2                 randconfig-002-20241111    gcc-14.2.0
nios2                 randconfig-002-20241112    gcc-14.2.0
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20241111    gcc-14.2.0
parisc                randconfig-001-20241112    gcc-14.2.0
parisc                randconfig-002-20241111    gcc-14.2.0
parisc                randconfig-002-20241112    gcc-14.2.0
parisc64                            defconfig    gcc-14.2.0
powerpc                    adder875_defconfig    clang-15
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-20
powerpc                          allyesconfig    gcc-14.2.0
powerpc                       holly_defconfig    clang-15
powerpc                      ppc44x_defconfig    gcc-14.2.0
powerpc               randconfig-001-20241111    gcc-14.2.0
powerpc               randconfig-001-20241112    gcc-14.2.0
powerpc               randconfig-002-20241111    gcc-14.2.0
powerpc               randconfig-002-20241112    gcc-14.2.0
powerpc               randconfig-003-20241111    gcc-14.2.0
powerpc               randconfig-003-20241112    gcc-14.2.0
powerpc                     skiroot_defconfig    gcc-14.2.0
powerpc                         wii_defconfig    gcc-14.2.0
powerpc                 xes_mpc85xx_defconfig    clang-15
powerpc64             randconfig-001-20241111    gcc-14.2.0
powerpc64             randconfig-001-20241112    gcc-14.2.0
powerpc64             randconfig-002-20241111    gcc-14.2.0
powerpc64             randconfig-002-20241112    gcc-14.2.0
powerpc64             randconfig-003-20241111    gcc-14.2.0
powerpc64             randconfig-003-20241112    gcc-14.2.0
riscv                            alldefconfig    clang-15
riscv                            allmodconfig    clang-20
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    clang-15
riscv                               defconfig    gcc-12
riscv                    nommu_k210_defconfig    clang-15
riscv                 randconfig-001-20241111    gcc-14.2.0
riscv                 randconfig-001-20241112    gcc-14.2.0
riscv                 randconfig-002-20241111    gcc-14.2.0
riscv                 randconfig-002-20241112    gcc-14.2.0
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20241111    gcc-14.2.0
s390                  randconfig-001-20241112    gcc-14.2.0
s390                  randconfig-002-20241111    gcc-14.2.0
s390                  randconfig-002-20241112    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                            hp6xx_defconfig    clang-15
sh                    randconfig-001-20241111    gcc-14.2.0
sh                    randconfig-001-20241112    gcc-14.2.0
sh                    randconfig-002-20241111    gcc-14.2.0
sh                    randconfig-002-20241112    gcc-14.2.0
sh                           se7206_defconfig    clang-15
sh                           se7712_defconfig    gcc-14.2.0
sh                             sh03_defconfig    clang-15
sparc                            allmodconfig    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20241111    gcc-14.2.0
sparc64               randconfig-001-20241112    gcc-14.2.0
sparc64               randconfig-002-20241111    gcc-14.2.0
sparc64               randconfig-002-20241112    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241111    gcc-14.2.0
um                    randconfig-001-20241112    gcc-14.2.0
um                    randconfig-002-20241111    gcc-14.2.0
um                    randconfig-002-20241112    gcc-14.2.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241112    gcc-12
x86_64      buildonly-randconfig-002-20241112    gcc-12
x86_64      buildonly-randconfig-003-20241112    gcc-12
x86_64      buildonly-randconfig-004-20241112    gcc-12
x86_64      buildonly-randconfig-005-20241112    gcc-12
x86_64      buildonly-randconfig-006-20241112    gcc-12
x86_64                              defconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20241112    gcc-12
x86_64                randconfig-002-20241112    gcc-12
x86_64                randconfig-003-20241112    gcc-12
x86_64                randconfig-004-20241112    gcc-12
x86_64                randconfig-005-20241112    gcc-12
x86_64                randconfig-006-20241112    gcc-12
x86_64                randconfig-011-20241112    gcc-12
x86_64                randconfig-012-20241112    gcc-12
x86_64                randconfig-013-20241112    gcc-12
x86_64                randconfig-014-20241112    gcc-12
x86_64                randconfig-015-20241112    gcc-12
x86_64                randconfig-016-20241112    gcc-12
x86_64                randconfig-071-20241112    gcc-12
x86_64                randconfig-072-20241112    gcc-12
x86_64                randconfig-073-20241112    gcc-12
x86_64                randconfig-074-20241112    gcc-12
x86_64                randconfig-075-20241112    gcc-12
x86_64                randconfig-076-20241112    gcc-12
x86_64                               rhel-8.3    gcc-12
x86_64                           rhel-8.3-bpf    clang-19
x86_64                         rhel-8.3-kunit    clang-19
x86_64                           rhel-8.3-ltp    clang-19
x86_64                          rhel-8.3-rust    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20241111    gcc-14.2.0
xtensa                randconfig-001-20241112    gcc-14.2.0
xtensa                randconfig-002-20241111    gcc-14.2.0
xtensa                randconfig-002-20241112    gcc-14.2.0
xtensa                         virt_defconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

