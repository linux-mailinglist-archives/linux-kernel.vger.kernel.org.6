Return-Path: <linux-kernel+bounces-447105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A219F2D5E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 10:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 871B77A2D4B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 09:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09DAB20124F;
	Mon, 16 Dec 2024 09:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RpqwxgAp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7037F1C54AA
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 09:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734342712; cv=none; b=Vk7UNxAuzXI0tBeg/LJVrUWvvkQuRRrKEBwZwBP152c9v1pn0R8JRVnpmjZd5BkdVwrr5bY20sAyL1IQpu/CwmYQ4DTXDFjnMmGkmLer41jmhw+R5WLdU1W7gbSGx451fWMI8BTkbdmMRYbk/zJgmYQPY2m4sOT09XmUcRvN/kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734342712; c=relaxed/simple;
	bh=6/2T2qYndEMTbKRRJPA540mFRQUog+pHIBxGMSjnADQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=HVI3r7SszhDp6P4i8KQ8hyoW87vJw8XtPMWhWy/pNh/nvMEbzyT6ycMbS2KCVdJDS3UTIbie1/To1f3ZMgnzglLq9QKD0IGDlAEIhd3TZgnrnpEEMr0sO0eSSF9bUtynoBEZTVsl38xArrU7VYdabdNu03pH0DXdZDIw9tSj98k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RpqwxgAp; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734342710; x=1765878710;
  h=date:from:to:cc:subject:message-id;
  bh=6/2T2qYndEMTbKRRJPA540mFRQUog+pHIBxGMSjnADQ=;
  b=RpqwxgApGWZGgwFfDbS6O+7b8fX5guMjZTrE+LRxIKIsYZJO56Kxvufx
   LxcjuMkW+LJn6CTGlifnDu8z75Iz356m1M+qg4XG2Xl6ImfY09IP3/fTU
   oX61p28R6kP9A9n25hXq8ZTIKbGT/zhRXMEBAQUkz7i8E7LA6aFEcnNTP
   dbquW6ujLbvMstJ3zZ4BiEFlJHAKfFriacuVhBi36+OilA8qxVzdJ6PpO
   29xBfNBnplIc+9lYbHAxFnOoOMgESTOEYVIGao3e41+GqmAcRl/82sGls
   MkMdglynijlysYBEjYsqGO7enUcDNaNGEtgUbQkZyRkRRaUcZPu0P35pA
   g==;
X-CSE-ConnectionGUID: EB6ji3KqRPy5KMAkkqvR1w==
X-CSE-MsgGUID: 5Ex009i1RFS+EM1FAl9Xfg==
X-IronPort-AV: E=McAfee;i="6700,10204,11287"; a="34042500"
X-IronPort-AV: E=Sophos;i="6.12,238,1728975600"; 
   d="scan'208";a="34042500"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 01:51:50 -0800
X-CSE-ConnectionGUID: 5DPdWHJkTemanh+k5wpaIg==
X-CSE-MsgGUID: rS3PBCp4QiS4H0MjTTf9LQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,238,1728975600"; 
   d="scan'208";a="102011372"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 16 Dec 2024 01:51:49 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tN7lS-000E8u-2h;
	Mon, 16 Dec 2024 09:51:46 +0000
Date: Mon, 16 Dec 2024 17:50:52 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 83c86b33de89cacd19efdb33f1ecd82b422b988a
Message-ID: <202412161746.B6uZ1qe4-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 83c86b33de89cacd19efdb33f1ecd82b422b988a  Merge branch into tip/master: 'x86/tdx'

elapsed time: 1145m

configs tested: 118
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20241215    gcc-13.2.0
arc                   randconfig-002-20241215    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                   randconfig-001-20241215    clang-20
arm                   randconfig-002-20241215    clang-16
arm                   randconfig-003-20241215    gcc-14.2.0
arm                   randconfig-004-20241215    clang-20
arm                        realview_defconfig    clang-19
arm                       spear13xx_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20241215    gcc-14.2.0
arm64                 randconfig-002-20241215    gcc-14.2.0
arm64                 randconfig-003-20241215    clang-20
arm64                 randconfig-004-20241215    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20241216    gcc-14.2.0
csky                  randconfig-002-20241216    gcc-14.2.0
hexagon                          alldefconfig    clang-15
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon               randconfig-001-20241216    clang-20
hexagon               randconfig-002-20241216    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241215    gcc-12
i386        buildonly-randconfig-002-20241215    gcc-12
i386        buildonly-randconfig-003-20241215    gcc-12
i386        buildonly-randconfig-004-20241215    gcc-12
i386        buildonly-randconfig-005-20241215    gcc-12
i386        buildonly-randconfig-006-20241215    clang-19
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20241216    gcc-14.2.0
loongarch             randconfig-002-20241216    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                          atari_defconfig    gcc-14.2.0
m68k                       m5475evb_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          eyeq6_defconfig    clang-20
mips                            gpr_defconfig    clang-20
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20241216    gcc-14.2.0
nios2                 randconfig-002-20241216    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                    or1ksim_defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                generic-64bit_defconfig    gcc-14.2.0
parisc                randconfig-001-20241216    gcc-14.2.0
parisc                randconfig-002-20241216    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                          g5_defconfig    gcc-14.2.0
powerpc                 mpc837x_rdb_defconfig    gcc-14.2.0
powerpc               randconfig-001-20241216    clang-20
powerpc               randconfig-002-20241216    clang-20
powerpc               randconfig-003-20241216    gcc-14.2.0
powerpc64             randconfig-001-20241216    clang-20
powerpc64             randconfig-002-20241216    clang-15
powerpc64             randconfig-003-20241216    gcc-14.2.0
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv             nommu_k210_sdcard_defconfig    gcc-14.2.0
riscv                    nommu_virt_defconfig    clang-20
riscv                 randconfig-001-20241215    clang-16
riscv                 randconfig-002-20241215    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20241215    gcc-14.2.0
s390                  randconfig-002-20241215    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20241215    gcc-14.2.0
sh                    randconfig-002-20241215    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20241215    gcc-14.2.0
sparc                 randconfig-002-20241215    gcc-14.2.0
sparc64               randconfig-001-20241215    gcc-14.2.0
sparc64               randconfig-002-20241215    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                    randconfig-001-20241215    gcc-12
um                    randconfig-002-20241215    clang-18
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241215    gcc-12
x86_64      buildonly-randconfig-002-20241215    clang-19
x86_64      buildonly-randconfig-003-20241215    clang-19
x86_64      buildonly-randconfig-004-20241215    gcc-12
x86_64      buildonly-randconfig-005-20241215    clang-19
x86_64      buildonly-randconfig-006-20241215    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                  cadence_csp_defconfig    gcc-14.2.0
xtensa                randconfig-001-20241215    gcc-14.2.0
xtensa                randconfig-002-20241215    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

