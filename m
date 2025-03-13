Return-Path: <linux-kernel+bounces-560154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D3EA5FEC9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 19:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BA031892CD6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 18:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4599B1E8353;
	Thu, 13 Mar 2025 18:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T/g6A82l"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C8C3E47B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 18:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741889223; cv=none; b=c9pC0izxUEVMsfzjKMyOa9XGd3WxEr2lSV+S4yIM7oLm5Os6/giFlz8Kp3SNfJhnJhc200LSSpDoAJ3bhUS8kJL4/MTQCGknQZjM6MB6KEAMcMyEjPcPOEVL/YBKle3vpYCik/qh0HXGh5/XvdOlUqxR20JKc020Sukkdxnt5gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741889223; c=relaxed/simple;
	bh=2NI/LfUGAJ3WISSmJRhkqp+GnLcJJ36JKp0ctnw92Kg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Elz9RwZ2Pg70w+5hOCrI0aXhbPgBBqQmF77YPBvbkKKLyWmbGJ9XDXDmMxQESjeW1me25DGpHZUWa23WP+q4gLsjGAK2DiHYJLO+OegnYn12ovVeMJ4aJ207t0XdEf6AW8UcPZwyNNZz5JQdA9YvsGrajAgvQIIfDDEbJId94ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T/g6A82l; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741889222; x=1773425222;
  h=date:from:to:cc:subject:message-id;
  bh=2NI/LfUGAJ3WISSmJRhkqp+GnLcJJ36JKp0ctnw92Kg=;
  b=T/g6A82lYJOxF/P3sDdKL1vlHngkrqbsIbcSKLK556bsMtyPQQLcX5jM
   3agHMvn+7brMM0zLCXSJM0kg/T/Oc9dFx/oIzAGd/3IqtlHrtramtXhhF
   hg+C5pA/uazaud1u49HUm0KJfwhL1edJARsk1jANFT1pHueyB/V+XtEj7
   Loo5imk1bsbFqujlRRR3amd0sV2vxd4SWkpmg41Eid7VTzGT0Wd6xowGx
   KrMuCYg+xWLOzXYl/EPc3CjqVcdxFPH5uI1hdkd3jnbQ6v9PK3EuseM8Z
   T2gX1YfpONx7rCRM4S9ueqS7FUQvgH1yCdKq4KtpodYdTUtAnyR2KjBPg
   w==;
X-CSE-ConnectionGUID: l2OrR/PBQUeePcTvoTA08g==
X-CSE-MsgGUID: QyWG4l+USnWjOf3lTZBZGw==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="42749585"
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="42749585"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 11:07:01 -0700
X-CSE-ConnectionGUID: reL2MlRMTlajTWhPzYpQ9Q==
X-CSE-MsgGUID: 9LPmzcssTfC9yinS7+wtcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="121741838"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 13 Mar 2025 11:06:59 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tsmxN-0009je-12;
	Thu, 13 Mar 2025 18:06:57 +0000
Date: Fri, 14 Mar 2025 02:06:26 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/cache] BUILD SUCCESS
 823beb31e55673bf2fd21374e095eec73a761ee7
Message-ID: <202503140220.xjWMkHyE-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cache
branch HEAD: 823beb31e55673bf2fd21374e095eec73a761ee7  x86/resctrl: Move get_{mon,ctrl}_domain_from_cpu() to live with their callers

elapsed time: 1454m

