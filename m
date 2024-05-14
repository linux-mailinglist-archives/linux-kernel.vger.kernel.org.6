Return-Path: <linux-kernel+bounces-179146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7478C5C58
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 22:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DAF81F2312A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 20:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB13181BA8;
	Tue, 14 May 2024 20:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YNPuPKgw"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147F61DDDB
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 20:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715718780; cv=none; b=khVSJnTKJ9N2naW7qQhcAvbA/BNLDJV5Uwu/Wl6q+5Zw0RWcZITC4E9NiUMGvFD8UPvUG09KIWVlbolFOQqXLv7TXy3FxYdltvyZB/nSkWzVvVdR4AayQTD05mY0qonLVg8SU9TVKlm/AVsTNQBLPY2814Jnzj1qloRzQjutxrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715718780; c=relaxed/simple;
	bh=PDgGk/ToVoHsgvgodc+rj9dbDYo/42sQGfbscJ9Uv1k=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ta1l2cBfjbXHAmiiFH7Bn/KEDm1lM6gVI3hrXmxJ3GYqndGUZnLfoamDR+5Y+YMP5WlznXmGTc5EO1X/NZIOkNAxmB92j9Ezk8qOMmWOe/quKPII4Sv2oP/brEFgQCJ1wGNaU42oqMlzbOxV7EevDSZOpoy4K+ho134R0vgScPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YNPuPKgw; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715718780; x=1747254780;
  h=date:from:to:cc:subject:message-id;
  bh=PDgGk/ToVoHsgvgodc+rj9dbDYo/42sQGfbscJ9Uv1k=;
  b=YNPuPKgwfLKF4ZUDgew4l3YN7HbT62AZa7PM78uz2Fx5g/Yr6WfSpvqF
   nhv6n0+2nDib4cHxn7t7cqErHeGCNhsYEVpfaUoyBvW7zrdXkX0PYSp0l
   +WL4WMNpBkyipHDhTiBjK9uQJj/Kd9MW2XiXiN9Z5U6Fc1Nj8je/RyQsW
   DbgoHEZVhIAFtKvEANO0QopGTLuSAUt5RAzZnX+st2nG+65IO/FlGZrCW
   kajAg8EwEMCFad/d/C8LnRjlqUNWTI8ETcnIUiMt5zatli8bkhRkqmITV
   LAXlRZuZBWHmsaFl9j4FmGeZQgzjz9XYOjjNyyU0GY5bjUjQpt6Jbynm3
   Q==;
X-CSE-ConnectionGUID: RYAuPABWS8G5kbMR4TB5kA==
X-CSE-MsgGUID: peHlVMZURg2tETCIEvN00w==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="22315144"
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="22315144"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 13:32:59 -0700
X-CSE-ConnectionGUID: qD8TAjt5RT2q8Z7eyMOwiw==
X-CSE-MsgGUID: K9KIv9cKQc6OKwWxMSZrsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="31227137"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 14 May 2024 13:32:58 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s6ypT-000Bzo-0u;
	Tue, 14 May 2024 20:32:55 +0000
Date: Wed, 15 May 2024 04:32:31 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 346ec194187ea36343c438cf8d76a58225fc49f0
Message-ID: <202405150429.UvYiATQA-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 346ec194187ea36343c438cf8d76a58225fc49f0  Merge branch into tip/master: 'x86/timers'

elapsed time: 736m

configs tested: 156
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
arc                   randconfig-001-20240514   gcc  
arc                   randconfig-002-20240514   gcc  
arc                        vdk_hs38_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                      jornada720_defconfig   clang
arm                        multi_v5_defconfig   gcc  
arm                   randconfig-001-20240514   clang
arm                   randconfig-002-20240514   gcc  
arm                   randconfig-003-20240514   gcc  
arm                   randconfig-004-20240514   gcc  
arm                        spear3xx_defconfig   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240514   clang
arm64                 randconfig-002-20240514   clang
arm64                 randconfig-003-20240514   gcc  
arm64                 randconfig-004-20240514   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240514   gcc  
csky                  randconfig-002-20240514   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240514   clang
hexagon               randconfig-002-20240514   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240514   clang
i386         buildonly-randconfig-002-20240514   clang
i386         buildonly-randconfig-003-20240514   gcc  
i386         buildonly-randconfig-004-20240514   clang
i386         buildonly-randconfig-005-20240514   gcc  
i386         buildonly-randconfig-006-20240514   clang
i386                                defconfig   clang
i386                  randconfig-001-20240514   gcc  
i386                  randconfig-002-20240514   clang
i386                  randconfig-003-20240514   gcc  
i386                  randconfig-004-20240514   clang
i386                  randconfig-005-20240514   clang
i386                  randconfig-006-20240514   clang
i386                  randconfig-011-20240514   clang
i386                  randconfig-012-20240514   gcc  
i386                  randconfig-013-20240514   gcc  
i386                  randconfig-014-20240514   clang
i386                  randconfig-015-20240514   gcc  
i386                  randconfig-016-20240514   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240514   gcc  
loongarch             randconfig-002-20240514   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        mvme16x_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                        bcm63xx_defconfig   clang
mips                         bigsur_defconfig   gcc  
mips                     cu1830-neo_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240514   gcc  
nios2                 randconfig-002-20240514   gcc  
openrisc                         alldefconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240514   gcc  
parisc                randconfig-002-20240514   gcc  
parisc64                            defconfig   gcc  
powerpc                     akebono_defconfig   clang
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                 canyonlands_defconfig   clang
powerpc                      katmai_defconfig   clang
powerpc               mpc834x_itxgp_defconfig   clang
powerpc                     rainier_defconfig   gcc  
powerpc               randconfig-001-20240514   gcc  
powerpc               randconfig-002-20240514   gcc  
powerpc               randconfig-003-20240514   clang
powerpc64             randconfig-001-20240514   clang
powerpc64             randconfig-002-20240514   clang
powerpc64             randconfig-003-20240514   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240514   gcc  
riscv                 randconfig-002-20240514   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240514   gcc  
s390                  randconfig-002-20240514   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                             espt_defconfig   gcc  
sh                    randconfig-001-20240514   gcc  
sh                    randconfig-002-20240514   gcc  
sh                   sh7770_generic_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240514   gcc  
sparc64               randconfig-002-20240514   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240514   clang
um                    randconfig-002-20240514   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                       common_defconfig   gcc  
xtensa                randconfig-001-20240514   gcc  
xtensa                randconfig-002-20240514   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

