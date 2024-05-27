Return-Path: <linux-kernel+bounces-191447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4222D8D0F63
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 23:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65D361C2127F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 21:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C5215F32D;
	Mon, 27 May 2024 21:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OBvsMD39"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB7C17E8F6
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 21:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716845087; cv=none; b=ZlBAzIRjg5Tn9yNKsNgQxaESrZnRlBdQVfKs+7FT0LHBk+EnxhkxLeLaC+voTZD7BNTlXPkH+JoWcvJ9mkR0laSLSPfXBv3U//62Q2NEtCgub2WzSN0XkXtacITvGAbnvNhpnVQWhayaSO/dADr/zwRS6nC5WNv09v2gnKcq5Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716845087; c=relaxed/simple;
	bh=V6cmSOfE8v9Y2xZnvUIl9f0RqYR7Xyr2+cgSVv3CDNM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=WGVFz7K+9isF87OHxHopEEDXLLRO+QwzRUV8/h4EfBQtPJTSMLoDZNd+VHv32zYSPNGQ9BQrlPQByCry/pbTS1TDYA0b4g0jN780fvE+zTakbE/L19QIl6BvWS3oeLB8znvyiuh6+WzE7V7zxws24O047xBeZA3d16mJAnA/EK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OBvsMD39; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716845085; x=1748381085;
  h=date:from:to:cc:subject:message-id;
  bh=V6cmSOfE8v9Y2xZnvUIl9f0RqYR7Xyr2+cgSVv3CDNM=;
  b=OBvsMD39Iilj7xumhjxzfSaBymkBs/HFH8cGAgx22/I8tdkXgpz+61XJ
   1mbGAyCPlEJ8Bef/5DhQNk7fdQ+tCCzzN/uqu7jXR/0esmkWItPbLdAx+
   sX4r78JAbeddG/NVKxY72LhL/8WisaHi58oHGyKhpMke9usHKdsiDmZtO
   rKfHydWeuHej6yQfS6/rVuQg8wxR9+bVQWWo7oVbmccDE+UT8TlPoLeGa
   zrUARaKan6eh1OXwaSd/7MckJgXuJ1vbyYnTX71HTlyAMFzj+yt1tOMTn
   bBufZstKRy1099MS59x4qxa+DrATSXiP4lqKBoOY8Bmj5BVpK0oZDCUyR
   A==;
X-CSE-ConnectionGUID: 2t4R4jYwTvusY/AbcUDcOg==
X-CSE-MsgGUID: Np8RpgFFRhqRQ/4UpqMQEw==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13043657"
X-IronPort-AV: E=Sophos;i="6.08,193,1712646000"; 
   d="scan'208";a="13043657"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 14:24:44 -0700
X-CSE-ConnectionGUID: 9R218JIyQp+thdTAeHgKsg==
X-CSE-MsgGUID: QJTGretMQ1u03fePv5TuMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,193,1712646000"; 
   d="scan'208";a="39847508"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 27 May 2024 14:24:44 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sBhph-000B6h-1E;
	Mon, 27 May 2024 21:24:41 +0000
Date: Tue, 28 May 2024 05:24:39 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:ras/core] BUILD SUCCESS
 5b9d292ea87c836ec47483f98344cb0e7add82fe
Message-ID: <202405280535.TVO359jC-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras/core
branch HEAD: 5b9d292ea87c836ec47483f98344cb0e7add82fe  x86/mce: Remove unused variable and return value in machine_check_poll()

elapsed time: 738m

configs tested: 113
configs skipped: 135

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                       aspeed_g5_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
hexagon                          allmodconfig   clang
hexagon                          allyesconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-004-20240527   clang
i386                                defconfig   clang
i386                  randconfig-002-20240527   clang
i386                  randconfig-012-20240527   clang
i386                  randconfig-014-20240527   clang
i386                  randconfig-016-20240527   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          atari_defconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            alldefconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                    or1ksim_defconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                     rainier_defconfig   gcc  
powerpc                     tqm5200_defconfig   gcc  
powerpc                     tqm8560_defconfig   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                           se7721_defconfig   gcc  
sh                        sh7757lcr_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240527   clang
x86_64       buildonly-randconfig-002-20240527   gcc  
x86_64       buildonly-randconfig-003-20240527   gcc  
x86_64       buildonly-randconfig-004-20240527   gcc  
x86_64       buildonly-randconfig-005-20240527   gcc  
x86_64       buildonly-randconfig-006-20240527   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240527   clang
x86_64                randconfig-002-20240527   gcc  
x86_64                randconfig-003-20240527   clang
x86_64                randconfig-004-20240527   clang
x86_64                randconfig-005-20240527   clang
x86_64                randconfig-006-20240527   clang
x86_64                randconfig-011-20240527   gcc  
x86_64                randconfig-012-20240527   gcc  
x86_64                randconfig-013-20240527   clang
x86_64                randconfig-014-20240527   gcc  
x86_64                randconfig-015-20240527   gcc  
x86_64                randconfig-016-20240527   gcc  
x86_64                randconfig-071-20240527   gcc  
x86_64                randconfig-072-20240527   clang
x86_64                randconfig-073-20240527   clang
x86_64                randconfig-074-20240527   clang
x86_64                randconfig-075-20240527   clang
x86_64                randconfig-076-20240527   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                generic_kc705_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

