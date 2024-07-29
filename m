Return-Path: <linux-kernel+bounces-266405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A000993FF6C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 22:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 547E528467C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 20:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E4E18A92C;
	Mon, 29 Jul 2024 20:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="faY8B0AV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282EC188CB6
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 20:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722284645; cv=none; b=OFA5RBYkKpLVa63Xvc2u01XwFSeTrZ/EiynvUd9fsrI7Kw+EiRcZwfIXqvoq56vqinyQRWDs7imMbBFgWqGpLvaqcqhrirS96eestjZdHKlzruw08kx9j8XMnBZ/D0Zgju9w3fiZfMY9YXkkeu7ZfR7wmDVSH2U4p1QmVSKShbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722284645; c=relaxed/simple;
	bh=5n6kTyLxhi6froHoN8asfkFjFCiSM2H55/fDdHDrfI8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=f+n4BfRWT5JQKjuZFB8rVCNcqQdD4RoK1WHfYOvvH1nOIq7/+mrVyTlCtjhIEKP6A2J3ySJkyRYb+jHsBhskH0unZ9B9D0VrqdT29u2qkf/uiLhSzHJ0DYKGUiAzrW2mBkLOfXWvaxnMfQxG5ZuLxTb5vY/SaZ4EiQwepmlDk8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=faY8B0AV; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722284644; x=1753820644;
  h=date:from:to:cc:subject:message-id;
  bh=5n6kTyLxhi6froHoN8asfkFjFCiSM2H55/fDdHDrfI8=;
  b=faY8B0AVHhgM8u2xljii5+grAhyIdlACNgB2orDKS2C5z0YtwzwPzUtN
   YrXS0JvyZ7W6q9+E4YxWha2TEdsqTWpugPqzRz2wckgsnp0ZJrI/MGcMX
   IVnNpjIsjLHSYL/OldTyzu5bqemBbE1jYp+B99yX+SakrozWIr0J4lywQ
   //VvVzRxpcW7b7CrzEDlk7dM6VUcSshjCPFM8iwJbZIve/6f/xtaH66Fy
   tgPFGQ6LVKJoOXlrBGpnUEnLqgdvU+sOS6DUpw+i3PG0gn+V8Li9dYgc9
   P1CIFvSNoXYWNThoWPU1kUeMkm7Z0yPkR+6yU/qAX2Cs+qHIs4SlnvIhN
   A==;
X-CSE-ConnectionGUID: oaa8d0gdRQuhrplTycdTIg==
X-CSE-MsgGUID: /c54Br9cREmDreCBMEx96A==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="42589718"
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="42589718"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 13:24:03 -0700
X-CSE-ConnectionGUID: 1i3FMwcXQU6qVMIQ196s6w==
X-CSE-MsgGUID: xA/jbtPSTJCWXGgWV69QSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="58410087"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 29 Jul 2024 13:24:01 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sYWuU-000s2S-2z;
	Mon, 29 Jul 2024 20:23:58 +0000
Date: Tue, 30 Jul 2024 04:23:39 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 9735495fa893827827e8870af054c8b114f2dcd9
Message-ID: <202407300435.GdK8LREz-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 9735495fa893827827e8870af054c8b114f2dcd9  Merge branch into tip/master: 'x86/mm'

elapsed time: 747m

