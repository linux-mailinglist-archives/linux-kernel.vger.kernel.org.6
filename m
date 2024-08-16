Return-Path: <linux-kernel+bounces-290365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C0D9552C6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 23:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48B39B21A3D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 21:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916B71C57B2;
	Fri, 16 Aug 2024 21:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mB4bRZ/W"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FB31C57A2
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 21:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723845379; cv=none; b=r2Z2iP5gI0hHamEI1B1QElfKO4gQA3nqYIawUnj6P/oXImxklskBnptClvmZYJ/Bits+tHuHZ+xfVQQJQSHTX0f3d7Qx4lcgmlEke4syRldyv6kcbncfcvBicpsgF6ErPECJbKH32vi4hatcHPDraPFpX7G2QI85LjrIHLZ9KiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723845379; c=relaxed/simple;
	bh=0ChsY6jzj18i3mXydpqy0aCVoGr8Ey5BBOPY7gRGedY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=jjpQR/QjvNl1Cw6dYMv8RDFiEfijt7ZO62gPV1FXSxwztm1CXnz9E/dUE5cCbPXwbD5pCz3elIRJ6Ds+fNngOGe2mgqHgQ0PGRHQpNt3XqvOKX4IXKGFvduG+kxLRUKpyabFbJ6jSAicioN8HVHo+id8XUpEKAiSu6OLeFNjA/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mB4bRZ/W; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723845378; x=1755381378;
  h=date:from:to:cc:subject:message-id;
  bh=0ChsY6jzj18i3mXydpqy0aCVoGr8Ey5BBOPY7gRGedY=;
  b=mB4bRZ/WHR+c9p/ifY4jEC2XXAxxWJK7Q6RUUSE95PKovALEvMwWv6bG
   JVhrMdt8Ee5ClFFfYiabMfg+fQkcT/M3RWfNIUgK4neGprB0Y1gH+7pk1
   GimurbMnfFy9y4FxzP4dVOkJjExjmGCn/kiFXqT6AooPOjnrHIuK82KoT
   rtexVMrEqsuZ2zhwEZ2q9h6VOcHDDAHMjHb0gZcqblEWugkuwLzYii66D
   Ee29GirR0YvvBHc8Wizrk6+z6siaNkD2RbJcUua6fVS5F28d/c5EjIgD7
   qrP1XHyxtcnWn0QpUWVLwxyYQBKjLeCuqI2WaoNeUtpKtrme/fvutx6uT
   g==;
X-CSE-ConnectionGUID: 10vdu/TFTdS+J4bfCOSlBA==
X-CSE-MsgGUID: ALnru/gSQN2cUDbZigKrxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="13062486"
X-IronPort-AV: E=Sophos;i="6.10,153,1719903600"; 
   d="scan'208";a="13062486"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 14:56:17 -0700
X-CSE-ConnectionGUID: KzcciOeeQWyfnTmzDBJjIg==
X-CSE-MsgGUID: YWEcUySMQNKcWebTyx2hyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,153,1719903600"; 
   d="scan'208";a="63967140"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 16 Aug 2024 14:56:16 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sf4ve-0006xR-0D;
	Fri, 16 Aug 2024 21:56:14 +0000
Date: Sat, 17 Aug 2024 05:55:58 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/wfamnae-next20240815] BUILD SUCCESS
 e62e44883c682ebd24d89c91b6928b8df18df1a5
Message-ID: <202408170556.0eaBmWDr-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/wfamnae-next20240815
branch HEAD: e62e44883c682ebd24d89c91b6928b8df18df1a5  integrity: Use static_assert() to check struct sizes

elapsed time: 1288m

