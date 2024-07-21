Return-Path: <linux-kernel+bounces-258312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24DA2938616
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 22:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 416071C208F6
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 20:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF3D168C26;
	Sun, 21 Jul 2024 20:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="So0ve6TO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65282FB2
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 20:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721594042; cv=none; b=L6iVUim3iw7uHCZ5F/pegtNU/tieIskLUflDGia7dn1b6Rhi1ZGoYNsACz4OdmtGUbD9g7KOSJasUuCS3q7NC+E30iROJgqN4KIbjMiN0CxYOfETGfUrXxG7h5szrOhAPd2zjJVDPo9TQ1WnWxjvDFNFjgftDE97/xuM4UlwPbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721594042; c=relaxed/simple;
	bh=JemDOzpBplNrkTRA5sRlh0c6SlvQ4eR353/cAHkIc5Q=;
	h=Date:From:To:Cc:Subject:Message-ID; b=jLcubhDAoF5OYkDDfna8zyi40ZdbP4nd/FYMcBAQSEjoCQJNGRXkSS5NFmTjV9+uHdhePAxkg+PeN5qaSUXWKIY+TrCJazR3sHZqzr75sVNsNgqZAIzqeZdCcR4tNW+OVjN5kWx6UI85PN18dE94D4pfwkdeSHQcqymd1fStTqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=So0ve6TO; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721594041; x=1753130041;
  h=date:from:to:cc:subject:message-id;
  bh=JemDOzpBplNrkTRA5sRlh0c6SlvQ4eR353/cAHkIc5Q=;
  b=So0ve6TOFPCn+AN/a9Dz6mwkYNe5Myc3auys+5LMMfeQJLnvQqIytI02
   vbOIgyI+zjsp03rpU2BxgRroHo+hUYqoUJZtBp7fdrQGKRTgHqVAgw3gz
   65LIfBf6bownmyA6D3e41Q1z6+v6agrWjQz9gwwVfxX/ZCN3qr+75m2cT
   pM6eovlP+VTjOeynd9TQtZrsRnvh047HYQoGI7AiqzmIldx8EWM8uBJja
   eWrQBs0DB2xdY1AM0+xxXHvD8XcE24NSvKb7OwE/m4/PGnj+9LlGTSQv/
   nbSibZHKDJRRbECH5leyYz02xal4QEtU9voalAk5CxisLMW0NeZJu6Mdm
   w==;
X-CSE-ConnectionGUID: UwOW71HSTYu+tKXZ1NOJsQ==
X-CSE-MsgGUID: LCwYCEoCT226Mn6vFJLwyw==
X-IronPort-AV: E=McAfee;i="6700,10204,11140"; a="41675066"
X-IronPort-AV: E=Sophos;i="6.09,225,1716274800"; 
   d="scan'208";a="41675066"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2024 13:34:01 -0700
X-CSE-ConnectionGUID: LglXN/JiRU2hRWnDxCHm8w==
X-CSE-MsgGUID: hNMj49rVRjWCe5L9jRC00A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,225,1716274800"; 
   d="scan'208";a="56518477"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 21 Jul 2024 13:33:59 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sVdFk-000kaU-1H;
	Sun, 21 Jul 2024 20:33:56 +0000
Date: Mon, 22 Jul 2024 04:33:30 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 5f2105a374ae763e309aa8651c58fbcc24e108c5
Message-ID: <202407220427.Hd4YYI15-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 5f2105a374ae763e309aa8651c58fbcc24e108c5  Merge branch into tip/master: 'x86/mm'

elapsed time: 725m

