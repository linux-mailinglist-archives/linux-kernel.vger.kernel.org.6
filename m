Return-Path: <linux-kernel+bounces-264228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7273D93E065
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 19:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED23E1F21AD0
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 17:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABAD7186E51;
	Sat, 27 Jul 2024 17:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lr1jbSsu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DF91B86E0
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 17:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722103058; cv=none; b=fZ5/MCTQpViZuaLNklm6WjLGgYFOYUmuNIqmL+jcQF3i6AnCBme1rLVAjjLiH0fGElqnhx9g8wtj12Rxgo9anod1m1QxY5bPrcg21rv6Vm8pdJ7fwJsSCIXutkugzkA3n/mxyAlLg6lLdVjZctdoz/CFa+iWsJCCkvYLB/z0y5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722103058; c=relaxed/simple;
	bh=f4X6sLVBqVCBhpFRm3Jj0cwE8loNwOi5YXY9SizYem0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=nrwXUyt0vu84g7qd1YKmc2yHP1LHFLyvnLxaZxntcEoKtBHgLGrR7HRMYWF71+uitkYwx9mDszX9jJPv3nD1RhDtxLMbdsfvcjjlks6kMu0GhUTgJzcoYh6KJg1YQUksiVaYnWm5YGrLq1FCwwISgf4CPq8sR3KM2YoKGvd0eAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lr1jbSsu; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722103057; x=1753639057;
  h=date:from:to:cc:subject:message-id;
  bh=f4X6sLVBqVCBhpFRm3Jj0cwE8loNwOi5YXY9SizYem0=;
  b=lr1jbSsuDuqybx7IcwgRzsj/nUiw0fipM5wxri5RWV63oSCozFf8H5Jp
   QRfIVW0/fSWA7CwDQDcp90VHDb2moWShYVwLZTHOlWOAiV7TxFxpcvKpb
   CYpBEXZNjJlgXIPpajaK3n4kn/pyU35207MB/4JCQOYY/8xQTnuJtI21O
   9N63SbdSzFtU79otygAVrZHokrCZeSJnSaR+gbEy7a7wuPljTmYwaRgvM
   OSma+60b8MTSoF6cQXMm7h8ub1qkIZm5v0R3zO38fAKPnReIasTzUM8fM
   nbR6Z+lDWD7/izdLm5gRVySZyrynUTi/maWv/fPqRDe5UeMymEGuDLRqY
   A==;
X-CSE-ConnectionGUID: VIZ2ULnITca+p4lB5FREug==
X-CSE-MsgGUID: qO3n31zOREy6mhXKqQNpNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11146"; a="19485925"
X-IronPort-AV: E=Sophos;i="6.09,242,1716274800"; 
   d="scan'208";a="19485925"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2024 10:57:36 -0700
X-CSE-ConnectionGUID: ZNMujZ54RsGhNMQhpEzO/A==
X-CSE-MsgGUID: n147QVZ+QCqzAmbEfvVpkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,242,1716274800"; 
   d="scan'208";a="84205593"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 27 Jul 2024 10:57:35 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sXlfg-000q7y-0m;
	Sat, 27 Jul 2024 17:57:32 +0000
Date: Sun, 28 Jul 2024 01:56:59 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:irq/urgent] BUILD SUCCESS
 81a91abab1307d7725fa4620952c0767beae7753
Message-ID: <202407280156.mTSVUCpk-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/urgent
branch HEAD: 81a91abab1307d7725fa4620952c0767beae7753  irqchip/loongarch-cpu: Fix return value of lpic_gsi_to_irq()

elapsed time: 1339m

