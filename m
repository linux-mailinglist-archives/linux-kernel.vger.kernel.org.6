Return-Path: <linux-kernel+bounces-319982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E0C9704AC
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 03:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98F36B22037
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 01:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BFAD272;
	Sun,  8 Sep 2024 01:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mU4j384p"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA79AD4B
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 01:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725759041; cv=none; b=hX6oW/gITB3XWY/nR26QuSSko/volCjc1o0DxsDn5yZfDWrXVwxo3Fk8Z6np+kTqM2B30RYIPx6P41ohg3BTLipTO5wosG14kZYQ4y/nzyBYgpN/ZFddb8MxGITRhjo0lgqA/q5BN32dvVlk609FtELBY9XKoyYIFydqprATe8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725759041; c=relaxed/simple;
	bh=EzXKv1sPzbGpYdw4cgcF23OkO4TjMTNpkOOeqd63Qa0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=c+ZHs/GuLfMH0VIxR9Pz5oI5aXlOcUrzX3EDnh+Ur0lxcC8VMG3h1HwR28fEK3MdKo0QTyV4wR/9YqJ0tG6D9CyL+RYM4YRemAIuQ0gXA6xLUZN95sFw43ghI7WRwSMk245kOwWl4+XA3KhhxQOY588Dp/vV6blVepmskoOqbwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mU4j384p; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725759040; x=1757295040;
  h=date:from:to:cc:subject:message-id;
  bh=EzXKv1sPzbGpYdw4cgcF23OkO4TjMTNpkOOeqd63Qa0=;
  b=mU4j384pmdrbjq/rqT8MlILHO75SHJp/cJorOP31ssDi6uP6CulE1leR
   WonsuywaD8HyOgQJExiZ/m5mtcHUh4YwyKM6YDDRsI3uCrvmr8LjOmZz5
   NAxMxb16Z200+zBMphQpiP8MUnWnOhszslnJBKbFJu2CQbVWx05IPSjFh
   jfEBvudLfpkLfJ5bkSv+iAJUeMr/2nuT2tbOnN5HW0QMEFeoFX+/lVGw5
   U2vBDXWzL/nLarprSJ5wikc3cerErXiz7cM/X1OHMP+Z9CGWuX3lC/1eG
   5HWgrUQFYD5FYBkQplwybulkEwchv9PQUD8tN+sNOnR//1HWJ+VXVwP87
   A==;
X-CSE-ConnectionGUID: /+YqtUy/TM2Ya2ApYKAABA==
X-CSE-MsgGUID: n9pPkZbcT1OWrZsdoPjX5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11188"; a="27403763"
X-IronPort-AV: E=Sophos;i="6.10,211,1719903600"; 
   d="scan'208";a="27403763"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2024 18:30:39 -0700
X-CSE-ConnectionGUID: GQtJdUPiQHGdk3/hIw4Vcw==
X-CSE-MsgGUID: 17zs6XjYT1exK3C2S77dlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,211,1719903600"; 
   d="scan'208";a="70724709"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 07 Sep 2024 18:30:39 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sn6lA-000DBT-0O;
	Sun, 08 Sep 2024 01:30:36 +0000
Date: Sun, 08 Sep 2024 09:30:29 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2024.09.06a] BUILD SUCCESS
 aa7cdd886c0cd9a8272eea1046c3368b34908763
Message-ID: <202409080927.8PoKNOi1-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2024.09.06a
branch HEAD: aa7cdd886c0cd9a8272eea1046c3368b34908763  srcu: Allow inlining of __srcu_read_{,un}lock_lite()

elapsed time: 2350m

configs tested: 93
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                   randconfig-001-20240908   gcc-13.2.0
arc                   randconfig-002-20240908   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-20
arm                              allyesconfig   gcc-14.1.0
arm                   randconfig-001-20240908   gcc-14.1.0
arm                   randconfig-002-20240908   clang-20
arm                   randconfig-003-20240908   clang-17
arm                   randconfig-004-20240908   clang-20
arm64                            allmodconfig   clang-20
arm64                             allnoconfig   gcc-14.1.0
arm64                 randconfig-001-20240908   clang-20
arm64                 randconfig-002-20240908   gcc-14.1.0
csky                              allnoconfig   gcc-14.1.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   clang-20
hexagon                          allyesconfig   clang-20
i386                             allmodconfig   gcc-12
i386                              allnoconfig   gcc-12
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240907   clang-18
i386         buildonly-randconfig-002-20240907   gcc-12
i386         buildonly-randconfig-003-20240907   gcc-12
i386         buildonly-randconfig-004-20240907   clang-18
i386         buildonly-randconfig-005-20240907   clang-18
i386         buildonly-randconfig-006-20240907   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240907   clang-18
i386                  randconfig-002-20240907   clang-18
i386                  randconfig-003-20240907   clang-18
i386                  randconfig-004-20240907   gcc-12
i386                  randconfig-005-20240907   gcc-12
i386                  randconfig-006-20240907   gcc-12
i386                  randconfig-011-20240907   clang-18
i386                  randconfig-012-20240907   gcc-12
i386                  randconfig-014-20240907   clang-18
i386                  randconfig-015-20240907   clang-18
i386                  randconfig-016-20240907   clang-18
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-20
riscv                            allmodconfig   clang-20
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-20
riscv                               defconfig   clang-20
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   clang-20
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
um                               allmodconfig   clang-20
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-12
um                                  defconfig   clang-20
um                             i386_defconfig   gcc-12
um                           x86_64_defconfig   clang-15
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240908   gcc-12
x86_64       buildonly-randconfig-002-20240908   gcc-12
x86_64       buildonly-randconfig-003-20240908   clang-18
x86_64       buildonly-randconfig-004-20240908   gcc-12
x86_64       buildonly-randconfig-006-20240908   clang-18
x86_64                              defconfig   gcc-11
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

