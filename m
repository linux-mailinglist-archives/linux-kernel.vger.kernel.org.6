Return-Path: <linux-kernel+bounces-310045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE17967411
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 02:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA0BE1C2106F
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 00:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A837E1E498;
	Sun,  1 Sep 2024 00:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aXYhU5GA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B36EA50
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 00:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725151527; cv=none; b=jeflR8zlPG889lUauwMDGkTC2ETM8rNnIGJm+vdWK8Rif4PZ71A0VUn43Unpn3pENYdmWxHWI4i03Uj8AIrcv1CKwmMBJTDf8w+7/6cOigpV91CIzNEdH2ZHqO/pdGDEMzHWl5E9s4yXifYQgErf97KkWTtBmL13mhQ0XGyZjXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725151527; c=relaxed/simple;
	bh=LaOS30z4FOc+pdvJl63gzHl9575sEDllJSJ/0QBPsBE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=VkSpGUDvLRpp9Zd863bCIceufwLCb6BTFl7qSuosE7aBIvNZW3uExPg1WEYA3mEVtfmBycO0MiwC8mATk3IeVatO3fKDX81jk3qfXjmMAtIW21upmJFOEs0lx3O/iKP0z5LX/clA8t4ZTp1StFZubZE4pUtEUz9eiC8sCBcxFJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aXYhU5GA; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725151526; x=1756687526;
  h=date:from:to:cc:subject:message-id;
  bh=LaOS30z4FOc+pdvJl63gzHl9575sEDllJSJ/0QBPsBE=;
  b=aXYhU5GAI4amKI8Br6goEOAIaGAHiZoJKYe3B8MPv1V1oIbH6lSsXXBw
   iJtrtd/zMvfRToREMqm92GvpJxJHzsuoC+qALvIXTlzZRjiY+eC9bsIbv
   0VIwqtUt2hJUPyNNSmbtK+58ZwJhfV7UYZtBdDdpyvK7kVKTrUfSzooEb
   24Sh4j6O3O0yOkGvd4sekpuJpxzbo7RfW5N+4VTVATeu3/Os1C7SuYhEX
   0kJwMb5RCuBZ/9V0/GqzzkA802ndGjs2f6jmjTyMZuxfKhFcYQMXCFYNq
   CuWm5BKKFzRlCMIfd7joIzUHf1NYljnSeiCFE+twzvgCILZ/31DZLTXLf
   Q==;
X-CSE-ConnectionGUID: MFHGjuHBQUOSQEa2uW5tDg==
X-CSE-MsgGUID: qZWTSe5XRH+guSG7uSZWNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11181"; a="34427543"
X-IronPort-AV: E=Sophos;i="6.10,193,1719903600"; 
   d="scan'208";a="34427543"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2024 17:45:25 -0700
X-CSE-ConnectionGUID: LvkkaMJDQ/ekPshEjW4Nug==
X-CSE-MsgGUID: IlBFcvJMRHyqvKihDSKvMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,193,1719903600"; 
   d="scan'208";a="68901567"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 31 Aug 2024 17:45:24 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1skYiY-0003F4-28;
	Sun, 01 Sep 2024 00:45:22 +0000
Date: Sun, 01 Sep 2024 08:45:04 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 c0ce9f7fd25ea5050d30c37ad8ed707ae968a5c5
Message-ID: <202409010802.rHN07mkg-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: c0ce9f7fd25ea5050d30c37ad8ed707ae968a5c5  Merge branch 'core/core'

elapsed time: 731m

