Return-Path: <linux-kernel+bounces-278844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 105FE94B58E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 05:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8697F1F2288A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 03:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10EE841C6D;
	Thu,  8 Aug 2024 03:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m+XzvYxx"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA3411187
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 03:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723088329; cv=none; b=bSUBnGRmZbmWnkAmbGRprUyuG2sg1vlEPJLLein94XkXolg2KyzZXD02Lam7FVfFYPbChdNlSZMFQ3sTLm2ViBvbUeEs0bp5AIm7i3E7W8Q3gJ+0zgJR341PURy+1/qN61SJVk9yyKUclQKuU3Yzinha7s8o1CXAUl8NFAcRJdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723088329; c=relaxed/simple;
	bh=9DP60DpSRkR4OS2TKj6+m7MzvXuUV3kLS4qJHRzCE70=;
	h=Date:From:To:Cc:Subject:Message-ID; b=JXNzK6tGV/KplpaH7xqvr6Z22CI7OsRIjDmVNU0sql2wlQQSAkeuEleFPx9fsosqnrv8YXm1u6SmNBvJrU6XYMlfrwxWf5bGTj15t4fZxmWi3mU2Pi+Zl8qytm0+S2J9A3Y9q6BbOTPIwR2YctHoqyvdun0Pvsx5X9nJnbeEGY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m+XzvYxx; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723088328; x=1754624328;
  h=date:from:to:cc:subject:message-id;
  bh=9DP60DpSRkR4OS2TKj6+m7MzvXuUV3kLS4qJHRzCE70=;
  b=m+XzvYxxAOLbN6kD5urVF+6uRu464xCWeekTwB5ixoP9u7SL2mTV8liL
   I2RwbbOrpcLEPlCyHyCUepEmTBnvNOlIe7qr6Fj6dGlF/+zyNyAAV7STt
   bRAeeulnQAsvsC144HyUGzW9Vfp7aN93cGUPG137kOBfossBLH2Yy96gw
   KNCuIRixefceyB3M490LFdxY9d0yeR7hdYsYQoPHh5uTsHei2AuxJqDxE
   vAF8FvvChxnbClxxyEXyin7Nr4L98wWPbcjmhfHtULfa+mD2jsL7rKzot
   DCy0g1mFkrTmfCs9ww7jVz6/CoZ1WH2m5SjU8Tcvm0iHNFlU16RT/0wLp
   A==;
X-CSE-ConnectionGUID: Iuz0juBXSvuoe4TGSFiU6g==
X-CSE-MsgGUID: eYgftLsyTCKeL6P4Vu5lxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="12911197"
X-IronPort-AV: E=Sophos;i="6.09,271,1716274800"; 
   d="scan'208";a="12911197"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 20:38:47 -0700
X-CSE-ConnectionGUID: 0BAkOZfjSJCpxcwJ7A8d1g==
X-CSE-MsgGUID: 6dzFKfsjRJCPRRgIqeJosQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,271,1716274800"; 
   d="scan'208";a="56931024"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 07 Aug 2024 20:38:46 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sbtz9-0005tq-1w;
	Thu, 08 Aug 2024 03:38:43 +0000
Date: Thu, 08 Aug 2024 11:37:43 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 532361ba3a0ea24e9561b29c843774c5b8853947
Message-ID: <202408081140.9WGUuIdu-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 532361ba3a0ea24e9561b29c843774c5b8853947  Merge branch into tip/master: 'x86/timers'

elapsed time: 1017m

