Return-Path: <linux-kernel+bounces-251102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A169300A9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 21:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87AB01F22DF7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 19:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B347E20DC5;
	Fri, 12 Jul 2024 19:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EHOfHb+V"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9117722315
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 19:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720811026; cv=none; b=V4u2zMXp53Du0qpH6GbmvuxqHYlgYnLFPQB9KfGR9cRyjXQKD9VWUh6YxXsqAEpCyXHBAHsF5U1wbHBRq7JRH0QY70rcKIkbjuFJTkKM2AjtMvooEoL05IhvuYMUKavHFAF97O1PvH+l1oHTFfjoOJ1+ADtJr2Ore4wt6VXuXtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720811026; c=relaxed/simple;
	bh=W+3rAx9faDUwNDWEe6g5U+3qwbA64sGtrKn1aBG6kTM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=AN8e6EBq2ewCbtqAerp06Z7K30nNmP77tbRGtJHkLzKj+uEzDOXhfnMN5CsDpoXkJKgwvqnMygMU0aweFY9l1nQzU+8R7k56hcGxFlAToQJyISlsSaYdpUbyOO6Urs3amUsec4XDf07c2hrzSAp0EzNbjHqi5J/oFRuVJh97stI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EHOfHb+V; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720811024; x=1752347024;
  h=date:from:to:cc:subject:message-id;
  bh=W+3rAx9faDUwNDWEe6g5U+3qwbA64sGtrKn1aBG6kTM=;
  b=EHOfHb+V2wuuEX6+mWNYncAWg/vOROwaAiBVFhe1GiEw/RZFbOdSnRWl
   DEsg72EOei6QszNn62jYPT+hhfxSHYadBJkCmuQoLcfMzV6mLjBCsYGvL
   ayL/YfyGKxNj5gA56UhrlxUX/K7dTl2OXOaNstSk3sSDWpOmpjORoK0xI
   ClDf4LbSQvsrVMbLih51Wda9fOJmR/naAqXaZFIBfefpvzOxzQqkzeChM
   ZU2mWpmy+7oOs2hegCJwMDxQ3bHDhB/1Zg6epSM4BVO6X1HhwocjbRYP5
   v+396psrj7md+jPMxiqD5G1Dm6ex1NqZ4859v1Tu8h9X/KdVNmacmcm/i
   w==;
X-CSE-ConnectionGUID: pwinhiCmRAKhyjP/jJd2mg==
X-CSE-MsgGUID: taODfg//T0eh01sQavqz4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11131"; a="18407870"
X-IronPort-AV: E=Sophos;i="6.09,203,1716274800"; 
   d="scan'208";a="18407870"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2024 12:03:43 -0700
X-CSE-ConnectionGUID: 7eLqlxWRRDWYSHh9q6n6TQ==
X-CSE-MsgGUID: htsUn1KMRFKUrdAdNghelQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,203,1716274800"; 
   d="scan'208";a="86503500"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 12 Jul 2024 12:03:43 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sSLYS-000bA4-1f;
	Fri, 12 Jul 2024 19:03:40 +0000
Date: Sat, 13 Jul 2024 03:03:32 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/merge] BUILD SUCCESS
 ef979fe98446a3b7c8aafd6f9f4b60b8b4f312a5
Message-ID: <202407130328.deaBNNcQ-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/merge
branch HEAD: ef979fe98446a3b7c8aafd6f9f4b60b8b4f312a5  Merge branch 'x86/cpu' into x86/merge, to ease integration testing, and to resolve conflicts

elapsed time: 1407m

