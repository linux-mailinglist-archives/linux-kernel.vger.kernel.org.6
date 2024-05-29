Return-Path: <linux-kernel+bounces-193632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0E78D2EDD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 09:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAF8A1F2A886
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 07:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE44168C08;
	Wed, 29 May 2024 07:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FdKuwTOW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D958315FCE6
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 07:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716968868; cv=none; b=NdrSdrdepRuigG1gi5VRUXeEZlueFTaUFFHDpFJJCvRf7vpCtbDPy+WzJudU0YHa5xjBAJjqC1gMF5/yAfyca3wiwEpUBgjp2xZaCteUwE+N8wYy0sMWp1mYORxZEjOqd4UINMryfIpiJm6xlF/4nZE3B3FRHjm2VFsHM6Ci22A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716968868; c=relaxed/simple;
	bh=HUU8OJHy+T5E9msAr/ClwIsTk/9KwT3s/ADzOgrW/yk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=JAP3OGBb+1Va7V7FuZDmi8AgEN84OjWItOGpIOam464iP7+t/zhOV00eiT3sCHDUEhN5QXUODVeMEl5AcGR8LLmi/Wu0ANHnCUAF9azICSTRR9V6LlSKdkuCvImyWeABP66RVpJZRcp/+JaZUc1WgEyWgRRhRgNreK7C1f3gmAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FdKuwTOW; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716968867; x=1748504867;
  h=date:from:to:cc:subject:message-id;
  bh=HUU8OJHy+T5E9msAr/ClwIsTk/9KwT3s/ADzOgrW/yk=;
  b=FdKuwTOW+1tb5dlmXqKc8DltU2cU/gdJY/Cxl6c/opJuFHxSDM4tQl8B
   eYIcynDRiEY6vInwEojkJPctwdXkwlldZjEJrUGfV4cb4OS6acsjQlnAd
   +vbUwW4XN7wQevRwqI6n0vaUgDVNBh2ifrcSnlpmE5Xj9vDkC97Rl+3Ey
   aSygS31l81FgrNmTiCzKlnZur/GHfOmDeV4thVwzWlMhesWc7Vt//+05V
   pDe7DKKcQs/KTsQUuxB6HnnnR+SzxAkw7EaOoc0wp0uPal8ZgDJx0UJ5Z
   BtMs+A1xytncUcuH3zD4+tdFodIHkj5/YN0h+NBNTebcWdaeU9kSveKcL
   g==;
X-CSE-ConnectionGUID: N72hK8enROCLpkMXqfZm+g==
X-CSE-MsgGUID: c9nd/dkuT+KzzF453xMFkA==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13197130"
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="13197130"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 00:47:46 -0700
X-CSE-ConnectionGUID: z1SeQbRATKWX78whQC4f7Q==
X-CSE-MsgGUID: rseD7sIwQNqfj97kJLaP4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="35301755"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 29 May 2024 00:47:45 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sCE29-000DHf-2I;
	Wed, 29 May 2024 07:47:42 +0000
Date: Wed, 29 May 2024 15:47:30 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:non-rcu/next] BUILD SUCCESS
 6b59ef87fa0bab0ba976f221d34308b6edc7ee07
Message-ID: <202405291528.ybyaKpPZ-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git non-rcu/next
branch HEAD: 6b59ef87fa0bab0ba976f221d34308b6edc7ee07  tsc: Check for sockets instead of CPUs to make code match comment

elapsed time: 815m

configs tested: 95
configs skipped: 134

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arm                        clps711x_defconfig   clang
arm                             mxs_defconfig   clang
arm                           sama7_defconfig   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   clang
arm64                               defconfig   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-002-20240529   gcc  
i386         buildonly-randconfig-003-20240529   gcc  
i386         buildonly-randconfig-005-20240529   gcc  
i386                                defconfig   clang
i386                  randconfig-002-20240529   gcc  
i386                  randconfig-003-20240529   gcc  
i386                  randconfig-004-20240529   gcc  
i386                  randconfig-014-20240529   gcc  
i386                  randconfig-016-20240529   gcc  
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
powerpc                      katmai_defconfig   clang
powerpc                 linkstation_defconfig   clang
powerpc                       ppc64_defconfig   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                    nommu_k210_defconfig   clang
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
um                               alldefconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-002-20240529   clang
x86_64       buildonly-randconfig-003-20240529   clang
x86_64       buildonly-randconfig-005-20240529   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-002-20240529   clang
x86_64                randconfig-003-20240529   clang
x86_64                randconfig-004-20240529   clang
x86_64                randconfig-013-20240529   clang
x86_64                randconfig-016-20240529   clang
x86_64                randconfig-071-20240529   clang
x86_64                randconfig-074-20240529   clang
x86_64                randconfig-075-20240529   clang
x86_64                randconfig-076-20240529   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