configs tested: 248
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240807   gcc-13.2.0
arc                   randconfig-001-20240808   gcc-13.2.0
arc                   randconfig-002-20240807   gcc-13.2.0
arc                   randconfig-002-20240808   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-20
arm                              allyesconfig   gcc-13.2.0
arm                              allyesconfig   gcc-14.1.0
arm                                 defconfig   gcc-13.2.0
arm                          moxart_defconfig   gcc-14.1.0
arm                   randconfig-001-20240807   clang-20
arm                   randconfig-001-20240808   gcc-13.2.0
arm                   randconfig-002-20240807   gcc-14.1.0
arm                   randconfig-002-20240808   gcc-13.2.0
arm                   randconfig-003-20240807   gcc-14.1.0
arm                   randconfig-003-20240808   gcc-13.2.0
arm                   randconfig-004-20240807   gcc-14.1.0
arm                   randconfig-004-20240808   gcc-13.2.0
arm64                            allmodconfig   clang-20
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240807   gcc-14.1.0
arm64                 randconfig-001-20240808   gcc-13.2.0
arm64                 randconfig-002-20240807   clang-17
arm64                 randconfig-002-20240808   gcc-13.2.0
arm64                 randconfig-003-20240807   clang-15
arm64                 randconfig-003-20240808   gcc-13.2.0
arm64                 randconfig-004-20240807   clang-20
arm64                 randconfig-004-20240808   gcc-13.2.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-13.2.0
csky                                defconfig   gcc-14.1.0
csky                  randconfig-001-20240807   gcc-14.1.0
csky                  randconfig-001-20240808   gcc-13.2.0
csky                  randconfig-002-20240807   gcc-14.1.0
csky                  randconfig-002-20240808   gcc-13.2.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   clang-20
hexagon                          allyesconfig   clang-20
hexagon               randconfig-001-20240807   clang-14
hexagon               randconfig-002-20240807   clang-20
i386                             alldefconfig   gcc-14.1.0
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-12
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-12
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240807   clang-18
i386         buildonly-randconfig-001-20240808   clang-18
i386         buildonly-randconfig-002-20240807   clang-18
i386         buildonly-randconfig-002-20240808   clang-18
i386         buildonly-randconfig-003-20240807   gcc-12
i386         buildonly-randconfig-003-20240808   clang-18
i386         buildonly-randconfig-004-20240807   clang-18
i386         buildonly-randconfig-004-20240808   clang-18
i386         buildonly-randconfig-005-20240807   clang-18
i386         buildonly-randconfig-005-20240808   clang-18
i386         buildonly-randconfig-006-20240807   gcc-12
i386         buildonly-randconfig-006-20240808   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240807   gcc-12
i386                  randconfig-001-20240808   clang-18
i386                  randconfig-002-20240807   clang-18
i386                  randconfig-002-20240808   clang-18
i386                  randconfig-003-20240807   clang-18
i386                  randconfig-003-20240808   clang-18
i386                  randconfig-004-20240807   gcc-12
i386                  randconfig-004-20240808   clang-18
i386                  randconfig-005-20240807   gcc-12
i386                  randconfig-005-20240808   clang-18
i386                  randconfig-006-20240807   clang-18
i386                  randconfig-006-20240808   clang-18
i386                  randconfig-011-20240807   clang-18
i386                  randconfig-011-20240808   clang-18
i386                  randconfig-012-20240807   gcc-11
i386                  randconfig-012-20240808   clang-18
i386                  randconfig-013-20240807   clang-18
i386                  randconfig-013-20240808   clang-18
i386                  randconfig-014-20240807   clang-18
i386                  randconfig-014-20240808   clang-18
i386                  randconfig-015-20240807   clang-18
i386                  randconfig-015-20240808   clang-18
i386                  randconfig-016-20240807   gcc-12
i386                  randconfig-016-20240808   clang-18
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240807   gcc-14.1.0
loongarch             randconfig-001-20240808   gcc-13.2.0
loongarch             randconfig-002-20240807   gcc-14.1.0
loongarch             randconfig-002-20240808   gcc-13.2.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                         apollo_defconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
m68k                       m5275evb_defconfig   gcc-14.1.0
m68k                        mvme16x_defconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-14.1.0
mips                         db1xxx_defconfig   gcc-14.1.0
mips                     decstation_defconfig   gcc-14.1.0
mips                     loongson1b_defconfig   gcc-14.1.0
mips                         rt305x_defconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240807   gcc-14.1.0
nios2                 randconfig-001-20240808   gcc-13.2.0
nios2                 randconfig-002-20240807   gcc-14.1.0
nios2                 randconfig-002-20240808   gcc-13.2.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
openrisc                       virt_defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240807   gcc-14.1.0
parisc                randconfig-001-20240808   gcc-13.2.0
parisc                randconfig-002-20240807   gcc-14.1.0
parisc                randconfig-002-20240808   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-20
powerpc                          allyesconfig   gcc-14.1.0
powerpc                      chrp32_defconfig   gcc-14.1.0
powerpc               randconfig-001-20240807   clang-20
powerpc               randconfig-001-20240808   gcc-13.2.0
powerpc               randconfig-002-20240808   gcc-13.2.0
powerpc               randconfig-003-20240807   gcc-14.1.0
powerpc64             randconfig-001-20240807   clang-15
powerpc64             randconfig-001-20240808   gcc-13.2.0
powerpc64             randconfig-002-20240807   gcc-14.1.0
powerpc64             randconfig-002-20240808   gcc-13.2.0
powerpc64             randconfig-003-20240807   gcc-14.1.0
riscv                            allmodconfig   clang-20
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-20
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-14.1.0
riscv                    nommu_virt_defconfig   gcc-14.1.0
riscv                 randconfig-001-20240807   clang-20
riscv                 randconfig-001-20240808   gcc-13.2.0
riscv                 randconfig-002-20240807   clang-20
riscv                 randconfig-002-20240808   gcc-13.2.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                             allyesconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240807   gcc-14.1.0
s390                  randconfig-001-20240808   gcc-13.2.0
s390                  randconfig-002-20240807   gcc-14.1.0
s390                  randconfig-002-20240808   gcc-13.2.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                    randconfig-001-20240807   gcc-14.1.0
sh                    randconfig-001-20240808   gcc-13.2.0
sh                    randconfig-002-20240807   gcc-14.1.0
sh                    randconfig-002-20240808   gcc-13.2.0
sh                      rts7751r2d1_defconfig   gcc-14.1.0
sh                           se7705_defconfig   gcc-14.1.0
sh                        sh7757lcr_defconfig   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240807   gcc-14.1.0
sparc64               randconfig-001-20240808   gcc-13.2.0
sparc64               randconfig-002-20240807   gcc-14.1.0
sparc64               randconfig-002-20240808   gcc-13.2.0
um                               allmodconfig   clang-20
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-12
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240807   gcc-12
um                    randconfig-001-20240808   gcc-13.2.0
um                    randconfig-002-20240807   clang-20
um                    randconfig-002-20240808   gcc-13.2.0
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240808   gcc-12
x86_64       buildonly-randconfig-002-20240808   gcc-12
x86_64       buildonly-randconfig-003-20240808   clang-18
x86_64       buildonly-randconfig-003-20240808   gcc-12
x86_64       buildonly-randconfig-004-20240808   clang-18
x86_64       buildonly-randconfig-004-20240808   gcc-12
x86_64       buildonly-randconfig-005-20240808   clang-18
x86_64       buildonly-randconfig-005-20240808   gcc-12
x86_64       buildonly-randconfig-006-20240808   clang-18
x86_64       buildonly-randconfig-006-20240808   gcc-12
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-11
x86_64                randconfig-001-20240808   gcc-12
x86_64                randconfig-002-20240808   clang-18
x86_64                randconfig-002-20240808   gcc-12
x86_64                randconfig-003-20240808   gcc-12
x86_64                randconfig-004-20240808   clang-18
x86_64                randconfig-004-20240808   gcc-12
x86_64                randconfig-005-20240808   clang-18
x86_64                randconfig-005-20240808   gcc-12
x86_64                randconfig-006-20240808   clang-18
x86_64                randconfig-006-20240808   gcc-12
x86_64                randconfig-011-20240808   clang-18
x86_64                randconfig-011-20240808   gcc-12
x86_64                randconfig-012-20240808   gcc-12
x86_64                randconfig-013-20240808   gcc-12
x86_64                randconfig-014-20240808   clang-18
x86_64                randconfig-014-20240808   gcc-12
x86_64                randconfig-015-20240808   gcc-12
x86_64                randconfig-016-20240808   clang-18
x86_64                randconfig-016-20240808   gcc-12
x86_64                randconfig-071-20240808   clang-18
x86_64                randconfig-071-20240808   gcc-12
x86_64                randconfig-072-20240808   clang-18
x86_64                randconfig-072-20240808   gcc-12
x86_64                randconfig-073-20240808   clang-18
x86_64                randconfig-073-20240808   gcc-12
x86_64                randconfig-074-20240808   gcc-12
x86_64                randconfig-075-20240808   clang-18
x86_64                randconfig-075-20240808   gcc-12
x86_64                randconfig-076-20240808   gcc-12
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240807   gcc-14.1.0
xtensa                randconfig-001-20240808   gcc-13.2.0
xtensa                randconfig-002-20240807   gcc-14.1.0
xtensa                randconfig-002-20240808   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

