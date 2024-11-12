Return-Path: <linux-kernel+bounces-404986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BEC9C4B65
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 02:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24E161F24D0F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 01:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D16B2038D7;
	Tue, 12 Nov 2024 01:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JuW7RBZI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727701F7559
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 01:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731373212; cv=none; b=FbpGOaI6iTUo6Kvt8Ts71UsuGj6ESB5eBRAAt2OVdMbCEMQ8hYkaT8AL/OrQLgSsasmo3KCrO6h9HDvOkk2R9fKwv9YwG+lTKIB0sfZ32tn8o3j1x7NfDj0Efm1Axs39+qmBF/sanFIS6T+sCaAFaCfKhrWUMgazyMw1PMXUPCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731373212; c=relaxed/simple;
	bh=XleyvQb+XB1syXZn8yxS4d6HaBFOiX/ES65uuxpFid4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=WnLon7rsbUXgg1jr0/18ZesURBOnZl4+4B9txT4lTmAdRTwVzL1pO+ysQ1Tc2WwDiWGemmghvT+Sxnn7hjWYmXzycejEX5Uu6eKNydOnv5ZKGla1WIh2QH2EH1YfHMwhXANWQoX/SducTVZWSMZdVYLmS2AYgXxA94NeTN1qLUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JuW7RBZI; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731373210; x=1762909210;
  h=date:from:to:cc:subject:message-id;
  bh=XleyvQb+XB1syXZn8yxS4d6HaBFOiX/ES65uuxpFid4=;
  b=JuW7RBZIJSyD+g7mrdxdld1DLRG902jYWqbSxooTo5wra1t5znSQIwr7
   qWRkiHQj+BLcTAjF6wseGx15t29nymWWWASjrc30VSP22yk9M+QRsQzT0
   csVgAHfS9+yf7epbogcC8aclZ/3ky7Qm5U98OlH1EJJDkZDCV8pu9CZcb
   7DLVcsZ/o2I8Tey2HkUKBu4Z/NDiTA5AT7MxwKkm5JQB+qN2gRC6RNa6G
   QUjvVFv+TI6tV4STqJOoq+UuP2fVMSzj0AvOulFfM8xgnGMzzJ1HgQobn
   VU/r97bsznCwAiEgrOkDdLENEOyATbVVwbxNIhqrjTb1DbB2oFTSa866A
   A==;
X-CSE-ConnectionGUID: h7P3Jzl1Ra6OAb37K+b6IA==
X-CSE-MsgGUID: lmRIBvfwSVuxqeCRtYiEpA==
X-IronPort-AV: E=McAfee;i="6700,10204,11253"; a="41802181"
X-IronPort-AV: E=Sophos;i="6.12,146,1728975600"; 
   d="scan'208";a="41802181"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2024 17:00:09 -0800
X-CSE-ConnectionGUID: pV1FqDliTq2/NXURXlnvQQ==
X-CSE-MsgGUID: j92w1AmRRVWvBrzGG+eOQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,146,1728975600"; 
   d="scan'208";a="87272452"
Received: from lkp-server01.sh.intel.com (HELO bcfed0da017c) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 11 Nov 2024 17:00:08 -0800
Received: from kbuild by bcfed0da017c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tAfGI-0000JI-1h;
	Tue, 12 Nov 2024 01:00:06 +0000
Date: Tue, 12 Nov 2024 08:59:18 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/platform] BUILD SUCCESS
 90f1b42b179487ee77d182893408cc1c40d50b13
Message-ID: <202411120813.erZzxJgt-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/platform
branch HEAD: 90f1b42b179487ee77d182893408cc1c40d50b13  x86/platform/intel-mid: Replace deprecated PCI functions

elapsed time: 791m

