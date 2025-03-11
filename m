Return-Path: <linux-kernel+bounces-556821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0675CA5CF1C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 20:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 910FA189E5CA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A2D262818;
	Tue, 11 Mar 2025 19:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WHlZlSNS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A581E7C0E
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 19:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741720614; cv=none; b=oarn0XrKBjqiiaShsm4Jasn6KdQ2X619J1uDUk1tNhCxc0vm5pxUs3dJXpor8pks0xSE4KVYoCVd0ODwn9yuA0whUi/mNm5eKsedAOnYD4r7goRZO1zyMgH+Ln0qVRfSy8Kq13rCTTzS5Nn/1fCN+6aD3WpdS13/19czC5zUJkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741720614; c=relaxed/simple;
	bh=dgcN0MeNPHXI0mmgdzb3n3xcd2GuWUIVEKXL+P0iupk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Ve34DjwEYqScxVE0zEvLe/vnYEXaFPjGA71titRTEGKcmBE1yb6/je4SOXCf3NANzDes+tyrSxRBAH+hnRTleRJZqfDCbO33FQr7j5zG+bRHNEibvthw4h4xunGL0MWHdcF9w/dIz4J6O0k1YL9LHJxtRiFDV5SiCRTHpNED6Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WHlZlSNS; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741720613; x=1773256613;
  h=date:from:to:cc:subject:message-id;
  bh=dgcN0MeNPHXI0mmgdzb3n3xcd2GuWUIVEKXL+P0iupk=;
  b=WHlZlSNSjzyj0oQflYvbQEzXTTR+G/6GMerMXiOKKDCNu1Urp8wlrM2c
   4My4MsIUTNAG86gXfkhi5xnWt1uCzmgmBjoX8R0Fi3BlbHwhVuPYeuSnd
   Bt53dbuDf/+l7x/eeoTQgyuNPHcns5xFalOI7QRHy7WfmDfAvUSvwOiOU
   u0bUA1d2ST2Vd/NWeO3Kk8oz6dHr25GMFLyJL4HfP09styN4Io5nITgO/
   ImHSba3FCA/eLpghpGv6UU/0XMz9ilfIgs4X3RYO+8IqRL5O1luNxS/cP
   F5myDbYWDMpzowmygZRzPD7Yq3LhbNsxjomEKeClCHGT5NKg/gt8SMAEy
   A==;
X-CSE-ConnectionGUID: 8i3++vCKR6C7zUioQ41hpg==
X-CSE-MsgGUID: ft6feX2CSxGCvEhRzl4PPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="53404561"
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; 
   d="scan'208";a="53404561"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 12:16:50 -0700
X-CSE-ConnectionGUID: XStq8UCzS/eKq1+rp3O9+g==
X-CSE-MsgGUID: snVtPzcJTWWmtzm4fXpEXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; 
   d="scan'208";a="157610084"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 11 Mar 2025 12:16:49 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ts55q-0007lu-2c;
	Tue, 11 Mar 2025 19:16:46 +0000
Date: Wed, 12 Mar 2025 03:15:53 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:core/urgent] BUILD SUCCESS
 366fef794bd2b7c2e9df933f6828dd9739bfba84
Message-ID: <202503120347.WtbpqUOO-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core/urgent
branch HEAD: 366fef794bd2b7c2e9df933f6828dd9739bfba84  <linux/cleanup.h>: Allow the passing of both iomem and non-iomem pointers to no_free_ptr()

elapsed time: 1450m

