Return-Path: <linux-kernel+bounces-210404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7F4904338
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 20:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8230B1F2534B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 18:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BF65B1FB;
	Tue, 11 Jun 2024 18:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DMsWpWn9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D21F7602B
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 18:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718129458; cv=none; b=BSyCyg75OzAGYzXGDjnVrCpQxiMZGG2TfrOk0Kn76UUacPNKRR+grFjWNNbTv3YKOP+Qtcne8jRX7+RHujGvqhKzVFwCz5Zsd1J4sLQ0zJ7MROaFuOdIBZpQpDI5485FoNv2fm4nj5Nalv8bJ1Wn+xf93n4mJs/+43jdruzuztA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718129458; c=relaxed/simple;
	bh=l3xNCzXk3xmwDmD+pMtsOXU0f7Jhky/gbT9eRPh2iQk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=gfF+rID58oA3a6PWm+sCIYl9TyfMoQgEMReyKdG2i2W6xypJNc27vKzBdCoyewkOi2jplPtv0mBQAPncX8Bqa5SLgx4dioQUfZG6KfDtcujp44nzWE/a+meKGOwHQfhxPIfBGCiqyaq29so9tX5Xe6Z1WM+FZ0JTIJZ68YuedQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DMsWpWn9; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718129456; x=1749665456;
  h=date:from:to:cc:subject:message-id;
  bh=l3xNCzXk3xmwDmD+pMtsOXU0f7Jhky/gbT9eRPh2iQk=;
  b=DMsWpWn9yJ8JE4rcVz5lxV75cY29hrV/GfzmIZHxy2eNzGsBo1kcjVHH
   fLS6II3jTFBn22OXdQvmjt2W5/ub2YM28yGUYLBohsctfHgiO4fik0CH1
   VdwvTN6E9LoUBK8UJ9utjw6NNK1/YM8xyU2az6bDjdC17hiP6xOC0VOZA
   0ev9pPAiO2rzRRV9zlFOpRftM038wgsE0Iy2zCzP5XcyZBv37bRQX10QQ
   fBuTYF0xT17UxSs0znsDHZemtcKfV88SqlDkLsisfdE8j6FhqYbm19oc7
   rkaQdQg3TjCPlgrS5k9ID8o38zz1rrKy8acsoIflLp0HIlKlvZgBowkSx
   g==;
X-CSE-ConnectionGUID: A1LgJFoKQNSOM3ntEOa5dQ==
X-CSE-MsgGUID: hB8dVEOnScCfljTNCuoqJA==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="14988059"
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="14988059"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 11:10:56 -0700
X-CSE-ConnectionGUID: eiZXIeMERKW1giHk/dv5mQ==
X-CSE-MsgGUID: RMU0jF7lQny+9DUu9HxGyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="44646002"
Received: from lkp-server01.sh.intel.com (HELO 628d7d8b9fc6) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 11 Jun 2024 11:10:55 -0700
Received: from kbuild by 628d7d8b9fc6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sH5xM-0000kM-20;
	Tue, 11 Jun 2024 18:10:52 +0000
Date: Wed, 12 Jun 2024 02:10:39 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/cache] BUILD SUCCESS
 f385f024639431bec3e70c33cdbc9563894b3ee5
Message-ID: <202406120237.NrMycO3N-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cache
branch HEAD: f385f024639431bec3e70c33cdbc9563894b3ee5  x86/resctrl: Replace open coded cacheinfo searches

elapsed time: 1457m

configs tested: 81
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                             allnoconfig   gcc-13.2.0
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc  
arc                               allnoconfig   gcc-13.2.0
arc                                 defconfig   gcc  
arc                                 defconfig   gcc-13.2.0
arm                               allnoconfig   clang
arm                                 defconfig   clang
arm64                             allnoconfig   gcc  
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc  
arm64                               defconfig   gcc-13.2.0
csky                              allnoconfig   gcc  
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc  
csky                                defconfig   gcc-13.2.0
hexagon                          allmodconfig   clang-19
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang-19
hexagon                             defconfig   clang
i386         buildonly-randconfig-003-20240611   clang
i386                  randconfig-001-20240611   clang
i386                  randconfig-004-20240611   clang
i386                  randconfig-006-20240611   clang
i386                  randconfig-011-20240611   clang
i386                  randconfig-013-20240611   clang
i386                  randconfig-015-20240611   clang
i386                  randconfig-016-20240611   clang
loongarch                        allmodconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc  
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc-13.2.0
m68k                              allnoconfig   gcc  
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-13.2.0
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc-13.2.0
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc-13.2.0
nios2                            allmodconfig   gcc-13.2.0
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc-13.2.0
nios2                               defconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                            defconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc-13.2.0
s390                                defconfig   clang
sh                               allmodconfig   gcc-13.2.0
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc-13.2.0
sh                                  defconfig   gcc  
sparc                            allmodconfig   gcc-13.2.0
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                               allyesconfig   gcc-13
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang-18
x86_64                              defconfig   gcc-13
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

