Return-Path: <linux-kernel+bounces-254576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 939F89334DE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 02:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7A08B21023
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 00:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73C2138C;
	Wed, 17 Jul 2024 00:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="apfMvCoF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2E2EC7
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 00:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721177973; cv=none; b=o+GXEaxml4QpvBtPuw3GzdlCQKxGxxm9/XmdUqrIi/F7gUTyFAFBWd7JVdS2PxTrk3O+yg/BzuuuV3EUvL8RIW0qt2xs3qebSKoRfvflweOv9+JtahIDuoRV2q/9wHFRYxKxo+o79Q9aKpjqFSvv/kSIPEIdWfiGrWaI/FoD7jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721177973; c=relaxed/simple;
	bh=gwiikU/ZLrn1xm3wP1cMkA3ESA6Gqb80evlq4kOUlD4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=nm7wnKaZpNLbAhp9Kc+Zx9zVUJRkLN8K6Vch5OqA27WxDDs8mAQuckXxSv5FfU0wyjmcrUq7MzrKMOejMopcWXNWKy9FqVoxo44Lisy1OzmxQR3fVBI3eBdMLcGDWPFBTJI1xGZ/5UHCNVOWXxEnRxAERuEO4H0ZRoILYUkHsCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=apfMvCoF; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721177972; x=1752713972;
  h=date:from:to:cc:subject:message-id;
  bh=gwiikU/ZLrn1xm3wP1cMkA3ESA6Gqb80evlq4kOUlD4=;
  b=apfMvCoFPeL6zWlP3uKsOl6nRLqmwWxQBIBp6d6dvHIy+oRmDWuZkGIF
   4OVwUsNIc5duIOQUjjE9Ea9rmo6P8mZydwujMxJVzvdMpLl6HAaD+iL6J
   jvLb8rBLnwfTuqUGPHuFHILWf3AO7MfzI2lK8kwoMNqmICdggn58edmsM
   k44j7iw1VVSs/2WUa2fv3465yZTM/eWQZ68+D4p0E25lGZDSuAsElDUT0
   26GbzgbuEEYt4heLP3t9dYXA5XkAodCe2KJG2wzQgFKH7PXx8Uf4VIhyt
   kEN0Occ698XEWMIRYtuUFD9bgmLbB5cG08OQtSI15VVNclLzZPGV8dsmE
   A==;
X-CSE-ConnectionGUID: Fb0/Za2MQHGOJIgJzHmJwA==
X-CSE-MsgGUID: UeJomvhOTQ+U9vpiwCApKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11135"; a="22420909"
X-IronPort-AV: E=Sophos;i="6.09,213,1716274800"; 
   d="scan'208";a="22420909"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2024 17:59:32 -0700
X-CSE-ConnectionGUID: kjIyU4vyTDei+Ut0LCPUqw==
X-CSE-MsgGUID: NIH2SHq8RQKWVWeNM11YXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,213,1716274800"; 
   d="scan'208";a="54414488"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 16 Jul 2024 17:59:30 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sTt0y-000fpH-05;
	Wed, 17 Jul 2024 00:59:28 +0000
Date: Wed, 17 Jul 2024 08:59:23 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 061ac7c2cba03ea918e083518ebb0577f9a01f82
Message-ID: <202407170821.NGXyHhlZ-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 061ac7c2cba03ea918e083518ebb0577f9a01f82  Merge branch into tip/master: 'x86/percpu'

elapsed time: 863m

