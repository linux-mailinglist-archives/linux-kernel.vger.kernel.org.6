Return-Path: <linux-kernel+bounces-390795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D475B9B7E95
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 043E41C21FE8
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE0C19E7EB;
	Thu, 31 Oct 2024 15:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d1LbBZ5C"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB111A3038
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 15:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730388818; cv=none; b=Or0cW6DDS9Rln3IQWeTmJpJt/oD/efGjBqq3qwTgaaW6hwnAQxQpFwF8ir+Or1YrGA/DO60QprWhpv6SqRgh1FRJfJAyxwgBtg3Ad/RPLNXjEOp7MvxMcqTpjmPuReFXSyQPJZ00dTYazwScSRai/WgopQb46GwA1nv96tcyz/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730388818; c=relaxed/simple;
	bh=2MiGTdyBVR0Ocm9gKax0hp6cNin++4RDhHCQAIawbvk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=GduN6x0BDwdpuTKM1KZrcmvRZaxZyIVUK6EPHnWErfRg3gNxU5lAS49OMITFfcMUSFSxlQABEVfQDGPbgDZGCLBO1e5SOSAw9XIyea2cNthD5DlwEP5YfJVWmFxoDB2to4wljq+a8o7bZ9eF7qbd/WgyiCfmsz/6hbR2OJWjnPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d1LbBZ5C; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730388816; x=1761924816;
  h=date:from:to:cc:subject:message-id;
  bh=2MiGTdyBVR0Ocm9gKax0hp6cNin++4RDhHCQAIawbvk=;
  b=d1LbBZ5CzFBD/kMAff7YKkY2DTRtHazhO6/Lq0TDNOF/1HBkLAyjjAVS
   nAzG89w8mUf1ODu1397CY67B/wA03GkdXLCokQBY+EJC+5DBygYT0IEPf
   QlJNZzktxw2baYx8qcrivCUqzP6UDkHkou79IWrm7bfHs5L4JRf2oycl9
   PGEjj9O48dB+fwJziZxzjIprtvc2Sqm7uyleBHSz9dxuqf4FVjmQuKIOC
   CtY1vke05E3whRqhy8GWaMnOrkaz+C49J+IPdXr6OoWWz//JXjh7OrhYQ
   ngcYOBgAhAH6kFBWo1Bh5chQIbVAYQ+E6PYRpyDVJfArXS0u6xjPqMtRv
   A==;
X-CSE-ConnectionGUID: 2q0cwt4pQFWAMgO7SIYrsQ==
X-CSE-MsgGUID: KLavgauTRk2DGYHl+G9Jfw==
X-IronPort-AV: E=McAfee;i="6700,10204,11242"; a="30243819"
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="30243819"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 08:33:35 -0700
X-CSE-ConnectionGUID: NGEZuHHFSXKMvRypwutSkg==
X-CSE-MsgGUID: s1oK5qSoSOWLP0OmF5GY/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="87255914"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 31 Oct 2024 08:33:33 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t6XAx-000gTE-2p;
	Thu, 31 Oct 2024 15:33:31 +0000
Date: Thu, 31 Oct 2024 23:32:42 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:irq/core] BUILD SUCCESS
 d1cb1437b785f312d63f447e2e79ff768e7ccc29
Message-ID: <202410312329.rm1sANBj-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
branch HEAD: d1cb1437b785f312d63f447e2e79ff768e7ccc29  irqchip/mips-gic: Prevent indirect access to clusters without CPU cores

elapsed time: 1483m

