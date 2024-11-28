Return-Path: <linux-kernel+bounces-424305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 314EE9DB2D1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 07:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA418161553
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 06:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFD71459F7;
	Thu, 28 Nov 2024 06:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E0KdZ/zI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B961D41C94
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 06:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732775884; cv=none; b=M4IKfFnZWLQf8G60j/vnJDRZq1NHYe397KAy92+NwIRGfS+uhO84SicWA/JQll/dScX++tX36xmwtd+tnwWuU34DDeZupjFaoTtuokmEpLWPoptReCxZYTCwzoJMw2CgLHRa5+oplJtjX8/Cj+lRu/I5qr+yahpzn/IR21w0lkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732775884; c=relaxed/simple;
	bh=q1+dE8fZWRUrEswt8O66YVIhIOZ5ugFJVLN1wsWbmZE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Hi9FnoTxMv4TPwUv5NuEV9hZVFVEZG2BkeFZfSysQ7LzefIkO86YqWdukmZPV7luLmf3ZNA7rCtyfhxUSnI2T30gqarNfrev+qqURd2yAJqOHk4l3i3jt+qsAKqLWJpAX+tf7naZMnPVJZcyu9BEYKeQxb1IAtJ7FPsNYALtuLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E0KdZ/zI; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732775883; x=1764311883;
  h=date:from:to:cc:subject:message-id;
  bh=q1+dE8fZWRUrEswt8O66YVIhIOZ5ugFJVLN1wsWbmZE=;
  b=E0KdZ/zIzbwUKF1OTsJ+Lk+GGxaZAA+VM5kH9Ej/VN5W6fJvcVFByjGW
   geCsqx/LdMc9W2sVHRy3pi1+SMukXMv83lDD4RrIDaj+k3lFhVlcvqgTs
   ZqU+ORxh5y4pFR0R7fUR/yW1kyEoZs7mSMV/es5suc4jGbhL6JKGL7/x+
   aJuApMPsGQ9RiKnjegZLQuaaRNlgn9vep6OpanN2Xw7KkL5G2kJyKcJ10
   If4jtcMaKsZvh2HCY6rBls30uWJgtkNgNyMG16tZJyN4BPC/4O9wZ5fbq
   lPrdjG1VWiIHP0kvvx0LExG8VNnsAZUO++hwVbcJVKFjJXCtphK6Kbg4c
   A==;
X-CSE-ConnectionGUID: 4OQnaaUVS+6UgTRuIeNnMQ==
X-CSE-MsgGUID: KvXdQ3tHQ+ugppQf2yiZcg==
X-IronPort-AV: E=McAfee;i="6700,10204,11269"; a="32932353"
X-IronPort-AV: E=Sophos;i="6.12,191,1728975600"; 
   d="scan'208";a="32932353"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2024 22:38:02 -0800
X-CSE-ConnectionGUID: uuLEF4VdRI2fU4jEA6e/SA==
X-CSE-MsgGUID: aXlk8rTrRB+mKhEOTgH8Qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,191,1728975600"; 
   d="scan'208";a="91757917"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 27 Nov 2024 22:38:01 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tGYA2-0009Bd-1l;
	Thu, 28 Nov 2024 06:37:58 +0000
Date: Thu, 28 Nov 2024 14:35:38 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 233556ac49d48a2030e8a0cc6d651062f624539b
Message-ID: <202411281428.xe4N0DCo-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 233556ac49d48a2030e8a0cc6d651062f624539b  Merge branch into tip/master: 'x86/mm'

elapsed time: 721m

