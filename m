Return-Path: <linux-kernel+bounces-287344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFFD59526B4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 02:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D45BF1C21C0F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 00:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B65310E5;
	Thu, 15 Aug 2024 00:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E/x17dRP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B5AA20
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 00:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723680948; cv=none; b=fq7EAp0uqW24oNeup+fLJ+XVXOLhpim9NaNaxKRa7J3AobMcX2ql7wgKgL2uj3bTPrIyFyakdFEqTKmNFOyDMyCwF9DtjO5JorZHk4pgu9x93+4FHBzZIOduQOqqpxI6z2B2Xn5p8iXATPYrUNXNS020ODjKrdebX2zBBOX+ogE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723680948; c=relaxed/simple;
	bh=UaZK112B7DFrPpmURnEwHt7GraRWZ+zuC8uXPZ4WpK4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=PmR4e81ympT8NBo1Mj2AqcqMsfQ177HrJ2gxMeHK70pkNz8/5bwTX3iFhMTS60dyacYLRF7BpFKIGjVjQts8xHne/hAThEJPXFce7/pJL5ce23WqMc0qCnzD4d8xaKC+E+DHkDuFAwRpEPPcdsfcmACGF9deO6FNg/EQac100VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E/x17dRP; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723680946; x=1755216946;
  h=date:from:to:cc:subject:message-id;
  bh=UaZK112B7DFrPpmURnEwHt7GraRWZ+zuC8uXPZ4WpK4=;
  b=E/x17dRP3MHGw48alTUy1vXvjNQPVbWUJWwYzo9zUdkjnmc8c+Ab3wbx
   gj6+KwWX/qBPnHbWa0NOhvqLqZVVRcSNHjkRlJwscpVFUkVwoj31owpfz
   UAV31h84A7etPrINCk6vzvZRx3cq0gekeZfrEvtgHJkV7ahrp2nhGySwb
   KiZJuI4SPmS1ix5ZZ+FMkC2ylrhvtTagsd9Yj/GD5vJ/TppXApfHiUCVh
   gXDGhcF4uBPnP5mb4tTVd1QtznPVGu/NoNukPapbELSHWpks1CRtgoMQV
   EeEF/WcshKKsYToT2BGXx1D1YcHBG1ODNiotYzOo0CgCnKUN96+7Ul7ZQ
   w==;
X-CSE-ConnectionGUID: vSacfDJjRRS9s283c4AXLA==
X-CSE-MsgGUID: 6V0FerHrQ5Wjq3Rx9hP8hg==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="22094426"
X-IronPort-AV: E=Sophos;i="6.10,147,1719903600"; 
   d="scan'208";a="22094426"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 17:15:45 -0700
X-CSE-ConnectionGUID: AePVkvj9THGu1ZvN2yoKyg==
X-CSE-MsgGUID: +s2I8CDtRfe/QKYtVeP+Qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,147,1719903600"; 
   d="scan'208";a="59343532"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 14 Aug 2024 17:15:45 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1seO9W-0002za-28;
	Thu, 15 Aug 2024 00:15:42 +0000
Date: Thu, 15 Aug 2024 08:15:33 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/platform] BUILD SUCCESS
 22f42697265589534df9b109fe0b0efa36896509
Message-ID: <202408150831.BHRM1H8S-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/platform
branch HEAD: 22f42697265589534df9b109fe0b0efa36896509  x86/platform/uv: Remove unused declaration uv_irq_2_mmr_info()

elapsed time: 726m

configs tested: 81
configs skipped: 129

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arm                              alldefconfig   gcc-14.1.0
arm                               allnoconfig   gcc-13.2.0
arm                        clps711x_defconfig   gcc-14.1.0
arm                            dove_defconfig   gcc-14.1.0
arm64                             allnoconfig   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-12
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-12
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240814   clang-18
i386         buildonly-randconfig-001-20240815   gcc-12
i386         buildonly-randconfig-002-20240814   clang-18
i386         buildonly-randconfig-002-20240815   gcc-12
i386         buildonly-randconfig-003-20240814   clang-18
i386         buildonly-randconfig-003-20240815   gcc-12
i386         buildonly-randconfig-004-20240814   clang-18
i386         buildonly-randconfig-004-20240815   gcc-12
i386         buildonly-randconfig-005-20240814   gcc-12
i386         buildonly-randconfig-005-20240815   gcc-12
i386         buildonly-randconfig-006-20240814   gcc-12
i386         buildonly-randconfig-006-20240815   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240814   clang-18
i386                  randconfig-001-20240815   gcc-12
i386                  randconfig-002-20240814   gcc-12
i386                  randconfig-002-20240815   gcc-12
i386                  randconfig-003-20240814   gcc-12
i386                  randconfig-003-20240815   gcc-12
i386                  randconfig-004-20240814   clang-18
i386                  randconfig-004-20240815   gcc-12
i386                  randconfig-005-20240814   clang-18
i386                  randconfig-005-20240815   gcc-12
i386                  randconfig-006-20240814   clang-18
i386                  randconfig-006-20240815   gcc-12
i386                  randconfig-011-20240814   gcc-12
i386                  randconfig-011-20240815   gcc-12
i386                  randconfig-012-20240814   gcc-12
i386                  randconfig-012-20240815   gcc-12
i386                  randconfig-013-20240814   clang-18
i386                  randconfig-013-20240815   gcc-12
i386                  randconfig-014-20240814   gcc-11
i386                  randconfig-014-20240815   gcc-12
i386                  randconfig-015-20240814   gcc-12
i386                  randconfig-015-20240815   gcc-12
i386                  randconfig-016-20240814   gcc-12
i386                  randconfig-016-20240815   gcc-12
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-14.1.0
mips                              allnoconfig   gcc-13.2.0
mips                  cavium_octeon_defconfig   gcc-14.1.0
mips                           ci20_defconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-13.2.0
powerpc                        cell_defconfig   gcc-14.1.0
powerpc                     sequoia_defconfig   gcc-14.1.0
powerpc                     tqm8548_defconfig   gcc-14.1.0
s390                             allmodconfig   clang-20
s390                             allyesconfig   clang-20
sh                                allnoconfig   gcc-13.2.0
sh                 kfr2r09-romimage_defconfig   gcc-14.1.0
sh                          kfr2r09_defconfig   gcc-14.1.0
sh                      rts7751r2d1_defconfig   gcc-14.1.0
sh                           se7750_defconfig   gcc-14.1.0
sh                   sh7724_generic_defconfig   gcc-14.1.0
sparc                       sparc64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-11
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

