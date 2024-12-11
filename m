Return-Path: <linux-kernel+bounces-440627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F729EC1EE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 03:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41F60282C7C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 02:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7241FBC9B;
	Wed, 11 Dec 2024 02:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HM9BcOVF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE266F4FA
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 02:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733882741; cv=none; b=RRfImABPju07gTWOBoTQnoDTuh9Zm3wXsVdvjsOq0G2aFyc4B3OUNhVJaCPM8zb14/aV3kNHWsw6mblXtJK+LY9rO09Tha+p1mw2iLL/r4GZydT4taeap1zvpJUdFNOTHhq6vPDvsCWIIJo2dsCTDVUz3FMiUhMI+CxYnN8S0I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733882741; c=relaxed/simple;
	bh=gVEf9rkct/feJrVvgh5aEH0+FRYrFNc4yb0NEK4NCRI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=DYFqMTAuNH5BklRNXsQ/xzUSvmp/pqnAOgd6KhtsfNSZWozBWvs/RnXh9AliFva35Jtt+L5dTU8G8aNKVixwVI9cv7TVB/uMaYsZrZPFYReTVoqpiHFPIShFOcijCXH6JE//tfF3cUnCvsHCHT8XDYugg4cTqSibun1IKSnHaPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HM9BcOVF; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733882740; x=1765418740;
  h=date:from:to:cc:subject:message-id;
  bh=gVEf9rkct/feJrVvgh5aEH0+FRYrFNc4yb0NEK4NCRI=;
  b=HM9BcOVF+EF7wRMQ0sU3XZfdSBISum2w1nbLrY+McsX7ZSyO2rxr+8xX
   LFnPOzns4dAyt8gPqETwto9DRI+jFIvX2WtcaMu54NV6tI9g/HaVe0AvZ
   UyVWTu+nNpXOWamIX2537xbfFjnfWydNy3G1TzqkTMCKRH4vpSnMu+x2m
   abLBV02DnSanR4SVq82gqz7ITNPTqQ9uhdE8gukQG9mrnnym/EZuB/lhU
   OVoETQW8QKavrpS24H6RyfdALRRBi+pGbsJPsX8TWaPVlq1/D/p6Lo2E8
   qAKv6BoBihxrVSP183ABAqeqxdpdi50TkMAV5RlSyp7Scf12PavWwjvAy
   g==;
X-CSE-ConnectionGUID: 48LOWfhYRxGP+Y9cY2y25w==
X-CSE-MsgGUID: 8FuIVwUNSPGdGyCk/4TwgA==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="34171912"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="34171912"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 18:05:40 -0800
X-CSE-ConnectionGUID: FcRgeqsYQBeLMT+j7OUIYw==
X-CSE-MsgGUID: lVQk0yxhQg6cwaE8rbCGmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118852962"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 10 Dec 2024 18:05:38 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tLC6a-00069O-0J;
	Wed, 11 Dec 2024 02:05:36 +0000
Date: Wed, 11 Dec 2024 10:05:21 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/boot] BUILD SUCCESS
 35aafa1d41cee0d3d50164561bca34befc1d9ce3
Message-ID: <202412111015.PUPhBkBm-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/boot
branch HEAD: 35aafa1d41cee0d3d50164561bca34befc1d9ce3  x86/boot/64: Fix spurious undefined reference when CONFIG_X86_5LEVEL=n, on GCC-12

elapsed time: 888m

