Return-Path: <linux-kernel+bounces-282152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB62D94E02D
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 07:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81836281854
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 05:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66E11B7E9;
	Sun, 11 Aug 2024 05:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iuxDWv1Y"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234951757D
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 05:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723355796; cv=none; b=KA4eQaItfnleewFkRZxeINzluqv7TWizbuyl7upH6Dz+usRK5EtDyg8u+40E3Au0Qo/OtxyPk/g0JNz8iP6TWa28PeRwdlh4j/ZU6n5KoRwn6wNNOv/dp9siMhH3eTXUEyNo2qDMoOXZQG4d9ZhuFKkkOAnC8/1BVdA7IVbG/Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723355796; c=relaxed/simple;
	bh=uP0try4nm03ngJMJYGni4dzCy44FI37Qk7hZ74WMHgg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ji3/77v0QxM2lok+864KDdLDJwQLUNw/DKMxpNgeOVuZec+IkCozHmPvoiQ/nAa5x1xUHCnyOM5Gbwsi63XTr+bFTi02SbEe8053nENAHQRHAB++UNM3tnhnQIYgQCIs9FBCFKkLJfQTt0+s2rdGNXTPsTOAhAt4bjOEdDleHcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iuxDWv1Y; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723355796; x=1754891796;
  h=date:from:to:cc:subject:message-id;
  bh=uP0try4nm03ngJMJYGni4dzCy44FI37Qk7hZ74WMHgg=;
  b=iuxDWv1YDVRbZbGvvWX1YVQb5T7FgkmoN/Q82QjWbi4gPXcFQmRZ2Dz/
   rqnT89c9lNe9JA0bLrSSzSac1fjCvduOx5kGqUkAZTn1YA+X92XnpSy4N
   U1qkpJLF4d0rXvLQXaBmnrpc++mUKpsF6gIlsfhhcgK/mGPENa3EP40hg
   9LTPbvSAeazO5pd1+I1eZdzl1PR85TEkerlHqhmqJmQA9/kdPoJwxwTX0
   xlcGQx+pd9Z5kOrati0+ZLMm+B8UsK6VgHXHiQky0LbxQ6O3zccXd9LGL
   WjcthkJMgiKGvI6Dyw7wHfYM9xse8JRpqiKK7P6v988HqzrVr/BplyGio
   w==;
X-CSE-ConnectionGUID: YQSA2fXnRZOwa8DT2mlQ1g==
X-CSE-MsgGUID: oxt7N+VUQsiKOb4d3UZyag==
X-IronPort-AV: E=McAfee;i="6700,10204,11160"; a="32635297"
X-IronPort-AV: E=Sophos;i="6.09,280,1716274800"; 
   d="scan'208";a="32635297"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2024 22:56:35 -0700
X-CSE-ConnectionGUID: JpuBSwP4SjqUaN4HFbdNWw==
X-CSE-MsgGUID: CUGOEAVkRUmhTxdAymjw5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,280,1716274800"; 
   d="scan'208";a="57845208"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 10 Aug 2024 22:56:33 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sd1Z8-000Ad5-2m;
	Sun, 11 Aug 2024 05:56:30 +0000
Date: Sun, 11 Aug 2024 13:56:17 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 885c9c1c668b0a82ca79c680e68321f8b4f3bf80
Message-ID: <202408111315.LxjT2Yju-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 885c9c1c668b0a82ca79c680e68321f8b4f3bf80  Merge branch into tip/master: 'x86/timers'

elapsed time: 1277m

