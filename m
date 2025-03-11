Return-Path: <linux-kernel+bounces-555487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF631A5B857
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 06:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 894EC3ADB61
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 05:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBC01EB9E5;
	Tue, 11 Mar 2025 05:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YLEangEV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD951E5B83
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 05:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741670652; cv=none; b=g10RXDMpPmFkHpRN0Xu7r/kXHcAfVNXy2hXHQUAO2T+1FMxSp/s15w/sgJPTLkdcSARoOcoJ0nOQl2mRT7nJ7GbFrWjzqm0i0Wi9rqvCErkcNlqyAfYuDrdbp8uNN0J0jj2HoY7kbAG+jQL9FEQQIk+0LNi1hWldhBbjlInRthE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741670652; c=relaxed/simple;
	bh=n1dUDXExtxs/71zYnfSyMtp+EVza+KNlTFPk00moy6o=;
	h=Date:From:To:Cc:Subject:Message-ID; b=pgW+I/5dgYeS0IOITetnoWkFMJZg7O02FegDn1gBb4n5eY8sTJeUCd6b7iq0HnfUubvM5ezb0L3fiXXKfloDBdlGHUR/+Tx5iGyzKDINR4orX76uDuIoJtug3i/RlAVMVoKL+8Vya1dqQNBqZaBdkvMa39DcSK19NIYqUxUfX2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YLEangEV; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741670651; x=1773206651;
  h=date:from:to:cc:subject:message-id;
  bh=n1dUDXExtxs/71zYnfSyMtp+EVza+KNlTFPk00moy6o=;
  b=YLEangEVfafWgROJkDiGroG9Pj3oAab0uAN6uo+11P2fCNXgBCP57ocE
   rWRJN6vqlFHWN0HawW/M08xO5KHpqw/f9nNpxY3Us6xlYf0EbNlMSkt6d
   i7e4t4H8V7tlSi9d4pD9nqeJ9GMK+GNNElZsuAkS9pWsv7cJzaNLMyIYr
   WKGNhAgRknKv3bSXuQ0egsa0M5k0hikjBpGZuQkmokpBd5U0qP4pCh+eG
   jz40ymdNJIHrZeXESNAr6+VmRmpfN43iNQAN5jrI756ppIdOTrHIvXjmI
   pA+bhNE4WFE11yLRhO+DSFy9UWDl5PTww8KKMJq/HGm3O7YPNAmRuiRgw
   A==;
X-CSE-ConnectionGUID: uTVrqF8oTZW7UjDt6M0WMQ==
X-CSE-MsgGUID: bQlWvMKqSc2GLQCgTDv+8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="42804503"
X-IronPort-AV: E=Sophos;i="6.14,238,1736841600"; 
   d="scan'208";a="42804503"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 22:24:10 -0700
X-CSE-ConnectionGUID: VuSWreMiRnSsrHRWPk9owA==
X-CSE-MsgGUID: zTbUewSESRCFz9TPjJ//Og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,238,1736841600"; 
   d="scan'208";a="125109860"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 10 Mar 2025 22:24:10 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1trs63-0006Nd-1B;
	Tue, 11 Mar 2025 05:24:07 +0000
Date: Tue, 11 Mar 2025 13:23:31 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/headers] BUILD SUCCESS
 e28eecf2602bdce826833ccb9a6b7a6bacafd98b
Message-ID: <202503111325.VPSPRu4V-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/headers
branch HEAD: e28eecf2602bdce826833ccb9a6b7a6bacafd98b  x86/headers: Replace __ASSEMBLY__ with __ASSEMBLER__ in UAPI headers

elapsed time: 1064m