configs tested: 191
configs skipped: 5

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
arc                          axs103_defconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                    vdk_hs38_smp_defconfig   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                               allnoconfig   clang-20
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                              allyesconfig   gcc-14.1.0
arm                                 defconfig   gcc-13.2.0
arm                          pxa910_defconfig   gcc-13.2.0
arm64                            allmodconfig   clang-20
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-13.2.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   clang-20
hexagon                          allyesconfig   clang-20
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-13
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-13
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240727   gcc-13
i386         buildonly-randconfig-002-20240727   clang-18
i386         buildonly-randconfig-002-20240727   gcc-13
i386         buildonly-randconfig-003-20240727   gcc-13
i386         buildonly-randconfig-003-20240727   gcc-8
i386         buildonly-randconfig-004-20240727   gcc-10
i386         buildonly-randconfig-004-20240727   gcc-13
i386         buildonly-randconfig-005-20240727   clang-18
i386         buildonly-randconfig-005-20240727   gcc-13
i386         buildonly-randconfig-006-20240727   clang-18
i386         buildonly-randconfig-006-20240727   gcc-13
i386                                defconfig   clang-18
i386                  randconfig-001-20240727   clang-18
i386                  randconfig-001-20240727   gcc-13
i386                  randconfig-002-20240727   gcc-13
i386                  randconfig-002-20240727   gcc-8
i386                  randconfig-003-20240727   clang-18
i386                  randconfig-003-20240727   gcc-13
i386                  randconfig-004-20240727   clang-18
i386                  randconfig-004-20240727   gcc-13
i386                  randconfig-005-20240727   clang-18
i386                  randconfig-005-20240727   gcc-13
i386                  randconfig-006-20240727   gcc-13
i386                  randconfig-011-20240727   gcc-13
i386                  randconfig-012-20240727   gcc-13
i386                  randconfig-013-20240727   gcc-11
i386                  randconfig-013-20240727   gcc-13
i386                  randconfig-014-20240727   gcc-13
i386                  randconfig-015-20240727   clang-18
i386                  randconfig-015-20240727   gcc-13
i386                  randconfig-016-20240727   gcc-13
i386                  randconfig-016-20240727   gcc-7
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-13.2.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
m68k                           sun3_defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-14.1.0
mips                          ath79_defconfig   gcc-13.2.0
mips                     loongson1b_defconfig   gcc-13.2.0
mips                malta_qemu_32r6_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-13.2.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-20
powerpc                          allyesconfig   gcc-14.1.0
powerpc                      bamboo_defconfig   gcc-13.2.0
powerpc                    mvme5100_defconfig   gcc-13.2.0
powerpc                      pmac32_defconfig   gcc-13.2.0
powerpc                     tqm8541_defconfig   gcc-13.2.0
riscv                            allmodconfig   clang-20
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-20
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-14.1.0
s390                             alldefconfig   gcc-13.2.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-14.1.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                     magicpanelr2_defconfig   gcc-13.2.0
sh                           se7619_defconfig   gcc-13.2.0
sparc                            allmodconfig   gcc-14.1.0
sparc                       sparc64_defconfig   gcc-13.2.0
sparc64                             defconfig   gcc-14.1.0
um                               allmodconfig   clang-20
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-13
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-14.1.0
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240727   gcc-8
x86_64       buildonly-randconfig-002-20240727   gcc-13
x86_64       buildonly-randconfig-002-20240727   gcc-8
x86_64       buildonly-randconfig-003-20240727   gcc-13
x86_64       buildonly-randconfig-003-20240727   gcc-8
x86_64       buildonly-randconfig-004-20240727   gcc-13
x86_64       buildonly-randconfig-004-20240727   gcc-8
x86_64       buildonly-randconfig-005-20240727   clang-18
x86_64       buildonly-randconfig-005-20240727   gcc-8
x86_64       buildonly-randconfig-006-20240727   gcc-13
x86_64       buildonly-randconfig-006-20240727   gcc-8
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240727   gcc-13
x86_64                randconfig-001-20240727   gcc-8
x86_64                randconfig-002-20240727   clang-18
x86_64                randconfig-002-20240727   gcc-8
x86_64                randconfig-003-20240727   clang-18
x86_64                randconfig-003-20240727   gcc-8
x86_64                randconfig-004-20240727   clang-18
x86_64                randconfig-004-20240727   gcc-8
x86_64                randconfig-005-20240727   gcc-13
x86_64                randconfig-005-20240727   gcc-8
x86_64                randconfig-006-20240727   clang-18
x86_64                randconfig-006-20240727   gcc-8
x86_64                randconfig-011-20240727   gcc-13
x86_64                randconfig-011-20240727   gcc-8
x86_64                randconfig-012-20240727   gcc-13
x86_64                randconfig-012-20240727   gcc-8
x86_64                randconfig-013-20240727   clang-18
x86_64                randconfig-013-20240727   gcc-8
x86_64                randconfig-014-20240727   gcc-10
x86_64                randconfig-014-20240727   gcc-8
x86_64                randconfig-015-20240727   gcc-12
x86_64                randconfig-015-20240727   gcc-8
x86_64                randconfig-016-20240727   gcc-10
x86_64                randconfig-016-20240727   gcc-8
x86_64                randconfig-071-20240727   gcc-13
x86_64                randconfig-071-20240727   gcc-8
x86_64                randconfig-072-20240727   gcc-13
x86_64                randconfig-072-20240727   gcc-8
x86_64                randconfig-073-20240727   gcc-8
x86_64                randconfig-074-20240727   gcc-8
x86_64                randconfig-075-20240727   clang-18
x86_64                randconfig-075-20240727   gcc-8
x86_64                randconfig-076-20240727   clang-18
x86_64                randconfig-076-20240727   gcc-8
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                            allnoconfig   gcc-14.1.0
xtensa                  cadence_csp_defconfig   gcc-13.2.0
xtensa                generic_kc705_defconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

