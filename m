Return-Path: <linux-kernel+bounces-277196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73ABF949DB5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 04:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E81921F2132E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 02:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A77A198E75;
	Wed,  7 Aug 2024 02:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cML+RFkp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FA4198E69
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 02:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722996761; cv=none; b=ZImFIj/Vdntd5983UsZXrA6bgOk4E+0xJgLxJH4cxNbUVY/W5rhaIHeU3eiLBfIqpoZxqIXFmp470UCK/jjcoBf2kwRL9UuapqlO1TQJySMoJCj6W6MwqcMFCZ30t0a+AOO0T0gaviQs8fiLeHeh+kaFDRodQd2O2WkX+KVxwM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722996761; c=relaxed/simple;
	bh=Wp7/Nz/h3OKBeQMNh3XltzWJLYCEZVe5ymbkRhuH06U=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Mz2pWDZg7u5RQjvTiWlZFeXTG931NxDUV6J51XTVgOfj0kf41bKh6doYo8HDB/2JpdbQkGNoFli0ixhsw2mNxtum3PzhhYagLHgrIaRT8fzp9HB/HccwZ4VzPpuFSDLdXQBa1snZrOtsXzhgjuHS5zPfAXxcKEanuUNOouiv6N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cML+RFkp; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722996759; x=1754532759;
  h=date:from:to:cc:subject:message-id;
  bh=Wp7/Nz/h3OKBeQMNh3XltzWJLYCEZVe5ymbkRhuH06U=;
  b=cML+RFkpEwC8F3ulKxtrG4lRBVdEyo2De+IXd3Xsqx5SZaeeLVEGfi31
   xmuPMG9BwR2dxSm2Nj17IsR9vV1SeuGc1Ls9VOTZoZhsTsjGtOyGL9qQO
   SEW3QG04fvDO9hWZWsqPeFYNN9stzkTU/vH4rOaEPbGjR9SBevjynZjAw
   z6JkL7rzOuqe5j7VTKvtglM7Qu8xUOZX7d3Deyxk4dNHs1wr5GbZQ8i4s
   Gc6GqZZe5iJaqLFAkh12ziTV+DCqwp6OXSlo5fLBNrGa/fiEG7fGScfr1
   epnHp4yaI/u9A0Lp/VLclRdMZVVWvGctcbrNTJwrxC8fJV8Dfovtln3XA
   g==;
X-CSE-ConnectionGUID: ZIllR8v5R+OSMa5XWpgmHg==
X-CSE-MsgGUID: DnaBTnRdRk62njc+XHe7XA==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="20619271"
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="20619271"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 19:12:38 -0700
X-CSE-ConnectionGUID: yedgl88hRC6ImLnrtzIhzQ==
X-CSE-MsgGUID: +zDZ8DTVTFmEdnTmhHM5fQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="94261864"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 06 Aug 2024 19:12:37 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sbWAE-00053c-1j;
	Wed, 07 Aug 2024 02:12:34 +0000
Date: Wed, 07 Aug 2024 10:12:09 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 9ebdc7589cbb5c976e6c8807cbe13f263d70d32c
Message-ID: <202408071007.xBJLDTmG-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 9ebdc7589cbb5c976e6c8807cbe13f263d70d32c  Merge branch into tip/master: 'x86/timers'

elapsed time: 870m

