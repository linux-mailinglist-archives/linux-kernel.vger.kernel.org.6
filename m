Return-Path: <linux-kernel+bounces-565857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD5CA6702A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 10:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A7177AC206
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 09:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443661FECA7;
	Tue, 18 Mar 2025 09:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iXRz8Ry/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0501B19B3EE
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 09:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742291169; cv=none; b=c0hSjejW6ipmWAcovXb+KCTYjq2ASVjgPF6A/PSU9dAVNWSoJczwec3hLXXqgrYq+uJbgg1jq76gvoUMO/iPoOgFWGW3YdsXWh+8KV6NmmLq/fQuTCM/pxwzKH+k5w4ADG12Isjbas10SNtNFMVTpNirA/y+WSY5FOk1vHLLJJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742291169; c=relaxed/simple;
	bh=/VysYLH0jpGZ5op6uoOe+wEOVG/rRQH/D9jwsKX4Anw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=DzXVSplFG843LXdfV9W1YiVwmAsFMd1SBC1fRC++aL2H21bhb1L4YNSrDHAKLMiQ6KnQGdOYg68S3pI6tEXVlZmxu9zDQBlqHxWfoLbsnOc2m65RK/1rV8+MVMtltijzPqNZF/VUrIEUHrByx35236VMvgnaXiGpL51U8LJyCWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iXRz8Ry/; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742291165; x=1773827165;
  h=date:from:to:cc:subject:message-id;
  bh=/VysYLH0jpGZ5op6uoOe+wEOVG/rRQH/D9jwsKX4Anw=;
  b=iXRz8Ry/2PVNtay9qFzAv3o2UUZKhJKw6NqxfuOxG+A9a32bTsUB0Ks+
   2rYVIhfdyQXMz4cPL2dqg8U3IixvY8Oro4ab+ovqWv0WjNm3GSt1vuA4a
   g25xVlSInwjBIAqxEIVFDSr3vZa2QSZYcDebRHf3QmLrlCL4v5yp9Khu3
   bX4okB9GNkPTHZR5kizY53C1AXN6qOsrOzjmX0/3DhvgklhEUepWkFGrM
   oQOS/HNM77kxHLY+dmFhiBD7lwOTFxcRqtqkPqn73Jf140QPiUyS+kh9c
   Gz+T7V6k8o+k3K/leS0cn+aJA+b6K1H0+PtU9Hakv+/W6VXY82GvbflK9
   A==;
X-CSE-ConnectionGUID: ayBUT8H6Tma4+A49lGHqJA==
X-CSE-MsgGUID: BFIiTG/HQWiS5xgbfT46ug==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="43438537"
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; 
   d="scan'208";a="43438537"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 02:46:04 -0700
X-CSE-ConnectionGUID: FMKOYTtgTFq3Ze+12J7KKw==
X-CSE-MsgGUID: zb1znlQXQ0ODRGt8Ok5nKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; 
   d="scan'208";a="127385865"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 18 Mar 2025 02:46:03 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tuTWK-000Ddj-0y;
	Tue, 18 Mar 2025 09:46:00 +0000
Date: Tue, 18 Mar 2025 17:45:33 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/sev] BUILD SUCCESS
 f0373cc0907ca7918266a507d6b3b5d75ee839ba
Message-ID: <202503181724.JGVulCb1-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/sev
branch HEAD: f0373cc0907ca7918266a507d6b3b5d75ee839ba  x86/sev: Simplify the code by removing unnecessary 'else' statement

elapsed time: 1449m

