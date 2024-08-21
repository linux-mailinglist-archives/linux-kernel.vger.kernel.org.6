Return-Path: <linux-kernel+bounces-295278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B87959943
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEEC61F253E6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07AC3204A1A;
	Wed, 21 Aug 2024 09:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kNZYXu3H"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B99204A01
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 09:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724233527; cv=none; b=pYN2bXdz1DYfYyJxa6kx/p33ySzYAe9YvPhDevllisGAKZiC5Ki2SrHqu7RwNNWqGVRksiVF1LujKk+3rio6/InepQDjqcX5mkjT/j7ARII/PQZSX5ysPEfwJrQa14ZgkdZ3LwSRX1RikWkoBJ5/xg5TjcjThJXmdiomCYpQkdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724233527; c=relaxed/simple;
	bh=cExYKNrrP1imMDe+PnnPU3Ung2uoEzUh9w7B/Oo5LvE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=S5nZm6GlSAL9dubhqC0B9+HO93q1vlnjRHajpMA1MsKbCvBgUGuZcNYmkN/4bfuMx+ZHXl7APaV4BndnfTE6RIrSnSm4cikx3G0qJIVtfvZnN0XYQ7NfS/DQaqvxqrccaol/CF4Oem+DpfRQpBEDrgRKiYA504PC6BDXPHLXmDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kNZYXu3H; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724233525; x=1755769525;
  h=date:from:to:cc:subject:message-id;
  bh=cExYKNrrP1imMDe+PnnPU3Ung2uoEzUh9w7B/Oo5LvE=;
  b=kNZYXu3HhGQl/YJFQ65JH0jvhXfUhZ5Awa4QJMw5TM+F6sI1bPxsqdqI
   G5dp6/yK0bhdA/wEM1eAMKSCvbW/RQhiJ+6AL4Xy1d56zSJvMpQWs/KOY
   v2ktEgRsYrnu0PlxFs5jIiSEENo6pw86ImW10KM7fGn/rP8laC4JROeIr
   nULCwIxojpP3rEC4XDmZvQFt8DZkHDlX+OPu0xTgkQ91u86hd99kpLpL+
   qV+RfLLAaDw0SLVwrltsxrFjsYuzSr/9DlzG1KtBhTziAkJeMr4JUt+3C
   /2UYt4D4BB0tNwovXPc1vIII4gJIndKlZ4VJWfrqkE8kmd7m21lHR9TsB
   g==;
X-CSE-ConnectionGUID: eyf/bfikTtmVdkAaR2j9HQ==
X-CSE-MsgGUID: K2yI78TZTF6uL5c/M4IcWA==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="33244910"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="33244910"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 02:45:24 -0700
X-CSE-ConnectionGUID: p+UmY0aoTbKoW+9efBiPdg==
X-CSE-MsgGUID: k8OQ21iWT7+4EZB5oSe9bQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="65244147"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 21 Aug 2024 02:45:23 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sghu5-000BB3-1c;
	Wed, 21 Aug 2024 09:45:21 +0000
Date: Wed, 21 Aug 2024 17:44:57 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:irq/core] BUILD SUCCESS
 0b3af7591dbfd16ca45740cd90eb34be8b9a7175
Message-ID: <202408211754.gALI3gzs-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
branch HEAD: 0b3af7591dbfd16ca45740cd90eb34be8b9a7175  irqchip/loongson-pch-msi: Switch to MSI parent domains

elapsed time: 1094m