configs tested: 149
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250311    gcc-13.2.0
arc                   randconfig-001-20250312    clang-21
arc                   randconfig-002-20250311    gcc-13.2.0
arc                   randconfig-002-20250312    clang-21
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    gcc-14.2.0
arm                   randconfig-001-20250311    gcc-14.2.0
arm                   randconfig-001-20250312    clang-21
arm                   randconfig-002-20250311    clang-16
arm                   randconfig-002-20250312    clang-21
arm                   randconfig-003-20250311    gcc-14.2.0
arm                   randconfig-003-20250312    clang-21
arm                   randconfig-004-20250311    gcc-14.2.0
arm                   randconfig-004-20250312    clang-21
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250311    gcc-14.2.0
arm64                 randconfig-001-20250312    clang-21
arm64                 randconfig-002-20250311    gcc-14.2.0
arm64                 randconfig-002-20250312    clang-21
arm64                 randconfig-003-20250311    gcc-14.2.0
arm64                 randconfig-003-20250312    clang-21
arm64                 randconfig-004-20250311    gcc-14.2.0
arm64                 randconfig-004-20250312    clang-21
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250311    gcc-14.2.0
csky                  randconfig-002-20250311    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250311    clang-21
hexagon               randconfig-002-20250311    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250311    gcc-12
i386        buildonly-randconfig-001-20250312    gcc-12
i386        buildonly-randconfig-002-20250311    clang-19
i386        buildonly-randconfig-002-20250312    gcc-12
i386        buildonly-randconfig-003-20250311    clang-19
i386        buildonly-randconfig-003-20250312    gcc-12
i386        buildonly-randconfig-004-20250311    clang-19
i386        buildonly-randconfig-004-20250312    gcc-12
i386        buildonly-randconfig-005-20250311    clang-19
i386        buildonly-randconfig-005-20250312    gcc-12
i386        buildonly-randconfig-006-20250311    gcc-11
i386        buildonly-randconfig-006-20250312    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-011-20250312    gcc-11
i386                  randconfig-012-20250312    gcc-11
i386                  randconfig-013-20250312    gcc-11
i386                  randconfig-014-20250312    gcc-11
i386                  randconfig-015-20250312    gcc-11
i386                  randconfig-016-20250312    gcc-11
i386                  randconfig-017-20250312    gcc-11
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250311    gcc-14.2.0
loongarch             randconfig-002-20250311    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                           ip28_defconfig    gcc-14.2.0
nios2                         10m50_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250311    gcc-14.2.0
nios2                 randconfig-002-20250311    gcc-14.2.0
openrisc                          allnoconfig    clang-15
openrisc                          allnoconfig    gcc-14.2.0
parisc                            allnoconfig    clang-15
parisc                            allnoconfig    gcc-14.2.0
parisc                randconfig-001-20250311    gcc-14.2.0
parisc                randconfig-002-20250311    gcc-14.2.0
powerpc                           allnoconfig    clang-15
powerpc                           allnoconfig    gcc-14.2.0
powerpc                        fsp2_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250311    clang-21
powerpc               randconfig-002-20250311    clang-16
powerpc               randconfig-003-20250311    gcc-14.2.0
powerpc64             randconfig-001-20250311    gcc-14.2.0
powerpc64             randconfig-002-20250311    clang-18
powerpc64             randconfig-003-20250311    gcc-14.2.0
riscv                             allnoconfig    clang-15
riscv                             allnoconfig    gcc-14.2.0
riscv                 randconfig-001-20250311    gcc-14.2.0
riscv                 randconfig-001-20250312    gcc-14.2.0
riscv                 randconfig-002-20250311    gcc-14.2.0
riscv                 randconfig-002-20250312    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250311    clang-15
s390                  randconfig-001-20250312    gcc-14.2.0
s390                  randconfig-002-20250311    gcc-14.2.0
s390                  randconfig-002-20250312    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                          r7780mp_defconfig    gcc-14.2.0
sh                    randconfig-001-20250311    gcc-14.2.0
sh                    randconfig-001-20250312    gcc-14.2.0
sh                    randconfig-002-20250311    gcc-14.2.0
sh                    randconfig-002-20250312    gcc-14.2.0
sh                            shmin_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250311    gcc-14.2.0
sparc                 randconfig-001-20250312    gcc-14.2.0
sparc                 randconfig-002-20250311    gcc-14.2.0
sparc                 randconfig-002-20250312    gcc-14.2.0
sparc                       sparc32_defconfig    gcc-14.2.0
sparc64               randconfig-001-20250311    gcc-14.2.0
sparc64               randconfig-001-20250312    gcc-14.2.0
sparc64               randconfig-002-20250311    gcc-14.2.0
sparc64               randconfig-002-20250312    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-15
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                    randconfig-001-20250311    gcc-12
um                    randconfig-001-20250312    gcc-14.2.0
um                    randconfig-002-20250311    gcc-12
um                    randconfig-002-20250312    gcc-14.2.0
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250311    gcc-12
x86_64      buildonly-randconfig-001-20250312    gcc-12
x86_64      buildonly-randconfig-002-20250311    gcc-12
x86_64      buildonly-randconfig-002-20250312    gcc-12
x86_64      buildonly-randconfig-003-20250311    clang-19
x86_64      buildonly-randconfig-003-20250312    gcc-12
x86_64      buildonly-randconfig-004-20250311    clang-19
x86_64      buildonly-randconfig-004-20250312    gcc-12
x86_64      buildonly-randconfig-005-20250311    gcc-12
x86_64      buildonly-randconfig-005-20250312    gcc-12
x86_64      buildonly-randconfig-006-20250311    gcc-12
x86_64      buildonly-randconfig-006-20250312    gcc-12
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                               rhel-9.4    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250311    gcc-14.2.0
xtensa                randconfig-001-20250312    gcc-14.2.0
xtensa                randconfig-002-20250311    gcc-14.2.0
xtensa                randconfig-002-20250312    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

