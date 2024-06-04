Return-Path: <linux-kernel+bounces-200135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD078FAB95
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 09:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B139A1C23F61
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 07:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6062213790F;
	Tue,  4 Jun 2024 07:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PiOGPGqX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8918A83CB4
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 07:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717485000; cv=none; b=NfSRF8diFksaaf6E8JLR7ISer70PUkBlYcW9gI9VmlU3VyDBAktmpqVrCrkGDE94e7xF4pmQNcVfObvivLVUgqUuP9abkqj6EnyiIXuuM4gwq9mbdB/JIeVN9hjExx95k5oBk8JLPS2/bDdIC4kG5mfF7nW+l7ovozAMqH2Vzek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717485000; c=relaxed/simple;
	bh=Y228hsjdhusMRLxJroXyYjEF7idWdZ6nJ5lhf0x1Bbg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=uZOLe3jf9x4et7Lmglh3olNyDt6hvt9FxevWQUu/x/Yh1rEjl2gj7XjiXvG/igVfsyDzCfvleHheNPEPHhU66apRLMiccx0h/rtR+wdoi3V4xSJ/8vwihEyrhaFs+PymSxIHNvddgzvujpYju+wcN98A67CnChY/lutfFVWQLcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PiOGPGqX; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717484998; x=1749020998;
  h=date:from:to:cc:subject:message-id;
  bh=Y228hsjdhusMRLxJroXyYjEF7idWdZ6nJ5lhf0x1Bbg=;
  b=PiOGPGqXBZ405qfkM2omWqILRYpkYW0SkKXcsgAnGZH+vB5XGxgikJhu
   gC82ZBVvN6Iiqkodlk45eJzOuJCHrtaAsQBDXese4BGZtUp1jXZLsAqsI
   8G+9AFJdDio5gUYFE2Nnk3ONL9FXuITC4Y2pdAqJblEsI5fVr85lv3plP
   78SMbyZa2yn7tb+SMi3UNKpmLOUknNMW8oOqfZ2By/usal1zvg/l3klhE
   AnX84mqKfkGvzESXj+tZ/B3VS92vru85KJJCr4Xm3Sbqv3RMS2VXWxxIz
   lK9cwMYaefAQEJJXYTgT85u8Bpd+foW4nUg/1mC9PiY0WNq6P9CzX5jqk
   g==;
X-CSE-ConnectionGUID: kS25amOJR8K7FT0VeaTOsg==
X-CSE-MsgGUID: KduiXiROSLeNFSdJ6CFkKQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="14233659"
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="14233659"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 00:09:58 -0700
X-CSE-ConnectionGUID: nndCvw7JRmefSxbFq5OleA==
X-CSE-MsgGUID: ecpEqiC6QmWqS4rqrjWCRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="42075365"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 04 Jun 2024 00:09:56 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sEOIs-000Mh2-0b;
	Tue, 04 Jun 2024 07:09:54 +0000
Date: Tue, 04 Jun 2024 15:09:27 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:irq/core] BUILD SUCCESS
 cb06c9826991c746039d076df10d40819f88a6bc
Message-ID: <202406041524.TwuDbvhk-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
branch HEAD: cb06c9826991c746039d076df10d40819f88a6bc  genirq/debugfs: Print irqdomain flags as human-readable strings

elapsed time: 1241m

