Return-Path: <linux-kernel+bounces-285855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 078C195137A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 06:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A2FB1F24699
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 04:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F044D131;
	Wed, 14 Aug 2024 04:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IgJ3vKTY"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A152182B5
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 04:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723609544; cv=none; b=qhLKFe1b+gYES8dM/+vRQco0r0c4PGZeZsAFLifejgZc8/ChuK9EOvoKnqYkYRfCeFSjbny8CffManhvKvmyApzjUOV0sf3s4n3IN3yXqHIqiF45QvzRdTxNcsht8BBhazl+R03bpobOTbYUCBjWLvi3qnzuZoG2Y3eXY1A+fuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723609544; c=relaxed/simple;
	bh=IAXwZbG/yxHmgXLz9PP+3jcKw4QniPX3uOcB60JQtU0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=eQJt1EkmSmKD1raPNM4WaZcnZNIGDDJLIZqcszlYIkza5E7r/NFaPiivfnXjLKXeMkxjvA4EE3/3n6MWJkM1DVx/poJRorJHfm5SOcO2NpfQYrPa+a7CWDRyB2EaxA09jUau0Y+B3HcixdmLhIeQdRivKMAiKwSIZ46Nx4qRAGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IgJ3vKTY; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723609542; x=1755145542;
  h=date:from:to:cc:subject:message-id;
  bh=IAXwZbG/yxHmgXLz9PP+3jcKw4QniPX3uOcB60JQtU0=;
  b=IgJ3vKTYmX68NXuuwvJlVV5ocKZvW6B9bGA5yLWggHbUOxnrntqI8uIu
   VGkxFOgvtRyqget8cHBCDzxEeLvfOEYkEPMzLs3xmLtd85r6lmyFXt0R4
   TyNeRL7EwNgE+exlg398DuNzIfoyvbV1LLZPhTejcs+vzRpqIJjW+B7x1
   Q1o71jm5VE+kBhNsD8vOOaEJuzODp/YX11kETywMhnq0KDoGRW4BrUJl3
   zqC2M3d/Qrvcoo4Chg+JgRPMXy1J7TFGvsUKZr05Ur42uU0DGGZlcXBpy
   lzC4mLjfYe7nls163AxNhuPPDUd7L85/Bc3q9U52mPLjeo27ZmM+aDGpK
   g==;
X-CSE-ConnectionGUID: cKNd3hLYTp+Fe/+YoYmaeg==
X-CSE-MsgGUID: KCRUwfOPQmW+tIok4JEFiQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="39254821"
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="39254821"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 21:25:42 -0700
X-CSE-ConnectionGUID: HIpWcOLuTvaVEvrW/z/MVQ==
X-CSE-MsgGUID: lRkzhUJXS3el6mYm7qIHCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="63730552"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 13 Aug 2024 21:25:41 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1se5Zp-00016u-2u;
	Wed, 14 Aug 2024 04:25:37 +0000
Date: Wed, 14 Aug 2024 12:24:47 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:irq/core] BUILD SUCCESS
 50059ccaa3c98badeae197b918e2ae06bb6f5162
Message-ID: <202408141245.p44TdRV4-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
branch HEAD: 50059ccaa3c98badeae197b918e2ae06bb6f5162  irqdomain: Always associate interrupts for legacy domains

elapsed time: 844m

configs tested: 140
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                           tb10x_defconfig   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                              allyesconfig   gcc-14.1.0
arm                         assabet_defconfig   gcc-13.2.0
arm                                 defconfig   gcc-13.2.0
arm                       omap2plus_defconfig   gcc-13.2.0
arm                           sunxi_defconfig   gcc-13.2.0
arm64                            allmodconfig   clang-20
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
hexagon                          allmodconfig   clang-20
hexagon                          allyesconfig   clang-20
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-12
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-12
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240814   clang-18
i386         buildonly-randconfig-002-20240814   clang-18
i386         buildonly-randconfig-003-20240814   clang-18
i386         buildonly-randconfig-004-20240814   clang-18
i386         buildonly-randconfig-005-20240814   clang-18
i386         buildonly-randconfig-006-20240814   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240814   clang-18
i386                  randconfig-002-20240814   clang-18
i386                  randconfig-003-20240814   clang-18
i386                  randconfig-004-20240814   clang-18
i386                  randconfig-005-20240814   clang-18
i386                  randconfig-006-20240814   clang-18
i386                  randconfig-011-20240814   clang-18
i386                  randconfig-012-20240814   clang-18
i386                  randconfig-013-20240814   clang-18
i386                  randconfig-014-20240814   clang-18
i386                  randconfig-015-20240814   clang-18
i386                  randconfig-016-20240814   clang-18
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                       bmips_be_defconfig   gcc-13.2.0
mips                         rt305x_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   gcc-14.1.0
powerpc                      katmai_defconfig   gcc-13.2.0
powerpc                 mpc837x_rdb_defconfig   gcc-13.2.0
powerpc                      ppc44x_defconfig   gcc-13.2.0
powerpc                 xes_mpc85xx_defconfig   gcc-13.2.0
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-14.1.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-13.2.0
s390                                defconfig   gcc-14.1.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                          landisk_defconfig   gcc-13.2.0
sh                          rsk7269_defconfig   gcc-13.2.0
sh                          sdk7780_defconfig   gcc-13.2.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
um                               allmodconfig   clang-20
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-12
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-14.1.0
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240814   clang-18
x86_64       buildonly-randconfig-002-20240814   clang-18
x86_64       buildonly-randconfig-003-20240814   clang-18
x86_64       buildonly-randconfig-004-20240814   clang-18
x86_64       buildonly-randconfig-005-20240814   clang-18
x86_64       buildonly-randconfig-006-20240814   clang-18
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-11
x86_64                randconfig-001-20240814   clang-18
x86_64                randconfig-002-20240814   clang-18
x86_64                randconfig-003-20240814   clang-18
x86_64                randconfig-004-20240814   clang-18
x86_64                randconfig-005-20240814   clang-18
x86_64                randconfig-006-20240814   clang-18
x86_64                randconfig-011-20240814   clang-18
x86_64                randconfig-012-20240814   clang-18
x86_64                randconfig-013-20240814   clang-18
x86_64                randconfig-014-20240814   clang-18
x86_64                randconfig-015-20240814   clang-18
x86_64                randconfig-016-20240814   clang-18
x86_64                randconfig-071-20240814   clang-18
x86_64                randconfig-072-20240814   clang-18
x86_64                randconfig-073-20240814   clang-18
x86_64                randconfig-074-20240814   clang-18
x86_64                randconfig-075-20240814   clang-18
x86_64                randconfig-076-20240814   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

