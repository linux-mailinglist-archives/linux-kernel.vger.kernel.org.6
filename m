Return-Path: <linux-kernel+bounces-267056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2969940BDE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 10:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 518C31F24466
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 08:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D928192B99;
	Tue, 30 Jul 2024 08:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MMwzzr53"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C23194087
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 08:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722328775; cv=none; b=dEetjl/8hwC1bzkzxdxqu9BWSUNwCc5+gHNCNPY1ZR9Mmw2z6rYapHB5Nx0N6FfDdSy8ED0Tc0JjFI3zBhGRDpd7S/PL7HGJghgHFRWhKu9xAyOodHSkyvFkkKKvpAi1kYyX86b4HO1ch5hcqHVBHG/qgvG/7XZgIYzZc6ekznM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722328775; c=relaxed/simple;
	bh=/M4NGVS6a55Sh92icBUo1vCWOXJWvem9GgDLAGLDhr0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=JwfpctYQee+wINbQPJdRD7u4Tlur5o4JtChjJcCC1O5GFkX1wlO6o2qpgeNdqFtIfr7XQ7T/+CnoYXBcSJN4pYw7n805pyHllyGBWbz2alqHnbSaB4vctIv/z+wi4U6vJJtTArNsStdpYWqQ5XEn6dY/N9ayn6L0fZaI7rWGQww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MMwzzr53; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722328773; x=1753864773;
  h=date:from:to:cc:subject:message-id;
  bh=/M4NGVS6a55Sh92icBUo1vCWOXJWvem9GgDLAGLDhr0=;
  b=MMwzzr530Tt302AZjLI85eTK1r4VbkkwnwXy82gecOdxgVHw1H7mE+gG
   6qQbQQ+8zm6C0KwM6cXpBWV8kGweMkLOVVvjyyFwniojqYMHGDCprrCyQ
   KeLSead/YUVMaO8uUP1R7b2CScVFaSFYgp4lrF7oFOpbmvR9jo2F5Q0MA
   8YQQClUaxfUhEmKHIrnZgHgqF84CES9fp44zTzpIDMQx6xDnetASzuL9F
   skFoNDbl1SGVEjuI012StP3r62wrt3P1lidEF2co/Ae30aMi4hHd7M3Pq
   Ii3ZG0l8vh7I4wefhkYkJZ/emIHKlqvoBXzmKDuHOg7QDep1FQ6PzfY7k
   w==;
X-CSE-ConnectionGUID: RyKCMJRUSR6bTMSr6EAGjQ==
X-CSE-MsgGUID: ckk+VF04QGGYwPu5Wc+u6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="31526112"
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="31526112"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 01:39:32 -0700
X-CSE-ConnectionGUID: TcatZoWDTkSYJV2yGGq68Q==
X-CSE-MsgGUID: AImhdle4QoyfvYOgE4uXpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="85217564"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 30 Jul 2024 01:39:31 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sYiOG-000sfo-1Q;
	Tue, 30 Jul 2024 08:39:28 +0000
Date: Tue, 30 Jul 2024 16:38:35 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:irq/urgent] BUILD SUCCESS
 f872d4af79fe8c71ae291ce8875b477e1669a6c7
Message-ID: <202407301632.3ErbyXij-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/urgent
branch HEAD: f872d4af79fe8c71ae291ce8875b477e1669a6c7  irqchip/meson-gpio: Convert meson_gpio_irq_controller::lock to 'raw_spinlock_t'

elapsed time: 1098m

