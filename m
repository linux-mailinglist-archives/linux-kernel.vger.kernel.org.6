Return-Path: <linux-kernel+bounces-375385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEB69A9555
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 03:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CD8B281858
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 01:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B8184D29;
	Tue, 22 Oct 2024 01:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SEiaVqIQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C83A84A2C
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 01:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729559646; cv=none; b=ph6sFf8RTZsJidKwa9sR8ET5TFLv6wCiAoEviyQESaMYnI05jgoXdiGWZHRDPhtJbLfpnZXHPo1AJozIIKyNxX17jtDQJr1YRbmuplztz4ePSMh0XsW77y7XKEVrtA4YfzhAXFy23l5QI/ec3aHatHLOWgJoDqHDbMge3PP9rFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729559646; c=relaxed/simple;
	bh=4Zrqcrtp4de00LcvilITGJeN0nqEAwz1omGqzkGtzos=;
	h=Date:From:To:Cc:Subject:Message-ID; b=PiPi7ojw0k5jsXcoTzmj79hhbi6c13pR7t3uQK4ejx8tJWfuzze1pdPxuRYPLz+1jhQl/T5GUIHA0TIX/sLjLFX2kquO7SyqPCWWpnvD6o9osnX56grtdzztqEUdys3rxagwExI5gMQnSolzHnBQAdW50LJtuFUc5RLtLzy6AGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SEiaVqIQ; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729559645; x=1761095645;
  h=date:from:to:cc:subject:message-id;
  bh=4Zrqcrtp4de00LcvilITGJeN0nqEAwz1omGqzkGtzos=;
  b=SEiaVqIQDwV6JIHLZzt4e7s1h0noGHxtjWK4fYcN4+4Zx9QTLagHGFoy
   yKAasJ5bVVr094aMxaBIgh06gC7qti+/kvTpmIAFMkIjpSRWED/Rdkj0J
   JEQQaeCoi7vMjRheAkVm3y4vPf5Y+Wy4ybf8OjdrtNO1o9CjtPDLolGCb
   7yU/omaHKsRlVu4W6qdWj7HHW8CX2N4osjo4Z4Knj5ONnfQdAniycdh9G
   fE0dOA7bCDO+5V+sYnP5mOUXqt143PgAGDiTlsSZk4ywOD5Brwkahz01x
   Ii0zDn8W1enyjT5Bd401/SacQHqoIyh+LW9mINvGq/y897LrgKer7HYsk
   g==;
X-CSE-ConnectionGUID: EHYoqvsOTkmPUoFTOPRUYQ==
X-CSE-MsgGUID: QaiYLUpTSqW1RMOvF/FQtA==
X-IronPort-AV: E=McAfee;i="6700,10204,11232"; a="29186544"
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="29186544"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 18:14:03 -0700
X-CSE-ConnectionGUID: eKtbkKWGQ+OzCOaWaktQRg==
X-CSE-MsgGUID: rtP/aiUxTW+ubOZdJAE7HA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="84305320"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 21 Oct 2024 18:14:01 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t33TD-000Sru-0d;
	Tue, 22 Oct 2024 01:13:59 +0000
Date: Tue, 22 Oct 2024 09:13:49 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD SUCCESS
 d1fb8a78b2ff1fe4e9478c75b4fbec588a73c1b0
Message-ID: <202410220941.vkXD7py7-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
branch HEAD: d1fb8a78b2ff1fe4e9478c75b4fbec588a73c1b0  Merge tag 'v6.12-rc4' into sched/core, to resolve conflict

elapsed time: 1100m

