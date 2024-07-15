Return-Path: <linux-kernel+bounces-252067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0711930DD2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 08:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20C111F2174D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 06:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2658B157A42;
	Mon, 15 Jul 2024 06:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dvVLzaDA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4046D25779
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 06:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721023908; cv=none; b=kdb7EnrFJ55H8NiRXtZw87DO7o5acHmpIHdszZHNa+wEMWiIuqFwVm3ft1x7pmHMP3smMSh7NXon7pCVhGlS5nNlTTt/U/5CpFn2li67cInr4WcKc4ClMdaozK6wzJ9ccwVlmyjCr5IkidtOXLdXkBsuX9w39fXs2SlINxDXCU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721023908; c=relaxed/simple;
	bh=dJ+PUgEOnFhNx0JOAp/DQ0wm3SdgJzoZ3TRVWaFcA8c=;
	h=Date:From:To:Cc:Subject:Message-ID; b=qCgNvW47KE59zJQZQfRrT0NRDV5Ltm4Co2J34blpri7qxdIQqYO9fVBG5cHXhT9CCAew5rIu5175Ht4HCEqmnv73ybs41d5PWnI7YfF9OssPoJbTqDAs8Y55pESElfsZjjE+k7KF2NAlUw38E0WDWQm39WG09F090x+10zlkjJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dvVLzaDA; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721023906; x=1752559906;
  h=date:from:to:cc:subject:message-id;
  bh=dJ+PUgEOnFhNx0JOAp/DQ0wm3SdgJzoZ3TRVWaFcA8c=;
  b=dvVLzaDAENL/vZfbhoKGo9NcdYaB9/blBwmoB++sLDdtS8C7NZxujRAV
   MWhptgRhqhZy9TuO7V8V9hzO+M9QWTbY+mCYnNbZMIikuA8LDrS83YHm0
   yas+gJL5dkPB+y740nFUZxfHMBefit7XEz7HBhxGSgexIVvfBLtb+aSqx
   r6dZd3tLblRx1+nr/r1VSL59bYculQpB92wK60feRDfqkiQ9Bb5iF5haG
   PleWheq6vniNk2fV72Nszc5jJ0bFzBCmccYGqjYCS+zjU54ZG6UrQzu5c
   8N0Tn43cpyFikBPRg5UKKGxffFlWy2hDcILsEYsZg4kix2no8LhXsQDPo
   A==;
X-CSE-ConnectionGUID: thVdK2zrQxu5J7W98dxWvQ==
X-CSE-MsgGUID: 5vgGRDHnQTm4RKfba8U1ow==
X-IronPort-AV: E=McAfee;i="6700,10204,11133"; a="18535999"
X-IronPort-AV: E=Sophos;i="6.09,209,1716274800"; 
   d="scan'208";a="18535999"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2024 23:11:42 -0700
X-CSE-ConnectionGUID: jVkTe+rHRTuSVNZyZ8zp0g==
X-CSE-MsgGUID: 2fzYd0LgRyq+fLab9ptB/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,209,1716274800"; 
   d="scan'208";a="87019015"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 14 Jul 2024 23:11:42 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sTEvy-000e3V-2d;
	Mon, 15 Jul 2024 06:11:38 +0000
Date: Mon, 15 Jul 2024 14:10:59 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:irq/core] BUILD SUCCESS
 faf243d11659b1f712fcf981957aea28118df6d6
Message-ID: <202407151456.xw4CQiNn-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
branch HEAD: faf243d11659b1f712fcf981957aea28118df6d6  Merge branch 'irq/msi' into irq/core

elapsed time: 725m

