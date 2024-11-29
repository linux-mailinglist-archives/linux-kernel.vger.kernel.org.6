Return-Path: <linux-kernel+bounces-425264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9519DBF99
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 08:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E351281E02
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 07:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1027155385;
	Fri, 29 Nov 2024 07:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iiNQjKkg"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E210B33C5
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 07:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732863925; cv=none; b=BU91NlomlQqAB/8qBbrOgQXyCEPqWrZgDHyWA+ylJC2jUvJAYeLRnhpLuO9neS/q+CmJclHkQ166Bcsg53HTunopq+zCGnpiVRjI1nxQGPSU2+X7Gk6j2MF+o4TT11rc54XSqa3HwKOLC/8VXo+UFt5oJ1KLbRYyW9HG2kxDy1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732863925; c=relaxed/simple;
	bh=fwZRByPPMpBXf9GdRYgE/NnWfNBMGPBEttJdwxI38lU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=AI/P7HFEYW7QccYenjvnq7uEoOgxpH4v4mTjKPJ1k1YJl6Q+g4BtF3cMidgjK/kAgxxftJRchyKcwLGu0LgFEo8adW76nMDZ2UcWOQCAcmI9khS1GQ1pJ04MhB8Yi9m+P2J+3OmOAPg99J9toCBV4ZUJ/NRHu5ydN7MIoKfNYmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iiNQjKkg; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732863924; x=1764399924;
  h=date:from:to:cc:subject:message-id;
  bh=fwZRByPPMpBXf9GdRYgE/NnWfNBMGPBEttJdwxI38lU=;
  b=iiNQjKkgYirBd92qrRphkQOuWaEfhQfntNTtRn+i1JXwB3WUSacJ8jsn
   63WAEorCIz+PBQXVpiIVO5Z0keZpBeOI/ASkK6IOOXr+1D1nj0fVPfwhS
   WxmQfXfolhWJKQY3YhBmY9DKmjv1W0/d016K6+yfqub3OYZq1HgSbHFtc
   YYIuOrpVZM1gZJ1/7X+EboTEt+L7zEwWD/WKFr2S0djwt0hKkIhDpuFQy
   RRchaQvRyZnKxXGgX1roSM5wyiRJCqeOTH8qnw/6GFtEqEicRHy8i/FzM
   fbSmC+oODoE+MdsBQzkgRQNsnSKS8qjyStA1LaSpRJFVOIcGrtw9SZKJi
   Q==;
X-CSE-ConnectionGUID: d2DdZHq4RQiwJmmacwmq9w==
X-CSE-MsgGUID: QXbK44HvSaut3TQstTgM8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11270"; a="43762534"
X-IronPort-AV: E=Sophos;i="6.12,194,1728975600"; 
   d="scan'208";a="43762534"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2024 23:05:23 -0800
X-CSE-ConnectionGUID: 2AX4zH7IR+yYxAJ0MwSeAg==
X-CSE-MsgGUID: 6PHpXXiQTR2YYFD1sxEc4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,194,1728975600"; 
   d="scan'208";a="92877832"
Received: from lkp-server01.sh.intel.com (HELO 5e2646291792) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 28 Nov 2024 23:05:22 -0800
Received: from kbuild by 5e2646291792 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tGv44-000074-0E;
	Fri, 29 Nov 2024 07:05:20 +0000
Date: Fri, 29 Nov 2024 15:02:32 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:tip/urgent] BUILD SUCCESS
 cde39ebf0d83c8e89f9473c0568bb2c1973f3af6
Message-ID: <202411291522.oJyOrURw-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tip/urgent
branch HEAD: cde39ebf0d83c8e89f9473c0568bb2c1973f3af6  Merge branch into tip/master: 'x86/urgent'

elapsed time: 1126m

