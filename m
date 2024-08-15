Return-Path: <linux-kernel+bounces-287712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2731F952BCB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 12:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D08A32833AB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 10:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C7B1BB6AC;
	Thu, 15 Aug 2024 09:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UIz9bxfq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED4019DF68
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 09:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723712707; cv=none; b=sEAGWhd5OITJnbXl2Va7MjfKByOA5IInf+zTk9bk7MXi4ILvuEKiCXhoC7T7GujKYyoRNrechFjpGthTnjsSRW/0HQVIccKfac1nSm9K7g70N75G1Tev1LqksFcEnEuj2+D8TwWQjBKiDXlMVCMU4pkp73VS0zcQITtq+Ui7NNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723712707; c=relaxed/simple;
	bh=BvBoKEulluwwI50YIpSSyN30AprN3f9CQurdOkmlusk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=rD1N6pjV4UzdChTFPU38EY8s0h/LqJ6JcjfTx67z9P06LEO3RUda9ojZ2pETNP/jIMxaApp2DmoyclAAt1bpxZGyqNTMitgW6HGFeyrbAf7CgD40ktW95GTeC5On7qfTmsrpDwdIZDG1ISo+5pdjLh9V+z9aiHrvwEi1boR6sVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UIz9bxfq; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723712705; x=1755248705;
  h=date:from:to:cc:subject:message-id;
  bh=BvBoKEulluwwI50YIpSSyN30AprN3f9CQurdOkmlusk=;
  b=UIz9bxfqCP31j7NRYGHdxa/JcguTYUCQHsz/vbOot6A1EWZn4UjOXe3r
   /zfdlUAgIk66iLTjT5UrVcd/Myw0Ic4Z5XBeCJpMp+1M35CGPhSJXlkTh
   A1jPFbdsmv9baYfWi4BFQgj/0OBUxr+hNNlmEBUOnie17aonpXnfnzYGi
   UKx0YH5ryE0UZsaVl/K78GHBXXc8+6XgofnYtCmvNaBoLfu0F+muWNiGR
   5GuKBdPMbHNja2hFeLkd3+h7DcLrk+/3FZjB5cSk35z07q/9CzWEHVKFG
   Z+Qe/kFfUHQPvEF8pUtuUavCPeWojD0OfObkltxaOxLIttDBFJ7aOybqR
   Q==;
X-CSE-ConnectionGUID: XRvnnFO6QMugmm0ncpBIfw==
X-CSE-MsgGUID: ID53IZR6R12rNwrl8pmswQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="44478447"
X-IronPort-AV: E=Sophos;i="6.10,148,1719903600"; 
   d="scan'208";a="44478447"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 02:05:04 -0700
X-CSE-ConnectionGUID: 9a9Lsy5HTPC68FOX0y8bvw==
X-CSE-MsgGUID: IjNBZuYSTAmDuLnMwBsjeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,148,1719903600"; 
   d="scan'208";a="58929988"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 15 Aug 2024 02:05:03 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1seWPl-0003M2-0i;
	Thu, 15 Aug 2024 09:05:01 +0000
Date: Thu, 15 Aug 2024 17:04:08 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:timers/core] BUILD SUCCESS
 330dd6d9c0fce69718b53ca0bc4f2e3920f7f600
Message-ID: <202408151705.7QT9tYbb-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
branch HEAD: 330dd6d9c0fce69718b53ca0bc4f2e3920f7f600  hrtimer: Annotate hrtimer_cpu_base_.*_expiry() for sparse.

elapsed time: 1337m