configs tested: 180
configs skipped: 24

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-20
arc                   randconfig-001-20241128    clang-20
arc                   randconfig-002-20241128    clang-20
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-20
arm                         assabet_defconfig    gcc-14.2.0
arm                            dove_defconfig    gcc-14.2.0
arm                           h3600_defconfig    gcc-14.2.0
arm                       imx_v6_v7_defconfig    gcc-14.2.0
arm                           imxrt_defconfig    gcc-14.2.0
arm                         lpc32xx_defconfig    gcc-14.2.0
arm                             mxs_defconfig    gcc-14.2.0
arm                        neponset_defconfig    gcc-14.2.0
arm                             pxa_defconfig    gcc-14.2.0
arm                   randconfig-001-20241128    clang-20
arm                   randconfig-002-20241128    clang-20
arm                   randconfig-003-20241128    clang-20
arm                   randconfig-004-20241128    clang-20
arm                           sama5_defconfig    gcc-14.2.0
arm                           spitz_defconfig    gcc-14.2.0
arm                           tegra_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20241128    clang-20
arm64                 randconfig-002-20241128    clang-20
arm64                 randconfig-003-20241128    clang-20
arm64                 randconfig-004-20241128    clang-20
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20241128    clang-20
csky                  randconfig-002-20241128    clang-20
hexagon                          alldefconfig    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-20
hexagon               randconfig-001-20241128    clang-20
hexagon               randconfig-002-20241128    clang-20
i386        buildonly-randconfig-001-20241128    clang-19
i386        buildonly-randconfig-002-20241128    clang-19
i386        buildonly-randconfig-003-20241128    clang-19
i386        buildonly-randconfig-004-20241128    clang-19
i386        buildonly-randconfig-005-20241128    clang-19
i386        buildonly-randconfig-006-20241128    clang-19
i386                  randconfig-001-20241128    clang-19
i386                  randconfig-002-20241128    clang-19
i386                  randconfig-003-20241128    clang-19
i386                  randconfig-004-20241128    clang-19
i386                  randconfig-005-20241128    clang-19
i386                  randconfig-006-20241128    clang-19
i386                  randconfig-011-20241128    clang-19
i386                  randconfig-012-20241128    clang-19
i386                  randconfig-013-20241128    clang-19
i386                  randconfig-014-20241128    clang-19
i386                  randconfig-015-20241128    clang-19
i386                  randconfig-016-20241128    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                 loongson3_defconfig    gcc-14.2.0
loongarch             randconfig-001-20241128    clang-20
loongarch             randconfig-002-20241128    clang-20
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                          atari_defconfig    gcc-14.2.0
m68k                       m5208evb_defconfig    gcc-14.2.0
m68k                       m5249evb_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                        bcm47xx_defconfig    gcc-14.2.0
mips                         db1xxx_defconfig    gcc-14.2.0
mips                            gpr_defconfig    clang-20
mips                           ip22_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20241128    clang-20
nios2                 randconfig-002-20241128    clang-20
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                randconfig-001-20241128    clang-20
parisc                randconfig-002-20241128    clang-20
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    gcc-14.2.0
powerpc                      chrp32_defconfig    gcc-14.2.0
powerpc                       ebony_defconfig    gcc-14.2.0
powerpc                      katmai_defconfig    gcc-14.2.0
powerpc                 mpc8315_rdb_defconfig    gcc-14.2.0
powerpc               randconfig-001-20241128    clang-20
powerpc               randconfig-002-20241128    clang-20
powerpc               randconfig-003-20241128    clang-20
powerpc                     tqm8540_defconfig    gcc-14.2.0
powerpc                 xes_mpc85xx_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20241128    clang-20
powerpc64             randconfig-002-20241128    clang-20
powerpc64             randconfig-003-20241128    clang-20
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    gcc-14.2.0
riscv                    nommu_k210_defconfig    gcc-14.2.0
riscv                 randconfig-001-20241128    clang-20
riscv                 randconfig-002-20241128    clang-20
s390                             allmodconfig    clang-20
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20241128    clang-20
s390                  randconfig-002-20241128    clang-20
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                         apsh4a3a_defconfig    clang-20
sh                 kfr2r09-romimage_defconfig    gcc-14.2.0
sh                          lboxre2_defconfig    gcc-14.2.0
sh                            migor_defconfig    gcc-14.2.0
sh                    randconfig-001-20241128    clang-20
sh                    randconfig-002-20241128    clang-20
sh                          rsk7201_defconfig    gcc-14.2.0
sh                   secureedge5410_defconfig    gcc-14.2.0
sh                             sh03_defconfig    gcc-14.2.0
sh                     sh7710voipgw_defconfig    gcc-14.2.0
sh                            shmin_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc64               randconfig-001-20241128    clang-20
sparc64               randconfig-002-20241128    clang-20
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                               allyesconfig    gcc-12
um                             i386_defconfig    gcc-14.2.0
um                    randconfig-001-20241128    clang-20
um                    randconfig-002-20241128    clang-20
x86_64      buildonly-randconfig-001-20241128    clang-19
x86_64      buildonly-randconfig-002-20241128    clang-19
x86_64      buildonly-randconfig-003-20241128    clang-19
x86_64      buildonly-randconfig-004-20241128    clang-19
x86_64      buildonly-randconfig-005-20241128    clang-19
x86_64      buildonly-randconfig-006-20241128    clang-19
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20241128    clang-19
x86_64                randconfig-002-20241128    clang-19
x86_64                randconfig-003-20241128    clang-19
x86_64                randconfig-004-20241128    clang-19
x86_64                randconfig-005-20241128    clang-19
x86_64                randconfig-006-20241128    clang-19
x86_64                randconfig-011-20241128    clang-19
x86_64                randconfig-012-20241128    clang-19
x86_64                randconfig-013-20241128    clang-19
x86_64                randconfig-014-20241128    clang-19
x86_64                randconfig-015-20241128    clang-19
x86_64                randconfig-016-20241128    clang-19
x86_64                randconfig-071-20241128    clang-19
x86_64                randconfig-072-20241128    clang-19
x86_64                randconfig-073-20241128    clang-19
x86_64                randconfig-074-20241128    clang-19
x86_64                randconfig-075-20241128    clang-19
x86_64                randconfig-076-20241128    clang-19
x86_64                               rhel-9.4    clang-19
x86_64                               rhel-9.4    gcc-12
x86_64                          rhel-9.4-func    clang-19
x86_64                    rhel-9.4-kselftests    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                  cadence_csp_defconfig    gcc-14.2.0
xtensa                          iss_defconfig    gcc-14.2.0
xtensa                randconfig-001-20241128    clang-20
xtensa                randconfig-002-20241128    clang-20
xtensa                    smp_lx200_defconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