configs tested: 219
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                     nsimosci_hs_defconfig   gcc-13.2.0
arc                 nsimosci_hs_smp_defconfig   gcc-13.2.0
arc                   randconfig-001-20240729   gcc-13.2.0
arc                   randconfig-002-20240729   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-20
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                              allyesconfig   gcc-14.1.0
arm                                 defconfig   gcc-13.2.0
arm                      footbridge_defconfig   gcc-13.2.0
arm                       imx_v4_v5_defconfig   clang-16
arm                       imx_v4_v5_defconfig   gcc-13.2.0
arm                          ixp4xx_defconfig   gcc-13.2.0
arm                         lpc18xx_defconfig   clang-20
arm                   randconfig-001-20240729   gcc-14.1.0
arm                   randconfig-002-20240729   gcc-14.1.0
arm                   randconfig-003-20240729   gcc-14.1.0
arm                   randconfig-004-20240729   clang-20
arm                    vt8500_v6_v7_defconfig   gcc-14.1.0
arm64                            allmodconfig   clang-20
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240729   clang-17
arm64                 randconfig-002-20240729   clang-20
arm64                 randconfig-003-20240729   gcc-14.1.0
arm64                 randconfig-004-20240729   clang-20
csky                             alldefconfig   gcc-14.1.0
csky                              allnoconfig   gcc-13.2.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240729   gcc-14.1.0
csky                  randconfig-002-20240729   gcc-14.1.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   clang-20
hexagon                          allyesconfig   clang-20
hexagon               randconfig-001-20240729   clang-20
hexagon               randconfig-002-20240729   clang-20
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-13
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-13
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240729   clang-18
i386         buildonly-randconfig-002-20240729   clang-18
i386         buildonly-randconfig-002-20240729   gcc-13
i386         buildonly-randconfig-003-20240729   clang-18
i386         buildonly-randconfig-004-20240729   clang-18
i386         buildonly-randconfig-004-20240729   gcc-10
i386         buildonly-randconfig-005-20240729   clang-18
i386         buildonly-randconfig-006-20240729   clang-18
i386         buildonly-randconfig-006-20240729   gcc-8
i386                                defconfig   clang-18
i386                  randconfig-001-20240729   clang-18
i386                  randconfig-001-20240729   gcc-12
i386                  randconfig-002-20240729   clang-18
i386                  randconfig-003-20240729   clang-18
i386                  randconfig-003-20240729   gcc-10
i386                  randconfig-004-20240729   clang-18
i386                  randconfig-004-20240729   gcc-13
i386                  randconfig-005-20240729   clang-18
i386                  randconfig-005-20240729   gcc-8
i386                  randconfig-006-20240729   clang-18
i386                  randconfig-006-20240729   gcc-13
i386                  randconfig-011-20240729   clang-18
i386                  randconfig-011-20240729   gcc-13
i386                  randconfig-012-20240729   clang-18
i386                  randconfig-013-20240729   clang-18
i386                  randconfig-013-20240729   gcc-9
i386                  randconfig-014-20240729   clang-18
i386                  randconfig-015-20240729   clang-18
i386                  randconfig-015-20240729   gcc-13
i386                  randconfig-016-20240729   clang-18
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-13.2.0
loongarch                 loongson3_defconfig   gcc-14.1.0
loongarch             randconfig-001-20240729   gcc-14.1.0
loongarch             randconfig-002-20240729   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
m68k                       m5475evb_defconfig   gcc-13.2.0
m68k                            mac_defconfig   gcc-13.2.0
m68k                        mvme147_defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-14.1.0
mips                  decstation_64_defconfig   gcc-13.2.0
mips                     loongson1c_defconfig   gcc-13.2.0
mips                      malta_kvm_defconfig   gcc-13.2.0
mips                      maltasmvp_defconfig   gcc-13.2.0
mips                           xway_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240729   gcc-14.1.0
nios2                 randconfig-002-20240729   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240729   gcc-14.1.0
parisc                randconfig-002-20240729   gcc-14.1.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-20
powerpc                      cm5200_defconfig   clang-20
powerpc                  iss476-smp_defconfig   gcc-14.1.0
powerpc                      katmai_defconfig   gcc-13.2.0
powerpc                 mpc8313_rdb_defconfig   gcc-13.2.0
powerpc                 mpc8315_rdb_defconfig   gcc-13.2.0
powerpc                     ppa8548_defconfig   gcc-13.2.0
powerpc                     tqm8548_defconfig   gcc-13.2.0
powerpc64             randconfig-001-20240729   gcc-14.1.0
powerpc64             randconfig-002-20240729   gcc-14.1.0
powerpc64             randconfig-003-20240729   gcc-14.1.0
riscv                            allmodconfig   clang-20
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-20
riscv                               defconfig   clang-20
riscv                               defconfig   gcc-14.1.0
riscv             nommu_k210_sdcard_defconfig   gcc-14.1.0
riscv                 randconfig-001-20240729   clang-16
riscv                 randconfig-002-20240729   clang-20
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   clang-20
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240729   clang-20
s390                  randconfig-002-20240729   gcc-14.1.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                        edosk7705_defconfig   gcc-14.1.0
sh                               j2_defconfig   gcc-13.2.0
sh                          kfr2r09_defconfig   gcc-14.1.0
sh                          landisk_defconfig   gcc-14.1.0
sh                    randconfig-001-20240729   gcc-14.1.0
sh                    randconfig-002-20240729   gcc-14.1.0
sh                          sdk7786_defconfig   gcc-13.2.0
sh                           se7206_defconfig   gcc-13.2.0
sh                            titan_defconfig   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240729   gcc-14.1.0
sparc64               randconfig-002-20240729   gcc-14.1.0
um                               allmodconfig   clang-20
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-13
um                                  defconfig   clang-20
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-13
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240729   clang-14
um                    randconfig-002-20240729   gcc-8
um                           x86_64_defconfig   clang-15
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240729   clang-18
x86_64       buildonly-randconfig-002-20240729   gcc-13
x86_64       buildonly-randconfig-003-20240729   gcc-10
x86_64       buildonly-randconfig-004-20240729   gcc-10
x86_64       buildonly-randconfig-005-20240729   gcc-10
x86_64       buildonly-randconfig-006-20240729   gcc-10
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240729   gcc-13
x86_64                randconfig-002-20240729   clang-18
x86_64                randconfig-003-20240729   clang-18
x86_64                randconfig-004-20240729   clang-18
x86_64                randconfig-005-20240729   clang-18
x86_64                randconfig-006-20240729   clang-18
x86_64                randconfig-011-20240729   gcc-8
x86_64                randconfig-012-20240729   gcc-8
x86_64                randconfig-013-20240729   gcc-13
x86_64                randconfig-014-20240729   clang-18
x86_64                randconfig-015-20240729   gcc-13
x86_64                randconfig-016-20240729   clang-18
x86_64                randconfig-071-20240729   gcc-13
x86_64                randconfig-072-20240729   gcc-13
x86_64                randconfig-073-20240729   clang-18
x86_64                randconfig-074-20240729   gcc-8
x86_64                randconfig-075-20240729   gcc-12
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240729   gcc-14.1.0
xtensa                randconfig-002-20240729   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

