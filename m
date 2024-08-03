Return-Path: <linux-kernel+bounces-273391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6739468B1
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 10:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57DF31C20B93
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 08:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B2514D6F9;
	Sat,  3 Aug 2024 08:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UzVcG4oO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4242C6AF
	for <linux-kernel@vger.kernel.org>; Sat,  3 Aug 2024 08:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722673423; cv=none; b=tn2SmRioq3LCY+aVCHpVACpABB1p7Gp8JFUHhNZk49E5aD4HLx0iqfwHRUUpYaxQo/NWNwZKIJPr469T5gKisewBNMleARQ5R+JFba2xM2i/ZARrasU9u2pYcXcpMP0/8PRVeIyjIbbVFgFP3lV35zW9oa9Tg/LzT4ymyfSt+is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722673423; c=relaxed/simple;
	bh=Trl7kDUEDx1yMJGDxEQzm0ykpbrgW5XKFcG+tzA0J3g=;
	h=Date:From:To:Cc:Subject:Message-ID; b=gFSRIuVIlKMTNyDlnakAwZQwjCCnGHryJ/m9noCo4gRPZEpJ93EGvLekekQLEnAzTU2WX1rRUQJ8QfLSsscuHIf3olbSAs8sXfnuGxGDWDVihLTAYgH1dfpLtoO27VQQKOmQMGAu2WCl5p026cZVRA6AeNcechph/qML2f3Miqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UzVcG4oO; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722673421; x=1754209421;
  h=date:from:to:cc:subject:message-id;
  bh=Trl7kDUEDx1yMJGDxEQzm0ykpbrgW5XKFcG+tzA0J3g=;
  b=UzVcG4oOyzSxRBtLq9lfWbt16NTTu/2kAEUp+YjAV9cnNtXoJBm4u/mv
   he5nTnGHcPqkjaux5FxHhaA4N6z2McoHsk2FvUnxc2LL4WatBya5ydNoE
   Iqbm57/heeIwOmoI8dMJRGIaWtozMzKzQb1oxgK30EmIzOEYpMv7MUnTa
   vNwG9BGg6R13Is5iIufAGssawJHx3MmOB5T0NQ2SQsnsa0aflU5aLBlEz
   KIvS6lDSjQ4dYbWybaT/XMfCvLuDpmPKO6kTzGq4mBv1f3+Vayp1AwP8a
   znaIyEcB01C40gHrw2IGDJgXkexa0+qdCOkID/huzMMcZpgqMZx9FVKNP
   A==;
X-CSE-ConnectionGUID: 9cIcPE5IR8+HtOJa9fYizA==
X-CSE-MsgGUID: kZrVGf76S6Ozn+Zgg2osig==
X-IronPort-AV: E=McAfee;i="6700,10204,11152"; a="38160002"
X-IronPort-AV: E=Sophos;i="6.09,260,1716274800"; 
   d="scan'208";a="38160002"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2024 01:23:40 -0700
X-CSE-ConnectionGUID: MCG3K/DySpaPK00ANLoskQ==
X-CSE-MsgGUID: TYC8jCotQmuPION2Ygzx2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,260,1716274800"; 
   d="scan'208";a="55601375"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 03 Aug 2024 01:23:39 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1saA2x-0000Jy-2y;
	Sat, 03 Aug 2024 08:23:30 +0000
Date: Sat, 03 Aug 2024 16:22:27 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 435dfff07e5b71ceecc35954645740ab91090fbb
Message-ID: <202408031624.rF76OthA-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 435dfff07e5b71ceecc35954645740ab91090fbb  Merge branch into tip/master: 'x86/timers'

elapsed time: 1457m

configs tested: 138
configs skipped: 6

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
arc                   randconfig-001-20240802   gcc-13.2.0
arc                   randconfig-002-20240802   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-14.1.0
arm                                 defconfig   gcc-13.2.0
arm                         nhk8815_defconfig   clang-20
arm                   randconfig-001-20240802   gcc-13.2.0
arm                   randconfig-002-20240802   gcc-13.2.0
arm                   randconfig-003-20240802   gcc-13.2.0
arm                   randconfig-004-20240802   gcc-13.2.0
arm                             rpc_defconfig   clang-20
arm                       spear13xx_defconfig   clang-20
arm64                            allmodconfig   clang-20
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240802   gcc-13.2.0
arm64                 randconfig-002-20240802   gcc-13.2.0
arm64                 randconfig-003-20240802   gcc-13.2.0
arm64                 randconfig-004-20240802   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240802   gcc-13.2.0
csky                  randconfig-002-20240802   gcc-13.2.0
hexagon                          allmodconfig   clang-20
hexagon                          allyesconfig   clang-20
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-12
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-12
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240802   gcc-13
i386         buildonly-randconfig-002-20240802   gcc-12
i386         buildonly-randconfig-003-20240802   clang-18
i386         buildonly-randconfig-004-20240802   gcc-13
i386         buildonly-randconfig-005-20240802   gcc-13
i386         buildonly-randconfig-006-20240802   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240802   gcc-12
i386                  randconfig-002-20240802   gcc-8
i386                  randconfig-003-20240802   clang-18
i386                  randconfig-004-20240802   gcc-13
i386                  randconfig-005-20240802   gcc-13
i386                  randconfig-006-20240802   gcc-13
i386                  randconfig-011-20240802   clang-18
i386                  randconfig-012-20240802   clang-18
i386                  randconfig-013-20240802   gcc-13
i386                  randconfig-014-20240802   clang-18
i386                  randconfig-015-20240802   clang-18
i386                  randconfig-016-20240802   gcc-11
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240802   gcc-13.2.0
loongarch             randconfig-002-20240802   gcc-13.2.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240802   gcc-13.2.0
nios2                 randconfig-002-20240802   gcc-13.2.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240802   gcc-13.2.0
parisc                randconfig-002-20240802   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   gcc-14.1.0
powerpc                      katmai_defconfig   clang-20
powerpc               randconfig-001-20240802   gcc-13.2.0
powerpc               randconfig-003-20240802   gcc-13.2.0
powerpc                      tqm8xx_defconfig   clang-20
powerpc64                        alldefconfig   clang-20
powerpc64             randconfig-001-20240802   gcc-13.2.0
powerpc64             randconfig-002-20240802   gcc-13.2.0
powerpc64             randconfig-003-20240802   gcc-13.2.0
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-14.1.0
riscv                 randconfig-001-20240802   gcc-13.2.0
riscv                 randconfig-002-20240802   gcc-13.2.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240802   gcc-13.2.0
s390                  randconfig-002-20240802   gcc-13.2.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                    randconfig-001-20240802   gcc-13.2.0
sh                    randconfig-002-20240802   gcc-13.2.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240802   gcc-13.2.0
sparc64               randconfig-002-20240802   gcc-13.2.0
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240802   gcc-13.2.0
um                    randconfig-002-20240802   gcc-13.2.0
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-11
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                randconfig-001-20240802   gcc-13.2.0
xtensa                randconfig-002-20240802   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

