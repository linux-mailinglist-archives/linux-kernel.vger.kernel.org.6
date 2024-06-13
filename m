Return-Path: <linux-kernel+bounces-214054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2D8907EBC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 00:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 526B61C21AD3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 22:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F035914D43B;
	Thu, 13 Jun 2024 22:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TVqxgExg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8892414B950
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 22:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718317099; cv=none; b=VbgAWWT/HWgb3tGSnxu0wNfbjeCHthOqBWcId35T1vo36b6zn+2rLBOdcqxfySUz8QbSfA5nUJavIued/xGt2C/843uH0WLa1SVCps8z6ZvXKhvEUZpcEYbs9FRSNKxgjClLFelYfBNtRbR2nvhp9daiHGJJvGvhB2XEPLMDjIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718317099; c=relaxed/simple;
	bh=OYLM1I6B5a3FtU4mP+iqEFmmpuLGKAs9iKkejAi2vkE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=pZv9fiEArFUf2GfJHU/o5y6WsxCLRee540EsszqDhRruTMV/XeImB0JuYK5paQ9WIw7yVR0qe47500IJhDQ6L02egLqIAsqw3jCSeQU2zoCcrrJGdFLPyi7oApTRJTUUorxvzA2tMmm2KeWpCNkGGVky/o+Y5KXjSrnwc2d3lxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TVqxgExg; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718317097; x=1749853097;
  h=date:from:to:cc:subject:message-id;
  bh=OYLM1I6B5a3FtU4mP+iqEFmmpuLGKAs9iKkejAi2vkE=;
  b=TVqxgExg8Dt5PyQbsmTRUKUfnGttcTzStSha6vvVvZoeAnS/VmXTbFsD
   YiDT5j83LNDrM/0lhyRw8kcxgWrghblsFroUdqZkRg1lYYPE6G9+mEck3
   Iho4kr5UstOmi7yr84G9twHsLIZlVAVIiazQj4F6sgvpa12ioRuu8Txs4
   bJzS/BSRVMMXUo7PRw70YQewBdT2TwCn6IpjOVBsqeoqilCdJ1Wz+Xgdq
   +2Vn8OSnGdtjku4Y6l5SjHq2XOUNS1PJmok4rOVM0XgmLH11n+R3C9luH
   ut86ghXZ4Wsp2SgepTjO/7A3w9ZiPkSD9NbovJBx83nnrEp8Z+cm1ZoMK
   A==;
X-CSE-ConnectionGUID: Klk3Mx5rRIm54ufCkg6TOg==
X-CSE-MsgGUID: 6fMxKNz2QDKL6SvTvplX7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="18966036"
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="18966036"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 15:18:17 -0700
X-CSE-ConnectionGUID: IU166pXbQ5aRRE/fwrj6DA==
X-CSE-MsgGUID: JjR7fWUQQEGyMymbw2S4xQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="45249318"
Received: from lkp-server01.sh.intel.com (HELO 9e3ee4e9e062) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 13 Jun 2024 15:18:16 -0700
Received: from kbuild by 9e3ee4e9e062 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sHslp-0000TE-39;
	Thu, 13 Jun 2024 22:18:13 +0000
Date: Fri, 14 Jun 2024 06:17:54 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/misc] BUILD SUCCESS
 efdf761a83cd390523223f58793755f5d60a4489
Message-ID: <202406140652.mcRnwx6L-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/misc
branch HEAD: efdf761a83cd390523223f58793755f5d60a4489  hwmon: (k10temp) Rename _data variable

elapsed time: 1549m

