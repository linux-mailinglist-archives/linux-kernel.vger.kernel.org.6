Return-Path: <linux-kernel+bounces-425251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BBFAA9DBF65
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 07:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 333A0B20F31
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 06:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F406C15624D;
	Fri, 29 Nov 2024 06:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jszj6dp8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CCA184F
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 06:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732860557; cv=none; b=NlIxFMfuzlwONVqhaCx3pb7uyzOjHU5twcsddwVU8QG9NXaX/oRyk5Fxr+78x2R7sspa1LIt533XyUqazh+ox+IuISLwqiCyy22IfYALwCzN4HMXE+ZDe/4uxTA67fF5wVqWUp9Ne4dCsBvRtmYfrrVuPGT+48f6Scbn0/akRFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732860557; c=relaxed/simple;
	bh=Z+P+EDxlPncIAbRH6Og/vXCWSagiSxIY0cD/jjLfX8o=;
	h=Date:From:To:Cc:Subject:Message-ID; b=MCWUV3xeW1z1s+4tG1d5Fqxo8Hfgwt1KOhIrnW3uSSIMaYkVsfeg7uyrsf915u/dLNPplubR83mb5eFIowlD0ShMLyPlO5kDOo4IoU71RDFVo/HbF4ekhRC2H9LbfLSSB4FvUMQEO2N+CW92i+TkCUf5haq1d/w1r0pQ6uwrEYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jszj6dp8; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732860555; x=1764396555;
  h=date:from:to:cc:subject:message-id;
  bh=Z+P+EDxlPncIAbRH6Og/vXCWSagiSxIY0cD/jjLfX8o=;
  b=jszj6dp8DH2el1IalT3kp0G1KrkWpwNUDbh8qtV9O3kyM039HnkMwI96
   9m0IFtLdg2qfiRd/twaIfAmKcbeNd8QUaOzKtvcsfyLkx0koAu/TuE45U
   AlXJ9tPtic1/zEKJ8ulx50kW6Q0QjWk2q9hwdLa+hwgvNYzxFEIdgmbq4
   inxjvBusGJE/uNjSSPFc2FGydFhGQXInXdOg4c/AuYvGqKKH/gCpkQNEe
   H4sdVyjt9OLiesJ3KzxRa1m1rhy4iqT1LYbqValFThWLXo7615OnQ3hGZ
   Zs2/OPifujPRaFueSjeMXIeuLFQJXsBbo+ViR1WVKDNkfEJLv5+Mug8k4
   A==;
X-CSE-ConnectionGUID: 8pct3hrCR0KeWIyaTXHByQ==
X-CSE-MsgGUID: A7NecnxoRtGrwdSGA4ay9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11270"; a="32461035"
X-IronPort-AV: E=Sophos;i="6.12,194,1728975600"; 
   d="scan'208";a="32461035"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2024 22:09:14 -0800
X-CSE-ConnectionGUID: UE3sdUhTQE+FGWMOjXX0RQ==
X-CSE-MsgGUID: 2i/6G9IGTCKpbyzjGhx5eQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,194,1728975600"; 
   d="scan'208";a="93254817"
Received: from lkp-server01.sh.intel.com (HELO 5e2646291792) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 28 Nov 2024 22:09:13 -0800
Received: from kbuild by 5e2646291792 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tGuBi-00002v-27;
	Fri, 29 Nov 2024 06:09:10 +0000
Date: Fri, 29 Nov 2024 14:06:25 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:timers/urgent] BUILD SUCCESS
 f5807b0606da7ac7c1b74a386b22134ec7702d05
Message-ID: <202411291415.vo2CEDQI-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/urgent
branch HEAD: f5807b0606da7ac7c1b74a386b22134ec7702d05  ntp: Remove invalid cast in time offset math

elapsed time: 1070m

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
arc                            hsdk_defconfig    gcc-13.2.0
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
arm                         lpc18xx_defconfig    clang-20
arm                       omap2plus_defconfig    clang-20
arm                         orion5x_defconfig    clang-14
arm                          pxa3xx_defconfig    clang-20
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
loongarch                        alldefconfig    clang-14
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
microblaze                      mmu_defconfig    clang-14
mips                              allnoconfig    gcc-14.2.0
mips                         bigsur_defconfig    gcc-14.2.0
mips                          eyeq5_defconfig    clang-14
mips                           ip27_defconfig    clang-14
mips                      maltaaprp_defconfig    clang-14
mips                        qi_lb60_defconfig    clang-20
mips                   sb1250_swarm_defconfig    gcc-14.2.0
mips                           xway_defconfig    clang-14
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
powerpc                      tqm8xx_defconfig    clang-20
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
riscv             nommu_k210_sdcard_defconfig    clang-14
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
sh                           se7751_defconfig    clang-14
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
xtensa                       common_defconfig    clang-14
xtensa                randconfig-001-20241129    clang-20
xtensa                randconfig-001-20241129    gcc-14.2.0
xtensa                randconfig-002-20241129    clang-20
xtensa                randconfig-002-20241129    gcc-14.2.0
xtensa                         virt_defconfig    gcc-14.2.0
xtensa                    xip_kc705_defconfig    clang-14

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

