Return-Path: <linux-kernel+bounces-198155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 962C38D7428
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 09:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49B30281C70
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 07:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D7AA1CD06;
	Sun,  2 Jun 2024 07:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oE/BXhL7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8011CAA4
	for <linux-kernel@vger.kernel.org>; Sun,  2 Jun 2024 07:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717313869; cv=none; b=Jo2RaRgt8c+wWh3WQ19K44+hJbYp0/m2a2U05b7NqPIlJBbB5RsLkYfKtCO20fOFAQZrIbpwnEPyz+AkNUMh/bDPv3fFouQw1fBXbrMKsLNpgyFeHCDvDwv0fvSeGlFRuNj5YWcr0HYAQtSRyZZGHFOMeZMu4XwSwnEZtMTaOhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717313869; c=relaxed/simple;
	bh=2rvdEpsMdrglaK7wkBwBSZx3sjF7natQ8QUE30MaIXk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=tfRdyyFUO32oY6J9yrNirnFl48ZIrxfkNWVk3pfPy/RvkhtjxFi5IZFmAwjtYy9q2nO+JWqbJtzgPuZCJccmOCOww8AG8NNII8cI6Bsdqp4H+5TbGd7rYT7IG2EhJf8kL5sVr3yKdDmGV9EOz3ixWCguKbyu43tNQQGsMgc9BQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oE/BXhL7; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717313869; x=1748849869;
  h=date:from:to:cc:subject:message-id;
  bh=2rvdEpsMdrglaK7wkBwBSZx3sjF7natQ8QUE30MaIXk=;
  b=oE/BXhL7ScXkdKT0FHcxzk/LDAxKQNjFZff/se/1P3zn7bAMkQfV7uRD
   upH8DGocwX+X4TcRsVOGG2YiijuAeUE6/b0xm1hzdYOisorkR1nVEoAte
   jf7mf3uS9IKQII4degQFm/z584ifjBd6eO0LsJ1fWh9C82tSY3nXZzbly
   crWjyCZNZNoOUqelbYB3xUABrjT/FWmS+swRUbinA+GLLe3Sw0mGIx20y
   AJzS70EZTFuRpuBr9c1r/3QV5+tcK8yQVhckHp5Rbuv/Nz2xVmCSB0MUi
   0wmOl8rWC9oQiFPrGrKYDoh9jxDihWHiZzE5M32Yv7K4aZYEPzgnAF2RE
   A==;
X-CSE-ConnectionGUID: mdXSvNQpTU6//J6ZCngsJA==
X-CSE-MsgGUID: ooQGr+7WQG2iSIkzg03RyA==
X-IronPort-AV: E=McAfee;i="6600,9927,11090"; a="17645357"
X-IronPort-AV: E=Sophos;i="6.08,208,1712646000"; 
   d="scan'208";a="17645357"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2024 00:37:48 -0700
X-CSE-ConnectionGUID: ShRkSGLHQyyhpyICZFhpFA==
X-CSE-MsgGUID: dnsogAWQTgiNxcz7RlsmOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,208,1712646000"; 
   d="scan'208";a="37166833"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 02 Jun 2024 00:37:46 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sDfmh-000JqZ-1f;
	Sun, 02 Jun 2024 07:37:43 +0000
Date: Sun, 02 Jun 2024 15:37:30 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/misc] BUILD SUCCESS
 95e3fa6acf624ca9689397ca7ea881450f3cbe24
Message-ID: <202406021527.p1ttw20l-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/misc
branch HEAD: 95e3fa6acf624ca9689397ca7ea881450f3cbe24  x86, arm: Add missing license tag to syscall tables files

elapsed time: 983m

configs tested: 147
configs skipped: 108

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240602   gcc  
arc                   randconfig-002-20240602   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240601   clang
arm                   randconfig-002-20240601   clang
arm                   randconfig-003-20240601   gcc  
arm                   randconfig-003-20240602   gcc  
arm                   randconfig-004-20240601   gcc  
arm                    vt8500_v6_v7_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-002-20240602   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240602   gcc  
csky                  randconfig-002-20240602   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240601   clang
i386         buildonly-randconfig-002-20240601   gcc  
i386         buildonly-randconfig-002-20240602   gcc  
i386         buildonly-randconfig-003-20240601   gcc  
i386         buildonly-randconfig-004-20240601   gcc  
i386         buildonly-randconfig-005-20240601   gcc  
i386         buildonly-randconfig-006-20240601   clang
i386                                defconfig   clang
i386                  randconfig-001-20240601   clang
i386                  randconfig-002-20240601   gcc  
i386                  randconfig-003-20240601   clang
i386                  randconfig-004-20240601   gcc  
i386                  randconfig-004-20240602   gcc  
i386                  randconfig-005-20240601   clang
i386                  randconfig-006-20240601   gcc  
i386                  randconfig-011-20240601   gcc  
i386                  randconfig-012-20240601   gcc  
i386                  randconfig-013-20240601   gcc  
i386                  randconfig-014-20240601   gcc  
i386                  randconfig-014-20240602   gcc  
i386                  randconfig-015-20240601   clang
i386                  randconfig-015-20240602   gcc  
i386                  randconfig-016-20240601   clang
i386                  randconfig-016-20240602   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240602   gcc  
loongarch             randconfig-002-20240602   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                         amcore_defconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                           ip28_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240602   gcc  
nios2                 randconfig-002-20240602   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                            defconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240602   gcc  
parisc                randconfig-002-20240602   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      arches_defconfig   gcc  
powerpc               randconfig-002-20240602   gcc  
powerpc64             randconfig-002-20240602   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
s390                             allmodconfig   clang
s390                             allyesconfig   gcc  
s390                  randconfig-001-20240602   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                               j2_defconfig   gcc  
sh                    randconfig-001-20240602   gcc  
sh                    randconfig-002-20240602   gcc  
sh                            titan_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240602   gcc  
sparc64               randconfig-002-20240602   gcc  
um                               allmodconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240602   gcc  
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240602   gcc  
x86_64       buildonly-randconfig-002-20240602   clang
x86_64       buildonly-randconfig-003-20240602   clang
x86_64       buildonly-randconfig-004-20240602   gcc  
x86_64       buildonly-randconfig-005-20240602   clang
x86_64       buildonly-randconfig-006-20240602   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240602   gcc  
x86_64                randconfig-002-20240602   clang
x86_64                randconfig-003-20240602   clang
x86_64                randconfig-004-20240602   gcc  
x86_64                randconfig-005-20240602   clang
x86_64                randconfig-006-20240602   clang
x86_64                randconfig-011-20240602   gcc  
x86_64                randconfig-012-20240602   clang
x86_64                randconfig-013-20240602   clang
x86_64                randconfig-014-20240602   gcc  
x86_64                randconfig-015-20240602   clang
x86_64                randconfig-016-20240602   gcc  
x86_64                randconfig-071-20240602   gcc  
x86_64                randconfig-072-20240602   clang
x86_64                randconfig-073-20240602   gcc  
x86_64                randconfig-074-20240602   clang
x86_64                randconfig-075-20240602   clang
x86_64                randconfig-076-20240602   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20240602   gcc  
xtensa                randconfig-002-20240602   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

