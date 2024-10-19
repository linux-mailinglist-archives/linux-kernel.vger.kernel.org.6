Return-Path: <linux-kernel+bounces-372821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE4D9A4DCB
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 14:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA3E2B23A75
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 12:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72FD1E0B85;
	Sat, 19 Oct 2024 12:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JXjzeJeI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B4D1DE887
	for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 12:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729340855; cv=none; b=n4qU7TAYochlm/UmjXCPmMov2PbWaWXt/8RkzV3MbF2y/HSOCRmDkJQL7tyYpJ+CjcxoGOzvXLf4+c64rdIM0x2lfauLJattUPwQqSHuKH0c/+Q2K00HEkJTs2aB63UUewPIhAN4HDKC1r6Y/yzeIHrOFs3vnrFUMmgpB0g2EG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729340855; c=relaxed/simple;
	bh=ZMTNZhpQxYQ0iLieekLWhwF4Vb8hm6PdUuZRZ3waeJ0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=C5vktdUF2ksv7vHqo3kR/j5C0sO++EyGe0WaTtwbtwId+z9NOdGgBxU7DXBejbmKn1kA8L6REjooRcNLmOm0qcbAkkkzQggli/Ewbfwr+VR6EoHfV68qrOsjFCUhPWqGiw4xqZWijzyOFPNMPbDt13KpsoTYnch29cKqvwzdvFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JXjzeJeI; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729340853; x=1760876853;
  h=date:from:to:cc:subject:message-id;
  bh=ZMTNZhpQxYQ0iLieekLWhwF4Vb8hm6PdUuZRZ3waeJ0=;
  b=JXjzeJeIqoRqixcYgpIdkvc82pXkL6dgnCOm52pw54+FSvKQqPIZ1LRy
   tHeg7VauY1LPD+6Rx3zgXeCAAoKkae5jru9IPU5h3Xu5xHuCV2Nt8f2nq
   /R0WNn+l0mAlZTOZkjug6g+/W7F2k2ydm6wuMNTh0AOUOORF5jtFL3Kku
   8+Xamhh26iNfb2uGgZdoh/4b+tKHE2hqpI+JHSJOW184ZgxpJ72cMaSm9
   eiRj3a4YGbOSSMwszll7mSHCRGdGJdT9jUeRPaGqu3DT7qagUIuxLA2Hu
   TA0zvOLR4824JPBa7Frg+p9W1SMs0TXFXiP1vR5xUon6kj8kvCL97DReZ
   w==;
X-CSE-ConnectionGUID: Tib4GU5QRqGPiC+jHuqrpg==
X-CSE-MsgGUID: mKwp2szWSyqDWo2ICRW9iw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28825911"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28825911"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2024 05:27:32 -0700
X-CSE-ConnectionGUID: vvxB+Q4QR1q/vmnqHDLM1g==
X-CSE-MsgGUID: SmTYv8/OTmGtyfpu1rtZ0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,216,1725346800"; 
   d="scan'208";a="109932306"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 19 Oct 2024 05:27:32 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t28YL-000Oyn-1d;
	Sat, 19 Oct 2024 12:27:29 +0000
Date: Sat, 19 Oct 2024 20:26:37 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2024.10.17a] BUILD SUCCESS
 202c6fa4204a77c7de0083c7cb5a82a83adb4711
Message-ID: <202410192030.r26Ev8jQ-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2024.10.17a
branch HEAD: 202c6fa4204a77c7de0083c7cb5a82a83adb4711  rcutorture: Decorate failing reader segments with CPU ID

elapsed time: 2431m

