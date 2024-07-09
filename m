Return-Path: <linux-kernel+bounces-246020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F6D92BCCD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 16:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6453E1F22476
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 14:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A788A18FC6E;
	Tue,  9 Jul 2024 14:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n7E+zSZi"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F164319CCF9
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 14:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720535017; cv=none; b=Fl4a9HjyPpLsGefs2JnsTfsvDB6ZaPvFFfIvYN+wmmTe2E/vfozhppnr1Snc9o9BIEirQaPoHEHCFctHQlvJC36fw7RNWpcXfybsKnzAA/sWlHlR+ibd+prJ6vlCoIQi+ZWrl5OxChx2f2axX97Ad3Ii0URcZW1k/0vCu4qznms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720535017; c=relaxed/simple;
	bh=HYIV1H/v6DQJZTvip56yb3vKIj+Qv5j9yMJj36L5xSw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=RAzQJ6/x6wOttm0l+by53RwuP0nOlBs6IwyYbhgWpVDCNOGUVA/4kXYXFu0hOBbYwWVYr1a4bK/cduzYJ25yb4J7BEBkUq/sGVGpC235xzq/uP+7WLs1XN7DH2CK9xEpwZgyTB2tSmspfclTmrAfYHEVgLC0unnLvr0c8wih3Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n7E+zSZi; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720535016; x=1752071016;
  h=date:from:to:cc:subject:message-id;
  bh=HYIV1H/v6DQJZTvip56yb3vKIj+Qv5j9yMJj36L5xSw=;
  b=n7E+zSZi2yI0YKHshrJniFZtQ5OOSLGZSaz0Imbw/DQPce/ENMvxImHX
   +6adZwpvfGTZKR+Ff8Kss6bwwmQl+PAemUBiinPvT7zvKYKEKftAH2uXt
   7LUHwYbg5ecT63c6hJX1kFXrM23cF8XLH2YR+vG1d+6ISaYKvX184FGwa
   c94fo64Q17CCotDILxhR5ff+ZL+EDnBUTWW5HWzxgE3goruyVcFWpwCOc
   +l9UllTg26GsEcbyAFsMdSH67PzP6lydOHCMxPxa0q65LiorvmTFldT6/
   fGFRqPvI3hg0xNhbNlwsNRHKt0vPT4uOR0H2ZRF8fl3jqHrBGDajNcQsx
   A==;
X-CSE-ConnectionGUID: 3KIi9+6LQF6aJLIaaOsEqA==
X-CSE-MsgGUID: HQJju4TdQVC6x40lLDpTwQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="28397479"
X-IronPort-AV: E=Sophos;i="6.09,195,1716274800"; 
   d="scan'208";a="28397479"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2024 07:23:35 -0700
X-CSE-ConnectionGUID: rmL3mKxhSOiPTyxSw2/eJA==
X-CSE-MsgGUID: 7otL323kRU2xBFCBz9Hfzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,195,1716274800"; 
   d="scan'208";a="47797851"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 09 Jul 2024 07:23:32 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sRBkf-000Wkd-2E;
	Tue, 09 Jul 2024 14:23:29 +0000
Date: Tue, 09 Jul 2024 22:22:40 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 aa9d8caba6e40b0b02a6f2b5f2bd9177cd76cacf
Message-ID: <202407092238.NDktlUKA-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: aa9d8caba6e40b0b02a6f2b5f2bd9177cd76cacf  Merge timers/core into tip/master

elapsed time: 1278m

