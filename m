Return-Path: <linux-kernel+bounces-246672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F3892C509
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 22:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F14781F2340D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 20:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B18185634;
	Tue,  9 Jul 2024 20:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FWYANoNE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C8D5FB8A
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 20:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720558565; cv=none; b=mzCMowojyBtRcD8OgcDFxOwJJRsglq1svsCgrcWO1E7xcii6UXBCGsD3OH4ijNNxesn81Ytzls2YyX3ww7dLlQaq28AOgWCa5GF91qHkYnkWgm5il469xZ4FNA2QNrLblwVAgm7vib0ZhbMoH//sgCJ6ELd5B9aBIO9PnqzVQkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720558565; c=relaxed/simple;
	bh=ejKAvx15Qr6/y/N6AE+ZHVdcfQUPMrAntD3GNyP0Dw8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=qlk3D97EyQ5nNv3oArAwIl5NeVR0ZowdvmgwNhm3hXWO+Mr2JlqvbAXGkKghKECNsWapLA4M651FL3pyTlRGIckNnEHhgC2Kx1MqxMk5CR1I6FEY5yuPatJLloQHmteNoDYYh676d306BYcDn3NMGPS5YkBj2bpGvvfdQeEjbHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FWYANoNE; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720558564; x=1752094564;
  h=date:from:to:cc:subject:message-id;
  bh=ejKAvx15Qr6/y/N6AE+ZHVdcfQUPMrAntD3GNyP0Dw8=;
  b=FWYANoNEygGCLBFfDYBLOix68doT7Etfb91bT4avBdkT1exVmWo4HkaK
   em0NETm8q93G4LmDbzKVX+RHaaitw4Q/H0RQnrJjZJzssJ2tLQGhaVrAQ
   WBG9RGoNjvPigTojLS26OgJUdqH8Mz2MIS/2Yeeq5iDeXhZRgKN/Ni9qj
   rhI8DgncsYNm9GEmdeXrmQz5S5CQYJio5SDnfpyLOvRSIDZ8L1OI1Y+YM
   bOJwHGk5DonX8sOhMTigZfTMNvF8bzYvhTJ8Ppl9CzAQ+AkmeNL+xrL8i
   lKst5apMya5ZJB4hsGuiI8QkEj7m3GyOgVo9pgbyIy1eW1s2On8sqWrBU
   Q==;
X-CSE-ConnectionGUID: 1l0Cn5tcQfe05MXnJ6Vn7w==
X-CSE-MsgGUID: tGfLcKqkTrWM9qQDE2zGHw==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="17989530"
X-IronPort-AV: E=Sophos;i="6.09,196,1716274800"; 
   d="scan'208";a="17989530"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2024 13:56:04 -0700
X-CSE-ConnectionGUID: 2UfKlkrVQuCabkjXxdkPVw==
X-CSE-MsgGUID: pMDhow4VQJ2nKr90Nn/cTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,196,1716274800"; 
   d="scan'208";a="47764412"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 09 Jul 2024 13:56:02 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sRHsW-000X5Q-0m;
	Tue, 09 Jul 2024 20:56:00 +0000
Date: Wed, 10 Jul 2024 04:55:54 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/WFAMNAE-next20240621-CbC] BUILD SUCCESS
 5625a19d70e0d4b59a776586e73f0dfd0c944e88
Message-ID: <202407100452.c6mf75Rk-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/WFAMNAE-next20240621-CbC
branch HEAD: 5625a19d70e0d4b59a776586e73f0dfd0c944e88  perf: Avoid -Wflex-array-member-not-at-end warnings

elapsed time: 1308m

