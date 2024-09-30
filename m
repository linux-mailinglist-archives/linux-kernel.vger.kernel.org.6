Return-Path: <linux-kernel+bounces-343255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 882A79898A6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 02:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5DAC1F220B0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 00:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CCC82119;
	Mon, 30 Sep 2024 00:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DFDdNiG8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9956915C3
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 00:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727656358; cv=none; b=QAS5eivpyLSnqfribD7WeFDbc24WEIshG4ZhH7VFvGEopwuWFX3fYT4ZO06c93Xk9wd4IuRUMC9DDe6boqU1HOFpa9YJXU/nwP+uGfANryw+B0wBAmFt4IGo59JjXE43Lu86aXZwemeRu3qSxo8EXIa62UGkpAUlCd5XA8k+BAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727656358; c=relaxed/simple;
	bh=JWYhHJWnb+W0QT6nXjFiFYImFp1gTe82S/CNjphBH5E=;
	h=Date:From:To:Cc:Subject:Message-ID; b=l5F5DmHh/POqHfOFK63jFkpgKcF2/m2V3l8363ohmWE1tCGY3HfEdUzuwlvh3nhofKWV/xrrreVq349c9Ywhjo1/z2oE/OTXaH4W17c4k7rbZPYIjioChStjJHk7IOZfmU+J6scYVxJoYa7J6zf38lbXTpAAjPBfDrfzuvv4Ifs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DFDdNiG8; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727656356; x=1759192356;
  h=date:from:to:cc:subject:message-id;
  bh=JWYhHJWnb+W0QT6nXjFiFYImFp1gTe82S/CNjphBH5E=;
  b=DFDdNiG8vYO6Px9dJpplaLTURuCK5pAK1ick0wDzOyOMM5eiWN4vbKF3
   DQKAFF4CiRWwZLBpqX9ppQ3jXGpI7rDrjOti7ePTZE+1ycA0sDbKAuC+j
   xxvtPhFsVsULxb0OLh/c6DqdbghWaszkjnsjlyKcNzh+VXTgvxnC0NpPh
   3hmE39VHnybISIgR9jL5XdQ+d5OD1WwT1rGGnGOs8ztAkeDDypXJlHRer
   LnmXt5xVpJYYcOdwC3AHjS8niuiEmu2/g+usDvuM1fJx59bHbt0GNamHb
   Yr/M8wRZKBcNc/1M9qXInRw7wtWU2iDXp0ODg9ytfirt1dVR3YxpnwEwt
   w==;
X-CSE-ConnectionGUID: EpbDR45ySNukOW3MnpfKaQ==
X-CSE-MsgGUID: 4sGHrSM+TxSgsbAWAUUEGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11210"; a="26605179"
X-IronPort-AV: E=Sophos;i="6.11,164,1725346800"; 
   d="scan'208";a="26605179"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2024 17:32:36 -0700
X-CSE-ConnectionGUID: 2GJ9rv/nT2ypq++u+I7vpQ==
X-CSE-MsgGUID: Hs0ftemQQNmCfqNYcQJXtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,164,1725346800"; 
   d="scan'208";a="73269425"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 29 Sep 2024 17:32:35 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sv4L2-000Opd-22;
	Mon, 30 Sep 2024 00:32:32 +0000
Date: Mon, 30 Sep 2024 08:32:05 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:locking/urgent] BUILD SUCCESS
 ae39e0bd150bd2739582f72ad70b5a0b15e74576
Message-ID: <202409300800.2sTu4P1g-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/urgent
branch HEAD: ae39e0bd150bd2739582f72ad70b5a0b15e74576  Merge branch 'locking/core' into locking/urgent, to pick up pending commits

elapsed time: 1037m

