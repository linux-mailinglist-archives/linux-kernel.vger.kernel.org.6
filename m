Return-Path: <linux-kernel+bounces-304562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D25B39621D9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 09:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 033061C235EB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 07:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1307F15B0F1;
	Wed, 28 Aug 2024 07:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OiR/44Xl"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C0F157A67
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 07:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724831809; cv=none; b=mhhRv770kAyI+rJgmgQjmRoPpG5pHsaT+MGYE6yv8WXEMy1EsAv+y75HySBXmvcJrISaBPh4n8KclJp5tbbbX7lN/GJ5DsSjPxA++Nh9i2MsWH85bJCcKL48aNTQBx1LjvGyQaP3vEZ//R1kfdsSf1Ab4FYNnyVwiyL1JmiSVv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724831809; c=relaxed/simple;
	bh=veZTnw5SMwXiq1Dp6JVPj0f0d+1bMTsq/hlJbJmD0Hg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=AVdoioCQn/eqYFEYFqGwBnFBbdKxIJvz6ZavA+MqnBOybmmwcFw7sOYXg/uF/Y56PTzth2PYHHPWiXo/giSnjZhvSQ8RgskE2NUPeMS5Vyze4z+nuiP8elyhIvMu3oxXKNNN7b4qTq+hbjCk8UfSz4Qb5gv4XKV2XZ7faxbOS2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OiR/44Xl; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724831806; x=1756367806;
  h=date:from:to:cc:subject:message-id;
  bh=veZTnw5SMwXiq1Dp6JVPj0f0d+1bMTsq/hlJbJmD0Hg=;
  b=OiR/44XluMsd1StKgW0xS8P4Ft1oc/B9v4b4JWI8OBsQs9Wv7VaKpHrZ
   C1H3EiWTmDdI5dlHTgjCBH1Wfgd1AWFESoxkpAdvEVoqxe8PhW5vHSgr0
   NMEfEUTkhmapXWnigi6uoKyxDPg4S/lzH/jCaUkFBUOYYiEhQ5vaHt77s
   VktevBIHXyAqY+3JVWyzmw5uyhB74WUNKxgoUwwpAJzlf2Nl2szYmLTUp
   WvnGTeXKcBe5n/gTHmhS9eyl7gAqbLST/B0wTt6sE/3uhXu3TWFtFSC5C
   P9R/473bn/+Ls497kNnKbAFluB1kEvrI5wZj2mqRXs/ZV/tyUQReJdUFa
   g==;
X-CSE-ConnectionGUID: ZzUVsPu5R72eY7cKboLOlQ==
X-CSE-MsgGUID: XuIlCY5jTWmo1UhzkRaO5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="26244954"
X-IronPort-AV: E=Sophos;i="6.10,182,1719903600"; 
   d="scan'208";a="26244954"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 00:56:46 -0700
X-CSE-ConnectionGUID: Q4JZJZbLQI6Zy9rJ9ngUcA==
X-CSE-MsgGUID: d6OeTyKhSdusq6hfiUoHMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,182,1719903600"; 
   d="scan'208";a="62798304"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 28 Aug 2024 00:56:45 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sjDXm-000Kco-2P;
	Wed, 28 Aug 2024 07:56:42 +0000
Date: Wed, 28 Aug 2024 15:56:30 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/bugs] BUILD SUCCESS
 40153505259d8dc0e4ea6889fca5e567c42b76a9
Message-ID: <202408281527.fX6sMSWg-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/bugs
branch HEAD: 40153505259d8dc0e4ea6889fca5e567c42b76a9  Documentation/srso: Document a method for checking safe RET operates properly

elapsed time: 1461m