configs tested: 126
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-14.1.0
alpha                            allyesconfig   clang-20
alpha                               defconfig   gcc-14.1.0
arc                              allmodconfig   clang-20
arc                               allnoconfig   gcc-14.1.0
arc                              allyesconfig   clang-20
arc                                 defconfig   gcc-14.1.0
arc                            hsdk_defconfig   gcc-14.1.0
arm                              allmodconfig   clang-20
arm                               allnoconfig   gcc-14.1.0
arm                              allyesconfig   clang-20
arm                       aspeed_g5_defconfig   clang-20
arm                         at91_dt_defconfig   clang-20
arm                        clps711x_defconfig   clang-20
arm                     davinci_all_defconfig   clang-20
arm                                 defconfig   gcc-14.1.0
arm                            dove_defconfig   gcc-14.1.0
arm                          exynos_defconfig   clang-20
arm                       multi_v4t_defconfig   gcc-14.1.0
arm                           sama5_defconfig   gcc-14.1.0
arm                           stm32_defconfig   gcc-14.1.0
arm64                            alldefconfig   clang-20
arm64                            allmodconfig   clang-20
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-14.1.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-14.1.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   gcc-14.1.0
hexagon                          allyesconfig   clang-20
hexagon                             defconfig   gcc-14.1.0
i386                             allmodconfig   clang-18
i386                              allnoconfig   clang-18
i386                             allyesconfig   clang-18
i386         buildonly-randconfig-001-20240901   clang-18
i386         buildonly-randconfig-002-20240901   clang-18
i386         buildonly-randconfig-003-20240901   clang-18
i386         buildonly-randconfig-004-20240901   clang-18
i386         buildonly-randconfig-005-20240901   clang-18
i386         buildonly-randconfig-006-20240901   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240901   clang-18
i386                  randconfig-002-20240901   clang-18
i386                  randconfig-003-20240901   clang-18
i386                  randconfig-004-20240901   clang-18
i386                  randconfig-005-20240901   clang-18
i386                  randconfig-006-20240901   clang-18
i386                  randconfig-011-20240901   clang-18
i386                  randconfig-012-20240901   clang-18
i386                  randconfig-013-20240901   clang-18
i386                  randconfig-014-20240901   clang-18
i386                  randconfig-015-20240901   clang-18
i386                  randconfig-016-20240901   clang-18
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-14.1.0
m68k                          hp300_defconfig   clang-20
m68k                        m5272c3_defconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
mips                       bmips_be_defconfig   gcc-14.1.0
mips                           ci20_defconfig   clang-20
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-14.1.0
openrisc                          allnoconfig   clang-20
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-12
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   clang-20
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-12
parisc64                            defconfig   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   clang-20
powerpc                          allyesconfig   gcc-14.1.0
powerpc                 canyonlands_defconfig   gcc-14.1.0
powerpc                        fsp2_defconfig   clang-20
powerpc                    gamecube_defconfig   gcc-14.1.0
powerpc                   motionpro_defconfig   gcc-14.1.0
powerpc                 mpc832x_rdb_defconfig   clang-20
powerpc                     tqm8540_defconfig   clang-20
powerpc                     tqm8555_defconfig   gcc-14.1.0
powerpc                         wii_defconfig   clang-20
riscv                            alldefconfig   gcc-14.1.0
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   clang-20
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-12
riscv                               defconfig   gcc-14.1.0
s390                             allmodconfig   gcc-14.1.0
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-12
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-12
sh                         ecovec24_defconfig   clang-20
sh                               j2_defconfig   clang-20
sh                          kfr2r09_defconfig   clang-20
sh                  sh7785lcr_32bit_defconfig   gcc-14.1.0
sh                        sh7785lcr_defconfig   gcc-14.1.0
sh                          urquell_defconfig   clang-20
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-12
um                               allmodconfig   clang-20
um                                allnoconfig   clang-20
um                               allyesconfig   clang-20
um                                  defconfig   gcc-12
um                             i386_defconfig   gcc-12
um                           x86_64_defconfig   gcc-12
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64                              defconfig   clang-18
x86_64                                  kexec   gcc-12
x86_64                          rhel-8.3-rust   clang-18
x86_64                               rhel-8.3   gcc-12
xtensa                            allnoconfig   gcc-14.1.0
xtensa                       common_defconfig   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

