Return-Path: <linux-kernel+bounces-265172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A078793ED8E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 08:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 539E8280F94
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 06:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F0084D10;
	Mon, 29 Jul 2024 06:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eOOTI2eN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DC564D
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 06:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722235179; cv=none; b=EeY+aBZrTW36ddE2vjDw3nxOQ7/Imp3Kt7crmkGnxiPZauxED9ZU/V9gTPoOTnhHHTkyT6uVmILL/qirYeEsxY5SFn3TokleQqYQsyhDURvLxQ/A34d4M2XKfs1zk53POQ4sE0mAftZUbQX5l9yg4ozTo3U1/4h9LGLbXPV0Hpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722235179; c=relaxed/simple;
	bh=EBaLsdsnLJhUPzd+wIedXTti3wZOLBYaQqfoDgUAJTE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=bQ07MbHo1fLIczyf3sY4TahNO/OuIEf/BeY8O+/87UG/esPacEn+kvKDUPsjj3kMypVnGmXCl83t6JAlIXFDejfvrJNYMOLSmvdBore13mkLqpWj5UkwZVd1k3seSPnzN01iUXskKI/T1hO/vlIxzJcgS9TFTqSFCtxNvcgW5YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eOOTI2eN; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722235177; x=1753771177;
  h=date:from:to:cc:subject:message-id;
  bh=EBaLsdsnLJhUPzd+wIedXTti3wZOLBYaQqfoDgUAJTE=;
  b=eOOTI2eNGsibsTYKC9DmR9wuvd8BMpshDXwcASKB6dSFiWBwEuuicL0p
   VFmglNlBGr0+Ed3GhBUpLY6avxveTs2LrW6uou/mELkyouWT9LjzPaqGB
   NliB96CCa+6E47l8rNQhgTM4AlU9ex1/II9oJaC1ADj6k54T4dFbWKnI8
   yC5pRw/94tkkL1hrZauM7LwTgGazO6/Fb5XRHXhrxPqQdGhuG0tjrVMlO
   6B34JDZh7yNLZB9HNReJxul7Ko5lrnspeDkdNZKAGhDujXB0a4ugCEPyP
   J5Jm7AAobASTUT5VHhOoK7qgN646HBZmymy/E8q0fcAJK/b25xFxLt8vA
   g==;
X-CSE-ConnectionGUID: MwXcyeHsTOKFYiOkFhagHw==
X-CSE-MsgGUID: iacAbNUMRNeULpoG+D2RcQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11147"; a="12760723"
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="12760723"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2024 23:39:36 -0700
X-CSE-ConnectionGUID: DGRBZZt+TyaX2sKDD2R7zw==
X-CSE-MsgGUID: YlvSnUa1S5SWmGDJ/WG2iQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="58969635"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 28 Jul 2024 23:39:35 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sYK2f-000rUs-1S;
	Mon, 29 Jul 2024 06:39:33 +0000
Date: Mon, 29 Jul 2024 14:38:33 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/wfamnae-next20240726-cbc] BUILD
 REGRESSION f5ec08c3584d05dca094f5dc4b4de254756bf9f6
Message-ID: <202407291430.QD0guME5-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/wfamnae-next20240726-cbc
branch HEAD: f5ec08c3584d05dca094f5dc4b4de254756bf9f6  ethtool: Avoid -Wflex-array-member-not-at-end warning

Error/Warning ids grouped by kconfigs:

recent_errors
|-- i386-allmodconfig
|   `-- usr-include-linux-ethtool.h:error:expected-declaration-specifiers-or-...-before-__builtin_offsetof
|-- i386-allyesconfig
|   `-- usr-include-linux-ethtool.h:error:expected-declaration-specifiers-or-...-before-__builtin_offsetof
|-- x86_64-allyesconfig
|   `-- usr-include-linux-ethtool.h:error:expected-parameter-declarator
|-- x86_64-buildonly-randconfig-003-20240729
|   `-- usr-include-linux-ethtool.h:error:expected-declaration-specifiers-or-...-before-__builtin_offsetof
`-- x86_64-buildonly-randconfig-004-20240729
    `-- usr-include-linux-ethtool.h:error:expected-declaration-specifiers-or-...-before-__builtin_offsetof

elapsed time: 885m

configs tested: 164
configs skipped: 10

