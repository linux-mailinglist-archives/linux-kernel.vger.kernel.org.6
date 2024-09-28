Return-Path: <linux-kernel+bounces-342336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A524A988DB1
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 05:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3F0F1C211EF
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 03:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E261534E6;
	Sat, 28 Sep 2024 03:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B7gbBz7C"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DC2EEAA
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 03:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727493301; cv=none; b=r47gcylfMuL1L1ne+bq1IWfQ+5NG1byphGmrTiH/a2KgS1QtwpgyNxL+MJkxX3KxWr+B74g3XLa2V8OY9Wlsd5HzsXEQvK822s+HBYoQDKvItzoUqJEwT1CllAg6+ZWYN6uWaRoE/kuv4Y6DVQ7HqfChw0Icl4zlwvhOHuXB8yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727493301; c=relaxed/simple;
	bh=lpYYlFjPXVT4LqAUQrlxcCYdhyoOnZmqYhu/K3oPbQ0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=tMh+Ajur+AS4FhP21CglrdrCQ0s2EyC1YfmiR616JMFk09dlfD+/lkp1uWh1ievpVQkKYg2VJLaDW4IAjU/BxUkFa21IWpizGhSrvpJKtj9FW0kc1ynu8+xxfvGAjXwyaljifyhogmi8lH5VM/UgvM5JJD4ZP2o1/2KJqDNpiks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B7gbBz7C; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727493300; x=1759029300;
  h=date:from:to:cc:subject:message-id;
  bh=lpYYlFjPXVT4LqAUQrlxcCYdhyoOnZmqYhu/K3oPbQ0=;
  b=B7gbBz7CHRT4W8yoeu5cdu3ZxARHZTV+gqvkgJP/5EujyFG/EBqAeR83
   eOJGhWFjqj+rFyWKXB4hx3NZOv6bhHnU/9+E6qA8pJ00ru0OU1CstccE9
   JmAUI2sjEdMWR6VY7A+Q2DGMrAeFJH/qm4ah8h2nIXTq5rscSOCRALIHC
   GsbpypGL4KSaXmgI2uy3AFleFVbL+X3mkFYrqx2T8u91BFnFYCUBg89oW
   +CkJfF1+jiYW0BLrai3DTVA178LZ5ESt3pyxOFgjI8Cce7sV+Zo3+Ysyr
   N284sCqy9/ndPb8I896f3dIf80W7iZbU+6m5LE5KzVtsrHvONysucyKo8
   A==;
X-CSE-ConnectionGUID: LX2d54BqS+Wp2gWUu/jTlQ==
X-CSE-MsgGUID: 59bElpnfRyqIxzp5KxUh9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11208"; a="38010297"
X-IronPort-AV: E=Sophos;i="6.11,160,1725346800"; 
   d="scan'208";a="38010297"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2024 20:14:59 -0700
X-CSE-ConnectionGUID: iP6YItpgTdSoIYXcSdk0dw==
X-CSE-MsgGUID: Md4subOjQ6W4vxZisgCsLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,160,1725346800"; 
   d="scan'208";a="72700528"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 27 Sep 2024 20:14:58 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1suNv5-000MsZ-2e;
	Sat, 28 Sep 2024 03:14:55 +0000
Date: Sat, 28 Sep 2024 11:14:20 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 d1b8f40d000887720e0c123c382d75e7fbb75cb6
Message-ID: <202409281114.0PjyrkMJ-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: d1b8f40d000887720e0c123c382d75e7fbb75cb6  Merge branch into tip/master: 'x86/splitlock'

elapsed time: 987m

configs tested: 145
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-13.3.0
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                                 defconfig    gcc-14.1.0
arc                        nsim_700_defconfig    gcc-14.1.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                       aspeed_g4_defconfig    gcc-14.1.0
arm                          collie_defconfig    gcc-14.1.0
arm                                 defconfig    gcc-14.1.0
arm                             pxa_defconfig    gcc-14.1.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
i386                             allmodconfig    clang-18
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-18
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-18
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20240928    clang-18
i386        buildonly-randconfig-002-20240928    clang-18
i386        buildonly-randconfig-003-20240928    clang-18
i386        buildonly-randconfig-004-20240928    clang-18
i386        buildonly-randconfig-005-20240928    clang-18
i386        buildonly-randconfig-006-20240928    clang-18
i386                                defconfig    clang-18
i386                  randconfig-001-20240928    clang-18
i386                  randconfig-002-20240928    clang-18
i386                  randconfig-003-20240928    clang-18
i386                  randconfig-004-20240928    clang-18
i386                  randconfig-005-20240928    clang-18
i386                  randconfig-006-20240928    clang-18
i386                  randconfig-011-20240928    clang-18
i386                  randconfig-012-20240928    clang-18
i386                  randconfig-013-20240928    clang-18
i386                  randconfig-014-20240928    clang-18
i386                  randconfig-015-20240928    clang-18
i386                  randconfig-016-20240928    clang-18
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
m68k                          multi_defconfig    gcc-14.1.0
m68k                           sun3_defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                            gpr_defconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.1.0
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
openrisc                 simple_smp_defconfig    gcc-14.1.0
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.1.0
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.1.0
powerpc                          allyesconfig    gcc-14.1.0
powerpc                     mpc512x_defconfig    gcc-14.1.0
powerpc                     tqm5200_defconfig    gcc-14.1.0
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.1.0
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
s390                       zfcpdump_defconfig    gcc-14.1.0
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                          rsk7201_defconfig    gcc-14.1.0
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
um                               alldefconfig    gcc-14.1.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64      buildonly-randconfig-001-20240928    clang-18
x86_64      buildonly-randconfig-002-20240928    clang-18
x86_64      buildonly-randconfig-003-20240928    clang-18
x86_64      buildonly-randconfig-004-20240928    clang-18
x86_64      buildonly-randconfig-005-20240928    clang-18
x86_64      buildonly-randconfig-006-20240928    clang-18
x86_64                              defconfig    clang-18
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-18
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20240928    clang-18
x86_64                randconfig-002-20240928    clang-18
x86_64                randconfig-003-20240928    clang-18
x86_64                randconfig-004-20240928    clang-18
x86_64                randconfig-005-20240928    clang-18
x86_64                randconfig-006-20240928    clang-18
x86_64                randconfig-011-20240928    clang-18
x86_64                randconfig-012-20240928    clang-18
x86_64                randconfig-013-20240928    clang-18
x86_64                randconfig-014-20240928    clang-18
x86_64                randconfig-015-20240928    clang-18
x86_64                randconfig-016-20240928    clang-18
x86_64                randconfig-071-20240928    clang-18
x86_64                randconfig-072-20240928    clang-18
x86_64                randconfig-073-20240928    clang-18
x86_64                randconfig-074-20240928    clang-18
x86_64                randconfig-075-20240928    clang-18
x86_64                randconfig-076-20240928    clang-18
x86_64                               rhel-8.3    gcc-12
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