configs tested: 188
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                      axs103_smp_defconfig    gcc-14.1.0
arc                                 defconfig    gcc-14.1.0
arc                   randconfig-001-20241021    gcc-14.1.0
arc                   randconfig-002-20241021    gcc-14.1.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                        clps711x_defconfig    gcc-14.1.0
arm                                 defconfig    gcc-14.1.0
arm                             mxs_defconfig    gcc-14.1.0
arm                       omap2plus_defconfig    gcc-14.1.0
arm                   randconfig-001-20241021    gcc-14.1.0
arm                   randconfig-002-20241021    gcc-14.1.0
arm                   randconfig-003-20241021    gcc-14.1.0
arm                   randconfig-004-20241021    gcc-14.1.0
arm                             rpc_defconfig    gcc-14.1.0
arm                         socfpga_defconfig    gcc-14.1.0
arm                       versatile_defconfig    gcc-14.1.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
arm64                 randconfig-001-20241021    gcc-14.1.0
arm64                 randconfig-002-20241021    gcc-14.1.0
arm64                 randconfig-003-20241021    gcc-14.1.0
arm64                 randconfig-004-20241021    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
csky                  randconfig-001-20241021    gcc-14.1.0
csky                  randconfig-002-20241021    gcc-14.1.0
hexagon                          alldefconfig    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
hexagon               randconfig-001-20241021    gcc-14.1.0
hexagon               randconfig-002-20241021    gcc-14.1.0
i386                             allmodconfig    clang-18
i386                              allnoconfig    clang-18
i386                             allyesconfig    clang-18
i386        buildonly-randconfig-001-20241021    clang-18
i386        buildonly-randconfig-002-20241021    clang-18
i386        buildonly-randconfig-003-20241021    clang-18
i386        buildonly-randconfig-004-20241021    clang-18
i386        buildonly-randconfig-005-20241021    clang-18
i386        buildonly-randconfig-006-20241021    clang-18
i386                                defconfig    clang-18
i386                  randconfig-001-20241021    clang-18
i386                  randconfig-002-20241021    clang-18
i386                  randconfig-003-20241021    clang-18
i386                  randconfig-004-20241021    clang-18
i386                  randconfig-005-20241021    clang-18
i386                  randconfig-006-20241021    clang-18
i386                  randconfig-011-20241021    clang-18
i386                  randconfig-012-20241021    clang-18
i386                  randconfig-013-20241021    clang-18
i386                  randconfig-014-20241021    clang-18
i386                  randconfig-015-20241021    clang-18
i386                  randconfig-016-20241021    clang-18
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
loongarch             randconfig-001-20241021    gcc-14.1.0
loongarch             randconfig-002-20241021    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
m68k                        m5307c3_defconfig    gcc-14.1.0
m68k                       m5475evb_defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                        bcm47xx_defconfig    gcc-14.1.0
mips                        bcm63xx_defconfig    gcc-14.1.0
mips                          eyeq6_defconfig    gcc-14.1.0
mips                     loongson1b_defconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
nios2                 randconfig-001-20241021    gcc-14.1.0
nios2                 randconfig-002-20241021    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20241021    gcc-14.1.0
parisc                randconfig-002-20241021    gcc-14.1.0
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.1.0
powerpc                       maple_defconfig    gcc-14.1.0
powerpc                     mpc512x_defconfig    gcc-14.1.0
powerpc                 mpc832x_rdb_defconfig    gcc-14.1.0
powerpc                       ppc64_defconfig    gcc-14.1.0
powerpc                      ppc64e_defconfig    gcc-14.1.0
powerpc                         ps3_defconfig    gcc-14.1.0
powerpc               randconfig-001-20241021    gcc-14.1.0
powerpc               randconfig-002-20241021    gcc-14.1.0
powerpc               randconfig-003-20241021    gcc-14.1.0
powerpc                     tqm5200_defconfig    gcc-14.1.0
powerpc                     tqm8548_defconfig    gcc-14.1.0
powerpc64             randconfig-001-20241021    gcc-14.1.0
powerpc64             randconfig-002-20241021    gcc-14.1.0
powerpc64             randconfig-003-20241021    gcc-14.1.0
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20241021    gcc-14.1.0
riscv                 randconfig-002-20241021    gcc-14.1.0
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20241021    gcc-14.1.0
s390                  randconfig-002-20241021    gcc-14.1.0
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                        apsh4ad0a_defconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                        edosk7705_defconfig    gcc-14.1.0
sh                          landisk_defconfig    gcc-14.1.0
sh                    randconfig-001-20241021    gcc-14.1.0
sh                    randconfig-002-20241021    gcc-14.1.0
sh                  sh7785lcr_32bit_defconfig    gcc-14.1.0
sh                             shx3_defconfig    gcc-14.1.0
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20241021    gcc-14.1.0
sparc64               randconfig-002-20241021    gcc-14.1.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241021    gcc-14.1.0
um                    randconfig-002-20241021    gcc-14.1.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64      buildonly-randconfig-001-20241022    clang-18
x86_64      buildonly-randconfig-002-20241022    clang-18
x86_64      buildonly-randconfig-003-20241022    clang-18
x86_64      buildonly-randconfig-004-20241022    clang-18
x86_64      buildonly-randconfig-005-20241022    clang-18
x86_64      buildonly-randconfig-006-20241022    clang-18
x86_64                              defconfig    clang-18
x86_64                                  kexec    clang-18
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20241022    clang-18
x86_64                randconfig-002-20241022    clang-18
x86_64                randconfig-003-20241022    clang-18
x86_64                randconfig-004-20241022    clang-18
x86_64                randconfig-005-20241022    clang-18
x86_64                randconfig-006-20241022    clang-18
x86_64                randconfig-011-20241022    clang-18
x86_64                randconfig-012-20241022    clang-18
x86_64                randconfig-013-20241022    clang-18
x86_64                randconfig-014-20241022    clang-18
x86_64                randconfig-015-20241022    clang-18
x86_64                randconfig-016-20241022    clang-18
x86_64                randconfig-071-20241022    clang-18
x86_64                randconfig-072-20241022    clang-18
x86_64                randconfig-073-20241022    clang-18
x86_64                randconfig-074-20241022    clang-18
x86_64                randconfig-075-20241022    clang-18
x86_64                randconfig-076-20241022    clang-18
x86_64                               rhel-8.3    gcc-12
x86_64                           rhel-8.3-bpf    clang-18
x86_64                         rhel-8.3-kunit    clang-18
x86_64                           rhel-8.3-ltp    clang-18
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0
xtensa                randconfig-001-20241021    gcc-14.1.0
xtensa                randconfig-002-20241021    gcc-14.1.0
xtensa                    smp_lx200_defconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

