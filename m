Return-Path: <linux-kernel+bounces-176433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C799E8C2FDC
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 08:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B953283F6F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 06:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A089917C8;
	Sat, 11 May 2024 06:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aXZbCAYE"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A1C380
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 06:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715409174; cv=none; b=hQBZSl8iYFFo0G/gVyeqGnpI5Tg9jVjSKIDJDnfkFSJxqguJNkDCmGG+URpE4aOGnzU/d+WkY81oLrppVvVez5cXQX7TnzO0N409KGMQX/pyaNjrKEd11CMbPIFoo27kE/PADhKxW9r+QgMsFWPssp9DaLg+HUIpDUCDqM0HcQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715409174; c=relaxed/simple;
	bh=x2NXg246qNH7wtEWMLuyyFdCXqMpeOZA5css5pgVgrQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=eCE8I4Yc4Cg/f5COu6zAOk5SrroMdiH9L2/UNf2rVteejg5g87snmqEW2zNr7DGOaToWXEngPUGHZvc+Qc6jfbxouf/+ROzLinm7j4oLl16Apt+/4DHeAW/jum7qF8BOu5K3jRFJI+xMnHEU09lhhH964ZGq0nKQIDzrZp2R2gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aXZbCAYE; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715409172; x=1746945172;
  h=date:from:to:cc:subject:message-id;
  bh=x2NXg246qNH7wtEWMLuyyFdCXqMpeOZA5css5pgVgrQ=;
  b=aXZbCAYEF4tNMgE1uoIx/x6FZEZSGex+MS6XriMSGfj1jSLLgBCsq7Gd
   U75aE53LaQYBlWPpqW7F7WhvPjgBlZyT4jXOy3gye1i1JEXakLj+HjbCK
   j9BFjT4lr1iNa/1ZrQmG/fVNRvJo2OldJT4jiC+NAZEQwJ4o7fDT9KHd4
   Mush3YfTGEys5kT/HfJU84WSNprYVxDE404ab8Q0DSIb6kR0YwR1mqPUM
   ++VwJkdkxF/lKfJFzIRey7pZXEoMvXOkfB3zvAVR8oQKF1aCYUczivHUy
   34TRUeWx+2VpU9EqJhmpeJo7XBV1QXMFXrcU/sFbfMj65vh+JQpP8vlPi
   Q==;
X-CSE-ConnectionGUID: 10xHkoF1Qvy8wlSD7WKWSA==
X-CSE-MsgGUID: N4qD3UQyTFqxhzAkzMU27w==
X-IronPort-AV: E=McAfee;i="6600,9927,11069"; a="11567788"
X-IronPort-AV: E=Sophos;i="6.08,153,1712646000"; 
   d="scan'208";a="11567788"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 23:32:52 -0700
X-CSE-ConnectionGUID: nTSJWChqSymM3H3PxoMUoA==
X-CSE-MsgGUID: JpNFIrHjTMS/BeX1B7mKFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,153,1712646000"; 
   d="scan'208";a="61012535"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 10 May 2024 23:32:50 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s5gHo-00072F-0x;
	Sat, 11 May 2024 06:32:48 +0000
Date: Sat, 11 May 2024 14:32:05 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 283cde9845c3b6478166a2e4c6faba2a9c734c69
Message-ID: <202405111404.zDg1bazs-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 283cde9845c3b6478166a2e4c6faba2a9c734c69  Merge branch into tip/master: 'x86/timers'

elapsed time: 1352m

