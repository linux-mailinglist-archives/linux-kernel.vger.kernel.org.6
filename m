Return-Path: <linux-kernel+bounces-404914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 449A69C4A94
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 01:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 035CBB3272B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 23:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC2E1C876B;
	Mon, 11 Nov 2024 23:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XAu1SGn3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379B41C7265
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 23:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731369190; cv=none; b=soVKz0oVRE///+m/aD1Wb7M0nvSG5qK7GMhdUz0VOKBccwpZ6dq1oQAyKdWm4kfspZXqB8Ge0WuV8jOpt5lc7qfFBtEySAgltv1QOlSJENXcOTkuSdJujtjcfjRHGRVmVCVhTzW6uzwGutgCIs8qPTDA7CA6PIZaFIAWpJOEWFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731369190; c=relaxed/simple;
	bh=O31jk/vav4HCbNQPCvC+JLw0Ru2D1Orem2a3rxuLa/8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=BT/yxFBDkaHCmL+haqmCQKiW78bicEdnIqUYA8g1BNLUYJF5sPrt+fd2lgt1bzb2ikhyqH4gTbcYE27JVyDCasTtTVQqPDNB+N1Niu4MXZe6jKI0p5chUzbiE8Q1iJgy0mNZvywcK8NIcA0QwF9+tfIzPawN0mo5f+AkdZXyjyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XAu1SGn3; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731369188; x=1762905188;
  h=date:from:to:cc:subject:message-id;
  bh=O31jk/vav4HCbNQPCvC+JLw0Ru2D1Orem2a3rxuLa/8=;
  b=XAu1SGn3eLvq+Dc/EfCsShELtNyQcP1LOUebqdkjssgbLaI4jqZvEJGW
   Adjre4oXH7krSIddVH7KmjiCbeixn6rPQbLQKpFIflRa+4QfH0uIp84e6
   4cwOHa3fT0HV/a9QgyuOg8nz+ZXpUGMC9DCCVI+MWhwS4uIGd8LGqJhYb
   IMuEFQGCzDc9rqii7UPq7DAm8lsG+llOalQ28Ph3OhIVfOpDUpeP6hs1G
   c61f8Yy0odCPl53iwpUY2PukALUCuP20q7yha9AjuEhxUiGOT4iRuiwls
   KC3b71Dzzvzo7bILmiX8LLHHnOu6rAS9+JCd9pPf3OOLN7AQ/yC9JwnBW
   A==;
X-CSE-ConnectionGUID: 9uYXnZakTZq8NQTdZmkvPw==
X-CSE-MsgGUID: 5P5z272oRT+vL7U3hBYPaQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="41751984"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="41751984"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2024 15:53:05 -0800
X-CSE-ConnectionGUID: NX2wda6WQ06nVMCI3Nb9yw==
X-CSE-MsgGUID: m8fVS+qMQOKALWbDzr3R0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,146,1728975600"; 
   d="scan'208";a="87550404"
Received: from lkp-server01.sh.intel.com (HELO bcfed0da017c) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 11 Nov 2024 15:53:03 -0800
Received: from kbuild by bcfed0da017c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tAeDM-0000Gm-2Z;
	Mon, 11 Nov 2024 23:53:00 +0000
Date: Tue, 12 Nov 2024 07:52:47 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:sched/urgent] BUILD SUCCESS
 d68803506ffb4f72cbeaea94a3a745a6faf62bdd
Message-ID: <202411120741.oBpFOX84-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/urgent
branch HEAD: d68803506ffb4f72cbeaea94a3a745a6faf62bdd  sched/fair: Dequeue sched_delayed tasks when waking to a busy CPU

elapsed time: 725m

