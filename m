Return-Path: <linux-kernel+bounces-516015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2F6A36BFF
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 05:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 735A2170FBF
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 04:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A481624F5;
	Sat, 15 Feb 2025 04:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kINOvs7q"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13CDC8E0
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 04:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739593799; cv=none; b=NlS8Q64a6RqOJQx9siF2IO/h/TcMWGlb3oS24lIx5f9gYdEThRF7BE/6Qrcy9oga2waJrT2QTWT4+gJ69KlrEMbpjrMNh0tsmveG5eQM9ha3rK7iAl5OWLEklsrLJ7Us1WwPjIN9QEHyj5mJN4gR3lAZF7N2I3bcHnjOEKiQm50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739593799; c=relaxed/simple;
	bh=71jC/vn+3UG4GpWJPSDbGYfEUOJEqW0udSL9XqQgKtc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=DVD05Gcc02n0jDU+4JZxC/kZQvFBfbdjYfctex6cZmTae9XrhOc1VcJXh2vBIHMaiBBhjFhpthIR3LAIpnSunHx3jwo+GkTiKoy3tEuBQAiiJMmQ//EA4izjh/4NUyqsEGIhfGqa6jldhUfx8/+KzUnUkFL6PijP10I4fawatPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kINOvs7q; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739593797; x=1771129797;
  h=date:from:to:cc:subject:message-id;
  bh=71jC/vn+3UG4GpWJPSDbGYfEUOJEqW0udSL9XqQgKtc=;
  b=kINOvs7q2VOrxOpBdvjfeBJSeud91VIdXp8f/ZU7kse8vOiYecx5S6Ag
   0+Xy/tmfVBeg2SzOq6/VGt0ODRtXweMwJCJ4qAzHTPhvqqL//SBwgHZqY
   ld0X6n6ZKzDyFZ/PgJ1FQEq7NcIwWyhiv8+tttg1MmHrMGHAtEtQ6WvK5
   g0czz/6EvFY01iSkMPah4ch3mi9oEr+EXoas7MfJFV2liWcnpC2cG8h3e
   BCZWDh9vJVfE+6/PFMvOiFANFH2udRiSQvYHsGIeBmMl9rJFwSyH+z+jy
   lzEBsHIErFELAuq4kft95oaHwaAjmsQxrnaYh+zVlhHcI4nR/sT6M40Qx
   w==;
X-CSE-ConnectionGUID: OFtk/I3lQHyLvV0XhbYYhw==
X-CSE-MsgGUID: iZeqS3QsR4S8Xn7t2Jh9RA==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="40271037"
X-IronPort-AV: E=Sophos;i="6.13,287,1732608000"; 
   d="scan'208";a="40271037"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 20:29:57 -0800
X-CSE-ConnectionGUID: HWD0v5ToRQKRIRFRK5K5fQ==
X-CSE-MsgGUID: /8dB8dATTUmfng4sBOsi8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,287,1732608000"; 
   d="scan'208";a="113610082"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 14 Feb 2025 20:29:56 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tj9oP-001AVH-2P;
	Sat, 15 Feb 2025 04:29:53 +0000
Date: Sat, 15 Feb 2025 12:29:46 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/wfamnae-next20250210-2] BUILD SUCCESS
 34c7452d336a112bfbc3e5cf7a2e286bc010647a
Message-ID: <202502151239.ta1RKzy2-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/wfamnae-next20250210-2
branch HEAD: 34c7452d336a112bfbc3e5cf7a2e286bc010647a  drm/amd/pm: Avoid multiple -Wflex-array-member-not-at-end warnings

elapsed time: 1450m

configs tested: 107
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250214    gcc-13.2.0
arc                   randconfig-002-20250214    gcc-13.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                   randconfig-001-20250214    clang-16
arm                   randconfig-002-20250214    gcc-14.2.0
arm                   randconfig-003-20250214    clang-21
arm                   randconfig-004-20250214    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250214    gcc-14.2.0
arm64                 randconfig-002-20250214    gcc-14.2.0
arm64                 randconfig-003-20250214    gcc-14.2.0
arm64                 randconfig-004-20250214    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250214    gcc-14.2.0
csky                  randconfig-002-20250214    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250214    clang-21
hexagon               randconfig-002-20250214    clang-15
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250214    gcc-12
i386        buildonly-randconfig-002-20250214    gcc-12
i386        buildonly-randconfig-003-20250214    clang-19
i386        buildonly-randconfig-004-20250214    gcc-12
i386        buildonly-randconfig-005-20250214    gcc-12
i386        buildonly-randconfig-006-20250214    gcc-12
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250214    gcc-14.2.0
loongarch             randconfig-002-20250214    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250214    gcc-14.2.0
nios2                 randconfig-002-20250214    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250214    gcc-14.2.0
parisc                randconfig-002-20250214    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc               randconfig-001-20250214    gcc-14.2.0
powerpc               randconfig-002-20250214    clang-18
powerpc               randconfig-003-20250214    clang-21
powerpc64             randconfig-001-20250214    clang-18
powerpc64             randconfig-002-20250214    gcc-14.2.0
powerpc64             randconfig-003-20250214    gcc-14.2.0
riscv                             allnoconfig    gcc-14.2.0
riscv                               defconfig    clang-19
riscv                 randconfig-001-20250214    clang-18
riscv                 randconfig-002-20250214    gcc-14.2.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20250214    gcc-14.2.0
s390                  randconfig-002-20250214    clang-19
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                    randconfig-001-20250214    gcc-14.2.0
sh                    randconfig-002-20250214    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250214    gcc-14.2.0
sparc                 randconfig-002-20250214    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250214    gcc-14.2.0
sparc64               randconfig-002-20250214    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250214    gcc-12
um                    randconfig-002-20250214    clang-16
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250214    clang-19
x86_64      buildonly-randconfig-002-20250214    clang-19
x86_64      buildonly-randconfig-003-20250214    gcc-12
x86_64      buildonly-randconfig-004-20250214    clang-19
x86_64      buildonly-randconfig-005-20250214    gcc-12
x86_64      buildonly-randconfig-006-20250214    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250214    gcc-14.2.0
xtensa                randconfig-002-20250214    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

