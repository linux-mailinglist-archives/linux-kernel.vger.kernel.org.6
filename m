Return-Path: <linux-kernel+bounces-419108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8019D6996
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 16:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFF89281919
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 15:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A24F28E0F;
	Sat, 23 Nov 2024 15:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fQRQV7SN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5282F1BC49
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 15:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732374840; cv=none; b=ltASMl64rx0wprdC965H07gWk7LEAL7UpJzyuaXbbqTX5k3RW+2aPs7HbjFXImfge1kMMRv0vKNGxmQ0Odo7vMMECDSDl1ht6tur3DQJEUsHTrJyFLOWHGhzR/HDRqTXsUB0PwkJ7YS9WqlqG+tD70bWw59EpK3dnlXrA1GNegY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732374840; c=relaxed/simple;
	bh=bNk/pTD+mO+Wutv1RMj+jPXChiMtDkwRN+LAUTJgEbE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Xs9oW0LtxsloIZ3Uh9jTWc4GzYzGAH4tc/Q0papFsufGYgt62d9R1tElxnzlANrkhvnHQRPhAoCoObbs80nN+Ce721Me5ns+Dpq/s12RX0SzJPAseZhBICu7g4Z8ojhxlAmfnexwDMCq06UeksB0PVP7J0N9uaDJSh0GNMxjRCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fQRQV7SN; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732374838; x=1763910838;
  h=date:from:to:cc:subject:message-id;
  bh=bNk/pTD+mO+Wutv1RMj+jPXChiMtDkwRN+LAUTJgEbE=;
  b=fQRQV7SNOA72ZYzjSOvYUyI795t3aPI3U+gUe/76kAzF8twPJ7UGHb6W
   SKzlE86d9TvYpVqjvQfDEzDlpD/HKuDds4bgW388Df8uTrrMBUnicmRB/
   y9X9jU0n4NSSwhHjqHX6JG92RHChFhjHQUJ1nkM4wC9wh3QBlfKPMBzQq
   jMYLpwCpeKDRoZsFjzhW4SEGqlIDaeYkMoaBAcDNR5vUU4tVcdaanpl8l
   AjqqxcsO6RXULdy4EyosA0cUr8sAVucrhhTsjxjxsHN1ztIpMcEn2Rbwr
   fUPuxpaBJVkffrkMmLKouIaoMEgp1SC4YBxTD7svpanmLCAx09TgRSydI
   w==;
X-CSE-ConnectionGUID: nHR+XO96TVCjAjH2+2uMyA==
X-CSE-MsgGUID: 3YIwwWkhR/KQAsxlfQYK8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11265"; a="32643158"
X-IronPort-AV: E=Sophos;i="6.12,179,1728975600"; 
   d="scan'208";a="32643158"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2024 07:13:58 -0800
X-CSE-ConnectionGUID: pOxUj2P3RyilE+03+DGhvA==
X-CSE-MsgGUID: Ih/tDuzeTU6xbKy+9IxLQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,179,1728975600"; 
   d="scan'208";a="91640422"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 23 Nov 2024 07:13:56 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tErpZ-0004hl-31;
	Sat, 23 Nov 2024 15:13:53 +0000
Date: Sat, 23 Nov 2024 23:13:03 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 dad0983b30438775d94bc4ad355c72152d00eb4b
Message-ID: <202411232357.GYt9rsJr-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: dad0983b30438775d94bc4ad355c72152d00eb4b  Merge branch into tip/master: 'x86/tdx'

elapsed time: 1267m

