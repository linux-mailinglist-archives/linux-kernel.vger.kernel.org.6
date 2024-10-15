Return-Path: <linux-kernel+bounces-365338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A9299E0CD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 10:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14DAFB24BAF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 08:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC4C1C9EDF;
	Tue, 15 Oct 2024 08:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n7aZlg7v"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537171B85F8
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 08:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728980320; cv=none; b=efkAbpP+quyznyQIa9UpcZhwg4iS/uITPhLMrlQ2++RRMx6ZaiUXdWbEqmgRI4Vk9LBmulrMwy4MxM0jduJn1Rgcz0rvWtsU0aP1DmMvh98ed8zmwj2qVFDWjs7FUTP9PvQp/qKhikX3G6/Go5IYIght9riiJO+ss/MG+rg6JFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728980320; c=relaxed/simple;
	bh=ahVaFIJ9Q4nkJPT/HtjQ9GsRX4RsaRaVXNn412Tk+HY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=SSt/17LBngBDhxixG4Cb2FsunXV4Uq3K3DAT0802Z7UiHKp5PUCcJmp6v0DV38qK4yNe08Xej3u63ZDLCVDkP9o2TapLXcUo9YvFQCNKTgEH8A53qPOcXExzoRkVTfyx8o0NsNvxNf2DKMa9bboBRitDz5UlPo/A7DR24L66LMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n7aZlg7v; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728980320; x=1760516320;
  h=date:from:to:cc:subject:message-id;
  bh=ahVaFIJ9Q4nkJPT/HtjQ9GsRX4RsaRaVXNn412Tk+HY=;
  b=n7aZlg7vEdxNbvmYl3zUF8PlP5QM7yhuQ10drU0cXAhIesOhxqLXmekR
   cq8BpXmKiss5+y+eSczeSbRKCggA9wseyQXHRMcYFd5UnIcVmueVWxuF+
   RUHv1XLC2zSlHSQlRW0bSGsRO/eYoCPHoZ2k8yCow2Dbs70+ctE48ubQP
   K/jYHaX8y71REo3rnuT6p08T5Gv+g1yMoM+PgNn0Gmpw+TZZatq/kzQUt
   2RlgXNvdloujLjZlldKUKHiDsN2pHArnfe7Fb3xs/u3/CJcqoLr5Rblnk
   eLd4//GD9XzCCRDOFI2LaCdoOxUuHY+wyOrn07eked2DyTZEVtAaLnrcc
   g==;
X-CSE-ConnectionGUID: NKMzkZwYQyiEVzSvWhjVog==
X-CSE-MsgGUID: EXgfyBZGTyyghlX4gdpyJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="45830915"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="45830915"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 01:18:39 -0700
X-CSE-ConnectionGUID: I1zoxudQRLCtSPQvIsiyLQ==
X-CSE-MsgGUID: CbUcFP3iTw6sk0POgBx9RQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,204,1725346800"; 
   d="scan'208";a="77762566"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 15 Oct 2024 01:18:38 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t0clH-000Hnr-1L;
	Tue, 15 Oct 2024 08:18:35 +0000
Date: Tue, 15 Oct 2024 16:17:35 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/cache] BUILD SUCCESS
 29eaa79583671f1e1b468760d505ef837317ab15
Message-ID: <202410151625.ELD6jCFy-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cache
branch HEAD: 29eaa79583671f1e1b468760d505ef837317ab15  x86/resctrl: Slightly clean-up mbm_config_show()

elapsed time: 912m

configs tested: 99
configs skipped: 125

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
arm                                 defconfig    gcc-14.1.0
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
i386                                defconfig    clang-18
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.1.0
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
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
x86_64      buildonly-randconfig-001-20241015    clang-18
x86_64      buildonly-randconfig-002-20241015    clang-18
x86_64      buildonly-randconfig-003-20241015    clang-18
x86_64      buildonly-randconfig-004-20241015    clang-18
x86_64      buildonly-randconfig-005-20241015    clang-18
x86_64      buildonly-randconfig-006-20241015    clang-18
x86_64                              defconfig    clang-18
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20241015    clang-18
x86_64                randconfig-002-20241015    clang-18
x86_64                randconfig-003-20241015    clang-18
x86_64                randconfig-004-20241015    clang-18
x86_64                randconfig-005-20241015    clang-18
x86_64                randconfig-006-20241015    clang-18
x86_64                randconfig-011-20241015    clang-18
x86_64                randconfig-012-20241015    clang-18
x86_64                randconfig-013-20241015    clang-18
x86_64                randconfig-014-20241015    clang-18
x86_64                randconfig-015-20241015    clang-18
x86_64                randconfig-016-20241015    clang-18
x86_64                randconfig-071-20241015    clang-18
x86_64                randconfig-072-20241015    clang-18
x86_64                randconfig-073-20241015    clang-18
x86_64                randconfig-074-20241015    clang-18
x86_64                randconfig-075-20241015    clang-18
x86_64                randconfig-076-20241015    clang-18
x86_64                               rhel-8.3    gcc-12
xtensa                            allnoconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

