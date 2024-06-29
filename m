Return-Path: <linux-kernel+bounces-234994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB5391CE14
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 18:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DA761C21080
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 16:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8569485285;
	Sat, 29 Jun 2024 16:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W8EFNVxO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8CF1CFB2
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 16:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719678089; cv=none; b=SblrhOvbSDKjQIZkzACHEP0aw6+Na2Y5RKmI3+A5Gr5X3R9vXeAci2ebwQDzvyzycnT8YqX8CcdXOEPtNuvEmaSwTgEhwMIb0OQZ6lDtoj245EixHVrB3P1NaUY2zigqBwLLdW1r0hmV+BKXoOtiq3JDBzIKiFiPkskTCJGWh+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719678089; c=relaxed/simple;
	bh=x5iwjhDP8M7vAcpOFCc7WcvAcmRll3liuMe38tUd4XE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=tybgos4luCf/zpF+G1OXVn3ksHrIeV9MZKKxyB/nx3Ac66qVS3RGGvmPotwC7iQGmYzmkDcRfC+c3ZmAk/+YFG02ss8ZPxuVRG1vNzzQ0KA/Tdgd02HwRuqQ44scP+HWrUEbdFTKbkXC7JVKom0yNEEouQDOMBXaQVqnltYL6lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W8EFNVxO; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719678088; x=1751214088;
  h=date:from:to:cc:subject:message-id;
  bh=x5iwjhDP8M7vAcpOFCc7WcvAcmRll3liuMe38tUd4XE=;
  b=W8EFNVxO5L34OAY0YbiQHKvRLtxXLCcBFdGMlDMjN7W0i7abos1UZkRc
   hqWNOC8IV9E06kcfraK7nwxaUOpzpxp/d4gtRtuQxXDqV0goez/cCMYHX
   xFmOB3ZaVlaxa+nqBzHLSx6imHybyqhmlfXx5wnx+nrELQFEf5Gy0vGOx
   aMdQfA4sAie+45ZrsG0pdkg33AqrPmZJ7iGvCmSemL4kGGCQYIF/eSb4Y
   EO7qCsx7A3IPCmp9NhgSKW+5mkyqqcBGXrZZNBqJ2PHOGs6FLwyiWSyTN
   qlxwOr1ajID4YTUxraagFuXg0OArFWAy8ajChm9S51zBNmbaVQNAC5zuR
   w==;
X-CSE-ConnectionGUID: VBktWd0wQgu7eUwgyA4fug==
X-CSE-MsgGUID: ndWXXSHBSl6saVwos7IizA==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="28238038"
X-IronPort-AV: E=Sophos;i="6.09,172,1716274800"; 
   d="scan'208";a="28238038"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2024 09:21:27 -0700
X-CSE-ConnectionGUID: LBYnmaKYRmSMQ0yEalLXBA==
X-CSE-MsgGUID: tIZ45x05SPGZ80TmQuzY4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,172,1716274800"; 
   d="scan'208";a="45041626"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 29 Jun 2024 09:21:25 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sNapH-000JhE-29;
	Sat, 29 Jun 2024 16:21:23 +0000
Date: Sun, 30 Jun 2024 00:21:05 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/cc] BUILD SUCCESS
 0a980db83ba789c78cd296b3cb68ee3acd0aac18
Message-ID: <202406300004.WrNgVezS-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cc
branch HEAD: 0a980db83ba789c78cd296b3cb68ee3acd0aac18  Merge branch 'x86/urgent' into x86/cc, to resolve conflict

elapsed time: 4803m

