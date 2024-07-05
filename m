Return-Path: <linux-kernel+bounces-242930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C75928EF5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 23:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3139CB26F03
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 21:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C73145FE1;
	Fri,  5 Jul 2024 21:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LatFpId4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AEA14373B
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 21:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720216273; cv=none; b=h/d8q0USdmjpSlJRXALnAlzSrsxnqDDdm3ShjPKV25c8KsZZMNWuAFwww8xidAyqJ/OabBnNvRm0GI+SM6RdrrkiotTIkeBId1nrVlENSL2CltnBoAyZKw7DXFWZKwoGZIFPBHRgAibDRSlWBTpJQEw8rxSldpOIQtXDMXTZWrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720216273; c=relaxed/simple;
	bh=sAnAsSUgDU8LXZHFRAqlVdf3EBLAwc4gvTEgaTZL7js=;
	h=Date:From:To:Cc:Subject:Message-ID; b=O3hwwyZrWIADtECsV/Fjd0YlqZ5Z5vfz6owCymYkL8WJYaAJrNDLYTcENP843gYRI5njP18rPOPxV2XYpq9vkOFtmJSehVjrn/Te2dUjqBlcmT2dL4Qpf4A++TcribFYfVgNo8WTK4fLiut3ikr09svzitbeGKk8ZhIUT+YMrck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LatFpId4; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720216271; x=1751752271;
  h=date:from:to:cc:subject:message-id;
  bh=sAnAsSUgDU8LXZHFRAqlVdf3EBLAwc4gvTEgaTZL7js=;
  b=LatFpId43ExrWsZILDEqqvUpQyqimVSkiYhgc0ACc6XCDZcMfejY6Fue
   x73Aqg3zC0aOeGzb2mYHOIq8rtDjivQsbAWx47hBgRfoMqF+WZJYUBkOJ
   EY3jggoEBxHfeZcd6u+WVwGNV6ffdvxkE5J1sAc8lKxH0A3K2cHqCnC/L
   yZAEJc7e2rJZeaLvpExnUUNws3yOcyJRmjEcpt1VKWa6BoE/tHZIfkTRm
   9Z0t/nrwjnjP73tKx0q2if/knvYkWCYhflaeZTbS+VRxwV06hpQF6TnB7
   UlFyP1dr9WVY5mbvQT9vl0EExDwWDOiAaQbWiIadu8ZT4RxvgNDb+4Z1J
   A==;
X-CSE-ConnectionGUID: /LYDa99cQ1SiB2THqYrmxQ==
X-CSE-MsgGUID: MooLOeJYRPexQv76S7WMiQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="28907278"
X-IronPort-AV: E=Sophos;i="6.09,186,1716274800"; 
   d="scan'208";a="28907278"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2024 14:51:10 -0700
X-CSE-ConnectionGUID: dRAxUoPcT+OvwVn0MXWOTg==
X-CSE-MsgGUID: +e/Kkh9lQdWYwZRrryDHug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,186,1716274800"; 
   d="scan'208";a="46903727"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 05 Jul 2024 14:51:10 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sPqpf-000Svw-12;
	Fri, 05 Jul 2024 21:51:07 +0000
Date: Sat, 06 Jul 2024 05:50:14 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:non-rcu/next] BUILD SUCCESS
 20560bc16e593c296841206a996aad3f4d1230e2
Message-ID: <202407060512.RL0waaNe-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git non-rcu/next
branch HEAD: 20560bc16e593c296841206a996aad3f4d1230e2  locking/csd_lock: Provide an indication of ongoing CSD-lock stall

elapsed time: 1453m

