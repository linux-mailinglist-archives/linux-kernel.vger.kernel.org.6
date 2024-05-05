Return-Path: <linux-kernel+bounces-168869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF5A8BBF15
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 04:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D744C281F30
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 02:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580A617F6;
	Sun,  5 May 2024 02:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AWyY8I+v"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0C7812
	for <linux-kernel@vger.kernel.org>; Sun,  5 May 2024 02:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714877882; cv=none; b=P0zqVU6o+C47JT+1d8UWbSfihQ+60N35EAT/gOBVEGTqLvB/ihregEwldkPNN0wwROu7gysP2z04lkoCSmH52lBW49qeaMYT+dLlYcialN3ZAzTVRJbmOwXhsy/Tvmx3InAhcv3bAcpOw7CkxEXHsQR2h6uA9g0drqt5Z8iIORo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714877882; c=relaxed/simple;
	bh=6sIprcSSUL5FqPgf4YlVB9KpliP25n5Doq0i6Ob6JXU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=n2Oi0giA700w6HcRNPT04YXB41ZhlAXRVhU2psgSt8YjhHAUtpKsmTEmJe7Qvg56GFiAZmaR8At6WG6uS02x71h8/Zu57MHHtUCqyKq85QlIXQEfRbFPGaIF2kFYz+WqwPShiSNMjqalOIpYVSxF1We24OTR25YjW7C20INkRWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AWyY8I+v; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714877880; x=1746413880;
  h=date:from:to:cc:subject:message-id;
  bh=6sIprcSSUL5FqPgf4YlVB9KpliP25n5Doq0i6Ob6JXU=;
  b=AWyY8I+vmIh8c/Z+9tsFJb2LzfiUEWNPwXCGsfu+ew13IF2LINzUqWTo
   0jSW8CPrXgZ7PQqpC9XXe08I9d4VVjV03bgLntbQahqBR/GbHHsjuStgB
   7/Cpqasus1ti2ZzhQlobQRiVMEfVSI21aNXPcftmF3zFcBrW9B1bPhE4c
   zr/zUd+alZkTFZY9XgWO6FNyHDxEEiZUPydQ6cFH5qTCD99kd2waVy22c
   SMztyXcUsRI8Kxyhhu/bNji5NvrFPAFWp/x/wdb/h5q0cbzuXhWrfT4fH
   NRCNpXL4sfcvOlh7J9nM7c9/MDj2eQRwTOE0rcgiPTma3bmW3IhBdWGAc
   A==;
X-CSE-ConnectionGUID: y4DpkuZDSjWVDiXV6viEiw==
X-CSE-MsgGUID: NmNvO8OKSF+pmvdxz0Fu/g==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="10776098"
X-IronPort-AV: E=Sophos;i="6.07,255,1708416000"; 
   d="scan'208";a="10776098"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2024 19:58:00 -0700
X-CSE-ConnectionGUID: XWQF/SnzT1CW3r/4Qh3RaA==
X-CSE-MsgGUID: /dpU+1w8RjO/wMTDuZkD8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,255,1708416000"; 
   d="scan'208";a="27834642"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 04 May 2024 19:57:58 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s3S4a-000DOH-0O;
	Sun, 05 May 2024 02:57:56 +0000
Date: Sun, 05 May 2024 10:57:07 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 7de3d344c432d4afe07d5d404647e4c2a7932964
Message-ID: <202405051005.gUK8MHip-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 7de3d344c432d4afe07d5d404647e4c2a7932964  Merge branch into tip/master: 'x86/timers'

elapsed time: 1163m

configs tested: 169
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
arc                        nsimosci_defconfig   gcc  
arc                 nsimosci_hs_smp_defconfig   gcc  
arc                   randconfig-001-20240504   gcc  
arc                   randconfig-002-20240504   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                         bcm2835_defconfig   clang
arm                                 defconfig   clang
arm                          ixp4xx_defconfig   gcc  
arm                   randconfig-001-20240504   clang
arm                   randconfig-002-20240504   clang
arm                   randconfig-003-20240504   clang
arm                   randconfig-004-20240504   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240504   gcc  
arm64                 randconfig-002-20240504   gcc  
arm64                 randconfig-003-20240504   gcc  
arm64                 randconfig-004-20240504   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240504   gcc  
csky                  randconfig-002-20240504   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240504   clang
hexagon               randconfig-002-20240504   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240504   clang
i386         buildonly-randconfig-002-20240504   gcc  
i386         buildonly-randconfig-003-20240504   gcc  
i386         buildonly-randconfig-004-20240504   clang
i386         buildonly-randconfig-005-20240504   clang
i386         buildonly-randconfig-006-20240504   clang
i386                                defconfig   clang
i386                  randconfig-001-20240504   gcc  
i386                  randconfig-002-20240504   clang
i386                  randconfig-003-20240504   gcc  
i386                  randconfig-004-20240504   clang
i386                  randconfig-005-20240504   clang
i386                  randconfig-006-20240504   gcc  
i386                  randconfig-011-20240504   gcc  
i386                  randconfig-012-20240504   clang
i386                  randconfig-013-20240504   clang
i386                  randconfig-014-20240504   gcc  
i386                  randconfig-015-20240504   gcc  
i386                  randconfig-016-20240504   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240504   gcc  
loongarch             randconfig-002-20240504   gcc  
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
mips                          rm200_defconfig   gcc  
mips                         rt305x_defconfig   clang
mips                        vocore2_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240504   gcc  
nios2                 randconfig-002-20240504   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240504   gcc  
parisc                randconfig-002-20240504   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                    amigaone_defconfig   gcc  
powerpc                     asp8347_defconfig   clang
powerpc                      katmai_defconfig   clang
powerpc                      pasemi_defconfig   clang
powerpc               randconfig-001-20240504   gcc  
powerpc               randconfig-002-20240504   gcc  
powerpc               randconfig-003-20240504   gcc  
powerpc                     stx_gp3_defconfig   clang
powerpc64             randconfig-001-20240504   clang
powerpc64             randconfig-002-20240504   clang
powerpc64             randconfig-003-20240504   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240504   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                       zfcpdump_defconfig   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                           se7343_defconfig   gcc  
sh                           se7780_defconfig   gcc  
sh                          urquell_defconfig   gcc  
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
x86_64                           alldefconfig   gcc  
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240505   gcc  
x86_64       buildonly-randconfig-002-20240505   clang
x86_64       buildonly-randconfig-003-20240505   clang
x86_64       buildonly-randconfig-004-20240505   clang
x86_64       buildonly-randconfig-005-20240505   gcc  
x86_64       buildonly-randconfig-006-20240505   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240505   clang
x86_64                randconfig-002-20240505   gcc  
x86_64                randconfig-003-20240505   clang
x86_64                randconfig-004-20240505   gcc  
x86_64                randconfig-005-20240505   gcc  
x86_64                randconfig-006-20240505   gcc  
x86_64                randconfig-011-20240505   clang
x86_64                randconfig-012-20240505   clang
x86_64                randconfig-013-20240505   clang
x86_64                randconfig-014-20240505   clang
x86_64                randconfig-015-20240505   clang
x86_64                randconfig-016-20240505   clang
x86_64                randconfig-071-20240505   clang
x86_64                randconfig-072-20240505   gcc  
x86_64                randconfig-073-20240505   gcc  
x86_64                randconfig-074-20240505   gcc  
x86_64                randconfig-075-20240505   clang
x86_64                randconfig-076-20240505   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

