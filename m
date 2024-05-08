Return-Path: <linux-kernel+bounces-172733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56FE18BF5EB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 08:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B568B28520B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 06:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3901D17C60;
	Wed,  8 May 2024 06:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VYIWgxab"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C502317756
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 06:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715148614; cv=none; b=C+P3rnb3+dSdsp5d39jaMuYRuKtNbpm+f9oe0aXqqRh6VjZ6QW90uu6datMHxa9El91zVeWzXYnnLt9KpW0XBDstSnKx7GIKxgOnO1OWtb3DXlLQRVBXXwidP+HKqTHgBf/yDG4sFhVYRMZqW20jvbFSmelOM+AHZ5IodhLwhis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715148614; c=relaxed/simple;
	bh=lqZdfEJUNlVMQ3K9Uudj6u+MGrPCjIZutlW1EvG8R8U=;
	h=Date:From:To:Cc:Subject:Message-ID; b=PgOLeGiJ5s+fOldSC5StMcoqPwP4WbqczMrjJCmovSVse82+de/EMmzFPNAC/W2nZPt6ymoyNIiMNy2vIzRstFlW9xiZslpA3Vst0SYRggDGWQKUEobCko8bGsgOHRft3FC19bjQlVvME+e6MK39LUCnsvVDG/e/RIeLFZQq7vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VYIWgxab; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715148613; x=1746684613;
  h=date:from:to:cc:subject:message-id;
  bh=lqZdfEJUNlVMQ3K9Uudj6u+MGrPCjIZutlW1EvG8R8U=;
  b=VYIWgxabidmTyN42pMSvWdnfHDDXpt0H+aB5HdY0BMrgTbF91xdYHOTL
   DGf7lAvHrbDIyRL73hFNzCeGf8tC2i5VgOVlUBKwcM2np+9ba3gPro5Z/
   a6wegY2FBepfNp7OnAxAw/Dk7yazv6yrqbp4jhoyHQJIsK9T1lmZvnjYN
   JtCOPtQcEL1gkPs9b08WhpttmoaTWrCPoN3JkwDcE9vOq6RWB91guoEIP
   vrwGxEDeEO40hLs0y4lXVGYEoI2E7fHgHOtoRF0SGrR+w6kKeOIbQr6fB
   y+VA+5dQMmpcLloMiwUV1P897amfsl1o6orjLNX3gznsBKKiM2QvDy/3X
   w==;
X-CSE-ConnectionGUID: QMA4WleeQsWwTaCsivGU/w==
X-CSE-MsgGUID: PIheiZtwSSWTk4nHh6ErjA==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="22380106"
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; 
   d="scan'208";a="22380106"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 23:10:12 -0700
X-CSE-ConnectionGUID: M/saBu4gRuKyHOJedVEz3g==
X-CSE-MsgGUID: se4wdPY2RoO/tpDW28GPeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; 
   d="scan'208";a="28869046"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 07 May 2024 23:10:10 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s4aVC-000344-0W;
	Wed, 08 May 2024 06:10:06 +0000
Date: Wed, 08 May 2024 14:09:27 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 7598293ab37c92025086de4b0ecd9474013a725f
Message-ID: <202405081426.WO8oNFO0-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 7598293ab37c92025086de4b0ecd9474013a725f  Merge branch into tip/master: 'x86/timers'

elapsed time: 1234m

configs tested: 163
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
arc                                 defconfig   gcc  
arc                   randconfig-001-20240508   gcc  
arc                   randconfig-002-20240508   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240508   gcc  
arm                   randconfig-002-20240508   clang
arm                   randconfig-003-20240508   clang
arm                   randconfig-004-20240508   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240508   gcc  
arm64                 randconfig-002-20240508   clang
arm64                 randconfig-003-20240508   gcc  
arm64                 randconfig-004-20240508   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240508   gcc  
csky                  randconfig-002-20240508   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240508   clang
hexagon               randconfig-002-20240508   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240507   clang
i386         buildonly-randconfig-002-20240507   clang
i386         buildonly-randconfig-003-20240507   clang
i386         buildonly-randconfig-004-20240507   gcc  
i386         buildonly-randconfig-005-20240507   gcc  
i386         buildonly-randconfig-006-20240507   clang
i386                                defconfig   clang
i386                  randconfig-001-20240507   clang
i386                  randconfig-002-20240507   gcc  
i386                  randconfig-003-20240507   clang
i386                  randconfig-004-20240507   clang
i386                  randconfig-005-20240507   clang
i386                  randconfig-006-20240507   clang
i386                  randconfig-011-20240507   gcc  
i386                  randconfig-012-20240507   clang
i386                  randconfig-013-20240507   clang
i386                  randconfig-014-20240507   gcc  
i386                  randconfig-015-20240507   gcc  
i386                  randconfig-016-20240507   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240508   gcc  
loongarch             randconfig-002-20240508   gcc  
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
nios2                 randconfig-001-20240508   gcc  
nios2                 randconfig-002-20240508   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240508   gcc  
parisc                randconfig-002-20240508   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20240508   clang
powerpc               randconfig-002-20240508   gcc  
powerpc               randconfig-003-20240508   clang
powerpc64             randconfig-001-20240508   gcc  
powerpc64             randconfig-002-20240508   gcc  
powerpc64             randconfig-003-20240508   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240508   gcc  
riscv                 randconfig-002-20240508   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240508   clang
s390                  randconfig-002-20240508   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240508   gcc  
sh                    randconfig-002-20240508   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240508   gcc  
sparc64               randconfig-002-20240508   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240508   gcc  
um                    randconfig-002-20240508   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240508   clang
x86_64       buildonly-randconfig-002-20240508   clang
x86_64       buildonly-randconfig-003-20240508   clang
x86_64       buildonly-randconfig-004-20240508   clang
x86_64       buildonly-randconfig-005-20240508   gcc  
x86_64       buildonly-randconfig-006-20240508   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240508   gcc  
x86_64                randconfig-002-20240508   clang
x86_64                randconfig-003-20240508   clang
x86_64                randconfig-004-20240508   gcc  
x86_64                randconfig-005-20240508   gcc  
x86_64                randconfig-006-20240508   gcc  
x86_64                randconfig-011-20240508   clang
x86_64                randconfig-012-20240508   clang
x86_64                randconfig-013-20240508   gcc  
x86_64                randconfig-014-20240508   gcc  
x86_64                randconfig-015-20240508   clang
x86_64                randconfig-016-20240508   gcc  
x86_64                randconfig-071-20240508   gcc  
x86_64                randconfig-072-20240508   gcc  
x86_64                randconfig-073-20240508   clang
x86_64                randconfig-074-20240508   gcc  
x86_64                randconfig-075-20240508   gcc  
x86_64                randconfig-076-20240508   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240508   gcc  
xtensa                randconfig-002-20240508   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

