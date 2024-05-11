Return-Path: <linux-kernel+bounces-176717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B6C8C339C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 21:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFFBE281CBE
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 19:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CCBC21A19;
	Sat, 11 May 2024 19:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MuAnsKrp"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340B821104
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 19:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715457025; cv=none; b=Q+rUXdfKnhcqj4fb/B9EzcIkp6jEXys0SiNgFdC4IzL7NfM5Glswbp3Feb7NWW3joJipP86tXRovE9lD0A9wY8BcoZjQU8r4om+XFjKz8HFpheohXKc6AuOyL1OWjx+vknhRzf9cKaqkYvoGxAehjxkT4zu8GnR1m3DNVv+n9q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715457025; c=relaxed/simple;
	bh=pag5bRK0kjIK4VYsKW6M+yJpoYQ9MINgIZb4imGP3g8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=BX2aZwydjKB/zA/WF2Pm9HVUJTMjnWSEg7Btz7D+Xz5+yS0WYF+PeScTmubaNdKGHHqWA1++KBHHGbKsRi3iUsHKFO001fnS+DjyqWA60AsOXfxMtfDp0WoT4m4hqZmSleHl/agW2XjE5Vuvjak+nUWQGqPCMHebaDscAaP7mp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MuAnsKrp; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715457023; x=1746993023;
  h=date:from:to:cc:subject:message-id;
  bh=pag5bRK0kjIK4VYsKW6M+yJpoYQ9MINgIZb4imGP3g8=;
  b=MuAnsKrpih3Oitf5hqh/B9ah/T8QJvI7s/8MgFsJLQz+JfSPCa5sk1wb
   1A2wbdO6y2rr4iSsjzliAdJ0hI1F++9TA+sX+fj18ICIY/AKylNIzQi4l
   J3PS2JvwsrB39Jk7QJA9WcogFmnQJD5ONn/RmlMd+nBlcaWrq/HLvS9WK
   wwYz3JCPAw9sh1epEQxvOiwKiQOCLdcm6Pc5fq4br3299IUiUwKJ9nHB+
   auy+QTK3G1GAnMAVWlBKxEdAIBoyarm0IwsYtSGccyX3C8huHXcVyNy4+
   XO0beRoA3yGniHV61ze+IvCUcbFHqK8Jigrk/YkbWDu7h63oVY5oD3VeZ
   g==;
X-CSE-ConnectionGUID: S/ik4I7OQ2aRCp9BJkX5zQ==
X-CSE-MsgGUID: rhbTaoRwRj6ZZ+j7RiIFdw==
X-IronPort-AV: E=McAfee;i="6600,9927,11070"; a="33943439"
X-IronPort-AV: E=Sophos;i="6.08,154,1712646000"; 
   d="scan'208";a="33943439"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2024 12:50:23 -0700
X-CSE-ConnectionGUID: D4huZhNeRuuQH7ZfFXxjTA==
X-CSE-MsgGUID: 3sACEO3OTHarMDbC3uOcDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,154,1712646000"; 
   d="scan'208";a="53140808"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 11 May 2024 12:50:22 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s5sjb-0007mR-1a;
	Sat, 11 May 2024 19:50:19 +0000
Date: Sun, 12 May 2024 03:49:29 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2024.05.07a] BUILD SUCCESS
 d6b93d32f90b0c1051fbb01e73afe81a4ce0e605
Message-ID: <202405120328.cgpUH9eo-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2024.05.07a
branch HEAD: d6b93d32f90b0c1051fbb01e73afe81a4ce0e605  squash! rcu: Add rcutree.nocb_patience_delay to reduce nohz_full OS jitter

elapsed time: 1314m

configs tested: 148
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
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                             mxs_defconfig   clang
arm                            qcom_defconfig   clang
arm                        spear3xx_defconfig   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240511   gcc  
i386         buildonly-randconfig-001-20240512   gcc  
i386         buildonly-randconfig-002-20240511   clang
i386         buildonly-randconfig-003-20240511   gcc  
i386         buildonly-randconfig-003-20240512   gcc  
i386         buildonly-randconfig-004-20240511   clang
i386         buildonly-randconfig-004-20240512   gcc  
i386         buildonly-randconfig-005-20240511   gcc  
i386         buildonly-randconfig-005-20240512   gcc  
i386         buildonly-randconfig-006-20240511   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240511   gcc  
i386                  randconfig-002-20240511   clang
i386                  randconfig-003-20240511   gcc  
i386                  randconfig-004-20240511   clang
i386                  randconfig-004-20240512   gcc  
i386                  randconfig-005-20240511   gcc  
i386                  randconfig-006-20240511   gcc  
i386                  randconfig-011-20240511   clang
i386                  randconfig-011-20240512   gcc  
i386                  randconfig-012-20240511   gcc  
i386                  randconfig-013-20240511   clang
i386                  randconfig-013-20240512   gcc  
i386                  randconfig-014-20240511   clang
i386                  randconfig-015-20240511   clang
i386                  randconfig-015-20240512   gcc  
i386                  randconfig-016-20240511   gcc  
i386                  randconfig-016-20240512   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                          rb532_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                       ebony_defconfig   clang
powerpc                      obs600_defconfig   clang
powerpc                     sequoia_defconfig   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                       zfcpdump_defconfig   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
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
x86_64       buildonly-randconfig-001-20240511   gcc  
x86_64       buildonly-randconfig-002-20240511   gcc  
x86_64       buildonly-randconfig-003-20240511   gcc  
x86_64       buildonly-randconfig-004-20240511   gcc  
x86_64       buildonly-randconfig-005-20240511   clang
x86_64       buildonly-randconfig-006-20240511   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240511   clang
x86_64                randconfig-002-20240511   clang
x86_64                randconfig-003-20240511   clang
x86_64                randconfig-004-20240511   gcc  
x86_64                randconfig-005-20240511   gcc  
x86_64                randconfig-006-20240511   clang
x86_64                randconfig-011-20240511   clang
x86_64                randconfig-012-20240511   gcc  
x86_64                randconfig-013-20240511   gcc  
x86_64                randconfig-014-20240511   gcc  
x86_64                randconfig-015-20240511   gcc  
x86_64                randconfig-016-20240511   gcc  
x86_64                randconfig-071-20240511   gcc  
x86_64                randconfig-072-20240511   gcc  
x86_64                randconfig-073-20240511   clang
x86_64                randconfig-074-20240511   gcc  
x86_64                randconfig-075-20240511   gcc  
x86_64                randconfig-076-20240511   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

