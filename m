Return-Path: <linux-kernel+bounces-283699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB0294F7E4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 22:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C6CC283E10
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 20:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052611940BE;
	Mon, 12 Aug 2024 20:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zt8vnRh1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29781991A4
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 20:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723493110; cv=none; b=oG+D2p6SyO3q2nN8QQ0U3e03uOb7C5r33g6cpmlmVpYLfNw0U4wxeUYQb4mPvHVs2PlDsKv1hPGLw0gtTxLkCkE6gbrPxz5Bn2jIvfNLJRVFYdsKQBDE6T2U3H9Xyatmsa03Q7a5WBE/MKx7UDlV2kqKN9ckG1rDH0aRrozU8W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723493110; c=relaxed/simple;
	bh=tL5ho6WlEQXaWkgkung7AhmdPx6iKw8KlWr9zDgbSRQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=VAppLp4bdBUOS/qc5bH2TePpTN97PoY+Il/2ahnCeqOlV+nFH3LDyNt+GHXTDFzLvbJKIFRQLk3RyEWrUFiLbvoYRHjiEpaaL3zMpUgWI/YqAyYZ3z74gOTCIz+A1GKpU6A0BbBVmKS8o9ACjBoAqyhWNe/lk2vaMXeyN6xG1AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zt8vnRh1; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723493107; x=1755029107;
  h=date:from:to:cc:subject:message-id;
  bh=tL5ho6WlEQXaWkgkung7AhmdPx6iKw8KlWr9zDgbSRQ=;
  b=Zt8vnRh1o7ni5yO8AFP5Ak8qkbKi2ZqHrK4bCVkGC/xxXchqOYtUaKvm
   TsXhh4nvT7BsjaQccCus/LizdQMXXKX4H1xnsf61O9kHaFwzLKxhezWvz
   7BtZSLpQnve9Ipv/yy8kyOfmkTpCP/E9JBG/9vGdTHmeBchQaMMFvPowI
   K2578rui8slf6vdm47mEPMyr81GUH/6vGIdaw51XOj4+E3xw0oZc7Oo43
   ziz1NZEsWVLapJDjO2PrJoy4mRvJwVPd9pbdI3v8wBdj0GPsRNOmBgHOv
   Svx7FwBpoNclmaj6cSTj9itNn1xOTjv/GNMI6SXg7wS4FIee24riVueui
   A==;
X-CSE-ConnectionGUID: f7qoiARhTvKhhg/OKcVYrw==
X-CSE-MsgGUID: 63nxWdFZQxK2qAoLM9uIEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="25388055"
X-IronPort-AV: E=Sophos;i="6.09,284,1716274800"; 
   d="scan'208";a="25388055"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 13:05:07 -0700
X-CSE-ConnectionGUID: YBwDk+LZQICoF/AhFbUTKg==
X-CSE-MsgGUID: wpsrTrUWQaes5rwPtxIkmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,284,1716274800"; 
   d="scan'208";a="63246583"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 12 Aug 2024 13:05:06 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sdbHr-000C8V-22;
	Mon, 12 Aug 2024 20:05:03 +0000
Date: Tue, 13 Aug 2024 04:04:34 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 b8c7cbc324dc17b9e42379b42603613580bec2d8
Message-ID: <202408130431.SeOq2W0Z-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: b8c7cbc324dc17b9e42379b42603613580bec2d8  Merge branch into tip/master: 'x86/timers'

elapsed time: 733m

