Return-Path: <linux-kernel+bounces-386440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E7D9B4387
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 08:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A46D228329A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 07:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17CD202F71;
	Tue, 29 Oct 2024 07:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MxvYKJqA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C432010F4
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 07:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730188252; cv=none; b=DpoBMrr1r3Wl0l4sgh3Wq9d3Gz9xS9BYz+Nt0fp+n/CT7NbitihoS+P3Un0a/1oU4EBNe3MCjw+qT7sKZVvb59vSq5eP5RcbYLoPhuhDov/WQc8843YAIRavbTLkQYssqSftq/951lgCRYNiHKKNEA9QpY7q14kwhqhKUw5fTJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730188252; c=relaxed/simple;
	bh=dNoHJ/zCXlLkAsXqPOLaTDOU7Wc/OLrqJFQgjDsv7V0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=gViUOWHDa4nvqZzYpI1zWJBUjyXB6sim4ATgJWc2rnHGGgUvZJRfnQhORd2oSpkZbN3yluM9SvnukNAA4tfWgk81P4bLbg0qLnLmE555Fy1Wo2nHnhlNf3nudIs7+2TwjR3bYxlz5z810XO+7ijIJQvIwMmNs/gmExktwu1NFWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MxvYKJqA; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730188250; x=1761724250;
  h=date:from:to:cc:subject:message-id;
  bh=dNoHJ/zCXlLkAsXqPOLaTDOU7Wc/OLrqJFQgjDsv7V0=;
  b=MxvYKJqAtl2sfSDN4+0uIsad8yYBiJcwBPJl8KdWjCFg5XB/SwZH9azD
   aaYUPPCfCx8HFcvIyu3xY8x19TLFY88U5ch3D8RaUXr0F+N+SuOhJRkJ8
   E1Ue96uTBib3GkRy7nFdXX2aZ+fsSl6KWVZHKvIJTxdI2T8jNa0qCsHfY
   80TU5WXhnGruiAxHG84h93Da1aG3SfLnW5Pao5dnR6mbxvxkODGSDjE2N
   wJcNr/Qafo0CFbGSgtcayXtBui9bg2QmKym/6MkcQpllkhjryVQQWwSSn
   lGECEs83dFuSiSQfhT5Uv0tRkvNAEwckh+hNIUC+/rQRo6hJowGrPW+iu
   w==;
X-CSE-ConnectionGUID: gu8tM3R4Rp+g60Un7Qnh/Q==
X-CSE-MsgGUID: YewTMRGJS5WSweTzIg/j5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11239"; a="29267894"
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="29267894"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 00:50:49 -0700
X-CSE-ConnectionGUID: fi31M8HzTzeGlUqMetjhhw==
X-CSE-MsgGUID: +ulgp7nGQSGLPGpop6C38A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="81946106"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 29 Oct 2024 00:50:48 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t5h02-000dOk-0w;
	Tue, 29 Oct 2024 07:50:46 +0000
Date: Tue, 29 Oct 2024 15:50:13 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:timers/vdso] BUILD REGRESSION
 d4a65302dd849fade9e2ca712826c35b8d068ecb
Message-ID: <202410291506.RSIh1he7-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/vdso
branch HEAD: d4a65302dd849fade9e2ca712826c35b8d068ecb  vdso: Change PAGE_MASK to signed on all 32-bit architectures

Error/Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202410290639.TBG289SO-lkp@intel.com

    include/vdso/page.h:13:25: error: expression in static assertion is not an integer
    include/vdso/page.h:15:39: error: 'CONFIG_PAGE_SHIFT' undeclared here (not in a function); did you mean 'CONFIG_LOG_BUF_SHIFT'?

Error/Warning ids grouped by kconfigs:

recent_errors
`-- m68k-alldefconfig
    |-- include-vdso-page.h:error:CONFIG_PAGE_SHIFT-undeclared-here-(not-in-a-function)
    `-- include-vdso-page.h:error:expression-in-static-assertion-is-not-an-integer

elapsed time: 862m

configs tested: 130
configs skipped: 10

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                                 defconfig    gcc-14.1.0
arc                         haps_hs_defconfig    gcc-14.1.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                         assabet_defconfig    gcc-14.1.0
arm                                 defconfig    gcc-14.1.0
arm                            hisi_defconfig    gcc-14.1.0
arm                          moxart_defconfig    clang-14
arm                       netwinder_defconfig    gcc-14.1.0
arm                           omap1_defconfig    clang-14
arm                         vf610m4_defconfig    gcc-14.1.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
i386                             allmodconfig    clang-19
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-19
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-19
i386                             allyesconfig    gcc-12
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                      maltaaprp_defconfig    clang-14
mips                        omega2p_defconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
openrisc                  or1klitex_defconfig    gcc-14.1.0
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc64                            defconfig    gcc-14.1.0
powerpc                    adder875_defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.1.0
powerpc                        cell_defconfig    gcc-14.1.0
powerpc                       holly_defconfig    clang-14
powerpc                       maple_defconfig    clang-14
powerpc                  mpc866_ads_defconfig    gcc-14.1.0
powerpc                  mpc885_ads_defconfig    clang-14
powerpc                       ppc64_defconfig    gcc-14.1.0
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                          debug_defconfig    clang-14
s390                                defconfig    gcc-12
s390                                defconfig    gcc-14.1.0
s390                       zfcpdump_defconfig    clang-14
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                 kfr2r09-romimage_defconfig    clang-14
sh                             sh03_defconfig    clang-14
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
um                               alldefconfig    clang-14
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241029    clang-19
x86_64      buildonly-randconfig-002-20241029    clang-19
x86_64      buildonly-randconfig-003-20241029    clang-19
x86_64      buildonly-randconfig-004-20241029    clang-19
x86_64      buildonly-randconfig-005-20241029    clang-19
x86_64      buildonly-randconfig-006-20241029    clang-19
x86_64                              defconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20241029    clang-19
x86_64                randconfig-002-20241029    clang-19
x86_64                randconfig-003-20241029    clang-19
x86_64                randconfig-004-20241029    clang-19
x86_64                randconfig-005-20241029    clang-19
x86_64                randconfig-006-20241029    clang-19
x86_64                randconfig-011-20241029    clang-19
x86_64                randconfig-012-20241029    clang-19
x86_64                randconfig-013-20241029    clang-19
x86_64                randconfig-014-20241029    clang-19
x86_64                randconfig-015-20241029    clang-19
x86_64                randconfig-016-20241029    clang-19
x86_64                randconfig-071-20241029    clang-19
x86_64                randconfig-072-20241029    clang-19
x86_64                randconfig-073-20241029    clang-19
x86_64                randconfig-074-20241029    clang-19
x86_64                randconfig-075-20241029    clang-19
x86_64                randconfig-076-20241029    clang-19
x86_64                               rhel-8.3    gcc-12
xtensa                            allnoconfig    gcc-14.1.0
xtensa                  audio_kc705_defconfig    gcc-14.1.0
xtensa                       common_defconfig    clang-14
xtensa                    xip_kc705_defconfig    clang-14

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

