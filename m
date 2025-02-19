Return-Path: <linux-kernel+bounces-522203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9DDA3C75F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 19:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB87B3BA322
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 18:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805D41FECC1;
	Wed, 19 Feb 2025 18:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A1UeWnXW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A78214A66
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 18:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739989399; cv=none; b=nYSJdJSZxHaoNqsj0te5GJjbgSCcZofjITwMXd7BCE3PvxjN4fcdjbPtdNP73ZPCjPC90QHFaAxkpc0PanX5OWEwDkQcqSDBI2PjsvbGtCdOxD2u204RjEuGmYg2IWnoJQ2UbsBQz8D4krW0/Bup1kQjTDzgzLu3nOeJpc6Z+ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739989399; c=relaxed/simple;
	bh=54xOSojKngCTcb3gwSgCrEU5ccPyKZZCGbLNRJN5AH4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=XLu+GSwZX7V4vWNfupe8OnmVVaCNdH31EsO2n7C9g0Z9eV3+hhkZ21f7AyKBqRuNRyO7maUE8xFf3Nmc1bjjNeEEn/fMODyxqNgAw6JoRI3mmEFSsxwYsSegBUirWNMTRDd+WQIj5juL/i7Mpn7AMwSrTeeyyXwBLu5sXWEGU3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A1UeWnXW; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739989397; x=1771525397;
  h=date:from:to:cc:subject:message-id;
  bh=54xOSojKngCTcb3gwSgCrEU5ccPyKZZCGbLNRJN5AH4=;
  b=A1UeWnXW9WDGmZHWmW5Q3CKRYBC9njkqpjT5yLETJPsBG7w8V3siybkv
   twyqZd+fa8k1ofMKQiaYekUFvIGaEcreVk5JKQTVY3w6WA9oWGiR12Drg
   cyMIiBfpgJFYnGvGRlLfFbdgsOwzZK80yf8cBdbu2HlxfiU6rvzz4MYOp
   7FwIcLIxvzj+U1EVRgkTlJjlV2rT0Oos1yKkBWZx0sfIt+Z3VKh9htN22
   ZJRJ2T+2v4JJiY868dBEDastItk/YqmXJDei4TMtz7PrvWWXmj2yzz+zj
   mFTrS76Gz0Y0lnZCTgic2dLYU4uKHCNzoKTeJuoo46ryBtxXqdgwcLCFk
   g==;
X-CSE-ConnectionGUID: dISa7WkgQSir72BPWlC5IQ==
X-CSE-MsgGUID: GK2a0lCORlKHGuchCrG74A==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="44388929"
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="44388929"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 10:23:17 -0800
X-CSE-ConnectionGUID: ef6W5XxGSxCxWyUZVJLbvg==
X-CSE-MsgGUID: RvtG8C+3Q4qljF2z9IVC0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="119772618"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 19 Feb 2025 10:23:17 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tkoj4-0003J5-03;
	Wed, 19 Feb 2025 18:23:14 +0000
Date: Thu, 20 Feb 2025 02:22:28 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:timers/cleanups] BUILD SUCCESS
 86a578e780a9fb0e1a1b6f3f3aa847c29b5255b9
Message-ID: <202502200220.NWwKMS3r-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/cleanups
branch HEAD: 86a578e780a9fb0e1a1b6f3f3aa847c29b5255b9  wifi: rt2x00: Switch to use hrtimer_update_function()

elapsed time: 1456m

configs tested: 74
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                           allyesconfig    gcc-14.2.0
arc                             allmodconfig    gcc-13.2.0
arc                             allyesconfig    gcc-13.2.0
arc                  randconfig-001-20250219    gcc-13.2.0
arc                  randconfig-002-20250219    gcc-13.2.0
arm                             allmodconfig    gcc-14.2.0
arm                             allyesconfig    gcc-14.2.0
arm                  randconfig-001-20250219    gcc-14.2.0
arm                  randconfig-002-20250219    clang-17
arm                  randconfig-003-20250219    clang-15
arm                  randconfig-004-20250219    gcc-14.2.0
arm64                           allmodconfig    clang-18
arm64                randconfig-001-20250219    clang-21
arm64                randconfig-002-20250219    gcc-14.2.0
arm64                randconfig-003-20250219    gcc-14.2.0
arm64                randconfig-004-20250219    gcc-14.2.0
csky                 randconfig-001-20250219    gcc-14.2.0
csky                 randconfig-002-20250219    gcc-14.2.0
hexagon                         allmodconfig    clang-21
hexagon                         allyesconfig    clang-18
hexagon              randconfig-001-20250219    clang-14
hexagon              randconfig-002-20250219    clang-21
i386                            allmodconfig    gcc-12
i386                             allnoconfig    gcc-12
i386                            allyesconfig    gcc-12
i386       buildonly-randconfig-001-20250219    clang-19
i386       buildonly-randconfig-002-20250219    clang-19
i386       buildonly-randconfig-003-20250219    gcc-12
i386       buildonly-randconfig-004-20250219    clang-19
i386       buildonly-randconfig-005-20250219    clang-19
i386       buildonly-randconfig-006-20250219    gcc-12
i386                               defconfig    clang-19
loongarch            randconfig-001-20250219    gcc-14.2.0
loongarch            randconfig-002-20250219    gcc-14.2.0
nios2                randconfig-001-20250219    gcc-14.2.0
nios2                randconfig-002-20250219    gcc-14.2.0
parisc               randconfig-001-20250219    gcc-14.2.0
parisc               randconfig-002-20250219    gcc-14.2.0
powerpc              randconfig-001-20250219    clang-15
powerpc              randconfig-002-20250219    clang-17
powerpc              randconfig-003-20250219    gcc-14.2.0
powerpc64            randconfig-001-20250219    gcc-14.2.0
powerpc64            randconfig-002-20250219    gcc-14.2.0
powerpc64            randconfig-003-20250219    gcc-14.2.0
riscv                randconfig-001-20250219    clang-21
riscv                randconfig-002-20250219    gcc-14.2.0
s390                            allmodconfig    clang-19
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20250219    clang-18
s390                 randconfig-002-20250219    clang-21
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20250219    gcc-14.2.0
sh                   randconfig-002-20250219    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20250219    gcc-14.2.0
sparc                randconfig-002-20250219    gcc-14.2.0
sparc64              randconfig-001-20250219    gcc-14.2.0
sparc64              randconfig-002-20250219    gcc-14.2.0
um                              allmodconfig    clang-21
um                              allyesconfig    gcc-12
um                   randconfig-001-20250219    clang-21
um                   randconfig-002-20250219    clang-21
x86_64                           allnoconfig    clang-19
x86_64                          allyesconfig    clang-19
x86_64     buildonly-randconfig-001-20250219    gcc-12
x86_64     buildonly-randconfig-002-20250219    clang-19
x86_64     buildonly-randconfig-003-20250219    gcc-12
x86_64     buildonly-randconfig-004-20250219    clang-19
x86_64     buildonly-randconfig-005-20250219    gcc-12
x86_64     buildonly-randconfig-006-20250219    clang-19
x86_64                             defconfig    gcc-11
xtensa               randconfig-001-20250219    gcc-14.2.0
xtensa               randconfig-002-20250219    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

