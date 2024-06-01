Return-Path: <linux-kernel+bounces-198038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D31988D72AD
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 01:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CD55281F6B
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 23:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533243CF5E;
	Sat,  1 Jun 2024 23:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i6gX6sJG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C62922F1E
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 23:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717283635; cv=none; b=WFutpsP0wZkkFHVq++LcxtL070KQO94TuSH6E7MmfXHDrlK+cE4nFPs12Ks/gy6zSdvCo/UbUfEFMD13r9VzqeqVLScu/AeAtPsZoUIeL9YlJivVqSpe60ge6pvalc75pNUzEe4XBbB0o0pqxSYgK72ATTko16osoJq0kvLxxGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717283635; c=relaxed/simple;
	bh=ghkgZMmTplg1D54z1/+oYA7MsPHp7B9Zh1Eu0LBHofw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=tJrcLVBcODnx5M7l8P/uuHF+YnrfzJmnJSzTOBY2BMVNAqGrMl+7NrYyF/dk2A57U5uHaacV62U34hbyfS2CWSovPQdfRMaqbl0ULQFRg1MwLDPLq308HTrlS+7oKoM/ravCa+fiA8Nc+C7OqHiKfV8kqx81yKoMTiEYA6/dIm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i6gX6sJG; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717283633; x=1748819633;
  h=date:from:to:cc:subject:message-id;
  bh=ghkgZMmTplg1D54z1/+oYA7MsPHp7B9Zh1Eu0LBHofw=;
  b=i6gX6sJGpIlV7BolX7BraNf1Vmsj7YsQDMN2mXCwTJj3NR9pEqT58oGl
   DcN6pCfR8xVv+xsAcswlXcMxJoVR7EgCcVpmk70GTDsyRWOHesNTz+oFB
   Wmqd7+5OykAe9eAVqyHfYzl0jFFIuNkn5fVuw5GR14nT22bgchqNw6/T7
   oDMtEOrUb0XlGlu8BYCNnfiSV97HNSc8ArWBT4Lsgw0FVAoMIKtMLDniW
   aNxheJprJIvIH0NB+ALMbKo/Zb5w0BM8OWqjCJqE60bHp16oMPGIoobdn
   YkbsWHwmWdM/n4hGeEk8zGBqrNA6GMiCR1eM0jqd6octwrwK9sxvUrCts
   A==;
X-CSE-ConnectionGUID: eUSZL90wQ1acH+/pSDLCpQ==
X-CSE-MsgGUID: wqMvgzyQTsKUYO+DXBiibA==
X-IronPort-AV: E=McAfee;i="6600,9927,11090"; a="24464115"
X-IronPort-AV: E=Sophos;i="6.08,208,1712646000"; 
   d="scan'208";a="24464115"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2024 16:13:48 -0700
X-CSE-ConnectionGUID: OgBzl3xfQpS9msJQsOepZw==
X-CSE-MsgGUID: Oa7vPNQWTOi9HUzgZ/GuWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,208,1712646000"; 
   d="scan'208";a="67688842"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 01 Jun 2024 16:13:47 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sDXuz-000JSh-0A;
	Sat, 01 Jun 2024 23:13:45 +0000
Date: Sun, 02 Jun 2024 07:12:51 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:non-rcu/next] BUILD SUCCESS
 aa451ad3bd81d0ab60f5df42e77261aea3410d4f
Message-ID: <202406020749.fctDM0YB-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git non-rcu/next
branch HEAD: aa451ad3bd81d0ab60f5df42e77261aea3410d4f  Merge branches 'cmpxchg.2024.05.30b', 'kcsan.2024.05.30b', 'lkmm.2024.05.30b', 'torture.2024.05.30b' and 'tsc.2024.05.27a' into HEAD

elapsed time: 1350m

