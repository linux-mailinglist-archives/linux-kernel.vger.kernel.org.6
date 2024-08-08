Return-Path: <linux-kernel+bounces-279694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9804C94C094
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 17:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8111B2436E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 15:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220A718EFEC;
	Thu,  8 Aug 2024 15:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XX6efhur"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C318A18F2E0
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 15:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723129723; cv=none; b=rJ0HO5iq91X9dO4daKCNs9olqlAN45mZTob4VZWTiLUVFas65pCgeK4+T2vkfCId7R91TmagrPOWenGr3aWSISBmQ8oVP3VCLgOb6/bCtvdOd/HyEKjaNo1AleAGs2VBDxuuSw7Up350+mTixQNR7iwIlzOqFmwgkHI6QzDjIHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723129723; c=relaxed/simple;
	bh=k7ZkFXca7Du9yNufYMnlWGTMkDjjQCxYqgw0MJwdQBU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=qQdAzUsWm0CdHVU28RaNvlTsMYdZsDRsQW97tIgPys1qrvBLZbKOpEfU4AS0FBkcN2aC5XftKcNhhfvas2YdyJo9VIHINZOvVGKF2C5+cUN65jbZ+6UL36nxzHJsKbhMOMuKCLkKYVwnK9GAc+3Q2AIrlz6nCYS7j5Y1uLT7VIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XX6efhur; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723129722; x=1754665722;
  h=date:from:to:cc:subject:message-id;
  bh=k7ZkFXca7Du9yNufYMnlWGTMkDjjQCxYqgw0MJwdQBU=;
  b=XX6efhurzuks/TUj47CrYmSKb94wHW0uGkr77rlxeS/NlxA5N4jQ8S+C
   n1zR7+MCjQqNm/fvN2fqdp+nm8FnxCLx6AJW+B+1xL2omXCcjNVizlL8b
   UkQodXnzgxUM9vGB2BnZOlZvUrW6G0eKN9OfPJVkkZB1oUty1j4qclqYp
   AbXGb/1T2WeiLPOOOOc2KSHA63ggTZtDwrxEXyORsYQRJA7z8A/BourvW
   iPge/CUmYAWVWW6nD3KTQI6iX745hnmpVLe4xpYOo1YROYOs2el+Yon0g
   j0RnOJYP//+PPLOxJeICuvDr7J8SkdI4Nb3ix7Xuesofd6510kL4bdf67
   w==;
X-CSE-ConnectionGUID: DD8XoYY9RxyddpF2X7IM7w==
X-CSE-MsgGUID: lXph6IDKQ5umSW+O5QUtyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="21430837"
X-IronPort-AV: E=Sophos;i="6.09,273,1716274800"; 
   d="scan'208";a="21430837"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 08:08:28 -0700
X-CSE-ConnectionGUID: qSC6guVjSlmFxmiHKuYU2g==
X-CSE-MsgGUID: 63+Vhf9RTOGaA7cXK3YClQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,273,1716274800"; 
   d="scan'208";a="61626352"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 08 Aug 2024 08:08:27 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sc4kb-0006Fy-0n;
	Thu, 08 Aug 2024 15:08:25 +0000
Date: Thu, 08 Aug 2024 23:08:02 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/apic] BUILD SUCCESS
 00e5bd44389145cd2f42be8e98cadb210731e72a
Message-ID: <202408082359.4L3k4Qeo-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/apic
branch HEAD: 00e5bd44389145cd2f42be8e98cadb210731e72a  x86/apic: Remove unused inline function apic_set_eoi_cb()

elapsed time: 1306m

