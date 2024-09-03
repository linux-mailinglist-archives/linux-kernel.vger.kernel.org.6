Return-Path: <linux-kernel+bounces-313848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E2296AAB0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 23:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D47952815A0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 21:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C151CE71A;
	Tue,  3 Sep 2024 21:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wzf+qvpI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F43126C05
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 21:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725400537; cv=none; b=pjv1SQHP0uPljZC3BSla+HLWPipBBUZMcHiFoDCmivMhTHCTv3eSlwDqkxck2Jj8jSrVsNIQQ9j4eTjuUT6tzC6YwJ19xadHfuMFNmcd7q7xCnp2thtqXnpZY626pbVJg1rptwG3vknzaKRGRS/lOBw/pbBhqrMYHhpFHhSOWF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725400537; c=relaxed/simple;
	bh=dNbTF0tJ7wfDr1D5iZLJN8q8FGeMRD37GaJW6kmAqN0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=AF04ykKN7CaIFiyttzh+X0MdWtDYtkSbIw5Wu3kjZHcviP0kJRZvzsIj5I4zxruEgKmJWFbkzwddkdbjKryHNV3erDW/I/skbJrhdEYM2hIQFvqvy9L5BR+MxtqUmlBNj3FdPfUmKIEcc8sVEJbgpU7nCg6mvyVy+hRnS8/X6po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wzf+qvpI; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725400536; x=1756936536;
  h=date:from:to:cc:subject:message-id;
  bh=dNbTF0tJ7wfDr1D5iZLJN8q8FGeMRD37GaJW6kmAqN0=;
  b=Wzf+qvpIypmDlgXnl+Zv/e/RQO7BGLuxqV428KU1K2qzw/InOVP8RTYK
   p4Y0Js2AHbnLYBTHd1Qf6s8nsXTBj/rHA4w2nGmYPg9M/RKqmXBkrSGT0
   jZcIhVq0Ulqh2PrYimYOYvTyYlrmQEoK22pKwpXn6L4BoJiYNnwAdp41M
   uVgpYh9G/BNyDBS0u+h2qHFx+Zgq3KI6Q8EWu+bgVvuf/Hi0VT3+z2m/d
   lBdJGGRehcJt++jU3Y/Z0bgaCtDM54qcW5lbeV6yk7yIbQGIi+sEI6E5/
   B6c+OKCksNFv4fVcE5/xEYaMijQB1h/0fMeZap/OSz2apgTrHJ/SxbebG
   g==;
X-CSE-ConnectionGUID: oJdLU9CiSUq1aIrExs/tXQ==
X-CSE-MsgGUID: BOeoJRAXQOmFMcztaWJ3mA==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="35185241"
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="35185241"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 14:55:35 -0700
X-CSE-ConnectionGUID: Dmxg5LjbSd6U3Voe3pkiQw==
X-CSE-MsgGUID: owL2TbotQxuzVT2IJ9/dbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="65557975"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 03 Sep 2024 14:55:34 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1slbUp-0007Aw-1U;
	Tue, 03 Sep 2024 21:55:31 +0000
Date: Wed, 04 Sep 2024 05:54:43 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/cpu] BUILD SUCCESS
 fd82221a59fa5ce9dc7523e11c5e995104a28cb0
Message-ID: <202409040541.Bf4nksM8-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cpu
branch HEAD: fd82221a59fa5ce9dc7523e11c5e995104a28cb0  x86/cpu/intel: Replace PAT erratum model/family magic numbers with symbolic IFM references

elapsed time: 739m

configs tested: 104
configs skipped: 129

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   clang-20
alpha                               defconfig   gcc-14.1.0
arc                              allmodconfig   clang-20
arc                              allyesconfig   clang-20
arc                                 defconfig   gcc-14.1.0
arm                              allmodconfig   clang-20
arm                              allyesconfig   clang-20
arm                     am200epdkit_defconfig   clang-20
arm                         assabet_defconfig   clang-20
arm                         axm55xx_defconfig   clang-20
arm                                 defconfig   gcc-14.1.0
arm                      jornada720_defconfig   clang-20
arm                        spear3xx_defconfig   clang-20
arm                        spear6xx_defconfig   clang-20
arm64                            allmodconfig   clang-20
arm64                               defconfig   gcc-14.1.0
csky                                defconfig   gcc-14.1.0
hexagon                          allmodconfig   clang-20
hexagon                          allyesconfig   clang-20
hexagon                             defconfig   gcc-14.1.0
i386                             allmodconfig   clang-18
i386                              allnoconfig   clang-18
i386                             allyesconfig   clang-18
i386                                defconfig   clang-18
loongarch                        allmodconfig   gcc-14.1.0
loongarch                           defconfig   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-14.1.0
m68k                        m5407c3_defconfig   clang-20
m68k                       m5475evb_defconfig   clang-20
m68k                           virt_defconfig   clang-20
microblaze                       allmodconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-14.1.0
mips                           ip28_defconfig   clang-20
mips                     loongson2k_defconfig   clang-20
mips                      malta_kvm_defconfig   clang-20
mips                         rt305x_defconfig   clang-20
nios2                               defconfig   gcc-14.1.0
openrisc                          allnoconfig   clang-20
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-12
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   clang-20
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-12
parisc64                            defconfig   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   clang-20
powerpc                          allyesconfig   gcc-14.1.0
powerpc                        icon_defconfig   clang-20
powerpc                  mpc885_ads_defconfig   clang-20
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   clang-20
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   clang-20
riscv                               defconfig   gcc-12
s390                             allmodconfig   gcc-14.1.0
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-12
sh                               allmodconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-12
sparc                            allmodconfig   gcc-14.1.0
sparc64                          alldefconfig   clang-20
sparc64                             defconfig   gcc-12
um                               allmodconfig   clang-20
um                                allnoconfig   clang-20
um                               allyesconfig   clang-20
um                                  defconfig   gcc-12
um                             i386_defconfig   gcc-12
um                           x86_64_defconfig   gcc-12
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240904   clang-18
x86_64       buildonly-randconfig-002-20240904   clang-18
x86_64       buildonly-randconfig-003-20240904   clang-18
x86_64       buildonly-randconfig-004-20240904   clang-18
x86_64       buildonly-randconfig-005-20240904   clang-18
x86_64       buildonly-randconfig-006-20240904   clang-18
x86_64                              defconfig   clang-18
x86_64                                  kexec   gcc-12
x86_64                randconfig-001-20240904   clang-18
x86_64                randconfig-002-20240904   clang-18
x86_64                randconfig-003-20240904   clang-18
x86_64                randconfig-004-20240904   clang-18
x86_64                randconfig-005-20240904   clang-18
x86_64                randconfig-006-20240904   clang-18
x86_64                randconfig-011-20240904   clang-18
x86_64                randconfig-012-20240904   clang-18
x86_64                randconfig-013-20240904   clang-18
x86_64                randconfig-014-20240904   clang-18
x86_64                randconfig-015-20240904   clang-18
x86_64                randconfig-016-20240904   clang-18
x86_64                randconfig-071-20240904   clang-18
x86_64                randconfig-072-20240904   clang-18
x86_64                randconfig-073-20240904   clang-18
x86_64                randconfig-074-20240904   clang-18
x86_64                randconfig-075-20240904   clang-18
x86_64                randconfig-076-20240904   clang-18
x86_64                          rhel-8.3-rust   clang-18
x86_64                               rhel-8.3   gcc-12

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

