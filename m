Return-Path: <linux-kernel+bounces-523872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D49A3DC64
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 692F070051E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 14:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FBB1FAC5E;
	Thu, 20 Feb 2025 14:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FrOI6PrL"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC5DA29
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 14:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740060974; cv=none; b=WslO3PZX4br/lvpVk0LioyivcyoAR6liGiGHdX+WGH7pjK9bNR5vATsYkHLKgYhWKbgH6TZcitSHOEyPa1I/apj3z/P4ApCVHfmbf9lmVLgD/m5fxAs9sq+NNNz8dBOiEOWZFku9LDEVdpfz0NFaL3w5y/xxCB2gyEh4yoknZNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740060974; c=relaxed/simple;
	bh=cAaH8ypisT5MCVqGFJgy0mTiI57XS5XxjyK0hggSiaE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=qYQySJl/+Cl8Dl3oDuRRNnXRlb+YbmdMW1VtaCDnqgqPQF89oHJsQUJPl1v8s8oV3bIfg7VT2h1GmxMiMsP0QfGwE+JLTodymhblvY/LqmmsNUSPb6iysRtwtmY7jv23BKCgAAJhd9Hlbca7GIVLPmPENI93WFLXN4uXHSvXfE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FrOI6PrL; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740060972; x=1771596972;
  h=date:from:to:cc:subject:message-id;
  bh=cAaH8ypisT5MCVqGFJgy0mTiI57XS5XxjyK0hggSiaE=;
  b=FrOI6PrLdxmuLN+tkVsW2HLlTzeT8bIPYxjkwIFLLTrvplkzVYCheYqI
   4Lez4qbUFzvi3lpxDgFeECKiFEY3b65a2Cd42wPW+sjfMYGvg+OB7Fh+1
   ccwQgzch5GUv2Gt/xmZksYLQTEDgujsRgNJ4i81om+MUINl+UA7Pm+aKU
   dafBcv5XMpL3UG9GxkZy+H6953ZmNS2oJcCG733uAG5vruoK0wZ8vthdA
   Rzk2op5fglB78N26YDqzUnbqcmjlvG7Pv1YnrAJNtGa9ItBqJ7g3jD2Kv
   GIA+VJBs/X1mY/K9+Tuyr7qR36HofG7UmohfeKBFwdUuGC7xUk1qic1CU
   A==;
X-CSE-ConnectionGUID: ciaW4vLrRKiZl+OJp4o8cA==
X-CSE-MsgGUID: Oivue1LfQ/aLhnPTPYCgeg==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="28438485"
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; 
   d="scan'208";a="28438485"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 06:16:11 -0800
X-CSE-ConnectionGUID: LPwXiQmIRx6bL3DE5/5ROQ==
X-CSE-MsgGUID: i0yoqn+YRNqMQlMeoWPmlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; 
   d="scan'208";a="138250933"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 20 Feb 2025 06:16:10 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tl7LU-0004Nd-1R;
	Thu, 20 Feb 2025 14:16:08 +0000
Date: Thu, 20 Feb 2025 22:15:42 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:tip/urgent] BUILD SUCCESS
 d5e608b7b081feaa442ec0322c6eb0cdc8661abc
Message-ID: <202502202236.Tomf1mRh-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tip/urgent
branch HEAD: d5e608b7b081feaa442ec0322c6eb0cdc8661abc  Merge branch into tip/master: 'perf/urgent'

elapsed time: 1456m

configs tested: 101
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250219    gcc-13.2.0
arc                   randconfig-002-20250219    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                   randconfig-001-20250219    gcc-14.2.0
arm                   randconfig-002-20250219    clang-17
arm                   randconfig-003-20250219    clang-15
arm                   randconfig-004-20250219    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250219    clang-21
arm64                 randconfig-002-20250219    gcc-14.2.0
arm64                 randconfig-003-20250219    gcc-14.2.0
arm64                 randconfig-004-20250219    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250220    gcc-14.2.0
csky                  randconfig-002-20250220    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250220    clang-21
hexagon               randconfig-002-20250220    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250219    clang-19
i386        buildonly-randconfig-002-20250219    clang-19
i386        buildonly-randconfig-003-20250219    gcc-12
i386        buildonly-randconfig-004-20250219    clang-19
i386        buildonly-randconfig-005-20250219    clang-19
i386        buildonly-randconfig-006-20250219    gcc-12
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250220    gcc-14.2.0
loongarch             randconfig-002-20250220    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250220    gcc-14.2.0
nios2                 randconfig-002-20250220    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                randconfig-001-20250220    gcc-14.2.0
parisc                randconfig-002-20250220    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc               randconfig-001-20250220    gcc-14.2.0
powerpc               randconfig-002-20250220    clang-16
powerpc               randconfig-003-20250220    clang-21
powerpc64             randconfig-001-20250220    clang-16
powerpc64             randconfig-002-20250220    clang-18
powerpc64             randconfig-003-20250220    gcc-14.2.0
riscv                             allnoconfig    gcc-14.2.0
riscv                 randconfig-001-20250220    gcc-14.2.0
riscv                 randconfig-002-20250220    clang-21
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250220    clang-19
s390                  randconfig-002-20250220    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250220    gcc-14.2.0
sh                    randconfig-002-20250220    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250220    gcc-14.2.0
sparc                 randconfig-002-20250220    gcc-14.2.0
sparc64               randconfig-001-20250220    gcc-14.2.0
sparc64               randconfig-002-20250220    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                    randconfig-001-20250220    gcc-12
um                    randconfig-002-20250220    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250219    gcc-12
x86_64      buildonly-randconfig-002-20250219    clang-19
x86_64      buildonly-randconfig-003-20250219    gcc-12
x86_64      buildonly-randconfig-004-20250219    clang-19
x86_64      buildonly-randconfig-005-20250219    gcc-12
x86_64      buildonly-randconfig-006-20250219    clang-19
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250220    gcc-14.2.0
xtensa                randconfig-002-20250220    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

