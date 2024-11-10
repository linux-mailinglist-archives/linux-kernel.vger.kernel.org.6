Return-Path: <linux-kernel+bounces-403097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2562C9C3101
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 07:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 667FFB210E9
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 06:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC84514B075;
	Sun, 10 Nov 2024 06:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PV2OYhoI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C9413D29A
	for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 06:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731218738; cv=none; b=PHQhXTMM5vG1PgpQe8ncNSJyCrKIk+HvRUD+M6Z90TprTRgkTgM0+ZTUfSKLiq9Q/LGm/uLeT23M15P5/p03EaWan2NRSq+ofCJw9fMLI5t4rBTiG9kv6JtUVw0JThLLJUENQV7dEU5QJLl6+AUphRexuaAFUtQiVQi54qXizmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731218738; c=relaxed/simple;
	bh=SwTTl1Uw/YXrs7DvIN0VyM1JCVcE9w4q0QEDdzZYKss=;
	h=Date:From:To:Cc:Subject:Message-ID; b=RxKudDlbdmG6amrMJftKGAYrfT3thmWEVYpLJRBFglIW8EEmwx/VKutCIrqo5ywL3jJp84M1sGlG6PbCOzFRaSxnppJhsgUOYzYF18bKWvAeRwYqn5twkpRQdBUQaaYgxtry0lbo0gXKmloNdC2PpsxVYSgK+vGnISLCZrSm8Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PV2OYhoI; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731218736; x=1762754736;
  h=date:from:to:cc:subject:message-id;
  bh=SwTTl1Uw/YXrs7DvIN0VyM1JCVcE9w4q0QEDdzZYKss=;
  b=PV2OYhoIHSubYRPGX2Hq1lYqXiT0oXsgrbR2/nIQUgplVi678MT3Kcp0
   5hscWfG9/FRN+L7zpw26QWZ51dacFqGAqCFCiJfa51RSesfa3MKPWXFAD
   QNEwvoPG/tjnBhcT2Derqmzeslez15L7vj7aKWgDAH8K9PkEkmOzLX9go
   sZiGCToC2vuzHMKA4HQgiziePbk9WrQPN1/dBLPN2HcrL9csa7RJVZcKD
   wTVdQ291Uds9NdFyxNgdcBNYMGzgGno9IsInAxnUrLJK3T6MM4j188wsc
   6ZX28EcP3FRq4nVQUAua44tHgN3gbur4AOLvJ+A/3KegWftrM4GRL0QwQ
   Q==;
X-CSE-ConnectionGUID: 0fWvCAJ+SxewCg//Mi/uBg==
X-CSE-MsgGUID: qMXIRO9JQ/OpL/Dz1V8yKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11251"; a="48570097"
X-IronPort-AV: E=Sophos;i="6.12,142,1728975600"; 
   d="scan'208";a="48570097"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2024 22:05:33 -0800
X-CSE-ConnectionGUID: 0h+/NhttTXWBxyi91QcWCQ==
X-CSE-MsgGUID: /a8XCJGnTbCrU1Gq4vHGVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,142,1728975600"; 
   d="scan'208";a="85969117"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 09 Nov 2024 22:05:32 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tA14j-000tEC-2R;
	Sun, 10 Nov 2024 06:05:29 +0000
Date: Sun, 10 Nov 2024 14:05:28 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:non-rcu/next] BUILD SUCCESS
 55468927226f4ad190b719cead09260cb371a642
Message-ID: <202411101423.zqEuFi3N-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git non-rcu/next
branch HEAD: 55468927226f4ad190b719cead09260cb371a642  Merge branches 'csd-lock.2024.10.11a', 'lkmm.2024.11.09a' and 'scftorture.2024.11.09a', tag 'nolibc.2024.11.01a' into HEAD

elapsed time: 723m