configs tested: 247
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
arc                   randconfig-001-20241111    gcc-14.2.0
arc                   randconfig-001-20241112    gcc-14.2.0
arc                   randconfig-002-20241111    gcc-14.2.0
arc                   randconfig-002-20241112    gcc-14.2.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-20
arm                         assabet_defconfig    gcc-14.2.0
arm                         at91_dt_defconfig    gcc-14.2.0
arm                                 defconfig    gcc-14.2.0
arm                            dove_defconfig    clang-20
arm                            dove_defconfig    gcc-14.2.0
arm                      footbridge_defconfig    gcc-14.2.0
arm                           imxrt_defconfig    gcc-14.2.0
arm                      jornada720_defconfig    clang-20
arm                   milbeaut_m10v_defconfig    gcc-14.2.0
arm                   randconfig-001-20241111    gcc-14.2.0
arm                   randconfig-001-20241112    gcc-14.2.0
arm                   randconfig-002-20241111    gcc-14.2.0
arm                   randconfig-002-20241112    gcc-14.2.0
arm                   randconfig-003-20241111    gcc-14.2.0
arm                   randconfig-003-20241112    gcc-14.2.0
arm                   randconfig-004-20241111    gcc-14.2.0
arm                   randconfig-004-20241112    gcc-14.2.0
arm                           u8500_defconfig    gcc-14.2.0
arm                         vf610m4_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20241111    gcc-14.2.0
arm64                 randconfig-001-20241112    gcc-14.2.0
arm64                 randconfig-002-20241111    gcc-14.2.0
arm64                 randconfig-002-20241112    gcc-14.2.0
arm64                 randconfig-003-20241111    gcc-14.2.0
arm64                 randconfig-003-20241112    gcc-14.2.0
arm64                 randconfig-004-20241111    gcc-14.2.0
arm64                 randconfig-004-20241112    gcc-14.2.0
csky                             alldefconfig    clang-20
csky                             alldefconfig    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20241111    gcc-14.2.0
csky                  randconfig-001-20241112    gcc-14.2.0
csky                  randconfig-002-20241111    gcc-14.2.0
csky                  randconfig-002-20241112    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20241111    gcc-14.2.0
hexagon               randconfig-001-20241112    gcc-14.2.0
hexagon               randconfig-002-20241111    gcc-14.2.0
hexagon               randconfig-002-20241112    gcc-14.2.0
i386                             allmodconfig    clang-19
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-19
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-19
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241111    gcc-11
i386        buildonly-randconfig-001-20241112    clang-19
i386        buildonly-randconfig-002-20241111    gcc-11
i386        buildonly-randconfig-002-20241112    clang-19
i386        buildonly-randconfig-003-20241111    gcc-11
i386        buildonly-randconfig-003-20241112    clang-19
i386        buildonly-randconfig-004-20241111    gcc-11
i386        buildonly-randconfig-004-20241112    clang-19
i386        buildonly-randconfig-005-20241111    gcc-11
i386        buildonly-randconfig-005-20241112    clang-19
i386        buildonly-randconfig-006-20241111    gcc-11
i386        buildonly-randconfig-006-20241112    clang-19
i386                                defconfig    clang-19
i386                  randconfig-001-20241111    gcc-11
i386                  randconfig-001-20241112    clang-19
i386                  randconfig-002-20241111    gcc-11
i386                  randconfig-002-20241112    clang-19
i386                  randconfig-003-20241111    gcc-11
i386                  randconfig-003-20241112    clang-19
i386                  randconfig-004-20241111    gcc-11
i386                  randconfig-004-20241112    clang-19
i386                  randconfig-005-20241111    gcc-11
i386                  randconfig-005-20241112    clang-19
i386                  randconfig-006-20241111    gcc-11
i386                  randconfig-006-20241112    clang-19
i386                  randconfig-011-20241111    gcc-11
i386                  randconfig-011-20241112    clang-19
i386                  randconfig-012-20241111    gcc-11
i386                  randconfig-012-20241112    clang-19
i386                  randconfig-013-20241111    gcc-11
i386                  randconfig-013-20241112    clang-19
i386                  randconfig-014-20241111    gcc-11
i386                  randconfig-014-20241112    clang-19
i386                  randconfig-015-20241111    gcc-11
i386                  randconfig-015-20241112    clang-19
i386                  randconfig-016-20241111    gcc-11
i386                  randconfig-016-20241112    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20241111    gcc-14.2.0
loongarch             randconfig-001-20241112    gcc-14.2.0
loongarch             randconfig-002-20241111    gcc-14.2.0
loongarch             randconfig-002-20241112    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                          amiga_defconfig    clang-20
m68k                                defconfig    gcc-14.2.0
m68k                            mac_defconfig    gcc-14.2.0
m68k                        mvme16x_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                           ip22_defconfig    clang-20
mips                        qi_lb60_defconfig    clang-20
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20241111    gcc-14.2.0
nios2                 randconfig-001-20241112    gcc-14.2.0
nios2                 randconfig-002-20241111    gcc-14.2.0
nios2                 randconfig-002-20241112    gcc-14.2.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20241111    gcc-14.2.0
parisc                randconfig-001-20241112    gcc-14.2.0
parisc                randconfig-002-20241111    gcc-14.2.0
parisc                randconfig-002-20241112    gcc-14.2.0
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.2.0
powerpc                     asp8347_defconfig    clang-20
powerpc               mpc834x_itxgp_defconfig    clang-20
powerpc                 mpc836x_rdk_defconfig    clang-20
powerpc                     mpc83xx_defconfig    clang-20
powerpc                      ppc44x_defconfig    gcc-14.2.0
powerpc                       ppc64_defconfig    clang-20
powerpc               randconfig-001-20241111    gcc-14.2.0
powerpc               randconfig-001-20241112    gcc-14.2.0
powerpc               randconfig-002-20241111    gcc-14.2.0
powerpc               randconfig-002-20241112    gcc-14.2.0
powerpc               randconfig-003-20241111    gcc-14.2.0
powerpc               randconfig-003-20241112    gcc-14.2.0
powerpc                     sequoia_defconfig    clang-20
powerpc                     skiroot_defconfig    gcc-14.2.0
powerpc                         wii_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20241111    gcc-14.2.0
powerpc64             randconfig-001-20241112    gcc-14.2.0
powerpc64             randconfig-002-20241111    gcc-14.2.0
powerpc64             randconfig-002-20241112    gcc-14.2.0
powerpc64             randconfig-003-20241111    gcc-14.2.0
powerpc64             randconfig-003-20241112    gcc-14.2.0
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20241111    gcc-14.2.0
riscv                 randconfig-001-20241112    gcc-14.2.0
riscv                 randconfig-002-20241111    gcc-14.2.0
riscv                 randconfig-002-20241112    gcc-14.2.0
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20241111    gcc-14.2.0
s390                  randconfig-001-20241112    gcc-14.2.0
s390                  randconfig-002-20241111    gcc-14.2.0
s390                  randconfig-002-20241112    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                ecovec24-romimage_defconfig    clang-20
sh                          polaris_defconfig    clang-20
sh                    randconfig-001-20241111    gcc-14.2.0
sh                    randconfig-001-20241112    gcc-14.2.0
sh                    randconfig-002-20241111    gcc-14.2.0
sh                    randconfig-002-20241112    gcc-14.2.0
sh                           se7343_defconfig    clang-20
sh                           se7712_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20241111    gcc-14.2.0
sparc64               randconfig-001-20241112    gcc-14.2.0
sparc64               randconfig-002-20241111    gcc-14.2.0
sparc64               randconfig-002-20241112    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241111    gcc-14.2.0
um                    randconfig-001-20241112    gcc-14.2.0
um                    randconfig-002-20241111    gcc-14.2.0
um                    randconfig-002-20241112    gcc-14.2.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241112    gcc-12
x86_64      buildonly-randconfig-002-20241112    gcc-12
x86_64      buildonly-randconfig-003-20241112    gcc-12
x86_64      buildonly-randconfig-004-20241112    gcc-12
x86_64      buildonly-randconfig-005-20241112    gcc-12
x86_64      buildonly-randconfig-006-20241112    gcc-12
x86_64                              defconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20241112    gcc-12
x86_64                randconfig-002-20241112    gcc-12
x86_64                randconfig-003-20241112    gcc-12
x86_64                randconfig-004-20241112    gcc-12
x86_64                randconfig-005-20241112    gcc-12
x86_64                randconfig-006-20241112    gcc-12
x86_64                randconfig-011-20241112    gcc-12
x86_64                randconfig-012-20241112    gcc-12
x86_64                randconfig-013-20241112    gcc-12
x86_64                randconfig-014-20241112    gcc-12
x86_64                randconfig-015-20241112    gcc-12
x86_64                randconfig-016-20241112    gcc-12
x86_64                randconfig-071-20241112    gcc-12
x86_64                randconfig-072-20241112    gcc-12
x86_64                randconfig-073-20241112    gcc-12
x86_64                randconfig-074-20241112    gcc-12
x86_64                randconfig-075-20241112    gcc-12
x86_64                randconfig-076-20241112    gcc-12
x86_64                               rhel-8.3    gcc-12
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20241111    gcc-14.2.0
xtensa                randconfig-001-20241112    gcc-14.2.0
xtensa                randconfig-002-20241111    gcc-14.2.0
xtensa                randconfig-002-20241112    gcc-14.2.0
xtensa                         virt_defconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

