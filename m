Return-Path: <linux-kernel+bounces-206659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6E5900C6A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 21:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3429A1F21A17
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 19:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416921482FA;
	Fri,  7 Jun 2024 19:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="laIgS71O"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB57E1CFB6
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 19:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717788098; cv=none; b=iCX39iHtb7HybjnQXEUVq1Kjbi0cHH1xh2+ru+nhZs6U3lvCjNMQY6t+i/37yPY5WE3ehiKuKomlzT0VyTCAQAx6HpkeK5poLhJ6vgTT1LRo+ECTKxrH8SCoNAfwFf8GigrR36nCGTBCm5NCEqRvR72BnzPdQW1IoBPiOl6A28k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717788098; c=relaxed/simple;
	bh=+292sdIBcsO4OOUbHoUlE/k+OUEZpCXA60cA6ofUfms=;
	h=Date:From:To:Cc:Subject:Message-ID; b=mBC6Ge9k/kILYoxvleaaNBJj/YXU5hwc4bLRdHxnLKxjjJ0K8PoDyGlyyS+uNq4C/2OpyXDxU+WPRiVR6PL/I5Fwj8P1xycigdgVPvw9/w9c0UOmDVLpqU7T/mIIKi4XE065Pb0KNnprxVYMQ0lwttqNRfDzbLaCtu8DiwWAzP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=laIgS71O; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717788097; x=1749324097;
  h=date:from:to:cc:subject:message-id;
  bh=+292sdIBcsO4OOUbHoUlE/k+OUEZpCXA60cA6ofUfms=;
  b=laIgS71OVLBRqX0AYALPYSHdCK5KycbumVTMeiJeBchM5j3sbBMXGkb3
   6VRQyxoKKFhdIjJepFNs4VR/Nncgz+CA9cB89k0F9fNCdIjOpLylSWbtT
   xPxH9QZraZlWADWPR6ds+SGAeViPpsXPKi/BtvXPN4uBPTWZ90hlEwRv3
   bEhnWW5DPSzF+S1Hkqqn2qG+OblkrOwEXTRSSrezaCFm27pL9WYsnWMru
   NOdW9wDp9vc48tL1rYC5sx4Bnohc+bc5uBeqd+AVvQvW25qsWk8G6CVCu
   0P8VZc57coyaGNVfRy/RikykgO7Bvqsm7u9aW3JiKttMorZRKlhhQN5UC
   g==;
X-CSE-ConnectionGUID: mDgNZDCZRoKAQdvfQp1RjQ==
X-CSE-MsgGUID: V4t+PljiRf6p9mw5mBhp5A==
X-IronPort-AV: E=McAfee;i="6600,9927,11096"; a="25179886"
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="25179886"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 12:21:36 -0700
X-CSE-ConnectionGUID: kRz0bVobTdao8z+CIC7aTw==
X-CSE-MsgGUID: 00KCuIXZTJSRwUL9Srbdfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="38856187"
Received: from lkp-server01.sh.intel.com (HELO 472b94a103a1) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 07 Jun 2024 12:21:35 -0700
Received: from kbuild by 472b94a103a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sFf9Y-0000Lc-2k;
	Fri, 07 Jun 2024 19:21:32 +0000
Date: Sat, 08 Jun 2024 03:21:27 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2024.06.03a] BUILD SUCCESS
 9dac05d8f2291d6284dbeead831d026192b5ba1d
Message-ID: <202406080325.ppcV5kfy-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2024.06.03a
branch HEAD: 9dac05d8f2291d6284dbeead831d026192b5ba1d  tools/memory-model: Code reorganization in lock.cat

elapsed time: 1446m

configs tested: 75
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arm                               allnoconfig   clang
arm                                 defconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386         buildonly-randconfig-001-20240607   clang
i386         buildonly-randconfig-002-20240607   clang
i386         buildonly-randconfig-003-20240607   clang
i386         buildonly-randconfig-004-20240607   clang
i386         buildonly-randconfig-005-20240607   clang
i386         buildonly-randconfig-006-20240607   clang
i386                  randconfig-001-20240607   gcc  
i386                  randconfig-002-20240607   gcc  
i386                  randconfig-003-20240607   gcc  
i386                  randconfig-004-20240607   gcc  
i386                  randconfig-005-20240607   gcc  
i386                  randconfig-006-20240607   gcc  
i386                  randconfig-011-20240607   clang
i386                  randconfig-012-20240607   gcc  
i386                  randconfig-013-20240607   clang
i386                  randconfig-014-20240607   clang
i386                  randconfig-015-20240607   clang
i386                  randconfig-016-20240607   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
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
s390                             allyesconfig   gcc  
s390                                defconfig   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

