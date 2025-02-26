Return-Path: <linux-kernel+bounces-534744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E533FA46AA2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 20:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CC341889BEE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36D02376E7;
	Wed, 26 Feb 2025 19:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="boLWt008"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F542248B4
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 19:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740596896; cv=none; b=X4znkCPUCGHxgnVmtuRAu+LFQpxD7ALMuoDfymdMz9JuZft209nVSD4swXKUQQqaFrPv4yjmMeWUSdxvAUjQq5HfNsBNvoJJ97NE68sUcBZ6xrFSPmW7r3scPjBVE1e+Md6P/lncU1bFPjCG2Cx0ngiu1gBJZHu1MpmhH25rAmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740596896; c=relaxed/simple;
	bh=32YTFDtIAHptjhEKZURB9ItMPPvRAX2nC5IK2cdpKPc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=eKOsY9An7AWvB+I7vQbzZRzURQK6tKpVIXhghZMiKQamXjADs7wW7Gr1exRyJFccfn8A8suUk9fFrqCz1ftFBEVZz8o7+/yP7sDw+q3GLb0yZx9TiQ+h6I9Yxvi+yCzp5eqx09e64E/umAZj1RovOgOkMx2waMFzzzn8bBikzhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=boLWt008; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740596894; x=1772132894;
  h=date:from:to:cc:subject:message-id;
  bh=32YTFDtIAHptjhEKZURB9ItMPPvRAX2nC5IK2cdpKPc=;
  b=boLWt008EJ80fe7F8PJwfLIiRRwX4F8Kvie0k/JEk7n70g3IS8PVaL1Y
   XX3V4hdLZrGR/l76pNor0MQNcYq38AJFkB6sB0NKoMVJhQF3XLn3iehnZ
   3uUx9OTkqSb+K6o8fomJ+xkqO7kvcPDfmhYK52ph2O9sI1XASFeQVtt3x
   p6lVNwUoQIKMpPgUCi08+GNtxCMx52pd8/CLfvhwB6BPqlkT5cVVbUtTj
   /hpxt09yRCSit2ZKK2HvWl9ZM8HBMVdFzVnJ9wXiExr+TS15gVlDuWHM5
   ZgFL4dh50WHFwalEN6ju2w4XQeXYnGnYV/rsoZEQwybH5PGWxejKOGRGh
   w==;
X-CSE-ConnectionGUID: E+zDCcToQ6Ogg8PfnN4pgw==
X-CSE-MsgGUID: Cowpi+48RHmD27qsR5yOMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="52451970"
X-IronPort-AV: E=Sophos;i="6.13,318,1732608000"; 
   d="scan'208";a="52451970"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 11:08:13 -0800
X-CSE-ConnectionGUID: bubFv7xbQLaVvR1Gp/QKQQ==
X-CSE-MsgGUID: PARnwNJlQ0i/y6KjO74LOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="153970240"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 26 Feb 2025 11:08:12 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tnMlJ-000CHQ-23;
	Wed, 26 Feb 2025 19:08:07 +0000
Date: Thu, 27 Feb 2025 03:07:00 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:non-rcu/next] BUILD SUCCESS
 a2bfbf847c96196d62c9a59bd32e1fdafd1c205c
Message-ID: <202502270355.wypOqCVA-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git non-rcu/next
branch HEAD: a2bfbf847c96196d62c9a59bd32e1fdafd1c205c  tools/memory-model: glossary.txt: Fix indents

elapsed time: 1460m

configs tested: 72
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-14.2.0
alpha                           allyesconfig    gcc-14.2.0
alpha                              defconfig    gcc-14.2.0
arc                             alldefconfig    gcc-13.2.0
arc                             allmodconfig    gcc-13.2.0
arc                             allyesconfig    gcc-13.2.0
arc                  randconfig-001-20250226    gcc-13.2.0
arc                  randconfig-002-20250226    gcc-13.2.0
arm                  randconfig-001-20250226    gcc-14.2.0
arm                  randconfig-002-20250226    clang-21
arm                  randconfig-003-20250226    gcc-14.2.0
arm                  randconfig-004-20250226    gcc-14.2.0
arm                        socfpga_defconfig    gcc-14.2.0
arm64                randconfig-001-20250226    gcc-14.2.0
arm64                randconfig-002-20250226    gcc-14.2.0
arm64                randconfig-003-20250226    clang-21
arm64                randconfig-004-20250226    gcc-14.2.0
csky                               defconfig    gcc-14.2.0
csky                 randconfig-001-20250226    gcc-14.2.0
csky                 randconfig-002-20250226    gcc-14.2.0
hexagon                         allmodconfig    clang-21
hexagon                         allyesconfig    clang-18
hexagon              randconfig-001-20250226    clang-21
hexagon              randconfig-002-20250226    clang-21
i386       buildonly-randconfig-001-20250226    gcc-12
i386       buildonly-randconfig-002-20250226    gcc-12
i386       buildonly-randconfig-003-20250226    gcc-12
i386       buildonly-randconfig-004-20250226    clang-19
i386       buildonly-randconfig-005-20250226    gcc-12
i386       buildonly-randconfig-006-20250226    gcc-12
loongarch            randconfig-001-20250226    gcc-14.2.0
loongarch            randconfig-002-20250226    gcc-14.2.0
mips                         eyeq5_defconfig    gcc-14.2.0
mips                      rbtx49xx_defconfig    gcc-14.2.0
nios2                randconfig-001-20250226    gcc-14.2.0
nios2                randconfig-002-20250226    gcc-14.2.0
parisc               randconfig-001-20250226    gcc-14.2.0
parisc               randconfig-002-20250226    gcc-14.2.0
powerpc              randconfig-001-20250226    gcc-14.2.0
powerpc              randconfig-002-20250226    clang-18
powerpc              randconfig-003-20250226    clang-21
powerpc64            randconfig-001-20250226    clang-18
powerpc64            randconfig-002-20250226    gcc-14.2.0
powerpc64            randconfig-003-20250226    gcc-14.2.0
riscv                randconfig-001-20250226    clang-18
riscv                randconfig-002-20250226    gcc-14.2.0
s390                            allmodconfig    clang-19
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20250226    gcc-14.2.0
s390                 randconfig-002-20250226    clang-15
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20250226    gcc-14.2.0
sh                   randconfig-002-20250226    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20250226    gcc-14.2.0
sparc                randconfig-002-20250226    gcc-14.2.0
sparc64              randconfig-001-20250226    gcc-14.2.0
sparc64              randconfig-002-20250226    gcc-14.2.0
um                              allmodconfig    clang-21
um                              allyesconfig    gcc-12
um                   randconfig-001-20250226    clang-18
um                   randconfig-002-20250226    gcc-12
x86_64     buildonly-randconfig-001-20250226    clang-19
x86_64     buildonly-randconfig-002-20250226    clang-19
x86_64     buildonly-randconfig-003-20250226    gcc-12
x86_64     buildonly-randconfig-004-20250226    clang-19
x86_64     buildonly-randconfig-005-20250226    gcc-12
x86_64     buildonly-randconfig-006-20250226    gcc-12
xtensa                 nommu_kc705_defconfig    gcc-14.2.0
xtensa               randconfig-001-20250226    gcc-14.2.0
xtensa               randconfig-002-20250226    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

