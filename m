Return-Path: <linux-kernel+bounces-280581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64AF194CC64
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 10:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D78E61F23D5B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 08:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608A719006D;
	Fri,  9 Aug 2024 08:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c1bhrDZC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E703019046B
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 08:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723192569; cv=none; b=GljQnhewcyT3mtFBgbh97QzB2YV08q5LeBXfLMwTmQXh4hwQ4YO/iKB11ix6xDgXgIdZcIj9V1b52CZ737srWuJ+LhgPu1G2P9DQjeIgLAkcZ4blLjtY1pAOFx6FASDRF+DSQTQqir/ZN79GgVJ61HaS1mpszSoeKlzeyU5e7mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723192569; c=relaxed/simple;
	bh=PM58SjB+NFMS/oMvT4sY7XbdrOTDx9niR5UytbEZC/E=;
	h=Date:From:To:Cc:Subject:Message-ID; b=DsKgxCCrmHgO8iTjXanRerGL529yvHo1Wkct8JY0hua9VBDw1Vewif2xLJCbFnkDQH0WsMNK6+73cnERVKeT+mXvFtA5HeV1FAxgMmlungwEoraTuLyW1WdKoWLunIBTus5X6IeCEsa+wy3w6LZELW79tbUfH+z1pNuerDu+kbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c1bhrDZC; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723192567; x=1754728567;
  h=date:from:to:cc:subject:message-id;
  bh=PM58SjB+NFMS/oMvT4sY7XbdrOTDx9niR5UytbEZC/E=;
  b=c1bhrDZCcb6bLZJLBLWCUzSM+hZxZ41FYej66uK0BmvA3UJ5n59jpbTY
   pHNYWXAG7Zg+5fUS+4SjThfqXf9cChvu7ILAEVnP432xznQLdrDdHntpc
   Nd8niJGCexHDMS3WN5hbHMuBaCOo2PGOdCb+DC+BOAOEtmiaXWe/j5S0S
   CKZtTRmvh77s6qVlDdc9aVnXxLe8T+Gxb+obH52OmtSd7DjWBqS0KIlKs
   6RjCC99jLZjFfKc7hIlbNu9VaG7Zx12fVNifD3qFI+6vrQsNClXeaFDLC
   nH8AyIuVLoCSB/CQv4nMtYUL4/ouQO9kYZvOHrAaEoYdLxnHD12vthZoz
   Q==;
X-CSE-ConnectionGUID: fnGDAES8RsacJ491m6Odxw==
X-CSE-MsgGUID: BpTu5dWIQnWOYsZdoAseAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="25151399"
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="25151399"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 01:36:06 -0700
X-CSE-ConnectionGUID: 77mPg0wASzqTx9KPzNMQwQ==
X-CSE-MsgGUID: /E07dOGYStypoK81cpwiJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="58062987"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 09 Aug 2024 01:36:05 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1scL6Q-0007cy-2s;
	Fri, 09 Aug 2024 08:36:02 +0000
Date: Fri, 09 Aug 2024 16:35:05 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 ad1b4b6ed19f86198f1c2e0c6a9b566944255259
Message-ID: <202408091603.lSSbHvFb-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: ad1b4b6ed19f86198f1c2e0c6a9b566944255259  Merge branch into tip/master: 'x86/timers'

elapsed time: 1455m

configs tested: 125
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                   randconfig-001-20240809   gcc-13.2.0
arc                   randconfig-002-20240809   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-20
arm                   randconfig-001-20240809   clang-15
arm                   randconfig-002-20240809   gcc-14.1.0
arm                   randconfig-003-20240809   clang-20
arm                   randconfig-004-20240809   clang-20
arm64                             allnoconfig   gcc-14.1.0
arm64                 randconfig-001-20240809   clang-20
arm64                 randconfig-002-20240809   clang-15
arm64                 randconfig-003-20240809   clang-15
arm64                 randconfig-004-20240809   clang-20
csky                              allnoconfig   gcc-14.1.0
csky                  randconfig-001-20240809   gcc-14.1.0
csky                  randconfig-002-20240809   gcc-14.1.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   clang-20
hexagon                          allyesconfig   clang-20
hexagon               randconfig-001-20240809   clang-20
hexagon               randconfig-002-20240809   clang-20
i386                             allmodconfig   gcc-12
i386                              allnoconfig   gcc-12
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240809   gcc-12
i386         buildonly-randconfig-002-20240809   clang-18
i386         buildonly-randconfig-003-20240809   gcc-11
i386         buildonly-randconfig-004-20240809   clang-18
i386         buildonly-randconfig-005-20240809   clang-18
i386         buildonly-randconfig-006-20240809   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240809   gcc-12
i386                  randconfig-002-20240809   clang-18
i386                  randconfig-003-20240809   clang-18
i386                  randconfig-004-20240809   gcc-12
i386                  randconfig-005-20240809   clang-18
i386                  randconfig-006-20240809   gcc-12
i386                  randconfig-011-20240809   gcc-12
i386                  randconfig-012-20240809   gcc-12
i386                  randconfig-013-20240809   gcc-12
i386                  randconfig-014-20240809   gcc-12
i386                  randconfig-015-20240809   gcc-11
i386                  randconfig-016-20240809   gcc-12
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch             randconfig-001-20240809   gcc-14.1.0
loongarch             randconfig-002-20240809   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-14.1.0
nios2                 randconfig-001-20240809   gcc-14.1.0
nios2                 randconfig-002-20240809   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240809   gcc-14.1.0
parisc                randconfig-002-20240809   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-20
powerpc               randconfig-001-20240809   clang-20
powerpc64             randconfig-001-20240809   gcc-14.1.0
powerpc64             randconfig-002-20240809   gcc-14.1.0
powerpc64             randconfig-003-20240809   gcc-14.1.0
riscv                            allmodconfig   clang-20
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-20
riscv                 randconfig-001-20240809   clang-20
riscv                 randconfig-002-20240809   clang-20
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                  randconfig-001-20240809   gcc-14.1.0
s390                  randconfig-002-20240809   gcc-14.1.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                    randconfig-001-20240809   gcc-14.1.0
sh                    randconfig-002-20240809   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
um                               allmodconfig   clang-20
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-12
x86_64                            allnoconfig   clang-18
x86_64       buildonly-randconfig-001-20240809   clang-18
x86_64       buildonly-randconfig-002-20240809   gcc-12
x86_64       buildonly-randconfig-003-20240809   gcc-12
x86_64       buildonly-randconfig-004-20240809   clang-18
x86_64       buildonly-randconfig-005-20240809   clang-18
x86_64       buildonly-randconfig-006-20240809   gcc-12
x86_64                              defconfig   gcc-11
x86_64                randconfig-001-20240809   gcc-12
x86_64                randconfig-002-20240809   gcc-12
x86_64                randconfig-003-20240809   gcc-12
x86_64                randconfig-004-20240809   clang-18
x86_64                randconfig-005-20240809   clang-18
x86_64                randconfig-006-20240809   gcc-12
x86_64                randconfig-011-20240809   clang-18
x86_64                randconfig-012-20240809   gcc-12
x86_64                randconfig-013-20240809   clang-18
x86_64                randconfig-014-20240809   clang-18
x86_64                randconfig-015-20240809   clang-18
x86_64                randconfig-016-20240809   gcc-12
x86_64                randconfig-071-20240809   clang-18
x86_64                randconfig-072-20240809   clang-18
x86_64                randconfig-073-20240809   gcc-12
x86_64                randconfig-074-20240809   clang-18
x86_64                randconfig-075-20240809   clang-18
x86_64                randconfig-076-20240809   gcc-12
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

