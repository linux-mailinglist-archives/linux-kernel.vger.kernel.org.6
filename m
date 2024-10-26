Return-Path: <linux-kernel+bounces-382917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3869B14E3
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 06:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 091391F22777
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 04:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7D1166F29;
	Sat, 26 Oct 2024 04:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UyEk6lqE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C141013C80C
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 04:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729917890; cv=none; b=f8eBmQWuwNDXeVKves5Ylzn0Q90SpvRTpEnCFVhPjVCIbjq1ARUiQzhHfHq5hl+GPDOS9CvhWhQyTR+QAZ9toLeDkz3B8ky2BWjcUK3JFjWEGRZ4mFmq+lJwz1ln3fNbtMDd/jGTWgZSb7KyWXaR8CSZCqnHHdWvItE5hTp2stE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729917890; c=relaxed/simple;
	bh=OrotBtnmWbtn+V+ZCdK3Qow2XexrBOldcI2IoC3rAGQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=jyeDTlgHYQLL9VxggTcePu8sliy6bDWGhfUwJ2u27BEK+OVNREg/TiXGDy7hYuKB86royTl/g33GlBhZwBs1PHTYpeLz7YumMm4Pg0eeoFkOS+UfApB0o2OLeOVa6nGnyoqIDkUBsN5DTmdD5FpWJFSV/ZNChwkC42iv6I+B9iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UyEk6lqE; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729917888; x=1761453888;
  h=date:from:to:cc:subject:message-id;
  bh=OrotBtnmWbtn+V+ZCdK3Qow2XexrBOldcI2IoC3rAGQ=;
  b=UyEk6lqEmwYdlSA6DMAlOqri5pY8ZXrMuIagd8m/XRCCwZJODt+ffV8n
   A9LfYKQIfF+VEw5hGHFcEK96QElummSEcbrmlSHGvA6YnsoauKuJu+CY3
   trrb9Fg++on0I6oCn2FV6aBRajcV+C/uf9brJqGns2BwlurRhtiJfJd09
   o/WRHykQ1mrrx0Nneu0rw4kCBROybknDArXfkVb+Z3GfYhxPkCeasRqeq
   2bpM6fucVwr7rLAWPyMfZwuJDQPlCm3k0hvs9M/uyfFzg5aYxx4wcEGvw
   NKKUsf3sLkO+s7qXO4Ib1OHBjyqANwaQDGKzCPh/Ke37vew/eab1SVjuz
   Q==;
X-CSE-ConnectionGUID: FPnFNMb8S7GanrDX2Jq8ig==
X-CSE-MsgGUID: qUKIMBiSQoysu5ELz6ZJvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="29489385"
X-IronPort-AV: E=Sophos;i="6.11,234,1725346800"; 
   d="scan'208";a="29489385"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 21:44:47 -0700
X-CSE-ConnectionGUID: KAj+I7SORsq1XONqyAU0fg==
X-CSE-MsgGUID: gnkv6ub9SD+MJe0mc4faog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,234,1725346800"; 
   d="scan'208";a="111919129"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 25 Oct 2024 21:44:46 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t4YfM-000ZHm-0y;
	Sat, 26 Oct 2024 04:44:44 +0000
Date: Sat, 26 Oct 2024 12:44:04 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/microcode] BUILD SUCCESS
 9a819753b0209c6edebdea447a1aa53e8c697653
Message-ID: <202410261256.u7b7zhhi-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/microcode
branch HEAD: 9a819753b0209c6edebdea447a1aa53e8c697653  x86/microcode/intel: Remove unnecessary cache writeback and invalidation

elapsed time: 736m

configs tested: 101
configs skipped: 130

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.1.0
arc                              alldefconfig    clang-17
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                                 defconfig    gcc-14.1.0
arc                 nsimosci_hs_smp_defconfig    clang-17
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                                 defconfig    gcc-14.1.0
arm                       imx_v4_v5_defconfig    clang-17
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                             allyesconfig    clang-19
i386        buildonly-randconfig-001-20241026    gcc-12
i386        buildonly-randconfig-002-20241026    gcc-12
i386        buildonly-randconfig-003-20241026    gcc-12
i386        buildonly-randconfig-004-20241026    gcc-12
i386        buildonly-randconfig-005-20241026    gcc-12
i386        buildonly-randconfig-006-20241026    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20241026    gcc-12
i386                  randconfig-002-20241026    gcc-12
i386                  randconfig-003-20241026    gcc-12
i386                  randconfig-004-20241026    gcc-12
i386                  randconfig-005-20241026    gcc-12
i386                  randconfig-006-20241026    gcc-12
i386                  randconfig-011-20241026    gcc-12
i386                  randconfig-012-20241026    gcc-12
i386                  randconfig-013-20241026    gcc-12
i386                  randconfig-014-20241026    gcc-12
i386                  randconfig-015-20241026    gcc-12
i386                  randconfig-016-20241026    gcc-12
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                          atari_defconfig    clang-17
m68k                                defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                           ci20_defconfig    clang-17
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                            defconfig    gcc-12
parisc                            allnoconfig    clang-20
parisc                              defconfig    gcc-12
parisc64                            defconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                     asp8347_defconfig    clang-17
powerpc                        icon_defconfig    clang-17
powerpc                 mpc8313_rdb_defconfig    clang-17
powerpc                      ppc64e_defconfig    clang-17
powerpc                      ppc6xx_defconfig    clang-17
riscv                             allnoconfig    clang-20
riscv                               defconfig    gcc-12
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                          r7780mp_defconfig    clang-17
sh                   rts7751r2dplus_defconfig    clang-17
sh                           se7721_defconfig    clang-17
sh                   sh7724_generic_defconfig    clang-17
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64                              defconfig    clang-19
x86_64                                  kexec    clang-19
x86_64                                  kexec    gcc-12
x86_64                               rhel-8.3    gcc-12
xtensa                            allnoconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