configs tested: 203
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                      axs103_smp_defconfig    clang-20
arc                                 defconfig    gcc-14.1.0
arc                   randconfig-001-20241019    clang-16
arc                   randconfig-002-20241019    clang-16
arc                        vdk_hs38_defconfig    clang-20
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                     am200epdkit_defconfig    clang-20
arm                       aspeed_g5_defconfig    gcc-14.1.0
arm                         axm55xx_defconfig    gcc-14.1.0
arm                                 defconfig    gcc-14.1.0
arm                         lpc32xx_defconfig    gcc-14.1.0
arm                         nhk8815_defconfig    clang-20
arm                       omap2plus_defconfig    clang-20
arm                          pxa910_defconfig    gcc-14.1.0
arm                   randconfig-001-20241019    clang-16
arm                   randconfig-002-20241019    clang-16
arm                   randconfig-003-20241019    clang-16
arm                   randconfig-004-20241019    clang-16
arm                          sp7021_defconfig    clang-20
arm                           u8500_defconfig    clang-20
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
arm64                 randconfig-001-20241019    clang-16
arm64                 randconfig-002-20241019    clang-16
arm64                 randconfig-003-20241019    clang-16
arm64                 randconfig-004-20241019    clang-16
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
csky                  randconfig-001-20241019    clang-16
csky                  randconfig-002-20241019    clang-16
hexagon                          alldefconfig    clang-20
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
hexagon               randconfig-001-20241019    clang-16
hexagon               randconfig-002-20241019    clang-16
i386                             allmodconfig    clang-18
i386                              allnoconfig    clang-18
i386                             allyesconfig    clang-18
i386        buildonly-randconfig-001-20241019    clang-18
i386        buildonly-randconfig-002-20241019    clang-18
i386        buildonly-randconfig-003-20241019    clang-18
i386        buildonly-randconfig-004-20241019    clang-18
i386        buildonly-randconfig-005-20241019    clang-18
i386        buildonly-randconfig-006-20241019    clang-18
i386                                defconfig    clang-18
i386                  randconfig-001-20241019    clang-18
i386                  randconfig-002-20241019    clang-18
i386                  randconfig-003-20241019    clang-18
i386                  randconfig-004-20241019    clang-18
i386                  randconfig-005-20241019    clang-18
i386                  randconfig-006-20241019    clang-18
i386                  randconfig-011-20241019    clang-18
i386                  randconfig-012-20241019    clang-18
i386                  randconfig-013-20241019    clang-18
i386                  randconfig-014-20241019    clang-18
i386                  randconfig-015-20241019    clang-18
i386                  randconfig-016-20241019    clang-18
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
loongarch             randconfig-001-20241019    clang-16
loongarch             randconfig-002-20241019    clang-16
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                         amcore_defconfig    clang-20
m68k                                defconfig    gcc-14.1.0
m68k                          hp300_defconfig    clang-20
m68k                        m5307c3_defconfig    clang-20
m68k                            mac_defconfig    gcc-14.1.0
m68k                        mvme147_defconfig    gcc-14.1.0
m68k                            q40_defconfig    gcc-14.1.0
m68k                        stmark2_defconfig    clang-20
m68k                          sun3x_defconfig    clang-20
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                          ath79_defconfig    gcc-14.1.0
mips                         bigsur_defconfig    clang-20
mips                          eyeq5_defconfig    clang-20
mips                         rt305x_defconfig    clang-20
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
nios2                 randconfig-001-20241019    clang-16
nios2                 randconfig-002-20241019    clang-16
openrisc                         alldefconfig    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc                generic-32bit_defconfig    clang-20
parisc                randconfig-001-20241019    clang-16
parisc                randconfig-002-20241019    clang-16
parisc64                            defconfig    gcc-14.1.0
powerpc                     akebono_defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.1.0
powerpc                   currituck_defconfig    clang-20
powerpc                       ebony_defconfig    clang-20
powerpc                       holly_defconfig    clang-20
powerpc                     mpc512x_defconfig    clang-20
powerpc                     mpc512x_defconfig    gcc-14.1.0
powerpc                 mpc832x_rdb_defconfig    gcc-14.1.0
powerpc                 mpc837x_rdb_defconfig    gcc-14.1.0
powerpc                    mvme5100_defconfig    clang-20
powerpc               randconfig-001-20241019    clang-16
powerpc               randconfig-002-20241019    clang-16
powerpc               randconfig-003-20241019    clang-16
powerpc                     tqm8541_defconfig    clang-20
powerpc64             randconfig-001-20241019    clang-16
powerpc64             randconfig-002-20241019    clang-16
powerpc64             randconfig-003-20241019    clang-16
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20241019    clang-16
riscv                 randconfig-002-20241019    clang-16
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20241019    clang-16
s390                  randconfig-002-20241019    clang-16
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                 kfr2r09-romimage_defconfig    gcc-14.1.0
sh                          lboxre2_defconfig    gcc-14.1.0
sh                    randconfig-001-20241019    clang-16
sh                    randconfig-002-20241019    clang-16
sh                      rts7751r2d1_defconfig    clang-20
sh                           se7705_defconfig    clang-20
sh                           se7722_defconfig    clang-20
sh                  sh7785lcr_32bit_defconfig    clang-20
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20241019    clang-16
sparc64               randconfig-002-20241019    clang-16
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241019    clang-16
um                    randconfig-002-20241019    clang-16
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64      buildonly-randconfig-001-20241019    clang-18
x86_64      buildonly-randconfig-002-20241019    clang-18
x86_64      buildonly-randconfig-003-20241019    clang-18
x86_64      buildonly-randconfig-004-20241019    clang-18
x86_64      buildonly-randconfig-005-20241019    clang-18
x86_64      buildonly-randconfig-006-20241019    clang-18
x86_64                              defconfig    clang-18
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20241019    clang-18
x86_64                randconfig-002-20241019    clang-18
x86_64                randconfig-003-20241019    clang-18
x86_64                randconfig-004-20241019    clang-18
x86_64                randconfig-005-20241019    clang-18
x86_64                randconfig-006-20241019    clang-18
x86_64                randconfig-011-20241019    clang-18
x86_64                randconfig-012-20241019    clang-18
x86_64                randconfig-013-20241019    clang-18
x86_64                randconfig-014-20241019    clang-18
x86_64                randconfig-015-20241019    clang-18
x86_64                randconfig-016-20241019    clang-18
x86_64                randconfig-071-20241019    clang-18
x86_64                randconfig-072-20241019    clang-18
x86_64                randconfig-073-20241019    clang-18
x86_64                randconfig-074-20241019    clang-18
x86_64                randconfig-075-20241019    clang-18
x86_64                randconfig-076-20241019    clang-18
x86_64                               rhel-8.3    gcc-12
x86_64                           rhel-8.3-bpf    clang-18
x86_64                         rhel-8.3-kunit    clang-18
x86_64                           rhel-8.3-ltp    clang-18
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0
xtensa                  cadence_csp_defconfig    clang-20
xtensa                randconfig-001-20241019    clang-16
xtensa                randconfig-002-20241019    clang-16
xtensa                    smp_lx200_defconfig    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

