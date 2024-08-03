Return-Path: <linux-kernel+bounces-273483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CADE39469D0
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 15:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 251A5281A53
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 13:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A702D6A357;
	Sat,  3 Aug 2024 13:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OeE5OA9q"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B151C1DFF7
	for <linux-kernel@vger.kernel.org>; Sat,  3 Aug 2024 13:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722690192; cv=none; b=lYFPaLXmdYKDHEx2C0qZnrvgRUfDET7ypIObvXzQtqKuFwouSRPydkqQ/HdxmUMQIF+X9Bd4uforhgpnBgs6MNBv7JtZsQgE5T3QBYYD1kWYAOS2vNr0OQBhxuD4n+mZksjatvPA8TAjNRCaV/m1RJludrk838wuY6QFKHjYO9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722690192; c=relaxed/simple;
	bh=7AM3Jza5j05/8FSQboiR+Hxm5bUyMtDwrIlYmkMDGOo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=CKik4xVFhbfuuPSqIWq6/vTSTFld2VcP5BUjsivjVnzk1GPv+j8JIp59FoUoYlLy6kZiafEzmaS+lO7QPgR6pXWBes1tXvE5N782KQCMLrmidmD23FYzXqv4Z97faHlJflrKcwuVfzYmwfI7Vz5fy7GiNYe7Dk5YGasS+muE++Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OeE5OA9q; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722690191; x=1754226191;
  h=date:from:to:cc:subject:message-id;
  bh=7AM3Jza5j05/8FSQboiR+Hxm5bUyMtDwrIlYmkMDGOo=;
  b=OeE5OA9q6Owg6x3dPwcGCGsR79FqftRB4Atsq6oyG9Q5Quhqd3cB5Cv5
   KMThWTTdZqTSCFQhTPmLHijICEhk+7OHx0yV96bXarTL5CaH5oQjISDj4
   bNRtGb+SitmwfaNF+LT9UezSTIiLq2ap1+UKHn5uUpVIlMg6NwA2BheBj
   80xh2oAdY6ocnHhhYJ34Ge0Wb+AJcaXHoEtbTW2CMfPL7cnkQdZkzUEUR
   4r98rL+ZJRTlp2RyQnePtqmvXUFFJTaNY0QxoeeLwin8Ng0KfIKjPxkBR
   IeUl5zjrPtmVQ3kFWbAj3c7cdsf46iTEeh7Vvvttwj3Lxv5x7jWmvjn31
   w==;
X-CSE-ConnectionGUID: HEhiSSMXS9OKlSc9JiDQ+g==
X-CSE-MsgGUID: 08T0RNqdQ+KJGjQGavnUSA==
X-IronPort-AV: E=McAfee;i="6700,10204,11153"; a="20373406"
X-IronPort-AV: E=Sophos;i="6.09,260,1716274800"; 
   d="scan'208";a="20373406"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2024 06:03:10 -0700
X-CSE-ConnectionGUID: gbme5zKDSuC5HWIfmcZYpQ==
X-CSE-MsgGUID: gYntKbDYTeCzT/HUSlppDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,260,1716274800"; 
   d="scan'208";a="55641574"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 03 Aug 2024 06:03:08 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1saEPV-0000Sk-3A;
	Sat, 03 Aug 2024 13:03:03 +0000
Date: Sat, 03 Aug 2024 21:01:32 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/mm] BUILD SUCCESS
 6998a73efbb8a87f4dd0bddde90b7f5b0d47b5e0
Message-ID: <202408032129.ODxcn1w4-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/mm
branch HEAD: 6998a73efbb8a87f4dd0bddde90b7f5b0d47b5e0  selftests/mm: Add new testcases for pkeys

elapsed time: 1435m

