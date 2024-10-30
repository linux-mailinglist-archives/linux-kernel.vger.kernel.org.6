Return-Path: <linux-kernel+bounces-388047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2B99B59CE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 03:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86AB9B228E5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 02:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234BA16F27E;
	Wed, 30 Oct 2024 02:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BzgSMJSg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDA14437
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 02:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730254547; cv=none; b=Z0W4d+Q2TJt7D2WGMacTxyl0aZz5DcI6MNOV45T9Ba7QKSszmEwHSwRpuNW9c+fRd0eSlCoUBVoF2d9JHj8aNqQbWDJZBan0wGJPwQSOhe/b9Bj9iEIHpJPK6h6yYjaAE6cFgNdimK+roxI1BQWr2DJNAVpBptooAGJ/FHw+dp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730254547; c=relaxed/simple;
	bh=o3ZL8s186Xog/DzvsiYYj+uGaAL+MKY8jwpK2cGyEYM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Wx10Zx83Fs2bYxfYv3O6ljSV3hvxjdMZTyQwMS3PItIcbRvYHglKj+uAANcHzkfpB/c5jAJP5pYKX3Dek4pSiYSaryD6UjvWM7D1QRGhjIdlJMtlEJKOz6ByFt7xiIHx+pXe3fJpI3Q3Tvz27m7aMI29OQeVrYlG3lOxJW7uol4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BzgSMJSg; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730254545; x=1761790545;
  h=date:from:to:cc:subject:message-id;
  bh=o3ZL8s186Xog/DzvsiYYj+uGaAL+MKY8jwpK2cGyEYM=;
  b=BzgSMJSgAt9sDv+pPw20XAlUC3i1IAnwRJP8DIn490cdn/6v2vo4mCfv
   2NYgbVuz+NNGlyngKRROVSiJO7xLeyHTWNgvbztsy4cWWew5cfvap3i18
   AglW6zlmYdd5w2ofHnVR069KcnbdP9uSIDUy5WUFQ8C70+ODUMmpe83Lw
   wJh5RpneDGc8G0KAiPoQDhjdk/KvjrGioj2y4g2Y2LxrLEXQJKVEpwIwK
   WFY0aOyO++XVQbpqLl/Jpb4AwOa1OkI5X7DEBpApw3a50sYV/WPUlmk/Y
   an9tEf4QG+ZJVPx5EU36EazjVOm/pijeMt10wqk3NE8jNoUbVAu/cLTcI
   A==;
X-CSE-ConnectionGUID: rNx4GXM3Tna4zn2iEtORmA==
X-CSE-MsgGUID: roSg7KUNSX2SlcyOAwqf5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="33736197"
X-IronPort-AV: E=Sophos;i="6.11,243,1725346800"; 
   d="scan'208";a="33736197"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 19:15:44 -0700
X-CSE-ConnectionGUID: FTLW5tcpQOilJMuHkl8pQw==
X-CSE-MsgGUID: iYXhc/XnQ7uzL0r/0MPFyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,243,1725346800"; 
   d="scan'208";a="87289859"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 29 Oct 2024 19:15:44 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t5yFI-000ePE-2A;
	Wed, 30 Oct 2024 02:15:40 +0000
Date: Wed, 30 Oct 2024 10:14:59 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/sev] BUILD SUCCESS
 3074152e56c9b0f9b9c67edfbc08b371db050b6d
Message-ID: <202410301051.dpAsuIQV-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/sev
branch HEAD: 3074152e56c9b0f9b9c67edfbc08b371db050b6d  x86/sev: Convert shared memory back to private on kexec

elapsed time: 879m

configs tested: 139
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                                 defconfig    gcc-14.1.0
arc                     haps_hs_smp_defconfig    clang-20
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                                 defconfig    gcc-14.1.0
arm                        keystone_defconfig    clang-20
arm                        mvebu_v5_defconfig    clang-20
arm                             rpc_defconfig    clang-20
arm                         s5pv210_defconfig    clang-20
arm                           sama7_defconfig    clang-20
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
i386                              allnoconfig    clang-19
i386                             allyesconfig    clang-19
i386        buildonly-randconfig-001-20241030    gcc-12
i386        buildonly-randconfig-002-20241030    gcc-12
i386        buildonly-randconfig-003-20241030    gcc-12
i386        buildonly-randconfig-004-20241030    gcc-12
i386        buildonly-randconfig-005-20241030    gcc-12
i386        buildonly-randconfig-006-20241030    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20241030    gcc-12
i386                  randconfig-002-20241030    gcc-12
i386                  randconfig-003-20241030    gcc-12
i386                  randconfig-004-20241030    gcc-12
i386                  randconfig-005-20241030    gcc-12
i386                  randconfig-006-20241030    gcc-12
i386                  randconfig-011-20241030    gcc-12
i386                  randconfig-012-20241030    gcc-12
i386                  randconfig-013-20241030    gcc-12
i386                  randconfig-014-20241030    gcc-12
i386                  randconfig-015-20241030    gcc-12
i386                  randconfig-016-20241030    gcc-12
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
mips                          ath79_defconfig    clang-20
mips                        maltaup_defconfig    clang-20
mips                          rb532_defconfig    clang-20
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.1.0
powerpc                       ppc64_defconfig    clang-20
powerpc                     tqm8541_defconfig    clang-20
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
s390                             allmodconfig    clang-20
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
sh                               alldefconfig    clang-20
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                          rsk7264_defconfig    clang-20
sh                  sh7785lcr_32bit_defconfig    clang-20
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241030    gcc-12
x86_64      buildonly-randconfig-002-20241030    gcc-12
x86_64      buildonly-randconfig-003-20241030    gcc-12
x86_64      buildonly-randconfig-004-20241030    gcc-12
x86_64      buildonly-randconfig-005-20241030    gcc-12
x86_64      buildonly-randconfig-006-20241030    gcc-12
x86_64                              defconfig    clang-19
x86_64                                  kexec    clang-19
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20241030    gcc-12
x86_64                randconfig-002-20241030    gcc-12
x86_64                randconfig-003-20241030    gcc-12
x86_64                randconfig-004-20241030    gcc-12
x86_64                randconfig-005-20241030    gcc-12
x86_64                randconfig-006-20241030    gcc-12
x86_64                randconfig-011-20241030    gcc-12
x86_64                randconfig-012-20241030    gcc-12
x86_64                randconfig-013-20241030    gcc-12
x86_64                randconfig-014-20241030    gcc-12
x86_64                randconfig-015-20241030    gcc-12
x86_64                randconfig-016-20241030    gcc-12
x86_64                randconfig-071-20241030    gcc-12
x86_64                randconfig-072-20241030    gcc-12
x86_64                randconfig-073-20241030    gcc-12
x86_64                randconfig-074-20241030    gcc-12
x86_64                randconfig-075-20241030    gcc-12
x86_64                randconfig-076-20241030    gcc-12
x86_64                               rhel-8.3    gcc-12
x86_64                           rhel-8.3-bpf    clang-19
x86_64                         rhel-8.3-kunit    clang-19
x86_64                           rhel-8.3-ltp    clang-19
x86_64                          rhel-8.3-rust    clang-19
xtensa                            allnoconfig    gcc-14.1.0
xtensa                  audio_kc705_defconfig    clang-20
xtensa                  cadence_csp_defconfig    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

