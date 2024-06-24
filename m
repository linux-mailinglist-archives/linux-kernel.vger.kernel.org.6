Return-Path: <linux-kernel+bounces-227791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F46E915699
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 20:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47427283BD9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 18:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63171A00CE;
	Mon, 24 Jun 2024 18:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DzvFp2CZ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70D21B950
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 18:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719254606; cv=none; b=TRETPO9xhHu0Z9dTfKNhpdokNfluxafBW3Gb15LceineEr2r27eU7ZCDR18u/aPkXDAn8o2jxVAEcTmczLIO/IhzUEVkQMROExKkLiX6IRqDXjPqxOM4VU1wyA/EuUtIyq3us+8AWOTF6Hs5rVFFSvedaEKNgSJqD0hadgq99lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719254606; c=relaxed/simple;
	bh=zMw5tHVX9yIJF5GXcG/K1tztvC7MtHTjm6pz6b9YlzI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=rmBt5jpgYQYO1XM0X0HCdQQJXWiIclSwdxLpk7s5LKMDtcj3Q19PJZDjLdk4XLvBcqj/pqsQlHhhs9/Aq78FCtnfM3YpWn0Rjw0h8CetOHh3tJo4x4mJYqplFDKyl2h2MOybEPHZgfIdCQbBE8w2Z4EbtFrgeAZebGkeOOxDHRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DzvFp2CZ; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719254604; x=1750790604;
  h=date:from:to:cc:subject:message-id;
  bh=zMw5tHVX9yIJF5GXcG/K1tztvC7MtHTjm6pz6b9YlzI=;
  b=DzvFp2CZoJ3NqIKIrvUx4qSaYRwr0Qo+PnTwGn5t5Y+Mv3y8ICNiu5p4
   ENca6F9sU0TPq2v/uzuiS/iFHpSVM2OZzEzyjyiH/knk8fRTy9qIZXCFq
   saRAJowspxR4vct43MLqG7K0QW3nyJeQaa+vMabZdOUUJf1sOLSkdXrvK
   LV/7FxvWJzlu5NtmIPtVdwcH5ffxR4ee5W+5JAolShgX9Odg/T42WMZk4
   rNY6NkquPgtbCuK06ljHVR6ih0Qdo5bkpCB8PRjE8DP3shM8e90WjEFWg
   wb4qSJm1VsrEdKDj6yLhyjWvbRgQHeOmjJa8XwKY2b3gSs+j1rtidiyad
   w==;
X-CSE-ConnectionGUID: oYdu1EvKRui8FKz+w3PmWg==
X-CSE-MsgGUID: Bu5f7cflQw243BdmJrGAVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="16120498"
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="16120498"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 11:43:23 -0700
X-CSE-ConnectionGUID: ACRfqAxkRbGpyODo9hG1eQ==
X-CSE-MsgGUID: 0RnWafndQgq/PWgww1pmjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="43477530"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 24 Jun 2024 11:43:22 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sLoet-000Dd4-3A;
	Mon, 24 Jun 2024 18:43:19 +0000
Date: Tue, 25 Jun 2024 02:42:25 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:timers/core] BUILD SUCCESS
 e1b6a78b58aa859c66a32cfaeb121df87631d4ed
Message-ID: <202406250223.e9QoKzK5-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
branch HEAD: e1b6a78b58aa859c66a32cfaeb121df87631d4ed  timekeeping: Add missing kernel-doc function comments

elapsed time: 1479m

