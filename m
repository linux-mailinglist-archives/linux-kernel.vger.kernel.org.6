Return-Path: <linux-kernel+bounces-251599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE839306BE
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 19:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF5DB1C21CE5
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 17:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1EE13D279;
	Sat, 13 Jul 2024 17:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X6SLBPyB"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07551DA58
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 17:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720892261; cv=none; b=osmmOJ+Qi8IRPBRGKahcXnumbs6CQFntIfS2fUgvHYzKymmoCRsGScyOqpZ+pmStJnjyJRAN/oJZxosm7iR6Y0Z5vjvZkS1oGNbGN1H+9aWy3DmyQ71SAvA5xRxSkg+KYjP3DD3/CbuftEr2OnIbV8PpvH6kWUESazm4WMa9d50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720892261; c=relaxed/simple;
	bh=IYorIIi2UDnfDx9jMbM0108wJtc8otjJs70HRhTIhHs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=klPfJlevW2IMNvsWwdhFdGePwXw6I0yZurhSccSe5Caq4ms5+mXTVqO7juaaWotAXb8L0TRMh2MNDwoE/3QvhoKMFWxl3YgDYzZtPZn18Z10VkyyOz+Advye1Fzadm4412a629OmZrcL2l1lscUV1/BBnc6CNyr3YvyJb7y4oF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X6SLBPyB; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720892259; x=1752428259;
  h=date:from:to:cc:subject:message-id;
  bh=IYorIIi2UDnfDx9jMbM0108wJtc8otjJs70HRhTIhHs=;
  b=X6SLBPyBK9Ln2GTTPJ6vQuY4ifXuJy8NoTCtUqUYXkdgEKH3iYPZJtpY
   hCZLQ4/0bMvwpDC+HU5KtY9Q7ku+icebl61VznO5FXMWM8l675e5B/uJV
   9WGVFE0Ar6ws7INAkUwBq12NuAQ4afs7h2vpf9zYXaIGbol6mz3uwxuo5
   5jmsYz1I4YkODUIPvptQIL2u4llAH7RkLZa8mUG8r9qt/mTpoM5tN60DV
   b7xq8ydVRjV8LZDGbAcQyki7l0qUv/tQEIpIMR52dAxWYUEyfq+wITgwW
   7c/TI/N0/VVhAQV2Rqw++dxe8DWw5P+13BV2I3y65frjZFIPuI7QZMZsD
   A==;
X-CSE-ConnectionGUID: 2yFOajBvQWi9oIYRXrPOrg==
X-CSE-MsgGUID: w0afT/3kS1qkfyb33FzsAA==
X-IronPort-AV: E=McAfee;i="6700,10204,11132"; a="35749220"
X-IronPort-AV: E=Sophos;i="6.09,206,1716274800"; 
   d="scan'208";a="35749220"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2024 10:37:39 -0700
X-CSE-ConnectionGUID: sdnk91e7QYmvyaMU6L6/9Q==
X-CSE-MsgGUID: mvHBVCLhRtWzmyD4Fz1bKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,206,1716274800"; 
   d="scan'208";a="49290393"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 13 Jul 2024 10:37:38 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sSggi-000caF-0T;
	Sat, 13 Jul 2024 17:37:36 +0000
Date: Sun, 14 Jul 2024 01:37:32 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 c1ef42a985f0244201ca589f9e5b814b1dc63a07
Message-ID: <202407140130.8myr03vH-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: c1ef42a985f0244201ca589f9e5b814b1dc63a07  Merge branch into tip/master: 'x86/vmware'

elapsed time: 1455m

