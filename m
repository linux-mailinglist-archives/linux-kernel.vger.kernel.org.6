Return-Path: <linux-kernel+bounces-432748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FBD09E4FBD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 09:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C046916505D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 08:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8041A1D3564;
	Thu,  5 Dec 2024 08:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ni6cKR2N"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805391AF0DA
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 08:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733387460; cv=none; b=DEwsYRms2SiUyltNlwLhW6hpSfzSpdxDNKMUlFposnajjVNx7N2+kytTm0JLHRcqqqJ4GrUUJDsWfOw6+3KvSX0/k0PtJBg75JAVm0VjM9E14/hc4IiR8tgf4xLOkV72+7OuqqL3dhKJ63vVYPuc1SCgah8HqXknCpvw8U3CoCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733387460; c=relaxed/simple;
	bh=OhP0yAPHkEuzy2fbqGGuioSp03X/uFbzHAFs36D3/L0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=KZNecNhVuoaNsxOH8C6cnA5xpAnpq7KZy+cXNKshvuQHecP7Jhx82QJBU0n1KMOAAlpBK4GMVPOfVlO4auENKVWaiYyFRdxDwQVTnH9042cy9q/M1gN0iaXzPfisPuxDOq0qXRCHfLAj+egLUNzhViptHsz/FSoyIndEmeuILjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ni6cKR2N; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733387459; x=1764923459;
  h=date:from:to:cc:subject:message-id;
  bh=OhP0yAPHkEuzy2fbqGGuioSp03X/uFbzHAFs36D3/L0=;
  b=ni6cKR2Noj32MxyqjG8DLC5RGhaOxRek8gcmHLtJuZXKZyTSmLgH+E0T
   9zUDD3Y9nXvlRDN7yetqb/w3XtTY7aqNXHK3OhCn06+sUYFpZtnwtgHw1
   fIbXOYUE83+/uRWgBr5OhQbkyjia3Pu9/d8+RXdt6shLKdBy/kqce03I1
   fAcKIW5e6+tGmKznQYO5pIF6VtSooVpkiFmEccjE6TVx+4oPaYVTmwkkk
   7HYggZSrzmBkbNHYwFezmPDBiTeOd/wMAQgMMvSqfB/NGg27paWxpOfg6
   AYiDnNnEw9DK0gbJGg5ec3EGXB9vJ7+jdmDTero2GJuKrHWOvQmogDYtQ
   A==;
X-CSE-ConnectionGUID: oFyn1uHgRLSSyj7fAplOTQ==
X-CSE-MsgGUID: w3CjXHfyQICm8URg0BxrDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="37466841"
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; 
   d="scan'208";a="37466841"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 00:30:58 -0800
X-CSE-ConnectionGUID: x6bXsS9DQDSepJH812SWaw==
X-CSE-MsgGUID: JVFLzJzDRGq2TSOUAKpn6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; 
   d="scan'208";a="98834206"
Received: from lkp-server02.sh.intel.com (HELO 1f5a171d57e2) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 05 Dec 2024 00:30:57 -0800
Received: from kbuild by 1f5a171d57e2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tJ7GA-0003yO-2I;
	Thu, 05 Dec 2024 08:30:54 +0000
Date: Thu, 05 Dec 2024 16:27:44 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:tip/urgent] BUILD SUCCESS
 691c327e72dfed220b87c74a09cfd91a27074a78
Message-ID: <202412051634.OnvEAwQn-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tip/urgent
branch HEAD: 691c327e72dfed220b87c74a09cfd91a27074a78  Merge branch into tip/master: 'x86/urgent'

elapsed time: 723m