configs tested: 199
configs skipped: 10

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig   gcc-13.2.0
alpha                             allnoconfig   gcc-13.2.0
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                          axs101_defconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240828   gcc-13.2.0
arc                   randconfig-002-20240828   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-20
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                              allyesconfig   gcc-14.1.0
arm                                 defconfig   gcc-13.2.0
arm                      footbridge_defconfig   gcc-13.2.0
arm                            mmp2_defconfig   gcc-13.2.0
arm                   randconfig-001-20240828   gcc-13.2.0
arm                   randconfig-002-20240828   gcc-13.2.0
arm                   randconfig-003-20240828   gcc-13.2.0
arm                   randconfig-004-20240828   gcc-13.2.0
arm                         s5pv210_defconfig   gcc-13.2.0
arm64                            allmodconfig   clang-20
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240828   gcc-13.2.0
arm64                 randconfig-002-20240828   gcc-13.2.0
arm64                 randconfig-003-20240828   gcc-13.2.0
arm64                 randconfig-004-20240828   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240828   gcc-13.2.0
csky                  randconfig-002-20240828   gcc-13.2.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   clang-20
hexagon                          allyesconfig   clang-20
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-12
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-12
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240828   gcc-12
i386         buildonly-randconfig-002-20240828   clang-18
i386         buildonly-randconfig-002-20240828   gcc-12
i386         buildonly-randconfig-003-20240828   gcc-12
i386         buildonly-randconfig-004-20240828   gcc-12
i386         buildonly-randconfig-005-20240828   gcc-12
i386         buildonly-randconfig-006-20240828   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240828   clang-18
i386                  randconfig-001-20240828   gcc-12
i386                  randconfig-002-20240828   gcc-12
i386                  randconfig-003-20240828   clang-18
i386                  randconfig-003-20240828   gcc-12
i386                  randconfig-004-20240828   clang-18
i386                  randconfig-004-20240828   gcc-12
i386                  randconfig-005-20240828   clang-18
i386                  randconfig-005-20240828   gcc-12
i386                  randconfig-006-20240828   gcc-12
i386                  randconfig-011-20240828   gcc-12
i386                  randconfig-012-20240828   gcc-12
i386                  randconfig-013-20240828   clang-18
i386                  randconfig-013-20240828   gcc-12
i386                  randconfig-014-20240828   gcc-11
i386                  randconfig-014-20240828   gcc-12
i386                  randconfig-015-20240828   gcc-12
i386                  randconfig-016-20240828   gcc-11
i386                  randconfig-016-20240828   gcc-12
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240828   gcc-13.2.0
loongarch             randconfig-002-20240828   gcc-13.2.0
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
microblaze                      mmu_defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-14.1.0
mips                     cu1000-neo_defconfig   gcc-13.2.0
mips                      malta_kvm_defconfig   gcc-13.2.0
mips                      maltasmvp_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240828   gcc-13.2.0
nios2                 randconfig-002-20240828   gcc-13.2.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240828   gcc-13.2.0
parisc                randconfig-002-20240828   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-20
powerpc                          allyesconfig   gcc-14.1.0
powerpc               randconfig-003-20240828   gcc-13.2.0
powerpc                    socrates_defconfig   gcc-13.2.0
powerpc64             randconfig-001-20240828   gcc-13.2.0
powerpc64             randconfig-002-20240828   gcc-13.2.0
powerpc64             randconfig-003-20240828   gcc-13.2.0
riscv                            allmodconfig   clang-20
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-20
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-14.1.0
riscv                 randconfig-001-20240828   gcc-13.2.0
riscv                 randconfig-002-20240828   gcc-13.2.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240828   gcc-13.2.0
s390                  randconfig-002-20240828   gcc-13.2.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                         ecovec24_defconfig   gcc-13.2.0
sh                            migor_defconfig   gcc-13.2.0
sh                    randconfig-001-20240828   gcc-13.2.0
sh                    randconfig-002-20240828   gcc-13.2.0
sh                          rsk7203_defconfig   gcc-13.2.0
sh                           se7712_defconfig   gcc-13.2.0
sh                   secureedge5410_defconfig   gcc-13.2.0
sh                             shx3_defconfig   gcc-13.2.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240828   gcc-13.2.0
sparc64               randconfig-002-20240828   gcc-13.2.0
um                               allmodconfig   clang-20
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-12
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240828   gcc-13.2.0
um                    randconfig-002-20240828   gcc-13.2.0
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240828   clang-18
x86_64       buildonly-randconfig-002-20240828   clang-18
x86_64       buildonly-randconfig-003-20240828   clang-18
x86_64       buildonly-randconfig-004-20240828   clang-18
x86_64       buildonly-randconfig-005-20240828   clang-18
x86_64       buildonly-randconfig-006-20240828   clang-18
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-11
x86_64                randconfig-001-20240828   clang-18
x86_64                randconfig-002-20240828   clang-18
x86_64                randconfig-003-20240828   clang-18
x86_64                randconfig-004-20240828   clang-18
x86_64                randconfig-005-20240828   clang-18
x86_64                randconfig-006-20240828   clang-18
x86_64                randconfig-011-20240828   clang-18
x86_64                randconfig-012-20240828   clang-18
x86_64                randconfig-013-20240828   clang-18
x86_64                randconfig-014-20240828   clang-18
x86_64                randconfig-015-20240828   clang-18
x86_64                randconfig-016-20240828   clang-18
x86_64                randconfig-071-20240828   clang-18
x86_64                randconfig-072-20240828   clang-18
x86_64                randconfig-073-20240828   clang-18
x86_64                randconfig-074-20240828   clang-18
x86_64                randconfig-075-20240828   clang-18
x86_64                randconfig-076-20240828   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240828   gcc-13.2.0
xtensa                randconfig-002-20240828   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

