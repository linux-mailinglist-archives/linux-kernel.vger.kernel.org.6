Return-Path: <linux-kernel+bounces-197746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6E28D6E98
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 09:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A19A1F21E67
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 07:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B022C14277;
	Sat,  1 Jun 2024 07:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="abPCJupD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53FD14A82
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 07:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717225378; cv=none; b=N2sojXG2OqHkfvt1uU3GhW6w03QJ3D8O0FM1qV18uoqH2UTpxUQubZUuzvT/oivVghXsfzDWgMWToqxwruHKoVw0jJ8U2FD1zbQSPEuFI1kuZrNwKe5El2PqJN3VbVG+iALDIyk7sHRtFlh0tI3Gyqe9yt1GlkqjIkFfb4MjxKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717225378; c=relaxed/simple;
	bh=t6Joi8bL7W7K8zYqemYCCPuv68E8dk31/cqvARQugA8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=j5owDy/auQ5GVwmKx8S0WKEB5Cf74IdMdaC0wroDpq0/vHOjiF3xQW5Aq+4L8WvpbXuED0pKfycIIVDgq8LiUB1JHskDnCPUhszGjfyahWbjxaDX7ZdkXkSlmebYbqgz4Ig331bU2sbgEwuLVF/aLEQWvER1KQ+bwNswDU7LpGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=abPCJupD; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717225377; x=1748761377;
  h=date:from:to:cc:subject:message-id;
  bh=t6Joi8bL7W7K8zYqemYCCPuv68E8dk31/cqvARQugA8=;
  b=abPCJupDCKjhAPTLwlk4rdcWKFgEZ1fJmFDq+fyGPSbifZiuUpfwQpuX
   MLfjMr9QYRFGC1bCeva0eyI2FKzXlzsL5ufKoa+dFrDxfJa8JcHbpCys+
   91tp+CRXnYED3qKurFxXw5xhD/BrqR/tl+FfSTVUb4mGtMqGz28Pbtb5u
   AVYIQM7rdvq4wM+F4ZjMAk5EGCxe/mBvO+78+adfMGWAylCox5hoRNF78
   Apw1qwr0M6LdIL0HHR0W0apUACf01W0KIs8JS/3k5rzd4FwTTXI2uG91G
   CcW8tlqftsQeiM1RY5vkOo74qd7q26de1X3dK7/89IEdBRc6jzDCQze81
   w==;
X-CSE-ConnectionGUID: YIRA+qVyQAmyJeScghDnEQ==
X-CSE-MsgGUID: 7t0kU7e9TLGsQJrTjA4Eeg==
X-IronPort-AV: E=McAfee;i="6600,9927,11089"; a="31308044"
X-IronPort-AV: E=Sophos;i="6.08,206,1712646000"; 
   d="scan'208";a="31308044"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2024 00:02:56 -0700
X-CSE-ConnectionGUID: yWqZE9kYSpqMJaUZ5aa+tA==
X-CSE-MsgGUID: iOcvZ6vUSTmEGVGlODQ4GQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,206,1712646000"; 
   d="scan'208";a="36474790"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 01 Jun 2024 00:02:54 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sDIlQ-000IVv-1j;
	Sat, 01 Jun 2024 07:02:52 +0000
Date: Sat, 01 Jun 2024 15:02:05 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:sched/urgent] BUILD SUCCESS
 d40605a6823577a6c40fad6fb1f10a40ea0389d7
Message-ID: <202406011503.ZuV2QL0x-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/urgent
branch HEAD: d40605a6823577a6c40fad6fb1f10a40ea0389d7  sched/x86: Export 'percpu arch_freq_scale'

elapsed time: 1243m

