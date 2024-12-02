Return-Path: <linux-kernel+bounces-428511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB5B9E0F76
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 01:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 076FC16234E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 00:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85B13C38;
	Tue,  3 Dec 2024 00:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aJV8pMcs"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3640E64D
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 00:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733184163; cv=none; b=QUpnJm32vql2FqW5XnBoBNdWUns2HYwIt5FnYukIRVdgy2Q5deHW8ALsIIn3UDitkLQHH1mxXu+us6peFaURMKm9qoEOAnMIFkO7aVygKcYgTQUgj1sroekchTjwAnFcnAxcFH46tGfmaA9Mntz4rVN/3OgllE02Nh4LvBZ0198=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733184163; c=relaxed/simple;
	bh=w/x1E9oQ6GCE3uTHHevh3mD7Lib5Fwz/Ufh+6OHsd1w=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Q28MIDcNRzyVbVxq2/Wffn7WP75XKmkLe3uGMTUmH1rtq23ePGEBJ3nhFr1ljdcPXs6F2GwlFub7RqN00pyuYkAs7cbwF53WYFwS1njbFaVwh2ce6gWGpEnmhR894jA/aDK1V/dBRRvZhJP+YqmziMku09IjXH+SLIhsPa4N1KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aJV8pMcs; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733184162; x=1764720162;
  h=date:from:to:cc:subject:message-id;
  bh=w/x1E9oQ6GCE3uTHHevh3mD7Lib5Fwz/Ufh+6OHsd1w=;
  b=aJV8pMcs7vmytfgpCHysWH0IeylAi4VyCs45ME67GuBkFtt1q2KCAb5a
   guFKFDIjqWwnOJSqtC0mIPsRZZWKvxZXfG5kLcEqqJKV7kbKGV/k+qg58
   g1uk3H6v+v0XuN/GDj4yjW1zykGg1a4ArlmypkL0ET+Nf6w0V87NOVY9i
   MAL+9jFrkjfwuMb3MLycuzW8M52+flnRKiHadpeE4NJFn4/jSerCtZxTn
   +73/5xOPyzLsdi8Ud1k35KkHCkGspinXe65GdKMKvEYJduKFXqwyWg3kq
   kGnOus0DIWdrO3kMJwc2cauh/U8bI4O4XZTO0RjVD6LdkWHwgvqATmAwq
   g==;
X-CSE-ConnectionGUID: M+8vUY9ZTa2Vl2AO189PIg==
X-CSE-MsgGUID: GtKXqJmuRsu0DBUafc1wag==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="44411927"
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="44411927"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 16:02:41 -0800
X-CSE-ConnectionGUID: pXm+jHpTTpujKtYTnS+LSg==
X-CSE-MsgGUID: GX/3sSO/QHawtPaEHjCTsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="92918141"
Received: from lkp-server02.sh.intel.com (HELO 36a1563c48ff) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 02 Dec 2024 16:02:40 -0800
Received: from kbuild by 36a1563c48ff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tIGNC-00033K-10;
	Tue, 03 Dec 2024 00:02:38 +0000
Date: Tue, 03 Dec 2024 07:59:48 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:sched/urgent] BUILD SUCCESS
 82f9cc094975240885c93effbca7f4603f5de1bf
Message-ID: <202412030738.K6PwCQHm-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/urgent
branch HEAD: 82f9cc094975240885c93effbca7f4603f5de1bf  locking: rtmutex: Fix wake_q logic in task_blocks_on_rt_mutex

elapsed time: 737m

