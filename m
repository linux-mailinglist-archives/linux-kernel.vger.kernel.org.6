Return-Path: <linux-kernel+bounces-539491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B4C7A4A508
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 22:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C72FA189B543
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 21:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A542D1D61BC;
	Fri, 28 Feb 2025 21:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cvy/3i3q"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C4223F36E
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 21:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740778016; cv=none; b=lfdrJsrhUiR9YBPu+gMRlHRH0Qkg2j1khcUxrYHfYeK5uGchV69mFRk/yNZIzJ++8cVv5/jpPkMApXZgnEWWxZzDjUeB0G4Lz8uO9O3SfSgGXBZAQNxQulcoX4bApUEcNEl7cRMtzjvzgf2K46+pOSItvK4LnfLJfxSrgP6zeZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740778016; c=relaxed/simple;
	bh=ih3c1w8oTdyWluwSwgEGg8tA7yPoRrLZf+I26L8YP84=;
	h=Date:From:To:Cc:Subject:Message-ID; b=GnxyAlBqhqkqxGW9yExdKat62jM+1hBgguNV5rvTdKs3npWuvgQ8VCWi8dMDjK7R6vsBKdXmhDgoao1t2Lgi5DTvbkM6H4wbpIB5yo7x8F2majUOhyIN3IHdaExF7BWqs8dyhsGI4KA+FuQXG04Q4qfPb4rKLOrNV2TQWKBPiuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cvy/3i3q; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740778014; x=1772314014;
  h=date:from:to:cc:subject:message-id;
  bh=ih3c1w8oTdyWluwSwgEGg8tA7yPoRrLZf+I26L8YP84=;
  b=cvy/3i3qu+lTdEQd/wXMYlKtqPV0wuDXYJSudfYvM1V5EBKTRRWKpMt7
   EcQPfqxRz/J8XN7NnCMW42S/VjXLYy8PnMDHKpCSl5JRdBMeETWp/cehT
   14CiaUCWG0IqA44BGiFa7RkmZzT0HBrXgcQSa6dmCiEXaXxmHwvj4ol42
   NJeawdhYXiDDkrwjepCeMRGvGMVFtu+cCoM8oNOHwviDKNY4A15fqI955
   i7BRXidhR3nkv42hTOKAdT0308Q/d8b/DgpkWRwiUyJx7naretXgYXOOm
   sWpg3yWf6yczol4HozYsAo9NsmAJZA6gtuxdMdrjw19LRFxoTt77xZ7Lv
   Q==;
X-CSE-ConnectionGUID: 5ZEvetopRuaXAnvBCeJkHA==
X-CSE-MsgGUID: 4JQDrE15QIS755sNxK/G6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="52353133"
X-IronPort-AV: E=Sophos;i="6.13,323,1732608000"; 
   d="scan'208";a="52353133"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 13:26:53 -0800
X-CSE-ConnectionGUID: VQXMi0+XSjulbC/WOPynmQ==
X-CSE-MsgGUID: kjNHYN/lRZWRHnQb5ZnYwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,323,1732608000"; 
   d="scan'208";a="122578290"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 28 Feb 2025 13:26:52 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1to7sg-000FXG-1O;
	Fri, 28 Feb 2025 21:26:50 +0000
Date: Sat, 01 Mar 2025 05:26:44 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:sched/urgent] BUILD SUCCESS
 82c387ef7568c0d96a918a5a78d9cad6256cfa15
Message-ID: <202503010534.1iYqRYuP-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/urgent
branch HEAD: 82c387ef7568c0d96a918a5a78d9cad6256cfa15  sched/core: Prevent rescheduling when interrupts are disabled

elapsed time: 1455m

configs tested: 79
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                               allnoconfig    gcc-13.2.0
arc                                 defconfig    gcc-13.2.0
arc                   randconfig-001-20250228    gcc-13.2.0
arc                   randconfig-002-20250228    gcc-13.2.0
arm                               allnoconfig    clang-17
arm                         axm55xx_defconfig    clang-17
arm                         bcm2835_defconfig    clang-16
arm                   randconfig-001-20250228    clang-21
arm                   randconfig-002-20250228    gcc-14.2.0
arm                   randconfig-003-20250228    gcc-14.2.0
arm                   randconfig-004-20250228    gcc-14.2.0
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250228    gcc-14.2.0
arm64                 randconfig-002-20250228    clang-21
arm64                 randconfig-003-20250228    clang-16
arm64                 randconfig-004-20250228    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250228    gcc-14.2.0
csky                  randconfig-002-20250228    gcc-14.2.0
hexagon                           allnoconfig    clang-21
hexagon               randconfig-001-20250228    clang-19
hexagon               randconfig-002-20250228    clang-21
i386        buildonly-randconfig-001-20250228    clang-19
i386        buildonly-randconfig-002-20250228    clang-19
i386        buildonly-randconfig-003-20250228    gcc-12
i386        buildonly-randconfig-004-20250228    clang-19
i386        buildonly-randconfig-005-20250228    clang-19
i386        buildonly-randconfig-006-20250228    clang-19
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250228    gcc-14.2.0
loongarch             randconfig-002-20250228    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250228    gcc-14.2.0
nios2                 randconfig-002-20250228    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250228    gcc-14.2.0
parisc                randconfig-002-20250228    gcc-14.2.0
powerpc               randconfig-001-20250228    gcc-14.2.0
powerpc               randconfig-002-20250228    clang-16
powerpc               randconfig-003-20250228    clang-18
powerpc64             randconfig-001-20250228    clang-16
powerpc64             randconfig-002-20250228    clang-18
powerpc64             randconfig-003-20250228    gcc-14.2.0
riscv                 randconfig-001-20250228    gcc-14.2.0
riscv                 randconfig-002-20250228    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250228    gcc-14.2.0
s390                  randconfig-002-20250228    clang-17
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250228    gcc-14.2.0
sh                    randconfig-002-20250228    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250228    gcc-14.2.0
sparc                 randconfig-002-20250228    gcc-14.2.0
sparc64               randconfig-001-20250228    gcc-14.2.0
sparc64               randconfig-002-20250228    gcc-14.2.0
um                    randconfig-001-20250228    clang-21
um                    randconfig-002-20250228    clang-21
x86_64                            allnoconfig    clang-19
x86_64      buildonly-randconfig-001-20250228    clang-19
x86_64      buildonly-randconfig-002-20250228    clang-19
x86_64      buildonly-randconfig-003-20250228    gcc-12
x86_64      buildonly-randconfig-004-20250228    clang-19
x86_64      buildonly-randconfig-005-20250228    gcc-12
x86_64      buildonly-randconfig-006-20250228    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250228    gcc-14.2.0
xtensa                randconfig-002-20250228    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