configs tested: 186
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig   gcc  
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240601   gcc  
arc                   randconfig-002-20240601   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240601   clang
arm                   randconfig-002-20240601   clang
arm                   randconfig-003-20240601   gcc  
arm                   randconfig-004-20240601   gcc  
arm                           u8500_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240601   gcc  
arm64                 randconfig-002-20240601   clang
arm64                 randconfig-003-20240601   clang
arm64                 randconfig-004-20240601   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240601   gcc  
csky                  randconfig-002-20240601   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240601   clang
hexagon               randconfig-002-20240601   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240531   clang
i386         buildonly-randconfig-001-20240601   clang
i386         buildonly-randconfig-002-20240531   gcc  
i386         buildonly-randconfig-003-20240531   gcc  
i386         buildonly-randconfig-004-20240531   clang
i386         buildonly-randconfig-005-20240531   gcc  
i386         buildonly-randconfig-006-20240531   clang
i386         buildonly-randconfig-006-20240601   clang
i386                                defconfig   clang
i386                  randconfig-001-20240531   gcc  
i386                  randconfig-001-20240601   clang
i386                  randconfig-002-20240531   clang
i386                  randconfig-003-20240531   clang
i386                  randconfig-003-20240601   clang
i386                  randconfig-004-20240531   gcc  
i386                  randconfig-005-20240531   clang
i386                  randconfig-005-20240601   clang
i386                  randconfig-006-20240531   clang
i386                  randconfig-011-20240531   clang
i386                  randconfig-012-20240531   gcc  
i386                  randconfig-013-20240531   gcc  
i386                  randconfig-014-20240531   clang
i386                  randconfig-015-20240531   gcc  
i386                  randconfig-015-20240601   clang
i386                  randconfig-016-20240531   clang
i386                  randconfig-016-20240601   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240601   gcc  
loongarch             randconfig-002-20240601   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5272c3_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                  cavium_octeon_defconfig   gcc  
mips                          eyeq5_defconfig   gcc  
mips                  maltasmvp_eva_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240601   gcc  
nios2                 randconfig-002-20240601   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240601   gcc  
parisc                randconfig-002-20240601   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                    klondike_defconfig   gcc  
powerpc                     rainier_defconfig   gcc  
powerpc               randconfig-001-20240601   gcc  
powerpc               randconfig-002-20240601   gcc  
powerpc               randconfig-003-20240601   gcc  
powerpc64             randconfig-001-20240601   clang
powerpc64             randconfig-002-20240601   clang
powerpc64             randconfig-003-20240601   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240601   clang
riscv                 randconfig-002-20240601   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240601   gcc  
s390                  randconfig-002-20240601   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                             espt_defconfig   gcc  
sh                    randconfig-001-20240601   gcc  
sh                    randconfig-002-20240601   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240601   gcc  
sparc64               randconfig-002-20240601   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240601   gcc  
um                    randconfig-002-20240601   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240601   clang
x86_64       buildonly-randconfig-002-20240601   clang
x86_64       buildonly-randconfig-003-20240601   gcc  
x86_64       buildonly-randconfig-004-20240601   gcc  
x86_64       buildonly-randconfig-005-20240601   clang
x86_64       buildonly-randconfig-006-20240601   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   clang
x86_64                randconfig-001-20240601   gcc  
x86_64                randconfig-002-20240601   clang
x86_64                randconfig-003-20240601   clang
x86_64                randconfig-004-20240601   clang
x86_64                randconfig-005-20240601   gcc  
x86_64                randconfig-006-20240601   clang
x86_64                randconfig-011-20240601   clang
x86_64                randconfig-012-20240601   clang
x86_64                randconfig-013-20240601   clang
x86_64                randconfig-014-20240601   gcc  
x86_64                randconfig-015-20240601   gcc  
x86_64                randconfig-016-20240601   gcc  
x86_64                randconfig-071-20240601   clang
x86_64                randconfig-072-20240601   gcc  
x86_64                randconfig-073-20240601   clang
x86_64                randconfig-074-20240601   gcc  
x86_64                randconfig-075-20240601   clang
x86_64                randconfig-076-20240601   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                  cadence_csp_defconfig   gcc  
xtensa                randconfig-001-20240601   gcc  
xtensa                randconfig-002-20240601   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