configs tested: 191
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-21
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    clang-18
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-18
arc                              allyesconfig    gcc-13.2.0
arc                          axs103_defconfig    gcc-14.2.0
arc                   randconfig-001-20250313    clang-18
arc                   randconfig-001-20250313    gcc-13.2.0
arc                   randconfig-002-20250313    clang-18
arc                   randconfig-002-20250313    gcc-13.2.0
arm                              allmodconfig    clang-18
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-18
arm                              allyesconfig    gcc-14.2.0
arm                       aspeed_g5_defconfig    gcc-14.2.0
arm                           h3600_defconfig    gcc-14.2.0
arm                       imx_v6_v7_defconfig    gcc-14.2.0
arm                          pxa910_defconfig    gcc-14.2.0
arm                   randconfig-001-20250313    clang-16
arm                   randconfig-001-20250313    clang-18
arm                   randconfig-002-20250313    clang-18
arm                   randconfig-003-20250313    clang-18
arm                   randconfig-003-20250313    gcc-14.2.0
arm                   randconfig-004-20250313    clang-18
arm                   randconfig-004-20250313    clang-21
arm                           sama5_defconfig    gcc-14.2.0
arm                         wpcm450_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250313    clang-18
arm64                 randconfig-002-20250313    clang-16
arm64                 randconfig-002-20250313    clang-18
arm64                 randconfig-003-20250313    clang-18
arm64                 randconfig-003-20250313    gcc-14.2.0
arm64                 randconfig-004-20250313    clang-18
arm64                 randconfig-004-20250313    clang-21
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250313    gcc-14.2.0
csky                  randconfig-002-20250313    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-18
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250313    clang-17
hexagon               randconfig-001-20250313    gcc-14.2.0
hexagon               randconfig-002-20250313    clang-21
hexagon               randconfig-002-20250313    gcc-14.2.0
i386                             allmodconfig    clang-19
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-19
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-19
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250313    clang-19
i386        buildonly-randconfig-001-20250313    gcc-12
i386        buildonly-randconfig-002-20250313    clang-19
i386        buildonly-randconfig-002-20250313    gcc-12
i386        buildonly-randconfig-003-20250313    clang-19
i386        buildonly-randconfig-004-20250313    clang-19
i386        buildonly-randconfig-004-20250313    gcc-12
i386        buildonly-randconfig-005-20250313    clang-19
i386        buildonly-randconfig-006-20250313    clang-19
i386        buildonly-randconfig-006-20250313    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20250313    clang-19
i386                  randconfig-002-20250313    clang-19
i386                  randconfig-003-20250313    clang-19
i386                  randconfig-004-20250313    clang-19
i386                  randconfig-005-20250313    clang-19
i386                  randconfig-006-20250313    clang-19
i386                  randconfig-007-20250313    clang-19
i386                  randconfig-011-20250313    clang-19
i386                  randconfig-012-20250313    clang-19
i386                  randconfig-013-20250313    clang-19
i386                  randconfig-014-20250313    clang-19
i386                  randconfig-015-20250313    clang-19
i386                  randconfig-016-20250313    clang-19
i386                  randconfig-017-20250313    clang-19
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250313    gcc-14.2.0
loongarch             randconfig-002-20250313    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          ath79_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250313    gcc-14.2.0
nios2                 randconfig-002-20250313    gcc-14.2.0
openrisc                          allnoconfig    clang-15
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-15
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250313    gcc-14.2.0
parisc                randconfig-002-20250313    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-15
powerpc                          allyesconfig    clang-16
powerpc                   currituck_defconfig    gcc-14.2.0
powerpc                      katmai_defconfig    gcc-14.2.0
powerpc                     kmeter1_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250313    clang-16
powerpc               randconfig-001-20250313    gcc-14.2.0
powerpc               randconfig-002-20250313    clang-18
powerpc               randconfig-002-20250313    gcc-14.2.0
powerpc               randconfig-003-20250313    gcc-14.2.0
powerpc64             randconfig-001-20250313    gcc-14.2.0
powerpc64             randconfig-002-20250313    gcc-14.2.0
powerpc64             randconfig-003-20250313    gcc-14.2.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    clang-15
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250313    clang-21
riscv                 randconfig-001-20250313    gcc-14.2.0
riscv                 randconfig-002-20250313    clang-21
riscv                 randconfig-002-20250313    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250313    clang-15
s390                  randconfig-001-20250313    gcc-14.2.0
s390                  randconfig-002-20250313    clang-15
s390                  randconfig-002-20250313    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250313    gcc-14.2.0
sh                    randconfig-002-20250313    gcc-14.2.0
sh                          rsk7269_defconfig    gcc-14.2.0
sh                           sh2007_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250313    gcc-14.2.0
sparc                 randconfig-002-20250313    gcc-14.2.0
sparc                       sparc64_defconfig    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250313    gcc-14.2.0
sparc64               randconfig-002-20250313    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-15
um                               allyesconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250313    clang-21
um                    randconfig-001-20250313    gcc-14.2.0
um                    randconfig-002-20250313    clang-21
um                    randconfig-002-20250313    gcc-14.2.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250313    clang-19
x86_64      buildonly-randconfig-002-20250313    clang-19
x86_64      buildonly-randconfig-003-20250313    clang-19
x86_64      buildonly-randconfig-004-20250313    clang-19
x86_64      buildonly-randconfig-004-20250313    gcc-12
x86_64      buildonly-randconfig-005-20250313    clang-19
x86_64      buildonly-randconfig-006-20250313    clang-19
x86_64      buildonly-randconfig-006-20250313    gcc-12
x86_64                              defconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20250313    gcc-12
x86_64                randconfig-002-20250313    gcc-12
x86_64                randconfig-003-20250313    gcc-12
x86_64                randconfig-004-20250313    gcc-12
x86_64                randconfig-005-20250313    gcc-12
x86_64                randconfig-006-20250313    gcc-12
x86_64                randconfig-007-20250313    gcc-12
x86_64                randconfig-008-20250313    gcc-12
x86_64                randconfig-071-20250313    gcc-12
x86_64                randconfig-072-20250313    gcc-12
x86_64                randconfig-073-20250313    gcc-12
x86_64                randconfig-074-20250313    gcc-12
x86_64                randconfig-075-20250313    gcc-12
x86_64                randconfig-076-20250313    gcc-12
x86_64                randconfig-077-20250313    gcc-12
x86_64                randconfig-078-20250313    gcc-12
x86_64                               rhel-9.4    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250313    gcc-14.2.0
xtensa                randconfig-002-20250313    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

