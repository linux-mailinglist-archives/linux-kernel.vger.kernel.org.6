Return-Path: <linux-kernel+bounces-190302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9617D8CFC9D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8A041C20D91
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DAB2135417;
	Mon, 27 May 2024 09:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gP4I8+ej"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B3B8BF0
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 09:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716801478; cv=none; b=RHUSoV8twhqPGDOGXKdvCua4NouawCiW5IolAfo+4ppS3bwATXZiiENCymz/fXqYoWQugeTbgIOrOCNA7Kckgsf2IKKNHIGBlbqd6h4+PqaoVhKHa+Zz5G51Je+6nmi+KzPut/T10WzCn1xLsVzsUF9/DTl7aDW3j+Hplyy/nWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716801478; c=relaxed/simple;
	bh=X+1TdWIBc4VkSsANR/M4LMEsY8Y2Pyi4OaOg4+ddEGs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=VmeYkCs0PLNnw/EtsjUOV9gW4zqVGlQc097UuVP/7Vo0u/inZFKH5p4XkEONGcrtwINJVy/OU6syYJqzetsPDgmYciehCgy0rpnToBMdxd5I77W8ckXaM+AejU1SSmqoNxkEUTzEIZD1iv6a3mw+cxgDyB7biVRQr27rYs+u1H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gP4I8+ej; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716801477; x=1748337477;
  h=date:from:to:cc:subject:message-id;
  bh=X+1TdWIBc4VkSsANR/M4LMEsY8Y2Pyi4OaOg4+ddEGs=;
  b=gP4I8+ejuVZeVG9HhDfNSLypU17LXRFuupDRfcUd7sGsTPdgTskwmo+7
   YLObFIGKgyAJ3jDCtD8zwlNoKxoSXSuui/TztlcKWfUrKSbkog6yRbCWW
   7Vwz84xgMKvMiKrUHAxKfGUj6kCBlaPFXVAkThQSrl0W5wtkkOWymvPvG
   3xCiUwY/oGXDgpHfZjE6+QuY3F8fstjvwypwndnWJv3JHmROOl2qU9LWv
   VBR7G0mJyVg/Wpp3N/eHK9TNGvKQJv9d5yBINIuz788mR634453B/gan0
   NNB4R/1DA1mARjfWsehXnVlO796j41NxiCzVIU0qq06NLumkLOoIOBHhj
   w==;
X-CSE-ConnectionGUID: 6RwDYdiXSmaRWDWqfK/y0A==
X-CSE-MsgGUID: fwsfImBiQ2SWIKu2ZzpxzA==
X-IronPort-AV: E=McAfee;i="6600,9927,11084"; a="12930534"
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="12930534"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 02:17:47 -0700
X-CSE-ConnectionGUID: pTcDNNuhQxGHc+r+ovOx5A==
X-CSE-MsgGUID: uYfB3qeqTDO/QGwDmUBU/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="34707943"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 27 May 2024 02:17:46 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sBWUA-0009rZ-2y;
	Mon, 27 May 2024 09:17:42 +0000
Date: Mon, 27 May 2024 17:17:21 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 66fff7c87d0d183ca45502d31578a45bbccba8c2
Message-ID: <202405271718.7zKsop3w-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 66fff7c87d0d183ca45502d31578a45bbccba8c2  Merge branch into tip/master: 'x86/percpu'

elapsed time: 724m

configs tested: 172
configs skipped: 4

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
arc                   randconfig-001-20240527   gcc  
arc                   randconfig-002-20240527   gcc  
arc                           tb10x_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                        mvebu_v5_defconfig   gcc  
arm                        neponset_defconfig   gcc  
arm                   randconfig-002-20240527   gcc  
arm                   randconfig-003-20240527   gcc  
arm                   randconfig-004-20240527   gcc  
arm                           spitz_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240527   gcc  
arm64                 randconfig-002-20240527   gcc  
arm64                 randconfig-004-20240527   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240527   gcc  
csky                  randconfig-002-20240527   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240527   gcc  
i386         buildonly-randconfig-002-20240527   gcc  
i386         buildonly-randconfig-003-20240527   gcc  
i386         buildonly-randconfig-004-20240527   clang
i386         buildonly-randconfig-005-20240527   gcc  
i386         buildonly-randconfig-006-20240527   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240527   gcc  
i386                  randconfig-002-20240527   clang
i386                  randconfig-003-20240527   gcc  
i386                  randconfig-004-20240527   gcc  
i386                  randconfig-005-20240527   gcc  
i386                  randconfig-006-20240527   gcc  
i386                  randconfig-011-20240527   gcc  
i386                  randconfig-012-20240527   clang
i386                  randconfig-013-20240527   gcc  
i386                  randconfig-014-20240527   clang
i386                  randconfig-015-20240527   gcc  
i386                  randconfig-016-20240527   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240527   gcc  
loongarch             randconfig-002-20240527   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                          hp300_defconfig   gcc  
m68k                       m5275evb_defconfig   gcc  
m68k                        mvme16x_defconfig   gcc  
m68k                           sun3_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                     cu1000-neo_defconfig   gcc  
mips                  decstation_64_defconfig   gcc  
mips                     decstation_defconfig   gcc  
nios2                            alldefconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240527   gcc  
nios2                 randconfig-002-20240527   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240527   gcc  
parisc                randconfig-002-20240527   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                    amigaone_defconfig   gcc  
powerpc                  iss476-smp_defconfig   gcc  
powerpc                     powernv_defconfig   gcc  
powerpc               randconfig-001-20240527   gcc  
powerpc               randconfig-002-20240527   gcc  
powerpc                    socrates_defconfig   gcc  
powerpc                     tqm8540_defconfig   gcc  
powerpc                      walnut_defconfig   gcc  
powerpc64             randconfig-002-20240527   gcc  
powerpc64             randconfig-003-20240527   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                        apsh4ad0a_defconfig   gcc  
sh                                  defconfig   gcc  
sh                        edosk7760_defconfig   gcc  
sh                             espt_defconfig   gcc  
sh                 kfr2r09-romimage_defconfig   gcc  
sh                    randconfig-001-20240527   gcc  
sh                    randconfig-002-20240527   gcc  
sh                   rts7751r2dplus_defconfig   gcc  
sh                           se7705_defconfig   gcc  
sh                           se7712_defconfig   gcc  
sh                           se7722_defconfig   gcc  
sh                           se7751_defconfig   gcc  
sh                   sh7724_generic_defconfig   gcc  
sh                   sh7770_generic_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240527   gcc  
sparc64               randconfig-002-20240527   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240527   gcc  
um                    randconfig-002-20240527   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-002-20240527   gcc  
x86_64       buildonly-randconfig-003-20240527   gcc  
x86_64       buildonly-randconfig-004-20240527   gcc  
x86_64       buildonly-randconfig-005-20240527   gcc  
x86_64       buildonly-randconfig-006-20240527   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-002-20240527   gcc  
x86_64                randconfig-011-20240527   gcc  
x86_64                randconfig-012-20240527   gcc  
x86_64                randconfig-014-20240527   gcc  
x86_64                randconfig-015-20240527   gcc  
x86_64                randconfig-016-20240527   gcc  
x86_64                randconfig-071-20240527   gcc  
x86_64                randconfig-076-20240527   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                generic_kc705_defconfig   gcc  
xtensa                randconfig-001-20240527   gcc  
xtensa                randconfig-002-20240527   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

