Return-Path: <linux-kernel+bounces-249907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFD492F16C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 23:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B0851F253B5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 21:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438B81A00F7;
	Thu, 11 Jul 2024 21:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gohz1DTp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95961A00C1
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 21:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720735074; cv=none; b=U5Adql50NHZrayJmqbJYhPaSpqSw06TpeU6Ucc3e2x1PDtI92p2rcY6+U1NeaFU+gldXBlxFBitF4tLlitLKFgIefE/7zXoQiijGWUzz8kAXDFDYcIFl7zh5QHLmBEUEJXSQM25TOxXPIfdmphn0vGHKVegAsfUGecqSmhO4/SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720735074; c=relaxed/simple;
	bh=o2WINdgMwEetaqCjxD7TvANT7De4VqeDnfoLcIy5vaQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Q/lwrRZcRaq0LGOeX1Q1nh543TtM5AaL2AW5/bzntF/mAJiDvLNVuI2PGY5DHN2gPoNqscNYSn2SQVlrfFdOS75u4MEnQ5peq7+igQnaTiH7DF+Uvm+bLZmWynpHhqYTQNFuFVr1rFs2KLTuHvnXsD02glxAhubTohoBFpupvOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gohz1DTp; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720735071; x=1752271071;
  h=date:from:to:cc:subject:message-id;
  bh=o2WINdgMwEetaqCjxD7TvANT7De4VqeDnfoLcIy5vaQ=;
  b=gohz1DTpL1HpNStHZAwgpAXl5+7rgCSVo/+gzCDx8ozPoP8NJhok8Y0Z
   6giWN9fJKMNS9rCK96yy/5qf/DM1lxmVJimFTZcjBPF9Dub+gREXfzpBL
   J5PSF6ed9PEqLGy5ncaCddIoF135yuUp2RlZ/eEbwZHEY/vB3GYB28EnL
   Cs3hRzb2SKznHlGboATeAgWm40balYFYDLJ12kCH32DwPsIjGrmzsIv9r
   FEc3G00Tp+brhT9fwL3S7CjMLx83d8QHRjhM1se9Tax0f38S139zOFjDR
   TCSjH9awl/8HtRxE9m418VYbYpxQ97sQaU3UoSsfM+Ye9uTSaRLuU/0GK
   Q==;
X-CSE-ConnectionGUID: vPAf3cwiQoymrLBW8GN9yw==
X-CSE-MsgGUID: bnUYuJujRiO2gA5nX1nUCA==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="22023129"
X-IronPort-AV: E=Sophos;i="6.09,201,1716274800"; 
   d="scan'208";a="22023129"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 14:57:51 -0700
X-CSE-ConnectionGUID: raHGYwsQSUa351SSLQwgAA==
X-CSE-MsgGUID: 7qRDUC1vRJ+wKT9OlA0b/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,201,1716274800"; 
   d="scan'208";a="48717304"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 11 Jul 2024 14:57:50 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sS1nQ-000Zx5-0W;
	Thu, 11 Jul 2024 21:57:48 +0000
Date: Fri, 12 Jul 2024 05:57:20 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:smp/core] BUILD SUCCESS
 77aeb1b685f9db73d276bad4bb30d48505a6fd23
Message-ID: <202407120518.xhQWcRpO-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp/core
branch HEAD: 77aeb1b685f9db73d276bad4bb30d48505a6fd23  smp: Add missing destroy_work_on_stack() call in smp_call_on_cpu()

elapsed time: 1458m

