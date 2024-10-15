Return-Path: <linux-kernel+bounces-366601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0CA99F7A3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 21:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 361ED1F22189
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 19:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3394C1F5850;
	Tue, 15 Oct 2024 19:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k6d61Duz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EAF1B6D13
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 19:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729022391; cv=none; b=gWMkjdet7IWhXC/LPfD1W6u/LO5EDvOIWmqAAKKTWXNenUWNj2dK/YE9037J+yqVyz+UWeyuQOEa+Rvcn1mKwvPMakwFW0O+g0Siay39HK3pjbz1xzXMbftlM1r+YWfWrH0R3vHJMGudnnex5Qbxcph2sv7h56nh8Ah62HLlz5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729022391; c=relaxed/simple;
	bh=Cs/cfh8k5ChNretn8h+TeBIjGrI86/n50LdM9PhcYQk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=jKk1KK7xN0Ld8aG/0TP1lbms8DN4k/Qvh7WPnwzO71HdE17Nni570bxe1tuGpJ6YqbKDGyaGTT2CRme8Qc+2XF2vvbTIFOEet8JrXrXVlz9dmMMA1qQJJDs8PXMzCzic+Nvj3QxPNkflRMJLZSnhY8hOO5rD1oSQbv26mMZLmeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k6d61Duz; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729022390; x=1760558390;
  h=date:from:to:cc:subject:message-id;
  bh=Cs/cfh8k5ChNretn8h+TeBIjGrI86/n50LdM9PhcYQk=;
  b=k6d61DuzvDQy7NqwGyRAJO7QZ4+i2/9fHsxwre7QHL3c+fFFqvMy18fo
   iGLFkvP98vrbVABODlLjKe7agweh/iQem7z0tXCfY35WZf/rrN9X81TgH
   7XKySXwxbXSd3/5d4yo2lT/eX/7XqHJSYHg723GccZpCTB2g2nHRiSGrr
   TZ914RDOZX/uVDOpsP2GXjRwrVk8CtCO/LUa6DGppHCo3p64nD+mcL4SF
   uY3SHM6rQE9fixW12pRZkZnsGGmFd5ouTaaIBadu96b2Ui/QxRwZkpa9B
   jXpjD458Yzj9zWE82Psm6GCKorPhWvmFwn9e2DPSk/bVBuA3aUwfvUzZO
   A==;
X-CSE-ConnectionGUID: 747oQfZdRP+xAJqXKTrrSA==
X-CSE-MsgGUID: lYEK6ZgrTDSkFikN+vUFZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="27918860"
X-IronPort-AV: E=Sophos;i="6.11,206,1725346800"; 
   d="scan'208";a="27918860"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 12:59:49 -0700
X-CSE-ConnectionGUID: KG9yOhn2S8u3jzNFpYpuKQ==
X-CSE-MsgGUID: aFRSYOCCTIqjOX4Q/l5ndA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,206,1725346800"; 
   d="scan'208";a="82783544"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 15 Oct 2024 12:59:48 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t0nhp-000JsF-1s;
	Tue, 15 Oct 2024 19:59:45 +0000
Date: Wed, 16 Oct 2024 03:58:48 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:sched/urgent] BUILD SUCCESS
 cd9626e9ebc77edec33023fe95dab4b04ffc819d
Message-ID: <202410160341.Xcm1yZtl-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/urgent
branch HEAD: cd9626e9ebc77edec33023fe95dab4b04ffc819d  sched/fair: Fix external p->on_rq users

elapsed time: 2193m

configs tested: 104
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                                 defconfig    gcc-14.1.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                        mvebu_v7_defconfig    clang-20
arm                           sama7_defconfig    clang-20
arm                        shmobile_defconfig    clang-20
arm                          sp7021_defconfig    clang-20
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
i386                             allmodconfig    clang-18
i386                              allnoconfig    clang-18
i386                             allyesconfig    clang-18
i386        buildonly-randconfig-001-20241015    clang-18
i386        buildonly-randconfig-002-20241015    clang-18
i386        buildonly-randconfig-003-20241015    clang-18
i386        buildonly-randconfig-004-20241015    clang-18
i386        buildonly-randconfig-005-20241015    clang-18
i386        buildonly-randconfig-006-20241015    clang-18
i386                                defconfig    clang-18
i386                  randconfig-001-20241015    clang-18
i386                  randconfig-002-20241015    clang-18
i386                  randconfig-003-20241015    clang-18
i386                  randconfig-004-20241015    clang-18
i386                  randconfig-005-20241015    clang-18
i386                  randconfig-006-20241015    clang-18
i386                  randconfig-011-20241015    clang-18
i386                  randconfig-012-20241015    clang-18
i386                  randconfig-013-20241015    clang-18
i386                  randconfig-014-20241015    clang-18
i386                  randconfig-015-20241015    clang-18
i386                  randconfig-016-20241015    clang-18
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                          amiga_defconfig    clang-20
m68k                                defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                           gcw0_defconfig    clang-20
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                            defconfig    gcc-12
parisc                            allnoconfig    clang-20
parisc                              defconfig    gcc-12
parisc64                            defconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                      ep88xc_defconfig    clang-20
powerpc                       holly_defconfig    clang-20
powerpc                      pasemi_defconfig    clang-20
powerpc                 xes_mpc85xx_defconfig    clang-20
riscv                             allnoconfig    clang-20
riscv                               defconfig    gcc-12
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                          landisk_defconfig    clang-20
sh                             shx3_defconfig    clang-20
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
um                               alldefconfig    clang-20
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64                              defconfig    clang-18
x86_64                                  kexec    clang-18
x86_64                                  kexec    gcc-12
x86_64                               rhel-8.3    gcc-12
x86_64                           rhel-8.3-bpf    clang-18
x86_64                         rhel-8.3-kunit    clang-18
x86_64                           rhel-8.3-ltp    clang-18
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0
xtensa                  nommu_kc705_defconfig    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

