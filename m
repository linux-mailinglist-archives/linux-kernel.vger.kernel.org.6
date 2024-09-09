Return-Path: <linux-kernel+bounces-320772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E72971005
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 09:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 752D91C2203B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 07:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D041AF4E2;
	Mon,  9 Sep 2024 07:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="adTOEvuD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739531AED5D
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 07:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725867707; cv=none; b=r9e+lVrXGrZGFHvGbUcRFSgKeoyIKTXg25NGHggU85UpwO7afsXlXvNlOxDEOb3vWuVThB/wEyQRILoszYZt6iLOcDnR8aAAl1zSveLae7/pYx0cymIbovgomv6w3VigcAMxUlUxQoWJ/FsWQSVuYqBXPV3y0EFAQWkMk9p9/u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725867707; c=relaxed/simple;
	bh=MoDyjakPkZFMqrFF8HHoc01Xc8rlmhqy+gCK85Mrnq8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=htRPuPRsoNkqM7TGr+bbX8WHidvHt8E5f7LkB3gt3U3WP3fxU4zp1y4oL1zbgIvi24x0IdPHnweFmuqdwx7vFc16NBoUMWB973tKAYOGg46Wc34M3qPWGrsXkh+6+lEjCUdnhx6hlBfXW/n3qudlxwvSr1qg9f28dChmOKQaym4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=adTOEvuD; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725867706; x=1757403706;
  h=date:from:to:cc:subject:message-id;
  bh=MoDyjakPkZFMqrFF8HHoc01Xc8rlmhqy+gCK85Mrnq8=;
  b=adTOEvuDVj15Y54pfYHlQU5el7ld1QmJZXV6HgPGe3Y2oTwrHsnx24Y4
   oAa2/R0Ll42BReHiE075io0weoJKOWolEUsv4DonHO/0G5o4miZSekvDg
   dw0bzSN0f3wDBOj3Z77HGkjyS92wGLxy6sDcYG72nF/3HVAyXz0Tv/3fN
   1fjbyj+DCM4vEWaMMUj09Zvy0LyLXCWhdWo8o014LfJ1TfTBHieTM/ll8
   MPYp6B7XuF6vmbNXQj9z0rBtmPfBR5e0bMgqRq8d20yyk5H2UoFs9tkSL
   tnkO9nDl6iL/hvjWZ7o7vsuYj8a9KB3AsxUqKsIQTx9I8O0ORKmZVAJe7
   w==;
X-CSE-ConnectionGUID: bVg8M78fQv28z9lT+AJfcg==
X-CSE-MsgGUID: pkw405vFQ8mlw6+ifTMwxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11189"; a="28427531"
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="28427531"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 00:41:45 -0700
X-CSE-ConnectionGUID: vwzXsqPhSrO4wWuzVYqO7Q==
X-CSE-MsgGUID: nsV88X4yQAecb8iqbvtWiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="71528203"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 09 Sep 2024 00:41:43 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1snZ1p-000ETN-1F;
	Mon, 09 Sep 2024 07:41:41 +0000
Date: Mon, 09 Sep 2024 15:41:32 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:irq/core] BUILD SUCCESS
 a6fe30d1e3657991c832702cecb44576128d7fa3
Message-ID: <202409091530.zyC11RyP-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
branch HEAD: a6fe30d1e3657991c832702cecb44576128d7fa3  genirq: Use cpumask_intersects()

elapsed time: 1015m

configs tested: 128
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-14.1.0
alpha                            allyesconfig   clang-20
alpha                               defconfig   gcc-14.1.0
arc                              allmodconfig   clang-20
arc                               allnoconfig   gcc-14.1.0
arc                              allyesconfig   clang-20
arc                                 defconfig   gcc-14.1.0
arm                              allmodconfig   clang-20
arm                               allnoconfig   gcc-14.1.0
arm                              allyesconfig   clang-20
arm                                 defconfig   gcc-14.1.0
arm64                            allmodconfig   clang-20
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-14.1.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-14.1.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   gcc-14.1.0
hexagon                          allyesconfig   clang-20
hexagon                             defconfig   gcc-14.1.0
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-12
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-12
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240909   clang-18
i386         buildonly-randconfig-002-20240909   clang-18
i386         buildonly-randconfig-002-20240909   gcc-12
i386         buildonly-randconfig-003-20240909   clang-18
i386         buildonly-randconfig-003-20240909   gcc-12
i386         buildonly-randconfig-004-20240909   clang-18
i386         buildonly-randconfig-004-20240909   gcc-12
i386         buildonly-randconfig-005-20240909   clang-18
i386         buildonly-randconfig-006-20240909   clang-18
i386         buildonly-randconfig-006-20240909   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240909   clang-18
i386                  randconfig-002-20240909   clang-18
i386                  randconfig-002-20240909   gcc-12
i386                  randconfig-003-20240909   clang-18
i386                  randconfig-004-20240909   clang-18
i386                  randconfig-004-20240909   gcc-12
i386                  randconfig-005-20240909   clang-18
i386                  randconfig-006-20240909   clang-18
i386                  randconfig-011-20240909   clang-18
i386                  randconfig-012-20240909   clang-18
i386                  randconfig-013-20240909   clang-18
i386                  randconfig-013-20240909   gcc-12
i386                  randconfig-014-20240909   clang-18
i386                  randconfig-015-20240909   clang-18
i386                  randconfig-016-20240909   clang-18
i386                  randconfig-016-20240909   gcc-12
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-14.1.0
openrisc                          allnoconfig   clang-20
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-12
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   clang-20
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-12
parisc64                            defconfig   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   clang-20
powerpc                          allyesconfig   gcc-14.1.0
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   clang-20
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-12
s390                             allmodconfig   gcc-14.1.0
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-12
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-12
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-12
um                               allmodconfig   clang-20
um                                allnoconfig   clang-20
um                               allyesconfig   clang-20
um                                  defconfig   gcc-12
um                             i386_defconfig   gcc-12
um                           x86_64_defconfig   gcc-12
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240909   gcc-12
x86_64       buildonly-randconfig-002-20240909   gcc-12
x86_64       buildonly-randconfig-003-20240909   gcc-12
x86_64       buildonly-randconfig-004-20240909   gcc-12
x86_64       buildonly-randconfig-005-20240909   gcc-12
x86_64       buildonly-randconfig-006-20240909   gcc-12
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-11
x86_64                randconfig-001-20240909   gcc-12
x86_64                randconfig-002-20240909   gcc-12
x86_64                randconfig-003-20240909   gcc-12
x86_64                randconfig-004-20240909   gcc-12
x86_64                randconfig-005-20240909   gcc-12
x86_64                randconfig-006-20240909   gcc-12
x86_64                randconfig-011-20240909   gcc-12
x86_64                randconfig-012-20240909   gcc-12
x86_64                randconfig-013-20240909   gcc-12
x86_64                randconfig-014-20240909   gcc-12
x86_64                randconfig-015-20240909   gcc-12
x86_64                randconfig-016-20240909   gcc-12
x86_64                randconfig-071-20240909   gcc-12
x86_64                randconfig-072-20240909   gcc-12
x86_64                randconfig-073-20240909   gcc-12
x86_64                randconfig-074-20240909   gcc-12
x86_64                randconfig-075-20240909   gcc-12
x86_64                randconfig-076-20240909   gcc-12
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