configs tested: 147
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                   randconfig-001-20240713   gcc-13.2.0
arc                   randconfig-002-20240713   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-19
arm                              allyesconfig   gcc-14.1.0
arm                         at91_dt_defconfig   clang-19
arm                   randconfig-001-20240713   gcc-14.1.0
arm                   randconfig-002-20240713   gcc-14.1.0
arm                   randconfig-003-20240713   clang-19
arm                   randconfig-004-20240713   clang-19
arm                        realview_defconfig   clang-19
arm64                            allmodconfig   clang-19
arm64                             allnoconfig   gcc-14.1.0
arm64                 randconfig-001-20240713   gcc-14.1.0
arm64                 randconfig-002-20240713   gcc-14.1.0
arm64                 randconfig-003-20240713   clang-19
arm64                 randconfig-004-20240713   gcc-14.1.0
csky                              allnoconfig   gcc-14.1.0
csky                  randconfig-001-20240713   gcc-14.1.0
csky                  randconfig-002-20240713   gcc-14.1.0
hexagon                           allnoconfig   clang-19
hexagon               randconfig-001-20240713   clang-19
hexagon               randconfig-002-20240713   clang-19
i386                             allmodconfig   gcc-13
i386                              allnoconfig   gcc-13
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240713   clang-18
i386         buildonly-randconfig-002-20240713   clang-18
i386         buildonly-randconfig-003-20240713   gcc-8
i386         buildonly-randconfig-004-20240713   clang-18
i386         buildonly-randconfig-005-20240713   gcc-13
i386         buildonly-randconfig-006-20240713   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240713   gcc-10
i386                  randconfig-002-20240713   gcc-13
i386                  randconfig-003-20240713   gcc-13
i386                  randconfig-004-20240713   clang-18
i386                  randconfig-005-20240713   gcc-10
i386                  randconfig-006-20240713   gcc-12
i386                  randconfig-011-20240713   clang-18
i386                  randconfig-012-20240713   gcc-7
i386                  randconfig-013-20240713   gcc-13
i386                  randconfig-014-20240713   gcc-13
i386                  randconfig-015-20240713   gcc-11
i386                  randconfig-016-20240713   clang-18
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch             randconfig-001-20240713   gcc-14.1.0
loongarch             randconfig-002-20240713   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                        m5407c3_defconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
mips                         bigsur_defconfig   gcc-14.1.0
mips                           ip28_defconfig   gcc-14.1.0
mips                      loongson3_defconfig   gcc-13.2.0
mips                malta_qemu_32r6_defconfig   gcc-13.2.0
mips                        maltaup_defconfig   clang-19
mips                           rs90_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-14.1.0
nios2                 randconfig-001-20240713   gcc-14.1.0
nios2                 randconfig-002-20240713   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240713   gcc-14.1.0
parisc                randconfig-002-20240713   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                     asp8347_defconfig   clang-17
powerpc                 canyonlands_defconfig   clang-19
powerpc                       eiger_defconfig   clang-19
powerpc                     mpc512x_defconfig   clang-19
powerpc                      ppc44x_defconfig   clang-16
powerpc               randconfig-001-20240713   gcc-14.1.0
powerpc               randconfig-002-20240713   gcc-14.1.0
powerpc               randconfig-003-20240713   clang-19
powerpc                     tqm8555_defconfig   clang-19
powerpc64             randconfig-001-20240713   gcc-14.1.0
powerpc64             randconfig-002-20240713   gcc-14.1.0
powerpc64             randconfig-003-20240713   clang-17
riscv                             allnoconfig   gcc-14.1.0
riscv                               defconfig   clang-19
riscv                 randconfig-001-20240713   gcc-14.1.0
riscv                 randconfig-002-20240713   gcc-14.1.0
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   clang-19
s390                  randconfig-001-20240713   clang-19
s390                  randconfig-002-20240713   clang-19
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                    randconfig-001-20240713   gcc-14.1.0
sh                    randconfig-002-20240713   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                          alldefconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240713   gcc-14.1.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-14.1.0
um                                  defconfig   clang-19
um                             i386_defconfig   gcc-13
um                           x86_64_defconfig   clang-15
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240713   clang-18
x86_64       buildonly-randconfig-002-20240713   clang-18
x86_64       buildonly-randconfig-003-20240713   gcc-13
x86_64       buildonly-randconfig-004-20240713   clang-18
x86_64       buildonly-randconfig-005-20240713   gcc-8
x86_64       buildonly-randconfig-006-20240713   clang-18
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240713   clang-18
x86_64                randconfig-002-20240713   clang-18
x86_64                randconfig-003-20240713   clang-18
x86_64                randconfig-004-20240713   gcc-13
x86_64                randconfig-005-20240713   clang-18
x86_64                randconfig-006-20240713   clang-18
x86_64                randconfig-011-20240713   clang-18
x86_64                randconfig-012-20240713   clang-18
x86_64                randconfig-013-20240713   gcc-13
x86_64                randconfig-014-20240713   clang-18
x86_64                randconfig-015-20240713   gcc-13
x86_64                randconfig-016-20240713   gcc-13
x86_64                randconfig-071-20240713   gcc-8
x86_64                randconfig-072-20240713   gcc-8
x86_64                randconfig-073-20240713   clang-18
x86_64                randconfig-074-20240713   clang-18
x86_64                randconfig-075-20240713   gcc-13
x86_64                randconfig-076-20240713   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

