Return-Path: <linux-kernel+bounces-559526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E31A5F500
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 13:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80FDF1891C29
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00892676D3;
	Thu, 13 Mar 2025 12:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ak9/AcPO"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E60266590
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 12:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741870570; cv=none; b=pB70HcpRw9YcaZF+TTNFSGAeiGMAefzikZDF08nNu8M8d2l9yr1J80Na4nWcNIalAWoh9HOIJDznF939AUFyIIa1c11uEwkAC28JFa15Mz5aI4UOA4Mbxui0RkcS6JD6+PV3BrCwhhYHiNw/8X7Ua7vDZvjknjyhkzOP5y4z2LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741870570; c=relaxed/simple;
	bh=8F793LJ/XqJodb0KFLqXCFX39m+RBf1cwEzrXcD6P0s=;
	h=Date:From:To:Cc:Subject:Message-ID; b=HsEriofL9RKFBM3jxu01eI4w/hefYFtgSPdmxR+HNfdul2dWDfudnW+l7skqihy5oH7ipN9ucQViN1D0r+jIGMm5jwmyU/KFRB/sydPhEtDLueoL+mtV/NFScBP3V/SkYXDUCwqu+6877zZUuS0zd0KbAG5l+h5eDwuiLyr4U9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ak9/AcPO; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741870568; x=1773406568;
  h=date:from:to:cc:subject:message-id;
  bh=8F793LJ/XqJodb0KFLqXCFX39m+RBf1cwEzrXcD6P0s=;
  b=Ak9/AcPOU1WOVGLeFGZob+4RjiPagPYW6+4tVrHfc+KnJBEq9c3ltceI
   xlf5ohiljCgcPqUq5abfK/RnMzStYB2/nRD/AoCLMTBOkRT9Fc+cZbBof
   RseeYxn77cfnbc3mrGFrlWX1NJpARns22auXAvljVeKJTSkkBIyCugSeb
   r1hGv60dTxIKmuepKwm2DMR4SweCcgOYtAs2pHEaYbkwhzpVXJaDCnNzX
   jCr0QSH6mj0yxpticgzOZ9GTJjrsEJqK7PwvUn9LoYIHvFYVNmJ7EBOhi
   qZBM7n572iF8ZYr8CQ5hJ5npGLzkG1/AfvAumHhnBmThsPpM8qM99G26n
   Q==;
X-CSE-ConnectionGUID: l7m6l3N3R6WbRdPCLh2i+A==
X-CSE-MsgGUID: v0OXC8ilRR2QKrgdiLIOYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="53620871"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="53620871"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 05:56:07 -0700
X-CSE-ConnectionGUID: KJ8SLAMeSM2AD0yo4neb1w==
X-CSE-MsgGUID: /HbtrGx2TwCUSYNy05Arzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="120940588"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 13 Mar 2025 05:56:06 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tsi6V-0009PO-2e;
	Thu, 13 Mar 2025 12:56:03 +0000
Date: Thu, 13 Mar 2025 20:55:10 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/build] BUILD SUCCESS
 e471a86a8c523eccdfd1c4745ed7ac7cbdcc1f3f
Message-ID: <202503132003.BX2KfWKI-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/build
branch HEAD: e471a86a8c523eccdfd1c4745ed7ac7cbdcc1f3f  x86/boot: Add back some padding for the CRC-32 checksum

elapsed time: 1451m

configs tested: 110
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-13.2.0
arc                   randconfig-001-20250312    gcc-13.2.0
arc                   randconfig-002-20250312    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                   randconfig-001-20250312    clang-19
arm                   randconfig-002-20250312    clang-21
arm                   randconfig-003-20250312    clang-19
arm                   randconfig-004-20250312    clang-21
arm                        vexpress_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250312    clang-21
arm64                 randconfig-002-20250312    gcc-14.2.0
arm64                 randconfig-003-20250312    gcc-14.2.0
arm64                 randconfig-004-20250312    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250312    gcc-14.2.0
csky                  randconfig-002-20250312    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250312    clang-21
hexagon               randconfig-002-20250312    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250312    clang-19
i386        buildonly-randconfig-002-20250312    clang-19
i386        buildonly-randconfig-003-20250312    gcc-12
i386        buildonly-randconfig-004-20250312    gcc-12
i386        buildonly-randconfig-005-20250312    gcc-12
i386        buildonly-randconfig-006-20250312    clang-19
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250312    gcc-14.2.0
loongarch             randconfig-002-20250312    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                           gcw0_defconfig    clang-15
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250312    gcc-14.2.0
nios2                 randconfig-002-20250312    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                randconfig-001-20250312    gcc-14.2.0
parisc                randconfig-002-20250312    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                 mpc832x_rdb_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250312    clang-21
powerpc               randconfig-002-20250312    clang-21
powerpc               randconfig-003-20250312    clang-21
powerpc                     sequoia_defconfig    clang-17
powerpc64             randconfig-001-20250312    clang-17
powerpc64             randconfig-002-20250312    clang-15
powerpc64             randconfig-003-20250312    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                 randconfig-001-20250312    clang-21
riscv                 randconfig-002-20250312    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250312    clang-15
s390                  randconfig-002-20250312    clang-16
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                          landisk_defconfig    gcc-14.2.0
sh                    randconfig-001-20250312    gcc-14.2.0
sh                    randconfig-002-20250312    gcc-14.2.0
sh                          rsk7264_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250312    gcc-14.2.0
sparc                 randconfig-002-20250312    gcc-14.2.0
sparc64               randconfig-001-20250312    gcc-14.2.0
sparc64               randconfig-002-20250312    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                    randconfig-001-20250312    gcc-12
um                    randconfig-002-20250312    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250312    clang-19
x86_64      buildonly-randconfig-002-20250312    clang-19
x86_64      buildonly-randconfig-003-20250312    gcc-12
x86_64      buildonly-randconfig-004-20250312    clang-19
x86_64      buildonly-randconfig-005-20250312    clang-19
x86_64      buildonly-randconfig-006-20250312    clang-19
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250312    gcc-14.2.0
xtensa                randconfig-002-20250312    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

