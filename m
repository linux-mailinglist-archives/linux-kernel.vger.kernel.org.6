Return-Path: <linux-kernel+bounces-397636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0503B9BDE56
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 06:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AA451F244AC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 05:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A234019066D;
	Wed,  6 Nov 2024 05:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h0CEcvya"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DC94084D
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 05:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730871732; cv=none; b=OnspvH+Wphi9JumfAdys1MsgaxEisrKoc2qf2QqxFAD+XMKy56SeBEqutJml+V/TnV364RrEsCngVVpqOy1JE83NwFmu2cn7u6lV90HRDh0c68mR+hEZmBAHZy+xUqjdCdndU7xVJGYVMCk+yfTrlbcKS+7JOM05Am4x6xIjmnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730871732; c=relaxed/simple;
	bh=osMcQIlPa3uzOA0JTHXol6HoP4Sjdp5lJLpyoUIxEuU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Q5UvZwGAOvKdlzeD5wFzgKGcN4uCNx3Aj2RBP3CIfyehPBicyxah+DYKKDiVz8rqHdolsYHI25saRgQ0o6AkOITEwKUACs8ojkc8wdXwiLAvHW+iH4tke0XKrkl3/KL9Y2T9RLc/vga0z1jv+MSewPa5+y7bJ1F9Ss6BjjtcPZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h0CEcvya; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730871730; x=1762407730;
  h=date:from:to:cc:subject:message-id;
  bh=osMcQIlPa3uzOA0JTHXol6HoP4Sjdp5lJLpyoUIxEuU=;
  b=h0CEcvyaWIxgDkyK9jXEDFaqOXplMOMhtDHKLjLWdWR3cN9+zgy3xDRf
   Xw1RXbWDABP4VTmtycnU248mZJE1QR7eTHmyLob7jW6SderZIqQunVJIt
   QHpHG0aUiQu5Q7BFSSVWI56w+DcOL1hK9kNWm4+HjXekSkp9pb5AFFggA
   0vVEZjVs5PBT8eSRZiCJkucN4NCQZ/7yk//92c8K6OHWoyo0yd6sNet2e
   a7hdMh/sy9oeyx9kbkBNYTC/hl44t+3kK9UogigN/jyYfh5vTP+jXUmcT
   Ebdl4hKCHQS2QmWT9XwC5/m3nqPUhVeHVfzqcQw3PJEwmLOikk+BYxCsV
   g==;
X-CSE-ConnectionGUID: 9KgiHUHmR+GdAoqk5BqF8g==
X-CSE-MsgGUID: 1uiXldhGSmiE3W6aAP+Gng==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30829780"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30829780"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 21:42:10 -0800
X-CSE-ConnectionGUID: hdxiQ5kvTwWxXiwfL4D70A==
X-CSE-MsgGUID: vbliv+XeQS64Tvgxx2goCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,262,1725346800"; 
   d="scan'208";a="84458726"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 05 Nov 2024 21:42:08 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t8Ynu-000mxs-1W;
	Wed, 06 Nov 2024 05:42:06 +0000
Date: Wed, 06 Nov 2024 13:41:44 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 a5ca1dc46a6b610dd4627d8b633d6c84f9724ef0
Message-ID: <202411061335.KarypsqY-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: a5ca1dc46a6b610dd4627d8b633d6c84f9724ef0  x86/CPU/AMD: Clear virtualized VMLOAD/VMSAVE on Zen4 client

elapsed time: 729m

