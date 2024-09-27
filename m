Return-Path: <linux-kernel+bounces-341300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9760987DF5
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 07:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EBAD1F22173
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 05:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D57172BCE;
	Fri, 27 Sep 2024 05:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ksagsEdG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904A815B15D
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 05:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727416021; cv=none; b=npRwKGoCP44XA7q7I/hqDVYq/PqRjb1uQA74lEV2VYmGmBxE3Z4LTwSs4/VOM4LaVJYMsSFl1Mfs+bqux34BAn0oX5dHn0jHsFW4U6tKIOvR+z/AH7x75EYx5dkrY/V3yauTzCTxzArYHasiEEybWuZI7PTSAPH3QN7Te6pjkiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727416021; c=relaxed/simple;
	bh=RgQ1DMWPUY7ekyAjN1wh3P6JUudFBkdvtmweWCoc2bA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=XER+rKok/6Py2BudWMg7NOAlDd6kgktUHHkO5YclYvgNY1TDN0mS+18OuornIxsx21CXQeylABVqwJPbPtF9KHFzcuMUFsYl6UtL6W79PDJfJYetM7AMNi0+2FCRRdePKPwgC9/ngKhdFL4MJi8/yafAQqNHJo7L//i+HD0hgE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ksagsEdG; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727416020; x=1758952020;
  h=date:from:to:cc:subject:message-id;
  bh=RgQ1DMWPUY7ekyAjN1wh3P6JUudFBkdvtmweWCoc2bA=;
  b=ksagsEdGzmv6BuAje9nI8D2a3A1tF1qLZjzV92LISVh17ubKFHNKFSw7
   Ei3iO2/xZYaweyfjiaXCuo6EzOnHJdrWPc+X5/Nf3oAHV0YBpVAx6dTki
   /X7n+wF84nJ38NXLxZhNIKiAcb8XR9DiSn7NHSF3StmFU/bowc8NBRDSF
   ZzTVCMzXzrgQERlXqjqiRuVL3+YCwv4P5b+AUR/whgd7wuz/AwzZl8sVr
   IoIffdMI1zyUkjF14apA2JTN8AOeWd9N1Z3vq+16CX1b8FlsqYNTdp57O
   4cF00/trdutZwOdr5cO3l3izsNXV8nMlshYRWFczIObWeMFXGWsed6LIX
   A==;
X-CSE-ConnectionGUID: Ool3WRpRQsqmZvLk1PQoLg==
X-CSE-MsgGUID: aq+T9NJ9SX+v9i0Vwmy9zQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="26682038"
X-IronPort-AV: E=Sophos;i="6.11,157,1725346800"; 
   d="scan'208";a="26682038"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 22:46:59 -0700
X-CSE-ConnectionGUID: U4xSjAZPSZ6FF/XI/RihPQ==
X-CSE-MsgGUID: YZPpsan8SQea/enMNwG5DQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,157,1725346800"; 
   d="scan'208";a="72720714"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 26 Sep 2024 22:46:58 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1su3od-000LX5-0c;
	Fri, 27 Sep 2024 05:46:55 +0000
Date: Fri, 27 Sep 2024 13:46:24 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 33a082493a691475e5fb5d09e2bd1c257c94c853
Message-ID: <202409271319.V82fzHoB-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 33a082493a691475e5fb5d09e2bd1c257c94c853  Merge branch into tip/master: 'x86/splitlock'

elapsed time: 1124m

