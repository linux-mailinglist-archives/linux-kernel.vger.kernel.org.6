Return-Path: <linux-kernel+bounces-408555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A02DF9C8063
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 03:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FA61283E3C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 02:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36971E571D;
	Thu, 14 Nov 2024 02:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AjNIZASb"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634BC17C20F
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 02:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731550114; cv=none; b=mF6fqE9+5bBmi/L2FMKauBGQ0QpumuRKovZMOjt41A3chAHmem2ivxOjHjhBEJOOr4ggKTaVZHVxVRdeXxvW2qZhEZBkB9CNKXHihtr6ImPcbdqYDPQYnBtnycMlrH3vvejGdKr0DkENCH0OHPTaapFJT0cA0m7tKpucHBL2tRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731550114; c=relaxed/simple;
	bh=P7Z7TiVEn9uxuwG+cTTx/SaZEo8X//Q57to6OeZtqsg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=nVEJzB6P4ni3LkLvShEiqckD4i0Vvdei/Z3azFwW1cndC0nY0TfFPuacoo1c/ATdbDwJvH2ARi3ZlKv5WEp1FCPDqJe7gKmf59afPmWW/VnouIxepWsuAU7WWyWaG3x6mohdwAXD2rdMEcM2Z9D3QW6zf4idVZ7o/wEJvZ/ITGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AjNIZASb; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731550113; x=1763086113;
  h=date:from:to:cc:subject:message-id;
  bh=P7Z7TiVEn9uxuwG+cTTx/SaZEo8X//Q57to6OeZtqsg=;
  b=AjNIZASbLUzG6a7lQ6GKPh5trzGPK2RxTjCyDACgoAKVtSbFdTNN/fpE
   v0YODQI0ASTrNUjKiSM0N+UHcPg3wYErJ/vYeJxlP8jdtTdDSWNY3L3iz
   jlt7rWblNIdwfHiz9lFr9v5dOO9VljUU+R/QV2n21YHRnNWuonCRFp8fz
   qlEcV/C3vYZbDnStzfUm9C7hl50v7qANvVR7M6xtIwY3Nod3Y4CaQiwhO
   VVTifqH4xO5J2WkE2xbxxkBNRPj09vFSXW6Za+Ojcs0OAXbj4Y9vs5MIp
   7cX8vb/2SxXVlZGvXBksX/6zCEF0b5lQDHSOgadZFVQVLxtqaOepCM9tY
   w==;
X-CSE-ConnectionGUID: 0shjXFXJTFSXZZgvbnfEQQ==
X-CSE-MsgGUID: jKnoAd+9Qsm5wBsQ5QfoMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11255"; a="31575455"
X-IronPort-AV: E=Sophos;i="6.12,152,1728975600"; 
   d="scan'208";a="31575455"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 18:08:32 -0800
X-CSE-ConnectionGUID: Zb21kEoITZmmsvfFVPcung==
X-CSE-MsgGUID: D71ed+fhQmS8sa6sTyuo1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,152,1728975600"; 
   d="scan'208";a="111369118"
Received: from lkp-server01.sh.intel.com (HELO b014a344d658) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 13 Nov 2024 18:08:31 -0800
Received: from kbuild by b014a344d658 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tBPHY-00002W-1D;
	Thu, 14 Nov 2024 02:08:28 +0000
Date: Thu, 14 Nov 2024 10:08:24 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 5283b49a869ba4d60e8b7fc4d353955512404bec
Message-ID: <202411141016.e7w6xdCQ-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 5283b49a869ba4d60e8b7fc4d353955512404bec  Merge branch into tip/master: 'x86/tdx'

elapsed time: 924m