configs tested: 142
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                   randconfig-001-20240717   gcc-13.2.0
arc                   randconfig-002-20240717   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-19
arm                              allyesconfig   gcc-14.1.0
arm                   randconfig-001-20240717   gcc-14.1.0
arm                   randconfig-002-20240717   gcc-14.1.0
arm                   randconfig-003-20240717   gcc-14.1.0
arm                   randconfig-004-20240717   clang-19
arm64                            allmodconfig   clang-19
arm64                             allnoconfig   gcc-14.1.0
arm64                 randconfig-001-20240717   gcc-14.1.0
arm64                 randconfig-002-20240717   clang-19
arm64                 randconfig-003-20240717   clang-16
arm64                 randconfig-004-20240717   clang-19
csky                              allnoconfig   gcc-14.1.0
csky                  randconfig-001-20240717   gcc-14.1.0
csky                  randconfig-002-20240717   gcc-14.1.0
hexagon                          allmodconfig   clang-19
hexagon                           allnoconfig   clang-19
hexagon                          allyesconfig   clang-19
hexagon               randconfig-001-20240717   clang-19
hexagon               randconfig-002-20240717   clang-19
i386                             allmodconfig   gcc-13
i386                              allnoconfig   gcc-13
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240716   clang-18
i386         buildonly-randconfig-002-20240716   clang-18
i386         buildonly-randconfig-003-20240716   clang-18
i386         buildonly-randconfig-004-20240716   clang-18
i386         buildonly-randconfig-005-20240716   clang-18
i386         buildonly-randconfig-006-20240716   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240716   clang-18
i386                  randconfig-002-20240716   clang-18
i386                  randconfig-003-20240716   gcc-9
i386                  randconfig-004-20240716   gcc-7
i386                  randconfig-005-20240716   clang-18
i386                  randconfig-006-20240716   gcc-9
i386                  randconfig-011-20240716   gcc-8
i386                  randconfig-012-20240716   clang-18
i386                  randconfig-013-20240716   gcc-8
i386                  randconfig-014-20240716   clang-18
i386                  randconfig-015-20240716   clang-18
i386                  randconfig-016-20240716   gcc-10
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch             randconfig-001-20240717   gcc-14.1.0
loongarch             randconfig-002-20240717   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-14.1.0
nios2                 randconfig-001-20240717   gcc-14.1.0
nios2                 randconfig-002-20240717   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240717   gcc-14.1.0
parisc                randconfig-002-20240717   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-19
powerpc               randconfig-001-20240717   clang-19
powerpc               randconfig-002-20240717   gcc-14.1.0
powerpc               randconfig-003-20240717   clang-19
powerpc64             randconfig-001-20240717   gcc-14.1.0
powerpc64             randconfig-002-20240717   gcc-14.1.0
powerpc64             randconfig-003-20240717   gcc-14.1.0
riscv                            allmodconfig   clang-19
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-19
riscv                               defconfig   clang-19
riscv                 randconfig-001-20240717   clang-19
riscv                 randconfig-002-20240717   clang-17
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   clang-19
s390                  randconfig-001-20240717   gcc-14.1.0
s390                  randconfig-002-20240717   gcc-14.1.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                    randconfig-001-20240717   gcc-14.1.0
sh                    randconfig-002-20240717   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240717   gcc-14.1.0
sparc64               randconfig-002-20240717   gcc-14.1.0
um                               allmodconfig   clang-19
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-13
um                                  defconfig   clang-19
um                             i386_defconfig   gcc-13
um                    randconfig-001-20240717   gcc-8
um                    randconfig-002-20240717   gcc-13
um                           x86_64_defconfig   clang-15
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240717   gcc-13
x86_64       buildonly-randconfig-002-20240717   gcc-13
x86_64       buildonly-randconfig-003-20240717   gcc-13
x86_64       buildonly-randconfig-004-20240717   clang-18
x86_64       buildonly-randconfig-005-20240717   clang-18
x86_64       buildonly-randconfig-006-20240717   gcc-13
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240717   gcc-7
x86_64                randconfig-002-20240717   gcc-9
x86_64                randconfig-003-20240717   clang-18
x86_64                randconfig-004-20240717   gcc-9
x86_64                randconfig-005-20240717   clang-18
x86_64                randconfig-006-20240717   gcc-11
x86_64                randconfig-011-20240717   gcc-8
x86_64                randconfig-012-20240717   clang-18
x86_64                randconfig-013-20240717   gcc-12
x86_64                randconfig-014-20240717   gcc-10
x86_64                randconfig-015-20240717   clang-18
x86_64                randconfig-016-20240717   clang-18
x86_64                randconfig-071-20240717   gcc-12
x86_64                randconfig-072-20240717   clang-18
x86_64                randconfig-073-20240717   gcc-10
x86_64                randconfig-074-20240717   gcc-13
x86_64                randconfig-075-20240717   gcc-13
x86_64                randconfig-076-20240717   gcc-12
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-002-20240717   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