configs tested: 208
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240821   gcc-13.2.0
arc                   randconfig-002-20240821   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-20
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                              allyesconfig   gcc-14.1.0
arm                                 defconfig   gcc-13.2.0
arm                            mmp2_defconfig   gcc-14.1.0
arm                            mps2_defconfig   gcc-14.1.0
arm                        multi_v5_defconfig   gcc-14.1.0
arm                             mxs_defconfig   gcc-14.1.0
arm                   randconfig-001-20240821   gcc-14.1.0
arm                   randconfig-002-20240821   gcc-14.1.0
arm                   randconfig-003-20240821   clang-20
arm                   randconfig-004-20240821   gcc-14.1.0
arm64                            allmodconfig   clang-20
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240821   gcc-14.1.0
arm64                 randconfig-002-20240821   gcc-14.1.0
arm64                 randconfig-003-20240821   gcc-14.1.0
arm64                 randconfig-004-20240821   clang-20
csky                              allnoconfig   gcc-13.2.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240821   gcc-14.1.0
csky                  randconfig-002-20240821   gcc-14.1.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   clang-20
hexagon                          allyesconfig   clang-20
hexagon               randconfig-001-20240821   clang-20
hexagon               randconfig-002-20240821   clang-20
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-12
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-12
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240821   gcc-12
i386         buildonly-randconfig-002-20240821   clang-18
i386         buildonly-randconfig-002-20240821   gcc-12
i386         buildonly-randconfig-003-20240821   clang-18
i386         buildonly-randconfig-003-20240821   gcc-12
i386         buildonly-randconfig-004-20240821   gcc-12
i386         buildonly-randconfig-005-20240821   gcc-12
i386         buildonly-randconfig-006-20240821   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240821   clang-18
i386                  randconfig-001-20240821   gcc-12
i386                  randconfig-002-20240821   gcc-12
i386                  randconfig-003-20240821   clang-18
i386                  randconfig-003-20240821   gcc-12
i386                  randconfig-004-20240821   gcc-12
i386                  randconfig-005-20240821   clang-18
i386                  randconfig-005-20240821   gcc-12
i386                  randconfig-006-20240821   gcc-12
i386                  randconfig-011-20240821   gcc-11
i386                  randconfig-011-20240821   gcc-12
i386                  randconfig-012-20240821   gcc-12
i386                  randconfig-013-20240821   clang-18
i386                  randconfig-013-20240821   gcc-12
i386                  randconfig-014-20240821   clang-18
i386                  randconfig-014-20240821   gcc-12
i386                  randconfig-015-20240821   gcc-12
i386                  randconfig-016-20240821   gcc-12
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240821   gcc-14.1.0
loongarch             randconfig-002-20240821   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
m68k                        stmark2_defconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-14.1.0
mips                          ath79_defconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240821   gcc-14.1.0
nios2                 randconfig-002-20240821   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
openrisc                 simple_smp_defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240821   gcc-14.1.0
parisc                randconfig-002-20240821   gcc-14.1.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-20
powerpc                     asp8347_defconfig   gcc-14.1.0
powerpc                   bluestone_defconfig   gcc-14.1.0
powerpc                   currituck_defconfig   gcc-14.1.0
powerpc                       holly_defconfig   gcc-14.1.0
powerpc               randconfig-001-20240821   gcc-14.1.0
powerpc               randconfig-002-20240821   clang-20
powerpc                     taishan_defconfig   gcc-14.1.0
powerpc64             randconfig-001-20240821   gcc-14.1.0
powerpc64             randconfig-002-20240821   clang-20
powerpc64             randconfig-003-20240821   gcc-14.1.0
riscv                            allmodconfig   clang-20
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-20
riscv                               defconfig   gcc-14.1.0
riscv                 randconfig-001-20240821   gcc-14.1.0
riscv                 randconfig-002-20240821   clang-16
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240821   clang-17
s390                  randconfig-002-20240821   clang-20
sh                               alldefconfig   gcc-14.1.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                    randconfig-001-20240821   gcc-14.1.0
sh                    randconfig-002-20240821   gcc-14.1.0
sh                           se7619_defconfig   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240821   gcc-14.1.0
sparc64               randconfig-002-20240821   gcc-14.1.0
um                               allmodconfig   clang-20
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-12
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240821   clang-20
um                    randconfig-002-20240821   gcc-12
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240821   gcc-12
x86_64       buildonly-randconfig-002-20240821   clang-18
x86_64       buildonly-randconfig-002-20240821   gcc-12
x86_64       buildonly-randconfig-003-20240821   gcc-12
x86_64       buildonly-randconfig-004-20240821   gcc-12
x86_64       buildonly-randconfig-005-20240821   gcc-12
x86_64       buildonly-randconfig-006-20240821   gcc-12
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-11
x86_64                randconfig-001-20240821   clang-18
x86_64                randconfig-001-20240821   gcc-12
x86_64                randconfig-002-20240821   gcc-12
x86_64                randconfig-003-20240821   clang-18
x86_64                randconfig-003-20240821   gcc-12
x86_64                randconfig-004-20240821   clang-18
x86_64                randconfig-004-20240821   gcc-12
x86_64                randconfig-005-20240821   clang-18
x86_64                randconfig-005-20240821   gcc-12
x86_64                randconfig-006-20240821   gcc-12
x86_64                randconfig-011-20240821   gcc-12
x86_64                randconfig-012-20240821   clang-18
x86_64                randconfig-012-20240821   gcc-12
x86_64                randconfig-013-20240821   clang-18
x86_64                randconfig-013-20240821   gcc-12
x86_64                randconfig-014-20240821   clang-18
x86_64                randconfig-014-20240821   gcc-12
x86_64                randconfig-015-20240821   gcc-12
x86_64                randconfig-016-20240821   clang-18
x86_64                randconfig-016-20240821   gcc-12
x86_64                randconfig-071-20240821   gcc-12
x86_64                randconfig-072-20240821   gcc-12
x86_64                randconfig-073-20240821   gcc-12
x86_64                randconfig-074-20240821   gcc-12
x86_64                randconfig-075-20240821   gcc-12
x86_64                randconfig-076-20240821   gcc-12
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                            allnoconfig   gcc-14.1.0
xtensa                generic_kc705_defconfig   gcc-14.1.0
xtensa                  nommu_kc705_defconfig   gcc-14.1.0
xtensa                randconfig-001-20240821   gcc-14.1.0
xtensa                randconfig-002-20240821   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

