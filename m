Return-Path: <linux-kernel+bounces-371671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B23299A3E63
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 14:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6723B2855DB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 12:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2589D22EEF;
	Fri, 18 Oct 2024 12:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E0N2eRSy"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E165FF9F8
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 12:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729254579; cv=none; b=NTM2Lv80nTxNUQA2LONSP/wOPq+b00GURc5j94mKEKo5Zy8kpLAv14/8ihNoeRVkt3iOxg9alfjgG5ISojuXg5I923pLvJMaZrDRKXqaKk+epx20Od6S8s2kF1lMpBTw/3qX7uFGmfq7J/T1yuuLa8WgZ2zp+4rPcXQ4EV3Gtw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729254579; c=relaxed/simple;
	bh=VV1oRK2SWRRte2+olJujx+EjC6To4nANOdZ0GtMgFps=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Bv9Mv+OXv4/SitRpH/6ATSGQRMl/9Cn0zg+XscqQsZc/U6tgAplEl841xVYC2cQfyKowV3aVnN4VwQaa8igjo8VxFt8iMWSeVfPx/HuvTz6iZsSyZ0qXjuKD8U54l1DhBCHkvU0E1itnryehGL7XVROw9WpHDknE/ACGXH5BRHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E0N2eRSy; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729254579; x=1760790579;
  h=date:from:to:cc:subject:message-id;
  bh=VV1oRK2SWRRte2+olJujx+EjC6To4nANOdZ0GtMgFps=;
  b=E0N2eRSyN7aqscU4zP368sgo4W6gusUwUUVLB+WGWyaO4C+T8iomqFlk
   B4ZVU6lpT0ak2wuNpCFaWvYv/3pXf7GHhUUAUWbrjIheFKADDI7mqWzTa
   Ls6/QHJMs9fvn9Xbe0+sJmuoUh6Tlrpu41N0b+R9AOdnQdKgZ7/RpCviU
   7+j1BnvdP9E2mZ9Ws/miV6zhL1lj0FkW/jKSCWca4aiZRHOYhjfTzZm2F
   LZNful/JOnjWhcE6QAtHYD+6fzrwVwqRHut37PJsGfPKz3fsIzOyaymt6
   olENd3tW6nsW0fotzy9XvO6SKIICyyfvbkKYJG5tcFcwSPOwNxYZmmamy
   Q==;
X-CSE-ConnectionGUID: KbumIYN7SqSjRwIP/NEPLQ==
X-CSE-MsgGUID: Vl5/uAVnQxyjtDtKU+f0rw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="46241900"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="46241900"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 05:29:38 -0700
X-CSE-ConnectionGUID: NkrbU1Q8TyqWaS6v7dag6g==
X-CSE-MsgGUID: /ggGwZDbR8OgLQ6xT4XoSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; 
   d="scan'208";a="83439244"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 18 Oct 2024 05:29:36 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t1m6o-000NoH-0N;
	Fri, 18 Oct 2024 12:29:34 +0000
Date: Fri, 18 Oct 2024 20:28:59 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/sev] BUILD SUCCESS
 0a895c0d9b73d934de95aa0dd4e631c394bdd25d
Message-ID: <202410182051.fAke1ASB-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/sev
branch HEAD: 0a895c0d9b73d934de95aa0dd4e631c394bdd25d  virt: sev-guest: Carve out SNP message context structure

elapsed time: 1436m

