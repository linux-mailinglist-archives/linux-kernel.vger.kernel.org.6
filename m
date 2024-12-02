Return-Path: <linux-kernel+bounces-428502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4B09E0F64
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 00:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CFE116543D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 23:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9EA1DF991;
	Mon,  2 Dec 2024 23:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AAeeCbhD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C8E61FD7
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 23:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733183362; cv=none; b=ZZJZJplxrPCFx0Du+nW7U8GhPetei7uCpBYjrSVma7TM4vPI+RBCtwElVLn1Hg05xM4LzHU9i5zuumYYEVxTX6g4o6d0eneEZqEC4vZP+0TEsT1U0M8DhQYX8CSzaPgTfR3kMpns6Chaqo8KDKJA0Uv8A5HvSxbd3BqkWXdIIwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733183362; c=relaxed/simple;
	bh=12u/pf6Zrt1QjGUOjMD+J7h4LgpOwnnr4KsAxPrRux4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=TShmJ3hpd/8Ugpqb+fPZoABsvV4EtGe452osajNbgDLpJuqrv4Oml7Nh8eBR1Gi+rZ7NM4k4nrbss0OSv9BxSGLCDhJXmDAsn3oyCuqEwJV5AggAXUloWjFIL1+aCuVg4u0GDtHPiHKl71b31KBHFd82hmqaAhlbenSxrmkYwl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AAeeCbhD; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733183360; x=1764719360;
  h=date:from:to:cc:subject:message-id;
  bh=12u/pf6Zrt1QjGUOjMD+J7h4LgpOwnnr4KsAxPrRux4=;
  b=AAeeCbhDLW3i3dKjf4yf0LNkXFGCMOiHWhFEkPFp4oW5lNdQLbJSqfHq
   DHjcQk3BGS2JnYXKv4vyy21jYp2+myKkqNvsen428LVmdgHlqAEQWw1OA
   NMLM5t01tR69FmoswxaMX3w1ZohCWpQzdul+5hxNPSzIaSlX5csrG5V1T
   kBkw6TNp1ANEOy/drbSj4SGJE2r4QgT7KeIw18SZuGr9xvsW8fRWbi0+9
   KF3h7oMyiUe0P/RJSfK0JuTSQTr+sSpnGJrUYmYpJqPw2Hnq6j/q/Pz2X
   VCjPjyI5bbkWxJeNkZaIExlcYn6Y62gzBh6SrbpID5GBIha9AAqAf74gc
   A==;
X-CSE-ConnectionGUID: O3GifluOTJS/+ODkZaJXaQ==
X-CSE-MsgGUID: LWkiu8YbSfGyEE+RWQ7VMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="33293262"
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="33293262"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 15:49:20 -0800
X-CSE-ConnectionGUID: Vore8pEGT+Wy4MeGBnibxQ==
X-CSE-MsgGUID: P/q8farMQm2gACkMqiaqww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="130718268"
Received: from lkp-server02.sh.intel.com (HELO 36a1563c48ff) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 02 Dec 2024 15:49:18 -0800
Received: from kbuild by 36a1563c48ff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tIGAF-00031h-2p;
	Mon, 02 Dec 2024 23:49:15 +0000
Date: Tue, 03 Dec 2024 07:46:01 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:perf/urgent] BUILD SUCCESS
 9f3de72a0c37005f897d69e4bdd59c25b8898447
Message-ID: <202412030751.hiO14T7Z-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/urgent
branch HEAD: 9f3de72a0c37005f897d69e4bdd59c25b8898447  perf/x86/intel/ds: Unconditionally drain PEBS DS when changing PEBS_DATA_CFG

elapsed time: 723m

