Return-Path: <linux-kernel+bounces-424440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8A09DB467
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 10:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 833DFB21B23
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 09:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BED41547EE;
	Thu, 28 Nov 2024 09:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fheWg0TU"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E55D1509BF
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 08:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732784402; cv=none; b=uPq30q1KaNRyWlP816YM6MFM5Oc3SwMGTfxI9OGVIvxlsYy4CSP8iTKd4CeV8XvoWACZAJBXaFdRVvDkuyFUEhn4bbc5vmHVAVEf77TCfaSQeadSfewbx8gnEdYfSi0oXPoqgH+r9yDWKdit0YFgpvu3GVgcuchwmAlIzK/+p+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732784402; c=relaxed/simple;
	bh=eGwhUj5henXICpR1WEiBYBaaCceMVobUWSP4jTlLHEA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=YCVZihGa3+DTF6KhfFUKdk1eMupQCIAF59zbVR9+eagMYhGXcpm3E+YyBEfZWNnixg+8DUGtCnIKKw1Bh0q67CBOzpJTxGbwliM+0K+b76aOY42lnCP9cOuKfbyWta4N9dM0ifvI7fTNZeHibNyiXWOeC/B27cA01/ByA288SIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fheWg0TU; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732784401; x=1764320401;
  h=date:from:to:cc:subject:message-id;
  bh=eGwhUj5henXICpR1WEiBYBaaCceMVobUWSP4jTlLHEA=;
  b=fheWg0TU5QFB3GeepWwpZZZGD048Ms/2/yLoRuOndlKbPUsjxVf8+a6q
   vcAMzxnggdO9cuawNQZHpDfKf0TzhBgtIocc9a/cfyyGBZI4o/t3Nm+EI
   i3QVm4nlxDoXCDOrwKjzhSoG0v/1GUVWl9NnpUwmPmZBiP9bAa17vZ+vj
   AWd2hKz0lCCTfsV3aHSnS/PNfLbbJZ37NMsIxOlPOlTvVyZV+YmhEqdZV
   2VSAreDwR68PPyL3fwpXgDQVHz0zRAU8rAehHTuq9gN04bWtw35nkVMyi
   KRqWiJwk59SQn8PStAvzy80xzBsZ5g9JcbJvFDaeBvVBNUFMdJ/33VALS
   g==;
X-CSE-ConnectionGUID: /njhlLdCRqSvg/nWKdKpEA==
X-CSE-MsgGUID: fU95H6lHQmicauGNIWT6oA==
X-IronPort-AV: E=McAfee;i="6700,10204,11269"; a="33155270"
X-IronPort-AV: E=Sophos;i="6.12,192,1728975600"; 
   d="scan'208";a="33155270"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2024 01:00:00 -0800
X-CSE-ConnectionGUID: 7/GJQkuQQJq3YWMwPTfUIQ==
X-CSE-MsgGUID: 9C8zoocsTvW9SEiw/SJlPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,192,1728975600"; 
   d="scan'208";a="129682050"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 28 Nov 2024 00:59:59 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tGaNQ-0009N8-0X;
	Thu, 28 Nov 2024 08:59:56 +0000
Date: Thu, 28 Nov 2024 16:57:48 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:tip/urgent] BUILD SUCCESS
 afb7955d33d6a57c681a7d088a6e36ee86ef55a3
Message-ID: <202411281638.iH8QX3o7-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tip/urgent
branch HEAD: afb7955d33d6a57c681a7d088a6e36ee86ef55a3  Merge branch into tip/master: 'x86/urgent'

elapsed time: 863m

configs tested: 188
configs skipped: 26

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    clang-20
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-20
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20241128    clang-20
arc                   randconfig-002-20241128    clang-20
arm                              allmodconfig    clang-20
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-20
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-20
arm                              allyesconfig    gcc-14.2.0
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
hexagon                           allnoconfig    clang-20
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
powerpc                          allyesconfig    clang-20
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
riscv                            allmodconfig    clang-20
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
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
xtensa                randconfig-001-20241128    clang-20
xtensa                randconfig-002-20241128    clang-20
xtensa                    smp_lx200_defconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