configs tested: 122
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                            allyesconfig   gcc-13.2.0
alpha                               defconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240613   gcc-13.2.0
arc                   randconfig-002-20240613   gcc-13.2.0
arm                               allnoconfig   clang-19
arm                                 defconfig   clang-14
arm                   randconfig-001-20240613   gcc-13.2.0
arm                   randconfig-002-20240613   clang-17
arm                   randconfig-003-20240613   clang-19
arm                   randconfig-004-20240613   clang-19
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240613   gcc-13.2.0
arm64                 randconfig-002-20240613   clang-19
arm64                 randconfig-003-20240613   clang-19
arm64                 randconfig-004-20240613   clang-19
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240613   gcc-13.2.0
csky                  randconfig-002-20240613   gcc-13.2.0
hexagon                          allmodconfig   clang-19
hexagon                           allnoconfig   clang-19
hexagon                          allyesconfig   clang-19
hexagon                             defconfig   clang-19
hexagon               randconfig-001-20240613   clang-19
hexagon               randconfig-002-20240613   clang-15
i386         buildonly-randconfig-001-20240613   gcc-9
i386         buildonly-randconfig-002-20240613   clang-18
i386         buildonly-randconfig-003-20240613   clang-18
i386         buildonly-randconfig-004-20240613   clang-18
i386         buildonly-randconfig-005-20240613   gcc-7
i386         buildonly-randconfig-006-20240613   clang-18
i386                  randconfig-001-20240613   gcc-7
i386                  randconfig-002-20240613   gcc-11
i386                  randconfig-003-20240613   gcc-13
i386                  randconfig-004-20240613   clang-18
i386                  randconfig-005-20240613   gcc-13
i386                  randconfig-006-20240613   gcc-13
i386                  randconfig-011-20240613   gcc-13
i386                  randconfig-012-20240613   clang-18
i386                  randconfig-013-20240613   clang-18
i386                  randconfig-014-20240613   gcc-12
i386                  randconfig-015-20240613   gcc-8
i386                  randconfig-016-20240613   gcc-13
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240613   gcc-13.2.0
loongarch             randconfig-002-20240613   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
m68k                                defconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240613   gcc-13.2.0
nios2                 randconfig-002-20240613   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                            defconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                              defconfig   gcc-13.2.0
parisc                randconfig-001-20240613   gcc-13.2.0
parisc                randconfig-002-20240613   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc               randconfig-001-20240613   clang-19
powerpc               randconfig-002-20240613   clang-19
powerpc               randconfig-003-20240613   clang-19
powerpc64             randconfig-001-20240613   clang-19
powerpc64             randconfig-002-20240613   clang-19
powerpc64             randconfig-003-20240613   gcc-13.2.0
riscv                             allnoconfig   gcc-13.2.0
riscv                               defconfig   clang-19
riscv                 randconfig-001-20240613   clang-19
riscv                 randconfig-002-20240613   clang-19
s390                              allnoconfig   clang-19
s390                                defconfig   clang-19
s390                  randconfig-001-20240613   gcc-13.2.0
s390                  randconfig-002-20240613   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                                  defconfig   gcc-13.2.0
sh                    randconfig-001-20240613   gcc-13.2.0
sh                    randconfig-002-20240613   gcc-13.2.0
sparc                             allnoconfig   gcc-13.2.0
sparc                               defconfig   gcc-13.2.0
sparc64                             defconfig   gcc-13.2.0
sparc64               randconfig-001-20240613   gcc-13.2.0
sparc64               randconfig-002-20240613   gcc-13.2.0
um                               allmodconfig   clang-19
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-13
um                                  defconfig   clang-19
um                             i386_defconfig   gcc-13
um                    randconfig-001-20240613   gcc-9
um                    randconfig-002-20240613   gcc-9
um                           x86_64_defconfig   clang-15
x86_64       buildonly-randconfig-001-20240614   clang-18
x86_64       buildonly-randconfig-002-20240614   gcc-8
x86_64       buildonly-randconfig-003-20240614   clang-18
x86_64       buildonly-randconfig-004-20240614   gcc-8
x86_64       buildonly-randconfig-005-20240614   gcc-10
x86_64       buildonly-randconfig-006-20240614   clang-18
x86_64                randconfig-001-20240614   clang-18
x86_64                randconfig-002-20240614   clang-18
x86_64                randconfig-003-20240614   clang-18
x86_64                randconfig-004-20240614   gcc-11
x86_64                randconfig-005-20240614   clang-18
x86_64                randconfig-006-20240614   clang-18
x86_64                randconfig-011-20240614   clang-18
x86_64                randconfig-012-20240614   clang-18
x86_64                randconfig-013-20240614   gcc-10
x86_64                randconfig-014-20240614   gcc-8
x86_64                randconfig-015-20240614   gcc-13
x86_64                randconfig-016-20240614   gcc-13
x86_64                randconfig-071-20240614   gcc-10
x86_64                randconfig-072-20240614   gcc-13
xtensa                            allnoconfig   gcc-13.2.0
xtensa                randconfig-001-20240613   gcc-13.2.0
xtensa                randconfig-002-20240613   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

