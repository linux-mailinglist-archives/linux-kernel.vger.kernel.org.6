Return-Path: <linux-kernel+bounces-189597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C1E48CF2AB
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 08:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03ECA281404
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 06:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2C53D72;
	Sun, 26 May 2024 06:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WUaJRiQI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2DD1A2C1E
	for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 06:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716705273; cv=none; b=kXT9RS2U+83k/2TnqRoROU8wTdpk1GHZkBVACkpkMVqhU+7I8jeKx+bRCsnevuuPGppNlQEp5TgwG+RyYBr2WMx9tscV+y5NfL7YIk3F8M4ou2ws+2NyWkTESb2ulcRw37KIsAQLSW5vovUxsb8rC2Fs4vpjopyAB6R3y5fqew8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716705273; c=relaxed/simple;
	bh=JAUyz7VywdUe2bWHKUbFKtRxPpC+ZLmzmLsaDZ3nlwE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=FcRWq9+4fGJCF1kW/OWQF6OC5F38YyNm/33dOWBYWyoFkO+6d1MOj0Mbi3zPVmpIvFkP7KTGUhAFRXbFvF8oYFEIKF6Li+imt/QSGWT3gexLveHNre6OzhdmKJ1KvvyTmDBaWAH7fTyz8Wva7dAtabW2F+MsTN2jmpJ0EgGe0aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WUaJRiQI; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716705271; x=1748241271;
  h=date:from:to:cc:subject:message-id;
  bh=JAUyz7VywdUe2bWHKUbFKtRxPpC+ZLmzmLsaDZ3nlwE=;
  b=WUaJRiQI8FWlo9/uEETmFochVeOT/+zr4fJ0UDhNiTLSsKA++tD9bIPS
   taVVrLNmLVf2i7IEl81NvaBV3SantXcr3n9WCR7OHrizMl9hVgkA2Lbeo
   0WzpAHSdfhRCh3mSLO2kiTHbbBVMQ7r3MqN9S+7ZXXbwHQSY1ZA/+YMny
   9R5UvoWFUgzbETrams6anLUGPaWsXgBrA0LzPxt0x6XZTUzSsY+nedx24
   DsTTqjSWVamb7XpgzbDybr7J85CZgHoa1M8dfAQvFLtGVD00tFkdNoTDb
   w6f2sk8Tgk4Z2/sa3Cp/DXbyhCjeo/ft5SVaB23u0URWMntn99xbcQlgV
   Q==;
X-CSE-ConnectionGUID: fbOLDnw8SHqfftYv/oJleA==
X-CSE-MsgGUID: nxblOczBT46+baIGdw4mYA==
X-IronPort-AV: E=McAfee;i="6600,9927,11083"; a="12860322"
X-IronPort-AV: E=Sophos;i="6.08,189,1712646000"; 
   d="scan'208";a="12860322"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2024 23:34:31 -0700
X-CSE-ConnectionGUID: 49hz/XJhRU6dL8k97HmSJg==
X-CSE-MsgGUID: ErEqNngQS+i2NjvVm9crOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,189,1712646000"; 
   d="scan'208";a="34920200"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 25 May 2024 23:34:29 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sB7Sd-0007oP-04;
	Sun, 26 May 2024 06:34:27 +0000
Date: Sun, 26 May 2024 14:34:01 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 ebdce75199f345ff8c344a1b2ac0776edd7a8c39
Message-ID: <202405261459.8gnBlXfr-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: ebdce75199f345ff8c344a1b2ac0776edd7a8c39  Merge branch into tip/master: 'x86/percpu'

elapsed time: 1071m

configs tested: 171
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
arc                   randconfig-001-20240526   gcc  
arc                   randconfig-002-20240526   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240526   clang
arm                   randconfig-002-20240526   gcc  
arm                   randconfig-003-20240526   clang
arm                   randconfig-004-20240526   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240526   gcc  
arm64                 randconfig-002-20240526   clang
arm64                 randconfig-003-20240526   gcc  
arm64                 randconfig-004-20240526   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240526   gcc  
csky                  randconfig-002-20240526   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240526   clang
hexagon               randconfig-002-20240526   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240525   gcc  
i386         buildonly-randconfig-002-20240525   gcc  
i386         buildonly-randconfig-002-20240526   gcc  
i386         buildonly-randconfig-003-20240525   gcc  
i386         buildonly-randconfig-003-20240526   gcc  
i386         buildonly-randconfig-004-20240525   clang
i386         buildonly-randconfig-005-20240525   gcc  
i386         buildonly-randconfig-006-20240525   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240525   clang
i386                  randconfig-002-20240525   gcc  
i386                  randconfig-003-20240525   clang
i386                  randconfig-004-20240525   clang
i386                  randconfig-005-20240525   gcc  
i386                  randconfig-005-20240526   gcc  
i386                  randconfig-006-20240525   gcc  
i386                  randconfig-011-20240525   clang
i386                  randconfig-012-20240525   clang
i386                  randconfig-012-20240526   gcc  
i386                  randconfig-013-20240525   clang
i386                  randconfig-013-20240526   gcc  
i386                  randconfig-014-20240525   gcc  
i386                  randconfig-014-20240526   gcc  
i386                  randconfig-015-20240525   clang
i386                  randconfig-015-20240526   gcc  
i386                  randconfig-016-20240525   gcc  
i386                  randconfig-016-20240526   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240526   gcc  
loongarch             randconfig-002-20240526   gcc  
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
nios2                 randconfig-001-20240526   gcc  
nios2                 randconfig-002-20240526   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240526   gcc  
parisc                randconfig-002-20240526   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20240526   clang
powerpc               randconfig-002-20240526   clang
powerpc               randconfig-003-20240526   gcc  
powerpc64             randconfig-001-20240526   clang
powerpc64             randconfig-002-20240526   gcc  
powerpc64             randconfig-003-20240526   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240526   clang
riscv                 randconfig-002-20240526   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240526   clang
s390                  randconfig-002-20240526   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240526   gcc  
sh                    randconfig-002-20240526   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240526   gcc  
sparc64               randconfig-002-20240526   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240526   clang
um                    randconfig-002-20240526   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240526   clang
x86_64       buildonly-randconfig-002-20240526   clang
x86_64       buildonly-randconfig-003-20240526   gcc  
x86_64       buildonly-randconfig-004-20240526   clang
x86_64       buildonly-randconfig-005-20240526   clang
x86_64       buildonly-randconfig-006-20240526   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240526   clang
x86_64                randconfig-002-20240526   clang
x86_64                randconfig-003-20240526   clang
x86_64                randconfig-004-20240526   gcc  
x86_64                randconfig-005-20240526   gcc  
x86_64                randconfig-006-20240526   clang
x86_64                randconfig-011-20240526   gcc  
x86_64                randconfig-012-20240526   gcc  
x86_64                randconfig-013-20240526   gcc  
x86_64                randconfig-014-20240526   gcc  
x86_64                randconfig-015-20240526   gcc  
x86_64                randconfig-016-20240526   clang
x86_64                randconfig-071-20240526   gcc  
x86_64                randconfig-072-20240526   clang
x86_64                randconfig-073-20240526   clang
x86_64                randconfig-074-20240526   clang
x86_64                randconfig-075-20240526   clang
x86_64                randconfig-076-20240526   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240526   gcc  
xtensa                randconfig-002-20240526   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

