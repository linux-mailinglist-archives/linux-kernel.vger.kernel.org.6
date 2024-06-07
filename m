Return-Path: <linux-kernel+bounces-205845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FE590011D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 12:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F7FF1F2203F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 10:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25DD615ECD6;
	Fri,  7 Jun 2024 10:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WjIbObKR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFFD15D5C4
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 10:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717757036; cv=none; b=XKPoRLY+npsdnogKOBWgg/LBIMCClCYRy5FsMrqynmnkF+P9HoOJ4HlyDHAsKpkidhqWJHhcswvOU9pNEXuBhibjsRbNerPW6tP5+aIV/KwA2QqpxBdr/6CsJqV9/lBu1Wsf1RMhhyTmANmCWRXuPJu5ygCyJBZ13aPFqpW1B58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717757036; c=relaxed/simple;
	bh=nftZrm39yKOwCjNTnJxdn3wtYwK7szKXFcVQzaV3Yw8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=GQge0SNT2SBV6Fk+SNyCE5tRHgAhjg6rqowXw7oRTuhu14oRbHn3ATgZFE6fYke9Mbmlwow+9JvytJ527oG+DGA2X8U6gozWiTcyrYpHP31Lo4+J+Ru7gTxAxdw0ckbUh0zeUkFPbkE8RsfvBqSZGQK0dPNYaN+YnJSfUkecOH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WjIbObKR; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717757035; x=1749293035;
  h=date:from:to:cc:subject:message-id;
  bh=nftZrm39yKOwCjNTnJxdn3wtYwK7szKXFcVQzaV3Yw8=;
  b=WjIbObKRPc1SIQoZnwe+njJaE/q3QGWnHYXQKQ5rqFFGlmVzByNklXA6
   gQFxI0gqIPO8mcuRvskZp8Y9TUfXLWa+tsDIIJNt4Qm8MKoQ6teRa30Yw
   Qb0nmD5656/tGPpJ7g9+bqdH76ad0VbzFHHHfzaSihNqeE/8PwfI7e8sV
   e2OhfRB1o36axPIDq0LpRibViWDrd9jkl6qjfHLBHzSp2BHyNxP4mqW0Y
   cgXpnStuAXrFSIxtD5fwnUdi32E56e+KOVhLcKkNqXkUlmqpi4TiBQJ+3
   v6U3EUzbp3jpH1BVaI4OECtJnZ3P2tklEGFctuQku01whs3uhE3w7E3xr
   Q==;
X-CSE-ConnectionGUID: /VWIpF0WT/Ob5X1EYdhSyw==
X-CSE-MsgGUID: dcOLvRBpThGfVqkegGrARA==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="11962272"
X-IronPort-AV: E=Sophos;i="6.08,220,1712646000"; 
   d="scan'208";a="11962272"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 03:43:54 -0700
X-CSE-ConnectionGUID: fy31twCCS5ibxzGgyTIOKg==
X-CSE-MsgGUID: REclHMxUQ+qnE2qyrHUHxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,220,1712646000"; 
   d="scan'208";a="75767764"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 07 Jun 2024 03:43:53 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sFX4Y-0004ek-32;
	Fri, 07 Jun 2024 10:43:50 +0000
Date: Fri, 07 Jun 2024 18:43:27 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 bf432610fb7b6870036f8f9ebbbef13cac638904
Message-ID: <202406071825.f0lPYkAs-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: bf432610fb7b6870036f8f9ebbbef13cac638904  Merge branch into tip/master: 'x86/percpu'

elapsed time: 1475m

configs tested: 113
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240607   gcc  
arc                   randconfig-002-20240607   gcc  
arm                               allnoconfig   clang
arm                                 defconfig   clang
arm                   randconfig-002-20240607   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386         buildonly-randconfig-001-20240607   clang
i386         buildonly-randconfig-002-20240607   clang
i386         buildonly-randconfig-003-20240607   clang
i386         buildonly-randconfig-004-20240607   clang
i386         buildonly-randconfig-005-20240607   clang
i386         buildonly-randconfig-006-20240607   clang
i386                  randconfig-001-20240607   gcc  
i386                  randconfig-002-20240607   gcc  
i386                  randconfig-003-20240607   gcc  
i386                  randconfig-004-20240607   gcc  
i386                  randconfig-005-20240607   gcc  
i386                  randconfig-006-20240607   gcc  
i386                  randconfig-011-20240607   clang
i386                  randconfig-012-20240607   gcc  
i386                  randconfig-013-20240607   clang
i386                  randconfig-014-20240607   clang
i386                  randconfig-015-20240607   clang
i386                  randconfig-016-20240607   clang
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
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
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
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
x86_64       buildonly-randconfig-001-20240606   gcc  
x86_64       buildonly-randconfig-002-20240606   clang
x86_64       buildonly-randconfig-003-20240606   gcc  
x86_64       buildonly-randconfig-004-20240606   gcc  
x86_64       buildonly-randconfig-005-20240606   gcc  
x86_64       buildonly-randconfig-006-20240606   clang
x86_64                randconfig-001-20240606   gcc  
x86_64                randconfig-002-20240606   gcc  
x86_64                randconfig-003-20240606   gcc  
x86_64                randconfig-004-20240606   clang
x86_64                randconfig-005-20240606   gcc  
x86_64                randconfig-006-20240606   gcc  
x86_64                randconfig-011-20240606   clang
x86_64                randconfig-012-20240606   gcc  
x86_64                randconfig-013-20240606   clang
x86_64                randconfig-014-20240606   clang
x86_64                randconfig-015-20240606   clang
x86_64                randconfig-016-20240606   clang
x86_64                randconfig-071-20240606   clang
x86_64                randconfig-072-20240606   gcc  
x86_64                randconfig-073-20240606   clang
x86_64                randconfig-074-20240606   clang
x86_64                randconfig-075-20240606   gcc  
x86_64                randconfig-076-20240606   clang
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