configs tested: 149
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig   gcc-13.2.0
alpha                             allnoconfig   gcc-13.2.0
alpha                            allyesconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                   randconfig-001-20240709   gcc-13.2.0
arc                   randconfig-002-20240709   gcc-13.2.0
arc                           tb10x_defconfig   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                               allnoconfig   clang-19
arm                              allyesconfig   gcc-13.2.0
arm                      integrator_defconfig   clang-19
arm                   randconfig-001-20240709   gcc-13.2.0
arm                   randconfig-002-20240709   clang-19
arm                   randconfig-003-20240709   clang-19
arm                   randconfig-004-20240709   gcc-13.2.0
arm64                            allmodconfig   clang-19
arm64                             allnoconfig   gcc-13.2.0
arm64                 randconfig-001-20240709   clang-19
arm64                 randconfig-002-20240709   clang-17
arm64                 randconfig-003-20240709   clang-19
arm64                 randconfig-004-20240709   clang-19
csky                              allnoconfig   gcc-13.2.0
csky                  randconfig-001-20240709   gcc-13.2.0
csky                  randconfig-002-20240709   gcc-13.2.0
hexagon                           allnoconfig   clang-19
hexagon                          allyesconfig   clang-19
hexagon               randconfig-001-20240709   clang-19
hexagon               randconfig-002-20240709   clang-19
i386                             allmodconfig   gcc-13
i386                              allnoconfig   gcc-13
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240709   gcc-11
i386         buildonly-randconfig-002-20240709   gcc-13
i386         buildonly-randconfig-003-20240709   clang-18
i386         buildonly-randconfig-004-20240709   clang-18
i386         buildonly-randconfig-005-20240709   clang-18
i386         buildonly-randconfig-006-20240709   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240709   gcc-13
i386                  randconfig-002-20240709   clang-18
i386                  randconfig-003-20240709   gcc-11
i386                  randconfig-004-20240709   gcc-13
i386                  randconfig-005-20240709   gcc-13
i386                  randconfig-006-20240709   gcc-13
i386                  randconfig-011-20240709   clang-18
i386                  randconfig-012-20240709   gcc-13
i386                  randconfig-013-20240709   gcc-12
i386                  randconfig-014-20240709   clang-18
i386                  randconfig-015-20240709   clang-18
i386                  randconfig-016-20240709   gcc-10
loongarch                        allmodconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch             randconfig-001-20240709   gcc-13.2.0
loongarch             randconfig-002-20240709   gcc-13.2.0
m68k                             allmodconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-13.2.0
m68k                       bvme6000_defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                         cobalt_defconfig   gcc-13.2.0
mips                           jazz_defconfig   clang-19
nios2                             allnoconfig   gcc-13.2.0
nios2                 randconfig-001-20240709   gcc-13.2.0
nios2                 randconfig-002-20240709   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                         allyesconfig   gcc-13.2.0
openrisc                    or1ksim_defconfig   gcc-13.2.0
parisc                           allmodconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                           allyesconfig   gcc-13.2.0
parisc                randconfig-001-20240709   gcc-13.2.0
parisc                randconfig-002-20240709   gcc-13.2.0
powerpc                          allmodconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc                          allyesconfig   clang-19
powerpc                     kilauea_defconfig   clang-19
powerpc                      mgcoge_defconfig   clang-19
powerpc                      ppc44x_defconfig   clang-16
powerpc               randconfig-001-20240709   clang-19
powerpc               randconfig-002-20240709   gcc-13.2.0
powerpc               randconfig-003-20240709   clang-15
powerpc64             randconfig-001-20240709   gcc-13.2.0
powerpc64             randconfig-002-20240709   gcc-13.2.0
powerpc64             randconfig-003-20240709   clang-19
riscv                            allmodconfig   clang-19
riscv                             allnoconfig   gcc-13.2.0
riscv                            allyesconfig   clang-19
riscv                 randconfig-001-20240709   clang-17
riscv                 randconfig-002-20240709   gcc-13.2.0
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                             allyesconfig   gcc-13.2.0
s390                  randconfig-001-20240709   gcc-13.2.0
s390                  randconfig-002-20240709   clang-19
sh                               allmodconfig   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                               allyesconfig   gcc-13.2.0
sh                        dreamcast_defconfig   gcc-13.2.0
sh                        edosk7760_defconfig   gcc-13.2.0
sh                            hp6xx_defconfig   gcc-13.2.0
sh                    randconfig-001-20240709   gcc-13.2.0
sh                    randconfig-002-20240709   gcc-13.2.0
sh                          rsk7203_defconfig   gcc-13.2.0
sh                          rsk7269_defconfig   gcc-13.2.0
sh                             shx3_defconfig   gcc-13.2.0
sparc                            allmodconfig   gcc-13.2.0
sparc64               randconfig-001-20240709   gcc-13.2.0
sparc64               randconfig-002-20240709   gcc-13.2.0
um                               allmodconfig   clang-19
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-13
um                    randconfig-001-20240709   gcc-13
um                    randconfig-002-20240709   gcc-11
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240709   gcc-11
x86_64       buildonly-randconfig-002-20240709   clang-18
x86_64       buildonly-randconfig-003-20240709   clang-18
x86_64       buildonly-randconfig-004-20240709   gcc-9
x86_64       buildonly-randconfig-005-20240709   gcc-13
x86_64       buildonly-randconfig-006-20240709   clang-18
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240709   clang-18
x86_64                randconfig-002-20240709   gcc-10
x86_64                randconfig-003-20240709   clang-18
x86_64                randconfig-004-20240709   gcc-12
x86_64                randconfig-005-20240709   gcc-13
x86_64                randconfig-006-20240709   gcc-8
x86_64                randconfig-011-20240709   clang-18
x86_64                randconfig-012-20240709   clang-18
x86_64                randconfig-013-20240709   clang-18
x86_64                randconfig-014-20240709   clang-18
x86_64                randconfig-015-20240709   clang-18
x86_64                randconfig-016-20240709   clang-18
x86_64                randconfig-071-20240709   gcc-7
x86_64                randconfig-072-20240709   clang-18
x86_64                randconfig-073-20240709   gcc-13
x86_64                randconfig-074-20240709   gcc-13
x86_64                randconfig-075-20240709   gcc-11
x86_64                randconfig-076-20240709   gcc-13
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                randconfig-001-20240709   gcc-13.2.0
xtensa                randconfig-002-20240709   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

