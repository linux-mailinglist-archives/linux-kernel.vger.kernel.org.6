Return-Path: <linux-kernel+bounces-203046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 391BF8FD58D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 20:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0908289E8C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 18:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8157713BC3F;
	Wed,  5 Jun 2024 18:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lIF+tik2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717EB13A897
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 18:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717611149; cv=none; b=sH4JVCt9GZpl3NRrcACtvbaWiauvplusq9LgaZixIWd1wP/YFacmCIDzW/YWSXA9Vvnh18cnUIuHRkwIOdWZjkxgaY4rGg496OQFTZFlMP+2ZJUqGu/Ak5i1NG2j6AK9f2zqI5yqPW3G8pRF9LMNPseH9ZJw2YeA0c7zAY0K1Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717611149; c=relaxed/simple;
	bh=NzkrDmVuRAlOm+LxzD8+YdcP4zRpVWrujiZa7F9ydM8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=EAQAfbONip6uTZGqLk3C6A+POgxE79s+Sv8apYb3Ns/roWIdkG7a8LKYwb/lMTRv8K0iHCQPJbUTo8OkSuUWo+FvYsefQ/6z12MaEJyZvq0rFyclZIS1boFjlNAANOLyzQ+Cdjt1tV3SNl7F03LenJ6htAGbXD+oZf3xZxo+4JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lIF+tik2; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717611148; x=1749147148;
  h=date:from:to:cc:subject:message-id;
  bh=NzkrDmVuRAlOm+LxzD8+YdcP4zRpVWrujiZa7F9ydM8=;
  b=lIF+tik2PX/AoW09e0QYvQrx3KPzYA84faJw5hZevncsKjc49BxoXPI/
   /N5R/x1oJuJoSMvw0Iiv8aXPxbGgojmqeV0QVdAiN/vYXe6B6V46qfuEo
   fQp+esKRWSfn6b9gvku9tHQAEaFXouGo6abAZklwr016vpCIb7F/yGADx
   hFskyy1XDy2vaDvyVJalUv5PNkx+lX4bN5iGW0czeYnTaUYLCKg2Zoce8
   0lwmP7nzQPcFTgyMwDLxdwWAVrnyNF9isvkWDpBUJcdeExRZxj/K2J9FA
   XebdWdS+tnQOceKNg0192xy1elsrsNkj7/bITx69aiBIG85D8nvE8Hdvr
   A==;
X-CSE-ConnectionGUID: 0mu5LkF2QyyVb7yLG694jQ==
X-CSE-MsgGUID: aqjz7Ip2RRGNbujk73kB+A==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="14395393"
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="14395393"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 11:12:28 -0700
X-CSE-ConnectionGUID: TgtFba+1Syu1+lrTr25usQ==
X-CSE-MsgGUID: i8fpm3TWTpyI0KhH15cqZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="37692518"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 05 Jun 2024 11:12:26 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sEv7X-00022I-2x;
	Wed, 05 Jun 2024 18:12:23 +0000
Date: Thu, 06 Jun 2024 02:11:57 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:non-rcu/next] BUILD SUCCESS
 ded6b7eb9d46e28671b45469f8fd655fa153221d
Message-ID: <202406060253.VtxuBtvS-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git non-rcu/next
branch HEAD: ded6b7eb9d46e28671b45469f8fd655fa153221d  Merge branches 'cmpxchg.2024.06.03a', 'kcsan.2024.05.30b', 'lkmm.2024.05.30b', 'torture.2024.05.30b' and 'tsc.2024.05.27a' into HEAD

elapsed time: 1476m

configs tested: 162
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
arc                   randconfig-001-20240605   gcc  
arc                   randconfig-002-20240605   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240605   clang
arm                   randconfig-002-20240605   clang
arm                   randconfig-003-20240605   clang
arm                   randconfig-004-20240605   gcc  
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240605   gcc  
arm64                 randconfig-002-20240605   clang
arm64                 randconfig-003-20240605   clang
arm64                 randconfig-004-20240605   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240605   gcc  
csky                  randconfig-002-20240605   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240605   clang
hexagon               randconfig-002-20240605   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240605   gcc  
i386         buildonly-randconfig-002-20240605   gcc  
i386         buildonly-randconfig-003-20240605   gcc  
i386         buildonly-randconfig-004-20240605   gcc  
i386         buildonly-randconfig-005-20240605   gcc  
i386         buildonly-randconfig-006-20240605   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240605   gcc  
i386                  randconfig-002-20240605   clang
i386                  randconfig-003-20240605   gcc  
i386                  randconfig-004-20240605   gcc  
i386                  randconfig-005-20240605   gcc  
i386                  randconfig-006-20240605   gcc  
i386                  randconfig-011-20240605   gcc  
i386                  randconfig-012-20240605   gcc  
i386                  randconfig-013-20240605   clang
i386                  randconfig-014-20240605   clang
i386                  randconfig-015-20240605   gcc  
i386                  randconfig-016-20240605   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240605   gcc  
loongarch             randconfig-002-20240605   gcc  
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
nios2                 randconfig-001-20240605   gcc  
nios2                 randconfig-002-20240605   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240605   gcc  
parisc                randconfig-002-20240605   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20240605   gcc  
powerpc               randconfig-002-20240605   gcc  
powerpc               randconfig-003-20240605   gcc  
powerpc64             randconfig-001-20240605   gcc  
powerpc64             randconfig-002-20240605   clang
powerpc64             randconfig-003-20240605   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240605   gcc  
riscv                 randconfig-002-20240605   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240605   gcc  
s390                  randconfig-002-20240605   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240605   gcc  
sh                    randconfig-002-20240605   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240605   gcc  
sparc64               randconfig-002-20240605   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240605   gcc  
um                    randconfig-002-20240605   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240605   gcc  
x86_64       buildonly-randconfig-002-20240605   gcc  
x86_64       buildonly-randconfig-003-20240605   gcc  
x86_64       buildonly-randconfig-004-20240605   clang
x86_64       buildonly-randconfig-005-20240605   clang
x86_64       buildonly-randconfig-006-20240605   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240605   clang
x86_64                randconfig-002-20240605   clang
x86_64                randconfig-003-20240605   gcc  
x86_64                randconfig-004-20240605   clang
x86_64                randconfig-005-20240605   clang
x86_64                randconfig-006-20240605   gcc  
x86_64                randconfig-011-20240605   clang
x86_64                randconfig-012-20240605   gcc  
x86_64                randconfig-013-20240605   clang
x86_64                randconfig-014-20240605   gcc  
x86_64                randconfig-015-20240605   clang
x86_64                randconfig-016-20240605   gcc  
x86_64                randconfig-071-20240605   gcc  
x86_64                randconfig-072-20240605   clang
x86_64                randconfig-073-20240605   gcc  
x86_64                randconfig-074-20240605   gcc  
x86_64                randconfig-075-20240605   gcc  
x86_64                randconfig-076-20240605   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240605   gcc  
xtensa                randconfig-002-20240605   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

