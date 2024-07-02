Return-Path: <linux-kernel+bounces-237749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BFC923DAF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 14:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CD801F232A2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 12:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614441662FE;
	Tue,  2 Jul 2024 12:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EFVLc/Lx"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C580A16FF2A
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 12:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719923128; cv=none; b=ZfL/a2/pr220k0KYPFbVBeMF+inKo2qrz/aFb2tLKKb6bUmD5P6jrUHVeT9dz7O0hZmjYFtHK8Ezcyal0E6aKdPgtULZGuehuosdUauxg6lEaGO2o656eTbBBWxhIrKPBs7Fj1Q2/0pgI0TIEmGS8zrES+JCeqEpOjdkmpGNxek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719923128; c=relaxed/simple;
	bh=evl2bS6d9F1sSu4fuJWgautkM5r1gEFsGAw1GotDw2g=;
	h=Date:From:To:Cc:Subject:Message-ID; b=SUbwiQ/Vz7QSK+iMqVsIpnthLYQW3Mi1Xui1/jgGnyRt/12clIzoylkocR1VgGTkmsAZ/bOnbnBk5ZdwDxnSTbQh6yv9zOcUjUO/g2sM8dWWh7H5eqBFNPSnVAnlP13iMLF/CX8E8toWVfc0VnyuHbrqIr8SzAzc4bn1k8Nq2IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EFVLc/Lx; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719923126; x=1751459126;
  h=date:from:to:cc:subject:message-id;
  bh=evl2bS6d9F1sSu4fuJWgautkM5r1gEFsGAw1GotDw2g=;
  b=EFVLc/LxnF3ivB3J+5utW2HTKNm+Go46RuZfSnrbJUuaavaMXFbUz7A/
   XDXPUPr3FSPLMBg+7itaKJwbQ72+zutb3qnkySbYK3ZrY0bDz3tqpwXnm
   t+xmO8hT/hphw7rHDN+bgBtY5QZJV39qD7Rb7J00CE8o7hspqOKC6uT5u
   ETPvn3XVrPGoGgoJeTsIvALtvddOhVqSlcCE/jiBkB9lCTZ3oFT4JSi0y
   6ZgHCp30fgSZFilBmyOkQeDzBvoAPOHnloZe1lGH6c+jVpm184bJM37Up
   Rp0JSiBxMlGD2sdJZNzVCKO7JhASpK/ApVSbNWOw6emgj1dCXX1Jh4qmT
   w==;
X-CSE-ConnectionGUID: hwFdQCoBR/qtzRigW5ZxKA==
X-CSE-MsgGUID: 7lSiIWABToa2itfDh88Q3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="20963215"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="20963215"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 05:25:25 -0700
X-CSE-ConnectionGUID: rIt6luoARgejGyoIME3pCA==
X-CSE-MsgGUID: HqAcdEwTRUOFxrm9lwKPQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="46622541"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 02 Jul 2024 05:25:25 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sOcZV-000O9y-1V;
	Tue, 02 Jul 2024 12:25:21 +0000
Date: Tue, 02 Jul 2024 20:25:19 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/alternatives] BUILD SUCCESS
 0d3db1f14abb4eb28613fbeb1e2ad92bac76debf
Message-ID: <202407022017.aHHSr75d-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/alternatives
branch HEAD: 0d3db1f14abb4eb28613fbeb1e2ad92bac76debf  x86/alternatives, kvm: Fix a couple of CALLs without a frame pointer

elapsed time: 1467m

