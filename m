Return-Path: <linux-kernel+bounces-282151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2695F94E02B
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 07:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 754AA1F21677
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 05:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D8E1AAC4;
	Sun, 11 Aug 2024 05:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hDjrmZOd"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F53F2F5B
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 05:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723355677; cv=none; b=Y2Fy/p90Wn1JzcWWJn6KNstedHAwLDt4zKHkORPb7isZ1p+gPqnh+cSAZ3pYcuiwy6V+4Fy8JY1QO8zd347ZC4JEDgRiUcU9i+chkyI2CIjbEOE2tq+rRyisdMNP8HpoJZiYMK3o8LbAeaklxd46c4SiBNeYXBChJbS683ZmJIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723355677; c=relaxed/simple;
	bh=UC76N+Mw0v7Qz7IkhGTc2SZvYO9VJ+H0SjbbZ1HwSaY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=igGTW1qvdV8fk6eWdSBfj9aAdyDiwmv3rufWl81I/zcz/roAzYAogISZTtlH+5C2lVOn6CZSBVai7PDjuDNiys+VWY+B7h90bIIViX5DuDh6sxKwlvLWjuI1MyU/Hp16YYbRtku6TFgl503q+FQK+kDlBW/4Bnth84USN0umPks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hDjrmZOd; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723355675; x=1754891675;
  h=date:from:to:cc:subject:message-id;
  bh=UC76N+Mw0v7Qz7IkhGTc2SZvYO9VJ+H0SjbbZ1HwSaY=;
  b=hDjrmZOdMMAKJDVxAcBsoGzUE01NdXRBNMIhMH04GsU5J1y3uaEpvF7L
   8Dn27KQas1C05OQX3VYn4ABHDjln5yRsmt8oUPLzGMOwhbfTj3u5T/W2Z
   fuZb/w8o/PDjcNZUwG2dPGEGbQmrukRNToSw7ET2cuhbde3JBBvTNvmSS
   HuPIDFb99W+h623/pV/PTHiamFzewwn6Bn/SR+ckDwmvBttn+6FEzGY2f
   nrzSg7yUGBbdyW6IjtqEsM4NM7CwhuNphyaz2iriyj8v4exl+WVz7dJ7u
   5QahYphbtFE8D3gwGgX85o5eXpJ+jsXGHQm9v4M6xcH0S4i+Y2gQYDTV9
   g==;
X-CSE-ConnectionGUID: 1YQSRuFhTz2Hrp4ueubwOA==
X-CSE-MsgGUID: HvaXDmK0T4yRPBlF9ioY/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11160"; a="21366723"
X-IronPort-AV: E=Sophos;i="6.09,280,1716274800"; 
   d="scan'208";a="21366723"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2024 22:54:35 -0700
X-CSE-ConnectionGUID: zhMe54IBS5+LzxQZ3dSJGQ==
X-CSE-MsgGUID: Ct0m91DPSjOruGoFSK4EJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,280,1716274800"; 
   d="scan'208";a="57850243"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 10 Aug 2024 22:54:33 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sd1XC-000Act-2U;
	Sun, 11 Aug 2024 05:54:30 +0000
Date: Sun, 11 Aug 2024 13:53:56 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/mm] BUILD SUCCESS
 4276a0bb62598966716e1ee1ac4a64d382cc9ef7
Message-ID: <202408111354.CWK7VOak-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/mm
branch HEAD: 4276a0bb62598966716e1ee1ac4a64d382cc9ef7  x86/mm: Remove unused CR3_HW_ASID_BITS

elapsed time: 1203m