configs tested: 206
configs skipped: 19

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
arc                   randconfig-001-20240816   gcc-13.2.0
arc                   randconfig-002-20240816   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-20
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                              allyesconfig   gcc-14.1.0
arm                          ixp4xx_defconfig   gcc-14.1.0
arm                   randconfig-001-20240816   gcc-13.2.0
arm                   randconfig-002-20240816   gcc-13.2.0
arm                   randconfig-003-20240816   gcc-13.2.0
arm                        realview_defconfig   clang-20
arm                             rpc_defconfig   clang-20
arm                           tegra_defconfig   clang-20
arm                           tegra_defconfig   gcc-14.1.0
arm                    vt8500_v6_v7_defconfig   gcc-14.1.0
arm64                            allmodconfig   clang-20
arm64                             allnoconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240816   gcc-13.2.0
csky                  randconfig-002-20240816   gcc-13.2.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   clang-20
hexagon                          allyesconfig   clang-20
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-12
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-12
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240816   gcc-12
i386         buildonly-randconfig-001-20240817   gcc-12
i386         buildonly-randconfig-002-20240816   gcc-12
i386         buildonly-randconfig-002-20240817   gcc-12
i386         buildonly-randconfig-003-20240816   gcc-12
i386         buildonly-randconfig-003-20240817   gcc-12
i386         buildonly-randconfig-004-20240817   gcc-12
i386         buildonly-randconfig-005-20240816   gcc-12
i386         buildonly-randconfig-005-20240817   gcc-12
i386         buildonly-randconfig-006-20240816   gcc-12
i386         buildonly-randconfig-006-20240817   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240817   gcc-12
i386                  randconfig-002-20240816   gcc-12
i386                  randconfig-002-20240817   gcc-12
i386                  randconfig-003-20240816   gcc-12
i386                  randconfig-003-20240817   gcc-12
i386                  randconfig-004-20240816   gcc-12
i386                  randconfig-005-20240817   gcc-12
i386                  randconfig-006-20240816   gcc-12
i386                  randconfig-011-20240816   gcc-12
i386                  randconfig-011-20240817   gcc-12
i386                  randconfig-012-20240816   gcc-12
i386                  randconfig-012-20240817   gcc-12
i386                  randconfig-013-20240816   gcc-12
i386                  randconfig-013-20240817   gcc-12
i386                  randconfig-014-20240816   gcc-12
i386                  randconfig-014-20240817   gcc-12
i386                  randconfig-015-20240816   gcc-12
i386                  randconfig-015-20240817   gcc-12
i386                  randconfig-016-20240816   gcc-12
i386                  randconfig-016-20240817   gcc-12
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240816   gcc-13.2.0
loongarch             randconfig-002-20240816   gcc-13.2.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
m68k                            mac_defconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-14.1.0
mips                           ci20_defconfig   gcc-14.1.0
mips                           ip22_defconfig   gcc-14.1.0
mips                      maltaaprp_defconfig   clang-20
mips                           mtx1_defconfig   gcc-14.1.0
mips                        omega2p_defconfig   gcc-14.1.0
nios2                            alldefconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240816   gcc-13.2.0
nios2                 randconfig-002-20240816   gcc-13.2.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240816   gcc-13.2.0
parisc                randconfig-002-20240816   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-20
powerpc                          allyesconfig   gcc-14.1.0
powerpc                     asp8347_defconfig   clang-20
powerpc                   bluestone_defconfig   gcc-14.1.0
powerpc                       eiger_defconfig   clang-20
powerpc                    gamecube_defconfig   gcc-14.1.0
powerpc                        icon_defconfig   clang-20
powerpc                      pcm030_defconfig   gcc-14.1.0
powerpc               randconfig-002-20240816   gcc-13.2.0
powerpc                     tqm5200_defconfig   gcc-14.1.0
powerpc                        warp_defconfig   gcc-14.1.0
powerpc64             randconfig-001-20240816   gcc-13.2.0
powerpc64             randconfig-002-20240816   gcc-13.2.0
powerpc64             randconfig-003-20240816   gcc-13.2.0
riscv                            allmodconfig   clang-20
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-20
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-14.1.0
riscv                 randconfig-001-20240816   gcc-13.2.0
riscv                 randconfig-002-20240816   gcc-13.2.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240816   gcc-13.2.0
s390                  randconfig-002-20240816   gcc-13.2.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                    randconfig-001-20240816   gcc-13.2.0
sh                    randconfig-002-20240816   gcc-13.2.0
sh                   sh7770_generic_defconfig   gcc-14.1.0
sh                        sh7785lcr_defconfig   gcc-14.1.0
sh                             shx3_defconfig   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240816   gcc-13.2.0
sparc64               randconfig-002-20240816   gcc-13.2.0
um                               allmodconfig   clang-20
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-12
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240816   gcc-13.2.0
um                    randconfig-002-20240816   gcc-13.2.0
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240816   clang-18
x86_64       buildonly-randconfig-002-20240816   clang-18
x86_64       buildonly-randconfig-003-20240816   clang-18
x86_64       buildonly-randconfig-004-20240816   clang-18
x86_64       buildonly-randconfig-005-20240816   clang-18
x86_64       buildonly-randconfig-006-20240816   clang-18
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-11
x86_64                                  kexec   clang-18
x86_64                randconfig-001-20240816   clang-18
x86_64                randconfig-002-20240816   clang-18
x86_64                randconfig-003-20240816   clang-18
x86_64                randconfig-004-20240816   clang-18
x86_64                randconfig-005-20240816   clang-18
x86_64                randconfig-006-20240816   clang-18
x86_64                randconfig-011-20240816   clang-18
x86_64                randconfig-012-20240816   clang-18
x86_64                randconfig-013-20240816   clang-18
x86_64                randconfig-014-20240816   clang-18
x86_64                randconfig-015-20240816   clang-18
x86_64                randconfig-016-20240816   clang-18
x86_64                randconfig-071-20240816   clang-18
x86_64                randconfig-072-20240816   clang-18
x86_64                randconfig-073-20240816   clang-18
x86_64                randconfig-074-20240816   clang-18
x86_64                randconfig-075-20240816   clang-18
x86_64                randconfig-076-20240816   clang-18
x86_64                          rhel-8.3-rust   clang-18
x86_64                               rhel-8.3   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240816   gcc-13.2.0
xtensa                randconfig-002-20240816   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