configs tested: 143
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                   randconfig-001-20240712   gcc-13.2.0
arc                   randconfig-002-20240712   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-19
arm                              allyesconfig   gcc-14.1.0
arm                   randconfig-001-20240712   clang-19
arm                   randconfig-002-20240712   clang-19
arm                   randconfig-003-20240712   gcc-14.1.0
arm                   randconfig-004-20240712   clang-15
arm64                            allmodconfig   clang-19
arm64                             allnoconfig   gcc-14.1.0
arm64                 randconfig-001-20240712   gcc-14.1.0
arm64                 randconfig-002-20240712   gcc-14.1.0
arm64                 randconfig-003-20240712   clang-19
arm64                 randconfig-004-20240712   clang-17
csky                              allnoconfig   gcc-14.1.0
csky                  randconfig-001-20240712   gcc-14.1.0
csky                  randconfig-002-20240712   gcc-14.1.0
hexagon                          allmodconfig   clang-19
hexagon                           allnoconfig   clang-19
hexagon                          allyesconfig   clang-19
hexagon               randconfig-001-20240712   clang-14
hexagon               randconfig-002-20240712   clang-19
i386                             allmodconfig   gcc-13
i386                              allnoconfig   gcc-13
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240712   gcc-9
i386         buildonly-randconfig-002-20240712   clang-18
i386         buildonly-randconfig-003-20240712   clang-18
i386         buildonly-randconfig-004-20240712   clang-18
i386         buildonly-randconfig-005-20240712   gcc-11
i386         buildonly-randconfig-006-20240712   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240712   clang-18
i386                  randconfig-002-20240712   clang-18
i386                  randconfig-003-20240712   clang-18
i386                  randconfig-004-20240712   clang-18
i386                  randconfig-005-20240712   clang-18
i386                  randconfig-006-20240712   clang-18
i386                  randconfig-011-20240712   clang-18
i386                  randconfig-012-20240712   clang-18
i386                  randconfig-013-20240712   clang-18
i386                  randconfig-014-20240712   gcc-10
i386                  randconfig-015-20240712   gcc-10
i386                  randconfig-016-20240712   gcc-12
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch             randconfig-001-20240712   gcc-14.1.0
loongarch             randconfig-002-20240712   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-14.1.0
nios2                 randconfig-001-20240712   gcc-14.1.0
nios2                 randconfig-002-20240712   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240712   gcc-14.1.0
parisc                randconfig-002-20240712   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-19
powerpc               randconfig-001-20240712   clang-15
powerpc               randconfig-002-20240712   clang-19
powerpc               randconfig-003-20240712   clang-19
powerpc64             randconfig-001-20240712   clang-19
powerpc64             randconfig-002-20240712   clang-19
powerpc64             randconfig-003-20240712   gcc-14.1.0
riscv                            allmodconfig   clang-19
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-19
riscv                               defconfig   clang-19
riscv                 randconfig-001-20240712   clang-19
riscv                 randconfig-002-20240712   gcc-14.1.0
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   clang-19
s390                  randconfig-001-20240712   gcc-14.1.0
s390                  randconfig-002-20240712   gcc-14.1.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                    randconfig-001-20240712   gcc-14.1.0
sh                    randconfig-002-20240712   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240712   gcc-14.1.0
sparc64               randconfig-002-20240712   gcc-14.1.0
um                               allmodconfig   clang-19
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-13
um                                  defconfig   clang-19
um                             i386_defconfig   gcc-13
um                    randconfig-001-20240712   clang-19
um                    randconfig-002-20240712   clang-15
um                           x86_64_defconfig   clang-15
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240712   clang-18
x86_64       buildonly-randconfig-002-20240712   clang-18
x86_64       buildonly-randconfig-003-20240712   clang-18
x86_64       buildonly-randconfig-004-20240712   clang-18
x86_64       buildonly-randconfig-005-20240712   clang-18
x86_64       buildonly-randconfig-006-20240712   clang-18
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240712   gcc-12
x86_64                randconfig-002-20240712   gcc-13
x86_64                randconfig-003-20240712   gcc-12
x86_64                randconfig-004-20240712   clang-18
x86_64                randconfig-005-20240712   gcc-13
x86_64                randconfig-006-20240712   clang-18
x86_64                randconfig-011-20240712   clang-18
x86_64                randconfig-012-20240712   clang-18
x86_64                randconfig-013-20240712   clang-18
x86_64                randconfig-014-20240712   gcc-13
x86_64                randconfig-015-20240712   clang-18
x86_64                randconfig-016-20240712   clang-18
x86_64                randconfig-071-20240712   gcc-13
x86_64                randconfig-072-20240712   gcc-11
x86_64                randconfig-073-20240712   clang-18
x86_64                randconfig-074-20240712   gcc-9
x86_64                randconfig-075-20240712   clang-18
x86_64                randconfig-076-20240712   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240712   gcc-14.1.0
xtensa                randconfig-002-20240712   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

