Return-Path: <linux-kernel+bounces-428661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 239119E11E6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 04:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8CE52832D1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 03:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215F5165EEB;
	Tue,  3 Dec 2024 03:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CmkxNZGf"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C469C17555
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 03:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733197165; cv=none; b=fyJqjVmrSiaDYiinVi59VN0k6IsQJAxLC0quNBSJqpHf6A0notTcScZKkVFkGMirzH5CJ0+hxKaDjp54oYSd4bAD8HQmzztzXPkH/zPIK3+TvwcHmC+Dd40+TIHzasKFOc+SI4gfVyBWMrcO/HABKtH2yMDE/LDrJAt/i4Y3ij8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733197165; c=relaxed/simple;
	bh=H/bAo6wQSaETr+HQKo1J6gbDGiWX1cSt/zNjTwOsLeQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=IrPQ2JP5pxZzzXzwE5DPMlG+hnN1afDTJxRAQ10PAb6+MkvhcUEZ7C0LAYK2SjspLdzwUvAiY8ZzYHBexg4LYB0bqzgQ6vX3utlCEvpnSQ1Qcli2kKP2ibilvnQFHbOyzygZ5SPyDlgLnWmLrzExXUenKqO0zyWSW9jdux55FzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CmkxNZGf; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733197163; x=1764733163;
  h=date:from:to:cc:subject:message-id;
  bh=H/bAo6wQSaETr+HQKo1J6gbDGiWX1cSt/zNjTwOsLeQ=;
  b=CmkxNZGftf7554V2n8MiAZqdrvZT+yn67WqrwA8HoHrZNhi2J6fFt2DY
   WhvB4CxayeW/2xUtz0tQnAUmmZj3BAk6xU2reCqeObxUtrS7c91faAFy7
   YTgz8zeeAMvsginowQvCBIvbYsdxTPYnae6bZapWUkCaO+NPf+BOSimD9
   nl4qx3ppHmWmuLXtXn0KaEub7H7XNHrS9hyD07cg0V/E3QiTWbH0kpmIW
   BgV831eZy9g4Qx3NLcQAa3FOioGPy9MIeWePNl4Xi9OxoL7WyizCp6s6k
   NZ9mPY2/aLH9WP0VIvUg3clg+Q8agpBiI2VTkZvWfzq+5OdQFg0BPV4FM
   g==;
X-CSE-ConnectionGUID: Ei+FfWCJQtubsBGPSgHwoQ==
X-CSE-MsgGUID: WchKm6ukTpOTospj4iptXA==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="50807957"
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="50807957"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 19:39:23 -0800
X-CSE-ConnectionGUID: QL6yAcj4QamRdAakSXPQgQ==
X-CSE-MsgGUID: E7Tp/9ivR2yK3iCCer/Vcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="93197302"
Received: from lkp-server01.sh.intel.com (HELO 388c121a226b) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 02 Dec 2024 19:39:23 -0800
Received: from kbuild by 388c121a226b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tIJku-00002S-0w;
	Tue, 03 Dec 2024 03:39:20 +0000
Date: Tue, 03 Dec 2024 11:36:59 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/cache] BUILD SUCCESS
 a763fc24ecf2ef0471ccba3b1ff6e6271f4bdc0b
Message-ID: <202412031149.cskVYlKB-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cache
branch HEAD: a763fc24ecf2ef0471ccba3b1ff6e6271f4bdc0b  x86/resctrl: Use kthread_run_on_cpu()

elapsed time: 725m

configs tested: 70
configs skipped: 92

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                            hsdk_defconfig    gcc-14.2.0
arc                   randconfig-001-20241203    clang-20
arc                   randconfig-002-20241203    clang-20
arc                    vdk_hs38_smp_defconfig    gcc-14.2.0
arm                               allnoconfig    gcc-14.2.0
arm                          ep93xx_defconfig    gcc-14.2.0
arm                         mv78xx0_defconfig    gcc-14.2.0
arm                   randconfig-001-20241203    clang-20
arm                   randconfig-002-20241203    clang-20
arm                   randconfig-003-20241203    clang-20
arm                   randconfig-004-20241203    clang-20
arm                           stm32_defconfig    gcc-14.2.0
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20241203    clang-20
arm64                 randconfig-002-20241203    clang-20
arm64                 randconfig-003-20241203    clang-20
arm64                 randconfig-004-20241203    clang-20
csky                             alldefconfig    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
hexagon                           allnoconfig    gcc-14.2.0
i386        buildonly-randconfig-001-20241203    clang-19
i386        buildonly-randconfig-001-20241203    gcc-12
i386        buildonly-randconfig-002-20241203    clang-19
i386        buildonly-randconfig-002-20241203    gcc-12
i386        buildonly-randconfig-003-20241203    clang-19
i386        buildonly-randconfig-004-20241203    clang-19
i386        buildonly-randconfig-005-20241203    clang-19
i386        buildonly-randconfig-006-20241203    clang-19
i386        buildonly-randconfig-006-20241203    gcc-12
loongarch                         allnoconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                        stmark2_defconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                  cavium_octeon_defconfig    gcc-14.2.0
mips                          eyeq5_defconfig    gcc-14.2.0
nios2                            alldefconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
openrisc                          allnoconfig    clang-20
parisc                            allnoconfig    clang-20
parisc                generic-64bit_defconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                     asp8347_defconfig    gcc-14.2.0
powerpc                   currituck_defconfig    gcc-14.2.0
powerpc                       eiger_defconfig    gcc-14.2.0
powerpc                   motionpro_defconfig    gcc-14.2.0
powerpc                     tqm8541_defconfig    gcc-14.2.0
riscv                             allnoconfig    clang-20
s390                              allnoconfig    clang-20
sh                                allnoconfig    gcc-14.2.0
sh                        edosk7760_defconfig    gcc-14.2.0
sh                 kfr2r09-romimage_defconfig    gcc-14.2.0
sh                          r7780mp_defconfig    gcc-14.2.0
sh                           se7724_defconfig    gcc-14.2.0
sh                           se7780_defconfig    gcc-14.2.0
sh                        sh7763rdp_defconfig    gcc-14.2.0
sh                        sh7785lcr_defconfig    gcc-14.2.0
sh                              ul2_defconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
um                                allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20241203    gcc-11
x86_64      buildonly-randconfig-002-20241203    gcc-11
x86_64      buildonly-randconfig-003-20241203    gcc-11
x86_64      buildonly-randconfig-004-20241203    gcc-11
x86_64      buildonly-randconfig-005-20241203    gcc-11
x86_64      buildonly-randconfig-006-20241203    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                         virt_defconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

