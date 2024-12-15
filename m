Return-Path: <linux-kernel+bounces-446550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D932D9F25FE
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 21:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4600618858CE
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 20:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB0E1B9831;
	Sun, 15 Dec 2024 20:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d2za67Yb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C327E175BF
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 20:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734293661; cv=none; b=TrD0LVkNAukM2rMvgGzHuHEL8o1C228sEiW0Q9ZiSsWafJGsm10Ogrt0YdUQzOlMsg+OuWIr5by0+YTeHdOxCunOUDJYpVGLWhIP52gwlBbhy2jS5lQ5O6JcBPjVzIa17vNVIIVyD6Jdl2rHyiCamtt8yJB9EsWejibgWjvW72M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734293661; c=relaxed/simple;
	bh=Bx0f7DBfPuvrprW1MAkGUj2tpXOFC0OqGNIMsqyrXUc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=p/TfvGrt52tp0ALTu+lxrf0r/5q07gSDNlMzdepn4LVD5U39kzPm2Z7bdY+iVjyktuNi7eg8V1YNSoWfLTJI8gOuAuf6EkVGgJzQwL2N2udAsAx00gTEIZK3vnubKzeshCRygpb4QyhhNP7yKOV6k+V0VNSjDuNi+Koz6jE7sso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d2za67Yb; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734293658; x=1765829658;
  h=date:from:to:cc:subject:message-id;
  bh=Bx0f7DBfPuvrprW1MAkGUj2tpXOFC0OqGNIMsqyrXUc=;
  b=d2za67YbGOJYzV1h+7GuSfEkftcx3/U/raFUf0ewRTm6dqlQ1fojTQAy
   0L1j/8Rqr9mtv4vHS0y+ablNXwhRyDmfnI5wZF7KaLc2nrzUQosBE4i6k
   AEl775IgjYIBdKxkXc6Nz3jvLk6ysA+r41ncz/GpNEL9BxUPSDMeAOpl/
   8tvRRqG5O0DdUgeyHHGhnxoeb/Z4+MFHQ2vAjof0a9YHX92K1tR5sRVff
   aNcaLRSS0u5LwGDR2/+7SdmNofZHB+z4H7WAfXO4vTiBLNEymvSeaMxYi
   yZGX6KmwVDOAX3h2aqdfHjrgGYheuMJAEIXktrhAkIpjwG4NFUvLmiHyZ
   w==;
X-CSE-ConnectionGUID: Z9+wRnDlTV6cZfKKCeifpA==
X-CSE-MsgGUID: TK4O/bY4SnyNVMqPDRGPHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11287"; a="34816272"
X-IronPort-AV: E=Sophos;i="6.12,237,1728975600"; 
   d="scan'208";a="34816272"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2024 12:14:17 -0800
X-CSE-ConnectionGUID: KGltaS3jR+6DrCZksunRAg==
X-CSE-MsgGUID: S7fyRXtLR46B1hoLPl4jbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="134345500"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 15 Dec 2024 12:14:16 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tMv0I-000DqD-0Z;
	Sun, 15 Dec 2024 20:14:14 +0000
Date: Mon, 16 Dec 2024 04:13:29 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/sev] BUILD SUCCESS
 21fc6178e92070523e70fc5db59ac83806d269d6
Message-ID: <202412160423.AVzFKCzx-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/sev
branch HEAD: 21fc6178e92070523e70fc5db59ac83806d269d6  x86/sev/docs: Document the SNP Reverse Map Table (RMP)

elapsed time: 1445m

configs tested: 132
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                      axs103_smp_defconfig    gcc-13.2.0
arc                                 defconfig    gcc-13.2.0
arc                   randconfig-001-20241215    gcc-13.2.0
arc                   randconfig-002-20241215    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                         axm55xx_defconfig    clang-17
arm                     davinci_all_defconfig    clang-20
arm                       multi_v4t_defconfig    clang-20
arm                       netwinder_defconfig    gcc-14.2.0
arm                   randconfig-001-20241215    clang-20
arm                   randconfig-002-20241215    clang-16
arm                   randconfig-003-20241215    gcc-14.2.0
arm                   randconfig-004-20241215    clang-20
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20241215    gcc-14.2.0
arm64                 randconfig-002-20241215    gcc-14.2.0
arm64                 randconfig-003-20241215    clang-20
arm64                 randconfig-004-20241215    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20241215    gcc-14.2.0
csky                  randconfig-002-20241215    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                             defconfig    clang-20
hexagon               randconfig-001-20241215    clang-20
hexagon               randconfig-002-20241215    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241215    gcc-12
i386        buildonly-randconfig-002-20241215    gcc-12
i386        buildonly-randconfig-003-20241215    gcc-12
i386        buildonly-randconfig-004-20241215    gcc-12
i386        buildonly-randconfig-005-20241215    gcc-12
i386        buildonly-randconfig-006-20241215    clang-19
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20241215    gcc-14.2.0
loongarch             randconfig-002-20241215    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                        mvme16x_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          eyeq5_defconfig    gcc-14.2.0
mips                            gpr_defconfig    clang-20
mips                      maltaaprp_defconfig    clang-20
nios2                            alldefconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20241215    gcc-14.2.0
nios2                 randconfig-002-20241215    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20241215    gcc-14.2.0
parisc                randconfig-002-20241215    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                     ep8248e_defconfig    gcc-14.2.0
powerpc                   lite5200b_defconfig    clang-20
powerpc               randconfig-001-20241215    gcc-14.2.0
powerpc               randconfig-002-20241215    clang-20
powerpc               randconfig-003-20241215    gcc-14.2.0
powerpc64             randconfig-001-20241215    gcc-14.2.0
powerpc64             randconfig-002-20241215    gcc-14.2.0
powerpc64             randconfig-003-20241215    gcc-14.2.0
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                               defconfig    clang-19
riscv                 randconfig-001-20241215    clang-16
riscv                 randconfig-002-20241215    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20241215    gcc-14.2.0
s390                  randconfig-002-20241215    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                    randconfig-001-20241215    gcc-14.2.0
sh                    randconfig-002-20241215    gcc-14.2.0
sh                   sh7724_generic_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20241215    gcc-14.2.0
sparc                 randconfig-002-20241215    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20241215    gcc-14.2.0
sparc64               randconfig-002-20241215    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                                  defconfig    clang-20
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241215    gcc-12
um                    randconfig-002-20241215    clang-18
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241215    gcc-12
x86_64      buildonly-randconfig-002-20241215    clang-19
x86_64      buildonly-randconfig-003-20241215    clang-19
x86_64      buildonly-randconfig-004-20241215    gcc-12
x86_64      buildonly-randconfig-005-20241215    clang-19
x86_64      buildonly-randconfig-006-20241215    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20241215    gcc-14.2.0
xtensa                randconfig-002-20241215    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

