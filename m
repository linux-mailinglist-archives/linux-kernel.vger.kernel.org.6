Return-Path: <linux-kernel+bounces-168584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E5E68BBA6F
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 12:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 572D51C210AB
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 10:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA8517BAA;
	Sat,  4 May 2024 10:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LFoJiS+R"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936A317556
	for <linux-kernel@vger.kernel.org>; Sat,  4 May 2024 10:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714817248; cv=none; b=qilBM4fU9E//tPEfPJR9g8M1kbBHzLtJXjg+x/Hmjg9Jcee7AIZwFvTnLkfDtG82nNp7AJlmD5HPt6QbyYgSf3aK7IMzbHhtIPFDnvw9OpqEjLEH+GtfKT/n2vpidWWzfif4HFgzIZ3TzKkv9V2qYhWkvOJddeAjIHrS/TatqBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714817248; c=relaxed/simple;
	bh=lavg5alSOBV9imzmSJrj8axu/HUYzSBjP3iR2NipXQE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=s8WNrnu1yqZEdd12Fvla0Zwyx5+af7rhBYE0hL+Pyj2W/4Ic/eF0gJr1VHL6Z613McTmFLI9uv9Zpjdq+aSFMHcl125ZScZUsogYfpLM0wi0pDld8TQZJFvNDKn6jOoCLLQaedfMnB2juRYBhFcqGwgFAtt4Bqmw4GxguTaCUgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LFoJiS+R; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714817246; x=1746353246;
  h=date:from:to:cc:subject:message-id;
  bh=lavg5alSOBV9imzmSJrj8axu/HUYzSBjP3iR2NipXQE=;
  b=LFoJiS+Rxfic8qXPLDBPnt3TrTNlmYiVNqxziyEc1zORByRqi+IPrGrE
   yuatG3OYnfvPIg0/9rg63sDrCznI3TVdJAtYrTrseQgfL6g0RMrMw7W5P
   KYwk74xJ/ZgSyUMcrvQtfz4jHPwX4UzEgRN+5lJusr8MRkXsz+WEOUNpb
   Tba19BjQfybkiNQ1yAOD1205OSIuTg35S+er5MzL9NcXxunUxlAaQ1x0I
   68hv0YM0AR0z3FC5GtPCS1mP35BWjly9S6eOYiDitPTXeeKimMKZwLrsl
   /d2wPS8J9vyoDmEoUZjEG0TxUmDwztj2fyejDcN0gA8gHp+J0SSjfsKws
   w==;
X-CSE-ConnectionGUID: g0nu6dqNQmaKneFhVWx+Ag==
X-CSE-MsgGUID: 5ooWyGuWT+alaV2BPd0tyQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="10745831"
X-IronPort-AV: E=Sophos;i="6.07,253,1708416000"; 
   d="scan'208";a="10745831"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2024 03:07:25 -0700
X-CSE-ConnectionGUID: 7M2lsK70RYGzztdIuIOCiA==
X-CSE-MsgGUID: NskagMwJQeG7vQ1xmJyGQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,253,1708416000"; 
   d="scan'208";a="28267897"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 04 May 2024 03:07:25 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s3CIb-000Ces-35;
	Sat, 04 May 2024 10:07:21 +0000
Date: Sat, 04 May 2024 18:06:30 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:perf/core] BUILD SUCCESS
 626c5acf39ba929a0d82d37e72072e21492a958e
Message-ID: <202405041829.1vjky30G-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core
branch HEAD: 626c5acf39ba929a0d82d37e72072e21492a958e  perf/x86/rapl: Rename 'maxdie' to nr_rapl_pmu and 'dieid' to rapl_pmu_idx

elapsed time: 1445m

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
arc                   randconfig-001-20240504   gcc  
arc                   randconfig-002-20240504   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                          moxart_defconfig   gcc  
arm                       omap2plus_defconfig   gcc  
arm                             pxa_defconfig   gcc  
arm                           u8500_defconfig   gcc  
arm                    vt8500_v6_v7_defconfig   gcc  
arm64                            alldefconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   clang
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240504   gcc  
arm64                 randconfig-002-20240504   gcc  
arm64                 randconfig-003-20240504   gcc  
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
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240504   gcc  
loongarch             randconfig-002-20240504   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5208evb_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                       lemote2f_defconfig   gcc  
mips                    maltaup_xpa_defconfig   gcc  
mips                          rm200_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240504   gcc  
nios2                 randconfig-002-20240504   gcc  
openrisc                         allmodconfig   gcc  
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
powerpc                        fsp2_defconfig   gcc  
powerpc                         ps3_defconfig   gcc  
powerpc               randconfig-001-20240504   gcc  
powerpc               randconfig-002-20240504   gcc  
powerpc               randconfig-003-20240504   gcc  
powerpc                    sam440ep_defconfig   gcc  
powerpc                  storcenter_defconfig   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240504   gcc  
riscv                 randconfig-002-20240504   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-002-20240504   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                         ap325rxa_defconfig   gcc  
sh                                  defconfig   gcc  
sh                         ecovec24_defconfig   gcc  
sh                    randconfig-001-20240504   gcc  
sh                    randconfig-002-20240504   gcc  
sh                           se7206_defconfig   gcc  
sh                           se7751_defconfig   gcc  
sh                           se7780_defconfig   gcc  
sh                   sh7724_generic_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240504   gcc  
sparc64               randconfig-002-20240504   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240504   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240504   gcc  
x86_64       buildonly-randconfig-002-20240504   clang
x86_64       buildonly-randconfig-003-20240504   gcc  
x86_64       buildonly-randconfig-004-20240504   gcc  
x86_64       buildonly-randconfig-005-20240504   clang
x86_64       buildonly-randconfig-006-20240504   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240504   clang
x86_64                randconfig-002-20240504   clang
x86_64                randconfig-003-20240504   clang
x86_64                randconfig-004-20240504   clang
x86_64                randconfig-005-20240504   gcc  
x86_64                randconfig-006-20240504   clang
x86_64                randconfig-011-20240504   gcc  
x86_64                randconfig-012-20240504   clang
x86_64                randconfig-013-20240504   gcc  
x86_64                randconfig-014-20240504   clang
x86_64                randconfig-015-20240504   gcc  
x86_64                randconfig-016-20240504   clang
x86_64                randconfig-071-20240504   gcc  
x86_64                randconfig-072-20240504   clang
x86_64                randconfig-073-20240504   gcc  
x86_64                randconfig-074-20240504   gcc  
x86_64                randconfig-075-20240504   clang
x86_64                randconfig-076-20240504   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                generic_kc705_defconfig   gcc  
xtensa                randconfig-001-20240504   gcc  
xtensa                randconfig-002-20240504   gcc  
xtensa                    xip_kc705_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

