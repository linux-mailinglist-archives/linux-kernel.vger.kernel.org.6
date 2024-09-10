Return-Path: <linux-kernel+bounces-323962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9E0974627
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 00:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E24C11C25BD5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 22:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6551AC423;
	Tue, 10 Sep 2024 22:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OHVfhpNP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C72C1A7040
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 22:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726008683; cv=none; b=CESlFuwVQzK5hvgSjrbF436OYwlBt4al/UCK8iXS9+YC4NrOaCVNoiuUE7m0KmUsPtT3ZDAMwPlpJx+E0KDqKjJa6Pk2Syj2Vv+vwEtGTIgMT9IDtvY/8T49fhxph4Bkf9M65NSzwGbKv28M/WHOZGAMCX8FTdAZ1x5FXHHZPfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726008683; c=relaxed/simple;
	bh=4QWvQSn5UdO0QXaOn4Z2MWrs2b4h1E2apvh4aQB4p/g=;
	h=Date:From:To:Cc:Subject:Message-ID; b=a4Qc+UU2qZLmv1kvuHqgljfIg2Y3+RqQknKAnCocMVE+CaXgjbjIEgWSPvoTuF8k0I3a5y6VUMP+nYa3WhGh0y1GrkCQFcWwlqfgNHGbE+A2bLeqwiII9USbmADV3u5KGgV/AlB6VrMPjzWQzWDkCP94WBiWdgsBolC3sn9xhxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OHVfhpNP; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726008681; x=1757544681;
  h=date:from:to:cc:subject:message-id;
  bh=4QWvQSn5UdO0QXaOn4Z2MWrs2b4h1E2apvh4aQB4p/g=;
  b=OHVfhpNPZJFMUZgCLeocm8+SUihvUxHx0YIB0oV/HA38AaJT2xx3Au/a
   3t3X1XlwVDg5rfAaXsvegeU3D1qqR9J3UuVoyj/iOsQSiRoPiPXEsVyNg
   YpkVcbhpuy7YggAiUZ8wa1HAZLOHy9d42bWGo84LFg7pIi1QGpvH72vUk
   lsAIC8SNpjW2YFCBN6sUjsXaJpodekBEFUDNkOnUWKJjSdND50cKqngmf
   MXZGqFvUVzDVieQ7e30rJrIqP6eejaS0BsntG5fgCQKAq4GmZEzF8agIT
   4jdLNLoBD+MTSueIfFeLS8KHPZ+qw0MzBVgv0fMIu0crPvEIDQBI+v3gm
   g==;
X-CSE-ConnectionGUID: lUv7wYglSp+oJber1+wUpQ==
X-CSE-MsgGUID: d6ig3oKOTluhD0NQXsIPOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="35379278"
X-IronPort-AV: E=Sophos;i="6.10,218,1719903600"; 
   d="scan'208";a="35379278"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 15:51:19 -0700
X-CSE-ConnectionGUID: 6Q+UP0kVQSeUf8VEgRZjLQ==
X-CSE-MsgGUID: VBnle7YfRluAXPOZbz959A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,218,1719903600"; 
   d="scan'208";a="67188349"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 10 Sep 2024 15:51:16 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1so9hY-0002nq-1N;
	Tue, 10 Sep 2024 22:51:12 +0000
Date: Wed, 11 Sep 2024 06:50:35 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:perf/core] BUILD SUCCESS
 5e645f31139183ac9a282238da18ca6bbc1c6f4a
Message-ID: <202409110633.u7siy8OE-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core
branch HEAD: 5e645f31139183ac9a282238da18ca6bbc1c6f4a  Merge branch 'perf/urgent' into perf/core, to pick up fixes

elapsed time: 725m

configs tested: 95
configs skipped: 129

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-14.1.0
alpha                            allyesconfig   clang-20
alpha                               defconfig   gcc-14.1.0
arc                               allnoconfig   gcc-14.1.0
arc                                 defconfig   gcc-14.1.0
arm                               allnoconfig   gcc-14.1.0
arm                       aspeed_g4_defconfig   gcc-14.1.0
arm                                 defconfig   gcc-14.1.0
arm                      footbridge_defconfig   gcc-14.1.0
arm                            hisi_defconfig   gcc-14.1.0
arm                           imxrt_defconfig   gcc-14.1.0
arm                            mmp2_defconfig   gcc-14.1.0
arm                        realview_defconfig   gcc-14.1.0
arm                         s5pv210_defconfig   gcc-14.1.0
arm                       spear13xx_defconfig   gcc-14.1.0
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-14.1.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-14.1.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   gcc-14.1.0
hexagon                          allyesconfig   clang-20
hexagon                             defconfig   gcc-14.1.0
i386                             allmodconfig   clang-18
i386                              allnoconfig   clang-18
i386                             allyesconfig   clang-18
i386         buildonly-randconfig-001-20240911   gcc-12
i386         buildonly-randconfig-002-20240911   gcc-12
i386         buildonly-randconfig-003-20240911   gcc-12
i386         buildonly-randconfig-004-20240911   gcc-12
i386         buildonly-randconfig-005-20240911   gcc-12
i386         buildonly-randconfig-006-20240911   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240911   gcc-12
i386                  randconfig-002-20240911   gcc-12
i386                  randconfig-003-20240911   gcc-12
i386                  randconfig-004-20240911   gcc-12
i386                  randconfig-005-20240911   gcc-12
i386                  randconfig-006-20240911   gcc-12
i386                  randconfig-011-20240911   gcc-12
i386                  randconfig-012-20240911   gcc-12
i386                  randconfig-013-20240911   gcc-12
i386                  randconfig-014-20240911   gcc-12
i386                  randconfig-015-20240911   gcc-12
i386                  randconfig-016-20240911   gcc-12
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                          atari_defconfig   gcc-14.1.0
m68k                                defconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                          defconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
mips                           ip32_defconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-12
parisc                           allmodconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-12
parisc64                            defconfig   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                          allyesconfig   gcc-14.1.0
powerpc                   currituck_defconfig   gcc-14.1.0
powerpc                       maple_defconfig   gcc-14.1.0
powerpc                 mpc834x_itx_defconfig   gcc-14.1.0
powerpc                     rainier_defconfig   gcc-14.1.0
riscv                            allmodconfig   gcc-14.1.0
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-12
s390                             allmodconfig   gcc-14.1.0
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-12
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-12
sh                          sdk7780_defconfig   gcc-14.1.0
sh                           se7206_defconfig   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-12
um                               allmodconfig   clang-20
um                               allyesconfig   clang-20
um                                  defconfig   gcc-12
um                             i386_defconfig   gcc-12
um                           x86_64_defconfig   gcc-12
x86_64                           alldefconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64                              defconfig   clang-18
x86_64                                  kexec   gcc-12
x86_64                          rhel-8.3-rust   clang-18
x86_64                               rhel-8.3   gcc-12
xtensa                            allnoconfig   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

