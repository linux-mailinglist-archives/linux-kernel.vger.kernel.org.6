Return-Path: <linux-kernel+bounces-215045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DB0908DB1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 16:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57B1B1F23AF5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 14:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4693610A0D;
	Fri, 14 Jun 2024 14:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GBpReznw"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89766F9E9
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 14:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718376187; cv=none; b=m8EoCFtmSCx6+uEz106l2S8QLa+08PTaoGFTG5TpUNoWxrvcw04nlRZuScALUZM1nWKsq4mOwsQpaCe/ppy39RYgy6Qhqe1L266IuRrUjhz61kOG+J/6RwiagCnBUuMMsrXenDOmjjW2y2ZpD8zTkD9hwGHmzgIgA52X5HRY9Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718376187; c=relaxed/simple;
	bh=VVvMhZh8EjxVQFUwhQdEGd6NG0T65QKlUJa6Vyl+t+w=;
	h=Date:From:To:Cc:Subject:Message-ID; b=fcNlvjRhiqV9QXmqC2sBSoD220uyYrOpA2Dz1BjwxDibRiYa6yu7cLcJJVPr5EY7zr7Xo2kTG75nuqKEIvW7x5nz4vu/vrIwRS+W9CCurXjPzO4n/82H/l5cx3nZYa2W8fatFxYWuxgjGSyo+SKnfL6YDyAQwVWH1qzP9Lh32iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GBpReznw; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718376185; x=1749912185;
  h=date:from:to:cc:subject:message-id;
  bh=VVvMhZh8EjxVQFUwhQdEGd6NG0T65QKlUJa6Vyl+t+w=;
  b=GBpReznwGXuW/6AnJppQStM2+a/3Q3RId3vz1R7xlB8eyJqVeNpKMK4p
   IoMzcmstUhDhwZGuGtLsx1rkr9wtSgxWyrmo5+WD5SkYCJ/zrSNChFC03
   N3h7RNo1d0MoiDh7ua8gugWkSh1nUNRCRYQZQcEJwwp92nbwkfNfiEdov
   glt/m6Y67rcwY9mvzuW2YalMeZPaGsR3E2NF6VbYyFczRxmZ6SJvuGCrA
   JZUocCz0Fj6kCk4M/YFFu0767bU1QsiSa9Qd1IClVSTeu0L+CkFgeLeqY
   hR6vvkmm/mhCODi4Rk5BFm+KQ9dC0rULI7U/9OUSHHTkMNvKF9foUHCWJ
   w==;
X-CSE-ConnectionGUID: hS/JBz5gQl2cL83odlYpPA==
X-CSE-MsgGUID: JovrtGvjSeWYm12ZvBGh3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11103"; a="15413305"
X-IronPort-AV: E=Sophos;i="6.08,238,1712646000"; 
   d="scan'208";a="15413305"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 07:43:05 -0700
X-CSE-ConnectionGUID: STREyiiFRHyonrQOXrHDVQ==
X-CSE-MsgGUID: VUUioRxETTCrIlohCYdRUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,238,1712646000"; 
   d="scan'208";a="71714179"
Received: from lkp-server01.sh.intel.com (HELO 9e3ee4e9e062) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 14 Jun 2024 07:43:04 -0700
Received: from kbuild by 9e3ee4e9e062 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sI88s-0001On-0D;
	Fri, 14 Jun 2024 14:43:02 +0000
Date: Fri, 14 Jun 2024 22:42:29 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:WIP.x86/fpu] BUILD SUCCESS
 26553b73af106045898fb7a951e3069cf563779d
Message-ID: <202406142226.OHvB9isk-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git WIP.x86/fpu
branch HEAD: 26553b73af106045898fb7a951e3069cf563779d  x86/fpu: Fix stale comment in ex_handler_fprestore()

elapsed time: 1721m

