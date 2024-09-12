Return-Path: <linux-kernel+bounces-326400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 550219767E0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 13:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF775B2441F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 11:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B02D1A724C;
	Thu, 12 Sep 2024 11:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VXNMDNQd"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC33A18BBBD
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 11:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726140354; cv=none; b=dAl3EMRNPbbvzimgD6VrmKP28vuVmTZqlmEInECnvz0IG6MS3NpTgPx6f4tETln97VB9jqB4J9k6NoBvrgZ5t7xGu7XR2JavPkvx2nw6NG5Q/Wq/hTfXFu0+fjIhlvNkSPHYKBQycuqkKTQpUGZpIxznwgA5I3Uprr4TZ2fBHT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726140354; c=relaxed/simple;
	bh=JGUUlAUn6xM6hXILRJ3+gNWfrWWOtBTX3P3+v635nOU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=fM5GOIqBl6obHKXkJyIbrFFsSXEDNi0btS4NHylOqtF1jddK+TclKiFlpQTANYzELzNHv9djVTHlB4jUln4jJZh7RNMAEkeach/Ioxv5uldaXWBYa+NxVrcFPK3vk4g9WD8cn7UtLBFo8Kv3XK/bE/BJhvbvUNPdSzUm8QCqkv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VXNMDNQd; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726140353; x=1757676353;
  h=date:from:to:cc:subject:message-id;
  bh=JGUUlAUn6xM6hXILRJ3+gNWfrWWOtBTX3P3+v635nOU=;
  b=VXNMDNQdgUm2yjaR4cDIbpwhFY/aeH6vk1vdMlxf7eqX2y3moReNKefY
   skWArQQ969Nj0mHyBx+l386nZFTvl2R1WYdQ+9JfLDT4LV/9A/RBAy/+9
   X1bEdZrdz+6uXCg0cPGh6eXVFlITTau8sZUv7H+ZM8yEgdwforxgw76HT
   OJGYxvw7DFze7+N1Mp7bhRJp4H9ltCqMwZB15fZHT+bgpOY5W+JcUesIY
   noqLzeX5sX/DqhvOulrBlvq4PRtoZbPea3AbkeeiFHfU3DwbFGfQGdvXs
   tQpc5X244cYSupmHOtg238EtgTHGK1pOQ00p+/Mq/vw8QKvM+cyZIzDCF
   Q==;
X-CSE-ConnectionGUID: dVtZ/6mvQaOmOCWPa70uPQ==
X-CSE-MsgGUID: jca/7oJgRaGUksVWf//Z8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="35575729"
X-IronPort-AV: E=Sophos;i="6.10,222,1719903600"; 
   d="scan'208";a="35575729"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 04:25:52 -0700
X-CSE-ConnectionGUID: RRJVSbYWQu+VaHEVTtXl1Q==
X-CSE-MsgGUID: AMYlU9GNRyurmoqCz2AmrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,222,1719903600"; 
   d="scan'208";a="67393413"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 12 Sep 2024 04:25:51 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sohxN-00051o-10;
	Thu, 12 Sep 2024 11:25:49 +0000
Date: Thu, 12 Sep 2024 19:25:46 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:locking/core] BUILD SUCCESS
 d00b83d416e73bc3fa4d21b14bec920e88b70ce6
Message-ID: <202409121944.4efRtBQn-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
branch HEAD: d00b83d416e73bc3fa4d21b14bec920e88b70ce6  locking/rwsem: Move is_rwsem_reader_owned() and rwsem_owner() under CONFIG_DEBUG_RWSEMS

elapsed time: 1481m

