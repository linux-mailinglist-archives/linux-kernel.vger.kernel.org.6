Return-Path: <linux-kernel+bounces-189273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0B68CEDCD
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 06:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA394282064
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 04:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144FC3C39;
	Sat, 25 May 2024 04:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZsBU1y2B"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD095CB8
	for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 04:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716610689; cv=none; b=WRlcv2/ZP0T/fcUyNOAUCASdsmpsHwA8f1gN0zmnW+Q2VGvn951B48QQUDBW7zsYtPy1vqowWHkvJh2qYCbRK2rl71H/OxQozAQWMSZq1ijmSJE36GG/WofbprM8hjFHunmmz2pSMc7kg4/6/Yfi7Zshye7FOavcwFu4ur3ji1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716610689; c=relaxed/simple;
	bh=vM0bdKIZQQR38QTAqFJffJeN2i1KiZp+5KVHG9YYQuk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=C6UkX9ZdSvBeYnhwc2z5lmDY3u1hyRMbIWS4D4ZfDt8azyhTQ9T5IYsYPg4nCrs6r6tCuCa1z+24xAfln5R8B9zBTkWpkCX+Pv4nLxb/3dW6/IxFk8KSe8bBVNhY9fzGMkOxU2lRTnuQ5UXJkmg2foX8dTcPjdiT63uB+TxisDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZsBU1y2B; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716610687; x=1748146687;
  h=date:from:to:cc:subject:message-id;
  bh=vM0bdKIZQQR38QTAqFJffJeN2i1KiZp+5KVHG9YYQuk=;
  b=ZsBU1y2BjX3OFO191RUdQxzq1hCfRbGu2Hf+by3wFq0d9xhuZzi23gWd
   LKJjZF9tsGe5hT4wYWmOxJFXS767LXVEU4i1ssgP+RMlhFJzCJyT/6tV9
   ySwTM+8qVh4joxmQOW+Kb99dPDW8SiKuy4+3Q+xq5LZwk8Ybj0RdvJT1p
   BUuHVwHpUMzdmb8qO/lm/ZvZM6cAgKQcO1jyfeddPYRXgmsDvAvc89b3B
   S3m4kcCByf0yFEzXAIZt67emJSd/zWcMFowIL34drkG2csDRrbEMRMhRY
   nPw5PCNHH0W9b+H6Fbn7xBLZ8KomaeoGbefkyWfo90eoW1Kt+sbhjJVLr
   Q==;
X-CSE-ConnectionGUID: 3JN4+DJgQ+K4fEP29zDwqA==
X-CSE-MsgGUID: 2CAG1JTTRQSwQMGQPMiTZA==
X-IronPort-AV: E=McAfee;i="6600,9927,11082"; a="11690856"
X-IronPort-AV: E=Sophos;i="6.08,187,1712646000"; 
   d="scan'208";a="11690856"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2024 21:18:06 -0700
X-CSE-ConnectionGUID: 8sFJvCeKRkufonWJMXyIVw==
X-CSE-MsgGUID: LfrVGpVDQKqTskxW6s7TsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,187,1712646000"; 
   d="scan'208";a="65448751"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 24 May 2024 21:18:05 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sAir5-0006U1-1q;
	Sat, 25 May 2024 04:18:03 +0000
Date: Sat, 25 May 2024 12:17:57 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:irq/urgent] BUILD SUCCESS
 b84a8aba806261d2f759ccedf4a2a6a80a5e55ba
Message-ID: <202405251254.Y3cWJYAk-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/urgent
branch HEAD: b84a8aba806261d2f759ccedf4a2a6a80a5e55ba  genirq/irqdesc: Prevent use-after-free in irq_find_at_or_after()

elapsed time: 1027m

configs tested: 160
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
arc                   randconfig-001-20240525   gcc  
arc                   randconfig-002-20240525   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240525   gcc  
arm                   randconfig-002-20240525   gcc  
arm                   randconfig-003-20240525   clang
arm                   randconfig-004-20240525   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240525   gcc  
arm64                 randconfig-002-20240525   clang
arm64                 randconfig-003-20240525   gcc  
arm64                 randconfig-004-20240525   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240525   gcc  
csky                  randconfig-002-20240525   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240525   clang
hexagon               randconfig-002-20240525   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240524   clang
i386         buildonly-randconfig-002-20240524   clang
i386         buildonly-randconfig-003-20240524   gcc  
i386         buildonly-randconfig-004-20240524   clang
i386         buildonly-randconfig-004-20240525   clang
i386         buildonly-randconfig-005-20240524   clang
i386         buildonly-randconfig-006-20240524   clang
i386                                defconfig   clang
i386                  randconfig-001-20240524   clang
i386                  randconfig-001-20240525   clang
i386                  randconfig-002-20240524   clang
i386                  randconfig-003-20240524   clang
i386                  randconfig-003-20240525   clang
i386                  randconfig-004-20240524   clang
i386                  randconfig-004-20240525   clang
i386                  randconfig-005-20240524   gcc  
i386                  randconfig-006-20240524   clang
i386                  randconfig-011-20240524   clang
i386                  randconfig-011-20240525   clang
i386                  randconfig-012-20240524   gcc  
i386                  randconfig-012-20240525   clang
i386                  randconfig-013-20240524   gcc  
i386                  randconfig-013-20240525   clang
i386                  randconfig-014-20240524   clang
i386                  randconfig-015-20240524   clang
i386                  randconfig-015-20240525   clang
i386                  randconfig-016-20240524   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240525   gcc  
loongarch             randconfig-002-20240525   gcc  
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
nios2                 randconfig-001-20240525   gcc  
nios2                 randconfig-002-20240525   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240525   gcc  
parisc                randconfig-002-20240525   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20240525   gcc  
powerpc               randconfig-002-20240525   gcc  
powerpc               randconfig-003-20240525   gcc  
powerpc64             randconfig-001-20240525   clang
powerpc64             randconfig-002-20240525   gcc  
powerpc64             randconfig-003-20240525   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240525   gcc  
riscv                 randconfig-002-20240525   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240525   clang
s390                  randconfig-002-20240525   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240525   gcc  
sh                    randconfig-002-20240525   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240525   gcc  
sparc64               randconfig-002-20240525   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240525   gcc  
um                    randconfig-002-20240525   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240525   clang
x86_64       buildonly-randconfig-002-20240525   gcc  
x86_64       buildonly-randconfig-003-20240525   gcc  
x86_64       buildonly-randconfig-004-20240525   gcc  
x86_64       buildonly-randconfig-005-20240525   gcc  
x86_64       buildonly-randconfig-006-20240525   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240525   clang
x86_64                randconfig-002-20240525   clang
x86_64                randconfig-003-20240525   clang
x86_64                randconfig-004-20240525   clang
x86_64                randconfig-005-20240525   clang
x86_64                randconfig-006-20240525   clang
x86_64                randconfig-011-20240525   clang
x86_64                randconfig-012-20240525   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240525   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

