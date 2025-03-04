Return-Path: <linux-kernel+bounces-545499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D32A4EDE1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 20:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECE0A3AE754
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 19:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B192641F4;
	Tue,  4 Mar 2025 19:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ESuYSgdY"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F6E25F7AC
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 19:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741117846; cv=none; b=ImAupVabH1X7woMlcKvnBpcIykK9t2SGde1SBLl2D5LFI0eadpmZYqNNAzuFdeq/MQrxkZcnw7omV3ho/2jQE2mEYrm/5NRyNOsEyxTj+uhZ/ydy3iXi4Io5F878N9Zo16hL48XUwd9ly8Tek5fuTGgmGrY4OdM+1J+189+Q2Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741117846; c=relaxed/simple;
	bh=fsrvmp0ORJ//RkaWHs3Hh+/d2KYarUlJ/FDE8QEpOic=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ZPPBlbMaeUWP0CChLq8ZG55H8ndE9kxxMvn9Pnies67EDpmeTkwfJn/AwMQdGl+kiFZ70KwzyvqQ6yTGduYrMD9QoAyA8eRDu981cp7/NgmZl8vVyHR5nKs2CEOU8ZlqIvYdSNJXeWHlpLv7+lagY44fq4h6e+t3FoAY1IRrGt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ESuYSgdY; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741117844; x=1772653844;
  h=date:from:to:cc:subject:message-id;
  bh=fsrvmp0ORJ//RkaWHs3Hh+/d2KYarUlJ/FDE8QEpOic=;
  b=ESuYSgdYk2RN3aNmCpJg6/Conj2khh73IUKFm/wbJ0+mXD7/cJMgmtWw
   YX0S1Le6d+whGYK4Kun0i0HQBGsMQgf/qbZRLb743lly09WHUMfmNtnDT
   CWPFqTmjkX9PiatCQBF9Y/bu+zl5tpLyVxmwU7YO44tl/Mtej0sy5CzUH
   yrWJW5/lsS3R6DNcrDEQrSSiI8CpYJ4OiRKL2njxFlw4qNlk9CZRtaIF0
   G7RvMIduWCPUS1q2ZFgu08KhUcGYeRMzG4mSV+KLJBSVmKqO8xWDocmnb
   jA3Q271CWUmdV/f41xALFFd+P8NvmwynmSDAQYxeD/g3BrKpBMdiD4Hwx
   w==;
X-CSE-ConnectionGUID: 5ikKQxFISU+/B+/q7F1SZQ==
X-CSE-MsgGUID: WD8EVdhyR0yEyXuzvl1GiQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="52263718"
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="52263718"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 11:50:43 -0800
X-CSE-ConnectionGUID: oNeP2ZZORCSr0Ahcwc8G3A==
X-CSE-MsgGUID: Fw6UJXzPSRy3QlvQSpc3Lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118979272"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 04 Mar 2025 11:50:43 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tpYHo-000KDI-0c;
	Tue, 04 Mar 2025 19:50:40 +0000
Date: Wed, 05 Mar 2025 03:50:34 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:timers/vdso] BUILD SUCCESS
 8770a9183fe18442c7cfbb56bb7e006462775a91
Message-ID: <202503050328.qb5S96x3-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/vdso
branch HEAD: 8770a9183fe18442c7cfbb56bb7e006462775a91  selftests: vDSO: vdso_standalone_test_x86: Switch to nolibc

elapsed time: 1446m

configs tested: 110
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              alldefconfig    gcc-13.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-13.2.0
arc                   randconfig-001-20250304    gcc-13.2.0
arc                   randconfig-002-20250304    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                      integrator_defconfig    clang-15
arm                          pxa3xx_defconfig    clang-21
arm                   randconfig-001-20250304    clang-21
arm                   randconfig-002-20250304    gcc-14.2.0
arm                   randconfig-003-20250304    clang-21
arm                   randconfig-004-20250304    gcc-14.2.0
arm                         s3c6400_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250304    clang-21
arm64                 randconfig-002-20250304    gcc-14.2.0
arm64                 randconfig-003-20250304    gcc-14.2.0
arm64                 randconfig-004-20250304    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250304    gcc-14.2.0
csky                  randconfig-002-20250304    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250304    clang-21
hexagon               randconfig-002-20250304    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250304    clang-19
i386        buildonly-randconfig-002-20250304    clang-19
i386        buildonly-randconfig-003-20250304    gcc-12
i386        buildonly-randconfig-004-20250304    gcc-11
i386        buildonly-randconfig-005-20250304    gcc-11
i386        buildonly-randconfig-006-20250304    gcc-12
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250304    gcc-14.2.0
loongarch             randconfig-002-20250304    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                       m5249evb_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250304    gcc-14.2.0
nios2                 randconfig-002-20250304    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                randconfig-001-20250304    gcc-14.2.0
parisc                randconfig-002-20250304    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc               randconfig-001-20250304    gcc-14.2.0
powerpc               randconfig-002-20250304    gcc-14.2.0
powerpc               randconfig-003-20250304    clang-21
powerpc64             randconfig-001-20250304    gcc-14.2.0
powerpc64             randconfig-002-20250304    gcc-14.2.0
powerpc64             randconfig-003-20250304    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                 randconfig-001-20250304    gcc-14.2.0
riscv                 randconfig-002-20250304    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250304    clang-15
s390                  randconfig-002-20250304    clang-15
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250304    gcc-14.2.0
sh                    randconfig-002-20250304    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250304    gcc-14.2.0
sparc                 randconfig-002-20250304    gcc-14.2.0
sparc64               randconfig-001-20250304    gcc-14.2.0
sparc64               randconfig-002-20250304    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                    randconfig-001-20250304    gcc-12
um                    randconfig-002-20250304    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250304    clang-19
x86_64      buildonly-randconfig-002-20250304    gcc-12
x86_64      buildonly-randconfig-003-20250304    gcc-12
x86_64      buildonly-randconfig-004-20250304    gcc-12
x86_64      buildonly-randconfig-005-20250304    gcc-12
x86_64      buildonly-randconfig-006-20250304    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250304    gcc-14.2.0
xtensa                randconfig-002-20250304    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

