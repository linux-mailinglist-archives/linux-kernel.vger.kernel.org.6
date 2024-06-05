Return-Path: <linux-kernel+bounces-201690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E578FC1D9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 04:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3FF3B21168
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 02:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14676BB26;
	Wed,  5 Jun 2024 02:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aCC/Pql+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201EB61FC9
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 02:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717554691; cv=none; b=G+fkbuNhept3KEZkl3zM3kFMjtJSJnVOo8YIa4CvC1cPUpY0Xj0318lK0mRcBD9cNIMZ4s4pVBpiYIVAyrP2+191dHoNjek0HhhzffIrVrFI+9RwADycx0/wmFZrZeD38ouEPZPGJG84TMWYBxZUgqQcwka1PNSG7QTCIvBRgMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717554691; c=relaxed/simple;
	bh=FeRuDmmoyeFphAaCbZQP8E6te2Rk+dVetPxxqEYOORc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=SWLixNeOAzheR1PRR/HlorAN2ChJSLDc5XjVLrQKzAvBGiTR4bkemCo19MKj6g6lgJaUyxvMiV560tbfkRW009LSQligXVKOwpE52vQg2ETVm3kcI4XdDmb48a++8ZhE6k5gYamvRy5XKwlI7JmUjqKMFuvBwomQDfIqYkJqdx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aCC/Pql+; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717554690; x=1749090690;
  h=date:from:to:cc:subject:message-id;
  bh=FeRuDmmoyeFphAaCbZQP8E6te2Rk+dVetPxxqEYOORc=;
  b=aCC/Pql+VRZN5BdiyI8hsFi5vLLw7qBBbYGaJNnXwm+ZAWLONvcBIBod
   QIWcZEHkGeAxD6UrnBE7MoSsfr4NwucdTsLliuAXCr3u1H8TI4LqYzFEX
   AdftdrYf7zIX0YHVzGMHMdMUKyue+NM2mlFKiw54O+lswwlrAZXn918x7
   DIrdL/HLeOub5Vo06QS1Gc3Hb8w08B/Aqpbe6nFpB3TVsCM7CzHSktNWY
   42f/GDqE8N09GSEuPCOi7a83oCEFO12GijKFk3hgAfo319fk8SDJC+89T
   lae4j5wp3k7WN40npg3hYC9A2LETqYwvZbB7e2iyjNehyuPhi0Etce8Ry
   g==;
X-CSE-ConnectionGUID: X6viAX5sREmy8WORkfWOnw==
X-CSE-MsgGUID: gjl/++o7RaCjgVuvZB1WvA==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="24766967"
X-IronPort-AV: E=Sophos;i="6.08,215,1712646000"; 
   d="scan'208";a="24766967"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 19:31:28 -0700
X-CSE-ConnectionGUID: H1QE/iZ+Tcus/R8LLy6D2g==
X-CSE-MsgGUID: y4kwBquoS3mi+6lPvJvWDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,215,1712646000"; 
   d="scan'208";a="74914436"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 04 Jun 2024 19:31:26 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sEgQu-0000of-0T;
	Wed, 05 Jun 2024 02:31:24 +0000
Date: Wed, 05 Jun 2024 10:31:16 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:cmpxchg-um.2024.05.30b] BUILD SUCCESS
 81ba375d0c523cc3c730fc1077815d4e45b51ee3
Message-ID: <202406051013.t0WH5LkC-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git cmpxchg-um.2024.05.30b
branch HEAD: 81ba375d0c523cc3c730fc1077815d4e45b51ee3  um: Emulate one-byte cmpxchg

elapsed time: 1476m

