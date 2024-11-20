Return-Path: <linux-kernel+bounces-415786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7069D3C66
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 14:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C86CE1F235A5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 13:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA651A00EC;
	Wed, 20 Nov 2024 13:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bwxPggJx"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD598433B3
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 13:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732108494; cv=none; b=os8JElriJ0n0WC3El0YlFmOR/AMb7cdtaL+DEox55Pjvsn089PJzAM/HlCe6l6L/tLNlz98x0A35/URQrnDpbXB6WgyAyKDNIR6DAxtnHYcS6LDlDyOW9caE1ZB7SvpkRySzCquhdbocfd3PF03w0L57TATZ+aDqQ9kqYPF0mkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732108494; c=relaxed/simple;
	bh=EmGaG2XZQODVdysvuZLg76hz+YImt0OFIENzjY7nbXc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=S9eAp09GV2Si3sRGScL/ehyfKvDwZjB4/msEwSKN31Vb/ZrN4FCsTSfMEnbS3R9XB3JMFXH4+2louhv1979RB1kpTJm+fY/krO+6T+isQPcmF5/UxEaib7gfU5BUP2jjpyk3pnnwiczGBMzQKAE3XkgGAg99JaquN8aWfsM7jio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bwxPggJx; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732108492; x=1763644492;
  h=date:from:to:cc:subject:message-id;
  bh=EmGaG2XZQODVdysvuZLg76hz+YImt0OFIENzjY7nbXc=;
  b=bwxPggJxvKlVc3JYlopUFtrD3pBGlCr6IqSdR8MpBhw64Bodxxoflkf0
   hR4C9swvSJsWS6xlL5msJmqRl1F+EHCO52nBye+wj1/vlNh4mDfIWo2dZ
   SVdqQbwC+wPqFMhcBaQYMDGr1emCbNL93bJ2SCTcESe3M03OK2li5CBsL
   LBQD8kNl+q62LojzC7Srnf83MqQgs9FFMu/jqD1uEQM3ApYJqJXtBwsDK
   y0perSplBX+jcFpDFQWIbh2xKdjUnMFhavoC4Pe45Ta0RkPGYpfe3FmGK
   b2v0TTmXTjf4h6unOzOtcbceX09YYtDaYnpz1yQpkYRRKV4stzfkIDK+5
   Q==;
X-CSE-ConnectionGUID: a+YfTvAbRZKqtNytLtDDqA==
X-CSE-MsgGUID: jLcHWPdPT7GWZH3Lw8OC+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11262"; a="32414026"
X-IronPort-AV: E=Sophos;i="6.12,169,1728975600"; 
   d="scan'208";a="32414026"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2024 05:14:51 -0800
X-CSE-ConnectionGUID: 8xUVi2iNQMq85HUJ/lrMuw==
X-CSE-MsgGUID: lLMfjSeMSe2Jt8VkQL/6PA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,169,1728975600"; 
   d="scan'208";a="94371246"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 20 Nov 2024 05:14:50 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tDkXf-0000su-2N;
	Wed, 20 Nov 2024 13:14:47 +0000
Date: Wed, 20 Nov 2024 21:13:16 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/mm] BUILD SUCCESS
 2815a56e4b7252a836969f5674ee356ea1ce482c
Message-ID: <202411202100.Ryab3Yjc-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/mm
branch HEAD: 2815a56e4b7252a836969f5674ee356ea1ce482c  x86/mm/tlb: Add tracepoint for TLB flush IPI to stale CPU

elapsed time: 725m