configs tested: 164
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.3.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240812   gcc-13.2.0
arc                   randconfig-002-20240812   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-20
arm                              allyesconfig   gcc-14.1.0
arm                                 defconfig   clang-14
arm                        mvebu_v7_defconfig   clang-15
arm                   randconfig-001-20240812   clang-15
arm                   randconfig-002-20240812   clang-20
arm                   randconfig-003-20240812   clang-20
arm                   randconfig-004-20240812   clang-20
arm                           tegra_defconfig   gcc-14.1.0
arm64                            allmodconfig   clang-20
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-14.1.0
arm64                 randconfig-001-20240812   gcc-14.1.0
arm64                 randconfig-002-20240812   clang-20
arm64                 randconfig-003-20240812   gcc-14.1.0
arm64                 randconfig-004-20240812   clang-20
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-14.1.0
csky                  randconfig-001-20240812   gcc-14.1.0
csky                  randconfig-002-20240812   gcc-14.1.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   clang-20
hexagon                          allyesconfig   clang-20
hexagon                             defconfig   clang-20
hexagon               randconfig-001-20240812   clang-20
hexagon               randconfig-002-20240812   clang-20
i386                             allmodconfig   gcc-12
i386                              allnoconfig   gcc-12
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240812   clang-18
i386         buildonly-randconfig-002-20240812   clang-18
i386         buildonly-randconfig-003-20240812   clang-18
i386         buildonly-randconfig-004-20240812   clang-18
i386         buildonly-randconfig-005-20240812   gcc-12
i386         buildonly-randconfig-006-20240812   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240812   gcc-12
i386                  randconfig-002-20240812   gcc-12
i386                  randconfig-003-20240812   gcc-12
i386                  randconfig-004-20240812   clang-18
i386                  randconfig-005-20240812   clang-18
i386                  randconfig-006-20240812   gcc-12
i386                  randconfig-011-20240812   gcc-12
i386                  randconfig-012-20240812   clang-18
i386                  randconfig-013-20240812   clang-18
i386                  randconfig-014-20240812   clang-18
i386                  randconfig-015-20240812   clang-18
i386                  randconfig-016-20240812   clang-18
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch             randconfig-001-20240812   gcc-14.1.0
loongarch             randconfig-002-20240812   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                       m5208evb_defconfig   gcc-14.1.0
m68k                        mvme16x_defconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
mips                          rb532_defconfig   clang-20
mips                        vocore2_defconfig   clang-15
nios2                             allnoconfig   gcc-14.1.0
nios2                 randconfig-001-20240812   gcc-14.1.0
nios2                 randconfig-002-20240812   gcc-14.1.0
openrisc                         alldefconfig   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240812   gcc-14.1.0
parisc                randconfig-002-20240812   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-20
powerpc                 canyonlands_defconfig   clang-20
powerpc                        cell_defconfig   gcc-14.1.0
powerpc                    ge_imp3a_defconfig   gcc-14.1.0
powerpc                        icon_defconfig   gcc-14.1.0
powerpc                  iss476-smp_defconfig   gcc-14.1.0
powerpc                      pasemi_defconfig   clang-20
powerpc                       ppc64_defconfig   clang-20
powerpc               randconfig-001-20240812   gcc-14.1.0
powerpc               randconfig-002-20240812   gcc-14.1.0
powerpc               randconfig-003-20240812   gcc-14.1.0
powerpc                     tqm8560_defconfig   gcc-14.1.0
powerpc64             randconfig-001-20240812   clang-20
powerpc64             randconfig-002-20240812   clang-15
powerpc64             randconfig-003-20240812   clang-20
riscv                            allmodconfig   clang-20
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-20
riscv                               defconfig   clang-20
riscv                 randconfig-001-20240812   gcc-14.1.0
riscv                 randconfig-002-20240812   clang-20
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   clang-20
s390                  randconfig-001-20240812   gcc-14.1.0
s390                  randconfig-002-20240812   gcc-14.1.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                    randconfig-001-20240812   gcc-14.1.0
sh                    randconfig-002-20240812   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240812   gcc-14.1.0
sparc64               randconfig-002-20240812   gcc-14.1.0
um                               allmodconfig   clang-20
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-12
um                                  defconfig   clang-20
um                             i386_defconfig   gcc-12
um                    randconfig-001-20240812   clang-20
um                    randconfig-002-20240812   gcc-12
um                           x86_64_defconfig   clang-15
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240812   clang-18
x86_64       buildonly-randconfig-002-20240812   clang-18
x86_64       buildonly-randconfig-003-20240812   gcc-12
x86_64       buildonly-randconfig-004-20240812   clang-18
x86_64       buildonly-randconfig-005-20240812   clang-18
x86_64       buildonly-randconfig-006-20240812   clang-18
x86_64                              defconfig   gcc-11
x86_64                randconfig-001-20240812   clang-18
x86_64                randconfig-002-20240812   clang-18
x86_64                randconfig-003-20240812   gcc-12
x86_64                randconfig-004-20240812   gcc-12
x86_64                randconfig-005-20240812   gcc-11
x86_64                randconfig-006-20240812   clang-18
x86_64                randconfig-011-20240812   clang-18
x86_64                randconfig-012-20240812   gcc-12
x86_64                randconfig-013-20240812   clang-18
x86_64                randconfig-014-20240812   clang-18
x86_64                randconfig-015-20240812   gcc-12
x86_64                randconfig-016-20240812   gcc-12
x86_64                randconfig-071-20240812   gcc-12
x86_64                randconfig-072-20240812   gcc-12
x86_64                randconfig-073-20240812   gcc-12
x86_64                randconfig-074-20240812   clang-18
x86_64                randconfig-075-20240812   gcc-12
x86_64                randconfig-076-20240812   gcc-12
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240812   gcc-14.1.0
xtensa                randconfig-002-20240812   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

