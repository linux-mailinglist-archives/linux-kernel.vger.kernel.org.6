Return-Path: <linux-kernel+bounces-393213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBAE89B9DCC
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 08:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DF30B21F4C
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 07:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DA2155753;
	Sat,  2 Nov 2024 07:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NnuCcqdT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6971012FF69
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 07:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730533986; cv=none; b=eGZNnaINzGeKqgXuDwblOqP1+RJ6CggSsme0kAB1KLLuL/mD3qQr1EoN8W39q7HhWB/dTOxM++SCQn8BxfkQmpHC72AHHkv1WRoHVOnXnU207jVOQbP5RI5t/C8lbmXJk0gPLgWJifxOey5PFyGdhNVfZGiyszL5R7lmwiIFPFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730533986; c=relaxed/simple;
	bh=2i5jgF8yCV7ltegY+ILAKyUn/ILCPDOE1TO7R4qeUek=;
	h=Date:From:To:Cc:Subject:Message-ID; b=qMmkeg80aomqORtsJ454HE3k13xBfsGGH2/8MQDgQMnoaRTqXNzZNngO1CE6BBoUPsoh3uBsK0HzvllcBcxUH+eTSB5UoKQKH3ZVkOl2dq+zEKjD7OQN3lfCOh1oD8zTz/Qp3psOpbaHCwD3ZuChzexbVh2ZIvSONlVzAEtOv6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NnuCcqdT; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730533984; x=1762069984;
  h=date:from:to:cc:subject:message-id;
  bh=2i5jgF8yCV7ltegY+ILAKyUn/ILCPDOE1TO7R4qeUek=;
  b=NnuCcqdTliGoxI13035ey/G3sTgwwq1EGEtSriYoEotmqXWTdDtj1k4J
   fWJ6a7u9Wzg3gj/uLQbdtl+kdBZePoqqqfT0oVyksFLR6cLkPATFkTk8E
   1x63nyeYlCWiCNNzH1bzmjm9gClvX/TtNUNJ5CEDobZvFEf00MMcOmoci
   K34Br+71JKyVBV6LMocglaCZ8sKNsHSRRS0ec1MWWGJGSw+osZ6bkRtmw
   9i3F3dUqNImuBPtQ3VxNxpzeASS9n3DJVR3rKVt5sJq/JVJOandeTPS/s
   MhcdjZk+9NqKbm8fn0bfilbrLDb+206MTHzU5PBzeBijz+X6UPZBGOV+E
   g==;
X-CSE-ConnectionGUID: tJEb5BIETPyb/D8dgScZgg==
X-CSE-MsgGUID: dge++R3bReCMZbzvVNR5Gg==
X-IronPort-AV: E=McAfee;i="6700,10204,11243"; a="55688250"
X-IronPort-AV: E=Sophos;i="6.11,252,1725346800"; 
   d="scan'208";a="55688250"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2024 00:53:04 -0700
X-CSE-ConnectionGUID: T1mUEyHBThmRDcJOkIJ6xQ==
X-CSE-MsgGUID: /kGXd/gMRg28fULz9HCSQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,252,1725346800"; 
   d="scan'208";a="82843994"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 02 Nov 2024 00:52:20 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t78vi-000iZl-2o;
	Sat, 02 Nov 2024 07:52:18 +0000
Date: Sat, 02 Nov 2024 15:51:51 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2024.10.29a] BUILD SUCCESS
 a327e7ef1ed5356236a15e55be41800667238590
Message-ID: <202411021536.xmM67Emf-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2024.10.29a
branch HEAD: a327e7ef1ed5356236a15e55be41800667238590  rcutorture: Make rcutorture_one_extend() check reader state

elapsed time: 3322m

