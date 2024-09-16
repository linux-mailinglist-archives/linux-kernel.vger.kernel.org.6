Return-Path: <linux-kernel+bounces-330890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 559F097A5BA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 18:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E92828CD10
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 16:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB43A15A86A;
	Mon, 16 Sep 2024 16:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ar/D3dMg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19131598F4
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 16:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726502861; cv=none; b=NiM3I+03+tMHqXXczWTzhLSf/uEHV0PJKUhWDmUK3aE2AOXblaGIzIE3PTy6Z2NBx9sbvj+Qbby0nHGQvXEK9l4ea8C0UToDXVNEPOa9t3GgsvjIcXng4JLLQ6KAsUrBWZHAGQVAzTeGQKluveP1+jarwLHgtZ7ZyleHMBCYWqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726502861; c=relaxed/simple;
	bh=9GBT6BdqjI23JcxY/dwmEHHRX6T2dQv/syYs8NGwo8A=;
	h=Date:From:To:Cc:Subject:Message-ID; b=uVOrRutdKPtMg/Ijvg/U4LMZxzIZ3akP3s37QgS20RdZtt/SzfmDtynP3wpEPCrmcyOW4u8/qlAEsaj0+ADzRolE0k3LbcYPZ2KrFdWfCmA/onBovVtjcmzeLqc0IKUIfNpRIIij6xsEpzR9LqwbENKoo8iWWVbbsZUF8Jrf1xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ar/D3dMg; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726502859; x=1758038859;
  h=date:from:to:cc:subject:message-id;
  bh=9GBT6BdqjI23JcxY/dwmEHHRX6T2dQv/syYs8NGwo8A=;
  b=Ar/D3dMgZRyWdCi6sGRb+9HKIHEl7dtzpUqT5vP6vHP19Fa3MjZH90Qg
   FUr7kt6s6spdB3AL24rxVEX7LvBmb+g6gSf3ZbcOGI+bmtu1oUq3zEVv3
   c/ub60Q/to5QJzJu67Z11bgkrxRq97gYt4V1wm8iDQDpWaP1fxEXR5O26
   yxOJFQkMk6vRglqFfEhmcJ8Ljt/HY5VlLsmO0ej8+51HMtN3hRMTqQmgp
   Javg82fQIFcKrR6tphUDSZouCcr13mBF98KeG0SoGdgHCRk0jY2FEblxG
   bm6AAcwngTJG/KGaAuSTzqj99fNcW4+Vbup1Px7yGjbRwtpQaxtk8FJJX
   g==;
X-CSE-ConnectionGUID: 8mDSdTE2ROivu2hv9yUVNg==
X-CSE-MsgGUID: Wpj3ynmoSz+Zq+s36NLkqQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11197"; a="25211938"
X-IronPort-AV: E=Sophos;i="6.10,233,1719903600"; 
   d="scan'208";a="25211938"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2024 09:07:16 -0700
X-CSE-ConnectionGUID: zvhc1wasQGWG8vHntPowXg==
X-CSE-MsgGUID: zT+O4u12QxmLR5b1EIwZ8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,233,1719903600"; 
   d="scan'208";a="73681682"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 16 Sep 2024 09:07:14 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sqEFr-000AEw-1B;
	Mon, 16 Sep 2024 16:07:11 +0000
Date: Tue, 17 Sep 2024 00:06:34 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 e26a543cdd84f21d29ed25a25a0e0642dfd81cfb
Message-ID: <202409170026.GHhgSIrt-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: e26a543cdd84f21d29ed25a25a0e0642dfd81cfb  Merge branch into tip/master: 'x86/timers'

elapsed time: 1520m

configs tested: 114
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                                 defconfig    gcc-14.1.0
arc                     haps_hs_smp_defconfig    gcc-14.1.0
arc                    vdk_hs38_smp_defconfig    gcc-14.1.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                                 defconfig    gcc-14.1.0
arm                          exynos_defconfig    gcc-14.1.0
arm                         wpcm450_defconfig    gcc-14.1.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
i386                             allmodconfig    clang-18
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-18
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-18
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20240916    clang-18
i386        buildonly-randconfig-002-20240916    clang-18
i386        buildonly-randconfig-003-20240916    clang-18
i386        buildonly-randconfig-004-20240916    clang-18
i386        buildonly-randconfig-005-20240916    clang-18
i386        buildonly-randconfig-006-20240916    clang-18
i386                                defconfig    clang-18
i386                  randconfig-001-20240916    clang-18
i386                  randconfig-002-20240916    clang-18
i386                  randconfig-003-20240916    clang-18
i386                  randconfig-004-20240916    clang-18
i386                  randconfig-005-20240916    clang-18
i386                  randconfig-006-20240916    clang-18
i386                  randconfig-011-20240916    clang-18
i386                  randconfig-012-20240916    clang-18
i386                  randconfig-013-20240916    clang-18
i386                  randconfig-014-20240916    clang-18
i386                  randconfig-015-20240916    clang-18
i386                  randconfig-016-20240916    clang-18
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
m68k                       m5208evb_defconfig    gcc-14.1.0
m68k                        stmark2_defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                       bmips_be_defconfig    gcc-14.1.0
mips                          eyeq6_defconfig    gcc-14.1.0
mips                          rb532_defconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.1.0
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc64                         alldefconfig    gcc-14.1.0
parisc64                            defconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.1.0
powerpc                          g5_defconfig    gcc-14.1.0
powerpc                      tqm8xx_defconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                           sh2007_defconfig    gcc-14.1.0
sh                              ul2_defconfig    gcc-14.1.0
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64                              defconfig    clang-18
x86_64                              defconfig    gcc-11
x86_64                           rhel-8.3-bpf    gcc-12
x86_64                         rhel-8.3-kunit    gcc-12
x86_64                           rhel-8.3-ltp    gcc-12
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0
xtensa                generic_kc705_defconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

