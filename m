Return-Path: <linux-kernel+bounces-547682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADE2A50C58
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 21:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F5773B0A45
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 20:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7187125525A;
	Wed,  5 Mar 2025 20:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e3q9cVNh"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B24C255237
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 20:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741205700; cv=none; b=Ac/h3CxT4qxuZE/FUSBEuy4KXTYLO8bKRpEDNwW61PYhozfNjzO0Ey0zJfeOjaYxaez9OnLpBlikUbhk0DTt9qfTg+uS8ls99Uslt6jplgNsN7VunTpKrxJkqXw5dTjfsMBS8rb7ygxq+UDqcxKgff5uXUesRAabS8ieQvdlKME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741205700; c=relaxed/simple;
	bh=+dtIJ93sF5JRKmRZGRypMedIhHAR3r84GNnpv/Ale38=;
	h=Date:From:To:Cc:Subject:Message-ID; b=XEBOS1vARBuuj5/hqf1XNIK0O66lfKBD92QmRITXTpQEixcSW+bq1sFHImbV1nGrwTeQGxnVPzp6PAuUKGKkZQT5AJlBXLkzdBoaY6S7XaG2d4NhOMy9DRwU3bNJHHO6nsQ97iZQPagPMhpRa5IqYCay4AZLR8PkfvJ6ySu01CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e3q9cVNh; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741205699; x=1772741699;
  h=date:from:to:cc:subject:message-id;
  bh=+dtIJ93sF5JRKmRZGRypMedIhHAR3r84GNnpv/Ale38=;
  b=e3q9cVNhDnFdU+m9WtX/woDhDQjp2Io0Y5dbgot7Xqnjfbym06xB39vA
   m6qP69SlT5wX+oqzyQj4crpXQvQKnxwZL7vadIA9ODHl9CysDDG6NV6Xy
   Z0GZAezbTRAIvPcITrPQU4ZSwRCKDSMwHLiYzzSFTPW4o97ffd+qyyhxk
   kwinFeE4dOD93fOLwjhkb4XQ7tb9T4SuIXcuSoo/HxVjMtCZedlqxH7i8
   wk+TnWiE/H5WA2d/CW+QQRGPr6IWCrkhQSzt/uGkONf/oycIVZ95M4NPc
   XyDL37kcForqC6u8H6dsuAG/0OUowpaJyrGJlpuTYkT5d8r8vOPQpBePj
   g==;
X-CSE-ConnectionGUID: iV0L8U52TBuD00YavlsaEg==
X-CSE-MsgGUID: Fy1lwYhGTaWUzw9CGijnwg==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="42321939"
X-IronPort-AV: E=Sophos;i="6.14,224,1736841600"; 
   d="scan'208";a="42321939"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 12:14:58 -0800
X-CSE-ConnectionGUID: kkoXlE+yQkO/tkCC5WkAfQ==
X-CSE-MsgGUID: zJGG292iRNqz6B81lYhVeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="156004715"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 05 Mar 2025 12:14:57 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tpv8n-000MAC-34;
	Wed, 05 Mar 2025 20:14:55 +0000
Date: Thu, 06 Mar 2025 04:14:46 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/asm] BUILD SUCCESS
 c8b584fe82d0f1e478a598f954943b095a4a8f5c
Message-ID: <202503060440.W23OSdQL-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/asm
branch HEAD: c8b584fe82d0f1e478a598f954943b095a4a8f5c  x86/irq/32: Change some static functions to bool

elapsed time: 1447m

configs tested: 88
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250305    gcc-13.2.0
arc                   randconfig-002-20250305    gcc-13.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                   randconfig-001-20250305    gcc-14.2.0
arm                   randconfig-002-20250305    clang-19
arm                   randconfig-003-20250305    gcc-14.2.0
arm                   randconfig-004-20250305    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250305    clang-15
arm64                 randconfig-002-20250305    gcc-14.2.0
arm64                 randconfig-003-20250305    clang-21
arm64                 randconfig-004-20250305    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250305    gcc-14.2.0
csky                  randconfig-002-20250305    gcc-14.2.0
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250305    clang-21
hexagon               randconfig-002-20250305    clang-18
i386                              allnoconfig    gcc-12
i386        buildonly-randconfig-001-20250305    clang-19
i386        buildonly-randconfig-002-20250305    clang-19
i386        buildonly-randconfig-003-20250305    clang-19
i386        buildonly-randconfig-004-20250305    clang-19
i386        buildonly-randconfig-005-20250305    clang-19
i386        buildonly-randconfig-006-20250305    gcc-12
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250305    gcc-14.2.0
loongarch             randconfig-002-20250305    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250305    gcc-14.2.0
nios2                 randconfig-002-20250305    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                randconfig-001-20250305    gcc-14.2.0
parisc                randconfig-002-20250305    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc               randconfig-001-20250305    clang-17
powerpc               randconfig-002-20250305    gcc-14.2.0
powerpc               randconfig-003-20250305    gcc-14.2.0
powerpc64             randconfig-001-20250305    clang-19
powerpc64             randconfig-002-20250305    clang-17
powerpc64             randconfig-003-20250305    clang-19
riscv                             allnoconfig    gcc-14.2.0
riscv                 randconfig-001-20250305    clang-19
riscv                 randconfig-002-20250305    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250305    gcc-14.2.0
s390                  randconfig-002-20250305    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250305    gcc-14.2.0
sh                    randconfig-002-20250305    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250305    gcc-14.2.0
sparc                 randconfig-002-20250305    gcc-14.2.0
sparc64               randconfig-001-20250305    gcc-14.2.0
sparc64               randconfig-002-20250305    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                    randconfig-001-20250305    clang-19
um                    randconfig-002-20250305    gcc-12
x86_64                            allnoconfig    clang-19
x86_64      buildonly-randconfig-001-20250305    clang-19
x86_64      buildonly-randconfig-002-20250305    gcc-12
x86_64      buildonly-randconfig-003-20250305    clang-19
x86_64      buildonly-randconfig-004-20250305    gcc-12
x86_64      buildonly-randconfig-005-20250305    clang-19
x86_64      buildonly-randconfig-006-20250305    clang-19
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250305    gcc-14.2.0
xtensa                randconfig-002-20250305    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