configs tested: 117
configs skipped: 146

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
arc                  randconfig-001-20241211    gcc-14.2.0
arc                  randconfig-002-20241211    gcc-14.2.0
arm                       neponset_defconfig    gcc-14.2.0
arm                          omap1_defconfig    gcc-14.2.0
arm                           qcom_defconfig    gcc-14.2.0
arm                  randconfig-001-20241211    gcc-14.2.0
arm                  randconfig-002-20241211    gcc-14.2.0
arm                  randconfig-003-20241211    gcc-14.2.0
arm                  randconfig-004-20241211    gcc-14.2.0
arm                       vexpress_defconfig    gcc-14.2.0
arm64                randconfig-001-20241211    gcc-14.2.0
arm64                randconfig-002-20241211    gcc-14.2.0
arm64                randconfig-003-20241211    gcc-14.2.0
arm64                randconfig-004-20241211    gcc-14.2.0
csky                 randconfig-001-20241211    gcc-14.2.0
csky                 randconfig-002-20241211    gcc-14.2.0
hexagon              randconfig-001-20241211    gcc-14.2.0
hexagon              randconfig-002-20241211    gcc-14.2.0
i386                            allmodconfig    clang-19
i386                             allnoconfig    clang-19
i386                            allyesconfig    clang-19
i386       buildonly-randconfig-001-20241210    gcc-12
i386       buildonly-randconfig-001-20241211    clang-19
i386       buildonly-randconfig-002-20241210    clang-19
i386       buildonly-randconfig-002-20241211    clang-19
i386       buildonly-randconfig-003-20241210    gcc-12
i386       buildonly-randconfig-003-20241211    clang-19
i386       buildonly-randconfig-004-20241210    clang-19
i386       buildonly-randconfig-004-20241211    clang-19
i386       buildonly-randconfig-005-20241210    clang-19
i386       buildonly-randconfig-005-20241211    clang-19
i386       buildonly-randconfig-006-20241210    clang-19
i386       buildonly-randconfig-006-20241211    clang-19
i386                               defconfig    clang-19
i386                 randconfig-001-20241211    gcc-12
i386                 randconfig-002-20241211    gcc-12
i386                 randconfig-003-20241211    gcc-12
i386                 randconfig-004-20241211    gcc-12
i386                 randconfig-005-20241211    gcc-12
i386                 randconfig-006-20241211    gcc-12
i386                 randconfig-007-20241211    gcc-12
i386                 randconfig-011-20241211    gcc-12
i386                 randconfig-012-20241211    gcc-12
i386                 randconfig-013-20241211    gcc-12
i386                 randconfig-014-20241211    gcc-12
i386                 randconfig-015-20241211    gcc-12
i386                 randconfig-016-20241211    gcc-12
i386                 randconfig-017-20241211    gcc-12
loongarch            randconfig-001-20241211    gcc-14.2.0
loongarch            randconfig-002-20241211    gcc-14.2.0
nios2                randconfig-001-20241211    gcc-14.2.0
nios2                randconfig-002-20241211    gcc-14.2.0
openrisc                           defconfig    gcc-12
parisc                             defconfig    gcc-12
parisc               randconfig-001-20241211    gcc-14.2.0
parisc               randconfig-002-20241211    gcc-14.2.0
powerpc                      eiger_defconfig    gcc-14.2.0
powerpc              randconfig-001-20241211    gcc-14.2.0
powerpc              randconfig-002-20241211    gcc-14.2.0
powerpc              randconfig-003-20241211    gcc-14.2.0
powerpc64            randconfig-001-20241211    gcc-14.2.0
powerpc64            randconfig-002-20241211    gcc-14.2.0
powerpc64            randconfig-003-20241211    gcc-14.2.0
riscv                              defconfig    gcc-12
riscv                randconfig-001-20241211    clang-20
riscv                randconfig-002-20241211    clang-20
s390                            allmodconfig    gcc-14.2.0
s390                            allyesconfig    gcc-14.2.0
s390                               defconfig    gcc-12
s390                               defconfig    gcc-14.2.0
s390                 randconfig-001-20241211    clang-20
s390                 randconfig-002-20241211    clang-20
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                                 defconfig    gcc-12
sh                   randconfig-001-20241211    clang-20
sh                   randconfig-002-20241211    clang-20
sh                          se7724_defconfig    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20241211    clang-20
sparc                randconfig-002-20241211    clang-20
sparc64                            defconfig    gcc-12
sparc64              randconfig-001-20241211    clang-20
sparc64              randconfig-002-20241211    clang-20
um                                 defconfig    gcc-12
um                            i386_defconfig    gcc-12
um                   randconfig-001-20241211    clang-20
um                   randconfig-002-20241211    clang-20
um                          x86_64_defconfig    gcc-12
x86_64                           allnoconfig    clang-19
x86_64                          allyesconfig    clang-19
x86_64     buildonly-randconfig-001-20241210    gcc-12
x86_64     buildonly-randconfig-001-20241211    gcc-12
x86_64     buildonly-randconfig-002-20241210    clang-19
x86_64     buildonly-randconfig-002-20241211    gcc-12
x86_64     buildonly-randconfig-003-20241210    clang-19
x86_64     buildonly-randconfig-003-20241211    gcc-12
x86_64     buildonly-randconfig-004-20241210    gcc-12
x86_64     buildonly-randconfig-004-20241211    gcc-12
x86_64     buildonly-randconfig-005-20241210    gcc-12
x86_64     buildonly-randconfig-005-20241211    gcc-12
x86_64     buildonly-randconfig-006-20241210    clang-19
x86_64     buildonly-randconfig-006-20241211    gcc-12
x86_64                             defconfig    clang-19
x86_64                                 kexec    clang-19
x86_64               randconfig-001-20241211    clang-19
x86_64               randconfig-002-20241211    clang-19
x86_64               randconfig-003-20241211    clang-19
x86_64               randconfig-004-20241211    clang-19
x86_64               randconfig-005-20241211    clang-19
x86_64               randconfig-006-20241211    clang-19
x86_64               randconfig-007-20241211    clang-19
x86_64               randconfig-008-20241211    clang-19
x86_64                              rhel-9.4    clang-19
xtensa               generic_kc705_defconfig    gcc-14.2.0
xtensa               randconfig-001-20241211    clang-20
xtensa               randconfig-002-20241211    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

