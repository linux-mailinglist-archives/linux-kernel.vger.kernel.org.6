Return-Path: <linux-kernel+bounces-258046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B8D938290
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 20:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DA32B21538
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 18:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96828147C8B;
	Sat, 20 Jul 2024 18:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MDQdYYm0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068591DDF6
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 18:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721501749; cv=none; b=JyRY94CjAyCDpIC6Ky3cTYKzJxaqrQT0Hs8L86mvcY5ZhJ/Zow8cQBlKDiU3hMzDhrfWz1JQ9XeUHe+BsKNj4fsUrCr4G/Cy+KPNEesEmIXUtDkOUjVp2XwErYPWw6CzhDWC1wgxIhNyArCAEpniL5Qya2BQEbpAeqjEQ44gmXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721501749; c=relaxed/simple;
	bh=3dUBv/b8dClSEyCPimmp/gJQNrPjUe3om4BUtmyVqnk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=IDYoR/xbIA9QIwo1YvpxouovRv0QHR7tbZwKsTA+SRFIZzDQd5/bzGGPQ4AQUXH10Z+1EsotLT+AyX0DVZdl76X4fODZQuByM57ViRwaamueLjAx8PBBxKEE4qA8lLzvFCeKRzcMkl9ozt/92epaUOhF33EASu+rT25FmqPsJrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MDQdYYm0; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721501748; x=1753037748;
  h=date:from:to:cc:subject:message-id;
  bh=3dUBv/b8dClSEyCPimmp/gJQNrPjUe3om4BUtmyVqnk=;
  b=MDQdYYm0GyctWYYNjufGu07P6uXWEl7MUzybebc4vGaEWX+zJdqWAwUe
   zXY4etF9fLhxqJeAPXodRAKccDDXpujwqjzLOf9KjzImIGCjoWHGTO9QX
   Ig+WwItT8HSP2FVbXoe9+GFl3kvxLcB31in0HHaNnZ3XfKJK9arMCgplU
   ZrXn/DkgmCw2s1GOOGtTzZML+g7c0IAu7uH6084nsO2m8n2rTwdXvS4+s
   BkalKZ9U6t+BhcXhc0Be3bw9RvRyJqNP/i4y4W0xtP7cy7olRd/BOAZsb
   9FyIWcfdzaPmO2Mz39WBfGXPAGl/IV662W1jXHV62xPEoJ7o8+P1EJrlh
   Q==;
X-CSE-ConnectionGUID: uNULy6QWRjaNtaWYKqfE5w==
X-CSE-MsgGUID: 398Fx5n1T+aG/hOCYKIjOg==
X-IronPort-AV: E=McAfee;i="6700,10204,11139"; a="22871778"
X-IronPort-AV: E=Sophos;i="6.09,224,1716274800"; 
   d="scan'208";a="22871778"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2024 11:55:47 -0700
X-CSE-ConnectionGUID: mfUVOApIQ2K+ddV96XR3VQ==
X-CSE-MsgGUID: wDBesVO7Tb2R3g1S+nHQzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,224,1716274800"; 
   d="scan'208";a="51500643"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 20 Jul 2024 11:55:45 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sVFF9-000jW0-0d;
	Sat, 20 Jul 2024 18:55:43 +0000
Date: Sun, 21 Jul 2024 02:55:19 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 cc2b0d9620d8198267865b2f3025763789e9592d
Message-ID: <202407210216.VuZNTvV9-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: cc2b0d9620d8198267865b2f3025763789e9592d  Merge branch into tip/master: 'x86/mm'

elapsed time: 725m

