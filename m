Return-Path: <linux-kernel+bounces-272328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CAEB945A51
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 10:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A02171C22004
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 08:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF651C37B9;
	Fri,  2 Aug 2024 08:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="inw2uBaI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A890C1C379A
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 08:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722588953; cv=none; b=EBMW+NBzm9rxI8fkB+ECBFdBs/jDNniz/pmrpgvOr8sRJDb7f/ahJ64F11p2fR18K4RSRAoRB/d9Cx7924HlF0K3xur/ziGoxCsnaXWkxe0h9wxQGBNJVkpfx9i2S8X5D0pV63x1Dq7hpDG8clBc0RF82/hvYp3lm6rkOM4Kick=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722588953; c=relaxed/simple;
	bh=JY6opLOtZ2EUGt2GMuOPaaURV/OnyFOQsJ5w1Ow05SE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=nuRqjEOiZMwIYIvbghKEBeKofT9T9V1q9mXRxv5b+eQcufp1ZS8gAlQ7nuehwl+cuWxT4mDh/5iI2GQMoTXqREyPIUBjxYKv6mLA2yaVdMU8AHcMWmREYDOb40iCLb4yvAzVFeeJ/mQoK/wBa396C1L49JZPxNp8cipi7Tvv4Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=inw2uBaI; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722588951; x=1754124951;
  h=date:from:to:cc:subject:message-id;
  bh=JY6opLOtZ2EUGt2GMuOPaaURV/OnyFOQsJ5w1Ow05SE=;
  b=inw2uBaIKfL7k3g7E9A3hs3YJqthuqyBQ6ndBLhzoti51VFRXgs9otnW
   ljqKD3Jc28ECilmHcg9ZvqDSxY0LmbcxoG/C4GYDnFfHsX/SsCbxF0XXm
   FEix7qpV8QJokwU9RdcD9yyiv5ziY19n8krSYpybaBAa0scKDhy63+0zG
   TrS0J8pxwkRidekKvHcFEuXlTerlEC7FupD0p/Gg1Vbs7g5CWIofbaLMC
   o2EIVvpOrdU/jPYXPMkfP3DMto7NQO12L4XWDh0dGhwkrMSfBi/xgh9/7
   AJIUQvIwJevMkDc0j/ThTdwNQYOOXhtIoe2GR65yOqI2nxpqTDKa15ROO
   g==;
X-CSE-ConnectionGUID: 37qnbqY3Rqi1k9lGzUObaw==
X-CSE-MsgGUID: 2CvX8OoWTCOtLLhYIScNdQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11151"; a="31969638"
X-IronPort-AV: E=Sophos;i="6.09,257,1716274800"; 
   d="scan'208";a="31969638"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2024 01:55:51 -0700
X-CSE-ConnectionGUID: mO+8DFuLQzm23Tg3GaxS9w==
X-CSE-MsgGUID: 4Vx62u8kQ2itb+E21y3Nbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,257,1716274800"; 
   d="scan'208";a="54979236"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 02 Aug 2024 01:55:50 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sZo4h-000wZ8-2n;
	Fri, 02 Aug 2024 08:55:47 +0000
Date: Fri, 02 Aug 2024 16:55:24 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:ras/core] BUILD SUCCESS
 793aa4bf192d0ad07cca001a596f955d121f5c10
Message-ID: <202408021620.8iiY1LL6-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras/core
branch HEAD: 793aa4bf192d0ad07cca001a596f955d121f5c10  x86/mce: Use mce_prep_record() helpers for apei_smca_report_x86_error()

elapsed time: 939m

configs tested: 116
configs skipped: 130

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                          axs101_defconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                        vdk_hs38_defconfig   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                     davinci_all_defconfig   clang-20
arm                                 defconfig   gcc-13.2.0
arm                      integrator_defconfig   gcc-13.2.0
arm                          ixp4xx_defconfig   clang-20
arm                         s3c6400_defconfig   gcc-13.2.0
arm                           sunxi_defconfig   gcc-13.2.0
arm                    vt8500_v6_v7_defconfig   clang-20
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
i386                             allmodconfig   clang-18
i386                              allnoconfig   clang-18
i386                             allyesconfig   clang-18
i386                                defconfig   clang-18
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
m68k                           virt_defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                malta_qemu_32r6_defconfig   gcc-13.2.0
mips                      maltasmvp_defconfig   gcc-13.2.0
mips                  maltasmvp_eva_defconfig   clang-20
mips                          rb532_defconfig   clang-20
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   gcc-14.1.0
powerpc                   bluestone_defconfig   clang-20
powerpc                  iss476-smp_defconfig   clang-20
powerpc                 linkstation_defconfig   clang-20
powerpc                   lite5200b_defconfig   clang-20
powerpc                       maple_defconfig   gcc-13.2.0
powerpc                   microwatt_defconfig   clang-20
powerpc                    mvme5100_defconfig   clang-20
powerpc                     rainier_defconfig   gcc-13.2.0
powerpc                     sequoia_defconfig   gcc-13.2.0
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-14.1.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-20
s390                                defconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                                  defconfig   gcc-14.1.0
sh                        edosk7760_defconfig   gcc-13.2.0
sh                          rsk7269_defconfig   gcc-13.2.0
sh                             sh03_defconfig   gcc-13.2.0
sh                            titan_defconfig   gcc-13.2.0
sparc64                             defconfig   gcc-14.1.0
um                                allnoconfig   gcc-14.1.0
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-14.1.0
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240802   gcc-8
x86_64       buildonly-randconfig-002-20240802   gcc-8
x86_64       buildonly-randconfig-003-20240802   gcc-8
x86_64       buildonly-randconfig-004-20240802   gcc-8
x86_64       buildonly-randconfig-005-20240802   gcc-8
x86_64       buildonly-randconfig-006-20240802   gcc-8
x86_64                              defconfig   clang-18
x86_64                randconfig-001-20240802   gcc-8
x86_64                randconfig-002-20240802   gcc-8
x86_64                randconfig-003-20240802   gcc-8
x86_64                randconfig-004-20240802   gcc-8
x86_64                randconfig-005-20240802   gcc-8
x86_64                randconfig-006-20240802   gcc-8
x86_64                randconfig-011-20240802   gcc-8
x86_64                randconfig-012-20240802   gcc-8
x86_64                randconfig-013-20240802   gcc-8
x86_64                randconfig-014-20240802   gcc-8
x86_64                randconfig-015-20240802   gcc-8
x86_64                randconfig-016-20240802   gcc-8
x86_64                randconfig-071-20240802   gcc-8
x86_64                randconfig-072-20240802   gcc-8
x86_64                randconfig-073-20240802   gcc-8
x86_64                randconfig-074-20240802   gcc-8
x86_64                randconfig-075-20240802   gcc-8
x86_64                randconfig-076-20240802   gcc-8
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                  audio_kc705_defconfig   gcc-13.2.0
xtensa                       common_defconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