configs tested: 218
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240815   gcc-13.2.0
arc                   randconfig-002-20240815   gcc-13.2.0
arm                              alldefconfig   gcc-14.1.0
arm                              allmodconfig   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-20
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                              allyesconfig   gcc-14.1.0
arm                        clps711x_defconfig   gcc-14.1.0
arm                                 defconfig   gcc-13.2.0
arm                            dove_defconfig   gcc-14.1.0
arm                   randconfig-001-20240815   gcc-13.2.0
arm                   randconfig-002-20240815   gcc-13.2.0
arm                   randconfig-003-20240815   gcc-13.2.0
arm                   randconfig-004-20240815   gcc-13.2.0
arm64                            allmodconfig   clang-20
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240815   gcc-13.2.0
arm64                 randconfig-002-20240815   gcc-13.2.0
arm64                 randconfig-003-20240815   gcc-13.2.0
arm64                 randconfig-004-20240815   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240815   gcc-13.2.0
csky                  randconfig-002-20240815   gcc-13.2.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   clang-20
hexagon                          allyesconfig   clang-20
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-12
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-12
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240814   clang-18
i386         buildonly-randconfig-001-20240815   gcc-12
i386         buildonly-randconfig-002-20240814   clang-18
i386         buildonly-randconfig-002-20240815   gcc-12
i386         buildonly-randconfig-003-20240814   clang-18
i386         buildonly-randconfig-003-20240815   gcc-12
i386         buildonly-randconfig-004-20240814   clang-18
i386         buildonly-randconfig-004-20240815   gcc-12
i386         buildonly-randconfig-005-20240814   gcc-12
i386         buildonly-randconfig-005-20240815   gcc-12
i386         buildonly-randconfig-006-20240814   gcc-12
i386         buildonly-randconfig-006-20240815   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240814   clang-18
i386                  randconfig-001-20240815   gcc-12
i386                  randconfig-002-20240814   gcc-12
i386                  randconfig-002-20240815   gcc-12
i386                  randconfig-003-20240814   gcc-12
i386                  randconfig-003-20240815   gcc-12
i386                  randconfig-004-20240814   clang-18
i386                  randconfig-004-20240815   gcc-12
i386                  randconfig-005-20240814   clang-18
i386                  randconfig-005-20240815   gcc-12
i386                  randconfig-006-20240814   clang-18
i386                  randconfig-006-20240815   gcc-12
i386                  randconfig-011-20240814   gcc-12
i386                  randconfig-011-20240815   gcc-12
i386                  randconfig-012-20240814   gcc-12
i386                  randconfig-012-20240815   gcc-12
i386                  randconfig-013-20240814   clang-18
i386                  randconfig-013-20240815   gcc-12
i386                  randconfig-014-20240814   gcc-11
i386                  randconfig-014-20240815   gcc-12
i386                  randconfig-015-20240814   gcc-12
i386                  randconfig-015-20240815   gcc-12
i386                  randconfig-016-20240814   gcc-12
i386                  randconfig-016-20240815   gcc-12
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240815   gcc-13.2.0
loongarch             randconfig-002-20240815   gcc-13.2.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-14.1.0
mips                  cavium_octeon_defconfig   gcc-14.1.0
mips                           ci20_defconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240815   gcc-13.2.0
nios2                 randconfig-002-20240815   gcc-13.2.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240815   gcc-13.2.0
parisc                randconfig-002-20240815   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-20
powerpc                          allyesconfig   gcc-14.1.0
powerpc                        cell_defconfig   gcc-14.1.0
powerpc               randconfig-001-20240815   gcc-13.2.0
powerpc               randconfig-002-20240815   gcc-13.2.0
powerpc                     sequoia_defconfig   gcc-14.1.0
powerpc                     tqm8548_defconfig   gcc-14.1.0
powerpc64             randconfig-001-20240815   gcc-13.2.0
powerpc64             randconfig-002-20240815   gcc-13.2.0
powerpc64             randconfig-003-20240815   gcc-13.2.0
riscv                            allmodconfig   clang-20
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-20
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-14.1.0
riscv                 randconfig-001-20240815   gcc-13.2.0
riscv                 randconfig-002-20240815   gcc-13.2.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240815   gcc-13.2.0
s390                  randconfig-002-20240815   gcc-13.2.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                 kfr2r09-romimage_defconfig   gcc-14.1.0
sh                          kfr2r09_defconfig   gcc-14.1.0
sh                    randconfig-001-20240815   gcc-13.2.0
sh                    randconfig-002-20240815   gcc-13.2.0
sh                      rts7751r2d1_defconfig   gcc-14.1.0
sh                           se7750_defconfig   gcc-14.1.0
sh                   sh7724_generic_defconfig   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc                       sparc64_defconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240815   gcc-13.2.0
sparc64               randconfig-002-20240815   gcc-13.2.0
um                               allmodconfig   clang-20
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-12
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240815   gcc-13.2.0
um                    randconfig-002-20240815   gcc-13.2.0
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240815   gcc-12
x86_64       buildonly-randconfig-002-20240815   gcc-11
x86_64       buildonly-randconfig-002-20240815   gcc-12
x86_64       buildonly-randconfig-003-20240815   clang-18
x86_64       buildonly-randconfig-003-20240815   gcc-12
x86_64       buildonly-randconfig-004-20240815   gcc-12
x86_64       buildonly-randconfig-005-20240815   gcc-12
x86_64       buildonly-randconfig-006-20240815   gcc-12
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-11
x86_64                randconfig-001-20240815   clang-18
x86_64                randconfig-001-20240815   gcc-12
x86_64                randconfig-002-20240815   gcc-12
x86_64                randconfig-003-20240815   clang-18
x86_64                randconfig-003-20240815   gcc-12
x86_64                randconfig-004-20240815   gcc-12
x86_64                randconfig-005-20240815   clang-18
x86_64                randconfig-005-20240815   gcc-12
x86_64                randconfig-006-20240815   gcc-12
x86_64                randconfig-011-20240815   clang-18
x86_64                randconfig-011-20240815   gcc-12
x86_64                randconfig-012-20240815   gcc-12
x86_64                randconfig-013-20240815   gcc-12
x86_64                randconfig-014-20240815   gcc-12
x86_64                randconfig-015-20240815   gcc-12
x86_64                randconfig-016-20240815   clang-18
x86_64                randconfig-016-20240815   gcc-12
x86_64                randconfig-071-20240815   clang-18
x86_64                randconfig-071-20240815   gcc-12
x86_64                randconfig-072-20240815   gcc-12
x86_64                randconfig-073-20240815   clang-18
x86_64                randconfig-073-20240815   gcc-12
x86_64                randconfig-074-20240815   gcc-12
x86_64                randconfig-075-20240815   clang-18
x86_64                randconfig-075-20240815   gcc-12
x86_64                randconfig-076-20240815   gcc-12
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240815   gcc-13.2.0
xtensa                randconfig-002-20240815   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