configs tested: 239
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                            allyesconfig   gcc-13.2.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                     haps_hs_smp_defconfig   gcc-13.2.0
arc                   randconfig-001-20240705   gcc-13.2.0
arc                   randconfig-002-20240705   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                               allnoconfig   clang-19
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                                 defconfig   gcc-13.2.0
arm                   randconfig-001-20240705   gcc-13.2.0
arm                   randconfig-002-20240705   gcc-13.2.0
arm                   randconfig-003-20240705   gcc-13.2.0
arm                   randconfig-004-20240705   gcc-13.2.0
arm                           u8500_defconfig   gcc-13.2.0
arm                         vf610m4_defconfig   gcc-13.2.0
arm64                            allmodconfig   clang-19
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240705   clang-19
arm64                 randconfig-002-20240705   clang-19
arm64                 randconfig-003-20240705   clang-19
arm64                 randconfig-004-20240705   clang-19
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240705   gcc-13.2.0
csky                  randconfig-002-20240705   gcc-13.2.0
hexagon                          allmodconfig   clang-19
hexagon                           allnoconfig   clang-19
hexagon                          allyesconfig   clang-19
hexagon               randconfig-001-20240705   clang-19
hexagon               randconfig-002-20240705   clang-17
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-13
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-13
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240705   gcc-13
i386         buildonly-randconfig-002-20240705   gcc-13
i386         buildonly-randconfig-002-20240705   gcc-9
i386         buildonly-randconfig-003-20240705   gcc-11
i386         buildonly-randconfig-003-20240705   gcc-13
i386         buildonly-randconfig-004-20240705   clang-18
i386         buildonly-randconfig-004-20240705   gcc-13
i386         buildonly-randconfig-005-20240705   clang-18
i386         buildonly-randconfig-005-20240705   gcc-13
i386         buildonly-randconfig-006-20240705   clang-18
i386         buildonly-randconfig-006-20240705   gcc-13
i386                                defconfig   clang-18
i386                  randconfig-001-20240705   gcc-13
i386                  randconfig-002-20240705   clang-18
i386                  randconfig-002-20240705   gcc-13
i386                  randconfig-003-20240705   gcc-11
i386                  randconfig-003-20240705   gcc-13
i386                  randconfig-004-20240705   gcc-13
i386                  randconfig-005-20240705   clang-18
i386                  randconfig-005-20240705   gcc-13
i386                  randconfig-006-20240705   clang-18
i386                  randconfig-006-20240705   gcc-13
i386                  randconfig-011-20240705   gcc-13
i386                  randconfig-012-20240705   gcc-13
i386                  randconfig-013-20240705   clang-18
i386                  randconfig-013-20240705   gcc-13
i386                  randconfig-014-20240705   gcc-13
i386                  randconfig-014-20240705   gcc-8
i386                  randconfig-015-20240705   gcc-10
i386                  randconfig-015-20240705   gcc-13
i386                  randconfig-016-20240705   clang-18
i386                  randconfig-016-20240705   gcc-13
loongarch                        allmodconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240705   gcc-13.2.0
loongarch             randconfig-002-20240705   gcc-13.2.0
m68k                             allmodconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-13.2.0
m68k                                defconfig   gcc-13.2.0
m68k                          hp300_defconfig   gcc-13.2.0
m68k                          sun3x_defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-13.2.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                  decstation_64_defconfig   gcc-13.2.0
mips                     decstation_defconfig   gcc-13.2.0
mips                          rb532_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240705   gcc-13.2.0
nios2                 randconfig-002-20240705   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                         allyesconfig   gcc-13.2.0
openrisc                            defconfig   gcc-13.2.0
parisc                           allmodconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                           allyesconfig   gcc-13.2.0
parisc                              defconfig   gcc-13.2.0
parisc                generic-64bit_defconfig   gcc-13.2.0
parisc                randconfig-001-20240705   gcc-13.2.0
parisc                randconfig-002-20240705   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc                          allyesconfig   clang-19
powerpc                          allyesconfig   gcc-13.2.0
powerpc                    amigaone_defconfig   gcc-13.2.0
powerpc                   bluestone_defconfig   gcc-13.2.0
powerpc                      cm5200_defconfig   gcc-13.2.0
powerpc                          g5_defconfig   gcc-13.2.0
powerpc                    ge_imp3a_defconfig   gcc-13.2.0
powerpc                 mpc8313_rdb_defconfig   gcc-13.2.0
powerpc               mpc834x_itxgp_defconfig   clang-14
powerpc                      pcm030_defconfig   clang-19
powerpc                      pcm030_defconfig   gcc-13.2.0
powerpc                      pmac32_defconfig   gcc-13.2.0
powerpc                     ppa8548_defconfig   gcc-13.2.0
powerpc                       ppc64_defconfig   clang-19
powerpc                      ppc64e_defconfig   gcc-13.2.0
powerpc                     rainier_defconfig   gcc-13.2.0
powerpc               randconfig-001-20240705   gcc-13.2.0
powerpc               randconfig-002-20240705   clang-19
powerpc               randconfig-003-20240705   clang-19
powerpc                     tqm8548_defconfig   gcc-13.2.0
powerpc64             randconfig-001-20240705   gcc-13.2.0
powerpc64             randconfig-002-20240705   clang-19
powerpc64             randconfig-003-20240705   clang-19
riscv                            allmodconfig   clang-19
riscv                            allmodconfig   gcc-13.2.0
riscv                             allnoconfig   gcc-13.2.0
riscv                            allyesconfig   clang-19
riscv                            allyesconfig   gcc-13.2.0
riscv                               defconfig   clang-19
riscv                               defconfig   gcc-13.2.0
riscv                 randconfig-001-20240705   gcc-13.2.0
riscv                 randconfig-002-20240705   clang-19
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                              allnoconfig   gcc-13.2.0
s390                             allyesconfig   clang-19
s390                             allyesconfig   gcc-13.2.0
s390                                defconfig   clang-19
s390                                defconfig   gcc-13.2.0
s390                  randconfig-001-20240705   gcc-13.2.0
s390                  randconfig-002-20240705   clang-16
sh                               allmodconfig   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                               allyesconfig   gcc-13.2.0
sh                                  defconfig   gcc-13.2.0
sh                          lboxre2_defconfig   gcc-13.2.0
sh                    randconfig-001-20240705   gcc-13.2.0
sh                    randconfig-002-20240705   gcc-13.2.0
sh                   rts7751r2dplus_defconfig   gcc-13.2.0
sh                            shmin_defconfig   gcc-13.2.0
sh                          urquell_defconfig   gcc-13.2.0
sparc                            allmodconfig   gcc-13.2.0
sparc64                             defconfig   gcc-13.2.0
sparc64               randconfig-001-20240705   gcc-13.2.0
sparc64               randconfig-002-20240705   gcc-13.2.0
um                               allmodconfig   clang-19
um                               allmodconfig   gcc-13.2.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-13.2.0
um                               allyesconfig   gcc-13
um                               allyesconfig   gcc-13.2.0
um                                  defconfig   clang-19
um                                  defconfig   gcc-13.2.0
um                             i386_defconfig   gcc-13
um                             i386_defconfig   gcc-13.2.0
um                    randconfig-001-20240705   clang-19
um                    randconfig-002-20240705   clang-15
um                           x86_64_defconfig   clang-15
um                           x86_64_defconfig   gcc-13.2.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240705   gcc-7
x86_64       buildonly-randconfig-002-20240705   gcc-13
x86_64       buildonly-randconfig-002-20240705   gcc-7
x86_64       buildonly-randconfig-003-20240705   clang-18
x86_64       buildonly-randconfig-003-20240705   gcc-7
x86_64       buildonly-randconfig-004-20240705   clang-18
x86_64       buildonly-randconfig-004-20240705   gcc-7
x86_64       buildonly-randconfig-005-20240705   clang-18
x86_64       buildonly-randconfig-005-20240705   gcc-7
x86_64       buildonly-randconfig-006-20240705   clang-18
x86_64       buildonly-randconfig-006-20240705   gcc-7
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240705   clang-18
x86_64                randconfig-001-20240705   gcc-7
x86_64                randconfig-002-20240705   gcc-13
x86_64                randconfig-002-20240705   gcc-7
x86_64                randconfig-003-20240705   clang-18
x86_64                randconfig-003-20240705   gcc-7
x86_64                randconfig-004-20240705   gcc-13
x86_64                randconfig-004-20240705   gcc-7
x86_64                randconfig-005-20240705   gcc-13
x86_64                randconfig-005-20240705   gcc-7
x86_64                randconfig-006-20240705   gcc-13
x86_64                randconfig-006-20240705   gcc-7
x86_64                randconfig-011-20240705   clang-18
x86_64                randconfig-011-20240705   gcc-7
x86_64                randconfig-012-20240705   gcc-7
x86_64                randconfig-012-20240705   gcc-9
x86_64                randconfig-013-20240705   clang-18
x86_64                randconfig-013-20240705   gcc-7
x86_64                randconfig-014-20240705   gcc-13
x86_64                randconfig-014-20240705   gcc-7
x86_64                randconfig-015-20240705   clang-18
x86_64                randconfig-015-20240705   gcc-7
x86_64                randconfig-016-20240705   gcc-7
x86_64                randconfig-016-20240705   gcc-9
x86_64                randconfig-071-20240705   gcc-13
x86_64                randconfig-071-20240705   gcc-7
x86_64                randconfig-072-20240705   gcc-13
x86_64                randconfig-072-20240705   gcc-7
x86_64                randconfig-073-20240705   clang-18
x86_64                randconfig-073-20240705   gcc-7
x86_64                randconfig-074-20240705   gcc-13
x86_64                randconfig-074-20240705   gcc-7
x86_64                randconfig-075-20240705   clang-18
x86_64                randconfig-075-20240705   gcc-7
x86_64                randconfig-076-20240705   clang-18
x86_64                randconfig-076-20240705   gcc-7
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                  audio_kc705_defconfig   gcc-13.2.0
xtensa                       common_defconfig   gcc-13.2.0
xtensa                randconfig-001-20240705   gcc-13.2.0
xtensa                randconfig-002-20240705   gcc-13.2.0
xtensa                    xip_kc705_defconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

