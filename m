Return-Path: <linux-kernel+bounces-201689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BDA8FC1D8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 04:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B84C1F25EF9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 02:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D916061FE9;
	Wed,  5 Jun 2024 02:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B3ufmue5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E85610E4
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 02:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717554690; cv=none; b=SqwppBwjQ5VJdqGy6ZgpsgqxhHW6pmuQy/occCkRK6xAae5L9ayXt6gs+UXN02O5VK6FPUTGYZa3x0Bjdmbtxvur9iPX2e1+Qxrv/wVEC2JOY5ZoBHBCuLacE3M6IP5b1BNpu3jgUb8njoo/fIF4WmLtzOXpWiB7Mfk0FNVfyjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717554690; c=relaxed/simple;
	bh=TyVfH0d68OYe9LOSbMShXTOwtwfIW0TxsW8MTJpV8AM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Rld8cyEAYibtnL8a7WI+XIwHIZ5Kva6fVOEIVvNy1m6FGZRlV/qXw6A0lL4mpe+J2UJgOTGTMg+TT0Owex6XCxoiSoLH0yr16YJyQThLdQ0Mt1ysyW8HTcp4JJWY+mv+nczmEdtjkmMiKhqAB22JGlGua3oDBS8W/tZxhAIMs8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B3ufmue5; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717554689; x=1749090689;
  h=date:from:to:cc:subject:message-id;
  bh=TyVfH0d68OYe9LOSbMShXTOwtwfIW0TxsW8MTJpV8AM=;
  b=B3ufmue5B1lWBO9DBU3d/wx63ZWxFJKGVu5e4dVqh/ibQBUZcizOCVaE
   3xMVMHOPLbSUFp1bLacAuwUNVURrdI9eeCdsnvh4fbEmaoqaLrCOVmme9
   9ujjotZ64A1tfO7NoqspXnCQ1jphEHf60VVvgQcA6E/s1KQZur1uckTNF
   D52enrT+3L3k17NtrJHCzSzIZ765MjqMO5Lxd1JlB4e6n0sM6Zd3KexMH
   elMAQ1aEYFXrFRUUNWNokp24gHg9AQ0b2WA4HHKok3o5NkkpGIhCt0dK3
   SBODt/T46yQVBtLE0yTLK6joxnmQOL2FvCz8GXYD4m9Relog31Wn44poX
   Q==;
X-CSE-ConnectionGUID: c30CcCwuQS6wA5E0Tk1Elg==
X-CSE-MsgGUID: bLwL8AEfRCqHrX8yRxKTkA==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="24766965"
X-IronPort-AV: E=Sophos;i="6.08,215,1712646000"; 
   d="scan'208";a="24766965"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 19:31:28 -0700
X-CSE-ConnectionGUID: 3Xc3IOJ8SzyGui9fqDoaTg==
X-CSE-MsgGUID: u6WV4BGGRzuJTYKX/BXF7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,215,1712646000"; 
   d="scan'208";a="74914437"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 04 Jun 2024 19:31:26 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sEgQu-0000oo-0o;
	Wed, 05 Jun 2024 02:31:24 +0000
Date: Wed, 05 Jun 2024 10:30:41 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2024.05.30b] BUILD SUCCESS
 9853762f3338973249ab0374f1f574c58651a10c
Message-ID: <202406051039.Tp7UmyDr-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2024.05.30b
branch HEAD: 9853762f3338973249ab0374f1f574c58651a10c  kcsan: test: add missing MODULE_DESCRIPTION() macro

elapsed time: 1475m

configs tested: 148
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240604   gcc  
arc                   randconfig-002-20240604   gcc  
arm                               allnoconfig   clang
arm                                 defconfig   clang
arm                       imx_v6_v7_defconfig   clang
arm                           omap1_defconfig   gcc  
arm                         orion5x_defconfig   clang
arm                   randconfig-001-20240604   clang
arm                   randconfig-002-20240604   gcc  
arm                   randconfig-003-20240604   clang
arm                   randconfig-004-20240604   gcc  
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240604   clang
arm64                 randconfig-002-20240604   gcc  
arm64                 randconfig-003-20240604   gcc  
arm64                 randconfig-004-20240604   clang
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240604   gcc  
csky                  randconfig-002-20240604   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240604   clang
hexagon               randconfig-002-20240604   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240604   gcc  
i386         buildonly-randconfig-002-20240604   clang
i386         buildonly-randconfig-003-20240604   clang
i386         buildonly-randconfig-004-20240604   gcc  
i386         buildonly-randconfig-005-20240604   clang
i386         buildonly-randconfig-006-20240604   clang
i386                                defconfig   clang
i386                  randconfig-001-20240604   clang
i386                  randconfig-002-20240604   clang
i386                  randconfig-003-20240604   clang
i386                  randconfig-004-20240604   clang
i386                  randconfig-005-20240604   gcc  
i386                  randconfig-006-20240604   gcc  
i386                  randconfig-011-20240604   clang
i386                  randconfig-012-20240604   gcc  
i386                  randconfig-013-20240604   gcc  
i386                  randconfig-014-20240604   clang
i386                  randconfig-015-20240604   clang
i386                  randconfig-016-20240604   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240604   gcc  
loongarch             randconfig-002-20240604   gcc  
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
mips                  decstation_64_defconfig   gcc  
mips                           ip27_defconfig   gcc  
mips                malta_qemu_32r6_defconfig   gcc  
mips                        maltaup_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240604   gcc  
nios2                 randconfig-002-20240604   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240604   gcc  
parisc                randconfig-002-20240604   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                      cm5200_defconfig   clang
powerpc                    klondike_defconfig   gcc  
powerpc                      makalu_defconfig   clang
powerpc               randconfig-001-20240604   gcc  
powerpc               randconfig-002-20240604   gcc  
powerpc               randconfig-003-20240604   gcc  
powerpc64             randconfig-001-20240604   gcc  
powerpc64             randconfig-002-20240604   gcc  
powerpc64             randconfig-003-20240604   clang
riscv                             allnoconfig   gcc  
riscv                               defconfig   clang
riscv                 randconfig-001-20240604   clang
riscv                 randconfig-002-20240604   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240604   clang
s390                  randconfig-002-20240604   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240604   gcc  
sh                    randconfig-002-20240604   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240604   gcc  
sparc64               randconfig-002-20240604   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240604   clang
um                    randconfig-002-20240604   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240605   gcc  
x86_64       buildonly-randconfig-002-20240605   gcc  
x86_64       buildonly-randconfig-003-20240605   gcc  
x86_64       buildonly-randconfig-004-20240605   clang
x86_64       buildonly-randconfig-005-20240605   clang
x86_64       buildonly-randconfig-006-20240605   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240605   clang
x86_64                randconfig-002-20240605   clang
x86_64                randconfig-003-20240605   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240604   gcc  
xtensa                randconfig-002-20240604   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

