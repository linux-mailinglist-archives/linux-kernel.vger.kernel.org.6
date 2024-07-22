Return-Path: <linux-kernel+bounces-259356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F969394B0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 22:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ED111C21717
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 20:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79156224D7;
	Mon, 22 Jul 2024 20:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aDDXrecr"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCAA17C8D
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 20:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721679600; cv=none; b=i81O1AM+COVcllM8SWJHCNe04f8cSUK2PUaOztK79KDc5EDg+RUE7ZxvJUKQ0VdYHIaGi9LOnnzchPKHWdqGx2HQ0mwZaHhQ7OAogNXwaUhTtuNYgQenobvQXKfX3tbbotCu1VuTB3CIh2Dbep6Ub4VSJewC9phZSAOYoCsMJJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721679600; c=relaxed/simple;
	bh=1Yj8FMjZJi+od0lIvgJE2QwIm3hG/ARxCMbydJbqHzI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ZAPcsKqDAxOgRebYZeN6z7yv43xj+ozO1AepfvO/V/jci8IYM4+YNJKm8sUviD75F1URSmEFnO4gjUb2iIETRn4/PDZZM1kBKpJsFK4Zm3M1WMVQyyvM2EnbQuTHjB3nsor/7goN5qUHQ0IragN0uNhxIteoOCDyDOaAMSt7to4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aDDXrecr; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721679598; x=1753215598;
  h=date:from:to:cc:subject:message-id;
  bh=1Yj8FMjZJi+od0lIvgJE2QwIm3hG/ARxCMbydJbqHzI=;
  b=aDDXrecreXKfeUzuphWaOiNMMLiH4cgc3FVAc6flk+czzM9bBsYPrc6P
   oYfi6wPlmR1OmbuFwILERBnPTLjRKW38i/1Jqmafqy2JRwBULCIrj/I2h
   L3QT6AumDKHfhomVCIySRxtRbscF6hN35QKMBxyGyyMpQXMFD0ZdoDbGf
   QkK+WmLWbPVJTk54N/IEO9j7BeonXbXCLG94sg5XcGHVVyRkShAYF4hWd
   qIBO5gDd0WOoAFwFEI/DwFPvXjYSSzOCcQbjiMKIC4R0H3CnwNcCWtcnq
   J7WhkGLyod4US88sWY61l53ehjDiiIBZTupO7GZSeXn6MEmjR9/fvXjBd
   g==;
X-CSE-ConnectionGUID: xwEbjBAfQwq6oIVIgD4fug==
X-CSE-MsgGUID: iSykm1TtQsu42kIrC3HlgA==
X-IronPort-AV: E=McAfee;i="6700,10204,11141"; a="29886863"
X-IronPort-AV: E=Sophos;i="6.09,229,1716274800"; 
   d="scan'208";a="29886863"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2024 13:19:57 -0700
X-CSE-ConnectionGUID: KsYROYPXRauzVXh+lTWY6Q==
X-CSE-MsgGUID: 5lzCD6dTSmKOUca/wuk7MQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,229,1716274800"; 
   d="scan'208";a="56838132"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 22 Jul 2024 13:19:56 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sVzVh-000lNH-2H;
	Mon, 22 Jul 2024 20:19:53 +0000
Date: Tue, 23 Jul 2024 04:19:40 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 f96d641fecb0002590f547c7f83ff48bff85f163
Message-ID: <202407230437.kGThwqyx-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: f96d641fecb0002590f547c7f83ff48bff85f163  Merge branch into tip/master: 'x86/mm'

elapsed time: 725m