configs tested: 180
configs skipped: 16

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
arc                   randconfig-001-20241202    gcc-13.2.0
arc                   randconfig-001-20241202    gcc-14.2.0
arc                   randconfig-001-20241203    clang-20
arc                   randconfig-002-20241202    gcc-13.2.0
arc                   randconfig-002-20241202    gcc-14.2.0
arc                   randconfig-002-20241203    clang-20
arc                        vdk_hs38_defconfig    clang-14
arm                              allmodconfig    clang-20
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-20
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-20
arm                              allyesconfig    gcc-14.2.0
arm                         at91_dt_defconfig    gcc-14.2.0
arm                        keystone_defconfig    clang-20
arm                            mps2_defconfig    clang-20
arm                         mv78xx0_defconfig    gcc-14.2.0
arm                          pxa168_defconfig    clang-20
arm                          pxa3xx_defconfig    clang-20
arm                   randconfig-001-20241202    gcc-14.2.0
arm                   randconfig-001-20241203    clang-20
arm                   randconfig-002-20241202    clang-20
arm                   randconfig-002-20241202    gcc-14.2.0
arm                   randconfig-002-20241203    clang-20
arm                   randconfig-003-20241202    gcc-14.2.0
arm                   randconfig-003-20241203    clang-20
arm                   randconfig-004-20241202    clang-20
arm                   randconfig-004-20241202    gcc-14.2.0
arm                   randconfig-004-20241203    clang-20
arm                         s5pv210_defconfig    clang-14
arm                         socfpga_defconfig    clang-20
arm                        spear6xx_defconfig    clang-14
arm                        spear6xx_defconfig    clang-20
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20241202    gcc-14.2.0
arm64                 randconfig-001-20241203    clang-20
arm64                 randconfig-002-20241202    gcc-14.2.0
arm64                 randconfig-002-20241203    clang-20
arm64                 randconfig-003-20241202    gcc-14.2.0
arm64                 randconfig-003-20241203    clang-20
arm64                 randconfig-004-20241202    clang-14
arm64                 randconfig-004-20241202    gcc-14.2.0
arm64                 randconfig-004-20241203    clang-20
csky                             alldefconfig    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-20
i386        buildonly-randconfig-001-20241202    clang-19
i386        buildonly-randconfig-001-20241202    gcc-12
i386        buildonly-randconfig-001-20241203    clang-19
i386        buildonly-randconfig-002-20241202    clang-19
i386        buildonly-randconfig-002-20241202    gcc-12
i386        buildonly-randconfig-002-20241203    clang-19
i386        buildonly-randconfig-003-20241202    clang-19
i386        buildonly-randconfig-003-20241202    gcc-12
i386        buildonly-randconfig-003-20241203    clang-19
i386        buildonly-randconfig-004-20241202    clang-19
i386        buildonly-randconfig-004-20241203    clang-19
i386        buildonly-randconfig-005-20241202    clang-19
i386        buildonly-randconfig-005-20241203    clang-19
i386        buildonly-randconfig-006-20241202    clang-19
i386        buildonly-randconfig-006-20241203    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                 loongson3_defconfig    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                          amiga_defconfig    gcc-14.2.0
m68k                          hp300_defconfig    gcc-14.2.0
m68k                       m5275evb_defconfig    gcc-14.2.0
m68k                        m5307c3_defconfig    gcc-14.2.0
m68k                        mvme16x_defconfig    gcc-14.2.0
m68k                          sun3x_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                      mmu_defconfig    clang-14
mips                              allnoconfig    gcc-14.2.0
mips                  cavium_octeon_defconfig    gcc-14.2.0
mips                           ip28_defconfig    gcc-14.2.0
mips                        qi_lb60_defconfig    gcc-14.2.0
mips                   sb1250_swarm_defconfig    gcc-14.2.0
nios2                         10m50_defconfig    clang-14
nios2                         3c120_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
openrisc                         alldefconfig    clang-20
openrisc                         alldefconfig    gcc-14.2.0
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-20
powerpc                          allyesconfig    gcc-14.2.0
powerpc                    amigaone_defconfig    clang-14
powerpc                      arches_defconfig    gcc-14.2.0
powerpc                   currituck_defconfig    clang-20
powerpc                       eiger_defconfig    gcc-14.2.0
powerpc                    ge_imp3a_defconfig    gcc-14.2.0
powerpc                  iss476-smp_defconfig    gcc-14.2.0
powerpc                      katmai_defconfig    clang-20
powerpc                   motionpro_defconfig    gcc-14.2.0
powerpc                 mpc8315_rdb_defconfig    gcc-14.2.0
powerpc               mpc834x_itxgp_defconfig    clang-14
powerpc                    mvme5100_defconfig    clang-14
powerpc                      pasemi_defconfig    clang-20
powerpc                      ppc6xx_defconfig    clang-14
powerpc                     tqm8541_defconfig    gcc-14.2.0
riscv                            allmodconfig    clang-20
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                            allyesconfig    gcc-14.2.0
riscv             nommu_k210_sdcard_defconfig    gcc-14.2.0
s390                             allmodconfig    clang-20
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                        edosk7705_defconfig    gcc-14.2.0
sh                        edosk7760_defconfig    gcc-14.2.0
sh                             espt_defconfig    gcc-14.2.0
sh                               j2_defconfig    gcc-14.2.0
sh                          kfr2r09_defconfig    gcc-14.2.0
sh                            migor_defconfig    clang-20
sh                            migor_defconfig    gcc-14.2.0
sh                           se7619_defconfig    clang-20
sh                           se7619_defconfig    gcc-14.2.0
sh                           se7705_defconfig    clang-20
sh                           se7722_defconfig    gcc-14.2.0
sh                           se7780_defconfig    clang-14
sh                        sh7785lcr_defconfig    gcc-14.2.0
sh                              ul2_defconfig    clang-14
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                               allyesconfig    gcc-12
x86_64      buildonly-randconfig-001-20241202    clang-19
x86_64      buildonly-randconfig-001-20241203    gcc-11
x86_64      buildonly-randconfig-002-20241202    clang-19
x86_64      buildonly-randconfig-002-20241202    gcc-12
x86_64      buildonly-randconfig-002-20241203    gcc-11
x86_64      buildonly-randconfig-003-20241202    clang-19
x86_64      buildonly-randconfig-003-20241202    gcc-12
x86_64      buildonly-randconfig-003-20241203    gcc-11
x86_64      buildonly-randconfig-004-20241202    clang-19
x86_64      buildonly-randconfig-004-20241203    gcc-11
x86_64      buildonly-randconfig-005-20241202    clang-19
x86_64      buildonly-randconfig-005-20241202    gcc-12
x86_64      buildonly-randconfig-005-20241203    gcc-11
x86_64      buildonly-randconfig-006-20241202    clang-19
x86_64      buildonly-randconfig-006-20241202    gcc-12
x86_64      buildonly-randconfig-006-20241203    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                       common_defconfig    clang-20
xtensa                    smp_lx200_defconfig    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

