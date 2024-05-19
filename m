Return-Path: <linux-kernel+bounces-183109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DF58C94C6
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 15:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 304691C20951
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 13:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB18E481DA;
	Sun, 19 May 2024 13:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aRrt++tC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C3C45BF9
	for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 13:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716124897; cv=none; b=OqGrEnwo12TTo+IeFt1QKKjhNiY2O5gKzFy3p04w43AqDqD7zLht1dtiArCobsKelidvV5QFbKlrriztMlS3IvgiN04Hkju3MXXnlk3wf9N0cFgFtbRLUS9N2eccva7Df/+oNwnf42H0O8NjeeRrlHNA37YpE1DJGbzgTNGbKG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716124897; c=relaxed/simple;
	bh=9oxj2yYMJZKqrVBnYOFE4xE8nxr3eUhGpdGAFv7t9QE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ffl1UzwUANFHI6JqHPdstGZfXn1r/Z8LNMHy03ladPAVYN7zqAkPUyz7uG1t64YF7ElLMeAQNB+EuEkk+YtYnMhjiACwCMYnksyQgQHhA8uw/H2hnkfO53roiSqqhKz/RDQlqim1UtnBfdVMohOBBGO1z34tg1Jm+pLSt9gSwOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aRrt++tC; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716124896; x=1747660896;
  h=date:from:to:cc:subject:message-id;
  bh=9oxj2yYMJZKqrVBnYOFE4xE8nxr3eUhGpdGAFv7t9QE=;
  b=aRrt++tCqqFUHaqXvCbg5ATwi6dmnfnTrkEesvBVnJb7nZ6425CmPw2b
   XUU9Lyv6diJvwNBCIPrUpESTdg93JRAk5UcA5vZXUXQOT+p2UrurrqPFB
   J/BrEdSgka57crxahu3p3viR5wHXedNjb2Rg5X9Hk2cor4TFSdyDcHCuT
   VGA/1Q+kl8RtH4Sj5Kgx+nhrQmBK7jr6nPmnDw0ckKcSow3c9q30mTGMQ
   nxotrjjcjr2ITLyNXcYIGTCZyNcQFe4YwMls/z1q8hIUPo4SsMFASgmz/
   5VtuQ8s1TdlK6+NbjKiR/fKo5VXQ88BrQhYpz4wRu+0tZXC4l9ZZNr/tF
   w==;
X-CSE-ConnectionGUID: FyH+TROLTk+Qlvb0PYgLgQ==
X-CSE-MsgGUID: 5q9z2XrTRMWM3XJbMfcaFg==
X-IronPort-AV: E=McAfee;i="6600,9927,11077"; a="16088325"
X-IronPort-AV: E=Sophos;i="6.08,173,1712646000"; 
   d="scan'208";a="16088325"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2024 06:21:35 -0700
X-CSE-ConnectionGUID: HjwJ1VrARfiXIvic+ztfHg==
X-CSE-MsgGUID: FeGvKOt1RGGaE7MLKGniDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,173,1712646000"; 
   d="scan'208";a="63093817"
Received: from unknown (HELO 108735ec233b) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 19 May 2024 06:21:34 -0700
Received: from kbuild by 108735ec233b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s8gTj-0003ep-1x;
	Sun, 19 May 2024 13:21:31 +0000
Date: Sun, 19 May 2024 21:21:07 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2024.05.17a] BUILD SUCCESS
 4384d0f904b73a0f01f1772b19c2e92fa898c34a
Message-ID: <202405192105.bIHBgibR-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2024.05.17a
branch HEAD: 4384d0f904b73a0f01f1772b19c2e92fa898c34a  rcu: add missing MODULE_DESCRIPTION() macros