configs tested: 307
configs skipped: 10

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                        nsim_700_defconfig   gcc-13.2.0
arc                   randconfig-001-20240806   gcc-13.2.0
arc                   randconfig-001-20240807   gcc-13.2.0
arc                   randconfig-002-20240806   gcc-13.2.0
arc                   randconfig-002-20240807   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-20
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                              allyesconfig   gcc-14.1.0
arm                         at91_dt_defconfig   gcc-13.2.0
arm                                 defconfig   gcc-13.2.0
arm                           h3600_defconfig   gcc-14.1.0
arm                         mv78xx0_defconfig   gcc-14.1.0
arm                           omap1_defconfig   gcc-14.1.0
arm                             pxa_defconfig   gcc-14.1.0
arm                   randconfig-001-20240806   clang-20
arm                   randconfig-001-20240806   gcc-13.2.0
arm                   randconfig-001-20240807   gcc-13.2.0
arm                   randconfig-002-20240806   gcc-13.2.0
arm                   randconfig-002-20240806   gcc-14.1.0
arm                   randconfig-002-20240807   gcc-13.2.0
arm                   randconfig-003-20240806   gcc-13.2.0
arm                   randconfig-003-20240806   gcc-14.1.0
arm                   randconfig-003-20240807   gcc-13.2.0
arm                   randconfig-004-20240806   gcc-13.2.0
arm                   randconfig-004-20240806   gcc-14.1.0
arm                   randconfig-004-20240807   gcc-13.2.0
arm                         s5pv210_defconfig   gcc-13.2.0
arm64                            allmodconfig   clang-20
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-13.2.0
arm64                               defconfig   gcc-14.1.0
arm64                 randconfig-001-20240806   clang-20
arm64                 randconfig-001-20240806   gcc-13.2.0
arm64                 randconfig-001-20240807   gcc-13.2.0
arm64                 randconfig-002-20240806   clang-20
arm64                 randconfig-002-20240806   gcc-13.2.0
arm64                 randconfig-002-20240807   gcc-13.2.0
arm64                 randconfig-003-20240806   clang-14
arm64                 randconfig-003-20240806   gcc-13.2.0
arm64                 randconfig-003-20240807   gcc-13.2.0
arm64                 randconfig-004-20240806   gcc-13.2.0
arm64                 randconfig-004-20240806   gcc-14.1.0
arm64                 randconfig-004-20240807   gcc-13.2.0
csky                             alldefconfig   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240806   gcc-13.2.0
csky                  randconfig-001-20240806   gcc-14.1.0
csky                  randconfig-001-20240807   gcc-13.2.0
csky                  randconfig-002-20240806   gcc-13.2.0
csky                  randconfig-002-20240806   gcc-14.1.0
csky                  randconfig-002-20240807   gcc-13.2.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   clang-20
hexagon                          allyesconfig   clang-20
hexagon               randconfig-001-20240806   clang-20
hexagon               randconfig-002-20240806   clang-17
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-12
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-12
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240806   gcc-11
i386         buildonly-randconfig-001-20240807   clang-18
i386         buildonly-randconfig-002-20240806   gcc-11
i386         buildonly-randconfig-002-20240806   gcc-12
i386         buildonly-randconfig-002-20240807   clang-18
i386         buildonly-randconfig-003-20240806   gcc-11
i386         buildonly-randconfig-003-20240806   gcc-12
i386         buildonly-randconfig-003-20240807   clang-18
i386         buildonly-randconfig-004-20240806   gcc-11
i386         buildonly-randconfig-004-20240806   gcc-12
i386         buildonly-randconfig-004-20240807   clang-18
i386         buildonly-randconfig-005-20240806   clang-18
i386         buildonly-randconfig-005-20240806   gcc-11
i386         buildonly-randconfig-005-20240807   clang-18
i386         buildonly-randconfig-006-20240806   gcc-11
i386         buildonly-randconfig-006-20240806   gcc-12
i386         buildonly-randconfig-006-20240807   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240806   clang-18
i386                  randconfig-001-20240806   gcc-11
i386                  randconfig-001-20240807   clang-18
i386                  randconfig-002-20240806   gcc-11
i386                  randconfig-002-20240806   gcc-12
i386                  randconfig-002-20240807   clang-18
i386                  randconfig-003-20240806   gcc-11
i386                  randconfig-003-20240806   gcc-12
i386                  randconfig-003-20240807   clang-18
i386                  randconfig-004-20240806   gcc-11
i386                  randconfig-004-20240806   gcc-12
i386                  randconfig-004-20240807   clang-18
i386                  randconfig-005-20240806   clang-18
i386                  randconfig-005-20240806   gcc-11
i386                  randconfig-005-20240807   clang-18
i386                  randconfig-006-20240806   clang-18
i386                  randconfig-006-20240806   gcc-11
i386                  randconfig-006-20240807   clang-18
i386                  randconfig-011-20240806   clang-18
i386                  randconfig-011-20240806   gcc-11
i386                  randconfig-011-20240807   clang-18
i386                  randconfig-012-20240806   gcc-11
i386                  randconfig-012-20240806   gcc-12
i386                  randconfig-012-20240807   clang-18
i386                  randconfig-013-20240806   clang-18
i386                  randconfig-013-20240806   gcc-11
i386                  randconfig-013-20240807   clang-18
i386                  randconfig-014-20240806   clang-18
i386                  randconfig-014-20240806   gcc-11
i386                  randconfig-014-20240807   clang-18
i386                  randconfig-015-20240806   clang-18
i386                  randconfig-015-20240806   gcc-11
i386                  randconfig-015-20240807   clang-18
i386                  randconfig-016-20240806   clang-18
i386                  randconfig-016-20240806   gcc-11
i386                  randconfig-016-20240807   clang-18
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-13.2.0
loongarch                 loongson3_defconfig   gcc-13.2.0
loongarch             randconfig-001-20240806   gcc-13.2.0
loongarch             randconfig-001-20240806   gcc-14.1.0
loongarch             randconfig-001-20240807   gcc-13.2.0
loongarch             randconfig-002-20240806   gcc-13.2.0
loongarch             randconfig-002-20240806   gcc-14.1.0
loongarch             randconfig-002-20240807   gcc-13.2.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
m68k                        stmark2_defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-14.1.0
mips                          eyeq5_defconfig   gcc-14.1.0
mips                          eyeq6_defconfig   gcc-13.2.0
mips                           gcw0_defconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240806   gcc-13.2.0
nios2                 randconfig-001-20240806   gcc-14.1.0
nios2                 randconfig-001-20240807   gcc-13.2.0
nios2                 randconfig-002-20240806   gcc-13.2.0
nios2                 randconfig-002-20240806   gcc-14.1.0
nios2                 randconfig-002-20240807   gcc-13.2.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                generic-64bit_defconfig   gcc-13.2.0
parisc                randconfig-001-20240806   gcc-13.2.0
parisc                randconfig-001-20240806   gcc-14.1.0
parisc                randconfig-001-20240807   gcc-13.2.0
parisc                randconfig-002-20240806   gcc-13.2.0
parisc                randconfig-002-20240806   gcc-14.1.0
parisc                randconfig-002-20240807   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   gcc-14.1.0
powerpc                     asp8347_defconfig   gcc-13.2.0
powerpc                   bluestone_defconfig   gcc-14.1.0
powerpc                       ebony_defconfig   gcc-13.2.0
powerpc                       eiger_defconfig   gcc-14.1.0
powerpc                     mpc5200_defconfig   gcc-14.1.0
powerpc               randconfig-001-20240806   gcc-13.2.0
powerpc               randconfig-001-20240806   gcc-14.1.0
powerpc               randconfig-001-20240807   gcc-13.2.0
powerpc               randconfig-003-20240806   clang-20
powerpc               randconfig-003-20240806   gcc-13.2.0
powerpc               randconfig-003-20240807   gcc-13.2.0
powerpc64             randconfig-001-20240806   gcc-13.2.0
powerpc64             randconfig-001-20240806   gcc-14.1.0
powerpc64             randconfig-001-20240807   gcc-13.2.0
powerpc64             randconfig-002-20240806   clang-16
powerpc64             randconfig-002-20240806   gcc-13.2.0
powerpc64             randconfig-002-20240807   gcc-13.2.0
powerpc64             randconfig-003-20240806   gcc-13.2.0
powerpc64             randconfig-003-20240807   gcc-13.2.0
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-14.1.0
riscv                 randconfig-001-20240806   gcc-13.2.0
riscv                 randconfig-001-20240806   gcc-14.1.0
riscv                 randconfig-001-20240807   gcc-13.2.0
riscv                 randconfig-002-20240806   clang-20
riscv                 randconfig-002-20240806   gcc-13.2.0
riscv                 randconfig-002-20240807   gcc-13.2.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240806   clang-20
s390                  randconfig-001-20240806   gcc-13.2.0
s390                  randconfig-001-20240807   gcc-13.2.0
s390                  randconfig-002-20240806   clang-20
s390                  randconfig-002-20240806   gcc-13.2.0
s390                  randconfig-002-20240807   gcc-13.2.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                         ap325rxa_defconfig   gcc-13.2.0
sh                                  defconfig   gcc-14.1.0
sh                               j2_defconfig   gcc-13.2.0
sh                     magicpanelr2_defconfig   gcc-14.1.0
sh                    randconfig-001-20240806   gcc-13.2.0
sh                    randconfig-001-20240806   gcc-14.1.0
sh                    randconfig-001-20240807   gcc-13.2.0
sh                    randconfig-002-20240806   gcc-13.2.0
sh                    randconfig-002-20240806   gcc-14.1.0
sh                    randconfig-002-20240807   gcc-13.2.0
sh                          rsk7269_defconfig   gcc-13.2.0
sh                          sdk7786_defconfig   gcc-14.1.0
sh                           se7705_defconfig   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240806   gcc-13.2.0
sparc64               randconfig-001-20240806   gcc-14.1.0
sparc64               randconfig-001-20240807   gcc-13.2.0
sparc64               randconfig-002-20240806   gcc-13.2.0
sparc64               randconfig-002-20240806   gcc-14.1.0
sparc64               randconfig-002-20240807   gcc-13.2.0
um                               allmodconfig   clang-20
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-12
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240806   clang-20
um                    randconfig-001-20240806   gcc-13.2.0
um                    randconfig-001-20240807   gcc-13.2.0
um                    randconfig-002-20240806   gcc-12
um                    randconfig-002-20240806   gcc-13.2.0
um                    randconfig-002-20240807   gcc-13.2.0
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240806   clang-18
x86_64       buildonly-randconfig-002-20240806   clang-18
x86_64       buildonly-randconfig-003-20240806   clang-18
x86_64       buildonly-randconfig-004-20240806   clang-18
x86_64       buildonly-randconfig-005-20240806   clang-18
x86_64       buildonly-randconfig-006-20240806   clang-18
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-11
x86_64                randconfig-001-20240806   clang-18
x86_64                randconfig-002-20240806   clang-18
x86_64                randconfig-003-20240806   clang-18
x86_64                randconfig-004-20240806   clang-18
x86_64                randconfig-005-20240806   clang-18
x86_64                randconfig-006-20240806   clang-18
x86_64                randconfig-011-20240806   clang-18
x86_64                randconfig-012-20240806   clang-18
x86_64                randconfig-013-20240806   clang-18
x86_64                randconfig-014-20240806   clang-18
x86_64                randconfig-015-20240806   clang-18
x86_64                randconfig-016-20240806   clang-18
x86_64                randconfig-071-20240806   clang-18
x86_64                randconfig-072-20240806   clang-18
x86_64                randconfig-073-20240806   clang-18
x86_64                randconfig-074-20240806   clang-18
x86_64                randconfig-075-20240806   clang-18
x86_64                randconfig-076-20240806   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                            allnoconfig   gcc-14.1.0
xtensa                  cadence_csp_defconfig   gcc-14.1.0
xtensa                randconfig-001-20240806   gcc-13.2.0
xtensa                randconfig-001-20240806   gcc-14.1.0
xtensa                randconfig-001-20240807   gcc-13.2.0
xtensa                randconfig-002-20240806   gcc-13.2.0
xtensa                randconfig-002-20240806   gcc-14.1.0
xtensa                randconfig-002-20240807   gcc-13.2.0
xtensa                    smp_lx200_defconfig   gcc-13.2.0
xtensa                         virt_defconfig   gcc-13.2.0
xtensa                         virt_defconfig   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