configs tested: 171
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-14.1.0
alpha                            allyesconfig   clang-20
alpha                            allyesconfig   gcc-13.3.0
arc                              allmodconfig   clang-20
arc                               allnoconfig   gcc-14.1.0
arc                              allyesconfig   clang-20
arc                   randconfig-001-20240912   gcc-13.2.0
arc                   randconfig-002-20240912   gcc-13.2.0
arm                              allmodconfig   clang-20
arm                               allnoconfig   gcc-14.1.0
arm                              allyesconfig   clang-20
arm                       aspeed_g5_defconfig   gcc-14.1.0
arm                       imx_v4_v5_defconfig   gcc-14.1.0
arm                          moxart_defconfig   gcc-14.1.0
arm                          pxa910_defconfig   gcc-14.1.0
arm                   randconfig-001-20240912   gcc-13.2.0
arm                   randconfig-002-20240912   gcc-13.2.0
arm                   randconfig-003-20240912   gcc-13.2.0
arm                   randconfig-004-20240912   gcc-13.2.0
arm                           spitz_defconfig   gcc-14.1.0
arm64                            allmodconfig   clang-20
arm64                             allnoconfig   gcc-14.1.0
arm64                 randconfig-001-20240912   gcc-13.2.0
arm64                 randconfig-002-20240912   gcc-13.2.0
arm64                 randconfig-003-20240912   gcc-13.2.0
arm64                 randconfig-004-20240912   gcc-13.2.0
csky                              allnoconfig   gcc-14.1.0
csky                  randconfig-001-20240912   gcc-13.2.0
csky                  randconfig-002-20240912   gcc-13.2.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   gcc-14.1.0
hexagon                          allyesconfig   clang-20
hexagon               randconfig-001-20240912   gcc-13.2.0
hexagon               randconfig-002-20240912   gcc-13.2.0
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-12
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-12
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240912   gcc-12
i386         buildonly-randconfig-002-20240912   gcc-11
i386         buildonly-randconfig-003-20240912   gcc-12
i386         buildonly-randconfig-004-20240912   clang-18
i386         buildonly-randconfig-005-20240912   gcc-12
i386         buildonly-randconfig-006-20240912   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240912   gcc-12
i386                  randconfig-002-20240912   gcc-12
i386                  randconfig-003-20240912   gcc-11
i386                  randconfig-004-20240912   gcc-12
i386                  randconfig-006-20240912   clang-18
i386                  randconfig-011-20240912   clang-18
i386                  randconfig-012-20240912   gcc-12
i386                  randconfig-013-20240912   gcc-12
i386                  randconfig-014-20240912   gcc-12
i386                  randconfig-015-20240912   clang-18
i386                  randconfig-016-20240912   clang-18
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch             randconfig-001-20240912   gcc-13.2.0
loongarch             randconfig-002-20240912   gcc-13.2.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                          hp300_defconfig   gcc-14.1.0
m68k                           sun3_defconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
mips                       lemote2f_defconfig   gcc-14.1.0
nios2                            alldefconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-14.1.0
nios2                 randconfig-001-20240912   gcc-13.2.0
nios2                 randconfig-002-20240912   gcc-13.2.0
openrisc                          allnoconfig   clang-20
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-12
openrisc                 simple_smp_defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   clang-20
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-12
parisc                randconfig-001-20240912   gcc-13.2.0
parisc                randconfig-002-20240912   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   clang-20
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   gcc-14.1.0
powerpc                       eiger_defconfig   gcc-14.1.0
powerpc                 mpc832x_rdb_defconfig   gcc-14.1.0
powerpc               mpc834x_itxgp_defconfig   gcc-14.1.0
powerpc                         ps3_defconfig   gcc-14.1.0
powerpc               randconfig-001-20240912   gcc-13.2.0
powerpc               randconfig-002-20240912   gcc-13.2.0
powerpc               randconfig-003-20240912   gcc-13.2.0
powerpc                        warp_defconfig   gcc-14.1.0
powerpc64             randconfig-001-20240912   gcc-13.2.0
powerpc64             randconfig-002-20240912   gcc-13.2.0
powerpc64             randconfig-003-20240912   gcc-13.2.0
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   clang-20
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-12
riscv                 randconfig-001-20240912   gcc-13.2.0
riscv                 randconfig-002-20240912   gcc-13.2.0
s390                             allmodconfig   gcc-14.1.0
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-12
s390                  randconfig-001-20240912   gcc-13.2.0
s390                  randconfig-002-20240912   gcc-13.2.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-12
sh                    randconfig-001-20240912   gcc-13.2.0
sh                    randconfig-002-20240912   gcc-13.2.0
sh                           se7619_defconfig   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-12
sparc64               randconfig-001-20240912   gcc-13.2.0
sparc64               randconfig-002-20240912   gcc-13.2.0
um                               allmodconfig   clang-20
um                                allnoconfig   clang-17
um                                allnoconfig   clang-20
um                               allyesconfig   clang-20
um                               allyesconfig   gcc-12
um                                  defconfig   gcc-12
um                             i386_defconfig   gcc-12
um                    randconfig-001-20240912   gcc-13.2.0
um                    randconfig-002-20240912   gcc-13.2.0
um                           x86_64_defconfig   gcc-12
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240912   clang-18
x86_64       buildonly-randconfig-002-20240912   clang-18
x86_64       buildonly-randconfig-003-20240912   clang-18
x86_64       buildonly-randconfig-004-20240912   clang-18
x86_64       buildonly-randconfig-005-20240912   clang-18
x86_64       buildonly-randconfig-006-20240912   clang-18
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-11
x86_64                                  kexec   gcc-12
x86_64                randconfig-001-20240912   clang-18
x86_64                randconfig-002-20240912   clang-18
x86_64                randconfig-003-20240912   clang-18
x86_64                randconfig-004-20240912   clang-18
x86_64                randconfig-005-20240912   clang-18
x86_64                randconfig-006-20240912   clang-18
x86_64                randconfig-011-20240912   clang-18
x86_64                randconfig-012-20240912   clang-18
x86_64                randconfig-013-20240912   clang-18
x86_64                randconfig-014-20240912   clang-18
x86_64                randconfig-015-20240912   clang-18
x86_64                randconfig-016-20240912   clang-18
x86_64                randconfig-071-20240912   clang-18
x86_64                randconfig-072-20240912   clang-18
x86_64                randconfig-073-20240912   clang-18
x86_64                randconfig-074-20240912   clang-18
x86_64                randconfig-075-20240912   clang-18
x86_64                randconfig-076-20240912   clang-18
x86_64                          rhel-8.3-rust   clang-18
x86_64                               rhel-8.3   gcc-12
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240912   gcc-13.2.0
xtensa                randconfig-002-20240912   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

