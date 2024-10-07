Return-Path: <linux-kernel+bounces-353527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 646DE992F0C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DF781C238CD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 14:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EEC11D61A7;
	Mon,  7 Oct 2024 14:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ot9ygD8d"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368391D6194
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 14:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728311099; cv=none; b=OWziwhtVXj0HWhWDMQOKp+jT2EWWz2QjHBkOpb3KWXhTOBlTPXahC4V5mCr5U5xQQQ76i0bOYiLR6zVVe71l3NatpAuCVX4/RLlHQN7PKFeX1VmfPMplsKroor+FveleFMbNRMGkRtQ24+s1q+DyIdjAT0NQqBcNzWlaho8lD4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728311099; c=relaxed/simple;
	bh=ggL9Huaa7iljd7AgqXtusGsC4yaY7nangw3K4ZRuHeM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ed1hZcYQX3AM9+1m4a4PRYwr5bh3pGFA31lxmxlwNQnDbnFt8JHfP2ek2cq3Huzoir33idevIxz6gX4U+VmAygbDU//YBnIduIs+Cf1rQ0dvehaNx2CUgWblJchUngiiUR8fi2jOW5dXNojP7gH3drihttG6bDGG1nuc5zeorhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ot9ygD8d; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728311099; x=1759847099;
  h=date:from:to:cc:subject:message-id;
  bh=ggL9Huaa7iljd7AgqXtusGsC4yaY7nangw3K4ZRuHeM=;
  b=Ot9ygD8dJoPgbPxO1LHlA+bYMJ95Ta1KgNqDFioMZvpFyY1yGtuEjbxk
   /cPfE4GrSr77rWCiQyUo0rcb8IY/2XdsbnTNsT0vgJwrXgDlrhuvTbcY9
   6bqUF361maRcLgCKSotDfqTEof/eHkRYbnher8BLxeUsVQDSMR7jqF4Hv
   FF1EUIoRGY5KCSqfCCE1nWUox+4WD7q/2a8OeuSuRDPII4/Vz9zR0AL/Q
   mfTfO1V3HcPQyZItIdKlL8Rw/820Z+f7SgFRnFJto4w1jR8Focs0WjLKm
   Bcv9rZlwuuhZGcsmyi748pIFHp7oXaR+SUlR6IKKp95uJ0tiLiq1qlDJs
   w==;
X-CSE-ConnectionGUID: ITNrVPGQRr6rJDGkCk16sQ==
X-CSE-MsgGUID: fAOrHtGKSfmxNtcKsmAF9g==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="44932867"
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="44932867"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 07:24:58 -0700
X-CSE-ConnectionGUID: k/ABZHiXQ8WIXSIe7k0PwA==
X-CSE-MsgGUID: Cn0jszF1SLWnxzmtpEJ+Pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="80096383"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 07 Oct 2024 07:24:54 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sxofM-00055c-11;
	Mon, 07 Oct 2024 14:24:52 +0000
Date: Mon, 07 Oct 2024 22:24:19 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:timers/core] BUILD SUCCESS
 b7f6d3a09da3a2272cbce28bdd8f8c6db772a84e
Message-ID: <202410072205.VTOC0UX8-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
branch HEAD: b7f6d3a09da3a2272cbce28bdd8f8c6db772a84e  Merge branch 'timers/vfs' into timers/core

elapsed time: 1131m

configs tested: 90
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                          ep93xx_defconfig    clang-15
arm                      integrator_defconfig    clang-15
arm                           spitz_defconfig    clang-15
arm                    vt8500_v6_v7_defconfig    clang-15
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
csky                             alldefconfig    clang-15
csky                              allnoconfig    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
i386                             allmodconfig    clang-18
i386                              allnoconfig    clang-18
i386                             allyesconfig    clang-18
i386        buildonly-randconfig-001-20241007    clang-18
i386        buildonly-randconfig-002-20241007    clang-18
i386        buildonly-randconfig-003-20241007    clang-18
i386        buildonly-randconfig-004-20241007    clang-18
i386        buildonly-randconfig-005-20241007    clang-18
i386        buildonly-randconfig-006-20241007    clang-18
i386                                defconfig    clang-18
i386                  randconfig-001-20241007    clang-18
i386                  randconfig-002-20241007    clang-18
i386                  randconfig-003-20241007    clang-18
i386                  randconfig-004-20241007    clang-18
i386                  randconfig-005-20241007    clang-18
i386                  randconfig-006-20241007    clang-18
i386                  randconfig-011-20241007    clang-18
i386                  randconfig-012-20241007    clang-18
i386                  randconfig-013-20241007    clang-18
i386                  randconfig-014-20241007    clang-18
i386                  randconfig-015-20241007    clang-18
i386                  randconfig-016-20241007    clang-18
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                 loongson3_defconfig    clang-15
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                          atari_defconfig    clang-15
m68k                          hp300_defconfig    clang-15
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                        vocore2_defconfig    clang-15
nios2                             allnoconfig    gcc-14.1.0
openrisc                          allnoconfig    gcc-14.1.0
openrisc                         allyesconfig    gcc-14.1.0
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    gcc-14.1.0
parisc                           allyesconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    gcc-14.1.0
powerpc                          allyesconfig    gcc-14.1.0
powerpc                        icon_defconfig    clang-15
powerpc                      katmai_defconfig    clang-15
powerpc                     kmeter1_defconfig    clang-15
powerpc                      mgcoge_defconfig    clang-15
powerpc                     taishan_defconfig    clang-15
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    gcc-14.1.0
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    clang-15
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                      rts7751r2d1_defconfig    clang-15
sparc                            allmodconfig    gcc-14.1.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                               allyesconfig    clang-20
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64                              defconfig    clang-18
x86_64                                  kexec    clang-18
x86_64                               rhel-8.3    gcc-12
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

