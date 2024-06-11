Return-Path: <linux-kernel+bounces-210441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5F39043B1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 20:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10C3528B233
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 18:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9092374416;
	Tue, 11 Jun 2024 18:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dN+2suD1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECC36E612
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 18:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718130599; cv=none; b=mvXRZTj/XP8XlNRDmuWxiyvH9ygYMxlSwraKjzqQEVYztwfOWUdX65osIQz1DvANnbtXkptAi87XHTcgWsCenVhrm4tNTQnkC1vhfmXqyv81dGUrrkIOdyCGclwvfdmNDIjazMNf0JkLUVU7anlMJd3nxUKIOSZwLfGXTOUGuso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718130599; c=relaxed/simple;
	bh=ktUxzUbRCFBsZxIJV1R0ORx6+3d3l6L+nqvxUC52Pxw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=KL5eBlsKFEuFnHwEnvB/JM+rQg6vKDzxvjeXY4XXSFmn7UBtKjaiShKgPaDPnAClRD7qXLNNWmzvfSG4ppW8T3xBzfrEHMiYgbalLFvJHxtxzjj6FZdjXAb8WQPZ/mV4bMlf5a5I423YusfCJ+eLAjTXnPPQpRTkcKUz/0n7NMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dN+2suD1; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718130598; x=1749666598;
  h=date:from:to:cc:subject:message-id;
  bh=ktUxzUbRCFBsZxIJV1R0ORx6+3d3l6L+nqvxUC52Pxw=;
  b=dN+2suD1wjsOa7zwNEeahq11CogL0tI5kUo+hua23Zg0iwj1bQ79BD2/
   UcJANEYGhh1giqHtO9BYR36vCGVjsDG8tGemHUhYJ3rwkksUvQntg0ZZL
   Dd/57qGoHa2evsfyMfp/S5aJXgom1LC9eRc9+bso4hpbFYFPAFv2WU0sM
   vGnyz27InYaOS8yiIv+0hbKxJw8d8f8E3WwKGyqiSp5cXtKzN7JE1mzaW
   smBwiGDQfhyeBf8DUVtEc89YOuPXY/VM611Y2nffckoA39d4q3Vo+pX8Q
   kV0ftbTcsPD/t6raIrnMlfp8vMRTwKozPTEY0qjBr45CSPvOc5rzTge/Q
   Q==;
X-CSE-ConnectionGUID: sqUnYpjmQASFaSjp9e7bNQ==
X-CSE-MsgGUID: FYrQbU/sSL2bdSfeIE+dWQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="32401165"
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="32401165"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 11:29:57 -0700
X-CSE-ConnectionGUID: dFCb+9biTaarbWznO6h50g==
X-CSE-MsgGUID: wsO6iW0nRcSg2U1gcMacAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="39631353"
Received: from lkp-server01.sh.intel.com (HELO 628d7d8b9fc6) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 11 Jun 2024 11:29:56 -0700
Received: from kbuild by 628d7d8b9fc6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sH6Fm-0000lq-01;
	Tue, 11 Jun 2024 18:29:54 +0000
Date: Wed, 12 Jun 2024 02:29:07 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:timers/urgent] BUILD SUCCESS
 07c54cc5988f19c9642fd463c2dbdac7fc52f777
Message-ID: <202406120205.dAR6GsT2-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/urgent
branch HEAD: 07c54cc5988f19c9642fd463c2dbdac7fc52f777  tick/nohz_full: Don't abuse smp_call_function_single() in tick_setup_device()

elapsed time: 1446m

configs tested: 89
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                             allnoconfig   gcc-13.2.0
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                               defconfig   gcc-13.2.0
arc                               allnoconfig   gcc  
arc                               allnoconfig   gcc-13.2.0
arc                                 defconfig   gcc  
arc                                 defconfig   gcc-13.2.0
arm                               allnoconfig   clang
arm                                 defconfig   clang
arm64                             allnoconfig   gcc  
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc  
arm64                               defconfig   gcc-13.2.0
csky                              allnoconfig   gcc  
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc  
csky                                defconfig   gcc-13.2.0
hexagon                          allmodconfig   clang-19
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang-19
hexagon                             defconfig   clang
i386         buildonly-randconfig-003-20240611   clang
i386                  randconfig-001-20240611   clang
i386                  randconfig-004-20240611   clang
i386                  randconfig-006-20240611   clang
i386                  randconfig-011-20240611   clang
i386                  randconfig-013-20240611   clang
i386                  randconfig-015-20240611   clang
i386                  randconfig-016-20240611   clang
loongarch                        allmodconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc  
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc-13.2.0
m68k                              allnoconfig   gcc  
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-13.2.0
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc-13.2.0
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc-13.2.0
nios2                            allmodconfig   gcc-13.2.0
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc-13.2.0
nios2                               defconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                          allnoconfig   gcc-13.2.0
openrisc                            defconfig   gcc  
openrisc                            defconfig   gcc-13.2.0
parisc                            allnoconfig   gcc  
parisc                            allnoconfig   gcc-13.2.0
parisc                              defconfig   gcc  
parisc                              defconfig   gcc-13.2.0
parisc64                            defconfig   gcc  
parisc64                            defconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc  
powerpc                           allnoconfig   gcc-13.2.0
riscv                             allnoconfig   gcc  
riscv                             allnoconfig   gcc-13.2.0
riscv                               defconfig   clang
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang
s390                             allyesconfig   gcc-13.2.0
s390                                defconfig   clang
sh                               allmodconfig   gcc-13.2.0
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc-13.2.0
sh                                  defconfig   gcc  
sparc                            allmodconfig   gcc-13.2.0
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc-13.2.0
sparc64                          allyesconfig   gcc-13.2.0
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                               allyesconfig   gcc-13
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang-18
x86_64                              defconfig   gcc-13
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

