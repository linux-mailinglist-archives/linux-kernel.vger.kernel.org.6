Return-Path: <linux-kernel+bounces-288454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D49F953A49
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 20:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D08F62828E9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 18:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5D1768E1;
	Thu, 15 Aug 2024 18:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nm5KYCa6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198FF605BA
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 18:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723747224; cv=none; b=RxRYPdrF87HCgyTePrvP/+8FahSnA/7WKzADukFvMSNGfQpP9unjoPumSPCiWPucdo7Meyw3hgAODU/u9vRpE6J2MkN+Ndr1SnjnOfrrlvRLwhqE8ctVqWObLFQlaK1aM4MD+mi3WopKFyRA8jQul+JH5ps4t/RInJcm5ZnJSR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723747224; c=relaxed/simple;
	bh=JyS9aPzVKa4cSRQNuUtYhOQvS1RkD7mmPRx2aFdaA58=;
	h=Date:From:To:Cc:Subject:Message-ID; b=YTvQwOk+ZOsKqLFjUidl2v6HxGE/BbexnDC+VbkZs5f5f6VqUN+V130f5z90TrC/IfT5cSEK+v8o5wwy4PwS0FkTSI+4FdcC8USKd4Ktw8eihDITQnJafMukcRw2lTX4qMOJ+xcVkmWE+CpQVgKfRuvCqG1G/9VWrk5oyuykPKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nm5KYCa6; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723747222; x=1755283222;
  h=date:from:to:cc:subject:message-id;
  bh=JyS9aPzVKa4cSRQNuUtYhOQvS1RkD7mmPRx2aFdaA58=;
  b=nm5KYCa6y9ZHxY1w1fbd/0Vdh+k/J6/+Y59mlkV0RxCq69/SIRRKZsKA
   BfiBgMdRrrK5Dl1XbkP1BozSVwQoRwkXBUV5aGIgVllHEnDnPu1E9ANXf
   8705O8l7/EK4Gb8bDSPzLDfI651oplZ4OWxi2isvhu46+0rqoJDTsCCXL
   6C/JzDyenrgCmyHmSR+Lks4Og7P4Yt5Hlf5sPnnmnoXT3TnNAu8ttSbgZ
   +wAPe6z89hBiIYLpfIAzlc7gnJLfya+b+F3hwcKhoB1dEEWzz4VRUBVgP
   C4uB6zr83soRPZEpgzIveim9pJcLP5JkdrigaE89k72eaW70urP6gzG4q
   Q==;
X-CSE-ConnectionGUID: tNVKsKQYTF6CB6RSlvfVIQ==
X-CSE-MsgGUID: QxLobJ7CQN2G+LDS4ZYqGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="33434990"
X-IronPort-AV: E=Sophos;i="6.10,149,1719903600"; 
   d="scan'208";a="33434990"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 11:40:21 -0700
X-CSE-ConnectionGUID: TSUVpagRQoGwKomcKEL7Sg==
X-CSE-MsgGUID: +F0IXPGCQLm+pP7cY6XniQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,149,1719903600"; 
   d="scan'208";a="90161483"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 15 Aug 2024 11:40:19 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sefOS-0005Tu-21;
	Thu, 15 Aug 2024 18:40:16 +0000
Date: Fri, 16 Aug 2024 02:39:31 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/mm] BUILD SUCCESS
 d4245fd4a62931aebd1c5e6b7b6f51b6ef7ad087
Message-ID: <202408160229.DgPLONSI-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/mm
branch HEAD: d4245fd4a62931aebd1c5e6b7b6f51b6ef7ad087  x86/mm: Remove duplicate check from build_cr3()

elapsed time: 1462m