configs tested: 192
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-20
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-20
arc                              allyesconfig    gcc-13.2.0
arc                      axs103_smp_defconfig    gcc-13.2.0
arc                                 defconfig    gcc-14.2.0
arc                            hsdk_defconfig    gcc-13.2.0
arc                   randconfig-001-20241114    clang-14
arc                   randconfig-002-20241114    clang-14
arc                        vdk_hs38_defconfig    gcc-14.2.0
arm                              alldefconfig    gcc-13.2.0
arm                              alldefconfig    gcc-14.2.0
arm                              allmodconfig    clang-20
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-20
arm                              allyesconfig    gcc-14.2.0
arm                                 defconfig    gcc-14.2.0
arm                            dove_defconfig    gcc-14.2.0
arm                          gemini_defconfig    gcc-13.2.0
arm                   randconfig-001-20241114    clang-14
arm                   randconfig-002-20241114    clang-14
arm                   randconfig-003-20241114    clang-14
arm                   randconfig-004-20241114    clang-14
arm                           sama5_defconfig    gcc-13.2.0
arm                         socfpga_defconfig    gcc-14.2.0
arm                        spear6xx_defconfig    gcc-13.2.0
arm                           sunxi_defconfig    gcc-13.2.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20241114    clang-14
arm64                 randconfig-002-20241114    clang-14
arm64                 randconfig-003-20241114    clang-14
arm64                 randconfig-004-20241114    clang-14
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20241114    clang-14
csky                  randconfig-002-20241114    clang-14
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20241114    clang-14
hexagon               randconfig-002-20241114    clang-14
i386                             allmodconfig    clang-19
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-19
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-19
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241114    clang-19
i386        buildonly-randconfig-002-20241114    clang-19
i386        buildonly-randconfig-002-20241114    gcc-11
i386        buildonly-randconfig-003-20241114    clang-19
i386        buildonly-randconfig-003-20241114    gcc-12
i386        buildonly-randconfig-004-20241114    clang-19
i386        buildonly-randconfig-004-20241114    gcc-12
i386        buildonly-randconfig-005-20241114    clang-19
i386        buildonly-randconfig-005-20241114    gcc-12
i386        buildonly-randconfig-006-20241114    clang-19
i386                                defconfig    clang-19
i386                  randconfig-001-20241114    clang-19
i386                  randconfig-001-20241114    gcc-12
i386                  randconfig-002-20241114    clang-19
i386                  randconfig-002-20241114    gcc-12
i386                  randconfig-003-20241114    clang-19
i386                  randconfig-004-20241114    clang-19
i386                  randconfig-004-20241114    gcc-12
i386                  randconfig-005-20241114    clang-19
i386                  randconfig-006-20241114    clang-19
i386                  randconfig-011-20241114    clang-19
i386                  randconfig-012-20241114    clang-19
i386                  randconfig-012-20241114    gcc-12
i386                  randconfig-013-20241114    clang-19
i386                  randconfig-014-20241114    clang-19
i386                  randconfig-015-20241114    clang-19
i386                  randconfig-015-20241114    gcc-12
i386                  randconfig-016-20241114    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20241114    clang-14
loongarch             randconfig-002-20241114    clang-14
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                        m5272c3_defconfig    gcc-14.2.0
m68k                        m5307c3_defconfig    gcc-14.2.0
m68k                            q40_defconfig    gcc-14.2.0
m68k                           virt_defconfig    gcc-13.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                      bmips_stb_defconfig    gcc-14.2.0
mips                           ip27_defconfig    gcc-13.2.0
mips                     loongson1b_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20241114    clang-14
nios2                 randconfig-002-20241114    clang-14
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
openrisc                  or1klitex_defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20241114    clang-14
parisc                randconfig-002-20241114    clang-14
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-20
powerpc                          allyesconfig    gcc-14.2.0
powerpc                      bamboo_defconfig    gcc-13.2.0
powerpc                        cell_defconfig    gcc-14.2.0
powerpc                       ebony_defconfig    gcc-14.2.0
powerpc                 linkstation_defconfig    gcc-13.2.0
powerpc                   lite5200b_defconfig    gcc-13.2.0
powerpc                 mpc832x_rdb_defconfig    gcc-13.2.0
powerpc               mpc834x_itxgp_defconfig    gcc-13.2.0
powerpc                     mpc83xx_defconfig    gcc-14.2.0
powerpc               randconfig-001-20241114    clang-14
powerpc               randconfig-002-20241114    clang-14
powerpc               randconfig-003-20241114    clang-14
powerpc                    socrates_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20241114    clang-14
powerpc64             randconfig-002-20241114    clang-14
riscv                            allmodconfig    clang-20
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20241114    clang-14
riscv                 randconfig-002-20241114    clang-14
s390                             allmodconfig    clang-20
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20241114    clang-14
s390                  randconfig-002-20241114    clang-14
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20241114    clang-14
sh                    randconfig-002-20241114    clang-14
sh                           se7343_defconfig    gcc-13.2.0
sh                           se7721_defconfig    gcc-14.2.0
sh                     sh7710voipgw_defconfig    gcc-13.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20241114    clang-14
sparc64               randconfig-002-20241114    clang-14
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241114    clang-14
um                    randconfig-002-20241114    clang-14
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64                              defconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                                  kexec    gcc-12
x86_64                               rhel-8.3    gcc-12
xtensa                            allnoconfig    gcc-14.2.0
xtensa                generic_kc705_defconfig    gcc-13.2.0
xtensa                          iss_defconfig    gcc-14.2.0
xtensa                randconfig-001-20241114    clang-14
xtensa                randconfig-002-20241114    clang-14

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