configs tested: 112
configs skipped: 128

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-14.2.0
arc                              allnoconfig    gcc-14.2.0
arm                              allnoconfig    gcc-14.2.0
arm                     integrator_defconfig    gcc-14.2.0
arm                         pxa3xx_defconfig    gcc-14.2.0
arm                        socfpga_defconfig    gcc-14.2.0
arm64                            allnoconfig    gcc-14.2.0
csky                             allnoconfig    gcc-14.2.0
csky                 randconfig-001-20250318    gcc-8.5.0
csky                 randconfig-002-20250318    gcc-8.5.0
hexagon                          allnoconfig    gcc-14.2.0
hexagon              randconfig-001-20250318    gcc-8.5.0
hexagon              randconfig-002-20250318    gcc-8.5.0
i386                            allmodconfig    clang-20
i386                            allmodconfig    gcc-12
i386                             allnoconfig    clang-20
i386                             allnoconfig    gcc-12
i386                            allyesconfig    clang-20
i386                            allyesconfig    gcc-12
i386       buildonly-randconfig-001-20250317    gcc-12
i386       buildonly-randconfig-002-20250317    clang-20
i386       buildonly-randconfig-003-20250317    clang-20
i386       buildonly-randconfig-004-20250317    clang-20
i386       buildonly-randconfig-005-20250317    gcc-12
i386       buildonly-randconfig-006-20250317    clang-20
i386                               defconfig    clang-20
i386                 randconfig-001-20250318    clang-20
i386                 randconfig-002-20250318    clang-20
i386                 randconfig-003-20250318    clang-20
i386                 randconfig-004-20250318    clang-20
i386                 randconfig-005-20250318    clang-20
i386                 randconfig-006-20250318    clang-20
i386                 randconfig-007-20250318    clang-20
i386                 randconfig-011-20250318    clang-20
i386                 randconfig-012-20250318    clang-20
i386                 randconfig-013-20250318    clang-20
i386                 randconfig-014-20250318    clang-20
i386                 randconfig-015-20250318    clang-20
i386                 randconfig-016-20250318    clang-20
i386                 randconfig-017-20250318    clang-20
loongarch                        allnoconfig    gcc-14.2.0
loongarch            randconfig-001-20250318    gcc-8.5.0
loongarch            randconfig-002-20250318    gcc-8.5.0
m68k                       mvme147_defconfig    gcc-14.2.0
m68k                          virt_defconfig    gcc-14.2.0
nios2                randconfig-001-20250318    gcc-8.5.0
nios2                randconfig-002-20250318    gcc-8.5.0
openrisc                        allyesconfig    gcc-5.5.0
openrisc                           defconfig    gcc-12
openrisc                      virt_defconfig    gcc-14.2.0
parisc                          allmodconfig    gcc-5.5.0
parisc                          allyesconfig    gcc-5.5.0
parisc                             defconfig    gcc-12
parisc               randconfig-001-20250318    gcc-8.5.0
parisc               randconfig-002-20250318    gcc-8.5.0
powerpc                         allmodconfig    gcc-5.5.0
powerpc                         allyesconfig    gcc-5.5.0
powerpc                       cell_defconfig    gcc-14.2.0
powerpc                     ppc44x_defconfig    gcc-14.2.0
powerpc              randconfig-001-20250318    gcc-8.5.0
powerpc              randconfig-002-20250318    gcc-8.5.0
powerpc              randconfig-003-20250318    gcc-8.5.0
powerpc64            randconfig-001-20250318    gcc-8.5.0
powerpc64            randconfig-002-20250318    gcc-8.5.0
powerpc64            randconfig-003-20250318    gcc-8.5.0
riscv                           allmodconfig    gcc-5.5.0
riscv                           allyesconfig    gcc-5.5.0
riscv                              defconfig    gcc-12
s390                            allmodconfig    gcc-14.2.0
s390                            allyesconfig    gcc-14.2.0
s390                               defconfig    gcc-12
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                                 defconfig    gcc-12
sh                        ecovec24_defconfig    gcc-14.2.0
sh                         lboxre2_defconfig    gcc-14.2.0
sh                     rts7751r2d1_defconfig    gcc-14.2.0
sh                       sh7785lcr_defconfig    gcc-14.2.0
sh                             ul2_defconfig    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc64                            defconfig    gcc-12
um                                 defconfig    gcc-12
um                            i386_defconfig    gcc-12
um                          x86_64_defconfig    gcc-12
x86_64                           allnoconfig    clang-20
x86_64                          allyesconfig    clang-20
x86_64     buildonly-randconfig-001-20250317    gcc-12
x86_64     buildonly-randconfig-002-20250317    clang-20
x86_64     buildonly-randconfig-003-20250317    gcc-12
x86_64     buildonly-randconfig-004-20250317    gcc-12
x86_64     buildonly-randconfig-005-20250317    gcc-12
x86_64     buildonly-randconfig-006-20250317    gcc-12
x86_64                             defconfig    clang-20
x86_64                             defconfig    gcc-11
x86_64                                 kexec    clang-20
x86_64               randconfig-001-20250318    gcc-12
x86_64               randconfig-002-20250318    gcc-12
x86_64               randconfig-003-20250318    gcc-12
x86_64               randconfig-004-20250318    gcc-12
x86_64               randconfig-005-20250318    gcc-12
x86_64               randconfig-006-20250318    gcc-12
x86_64               randconfig-007-20250318    gcc-12
x86_64               randconfig-008-20250318    gcc-12
x86_64               randconfig-071-20250318    gcc-12
x86_64               randconfig-072-20250318    gcc-12
x86_64               randconfig-073-20250318    gcc-12
x86_64               randconfig-074-20250318    gcc-12
x86_64               randconfig-075-20250318    gcc-12
x86_64               randconfig-076-20250318    gcc-12
x86_64               randconfig-077-20250318    gcc-12
x86_64               randconfig-078-20250318    gcc-12
x86_64                              rhel-9.4    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

