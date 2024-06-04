Return-Path: <linux-kernel+bounces-200112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE608FAAE8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 08:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C8711C219B1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 06:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B65A137C38;
	Tue,  4 Jun 2024 06:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OeaXlVZc"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6787412F382
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 06:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717482824; cv=none; b=rPPhTdlQv2Tuz/nUTITILp20ISnFipu2OVfykbdH3mVgEapAyHnjxcwkeQtYh01JAEZpPsgNJ1S2LRkjq/8r109su9DdKuN0CtEcW2hKnuxNn1ZgKtUfapeRqq0ocgDU9RwPDWm2EtPFsskJXEoe8Mwzvla4cwxawtbLI2Ith4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717482824; c=relaxed/simple;
	bh=jz9PgiwPBoFygFNSv04SJyx4o8wUFJ+2niPX9zeU46Q=;
	h=Date:From:To:Cc:Subject:Message-ID; b=c1bZSTKoGjziChaoxQlFXcqMuk088w8A+LiHUDXNswUZxFMlhLEEAb98bvFZugpc3mvSNfAesbFZgIvyXQImRrherJ2nQe6ndKeh7D8Z70y5h+5GnvRU67Xkc5ZENOueAHVMsaBxkGLqjVK4byeppi/yLH0P2SUG3e2aXPzZWrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OeaXlVZc; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717482822; x=1749018822;
  h=date:from:to:cc:subject:message-id;
  bh=jz9PgiwPBoFygFNSv04SJyx4o8wUFJ+2niPX9zeU46Q=;
  b=OeaXlVZc6mk27Gy4iD1pkmbsAmRXRNzAK+SGhjJH0OwU8TwQ2jvQGXPt
   CATxB7cO1MhT24zpHLrqW3Lw4ozvIw0oLPmzFF+L+FyoPYv/DuYzDdBlH
   ibeifIx8TynoOdzkD1wvJenYxAACHUL9zKq+rRPHY37nYW0guqRdwWZLd
   Hs4jUbQM4L7sakSDW7MZWgp8exCL6DzWBuehLQuy9SfeamtqpJonjXGWH
   T0MaX06tEB3NV3NBmQmtaExCr+XneYOzCYaOkvN9ntcECrEBU9SRidQYM
   BQna7IbzeO9iB13haL3sOQ6+9BHECODE8rRS33pmQcUGSCDmN3u8/kqUG
   w==;
X-CSE-ConnectionGUID: 4VxQMW46QaKIWkXpvSCxBg==
X-CSE-MsgGUID: qvs8EzxhRF+QT8ruZBNvEw==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="31539367"
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="31539367"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 23:33:29 -0700
X-CSE-ConnectionGUID: IGzJz5htQrKPLi9d6WVUPA==
X-CSE-MsgGUID: wN6qZO1wQzmensTsS+Xzqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="68300348"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 03 Jun 2024 23:33:28 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sENja-000MfI-1B;
	Tue, 04 Jun 2024 06:33:26 +0000
Date: Tue, 04 Jun 2024 14:32:45 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:timers/core] BUILD SUCCESS
 02ecee07ca30f76f2a0f1381661a688b8e501ab0
Message-ID: <202406041443.HbjebcD8-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
branch HEAD: 02ecee07ca30f76f2a0f1381661a688b8e501ab0  timekeeping: Add function to convert realtime to base clock

elapsed time: 1265m

