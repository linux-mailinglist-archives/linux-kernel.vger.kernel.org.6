Return-Path: <linux-kernel+bounces-521272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96873A3BAC1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 10:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A7EA7A63CD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 09:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5011CAA95;
	Wed, 19 Feb 2025 09:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZSo4VFLd"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449FD1C5D7A
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 09:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739958450; cv=none; b=mNwI24/ALbvGrYD9JHz+pzjjE32sRF/80A7Powmzu+DP7bC6sHwqiDYobXNQ/+lfyK+ftT6hk+fIDXnWnqgh4mu0MQW8OLbNgZEFZ3hDaEctWxzeqDdp8mXMno3boXC+rPgZSfJH89XehAFViIwePZIhQHHOzkwi3kgBlhmtfy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739958450; c=relaxed/simple;
	bh=UiTE3lit8aZ+AxZTBc4vdLHZ1tFOC5IsmqjL/Djtnpc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=QvyOfbQCx/1N0kg2ofl4QRP9KsxVrun7MyLO/OhAAVbUIIEdnY9eXSCK3KrjmZMPa9pAY4dMMS2vDFtznAT3YWcaCtzwovZxqiWRqsCenXl4OH8TyODMxS5TcKKJOcQ+bItPnBBgYHs7HiDnaXmRJyY+WksJz7L7ABtJexKLSpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZSo4VFLd; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739958448; x=1771494448;
  h=date:from:to:cc:subject:message-id;
  bh=UiTE3lit8aZ+AxZTBc4vdLHZ1tFOC5IsmqjL/Djtnpc=;
  b=ZSo4VFLd+ZOvkYaCriaLVct8Idwn8AoMFDQ9s4lwjcQiqklxGNCXBB5I
   CyFT0F+vTIbuLjt1SeTZq6fcGeuyNEeSCbxtDLWkQt+1Kj+kSN8ulb3xX
   1ui7RzF5UVdLPwZWFuq+Liw/iMyU2yldPaL1j0q/9XIlipMrDlojj+oRo
   rWvdiQX7yq4vTaDoYDAAfAC4LPX2sFyMyazdlNNVFFwumy6A9tT98vTtU
   ZXvUI8yVRJWZ9FoCbROvcQ5/FoKC5Ft3FbxnVmNM/kMddDs2pL888nqvs
   vlqv8M096al37k75tWHHnooaDESOoyf3rqPAAcU3fVOUXEcap4BkQZFB7
   Q==;
X-CSE-ConnectionGUID: VsEbihp3T6uKi7WFC4OUyw==
X-CSE-MsgGUID: ZmaMeXu/RfqR6RDMNlCC8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="58094164"
X-IronPort-AV: E=Sophos;i="6.13,298,1732608000"; 
   d="scan'208";a="58094164"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 01:47:27 -0800
X-CSE-ConnectionGUID: wTyf5PA+Ts+kJs804/yPpA==
X-CSE-MsgGUID: QcOCp3p1QRmZnHl/hBKypg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118801176"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 19 Feb 2025 01:47:26 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tkgfs-0002kO-1P;
	Wed, 19 Feb 2025 09:47:24 +0000
Date: Wed, 19 Feb 2025 17:47:05 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:perf/urgent] BUILD SUCCESS
 ec5fd50aeff9c9156304853c6d75eda852d4a2c8
Message-ID: <202502191700.3Cwqa9MD-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/urgent
branch HEAD: ec5fd50aeff9c9156304853c6d75eda852d4a2c8  uprobes: Don't use %pK through printk

elapsed time: 1458m

configs tested: 110
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250218    gcc-13.2.0
arc                   randconfig-002-20250218    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                   randconfig-001-20250218    gcc-14.2.0
arm                   randconfig-002-20250218    gcc-14.2.0
arm                   randconfig-003-20250218    gcc-14.2.0
arm                   randconfig-004-20250218    clang-21
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250218    clang-21
arm64                 randconfig-002-20250218    clang-21
arm64                 randconfig-003-20250218    gcc-14.2.0
arm64                 randconfig-004-20250218    clang-16
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250218    gcc-14.2.0
csky                  randconfig-002-20250218    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250218    clang-17
hexagon               randconfig-002-20250218    clang-21
i386                              allnoconfig    gcc-12
i386        buildonly-randconfig-001-20250218    gcc-12
i386        buildonly-randconfig-002-20250218    gcc-12
i386        buildonly-randconfig-003-20250218    gcc-12
i386        buildonly-randconfig-004-20250218    clang-19
i386        buildonly-randconfig-005-20250218    clang-19
i386        buildonly-randconfig-006-20250218    gcc-12
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250218    gcc-14.2.0
loongarch             randconfig-002-20250218    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250218    gcc-14.2.0
nios2                 randconfig-002-20250218    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250218    gcc-14.2.0
parisc                randconfig-002-20250218    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc               randconfig-001-20250218    gcc-14.2.0
powerpc               randconfig-002-20250218    gcc-14.2.0
powerpc               randconfig-003-20250218    clang-21
powerpc64             randconfig-001-20250218    gcc-14.2.0
powerpc64             randconfig-002-20250218    clang-16
powerpc64             randconfig-003-20250218    clang-18
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-21
riscv                               defconfig    clang-19
riscv                 randconfig-001-20250218    gcc-14.2.0
riscv                 randconfig-002-20250218    clang-21
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20250218    clang-21
s390                  randconfig-002-20250218    clang-15
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                    randconfig-001-20250218    gcc-14.2.0
sh                    randconfig-002-20250218    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250218    gcc-14.2.0
sparc                 randconfig-002-20250218    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250218    gcc-14.2.0
sparc64               randconfig-002-20250218    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250218    clang-21
um                    randconfig-002-20250218    gcc-11
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64      buildonly-randconfig-001-20250218    clang-19
x86_64      buildonly-randconfig-002-20250218    gcc-12
x86_64      buildonly-randconfig-003-20250218    clang-19
x86_64      buildonly-randconfig-004-20250218    gcc-12
x86_64      buildonly-randconfig-005-20250218    clang-19
x86_64      buildonly-randconfig-006-20250218    clang-19
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250218    gcc-14.2.0
xtensa                randconfig-002-20250218    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