configs tested: 141
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.3.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240715   gcc-13.2.0
arc                   randconfig-002-20240715   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-19
arm                              allyesconfig   gcc-14.1.0
arm                         bcm2835_defconfig   clang-19
arm                                 defconfig   clang-14
arm                       imx_v4_v5_defconfig   clang-16
arm                            mps2_defconfig   clang-19
arm                   randconfig-001-20240715   gcc-14.1.0
arm                   randconfig-002-20240715   gcc-14.1.0
arm                   randconfig-003-20240715   gcc-14.1.0
arm                   randconfig-004-20240715   clang-19
arm64                            allmodconfig   clang-19
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-14.1.0
arm64                 randconfig-001-20240715   clang-19
arm64                 randconfig-002-20240715   clang-19
arm64                 randconfig-003-20240715   clang-19
arm64                 randconfig-004-20240715   clang-19
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-14.1.0
csky                  randconfig-001-20240715   gcc-14.1.0
csky                  randconfig-002-20240715   gcc-14.1.0
hexagon                          allmodconfig   clang-19
hexagon                           allnoconfig   clang-19
hexagon                          allyesconfig   clang-19
hexagon                             defconfig   clang-19
hexagon               randconfig-001-20240715   clang-19
hexagon               randconfig-002-20240715   clang-19
i386                             allmodconfig   gcc-13
i386                              allnoconfig   gcc-13
i386                             allyesconfig   gcc-13
i386                                defconfig   clang-18
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-14.1.0
loongarch             randconfig-001-20240715   gcc-14.1.0
loongarch             randconfig-002-20240715   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                          atari_defconfig   gcc-14.1.0
m68k                                defconfig   gcc-14.1.0
m68k                          multi_defconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
mips                            gpr_defconfig   clang-19
mips                      maltasmvp_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-14.1.0
nios2                 randconfig-001-20240715   gcc-14.1.0
nios2                 randconfig-002-20240715   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240715   gcc-14.1.0
parisc                randconfig-002-20240715   gcc-14.1.0
parisc64                            defconfig   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-19
powerpc                       holly_defconfig   clang-19
powerpc                      ppc44x_defconfig   clang-16
powerpc               randconfig-001-20240715   clang-17
powerpc               randconfig-002-20240715   clang-19
powerpc               randconfig-003-20240715   gcc-14.1.0
powerpc                     redwood_defconfig   clang-19
powerpc                     tqm8555_defconfig   clang-19
powerpc64             randconfig-001-20240715   clang-14
powerpc64             randconfig-002-20240715   gcc-14.1.0
powerpc64             randconfig-003-20240715   gcc-14.1.0
riscv                            allmodconfig   clang-19
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-19
riscv                               defconfig   clang-19
riscv                 randconfig-001-20240715   gcc-14.1.0
riscv                 randconfig-002-20240715   gcc-14.1.0
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   clang-19
s390                  randconfig-001-20240715   gcc-14.1.0
s390                  randconfig-002-20240715   gcc-14.1.0
s390                       zfcpdump_defconfig   clang-19
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                        edosk7760_defconfig   gcc-14.1.0
sh                          landisk_defconfig   gcc-14.1.0
sh                    randconfig-001-20240715   gcc-14.1.0
sh                    randconfig-002-20240715   gcc-14.1.0
sh                           se7619_defconfig   gcc-14.1.0
sh                           se7712_defconfig   gcc-14.1.0
sh                          urquell_defconfig   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
um                               allmodconfig   clang-19
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-13
um                                  defconfig   clang-19
um                             i386_defconfig   gcc-13
um                           x86_64_defconfig   clang-15
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240715   clang-18
x86_64       buildonly-randconfig-002-20240715   gcc-13
x86_64       buildonly-randconfig-003-20240715   clang-18
x86_64       buildonly-randconfig-004-20240715   gcc-13
x86_64       buildonly-randconfig-005-20240715   gcc-13
x86_64       buildonly-randconfig-006-20240715   gcc-8
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240715   gcc-9
x86_64                randconfig-002-20240715   gcc-7
x86_64                randconfig-003-20240715   clang-18
x86_64                randconfig-004-20240715   clang-18
x86_64                randconfig-005-20240715   gcc-11
x86_64                randconfig-006-20240715   clang-18
x86_64                randconfig-011-20240715   gcc-12
x86_64                randconfig-012-20240715   clang-18
x86_64                randconfig-013-20240715   clang-18
x86_64                randconfig-014-20240715   gcc-12
x86_64                randconfig-015-20240715   gcc-10
x86_64                randconfig-016-20240715   gcc-10
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