configs tested: 108
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                   randconfig-001-20240624   gcc-13.2.0
arc                   randconfig-002-20240624   gcc-13.2.0
arm                               allnoconfig   clang-19
arm                   randconfig-001-20240624   clang-17
arm                   randconfig-002-20240624   gcc-13.2.0
arm                   randconfig-003-20240624   gcc-13.2.0
arm                   randconfig-004-20240624   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                 randconfig-001-20240624   clang-19
arm64                 randconfig-002-20240624   gcc-13.2.0
arm64                 randconfig-003-20240624   gcc-13.2.0
arm64                 randconfig-004-20240624   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                  randconfig-001-20240624   gcc-13.2.0
csky                  randconfig-002-20240624   gcc-13.2.0
hexagon                           allnoconfig   clang-19
hexagon               randconfig-001-20240624   clang-19
hexagon               randconfig-002-20240624   clang-19
i386         buildonly-randconfig-001-20240624   gcc-8
i386         buildonly-randconfig-002-20240624   gcc-13
i386         buildonly-randconfig-003-20240624   clang-18
i386         buildonly-randconfig-004-20240624   gcc-10
i386         buildonly-randconfig-005-20240624   clang-18
i386         buildonly-randconfig-006-20240624   clang-18
i386                  randconfig-001-20240624   clang-18
i386                  randconfig-002-20240624   clang-18
i386                  randconfig-003-20240624   gcc-13
i386                  randconfig-004-20240624   gcc-13
i386                  randconfig-005-20240624   gcc-13
i386                  randconfig-006-20240624   clang-18
i386                  randconfig-011-20240624   clang-18
i386                  randconfig-012-20240624   clang-18
i386                  randconfig-013-20240624   gcc-9
i386                  randconfig-014-20240624   clang-18
i386                  randconfig-015-20240624   clang-18
i386                  randconfig-016-20240624   gcc-9
loongarch                         allnoconfig   gcc-13.2.0
loongarch             randconfig-001-20240624   gcc-13.2.0
loongarch             randconfig-002-20240624   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                 randconfig-001-20240624   gcc-13.2.0
nios2                 randconfig-002-20240624   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                            defconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                              defconfig   gcc-13.2.0
parisc                randconfig-001-20240624   gcc-13.2.0
parisc                randconfig-002-20240624   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc               randconfig-001-20240624   clang-19
powerpc               randconfig-002-20240624   gcc-13.2.0
powerpc               randconfig-003-20240624   clang-16
powerpc64             randconfig-001-20240624   clang-17
powerpc64             randconfig-002-20240624   clang-19
powerpc64             randconfig-003-20240624   clang-19
riscv                             allnoconfig   gcc-13.2.0
riscv                               defconfig   clang-19
riscv                 randconfig-001-20240624   clang-19
riscv                 randconfig-002-20240624   gcc-13.2.0
s390                              allnoconfig   clang-19
s390                                defconfig   clang-19
s390                  randconfig-001-20240624   clang-15
s390                  randconfig-002-20240624   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                                  defconfig   gcc-13.2.0
sh                    randconfig-001-20240624   gcc-13.2.0
sh                    randconfig-002-20240624   gcc-13.2.0
sparc64                             defconfig   gcc-13.2.0
sparc64               randconfig-001-20240624   gcc-13.2.0
sparc64               randconfig-002-20240624   gcc-13.2.0
um                                allnoconfig   clang-17
um                                  defconfig   clang-19
um                             i386_defconfig   gcc-13
um                    randconfig-001-20240624   clang-19
um                    randconfig-002-20240624   clang-19
um                           x86_64_defconfig   clang-15
x86_64       buildonly-randconfig-001-20240624   gcc-13
x86_64       buildonly-randconfig-002-20240624   gcc-13
x86_64       buildonly-randconfig-003-20240624   clang-18
x86_64       buildonly-randconfig-004-20240624   clang-18
x86_64       buildonly-randconfig-005-20240624   clang-18
x86_64       buildonly-randconfig-006-20240624   clang-18
x86_64                randconfig-001-20240624   clang-18
x86_64                randconfig-002-20240624   clang-18
x86_64                randconfig-003-20240624   clang-18
x86_64                randconfig-004-20240624   clang-18
x86_64                randconfig-005-20240624   gcc-11
x86_64                randconfig-006-20240624   gcc-13
x86_64                randconfig-011-20240624   clang-18
x86_64                randconfig-012-20240624   gcc-8
x86_64                randconfig-013-20240624   clang-18
x86_64                randconfig-014-20240624   gcc-8
x86_64                randconfig-015-20240624   gcc-13
x86_64                randconfig-016-20240624   clang-18
x86_64                randconfig-071-20240624   gcc-10
x86_64                randconfig-072-20240624   gcc-10
x86_64                randconfig-073-20240624   gcc-13
x86_64                randconfig-074-20240624   gcc-13
x86_64                randconfig-075-20240624   gcc-13
x86_64                randconfig-076-20240624   gcc-8
xtensa                            allnoconfig   gcc-13.2.0
xtensa                randconfig-001-20240624   gcc-13.2.0
xtensa                randconfig-002-20240624   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