configs tested: 214
configs skipped: 10

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
arc                            hsdk_defconfig   gcc-13.2.0
arc                   randconfig-001-20240803   gcc-13.2.0
arc                   randconfig-002-20240803   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                         bcm2835_defconfig   clang-20
arm                        clps711x_defconfig   clang-20
arm                                 defconfig   gcc-13.2.0
arm                      jornada720_defconfig   clang-20
arm                        keystone_defconfig   clang-20
arm                         lpc32xx_defconfig   gcc-14.1.0
arm                          moxart_defconfig   clang-20
arm                            mps2_defconfig   clang-20
arm                        mvebu_v7_defconfig   gcc-13.2.0
arm                             mxs_defconfig   clang-20
arm                       omap2plus_defconfig   gcc-14.1.0
arm                   randconfig-001-20240803   gcc-13.2.0
arm                   randconfig-002-20240803   gcc-13.2.0
arm                   randconfig-003-20240803   gcc-13.2.0
arm                   randconfig-004-20240803   gcc-13.2.0
arm                        realview_defconfig   gcc-13.2.0
arm                         s3c6400_defconfig   gcc-13.2.0
arm                         s3c6400_defconfig   gcc-14.1.0
arm                           sama5_defconfig   clang-20
arm                        spear3xx_defconfig   gcc-14.1.0
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240803   gcc-13.2.0
arm64                 randconfig-002-20240803   gcc-13.2.0
arm64                 randconfig-003-20240803   gcc-13.2.0
arm64                 randconfig-004-20240803   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240803   gcc-13.2.0
csky                  randconfig-002-20240803   gcc-13.2.0
hexagon                          allmodconfig   clang-20
hexagon                          allyesconfig   clang-20
i386                             allmodconfig   clang-18
i386                              allnoconfig   clang-18
i386                             allyesconfig   clang-18
i386         buildonly-randconfig-001-20240803   clang-18
i386         buildonly-randconfig-002-20240803   clang-18
i386         buildonly-randconfig-002-20240803   gcc-12
i386         buildonly-randconfig-003-20240803   clang-18
i386         buildonly-randconfig-003-20240803   gcc-12
i386         buildonly-randconfig-004-20240803   clang-18
i386         buildonly-randconfig-004-20240803   gcc-12
i386         buildonly-randconfig-005-20240803   clang-18
i386         buildonly-randconfig-006-20240803   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240803   clang-18
i386                  randconfig-001-20240803   gcc-12
i386                  randconfig-002-20240803   clang-18
i386                  randconfig-002-20240803   gcc-12
i386                  randconfig-003-20240803   clang-18
i386                  randconfig-004-20240803   clang-18
i386                  randconfig-004-20240803   gcc-12
i386                  randconfig-005-20240803   clang-18
i386                  randconfig-006-20240803   clang-18
i386                  randconfig-011-20240803   clang-18
i386                  randconfig-011-20240803   gcc-12
i386                  randconfig-012-20240803   clang-18
i386                  randconfig-012-20240803   gcc-11
i386                  randconfig-013-20240803   clang-18
i386                  randconfig-014-20240803   clang-18
i386                  randconfig-015-20240803   clang-18
i386                  randconfig-015-20240803   gcc-12
i386                  randconfig-016-20240803   clang-18
i386                  randconfig-016-20240803   gcc-12
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240803   gcc-13.2.0
loongarch             randconfig-002-20240803   gcc-13.2.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
m68k                            mac_defconfig   gcc-13.2.0
m68k                        stmark2_defconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                     cu1000-neo_defconfig   gcc-14.1.0
mips                  decstation_64_defconfig   gcc-14.1.0
mips                           gcw0_defconfig   clang-20
mips                           ip22_defconfig   gcc-13.2.0
mips                        maltaup_defconfig   clang-20
mips                    maltaup_xpa_defconfig   clang-20
mips                           mtx1_defconfig   gcc-13.2.0
mips                      pic32mzda_defconfig   clang-20
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240803   gcc-13.2.0
nios2                 randconfig-002-20240803   gcc-13.2.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240803   gcc-13.2.0
parisc                randconfig-002-20240803   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   gcc-14.1.0
powerpc                   bluestone_defconfig   gcc-13.2.0
powerpc                      cm5200_defconfig   gcc-13.2.0
powerpc                      ep88xc_defconfig   clang-20
powerpc                        fsp2_defconfig   clang-20
powerpc                       holly_defconfig   gcc-14.1.0
powerpc                     ksi8560_defconfig   gcc-13.2.0
powerpc                   microwatt_defconfig   gcc-14.1.0
powerpc                 mpc8313_rdb_defconfig   clang-20
powerpc                 mpc834x_itx_defconfig   gcc-14.1.0
powerpc               mpc834x_itxgp_defconfig   clang-20
powerpc                      pcm030_defconfig   clang-20
powerpc                       ppc64_defconfig   gcc-14.1.0
powerpc               randconfig-001-20240803   gcc-13.2.0
powerpc               randconfig-003-20240803   gcc-13.2.0
powerpc                  storcenter_defconfig   gcc-13.2.0
powerpc                     tqm8560_defconfig   gcc-14.1.0
powerpc                      tqm8xx_defconfig   clang-20
powerpc                        warp_defconfig   gcc-13.2.0
powerpc                 xes_mpc85xx_defconfig   gcc-13.2.0
powerpc64             randconfig-001-20240803   gcc-13.2.0
powerpc64             randconfig-002-20240803   gcc-13.2.0
powerpc64             randconfig-003-20240803   gcc-13.2.0
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-14.1.0
riscv                 randconfig-001-20240803   gcc-13.2.0
riscv                 randconfig-002-20240803   gcc-13.2.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-20
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240803   gcc-13.2.0
s390                  randconfig-002-20240803   gcc-13.2.0
s390                       zfcpdump_defconfig   clang-20
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                             espt_defconfig   gcc-14.1.0
sh                          r7780mp_defconfig   gcc-14.1.0
sh                    randconfig-001-20240803   gcc-13.2.0
sh                    randconfig-002-20240803   gcc-13.2.0
sh                          rsk7203_defconfig   gcc-13.2.0
sh                           se7619_defconfig   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240803   gcc-13.2.0
sparc64               randconfig-002-20240803   gcc-13.2.0
um                               allmodconfig   clang-20
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-12
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240803   gcc-13.2.0
um                    randconfig-002-20240803   gcc-13.2.0
um                           x86_64_defconfig   clang-20
um                           x86_64_defconfig   gcc-14.1.0
x86_64                           alldefconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240803   gcc-12
x86_64       buildonly-randconfig-002-20240803   gcc-12
x86_64       buildonly-randconfig-003-20240803   gcc-12
x86_64       buildonly-randconfig-004-20240803   gcc-12
x86_64       buildonly-randconfig-005-20240803   gcc-12
x86_64       buildonly-randconfig-006-20240803   gcc-12
x86_64                              defconfig   clang-18
x86_64                randconfig-001-20240803   gcc-12
x86_64                randconfig-002-20240803   gcc-12
x86_64                randconfig-003-20240803   gcc-12
x86_64                randconfig-004-20240803   gcc-12
x86_64                randconfig-005-20240803   gcc-12
x86_64                randconfig-006-20240803   gcc-12
x86_64                randconfig-011-20240803   gcc-12
x86_64                randconfig-012-20240803   gcc-12
x86_64                randconfig-013-20240803   gcc-12
x86_64                randconfig-014-20240803   gcc-12
x86_64                randconfig-015-20240803   gcc-12
x86_64                randconfig-016-20240803   gcc-12
x86_64                randconfig-071-20240803   gcc-12
x86_64                randconfig-072-20240803   gcc-12
x86_64                randconfig-073-20240803   gcc-12
x86_64                randconfig-074-20240803   gcc-12
x86_64                randconfig-075-20240803   gcc-12
x86_64                randconfig-076-20240803   gcc-12
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                randconfig-001-20240803   gcc-13.2.0
xtensa                randconfig-002-20240803   gcc-13.2.0
xtensa                         virt_defconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