tested configs:
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.3.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                     nsimosci_hs_defconfig   gcc-13.2.0
arc                   randconfig-001-20240729   gcc-13.2.0
arc                   randconfig-002-20240729   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-20
arm                              allyesconfig   gcc-14.1.0
arm                                 defconfig   clang-14
arm                      footbridge_defconfig   clang-20
arm                       imx_v4_v5_defconfig   clang-16
arm                          ixp4xx_defconfig   gcc-14.1.0
arm                   randconfig-001-20240729   gcc-14.1.0
arm                   randconfig-002-20240729   gcc-14.1.0
arm                   randconfig-003-20240729   gcc-14.1.0
arm                   randconfig-004-20240729   clang-20
arm64                            allmodconfig   clang-20
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-14.1.0
arm64                 randconfig-001-20240729   clang-17
arm64                 randconfig-002-20240729   clang-20
arm64                 randconfig-003-20240729   gcc-14.1.0
arm64                 randconfig-004-20240729   clang-20
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-14.1.0
csky                  randconfig-001-20240729   gcc-14.1.0
csky                  randconfig-002-20240729   gcc-14.1.0
hexagon                           allnoconfig   clang-20
hexagon                             defconfig   clang-20
hexagon               randconfig-001-20240729   clang-20
hexagon               randconfig-002-20240729   clang-20
i386                             allmodconfig   gcc-13
i386                              allnoconfig   gcc-13
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240729   clang-18
i386         buildonly-randconfig-002-20240729   gcc-13
i386         buildonly-randconfig-003-20240729   clang-18
i386         buildonly-randconfig-004-20240729   gcc-10
i386         buildonly-randconfig-005-20240729   clang-18
i386         buildonly-randconfig-006-20240729   gcc-8
i386                                defconfig   clang-18
i386                  randconfig-001-20240729   gcc-12
i386                  randconfig-002-20240729   clang-18
i386                  randconfig-003-20240729   gcc-10
i386                  randconfig-004-20240729   gcc-13
i386                  randconfig-005-20240729   gcc-8
i386                  randconfig-006-20240729   gcc-13
i386                  randconfig-011-20240729   gcc-13
i386                  randconfig-012-20240729   clang-18
i386                  randconfig-013-20240729   gcc-9
i386                  randconfig-014-20240729   clang-18
i386                  randconfig-015-20240729   gcc-13
i386                  randconfig-016-20240729   clang-18
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-14.1.0
loongarch             randconfig-001-20240729   gcc-14.1.0
loongarch             randconfig-002-20240729   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-14.1.0
m68k                       m5475evb_defconfig   gcc-14.1.0
m68k                            mac_defconfig   gcc-14.1.0
m68k                        mvme147_defconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
mips                      malta_kvm_defconfig   gcc-13.2.0
mips                           xway_defconfig   clang-20
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-14.1.0
nios2                 randconfig-001-20240729   gcc-14.1.0
nios2                 randconfig-002-20240729   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240729   gcc-14.1.0
parisc                randconfig-002-20240729   gcc-14.1.0
parisc64                            defconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-20
powerpc                      katmai_defconfig   clang-20
powerpc                 mpc8313_rdb_defconfig   gcc-14.1.0
powerpc                 mpc8315_rdb_defconfig   clang-20
powerpc                     ppa8548_defconfig   gcc-14.1.0
powerpc                     tqm8548_defconfig   clang-20
powerpc64             randconfig-001-20240729   gcc-14.1.0
powerpc64             randconfig-002-20240729   gcc-14.1.0
powerpc64             randconfig-003-20240729   gcc-14.1.0
riscv                            allmodconfig   clang-20
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-20
riscv                               defconfig   clang-20
riscv                 randconfig-001-20240729   clang-16
riscv                 randconfig-002-20240729   clang-20
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   clang-20
s390                  randconfig-001-20240729   clang-20
s390                  randconfig-002-20240729   gcc-14.1.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                               j2_defconfig   gcc-14.1.0
sh                    randconfig-001-20240729   gcc-14.1.0
sh                    randconfig-002-20240729   gcc-14.1.0
sh                          sdk7786_defconfig   gcc-14.1.0
sh                           se7206_defconfig   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240729   gcc-14.1.0
sparc64               randconfig-002-20240729   gcc-14.1.0
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-13
um                                  defconfig   clang-20
um                             i386_defconfig   gcc-13
um                    randconfig-001-20240729   clang-14
um                    randconfig-002-20240729   gcc-8
um                           x86_64_defconfig   clang-15
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240729   clang-18
x86_64       buildonly-randconfig-002-20240729   gcc-13
x86_64       buildonly-randconfig-003-20240729   gcc-10
x86_64       buildonly-randconfig-004-20240729   gcc-10
x86_64       buildonly-randconfig-005-20240729   gcc-10
x86_64       buildonly-randconfig-006-20240729   gcc-10
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240729   gcc-13
x86_64                randconfig-002-20240729   clang-18
x86_64                randconfig-003-20240729   clang-18
x86_64                randconfig-004-20240729   clang-18
x86_64                randconfig-005-20240729   clang-18
x86_64                randconfig-006-20240729   clang-18
x86_64                randconfig-011-20240729   gcc-8
x86_64                randconfig-012-20240729   gcc-8
x86_64                randconfig-013-20240729   gcc-13
x86_64                randconfig-014-20240729   clang-18
x86_64                randconfig-015-20240729   gcc-13
x86_64                randconfig-016-20240729   clang-18
x86_64                randconfig-071-20240729   gcc-13
x86_64                randconfig-072-20240729   gcc-13
x86_64                randconfig-073-20240729   clang-18
x86_64                randconfig-074-20240729   gcc-8
x86_64                randconfig-075-20240729   gcc-12
x86_64                randconfig-076-20240729   gcc-13
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240729   gcc-14.1.0
xtensa                randconfig-002-20240729   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

