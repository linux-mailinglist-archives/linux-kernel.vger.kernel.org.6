Return-Path: <linux-kernel+bounces-239991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB639267AA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 20:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8C241C242F0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 18:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5908F1922CA;
	Wed,  3 Jul 2024 18:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dB6EiuS9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E2419067C
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 18:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720029799; cv=none; b=qDlR5zJZnIaGcbsXxOxMHFTbRuqcgHph4FVmmanjrAiB/PHrGw3h4NlZ3uGqkyjDTMJepSlR3AWjrzUNlOKNwvCjAdgtgWEkJv7n7vER5fWKNa0xXoRMEyhkEEU9DXoWz7EVEbZXa6xhZl/lsicDg1AicLrWOKvJ0SA0UJ7DV0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720029799; c=relaxed/simple;
	bh=79qYu5602aJY3EdQbkuHxkpNHe5e7OMs2hD5R/sSmhw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=qJvvvOO4/vUkVnYPUvL0nfQOXro7eE8aR02wY7etwV+HHWXqh/mpBcXgkTHpVzHlSCv/6GrK6YtVztSSl6V+P5L0mTDq6X9VPvRSj9uKS1cwMzlnVx8AemEyUVYgsCngnedlzS2syo70WUfO/jZBNTYX7GkXfTSy/qQZW/WQRVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dB6EiuS9; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720029797; x=1751565797;
  h=date:from:to:cc:subject:message-id;
  bh=79qYu5602aJY3EdQbkuHxkpNHe5e7OMs2hD5R/sSmhw=;
  b=dB6EiuS92m/ehLvx6NFCag5lzguUo6Z2wW4SqNHPW17+vLl8l9cMk8G6
   IXuZ7MfvtmDqp1ME95OiZ7DSUoVRpyWbVxCIr3rfdxUgpN/n0HRIYDeyI
   x9AybtKcsbRvABBrR86rg/dJpff/RZTwQPhqx5xjZXMe6k3q3Lm3iVM7t
   c1cokJLV/w8OtOwRIvGAtYAQnE5y2SK6ZztLC7iJMwy4ICk8AyJGWKnYT
   MNzSw/LBOjD0NvUiArTZVEb6awb6F2OyGuO6XL2mW/EwSbhsoPhDyrbhi
   +quGoTL7iRq2vFbhoEUfo2bong2w1u3OkOIDFUmkVmQ76TeehDZ9YOhwx
   Q==;
X-CSE-ConnectionGUID: 2hm70/o2SQCYRLHmfOWRMA==
X-CSE-MsgGUID: xL5SpZxXQCW4Xo4Npc1C4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11122"; a="17002045"
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="17002045"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 11:03:17 -0700
X-CSE-ConnectionGUID: bS2QyeXlTo+A9eMibCoC+g==
X-CSE-MsgGUID: UsMP0SnOTBqDptSUviw8Mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="47000722"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 03 Jul 2024 11:03:16 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sP4K1-000Q5C-0h;
	Wed, 03 Jul 2024 18:03:13 +0000
Date: Thu, 04 Jul 2024 02:02:55 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/mm] BUILD SUCCESS
 b7c35279e0da414e7d90eba76f58a16223a734cb
Message-ID: <202407040253.Srm21HH8-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/daveh/devel.git x86/mm
branch HEAD: b7c35279e0da414e7d90eba76f58a16223a734cb  x86/mm: Cleanup prctl_enable_tagged_addr() nr_bits error checking

elapsed time: 1391m

configs tested: 91
configs skipped: 206

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                            allyesconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                         haps_hs_defconfig   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                          collie_defconfig   gcc-13.2.0
arm                          gemini_defconfig   gcc-13.2.0
arm                           imxrt_defconfig   gcc-13.2.0
arm                       netwinder_defconfig   gcc-13.2.0
arm                        spear3xx_defconfig   gcc-13.2.0
arm                         wpcm450_defconfig   gcc-13.2.0
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
i386                             allmodconfig   clang-18
i386                              allnoconfig   clang-18
i386                             allyesconfig   clang-18
i386         buildonly-randconfig-001-20240703   clang-18
i386         buildonly-randconfig-002-20240703   clang-18
i386         buildonly-randconfig-003-20240703   clang-18
i386         buildonly-randconfig-004-20240703   clang-18
i386         buildonly-randconfig-005-20240703   clang-18
i386         buildonly-randconfig-006-20240703   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240703   clang-18
i386                  randconfig-002-20240703   clang-18
i386                  randconfig-003-20240703   clang-18
i386                  randconfig-004-20240703   clang-18
i386                  randconfig-005-20240703   clang-18
i386                  randconfig-006-20240703   clang-18
i386                  randconfig-011-20240703   clang-18
i386                  randconfig-012-20240703   clang-18
i386                  randconfig-013-20240703   clang-18
i386                  randconfig-014-20240703   clang-18
i386                  randconfig-015-20240703   clang-18
i386                  randconfig-016-20240703   clang-18
loongarch                        allmodconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-13.2.0
m68k                             allmodconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                         allyesconfig   gcc-13.2.0
openrisc                            defconfig   gcc-13.2.0
parisc                           allmodconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                           allyesconfig   gcc-13.2.0
parisc                              defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc                          allyesconfig   gcc-13.2.0
powerpc                   motionpro_defconfig   gcc-13.2.0
powerpc                 mpc8315_rdb_defconfig   gcc-13.2.0
riscv                            allmodconfig   gcc-13.2.0
riscv                             allnoconfig   gcc-13.2.0
riscv                            allyesconfig   gcc-13.2.0
riscv                               defconfig   gcc-13.2.0
s390                             allmodconfig   clang-19
s390                              allnoconfig   gcc-13.2.0
s390                             allyesconfig   clang-19
s390                                defconfig   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                         ap325rxa_defconfig   gcc-13.2.0
sh                                  defconfig   gcc-13.2.0
sh                          polaris_defconfig   gcc-13.2.0
sh                   rts7751r2dplus_defconfig   gcc-13.2.0
sh                              ul2_defconfig   gcc-13.2.0
sparc                       sparc64_defconfig   gcc-13.2.0
sparc64                             defconfig   gcc-13.2.0
um                               allmodconfig   gcc-13.2.0
um                                allnoconfig   gcc-13.2.0
um                               allyesconfig   gcc-13.2.0
um                                  defconfig   gcc-13.2.0
um                             i386_defconfig   gcc-13.2.0
um                           x86_64_defconfig   gcc-13.2.0
x86_64                           alldefconfig   gcc-13.2.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64                              defconfig   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                       common_defconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