configs tested: 200
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                     haps_hs_smp_defconfig   gcc-13.2.0
arc                   randconfig-001-20240815   gcc-13.2.0
arc                   randconfig-002-20240815   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-20
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                              allyesconfig   gcc-14.1.0
arm                     am200epdkit_defconfig   gcc-13.2.0
arm                                 defconfig   gcc-13.2.0
arm                          ixp4xx_defconfig   gcc-13.2.0
arm                   randconfig-001-20240815   gcc-13.2.0
arm                   randconfig-002-20240815   gcc-13.2.0
arm                   randconfig-003-20240815   gcc-13.2.0
arm                   randconfig-004-20240815   gcc-13.2.0
arm                        shmobile_defconfig   gcc-13.2.0
arm64                            allmodconfig   clang-20
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240815   gcc-13.2.0
arm64                 randconfig-002-20240815   gcc-13.2.0
arm64                 randconfig-003-20240815   gcc-13.2.0
arm64                 randconfig-004-20240815   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240815   gcc-13.2.0
csky                  randconfig-002-20240815   gcc-13.2.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   clang-20
hexagon                          allyesconfig   clang-20
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-12
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-12
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240815   gcc-12
i386         buildonly-randconfig-002-20240815   clang-18
i386         buildonly-randconfig-002-20240815   gcc-12
i386         buildonly-randconfig-003-20240815   clang-18
i386         buildonly-randconfig-003-20240815   gcc-12
i386         buildonly-randconfig-004-20240815   clang-18
i386         buildonly-randconfig-004-20240815   gcc-12
i386         buildonly-randconfig-005-20240815   clang-18
i386         buildonly-randconfig-005-20240815   gcc-12
i386         buildonly-randconfig-006-20240815   clang-18
i386         buildonly-randconfig-006-20240815   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240815   gcc-12
i386                  randconfig-002-20240815   clang-18
i386                  randconfig-002-20240815   gcc-12
i386                  randconfig-003-20240815   clang-18
i386                  randconfig-003-20240815   gcc-12
i386                  randconfig-004-20240815   gcc-12
i386                  randconfig-005-20240815   gcc-12
i386                  randconfig-006-20240815   gcc-12
i386                  randconfig-011-20240815   clang-18
i386                  randconfig-011-20240815   gcc-12
i386                  randconfig-012-20240815   clang-18
i386                  randconfig-012-20240815   gcc-12
i386                  randconfig-013-20240815   gcc-12
i386                  randconfig-014-20240815   clang-18
i386                  randconfig-014-20240815   gcc-12
i386                  randconfig-015-20240815   clang-18
i386                  randconfig-015-20240815   gcc-12
i386                  randconfig-016-20240815   gcc-12
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240815   gcc-13.2.0
loongarch             randconfig-002-20240815   gcc-13.2.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
m68k                           sun3_defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-14.1.0
mips                           ip30_defconfig   gcc-13.2.0
mips                          malta_defconfig   gcc-13.2.0
mips                          rm200_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240815   gcc-13.2.0
nios2                 randconfig-002-20240815   gcc-13.2.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240815   gcc-13.2.0
parisc                randconfig-002-20240815   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-20
powerpc                          allyesconfig   gcc-14.1.0
powerpc                    amigaone_defconfig   gcc-13.2.0
powerpc                  mpc885_ads_defconfig   gcc-13.2.0
powerpc               randconfig-001-20240815   gcc-13.2.0
powerpc               randconfig-002-20240815   gcc-13.2.0
powerpc64             randconfig-001-20240815   gcc-13.2.0
powerpc64             randconfig-002-20240815   gcc-13.2.0
powerpc64             randconfig-003-20240815   gcc-13.2.0
riscv                            allmodconfig   clang-20
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-14.1.0
riscv                 randconfig-001-20240815   gcc-13.2.0
riscv                 randconfig-002-20240815   gcc-13.2.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                             allyesconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240815   gcc-13.2.0
s390                  randconfig-002-20240815   gcc-13.2.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                        edosk7705_defconfig   gcc-13.2.0
sh                    randconfig-001-20240815   gcc-13.2.0
sh                    randconfig-002-20240815   gcc-13.2.0
sh                          rsk7264_defconfig   gcc-13.2.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                          alldefconfig   gcc-13.2.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240815   gcc-13.2.0
sparc64               randconfig-002-20240815   gcc-13.2.0
um                               allmodconfig   clang-20
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-12
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240815   gcc-13.2.0
um                    randconfig-002-20240815   gcc-13.2.0
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240815   gcc-12
x86_64       buildonly-randconfig-002-20240815   gcc-12
x86_64       buildonly-randconfig-003-20240815   gcc-12
x86_64       buildonly-randconfig-004-20240815   gcc-12
x86_64       buildonly-randconfig-005-20240815   gcc-12
x86_64       buildonly-randconfig-006-20240815   gcc-12
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-11
x86_64                randconfig-001-20240815   gcc-12
x86_64                randconfig-002-20240815   gcc-12
x86_64                randconfig-003-20240815   gcc-12
x86_64                randconfig-004-20240815   gcc-12
x86_64                randconfig-005-20240815   gcc-12
x86_64                randconfig-006-20240815   gcc-12
x86_64                randconfig-011-20240815   gcc-12
x86_64                randconfig-012-20240815   gcc-12
x86_64                randconfig-013-20240815   gcc-12
x86_64                randconfig-014-20240815   gcc-12
x86_64                randconfig-015-20240815   gcc-12
x86_64                randconfig-016-20240815   gcc-12
x86_64                randconfig-071-20240815   gcc-12
x86_64                randconfig-072-20240815   gcc-12
x86_64                randconfig-073-20240815   gcc-12
x86_64                randconfig-074-20240815   gcc-12
x86_64                randconfig-075-20240815   gcc-12
x86_64                randconfig-076-20240815   gcc-12
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                            allnoconfig   gcc-14.1.0
xtensa                  audio_kc705_defconfig   gcc-13.2.0
xtensa                       common_defconfig   gcc-13.2.0
xtensa                randconfig-001-20240815   gcc-13.2.0
xtensa                randconfig-002-20240815   gcc-13.2.0
xtensa                         virt_defconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