configs tested: 169
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                          axs101_defconfig   gcc-13.2.0
arc                      axs103_smp_defconfig   gcc-13.2.0
arc                   randconfig-001-20240720   gcc-13.2.0
arc                   randconfig-002-20240720   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-19
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-14.1.0
arm                   randconfig-001-20240720   clang-15
arm                   randconfig-002-20240720   gcc-14.1.0
arm                   randconfig-003-20240720   gcc-14.1.0
arm                   randconfig-004-20240720   gcc-14.1.0
arm                           stm32_defconfig   gcc-14.1.0
arm64                            allmodconfig   clang-19
arm64                             allnoconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-14.1.0
arm64                 randconfig-001-20240720   gcc-14.1.0
arm64                 randconfig-002-20240720   clang-17
arm64                 randconfig-003-20240720   gcc-14.1.0
arm64                 randconfig-004-20240720   clang-19
csky                              allnoconfig   gcc-13.2.0
csky                              allnoconfig   gcc-14.1.0
csky                  randconfig-001-20240720   gcc-14.1.0
csky                  randconfig-002-20240720   gcc-14.1.0
hexagon                          allmodconfig   clang-19
hexagon                           allnoconfig   clang-19
hexagon                          allyesconfig   clang-19
hexagon               randconfig-001-20240720   clang-16
hexagon               randconfig-002-20240720   clang-19
i386                             allmodconfig   gcc-13
i386                              allnoconfig   gcc-13
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240720   clang-18
i386         buildonly-randconfig-002-20240720   gcc-13
i386         buildonly-randconfig-003-20240720   gcc-13
i386         buildonly-randconfig-004-20240720   clang-18
i386         buildonly-randconfig-005-20240720   clang-18
i386         buildonly-randconfig-006-20240720   gcc-11
i386                                defconfig   clang-18
i386                  randconfig-001-20240720   gcc-7
i386                  randconfig-002-20240720   clang-18
i386                  randconfig-003-20240720   clang-18
i386                  randconfig-004-20240720   clang-18
i386                  randconfig-005-20240720   gcc-13
i386                  randconfig-006-20240720   gcc-11
i386                  randconfig-011-20240720   gcc-13
i386                  randconfig-012-20240720   gcc-13
i386                  randconfig-013-20240720   gcc-13
i386                  randconfig-014-20240720   gcc-13
i386                  randconfig-015-20240720   gcc-12
i386                  randconfig-016-20240720   gcc-13
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch             randconfig-001-20240720   gcc-14.1.0
loongarch             randconfig-002-20240720   gcc-14.1.0
m68k                             alldefconfig   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                       m5249evb_defconfig   gcc-14.1.0
m68k                        m5407c3_defconfig   gcc-14.1.0
m68k                        mvme147_defconfig   gcc-14.1.0
m68k                           sun3_defconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
mips                              allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-14.1.0
mips                     decstation_defconfig   gcc-13.2.0
mips                       lemote2f_defconfig   gcc-13.2.0
mips                          rb532_defconfig   clang-19
nios2                             allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-14.1.0
nios2                 randconfig-001-20240720   gcc-14.1.0
nios2                 randconfig-002-20240720   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240720   gcc-14.1.0
parisc                randconfig-002-20240720   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-19
powerpc                      pmac32_defconfig   clang-19
powerpc                         ps3_defconfig   gcc-14.1.0
powerpc               randconfig-001-20240720   clang-19
powerpc               randconfig-002-20240720   clang-19
powerpc               randconfig-003-20240720   gcc-14.1.0
powerpc                     redwood_defconfig   clang-19
powerpc64             randconfig-001-20240720   clang-19
powerpc64             randconfig-002-20240720   clang-19
powerpc64             randconfig-003-20240720   gcc-14.1.0
riscv                            allmodconfig   clang-19
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-19
riscv                               defconfig   clang-19
riscv                 randconfig-001-20240720   clang-19
riscv                 randconfig-002-20240720   gcc-14.1.0
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   clang-19
s390                  randconfig-001-20240720   gcc-14.1.0
s390                  randconfig-002-20240720   clang-15
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                        apsh4ad0a_defconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                    randconfig-001-20240720   gcc-14.1.0
sh                    randconfig-002-20240720   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240720   gcc-14.1.0
sparc64               randconfig-002-20240720   gcc-14.1.0
um                               allmodconfig   clang-19
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-13
um                                  defconfig   clang-19
um                             i386_defconfig   gcc-13
um                    randconfig-001-20240720   gcc-13
um                    randconfig-002-20240720   clang-15
um                           x86_64_defconfig   clang-15
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240720   clang-18
x86_64       buildonly-randconfig-002-20240720   gcc-13
x86_64       buildonly-randconfig-003-20240720   clang-18
x86_64       buildonly-randconfig-004-20240720   clang-18
x86_64       buildonly-randconfig-005-20240720   gcc-13
x86_64       buildonly-randconfig-006-20240720   gcc-13
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240720   clang-18
x86_64                randconfig-002-20240720   gcc-13
x86_64                randconfig-003-20240720   clang-18
x86_64                randconfig-004-20240720   clang-18
x86_64                randconfig-005-20240720   clang-18
x86_64                randconfig-006-20240720   gcc-13
x86_64                randconfig-011-20240720   gcc-13
x86_64                randconfig-012-20240720   clang-18
x86_64                randconfig-013-20240720   gcc-13
x86_64                randconfig-014-20240720   clang-18
x86_64                randconfig-015-20240720   gcc-13
x86_64                randconfig-016-20240720   gcc-13
x86_64                randconfig-071-20240720   clang-18
x86_64                randconfig-072-20240720   gcc-13
x86_64                randconfig-073-20240720   gcc-13
x86_64                randconfig-074-20240720   gcc-9
x86_64                randconfig-075-20240720   gcc-13
x86_64                randconfig-076-20240720   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240720   gcc-14.1.0
xtensa                randconfig-002-20240720   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

