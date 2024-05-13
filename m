Return-Path: <linux-kernel+bounces-177432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFEFD8C3E80
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 12:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F22821C2165F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 10:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53ED6149001;
	Mon, 13 May 2024 10:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YWdDR+38"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D4414885F
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 10:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715594427; cv=none; b=eqr1w3PvYm9XB+rV+kXuOEdFe13GSYP7ZgUEJdqF0EOaEgj5KR9B2LHcHLHqj5A4lYNY737Mb3BMO3YJZTe7E9Qo49NSmQThK/W2UhCtHYmo+5I5v2FjW2OPSaDo7xznxu4R9wx/5mWHvEzwOyDIq2P1nNFV5Yz6ozN/Lj25ivQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715594427; c=relaxed/simple;
	bh=TA2SsAy7GABkk4KvBm1yFpCxBDWW7uEenMlcgdZBtvM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=naqN7PkqV7RK7VCgBgMus/+x31x7qUp34NVo5W7HLEPb6ggnOzEBt8mrv14YmUqkP6UCFJKENnrZ2MlRMARiYlozgUf0jGQCNCvtvP+WFMMh+M8ngSunVg73BZg3Z6fQle3ft4hIpDFL31mlVPmhwIS34NDtkRdjdbldLkvj2ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YWdDR+38; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715594426; x=1747130426;
  h=date:from:to:cc:subject:message-id;
  bh=TA2SsAy7GABkk4KvBm1yFpCxBDWW7uEenMlcgdZBtvM=;
  b=YWdDR+38OVqoUT0vgMYvYwS+KzDOAxEn3yqd9BOGlsEo8iLO81Axz729
   KWlxGuxaNoMcbPPk3/pDx01uWl5cT6tQ+8ajjm0pqSC0lL/qsh0Mfgc5t
   6pJjEN7w2SCcyG6kw1Wkz/GhnbHJuixRaa0cfnCGO1MDHAWRu2kFm1IXn
   be2CiBPFpL2i83XsHbiZCjpkVa2WClbbqzTkSrpBAW8g+eCoNPmHdiY8x
   TbMhFfk4lQJFbbQC7dHPVfa4RcjGRq7bkHPeV7DTKnuzg4dKMA2cMvwq3
   07XyblBDUV/Bd+OIGKs6bzEk2DnF9TyOU/H0IWzxyKd/zH9lgVLFG3WZ5
   w==;
X-CSE-ConnectionGUID: GPns/kIdRA6fFoZNbOG4nA==
X-CSE-MsgGUID: LKrDS5rcTFOyc9w0sQGVeg==
X-IronPort-AV: E=McAfee;i="6600,9927,11071"; a="11343255"
X-IronPort-AV: E=Sophos;i="6.08,158,1712646000"; 
   d="scan'208";a="11343255"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 03:00:25 -0700
X-CSE-ConnectionGUID: xEQMPX7JR36jckkSXoZ+Eg==
X-CSE-MsgGUID: p7nsEfYFTUSnbdqUdItHCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,158,1712646000"; 
   d="scan'208";a="30313460"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 13 May 2024 03:00:23 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s6STl-000A3P-23;
	Mon, 13 May 2024 10:00:21 +0000
Date: Mon, 13 May 2024 18:00:03 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 0e9b1d2b05601ee54f26a3f562450db708707e85
Message-ID: <202405131801.dDsA9EZH-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: 0e9b1d2b05601ee54f26a3f562450db708707e85  Merge branches 'cmpxchg.2024.05.11a', 'kcsan.2024.05.07a', 'lkmm.2024.05.06a', 'rcu-merge.2024.05.01a' and 'tsc.2024.04.09c' into HEAD

elapsed time: 726m