configs tested: 209
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-13.3.0
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                            allyesconfig    gcc-13.3.0
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-14.1.0
arc                   randconfig-001-20240927    gcc-13.2.0
arc                   randconfig-001-20240927    gcc-14.1.0
arc                   randconfig-002-20240927    gcc-13.2.0
arc                   randconfig-002-20240927    gcc-14.1.0
arm                              allmodconfig    clang-20
arm                              allmodconfig    gcc-14.1.0
arm                               allnoconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                              allyesconfig    gcc-14.1.0
arm                                 defconfig    gcc-14.1.0
arm                       multi_v4t_defconfig    gcc-14.1.0
arm                          pxa910_defconfig    gcc-14.1.0
arm                   randconfig-001-20240927    clang-20
arm                   randconfig-001-20240927    gcc-14.1.0
arm                   randconfig-002-20240927    gcc-14.1.0
arm                   randconfig-003-20240927    clang-20
arm                   randconfig-003-20240927    gcc-14.1.0
arm                   randconfig-004-20240927    clang-20
arm                   randconfig-004-20240927    gcc-14.1.0
arm                         s5pv210_defconfig    gcc-14.1.0
arm                           tegra_defconfig    gcc-14.1.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
arm64                 randconfig-001-20240927    gcc-14.1.0
arm64                 randconfig-002-20240927    gcc-14.1.0
arm64                 randconfig-003-20240927    gcc-14.1.0
arm64                 randconfig-004-20240927    clang-15
arm64                 randconfig-004-20240927    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
csky                  randconfig-001-20240927    gcc-14.1.0
csky                  randconfig-002-20240927    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
hexagon               randconfig-001-20240927    clang-20
hexagon               randconfig-001-20240927    gcc-14.1.0
hexagon               randconfig-002-20240927    clang-16
hexagon               randconfig-002-20240927    gcc-14.1.0
i386                             allmodconfig    clang-18
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-18
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-18
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20240927    clang-18
i386        buildonly-randconfig-002-20240927    clang-18
i386        buildonly-randconfig-002-20240927    gcc-12
i386        buildonly-randconfig-003-20240927    clang-18
i386        buildonly-randconfig-004-20240927    clang-18
i386        buildonly-randconfig-005-20240927    clang-18
i386        buildonly-randconfig-006-20240927    clang-18
i386        buildonly-randconfig-006-20240927    gcc-12
i386                                defconfig    clang-18
i386                  randconfig-001-20240927    clang-18
i386                  randconfig-002-20240927    clang-18
i386                  randconfig-003-20240927    clang-18
i386                  randconfig-004-20240927    clang-18
i386                  randconfig-004-20240927    gcc-12
i386                  randconfig-005-20240927    clang-18
i386                  randconfig-006-20240927    clang-18
i386                  randconfig-011-20240927    clang-18
i386                  randconfig-011-20240927    gcc-12
i386                  randconfig-012-20240927    clang-18
i386                  randconfig-013-20240927    clang-18
i386                  randconfig-013-20240927    gcc-12
i386                  randconfig-014-20240927    clang-18
i386                  randconfig-014-20240927    gcc-12
i386                  randconfig-015-20240927    clang-18
i386                  randconfig-015-20240927    gcc-11
i386                  randconfig-016-20240927    clang-18
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
loongarch             randconfig-001-20240927    gcc-14.1.0
loongarch             randconfig-002-20240927    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
m68k                       m5475evb_defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                  cavium_octeon_defconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
nios2                 randconfig-001-20240927    gcc-14.1.0
nios2                 randconfig-002-20240927    gcc-14.1.0
openrisc                          allnoconfig    gcc-14.1.0
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    gcc-14.1.0
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20240927    gcc-14.1.0
parisc                randconfig-002-20240927    gcc-14.1.0
parisc64                            defconfig    gcc-14.1.0
powerpc                    adder875_defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    gcc-14.1.0
powerpc                          allyesconfig    clang-20
powerpc                          allyesconfig    gcc-14.1.0
powerpc                      ep88xc_defconfig    gcc-14.1.0
powerpc               randconfig-001-20240927    gcc-14.1.0
powerpc               randconfig-002-20240927    gcc-14.1.0
powerpc               randconfig-003-20240927    gcc-14.1.0
powerpc64             randconfig-001-20240927    clang-20
powerpc64             randconfig-001-20240927    gcc-14.1.0
powerpc64             randconfig-002-20240927    clang-20
powerpc64             randconfig-002-20240927    gcc-14.1.0
powerpc64             randconfig-003-20240927    clang-20
powerpc64             randconfig-003-20240927    gcc-14.1.0
riscv                            allmodconfig    clang-20
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    gcc-14.1.0
riscv                            allyesconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20240927    clang-20
riscv                 randconfig-001-20240927    gcc-14.1.0
riscv                 randconfig-002-20240927    gcc-14.1.0
s390                             allmodconfig    clang-20
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20240927    gcc-14.1.0
s390                  randconfig-002-20240927    gcc-14.1.0
s390                       zfcpdump_defconfig    gcc-14.1.0
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                        edosk7705_defconfig    gcc-14.1.0
sh                    randconfig-001-20240927    gcc-14.1.0
sh                    randconfig-002-20240927    gcc-14.1.0
sh                             shx3_defconfig    gcc-14.1.0
sh                          urquell_defconfig    gcc-14.1.0
sparc                            alldefconfig    gcc-14.1.0
sparc                            allmodconfig    gcc-14.1.0
sparc                       sparc32_defconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20240927    gcc-14.1.0
sparc64               randconfig-002-20240927    gcc-14.1.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                               allyesconfig    clang-20
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20240927    clang-17
um                    randconfig-001-20240927    gcc-14.1.0
um                    randconfig-002-20240927    clang-20
um                    randconfig-002-20240927    gcc-14.1.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64      buildonly-randconfig-001-20240927    clang-18
x86_64      buildonly-randconfig-002-20240927    clang-18
x86_64      buildonly-randconfig-003-20240927    clang-18
x86_64      buildonly-randconfig-004-20240927    clang-18
x86_64      buildonly-randconfig-005-20240927    clang-18
x86_64      buildonly-randconfig-006-20240927    clang-18
x86_64                              defconfig    clang-18
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-18
x86_64                randconfig-001-20240927    clang-18
x86_64                randconfig-002-20240927    clang-18
x86_64                randconfig-003-20240927    clang-18
x86_64                randconfig-004-20240927    clang-18
x86_64                randconfig-005-20240927    clang-18
x86_64                randconfig-006-20240927    clang-18
x86_64                randconfig-011-20240927    clang-18
x86_64                randconfig-012-20240927    clang-18
x86_64                randconfig-013-20240927    clang-18
x86_64                randconfig-014-20240927    clang-18
x86_64                randconfig-015-20240927    clang-18
x86_64                randconfig-016-20240927    clang-18
x86_64                randconfig-071-20240927    clang-18
x86_64                randconfig-072-20240927    clang-18
x86_64                randconfig-073-20240927    clang-18
x86_64                randconfig-074-20240927    clang-18
x86_64                randconfig-075-20240927    clang-18
x86_64                randconfig-076-20240927    clang-18
x86_64                               rhel-8.3    gcc-12
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0
xtensa                randconfig-001-20240927    gcc-14.1.0
xtensa                randconfig-002-20240927    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