configs tested: 236
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-20
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-20
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-14.2.0
arc                   randconfig-001-20241123    gcc-13.2.0
arc                   randconfig-001-20241123    gcc-14.2.0
arc                   randconfig-002-20241123    gcc-13.2.0
arc                   randconfig-002-20241123    gcc-14.2.0
arc                           tb10x_defconfig    clang-14
arm                              allmodconfig    clang-20
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-20
arm                              allyesconfig    gcc-14.2.0
arm                                 defconfig    gcc-14.2.0
arm                          ep93xx_defconfig    clang-14
arm                   milbeaut_m10v_defconfig    clang-14
arm                   randconfig-001-20241123    gcc-14.2.0
arm                   randconfig-002-20241123    clang-20
arm                   randconfig-002-20241123    gcc-14.2.0
arm                   randconfig-003-20241123    clang-20
arm                   randconfig-003-20241123    gcc-14.2.0
arm                   randconfig-004-20241123    gcc-14.2.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20241123    clang-20
arm64                 randconfig-001-20241123    gcc-14.2.0
arm64                 randconfig-002-20241123    gcc-14.2.0
arm64                 randconfig-003-20241123    gcc-14.2.0
arm64                 randconfig-004-20241123    clang-20
arm64                 randconfig-004-20241123    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20241123    gcc-14.2.0
csky                  randconfig-002-20241123    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20241123    clang-20
hexagon               randconfig-001-20241123    gcc-14.2.0
hexagon               randconfig-002-20241123    clang-20
hexagon               randconfig-002-20241123    gcc-14.2.0
i386                             allmodconfig    clang-19
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-19
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-19
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241123    clang-19
i386        buildonly-randconfig-002-20241123    clang-19
i386        buildonly-randconfig-003-20241123    clang-19
i386        buildonly-randconfig-003-20241123    gcc-12
i386        buildonly-randconfig-004-20241123    clang-19
i386        buildonly-randconfig-005-20241123    clang-19
i386        buildonly-randconfig-006-20241123    clang-19
i386                                defconfig    clang-19
i386                  randconfig-001-20241123    clang-19
i386                  randconfig-002-20241123    clang-19
i386                  randconfig-003-20241123    clang-19
i386                  randconfig-003-20241123    gcc-12
i386                  randconfig-004-20241123    clang-19
i386                  randconfig-005-20241123    clang-19
i386                  randconfig-006-20241123    clang-19
i386                  randconfig-011-20241123    clang-19
i386                  randconfig-011-20241123    gcc-12
i386                  randconfig-012-20241123    clang-19
i386                  randconfig-013-20241123    clang-19
i386                  randconfig-013-20241123    gcc-12
i386                  randconfig-014-20241123    clang-19
i386                  randconfig-014-20241123    gcc-12
i386                  randconfig-015-20241123    clang-19
i386                  randconfig-016-20241123    clang-19
i386                  randconfig-016-20241123    gcc-12
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20241123    gcc-14.2.0
loongarch             randconfig-002-20241123    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          ath79_defconfig    clang-14
mips                           ip32_defconfig    clang-14
mips                      maltaaprp_defconfig    clang-14
mips                          rb532_defconfig    clang-14
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20241123    gcc-14.2.0
nios2                 randconfig-002-20241123    gcc-14.2.0
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20241123    gcc-14.2.0
parisc                randconfig-002-20241123    gcc-14.2.0
parisc64                            defconfig    gcc-14.2.0
powerpc                    adder875_defconfig    clang-14
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-20
powerpc                          allyesconfig    gcc-14.2.0
powerpc                      cm5200_defconfig    clang-14
powerpc                 mpc834x_itx_defconfig    clang-14
powerpc                 mpc837x_rdb_defconfig    clang-14
powerpc               randconfig-001-20241123    gcc-14.2.0
powerpc               randconfig-002-20241123    clang-20
powerpc               randconfig-002-20241123    gcc-14.2.0
powerpc               randconfig-003-20241123    clang-20
powerpc               randconfig-003-20241123    gcc-14.2.0
powerpc                     taishan_defconfig    clang-14
powerpc64             randconfig-001-20241123    gcc-14.2.0
powerpc64             randconfig-002-20241123    clang-20
powerpc64             randconfig-002-20241123    gcc-14.2.0
powerpc64             randconfig-003-20241123    clang-20
powerpc64             randconfig-003-20241123    gcc-14.2.0
riscv                            allmodconfig    clang-20
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    clang-20
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20241123    clang-20
riscv                 randconfig-001-20241123    gcc-14.2.0
riscv                 randconfig-002-20241123    gcc-14.2.0
s390                             allmodconfig    clang-20
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-20
s390                                defconfig    gcc-12
s390                  randconfig-001-20241123    gcc-14.2.0
s390                  randconfig-002-20241123    clang-20
s390                  randconfig-002-20241123    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                                  defconfig    gcc-14.2.0
sh                    randconfig-001-20241123    gcc-14.2.0
sh                    randconfig-002-20241123    gcc-14.2.0
sh                          rsk7264_defconfig    clang-14
sh                          sdk7786_defconfig    clang-14
sh                           se7705_defconfig    clang-14
sparc                            alldefconfig    clang-14
sparc                            allmodconfig    gcc-14.2.0
sparc                       sparc32_defconfig    clang-14
sparc64                             defconfig    gcc-12
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20241123    gcc-14.2.0
sparc64               randconfig-002-20241123    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                               allyesconfig    gcc-12
um                                  defconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241123    clang-20
um                    randconfig-001-20241123    gcc-14.2.0
um                    randconfig-002-20241123    clang-20
um                    randconfig-002-20241123    gcc-14.2.0
um                           x86_64_defconfig    clang-15
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241123    gcc-12
x86_64      buildonly-randconfig-002-20241123    gcc-12
x86_64      buildonly-randconfig-003-20241123    gcc-11
x86_64      buildonly-randconfig-003-20241123    gcc-12
x86_64      buildonly-randconfig-004-20241123    gcc-12
x86_64      buildonly-randconfig-005-20241123    gcc-12
x86_64      buildonly-randconfig-006-20241123    clang-19
x86_64      buildonly-randconfig-006-20241123    gcc-12
x86_64                              defconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20241123    clang-19
x86_64                randconfig-001-20241123    gcc-12
x86_64                randconfig-002-20241123    gcc-12
x86_64                randconfig-003-20241123    clang-19
x86_64                randconfig-003-20241123    gcc-12
x86_64                randconfig-004-20241123    clang-19
x86_64                randconfig-004-20241123    gcc-12
x86_64                randconfig-005-20241123    gcc-12
x86_64                randconfig-006-20241123    clang-19
x86_64                randconfig-006-20241123    gcc-12
x86_64                randconfig-011-20241123    gcc-12
x86_64                randconfig-012-20241123    clang-19
x86_64                randconfig-012-20241123    gcc-12
x86_64                randconfig-013-20241123    gcc-12
x86_64                randconfig-014-20241123    clang-19
x86_64                randconfig-014-20241123    gcc-12
x86_64                randconfig-015-20241123    clang-19
x86_64                randconfig-015-20241123    gcc-12
x86_64                randconfig-016-20241123    gcc-12
x86_64                randconfig-071-20241123    clang-19
x86_64                randconfig-071-20241123    gcc-12
x86_64                randconfig-072-20241123    clang-19
x86_64                randconfig-072-20241123    gcc-12
x86_64                randconfig-073-20241123    gcc-12
x86_64                randconfig-074-20241123    clang-19
x86_64                randconfig-074-20241123    gcc-12
x86_64                randconfig-075-20241123    gcc-11
x86_64                randconfig-075-20241123    gcc-12
x86_64                randconfig-076-20241123    clang-19
x86_64                randconfig-076-20241123    gcc-12
x86_64                               rhel-9.4    clang-19
x86_64                               rhel-9.4    gcc-12
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20241123    gcc-14.2.0
xtensa                randconfig-002-20241123    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