configs tested: 155
configs skipped: 95

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-20
arc                   randconfig-001-20241202    gcc-14.2.0
arc                   randconfig-001-20241203    clang-20
arc                   randconfig-002-20241202    gcc-14.2.0
arc                   randconfig-002-20241203    clang-20
arc                        vdk_hs38_defconfig    clang-14
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-20
arm                         at91_dt_defconfig    gcc-14.2.0
arm                        keystone_defconfig    clang-20
arm                            mps2_defconfig    clang-20
arm                         mv78xx0_defconfig    gcc-14.2.0
arm                          pxa168_defconfig    clang-20
arm                          pxa3xx_defconfig    clang-20
arm                   randconfig-001-20241202    gcc-14.2.0
arm                   randconfig-001-20241203    clang-20
arm                   randconfig-002-20241202    gcc-14.2.0
arm                   randconfig-002-20241203    clang-20
arm                   randconfig-003-20241202    gcc-14.2.0
arm                   randconfig-003-20241203    clang-20
arm                   randconfig-004-20241202    gcc-14.2.0
arm                   randconfig-004-20241203    clang-20
arm                         s5pv210_defconfig    clang-14
arm                         socfpga_defconfig    clang-20
arm                        spear6xx_defconfig    clang-14
arm                        spear6xx_defconfig    clang-20
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20241202    gcc-14.2.0
arm64                 randconfig-001-20241203    clang-20
arm64                 randconfig-002-20241202    gcc-14.2.0
arm64                 randconfig-002-20241203    clang-20
arm64                 randconfig-003-20241202    gcc-14.2.0
arm64                 randconfig-003-20241203    clang-20
arm64                 randconfig-004-20241202    gcc-14.2.0
arm64                 randconfig-004-20241203    clang-20
csky                             alldefconfig    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-20
i386        buildonly-randconfig-001-20241202    clang-19
i386        buildonly-randconfig-001-20241202    gcc-12
i386        buildonly-randconfig-001-20241203    clang-19
i386        buildonly-randconfig-002-20241202    clang-19
i386        buildonly-randconfig-002-20241202    gcc-12
i386        buildonly-randconfig-002-20241203    clang-19
i386        buildonly-randconfig-003-20241202    clang-19
i386        buildonly-randconfig-003-20241202    gcc-12
i386        buildonly-randconfig-003-20241203    clang-19
i386        buildonly-randconfig-004-20241202    clang-19
i386        buildonly-randconfig-004-20241203    clang-19
i386        buildonly-randconfig-005-20241202    clang-19
i386        buildonly-randconfig-005-20241203    clang-19
i386        buildonly-randconfig-006-20241202    clang-19
i386        buildonly-randconfig-006-20241203    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                 loongson3_defconfig    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                          amiga_defconfig    gcc-14.2.0
m68k                          hp300_defconfig    gcc-14.2.0
m68k                       m5275evb_defconfig    gcc-14.2.0
m68k                        m5307c3_defconfig    gcc-14.2.0
m68k                        mvme16x_defconfig    gcc-14.2.0
m68k                          sun3x_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                      mmu_defconfig    clang-14
mips                              allnoconfig    gcc-14.2.0
mips                  cavium_octeon_defconfig    gcc-14.2.0
mips                           ip28_defconfig    gcc-14.2.0
mips                        qi_lb60_defconfig    gcc-14.2.0
mips                   sb1250_swarm_defconfig    gcc-14.2.0
nios2                         10m50_defconfig    clang-14
nios2                         3c120_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
openrisc                         alldefconfig    clang-20
openrisc                         alldefconfig    gcc-14.2.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.2.0
powerpc                    amigaone_defconfig    clang-14
powerpc                      arches_defconfig    gcc-14.2.0
powerpc                   currituck_defconfig    clang-20
powerpc                       eiger_defconfig    gcc-14.2.0
powerpc                    ge_imp3a_defconfig    gcc-14.2.0
powerpc                  iss476-smp_defconfig    gcc-14.2.0
powerpc                   motionpro_defconfig    gcc-14.2.0
powerpc                 mpc8315_rdb_defconfig    gcc-14.2.0
powerpc               mpc834x_itxgp_defconfig    clang-14
powerpc                    mvme5100_defconfig    clang-14
powerpc                      pasemi_defconfig    clang-20
powerpc                      ppc6xx_defconfig    clang-14
powerpc                     tqm8541_defconfig    gcc-14.2.0
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.2.0
riscv             nommu_k210_sdcard_defconfig    gcc-14.2.0
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                        edosk7705_defconfig    gcc-14.2.0
sh                        edosk7760_defconfig    gcc-14.2.0
sh                               j2_defconfig    gcc-14.2.0
sh                          kfr2r09_defconfig    gcc-14.2.0
sh                            migor_defconfig    clang-20
sh                            migor_defconfig    gcc-14.2.0
sh                           se7619_defconfig    clang-20
sh                           se7619_defconfig    gcc-14.2.0
sh                           se7705_defconfig    clang-20
sh                           se7722_defconfig    gcc-14.2.0
sh                           se7780_defconfig    clang-14
sh                        sh7785lcr_defconfig    gcc-14.2.0
sh                              ul2_defconfig    clang-14
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20241202    clang-19
x86_64      buildonly-randconfig-001-20241203    gcc-11
x86_64      buildonly-randconfig-002-20241202    clang-19
x86_64      buildonly-randconfig-002-20241202    gcc-12
x86_64      buildonly-randconfig-002-20241203    gcc-11
x86_64      buildonly-randconfig-003-20241202    clang-19
x86_64      buildonly-randconfig-003-20241202    gcc-12
x86_64      buildonly-randconfig-003-20241203    gcc-11
x86_64      buildonly-randconfig-004-20241202    clang-19
x86_64      buildonly-randconfig-004-20241203    gcc-11
x86_64      buildonly-randconfig-005-20241202    clang-19
x86_64      buildonly-randconfig-005-20241202    gcc-12
x86_64      buildonly-randconfig-005-20241203    gcc-11
x86_64      buildonly-randconfig-006-20241202    clang-19
x86_64      buildonly-randconfig-006-20241202    gcc-12
x86_64      buildonly-randconfig-006-20241203    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                       common_defconfig    clang-20
xtensa                    smp_lx200_defconfig    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