configs tested: 150
configs skipped: 4

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
arc                 nsimosci_hs_smp_defconfig    gcc-14.1.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                                 defconfig    gcc-14.1.0
arm                          exynos_defconfig    gcc-14.1.0
arm                          gemini_defconfig    gcc-14.1.0
arm                          ixp4xx_defconfig    gcc-14.1.0
arm                        keystone_defconfig    gcc-14.1.0
arm                        multi_v7_defconfig    gcc-14.1.0
arm                             rpc_defconfig    gcc-14.1.0
arm                         s5pv210_defconfig    gcc-14.1.0
arm                           tegra_defconfig    gcc-14.1.0
arm                       versatile_defconfig    gcc-14.1.0
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
i386        buildonly-randconfig-001-20241018    gcc-11
i386        buildonly-randconfig-002-20241018    gcc-11
i386        buildonly-randconfig-003-20241018    gcc-11
i386        buildonly-randconfig-004-20241018    gcc-11
i386        buildonly-randconfig-005-20241018    gcc-11
i386        buildonly-randconfig-006-20241018    gcc-11
i386                                defconfig    clang-18
i386                  randconfig-001-20241018    gcc-11
i386                  randconfig-002-20241018    gcc-11
i386                  randconfig-003-20241018    gcc-11
i386                  randconfig-004-20241018    gcc-11
i386                  randconfig-005-20241018    gcc-11
i386                  randconfig-006-20241018    gcc-11
i386                  randconfig-011-20241018    gcc-11
i386                  randconfig-012-20241018    gcc-11
i386                  randconfig-013-20241018    gcc-11
i386                  randconfig-014-20241018    gcc-11
i386                  randconfig-015-20241018    gcc-11
i386                  randconfig-016-20241018    gcc-11
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
m68k                        m5272c3_defconfig    gcc-14.1.0
m68k                        stmark2_defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
microblaze                      mmu_defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                  cavium_octeon_defconfig    gcc-14.1.0
mips                           ip30_defconfig    gcc-14.1.0
nios2                            alldefconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
openrisc                    or1ksim_defconfig    gcc-14.1.0
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.1.0
powerpc                  iss476-smp_defconfig    gcc-14.1.0
powerpc                      pcm030_defconfig    gcc-14.1.0
powerpc                     redwood_defconfig    gcc-14.1.0
powerpc                     skiroot_defconfig    gcc-14.1.0
powerpc                      tqm8xx_defconfig    gcc-14.1.0
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
riscv             nommu_k210_sdcard_defconfig    gcc-14.1.0
riscv                    nommu_virt_defconfig    gcc-14.1.0
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                            hp6xx_defconfig    gcc-14.1.0
sh                          sdk7786_defconfig    gcc-14.1.0
sh                           se7705_defconfig    gcc-14.1.0
sh                           se7751_defconfig    gcc-14.1.0
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64      buildonly-randconfig-001-20241018    clang-18
x86_64      buildonly-randconfig-002-20241018    clang-18
x86_64      buildonly-randconfig-003-20241018    clang-18
x86_64      buildonly-randconfig-004-20241018    clang-18
x86_64      buildonly-randconfig-005-20241018    clang-18
x86_64      buildonly-randconfig-006-20241018    clang-18
x86_64                              defconfig    clang-18
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20241018    clang-18
x86_64                randconfig-002-20241018    clang-18
x86_64                randconfig-003-20241018    clang-18
x86_64                randconfig-004-20241018    clang-18
x86_64                randconfig-005-20241018    clang-18
x86_64                randconfig-006-20241018    clang-18
x86_64                randconfig-011-20241018    clang-18
x86_64                randconfig-012-20241018    clang-18
x86_64                randconfig-013-20241018    clang-18
x86_64                randconfig-014-20241018    clang-18
x86_64                randconfig-015-20241018    clang-18
x86_64                randconfig-016-20241018    clang-18
x86_64                randconfig-071-20241018    clang-18
x86_64                randconfig-072-20241018    clang-18
x86_64                randconfig-073-20241018    clang-18
x86_64                randconfig-074-20241018    clang-18
x86_64                randconfig-075-20241018    clang-18
x86_64                randconfig-076-20241018    clang-18
x86_64                               rhel-8.3    gcc-12
x86_64                           rhel-8.3-bpf    clang-18
x86_64                         rhel-8.3-kunit    clang-18
x86_64                           rhel-8.3-ltp    clang-18
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0
xtensa                       common_defconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

