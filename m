Return-Path: <linux-kernel+bounces-287567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D5095296A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 08:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D328A1C21F90
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 06:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A71317837D;
	Thu, 15 Aug 2024 06:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="flu433oX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93E617798F
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 06:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723703643; cv=none; b=AJZ7f5UapEzGW7Rn+2olKEcbveQB2sj80wpATdQ3V5jNkysXcdfHKgZPKhizsOmjojS8IuJAh5ioSEdf46eRuTIDCdBeOGPMYg0cW+NELKxrs0m+dnNbiGxxn2gf3lV/GDGyW0+nhvaLllneu+T7gsYkPFFGLGZnJxp65P8cc7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723703643; c=relaxed/simple;
	bh=JLkqBNJEsNahQG+sN8KvXXFb3JrM1ZKjGWilM5BLyXY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=mu7FMExNQ65h6zKRbyZvZIfUwNclS8iI8exf+9fjFg9V9u5TA628acwS2PD5ZDKA1jURvTjolG7wznqQoxNo5httvCj6bn0SpOVivyyb7/1hr+lTxugnvtT2fI8dLXpoirXBggx4cXXTZrfg0K5XR2yKl2YxHe3yGjFAd5ztxTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=flu433oX; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723703642; x=1755239642;
  h=date:from:to:cc:subject:message-id;
  bh=JLkqBNJEsNahQG+sN8KvXXFb3JrM1ZKjGWilM5BLyXY=;
  b=flu433oX4d/gwzbMhAtfoybMzNk7Sh3RN21x5xDLfiKUXYUBqNRaNgQu
   2ViKpOfIOXN0gt0YMHwMKZH8un1QTXw5UCcxtrI1i7pgx5YoZ9cjSNw4a
   odKxcSCIJFRUW9Qcp/Uhjk0SKv7hahByEbW2+/mpB7VATehCTbsjPpCrZ
   QsFCG23G9/5hi8APpaYz8BuOVfKEqcmLiDfIxDZrSTn2+MiVqMMuAVdH8
   xMM7UzRnbDGfRvqDZQLMZC8+QaS0a7w99d5/20eMD1n3Q5+qZWU0H2Fc4
   Zo8+Km8XfQVczBNhN5wXvVpbacX2MBrwsHWEBjy/dIW/ZR+qpzZ+QRqeS
   w==;
X-CSE-ConnectionGUID: NytcnXjZS1SPjRoAAKbIpA==
X-CSE-MsgGUID: EOfyJu4YRcKPFZXBzvL1JA==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="32526942"
X-IronPort-AV: E=Sophos;i="6.10,148,1719903600"; 
   d="scan'208";a="32526942"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 23:34:01 -0700
X-CSE-ConnectionGUID: Mi1uG9sNTWiNaUCpgWIN3A==
X-CSE-MsgGUID: NU7o8OewQOaX4YQ7GyfyBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,148,1719903600"; 
   d="scan'208";a="63691381"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 14 Aug 2024 23:33:59 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1seU3Z-0003H4-0U;
	Thu, 15 Aug 2024 06:33:57 +0000
Date: Thu, 15 Aug 2024 14:33:18 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:perf/core] BUILD SUCCESS
 fe826cc2654e8561b64246325e6a51b62bf2488c
Message-ID: <202408151415.b7q8LFc2-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core
branch HEAD: fe826cc2654e8561b64246325e6a51b62bf2488c  perf: Really fix event_function_call() locking

elapsed time: 1467m