configs tested: 224
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
arc                          axs101_defconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240603   gcc  
arc                   randconfig-001-20240604   gcc  
arc                   randconfig-002-20240603   gcc  
arc                   randconfig-002-20240604   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240603   gcc  
arm                   randconfig-001-20240604   clang
arm                   randconfig-002-20240603   gcc  
arm                   randconfig-002-20240604   gcc  
arm                   randconfig-003-20240603   gcc  
arm                   randconfig-003-20240604   clang
arm                   randconfig-004-20240603   gcc  
arm                   randconfig-004-20240604   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   clang
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240603   gcc  
arm64                 randconfig-001-20240604   clang
arm64                 randconfig-002-20240603   gcc  
arm64                 randconfig-002-20240604   gcc  
arm64                 randconfig-003-20240603   clang
arm64                 randconfig-003-20240604   gcc  
arm64                 randconfig-004-20240603   gcc  
arm64                 randconfig-004-20240604   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240603   gcc  
csky                  randconfig-001-20240604   gcc  
csky                  randconfig-002-20240603   gcc  
csky                  randconfig-002-20240604   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240603   clang
hexagon               randconfig-001-20240604   clang
hexagon               randconfig-002-20240603   clang
hexagon               randconfig-002-20240604   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240603   clang
i386         buildonly-randconfig-002-20240603   clang
i386         buildonly-randconfig-002-20240604   clang
i386         buildonly-randconfig-003-20240603   gcc  
i386         buildonly-randconfig-003-20240604   clang
i386         buildonly-randconfig-004-20240603   gcc  
i386         buildonly-randconfig-005-20240603   gcc  
i386         buildonly-randconfig-005-20240604   clang
i386         buildonly-randconfig-006-20240603   clang
i386         buildonly-randconfig-006-20240604   clang
i386                                defconfig   clang
i386                  randconfig-001-20240603   clang
i386                  randconfig-001-20240604   clang
i386                  randconfig-002-20240603   gcc  
i386                  randconfig-002-20240604   clang
i386                  randconfig-003-20240603   gcc  
i386                  randconfig-003-20240604   clang
i386                  randconfig-004-20240603   clang
i386                  randconfig-004-20240604   clang
i386                  randconfig-005-20240603   clang
i386                  randconfig-006-20240603   gcc  
i386                  randconfig-011-20240603   clang
i386                  randconfig-011-20240604   clang
i386                  randconfig-012-20240603   clang
i386                  randconfig-013-20240603   clang
i386                  randconfig-014-20240603   clang
i386                  randconfig-014-20240604   clang
i386                  randconfig-015-20240603   clang
i386                  randconfig-015-20240604   clang
i386                  randconfig-016-20240603   gcc  
i386                  randconfig-016-20240604   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240603   gcc  
loongarch             randconfig-001-20240604   gcc  
loongarch             randconfig-002-20240603   gcc  
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
mips                       bmips_be_defconfig   gcc  
mips                  decstation_64_defconfig   gcc  
mips                  maltasmvp_eva_defconfig   gcc  
mips                    maltaup_xpa_defconfig   gcc  
mips                           rs90_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240603   gcc  
nios2                 randconfig-001-20240604   gcc  
nios2                 randconfig-002-20240603   gcc  
nios2                 randconfig-002-20240604   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-32bit_defconfig   gcc  
parisc                randconfig-001-20240603   gcc  
parisc                randconfig-001-20240604   gcc  
parisc                randconfig-002-20240603   gcc  
parisc                randconfig-002-20240604   gcc  
parisc64                         alldefconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20240603   gcc  
powerpc               randconfig-001-20240604   gcc  
powerpc               randconfig-002-20240603   gcc  
powerpc               randconfig-002-20240604   gcc  
powerpc               randconfig-003-20240603   gcc  
powerpc               randconfig-003-20240604   gcc  
powerpc64             randconfig-001-20240603   gcc  
powerpc64             randconfig-001-20240604   gcc  
powerpc64             randconfig-002-20240603   gcc  
powerpc64             randconfig-002-20240604   gcc  
powerpc64             randconfig-003-20240604   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
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
sh                          kfr2r09_defconfig   gcc  
sh                    randconfig-001-20240603   gcc  
sh                    randconfig-001-20240604   gcc  
sh                    randconfig-002-20240603   gcc  
sh                    randconfig-002-20240604   gcc  
sh                           se7724_defconfig   gcc  
sh                        sh7763rdp_defconfig   gcc  
sh                  sh7785lcr_32bit_defconfig   gcc  
sh                        sh7785lcr_defconfig   gcc  
sh                            shmin_defconfig   gcc  
sh                              ul2_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240603   gcc  
sparc64               randconfig-001-20240604   gcc  
sparc64               randconfig-002-20240603   gcc  
sparc64               randconfig-002-20240604   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240604   clang
um                    randconfig-002-20240603   gcc  
um                    randconfig-002-20240604   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240604   clang
x86_64       buildonly-randconfig-002-20240604   clang
x86_64       buildonly-randconfig-003-20240604   gcc  
x86_64       buildonly-randconfig-004-20240604   clang
x86_64       buildonly-randconfig-005-20240604   gcc  
x86_64       buildonly-randconfig-006-20240604   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240604   clang
x86_64                randconfig-002-20240604   gcc  
x86_64                randconfig-003-20240604   gcc  
x86_64                randconfig-004-20240604   gcc  
x86_64                randconfig-005-20240604   gcc  
x86_64                randconfig-006-20240604   gcc  
x86_64                randconfig-011-20240604   clang
x86_64                randconfig-012-20240604   clang
x86_64                randconfig-013-20240604   clang
x86_64                randconfig-014-20240604   clang
x86_64                randconfig-015-20240604   clang
x86_64                randconfig-016-20240604   clang
x86_64                randconfig-071-20240604   clang
x86_64                randconfig-072-20240604   gcc  
x86_64                randconfig-073-20240604   gcc  
x86_64                randconfig-074-20240604   clang
x86_64                randconfig-075-20240604   clang
x86_64                randconfig-076-20240604   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240603   gcc  
xtensa                randconfig-001-20240604   gcc  
xtensa                randconfig-002-20240603   gcc  
xtensa                randconfig-002-20240604   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