configs tested: 207
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-20
arc                          axs101_defconfig    clang-18
arc                          axs101_defconfig    clang-20
arc                          axs103_defconfig    clang-20
arc                      axs103_smp_defconfig    gcc-14.2.0
arc                        nsimosci_defconfig    clang-20
arc                            randconfig-001    clang-20
arc                   randconfig-001-20241205    clang-20
arc                   randconfig-001-20241205    gcc-13.2.0
arc                            randconfig-002    clang-20
arc                   randconfig-002-20241205    clang-20
arc                   randconfig-002-20241205    gcc-13.2.0
arc                           tb10x_defconfig    clang-20
arc                        vdk_hs38_defconfig    gcc-14.2.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    clang-20
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-20
arm                         assabet_defconfig    gcc-14.2.0
arm                         at91_dt_defconfig    clang-20
arm                          collie_defconfig    gcc-14.2.0
arm                          exynos_defconfig    gcc-14.2.0
arm                       imx_v4_v5_defconfig    clang-18
arm                           imxrt_defconfig    clang-20
arm                      integrator_defconfig    clang-20
arm                          ixp4xx_defconfig    clang-20
arm                        keystone_defconfig    clang-20
arm                            mps2_defconfig    clang-20
arm                       multi_v4t_defconfig    clang-20
arm                        multi_v7_defconfig    gcc-14.2.0
arm                         mv78xx0_defconfig    clang-17
arm                           omap1_defconfig    clang-20
arm                          pxa910_defconfig    clang-20
arm                          pxa910_defconfig    gcc-14.2.0
arm                            randconfig-001    clang-20
arm                   randconfig-001-20241205    clang-20
arm                            randconfig-002    clang-20
arm                   randconfig-002-20241205    clang-20
arm                   randconfig-002-20241205    gcc-14.2.0
arm                            randconfig-003    clang-20
arm                   randconfig-003-20241205    clang-20
arm                            randconfig-004    clang-20
arm                   randconfig-004-20241205    clang-15
arm                   randconfig-004-20241205    clang-20
arm                        realview_defconfig    clang-20
arm                           sama7_defconfig    clang-20
arm                          sp7021_defconfig    clang-20
arm                        spear3xx_defconfig    clang-20
arm                           spitz_defconfig    gcc-14.2.0
arm                           stm32_defconfig    clang-20
arm                    vt8500_v6_v7_defconfig    clang-20
arm                         wpcm450_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    clang-20
arm64                          randconfig-001    clang-20
arm64                 randconfig-001-20241205    clang-15
arm64                 randconfig-001-20241205    clang-20
arm64                          randconfig-002    clang-20
arm64                 randconfig-002-20241205    clang-20
arm64                 randconfig-002-20241205    gcc-14.2.0
arm64                          randconfig-003    clang-20
arm64                 randconfig-003-20241205    clang-20
arm64                          randconfig-004    clang-20
arm64                 randconfig-004-20241205    clang-20
arm64                 randconfig-004-20241205    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
hexagon                          alldefconfig    clang-20
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-20
i386                 buildonly-randconfig-001    gcc-12
i386        buildonly-randconfig-001-20241205    clang-19
i386                 buildonly-randconfig-002    gcc-12
i386        buildonly-randconfig-002-20241205    clang-19
i386                 buildonly-randconfig-003    gcc-12
i386        buildonly-randconfig-003-20241205    clang-19
i386                 buildonly-randconfig-004    gcc-12
i386        buildonly-randconfig-004-20241205    clang-19
i386                 buildonly-randconfig-005    gcc-12
i386        buildonly-randconfig-005-20241205    clang-19
i386                 buildonly-randconfig-006    gcc-12
i386        buildonly-randconfig-006-20241205    clang-19
loongarch                        alldefconfig    gcc-14.2.0
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                       m5249evb_defconfig    gcc-14.2.0
m68k                            mac_defconfig    gcc-14.2.0
m68k                        mvme147_defconfig    gcc-14.2.0
m68k                           virt_defconfig    clang-20
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          ath79_defconfig    clang-20
mips                         bigsur_defconfig    clang-17
mips                          eyeq6_defconfig    clang-20
mips                            gpr_defconfig    clang-20
mips                           jazz_defconfig    clang-20
mips                     loongson1b_defconfig    gcc-14.2.0
mips                          rb532_defconfig    clang-17
mips                   sb1250_swarm_defconfig    clang-20
nios2                         3c120_defconfig    clang-20
nios2                             allnoconfig    gcc-14.2.0
openrisc                         alldefconfig    clang-20
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                       virt_defconfig    gcc-14.2.0
parisc                           alldefconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                generic-32bit_defconfig    clang-20
powerpc                    adder875_defconfig    clang-20
powerpc                     akebono_defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    gcc-14.2.0
powerpc                      cm5200_defconfig    clang-20
powerpc                   currituck_defconfig    clang-20
powerpc                       ebony_defconfig    clang-18
powerpc                          g5_defconfig    gcc-14.2.0
powerpc                    ge_imp3a_defconfig    clang-18
powerpc                    ge_imp3a_defconfig    clang-20
powerpc                       holly_defconfig    clang-20
powerpc                        icon_defconfig    clang-20
powerpc                  iss476-smp_defconfig    clang-20
powerpc                 linkstation_defconfig    clang-18
powerpc                   lite5200b_defconfig    clang-20
powerpc                      mgcoge_defconfig    clang-20
powerpc                 mpc8313_rdb_defconfig    clang-20
powerpc                 mpc834x_itx_defconfig    gcc-14.2.0
powerpc                 mpc837x_rdb_defconfig    clang-20
powerpc                    mvme5100_defconfig    clang-20
powerpc                    mvme5100_defconfig    gcc-14.2.0
powerpc                      ppc44x_defconfig    clang-20
powerpc                     skiroot_defconfig    clang-20
powerpc                     tqm5200_defconfig    gcc-14.2.0
powerpc                     tqm8548_defconfig    clang-20
powerpc                     tqm8555_defconfig    clang-20
powerpc                        warp_defconfig    clang-17
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    gcc-14.2.0
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                        dreamcast_defconfig    clang-17
sh                        dreamcast_defconfig    gcc-14.2.0
sh                ecovec24-romimage_defconfig    clang-18
sh                          landisk_defconfig    gcc-14.2.0
sh                            migor_defconfig    gcc-14.2.0
sh                          polaris_defconfig    gcc-14.2.0
sh                          rsk7201_defconfig    clang-20
sh                          sdk7780_defconfig    clang-20
sh                           se7206_defconfig    clang-17
sh                           se7343_defconfig    gcc-14.2.0
sh                           se7721_defconfig    gcc-14.2.0
sh                           se7722_defconfig    clang-17
sh                             sh03_defconfig    clang-20
sh                   sh7724_generic_defconfig    clang-20
sh                   sh7724_generic_defconfig    gcc-14.2.0
sh                        sh7757lcr_defconfig    gcc-14.2.0
sh                             shx3_defconfig    clang-20
sh                            titan_defconfig    clang-20
sh                          urquell_defconfig    gcc-14.2.0
sparc                            alldefconfig    clang-18
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                           x86_64_defconfig    clang-20
x86_64               buildonly-randconfig-001    gcc-11
x86_64      buildonly-randconfig-001-20241205    clang-19
x86_64               buildonly-randconfig-002    clang-19
x86_64      buildonly-randconfig-002-20241205    clang-19
x86_64               buildonly-randconfig-003    gcc-12
x86_64      buildonly-randconfig-003-20241205    clang-19
x86_64               buildonly-randconfig-004    gcc-12
x86_64      buildonly-randconfig-004-20241205    clang-19
x86_64               buildonly-randconfig-005    gcc-12
x86_64      buildonly-randconfig-005-20241205    clang-19
x86_64               buildonly-randconfig-006    clang-19
x86_64      buildonly-randconfig-006-20241205    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                  audio_kc705_defconfig    clang-20
xtensa                  cadence_csp_defconfig    gcc-14.2.0
xtensa                generic_kc705_defconfig    clang-20
xtensa                          iss_defconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

