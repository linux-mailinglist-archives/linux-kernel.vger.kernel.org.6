Return-Path: <linux-kernel+bounces-436611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7784E9E8895
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 00:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50E901884E06
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 23:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD24A19067A;
	Sun,  8 Dec 2024 23:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PLc/n0l0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781F41E86E
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 23:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733701309; cv=none; b=DzUohyGDFOAFk9GI1P7a2gO5tT3W0dOjpTPVIgUshHXdovt4GoLemV6YpweBXpwCGSxc2k9VMiq9I334YMPR0q4N6wnLl9WrmsPWcXwygjz6yQTfORH9NKs/ItN4CPOawOyNx6O4rKVnlATktAwQV1SygJEIPVBZt1hyqpIB1wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733701309; c=relaxed/simple;
	bh=7spb/TRfkMy1sdYxNDJpgXRA3wywoeIYT0xXYk+kLIk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=CwJlmeBWxR/mhFlhZQ0kyttASvfW8j4CN9af4ba4RH5epQ6kecoA0H0UHOs3jLR7XpJeP72/ItrniPMf4VWQaki0HaJYzpeonk4JfLXFqqEN2Eran0owRU728zuN0gGewZo++hsyh/ELD9SwnpvFNpBzonqFyNeBNUzoxJIuKZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PLc/n0l0; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733701307; x=1765237307;
  h=date:from:to:cc:subject:message-id;
  bh=7spb/TRfkMy1sdYxNDJpgXRA3wywoeIYT0xXYk+kLIk=;
  b=PLc/n0l03Iya35/23170u+IDfzfUB6xWsRJEtTtOIgFOUIV5B9v+ZzhB
   mULy9pWi1FcABpHVK2xXBlGm6LDjU2aeaFX9vviprgobLsIIohZbmTnzT
   myHpzHfe2ixamyDR8Gt3GhSMoWzgMXkAojo5gfEW3Knk6R4Dg6f433P2u
   +nO/KqhmoDwTScJkxwipHaV2ucUMgxwJ2wCIY7jxxRlHPOaEuiMzVuewo
   Ei+YsEtwx4bmhTsIVmvOUXNA4C7uJ1RgsbTiUmX3G/TXyStds4+BzGuw1
   cdK3KrtHy5DkO1RXTCT84WllnNbNISQGddjwZ0U1kVhMB9j/VVxqa1mYF
   Q==;
X-CSE-ConnectionGUID: Cb+QsZ67S7a3NPxhNsWPvQ==
X-CSE-MsgGUID: 0lda6OWASAaVmHBY5K8YQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11280"; a="44458524"
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="44458524"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2024 15:41:47 -0800
X-CSE-ConnectionGUID: 04mwGccrToumcev21PLeHA==
X-CSE-MsgGUID: Q+qMYUvTQgyBBCusFwq50Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="99858805"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 08 Dec 2024 15:41:45 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tKQuE-0003bF-23;
	Sun, 08 Dec 2024 23:41:42 +0000
Date: Mon, 09 Dec 2024 07:38:28 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 525077ae7145cc868b69282f85bed2be8ecd1ed5
Message-ID: <202412090718.fGkOHNZk-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cleanups
branch HEAD: 525077ae7145cc868b69282f85bed2be8ecd1ed5  x86/ioremap: Remove unused size parameter in remapping functions

elapsed time: 725m