configs tested: 143
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.3.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240811   gcc-13.2.0
arc                   randconfig-002-20240811   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-20
arm                              allyesconfig   gcc-14.1.0
arm                         bcm2835_defconfig   clang-20
arm                                 defconfig   clang-14
arm                            mps2_defconfig   clang-20
arm                       multi_v4t_defconfig   clang-20
arm                         mv78xx0_defconfig   clang-20
arm                   randconfig-001-20240811   clang-14
arm                   randconfig-002-20240811   clang-20
arm                   randconfig-003-20240811   gcc-14.1.0
arm                   randconfig-004-20240811   gcc-14.1.0
arm64                            allmodconfig   clang-20
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-14.1.0
arm64                 randconfig-001-20240811   clang-20
arm64                 randconfig-002-20240811   gcc-14.1.0
arm64                 randconfig-003-20240811   gcc-14.1.0
arm64                 randconfig-004-20240811   gcc-14.1.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-14.1.0
csky                  randconfig-001-20240811   gcc-14.1.0
csky                  randconfig-002-20240811   gcc-14.1.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   clang-20
hexagon                          allyesconfig   clang-20
hexagon                             defconfig   clang-20
hexagon               randconfig-001-20240811   clang-20
hexagon               randconfig-002-20240811   clang-20
i386                             allmodconfig   gcc-12
i386                              allnoconfig   gcc-12
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240810   clang-18
i386         buildonly-randconfig-002-20240810   clang-18
i386         buildonly-randconfig-003-20240810   clang-18
i386         buildonly-randconfig-004-20240810   clang-18
i386         buildonly-randconfig-005-20240810   gcc-12
i386         buildonly-randconfig-006-20240810   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240810   clang-18
i386                  randconfig-002-20240810   gcc-12
i386                  randconfig-003-20240810   clang-18
i386                  randconfig-004-20240810   gcc-12
i386                  randconfig-005-20240810   gcc-12
i386                  randconfig-006-20240810   clang-18
i386                  randconfig-011-20240810   gcc-12
i386                  randconfig-012-20240810   gcc-12
i386                  randconfig-013-20240810   clang-18
i386                  randconfig-014-20240810   gcc-12
i386                  randconfig-015-20240810   gcc-12
i386                  randconfig-016-20240810   gcc-12
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-14.1.0
loongarch             randconfig-001-20240811   gcc-14.1.0
loongarch             randconfig-002-20240811   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                          atari_defconfig   gcc-14.1.0
m68k                                defconfig   gcc-14.1.0
m68k                        mvme16x_defconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
mips                          ath25_defconfig   clang-20
mips                        bcm47xx_defconfig   clang-15
mips                      maltasmvp_defconfig   gcc-13.2.0
mips                  maltasmvp_eva_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-14.1.0
nios2                 randconfig-001-20240811   gcc-14.1.0
nios2                 randconfig-002-20240811   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240811   gcc-14.1.0
parisc                randconfig-002-20240811   gcc-14.1.0
parisc64                            defconfig   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-20
powerpc                     mpc512x_defconfig   clang-20
powerpc                 mpc834x_itx_defconfig   clang-20
powerpc               randconfig-001-20240811   clang-20
powerpc               randconfig-003-20240811   clang-20
powerpc                     tqm8555_defconfig   clang-20
powerpc64             randconfig-001-20240811   clang-14
powerpc64             randconfig-002-20240811   gcc-14.1.0
riscv                            allmodconfig   clang-20
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-20
riscv                               defconfig   clang-20
riscv                 randconfig-001-20240811   gcc-14.1.0
riscv                 randconfig-002-20240811   clang-20
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   clang-20
s390                  randconfig-001-20240811   clang-20
s390                  randconfig-002-20240811   clang-20
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                    randconfig-001-20240811   gcc-14.1.0
sh                    randconfig-002-20240811   gcc-14.1.0
sh                   rts7751r2dplus_defconfig   gcc-14.1.0
sh                           se7619_defconfig   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240811   gcc-14.1.0
sparc64               randconfig-002-20240811   gcc-14.1.0
um                               allmodconfig   clang-20
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-12
um                                  defconfig   clang-20
um                             i386_defconfig   gcc-12
um                    randconfig-001-20240811   gcc-12
um                    randconfig-002-20240811   clang-20
um                           x86_64_defconfig   clang-15
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64                              defconfig   gcc-11
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240811   gcc-14.1.0
xtensa                randconfig-002-20240811   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

