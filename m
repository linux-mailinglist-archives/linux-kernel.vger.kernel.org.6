Return-Path: <linux-kernel+bounces-402680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDE29C2A75
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 06:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 604AB1C20E23
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 05:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6F513B2A2;
	Sat,  9 Nov 2024 05:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bQ9Z6xfD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB0F28E8
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 05:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731131797; cv=none; b=GjJoL5wfHZanSwzt3dETkU8i0PO6HSaHqDcj8J6ndTepet7WJc6Azhup03AZB/sZpMOeeIZuDsgijpLZH53gn31iIQlsiudOpk/Oe0dxvLpFn5NuzeL0HOrxWII4fX2gqjI5Fv0c3B+Az7BLSsuHUjQnjeYpxM3DM7fQkQFzmHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731131797; c=relaxed/simple;
	bh=SWGpaYTgXFC0bBXwF+TrFvujseEvGQwvnGMRLldqfME=;
	h=Date:From:To:Cc:Subject:Message-ID; b=YJdo0RuIbf5IhTfl45AGrOl8pgtyQTRvXojFEv1UJ13OYcegmcIO/gioWSJe9zQySESs82hJEFyyAR6xK5GUxgooOw2+NEVIxWNzSePRGCdSZ0VZCfDLWPlRyWF0He3JDZ6/Dfk03yup47fzQtdhz5P1DDq7U+NGSXwXZTH2lzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bQ9Z6xfD; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731131795; x=1762667795;
  h=date:from:to:cc:subject:message-id;
  bh=SWGpaYTgXFC0bBXwF+TrFvujseEvGQwvnGMRLldqfME=;
  b=bQ9Z6xfDwKoyWnUT8E8b6+RSMrGPBHLF2dzpVuki5w6HfRoNXWgZ1Edq
   oLHcKBba0w8spi1avrDLP7ng+J3cliTibV58kDZBqFemsMedfgPKNWzff
   FaztMH/K636KO+z18imXoEoB0UBQmcYYsJ4+AljrJMRkeofThcG5jVPUn
   jUvmEX+wJOJosfu0ZxVug9uAoCHXiwpVPpf4XxOYyCLIb2iBL2eEkvzSN
   B1szzMJC46BlfjtppfxrLHCBzKa4JBPujvpUznFq4fJBVF5xReQ0LgKQt
   iEkdxtEgWiHJa7Yel2g0psaXNGOcGBU77aqzitQsllfxQqWPnJLJL14KI
   Q==;
X-CSE-ConnectionGUID: usHS3JuaQjmI3hQbKKrlnA==
X-CSE-MsgGUID: dEMAT4ZGQ1aDoWj4JIn4Jw==
X-IronPort-AV: E=McAfee;i="6700,10204,11250"; a="42422160"
X-IronPort-AV: E=Sophos;i="6.12,140,1728975600"; 
   d="scan'208";a="42422160"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 21:56:35 -0800
X-CSE-ConnectionGUID: FhB6VZTxRrWYin0q3n0OXw==
X-CSE-MsgGUID: 8Ox58vIYQBi4krG9drK0ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,140,1728975600"; 
   d="scan'208";a="109200255"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 08 Nov 2024 21:56:34 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t9eSV-000s7F-29;
	Sat, 09 Nov 2024 05:56:31 +0000
Date: Sat, 09 Nov 2024 13:56:17 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/misc] BUILD SUCCESS
 62e724494db7954c47b4417769f1225cf98f4d77
Message-ID: <202411091311.y9A390ba-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/misc
branch HEAD: 62e724494db7954c47b4417769f1225cf98f4d77  x86/cpu: Make sure flag_is_changeable_p() is always being used

elapsed time: 723m