configs tested: 218
configs skipped: 8

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
arc                                 defconfig   gcc-13.2.0
arc                         haps_hs_defconfig   gcc-13.2.0
arc                   randconfig-001-20240811   gcc-13.2.0
arc                   randconfig-002-20240811   gcc-13.2.0
arc                           tb10x_defconfig   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-20
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                              allyesconfig   gcc-14.1.0
arm                         axm55xx_defconfig   gcc-13.2.0
arm                                 defconfig   gcc-13.2.0
arm                            hisi_defconfig   gcc-13.2.0
arm                      integrator_defconfig   gcc-13.2.0
arm                        mvebu_v7_defconfig   gcc-13.2.0
arm                       omap2plus_defconfig   gcc-13.2.0
arm                   randconfig-001-20240811   gcc-13.2.0
arm                   randconfig-002-20240811   gcc-13.2.0
arm                   randconfig-003-20240811   gcc-13.2.0
arm                   randconfig-004-20240811   gcc-13.2.0
arm                        shmobile_defconfig   gcc-13.2.0
arm64                            allmodconfig   clang-20
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240811   gcc-13.2.0
arm64                 randconfig-002-20240811   gcc-13.2.0
arm64                 randconfig-003-20240811   gcc-13.2.0
arm64                 randconfig-004-20240811   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240811   gcc-13.2.0
csky                  randconfig-002-20240811   gcc-13.2.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   clang-20
hexagon                          allyesconfig   clang-20
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-12
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-12
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240810   clang-18
i386         buildonly-randconfig-001-20240811   gcc-12
i386         buildonly-randconfig-002-20240810   clang-18
i386         buildonly-randconfig-002-20240811   gcc-12
i386         buildonly-randconfig-003-20240810   clang-18
i386         buildonly-randconfig-003-20240811   gcc-12
i386         buildonly-randconfig-004-20240810   clang-18
i386         buildonly-randconfig-004-20240811   gcc-12
i386         buildonly-randconfig-005-20240810   gcc-12
i386         buildonly-randconfig-005-20240811   gcc-12
i386         buildonly-randconfig-006-20240810   gcc-12
i386         buildonly-randconfig-006-20240811   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240810   clang-18
i386                  randconfig-001-20240811   gcc-12
i386                  randconfig-002-20240810   gcc-12
i386                  randconfig-002-20240811   gcc-12
i386                  randconfig-003-20240810   clang-18
i386                  randconfig-003-20240811   gcc-12
i386                  randconfig-004-20240810   gcc-12
i386                  randconfig-004-20240811   gcc-12
i386                  randconfig-005-20240810   gcc-12
i386                  randconfig-005-20240811   gcc-12
i386                  randconfig-006-20240810   clang-18
i386                  randconfig-006-20240811   gcc-12
i386                  randconfig-011-20240810   gcc-12
i386                  randconfig-011-20240811   gcc-12
i386                  randconfig-012-20240810   gcc-12
i386                  randconfig-012-20240811   gcc-12
i386                  randconfig-013-20240810   clang-18
i386                  randconfig-013-20240811   gcc-12
i386                  randconfig-014-20240810   gcc-12
i386                  randconfig-014-20240811   gcc-12
i386                  randconfig-015-20240810   gcc-12
i386                  randconfig-015-20240811   gcc-12
i386                  randconfig-016-20240810   gcc-12
i386                  randconfig-016-20240811   gcc-12
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240811   gcc-13.2.0
loongarch             randconfig-002-20240811   gcc-13.2.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
m68k                        mvme147_defconfig   gcc-13.2.0
m68k                           sun3_defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-14.1.0
mips                         bigsur_defconfig   gcc-13.2.0
mips                      bmips_stb_defconfig   gcc-13.2.0
mips                          eyeq6_defconfig   gcc-13.2.0
mips                           ip28_defconfig   gcc-13.2.0
mips                        vocore2_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240811   gcc-13.2.0
nios2                 randconfig-002-20240811   gcc-13.2.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240811   gcc-13.2.0
parisc                randconfig-002-20240811   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-20
powerpc                          allyesconfig   gcc-14.1.0
powerpc                   bluestone_defconfig   gcc-13.2.0
powerpc                     ep8248e_defconfig   gcc-13.2.0
powerpc                 mpc834x_itx_defconfig   gcc-13.2.0
powerpc                      pmac32_defconfig   gcc-13.2.0
powerpc                     rainier_defconfig   gcc-13.2.0
powerpc               randconfig-001-20240811   gcc-13.2.0
powerpc               randconfig-003-20240811   gcc-13.2.0
powerpc                     redwood_defconfig   gcc-13.2.0
powerpc                     tqm8541_defconfig   gcc-13.2.0
powerpc64                        alldefconfig   gcc-13.2.0
powerpc64             randconfig-001-20240811   gcc-13.2.0
powerpc64             randconfig-002-20240811   gcc-13.2.0
powerpc64             randconfig-003-20240811   gcc-13.2.0
riscv                            allmodconfig   clang-20
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-20
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-14.1.0
riscv                 randconfig-001-20240811   gcc-13.2.0
riscv                 randconfig-002-20240811   gcc-13.2.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                             allyesconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240811   gcc-13.2.0
s390                  randconfig-002-20240811   gcc-13.2.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                          kfr2r09_defconfig   gcc-13.2.0
sh                    randconfig-001-20240811   gcc-13.2.0
sh                    randconfig-002-20240811   gcc-13.2.0
sh                          rsk7269_defconfig   gcc-13.2.0
sh                             shx3_defconfig   gcc-13.2.0
sparc                            allmodconfig   gcc-14.1.0
sparc                       sparc32_defconfig   gcc-13.2.0
sparc64                          alldefconfig   gcc-13.2.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240811   gcc-13.2.0
sparc64               randconfig-002-20240811   gcc-13.2.0
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240811   gcc-13.2.0
um                    randconfig-002-20240811   gcc-13.2.0
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240811   gcc-12
x86_64       buildonly-randconfig-002-20240811   gcc-12
x86_64       buildonly-randconfig-003-20240811   gcc-12
x86_64       buildonly-randconfig-004-20240811   gcc-12
x86_64       buildonly-randconfig-005-20240811   gcc-12
x86_64       buildonly-randconfig-006-20240811   gcc-12
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-11
x86_64                randconfig-001-20240811   gcc-12
x86_64                randconfig-002-20240811   gcc-12
x86_64                randconfig-003-20240811   gcc-12
x86_64                randconfig-004-20240811   gcc-12
x86_64                randconfig-005-20240811   gcc-12
x86_64                randconfig-006-20240811   gcc-12
x86_64                randconfig-011-20240811   gcc-12
x86_64                randconfig-012-20240811   gcc-12
x86_64                randconfig-013-20240811   gcc-12
x86_64                randconfig-014-20240811   gcc-12
x86_64                randconfig-015-20240811   gcc-12
x86_64                randconfig-016-20240811   gcc-12
x86_64                randconfig-071-20240811   gcc-12
x86_64                randconfig-072-20240811   gcc-12
x86_64                randconfig-073-20240811   gcc-12
x86_64                randconfig-074-20240811   gcc-12
x86_64                randconfig-075-20240811   gcc-12
x86_64                randconfig-076-20240811   gcc-12
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240811   gcc-13.2.0
xtensa                randconfig-002-20240811   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