configs tested: 156
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.3.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240814   gcc-13.2.0
arc                   randconfig-002-20240814   gcc-13.2.0
arm                              alldefconfig   gcc-14.1.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-20
arm                              allyesconfig   gcc-14.1.0
arm                        clps711x_defconfig   clang-20
arm                            dove_defconfig   gcc-14.1.0
arm                   randconfig-001-20240814   clang-20
arm                   randconfig-002-20240814   clang-20
arm                   randconfig-003-20240814   clang-20
arm                   randconfig-004-20240814   clang-20
arm64                            allmodconfig   clang-20
arm64                             allnoconfig   gcc-14.1.0
arm64                 randconfig-001-20240814   clang-20
arm64                 randconfig-002-20240814   gcc-14.1.0
arm64                 randconfig-003-20240814   gcc-14.1.0
arm64                 randconfig-004-20240814   clang-20
csky                              allnoconfig   gcc-14.1.0
csky                  randconfig-001-20240814   gcc-14.1.0
csky                  randconfig-002-20240814   gcc-14.1.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   clang-20
hexagon                          allyesconfig   clang-20
hexagon               randconfig-001-20240814   clang-16
hexagon               randconfig-002-20240814   clang-14
i386                             allmodconfig   gcc-12
i386                              allnoconfig   gcc-12
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240814   clang-18
i386         buildonly-randconfig-002-20240814   clang-18
i386         buildonly-randconfig-003-20240814   clang-18
i386         buildonly-randconfig-004-20240814   clang-18
i386         buildonly-randconfig-005-20240814   gcc-12
i386         buildonly-randconfig-006-20240814   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240814   clang-18
i386                  randconfig-002-20240814   gcc-12
i386                  randconfig-003-20240814   gcc-12
i386                  randconfig-004-20240814   clang-18
i386                  randconfig-005-20240814   clang-18
i386                  randconfig-006-20240814   clang-18
i386                  randconfig-011-20240814   gcc-12
i386                  randconfig-012-20240814   gcc-12
i386                  randconfig-013-20240814   clang-18
i386                  randconfig-014-20240814   gcc-11
i386                  randconfig-015-20240814   gcc-12
i386                  randconfig-016-20240814   gcc-12
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch             randconfig-001-20240814   gcc-14.1.0
loongarch             randconfig-002-20240814   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
mips                  cavium_octeon_defconfig   gcc-14.1.0
mips                           ci20_defconfig   clang-20
mips                  decstation_64_defconfig   gcc-13.2.0
mips                          malta_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-14.1.0
nios2                 randconfig-001-20240814   gcc-14.1.0
nios2                 randconfig-002-20240814   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240814   gcc-14.1.0
parisc                randconfig-002-20240814   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-20
powerpc                        cell_defconfig   gcc-14.1.0
powerpc               randconfig-002-20240814   clang-20
powerpc               randconfig-003-20240814   gcc-14.1.0
powerpc                     sequoia_defconfig   clang-20
powerpc                     tqm8548_defconfig   clang-20
powerpc64             randconfig-001-20240814   clang-20
powerpc64             randconfig-002-20240814   clang-15
powerpc64             randconfig-003-20240814   clang-20
riscv                            allmodconfig   clang-20
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-20
riscv                               defconfig   clang-20
riscv                 randconfig-001-20240814   gcc-14.1.0
riscv                 randconfig-002-20240814   clang-20
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   clang-20
s390                  randconfig-001-20240814   gcc-14.1.0
s390                  randconfig-002-20240814   gcc-14.1.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                 kfr2r09-romimage_defconfig   gcc-14.1.0
sh                          kfr2r09_defconfig   gcc-14.1.0
sh                    randconfig-001-20240814   gcc-14.1.0
sh                    randconfig-002-20240814   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240814   gcc-14.1.0
sparc64               randconfig-002-20240814   gcc-14.1.0
um                               allmodconfig   clang-20
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-12
um                                  defconfig   clang-20
um                             i386_defconfig   gcc-12
um                    randconfig-001-20240814   clang-20
um                    randconfig-002-20240814   clang-20
um                           x86_64_defconfig   clang-15
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240814   clang-18
x86_64       buildonly-randconfig-002-20240814   gcc-12
x86_64       buildonly-randconfig-003-20240814   clang-18
x86_64       buildonly-randconfig-004-20240814   clang-18
x86_64       buildonly-randconfig-005-20240814   gcc-12
x86_64       buildonly-randconfig-006-20240814   clang-18
x86_64                              defconfig   gcc-11
x86_64                randconfig-001-20240814   clang-18
x86_64                randconfig-002-20240814   gcc-12
x86_64                randconfig-003-20240814   gcc-11
x86_64                randconfig-004-20240814   gcc-12
x86_64                randconfig-005-20240814   gcc-12
x86_64                randconfig-006-20240814   gcc-12
x86_64                randconfig-011-20240814   clang-18
x86_64                randconfig-012-20240814   clang-18
x86_64                randconfig-013-20240814   gcc-11
x86_64                randconfig-014-20240814   clang-18
x86_64                randconfig-015-20240814   gcc-12
x86_64                randconfig-016-20240814   clang-18
x86_64                randconfig-071-20240814   clang-18
x86_64                randconfig-072-20240814   clang-18
x86_64                randconfig-073-20240814   clang-18
x86_64                randconfig-074-20240814   clang-18
x86_64                randconfig-075-20240814   gcc-12
x86_64                randconfig-076-20240814   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240814   gcc-14.1.0
xtensa                randconfig-002-20240814   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