configs tested: 196
configs skipped: 5

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
arc                     nsimosci_hs_defconfig    gcc-13.2.0
arc                   randconfig-001-20241102    gcc-14.1.0
arc                   randconfig-002-20241102    gcc-14.1.0
arc                           tb10x_defconfig    clang-14
arc                           tb10x_defconfig    gcc-14.1.0
arc                        vdk_hs38_defconfig    clang-14
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                         bcm2835_defconfig    gcc-13.2.0
arm                                 defconfig    gcc-14.1.0
arm                            dove_defconfig    gcc-14.1.0
arm                       imx_v4_v5_defconfig    clang-14
arm                        multi_v5_defconfig    gcc-14.1.0
arm                        mvebu_v5_defconfig    clang-14
arm                   randconfig-001-20241102    gcc-14.1.0
arm                   randconfig-002-20241102    gcc-14.1.0
arm                   randconfig-003-20241102    gcc-14.1.0
arm                   randconfig-004-20241102    gcc-14.1.0
arm                         s5pv210_defconfig    gcc-13.2.0
arm                           sunxi_defconfig    clang-14
arm                           tegra_defconfig    gcc-13.2.0
arm                           tegra_defconfig    gcc-14.1.0
arm                           u8500_defconfig    gcc-13.2.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
arm64                 randconfig-001-20241102    gcc-14.1.0
arm64                 randconfig-002-20241102    gcc-14.1.0
arm64                 randconfig-003-20241102    gcc-14.1.0
arm64                 randconfig-004-20241102    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
csky                  randconfig-001-20241102    gcc-14.1.0
csky                  randconfig-002-20241102    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
hexagon               randconfig-001-20241102    gcc-14.1.0
hexagon               randconfig-002-20241102    gcc-14.1.0
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                             allyesconfig    clang-19
i386        buildonly-randconfig-001-20241102    gcc-12
i386        buildonly-randconfig-002-20241102    gcc-12
i386        buildonly-randconfig-003-20241102    gcc-12
i386        buildonly-randconfig-004-20241102    gcc-12
i386        buildonly-randconfig-005-20241102    gcc-12
i386        buildonly-randconfig-006-20241102    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20241102    gcc-12
i386                  randconfig-002-20241102    gcc-12
i386                  randconfig-003-20241102    gcc-12
i386                  randconfig-004-20241102    gcc-12
i386                  randconfig-005-20241102    gcc-12
i386                  randconfig-006-20241102    gcc-12
i386                  randconfig-011-20241102    gcc-12
i386                  randconfig-012-20241102    gcc-12
i386                  randconfig-013-20241102    gcc-12
i386                  randconfig-014-20241102    gcc-12
i386                  randconfig-015-20241102    gcc-12
i386                  randconfig-016-20241102    gcc-12
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
loongarch             randconfig-001-20241102    gcc-14.1.0
loongarch             randconfig-002-20241102    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                         apollo_defconfig    clang-14
m68k                                defconfig    gcc-14.1.0
m68k                        m5307c3_defconfig    gcc-14.1.0
m68k                        m5407c3_defconfig    gcc-14.1.0
m68k                       m5475evb_defconfig    gcc-13.2.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                        bcm47xx_defconfig    gcc-13.2.0
mips                        bcm63xx_defconfig    clang-14
mips                           ip22_defconfig    gcc-13.2.0
mips                           ip30_defconfig    gcc-14.1.0
mips                        omega2p_defconfig    clang-14
mips                       rbtx49xx_defconfig    gcc-13.2.0
nios2                            alldefconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
nios2                 randconfig-001-20241102    gcc-14.1.0
nios2                 randconfig-002-20241102    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.1.0
parisc                           alldefconfig    clang-14
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.1.0
parisc                randconfig-001-20241102    gcc-14.1.0
parisc                randconfig-002-20241102    gcc-14.1.0
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.1.0
powerpc                      arches_defconfig    gcc-13.2.0
powerpc                      arches_defconfig    gcc-14.1.0
powerpc                        fsp2_defconfig    gcc-13.2.0
powerpc                     mpc5200_defconfig    clang-14
powerpc                    mvme5100_defconfig    gcc-14.1.0
powerpc                      pasemi_defconfig    gcc-14.1.0
powerpc               randconfig-001-20241102    gcc-14.1.0
powerpc               randconfig-002-20241102    gcc-14.1.0
powerpc               randconfig-003-20241102    gcc-14.1.0
powerpc64             randconfig-001-20241102    gcc-14.1.0
powerpc64             randconfig-002-20241102    gcc-14.1.0
powerpc64             randconfig-003-20241102    gcc-14.1.0
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
riscv                 randconfig-001-20241102    gcc-14.1.0
riscv                 randconfig-002-20241102    gcc-14.1.0
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                  randconfig-001-20241102    gcc-14.1.0
s390                  randconfig-002-20241102    gcc-14.1.0
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                             espt_defconfig    gcc-14.1.0
sh                 kfr2r09-romimage_defconfig    clang-14
sh                          r7785rp_defconfig    clang-14
sh                    randconfig-001-20241102    gcc-14.1.0
sh                    randconfig-002-20241102    gcc-14.1.0
sh                           se7619_defconfig    clang-14
sh                           se7712_defconfig    gcc-13.2.0
sh                           se7750_defconfig    clang-14
sh                        sh7757lcr_defconfig    gcc-13.2.0
sh                        sh7785lcr_defconfig    gcc-14.1.0
sparc                            allmodconfig    gcc-14.1.0
sparc                       sparc64_defconfig    gcc-13.2.0
sparc64               randconfig-001-20241102    gcc-14.1.0
sparc64               randconfig-002-20241102    gcc-14.1.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                             i386_defconfig    clang-14
um                    randconfig-001-20241102    gcc-14.1.0
um                    randconfig-002-20241102    gcc-14.1.0
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241102    clang-19
x86_64      buildonly-randconfig-002-20241102    clang-19
x86_64      buildonly-randconfig-003-20241102    clang-19
x86_64      buildonly-randconfig-004-20241102    clang-19
x86_64      buildonly-randconfig-005-20241102    clang-19
x86_64      buildonly-randconfig-006-20241102    clang-19
x86_64                              defconfig    clang-19
x86_64                                  kexec    clang-19
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20241102    clang-19
x86_64                randconfig-002-20241102    clang-19
x86_64                randconfig-003-20241102    clang-19
x86_64                randconfig-004-20241102    clang-19
x86_64                randconfig-005-20241102    clang-19
x86_64                randconfig-006-20241102    clang-19
x86_64                randconfig-011-20241102    clang-19
x86_64                randconfig-012-20241102    clang-19
x86_64                randconfig-013-20241102    clang-19
x86_64                randconfig-014-20241102    clang-19
x86_64                randconfig-015-20241102    clang-19
x86_64                randconfig-016-20241102    clang-19
x86_64                randconfig-071-20241102    clang-19
x86_64                randconfig-072-20241102    clang-19
x86_64                randconfig-073-20241102    clang-19
x86_64                randconfig-074-20241102    clang-19
x86_64                randconfig-075-20241102    clang-19
x86_64                randconfig-076-20241102    clang-19
x86_64                               rhel-8.3    gcc-12
x86_64                           rhel-8.3-bpf    clang-19
x86_64                         rhel-8.3-kunit    clang-19
x86_64                           rhel-8.3-ltp    clang-19
x86_64                          rhel-8.3-rust    clang-19
xtensa                            allnoconfig    gcc-14.1.0
xtensa                       common_defconfig    clang-14
xtensa                          iss_defconfig    gcc-14.1.0
xtensa                randconfig-001-20241102    gcc-14.1.0
xtensa                randconfig-002-20241102    gcc-14.1.0
xtensa                         virt_defconfig    gcc-13.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

