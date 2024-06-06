Return-Path: <linux-kernel+bounces-204496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C455E8FEFCE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 17:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6B251C24398
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380FD19E7C9;
	Thu,  6 Jun 2024 14:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J/TAwQlP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2303B198E9A
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 14:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717684749; cv=none; b=rK0Gy3pPQN+7fo0zR6qHYp1ZPwQSJmxiN0VkLSL3PUrrdUMVvPt8+O2Oa7cmlj+0Usy37JHstIdOV+kWg4025QYTzlkXIzEhSlxY9zxNEcM2QcF+1kjYYvHQDebEUZsrr+EfGb9f3roVhA1LheQbTZzripRyohbEUmCUK5ObPbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717684749; c=relaxed/simple;
	bh=O8n0Mo/8n7ogCj2ojDahL4mRLFE5oqFOARZIsUqF7dY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Tza/aGcU1i8ccYHUd1dWBHF/CG7TvBnCNX/JmhUYtH5pqEoxhvjFnxsM6MeJZjd8F3esfLc9VIPj/CFTQwajgnuQX+a3b1tuyPbmx7exKkF6HKD84bRe5nAP3jiE8TEpgy1qe6TyLPgA1PfSUhy4r5sRBk9Jkg/9N46I+jbrF88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J/TAwQlP; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717684747; x=1749220747;
  h=date:from:to:cc:subject:message-id;
  bh=O8n0Mo/8n7ogCj2ojDahL4mRLFE5oqFOARZIsUqF7dY=;
  b=J/TAwQlP70zHV8r1cRRwC1QIn3x2+n4Uw+9spO7XPrnH2OZns0C9Rs+O
   /ZvgcECW/JklzVEreXjO3bU8es/GZQiDHpdg2LMdB7J3hPu3Z/w+1BbTq
   oZi5+ksjrBhQlTr0iNv3a8Si8Z31qXZ5dxX2hqmgVuozcJ2UVSoSRP529
   1NaGm+BKlIJIme/0B37jdUjCTMJdgxHYNQ58+M/u8fZW/hmaQ84XLShpm
   FchnG/RL20MhV6AUnBmuWFcPu5HxgwZ4bHph3LRqCA5mWffk2xTRCe7MK
   86FLYFWcnyNwj83VLIi7zdK4dTyiFwTIlzHqTso44dkwLZoszfiBU1Bfe
   Q==;
X-CSE-ConnectionGUID: TfRlLQVkSFGRN57jv7m7ZQ==
X-CSE-MsgGUID: 77s7kL3fRZSEIlWUiTrJAQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="31901658"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="31901658"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 07:39:06 -0700
X-CSE-ConnectionGUID: q1D6jtKDTuqn+0suMFMbaw==
X-CSE-MsgGUID: CgpZ025QRLGxLkqo/I+3GQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="38090799"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 06 Jun 2024 07:39:05 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sFEGc-0003DM-2Y;
	Thu, 06 Jun 2024 14:39:02 +0000
Date: Thu, 06 Jun 2024 22:38:22 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:locking/urgent] BUILD SUCCESS
 f92a59f6d12e31ead999fee9585471b95a8ae8a3
Message-ID: <202406062219.Tm2wTgBS-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/urgent
branch HEAD: f92a59f6d12e31ead999fee9585471b95a8ae8a3  locking/atomic: scripts: fix ${atomic}_sub_and_test() kerneldoc

elapsed time: 1474m

configs tested: 148
configs skipped: 4

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
arc                   randconfig-001-20240606   gcc  
arc                   randconfig-002-20240606   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                           omap1_defconfig   gcc  
arm                           tegra_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-002-20240606   gcc  
csky                             alldefconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240606   gcc  
csky                  randconfig-002-20240606   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240606   clang
i386         buildonly-randconfig-002-20240606   clang
i386         buildonly-randconfig-003-20240606   clang
i386         buildonly-randconfig-004-20240606   gcc  
i386         buildonly-randconfig-005-20240606   clang
i386         buildonly-randconfig-006-20240606   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240606   clang
i386                  randconfig-002-20240606   clang
i386                  randconfig-003-20240606   clang
i386                  randconfig-004-20240606   clang
i386                  randconfig-005-20240606   clang
i386                  randconfig-006-20240606   clang
i386                  randconfig-011-20240606   clang
i386                  randconfig-012-20240606   gcc  
i386                  randconfig-013-20240606   gcc  
i386                  randconfig-014-20240606   gcc  
i386                  randconfig-015-20240606   gcc  
i386                  randconfig-016-20240606   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240606   gcc  
loongarch             randconfig-002-20240606   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                          hp300_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                      maltasmvp_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240606   gcc  
nios2                 randconfig-002-20240606   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240606   gcc  
parisc                randconfig-002-20240606   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                        icon_defconfig   gcc  
powerpc               randconfig-001-20240606   gcc  
powerpc               randconfig-002-20240606   gcc  
powerpc               randconfig-003-20240606   gcc  
powerpc64             randconfig-003-20240606   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240606   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240606   gcc  
s390                  randconfig-002-20240606   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                          r7785rp_defconfig   gcc  
sh                    randconfig-001-20240606   gcc  
sh                    randconfig-002-20240606   gcc  
sh                      rts7751r2d1_defconfig   gcc  
sh                  sh7785lcr_32bit_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240606   gcc  
sparc64               randconfig-002-20240606   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-002-20240606   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-002-20240606   clang
x86_64       buildonly-randconfig-006-20240606   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-011-20240606   clang
x86_64                randconfig-013-20240606   clang
x86_64                randconfig-014-20240606   clang
x86_64                randconfig-015-20240606   clang
x86_64                randconfig-016-20240606   clang
x86_64                randconfig-071-20240606   clang
x86_64                randconfig-073-20240606   clang
x86_64                randconfig-074-20240606   clang
x86_64                randconfig-076-20240606   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                  nommu_kc705_defconfig   gcc  
xtensa                randconfig-001-20240606   gcc  
xtensa                randconfig-002-20240606   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

