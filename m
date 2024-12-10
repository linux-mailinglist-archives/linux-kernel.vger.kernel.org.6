Return-Path: <linux-kernel+bounces-438996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADEAC9EA94B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 08:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7570281F87
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 07:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1660522B5B9;
	Tue, 10 Dec 2024 07:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V3yWCyWM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E8A2248A1
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 07:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733814602; cv=none; b=NMjTtyqbzePKk4wPUekuFStLEvEuNP8VC1IV/sYlfrBqHUUhshHicJzyWkX/VH7D2rGyJr2bBZd/2e/W1FUP0FjcRXrxZrU8JFECrDPRzDFSdDhTjCMUzFV+7PvZqp9fPlpjY+3ul3gX8v+CoSkmre4P9DcPN/vel56prvx1blY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733814602; c=relaxed/simple;
	bh=oAAWmROPEFe0Do8CfzDApOVvtm2lZhgKlZhDI1PTCVI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=kg/gSBuflfhHQ3SyCl9jDnNRSmYToYUe3RV8I0trdTKrEQstKWeXO6JgMjair/6cegBVHfALxbyi+I6r0LGVL/i720RkG5NP+vP91WS0MVOgK83y28A6BNppvr628N0NsLNQ7cuCnkOS7Ok+GOxpgjfz76p0bcAPpsGYwhDK7II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V3yWCyWM; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733814601; x=1765350601;
  h=date:from:to:cc:subject:message-id;
  bh=oAAWmROPEFe0Do8CfzDApOVvtm2lZhgKlZhDI1PTCVI=;
  b=V3yWCyWM1R3rgs9wg8B8E1uhBvyPA5DntYDtLHdU6J/zNtuAFbXFPiKD
   FP1txOLhYms8TOiGZFjellgVtHotUSaYjrxf+BvBVZZD5CvqsQ6fQSTZ3
   T938RNou8COhu/Wsy9hLTBS3yf+9sob7n5M+oQIF2jMSx8NY/yVRKA0ZC
   KXKqNmNH0fozdqZs9lqFLwZtj+k8BsCZThv3nytBAQqijjcpOdE60439u
   U0KbVft04siPkKwAzH47s2g9fRQzoFlcvTn7ais+EnipUQIGO9h1sfO78
   gViNUP+WKZvKb+6TRm4MFm/Iq35MKRmzPH4gucbbrYPGoIxEMOstbyjQm
   Q==;
X-CSE-ConnectionGUID: nGmG53iPSZ+Qx8xrrHuY6A==
X-CSE-MsgGUID: KT+pHfPXQAaEmCyf3sxOjA==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="33872905"
X-IronPort-AV: E=Sophos;i="6.12,221,1728975600"; 
   d="scan'208";a="33872905"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 23:10:00 -0800
X-CSE-ConnectionGUID: IIKUCcgpSDS7cyBI/8eQ8A==
X-CSE-MsgGUID: un2ymiepRpm0sooPiJZp/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,221,1728975600"; 
   d="scan'208";a="95512045"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 09 Dec 2024 23:09:58 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tKuNY-0005ET-0E;
	Tue, 10 Dec 2024 07:09:56 +0000
Date: Tue, 10 Dec 2024 15:09:23 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:sched/urgent] BUILD SUCCESS
 76f2f783294d7d55c2564e2dfb0a7279ba0bc264
Message-ID: <202412101516.Nq1ohCuG-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/urgent
branch HEAD: 76f2f783294d7d55c2564e2dfb0a7279ba0bc264  sched/eevdf: More PELT vs DELAYED_DEQUEUE

elapsed time: 1193m

