Return-Path: <linux-kernel+bounces-208684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C4C90281A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 19:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42E531F235C8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 17:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32241494A6;
	Mon, 10 Jun 2024 17:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iQZvMxpZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BA9147C74
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 17:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718042216; cv=none; b=UCC5tPdA0xQ+7Ye2YgIwSQjko75rpFQ/5chIzPifD/2lZHKqiYQHepiwDV2IXvxuhNrpRv8B5Cp7++A99N7MOMDSZpzpk4CEj7DUiX+7EOw8O2ioVTa67C6lqgkIs1CqA24NAS5LmMsH2HeiYW621fp2JoWaH+c7R9RLBNyPNuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718042216; c=relaxed/simple;
	bh=gMkJp238NkJLkLWLH+17nLRU4UMSl4yKNuuo7vW/USw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=LoW9sFVDKv35l16hVEsopT2/3e6Mwcf43r8b805o2VMInb9Zq1CMDKSFa/86zSHupO2P4M47ufWX5JGj5HSDk4+gkw3Tlt9IT4bfCSYu41XGx0QlTZm9ES8/J5Ehrb/udHntHPc/+CXkDe84He8J/gVoNe2nRdAJgsaBiSnCZUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iQZvMxpZ; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718042214; x=1749578214;
  h=date:from:to:cc:subject:message-id;
  bh=gMkJp238NkJLkLWLH+17nLRU4UMSl4yKNuuo7vW/USw=;
  b=iQZvMxpZiOPFLhzmxnVulEvOHIS8qW1pklb5Tzsb6oX6aMZ7cZufvdqx
   8QMGo4Z3F2Tht34gRFyoFkjOW9nDJl1YR8L5dRsOwerJBjKZqr9DQwmfz
   PNXqxtY+XzZL3wdAh6n2TuQpTzfyQsoLcSGRchYN9all6RT6Qvqo7qBVL
   abQ2vr8Gg1NmMA61A4obTIY3iTAd+q+Uvfrd0aizOqCUsYu5dKl8z3oa/
   V3c2GwPf09shlXmUdGAE+9uW9xS7QD60Fq8TBxU3QyiqB64FPJ4EW965r
   ZkRZspnLQjj7rVmNvq2GpPvbIo/h7h0vutpy+c0rUFqsAHHogv3M/MHk5
   g==;
X-CSE-ConnectionGUID: FZTDPPNIQFqmxzRl+sEZiQ==
X-CSE-MsgGUID: imTcDBjQS0i1KIufPUJc2A==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="14666174"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="14666174"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 10:56:54 -0700
X-CSE-ConnectionGUID: 9TYhhgPTRSS4zgwTBr18jQ==
X-CSE-MsgGUID: IjxOFIL6QM6HjUhGZ3RY4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="70305835"
Received: from lkp-server01.sh.intel.com (HELO 8967fbab76b3) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 10 Jun 2024 10:56:51 -0700
Received: from kbuild by 8967fbab76b3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sGjGE-0002MP-1m;
	Mon, 10 Jun 2024 17:56:50 +0000
Date: Tue, 11 Jun 2024 01:56:31 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:non-rcu/next] BUILD SUCCESS
 e78511732bbdbc97bf05ca7a7096feac8f24b824
Message-ID: <202406110130.NDC61Y98-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git non-rcu/next
branch HEAD: e78511732bbdbc97bf05ca7a7096feac8f24b824  Merge branches 'cmpxchg.2024.06.06a', 'kcsan.2024.06.06a', 'lkmm.2024.06.06a', 'torture.2024.05.30b' and 'tsc.2024.05.27a' into HEAD

elapsed time: 1450m

configs tested: 114
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240610   gcc  
arc                   randconfig-002-20240610   gcc  
arm                               allnoconfig   clang
arm                         at91_dt_defconfig   clang
arm                                 defconfig   clang
arm                           h3600_defconfig   gcc  
arm                         lpc18xx_defconfig   clang
arm                          pxa168_defconfig   clang
arm                          pxa3xx_defconfig   clang
arm                   randconfig-001-20240610   gcc  
arm                   randconfig-002-20240610   gcc  
arm                   randconfig-003-20240610   clang
arm                   randconfig-004-20240610   gcc  
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240610   gcc  
arm64                 randconfig-002-20240610   gcc  
arm64                 randconfig-003-20240610   gcc  
arm64                 randconfig-004-20240610   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240610   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240610   clang
i386         buildonly-randconfig-002-20240610   gcc  
i386         buildonly-randconfig-003-20240610   gcc  
i386         buildonly-randconfig-004-20240610   clang
i386         buildonly-randconfig-005-20240610   gcc  
i386         buildonly-randconfig-006-20240610   clang
i386                                defconfig   clang
i386                  randconfig-001-20240610   gcc  
i386                  randconfig-002-20240610   gcc  
i386                  randconfig-003-20240610   gcc  
i386                  randconfig-004-20240610   gcc  
i386                  randconfig-005-20240610   clang
i386                  randconfig-006-20240610   gcc  
i386                  randconfig-011-20240610   clang
i386                  randconfig-012-20240610   clang
i386                  randconfig-013-20240610   clang
i386                  randconfig-014-20240610   clang
i386                  randconfig-015-20240610   clang
i386                  randconfig-016-20240610   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
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
mips                         cobalt_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                            defconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-002-20240610   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-003-20240610   clang
x86_64                randconfig-006-20240610   clang
x86_64                randconfig-011-20240610   clang
x86_64                randconfig-015-20240610   clang
x86_64                randconfig-016-20240610   clang
x86_64                randconfig-072-20240610   clang
x86_64                randconfig-073-20240610   clang
x86_64                randconfig-075-20240610   clang
x86_64                randconfig-076-20240610   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