configs tested: 140
configs skipped: 130

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
arc                        nsim_700_defconfig    clang-20
arc                     nsimosci_hs_defconfig    gcc-13.2.0
arc                           tb10x_defconfig    gcc-13.2.0
arc                        vdk_hs38_defconfig    gcc-14.2.0
arm                           h3600_defconfig    gcc-14.2.0
arm                           imxrt_defconfig    gcc-14.2.0
arm                       multi_v4t_defconfig    clang-18
arm                        multi_v5_defconfig    gcc-13.2.0
arm                        shmobile_defconfig    clang-20
arm                       spear13xx_defconfig    gcc-13.2.0
csky                             alldefconfig    gcc-13.2.0
csky                  randconfig-001-20241209    clang-17
csky                  randconfig-002-20241209    clang-17
hexagon               randconfig-001-20241209    clang-17
hexagon               randconfig-002-20241209    clang-17
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241208    gcc-12
i386        buildonly-randconfig-002-20241208    clang-19
i386        buildonly-randconfig-003-20241208    gcc-11
i386        buildonly-randconfig-004-20241208    gcc-12
i386        buildonly-randconfig-005-20241208    clang-19
i386        buildonly-randconfig-006-20241208    clang-19
i386                                defconfig    clang-19
i386                  randconfig-001-20241208    gcc-12
i386                  randconfig-001-20241209    clang-19
i386                  randconfig-002-20241208    gcc-12
i386                  randconfig-002-20241209    clang-19
i386                  randconfig-003-20241208    gcc-12
i386                  randconfig-003-20241209    clang-19
i386                  randconfig-004-20241208    gcc-12
i386                  randconfig-004-20241209    clang-19
i386                  randconfig-005-20241208    gcc-12
i386                  randconfig-005-20241209    clang-19
i386                  randconfig-006-20241208    gcc-12
i386                  randconfig-006-20241209    clang-19
i386                  randconfig-007-20241208    gcc-12
i386                  randconfig-007-20241209    clang-19
i386                  randconfig-011-20241208    clang-19
i386                  randconfig-011-20241209    gcc-12
i386                  randconfig-012-20241208    clang-19
i386                  randconfig-012-20241209    gcc-12
i386                  randconfig-013-20241208    clang-19
i386                  randconfig-013-20241209    gcc-12
i386                  randconfig-014-20241208    clang-19
i386                  randconfig-014-20241209    gcc-12
i386                  randconfig-015-20241208    clang-19
i386                  randconfig-015-20241209    gcc-12
i386                  randconfig-016-20241208    clang-19
i386                  randconfig-016-20241209    gcc-12
i386                  randconfig-017-20241208    clang-19
i386                  randconfig-017-20241209    gcc-12
loongarch                        allmodconfig    gcc-14.2.0
loongarch             randconfig-001-20241209    clang-17
loongarch             randconfig-002-20241209    clang-17
m68k                             allmodconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                       bvme6000_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                      bmips_stb_defconfig    clang-18
mips                           ip28_defconfig    clang-18
mips                           jazz_defconfig    clang-18
mips                        omega2p_defconfig    gcc-14.2.0
nios2                 randconfig-001-20241209    clang-17
nios2                 randconfig-002-20241209    clang-17
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20241209    clang-17
parisc                randconfig-002-20241209    clang-17
powerpc                          allmodconfig    gcc-14.2.0
powerpc                          allyesconfig    gcc-14.2.0
powerpc                     asp8347_defconfig    gcc-13.2.0
powerpc                 canyonlands_defconfig    clang-18
powerpc                      cm5200_defconfig    clang-20
powerpc                      mgcoge_defconfig    clang-18
powerpc               randconfig-001-20241209    clang-17
powerpc               randconfig-002-20241209    clang-17
powerpc               randconfig-003-20241209    clang-17
powerpc                  storcenter_defconfig    gcc-14.2.0
powerpc                     tqm8541_defconfig    gcc-13.2.0
powerpc64             randconfig-001-20241209    clang-17
powerpc64             randconfig-002-20241209    clang-17
powerpc64             randconfig-003-20241209    clang-17
riscv                            allmodconfig    gcc-14.2.0
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
s390                                defconfig    gcc-12
sh                                  defconfig    gcc-12
sh                        dreamcast_defconfig    clang-20
sh                             espt_defconfig    clang-18
sh                     magicpanelr2_defconfig    gcc-14.2.0
sh                          rsk7203_defconfig    clang-20
sh                          rsk7269_defconfig    gcc-14.2.0
sparc                            alldefconfig    clang-18
sparc                       sparc64_defconfig    gcc-13.2.0
sparc64                             defconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241208    gcc-12
x86_64      buildonly-randconfig-002-20241208    clang-19
x86_64      buildonly-randconfig-003-20241208    gcc-12
x86_64      buildonly-randconfig-004-20241208    clang-19
x86_64      buildonly-randconfig-005-20241208    clang-19
x86_64      buildonly-randconfig-006-20241208    gcc-12
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20241208    gcc-12
x86_64                randconfig-001-20241209    gcc-12
x86_64                randconfig-002-20241208    gcc-12
x86_64                randconfig-002-20241209    gcc-12
x86_64                randconfig-003-20241208    gcc-12
x86_64                randconfig-003-20241209    gcc-12
x86_64                randconfig-004-20241208    gcc-12
x86_64                randconfig-004-20241209    gcc-12
x86_64                randconfig-005-20241208    gcc-12
x86_64                randconfig-005-20241209    gcc-12
x86_64                randconfig-006-20241208    gcc-12
x86_64                randconfig-006-20241209    gcc-12
x86_64                randconfig-007-20241208    gcc-12
x86_64                randconfig-007-20241209    gcc-12
x86_64                randconfig-008-20241208    gcc-12
x86_64                randconfig-008-20241209    gcc-12
x86_64                randconfig-071-20241209    gcc-12
x86_64                randconfig-072-20241209    gcc-12
x86_64                randconfig-073-20241209    gcc-12
x86_64                randconfig-074-20241209    gcc-12
x86_64                randconfig-075-20241209    gcc-12
x86_64                randconfig-076-20241209    gcc-12
x86_64                randconfig-077-20241209    gcc-12
x86_64                randconfig-078-20241209    gcc-12
x86_64                               rhel-9.4    clang-19
xtensa                       common_defconfig    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