configs tested: 224
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                          axs101_defconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240808   gcc-13.2.0
arc                   randconfig-002-20240808   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-20
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                              allyesconfig   gcc-14.1.0
arm                                 defconfig   gcc-13.2.0
arm                            mmp2_defconfig   gcc-14.1.0
arm                          moxart_defconfig   gcc-14.1.0
arm                        neponset_defconfig   gcc-13.2.0
arm                       netwinder_defconfig   gcc-14.1.0
arm                   randconfig-001-20240808   gcc-13.2.0
arm                   randconfig-002-20240808   gcc-13.2.0
arm                   randconfig-003-20240808   gcc-13.2.0
arm                   randconfig-004-20240808   gcc-13.2.0
arm                             rpc_defconfig   gcc-13.2.0
arm                         s3c6400_defconfig   gcc-13.2.0
arm                           spitz_defconfig   gcc-14.1.0
arm                           stm32_defconfig   gcc-13.2.0
arm64                            allmodconfig   clang-20
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240808   gcc-13.2.0
arm64                 randconfig-002-20240808   gcc-13.2.0
arm64                 randconfig-003-20240808   gcc-13.2.0
arm64                 randconfig-004-20240808   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-13.2.0
csky                                defconfig   gcc-14.1.0
csky                  randconfig-001-20240808   gcc-13.2.0
csky                  randconfig-002-20240808   gcc-13.2.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   clang-20
hexagon                          allyesconfig   clang-20
i386                             alldefconfig   gcc-14.1.0
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-12
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-12
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240808   clang-18
i386         buildonly-randconfig-002-20240808   clang-18
i386         buildonly-randconfig-002-20240808   gcc-12
i386         buildonly-randconfig-003-20240808   clang-18
i386         buildonly-randconfig-004-20240808   clang-18
i386         buildonly-randconfig-005-20240808   clang-18
i386         buildonly-randconfig-006-20240808   clang-18
i386         buildonly-randconfig-006-20240808   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240808   clang-18
i386                  randconfig-001-20240808   gcc-12
i386                  randconfig-002-20240808   clang-18
i386                  randconfig-002-20240808   gcc-12
i386                  randconfig-003-20240808   clang-18
i386                  randconfig-004-20240808   clang-18
i386                  randconfig-004-20240808   gcc-12
i386                  randconfig-005-20240808   clang-18
i386                  randconfig-005-20240808   gcc-12
i386                  randconfig-006-20240808   clang-18
i386                  randconfig-006-20240808   gcc-12
i386                  randconfig-011-20240808   clang-18
i386                  randconfig-012-20240808   clang-18
i386                  randconfig-012-20240808   gcc-11
i386                  randconfig-013-20240808   clang-18
i386                  randconfig-014-20240808   clang-18
i386                  randconfig-014-20240808   gcc-11
i386                  randconfig-015-20240808   clang-18
i386                  randconfig-015-20240808   gcc-12
i386                  randconfig-016-20240808   clang-18
i386                  randconfig-016-20240808   gcc-12
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240808   gcc-13.2.0
loongarch             randconfig-002-20240808   gcc-13.2.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                         apollo_defconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
m68k                       m5275evb_defconfig   gcc-14.1.0
m68k                       m5475evb_defconfig   gcc-13.2.0
m68k                       m5475evb_defconfig   gcc-14.1.0
m68k                        mvme16x_defconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-14.1.0
mips                        bcm47xx_defconfig   gcc-13.2.0
mips                         db1xxx_defconfig   gcc-14.1.0
mips                     decstation_defconfig   gcc-14.1.0
mips                           ip30_defconfig   gcc-14.1.0
mips                     loongson1b_defconfig   gcc-14.1.0
mips                         rt305x_defconfig   gcc-14.1.0
mips                   sb1250_swarm_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240808   gcc-13.2.0
nios2                 randconfig-002-20240808   gcc-13.2.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
openrisc                       virt_defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                generic-32bit_defconfig   gcc-13.2.0
parisc                randconfig-001-20240808   gcc-13.2.0
parisc                randconfig-002-20240808   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   gcc-14.1.0
powerpc                      arches_defconfig   gcc-14.1.0
powerpc                      chrp32_defconfig   gcc-14.1.0
powerpc                 mpc8313_rdb_defconfig   gcc-14.1.0
powerpc               randconfig-001-20240808   gcc-13.2.0
powerpc               randconfig-002-20240808   gcc-13.2.0
powerpc                     redwood_defconfig   gcc-14.1.0
powerpc                     sequoia_defconfig   gcc-14.1.0
powerpc                     skiroot_defconfig   gcc-13.2.0
powerpc64             randconfig-001-20240808   gcc-13.2.0
powerpc64             randconfig-002-20240808   gcc-13.2.0
powerpc64             randconfig-003-20240808   gcc-13.2.0
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-14.1.0
riscv                    nommu_virt_defconfig   gcc-14.1.0
riscv                 randconfig-001-20240808   gcc-13.2.0
riscv                 randconfig-002-20240808   gcc-13.2.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240808   gcc-13.2.0
s390                  randconfig-002-20240808   gcc-13.2.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                    randconfig-001-20240808   gcc-13.2.0
sh                    randconfig-002-20240808   gcc-13.2.0
sh                      rts7751r2d1_defconfig   gcc-14.1.0
sh                           se7705_defconfig   gcc-14.1.0
sh                           se7721_defconfig   gcc-13.2.0
sh                        sh7757lcr_defconfig   gcc-14.1.0
sh                        sh7763rdp_defconfig   gcc-14.1.0
sparc                            alldefconfig   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240808   gcc-13.2.0
sparc64               randconfig-002-20240808   gcc-13.2.0
um                               allmodconfig   clang-20
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-12
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240808   gcc-13.2.0
um                    randconfig-002-20240808   gcc-13.2.0
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240808   gcc-12
x86_64       buildonly-randconfig-002-20240808   gcc-12
x86_64       buildonly-randconfig-003-20240808   gcc-12
x86_64       buildonly-randconfig-004-20240808   gcc-12
x86_64       buildonly-randconfig-005-20240808   gcc-12
x86_64       buildonly-randconfig-006-20240808   gcc-12
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-11
x86_64                randconfig-001-20240808   gcc-12
x86_64                randconfig-002-20240808   gcc-12
x86_64                randconfig-003-20240808   gcc-12
x86_64                randconfig-004-20240808   gcc-12
x86_64                randconfig-005-20240808   gcc-12
x86_64                randconfig-006-20240808   gcc-12
x86_64                randconfig-011-20240808   gcc-12
x86_64                randconfig-012-20240808   gcc-12
x86_64                randconfig-013-20240808   gcc-12
x86_64                randconfig-014-20240808   gcc-12
x86_64                randconfig-015-20240808   gcc-12
x86_64                randconfig-016-20240808   gcc-12
x86_64                randconfig-071-20240808   gcc-12
x86_64                randconfig-072-20240808   gcc-12
x86_64                randconfig-073-20240808   gcc-12
x86_64                randconfig-074-20240808   gcc-12
x86_64                randconfig-075-20240808   gcc-12
x86_64                randconfig-076-20240808   gcc-12
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                            allnoconfig   gcc-14.1.0
xtensa                       common_defconfig   gcc-14.1.0
xtensa                randconfig-001-20240808   gcc-13.2.0
xtensa                randconfig-002-20240808   gcc-13.2.0
xtensa                    xip_kc705_defconfig   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