elapsed time: 722m

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
arc                                 defconfig   gcc  
arc                   randconfig-001-20240519   gcc  
arc                   randconfig-002-20240519   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                          ep93xx_defconfig   clang
arm                      integrator_defconfig   clang
arm                        multi_v5_defconfig   gcc  
arm                       netwinder_defconfig   gcc  
arm                          pxa168_defconfig   clang
arm                   randconfig-001-20240519   gcc  
arm                   randconfig-002-20240519   gcc  
arm                   randconfig-003-20240519   clang
arm                   randconfig-004-20240519   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240519   clang
arm64                 randconfig-002-20240519   clang
arm64                 randconfig-003-20240519   clang
arm64                 randconfig-004-20240519   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240519   gcc  
csky                  randconfig-002-20240519   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240519   clang
hexagon               randconfig-002-20240519   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240519   clang
i386         buildonly-randconfig-002-20240519   gcc  
i386         buildonly-randconfig-003-20240519   clang
i386         buildonly-randconfig-004-20240519   gcc  
i386         buildonly-randconfig-005-20240519   clang
i386         buildonly-randconfig-006-20240519   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240519   clang
i386                  randconfig-002-20240519   gcc  
i386                  randconfig-003-20240519   gcc  
i386                  randconfig-004-20240519   clang
i386                  randconfig-005-20240519   gcc  
i386                  randconfig-006-20240519   clang
i386                  randconfig-011-20240519   clang
i386                  randconfig-012-20240519   clang
i386                  randconfig-013-20240519   gcc  
i386                  randconfig-014-20240519   gcc  
i386                  randconfig-015-20240519   clang
i386                  randconfig-016-20240519   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240519   gcc  
loongarch             randconfig-002-20240519   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                         apollo_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                          hp300_defconfig   gcc  
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
nios2                 randconfig-001-20240519   gcc  
nios2                 randconfig-002-20240519   gcc  
openrisc                         alldefconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240519   gcc  
parisc                randconfig-002-20240519   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                   bluestone_defconfig   clang
powerpc                 canyonlands_defconfig   clang
powerpc                       holly_defconfig   clang
powerpc                     mpc5200_defconfig   clang
powerpc               randconfig-001-20240519   gcc  
powerpc               randconfig-002-20240519   clang
powerpc               randconfig-003-20240519   gcc  
powerpc                     tqm5200_defconfig   gcc  
powerpc                      tqm8xx_defconfig   clang
powerpc                      walnut_defconfig   gcc  
powerpc64             randconfig-001-20240519   gcc  
powerpc64             randconfig-002-20240519   gcc  
powerpc64             randconfig-003-20240519   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240519   gcc  
riscv                 randconfig-002-20240519   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240519   gcc  
s390                  randconfig-002-20240519   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240519   gcc  
sh                    randconfig-002-20240519   gcc  
sh                          rsk7203_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240519   gcc  
sparc64               randconfig-002-20240519   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240519   gcc  
um                    randconfig-002-20240519   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240519   clang
x86_64       buildonly-randconfig-002-20240519   clang
x86_64       buildonly-randconfig-003-20240519   clang
x86_64       buildonly-randconfig-004-20240519   gcc  
x86_64       buildonly-randconfig-005-20240519   gcc  
x86_64       buildonly-randconfig-006-20240519   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240519   gcc  
x86_64                randconfig-002-20240519   gcc  
x86_64                randconfig-003-20240519   gcc  
x86_64                randconfig-004-20240519   gcc  
x86_64                randconfig-005-20240519   gcc  
x86_64                randconfig-006-20240519   clang
x86_64                randconfig-011-20240519   clang
x86_64                randconfig-012-20240519   gcc  
x86_64                randconfig-013-20240519   gcc  
x86_64                randconfig-014-20240519   gcc  
x86_64                randconfig-015-20240519   clang
x86_64                randconfig-016-20240519   clang
x86_64                randconfig-071-20240519   clang
x86_64                randconfig-072-20240519   gcc  
x86_64                randconfig-073-20240519   clang
x86_64                randconfig-074-20240519   clang
x86_64                randconfig-075-20240519   clang
x86_64                randconfig-076-20240519   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                          iss_defconfig   gcc  
xtensa                randconfig-001-20240519   gcc  
xtensa                randconfig-002-20240519   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

