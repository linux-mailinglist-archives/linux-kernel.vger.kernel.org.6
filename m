Return-Path: <linux-kernel+bounces-527099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C211A4074B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 11:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59E2D19C2D3E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 10:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B487F207DFD;
	Sat, 22 Feb 2025 10:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KMFEwMQ/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A5F5223
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 10:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740219253; cv=none; b=r7A1uxEZq2vU8pwPEbCRKOSWtWZZ6Aza/50V7biY5fcvR9ylwLetZtuhSe4Vp5sdXCMNrwBtYlVOfbeJcO8H7zFYzgMyXzBSm80nFuQPCKmdM/VJE4pyG7Wcmit6dgXLZzPGBpBd1oRsnvEQtCFRcn3jVYNEh1KA6YKv5oPim8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740219253; c=relaxed/simple;
	bh=/L4ISuyVMXpc9iMWxcOA2vo4kwP4h4sUVhVfxALtVV0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=J7fw/z6csL3HdzEPNTPH1sIUQNBbT3trF6j/bccNZFnv2EE+nX7bI+eSGiPMDMhClckj8q6SyEyJqmaNroS4PyskZQrEDrQG55HXwOyPi4qjXV2MX8oj948FmFos+XBaBEcD0HT5UrI8O8qi9toPm+3FdFigloSyl5BYM6nF2BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KMFEwMQ/; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740219251; x=1771755251;
  h=date:from:to:cc:subject:message-id;
  bh=/L4ISuyVMXpc9iMWxcOA2vo4kwP4h4sUVhVfxALtVV0=;
  b=KMFEwMQ/cLQsAHrRl2Z/o+CvFVSCK7OKm9npEdBggcnSq2FOaMJTWKJU
   MnTFpc4FilrKHBbTMr6r248lW1xjomJweBez7bhmJmsK0QgcXOdJWFOcl
   X19ovJbsh00XpGgDUBN/BYmlMOpyiHLrCqNXXXLKAAYj3dUOp5ogRp7ua
   iefajlwywCKuB0+LkIKbXg8lxx2IKj6VG+csqTp1dapoQ3kHoEaPVsXpW
   Ks1OaOb+rE2JGQVWMU57/hDlQnMgot05WhyIvRGKQBFTGWxHkfLw0HeWz
   OrC+/TFxgpT37nAUkiKd1scPM0tfMIRXxoAPlFdaiQ8QFRVSCu5G0rDRU
   Q==;
X-CSE-ConnectionGUID: njiVR5xTRFC1CiQ3kY3urg==
X-CSE-MsgGUID: agr5OPuyQFe/hmgt9G+bgw==
X-IronPort-AV: E=McAfee;i="6700,10204,11352"; a="28634864"
X-IronPort-AV: E=Sophos;i="6.13,307,1732608000"; 
   d="scan'208";a="28634864"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2025 02:14:10 -0800
X-CSE-ConnectionGUID: dDL2Rts/QMyMOQPH6ap+8Q==
X-CSE-MsgGUID: exZ4Z4yOREaE6RCo/FmHGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,307,1732608000"; 
   d="scan'208";a="120514043"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 22 Feb 2025 02:14:10 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tlmWI-0006TT-0e;
	Sat, 22 Feb 2025 10:14:03 +0000
Date: Sat, 22 Feb 2025 18:13:53 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:timers/vdso] BUILD SUCCESS
 ac1a42f4e4e296b5ba5fdb39444f65d6e5196240
Message-ID: <202502221846.WoooTQrM-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/vdso
branch HEAD: ac1a42f4e4e296b5ba5fdb39444f65d6e5196240  vdso: Remove remnants of architecture-specific time storage

elapsed time: 1469m

configs tested: 91
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250221    gcc-13.2.0
arc                   randconfig-002-20250221    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                              allyesconfig    gcc-14.2.0
arm                   randconfig-001-20250221    gcc-14.2.0
arm                   randconfig-002-20250221    clang-19
arm                   randconfig-003-20250221    gcc-14.2.0
arm                   randconfig-004-20250221    clang-21
arm64                            allmodconfig    clang-18
arm64                 randconfig-001-20250221    clang-15
arm64                 randconfig-002-20250221    clang-21
arm64                 randconfig-003-20250221    clang-21
arm64                 randconfig-004-20250221    gcc-14.2.0
csky                  randconfig-001-20250221    gcc-14.2.0
csky                  randconfig-002-20250221    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250221    clang-21
hexagon               randconfig-002-20250221    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386        buildonly-randconfig-001-20250221    gcc-12
i386        buildonly-randconfig-002-20250221    gcc-12
i386        buildonly-randconfig-003-20250221    gcc-12
i386        buildonly-randconfig-004-20250221    gcc-12
i386        buildonly-randconfig-005-20250221    clang-19
i386        buildonly-randconfig-006-20250221    clang-19
loongarch             randconfig-001-20250221    gcc-14.2.0
loongarch             randconfig-002-20250221    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250221    gcc-14.2.0
nios2                 randconfig-002-20250221    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250221    gcc-14.2.0
parisc                randconfig-002-20250221    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc               randconfig-001-20250221    clang-21
powerpc               randconfig-002-20250221    clang-21
powerpc               randconfig-003-20250221    clang-17
powerpc64             randconfig-001-20250221    clang-21
powerpc64             randconfig-002-20250221    clang-21
powerpc64             randconfig-003-20250221    clang-19
riscv                             allnoconfig    gcc-14.2.0
riscv                               defconfig    clang-19
riscv                 randconfig-001-20250221    clang-21
riscv                 randconfig-002-20250221    clang-21
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250221    gcc-14.2.0
s390                  randconfig-002-20250221    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                    randconfig-001-20250221    gcc-14.2.0
sh                    randconfig-002-20250221    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250221    gcc-14.2.0
sparc                 randconfig-002-20250221    gcc-14.2.0
sparc64               randconfig-001-20250221    gcc-14.2.0
sparc64               randconfig-002-20250221    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                    randconfig-001-20250221    gcc-12
um                    randconfig-002-20250221    gcc-12
x86_64                            allnoconfig    clang-19
x86_64      buildonly-randconfig-001-20250221    gcc-12
x86_64      buildonly-randconfig-002-20250221    clang-19
x86_64      buildonly-randconfig-003-20250221    clang-19
x86_64      buildonly-randconfig-004-20250221    clang-19
x86_64      buildonly-randconfig-005-20250221    clang-19
x86_64      buildonly-randconfig-006-20250221    clang-19
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250221    gcc-14.2.0
xtensa                randconfig-002-20250221    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