configs tested: 163
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig    gcc-14.2.0
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-13.2.0
arc                   randconfig-001-20241120    gcc-13.2.0
arc                   randconfig-002-20241120    gcc-13.2.0
arc                    vdk_hs38_smp_defconfig    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-20
arm                              allyesconfig    gcc-14.2.0
arm                                 defconfig    clang-14
arm                          gemini_defconfig    clang-20
arm                         lpc32xx_defconfig    clang-20
arm                        mvebu_v5_defconfig    gcc-14.2.0
arm                         nhk8815_defconfig    clang-20
arm                           omap1_defconfig    gcc-14.2.0
arm                   randconfig-001-20241120    clang-20
arm                   randconfig-002-20241120    clang-20
arm                   randconfig-003-20241120    gcc-14.2.0
arm                   randconfig-004-20241120    gcc-14.2.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20241120    gcc-14.2.0
arm64                 randconfig-002-20241120    clang-17
arm64                 randconfig-003-20241120    gcc-14.2.0
arm64                 randconfig-004-20241120    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20241120    gcc-14.2.0
csky                  randconfig-002-20241120    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    clang-20
hexagon               randconfig-001-20241120    clang-20
hexagon               randconfig-002-20241120    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241120    clang-19
i386        buildonly-randconfig-002-20241120    gcc-12
i386        buildonly-randconfig-003-20241120    gcc-12
i386        buildonly-randconfig-004-20241120    gcc-12
i386        buildonly-randconfig-005-20241120    clang-19
i386        buildonly-randconfig-006-20241120    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20241120    gcc-12
i386                  randconfig-002-20241120    gcc-12
i386                  randconfig-003-20241120    gcc-12
i386                  randconfig-004-20241120    gcc-12
i386                  randconfig-005-20241120    gcc-12
i386                  randconfig-006-20241120    gcc-12
i386                  randconfig-011-20241120    clang-19
i386                  randconfig-012-20241120    clang-19
i386                  randconfig-013-20241120    clang-19
i386                  randconfig-014-20241120    gcc-11
i386                  randconfig-015-20241120    gcc-12
i386                  randconfig-016-20241120    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20241120    gcc-14.2.0
loongarch             randconfig-002-20241120    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                        m5272c3_defconfig    gcc-14.2.0
m68k                            mac_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20241120    gcc-14.2.0
nios2                 randconfig-002-20241120    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20241120    gcc-14.2.0
parisc                randconfig-002-20241120    gcc-14.2.0
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-20
powerpc               randconfig-001-20241120    gcc-14.2.0
powerpc               randconfig-002-20241120    gcc-14.2.0
powerpc               randconfig-003-20241120    gcc-14.2.0
powerpc                     tqm8548_defconfig    clang-20
powerpc64             randconfig-001-20241120    clang-20
powerpc64             randconfig-002-20241120    clang-20
powerpc64             randconfig-003-20241120    clang-20
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                               defconfig    clang-20
riscv                 randconfig-001-20241120    gcc-14.2.0
riscv                 randconfig-002-20241120    gcc-14.2.0
s390                             allmodconfig    clang-20
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-20
s390                  randconfig-001-20241120    clang-20
s390                  randconfig-002-20241120    clang-20
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                    randconfig-001-20241120    gcc-14.2.0
sh                    randconfig-002-20241120    gcc-14.2.0
sh                          rsk7201_defconfig    gcc-14.2.0
sh                            shmin_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20241120    gcc-14.2.0
sparc64               randconfig-002-20241120    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                               allyesconfig    gcc-12
um                                  defconfig    clang-20
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241120    gcc-12
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241120    clang-19
x86_64      buildonly-randconfig-002-20241120    gcc-12
x86_64      buildonly-randconfig-003-20241120    gcc-12
x86_64      buildonly-randconfig-004-20241120    gcc-12
x86_64      buildonly-randconfig-005-20241120    gcc-12
x86_64      buildonly-randconfig-006-20241120    clang-19
x86_64                              defconfig    gcc-11
x86_64                randconfig-001-20241120    clang-19
x86_64                randconfig-002-20241120    gcc-11
x86_64                randconfig-003-20241120    clang-19
x86_64                randconfig-004-20241120    clang-19
x86_64                randconfig-005-20241120    clang-19
x86_64                randconfig-006-20241120    clang-19
x86_64                randconfig-011-20241120    gcc-12
x86_64                randconfig-012-20241120    gcc-12
x86_64                randconfig-013-20241120    clang-19
x86_64                randconfig-014-20241120    gcc-12
x86_64                randconfig-015-20241120    clang-19
x86_64                randconfig-016-20241120    clang-19
x86_64                randconfig-071-20241120    clang-19
x86_64                randconfig-072-20241120    clang-19
x86_64                randconfig-073-20241120    gcc-12
x86_64                randconfig-074-20241120    clang-19
x86_64                randconfig-075-20241120    clang-19
x86_64                randconfig-076-20241120    gcc-12
xtensa                            allnoconfig    gcc-14.2.0
xtensa                  audio_kc705_defconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

