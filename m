Return-Path: <linux-kernel+bounces-393317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CB59B9F16
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 11:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F09851C20E42
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 10:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1856C1714C4;
	Sat,  2 Nov 2024 10:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kys5V09Z"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F1E42070
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 10:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730545056; cv=none; b=GuNLuAGDOOtsBnTjRvZ64R/Zh1O0DOpBUnUdKzDz/2tGc1vbU3rOSOCDByjn6Ee9F3r2s+D76kpwB2NA7uZoHbZKqY7wAHeoTwX9jfm9f8oVfWyfu75/1ls1k7x1tQrH2jj/Gf8Ss3pIxdwxyJ/aJ+Z6NNERqdRdS49Zg7CQ74U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730545056; c=relaxed/simple;
	bh=X1CHzBXHTaQsy12nNRXxUcress+uqhJd/8MrfL+YveE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=OpANAsBDxWQqHwix4p3wJ8o/0S441qbLuiLppEOumza3a9RmrcM0OPHBOvHcVRBfoXm9MG9N9bi2KsizxuIzJrIZncg6Xautv6UaOkRmllLqbfEu8UKToCv885CUlr/7tGDfWyPaUWd6CienRPK3A1SyMaxl+eGC0Lt1LvBt8AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kys5V09Z; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730545055; x=1762081055;
  h=date:from:to:cc:subject:message-id;
  bh=X1CHzBXHTaQsy12nNRXxUcress+uqhJd/8MrfL+YveE=;
  b=Kys5V09ZQx4ip1mnPwzmDrgZREPi9oFLFSA679NSuTGDQlIeUY3Q56Jk
   +zsKZSBD26Xm3mTV+nfOqm4crFLYCod+fs3+XqxIrumySjUApJi+jXk7V
   jI13DUstKr3xjaayWvVAeTwnNdL3lZVgXGc2Dv6tNzCvNuspH7Yd74StM
   JGvWFgMA/wOYXZ6Odi/au8Op2mjWdkdtkQJj0mLK6kb40vCk/ZDiBcEtd
   e8fwDEjfcfIe1WVSC0BYLr+yAWt4MCsOwCupG2LJKugVfZRA3ID+UFfLK
   5smPlOcsUeAZFd8so5Gn2a8ORhk/0BrnA2PkpUoYGPPaYKwnKLQ4CbgpR
   Q==;
X-CSE-ConnectionGUID: 11TWCyB7SO6npk2Qgkhzng==
X-CSE-MsgGUID: Kt5aNtvKStCFVJ97A7e9iw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="52866186"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="52866186"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2024 03:57:33 -0700
X-CSE-ConnectionGUID: T5ZBFvSjR5Cws58iZ2rncA==
X-CSE-MsgGUID: Nj/hZvOTT82u2STR6d7TMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,252,1725346800"; 
   d="scan'208";a="113979779"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 02 Nov 2024 03:57:33 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t7Bov-000ioF-2V;
	Sat, 02 Nov 2024 10:57:29 +0000
Date: Sat, 02 Nov 2024 18:56:52 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:irq/core] BUILD SUCCESS
 0053892ff7d4bab5efdb4def0fd211ec36e26f69
Message-ID: <202411021838.92lubVnu-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
branch HEAD: 0053892ff7d4bab5efdb4def0fd211ec36e26f69  irqchip/mips-gic: Fix selection of GENERIC_IRQ_EFFECTIVE_AFF_MASK

elapsed time: 789m

configs tested: 135
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                   randconfig-001-20241102    gcc-14.1.0
arc                   randconfig-002-20241102    gcc-14.1.0
arc                           tb10x_defconfig    gcc-14.1.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                            dove_defconfig    gcc-14.1.0
arm                        multi_v5_defconfig    gcc-14.1.0
arm                   randconfig-001-20241102    gcc-14.1.0
arm                   randconfig-002-20241102    gcc-14.1.0
arm                   randconfig-003-20241102    gcc-14.1.0
arm                   randconfig-004-20241102    gcc-14.1.0
arm                           tegra_defconfig    gcc-14.1.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                 randconfig-001-20241102    gcc-14.1.0
arm64                 randconfig-002-20241102    gcc-14.1.0
arm64                 randconfig-003-20241102    gcc-14.1.0
arm64                 randconfig-004-20241102    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                  randconfig-001-20241102    gcc-14.1.0
csky                  randconfig-002-20241102    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon               randconfig-001-20241102    gcc-14.1.0
hexagon               randconfig-002-20241102    gcc-14.1.0
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                             allyesconfig    clang-19
i386        buildonly-randconfig-001-20241102    gcc-12
i386        buildonly-randconfig-002-20241102    gcc-12
i386        buildonly-randconfig-003-20241102    gcc-12
i386        buildonly-randconfig-004-20241102    gcc-12
i386        buildonly-randconfig-005-20241102    gcc-12
i386        buildonly-randconfig-006-20241102    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20241102    gcc-12
i386                  randconfig-002-20241102    gcc-12
i386                  randconfig-003-20241102    gcc-12
i386                  randconfig-004-20241102    gcc-12
i386                  randconfig-005-20241102    gcc-12
i386                  randconfig-006-20241102    gcc-12
i386                  randconfig-011-20241102    gcc-12
i386                  randconfig-012-20241102    gcc-12
i386                  randconfig-013-20241102    gcc-12
i386                  randconfig-014-20241102    gcc-12
i386                  randconfig-015-20241102    gcc-12
i386                  randconfig-016-20241102    gcc-12
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch             randconfig-001-20241102    gcc-14.1.0
loongarch             randconfig-002-20241102    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                        m5307c3_defconfig    gcc-14.1.0
m68k                        m5407c3_defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                           ip30_defconfig    gcc-14.1.0
nios2                            alldefconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                 randconfig-001-20241102    gcc-14.1.0
nios2                 randconfig-002-20241102    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20241102    gcc-14.1.0
parisc                randconfig-002-20241102    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.1.0
powerpc                      arches_defconfig    gcc-14.1.0
powerpc                    mvme5100_defconfig    gcc-14.1.0
powerpc                      pasemi_defconfig    gcc-14.1.0
powerpc               randconfig-001-20241102    gcc-14.1.0
powerpc               randconfig-002-20241102    gcc-14.1.0
powerpc               randconfig-003-20241102    gcc-14.1.0
powerpc64             randconfig-001-20241102    gcc-14.1.0
powerpc64             randconfig-002-20241102    gcc-14.1.0
powerpc64             randconfig-003-20241102    gcc-14.1.0
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20241102    gcc-14.1.0
riscv                 randconfig-002-20241102    gcc-14.1.0
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20241102    gcc-14.1.0
s390                  randconfig-002-20241102    gcc-14.1.0
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                             espt_defconfig    gcc-14.1.0
sh                    randconfig-001-20241102    gcc-14.1.0
sh                    randconfig-002-20241102    gcc-14.1.0
sh                        sh7785lcr_defconfig    gcc-14.1.0
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20241102    gcc-14.1.0
sparc64               randconfig-002-20241102    gcc-14.1.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241102    gcc-14.1.0
um                    randconfig-002-20241102    gcc-14.1.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64                              defconfig    clang-19
x86_64                                  kexec    clang-19
x86_64                                  kexec    gcc-12
x86_64                               rhel-8.3    gcc-12
xtensa                            allnoconfig    gcc-14.1.0
xtensa                          iss_defconfig    gcc-14.1.0
xtensa                randconfig-001-20241102    gcc-14.1.0
xtensa                randconfig-002-20241102    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

