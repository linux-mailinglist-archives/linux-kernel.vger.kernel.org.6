Return-Path: <linux-kernel+bounces-362893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5311399BAC8
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 20:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8C3B281B30
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 18:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33051487D6;
	Sun, 13 Oct 2024 18:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nnBlW7XE"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97FB83CD6
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 18:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728843965; cv=none; b=ivcCpXiY/wFW0MBGCuvYVnvdp3Px8ZbkEcoFocF8EPWg64Wjhpq1MMt8TEuuoZktcloOlZvT6vAF7Esqpa84QF83IUvFb2WpH0h0b9ILxOZ6DhQARPHoScSq8eDs+NwHzUuLvaVJkn2xm/tvGosCvYqrqJckFVQn1fLAHLlKbdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728843965; c=relaxed/simple;
	bh=LsanfURgf+b2rZO+u/RexPBNlSgBuawtLe8cXEMgcQw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=kMpoYhLApb4taMgEGRTxa5nzXgs/STwBPEtshVda9HcBsAZmlevjhkbk0lxhdf80YXzFqbPBo7Onh/nnWTy1vVRe8Z9oHgsuBbPmWGAZxw2d3ogJjJpsPjDBtcHMZii3WU5Ogekm8voB7di1tzCjf6WoP/NPTnv6B8i2mXUPx/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nnBlW7XE; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728843962; x=1760379962;
  h=date:from:to:cc:subject:message-id;
  bh=LsanfURgf+b2rZO+u/RexPBNlSgBuawtLe8cXEMgcQw=;
  b=nnBlW7XE0Ofe6K5El+VmfFcKz0uvE3fl6Ae1MndhlSzgAUACThko9A0d
   WI5yT+T5f54k3ReI5iG83Legw/o28hdag1g4+uo9iQ9hnchw9ON+fu+tY
   naRk7Poz2Ez1pD9n1CHDyG7R8uuZNoKZkJ2YLq/rz+662w+p0JeiETv4+
   dDiTr7CljhaHnFaCAPbNCLwvpVkNPM3s95IdXm4fmAjeykFggM1VRparr
   ZDI6UkeU0NklzCvMSRXMdLrsu+k0xhcnTSfIFG0mEZ0sRbR88YvAv9qcs
   mFtBj3ZPVHRQctZhEs3qzBD1FeOd8UWtlX6Qwlx73HSEhN0S9vS5pxqQJ
   g==;
X-CSE-ConnectionGUID: OwbuTW/aTdCKpBfKLROTJA==
X-CSE-MsgGUID: 70coeaSWQSCyK7X6fHi6Bw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28138127"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28138127"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2024 11:26:02 -0700
X-CSE-ConnectionGUID: udb4vQ6BSZGyC04RufPfXA==
X-CSE-MsgGUID: Zo4HRQ6xSDSuw+5b3uB5eQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="82162282"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 13 Oct 2024 11:26:01 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t03Hy-000Ebf-2I;
	Sun, 13 Oct 2024 18:25:58 +0000
Date: Mon, 14 Oct 2024 02:25:51 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:non-rcu/next] BUILD SUCCESS
 c87bf8b027379bc727e5d14771918bb48451e8fb
Message-ID: <202410140242.ezMuYUQt-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git non-rcu/next
branch HEAD: c87bf8b027379bc727e5d14771918bb48451e8fb  Merge branches 'cmpxchg.2024.10.11a', 'csd-lock.2024.10.11a' and 'lkmm.2024.10.11a' into HEAD

elapsed time: 2860m

