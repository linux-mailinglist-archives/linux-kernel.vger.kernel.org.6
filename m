Return-Path: <linux-kernel+bounces-208685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A049D90281B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 19:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20D7C1F23644
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 17:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D96114B963;
	Mon, 10 Jun 2024 17:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fWX6DN5+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C2F1487F1
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 17:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718042217; cv=none; b=T4UUlk8xlOVJ6lrZtUzPpJrCgtXKnibN3EqVUvEiipIa/c6r4++GZFJSGhCoZDTdHTsB7uOqybX4Z1pWraGbIShstU4cQ35jf0fhxLAJqqPUTF46mNtI8BEwaEZOUu/iaSH2hy/mx8gL+iuOlHNfjr9pUkrgZbhutKUkZOi7FTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718042217; c=relaxed/simple;
	bh=unUvIdc/8vzuqCyuMyO99iFQBGvazBdMbdZCF1G4HtM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=A4vppVAgCqLbSgxmQ3kMY0eQWIbxweuwoaIQKfXlTUw68UCJ+C3SD9k/8jV+Ba8ZNtyIBtyuWmXhN6cHqPv00EcGYTRWhm8JUjuCDXAmfI2/AClGcmVx+i3spQ405rGHdG1nQz7A3Hu5CFbPkxhwR8LJsK0RFT3HRe6IvpT4h7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fWX6DN5+; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718042216; x=1749578216;
  h=date:from:to:cc:subject:message-id;
  bh=unUvIdc/8vzuqCyuMyO99iFQBGvazBdMbdZCF1G4HtM=;
  b=fWX6DN5+39VuA0mR49Pougga5LcYZolTZYhTVYI+kUUU++8tISw9AC+O
   HjY8CKXOOERIjRcgyRPYr4VJiI6yyK172zfQXLJMeZw5wqfcjhbWyaD/N
   7bx1NG1xw4wnkvLdxx+eoj2AHbJtiXNIQvcZM+GhXI0jx5f9mwzQfdKh5
   XtQzM6YWhdEjw9gYhoI6XMmwQzFRIgoGCNTFTiAdudfJiNmDbhgKLLEy7
   2ws6+wqAK0ZenlXBQfXbYDGGSaaRpBXn3cR5Ru9vAX/m0zLCj1HtFrUsr
   YaajCuGBy32gRNM3kdJJP7QRa5oibBnVKUaIg0eAy2UFv9bw/kObOqph4
   A==;
X-CSE-ConnectionGUID: HyM5UnmnQpKop+hI5Z6jOA==
X-CSE-MsgGUID: x1qGcnJ4SOCoBkVhtTZ/Jw==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="14666176"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="14666176"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 10:56:54 -0700
X-CSE-ConnectionGUID: BNn4ZUM+R6WqYggpBOlVZQ==
X-CSE-MsgGUID: Fdk35mDURlSRdWz16uqKlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="70305836"
Received: from lkp-server01.sh.intel.com (HELO 8967fbab76b3) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 10 Jun 2024 10:56:51 -0700
Received: from kbuild by 8967fbab76b3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sGjGE-0002MS-1t;
	Mon, 10 Jun 2024 17:56:50 +0000
Date: Tue, 11 Jun 2024 01:56:05 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:next] BUILD SUCCESS
 f395ae346be5c56cef189dfa5530d4608ff7af5c
Message-ID: <202406110103.j9xqzStI-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git next
branch HEAD: f395ae346be5c56cef189dfa5530d4608ff7af5c  Merge branches 'doc.2024.06.06a', 'fixes.2024.06.06a', 'mb.2024.06.03a', 'nocb.2024.06.03a', 'rcu-tasks.2024.06.06a' and 'rcutorture.2024.06.06a' into HEAD

elapsed time: 1450m

configs tested: 125
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
arm                               allnoconfig   clang
arm                                 defconfig   clang
arm                          pxa910_defconfig   gcc  
arm                             rpc_defconfig   clang
arm                         s5pv210_defconfig   gcc  
arm                          sp7021_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   clang
arm64                               defconfig   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
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
m68k                       m5208evb_defconfig   gcc  
m68k                        mvme16x_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                         bigsur_defconfig   gcc  
mips                            gpr_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                            defconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-32bit_defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                 linkstation_defconfig   clang
powerpc                  mpc885_ads_defconfig   clang
powerpc                     taishan_defconfig   clang
powerpc                     tqm8560_defconfig   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                          r7780mp_defconfig   gcc  
sh                          rsk7203_defconfig   gcc  
sh                          rsk7264_defconfig   gcc  
sh                        sh7763rdp_defconfig   gcc  
sh                          urquell_defconfig   gcc  
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
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

