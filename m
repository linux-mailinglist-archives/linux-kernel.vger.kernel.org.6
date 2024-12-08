Return-Path: <linux-kernel+bounces-436353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3379E84D3
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 12:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8B7D1884A14
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 11:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA79C145324;
	Sun,  8 Dec 2024 11:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eG4F3g/K"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B811474B7
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 11:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733658709; cv=none; b=EF5tNV3nh65e2bSST50BuKB9d15Zepx5Jm1F1CNJyT2NwxTu65zSxrnmnSzy37g5DXXjCNqdq6fOJo+R/7lnv0Rjx47Eqkxs32miG6N9FCB17FzKnDx4FFIRw0BBYE37q4jSCjp9Swm9VlXSx66ofGOyq9zb/JyQGQOBjxwIVbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733658709; c=relaxed/simple;
	bh=BuoLXwhYuyLt0BFU4Efj/R43KAhOmjL+t/1tUosPim0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=jK8IpqTndk+XvJzbw6Y/LUftdjuk1rQufS3h3iFux/0RuVzFDy0c2kEdSjs/96WUlHfC/9n4RSYnmomws/y5Y7+ITyrLpnjxSnPy7k6KSSTVODnP6f+FT5EqrRBb1ow6+GgsSDaA5OI7EdKsCq5y9LHC/8BD8IL2ZiJHkXkv1qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eG4F3g/K; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733658707; x=1765194707;
  h=date:from:to:cc:subject:message-id;
  bh=BuoLXwhYuyLt0BFU4Efj/R43KAhOmjL+t/1tUosPim0=;
  b=eG4F3g/KK7ypcNs1TBRHe5P9/Q/FWn7pTSnESvUCQNT/HWS2dVXUhu+a
   Qdm693Vi0pbY5707XHFdV99eo7ZRMs3VT8kA4BisdCyuS+ftqPQko91TN
   0ojzc1SX6VVB8VunUa5K9+SFa5AMM0tk/VOi7eaKvn+H7ZP1LY021RIFJ
   QX+/tV6fuzj9KJG2oA3xVFGpN0og3QvII2qOf9yOvdMm8Izw1hlL4VtlA
   BF114qT3twkmnheTwPiEJxDKngIfi25BxBZ1ZEWKFUfOenbdDzIVkV7+5
   rDi6qWQqpFVLvLkjJbv/pmJZ2g4aK/bAkM2V72VTWlX8/Qw/5sRe3z+4Q
   g==;
X-CSE-ConnectionGUID: vTAhVXPQQUaiQffeg9/vBg==
X-CSE-MsgGUID: gzC965RgTsaSAt1q6jtpbw==
X-IronPort-AV: E=McAfee;i="6700,10204,11280"; a="33851949"
X-IronPort-AV: E=Sophos;i="6.12,217,1728975600"; 
   d="scan'208";a="33851949"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2024 03:51:46 -0800
X-CSE-ConnectionGUID: fSmMSAp6TCKSOzHFGRKnfA==
X-CSE-MsgGUID: kLaEcCR2Q5iJJN7ZK758zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,217,1728975600"; 
   d="scan'208";a="95181763"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 08 Dec 2024 03:51:44 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tKFp8-0003Ib-1x;
	Sun, 08 Dec 2024 11:51:42 +0000
Date: Sun, 08 Dec 2024 19:48:24 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev] BUILD SUCCESS
 3b83e818ae404ea50fdc043ef868a7da896453b0
Message-ID: <202412081914.tBRUMnwv-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev
branch HEAD: 3b83e818ae404ea50fdc043ef868a7da896453b0  rcutorture: Add ftrace-compatible timestamp to GP# failure/close-call output

elapsed time: 929m