configs tested: 202
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.1.0
arc                              alldefconfig    clang-20
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                                 defconfig    gcc-14.1.0
arc                        nsimosci_defconfig    clang-20
arc                   randconfig-001-20241013    gcc-14.1.0
arc                   randconfig-002-20241013    gcc-14.1.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                                 defconfig    gcc-14.1.0
arm                          ixp4xx_defconfig    clang-20
arm                          moxart_defconfig    gcc-14.1.0
arm                           omap1_defconfig    gcc-14.1.0
arm                          pxa168_defconfig    gcc-14.1.0
arm                          pxa3xx_defconfig    clang-20
arm                   randconfig-001-20241013    gcc-14.1.0
arm                   randconfig-002-20241013    gcc-14.1.0
arm                   randconfig-003-20241013    gcc-14.1.0
arm                   randconfig-004-20241013    gcc-14.1.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
arm64                 randconfig-001-20241013    gcc-14.1.0
arm64                 randconfig-002-20241013    gcc-14.1.0
arm64                 randconfig-003-20241013    gcc-14.1.0
arm64                 randconfig-004-20241013    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
csky                  randconfig-001-20241013    gcc-14.1.0
csky                  randconfig-002-20241013    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
hexagon               randconfig-001-20241013    gcc-14.1.0
hexagon               randconfig-002-20241013    gcc-14.1.0
i386                             allmodconfig    clang-18
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-18
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-18
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241013    clang-18
i386        buildonly-randconfig-001-20241013    gcc-12
i386        buildonly-randconfig-002-20241013    gcc-12
i386        buildonly-randconfig-003-20241013    clang-18
i386        buildonly-randconfig-003-20241013    gcc-12
i386        buildonly-randconfig-004-20241013    gcc-12
i386        buildonly-randconfig-005-20241013    clang-18
i386        buildonly-randconfig-005-20241013    gcc-12
i386        buildonly-randconfig-006-20241013    clang-18
i386        buildonly-randconfig-006-20241013    gcc-12
i386                                defconfig    clang-18
i386                  randconfig-001-20241013    clang-18
i386                  randconfig-001-20241013    gcc-12
i386                  randconfig-002-20241013    gcc-12
i386                  randconfig-003-20241013    gcc-12
i386                  randconfig-004-20241013    gcc-11
i386                  randconfig-004-20241013    gcc-12
i386                  randconfig-005-20241013    clang-18
i386                  randconfig-005-20241013    gcc-12
i386                  randconfig-006-20241013    clang-18
i386                  randconfig-006-20241013    gcc-12
i386                  randconfig-011-20241013    clang-18
i386                  randconfig-011-20241013    gcc-12
i386                  randconfig-012-20241013    gcc-12
i386                  randconfig-013-20241013    clang-18
i386                  randconfig-013-20241013    gcc-12
i386                  randconfig-014-20241013    gcc-12
i386                  randconfig-015-20241013    clang-18
i386                  randconfig-015-20241013    gcc-12
i386                  randconfig-016-20241013    clang-18
i386                  randconfig-016-20241013    gcc-12
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
loongarch             randconfig-001-20241013    gcc-14.1.0
loongarch             randconfig-002-20241013    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
m68k                            q40_defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                          ath79_defconfig    clang-20
mips                           ip32_defconfig    clang-20
mips                     loongson1c_defconfig    gcc-14.1.0
mips                          rm200_defconfig    gcc-14.1.0
mips                         rt305x_defconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
nios2                 randconfig-001-20241013    gcc-14.1.0
nios2                 randconfig-002-20241013    gcc-14.1.0
openrisc                          allnoconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                            allnoconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20241013    gcc-14.1.0
parisc                randconfig-002-20241013    gcc-14.1.0
parisc64                            defconfig    gcc-14.1.0
powerpc                           allnoconfig    gcc-14.1.0
powerpc                   currituck_defconfig    gcc-14.1.0
powerpc                       eiger_defconfig    clang-20
powerpc                     ep8248e_defconfig    gcc-14.1.0
powerpc                       holly_defconfig    clang-20
powerpc                     ksi8560_defconfig    gcc-14.1.0
powerpc                      mgcoge_defconfig    gcc-14.1.0
powerpc                      pasemi_defconfig    gcc-14.1.0
powerpc                     powernv_defconfig    gcc-14.1.0
powerpc               randconfig-001-20241013    gcc-14.1.0
powerpc               randconfig-002-20241013    gcc-14.1.0
powerpc               randconfig-003-20241013    gcc-14.1.0
powerpc                     tqm8540_defconfig    gcc-14.1.0
powerpc                      tqm8xx_defconfig    clang-20
powerpc64             randconfig-001-20241013    gcc-14.1.0
powerpc64             randconfig-002-20241013    gcc-14.1.0
powerpc64             randconfig-003-20241013    gcc-14.1.0
riscv                             allnoconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20241013    gcc-14.1.0
riscv                 randconfig-002-20241013    gcc-14.1.0
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20241013    gcc-14.1.0
s390                  randconfig-002-20241013    gcc-14.1.0
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                        dreamcast_defconfig    gcc-14.1.0
sh                ecovec24-romimage_defconfig    clang-20
sh                        edosk7760_defconfig    gcc-14.1.0
sh                          polaris_defconfig    clang-20
sh                    randconfig-001-20241013    gcc-14.1.0
sh                    randconfig-002-20241013    gcc-14.1.0
sh                           se7619_defconfig    clang-20
sh                   sh7724_generic_defconfig    clang-20
sh                        sh7763rdp_defconfig    gcc-14.1.0
sh                            titan_defconfig    clang-20
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20241013    gcc-14.1.0
sparc64               randconfig-002-20241013    gcc-14.1.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241013    gcc-14.1.0
um                    randconfig-002-20241013    gcc-14.1.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64      buildonly-randconfig-001-20241013    clang-18
x86_64      buildonly-randconfig-002-20241013    clang-18
x86_64      buildonly-randconfig-003-20241013    clang-18
x86_64      buildonly-randconfig-004-20241013    clang-18
x86_64      buildonly-randconfig-005-20241013    clang-18
x86_64      buildonly-randconfig-006-20241013    clang-18
x86_64                              defconfig    clang-18
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-18
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20241013    clang-18
x86_64                randconfig-002-20241013    clang-18
x86_64                randconfig-003-20241013    clang-18
x86_64                randconfig-004-20241013    clang-18
x86_64                randconfig-005-20241013    clang-18
x86_64                randconfig-006-20241013    clang-18
x86_64                randconfig-011-20241013    clang-18
x86_64                randconfig-012-20241013    clang-18
x86_64                randconfig-013-20241013    clang-18
x86_64                randconfig-014-20241013    clang-18
x86_64                randconfig-015-20241013    clang-18
x86_64                randconfig-016-20241013    clang-18
x86_64                randconfig-071-20241013    clang-18
x86_64                randconfig-072-20241013    clang-18
x86_64                randconfig-073-20241013    clang-18
x86_64                randconfig-074-20241013    clang-18
x86_64                randconfig-075-20241013    clang-18
x86_64                randconfig-076-20241013    clang-18
x86_64                               rhel-8.3    gcc-12
x86_64                           rhel-8.3-bpf    clang-18
x86_64                         rhel-8.3-kunit    clang-18
x86_64                           rhel-8.3-ltp    clang-18
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0
xtensa                       common_defconfig    clang-20
xtensa                randconfig-001-20241013    gcc-14.1.0
xtensa                randconfig-002-20241013    gcc-14.1.0
xtensa                    smp_lx200_defconfig    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