configs tested: 220
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240722   gcc-13.2.0
arc                   randconfig-002-20240722   gcc-13.2.0
arc                           tb10x_defconfig   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-19
arm                              allyesconfig   gcc-13.2.0
arm                              allyesconfig   gcc-14.1.0
arm                                 defconfig   gcc-13.2.0
arm                          ep93xx_defconfig   gcc-13.2.0
arm                      footbridge_defconfig   clang-19
arm                            mps2_defconfig   gcc-13.2.0
arm                        mvebu_v7_defconfig   clang-15
arm                            qcom_defconfig   clang-19
arm                   randconfig-001-20240722   gcc-14.1.0
arm                   randconfig-002-20240722   clang-19
arm                   randconfig-003-20240722   clang-19
arm                   randconfig-004-20240722   clang-19
arm                             rpc_defconfig   clang-19
arm                         s3c6400_defconfig   gcc-13.2.0
arm                       spear13xx_defconfig   gcc-14.1.0
arm                        spear3xx_defconfig   clang-16
arm                         vf610m4_defconfig   gcc-13.2.0
arm64                            allmodconfig   clang-19
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240722   clang-19
arm64                 randconfig-002-20240722   clang-19
arm64                 randconfig-003-20240722   clang-15
arm64                 randconfig-004-20240722   gcc-14.1.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240722   gcc-14.1.0
csky                  randconfig-002-20240722   gcc-14.1.0
hexagon                          allmodconfig   clang-19
hexagon                           allnoconfig   clang-19
hexagon                          allyesconfig   clang-19
hexagon               randconfig-001-20240722   clang-17
hexagon               randconfig-002-20240722   clang-19
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-13
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-13
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240722   gcc-13
i386         buildonly-randconfig-002-20240722   gcc-13
i386         buildonly-randconfig-003-20240722   clang-18
i386         buildonly-randconfig-003-20240722   gcc-13
i386         buildonly-randconfig-004-20240722   clang-18
i386         buildonly-randconfig-004-20240722   gcc-13
i386         buildonly-randconfig-005-20240722   gcc-13
i386         buildonly-randconfig-005-20240722   gcc-9
i386         buildonly-randconfig-006-20240722   clang-18
i386         buildonly-randconfig-006-20240722   gcc-13
i386                                defconfig   clang-18
i386                  randconfig-001-20240722   clang-18
i386                  randconfig-001-20240722   gcc-13
i386                  randconfig-002-20240722   clang-18
i386                  randconfig-002-20240722   gcc-13
i386                  randconfig-003-20240722   gcc-11
i386                  randconfig-003-20240722   gcc-13
i386                  randconfig-004-20240722   clang-18
i386                  randconfig-004-20240722   gcc-13
i386                  randconfig-005-20240722   clang-18
i386                  randconfig-005-20240722   gcc-13
i386                  randconfig-006-20240722   gcc-13
i386                  randconfig-011-20240722   gcc-13
i386                  randconfig-012-20240722   clang-18
i386                  randconfig-012-20240722   gcc-13
i386                  randconfig-013-20240722   clang-18
i386                  randconfig-013-20240722   gcc-13
i386                  randconfig-014-20240722   clang-18
i386                  randconfig-014-20240722   gcc-13
i386                  randconfig-015-20240722   clang-18
i386                  randconfig-015-20240722   gcc-13
i386                  randconfig-016-20240722   gcc-13
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240722   gcc-14.1.0
loongarch             randconfig-002-20240722   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
m68k                       m5208evb_defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-14.1.0
mips                           ci20_defconfig   clang-19
mips                           ip22_defconfig   gcc-14.1.0
mips                      maltaaprp_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240722   gcc-14.1.0
nios2                 randconfig-002-20240722   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240722   gcc-14.1.0
parisc                randconfig-002-20240722   gcc-14.1.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-19
powerpc                      cm5200_defconfig   clang-19
powerpc                    ge_imp3a_defconfig   gcc-13.2.0
powerpc                      katmai_defconfig   clang-19
powerpc                      mgcoge_defconfig   gcc-13.2.0
powerpc                 mpc8313_rdb_defconfig   gcc-13.2.0
powerpc               randconfig-001-20240722   clang-19
powerpc               randconfig-002-20240722   clang-19
powerpc               randconfig-003-20240722   gcc-14.1.0
powerpc                     redwood_defconfig   clang-19
powerpc                     sequoia_defconfig   gcc-13.2.0
powerpc                    socrates_defconfig   gcc-14.1.0
powerpc                     tqm8555_defconfig   clang-19
powerpc64             randconfig-001-20240722   gcc-14.1.0
powerpc64             randconfig-002-20240722   gcc-14.1.0
powerpc64             randconfig-003-20240722   clang-19
riscv                            allmodconfig   clang-19
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-19
riscv                               defconfig   clang-19
riscv                               defconfig   gcc-14.1.0
riscv                 randconfig-001-20240722   clang-19
riscv                 randconfig-002-20240722   clang-17
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   clang-19
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240722   gcc-14.1.0
s390                  randconfig-002-20240722   gcc-14.1.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                        edosk7705_defconfig   gcc-14.1.0
sh                          landisk_defconfig   gcc-13.2.0
sh                    randconfig-001-20240722   gcc-14.1.0
sh                    randconfig-002-20240722   gcc-14.1.0
sh                          rsk7264_defconfig   gcc-14.1.0
sh                           se7722_defconfig   gcc-14.1.0
sh                           se7750_defconfig   gcc-14.1.0
sh                   sh7724_generic_defconfig   gcc-13.2.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240722   gcc-14.1.0
sparc64               randconfig-002-20240722   gcc-14.1.0
um                               allmodconfig   clang-19
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-13
um                                  defconfig   clang-19
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-13
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240722   gcc-13
um                    randconfig-002-20240722   clang-19
um                           x86_64_defconfig   clang-15
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240722   clang-18
x86_64       buildonly-randconfig-002-20240722   clang-18
x86_64       buildonly-randconfig-003-20240722   clang-18
x86_64       buildonly-randconfig-004-20240722   clang-18
x86_64       buildonly-randconfig-004-20240722   gcc-13
x86_64       buildonly-randconfig-005-20240722   clang-18
x86_64       buildonly-randconfig-005-20240722   gcc-13
x86_64       buildonly-randconfig-006-20240722   clang-18
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240722   clang-18
x86_64                randconfig-001-20240722   gcc-8
x86_64                randconfig-002-20240722   clang-18
x86_64                randconfig-003-20240722   clang-18
x86_64                randconfig-003-20240722   gcc-13
x86_64                randconfig-004-20240722   clang-18
x86_64                randconfig-004-20240722   gcc-13
x86_64                randconfig-005-20240722   clang-18
x86_64                randconfig-006-20240722   clang-18
x86_64                randconfig-006-20240722   gcc-13
x86_64                randconfig-011-20240722   clang-18
x86_64                randconfig-012-20240722   clang-18
x86_64                randconfig-012-20240722   gcc-11
x86_64                randconfig-013-20240722   clang-18
x86_64                randconfig-013-20240722   gcc-9
x86_64                randconfig-014-20240722   clang-18
x86_64                randconfig-014-20240722   gcc-13
x86_64                randconfig-015-20240722   clang-18
x86_64                randconfig-016-20240722   clang-18
x86_64                randconfig-071-20240722   clang-18
x86_64                randconfig-072-20240722   clang-18
x86_64                randconfig-072-20240722   gcc-9
x86_64                randconfig-073-20240722   clang-18
x86_64                randconfig-074-20240722   clang-18
x86_64                randconfig-075-20240722   clang-18
x86_64                randconfig-076-20240722   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-14.1.0
xtensa                       common_defconfig   gcc-13.2.0
xtensa                  nommu_kc705_defconfig   gcc-13.2.0
xtensa                randconfig-001-20240722   gcc-14.1.0
xtensa                randconfig-002-20240722   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