configs tested: 236
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240711   gcc-13.2.0
arc                   randconfig-002-20240711   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                              allyesconfig   gcc-14.1.0
arm                                 defconfig   gcc-13.2.0
arm                             mxs_defconfig   clang-19
arm                   randconfig-001-20240711   clang-19
arm                   randconfig-001-20240711   gcc-13.2.0
arm                   randconfig-002-20240711   gcc-13.2.0
arm                   randconfig-002-20240711   gcc-13.3.0
arm                   randconfig-003-20240711   clang-19
arm                   randconfig-003-20240711   gcc-13.2.0
arm                   randconfig-004-20240711   gcc-13.2.0
arm                   randconfig-004-20240711   gcc-13.3.0
arm                        vexpress_defconfig   clang-19
arm64                            allmodconfig   clang-19
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240711   clang-19
arm64                 randconfig-001-20240711   gcc-13.2.0
arm64                 randconfig-002-20240711   gcc-13.2.0
arm64                 randconfig-002-20240711   gcc-13.3.0
arm64                 randconfig-003-20240711   gcc-13.2.0
arm64                 randconfig-003-20240711   gcc-13.3.0
arm64                 randconfig-004-20240711   gcc-13.2.0
arm64                 randconfig-004-20240711   gcc-13.3.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240711   gcc-13.2.0
csky                  randconfig-001-20240711   gcc-13.3.0
csky                  randconfig-002-20240711   gcc-13.2.0
csky                  randconfig-002-20240711   gcc-13.3.0
hexagon                          allmodconfig   clang-19
hexagon                          allyesconfig   clang-19
hexagon               randconfig-001-20240711   clang-19
hexagon               randconfig-002-20240711   clang-19
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-13
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-13
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240711   gcc-13
i386         buildonly-randconfig-002-20240711   gcc-10
i386         buildonly-randconfig-002-20240711   gcc-13
i386         buildonly-randconfig-003-20240711   gcc-13
i386         buildonly-randconfig-004-20240711   gcc-13
i386         buildonly-randconfig-004-20240711   gcc-8
i386         buildonly-randconfig-005-20240711   gcc-10
i386         buildonly-randconfig-005-20240711   gcc-13
i386         buildonly-randconfig-006-20240711   gcc-13
i386                                defconfig   clang-18
i386                  randconfig-001-20240711   gcc-13
i386                  randconfig-002-20240711   gcc-10
i386                  randconfig-002-20240711   gcc-13
i386                  randconfig-003-20240711   gcc-13
i386                  randconfig-003-20240711   gcc-8
i386                  randconfig-004-20240711   gcc-13
i386                  randconfig-005-20240711   clang-18
i386                  randconfig-005-20240711   gcc-13
i386                  randconfig-006-20240711   gcc-13
i386                  randconfig-011-20240711   gcc-13
i386                  randconfig-011-20240711   gcc-9
i386                  randconfig-012-20240711   clang-18
i386                  randconfig-012-20240711   gcc-13
i386                  randconfig-013-20240711   gcc-13
i386                  randconfig-014-20240711   clang-18
i386                  randconfig-014-20240711   gcc-13
i386                  randconfig-015-20240711   clang-18
i386                  randconfig-015-20240711   gcc-13
i386                  randconfig-016-20240711   gcc-13
i386                  randconfig-016-20240711   gcc-9
loongarch                        allmodconfig   gcc-13.3.0
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240711   gcc-13.2.0
loongarch             randconfig-001-20240711   gcc-13.3.0
loongarch             randconfig-002-20240711   gcc-13.2.0
loongarch             randconfig-002-20240711   gcc-13.3.0
m68k                             allmodconfig   gcc-13.3.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-13.3.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                           gcw0_defconfig   clang-19
mips                      loongson3_defconfig   clang-19
mips                         rt305x_defconfig   clang-19
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240711   gcc-13.2.0
nios2                 randconfig-001-20240711   gcc-13.3.0
nios2                 randconfig-002-20240711   gcc-13.2.0
nios2                 randconfig-002-20240711   gcc-14.1.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.3.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.3.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240711   gcc-13.2.0
parisc                randconfig-001-20240711   gcc-13.3.0
parisc                randconfig-002-20240711   gcc-13.2.0
parisc                randconfig-002-20240711   gcc-13.3.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.3.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-19
powerpc                          allyesconfig   gcc-14.1.0
powerpc                   bluestone_defconfig   clang-19
powerpc                      katmai_defconfig   clang-19
powerpc                       maple_defconfig   clang-19
powerpc               randconfig-001-20240711   gcc-13.2.0
powerpc               randconfig-001-20240711   gcc-14.1.0
powerpc               randconfig-002-20240711   clang-19
powerpc               randconfig-002-20240711   gcc-13.2.0
powerpc               randconfig-003-20240711   clang-19
powerpc               randconfig-003-20240711   gcc-13.2.0
powerpc                     sequoia_defconfig   clang-19
powerpc64             randconfig-001-20240711   gcc-13.2.0
powerpc64             randconfig-001-20240711   gcc-14.1.0
powerpc64             randconfig-002-20240711   clang-16
powerpc64             randconfig-002-20240711   gcc-13.2.0
powerpc64             randconfig-003-20240711   gcc-13.2.0
powerpc64             randconfig-003-20240711   gcc-14.1.0
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-13.2.0
riscv                             allnoconfig   gcc-13.3.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-19
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-14.1.0
riscv                 randconfig-001-20240711   clang-14
riscv                 randconfig-001-20240711   gcc-13.2.0
riscv                 randconfig-002-20240711   gcc-13.2.0
riscv                 randconfig-002-20240711   gcc-14.1.0
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                              allnoconfig   gcc-13.2.0
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-19
s390                             allyesconfig   gcc-13.2.0
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240711   clang-19
s390                  randconfig-001-20240711   gcc-13.2.0
s390                  randconfig-002-20240711   gcc-13.2.0
s390                  randconfig-002-20240711   gcc-14.1.0
s390                       zfcpdump_defconfig   clang-19
sh                               allmodconfig   gcc-13.3.0
sh                                allnoconfig   gcc-13.2.0
sh                               allyesconfig   gcc-13.3.0
sh                                  defconfig   gcc-14.1.0
sh                    randconfig-001-20240711   gcc-13.2.0
sh                    randconfig-001-20240711   gcc-14.1.0
sh                    randconfig-002-20240711   gcc-13.2.0
sh                    randconfig-002-20240711   gcc-14.1.0
sparc                            allmodconfig   gcc-13.3.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240711   gcc-13.2.0
sparc64               randconfig-001-20240711   gcc-14.1.0
sparc64               randconfig-002-20240711   gcc-13.2.0
sparc64               randconfig-002-20240711   gcc-14.1.0
um                               allmodconfig   clang-19
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-13.2.0
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-13
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240711   gcc-13.2.0
um                    randconfig-001-20240711   gcc-8
um                    randconfig-002-20240711   gcc-13.2.0
um                    randconfig-002-20240711   gcc-8
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240711   clang-18
x86_64       buildonly-randconfig-002-20240711   clang-18
x86_64       buildonly-randconfig-003-20240711   clang-18
x86_64       buildonly-randconfig-004-20240711   clang-18
x86_64       buildonly-randconfig-005-20240711   clang-18
x86_64       buildonly-randconfig-006-20240711   clang-18
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240711   clang-18
x86_64                randconfig-002-20240711   clang-18
x86_64                randconfig-003-20240711   clang-18
x86_64                randconfig-004-20240711   clang-18
x86_64                randconfig-005-20240711   clang-18
x86_64                randconfig-006-20240711   clang-18
x86_64                randconfig-011-20240711   clang-18
x86_64                randconfig-012-20240711   clang-18
x86_64                randconfig-013-20240711   clang-18
x86_64                randconfig-014-20240711   clang-18
x86_64                randconfig-015-20240711   clang-18
x86_64                randconfig-016-20240711   clang-18
x86_64                randconfig-071-20240711   clang-18
x86_64                randconfig-072-20240711   clang-18
x86_64                randconfig-073-20240711   clang-18
x86_64                randconfig-074-20240711   clang-18
x86_64                randconfig-075-20240711   clang-18
x86_64                randconfig-076-20240711   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                randconfig-001-20240711   gcc-13.2.0
xtensa                randconfig-001-20240711   gcc-14.1.0
xtensa                randconfig-002-20240711   gcc-13.2.0
xtensa                randconfig-002-20240711   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

