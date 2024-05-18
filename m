Return-Path: <linux-kernel+bounces-182991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 726FE8C929F
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 23:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCF2BB20D25
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 21:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34496CDD0;
	Sat, 18 May 2024 21:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iNY+xBSw"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E40DDA6
	for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 21:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716069248; cv=none; b=gfTgCZjIcFGc/bWIr24ykcKjXqNftbbBk1EizFRVDvOr8Ij94e6lK0gC+Kc4jnQdWctLmyyUYztPl0NvpTyZ5KTC+9GsoRkXWRqEBLse1JusfpajYBKbqTY000M9aG87+RzOPZpB7ISQStDGx/2GuccBwMuQFJneSl374UqirmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716069248; c=relaxed/simple;
	bh=u+rq/xJ1AMvMyN0hGEVFG4k/w2HHrpYkxfOPd8j3nZc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=FMhrAy7hr8hKLJIARwGzfyrUY6p4vZ6zHGZN0ApklJMIUZn66sTu+qkM8WX6jlcOG3MSxv4Rs9WAwaYKYWUUBZx5wPrXV4dg8BtTFuz+BPqPa99r9sQNkkD9YC/Js4VCErszdDR0mgWSy4Dde/ZKWoWtWlAQXIbiBu9GA3NZVbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iNY+xBSw; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716069246; x=1747605246;
  h=date:from:to:cc:subject:message-id;
  bh=u+rq/xJ1AMvMyN0hGEVFG4k/w2HHrpYkxfOPd8j3nZc=;
  b=iNY+xBSwbepmBWU6g3d0K2FCFCaYXE9A9gAs9PxcxFRTKI0J907A4ksJ
   XJer8TB16Ws5NtgfM4iuDi03vr9vcU4rArP43LSKC4BmsWUaLekkhk6v7
   qSRtjU5oM48E8ay/seGq/3FuiDrY16vfbiutJ3JrsnkeXtsz5kowX0EDg
   rhBvCGncdI0vFpmkaRC2vwy0auhPvJ24ohMp8/NHFVg2Yli2a1bfMX910
   Cjb4Vmu1iOpOoKVDoUUTq82/+qGjDSX++GE7fLHYUeNxlGtjs54cwAdAe
   jneoSCLNW5m71hCFSN6ua023A6Lu4fXwTfpbEAzV8oOG2N38CJ5Fr3PuH
   Q==;
X-CSE-ConnectionGUID: meFLoRcbQFiCH/gqQNPEzw==
X-CSE-MsgGUID: IUwIW4lTTM2Gj7gdxuKfyQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11076"; a="23646034"
X-IronPort-AV: E=Sophos;i="6.08,171,1712646000"; 
   d="scan'208";a="23646034"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2024 14:54:05 -0700
X-CSE-ConnectionGUID: KlwPWS3pRhSOpyiQlwzJEg==
X-CSE-MsgGUID: XOtGyIepTOi+7C/osjH4+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,171,1712646000"; 
   d="scan'208";a="36879956"
Received: from unknown (HELO 108735ec233b) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 18 May 2024 14:54:04 -0700
Received: from kbuild by 108735ec233b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s8S09-0002fM-1Y;
	Sat, 18 May 2024 21:54:01 +0000
Date: Sun, 19 May 2024 05:53:03 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 6a1102a72a295f0cf339a8c78cdc7882ac6cc2b6
Message-ID: <202405190501.TKooT3JJ-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 6a1102a72a295f0cf339a8c78cdc7882ac6cc2b6  Merge branch into tip/master: 'x86/percpu'

elapsed time: 725m