configs tested: 186
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                            allyesconfig    gcc-13.3.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                          axs101_defconfig    gcc-14.1.0
arc                   randconfig-001-20241031    gcc-14.1.0
arc                   randconfig-002-20241031    gcc-14.1.0
arc                           tb10x_defconfig    gcc-14.1.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                       imx_v4_v5_defconfig    gcc-14.1.0
arm                            mmp2_defconfig    gcc-14.1.0
arm                        mvebu_v7_defconfig    gcc-14.1.0
arm                        neponset_defconfig    gcc-14.1.0
arm                   randconfig-001-20241031    gcc-14.1.0
arm                   randconfig-002-20241031    gcc-14.1.0
arm                   randconfig-003-20241031    gcc-14.1.0
arm                   randconfig-004-20241031    gcc-14.1.0
arm                         s3c6400_defconfig    gcc-14.1.0
arm                         socfpga_defconfig    gcc-14.1.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                 randconfig-001-20241031    gcc-14.1.0
arm64                 randconfig-002-20241031    gcc-14.1.0
arm64                 randconfig-003-20241031    gcc-14.1.0
arm64                 randconfig-004-20241031    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                  randconfig-001-20241031    gcc-14.1.0
csky                  randconfig-002-20241031    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon               randconfig-001-20241031    gcc-14.1.0
hexagon               randconfig-002-20241031    gcc-14.1.0
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-19
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241031    clang-19
i386        buildonly-randconfig-002-20241031    clang-19
i386        buildonly-randconfig-003-20241031    clang-19
i386        buildonly-randconfig-004-20241031    clang-19
i386        buildonly-randconfig-005-20241031    clang-19
i386        buildonly-randconfig-006-20241031    clang-19
i386                                defconfig    clang-19
i386                  randconfig-001-20241031    clang-19
i386                  randconfig-002-20241031    clang-19
i386                  randconfig-003-20241031    clang-19
i386                  randconfig-004-20241031    clang-19
i386                  randconfig-005-20241031    clang-19
i386                  randconfig-006-20241031    clang-19
i386                  randconfig-011-20241031    clang-19
i386                  randconfig-012-20241031    clang-19
i386                  randconfig-013-20241031    clang-19
i386                  randconfig-014-20241031    clang-19
i386                  randconfig-015-20241031    clang-19
i386                  randconfig-016-20241031    clang-19
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch             randconfig-001-20241031    gcc-14.1.0
loongarch             randconfig-002-20241031    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                          amiga_defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                       bmips_be_defconfig    gcc-14.1.0
mips                      bmips_stb_defconfig    gcc-14.1.0
mips                         rt305x_defconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                 randconfig-001-20241031    gcc-14.1.0
nios2                 randconfig-002-20241031    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20241031    gcc-14.1.0
parisc                randconfig-002-20241031    gcc-14.1.0
powerpc                    adder875_defconfig    gcc-14.1.0
powerpc                     akebono_defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.1.0
powerpc                     asp8347_defconfig    gcc-14.1.0
powerpc                    gamecube_defconfig    gcc-14.1.0
powerpc                       holly_defconfig    gcc-14.1.0
powerpc                      mgcoge_defconfig    gcc-14.1.0
powerpc                      pasemi_defconfig    gcc-14.1.0
powerpc                         ps3_defconfig    gcc-14.1.0
powerpc               randconfig-001-20241031    gcc-14.1.0
powerpc               randconfig-002-20241031    gcc-14.1.0
powerpc               randconfig-003-20241031    gcc-14.1.0
powerpc                     sequoia_defconfig    gcc-14.1.0
powerpc64             randconfig-001-20241031    gcc-14.1.0
powerpc64             randconfig-002-20241031    gcc-14.1.0
powerpc64             randconfig-003-20241031    gcc-14.1.0
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
riscv                    nommu_k210_defconfig    gcc-14.1.0
riscv                 randconfig-001-20241031    gcc-14.1.0
riscv                 randconfig-002-20241031    gcc-14.1.0
s390                             allmodconfig    clang-20
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20241031    gcc-14.1.0
s390                  randconfig-002-20241031    gcc-14.1.0
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                        dreamcast_defconfig    gcc-14.1.0
sh                         ecovec24_defconfig    gcc-14.1.0
sh                        edosk7705_defconfig    gcc-14.1.0
sh                    randconfig-001-20241031    gcc-14.1.0
sh                    randconfig-002-20241031    gcc-14.1.0
sh                      rts7751r2d1_defconfig    gcc-14.1.0
sh                           se7721_defconfig    gcc-14.1.0
sh                           se7722_defconfig    gcc-14.1.0
sh                             sh03_defconfig    gcc-14.1.0
sh                   sh7724_generic_defconfig    gcc-14.1.0
sh                          urquell_defconfig    gcc-14.1.0
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20241031    gcc-14.1.0
sparc64               randconfig-002-20241031    gcc-14.1.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241031    gcc-14.1.0
um                    randconfig-002-20241031    gcc-14.1.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241031    clang-19
x86_64      buildonly-randconfig-002-20241031    clang-19
x86_64      buildonly-randconfig-003-20241031    clang-19
x86_64      buildonly-randconfig-004-20241031    clang-19
x86_64      buildonly-randconfig-005-20241031    clang-19
x86_64      buildonly-randconfig-006-20241031    clang-19
x86_64                              defconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20241031    clang-19
x86_64                randconfig-002-20241031    clang-19
x86_64                randconfig-003-20241031    clang-19
x86_64                randconfig-004-20241031    clang-19
x86_64                randconfig-005-20241031    clang-19
x86_64                randconfig-006-20241031    clang-19
x86_64                randconfig-011-20241031    clang-19
x86_64                randconfig-012-20241031    clang-19
x86_64                randconfig-013-20241031    clang-19
x86_64                randconfig-014-20241031    clang-19
x86_64                randconfig-015-20241031    clang-19
x86_64                randconfig-016-20241031    clang-19
x86_64                randconfig-071-20241031    clang-19
x86_64                randconfig-072-20241031    clang-19
x86_64                randconfig-073-20241031    clang-19
x86_64                randconfig-074-20241031    clang-19
x86_64                randconfig-075-20241031    clang-19
x86_64                randconfig-076-20241031    clang-19
x86_64                               rhel-8.3    gcc-12
x86_64                           rhel-8.3-bpf    clang-19
x86_64                         rhel-8.3-kunit    clang-19
x86_64                           rhel-8.3-ltp    clang-19
x86_64                          rhel-8.3-rust    clang-19
xtensa                            allnoconfig    gcc-14.1.0
xtensa                randconfig-001-20241031    gcc-14.1.0
xtensa                randconfig-002-20241031    gcc-14.1.0
xtensa                    xip_kc705_defconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