configs tested: 250
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                        nsimosci_defconfig   gcc-13.2.0
arc                   randconfig-001-20240730   gcc-13.2.0
arc                   randconfig-002-20240730   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-20
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                              allyesconfig   gcc-14.1.0
arm                         bcm2835_defconfig   clang-20
arm                                 defconfig   gcc-13.2.0
arm                            hisi_defconfig   gcc-13.2.0
arm                        keystone_defconfig   clang-20
arm                        keystone_defconfig   gcc-13.2.0
arm                             pxa_defconfig   gcc-13.2.0
arm                   randconfig-001-20240730   gcc-13.2.0
arm                   randconfig-001-20240730   gcc-14.1.0
arm                   randconfig-002-20240730   gcc-13.2.0
arm                   randconfig-002-20240730   gcc-14.1.0
arm                   randconfig-003-20240730   gcc-13.2.0
arm                   randconfig-003-20240730   gcc-14.1.0
arm                   randconfig-004-20240730   gcc-13.2.0
arm                   randconfig-004-20240730   gcc-14.1.0
arm64                            allmodconfig   clang-20
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240730   gcc-13.2.0
arm64                 randconfig-001-20240730   gcc-14.1.0
arm64                 randconfig-002-20240730   clang-20
arm64                 randconfig-002-20240730   gcc-13.2.0
arm64                 randconfig-003-20240730   clang-20
arm64                 randconfig-003-20240730   gcc-13.2.0
arm64                 randconfig-004-20240730   gcc-13.2.0
arm64                 randconfig-004-20240730   gcc-14.1.0
csky                              allnoconfig   gcc-13.2.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240730   gcc-13.2.0
csky                  randconfig-001-20240730   gcc-14.1.0
csky                  randconfig-002-20240730   gcc-13.2.0
csky                  randconfig-002-20240730   gcc-14.1.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   clang-20
hexagon                          allyesconfig   clang-20
hexagon               randconfig-001-20240730   clang-20
hexagon               randconfig-002-20240730   clang-20
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-13
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-13
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240730   gcc-13
i386         buildonly-randconfig-002-20240730   gcc-13
i386         buildonly-randconfig-003-20240730   gcc-13
i386         buildonly-randconfig-004-20240730   gcc-13
i386         buildonly-randconfig-005-20240730   gcc-13
i386         buildonly-randconfig-006-20240730   gcc-13
i386                                defconfig   clang-18
i386                  randconfig-001-20240730   gcc-13
i386                  randconfig-002-20240730   gcc-13
i386                  randconfig-003-20240730   gcc-13
i386                  randconfig-004-20240730   gcc-13
i386                  randconfig-005-20240730   gcc-13
i386                  randconfig-006-20240730   gcc-13
i386                  randconfig-011-20240730   gcc-13
i386                  randconfig-012-20240730   gcc-13
i386                  randconfig-013-20240730   gcc-13
i386                  randconfig-014-20240730   gcc-13
i386                  randconfig-015-20240730   gcc-13
i386                  randconfig-016-20240730   gcc-13
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240730   gcc-13.2.0
loongarch             randconfig-001-20240730   gcc-14.1.0
loongarch             randconfig-002-20240730   gcc-13.2.0
loongarch             randconfig-002-20240730   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-14.1.0
mips                     cu1000-neo_defconfig   gcc-13.2.0
mips                           gcw0_defconfig   gcc-13.2.0
mips                            gpr_defconfig   gcc-13.2.0
mips                malta_qemu_32r6_defconfig   clang-20
mips                      maltaaprp_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240730   gcc-13.2.0
nios2                 randconfig-001-20240730   gcc-14.1.0
nios2                 randconfig-002-20240730   gcc-13.2.0
nios2                 randconfig-002-20240730   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                generic-64bit_defconfig   gcc-13.2.0
parisc                randconfig-001-20240730   gcc-13.2.0
parisc                randconfig-001-20240730   gcc-14.1.0
parisc                randconfig-002-20240730   gcc-13.2.0
parisc                randconfig-002-20240730   gcc-14.1.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-20
powerpc                          allyesconfig   gcc-14.1.0
powerpc                 canyonlands_defconfig   clang-20
powerpc                 canyonlands_defconfig   gcc-13.2.0
powerpc                       ebony_defconfig   clang-20
powerpc                     ep8248e_defconfig   clang-20
powerpc                      pmac32_defconfig   clang-20
powerpc               randconfig-002-20240730   clang-16
powerpc               randconfig-002-20240730   gcc-13.2.0
powerpc               randconfig-003-20240730   clang-20
powerpc               randconfig-003-20240730   gcc-13.2.0
powerpc                    sam440ep_defconfig   gcc-13.2.0
powerpc                     taishan_defconfig   clang-20
powerpc                     tqm8555_defconfig   clang-20
powerpc                      tqm8xx_defconfig   clang-20
powerpc64             randconfig-001-20240730   gcc-13.2.0
powerpc64             randconfig-001-20240730   gcc-14.1.0
powerpc64             randconfig-002-20240730   clang-20
powerpc64             randconfig-002-20240730   gcc-13.2.0
powerpc64             randconfig-003-20240730   gcc-13.2.0
powerpc64             randconfig-003-20240730   gcc-14.1.0
riscv                            allmodconfig   clang-20
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-20
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   clang-20
riscv                               defconfig   gcc-14.1.0
riscv                 randconfig-001-20240730   clang-14
riscv                 randconfig-001-20240730   gcc-13.2.0
riscv                 randconfig-002-20240730   gcc-13.2.0
riscv                 randconfig-002-20240730   gcc-14.1.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   clang-20
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240730   gcc-13.2.0
s390                  randconfig-001-20240730   gcc-14.1.0
s390                  randconfig-002-20240730   clang-20
s390                  randconfig-002-20240730   gcc-13.2.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                             espt_defconfig   gcc-13.2.0
sh                          polaris_defconfig   gcc-13.2.0
sh                          r7780mp_defconfig   gcc-13.2.0
sh                    randconfig-001-20240730   gcc-13.2.0
sh                    randconfig-001-20240730   gcc-14.1.0
sh                    randconfig-002-20240730   gcc-13.2.0
sh                    randconfig-002-20240730   gcc-14.1.0
sh                          rsk7269_defconfig   gcc-13.2.0
sh                           se7721_defconfig   gcc-13.2.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240730   gcc-13.2.0
sparc64               randconfig-001-20240730   gcc-14.1.0
sparc64               randconfig-002-20240730   gcc-13.2.0
sparc64               randconfig-002-20240730   gcc-14.1.0
um                               allmodconfig   clang-20
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-13
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   clang-20
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-13
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240730   gcc-13
um                    randconfig-001-20240730   gcc-13.2.0
um                    randconfig-002-20240730   clang-20
um                    randconfig-002-20240730   gcc-13.2.0
um                           x86_64_defconfig   clang-15
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240730   clang-18
x86_64       buildonly-randconfig-002-20240730   clang-18
x86_64       buildonly-randconfig-002-20240730   gcc-12
x86_64       buildonly-randconfig-003-20240730   clang-18
x86_64       buildonly-randconfig-004-20240730   clang-18
x86_64       buildonly-randconfig-004-20240730   gcc-13
x86_64       buildonly-randconfig-005-20240730   clang-18
x86_64       buildonly-randconfig-005-20240730   gcc-12
x86_64       buildonly-randconfig-006-20240730   clang-18
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240730   clang-18
x86_64                randconfig-002-20240730   clang-18
x86_64                randconfig-002-20240730   gcc-13
x86_64                randconfig-003-20240730   clang-18
x86_64                randconfig-004-20240730   clang-18
x86_64                randconfig-005-20240730   clang-18
x86_64                randconfig-006-20240730   clang-18
x86_64                randconfig-011-20240730   clang-18
x86_64                randconfig-011-20240730   gcc-13
x86_64                randconfig-012-20240730   clang-18
x86_64                randconfig-013-20240730   clang-18
x86_64                randconfig-014-20240730   clang-18
x86_64                randconfig-015-20240730   clang-18
x86_64                randconfig-015-20240730   gcc-8
x86_64                randconfig-016-20240730   clang-18
x86_64                randconfig-016-20240730   gcc-13
x86_64                randconfig-071-20240730   clang-18
x86_64                randconfig-071-20240730   gcc-8
x86_64                randconfig-072-20240730   clang-18
x86_64                randconfig-073-20240730   clang-18
x86_64                randconfig-073-20240730   gcc-12
x86_64                randconfig-074-20240730   clang-18
x86_64                randconfig-075-20240730   clang-18
x86_64                randconfig-076-20240730   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240730   gcc-13.2.0
xtensa                randconfig-002-20240730   gcc-13.2.0
xtensa                    smp_lx200_defconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