configs tested: 184
configs skipped: 133

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                            hsdk_defconfig    gcc-14.1.0
arc                        nsim_700_defconfig    gcc-14.1.0
arc                   randconfig-001-20241106    gcc-14.2.0
arc                   randconfig-002-20241106    gcc-14.2.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                         axm55xx_defconfig    gcc-14.1.0
arm                   randconfig-001-20241106    gcc-14.2.0
arm                   randconfig-002-20241106    gcc-14.2.0
arm                   randconfig-003-20241106    gcc-14.2.0
arm                   randconfig-004-20241106    gcc-14.2.0
arm                           sama5_defconfig    gcc-14.1.0
arm                        shmobile_defconfig    gcc-14.1.0
arm                          sp7021_defconfig    gcc-14.1.0
arm                        spear6xx_defconfig    gcc-14.1.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                 randconfig-001-20241106    gcc-14.2.0
arm64                 randconfig-002-20241106    gcc-14.2.0
arm64                 randconfig-003-20241106    gcc-14.2.0
arm64                 randconfig-004-20241106    gcc-14.2.0
csky                              allnoconfig    gcc-14.1.0
csky                  randconfig-001-20241106    gcc-14.2.0
csky                  randconfig-002-20241106    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon               randconfig-001-20241106    gcc-14.2.0
hexagon               randconfig-002-20241106    gcc-14.2.0
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                             allyesconfig    clang-19
i386        buildonly-randconfig-001-20241106    gcc-12
i386        buildonly-randconfig-002-20241106    gcc-12
i386        buildonly-randconfig-003-20241106    gcc-12
i386        buildonly-randconfig-004-20241106    gcc-12
i386        buildonly-randconfig-005-20241106    gcc-12
i386        buildonly-randconfig-006-20241106    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20241106    gcc-12
i386                  randconfig-002-20241106    gcc-12
i386                  randconfig-003-20241106    gcc-12
i386                  randconfig-004-20241106    gcc-12
i386                  randconfig-005-20241106    gcc-12
i386                  randconfig-006-20241106    gcc-12
i386                  randconfig-011-20241106    gcc-12
i386                  randconfig-012-20241106    gcc-12
i386                  randconfig-013-20241106    gcc-12
i386                  randconfig-014-20241106    gcc-12
i386                  randconfig-015-20241106    gcc-12
i386                  randconfig-016-20241106    gcc-12
loongarch                        allmodconfig    gcc-14.1.0
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch             randconfig-001-20241106    gcc-14.2.0
loongarch             randconfig-002-20241106    gcc-14.2.0
m68k                             allmodconfig    gcc-14.1.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.2.0
m68k                         amcore_defconfig    gcc-14.1.0
m68k                       m5249evb_defconfig    gcc-14.1.0
m68k                           sun3_defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.1.0
mips                        vocore2_defconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                 randconfig-001-20241106    gcc-14.2.0
nios2                 randconfig-002-20241106    gcc-14.2.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
openrisc                    or1ksim_defconfig    gcc-14.1.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20241106    gcc-14.2.0
parisc                randconfig-002-20241106    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.2.0
powerpc                     ep8248e_defconfig    gcc-14.1.0
powerpc                   motionpro_defconfig    gcc-14.1.0
powerpc                 mpc8315_rdb_defconfig    gcc-14.1.0
powerpc                 mpc837x_rdb_defconfig    gcc-14.1.0
powerpc                      ppc64e_defconfig    gcc-14.1.0
powerpc                     rainier_defconfig    gcc-14.1.0
powerpc               randconfig-001-20241106    gcc-14.2.0
powerpc               randconfig-002-20241106    gcc-14.2.0
powerpc               randconfig-003-20241106    gcc-14.2.0
powerpc                     sequoia_defconfig    gcc-14.1.0
powerpc                  storcenter_defconfig    gcc-14.1.0
powerpc64             randconfig-001-20241106    gcc-14.2.0
powerpc64             randconfig-002-20241106    gcc-14.2.0
powerpc64             randconfig-003-20241106    gcc-14.2.0
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20241106    gcc-14.2.0
riscv                 randconfig-002-20241106    gcc-14.2.0
s390                             allmodconfig    gcc-14.1.0
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20241106    gcc-14.2.0
s390                  randconfig-002-20241106    gcc-14.2.0
s390                       zfcpdump_defconfig    gcc-14.1.0
sh                               allmodconfig    gcc-14.1.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.2.0
sh                        apsh4ad0a_defconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                ecovec24-romimage_defconfig    gcc-14.1.0
sh                    randconfig-001-20241106    gcc-14.2.0
sh                    randconfig-002-20241106    gcc-14.2.0
sh                           se7750_defconfig    gcc-14.1.0
sh                           sh2007_defconfig    gcc-14.1.0
sh                     sh7710voipgw_defconfig    gcc-14.1.0
sh                        sh7763rdp_defconfig    gcc-14.1.0
sparc                            allmodconfig    gcc-14.1.0
sparc                            allmodconfig    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20241106    gcc-14.2.0
sparc64               randconfig-002-20241106    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241106    gcc-14.2.0
um                    randconfig-002-20241106    gcc-14.2.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241106    gcc-11
x86_64      buildonly-randconfig-002-20241106    gcc-11
x86_64      buildonly-randconfig-003-20241106    gcc-11
x86_64      buildonly-randconfig-004-20241106    gcc-11
x86_64      buildonly-randconfig-005-20241106    gcc-11
x86_64      buildonly-randconfig-006-20241106    gcc-11
x86_64                              defconfig    clang-19
x86_64                                  kexec    clang-19
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20241106    gcc-11
x86_64                randconfig-002-20241106    gcc-11
x86_64                randconfig-003-20241106    gcc-11
x86_64                randconfig-004-20241106    gcc-11
x86_64                randconfig-005-20241106    gcc-11
x86_64                randconfig-006-20241106    gcc-11
x86_64                randconfig-011-20241106    gcc-11
x86_64                randconfig-012-20241106    gcc-11
x86_64                randconfig-013-20241106    gcc-11
x86_64                randconfig-014-20241106    gcc-11
x86_64                randconfig-015-20241106    gcc-11
x86_64                randconfig-016-20241106    gcc-11
x86_64                randconfig-071-20241106    gcc-11
x86_64                randconfig-072-20241106    gcc-11
x86_64                randconfig-073-20241106    gcc-11
x86_64                randconfig-074-20241106    gcc-11
x86_64                randconfig-075-20241106    gcc-11
x86_64                randconfig-076-20241106    gcc-11
x86_64                               rhel-8.3    gcc-12
xtensa                            allnoconfig    gcc-14.1.0
xtensa                  audio_kc705_defconfig    gcc-14.1.0
xtensa                randconfig-001-20241106    gcc-14.2.0
xtensa                randconfig-002-20241106    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

