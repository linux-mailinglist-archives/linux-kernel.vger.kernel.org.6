Return-Path: <linux-kernel+bounces-404913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D46669C4A3B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 00:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FBDE1F21EA9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 23:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94FF31C7B82;
	Mon, 11 Nov 2024 23:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="guVCEECO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57851C6F6A
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 23:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731369189; cv=none; b=W5nNqXFk4WWTyKjO9Z5uJ8d82gJ/V/OQb46cKKbWdQYEq4WOse8tl81vuRPUckVoEqHAULkkPBk+JoCUrHKFJpmp9mUncSAEcX6gwELziamVSvnBdzZ3YjqUlySZKhijKIJyypdijVj5DZt4BySa5OcnXpE05zYTxuzR8FO1juI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731369189; c=relaxed/simple;
	bh=/0LqUalDTDE4AW3lSsuyvA0z0iKK9PGuDU3CaVIgVKA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ewBEP3oXB8YJ/+qM7CK6H0y5jFZDVLa35ZTLXP1U57fEw7m9gX6CKKKXEYFk2gXR/kft+vP/SzvkXbO8T6bDGI2H29u2eHABaACIgUSHi72Mi0oa7snOoqJ/P2waZAjaugSXCHqxKvkx4YljPdGQ8UQp0uSKhs39fhjDJ14w26U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=guVCEECO; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731369188; x=1762905188;
  h=date:from:to:cc:subject:message-id;
  bh=/0LqUalDTDE4AW3lSsuyvA0z0iKK9PGuDU3CaVIgVKA=;
  b=guVCEECO5/vtAx5uuT2HaAlGHYzJ+4YdS+w2Fek+4ZUw2SN64L3PO4kS
   4hYds60as5DAmhedMPrg2Thvs4VUv8Bc/+VNnQhYu75vjWGgogWB38JzM
   N+DyVE5jPb9Ohw4avQSF8Lsms30YkwmomZzCMUb7pz8bPkSEhfLNRQZpg
   8gmZ9fJ2jPJ41YgPHCg0+ZD49mQw132L8e4xv8rJoCryYzF6JkhZu5VqS
   gjFcaOIhMVCf5RwFNkf9vqEcZ9BvCg2qAGFGGlm98OciFoOhmlk1qroXK
   Dkg9W3tFW3eaR7GyC/CwGIqLMw4TPoVINBH5RWCQmZB+tGNDcD5dHqR4/
   A==;
X-CSE-ConnectionGUID: /rY08btMRf2Ejvwckg+pUQ==
X-CSE-MsgGUID: /MLiAmLVRY+2gLOcqrUhrw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="41751981"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="41751981"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2024 15:53:05 -0800
X-CSE-ConnectionGUID: 2drqkusmSBmlgeGKDyu6zA==
X-CSE-MsgGUID: UPstTd+1RYK1PPfo22J9kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,146,1728975600"; 
   d="scan'208";a="87550403"
Received: from lkp-server01.sh.intel.com (HELO bcfed0da017c) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 11 Nov 2024 15:53:03 -0800
Received: from kbuild by bcfed0da017c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tAeDM-0000Gk-2V;
	Mon, 11 Nov 2024 23:53:00 +0000
Date: Tue, 12 Nov 2024 07:52:40 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD SUCCESS
 771d271b2b908cf660d6789bb4355ed553250edc
Message-ID: <202411120733.vtjiBpTD-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
branch HEAD: 771d271b2b908cf660d6789bb4355ed553250edc  sched, x86: Update the comment for TIF_NEED_RESCHED_LAZY.

elapsed time: 725m

configs tested: 229
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
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20241111    gcc-14.2.0
xtensa                randconfig-001-20241112    gcc-14.2.0
xtensa                randconfig-002-20241111    gcc-14.2.0
xtensa                randconfig-002-20241112    gcc-14.2.0
xtensa                         virt_defconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

