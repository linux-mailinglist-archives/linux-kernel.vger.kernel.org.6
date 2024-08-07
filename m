Return-Path: <linux-kernel+bounces-278033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB54B94A9C4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 16:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90305287294
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 14:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA126F30E;
	Wed,  7 Aug 2024 14:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G6I8OVsM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B245914C
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 14:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723040146; cv=none; b=ATHZPLol4TLv1GoZkWH1i9OfTR2vWXVaPuTDR9/QkDqce5ji542enZ4ta4bkvGO2v23Fy8ReFGmL/LqgkLe1qc0upq3SkyYJfjT+kEpvyX0ApQahDPWOgU0WAfnL1xjF5U1LRQ9WqiwyfzJJTxWxuq/3msvHmGd4u0M+2texEDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723040146; c=relaxed/simple;
	bh=Y119Zw7CfM+Jhwm2HRhsivRhO0B3gCDeh660Fa0xanQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Gq1LPtNkkQV43srOSi2Rv+ap5iB3jiuc2vz5c/mAumzPuVmLx6wTIqBsqg0apvpaIrUe4Qa7y41bzJy0+kPqEntJFCjQ02dDq5tcxvRPItd7LCI9oHg28iNYHxjVmB+mAj0e07AncqNpswwd8akmBlRNjqx1Oj1paehhpsilPA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G6I8OVsM; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723040144; x=1754576144;
  h=date:from:to:cc:subject:message-id;
  bh=Y119Zw7CfM+Jhwm2HRhsivRhO0B3gCDeh660Fa0xanQ=;
  b=G6I8OVsMf4S6rmu/DaEithYqVbt5x5G2MysljlKys9xrQ9jxyN6/D7nC
   JCMq+sSEEVydnon+pIGG5zITq9DqK031lTIzCGCkxF3cweOA6gAA2NOiO
   KrNJGaiYlGM3Mhg+W8jglTezRRjI3aPPdHIJwLqJZ+Dpg+Gyw1HjGYR79
   B8O1GmdJX/OGXe8TrY2aOAf4d55hy88VaD/3nceXD3m31TvWCtSHXvBV7
   krIQHq8sD9qSoRQxalBMvyQQYSiWLyNKjbqJGQY5ozX9tNCyHzAXGEONg
   hLCYWYdzTCFtqh+UORdCh5R8YMWWPKjZjoXqLpVFFePDgVuYOGHVOxNwN
   A==;
X-CSE-ConnectionGUID: 3Tt2zR0AT2Wvu50usYxSzQ==
X-CSE-MsgGUID: wCfWEfzFSiSreo5FVu0+fw==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="43633916"
X-IronPort-AV: E=Sophos;i="6.09,270,1716274800"; 
   d="scan'208";a="43633916"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 07:15:43 -0700
X-CSE-ConnectionGUID: jewG/+A4TGC7jMrlJzUPow==
X-CSE-MsgGUID: Ic1pyOeMRwCjnew024BH9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,270,1716274800"; 
   d="scan'208";a="57084590"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 07 Aug 2024 07:15:41 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sbhRm-0005RT-1J;
	Wed, 07 Aug 2024 14:15:27 +0000
Date: Wed, 07 Aug 2024 22:14:35 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2024.08.05a] BUILD SUCCESS
 a8d56c8698d39983ac6c92a15549d1abe94ac520
Message-ID: <202408072233.l4Zlx079-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://github.com/paulmckrcu/linux dev.2024.08.05a
branch HEAD: a8d56c8698d39983ac6c92a15549d1abe94ac520  refscale: Constify struct ref_scale_ops

elapsed time: 756m

