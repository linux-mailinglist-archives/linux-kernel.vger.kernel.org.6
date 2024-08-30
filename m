Return-Path: <linux-kernel+bounces-308383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 553EA965C3D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 11:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84260B20628
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 09:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2228D16DEBC;
	Fri, 30 Aug 2024 09:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j3Ol0zLq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B03BA3D
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 09:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725008526; cv=none; b=exdkYyjkNZW8HmOZSQuJq0mSoStgRU/pmYFIoLv7yjATCCWOH/DGMnWW2nJ6WnPpyfvRKoEGNVUHjv7bEpSFd+eiuaf8SYtYvN632K0SqPb4AZ4JdZVypr+Xjv2rMFa9jNmx0xZKFFzK8+DDDujNNBlt+Mh8lvOqY4aghZMuIqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725008526; c=relaxed/simple;
	bh=8DztmzV3LQLLMtrO6fQkPg3OK93aMwCcntMehDDYkOw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=kFY4+6uyHtX99/OEzzBsMCq2Voa9G40tAfRJ3jxsfHOk3wDfB7M2T5UyvKVxhlB+OUy/aIQM8A7xr0DdPsCYOyN3IfWvOshEJCXFNnpv6KMSq1PSstPKy3UjdS7comYXvXvn62EsvBn3EBUGdxfjWSqwmaocUXDhWp7bjiiAC08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j3Ol0zLq; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725008525; x=1756544525;
  h=date:from:to:cc:subject:message-id;
  bh=8DztmzV3LQLLMtrO6fQkPg3OK93aMwCcntMehDDYkOw=;
  b=j3Ol0zLqlkm+M4NKVpgkdMbCY7f0vuno7sSW1w9CBEwU2GvjFJXf0pZD
   n1tKb2o0ShL9e6MmE/IhKpZAB7HqEIkEkL2+En51iRQej1EqiRcEjmUKp
   SWrDtFOYYQe4cjcvyHDBldR+HB0Bmvi1lid2vhzkndO/LW+10+771xuZd
   KkOORCAbKMyIBh/0dSzz6tEmIx9IsrCDrCgc0krrx6/HRkR1K/32+Wgn7
   6QCYoq1ZGwx+/n8NWsn03olqYzugylOHQgUGyzSaNjHaaZ5uCVKnFzarC
   JPR+OfRa5LIY6AhIAwb1EYxoH5+mSbeVDiAYF3MdLhbGkmBG9wO/h/78g
   g==;
X-CSE-ConnectionGUID: uMkEiDGqQki/GVRDUV9Geg==
X-CSE-MsgGUID: 5WVJEipCSKCRyW/8wCZnQg==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="27401999"
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600"; 
   d="scan'208";a="27401999"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 02:02:04 -0700
X-CSE-ConnectionGUID: JdflyowERu+MyD9gUXpH0Q==
X-CSE-MsgGUID: Y4UPYE4ATWaEegY2Mk5ykA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600"; 
   d="scan'208";a="63533714"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 30 Aug 2024 02:02:02 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sjxW3-0001Ig-3D;
	Fri, 30 Aug 2024 09:01:59 +0000
Date: Fri, 30 Aug 2024 17:01:52 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 a85536e1bce722cb184abbac98068217874bdd6e
Message-ID: <202408301749.P4p6NtCz-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: a85536e1bce722cb184abbac98068217874bdd6e  Merge branch into tip/master: 'x86/timers'

elapsed time: 2789m

configs tested: 111
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.3.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                     haps_hs_smp_defconfig   gcc-13.2.0
arc                            hsdk_defconfig   gcc-13.2.0
arc                   randconfig-001-20240830   gcc-13.2.0
arc                   randconfig-002-20240830   gcc-13.2.0
arc                    vdk_hs38_smp_defconfig   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-20
arm                              allyesconfig   gcc-14.1.0
arm                         axm55xx_defconfig   clang-20
arm                                 defconfig   clang-14
arm                          ixp4xx_defconfig   gcc-14.1.0
arm                         mv78xx0_defconfig   clang-20
arm                        neponset_defconfig   gcc-14.1.0
arm                   randconfig-001-20240830   gcc-14.1.0
arm                   randconfig-002-20240830   clang-20
arm                   randconfig-003-20240830   clang-20
arm                   randconfig-004-20240830   gcc-14.1.0
arm                         s5pv210_defconfig   gcc-14.1.0
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-14.1.0
arm64                 randconfig-001-20240830   clang-14
arm64                 randconfig-002-20240830   gcc-14.1.0
arm64                 randconfig-003-20240830   clang-20
arm64                 randconfig-004-20240830   clang-20
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-14.1.0
csky                  randconfig-001-20240830   gcc-14.1.0
csky                  randconfig-002-20240830   gcc-14.1.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   clang-20
hexagon                             defconfig   clang-20
hexagon               randconfig-001-20240830   clang-20
i386                             allmodconfig   gcc-12
i386                              allnoconfig   gcc-12
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240830   gcc-12
i386         buildonly-randconfig-002-20240830   gcc-12
i386         buildonly-randconfig-003-20240830   gcc-12
i386         buildonly-randconfig-004-20240830   clang-18
i386         buildonly-randconfig-005-20240830   gcc-12
i386         buildonly-randconfig-006-20240830   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240830   clang-18
i386                  randconfig-002-20240830   gcc-12
i386                  randconfig-003-20240830   gcc-12
i386                  randconfig-004-20240830   clang-18
i386                  randconfig-005-20240830   clang-18
i386                  randconfig-006-20240830   gcc-12
i386                  randconfig-011-20240830   gcc-12
i386                  randconfig-012-20240830   clang-18
i386                  randconfig-013-20240830   gcc-12
i386                  randconfig-014-20240830   gcc-12
i386                  randconfig-015-20240830   clang-18
i386                  randconfig-016-20240830   gcc-12
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                        m5407c3_defconfig   gcc-14.1.0
m68k                          sun3x_defconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
mips                      fuloong2e_defconfig   gcc-13.2.0
mips                   sb1250_swarm_defconfig   gcc-14.1.0
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
powerpc                   currituck_defconfig   clang-20
powerpc                     mpc5200_defconfig   clang-14
powerpc                 mpc837x_rdb_defconfig   gcc-14.1.0
riscv                            allmodconfig   clang-20
riscv                             allnoconfig   gcc-14.1.0
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
x86_64                              defconfig   gcc-11
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