configs tested: 222
configs skipped: 22

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
arc                            hsdk_defconfig    gcc-14.2.0
arc                   randconfig-001-20241129    clang-20
arc                   randconfig-001-20241129    gcc-13.2.0
arc                   randconfig-002-20241129    clang-20
arc                   randconfig-002-20241129    gcc-13.2.0
arm                              allmodconfig    clang-20
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-20
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-20
arm                              allyesconfig    gcc-14.2.0
arm                          collie_defconfig    gcc-14.2.0
arm                          exynos_defconfig    clang-20
arm                          ixp4xx_defconfig    clang-20
arm                         lpc18xx_defconfig    gcc-14.2.0
arm                       omap2plus_defconfig    clang-20
arm                         orion5x_defconfig    clang-20
arm                          pxa3xx_defconfig    gcc-14.2.0
arm                            qcom_defconfig    clang-20
arm                   randconfig-001-20241129    clang-15
arm                   randconfig-001-20241129    clang-20
arm                   randconfig-002-20241129    clang-20
arm                   randconfig-002-20241129    gcc-14.2.0
arm                   randconfig-003-20241129    clang-20
arm                   randconfig-004-20241129    clang-20
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    clang-20
arm64                 randconfig-001-20241129    clang-15
arm64                 randconfig-001-20241129    clang-20
arm64                 randconfig-002-20241129    clang-20
arm64                 randconfig-003-20241129    clang-20
arm64                 randconfig-004-20241129    clang-20
arm64                 randconfig-004-20241129    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20241129    clang-20
csky                  randconfig-001-20241129    gcc-14.2.0
csky                  randconfig-002-20241129    clang-20
csky                  randconfig-002-20241129    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-20
hexagon               randconfig-001-20241129    clang-14
hexagon               randconfig-001-20241129    clang-20
hexagon               randconfig-002-20241129    clang-20
i386        buildonly-randconfig-001-20241129    clang-19
i386        buildonly-randconfig-001-20241129    gcc-12
i386        buildonly-randconfig-002-20241129    clang-19
i386        buildonly-randconfig-003-20241129    clang-19
i386        buildonly-randconfig-003-20241129    gcc-12
i386        buildonly-randconfig-004-20241129    clang-19
i386        buildonly-randconfig-005-20241129    clang-19
i386        buildonly-randconfig-006-20241129    clang-19
i386        buildonly-randconfig-006-20241129    gcc-12
i386                  randconfig-001-20241129    clang-19
i386                  randconfig-001-20241129    gcc-12
i386                  randconfig-002-20241129    clang-19
i386                  randconfig-003-20241129    clang-19
i386                  randconfig-003-20241129    gcc-12
i386                  randconfig-004-20241129    clang-19
i386                  randconfig-005-20241129    clang-19
i386                  randconfig-006-20241129    clang-19
i386                  randconfig-006-20241129    gcc-12
i386                  randconfig-011-20241129    clang-19
i386                  randconfig-011-20241129    gcc-12
i386                  randconfig-012-20241129    clang-19
i386                  randconfig-013-20241129    clang-19
i386                  randconfig-014-20241129    clang-19
i386                  randconfig-015-20241129    clang-19
i386                  randconfig-015-20241129    gcc-12
i386                  randconfig-016-20241129    clang-19
i386                  randconfig-016-20241129    gcc-12
loongarch                        alldefconfig    gcc-14.2.0
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20241129    clang-20
loongarch             randconfig-001-20241129    gcc-14.2.0
loongarch             randconfig-002-20241129    clang-20
loongarch             randconfig-002-20241129    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                       m5475evb_defconfig    gcc-14.2.0
m68k                        mvme16x_defconfig    gcc-14.2.0
m68k                           virt_defconfig    clang-20
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                      mmu_defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                         bigsur_defconfig    gcc-14.2.0
mips                          eyeq5_defconfig    gcc-14.2.0
mips                           ip27_defconfig    gcc-14.2.0
mips                      maltaaprp_defconfig    clang-14
mips                        qi_lb60_defconfig    clang-20
mips                   sb1250_swarm_defconfig    gcc-14.2.0
mips                           xway_defconfig    clang-20
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20241129    clang-20
nios2                 randconfig-001-20241129    gcc-14.2.0
nios2                 randconfig-002-20241129    clang-20
nios2                 randconfig-002-20241129    gcc-14.2.0
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                  or1klitex_defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                randconfig-001-20241129    clang-20
parisc                randconfig-001-20241129    gcc-14.2.0
parisc                randconfig-002-20241129    clang-20
parisc                randconfig-002-20241129    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-20
powerpc                          allyesconfig    gcc-14.2.0
powerpc                      cm5200_defconfig    clang-20
powerpc                      ppc64e_defconfig    clang-20
powerpc               randconfig-001-20241129    clang-20
powerpc               randconfig-002-20241129    clang-20
powerpc               randconfig-003-20241129    clang-20
powerpc               randconfig-003-20241129    gcc-14.2.0
powerpc                      tqm8xx_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20241129    clang-15
powerpc64             randconfig-001-20241129    clang-20
powerpc64             randconfig-002-20241129    clang-20
powerpc64             randconfig-002-20241129    gcc-14.2.0
powerpc64             randconfig-003-20241129    clang-20
powerpc64             randconfig-003-20241129    gcc-14.2.0
riscv                            allmodconfig    clang-20
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                            allyesconfig    gcc-14.2.0
riscv             nommu_k210_sdcard_defconfig    gcc-14.2.0
riscv                 randconfig-001-20241129    clang-20
riscv                 randconfig-001-20241129    gcc-14.2.0
riscv                 randconfig-002-20241129    clang-20
s390                             allmodconfig    clang-20
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20241129    clang-20
s390                  randconfig-002-20241129    clang-20
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20241129    clang-20
sh                    randconfig-001-20241129    gcc-14.2.0
sh                    randconfig-002-20241129    clang-20
sh                    randconfig-002-20241129    gcc-14.2.0
sh                          rsk7201_defconfig    clang-20
sh                           se7751_defconfig    gcc-14.2.0
sh                   sh7724_generic_defconfig    clang-20
sh                   sh7770_generic_defconfig    gcc-14.2.0
sh                        sh7785lcr_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc64               randconfig-001-20241129    clang-20
sparc64               randconfig-001-20241129    gcc-14.2.0
sparc64               randconfig-002-20241129    clang-20
sparc64               randconfig-002-20241129    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                               allyesconfig    gcc-12
um                    randconfig-001-20241129    clang-20
um                    randconfig-001-20241129    gcc-12
um                    randconfig-002-20241129    clang-20
x86_64      buildonly-randconfig-001-20241129    clang-19
x86_64      buildonly-randconfig-002-20241129    clang-19
x86_64      buildonly-randconfig-003-20241129    clang-19
x86_64      buildonly-randconfig-004-20241129    clang-19
x86_64      buildonly-randconfig-005-20241129    clang-19
x86_64      buildonly-randconfig-006-20241129    clang-19
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20241129    clang-19
x86_64                randconfig-002-20241129    clang-19
x86_64                randconfig-003-20241129    clang-19
x86_64                randconfig-004-20241129    clang-19
x86_64                randconfig-005-20241129    clang-19
x86_64                randconfig-006-20241129    clang-19
x86_64                randconfig-011-20241129    clang-19
x86_64                randconfig-012-20241129    clang-19
x86_64                randconfig-013-20241129    clang-19
x86_64                randconfig-014-20241129    clang-19
x86_64                randconfig-015-20241129    clang-19
x86_64                randconfig-016-20241129    clang-19
x86_64                randconfig-071-20241129    clang-19
x86_64                randconfig-072-20241129    clang-19
x86_64                randconfig-073-20241129    clang-19
x86_64                randconfig-074-20241129    clang-19
x86_64                randconfig-075-20241129    clang-19
x86_64                randconfig-076-20241129    clang-19
x86_64                               rhel-9.4    clang-19
x86_64                               rhel-9.4    gcc-12
x86_64                           rhel-9.4-bpf    clang-19
x86_64                         rhel-9.4-kunit    clang-19
x86_64                           rhel-9.4-ltp    clang-19
x86_64                          rhel-9.4-rust    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                       common_defconfig    gcc-14.2.0
xtensa                randconfig-001-20241129    clang-20
xtensa                randconfig-001-20241129    gcc-14.2.0
xtensa                randconfig-002-20241129    clang-20
xtensa                randconfig-002-20241129    gcc-14.2.0
xtensa                         virt_defconfig    gcc-14.2.0
xtensa                    xip_kc705_defconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