configs tested: 255
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-18
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    clang-18
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-14.2.0
arc                   randconfig-001-20241209    gcc-13.2.0
arc                   randconfig-001-20241210    gcc-14.2.0
arc                   randconfig-002-20241209    gcc-13.2.0
arc                   randconfig-002-20241210    gcc-14.2.0
arm                              allmodconfig    clang-18
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    clang-18
arm                              allyesconfig    gcc-14.2.0
arm                         bcm2835_defconfig    clang-16
arm                                 defconfig    gcc-14.2.0
arm                           omap1_defconfig    clang-16
arm                          pxa3xx_defconfig    clang-16
arm                   randconfig-001-20241209    clang-20
arm                   randconfig-001-20241210    gcc-14.2.0
arm                   randconfig-002-20241209    clang-20
arm                   randconfig-002-20241210    gcc-14.2.0
arm                   randconfig-003-20241209    clang-20
arm                   randconfig-003-20241210    gcc-14.2.0
arm                   randconfig-004-20241209    clang-20
arm                   randconfig-004-20241210    gcc-14.2.0
arm                           u8500_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20241209    gcc-14.2.0
arm64                 randconfig-001-20241210    gcc-14.2.0
arm64                 randconfig-002-20241209    clang-20
arm64                 randconfig-002-20241210    gcc-14.2.0
arm64                 randconfig-003-20241209    clang-19
arm64                 randconfig-003-20241210    gcc-14.2.0
arm64                 randconfig-004-20241209    gcc-14.2.0
arm64                 randconfig-004-20241210    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20241209    gcc-14.2.0
csky                  randconfig-001-20241210    gcc-14.2.0
csky                  randconfig-002-20241209    gcc-14.2.0
csky                  randconfig-002-20241210    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20241209    clang-16
hexagon               randconfig-001-20241210    gcc-14.2.0
hexagon               randconfig-002-20241209    clang-20
hexagon               randconfig-002-20241210    gcc-14.2.0
i386                             allmodconfig    clang-19
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-19
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-19
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241209    clang-19
i386        buildonly-randconfig-001-20241210    gcc-12
i386        buildonly-randconfig-002-20241209    clang-19
i386        buildonly-randconfig-002-20241210    gcc-12
i386        buildonly-randconfig-003-20241209    clang-19
i386        buildonly-randconfig-003-20241210    gcc-12
i386        buildonly-randconfig-004-20241209    clang-19
i386        buildonly-randconfig-004-20241210    gcc-12
i386        buildonly-randconfig-005-20241209    clang-19
i386        buildonly-randconfig-005-20241210    gcc-12
i386        buildonly-randconfig-006-20241209    clang-19
i386        buildonly-randconfig-006-20241210    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20241210    clang-19
i386                  randconfig-002-20241210    clang-19
i386                  randconfig-003-20241210    clang-19
i386                  randconfig-004-20241210    clang-19
i386                  randconfig-005-20241210    clang-19
i386                  randconfig-006-20241210    clang-19
i386                  randconfig-007-20241210    clang-19
i386                  randconfig-011-20241210    clang-19
i386                  randconfig-012-20241210    clang-19
i386                  randconfig-013-20241210    clang-19
i386                  randconfig-014-20241210    clang-19
i386                  randconfig-015-20241210    clang-19
i386                  randconfig-016-20241210    clang-19
i386                  randconfig-017-20241210    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20241209    gcc-14.2.0
loongarch             randconfig-001-20241210    gcc-14.2.0
loongarch             randconfig-002-20241209    gcc-14.2.0
loongarch             randconfig-002-20241210    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                       m5275evb_defconfig    gcc-14.2.0
m68k                       m5475evb_defconfig    gcc-14.2.0
m68k                        stmark2_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                         db1xxx_defconfig    clang-16
mips                           gcw0_defconfig    clang-15
mips                           ip30_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20241209    gcc-14.2.0
nios2                 randconfig-001-20241210    gcc-14.2.0
nios2                 randconfig-002-20241209    gcc-14.2.0
nios2                 randconfig-002-20241210    gcc-14.2.0
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
parisc                randconfig-001-20241209    gcc-14.2.0
parisc                randconfig-001-20241210    gcc-14.2.0
parisc                randconfig-002-20241209    gcc-14.2.0
parisc                randconfig-002-20241210    gcc-14.2.0
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                   bluestone_defconfig    clang-20
powerpc                    ge_imp3a_defconfig    gcc-14.2.0
powerpc                  iss476-smp_defconfig    gcc-14.2.0
powerpc                   lite5200b_defconfig    clang-16
powerpc                   motionpro_defconfig    clang-16
powerpc                     mpc83xx_defconfig    gcc-14.2.0
powerpc                      pmac32_defconfig    gcc-14.2.0
powerpc               randconfig-001-20241209    gcc-14.2.0
powerpc               randconfig-001-20241210    gcc-14.2.0
powerpc               randconfig-002-20241209    clang-15
powerpc               randconfig-002-20241210    gcc-14.2.0
powerpc               randconfig-003-20241209    clang-17
powerpc               randconfig-003-20241210    gcc-14.2.0
powerpc64             randconfig-001-20241209    gcc-14.2.0
powerpc64             randconfig-001-20241210    gcc-14.2.0
powerpc64             randconfig-002-20241209    clang-17
powerpc64             randconfig-002-20241210    gcc-14.2.0
powerpc64             randconfig-003-20241209    clang-20
powerpc64             randconfig-003-20241210    gcc-14.2.0
riscv                            alldefconfig    clang-16
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                               defconfig    clang-19
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20241209    clang-19
riscv                 randconfig-001-20241210    gcc-14.2.0
riscv                 randconfig-002-20241209    clang-20
riscv                 randconfig-002-20241210    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                                defconfig    gcc-12
s390                  randconfig-001-20241209    clang-16
s390                  randconfig-001-20241210    gcc-14.2.0
s390                  randconfig-002-20241209    gcc-14.2.0
s390                  randconfig-002-20241210    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                                  defconfig    gcc-14.2.0
sh                    randconfig-001-20241209    gcc-14.2.0
sh                    randconfig-001-20241210    gcc-14.2.0
sh                    randconfig-002-20241209    gcc-14.2.0
sh                    randconfig-002-20241210    gcc-14.2.0
sh                   rts7751r2dplus_defconfig    gcc-14.2.0
sh                        sh7757lcr_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20241209    gcc-14.2.0
sparc                 randconfig-001-20241210    gcc-14.2.0
sparc                 randconfig-002-20241209    gcc-14.2.0
sparc                 randconfig-002-20241210    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20241209    gcc-14.2.0
sparc64               randconfig-001-20241210    gcc-14.2.0
sparc64               randconfig-002-20241209    gcc-14.2.0
sparc64               randconfig-002-20241210    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-18
um                                allnoconfig    clang-20
um                               allyesconfig    gcc-12
um                                  defconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241209    clang-19
um                    randconfig-001-20241210    gcc-14.2.0
um                    randconfig-002-20241209    gcc-12
um                    randconfig-002-20241210    gcc-14.2.0
um                           x86_64_defconfig    clang-15
um                           x86_64_defconfig    gcc-12
um                           x86_64_defconfig    gcc-14.2.0
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241209    gcc-12
x86_64      buildonly-randconfig-001-20241210    clang-19
x86_64      buildonly-randconfig-002-20241209    gcc-12
x86_64      buildonly-randconfig-002-20241210    clang-19
x86_64      buildonly-randconfig-003-20241209    clang-19
x86_64      buildonly-randconfig-003-20241210    clang-19
x86_64      buildonly-randconfig-004-20241209    gcc-12
x86_64      buildonly-randconfig-004-20241210    clang-19
x86_64      buildonly-randconfig-005-20241209    clang-19
x86_64      buildonly-randconfig-005-20241210    clang-19
x86_64      buildonly-randconfig-006-20241209    clang-19
x86_64      buildonly-randconfig-006-20241210    clang-19
x86_64                              defconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20241210    gcc-12
x86_64                randconfig-002-20241210    gcc-12
x86_64                randconfig-003-20241210    gcc-12
x86_64                randconfig-004-20241210    gcc-12
x86_64                randconfig-005-20241210    gcc-12
x86_64                randconfig-006-20241210    gcc-12
x86_64                randconfig-007-20241210    gcc-12
x86_64                randconfig-008-20241210    gcc-12
x86_64                randconfig-071-20241210    gcc-12
x86_64                randconfig-072-20241210    gcc-12
x86_64                randconfig-073-20241210    gcc-12
x86_64                randconfig-074-20241210    gcc-12
x86_64                randconfig-075-20241210    gcc-12
x86_64                randconfig-076-20241210    gcc-12
x86_64                randconfig-077-20241210    gcc-12
x86_64                randconfig-078-20241210    gcc-12
x86_64                               rhel-9.4    clang-19
x86_64                           rhel-9.4-bpf    clang-19
x86_64                         rhel-9.4-kunit    clang-19
x86_64                           rhel-9.4-ltp    clang-19
x86_64                          rhel-9.4-rust    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20241209    gcc-14.2.0
xtensa                randconfig-001-20241210    gcc-14.2.0
xtensa                randconfig-002-20241209    gcc-14.2.0
xtensa                randconfig-002-20241210    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