configs tested: 88
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                               defconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240628   gcc-13.2.0
arc                   randconfig-002-20240628   gcc-13.2.0
arm                               allnoconfig   clang-19
arm                   randconfig-001-20240628   gcc-13.2.0
arm                   randconfig-002-20240628   gcc-13.2.0
arm                   randconfig-003-20240628   gcc-13.2.0
arm                   randconfig-004-20240628   clang-19
arm64                             allnoconfig   gcc-13.2.0
arm64                 randconfig-001-20240628   gcc-13.2.0
arm64                 randconfig-002-20240628   gcc-13.2.0
arm64                 randconfig-003-20240628   clang-19
arm64                 randconfig-004-20240628   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240628   gcc-13.2.0
csky                  randconfig-002-20240628   gcc-13.2.0
hexagon                           allnoconfig   clang-19
hexagon                             defconfig   clang-19
hexagon               randconfig-001-20240628   clang-19
hexagon               randconfig-002-20240628   clang-19
loongarch                         allnoconfig   gcc-13.2.0
loongarch             randconfig-001-20240628   gcc-13.2.0
loongarch             randconfig-002-20240628   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                 randconfig-001-20240628   gcc-13.2.0
nios2                 randconfig-002-20240628   gcc-13.2.0
openrisc                            defconfig   gcc-13.2.0
parisc                              defconfig   gcc-13.2.0
parisc                randconfig-001-20240628   gcc-13.2.0
parisc                randconfig-002-20240628   gcc-13.2.0
powerpc               randconfig-001-20240628   gcc-13.2.0
powerpc               randconfig-002-20240628   gcc-13.2.0
powerpc               randconfig-003-20240628   gcc-13.2.0
powerpc64             randconfig-001-20240628   gcc-13.2.0
powerpc64             randconfig-002-20240628   gcc-13.2.0
powerpc64             randconfig-003-20240628   clang-19
riscv                               defconfig   clang-19
riscv                 randconfig-001-20240628   gcc-13.2.0
riscv                 randconfig-002-20240628   gcc-13.2.0
s390                                defconfig   clang-19
s390                  randconfig-001-20240628   clang-19
s390                  randconfig-002-20240628   clang-19
sh                                allnoconfig   gcc-13.2.0
sh                                  defconfig   gcc-13.2.0
sh                    randconfig-001-20240628   gcc-13.2.0
sh                    randconfig-002-20240628   gcc-13.2.0
sparc64                             defconfig   gcc-13.2.0
sparc64               randconfig-001-20240628   gcc-13.2.0
sparc64               randconfig-002-20240628   gcc-13.2.0
um                                  defconfig   clang-19
um                             i386_defconfig   gcc-13
um                    randconfig-001-20240628   gcc-13
um                    randconfig-002-20240628   clang-19
um                           x86_64_defconfig   clang-15
x86_64       buildonly-randconfig-001-20240628   gcc-13
x86_64       buildonly-randconfig-002-20240628   clang-18
x86_64       buildonly-randconfig-003-20240628   gcc-13
x86_64       buildonly-randconfig-004-20240628   gcc-13
x86_64       buildonly-randconfig-005-20240628   gcc-13
x86_64       buildonly-randconfig-006-20240628   clang-18
x86_64                randconfig-001-20240628   clang-18
x86_64                randconfig-002-20240628   clang-18
x86_64                randconfig-003-20240628   gcc-11
x86_64                randconfig-004-20240628   gcc-7
x86_64                randconfig-005-20240628   clang-18
x86_64                randconfig-006-20240628   clang-18
x86_64                randconfig-011-20240628   clang-18
x86_64                randconfig-012-20240628   gcc-10
x86_64                randconfig-013-20240628   gcc-13
x86_64                randconfig-014-20240628   clang-18
x86_64                randconfig-015-20240628   clang-18
x86_64                randconfig-016-20240628   gcc-12
x86_64                randconfig-071-20240628   clang-18
x86_64                randconfig-072-20240628   gcc-13
x86_64                randconfig-073-20240628   clang-18
x86_64                randconfig-074-20240628   gcc-13
x86_64                randconfig-075-20240628   gcc-13
x86_64                randconfig-076-20240628   gcc-13
xtensa                            allnoconfig   gcc-13.2.0
xtensa                randconfig-001-20240628   gcc-13.2.0
xtensa                randconfig-002-20240628   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

