Return-Path: <linux-kernel+bounces-343304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4181698995E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 05:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 696DC1C20BF4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 03:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BE72B9B7;
	Mon, 30 Sep 2024 03:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dDv5N1mv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FD82F29
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 03:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727666209; cv=none; b=XBOjmwzkZ19GKJRW48PCpLHwDJeTRdlCsTd/sxOqjFkEG5IaxdyDFO8i4HZl77QhEd7W8L2/Vp9CJCZgf0dahzly0Ds104PNdJISXZJe4jxUKOkIy1xSfcKNsrktCNu8wkwowuoREmUpzDEwhAr0dqxyi9fEzaBPUfzJ52N7+1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727666209; c=relaxed/simple;
	bh=VJyyUGIfPG5MH1zCjIPK0B7zaSn85n0jOAc6HGE0/1A=;
	h=Date:From:To:Cc:Subject:Message-ID; b=fDAbpf2ouifiYTLXd1HhK3vnyZxhF5prwuTQHpZi/6a3YlhOMpTvYdp7hI/Fdsaywo6CAEA0YNi8K7o2XNX39H0Tj6EbwtEnzJABTfRG1qDQI41zdUgQf56+N4USDYH9xaKGnKDulRr9EQLvjYkU47aMJU/mqlu/CuNgxzDC9Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dDv5N1mv; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727666207; x=1759202207;
  h=date:from:to:cc:subject:message-id;
  bh=VJyyUGIfPG5MH1zCjIPK0B7zaSn85n0jOAc6HGE0/1A=;
  b=dDv5N1mvOWLOmiQWhfIi7HtHRkE+NGhFLZsrlxLxIY3MQ5ne0fILYmXz
   /DI/eBRKhVOnYyQaNLIObHw0YbIN6U/HlhfvENwHlLrZ9dpdZmfByPofn
   adICrZkrw/O5YtVSH8sOlf07Dt6IqGC7xFBRW4HvwHjdif5fHK0PS5S3L
   exyqaWVKBOnta+S4eyd/Hj/8ZJ3isekXw6uuoywuMHTobJ2j4hlFy+2eP
   kmYcvMFW3bHO90BJiEIGe++F2dyPoNspMGetgum+jf6s5uQuGx0jzgRv0
   sWL3O3s9Xs+rQM9E6FvaUTNy2YR0mWGBIu1Oxb3xxDtGfCY7WWSTtMBG9
   A==;
X-CSE-ConnectionGUID: nRfx1y5oR16joilLvhaWlw==
X-CSE-MsgGUID: Q3mz8Pa1S+y9MeOCzZDlmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11210"; a="30438135"
X-IronPort-AV: E=Sophos;i="6.11,164,1725346800"; 
   d="scan'208";a="30438135"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2024 20:16:46 -0700
X-CSE-ConnectionGUID: HZnRoQdIQYSSjfsVVaa8Zg==
X-CSE-MsgGUID: kPbwR0E+QmGYjTy2XlsBtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,164,1725346800"; 
   d="scan'208";a="73476195"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 29 Sep 2024 20:16:45 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sv6tu-000Oz9-29;
	Mon, 30 Sep 2024 03:16:42 +0000
Date: Mon, 30 Sep 2024 11:16:38 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 e6f94e75819dd987911ade54d2c7812955737acc
Message-ID: <202409301133.NOJsZQf0-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: e6f94e75819dd987911ade54d2c7812955737acc  Merge branch into tip/master: 'x86/splitlock'

elapsed time: 1201m