configs tested: 180
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                      axs103_smp_defconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240511   gcc  
arc                   randconfig-002-20240511   gcc  
arc                    vdk_hs38_smp_defconfig   gcc  
arm                              alldefconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                          collie_defconfig   gcc  
arm                                 defconfig   clang
arm                          ep93xx_defconfig   clang
arm                            mmp2_defconfig   gcc  
arm                   randconfig-001-20240511   clang
arm                   randconfig-002-20240511   clang
arm                   randconfig-003-20240511   gcc  
arm                   randconfig-004-20240511   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240511   gcc  
arm64                 randconfig-002-20240511   clang
arm64                 randconfig-003-20240511   gcc  
arm64                 randconfig-004-20240511   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240511   gcc  
csky                  randconfig-002-20240511   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240511   clang
hexagon               randconfig-002-20240511   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240510   clang
i386         buildonly-randconfig-002-20240510   gcc  
i386         buildonly-randconfig-003-20240510   clang
i386         buildonly-randconfig-004-20240510   clang
i386         buildonly-randconfig-005-20240510   clang
i386         buildonly-randconfig-006-20240510   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240510   clang
i386                  randconfig-002-20240510   clang
i386                  randconfig-003-20240510   gcc  
i386                  randconfig-004-20240510   gcc  
i386                  randconfig-005-20240510   clang
i386                  randconfig-006-20240510   clang
i386                  randconfig-011-20240510   clang
i386                  randconfig-012-20240510   clang
i386                  randconfig-013-20240510   gcc  
i386                  randconfig-014-20240510   clang
i386                  randconfig-015-20240510   gcc  
i386                  randconfig-016-20240510   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240511   gcc  
loongarch             randconfig-002-20240511   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240511   gcc  
nios2                 randconfig-002-20240511   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                 simple_smp_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240511   gcc  
parisc                randconfig-002-20240511   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      chrp32_defconfig   clang
powerpc                    klondike_defconfig   gcc  
powerpc                     mpc512x_defconfig   clang
powerpc               randconfig-001-20240511   gcc  
powerpc               randconfig-002-20240511   clang
powerpc               randconfig-003-20240511   gcc  
powerpc                 xes_mpc85xx_defconfig   gcc  
powerpc64             randconfig-001-20240511   gcc  
powerpc64             randconfig-002-20240511   gcc  
powerpc64             randconfig-003-20240511   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240511   gcc  
riscv                 randconfig-002-20240511   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240511   clang
s390                  randconfig-002-20240511   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                ecovec24-romimage_defconfig   gcc  
sh                 kfr2r09-romimage_defconfig   gcc  
sh                    randconfig-001-20240511   gcc  
sh                    randconfig-002-20240511   gcc  
sh                   rts7751r2dplus_defconfig   gcc  
sh                           se7722_defconfig   gcc  
sh                           se7724_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240511   gcc  
sparc64               randconfig-002-20240511   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240511   gcc  
um                    randconfig-002-20240511   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240511   gcc  
x86_64       buildonly-randconfig-002-20240511   gcc  
x86_64       buildonly-randconfig-003-20240511   gcc  
x86_64       buildonly-randconfig-004-20240511   gcc  
x86_64       buildonly-randconfig-005-20240511   clang
x86_64       buildonly-randconfig-006-20240511   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240511   clang
x86_64                randconfig-002-20240511   clang
x86_64                randconfig-003-20240511   clang
x86_64                randconfig-004-20240511   gcc  
x86_64                randconfig-005-20240511   gcc  
x86_64                randconfig-006-20240511   clang
x86_64                randconfig-011-20240511   clang
x86_64                randconfig-012-20240511   gcc  
x86_64                randconfig-013-20240511   gcc  
x86_64                randconfig-014-20240511   gcc  
x86_64                randconfig-015-20240511   gcc  
x86_64                randconfig-016-20240511   gcc  
x86_64                randconfig-071-20240511   gcc  
x86_64                randconfig-072-20240511   gcc  
x86_64                randconfig-073-20240511   clang
x86_64                randconfig-074-20240511   gcc  
x86_64                randconfig-075-20240511   gcc  
x86_64                randconfig-076-20240511   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                          iss_defconfig   gcc  
xtensa                randconfig-001-20240511   gcc  
xtensa                randconfig-002-20240511   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