configs tested: 156
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                            allyesconfig   gcc-13.2.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240709   gcc-13.2.0
arc                   randconfig-002-20240709   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                               allnoconfig   clang-19
arm                              allyesconfig   gcc-13.2.0
arm                      jornada720_defconfig   clang-19
arm                   randconfig-001-20240709   gcc-13.2.0
arm                   randconfig-002-20240709   clang-19
arm                   randconfig-003-20240709   clang-19
arm                   randconfig-004-20240709   gcc-13.2.0
arm                          sp7021_defconfig   gcc-13.2.0
arm64                            allmodconfig   clang-19
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240709   clang-19
arm64                 randconfig-002-20240709   clang-17
arm64                 randconfig-003-20240709   clang-19
arm64                 randconfig-004-20240709   clang-19
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240709   gcc-13.2.0
csky                  randconfig-002-20240709   gcc-13.2.0
hexagon                          allmodconfig   clang-19
hexagon                           allnoconfig   clang-19
hexagon                          allyesconfig   clang-19
hexagon                             defconfig   clang-19
hexagon               randconfig-001-20240709   clang-19
hexagon               randconfig-002-20240709   clang-19
i386                             allmodconfig   gcc-13
i386                              allnoconfig   gcc-13
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240709   gcc-11
i386         buildonly-randconfig-002-20240709   gcc-13
i386         buildonly-randconfig-003-20240709   clang-18
i386         buildonly-randconfig-004-20240709   clang-18
i386         buildonly-randconfig-005-20240709   clang-18
i386         buildonly-randconfig-006-20240709   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240709   gcc-13
i386                  randconfig-002-20240709   clang-18
i386                  randconfig-003-20240709   gcc-11
i386                  randconfig-004-20240709   gcc-13
i386                  randconfig-005-20240709   gcc-13
i386                  randconfig-006-20240709   gcc-13
i386                  randconfig-011-20240709   clang-18
i386                  randconfig-012-20240709   gcc-13
i386                  randconfig-013-20240709   gcc-12
i386                  randconfig-014-20240709   clang-18
i386                  randconfig-015-20240709   clang-18
i386                  randconfig-016-20240709   gcc-10
loongarch                        allmodconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch             randconfig-001-20240709   gcc-13.2.0
loongarch             randconfig-002-20240709   gcc-13.2.0
m68k                             allmodconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                           ci20_defconfig   clang-19
mips                  decstation_64_defconfig   gcc-13.2.0
mips                     loongson1c_defconfig   gcc-13.2.0
mips                        omega2p_defconfig   clang-19
mips                   sb1250_swarm_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                 randconfig-001-20240709   gcc-13.2.0
nios2                 randconfig-002-20240709   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                         allyesconfig   gcc-13.2.0
openrisc                            defconfig   gcc-13.2.0
openrisc                 simple_smp_defconfig   gcc-13.2.0
parisc                           allmodconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                           allyesconfig   gcc-13.2.0
parisc                              defconfig   gcc-13.2.0
parisc                randconfig-001-20240709   gcc-13.2.0
parisc                randconfig-002-20240709   gcc-13.2.0
powerpc                          allmodconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc                          allyesconfig   clang-19
powerpc                      arches_defconfig   gcc-13.2.0
powerpc                     asp8347_defconfig   clang-17
powerpc                   currituck_defconfig   clang-19
powerpc                 mpc8313_rdb_defconfig   gcc-13.2.0
powerpc                 mpc832x_rdb_defconfig   gcc-13.2.0
powerpc                     powernv_defconfig   gcc-13.2.0
powerpc               randconfig-001-20240709   clang-19
powerpc               randconfig-002-20240709   gcc-13.2.0
powerpc               randconfig-003-20240709   clang-15
powerpc                     tqm8548_defconfig   clang-19
powerpc64             randconfig-001-20240709   gcc-13.2.0
powerpc64             randconfig-002-20240709   gcc-13.2.0
powerpc64             randconfig-003-20240709   clang-19
riscv                            allmodconfig   clang-19
riscv                             allnoconfig   gcc-13.2.0
riscv                            allyesconfig   clang-19
riscv                 randconfig-001-20240709   clang-17
riscv                 randconfig-002-20240709   gcc-13.2.0
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                             allyesconfig   gcc-13.2.0
s390                  randconfig-001-20240709   gcc-13.2.0
s390                  randconfig-002-20240709   clang-19
sh                               allmodconfig   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                               allyesconfig   gcc-13.2.0
sh                    randconfig-001-20240709   gcc-13.2.0
sh                    randconfig-002-20240709   gcc-13.2.0
sparc                            allmodconfig   gcc-13.2.0
sparc64               randconfig-001-20240709   gcc-13.2.0
sparc64               randconfig-002-20240709   gcc-13.2.0
um                               allmodconfig   clang-19
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-13
um                    randconfig-001-20240709   gcc-13
um                    randconfig-002-20240709   gcc-11
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240709   gcc-11
x86_64       buildonly-randconfig-002-20240709   clang-18
x86_64       buildonly-randconfig-003-20240709   clang-18
x86_64       buildonly-randconfig-004-20240709   gcc-9
x86_64       buildonly-randconfig-005-20240709   gcc-13
x86_64       buildonly-randconfig-006-20240709   clang-18
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240709   clang-18
x86_64                randconfig-002-20240709   gcc-10
x86_64                randconfig-003-20240709   clang-18
x86_64                randconfig-004-20240709   gcc-12
x86_64                randconfig-005-20240709   gcc-13
x86_64                randconfig-006-20240709   gcc-8
x86_64                randconfig-011-20240709   clang-18
x86_64                randconfig-012-20240709   clang-18
x86_64                randconfig-013-20240709   clang-18
x86_64                randconfig-014-20240709   clang-18
x86_64                randconfig-015-20240709   clang-18
x86_64                randconfig-016-20240709   clang-18
x86_64                randconfig-071-20240709   gcc-7
x86_64                randconfig-072-20240709   clang-18
x86_64                randconfig-073-20240709   gcc-13
x86_64                randconfig-074-20240709   gcc-13
x86_64                randconfig-075-20240709   gcc-11
x86_64                randconfig-076-20240709   gcc-13
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                randconfig-001-20240709   gcc-13.2.0
xtensa                randconfig-002-20240709   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

