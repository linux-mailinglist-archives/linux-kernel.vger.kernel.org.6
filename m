Return-Path: <linux-kernel+bounces-550034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F21E3A55A43
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 23:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28B64176421
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 22:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FADE27CB1D;
	Thu,  6 Mar 2025 22:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QkGxyLC4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C36161320
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 22:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741301931; cv=none; b=CuJsw0/+6ElovCbOPUhSlLdGDXXeNsb0qK3H41BfSbQCGF9t8QRsQeZmWTZquDaNE1C0db2KdraPaXnYTTz0gd1iUd7fZKTeW252LIf0FhVe8K9bH1YlD0uc/ij6NeqjErhrvm5aR1JZhE3SH27VuVIPPEyNTnbzCh/RYaryDic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741301931; c=relaxed/simple;
	bh=fOwK2BPFlcy491EdhaRDwoGKr5VXHWkldsdkOh5pzeQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=tEA1/fOsJQxpU211mOSsYWiRe6o8bBJJJ3mv+Mtk3Ny24ZbdF5TumiBPNECr2Vmt/amhkwEHefebMAaYr7AzHLVLoBhv4mwjPBW+AUzJQGwT6pQiaLXJXL4msxsvM8/tjM1wlWgkgVtvpaaOHQTgA0ho3cITwo7uOuTIBOge+yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QkGxyLC4; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741301930; x=1772837930;
  h=date:from:to:cc:subject:message-id;
  bh=fOwK2BPFlcy491EdhaRDwoGKr5VXHWkldsdkOh5pzeQ=;
  b=QkGxyLC4i6qZSxRJlDeMzSMIM6xmHTjfTDPvXbSUAUdyp3Ay2u56+c4b
   b3fDW3KXqmfV5nD6hkzYwPAiD6cJyjPgFy8lrGJ2vhQqLAHsksdwzO3d6
   p6rYBarIrhu1aC71An3gnT15+As+Dmul9ASlHga93hicL2wJpL/1bI7Yn
   ClCcXTUJxNN88Jx8pzsbZQa3QxWPNnHb7kZl6H3CTRrLSJUGV4K4MxSZ4
   s4J09wmwO8Rrj1BZHG6ZcdKipWCOWoyWKlDmNthP06soaMSNPGKzQIlhk
   J8ZxTUjM1P6lDKDmcAQaNvveE16FxUR31zEFiMH4/lwl5EhwdMPxGgOu3
   A==;
X-CSE-ConnectionGUID: xx/fJ6EKTGys0xOak7AxyA==
X-CSE-MsgGUID: IZAZTcTxThmRYSkE9uPUAA==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="64782688"
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; 
   d="scan'208";a="64782688"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 14:58:50 -0800
X-CSE-ConnectionGUID: uH5lzDt5S+ifIVcNmYecRg==
X-CSE-MsgGUID: hQmo1FdRSUeejGiljmenyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="156376102"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 06 Mar 2025 14:58:48 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tqKAv-000NjH-2c;
	Thu, 06 Mar 2025 22:58:45 +0000
Date: Fri, 07 Mar 2025 06:57:48 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/merge] BUILD SUCCESS
 f06709e6f17f38b07164887f58b7a29e3b4e88c1
Message-ID: <202503070643.tehRtNsb-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/merge
branch HEAD: f06709e6f17f38b07164887f58b7a29e3b4e88c1  Merge branch 'x86/mm' into x86/merge, to resolve conflict

elapsed time: 1448m

