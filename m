Return-Path: <linux-kernel+bounces-385453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DB09B3758
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 18:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1862B1F22A5A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 17:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A73C1DF72E;
	Mon, 28 Oct 2024 17:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="laXRUwNs"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DF61DF269
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 17:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730135238; cv=none; b=GtSW/iysS+hDOYfwMpbqtawWWfeYa+kTeWi2ipDLoTgIdcI7NJEeM1IesI0/qrqr58pDQtBW3pNGFCZb7uyhi5SYfwy70M5uifehOTCR2Xyab4plFqPlyr9BFW3fpSME1xAXCKng1q+BtNSM/a/WkrUAOdomWJLCasSWLzgvXG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730135238; c=relaxed/simple;
	bh=W40Us+IC5bc/6kjCOF4OnkFw53nOp75Ff28maSQE6y4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=h6M7KrLWT0dUhoo8ont6K8dub3q0kOKlVZSUrPTQCcUtM+Kxn7qv2DgLztXoOacM4JqxwNnx5ZN7A9V3IMrVuWrMKxiDcfW8OWbVavzbCNYrnt3tCuIbVstK8uqtJX4DE7KTIM6SAlEiZDOH3EwCzFEkYyFJmGwghTS9VY1p1Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=laXRUwNs; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730135236; x=1761671236;
  h=date:from:to:cc:subject:message-id;
  bh=W40Us+IC5bc/6kjCOF4OnkFw53nOp75Ff28maSQE6y4=;
  b=laXRUwNs//nuVJoBt4b09W964+gOhkTkMPlREwbrLZi0jXwK6A9P9PWe
   JQ5grfW+xYXXTpCZGHT+mhmt/sXzYRi74axQgpqdx0IREVK/UbvL6WESD
   z4K4u84/awEMr7cOprFYKs4KcR2lMnmC+aefFVyjqJcz5IgWutN928b1R
   Tb2KInrzH+QLKMNM8HuLYe5aAPHk9+q42ZPNq++fDipU3qlvWhF8C0sI9
   eQT7XjAFiBJV6u4kYmVTmlepdfJdaI6h4f9+Nrrd5pxwGps0L8FOxOFsJ
   mPbt63Aml6LiWBXlHnIGCupDEEY/MuSiNyDorXrPQkAW8Odbud7RM4egB
   g==;
X-CSE-ConnectionGUID: 4KPL2umYTb+WheZB7nW1bg==
X-CSE-MsgGUID: D0bm8T5MQE6nsiavSSgzqw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="52294481"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="52294481"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 10:07:16 -0700
X-CSE-ConnectionGUID: 0TWiUlhRTK6Z4Tzjh6lTBg==
X-CSE-MsgGUID: myhfXlUzTsiO/yQ+3xyylw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="82097755"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 28 Oct 2024 10:07:14 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t5TCx-000cfY-2N;
	Mon, 28 Oct 2024 17:07:11 +0000
Date: Tue, 29 Oct 2024 01:06:31 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:irq/urgent] BUILD SUCCESS
 e6c24e2d05bb05de96ffb9bdb0ee62d20ad526f8
Message-ID: <202410290124.hy26s5hd-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/urgent
branch HEAD: e6c24e2d05bb05de96ffb9bdb0ee62d20ad526f8  irqchip/gic-v4: Correctly deal with set_affinity on lazily-mapped VPEs

elapsed time: 1448m