configs tested: 151
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250310    gcc-13.2.0
arc                   randconfig-002-20250310    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    gcc-14.2.0
arm                   randconfig-001-20250310    clang-21
arm                   randconfig-002-20250310    gcc-14.2.0
arm                   randconfig-003-20250310    gcc-14.2.0
arm                   randconfig-004-20250310    clang-21
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250310    clang-19
arm64                 randconfig-002-20250310    clang-17
arm64                 randconfig-003-20250310    clang-15
arm64                 randconfig-004-20250310    clang-17
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250310    gcc-14.2.0
csky                  randconfig-002-20250310    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-21
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250310    clang-21
hexagon               randconfig-002-20250310    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250310    clang-19
i386        buildonly-randconfig-001-20250311    clang-19
i386        buildonly-randconfig-002-20250310    clang-19
i386        buildonly-randconfig-002-20250311    clang-19
i386        buildonly-randconfig-003-20250310    clang-19
i386        buildonly-randconfig-003-20250311    clang-19
i386        buildonly-randconfig-004-20250310    clang-19
i386        buildonly-randconfig-004-20250311    clang-19
i386        buildonly-randconfig-005-20250310    clang-19
i386        buildonly-randconfig-005-20250311    clang-19
i386        buildonly-randconfig-006-20250310    clang-19
i386        buildonly-randconfig-006-20250311    clang-19
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250310    gcc-14.2.0
loongarch             randconfig-002-20250310    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250310    gcc-14.2.0
nios2                 randconfig-002-20250310    gcc-14.2.0
openrisc                          allnoconfig    clang-15
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-15
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250310    gcc-14.2.0
parisc                randconfig-002-20250310    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-15
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc               randconfig-001-20250310    clang-17
powerpc               randconfig-002-20250310    clang-21
powerpc               randconfig-003-20250310    clang-17
powerpc64             randconfig-001-20250310    gcc-14.2.0
powerpc64             randconfig-002-20250310    gcc-14.2.0
powerpc64             randconfig-003-20250310    gcc-14.2.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    clang-15
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-21
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250310    clang-19
riscv                 randconfig-001-20250311    gcc-14.2.0
riscv                 randconfig-002-20250310    gcc-14.2.0
riscv                 randconfig-002-20250311    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250310    gcc-14.2.0
s390                  randconfig-001-20250311    gcc-14.2.0
s390                  randconfig-002-20250310    clang-18
s390                  randconfig-002-20250311    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250310    gcc-14.2.0
sh                    randconfig-001-20250311    gcc-14.2.0
sh                    randconfig-002-20250310    gcc-14.2.0
sh                    randconfig-002-20250311    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250310    gcc-14.2.0
sparc                 randconfig-001-20250311    gcc-14.2.0
sparc                 randconfig-002-20250310    gcc-14.2.0
sparc                 randconfig-002-20250311    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250310    gcc-14.2.0
sparc64               randconfig-001-20250311    gcc-14.2.0
sparc64               randconfig-002-20250310    gcc-14.2.0
sparc64               randconfig-002-20250311    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-15
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250310    gcc-12
um                    randconfig-001-20250311    gcc-14.2.0
um                    randconfig-002-20250310    clang-17
um                    randconfig-002-20250311    gcc-14.2.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250310    gcc-12
x86_64      buildonly-randconfig-001-20250311    clang-19
x86_64      buildonly-randconfig-002-20250310    clang-19
x86_64      buildonly-randconfig-002-20250311    clang-19
x86_64      buildonly-randconfig-003-20250310    clang-19
x86_64      buildonly-randconfig-003-20250311    clang-19
x86_64      buildonly-randconfig-004-20250310    clang-19
x86_64      buildonly-randconfig-004-20250311    clang-19
x86_64      buildonly-randconfig-005-20250310    clang-19
x86_64      buildonly-randconfig-005-20250311    clang-19
x86_64      buildonly-randconfig-006-20250310    gcc-12
x86_64      buildonly-randconfig-006-20250311    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                               rhel-9.4    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250310    gcc-14.2.0
xtensa                randconfig-001-20250311    gcc-14.2.0
xtensa                randconfig-002-20250310    gcc-14.2.0
xtensa                randconfig-002-20250311    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