configs tested: 187
configs skipped: 112

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
arc                      axs103_smp_defconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240604   gcc  
arc                   randconfig-001-20240605   gcc  
arc                   randconfig-002-20240604   gcc  
arc                   randconfig-002-20240605   gcc  
arm                   randconfig-002-20240604   gcc  
arm                   randconfig-004-20240604   gcc  
arm                   randconfig-004-20240605   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   clang
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240605   gcc  
arm64                 randconfig-002-20240604   gcc  
arm64                 randconfig-003-20240604   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240604   gcc  
csky                  randconfig-001-20240605   gcc  
csky                  randconfig-002-20240604   gcc  
csky                  randconfig-002-20240605   gcc  
hexagon                          allmodconfig   clang
hexagon                          allyesconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-002-20240604   clang
i386         buildonly-randconfig-003-20240604   clang
i386         buildonly-randconfig-005-20240604   clang
i386         buildonly-randconfig-006-20240604   clang
i386                  randconfig-001-20240604   clang
i386                  randconfig-002-20240604   clang
i386                  randconfig-003-20240604   clang
i386                  randconfig-004-20240604   clang
i386                  randconfig-011-20240604   clang
i386                  randconfig-014-20240604   clang
i386                  randconfig-015-20240604   clang
i386                  randconfig-016-20240604   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240604   gcc  
loongarch             randconfig-001-20240605   gcc  
loongarch             randconfig-002-20240604   gcc  
loongarch             randconfig-002-20240605   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          amiga_defconfig   gcc  
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
nios2                 randconfig-001-20240604   gcc  
nios2                 randconfig-001-20240605   gcc  
nios2                 randconfig-002-20240604   gcc  
nios2                 randconfig-002-20240605   gcc  
openrisc                          allnoconfig   gcc  
openrisc                            defconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-32bit_defconfig   gcc  
parisc                randconfig-001-20240604   gcc  
parisc                randconfig-001-20240605   gcc  
parisc                randconfig-002-20240604   gcc  
parisc                randconfig-002-20240605   gcc  
parisc64                         alldefconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20240604   gcc  
powerpc               randconfig-001-20240605   gcc  
powerpc               randconfig-002-20240604   gcc  
powerpc               randconfig-002-20240605   gcc  
powerpc               randconfig-003-20240604   gcc  
powerpc               randconfig-003-20240605   gcc  
powerpc64             randconfig-001-20240604   gcc  
powerpc64             randconfig-001-20240605   gcc  
powerpc64             randconfig-002-20240604   gcc  
powerpc64             randconfig-003-20240605   gcc  
riscv                            alldefconfig   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240605   gcc  
riscv                 randconfig-002-20240604   gcc  
riscv                 randconfig-002-20240605   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240605   gcc  
s390                  randconfig-002-20240604   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                         ecovec24_defconfig   gcc  
sh                          kfr2r09_defconfig   gcc  
sh                    randconfig-001-20240604   gcc  
sh                    randconfig-001-20240605   gcc  
sh                    randconfig-002-20240604   gcc  
sh                    randconfig-002-20240605   gcc  
sh                          rsk7264_defconfig   gcc  
sh                          rsk7269_defconfig   gcc  
sh                      rts7751r2d1_defconfig   gcc  
sh                           se7724_defconfig   gcc  
sh                   sh7724_generic_defconfig   gcc  
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
sparc64               randconfig-001-20240604   gcc  
sparc64               randconfig-001-20240605   gcc  
sparc64               randconfig-002-20240604   gcc  
sparc64               randconfig-002-20240605   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240605   gcc  
um                           x86_64_defconfig   clang
x86_64       buildonly-randconfig-001-20240604   clang
x86_64       buildonly-randconfig-001-20240605   gcc  
x86_64       buildonly-randconfig-002-20240604   clang
x86_64       buildonly-randconfig-002-20240605   gcc  
x86_64       buildonly-randconfig-003-20240605   gcc  
x86_64       buildonly-randconfig-004-20240604   clang
x86_64       buildonly-randconfig-006-20240604   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240604   clang
x86_64                randconfig-003-20240605   gcc  
x86_64                randconfig-006-20240605   gcc  
x86_64                randconfig-011-20240604   clang
x86_64                randconfig-012-20240604   clang
x86_64                randconfig-012-20240605   gcc  
x86_64                randconfig-013-20240604   clang
x86_64                randconfig-014-20240604   clang
x86_64                randconfig-014-20240605   gcc  
x86_64                randconfig-015-20240604   clang
x86_64                randconfig-016-20240604   clang
x86_64                randconfig-016-20240605   gcc  
x86_64                randconfig-071-20240604   clang
x86_64                randconfig-071-20240605   gcc  
x86_64                randconfig-073-20240605   gcc  
x86_64                randconfig-074-20240604   clang
x86_64                randconfig-074-20240605   gcc  
x86_64                randconfig-075-20240604   clang
x86_64                randconfig-075-20240605   gcc  
x86_64                randconfig-076-20240604   clang
x86_64                randconfig-076-20240605   gcc  
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                       common_defconfig   gcc  
xtensa                randconfig-001-20240604   gcc  
xtensa                randconfig-001-20240605   gcc  
xtensa                randconfig-002-20240604   gcc  
xtensa                randconfig-002-20240605   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