configs tested: 233
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-13.3.0
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                            allyesconfig    gcc-13.3.0
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-14.1.0
arc                     haps_hs_smp_defconfig    clang-20
arc                     haps_hs_smp_defconfig    gcc-14.1.0
arc                   randconfig-001-20240930    clang-15
arc                   randconfig-002-20240930    clang-15
arc                           tb10x_defconfig    clang-20
arc                    vdk_hs38_smp_defconfig    gcc-14.1.0
arm                              allmodconfig    clang-20
arm                              allmodconfig    gcc-14.1.0
arm                               allnoconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                              allyesconfig    gcc-14.1.0
arm                                 defconfig    gcc-14.1.0
arm                          ep93xx_defconfig    clang-20
arm                      integrator_defconfig    clang-20
arm                       omap2plus_defconfig    gcc-14.1.0
arm                         orion5x_defconfig    clang-20
arm                   randconfig-001-20240930    clang-15
arm                   randconfig-002-20240930    clang-15
arm                   randconfig-003-20240930    clang-15
arm                   randconfig-004-20240930    clang-15
arm                        realview_defconfig    clang-20
arm                          sp7021_defconfig    clang-20
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
arm64                 randconfig-001-20240930    clang-15
arm64                 randconfig-002-20240930    clang-15
arm64                 randconfig-003-20240930    clang-15
arm64                 randconfig-004-20240930    clang-15
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
csky                  randconfig-001-20240930    clang-15
csky                  randconfig-002-20240930    clang-15
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
hexagon               randconfig-001-20240930    clang-15
hexagon               randconfig-002-20240930    clang-15
i386                             allmodconfig    clang-18
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-18
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-18
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20240929    clang-18
i386        buildonly-randconfig-001-20240930    clang-18
i386        buildonly-randconfig-002-20240929    clang-18
i386        buildonly-randconfig-002-20240930    clang-18
i386        buildonly-randconfig-003-20240929    clang-18
i386        buildonly-randconfig-003-20240930    clang-18
i386        buildonly-randconfig-004-20240929    clang-18
i386        buildonly-randconfig-004-20240930    clang-18
i386        buildonly-randconfig-005-20240929    clang-18
i386        buildonly-randconfig-005-20240930    clang-18
i386        buildonly-randconfig-006-20240929    clang-18
i386        buildonly-randconfig-006-20240930    clang-18
i386                                defconfig    clang-18
i386                  randconfig-001-20240929    clang-18
i386                  randconfig-001-20240930    clang-18
i386                  randconfig-002-20240929    clang-18
i386                  randconfig-002-20240930    clang-18
i386                  randconfig-003-20240929    gcc-12
i386                  randconfig-003-20240930    clang-18
i386                  randconfig-004-20240929    clang-18
i386                  randconfig-004-20240930    clang-18
i386                  randconfig-005-20240929    clang-18
i386                  randconfig-005-20240930    clang-18
i386                  randconfig-006-20240929    gcc-12
i386                  randconfig-006-20240930    clang-18
i386                  randconfig-011-20240929    gcc-11
i386                  randconfig-011-20240930    clang-18
i386                  randconfig-012-20240929    gcc-12
i386                  randconfig-012-20240930    clang-18
i386                  randconfig-013-20240929    clang-18
i386                  randconfig-013-20240930    clang-18
i386                  randconfig-014-20240929    gcc-12
i386                  randconfig-014-20240930    clang-18
i386                  randconfig-015-20240929    clang-18
i386                  randconfig-015-20240930    clang-18
i386                  randconfig-016-20240929    gcc-12
i386                  randconfig-016-20240930    clang-18
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
loongarch                 loongson3_defconfig    clang-20
loongarch             randconfig-001-20240930    clang-15
loongarch             randconfig-002-20240930    clang-15
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
m68k                            mac_defconfig    gcc-14.1.0
m68k                           sun3_defconfig    gcc-14.1.0
m68k                          sun3x_defconfig    clang-20
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                       bmips_be_defconfig    gcc-14.1.0
mips                           ci20_defconfig    clang-20
mips                      fuloong2e_defconfig    gcc-14.1.0
mips                     loongson1b_defconfig    gcc-14.1.0
mips                      pic32mzda_defconfig    gcc-14.1.0
mips                          rb532_defconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
nios2                 randconfig-001-20240930    clang-15
nios2                 randconfig-002-20240930    clang-15
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.1.0
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.1.0
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20240930    clang-15
parisc                randconfig-002-20240930    clang-15
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.1.0
powerpc                          allyesconfig    clang-20
powerpc                          allyesconfig    gcc-14.1.0
powerpc                   bluestone_defconfig    clang-20
powerpc                      cm5200_defconfig    clang-20
powerpc                     ep8248e_defconfig    clang-20
powerpc               randconfig-001-20240930    clang-15
powerpc               randconfig-002-20240930    clang-15
powerpc               randconfig-003-20240930    clang-15
powerpc64             randconfig-001-20240930    clang-15
powerpc64             randconfig-002-20240930    clang-15
powerpc64             randconfig-003-20240930    clang-15
riscv                            allmodconfig    clang-20
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.1.0
riscv                            allyesconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20240930    clang-15
riscv                 randconfig-002-20240930    clang-15
s390                             allmodconfig    clang-20
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20240930    clang-15
s390                  randconfig-002-20240930    clang-15
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                             espt_defconfig    gcc-14.1.0
sh                            hp6xx_defconfig    clang-20
sh                 kfr2r09-romimage_defconfig    gcc-14.1.0
sh                    randconfig-001-20240930    clang-15
sh                    randconfig-002-20240930    clang-15
sh                           se7619_defconfig    clang-20
sh                             shx3_defconfig    gcc-14.1.0
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20240930    clang-15
sparc64               randconfig-002-20240930    clang-15
um                               alldefconfig    clang-20
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    clang-20
um                             i386_defconfig    gcc-12
um                             i386_defconfig    gcc-14.1.0
um                    randconfig-001-20240930    clang-15
um                    randconfig-002-20240930    clang-15
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64      buildonly-randconfig-001-20240930    gcc-11
x86_64      buildonly-randconfig-002-20240930    gcc-11
x86_64      buildonly-randconfig-003-20240930    gcc-11
x86_64      buildonly-randconfig-004-20240930    gcc-11
x86_64      buildonly-randconfig-005-20240930    gcc-11
x86_64      buildonly-randconfig-006-20240930    gcc-11
x86_64                              defconfig    clang-18
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-18
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20240930    gcc-11
x86_64                randconfig-002-20240930    gcc-11
x86_64                randconfig-003-20240930    gcc-11
x86_64                randconfig-004-20240930    gcc-11
x86_64                randconfig-005-20240930    gcc-11
x86_64                randconfig-006-20240930    gcc-11
x86_64                randconfig-011-20240930    gcc-11
x86_64                randconfig-012-20240930    gcc-11
x86_64                randconfig-013-20240930    gcc-11
x86_64                randconfig-014-20240930    gcc-11
x86_64                randconfig-015-20240930    gcc-11
x86_64                randconfig-016-20240930    gcc-11
x86_64                randconfig-071-20240930    gcc-11
x86_64                randconfig-072-20240930    gcc-11
x86_64                randconfig-073-20240930    gcc-11
x86_64                randconfig-074-20240930    gcc-11
x86_64                randconfig-075-20240930    gcc-11
x86_64                randconfig-076-20240930    gcc-11
x86_64                               rhel-8.3    gcc-12
x86_64                           rhel-8.3-bpf    clang-18
x86_64                         rhel-8.3-kunit    clang-18
x86_64                           rhel-8.3-ltp    clang-18
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0
xtensa                       common_defconfig    gcc-14.1.0
xtensa                randconfig-001-20240930    clang-15
xtensa                randconfig-002-20240930    clang-15

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