configs tested: 233
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-20
arc                          axs101_defconfig    clang-20
arc                                 defconfig    gcc-14.2.0
arc                   randconfig-001-20241111    gcc-14.2.0
arc                   randconfig-001-20241112    gcc-14.2.0
arc                   randconfig-002-20241111    gcc-14.2.0
arc                   randconfig-002-20241112    gcc-14.2.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-20
arm                         assabet_defconfig    gcc-14.2.0
arm                         at91_dt_defconfig    gcc-14.2.0
arm                                 defconfig    gcc-14.2.0
arm                            dove_defconfig    clang-20
arm                            dove_defconfig    gcc-14.2.0
arm                      footbridge_defconfig    gcc-14.2.0
arm                           imxrt_defconfig    gcc-14.2.0
arm                      jornada720_defconfig    clang-20
arm                   milbeaut_m10v_defconfig    gcc-14.2.0
arm                   randconfig-001-20241111    gcc-14.2.0
arm                   randconfig-001-20241112    gcc-14.2.0
arm                   randconfig-002-20241111    gcc-14.2.0
arm                   randconfig-002-20241112    gcc-14.2.0
arm                   randconfig-003-20241111    gcc-14.2.0
arm                   randconfig-003-20241112    gcc-14.2.0
arm                   randconfig-004-20241111    gcc-14.2.0
arm                   randconfig-004-20241112    gcc-14.2.0
arm                           u8500_defconfig    gcc-14.2.0
arm                         vf610m4_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20241111    gcc-14.2.0
arm64                 randconfig-001-20241112    gcc-14.2.0
arm64                 randconfig-002-20241111    gcc-14.2.0
arm64                 randconfig-002-20241112    gcc-14.2.0
arm64                 randconfig-003-20241111    gcc-14.2.0
arm64                 randconfig-003-20241112    gcc-14.2.0
arm64                 randconfig-004-20241111    gcc-14.2.0
arm64                 randconfig-004-20241112    gcc-14.2.0
csky                             alldefconfig    clang-20
csky                             alldefconfig    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20241111    gcc-14.2.0
csky                  randconfig-001-20241112    gcc-14.2.0
csky                  randconfig-002-20241111    gcc-14.2.0
csky                  randconfig-002-20241112    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20241111    gcc-14.2.0
hexagon               randconfig-001-20241112    gcc-14.2.0
hexagon               randconfig-002-20241111    gcc-14.2.0
hexagon               randconfig-002-20241112    gcc-14.2.0
i386                             allmodconfig    clang-19
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-19
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-19
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241111    gcc-11
i386        buildonly-randconfig-001-20241112    clang-19
i386        buildonly-randconfig-002-20241111    gcc-11
i386        buildonly-randconfig-002-20241112    clang-19
i386        buildonly-randconfig-003-20241111    gcc-11
i386        buildonly-randconfig-003-20241112    clang-19
i386        buildonly-randconfig-004-20241111    gcc-11
i386        buildonly-randconfig-004-20241112    clang-19
i386        buildonly-randconfig-005-20241111    gcc-11
i386        buildonly-randconfig-005-20241112    clang-19
i386        buildonly-randconfig-006-20241111    gcc-11
i386        buildonly-randconfig-006-20241112    clang-19
i386                                defconfig    clang-19
i386                  randconfig-001-20241111    gcc-11
i386                  randconfig-001-20241112    clang-19
i386                  randconfig-002-20241111    gcc-11
i386                  randconfig-002-20241112    clang-19
i386                  randconfig-003-20241111    gcc-11
i386                  randconfig-003-20241112    clang-19
i386                  randconfig-004-20241111    gcc-11
i386                  randconfig-004-20241112    clang-19
i386                  randconfig-005-20241111    gcc-11
i386                  randconfig-005-20241112    clang-19
i386                  randconfig-006-20241111    gcc-11
i386                  randconfig-006-20241112    clang-19
i386                  randconfig-011-20241111    gcc-11
i386                  randconfig-011-20241112    clang-19
i386                  randconfig-012-20241111    gcc-11
i386                  randconfig-012-20241112    clang-19
i386                  randconfig-013-20241111    gcc-11
i386                  randconfig-013-20241112    clang-19
i386                  randconfig-014-20241111    gcc-11
i386                  randconfig-014-20241112    clang-19
i386                  randconfig-015-20241111    gcc-11
i386                  randconfig-015-20241112    clang-19
i386                  randconfig-016-20241111    gcc-11
i386                  randconfig-016-20241112    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20241111    gcc-14.2.0
loongarch             randconfig-001-20241112    gcc-14.2.0
loongarch             randconfig-002-20241111    gcc-14.2.0
loongarch             randconfig-002-20241112    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                          amiga_defconfig    clang-20
m68k                                defconfig    gcc-14.2.0
m68k                            mac_defconfig    gcc-14.2.0
m68k                        mvme16x_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                           ip22_defconfig    clang-20
mips                        qi_lb60_defconfig    clang-20
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20241111    gcc-14.2.0
nios2                 randconfig-001-20241112    gcc-14.2.0
nios2                 randconfig-002-20241111    gcc-14.2.0
nios2                 randconfig-002-20241112    gcc-14.2.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20241111    gcc-14.2.0
parisc                randconfig-001-20241112    gcc-14.2.0
parisc                randconfig-002-20241111    gcc-14.2.0
parisc                randconfig-002-20241112    gcc-14.2.0
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    clang-20
powerpc                          allyesconfig    gcc-14.2.0
powerpc                     asp8347_defconfig    clang-20
powerpc               mpc834x_itxgp_defconfig    clang-20
powerpc                 mpc836x_rdk_defconfig    clang-20
powerpc                     mpc83xx_defconfig    clang-20
powerpc                      ppc44x_defconfig    gcc-14.2.0
powerpc                       ppc64_defconfig    clang-20
powerpc               randconfig-001-20241111    gcc-14.2.0
powerpc               randconfig-001-20241112    gcc-14.2.0
powerpc               randconfig-002-20241111    gcc-14.2.0
powerpc               randconfig-002-20241112    gcc-14.2.0
powerpc               randconfig-003-20241111    gcc-14.2.0
powerpc               randconfig-003-20241112    gcc-14.2.0
powerpc                     sequoia_defconfig    clang-20
powerpc                     skiroot_defconfig    gcc-14.2.0
powerpc                         wii_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20241111    gcc-14.2.0
powerpc64             randconfig-001-20241112    gcc-14.2.0
powerpc64             randconfig-002-20241111    gcc-14.2.0
powerpc64             randconfig-002-20241112    gcc-14.2.0
powerpc64             randconfig-003-20241111    gcc-14.2.0
powerpc64             randconfig-003-20241112    gcc-14.2.0
riscv                            allmodconfig    clang-20
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    clang-20
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20241111    gcc-14.2.0
riscv                 randconfig-001-20241112    gcc-14.2.0
riscv                 randconfig-002-20241111    gcc-14.2.0
riscv                 randconfig-002-20241112    gcc-14.2.0
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20241111    gcc-14.2.0
s390                  randconfig-001-20241112    gcc-14.2.0
s390                  randconfig-002-20241111    gcc-14.2.0
s390                  randconfig-002-20241112    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                ecovec24-romimage_defconfig    clang-20
sh                          polaris_defconfig    clang-20
sh                    randconfig-001-20241111    gcc-14.2.0
sh                    randconfig-001-20241112    gcc-14.2.0
sh                    randconfig-002-20241111    gcc-14.2.0
sh                    randconfig-002-20241112    gcc-14.2.0
sh                           se7343_defconfig    clang-20
sh                           se7712_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20241111    gcc-14.2.0
sparc64               randconfig-001-20241112    gcc-14.2.0
sparc64               randconfig-002-20241111    gcc-14.2.0
sparc64               randconfig-002-20241112    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241111    gcc-14.2.0
um                    randconfig-001-20241112    gcc-14.2.0
um                    randconfig-002-20241111    gcc-14.2.0
um                    randconfig-002-20241112    gcc-14.2.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64                              defconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                                  kexec    gcc-12
x86_64                               rhel-8.3    gcc-12
x86_64                           rhel-8.3-bpf    clang-19
x86_64                         rhel-8.3-kunit    clang-19
x86_64                           rhel-8.3-ltp    clang-19
x86_64                          rhel-8.3-rust    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20241111    gcc-14.2.0
xtensa                randconfig-001-20241112    gcc-14.2.0
xtensa                randconfig-002-20241111    gcc-14.2.0
xtensa                randconfig-002-20241112    gcc-14.2.0
xtensa                         virt_defconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

