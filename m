Return-Path: <linux-kernel+bounces-176849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5D68C35EC
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 12:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EADBCB20E8C
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 10:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3422C1CAB3;
	Sun, 12 May 2024 10:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TSUgRiQ/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC861CA80
	for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 10:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715508954; cv=none; b=mmmLSWx9ddgcRML3lU7Pozs95YuoOWXQGyYHLEwYDFGALA1jHjQkN9pMEtYku+ERohA3N4WSQ5Q0f/tlENehgAVkSXe4cCepX9l6/jhN2BG7V/+08lSFRZ2j6es6KZKgkuidA0Gbsjv+6FTAtZlAhnXE2bYJQT4E7f586b32zK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715508954; c=relaxed/simple;
	bh=t4/MHATq48DlYRJegrxuVSvlx22CyaZgwROpnfcQd/E=;
	h=Date:From:To:Cc:Subject:Message-ID; b=SzE7uEO7ET4tc0kT7GM9B8jI9N8tmbwZwA37c6rVg8mVxrGhFJ2oOnIeRpHSK8Fku8OhSrFFBh2xsBWGqSo35/0UEHyXkxrhC1JjqeK5LUGl3d4H6j68a3MnhLOSBkNwL39dbpgHA+64lPlFhC4MaBp6/qsTImHHj89lO/SKiC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TSUgRiQ/; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715508952; x=1747044952;
  h=date:from:to:cc:subject:message-id;
  bh=t4/MHATq48DlYRJegrxuVSvlx22CyaZgwROpnfcQd/E=;
  b=TSUgRiQ/f+RsgVqrCiY7ZNiT8B6sZ2f7esvZlclgpYEhAFyD8mxl5CMx
   YkuylM2t/QUHAcGl9SIa0sctvLIiXkIJa2tugD0EMsRm9cq6anqEx3VZS
   IENdq8mmkUyB8L49ZAySVaGgo8z6hJYBeYcn0iOO2T7mgYgafM7elDrxk
   uXcYcJBXOO+4PrRWONMAUYKmJrDlbYc7zP6rje0EfB4TejschWSUo5XJT
   miDFMLWhPaDB2vRVJFqAUZyWoTqqXfhOyRy4yIFlrOfT78HRc1tYzbMIJ
   J6H8qjlugoNzBW0qbe5hX2p780XZ5Vlpc6OLV6PlbAiiImTh51ydESRPw
   A==;
X-CSE-ConnectionGUID: n/COmEhtTbGeQsIicnrjew==
X-CSE-MsgGUID: mS7O3oEtQF+luscmFmH3iA==
X-IronPort-AV: E=McAfee;i="6600,9927,11070"; a="36832782"
X-IronPort-AV: E=Sophos;i="6.08,155,1712646000"; 
   d="scan'208";a="36832782"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2024 03:15:52 -0700
X-CSE-ConnectionGUID: 2aW2Riq7TYiUxDL9kAIjxg==
X-CSE-MsgGUID: gjRwCVJtSeyTGTaZ4UMh3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,155,1712646000"; 
   d="scan'208";a="53280958"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 12 May 2024 03:15:51 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s66FA-0008VH-0L;
	Sun, 12 May 2024 10:15:48 +0000
Date: Sun, 12 May 2024 18:15:36 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 63c0e046aa0afb5ace5b22b99be953975bff3b51
Message-ID: <202405121834.AaqjZdnc-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 63c0e046aa0afb5ace5b22b99be953975bff3b51  Merge branch into tip/master: 'x86/timers'

elapsed time: 1494m

configs tested: 97
configs skipped: 3

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
arc                     haps_hs_smp_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                     davinci_all_defconfig   clang
arm                                 defconfig   clang
arm                         lpc32xx_defconfig   clang
arm                            mmp2_defconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240512   gcc  
i386         buildonly-randconfig-002-20240512   clang
i386         buildonly-randconfig-003-20240512   gcc  
i386         buildonly-randconfig-004-20240512   gcc  
i386         buildonly-randconfig-005-20240512   gcc  
i386         buildonly-randconfig-006-20240512   clang
i386                                defconfig   clang
i386                  randconfig-001-20240512   clang
i386                  randconfig-002-20240512   clang
i386                  randconfig-003-20240512   clang
i386                  randconfig-004-20240512   gcc  
i386                  randconfig-005-20240512   clang
i386                  randconfig-006-20240512   clang
i386                  randconfig-011-20240512   gcc  
i386                  randconfig-012-20240512   clang
i386                  randconfig-013-20240512   gcc  
i386                  randconfig-014-20240512   clang
i386                  randconfig-015-20240512   gcc  
i386                  randconfig-016-20240512   gcc  
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
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
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
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

