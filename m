Return-Path: <linux-kernel+bounces-324067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 277C297478B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 02:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BDBF1C256AA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 00:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D83125DB;
	Wed, 11 Sep 2024 00:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YImhK7Ss"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1003D7A
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 00:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726015640; cv=none; b=IcN3qlAmJYx/ZFcgCoQII6RoXDmTh8KTr9NTXyQ65qWoEXWQPUq5LfqvA5Dy7erLHtGddW3j7K1f7FcSLZ4X96wF51AyyO/CfwPPYqVnUZVUReyw+CF9qNDAHG6sWUMS5oKd63MGZ18vahxC0ieFqnKBZSK8cxJ2YyAC1Ba8c6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726015640; c=relaxed/simple;
	bh=gS3ZxyAm+hyBT0ht4BjhvcwNhHhJsvyMv62jjgyUvR0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=cojcGdxwJyKURO0L6JlNvdO02bFpHotN6e8HCsgZ61QYZHxNDe1D/H+kvBsqNaJ8yMNQ50rVP48vECPNpcvgVVaCTkr9IWYSV2XV9TaZz4qdO7cn5nuICOwhP4yRnKs8fcCMHjKwQXPdjS8d4upIN5fiUt9NLf6j5Tr+H6aQWxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YImhK7Ss; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726015639; x=1757551639;
  h=date:from:to:cc:subject:message-id;
  bh=gS3ZxyAm+hyBT0ht4BjhvcwNhHhJsvyMv62jjgyUvR0=;
  b=YImhK7SsX3eMKNYIoSSXzMwtx9+mqvB0B2+vff9ULuzIquoJTqOuCDtO
   kCc6JDnKrK/1TNRDJyRzZh9z+0BohOFjk9NWUjifZ4/WJBJizr1SZV7p2
   kgqjnTtaJolN95Tgzjp2lhSBMPubVQ8mSkC7gmJYcdE8fJvWYeNVrucdo
   zi8cWNrnyG1MLYDFWhwGZaoWXKD04WaBNMDUtvNGiaK/15Q3dSSrJyuAo
   2gWyqx5XGk5v64+Ef+PIQIF/k6CWreFH559q7XVAUyFJXbAAoLpmIYZ5B
   heXvMAA7l76DGdp1dN0qlCrqw+XqE95OYu3y6B+JAzEjdjfW8qtN5S732
   A==;
X-CSE-ConnectionGUID: Xy37SqD1Tf6hO8F143OdqA==
X-CSE-MsgGUID: vJgGQlOuSIG0N/iWYEWToA==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="27714526"
X-IronPort-AV: E=Sophos;i="6.10,218,1719903600"; 
   d="scan'208";a="27714526"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 17:47:19 -0700
X-CSE-ConnectionGUID: drcnZ7yGRziozlIb+wig5w==
X-CSE-MsgGUID: yC7QFZ+/Ssa/I3mnWBuo6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,218,1719903600"; 
   d="scan'208";a="67435638"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 10 Sep 2024 17:47:18 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1soBVr-0002sw-1N;
	Wed, 11 Sep 2024 00:47:15 +0000
Date: Wed, 11 Sep 2024 08:46:58 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD REGRESSION
 6cbbb91711c6b17da3802a3cf072d3311828ca33
Message-ID: <202409110855.nvi2VykL-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
branch HEAD: 6cbbb91711c6b17da3802a3cf072d3311828ca33  sched/cpufreq: Use NSEC_PER_MSEC for deadline task

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202409110611.dmyDCkoe-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

drivers/cpufreq/cppc_cpufreq.c:227:20: error: use of undeclared identifier 'NSER_PER_MSEC'
drivers/cpufreq/cppc_cpufreq.c:229:3: error: member reference base type 'long' is not a structure or union

Error/Warning ids grouped by kconfigs:

