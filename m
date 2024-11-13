Return-Path: <linux-kernel+bounces-407202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C72969C6A1F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 08:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EDE3B2545A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 07:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1E318870D;
	Wed, 13 Nov 2024 07:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hM9zmP3B"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967D118562F
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 07:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731483759; cv=none; b=NkPUAhiuIGoBylEGeowHVrJrpWBREHWR47fGyQzLRMNewbpoJX0d1z9rXbwZ8O24Tu7fH1mlWq6i7y0O2xPV1v90e2Z6z3pb/OFYLeikJFtLPnVqWEUqmS3TFv/VXBbs/OVockIjKX+zLqb955c8yjA39GnnylJBQCH9mVoPwaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731483759; c=relaxed/simple;
	bh=8ysPASlkbNXHD73og71M2aHLW60DiVRb7OhZhNWbGr0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=bY+ULWau2F0pRPLOW/OGhkUj7UVmE83QBqhs7PnnilFtBRAX9gxP24ZjbHAmagm2QpPqqBY056QrbC3wRKdwo+D2VSeWE65QHh/0eDFhp3+3vt0LtUfJvxXCePAchvqDbCvhji10+ZjWRAh/r+8kfx0ul9jWqsu2+WGZKRuSE88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hM9zmP3B; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731483758; x=1763019758;
  h=date:from:to:cc:subject:message-id;
  bh=8ysPASlkbNXHD73og71M2aHLW60DiVRb7OhZhNWbGr0=;
  b=hM9zmP3BMZP/zc1QwHoz59rNIrVKPc//vWEP0n+vHFoxonxUWu2l3Hm8
   IcUATQQ2tnplEq2m+GxBxpajQLG6Mb2BZOH6fG0jOHikJsMumqBKZNUw+
   ef+7N/FFA25AMhQVZ4YpuSSGjxOmJ0JyQlgFu/LJIoqmiYSA6tlrxKwJv
   fSJNXfps+vspd4YWwhZ6sfOFuFoyWEwgYa/iaE0vV++hsVKo4icW/4asd
   QhKT27wyfO8J0P+nm+Hj6Oxg37G8NqaQNNKdlcwyIbTMAFffc2gFtZVai
   6TF4C+OkgiNhisThNNrxPW3Ct+Oje8GKtOXzoT/Qqt1CMwb+CnebEivBx
   g==;
X-CSE-ConnectionGUID: lQMP/Ha8RBWQqQ3TW+8BKA==
X-CSE-MsgGUID: 3iKvh5dNR/qenrylNdBN2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="41975253"
X-IronPort-AV: E=Sophos;i="6.12,150,1728975600"; 
   d="scan'208";a="41975253"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 23:42:37 -0800
X-CSE-ConnectionGUID: gwC23Wd0ST+ONhpq02ayQA==
X-CSE-MsgGUID: JNiiOVkZQdCCqnbkiWx3+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,150,1728975600"; 
   d="scan'208";a="88210216"
Received: from lkp-server01.sh.intel.com (HELO 80bd855f15b3) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 12 Nov 2024 23:42:36 -0800
Received: from kbuild by 80bd855f15b3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tB81J-00006o-1w;
	Wed, 13 Nov 2024 07:42:33 +0000
Date: Wed, 13 Nov 2024 15:42:25 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/sgx] BUILD SUCCESS
 f060c89dc1a3cfb6db3894e1d96980a568aa355c
Message-ID: <202411131519.lJtWYlq6-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/sgx
branch HEAD: f060c89dc1a3cfb6db3894e1d96980a568aa355c  x86/sgx: Use vmalloc_array() instead of vmalloc()

elapsed time: 733m

configs tested: 100
configs skipped: 127

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-20
arc                         haps_hs_defconfig    gcc-14.2.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-20
arm                         at91_dt_defconfig    gcc-14.2.0
arm                          collie_defconfig    gcc-14.2.0
arm                          exynos_defconfig    gcc-14.2.0
arm                        mvebu_v5_defconfig    gcc-14.2.0
arm                         s3c6400_defconfig    gcc-14.2.0
arm                         s5pv210_defconfig    gcc-14.2.0
arm                          sp7021_defconfig    gcc-14.2.0
arm                        spear6xx_defconfig    gcc-14.2.0
arm                           stm32_defconfig    gcc-14.2.0
arm                         wpcm450_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-20
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                             allyesconfig    clang-19
i386        buildonly-randconfig-001-20241113    clang-19
i386        buildonly-randconfig-002-20241113    clang-19
i386        buildonly-randconfig-003-20241113    clang-19
i386        buildonly-randconfig-004-20241113    clang-19
i386        buildonly-randconfig-005-20241113    clang-19
i386        buildonly-randconfig-006-20241113    clang-19
i386                                defconfig    clang-19
i386                  randconfig-001-20241113    clang-19
i386                  randconfig-002-20241113    clang-19
i386                  randconfig-003-20241113    clang-19
i386                  randconfig-004-20241113    clang-19
i386                  randconfig-005-20241113    clang-19
i386                  randconfig-006-20241113    clang-19
i386                  randconfig-011-20241113    clang-19
i386                  randconfig-012-20241113    clang-19
i386                  randconfig-013-20241113    clang-19
i386                  randconfig-014-20241113    clang-19
i386                  randconfig-015-20241113    clang-19
i386                  randconfig-016-20241113    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
m68k                             alldefconfig    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          ath79_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
openrisc                          allnoconfig    clang-20
openrisc                       virt_defconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
powerpc                           allnoconfig    clang-20
powerpc                  iss476-smp_defconfig    gcc-14.2.0
powerpc                       maple_defconfig    gcc-14.2.0
powerpc                  mpc885_ads_defconfig    gcc-14.2.0
powerpc                     ppa8548_defconfig    gcc-14.2.0
powerpc                     tqm5200_defconfig    gcc-14.2.0
riscv                             allnoconfig    clang-20
riscv             nommu_k210_sdcard_defconfig    gcc-14.2.0
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                        dreamcast_defconfig    gcc-14.2.0
sh                        edosk7705_defconfig    gcc-14.2.0
sh                        edosk7760_defconfig    gcc-14.2.0
sh                            hp6xx_defconfig    gcc-14.2.0
sh                      rts7751r2d1_defconfig    gcc-14.2.0
sh                           se7705_defconfig    gcc-14.2.0
sh                           se7721_defconfig    gcc-14.2.0
sh                           se7724_defconfig    gcc-14.2.0
sh                           se7750_defconfig    gcc-14.2.0
sh                             sh03_defconfig    gcc-14.2.0
sh                        sh7757lcr_defconfig    gcc-14.2.0
sh                   sh7770_generic_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64                              defconfig    clang-19
x86_64                                  kexec    clang-19
x86_64                                  kexec    gcc-12
x86_64                               rhel-8.3    gcc-12
xtensa                            allnoconfig    gcc-14.2.0
xtensa                         virt_defconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

