Return-Path: <linux-kernel+bounces-204513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D938FEFF9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 17:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 651F11C22323
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5E113D28C;
	Thu,  6 Jun 2024 14:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Eu8v6j6S"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D98B2233B
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 14:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717685230; cv=none; b=nT/7os2DvFw9sEHmiJup2jQ4TMeYQptjqT2JRBxpH7J15fZuaFnPGqjcGZXO5jL8hCcDUgoDvr+fLplq1twLVyOLgVdMLznycbLy/GVRYKRpmupSiYwlfNhKXX7FDjnprJA+FyKAylkJxukEdIxXpQft6AFi9DyihIqaOnxLd7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717685230; c=relaxed/simple;
	bh=OymsnDj3w3tCsTSRR5FZy4jj2gxTE66hzhpsFHEQAz0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=o8iIXYOwX9pL9KjVFtJ+yOxdCpCnfHmOnfNk8lEoV/mS+9yf4y+Xo80buEz5AMJorFakWaj7zJo59AtzaXLvJ9Jm7ETdsHaeE9vKRah2mZmMFDuUwlaT0p1N/Ss5Z1yKmjL88utTB3tF/jOe5M6Q+C6citcp/dWgw1dV7zZ5tDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Eu8v6j6S; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717685230; x=1749221230;
  h=date:from:to:cc:subject:message-id;
  bh=OymsnDj3w3tCsTSRR5FZy4jj2gxTE66hzhpsFHEQAz0=;
  b=Eu8v6j6ScJGcuNMmwySesVoprcr/uzGKaol0sWme/Kv757qsXIvfYh3f
   f2kpWWc76rlt8L6DOYtK23cyCcQlfKLhn0632SLWYwBa8VbVlLkOCqQFz
   4FKCis7FzfUvfut74TyZGmE+oW99QWOl6bwC48v0byRB5TXUNZdjkglTs
   Lq9tt3sUrGAlJaOMM3HRYgl1sNNEh+PBe8NhTorTCdUoRrNtjJlkXRN8i
   4f3TTFEFNKjxuqWfJaKZbb1dxee2VLWp1Le7fLkNpq8QXtFYhJ/5wVxE5
   sJLTwHds28vOMXargINhBWpnjo35J3suHjqgbIcXRFVZMnneqmpWpBMtw
   A==;
X-CSE-ConnectionGUID: cVWFyEyoR6i1QIJaSl9MWQ==
X-CSE-MsgGUID: WxnAwxqlTnasDtRWJYg+9g==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="18149546"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="18149546"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 07:47:09 -0700
X-CSE-ConnectionGUID: dffT01mPRRW5oG+CZhOIuA==
X-CSE-MsgGUID: D9m99mpJSp2/fs8zoORhzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="38061670"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 06 Jun 2024 07:47:08 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sFEOP-0003FS-1u;
	Thu, 06 Jun 2024 14:47:05 +0000
Date: Thu, 06 Jun 2024 22:46:57 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:perf/urgent] BUILD SUCCESS
 74751ef5c1912ebd3e65c3b65f45587e05ce5d36
Message-ID: <202406062255.mCdyQO3H-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/urgent
branch HEAD: 74751ef5c1912ebd3e65c3b65f45587e05ce5d36  perf/core: Fix missing wakeup when waiting for context reference

elapsed time: 1482m

configs tested: 144
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
arc                   randconfig-001-20240606   gcc  
arc                   randconfig-002-20240606   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                                 defconfig   clang
arm                   randconfig-001-20240606   clang
arm                   randconfig-002-20240606   clang
arm                   randconfig-003-20240606   clang
arm                   randconfig-004-20240606   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240606   clang
arm64                 randconfig-002-20240606   gcc  
arm64                 randconfig-003-20240606   clang
arm64                 randconfig-004-20240606   clang
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240606   gcc  
csky                  randconfig-002-20240606   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240606   clang
hexagon               randconfig-002-20240606   clang
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
powerpc               randconfig-001-20240606   gcc  
powerpc               randconfig-002-20240606   gcc  
powerpc               randconfig-003-20240606   gcc  
powerpc64             randconfig-001-20240606   clang
powerpc64             randconfig-002-20240606   clang
powerpc64             randconfig-003-20240606   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240606   gcc  
riscv                 randconfig-002-20240606   clang
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
sh                    randconfig-001-20240606   gcc  
sh                    randconfig-002-20240606   gcc  
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
um                    randconfig-001-20240606   clang
um                    randconfig-002-20240606   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240606   gcc  
x86_64       buildonly-randconfig-002-20240606   clang
x86_64       buildonly-randconfig-003-20240606   gcc  
x86_64       buildonly-randconfig-004-20240606   gcc  
x86_64       buildonly-randconfig-005-20240606   gcc  
x86_64       buildonly-randconfig-006-20240606   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240606   gcc  
x86_64                randconfig-002-20240606   gcc  
x86_64                randconfig-003-20240606   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240606   gcc  
xtensa                randconfig-002-20240606   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