configs tested: 181
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig   gcc-13.2.0
alpha                             allnoconfig   gcc-13.2.0
alpha                            allyesconfig   gcc-13.2.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240702   gcc-13.2.0
arc                   randconfig-002-20240702   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                                 defconfig   gcc-13.2.0
arm                       omap2plus_defconfig   gcc-13.2.0
arm                   randconfig-001-20240702   gcc-13.2.0
arm                   randconfig-002-20240702   gcc-13.2.0
arm                   randconfig-003-20240702   gcc-13.2.0
arm                   randconfig-004-20240702   gcc-13.2.0
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240702   gcc-13.2.0
arm64                 randconfig-002-20240702   gcc-13.2.0
arm64                 randconfig-003-20240702   gcc-13.2.0
arm64                 randconfig-004-20240702   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240702   gcc-13.2.0
csky                  randconfig-002-20240702   gcc-13.2.0
i386                             allmodconfig   clang-18
i386                              allnoconfig   clang-18
i386                             allyesconfig   clang-18
i386         buildonly-randconfig-001-20240702   gcc-13
i386         buildonly-randconfig-002-20240702   gcc-10
i386         buildonly-randconfig-002-20240702   gcc-13
i386         buildonly-randconfig-003-20240702   gcc-13
i386         buildonly-randconfig-004-20240702   clang-18
i386         buildonly-randconfig-004-20240702   gcc-13
i386         buildonly-randconfig-005-20240702   gcc-10
i386         buildonly-randconfig-005-20240702   gcc-13
i386         buildonly-randconfig-006-20240702   gcc-13
i386                                defconfig   clang-18
i386                  randconfig-001-20240702   gcc-10
i386                  randconfig-001-20240702   gcc-13
i386                  randconfig-002-20240702   gcc-12
i386                  randconfig-002-20240702   gcc-13
i386                  randconfig-003-20240702   gcc-13
i386                  randconfig-004-20240702   gcc-13
i386                  randconfig-005-20240702   gcc-10
i386                  randconfig-005-20240702   gcc-13
i386                  randconfig-006-20240702   clang-18
i386                  randconfig-006-20240702   gcc-13
i386                  randconfig-011-20240702   gcc-13
i386                  randconfig-011-20240702   gcc-9
i386                  randconfig-012-20240702   clang-18
i386                  randconfig-012-20240702   gcc-13
i386                  randconfig-013-20240702   gcc-11
i386                  randconfig-013-20240702   gcc-13
i386                  randconfig-014-20240702   clang-18
i386                  randconfig-014-20240702   gcc-13
i386                  randconfig-015-20240702   clang-18
i386                  randconfig-015-20240702   gcc-13
i386                  randconfig-016-20240702   clang-18
i386                  randconfig-016-20240702   gcc-13
loongarch                        allmodconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240702   gcc-13.2.0
loongarch             randconfig-002-20240702   gcc-13.2.0
m68k                             allmodconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-13.2.0
m68k                          amiga_defconfig   gcc-13.2.0
m68k                                defconfig   gcc-13.2.0
m68k                          hp300_defconfig   gcc-13.2.0
m68k                          multi_defconfig   gcc-13.2.0
m68k                        mvme147_defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-13.2.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                         cobalt_defconfig   gcc-13.2.0
mips                      maltaaprp_defconfig   gcc-13.2.0
mips                        maltaup_defconfig   gcc-13.2.0
mips                       rbtx49xx_defconfig   gcc-13.2.0
mips                          rm200_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240702   gcc-13.2.0
nios2                 randconfig-002-20240702   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                         allyesconfig   gcc-13.2.0
openrisc                            defconfig   gcc-13.2.0
parisc                           allmodconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                           allyesconfig   gcc-13.2.0
parisc                              defconfig   gcc-13.2.0
parisc                randconfig-001-20240702   gcc-13.2.0
parisc                randconfig-002-20240702   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc                          allyesconfig   gcc-13.2.0
powerpc                      arches_defconfig   gcc-13.2.0
powerpc                      pcm030_defconfig   gcc-13.2.0
powerpc               randconfig-001-20240702   gcc-13.2.0
powerpc               randconfig-002-20240702   gcc-13.2.0
powerpc               randconfig-003-20240702   gcc-13.2.0
powerpc                 xes_mpc85xx_defconfig   gcc-13.2.0
powerpc64             randconfig-001-20240702   gcc-13.2.0
powerpc64             randconfig-002-20240702   gcc-13.2.0
powerpc64             randconfig-003-20240702   gcc-13.2.0
riscv                            allmodconfig   gcc-13.2.0
riscv                             allnoconfig   gcc-13.2.0
riscv                            allyesconfig   gcc-13.2.0
riscv                               defconfig   gcc-13.2.0
riscv                 randconfig-001-20240702   gcc-13.2.0
riscv                 randconfig-002-20240702   gcc-13.2.0
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                              allnoconfig   gcc-13.2.0
s390                             allyesconfig   clang-19
s390                                defconfig   gcc-13.2.0
s390                  randconfig-001-20240702   gcc-13.2.0
s390                  randconfig-002-20240702   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                                  defconfig   gcc-13.2.0
sh                            hp6xx_defconfig   gcc-13.2.0
sh                          landisk_defconfig   gcc-13.2.0
sh                    randconfig-001-20240702   gcc-13.2.0
sh                    randconfig-002-20240702   gcc-13.2.0
sparc64                             defconfig   gcc-13.2.0
sparc64               randconfig-001-20240702   gcc-13.2.0
sparc64               randconfig-002-20240702   gcc-13.2.0
um                               allmodconfig   gcc-13.2.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-13.2.0
um                               allyesconfig   gcc-13.2.0
um                                  defconfig   gcc-13.2.0
um                             i386_defconfig   gcc-13.2.0
um                    randconfig-001-20240702   gcc-13.2.0
um                    randconfig-002-20240702   gcc-13.2.0
um                           x86_64_defconfig   gcc-13.2.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240702   gcc-8
x86_64       buildonly-randconfig-002-20240702   gcc-8
x86_64       buildonly-randconfig-003-20240702   gcc-8
x86_64       buildonly-randconfig-004-20240702   gcc-8
x86_64       buildonly-randconfig-005-20240702   gcc-8
x86_64       buildonly-randconfig-006-20240702   gcc-8
x86_64                              defconfig   clang-18
x86_64                                  kexec   clang-18
x86_64                randconfig-001-20240702   gcc-8
x86_64                randconfig-002-20240702   gcc-8
x86_64                randconfig-003-20240702   gcc-8
x86_64                randconfig-004-20240702   gcc-8
x86_64                randconfig-005-20240702   gcc-8
x86_64                randconfig-006-20240702   gcc-8
x86_64                randconfig-011-20240702   gcc-8
x86_64                randconfig-012-20240702   gcc-8
x86_64                randconfig-013-20240702   gcc-8
x86_64                randconfig-014-20240702   gcc-8
x86_64                randconfig-015-20240702   gcc-8
x86_64                randconfig-016-20240702   gcc-8
x86_64                randconfig-071-20240702   gcc-8
x86_64                randconfig-072-20240702   gcc-8
x86_64                randconfig-073-20240702   gcc-8
x86_64                randconfig-074-20240702   gcc-8
x86_64                randconfig-075-20240702   gcc-8
x86_64                randconfig-076-20240702   gcc-8
x86_64                           rhel-8.3-bpf   clang-18
x86_64                          rhel-8.3-func   clang-18
x86_64                          rhel-8.3-rust   clang-18
x86_64                               rhel-8.3   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                randconfig-001-20240702   gcc-13.2.0
xtensa                randconfig-002-20240702   gcc-13.2.0
xtensa                         virt_defconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