configs tested: 207
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-21
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    clang-18
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-18
arc                   randconfig-001-20250306    gcc-13.2.0
arc                   randconfig-001-20250307    clang-15
arc                   randconfig-002-20250306    gcc-13.2.0
arc                   randconfig-002-20250307    clang-15
arc                    vdk_hs38_smp_defconfig    gcc-14.2.0
arm                              allmodconfig    clang-18
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-18
arm                          exynos_defconfig    gcc-14.2.0
arm                        mvebu_v7_defconfig    gcc-14.2.0
arm                   randconfig-001-20250306    gcc-14.2.0
arm                   randconfig-001-20250307    clang-15
arm                   randconfig-002-20250306    gcc-14.2.0
arm                   randconfig-002-20250307    clang-15
arm                   randconfig-003-20250306    gcc-14.2.0
arm                   randconfig-003-20250307    clang-15
arm                   randconfig-004-20250306    clang-18
arm                   randconfig-004-20250307    clang-15
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250306    gcc-14.2.0
arm64                 randconfig-001-20250307    clang-15
arm64                 randconfig-002-20250306    gcc-14.2.0
arm64                 randconfig-002-20250307    clang-15
arm64                 randconfig-003-20250306    gcc-14.2.0
arm64                 randconfig-003-20250307    clang-15
arm64                 randconfig-004-20250306    gcc-14.2.0
arm64                 randconfig-004-20250307    clang-15
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250306    gcc-14.2.0
csky                  randconfig-001-20250307    gcc-14.2.0
csky                  randconfig-002-20250306    gcc-14.2.0
csky                  randconfig-002-20250307    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-18
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250306    clang-21
hexagon               randconfig-001-20250307    gcc-14.2.0
hexagon               randconfig-002-20250306    clang-19
hexagon               randconfig-002-20250307    gcc-14.2.0
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                             allyesconfig    clang-19
i386        buildonly-randconfig-001-20250306    clang-19
i386        buildonly-randconfig-001-20250307    clang-19
i386        buildonly-randconfig-002-20250306    clang-19
i386        buildonly-randconfig-002-20250307    clang-19
i386        buildonly-randconfig-003-20250306    clang-19
i386        buildonly-randconfig-003-20250307    clang-19
i386        buildonly-randconfig-004-20250306    gcc-12
i386        buildonly-randconfig-004-20250307    clang-19
i386        buildonly-randconfig-005-20250306    gcc-12
i386        buildonly-randconfig-005-20250307    clang-19
i386        buildonly-randconfig-006-20250306    clang-19
i386        buildonly-randconfig-006-20250307    clang-19
i386                                defconfig    clang-19
i386                  randconfig-001-20250307    clang-19
i386                  randconfig-002-20250307    clang-19
i386                  randconfig-003-20250307    clang-19
i386                  randconfig-004-20250307    clang-19
i386                  randconfig-005-20250307    clang-19
i386                  randconfig-006-20250307    clang-19
i386                  randconfig-007-20250307    clang-19
i386                  randconfig-011-20250307    gcc-11
i386                  randconfig-012-20250307    gcc-11
i386                  randconfig-013-20250307    gcc-11
i386                  randconfig-014-20250307    gcc-11
i386                  randconfig-015-20250307    gcc-11
i386                  randconfig-016-20250307    gcc-11
i386                  randconfig-017-20250307    gcc-11
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250306    gcc-14.2.0
loongarch             randconfig-001-20250307    gcc-14.2.0
loongarch             randconfig-002-20250306    gcc-14.2.0
loongarch             randconfig-002-20250307    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                          amiga_defconfig    gcc-14.2.0
m68k                        m5407c3_defconfig    gcc-14.2.0
microblaze                       alldefconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                           ip32_defconfig    gcc-14.2.0
nios2                         10m50_defconfig    gcc-14.2.0
nios2                            alldefconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250306    gcc-14.2.0
nios2                 randconfig-001-20250307    gcc-14.2.0
nios2                 randconfig-002-20250306    gcc-14.2.0
nios2                 randconfig-002-20250307    gcc-14.2.0
openrisc                          allnoconfig    clang-15
openrisc                            defconfig    gcc-12
parisc                            allnoconfig    clang-15
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250306    gcc-14.2.0
parisc                randconfig-001-20250307    gcc-14.2.0
parisc                randconfig-002-20250306    gcc-14.2.0
parisc                randconfig-002-20250307    gcc-14.2.0
powerpc                           allnoconfig    clang-15
powerpc                        icon_defconfig    gcc-14.2.0
powerpc                 linkstation_defconfig    gcc-14.2.0
powerpc                      pcm030_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250306    clang-21
powerpc               randconfig-001-20250307    gcc-14.2.0
powerpc               randconfig-002-20250306    clang-18
powerpc               randconfig-002-20250307    gcc-14.2.0
powerpc               randconfig-003-20250306    gcc-14.2.0
powerpc               randconfig-003-20250307    gcc-14.2.0
powerpc64             randconfig-001-20250306    clang-18
powerpc64             randconfig-001-20250307    gcc-14.2.0
powerpc64             randconfig-002-20250306    clang-21
powerpc64             randconfig-002-20250307    gcc-14.2.0
powerpc64             randconfig-003-20250306    clang-18
powerpc64             randconfig-003-20250307    gcc-14.2.0
riscv                             allnoconfig    clang-15
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250306    clang-18
riscv                 randconfig-001-20250307    gcc-14.2.0
riscv                 randconfig-002-20250306    gcc-14.2.0
riscv                 randconfig-002-20250307    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250306    gcc-14.2.0
s390                  randconfig-001-20250307    gcc-14.2.0
s390                  randconfig-002-20250306    clang-19
s390                  randconfig-002-20250307    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250306    gcc-14.2.0
sh                    randconfig-001-20250307    gcc-14.2.0
sh                    randconfig-002-20250306    gcc-14.2.0
sh                    randconfig-002-20250307    gcc-14.2.0
sh                          sdk7780_defconfig    gcc-14.2.0
sh                          sdk7786_defconfig    gcc-14.2.0
sh                              ul2_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250306    gcc-14.2.0
sparc                 randconfig-001-20250307    gcc-14.2.0
sparc                 randconfig-002-20250306    gcc-14.2.0
sparc                 randconfig-002-20250307    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250306    gcc-14.2.0
sparc64               randconfig-001-20250307    gcc-14.2.0
sparc64               randconfig-002-20250306    gcc-14.2.0
sparc64               randconfig-002-20250307    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-15
um                               allyesconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250306    gcc-12
um                    randconfig-001-20250307    gcc-14.2.0
um                    randconfig-002-20250306    clang-16
um                    randconfig-002-20250307    gcc-14.2.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250306    gcc-11
x86_64      buildonly-randconfig-001-20250307    clang-19
x86_64      buildonly-randconfig-002-20250306    clang-19
x86_64      buildonly-randconfig-002-20250307    clang-19
x86_64      buildonly-randconfig-003-20250306    clang-19
x86_64      buildonly-randconfig-003-20250307    clang-19
x86_64      buildonly-randconfig-004-20250306    clang-19
x86_64      buildonly-randconfig-004-20250307    clang-19
x86_64      buildonly-randconfig-005-20250306    clang-19
x86_64      buildonly-randconfig-005-20250307    clang-19
x86_64      buildonly-randconfig-006-20250306    gcc-12
x86_64      buildonly-randconfig-006-20250307    clang-19
x86_64                              defconfig    clang-19
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20250307    clang-19
x86_64                randconfig-002-20250307    clang-19
x86_64                randconfig-003-20250307    clang-19
x86_64                randconfig-004-20250307    clang-19
x86_64                randconfig-005-20250307    clang-19
x86_64                randconfig-006-20250307    clang-19
x86_64                randconfig-007-20250307    clang-19
x86_64                randconfig-008-20250307    clang-19
x86_64                randconfig-071-20250307    clang-19
x86_64                randconfig-072-20250307    clang-19
x86_64                randconfig-073-20250307    clang-19
x86_64                randconfig-074-20250307    clang-19
x86_64                randconfig-075-20250307    clang-19
x86_64                randconfig-076-20250307    clang-19
x86_64                randconfig-077-20250307    clang-19
x86_64                randconfig-078-20250307    clang-19
x86_64                               rhel-9.4    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                          iss_defconfig    gcc-14.2.0
xtensa                randconfig-001-20250306    gcc-14.2.0
xtensa                randconfig-001-20250307    gcc-14.2.0
xtensa                randconfig-002-20250306    gcc-14.2.0
xtensa                randconfig-002-20250307    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

