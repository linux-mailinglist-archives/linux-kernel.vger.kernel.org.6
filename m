Return-Path: <linux-kernel+bounces-528465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29316A417F6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D6E23B018D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 08:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B906924290E;
	Mon, 24 Feb 2025 08:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T3h69O89"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD25242925
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 08:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740387392; cv=none; b=fIDle1+ZijLsdPDHh9lW1exIeGhihL+pZq1PmLJaFA1EJpHVVQK18m/Ke1KEcjBvIEI92g5TXN7F4d7Hc3cM+mgybLFzQegQZ/iubGtr2JVtHIxlIWrG8r8FK7ZY6GlNGnPunz9PJ+9N/bOhqSP4VnYxyjfmYknNJ5y16y823Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740387392; c=relaxed/simple;
	bh=4D6/VJRcgqAyUc+D/Vf5dvfu736+rhIQdp7DasTXfgY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=vEDqza6q0BimPo4uXHYPjtAgJVW6b49xdEiwy8fzf79R4Y5GIy6xwYrYvvJSjR6hSDkzVfu24yBk1AH4MPDw/5NDYTMzcXp3VW89E8q0jlPo06uw0l8UE92O64jUufPDX7crSXTk4yy/787csf4Ntf7/AcVXMBzlOomcZH6afZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T3h69O89; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740387392; x=1771923392;
  h=date:from:to:cc:subject:message-id;
  bh=4D6/VJRcgqAyUc+D/Vf5dvfu736+rhIQdp7DasTXfgY=;
  b=T3h69O89gZqUSP2Ya+u2GywUciG4f9gwIYLP/FTnDzBBG8MZqJ/ZG1zs
   LX2TV7hm2maMb8e8KZr9HacQvd49TTYroW2j+HIcKsjkuoC6oFGxw/TIm
   ASmTCio6wQ0E51wVKb6KDzv3lapl4ew5RkDrDUgxBYI+6pkRAAHulKN3m
   idrV12QcnOlDBGrtLAXzOBenXoIDDkjfnGWttBqOVljNFEeoyIKqCXIMb
   wxrFzVnxIbr2QTSZ47Vd6/6GADB4soWR46cv8K2JYrDi8NRWETsdmIM0T
   MqX6GRJ5Xu8e913nzeAnNWkeW+klHqXIpr+2GPFWn3FYJ7hkhi0UOA27r
   A==;
X-CSE-ConnectionGUID: pZcbUHd8QOms66G6353FeA==
X-CSE-MsgGUID: wCPwonVtSvOcVQQxvFPhfA==
X-IronPort-AV: E=McAfee;i="6700,10204,11354"; a="44785165"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="44785165"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 00:56:31 -0800
X-CSE-ConnectionGUID: dMnliZoeTd6YhaGPdG++hw==
X-CSE-MsgGUID: m5TjVTMkTX2GOTyKUBybEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="120123739"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 24 Feb 2025 00:56:29 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tmUGJ-00084b-19;
	Mon, 24 Feb 2025 08:56:27 +0000
Date: Mon, 24 Feb 2025 16:56:26 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/asm] BUILD SUCCESS
 dc8bd769e70ecae0916bf1b05acad6120c6bd6f0
Message-ID: <202502241619.0BLq4SAX-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/asm
branch HEAD: dc8bd769e70ecae0916bf1b05acad6120c6bd6f0  x86/ioperm: Use atomic64_inc_return() in ksys_ioperm()

elapsed time: 834m

configs tested: 128
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250224    gcc-13.2.0
arc                   randconfig-002-20250224    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                       aspeed_g4_defconfig    clang-21
arm                     davinci_all_defconfig    clang-21
arm                   randconfig-001-20250224    gcc-14.2.0
arm                   randconfig-002-20250224    gcc-14.2.0
arm                   randconfig-003-20250224    gcc-14.2.0
arm                   randconfig-004-20250224    gcc-14.2.0
arm                             rpc_defconfig    clang-17
arm                       spear13xx_defconfig    gcc-14.2.0
arm                           stm32_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250224    gcc-14.2.0
arm64                 randconfig-002-20250224    clang-21
arm64                 randconfig-003-20250224    gcc-14.2.0
arm64                 randconfig-004-20250224    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250224    gcc-14.2.0
csky                  randconfig-002-20250224    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250224    clang-21
hexagon               randconfig-002-20250224    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250224    clang-19
i386        buildonly-randconfig-002-20250224    gcc-12
i386        buildonly-randconfig-003-20250224    clang-19
i386        buildonly-randconfig-004-20250224    gcc-12
i386        buildonly-randconfig-005-20250224    clang-19
i386        buildonly-randconfig-006-20250224    clang-19
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250224    gcc-14.2.0
loongarch             randconfig-002-20250224    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                           sun3_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                            alldefconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250224    gcc-14.2.0
nios2                 randconfig-002-20250224    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250224    gcc-14.2.0
parisc                randconfig-002-20250224    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                       eiger_defconfig    clang-17
powerpc                 mpc834x_itx_defconfig    clang-21
powerpc               randconfig-001-20250224    gcc-14.2.0
powerpc               randconfig-002-20250224    gcc-14.2.0
powerpc               randconfig-003-20250224    gcc-14.2.0
powerpc                     tqm8548_defconfig    clang-19
powerpc64             randconfig-002-20250224    clang-18
powerpc64             randconfig-003-20250224    gcc-14.2.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-21
riscv                               defconfig    clang-19
riscv                    nommu_virt_defconfig    clang-21
riscv                 randconfig-001-20250224    gcc-14.2.0
riscv                 randconfig-002-20250224    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20250224    gcc-14.2.0
s390                  randconfig-002-20250224    clang-17
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                    randconfig-001-20250224    gcc-14.2.0
sh                    randconfig-002-20250224    gcc-14.2.0
sh                           sh2007_defconfig    gcc-14.2.0
sh                        sh7763rdp_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250224    gcc-14.2.0
sparc                 randconfig-002-20250224    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250224    gcc-14.2.0
sparc64               randconfig-002-20250224    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250224    gcc-12
um                    randconfig-002-20250224    gcc-12
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250224    gcc-11
x86_64      buildonly-randconfig-002-20250224    gcc-12
x86_64      buildonly-randconfig-003-20250224    clang-19
x86_64      buildonly-randconfig-004-20250224    gcc-12
x86_64      buildonly-randconfig-005-20250224    clang-19
x86_64      buildonly-randconfig-006-20250224    clang-19
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                       common_defconfig    gcc-14.2.0
xtensa                randconfig-001-20250224    gcc-14.2.0
xtensa                randconfig-002-20250224    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