configs tested: 203
configs skipped: 11

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    clang-20
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-18
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-18
arc                      axs103_smp_defconfig    gcc-13.2.0
arc                                 defconfig    gcc-14.2.0
arc                   randconfig-001-20241208    gcc-13.2.0
arc                   randconfig-002-20241208    gcc-13.2.0
arm                              allmodconfig    clang-18
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-18
arm                                 defconfig    gcc-14.2.0
arm                          ep93xx_defconfig    clang-20
arm                      footbridge_defconfig    gcc-14.2.0
arm                   milbeaut_m10v_defconfig    clang-19
arm                       multi_v4t_defconfig    clang-18
arm                       multi_v4t_defconfig    clang-20
arm                        multi_v5_defconfig    clang-18
arm                        multi_v7_defconfig    clang-19
arm                       netwinder_defconfig    gcc-14.2.0
arm                            qcom_defconfig    clang-15
arm                   randconfig-001-20241208    gcc-14.2.0
arm                   randconfig-002-20241208    clang-20
arm                   randconfig-003-20241208    gcc-14.2.0
arm                   randconfig-004-20241208    gcc-14.2.0
arm                         s3c6400_defconfig    gcc-14.2.0
arm                       versatile_defconfig    clang-18
arm                    vt8500_v6_v7_defconfig    gcc-13.2.0
arm                    vt8500_v6_v7_defconfig    gcc-14.2.0
arm                         wpcm450_defconfig    clang-20
arm64                            alldefconfig    clang-20
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20241208    gcc-14.2.0
arm64                 randconfig-002-20241208    gcc-14.2.0
arm64                 randconfig-003-20241208    gcc-14.2.0
arm64                 randconfig-004-20241208    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.2.0
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241208    gcc-12
i386        buildonly-randconfig-002-20241208    clang-19
i386        buildonly-randconfig-003-20241208    gcc-11
i386        buildonly-randconfig-004-20241208    gcc-12
i386        buildonly-randconfig-005-20241208    clang-19
i386        buildonly-randconfig-006-20241208    clang-19
i386                                defconfig    clang-19
i386                  randconfig-001-20241208    gcc-12
i386                  randconfig-002-20241208    gcc-12
i386                  randconfig-003-20241208    gcc-12
i386                  randconfig-004-20241208    gcc-12
i386                  randconfig-005-20241208    gcc-12
i386                  randconfig-006-20241208    gcc-12
i386                  randconfig-007-20241208    gcc-12
i386                  randconfig-011-20241208    clang-19
i386                  randconfig-012-20241208    clang-19
i386                  randconfig-013-20241208    clang-19
i386                  randconfig-014-20241208    clang-19
i386                  randconfig-015-20241208    clang-19
i386                  randconfig-016-20241208    clang-19
i386                  randconfig-017-20241208    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                          atari_defconfig    clang-20
m68k                                defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          ath25_defconfig    gcc-13.2.0
mips                      bmips_stb_defconfig    clang-18
mips                            gpr_defconfig    clang-20
mips                           ip22_defconfig    clang-15
mips                           ip22_defconfig    clang-18
mips                           ip28_defconfig    clang-18
mips                           jazz_defconfig    clang-18
mips                           jazz_defconfig    gcc-13.2.0
mips                         rt305x_defconfig    clang-19
mips                        vocore2_defconfig    clang-15
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    clang-16
powerpc                          allyesconfig    gcc-14.2.0
powerpc                 canyonlands_defconfig    clang-18
powerpc                 canyonlands_defconfig    gcc-13.2.0
powerpc                       holly_defconfig    clang-20
powerpc                      mgcoge_defconfig    clang-18
powerpc                  mpc885_ads_defconfig    clang-20
powerpc                    mvme5100_defconfig    clang-15
powerpc                     stx_gp3_defconfig    clang-20
powerpc                     tqm5200_defconfig    clang-19
powerpc                     tqm8555_defconfig    clang-15
powerpc                        warp_defconfig    gcc-14.2.0
powerpc64                        alldefconfig    clang-18
riscv                            allmodconfig    clang-20
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    clang-20
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    clang-20
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20241208    gcc-14.2.0
riscv                 randconfig-002-20241208    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20241208    gcc-14.2.0
s390                  randconfig-002-20241208    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                             espt_defconfig    clang-18
sh                             espt_defconfig    gcc-14.2.0
sh                 kfr2r09-romimage_defconfig    gcc-13.2.0
sh                 kfr2r09-romimage_defconfig    gcc-14.2.0
sh                          r7780mp_defconfig    clang-15
sh                          r7780mp_defconfig    clang-19
sh                    randconfig-001-20241208    gcc-14.2.0
sh                    randconfig-002-20241208    gcc-14.2.0
sh                          sdk7780_defconfig    clang-18
sh                           se7712_defconfig    clang-20
sh                           se7724_defconfig    clang-19
sparc                            alldefconfig    clang-18
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20241208    gcc-14.2.0
sparc                 randconfig-002-20241208    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20241208    gcc-14.2.0
sparc64               randconfig-002-20241208    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241208    gcc-14.2.0
um                    randconfig-002-20241208    gcc-14.2.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241208    gcc-12
x86_64      buildonly-randconfig-002-20241208    clang-19
x86_64      buildonly-randconfig-003-20241208    gcc-12
x86_64      buildonly-randconfig-004-20241208    clang-19
x86_64      buildonly-randconfig-005-20241208    clang-19
x86_64      buildonly-randconfig-006-20241208    gcc-12
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20241208    gcc-12
x86_64                randconfig-002-20241208    gcc-12
x86_64                randconfig-003-20241208    gcc-12
x86_64                randconfig-004-20241208    gcc-12
x86_64                randconfig-005-20241208    gcc-12
x86_64                randconfig-006-20241208    gcc-12
x86_64                randconfig-007-20241208    gcc-12
x86_64                randconfig-008-20241208    gcc-12
x86_64                randconfig-071-20241208    gcc-12
x86_64                randconfig-072-20241208    gcc-12
x86_64                randconfig-073-20241208    gcc-12
x86_64                randconfig-074-20241208    gcc-12
x86_64                randconfig-075-20241208    gcc-12
x86_64                randconfig-076-20241208    gcc-12
x86_64                randconfig-077-20241208    gcc-12
x86_64                randconfig-078-20241208    gcc-12
x86_64                               rhel-9.4    clang-19
x86_64                           rhel-9.4-bpf    clang-19
x86_64                         rhel-9.4-kunit    clang-19
x86_64                           rhel-9.4-ltp    clang-19
x86_64                          rhel-9.4-rust    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                  cadence_csp_defconfig    gcc-13.2.0
xtensa                       common_defconfig    clang-20
xtensa                       common_defconfig    gcc-13.2.0
xtensa                generic_kc705_defconfig    clang-18
xtensa                randconfig-001-20241208    gcc-14.2.0
xtensa                randconfig-002-20241208    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