configs tested: 212
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
arc                          axs101_defconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240603   gcc  
arc                   randconfig-001-20240604   gcc  
arc                   randconfig-002-20240603   gcc  
arc                   randconfig-002-20240604   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240603   gcc  
arm                   randconfig-002-20240603   gcc  
arm                   randconfig-002-20240604   gcc  
arm                   randconfig-003-20240603   gcc  
arm                   randconfig-004-20240603   gcc  
arm                   randconfig-004-20240604   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   clang
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240603   gcc  
arm64                 randconfig-002-20240603   gcc  
arm64                 randconfig-002-20240604   gcc  
arm64                 randconfig-003-20240603   clang
arm64                 randconfig-003-20240604   gcc  
arm64                 randconfig-004-20240603   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240603   gcc  
csky                  randconfig-001-20240604   gcc  
csky                  randconfig-002-20240603   gcc  
csky                  randconfig-002-20240604   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240603   clang
hexagon               randconfig-002-20240603   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240603   clang
i386         buildonly-randconfig-002-20240603   clang
i386         buildonly-randconfig-003-20240603   gcc  
i386         buildonly-randconfig-004-20240603   gcc  
i386         buildonly-randconfig-005-20240603   gcc  
i386         buildonly-randconfig-006-20240603   clang
i386                                defconfig   clang
i386                  randconfig-001-20240603   clang
i386                  randconfig-002-20240603   gcc  
i386                  randconfig-003-20240603   gcc  
i386                  randconfig-004-20240603   clang
i386                  randconfig-005-20240603   clang
i386                  randconfig-006-20240603   gcc  
i386                  randconfig-011-20240603   clang
i386                  randconfig-012-20240603   clang
i386                  randconfig-013-20240603   clang
i386                  randconfig-014-20240603   clang
i386                  randconfig-015-20240603   clang
i386                  randconfig-016-20240603   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240603   gcc  
loongarch             randconfig-001-20240604   gcc  
loongarch             randconfig-002-20240603   gcc  
loongarch             randconfig-002-20240604   gcc  
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
mips                       bmips_be_defconfig   gcc  
mips                  decstation_64_defconfig   gcc  
mips                  maltasmvp_eva_defconfig   gcc  
mips                    maltaup_xpa_defconfig   gcc  
mips                           rs90_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240603   gcc  
nios2                 randconfig-001-20240604   gcc  
nios2                 randconfig-002-20240603   gcc  
nios2                 randconfig-002-20240604   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-32bit_defconfig   gcc  
parisc                randconfig-001-20240603   gcc  
parisc                randconfig-001-20240604   gcc  
parisc                randconfig-002-20240603   gcc  
parisc                randconfig-002-20240604   gcc  
parisc64                         alldefconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20240603   gcc  
powerpc               randconfig-001-20240604   gcc  
powerpc               randconfig-002-20240603   gcc  
powerpc               randconfig-002-20240604   gcc  
powerpc               randconfig-003-20240603   gcc  
powerpc               randconfig-003-20240604   gcc  
powerpc64             randconfig-001-20240603   gcc  
powerpc64             randconfig-001-20240604   gcc  
powerpc64             randconfig-002-20240603   gcc  
powerpc64             randconfig-002-20240604   gcc  
powerpc64             randconfig-003-20240603   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240603   clang
riscv                 randconfig-002-20240603   clang
riscv                 randconfig-002-20240604   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240603   clang
s390                  randconfig-002-20240603   clang
s390                  randconfig-002-20240604   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                          kfr2r09_defconfig   gcc  
sh                    randconfig-001-20240603   gcc  
sh                    randconfig-001-20240604   gcc  
sh                    randconfig-002-20240603   gcc  
sh                    randconfig-002-20240604   gcc  
sh                           se7724_defconfig   gcc  
sh                        sh7763rdp_defconfig   gcc  
sh                  sh7785lcr_32bit_defconfig   gcc  
sh                        sh7785lcr_defconfig   gcc  
sh                            shmin_defconfig   gcc  
sh                              ul2_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240603   gcc  
sparc64               randconfig-001-20240604   gcc  
sparc64               randconfig-002-20240603   gcc  
sparc64               randconfig-002-20240604   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240603   clang
um                    randconfig-002-20240603   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240603   gcc  
x86_64       buildonly-randconfig-001-20240604   clang
x86_64       buildonly-randconfig-002-20240603   gcc  
x86_64       buildonly-randconfig-002-20240604   clang
x86_64       buildonly-randconfig-003-20240603   gcc  
x86_64       buildonly-randconfig-004-20240604   clang
x86_64       buildonly-randconfig-006-20240603   gcc  
x86_64       buildonly-randconfig-006-20240604   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240603   gcc  
x86_64                randconfig-001-20240604   clang
x86_64                randconfig-004-20240603   gcc  
x86_64                randconfig-005-20240603   gcc  
x86_64                randconfig-006-20240603   gcc  
x86_64                randconfig-011-20240603   gcc  
x86_64                randconfig-011-20240604   clang
x86_64                randconfig-012-20240603   gcc  
x86_64                randconfig-012-20240604   clang
x86_64                randconfig-013-20240604   clang
x86_64                randconfig-014-20240603   gcc  
x86_64                randconfig-014-20240604   clang
x86_64                randconfig-015-20240603   gcc  
x86_64                randconfig-015-20240604   clang
x86_64                randconfig-016-20240604   clang
x86_64                randconfig-071-20240604   clang
x86_64                randconfig-074-20240604   clang
x86_64                randconfig-075-20240603   gcc  
x86_64                randconfig-075-20240604   clang
x86_64                randconfig-076-20240603   gcc  
x86_64                randconfig-076-20240604   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240603   gcc  
xtensa                randconfig-001-20240604   gcc  
xtensa                randconfig-002-20240603   gcc  
xtensa                randconfig-002-20240604   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

