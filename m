Return-Path: <linux-kernel+bounces-195088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B18C8D4775
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 10:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11DC6283FC5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 08:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B726F302;
	Thu, 30 May 2024 08:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WFHb7A11"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB531761BF
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 08:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717058927; cv=none; b=a74lxwUt9cF2ZJQlq+dtxS1VuRonnUJdMaGLhP71whyS5g4ZeMx2VPy9OOnuDSCSjbczmUodRIEC31+tZn9doHzOv4fsXqP57BPWt5ITwluvbQZOyRaC/R79NXl6HGDsDBu44qlKyDsTo6Hi4rQUuWgtuMyDW9BaxDJrQ6l/oeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717058927; c=relaxed/simple;
	bh=K9AYVGqmmTbqc2fz0HuTn2hcwb/UzZwnoV2Z3W2k5k4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=XwqHxG+klutKqLuXgOQYpsG+p2oB/mexGUyr3yQ6pRCg1oV8CmaDpNBEvCMMmF/ovtRg8OVS6sTf7jnMqcnZLGM1mbLZxibB+iS67hBd6lWwOyRsBdR/k/3AE8J1P9/IkUkJxXRzBcHIV12R3/9D4d/6mXAESSlm7pbK2zz7Kp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WFHb7A11; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717058925; x=1748594925;
  h=date:from:to:cc:subject:message-id;
  bh=K9AYVGqmmTbqc2fz0HuTn2hcwb/UzZwnoV2Z3W2k5k4=;
  b=WFHb7A11B9WV59/IPVLquOicTqMaFHkqRu7VIMdgeyzrwSTV91GYvBmu
   hkKFPnRUVvpJkC5ldqWIdkLymaZS+u4sWC5etCGcnTRiGo7pCsnStkZMc
   SZ95NUOzGDyxt59iNJ6EGnu0Z/QDo6vPoB2ShMpK/BuDDqz15MZ2yvuF4
   UWvhtm15DaFOQb8sioSak3VswQfNiws6NOdj2GsJwOCcHCyLt6iFSazUY
   3UobH/N56KR6s/FOjmp002TISrAW45YpF25+frw5XU+jEn7YBaK+nyt7N
   wTuKXXrvKeoyqTgEKyfkszKzvTNNCNamWNxv2IMOzY79cvcidg3VLjb1p
   Q==;
X-CSE-ConnectionGUID: v7kSifotQaKYVDu+RRKE1A==
X-CSE-MsgGUID: B/tvK1MJTmu+KRUxStWWuA==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="13470287"
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="13470287"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 01:48:44 -0700
X-CSE-ConnectionGUID: 3v9b1s6gRamjGqzAs3IwZQ==
X-CSE-MsgGUID: +wKLB0EWTxSKxTBKXA7nyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="35828442"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 30 May 2024 01:48:43 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sCbSi-000F2L-1d;
	Thu, 30 May 2024 08:48:40 +0000
Date: Thu, 30 May 2024 16:47:52 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/cc] BUILD SUCCESS
 3f3d80f505f3d7273f374935558db5188acdd162
Message-ID: <202405301649.VEKylzRj-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cc
branch HEAD: 3f3d80f505f3d7273f374935558db5188acdd162  x86/kexec: Remove spurious unconditional JMP from from identity_mapped()

elapsed time: 986m

configs tested: 81
configs skipped: 149

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
hexagon                          allmodconfig   clang
hexagon                          allyesconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240530   gcc  
i386         buildonly-randconfig-002-20240530   gcc  
i386         buildonly-randconfig-003-20240530   clang
i386         buildonly-randconfig-004-20240530   clang
i386         buildonly-randconfig-005-20240530   clang
i386         buildonly-randconfig-006-20240530   clang
i386                                defconfig   clang
i386                  randconfig-001-20240530   gcc  
i386                  randconfig-002-20240530   clang
i386                  randconfig-003-20240530   gcc  
i386                  randconfig-004-20240530   clang
i386                  randconfig-005-20240530   gcc  
i386                  randconfig-006-20240530   gcc  
i386                  randconfig-011-20240530   clang
i386                  randconfig-012-20240530   gcc  
i386                  randconfig-013-20240530   clang
i386                  randconfig-014-20240530   clang
i386                  randconfig-015-20240530   gcc  
i386                  randconfig-016-20240530   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
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
openrisc                          allnoconfig   gcc  
openrisc                            defconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
s390                             allyesconfig   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                               allyesconfig   gcc  
um                             i386_defconfig   gcc  
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