configs tested: 217
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-13.3.0
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                            allyesconfig    gcc-13.3.0
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-14.1.0
arc                     haps_hs_smp_defconfig    clang-20
arc                   randconfig-001-20240930    clang-15
arc                   randconfig-002-20240930    clang-15
arc                           tb10x_defconfig    clang-20
arm                              allmodconfig    clang-20
arm                              allmodconfig    gcc-14.1.0
arm                               allnoconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                              allyesconfig    gcc-14.1.0
arm                                 defconfig    gcc-14.1.0
arm                          ep93xx_defconfig    clang-20
arm                      integrator_defconfig    clang-20
arm                         orion5x_defconfig    clang-20
arm                   randconfig-001-20240930    clang-15
arm                   randconfig-002-20240930    clang-15
arm                   randconfig-003-20240930    clang-15
arm                   randconfig-004-20240930    clang-15
arm                        realview_defconfig    clang-20
arm                          sp7021_defconfig    clang-20
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
arm64                 randconfig-001-20240930    clang-15
arm64                 randconfig-002-20240930    clang-15
arm64                 randconfig-003-20240930    clang-15
arm64                 randconfig-004-20240930    clang-15
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
csky                  randconfig-001-20240930    clang-15
csky                  randconfig-002-20240930    clang-15
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
hexagon               randconfig-001-20240930    clang-15
hexagon               randconfig-002-20240930    clang-15
i386                             allmodconfig    clang-18
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-18
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-18
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20240929    clang-18
i386        buildonly-randconfig-001-20240930    clang-18
i386        buildonly-randconfig-002-20240929    clang-18
i386        buildonly-randconfig-002-20240930    clang-18
i386        buildonly-randconfig-003-20240929    clang-18
i386        buildonly-randconfig-003-20240930    clang-18
i386        buildonly-randconfig-004-20240929    clang-18
i386        buildonly-randconfig-004-20240930    clang-18
i386        buildonly-randconfig-005-20240929    clang-18
i386        buildonly-randconfig-005-20240930    clang-18
i386        buildonly-randconfig-006-20240929    clang-18
i386        buildonly-randconfig-006-20240930    clang-18
i386                                defconfig    clang-18
i386                  randconfig-001-20240929    clang-18
i386                  randconfig-001-20240930    clang-18
i386                  randconfig-002-20240929    clang-18
i386                  randconfig-002-20240930    clang-18
i386                  randconfig-003-20240929    gcc-12
i386                  randconfig-003-20240930    clang-18
i386                  randconfig-004-20240929    clang-18
i386                  randconfig-004-20240930    clang-18
i386                  randconfig-005-20240929    clang-18
i386                  randconfig-005-20240930    clang-18
i386                  randconfig-006-20240929    gcc-12
i386                  randconfig-006-20240930    clang-18
i386                  randconfig-011-20240929    gcc-11
i386                  randconfig-011-20240930    clang-18
i386                  randconfig-012-20240929    gcc-12
i386                  randconfig-012-20240930    clang-18
i386                  randconfig-013-20240929    clang-18
i386                  randconfig-013-20240930    clang-18
i386                  randconfig-014-20240929    gcc-12
i386                  randconfig-014-20240930    clang-18
i386                  randconfig-015-20240929    clang-18
i386                  randconfig-015-20240930    clang-18
i386                  randconfig-016-20240929    gcc-12
i386                  randconfig-016-20240930    clang-18
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
loongarch                 loongson3_defconfig    clang-20
loongarch             randconfig-001-20240930    clang-15
loongarch             randconfig-002-20240930    clang-15
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
m68k                          sun3x_defconfig    clang-20
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                           ci20_defconfig    clang-20
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
nios2                 randconfig-001-20240930    clang-15
nios2                 randconfig-002-20240930    clang-15
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.1.0
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.1.0
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20240930    clang-15
parisc                randconfig-002-20240930    clang-15
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.1.0
powerpc                          allyesconfig    clang-20
powerpc                          allyesconfig    gcc-14.1.0
powerpc                   bluestone_defconfig    clang-20
powerpc                      cm5200_defconfig    clang-20
powerpc                     ep8248e_defconfig    clang-20
powerpc               randconfig-001-20240930    clang-15
powerpc               randconfig-002-20240930    clang-15
powerpc               randconfig-003-20240930    clang-15
powerpc64             randconfig-001-20240930    clang-15
powerpc64             randconfig-002-20240930    clang-15
powerpc64             randconfig-003-20240930    clang-15
riscv                            allmodconfig    clang-20
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.1.0
riscv                            allyesconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20240930    clang-15
riscv                 randconfig-002-20240930    clang-15
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20240930    clang-15
s390                  randconfig-002-20240930    clang-15
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                            hp6xx_defconfig    clang-20
sh                    randconfig-001-20240930    clang-15
sh                    randconfig-002-20240930    clang-15
sh                           se7619_defconfig    clang-20
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20240930    clang-15
sparc64               randconfig-002-20240930    clang-15
um                               alldefconfig    clang-20
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    clang-20
um                             i386_defconfig    gcc-12
um                    randconfig-001-20240930    clang-15
um                    randconfig-002-20240930    clang-15
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64      buildonly-randconfig-001-20240930    gcc-11
x86_64      buildonly-randconfig-002-20240930    gcc-11
x86_64      buildonly-randconfig-003-20240930    gcc-11
x86_64      buildonly-randconfig-004-20240930    gcc-11
x86_64      buildonly-randconfig-005-20240930    gcc-11
x86_64      buildonly-randconfig-006-20240930    gcc-11
x86_64                              defconfig    clang-18
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-18
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20240930    gcc-11
x86_64                randconfig-002-20240930    gcc-11
x86_64                randconfig-003-20240930    gcc-11
x86_64                randconfig-004-20240930    gcc-11
x86_64                randconfig-005-20240930    gcc-11
x86_64                randconfig-006-20240930    gcc-11
x86_64                randconfig-011-20240930    gcc-11
x86_64                randconfig-012-20240930    gcc-11
x86_64                randconfig-013-20240930    gcc-11
x86_64                randconfig-014-20240930    gcc-11
x86_64                randconfig-015-20240930    gcc-11
x86_64                randconfig-016-20240930    gcc-11
x86_64                randconfig-071-20240930    gcc-11
x86_64                randconfig-072-20240930    gcc-11
x86_64                randconfig-073-20240930    gcc-11
x86_64                randconfig-074-20240930    gcc-11
x86_64                randconfig-075-20240930    gcc-11
x86_64                randconfig-076-20240930    gcc-11
x86_64                               rhel-8.3    gcc-12
x86_64                           rhel-8.3-bpf    clang-18
x86_64                         rhel-8.3-kunit    clang-18
x86_64                           rhel-8.3-ltp    clang-18
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0
xtensa                randconfig-001-20240930    clang-15
xtensa                randconfig-002-20240930    clang-15

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