configs tested: 241
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-20
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-20
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-14.2.0
arc                   randconfig-001-20241110    gcc-13.2.0
arc                   randconfig-002-20241110    gcc-13.2.0
arm                              allmodconfig    clang-20
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-20
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-20
arm                              allyesconfig    gcc-14.2.0
arm                     am200epdkit_defconfig    gcc-14.2.0
arm                         at91_dt_defconfig    clang-20
arm                                 defconfig    gcc-14.2.0
arm                            dove_defconfig    gcc-14.2.0
arm                          gemini_defconfig    clang-20
arm                           h3600_defconfig    clang-15
arm                            hisi_defconfig    clang-15
arm                       imx_v6_v7_defconfig    clang-20
arm                           imxrt_defconfig    clang-20
arm                          ixp4xx_defconfig    gcc-14.2.0
arm                       netwinder_defconfig    gcc-14.2.0
arm                          pxa910_defconfig    clang-20
arm                   randconfig-001-20241110    clang-20
arm                   randconfig-002-20241110    gcc-14.2.0
arm                   randconfig-003-20241110    gcc-14.2.0
arm                   randconfig-004-20241110    clang-20
arm                           sama5_defconfig    clang-20
arm                           sama7_defconfig    clang-15
arm                           spitz_defconfig    clang-15
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20241110    gcc-14.2.0
arm64                 randconfig-002-20241110    gcc-14.2.0
arm64                 randconfig-003-20241110    gcc-14.2.0
arm64                 randconfig-004-20241110    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20241110    gcc-14.2.0
csky                  randconfig-002-20241110    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20241110    clang-20
hexagon               randconfig-002-20241110    clang-20
i386                             allmodconfig    clang-19
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-19
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-19
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241110    gcc-11
i386        buildonly-randconfig-002-20241110    gcc-11
i386        buildonly-randconfig-002-20241110    gcc-12
i386        buildonly-randconfig-003-20241110    clang-19
i386        buildonly-randconfig-003-20241110    gcc-11
i386        buildonly-randconfig-004-20241110    gcc-11
i386        buildonly-randconfig-005-20241110    gcc-11
i386        buildonly-randconfig-005-20241110    gcc-12
i386        buildonly-randconfig-006-20241110    gcc-11
i386        buildonly-randconfig-006-20241110    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20241110    gcc-11
i386                  randconfig-001-20241110    gcc-12
i386                  randconfig-002-20241110    clang-19
i386                  randconfig-002-20241110    gcc-11
i386                  randconfig-003-20241110    gcc-11
i386                  randconfig-003-20241110    gcc-12
i386                  randconfig-004-20241110    clang-19
i386                  randconfig-004-20241110    gcc-11
i386                  randconfig-005-20241110    gcc-11
i386                  randconfig-005-20241110    gcc-12
i386                  randconfig-006-20241110    gcc-11
i386                  randconfig-006-20241110    gcc-12
i386                  randconfig-011-20241110    clang-19
i386                  randconfig-011-20241110    gcc-11
i386                  randconfig-012-20241110    gcc-11
i386                  randconfig-012-20241110    gcc-12
i386                  randconfig-013-20241110    gcc-11
i386                  randconfig-013-20241110    gcc-12
i386                  randconfig-014-20241110    gcc-11
i386                  randconfig-014-20241110    gcc-12
i386                  randconfig-015-20241110    gcc-11
i386                  randconfig-015-20241110    gcc-12
i386                  randconfig-016-20241110    clang-19
i386                  randconfig-016-20241110    gcc-11
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch                 loongson3_defconfig    clang-15
loongarch             randconfig-001-20241110    gcc-14.2.0
loongarch             randconfig-002-20241110    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                       bvme6000_defconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                        m5272c3_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                        bcm47xx_defconfig    clang-15
mips                         db1xxx_defconfig    clang-15
mips                           mtx1_defconfig    clang-20
mips                          rb532_defconfig    clang-20
mips                        vocore2_defconfig    clang-15
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20241110    gcc-14.2.0
nios2                 randconfig-002-20241110    gcc-14.2.0
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
openrisc                            defconfig    gcc-14.2.0
openrisc                       virt_defconfig    clang-20
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                              defconfig    gcc-14.2.0
parisc                generic-32bit_defconfig    gcc-14.2.0
parisc                randconfig-001-20241110    gcc-14.2.0
parisc                randconfig-002-20241110    gcc-14.2.0
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-20
powerpc                          allyesconfig    gcc-14.2.0
powerpc                        cell_defconfig    gcc-14.2.0
powerpc                      chrp32_defconfig    clang-20
powerpc                       ebony_defconfig    clang-15
powerpc                       eiger_defconfig    clang-15
powerpc                        fsp2_defconfig    clang-15
powerpc                    ge_imp3a_defconfig    clang-20
powerpc                   lite5200b_defconfig    clang-15
powerpc                  mpc885_ads_defconfig    clang-20
powerpc                    mvme5100_defconfig    clang-15
powerpc               randconfig-001-20241110    gcc-14.2.0
powerpc                     tqm8540_defconfig    gcc-14.2.0
powerpc                     tqm8555_defconfig    clang-15
powerpc                         wii_defconfig    gcc-14.2.0
riscv                            alldefconfig    clang-20
riscv                            allmodconfig    clang-20
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    clang-20
riscv                               defconfig    gcc-12
s390                             allmodconfig    clang-20
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                          debug_defconfig    clang-20
s390                          debug_defconfig    gcc-14.2.0
s390                                defconfig    clang-20
s390                                defconfig    gcc-12
s390                       zfcpdump_defconfig    clang-20
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                                  defconfig    gcc-14.2.0
sh                        edosk7760_defconfig    clang-15
sh                          rsk7201_defconfig    clang-15
sh                          rsk7264_defconfig    clang-20
sh                           se7705_defconfig    gcc-14.2.0
sh                              ul2_defconfig    clang-15
sparc                            allmodconfig    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64                             defconfig    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                               allyesconfig    gcc-12
um                                  defconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                           x86_64_defconfig    clang-15
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241110    clang-19
x86_64      buildonly-randconfig-001-20241110    gcc-12
x86_64      buildonly-randconfig-002-20241110    gcc-12
x86_64      buildonly-randconfig-003-20241110    clang-19
x86_64      buildonly-randconfig-003-20241110    gcc-12
x86_64      buildonly-randconfig-004-20241110    gcc-12
x86_64      buildonly-randconfig-005-20241110    gcc-12
x86_64      buildonly-randconfig-006-20241110    clang-19
x86_64      buildonly-randconfig-006-20241110    gcc-12
x86_64                              defconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20241110    gcc-12
x86_64                randconfig-002-20241110    clang-19
x86_64                randconfig-002-20241110    gcc-12
x86_64                randconfig-003-20241110    gcc-12
x86_64                randconfig-004-20241110    gcc-12
x86_64                randconfig-005-20241110    clang-19
x86_64                randconfig-005-20241110    gcc-12
x86_64                randconfig-006-20241110    clang-19
x86_64                randconfig-006-20241110    gcc-12
x86_64                randconfig-011-20241110    gcc-12
x86_64                randconfig-012-20241110    gcc-12
x86_64                randconfig-013-20241110    gcc-12
x86_64                randconfig-014-20241110    clang-19
x86_64                randconfig-014-20241110    gcc-12
x86_64                randconfig-015-20241110    gcc-12
x86_64                randconfig-016-20241110    gcc-12
x86_64                randconfig-071-20241110    clang-19
x86_64                randconfig-071-20241110    gcc-12
x86_64                randconfig-072-20241110    gcc-12
x86_64                randconfig-073-20241110    gcc-12
x86_64                randconfig-074-20241110    gcc-12
x86_64                randconfig-075-20241110    gcc-11
x86_64                randconfig-075-20241110    gcc-12
x86_64                randconfig-076-20241110    clang-19
x86_64                randconfig-076-20241110    gcc-12
x86_64                               rhel-8.3    gcc-12
xtensa                            allnoconfig    gcc-14.2.0
xtensa                  cadence_csp_defconfig    gcc-14.2.0
xtensa                          iss_defconfig    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