configs tested: 200
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
arc                   randconfig-001-20240601   gcc  
arc                   randconfig-001-20240602   gcc  
arc                   randconfig-002-20240601   gcc  
arc                   randconfig-002-20240602   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240601   clang
arm                   randconfig-002-20240601   clang
arm                   randconfig-003-20240601   gcc  
arm                   randconfig-003-20240602   gcc  
arm                   randconfig-004-20240601   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240601   gcc  
arm64                 randconfig-002-20240601   clang
arm64                 randconfig-002-20240602   gcc  
arm64                 randconfig-003-20240601   clang
arm64                 randconfig-004-20240601   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240601   gcc  
csky                  randconfig-001-20240602   gcc  
csky                  randconfig-002-20240601   gcc  
csky                  randconfig-002-20240602   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240601   clang
hexagon               randconfig-002-20240601   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240601   clang
i386         buildonly-randconfig-002-20240601   gcc  
i386         buildonly-randconfig-003-20240601   gcc  
i386         buildonly-randconfig-004-20240601   gcc  
i386         buildonly-randconfig-005-20240601   gcc  
i386         buildonly-randconfig-006-20240601   clang
i386                                defconfig   clang
i386                  randconfig-001-20240601   clang
i386                  randconfig-002-20240601   gcc  
i386                  randconfig-003-20240601   clang
i386                  randconfig-004-20240601   gcc  
i386                  randconfig-005-20240601   clang
i386                  randconfig-006-20240601   gcc  
i386                  randconfig-011-20240601   gcc  
i386                  randconfig-012-20240601   gcc  
i386                  randconfig-013-20240601   gcc  
i386                  randconfig-014-20240601   gcc  
i386                  randconfig-015-20240601   clang
i386                  randconfig-016-20240601   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240601   gcc  
loongarch             randconfig-001-20240602   gcc  
loongarch             randconfig-002-20240601   gcc  
loongarch             randconfig-002-20240602   gcc  
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
nios2                 randconfig-001-20240601   gcc  
nios2                 randconfig-001-20240602   gcc  
nios2                 randconfig-002-20240601   gcc  
nios2                 randconfig-002-20240602   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240601   gcc  
parisc                randconfig-001-20240602   gcc  
parisc                randconfig-002-20240601   gcc  
parisc                randconfig-002-20240602   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20240601   gcc  
powerpc               randconfig-002-20240601   gcc  
powerpc               randconfig-002-20240602   gcc  
powerpc               randconfig-003-20240601   gcc  
powerpc64             randconfig-001-20240601   clang
powerpc64             randconfig-002-20240601   clang
powerpc64             randconfig-002-20240602   gcc  
powerpc64             randconfig-003-20240601   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240601   clang
riscv                 randconfig-002-20240601   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240601   gcc  
s390                  randconfig-001-20240602   gcc  
s390                  randconfig-002-20240601   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240601   gcc  
sh                    randconfig-001-20240602   gcc  
sh                    randconfig-002-20240601   gcc  
sh                    randconfig-002-20240602   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240601   gcc  
sparc64               randconfig-001-20240602   gcc  
sparc64               randconfig-002-20240601   gcc  
sparc64               randconfig-002-20240602   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240601   gcc  
um                    randconfig-001-20240602   gcc  
um                    randconfig-002-20240601   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240601   clang
x86_64       buildonly-randconfig-002-20240601   clang
x86_64       buildonly-randconfig-002-20240602   clang
x86_64       buildonly-randconfig-003-20240601   gcc  
x86_64       buildonly-randconfig-003-20240602   clang
x86_64       buildonly-randconfig-004-20240601   gcc  
x86_64       buildonly-randconfig-005-20240601   clang
x86_64       buildonly-randconfig-005-20240602   clang
x86_64       buildonly-randconfig-006-20240601   gcc  
x86_64       buildonly-randconfig-006-20240602   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240601   gcc  
x86_64                randconfig-002-20240601   clang
x86_64                randconfig-002-20240602   clang
x86_64                randconfig-003-20240601   clang
x86_64                randconfig-003-20240602   clang
x86_64                randconfig-004-20240601   clang
x86_64                randconfig-005-20240601   gcc  
x86_64                randconfig-005-20240602   clang
x86_64                randconfig-006-20240601   clang
x86_64                randconfig-006-20240602   clang
x86_64                randconfig-011-20240601   clang
x86_64                randconfig-012-20240601   clang
x86_64                randconfig-012-20240602   clang
x86_64                randconfig-013-20240601   clang
x86_64                randconfig-013-20240602   clang
x86_64                randconfig-014-20240601   gcc  
x86_64                randconfig-015-20240601   gcc  
x86_64                randconfig-015-20240602   clang
x86_64                randconfig-016-20240601   gcc  
x86_64                randconfig-071-20240601   clang
x86_64                randconfig-072-20240601   gcc  
x86_64                randconfig-072-20240602   clang
x86_64                randconfig-073-20240601   clang
x86_64                randconfig-074-20240601   gcc  
x86_64                randconfig-074-20240602   clang
x86_64                randconfig-075-20240601   clang
x86_64                randconfig-075-20240602   clang
x86_64                randconfig-076-20240601   gcc  
x86_64                randconfig-076-20240602   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240601   gcc  
xtensa                randconfig-001-20240602   gcc  
xtensa                randconfig-002-20240601   gcc  
xtensa                randconfig-002-20240602   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

