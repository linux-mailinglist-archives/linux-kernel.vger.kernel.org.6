Return-Path: <linux-kernel+bounces-300678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3745C95E718
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 04:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99961B207D4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 02:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E06433DC;
	Mon, 26 Aug 2024 02:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XN0lOars"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20884548E1
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 02:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724641024; cv=none; b=R7BoXhOzdwKszAeOahJdUy0TPWEVNHdfWoCQhy/mCH8Bs75TKZyDaEfptaYCccjRS0T2xgwKCBpZB7aDGZ/eShx+gCw51WzNQKljdW7/OZrRrSg297EuHiOBBjNXji2IRemJjACLIoTmaAMR0NicH16ux3pNFCfKkEhkLNq0TPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724641024; c=relaxed/simple;
	bh=WRWBNqw0EAIZ8MBKcVuK4837byF0EnGLekTeLAlLiIg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=AXnk2zgojyN8GbtkuXfs3OUTL5lqrG18aXLJoeV22cEElosmu1g20G/yRjWvroLqHq3KBW7e5pM01XCqCOgdu55YbK+bmh0OKeKp4qd21A+SPSf7k+N2v7iWm0teJ0rXoeljSswsfe8yx9ChASx5Bsc07B6zowrU6A3s6366yOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XN0lOars; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724641023; x=1756177023;
  h=date:from:to:cc:subject:message-id;
  bh=WRWBNqw0EAIZ8MBKcVuK4837byF0EnGLekTeLAlLiIg=;
  b=XN0lOarsrF/N3GNr6LRGOEAUuNeb7lwA5avs1LrEIcMpwQvSCXIp9W0A
   B8gTs40XaPc0AgSN/GwTPGNmoLkQSNwN5biIONTjKyZARYs8Gh9ZnFe86
   P13cdn65Wpl7FoBWPc+c69Ks/+pLAcF0Ig1IDPUQiZH4iff/8Q7wKYf+u
   SlwdNtQU/Gpl9PrBdq6meaBtCXN2DnM7HOWXRLfCjJctOzbALbe0jf0SD
   8UCW+rkE2yBVIg72jOJ5i43AowH7LIfKLr/ALQ42nLoI2nDiGKoKxOYJ1
   FfFig5RiXPkjsR4WMMNJZQG5hfn4WwqQ6bpiLLb6aQTiM+aFfIbFiSkOG
   Q==;
X-CSE-ConnectionGUID: 8x22SEveTImlnVYg1Bevmw==
X-CSE-MsgGUID: 1jjMwz2RTyWPN6DvbDvqSQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11175"; a="34204282"
X-IronPort-AV: E=Sophos;i="6.10,176,1719903600"; 
   d="scan'208";a="34204282"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2024 19:57:02 -0700
X-CSE-ConnectionGUID: Dgp1xIQuR16nBJpjhdrSig==
X-CSE-MsgGUID: eRyaYnyVTieOSzn9MbrujQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,176,1719903600"; 
   d="scan'208";a="67300402"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 25 Aug 2024 19:57:01 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1siPuc-000Fbz-24;
	Mon, 26 Aug 2024 02:56:58 +0000
Date: Mon, 26 Aug 2024 10:56:18 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:perf/urgent] BUILD SUCCESS
 25dfc9e357af8aed1ca79b318a73f2c59c1f0b2b
Message-ID: <202408261016.KiUVeFfp-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/urgent
branch HEAD: 25dfc9e357af8aed1ca79b318a73f2c59c1f0b2b  perf/x86/intel: Limit the period on Haswell

elapsed time: 725m

configs tested: 102
configs skipped: 129

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                        nsimosci_defconfig   gcc-12.3.0
arm                               allnoconfig   gcc-13.2.0
arm                                 defconfig   gcc-13.2.0
arm                          ixp4xx_defconfig   gcc-12.3.0
arm                       netwinder_defconfig   gcc-12.3.0
arm                           stm32_defconfig   gcc-12.3.0
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
i386                             allmodconfig   gcc-12
i386                              allnoconfig   gcc-12
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240826   clang-18
i386         buildonly-randconfig-002-20240826   gcc-12
i386         buildonly-randconfig-003-20240826   clang-18
i386         buildonly-randconfig-004-20240826   clang-18
i386         buildonly-randconfig-005-20240826   clang-18
i386         buildonly-randconfig-006-20240826   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240826   gcc-12
i386                  randconfig-002-20240826   gcc-12
i386                  randconfig-003-20240826   clang-18
i386                  randconfig-004-20240826   gcc-12
i386                  randconfig-005-20240826   gcc-12
i386                  randconfig-006-20240826   clang-18
i386                  randconfig-011-20240826   gcc-12
i386                  randconfig-012-20240826   gcc-12
i386                  randconfig-013-20240826   gcc-12
i386                  randconfig-014-20240826   gcc-12
i386                  randconfig-015-20240826   gcc-12
i386                  randconfig-016-20240826   gcc-12
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
m68k                                defconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                      bmips_stb_defconfig   gcc-12.3.0
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
openrisc                            defconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc64                            defconfig   gcc-13.2.0
powerpc                 linkstation_defconfig   gcc-12.3.0
powerpc                  mpc866_ads_defconfig   gcc-12.3.0
powerpc                  mpc885_ads_defconfig   gcc-12.3.0
powerpc                      pcm030_defconfig   gcc-12.3.0
riscv                               defconfig   gcc-14.1.0
riscv                    nommu_virt_defconfig   gcc-12.3.0
s390                             allmodconfig   clang-20
s390                             allyesconfig   clang-20
s390                                defconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                                  defconfig   gcc-14.1.0
sh                      rts7751r2d1_defconfig   gcc-12.3.0
sh                   rts7751r2dplus_defconfig   gcc-12.3.0
sh                           se7724_defconfig   gcc-12.3.0
sh                           sh2007_defconfig   gcc-12.3.0
sh                             shx3_defconfig   gcc-12.3.0
sparc64                             defconfig   gcc-14.1.0
um                               allmodconfig   gcc-13.3.0
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-14.1.0
um                           x86_64_defconfig   gcc-14.1.0
x86_64                           alldefconfig   gcc-12.3.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240826   clang-18
x86_64       buildonly-randconfig-002-20240826   gcc-12
x86_64       buildonly-randconfig-003-20240826   gcc-12
x86_64       buildonly-randconfig-004-20240826   gcc-12
x86_64       buildonly-randconfig-005-20240826   clang-18
x86_64       buildonly-randconfig-006-20240826   clang-18
x86_64                              defconfig   gcc-11
x86_64                randconfig-001-20240826   gcc-12
x86_64                randconfig-002-20240826   clang-18
x86_64                randconfig-003-20240826   clang-18
x86_64                randconfig-004-20240826   clang-18
x86_64                randconfig-005-20240826   gcc-12
x86_64                randconfig-006-20240826   clang-18
x86_64                randconfig-011-20240826   clang-18
x86_64                randconfig-012-20240826   clang-18
x86_64                randconfig-013-20240826   gcc-12
x86_64                randconfig-014-20240826   gcc-12
x86_64                randconfig-015-20240826   clang-18
x86_64                randconfig-016-20240826   clang-18
x86_64                randconfig-071-20240826   clang-18
x86_64                randconfig-072-20240826   clang-18
x86_64                randconfig-073-20240826   clang-18
x86_64                randconfig-074-20240826   gcc-12
x86_64                randconfig-075-20240826   gcc-12
x86_64                randconfig-076-20240826   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