configs tested: 179
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
arc                   randconfig-001-20240513   gcc  
arc                   randconfig-002-20240513   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                         lpc32xx_defconfig   clang
arm                   randconfig-001-20240513   clang
arm                   randconfig-002-20240513   gcc  
arm                   randconfig-003-20240513   clang
arm                   randconfig-004-20240513   gcc  
arm                           sunxi_defconfig   gcc  
arm                        vexpress_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240513   gcc  
arm64                 randconfig-002-20240513   gcc  
arm64                 randconfig-003-20240513   clang
arm64                 randconfig-004-20240513   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240513   gcc  
csky                  randconfig-002-20240513   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240513   clang
hexagon               randconfig-002-20240513   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240513   clang
i386         buildonly-randconfig-002-20240513   clang
i386         buildonly-randconfig-003-20240513   gcc  
i386         buildonly-randconfig-004-20240513   clang
i386         buildonly-randconfig-005-20240513   gcc  
i386         buildonly-randconfig-006-20240513   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240513   gcc  
i386                  randconfig-002-20240513   clang
i386                  randconfig-003-20240513   gcc  
i386                  randconfig-004-20240513   clang
i386                  randconfig-005-20240513   gcc  
i386                  randconfig-006-20240513   gcc  
i386                  randconfig-011-20240513   gcc  
i386                  randconfig-012-20240513   clang
i386                  randconfig-013-20240513   clang
i386                  randconfig-014-20240513   gcc  
i386                  randconfig-015-20240513   gcc  
i386                  randconfig-016-20240513   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240513   gcc  
loongarch             randconfig-002-20240513   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                            mac_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                          ath79_defconfig   gcc  
mips                           jazz_defconfig   clang
mips                     loongson1b_defconfig   clang
mips                     loongson2k_defconfig   gcc  
mips                        qi_lb60_defconfig   clang
mips                           rs90_defconfig   gcc  
mips                         rt305x_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240513   gcc  
nios2                 randconfig-002-20240513   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240513   gcc  
parisc                randconfig-002-20240513   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                       eiger_defconfig   clang
powerpc               randconfig-001-20240513   gcc  
powerpc               randconfig-002-20240513   gcc  
powerpc               randconfig-003-20240513   gcc  
powerpc                     redwood_defconfig   clang
powerpc                      tqm8xx_defconfig   clang
powerpc64             randconfig-001-20240513   gcc  
powerpc64             randconfig-002-20240513   clang
powerpc64             randconfig-003-20240513   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240513   gcc  
riscv                 randconfig-002-20240513   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240513   gcc  
s390                  randconfig-002-20240513   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                        apsh4ad0a_defconfig   gcc  
sh                                  defconfig   gcc  
sh                          r7780mp_defconfig   gcc  
sh                    randconfig-001-20240513   gcc  
sh                    randconfig-002-20240513   gcc  
sh                          sdk7786_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240513   gcc  
sparc64               randconfig-002-20240513   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240513   clang
um                    randconfig-002-20240513   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240513   gcc  
x86_64       buildonly-randconfig-002-20240513   gcc  
x86_64       buildonly-randconfig-003-20240513   gcc  
x86_64       buildonly-randconfig-004-20240513   clang
x86_64       buildonly-randconfig-005-20240513   clang
x86_64       buildonly-randconfig-006-20240513   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240513   clang
x86_64                randconfig-002-20240513   clang
x86_64                randconfig-003-20240513   clang
x86_64                randconfig-004-20240513   gcc  
x86_64                randconfig-005-20240513   clang
x86_64                randconfig-006-20240513   clang
x86_64                randconfig-011-20240513   clang
x86_64                randconfig-012-20240513   gcc  
x86_64                randconfig-013-20240513   clang
x86_64                randconfig-014-20240513   clang
x86_64                randconfig-015-20240513   gcc  
x86_64                randconfig-016-20240513   clang
x86_64                randconfig-071-20240513   clang
x86_64                randconfig-072-20240513   clang
x86_64                randconfig-073-20240513   clang
x86_64                randconfig-074-20240513   gcc  
x86_64                randconfig-075-20240513   gcc  
x86_64                randconfig-076-20240513   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240513   gcc  
xtensa                randconfig-002-20240513   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