configs tested: 180
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
arc                   randconfig-001-20240518   gcc  
arc                   randconfig-002-20240518   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                          exynos_defconfig   clang
arm                          moxart_defconfig   gcc  
arm                        neponset_defconfig   gcc  
arm                   randconfig-001-20240518   gcc  
arm                   randconfig-002-20240518   clang
arm                   randconfig-003-20240518   gcc  
arm                   randconfig-004-20240518   gcc  
arm                    vt8500_v6_v7_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240518   clang
arm64                 randconfig-002-20240518   gcc  
arm64                 randconfig-003-20240518   clang
arm64                 randconfig-004-20240518   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240518   gcc  
csky                  randconfig-002-20240518   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240518   clang
hexagon               randconfig-002-20240518   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240518   gcc  
i386         buildonly-randconfig-002-20240518   gcc  
i386         buildonly-randconfig-003-20240518   gcc  
i386         buildonly-randconfig-004-20240518   clang
i386         buildonly-randconfig-005-20240518   clang
i386         buildonly-randconfig-006-20240518   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240518   clang
i386                  randconfig-002-20240518   clang
i386                  randconfig-003-20240518   gcc  
i386                  randconfig-004-20240518   gcc  
i386                  randconfig-005-20240518   clang
i386                  randconfig-006-20240518   gcc  
i386                  randconfig-011-20240518   gcc  
i386                  randconfig-012-20240518   clang
i386                  randconfig-013-20240518   clang
i386                  randconfig-014-20240518   gcc  
i386                  randconfig-015-20240518   clang
i386                  randconfig-016-20240518   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240518   gcc  
loongarch             randconfig-002-20240518   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5272c3_defconfig   gcc  
m68k                            mac_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                        bcm47xx_defconfig   clang
mips                  cavium_octeon_defconfig   gcc  
mips                           jazz_defconfig   clang
nios2                         10m50_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240518   gcc  
nios2                 randconfig-002-20240518   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240518   gcc  
parisc                randconfig-002-20240518   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                     mpc512x_defconfig   clang
powerpc                      ppc64e_defconfig   gcc  
powerpc               randconfig-001-20240518   clang
powerpc               randconfig-002-20240518   clang
powerpc               randconfig-003-20240518   clang
powerpc64             randconfig-001-20240518   gcc  
powerpc64             randconfig-002-20240518   gcc  
powerpc64             randconfig-003-20240518   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240518   gcc  
riscv                 randconfig-002-20240518   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240518   clang
s390                  randconfig-002-20240518   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                            hp6xx_defconfig   gcc  
sh                    randconfig-001-20240518   gcc  
sh                    randconfig-002-20240518   gcc  
sh                          rsk7201_defconfig   gcc  
sh                          rsk7203_defconfig   gcc  
sh                           se7722_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240518   gcc  
sparc64               randconfig-002-20240518   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240518   clang
um                    randconfig-002-20240518   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240518   gcc  
x86_64       buildonly-randconfig-002-20240518   clang
x86_64       buildonly-randconfig-003-20240518   clang
x86_64       buildonly-randconfig-004-20240518   clang
x86_64       buildonly-randconfig-005-20240518   clang
x86_64       buildonly-randconfig-006-20240518   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240518   clang
x86_64                randconfig-002-20240518   clang
x86_64                randconfig-003-20240518   gcc  
x86_64                randconfig-004-20240518   gcc  
x86_64                randconfig-005-20240518   gcc  
x86_64                randconfig-006-20240518   clang
x86_64                randconfig-011-20240518   gcc  
x86_64                randconfig-012-20240518   gcc  
x86_64                randconfig-013-20240518   clang
x86_64                randconfig-014-20240518   gcc  
x86_64                randconfig-015-20240518   clang
x86_64                randconfig-016-20240518   clang
x86_64                randconfig-071-20240518   clang
x86_64                randconfig-072-20240518   clang
x86_64                randconfig-073-20240518   gcc  
x86_64                randconfig-074-20240518   clang
x86_64                randconfig-075-20240518   gcc  
x86_64                randconfig-076-20240518   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                generic_kc705_defconfig   gcc  
xtensa                randconfig-001-20240518   gcc  
xtensa                randconfig-002-20240518   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