configs tested: 197
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
alpha                               defconfig   gcc-13.3.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240721   gcc-13.2.0
arc                   randconfig-002-20240721   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-19
arm                              allyesconfig   gcc-13.2.0
arm                              allyesconfig   gcc-14.1.0
arm                                 defconfig   clang-14
arm                                 defconfig   gcc-13.2.0
arm                       multi_v4t_defconfig   clang-19
arm                          pxa910_defconfig   clang-19
arm                             pxa_defconfig   gcc-14.1.0
arm                   randconfig-001-20240721   gcc-14.1.0
arm                   randconfig-002-20240721   gcc-14.1.0
arm                   randconfig-003-20240721   gcc-14.1.0
arm                   randconfig-004-20240721   gcc-14.1.0
arm                        spear6xx_defconfig   clang-19
arm64                            allmodconfig   clang-19
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-13.2.0
arm64                               defconfig   gcc-14.1.0
arm64                 randconfig-001-20240721   gcc-14.1.0
arm64                 randconfig-002-20240721   gcc-14.1.0
arm64                 randconfig-003-20240721   gcc-14.1.0
arm64                 randconfig-004-20240721   gcc-14.1.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-13.2.0
csky                                defconfig   gcc-14.1.0
csky                  randconfig-001-20240721   gcc-14.1.0
csky                  randconfig-002-20240721   gcc-14.1.0
hexagon                          allmodconfig   clang-19
hexagon                           allnoconfig   clang-19
hexagon                          allyesconfig   clang-19
hexagon                             defconfig   clang-19
hexagon               randconfig-001-20240721   clang-19
hexagon               randconfig-002-20240721   clang-19
i386                             allmodconfig   gcc-13
i386                              allnoconfig   gcc-13
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240721   gcc-8
i386         buildonly-randconfig-002-20240721   clang-18
i386         buildonly-randconfig-003-20240721   clang-18
i386         buildonly-randconfig-004-20240721   clang-18
i386         buildonly-randconfig-005-20240721   gcc-13
i386         buildonly-randconfig-006-20240721   gcc-8
i386                                defconfig   clang-18
i386                  randconfig-001-20240721   gcc-8
i386                  randconfig-002-20240721   gcc-10
i386                  randconfig-003-20240721   gcc-13
i386                  randconfig-004-20240721   clang-18
i386                  randconfig-005-20240721   gcc-13
i386                  randconfig-006-20240721   gcc-13
i386                  randconfig-011-20240721   gcc-13
i386                  randconfig-012-20240721   clang-18
i386                  randconfig-013-20240721   gcc-11
i386                  randconfig-014-20240721   gcc-13
i386                  randconfig-015-20240721   gcc-11
i386                  randconfig-016-20240721   clang-18
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-13.2.0
loongarch                           defconfig   gcc-14.1.0
loongarch             randconfig-001-20240721   gcc-14.1.0
loongarch             randconfig-002-20240721   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
m68k                                defconfig   gcc-14.1.0
m68k                        m5407c3_defconfig   gcc-14.1.0
m68k                          sun3x_defconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
microblaze                          defconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
mips                          ath79_defconfig   clang-19
mips                         db1xxx_defconfig   clang-19
mips                  decstation_64_defconfig   gcc-13.2.0
mips                    maltaup_xpa_defconfig   clang-19
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-13.2.0
nios2                               defconfig   gcc-14.1.0
nios2                 randconfig-001-20240721   gcc-14.1.0
nios2                 randconfig-002-20240721   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
openrisc                    or1ksim_defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240721   gcc-14.1.0
parisc                randconfig-002-20240721   gcc-14.1.0
parisc64                            defconfig   gcc-13.2.0
parisc64                            defconfig   gcc-14.1.0
powerpc                     akebono_defconfig   clang-19
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-19
powerpc                      arches_defconfig   gcc-14.1.0
powerpc                     asp8347_defconfig   clang-17
powerpc                        cell_defconfig   gcc-14.1.0
powerpc                   currituck_defconfig   clang-19
powerpc                        icon_defconfig   clang-19
powerpc                   lite5200b_defconfig   clang-19
powerpc                      mgcoge_defconfig   clang-19
powerpc                  mpc885_ads_defconfig   clang-19
powerpc                      ppc6xx_defconfig   gcc-14.1.0
powerpc               randconfig-001-20240721   gcc-14.1.0
powerpc               randconfig-002-20240721   clang-16
powerpc               randconfig-003-20240721   clang-19
powerpc                    sam440ep_defconfig   clang-19
powerpc                  storcenter_defconfig   clang-19
powerpc64             randconfig-001-20240721   gcc-14.1.0
powerpc64             randconfig-002-20240721   gcc-14.1.0
powerpc64             randconfig-003-20240721   clang-19
riscv                            allmodconfig   clang-19
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-19
riscv                               defconfig   clang-19
riscv                               defconfig   gcc-14.1.0
riscv                 randconfig-001-20240721   clang-19
riscv                 randconfig-002-20240721   gcc-14.1.0
s390                             alldefconfig   gcc-14.1.0
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   clang-19
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240721   clang-19
s390                  randconfig-002-20240721   clang-19
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                         ecovec24_defconfig   gcc-14.1.0
sh                    randconfig-001-20240721   gcc-14.1.0
sh                    randconfig-002-20240721   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240721   gcc-14.1.0
sparc64               randconfig-002-20240721   gcc-14.1.0
um                               allmodconfig   clang-19
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-13
um                                  defconfig   clang-19
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-13
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240721   gcc-13
um                    randconfig-002-20240721   gcc-13
um                           x86_64_defconfig   clang-15
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240721   clang-18
x86_64       buildonly-randconfig-002-20240721   clang-18
x86_64       buildonly-randconfig-003-20240721   gcc-13
x86_64       buildonly-randconfig-004-20240721   clang-18
x86_64       buildonly-randconfig-005-20240721   clang-18
x86_64       buildonly-randconfig-006-20240721   clang-18
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240721   gcc-13
x86_64                randconfig-002-20240721   clang-18
x86_64                randconfig-003-20240721   clang-18
x86_64                randconfig-004-20240721   gcc-13
x86_64                randconfig-005-20240721   gcc-9
x86_64                randconfig-006-20240721   clang-18
x86_64                randconfig-011-20240721   clang-18
x86_64                randconfig-012-20240721   gcc-8
x86_64                randconfig-013-20240721   gcc-8
x86_64                randconfig-014-20240721   gcc-13
x86_64                randconfig-015-20240721   clang-18
x86_64                randconfig-016-20240721   gcc-13
x86_64                randconfig-071-20240721   clang-18
x86_64                randconfig-072-20240721   clang-18
x86_64                randconfig-073-20240721   gcc-8
x86_64                randconfig-074-20240721   clang-18
x86_64                randconfig-075-20240721   gcc-13
x86_64                randconfig-076-20240721   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-14.1.0
xtensa                  audio_kc705_defconfig   gcc-14.1.0
xtensa                randconfig-001-20240721   gcc-14.1.0
xtensa                randconfig-002-20240721   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