configs tested: 112
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                            allyesconfig   gcc-13.2.0
alpha                               defconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240614   gcc-13.2.0
arc                   randconfig-002-20240614   gcc-13.2.0
arm                               allnoconfig   clang-19
arm                                 defconfig   clang-14
arm                   randconfig-001-20240614   gcc-13.2.0
arm                   randconfig-002-20240614   gcc-13.2.0
arm                   randconfig-003-20240614   gcc-13.2.0
arm                   randconfig-004-20240614   clang-19
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240614   gcc-13.2.0
arm64                 randconfig-002-20240614   clang-19
arm64                 randconfig-003-20240614   gcc-13.2.0
arm64                 randconfig-004-20240614   clang-19
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240614   gcc-13.2.0
csky                  randconfig-002-20240614   gcc-13.2.0
hexagon                          allmodconfig   clang-19
hexagon                           allnoconfig   clang-19
hexagon                          allyesconfig   clang-19
hexagon                             defconfig   clang-19
hexagon               randconfig-001-20240614   clang-19
hexagon               randconfig-002-20240614   clang-19
i386         buildonly-randconfig-001-20240614   clang-18
i386         buildonly-randconfig-002-20240614   clang-18
i386         buildonly-randconfig-003-20240614   gcc-12
i386         buildonly-randconfig-004-20240614   gcc-8
i386         buildonly-randconfig-005-20240614   gcc-13
i386         buildonly-randconfig-006-20240614   gcc-10
i386                  randconfig-001-20240614   gcc-13
i386                  randconfig-002-20240614   gcc-8
i386                  randconfig-003-20240614   gcc-13
i386                  randconfig-004-20240614   clang-18
i386                  randconfig-005-20240614   gcc-13
i386                  randconfig-006-20240614   gcc-10
i386                  randconfig-011-20240614   gcc-13
i386                  randconfig-012-20240614   clang-18
i386                  randconfig-013-20240614   gcc-13
i386                  randconfig-014-20240614   gcc-13
i386                  randconfig-015-20240614   clang-18
i386                  randconfig-016-20240614   clang-18
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240614   gcc-13.2.0
loongarch             randconfig-002-20240614   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
m68k                                defconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240614   gcc-13.2.0
nios2                 randconfig-002-20240614   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                            defconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                              defconfig   gcc-13.2.0
parisc                randconfig-001-20240614   gcc-13.2.0
parisc                randconfig-002-20240614   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc               randconfig-001-20240614   gcc-13.2.0
powerpc               randconfig-002-20240614   clang-19
powerpc               randconfig-003-20240614   gcc-13.2.0
powerpc64             randconfig-001-20240614   clang-19
powerpc64             randconfig-002-20240614   gcc-13.2.0
powerpc64             randconfig-003-20240614   gcc-13.2.0
riscv                             allnoconfig   gcc-13.2.0
riscv                               defconfig   clang-19
riscv                 randconfig-001-20240614   gcc-13.2.0
riscv                 randconfig-002-20240614   clang-19
s390                              allnoconfig   clang-19
s390                                defconfig   clang-19
s390                  randconfig-001-20240614   gcc-13.2.0
s390                  randconfig-002-20240614   clang-19
sh                                allnoconfig   gcc-13.2.0
sh                                  defconfig   gcc-13.2.0
sh                    randconfig-001-20240614   gcc-13.2.0
sh                    randconfig-002-20240614   gcc-13.2.0
sparc                             allnoconfig   gcc-13.2.0
sparc                               defconfig   gcc-13.2.0
sparc64                             defconfig   gcc-13.2.0
sparc64               randconfig-001-20240614   gcc-13.2.0
sparc64               randconfig-002-20240614   gcc-13.2.0
um                               allmodconfig   clang-19
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-13
um                                  defconfig   clang-19
um                             i386_defconfig   gcc-13
um                    randconfig-001-20240614   gcc-13
um                    randconfig-002-20240614   gcc-13
um                           x86_64_defconfig   clang-15
x86_64       buildonly-randconfig-001-20240614   clang-18
x86_64       buildonly-randconfig-002-20240614   gcc-8
x86_64       buildonly-randconfig-003-20240614   clang-18
x86_64       buildonly-randconfig-004-20240614   gcc-8
x86_64       buildonly-randconfig-005-20240614   gcc-10
x86_64       buildonly-randconfig-006-20240614   clang-18
x86_64                randconfig-001-20240614   clang-18
x86_64                randconfig-002-20240614   clang-18
x86_64                randconfig-003-20240614   clang-18
x86_64                randconfig-004-20240614   gcc-11
xtensa                            allnoconfig   gcc-13.2.0
xtensa                randconfig-001-20240614   gcc-13.2.0
xtensa                randconfig-002-20240614   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

