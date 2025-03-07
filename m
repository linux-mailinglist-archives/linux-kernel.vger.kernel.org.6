Return-Path: <linux-kernel+bounces-552058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 067C8A574CD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 23:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03A247A60A4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 22:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6769A257437;
	Fri,  7 Mar 2025 22:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AONy9Tl0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598FE1FFC44
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 22:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741385698; cv=none; b=F9J7Nh2zHkWXkUUUqWCwIA52McFrB5CkaLLu/UIAXEmuR+4GB6DOMb0Ww/l8AX1hwRmdD+IW/rZFfYZqipTa9npwHU0WXSVmXqLwydmcm2TKjzpzw20iruHSVFdprmbfQFmP8CNZDU1cv/S1CofRY53XhW8lukvspVtynUtB81s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741385698; c=relaxed/simple;
	bh=W1y0R6f4u08fwADZuOur2F3RZ9j+ANjT2PTB6oeYxoo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=mVXRt+ifL3NX9CXcChN4eBxNPj0dgyrCN4YOwlyccmE33LmUUurfLfNB1IqWdqRY4F2fvLZSHgDRAohfgwh1Kz5IEbY1C09MAdEW0JeetooXKvliM8wQoDJCLCQn7ly1frBk3bxGQGZuDtM3n0N9mHBKs9DxlYbVqiRntVSsyNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AONy9Tl0; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741385697; x=1772921697;
  h=date:from:to:cc:subject:message-id;
  bh=W1y0R6f4u08fwADZuOur2F3RZ9j+ANjT2PTB6oeYxoo=;
  b=AONy9Tl0QjhDh4R/DnmKqz3QTS7WqVJBW4s45MH7PVe3QOo4KlAvX/lx
   pZhp/p31hehSKOBkHp4axSC2bxKzPPhrlvtdMbgi++dgKhPAXOhemfWrV
   yrMLZ6dPq0P9xFyMezurqv0F39J1RQpmntIFhKKi0H8LFr137eVViZKds
   cEJT8zOLIQSjdA6qBL6CFwp8Kf2yXJZgEMCRlfpAHMRuDzukdscI5JR8i
   pwqoFnrJgi6hAUeCPE+ugETxuEtN5VYudMTH9RjMXwsgDzNxligFUASz0
   SqSC33MtS5zYQBOHPjVF8MJCvd9RqoH1eJoqd+WR+bO+6Qhc2AYzhrC8A
   Q==;
X-CSE-ConnectionGUID: NWwPIg9kSCCepvB4lmzOew==
X-CSE-MsgGUID: ye4M38nmQd6l+D2//l+TgA==
X-IronPort-AV: E=McAfee;i="6700,10204,11366"; a="64886520"
X-IronPort-AV: E=Sophos;i="6.14,230,1736841600"; 
   d="scan'208";a="64886520"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 14:14:57 -0800
X-CSE-ConnectionGUID: LL0XMq3xQ/2j06gqpezRuQ==
X-CSE-MsgGUID: HxKOrNNcS5y5hQOjdvx+MQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,230,1736841600"; 
   d="scan'208";a="150234553"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 07 Mar 2025 14:14:55 -0800
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tqfy1-00018F-27;
	Fri, 07 Mar 2025 22:14:53 +0000
Date: Sat, 08 Mar 2025 06:14:19 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/asm] BUILD SUCCESS
 aa3942d4d12ef57f031faa2772fe410c24191e36
Message-ID: <202503080612.IEQRbZJe-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/asm
branch HEAD: aa3942d4d12ef57f031faa2772fe410c24191e36  x86/kexec: Merge x86_32 and x86_64 code using macros from <asm/asm.h>

elapsed time: 1456m

configs tested: 57
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
arc                  randconfig-001-20250307    gcc-13.2.0
arc                  randconfig-002-20250307    gcc-13.2.0
arm                  randconfig-001-20250307    clang-21
arm                  randconfig-002-20250307    gcc-14.2.0
arm                  randconfig-003-20250307    clang-19
arm                  randconfig-004-20250307    clang-21
arm64                randconfig-001-20250307    gcc-14.2.0
arm64                randconfig-002-20250307    clang-15
arm64                randconfig-003-20250307    gcc-14.2.0
arm64                randconfig-004-20250307    clang-15
csky                 randconfig-001-20250307    gcc-14.2.0
csky                 randconfig-002-20250307    gcc-14.2.0
hexagon              randconfig-001-20250307    clang-21
hexagon              randconfig-002-20250307    clang-21
i386       buildonly-randconfig-001-20250307    clang-19
i386       buildonly-randconfig-002-20250307    clang-19
i386       buildonly-randconfig-003-20250307    gcc-11
i386       buildonly-randconfig-004-20250307    clang-19
i386       buildonly-randconfig-005-20250307    gcc-12
i386       buildonly-randconfig-006-20250307    clang-19
loongarch            randconfig-001-20250307    gcc-14.2.0
loongarch            randconfig-002-20250307    gcc-14.2.0
nios2                randconfig-001-20250307    gcc-14.2.0
nios2                randconfig-002-20250307    gcc-14.2.0
parisc               randconfig-001-20250307    gcc-14.2.0
parisc               randconfig-002-20250307    gcc-14.2.0
powerpc              randconfig-001-20250307    gcc-14.2.0
powerpc              randconfig-002-20250307    clang-21
powerpc              randconfig-003-20250307    clang-19
powerpc64            randconfig-001-20250307    clang-21
powerpc64            randconfig-002-20250307    gcc-14.2.0
powerpc64            randconfig-003-20250307    gcc-14.2.0
riscv                randconfig-001-20250307    gcc-14.2.0
riscv                randconfig-002-20250307    clang-19
s390                            allmodconfig    clang-19
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20250307    gcc-14.2.0
s390                 randconfig-002-20250307    gcc-14.2.0
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20250307    gcc-14.2.0
sh                   randconfig-002-20250307    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20250307    gcc-14.2.0
sparc                randconfig-002-20250307    gcc-14.2.0
sparc64              randconfig-001-20250307    gcc-14.2.0
sparc64              randconfig-002-20250307    gcc-14.2.0
um                   randconfig-001-20250307    clang-17
um                   randconfig-002-20250307    clang-21
x86_64     buildonly-randconfig-001-20250307    clang-19
x86_64     buildonly-randconfig-002-20250307    gcc-12
x86_64     buildonly-randconfig-003-20250307    clang-19
x86_64     buildonly-randconfig-004-20250307    clang-19
x86_64     buildonly-randconfig-005-20250307    clang-19
x86_64     buildonly-randconfig-006-20250307    gcc-12
xtensa               randconfig-001-20250307    gcc-14.2.0
xtensa               randconfig-002-20250307    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