configs tested: 165
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
arc                         haps_hs_defconfig   gcc-13.2.0
arc                        nsim_700_defconfig   gcc-13.2.0
arc                   randconfig-001-20240807   gcc-13.2.0
arc                   randconfig-002-20240807   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-20
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                              allyesconfig   gcc-14.1.0
arm                                 defconfig   gcc-13.2.0
arm                           h3600_defconfig   gcc-13.2.0
arm                         lpc18xx_defconfig   gcc-13.2.0
arm                          pxa910_defconfig   gcc-13.2.0
arm                   randconfig-001-20240807   gcc-13.2.0
arm                   randconfig-002-20240807   gcc-13.2.0
arm                   randconfig-003-20240807   gcc-13.2.0
arm                   randconfig-004-20240807   gcc-13.2.0
arm                           sama7_defconfig   gcc-13.2.0
arm                           sunxi_defconfig   gcc-13.2.0
arm64                            allmodconfig   clang-20
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240807   gcc-13.2.0
arm64                 randconfig-002-20240807   gcc-13.2.0
arm64                 randconfig-003-20240807   gcc-13.2.0
arm64                 randconfig-004-20240807   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240807   gcc-13.2.0
csky                  randconfig-002-20240807   gcc-13.2.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   clang-20
hexagon                          allyesconfig   clang-20
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-12
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-12
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240807   clang-18
i386         buildonly-randconfig-002-20240807   clang-18
i386         buildonly-randconfig-003-20240807   clang-18
i386         buildonly-randconfig-003-20240807   gcc-12
i386         buildonly-randconfig-004-20240807   clang-18
i386         buildonly-randconfig-005-20240807   clang-18
i386         buildonly-randconfig-006-20240807   clang-18
i386         buildonly-randconfig-006-20240807   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240807   clang-18
i386                  randconfig-001-20240807   gcc-12
i386                  randconfig-002-20240807   clang-18
i386                  randconfig-003-20240807   clang-18
i386                  randconfig-004-20240807   clang-18
i386                  randconfig-005-20240807   clang-18
i386                  randconfig-006-20240807   clang-18
i386                  randconfig-011-20240807   clang-18
i386                  randconfig-012-20240807   clang-18
i386                  randconfig-013-20240807   clang-18
i386                  randconfig-014-20240807   clang-18
i386                  randconfig-015-20240807   clang-18
i386                  randconfig-016-20240807   clang-18
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240807   gcc-13.2.0
loongarch             randconfig-002-20240807   gcc-13.2.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                          amiga_defconfig   gcc-13.2.0
m68k                                defconfig   gcc-13.2.0
m68k                        m5307c3_defconfig   gcc-13.2.0
m68k                            mac_defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240807   gcc-13.2.0
nios2                 randconfig-002-20240807   gcc-13.2.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240807   gcc-13.2.0
parisc                randconfig-002-20240807   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   gcc-14.1.0
powerpc                   currituck_defconfig   gcc-13.2.0
powerpc                         ps3_defconfig   gcc-13.2.0
powerpc               randconfig-001-20240807   gcc-13.2.0
powerpc               randconfig-003-20240807   gcc-13.2.0
powerpc64             randconfig-001-20240807   gcc-13.2.0
powerpc64             randconfig-002-20240807   gcc-13.2.0
powerpc64             randconfig-003-20240807   gcc-13.2.0
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-14.1.0
riscv                 randconfig-001-20240807   gcc-13.2.0
riscv                 randconfig-002-20240807   gcc-13.2.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                             allyesconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240807   gcc-13.2.0
s390                  randconfig-002-20240807   gcc-13.2.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                    randconfig-001-20240807   gcc-13.2.0
sh                    randconfig-002-20240807   gcc-13.2.0
sh                           se7750_defconfig   gcc-13.2.0
sh                          urquell_defconfig   gcc-13.2.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240807   gcc-13.2.0
sparc64               randconfig-002-20240807   gcc-13.2.0
um                               allmodconfig   clang-20
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-12
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-13.2.0
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240807   gcc-13.2.0
um                    randconfig-002-20240807   gcc-13.2.0
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-11
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240807   gcc-13.2.0
xtensa                randconfig-002-20240807   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