recent_errors
`-- riscv-allmodconfig
    |-- drivers-cpufreq-cppc_cpufreq.c:error:member-reference-base-type-long-is-not-a-structure-or-union
    `-- drivers-cpufreq-cppc_cpufreq.c:error:use-of-undeclared-identifier-NSER_PER_MSEC

elapsed time: 999m

configs tested: 112
configs skipped: 3

tested configs:
alpha                             allnoconfig   gcc-14.1.0
alpha                            allyesconfig   clang-20
alpha                               defconfig   gcc-14.1.0
arc                              allmodconfig   clang-20
arc                               allnoconfig   gcc-14.1.0
arc                              allyesconfig   clang-20
arc                                 defconfig   gcc-14.1.0
arm                              allmodconfig   clang-20
arm                               allnoconfig   gcc-14.1.0
arm                              allyesconfig   clang-20
arm                       aspeed_g4_defconfig   gcc-14.1.0
arm                                 defconfig   gcc-14.1.0
arm                      footbridge_defconfig   gcc-14.1.0
arm                            hisi_defconfig   gcc-14.1.0
arm                           imxrt_defconfig   gcc-14.1.0
arm                            mmp2_defconfig   gcc-14.1.0
arm                        realview_defconfig   gcc-14.1.0
arm                         s5pv210_defconfig   gcc-14.1.0
arm                       spear13xx_defconfig   gcc-14.1.0
arm64                            allmodconfig   clang-20
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-14.1.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-14.1.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   gcc-14.1.0
hexagon                          allyesconfig   clang-20
hexagon                             defconfig   gcc-14.1.0
i386                             allmodconfig   clang-18
i386                              allnoconfig   clang-18
i386                             allyesconfig   clang-18
i386         buildonly-randconfig-001-20240911   gcc-12
i386         buildonly-randconfig-002-20240911   gcc-12
i386         buildonly-randconfig-003-20240911   gcc-12
i386         buildonly-randconfig-004-20240911   gcc-12
i386         buildonly-randconfig-005-20240911   gcc-12
i386         buildonly-randconfig-006-20240911   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240911   gcc-12
i386                  randconfig-002-20240911   gcc-12
i386                  randconfig-003-20240911   gcc-12
i386                  randconfig-004-20240911   gcc-12
i386                  randconfig-005-20240911   gcc-12
i386                  randconfig-006-20240911   gcc-12
i386                  randconfig-011-20240911   gcc-12
i386                  randconfig-012-20240911   gcc-12
i386                  randconfig-013-20240911   gcc-12
i386                  randconfig-014-20240911   gcc-12
i386                  randconfig-015-20240911   gcc-12
i386                  randconfig-016-20240911   gcc-12
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                          atari_defconfig   gcc-14.1.0
m68k                                defconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
mips                           ip32_defconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-14.1.0
openrisc                          allnoconfig   clang-20
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-12
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   clang-20
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-12
parisc64                            defconfig   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   clang-20
powerpc                          allyesconfig   gcc-14.1.0
powerpc                   currituck_defconfig   gcc-14.1.0
powerpc                       maple_defconfig   gcc-14.1.0
powerpc                 mpc834x_itx_defconfig   gcc-14.1.0
powerpc                     rainier_defconfig   gcc-14.1.0
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   clang-20
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-12
s390                             allmodconfig   clang-20
s390                             allmodconfig   gcc-14.1.0
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-12
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-12
sh                          sdk7780_defconfig   gcc-14.1.0
sh                           se7206_defconfig   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-12
um                               allmodconfig   clang-20
um                                allnoconfig   clang-20
um                               allyesconfig   clang-20
um                                  defconfig   gcc-12
um                             i386_defconfig   gcc-12
um                           x86_64_defconfig   gcc-12
x86_64                           alldefconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64                              defconfig   clang-18
x86_64                                  kexec   gcc-12
x86_64                          rhel-8.3-rust   clang-18
x86_64                               rhel-8.3   gcc-12
xtensa                            allnoconfig   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