configs tested: 230
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig    gcc-13.2.0
alpha                             allnoconfig    gcc-13.3.0
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                            allyesconfig    gcc-13.3.0
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                          axs101_defconfig    gcc-13.2.0
arc                                 defconfig    gcc-14.1.0
arc                     haps_hs_smp_defconfig    gcc-13.2.0
arc                     nsimosci_hs_defconfig    gcc-13.2.0
arc                   randconfig-001-20241028    gcc-14.1.0
arc                   randconfig-002-20241028    gcc-14.1.0
arc                           tb10x_defconfig    clang-20
arc                        vdk_hs38_defconfig    clang-14
arm                              allmodconfig    clang-20
arm                               allnoconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                         assabet_defconfig    clang-14
arm                          collie_defconfig    clang-14
arm                                 defconfig    gcc-14.1.0
arm                          ep93xx_defconfig    clang-20
arm                          gemini_defconfig    clang-14
arm                         nhk8815_defconfig    clang-20
arm                           omap1_defconfig    clang-14
arm                          pxa3xx_defconfig    clang-14
arm                   randconfig-001-20241028    gcc-14.1.0
arm                   randconfig-002-20241028    gcc-14.1.0
arm                   randconfig-003-20241028    gcc-14.1.0
arm                   randconfig-004-20241028    gcc-14.1.0
arm                         s3c6400_defconfig    clang-14
arm                         s5pv210_defconfig    gcc-13.2.0
arm                         wpcm450_defconfig    clang-14
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
arm64                 randconfig-001-20241028    gcc-14.1.0
arm64                 randconfig-002-20241028    gcc-14.1.0
arm64                 randconfig-003-20241028    gcc-14.1.0
arm64                 randconfig-004-20241028    gcc-14.1.0
csky                             alldefconfig    clang-20
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
csky                  randconfig-001-20241028    gcc-14.1.0
csky                  randconfig-002-20241028    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
hexagon               randconfig-001-20241028    gcc-14.1.0
hexagon               randconfig-002-20241028    gcc-14.1.0
i386                             allmodconfig    clang-19
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-19
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-19
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241028    clang-19
i386        buildonly-randconfig-001-20241028    gcc-12
i386        buildonly-randconfig-002-20241028    clang-19
i386        buildonly-randconfig-003-20241028    clang-19
i386        buildonly-randconfig-004-20241028    clang-19
i386        buildonly-randconfig-005-20241028    clang-19
i386        buildonly-randconfig-006-20241028    clang-19
i386                                defconfig    clang-19
i386                  randconfig-001-20241028    clang-19
i386                  randconfig-002-20241028    clang-19
i386                  randconfig-002-20241028    gcc-12
i386                  randconfig-003-20241028    clang-19
i386                  randconfig-003-20241028    gcc-12
i386                  randconfig-004-20241028    clang-19
i386                  randconfig-005-20241028    clang-19
i386                  randconfig-006-20241028    clang-19
i386                  randconfig-011-20241028    clang-19
i386                  randconfig-011-20241028    gcc-11
i386                  randconfig-012-20241028    clang-19
i386                  randconfig-013-20241028    clang-19
i386                  randconfig-014-20241028    clang-19
i386                  randconfig-015-20241028    clang-19
i386                  randconfig-015-20241028    gcc-12
i386                  randconfig-016-20241028    clang-19
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
loongarch             randconfig-001-20241028    gcc-14.1.0
loongarch             randconfig-002-20241028    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
m68k                        m5307c3_defconfig    clang-20
m68k                        m5407c3_defconfig    clang-20
m68k                            q40_defconfig    clang-20
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                          ath79_defconfig    clang-20
mips                        bcm63xx_defconfig    clang-20
mips                          eyeq5_defconfig    clang-14
mips                      maltaaprp_defconfig    clang-14
mips                   sb1250_swarm_defconfig    gcc-13.2.0
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
nios2                 randconfig-001-20241028    gcc-14.1.0
nios2                 randconfig-002-20241028    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.1.0
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.1.0
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc                generic-32bit_defconfig    clang-20
parisc                randconfig-001-20241028    gcc-14.1.0
parisc                randconfig-002-20241028    gcc-14.1.0
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.1.0
powerpc                          allyesconfig    clang-20
powerpc                          allyesconfig    gcc-14.1.0
powerpc                      cm5200_defconfig    clang-14
powerpc                     ksi8560_defconfig    gcc-13.2.0
powerpc                 linkstation_defconfig    clang-14
powerpc               randconfig-001-20241028    gcc-14.1.0
powerpc               randconfig-002-20241028    gcc-14.1.0
powerpc               randconfig-003-20241028    gcc-14.1.0
powerpc                         wii_defconfig    clang-14
powerpc64             randconfig-001-20241028    gcc-14.1.0
powerpc64             randconfig-002-20241028    gcc-14.1.0
powerpc64             randconfig-003-20241028    gcc-14.1.0
riscv                            allmodconfig    clang-20
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.1.0
riscv                            allyesconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    clang-20
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20241028    gcc-14.1.0
riscv                 randconfig-002-20241028    gcc-14.1.0
s390                             allmodconfig    clang-20
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20241028    gcc-14.1.0
s390                  randconfig-002-20241028    gcc-14.1.0
sh                               alldefconfig    clang-14
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                         apsh4a3a_defconfig    gcc-13.2.0
sh                                  defconfig    gcc-12
sh                               j2_defconfig    clang-20
sh                            migor_defconfig    clang-20
sh                    randconfig-001-20241028    gcc-14.1.0
sh                    randconfig-002-20241028    gcc-14.1.0
sh                          rsk7264_defconfig    clang-20
sh                          rsk7269_defconfig    clang-14
sh                          sdk7780_defconfig    clang-20
sh                          sdk7786_defconfig    gcc-13.2.0
sh                           se7206_defconfig    gcc-13.2.0
sh                           se7343_defconfig    clang-20
sh                           se7343_defconfig    gcc-13.2.0
sh                   sh7770_generic_defconfig    gcc-13.2.0
sh                        sh7785lcr_defconfig    gcc-13.2.0
sh                              ul2_defconfig    clang-14
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20241028    gcc-14.1.0
sparc64               randconfig-002-20241028    gcc-14.1.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                             i386_defconfig    gcc-13.2.0
um                    randconfig-001-20241028    gcc-14.1.0
um                    randconfig-002-20241028    gcc-14.1.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241028    gcc-12
x86_64      buildonly-randconfig-002-20241028    gcc-12
x86_64      buildonly-randconfig-003-20241028    gcc-12
x86_64      buildonly-randconfig-004-20241028    gcc-12
x86_64      buildonly-randconfig-005-20241028    gcc-12
x86_64      buildonly-randconfig-006-20241028    gcc-12
x86_64                              defconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20241028    gcc-12
x86_64                randconfig-002-20241028    gcc-12
x86_64                randconfig-003-20241028    gcc-12
x86_64                randconfig-004-20241028    gcc-12
x86_64                randconfig-005-20241028    gcc-12
x86_64                randconfig-006-20241028    gcc-12
x86_64                randconfig-011-20241028    gcc-12
x86_64                randconfig-012-20241028    gcc-12
x86_64                randconfig-013-20241028    gcc-12
x86_64                randconfig-014-20241028    gcc-12
x86_64                randconfig-015-20241028    gcc-12
x86_64                randconfig-016-20241028    gcc-12
x86_64                randconfig-071-20241028    gcc-12
x86_64                randconfig-072-20241028    gcc-12
x86_64                randconfig-073-20241028    gcc-12
x86_64                randconfig-074-20241028    gcc-12
x86_64                randconfig-075-20241028    gcc-12
x86_64                randconfig-076-20241028    gcc-12
x86_64                               rhel-8.3    gcc-12
x86_64                           rhel-8.3-bpf    clang-19
x86_64                         rhel-8.3-kunit    clang-19
x86_64                           rhel-8.3-ltp    clang-19
x86_64                          rhel-8.3-rust    clang-19
xtensa                            allnoconfig    gcc-14.1.0
xtensa                generic_kc705_defconfig    clang-20
xtensa                randconfig-001-20241028    gcc-14.1.0
xtensa                randconfig-002-20241028    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

