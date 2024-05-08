Return-Path: <linux-kernel+bounces-173889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25EE38C0740
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 00:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA123281080
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 22:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB4613328D;
	Wed,  8 May 2024 22:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gTk16Kq5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5F51E89A
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 22:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715206539; cv=none; b=t0b68857J6s45kinesdS0DQMgEJfnzyquyIG0tkVtliySp8ASIUBIgXwgyAq8UHbo93uL+ihcyXYWy/WOKMumKoFKTi+xEcMBAGceSaodZAXJvY+6l7ZWGBTRhXt3OdPeYX7ne+rnLo0QLsvCsPui9AyFGlUesj4TXaiqSOtos8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715206539; c=relaxed/simple;
	bh=yjUf8hncPawWk3sTgkRhcrYgFbIEcsA0qkywojvzO3w=;
	h=Date:From:To:Cc:Subject:Message-ID; b=oAN3trfrzvPW/1kLEVnrjLqk3Xa+h3V57npNcvjPK1HpDS+Fv7Wgvfl3bUHnakex8zLUCtN1Fzy3m1AWzdlw4ZMaIkngNUgK5B0OobDMGhvS1xwARnR2bDe/jN5g1pjAha75zNHpA9LUcd1NksmEwrJ5XN+21y/Sx5Zv87eSPhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gTk16Kq5; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715206538; x=1746742538;
  h=date:from:to:cc:subject:message-id;
  bh=yjUf8hncPawWk3sTgkRhcrYgFbIEcsA0qkywojvzO3w=;
  b=gTk16Kq5nCtF+igulJeEC2IC8hrXvEeX3AiMxF5THwI/Zbq/AWJxUNCC
   MRU73riDwPcyMVZZHdNBM6dEkAxh08BaK7u48eN32c49yD23sz/3pR2ly
   NuDP/DlJIRhjgAs2FjlpRCxKzPLS5kHkvMTtowV07oy/LyThN5S5R9zqp
   fNhyUG9xnVs4zALwtF7L+APz3STHqpynpdEUdM/17BUIRZPZgxSTCY/W5
   mQ0+itX9JaLpTQj7au5srGZhAenI9Q65Lo2R2wA4P6djrabLeo4rvQfAV
   R/20XkdO0z98PzHvtc5Xdd+t95lyS7ySVVzykakt80+GoZDNDEl6Eqtpx
   g==;
X-CSE-ConnectionGUID: PfEwJVZyRsKyMZaAME/SCw==
X-CSE-MsgGUID: GcIW1pxrSH6kpmnq506uGw==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="11036109"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="11036109"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 15:15:38 -0700
X-CSE-ConnectionGUID: CHW1FK0NRl2hW+sog8Tb7A==
X-CSE-MsgGUID: IjTiHijmQz+CeDPidVwg9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="28982921"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 08 May 2024 15:15:36 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s4pZV-0004A5-2Z;
	Wed, 08 May 2024 22:15:33 +0000
Date: Thu, 09 May 2024 06:15:22 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 2604e6c504cc9626199dbde61605f35f1f055d8a
Message-ID: <202405090620.9XQeVuYL-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: 2604e6c504cc9626199dbde61605f35f1f055d8a  Merge branches 'cmpxchg.2024.05.01a', 'kcsan.2024.05.07a', 'lkmm.2024.05.06a', 'rcu-merge.2024.05.01a' and 'tsc.2024.04.09c' into HEAD

elapsed time: 1468m

configs tested: 159
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
arc                   randconfig-001-20240508   gcc  
arc                   randconfig-002-20240508   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240508   gcc  
arm                   randconfig-002-20240508   clang
arm                   randconfig-003-20240508   clang
arm                   randconfig-004-20240508   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240508   gcc  
arm64                 randconfig-002-20240508   clang
arm64                 randconfig-003-20240508   gcc  
arm64                 randconfig-004-20240508   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240508   gcc  
csky                  randconfig-002-20240508   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240508   clang
hexagon               randconfig-002-20240508   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240508   clang
i386         buildonly-randconfig-002-20240508   clang
i386         buildonly-randconfig-003-20240508   gcc  
i386         buildonly-randconfig-004-20240508   gcc  
i386         buildonly-randconfig-005-20240508   clang
i386         buildonly-randconfig-006-20240508   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240508   gcc  
i386                  randconfig-002-20240508   clang
i386                  randconfig-003-20240508   clang
i386                  randconfig-004-20240508   gcc  
i386                  randconfig-005-20240508   clang
i386                  randconfig-006-20240508   gcc  
i386                  randconfig-011-20240508   gcc  
i386                  randconfig-012-20240508   gcc  
i386                  randconfig-013-20240508   clang
i386                  randconfig-014-20240508   clang
i386                  randconfig-015-20240508   clang
i386                  randconfig-016-20240508   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240508   gcc  
loongarch             randconfig-002-20240508   gcc  
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
nios2                 randconfig-001-20240508   gcc  
nios2                 randconfig-002-20240508   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240508   gcc  
parisc                randconfig-002-20240508   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc               randconfig-001-20240508   clang
powerpc               randconfig-002-20240508   gcc  
powerpc               randconfig-003-20240508   clang
powerpc64             randconfig-001-20240508   gcc  
powerpc64             randconfig-002-20240508   gcc  
powerpc64             randconfig-003-20240508   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   clang
riscv                 randconfig-001-20240508   gcc  
riscv                 randconfig-002-20240508   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240508   clang
s390                  randconfig-002-20240508   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240508   gcc  
sh                    randconfig-002-20240508   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240508   gcc  
sparc64               randconfig-002-20240508   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240508   gcc  
um                    randconfig-002-20240508   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240508   clang
x86_64       buildonly-randconfig-002-20240508   clang
x86_64       buildonly-randconfig-003-20240508   clang
x86_64       buildonly-randconfig-004-20240508   clang
x86_64       buildonly-randconfig-005-20240508   gcc  
x86_64       buildonly-randconfig-006-20240508   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240508   gcc  
x86_64                randconfig-002-20240508   clang
x86_64                randconfig-003-20240508   clang
x86_64                randconfig-004-20240508   gcc  
x86_64                randconfig-005-20240508   gcc  
x86_64                randconfig-006-20240508   gcc  
x86_64                randconfig-011-20240508   clang
x86_64                randconfig-012-20240508   clang
x86_64                randconfig-013-20240508   gcc  
x86_64                randconfig-014-20240508   gcc  
x86_64                randconfig-015-20240508   clang
x86_64                randconfig-016-20240508   gcc  
x86_64                randconfig-071-20240508   gcc  
x86_64                randconfig-072-20240508   gcc  
x86_64                randconfig-073-20240508   clang
x86_64                randconfig-074-20240508   gcc  
x86_64                randconfig-075-20240508   gcc  
x86_64                randconfig-076-20240508   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240508   gcc  
xtensa                randconfig-002-20240508   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