configs tested: 166
configs skipped: 130

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-20
arc                          axs101_defconfig    clang-20
arc                                 defconfig    gcc-14.2.0
arc                         haps_hs_defconfig    clang-14
arc                        nsimosci_defconfig    gcc-14.2.0
arc                        vdk_hs38_defconfig    clang-20
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-20
arm                                 defconfig    gcc-14.2.0
arm                         lpc18xx_defconfig    gcc-14.2.0
arm                         lpc32xx_defconfig    clang-20
arm                            mps2_defconfig    gcc-14.2.0
arm                        neponset_defconfig    clang-14
arm                            qcom_defconfig    gcc-14.2.0
arm                        realview_defconfig    clang-20
arm                         s3c6400_defconfig    gcc-14.2.0
arm                           stm32_defconfig    clang-20
arm                           u8500_defconfig    clang-14
arm                           u8500_defconfig    clang-20
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.2.0
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                             allyesconfig    clang-19
i386        buildonly-randconfig-001-20241109    clang-19
i386        buildonly-randconfig-002-20241109    clang-19
i386        buildonly-randconfig-003-20241109    clang-19
i386        buildonly-randconfig-004-20241109    clang-19
i386        buildonly-randconfig-005-20241109    clang-19
i386        buildonly-randconfig-006-20241109    clang-19
i386                                defconfig    clang-19
i386                  randconfig-001-20241109    clang-19
i386                  randconfig-002-20241109    clang-19
i386                  randconfig-003-20241109    clang-19
i386                  randconfig-004-20241109    clang-19
i386                  randconfig-005-20241109    clang-19
i386                  randconfig-006-20241109    clang-19
i386                  randconfig-011-20241109    clang-19
i386                  randconfig-012-20241109    clang-19
i386                  randconfig-013-20241109    clang-19
i386                  randconfig-014-20241109    clang-19
i386                  randconfig-015-20241109    clang-19
i386                  randconfig-016-20241109    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                       m5249evb_defconfig    clang-14
m68k                        stmark2_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          ath79_defconfig    clang-20
mips                          eyeq5_defconfig    clang-20
mips                      maltaaprp_defconfig    clang-14
mips                        omega2p_defconfig    clang-20
mips                        qi_lb60_defconfig    gcc-14.2.0
mips                          rb532_defconfig    clang-14
mips                           xway_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
parisc                           alldefconfig    clang-14
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.2.0
powerpc                      arches_defconfig    clang-14
powerpc                     ep8248e_defconfig    clang-14
powerpc                        fsp2_defconfig    clang-14
powerpc                  iss476-smp_defconfig    clang-14
powerpc                  iss476-smp_defconfig    clang-20
powerpc                     ksi8560_defconfig    gcc-14.2.0
powerpc                     mpc512x_defconfig    gcc-14.2.0
powerpc                 mpc8313_rdb_defconfig    clang-14
powerpc                 mpc8313_rdb_defconfig    clang-20
powerpc                 mpc8313_rdb_defconfig    gcc-14.2.0
powerpc                 mpc834x_itx_defconfig    clang-20
powerpc                 mpc836x_rdk_defconfig    clang-14
powerpc                  mpc866_ads_defconfig    clang-20
powerpc                  mpc885_ads_defconfig    clang-14
powerpc                     redwood_defconfig    clang-14
powerpc                 xes_mpc85xx_defconfig    clang-20
riscv                            alldefconfig    clang-20
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                        edosk7705_defconfig    gcc-14.2.0
sh                            hp6xx_defconfig    clang-20
sh                     magicpanelr2_defconfig    gcc-14.2.0
sh                           se7619_defconfig    gcc-14.2.0
sh                           se7721_defconfig    gcc-14.2.0
sh                              ul2_defconfig    clang-20
sh                          urquell_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc64                             defconfig    gcc-12
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241109    gcc-12
x86_64      buildonly-randconfig-002-20241109    gcc-12
x86_64      buildonly-randconfig-003-20241109    gcc-12
x86_64      buildonly-randconfig-004-20241109    gcc-12
x86_64      buildonly-randconfig-005-20241109    gcc-12
x86_64      buildonly-randconfig-006-20241109    gcc-12
x86_64                              defconfig    clang-19
x86_64                                  kexec    clang-19
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20241109    gcc-12
x86_64                randconfig-002-20241109    gcc-12
x86_64                randconfig-003-20241109    gcc-12
x86_64                randconfig-004-20241109    gcc-12
x86_64                randconfig-005-20241109    gcc-12
x86_64                randconfig-006-20241109    gcc-12
x86_64                randconfig-011-20241109    gcc-12
x86_64                randconfig-012-20241109    gcc-12
x86_64                randconfig-013-20241109    gcc-12
x86_64                randconfig-014-20241109    gcc-12
x86_64                randconfig-015-20241109    gcc-12
x86_64                randconfig-016-20241109    gcc-12
x86_64                randconfig-071-20241109    gcc-12
x86_64                randconfig-072-20241109    gcc-12
x86_64                randconfig-073-20241109    gcc-12
x86_64                randconfig-074-20241109    gcc-12
x86_64                randconfig-075-20241109    gcc-12
x86_64                randconfig-076-20241109    gcc-12
x86_64                               rhel-8.3    gcc-12
xtensa                            allnoconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

