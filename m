Return-Path: <linux-kernel+bounces-197798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC0B8D6F4A
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 12:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25BDEB22B97
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 10:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E72B14EC41;
	Sat,  1 Jun 2024 10:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m0cfFzgC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64256F2EB
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 10:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717236619; cv=none; b=Lge/T4SvJuIaMU/o8F9LUCe2NCWA52nl77hlivL3Ceb+yVJfVEvAXrGoQEiT/84/QjtG3n6eUiEVoeioamSYcjdnpnoHbSdOoQwTyo8HnP8NoVoHd6etl7suhr0Ayfmrhf6lGsYHUK+onPKND9Q78PyagqtHRYfpYJ04l9z8rgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717236619; c=relaxed/simple;
	bh=L2Fb0cA6egvQk7LSOeuXnq+6wOfz3vlPMZBefyOFWoU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=bpmTsf9kEcrOYC5dl3KW1Qq8+Rt/IyEMRsC9UkebeboXmiG4QrJWH595leVgfbYJ+zjw7KxgKfiASGwM9giCwUH4g7VP/VrXbINU5mgIS4+smsLbh8wLWMnD6maWEVSVEzZ3CDd1g3Ujz//ey7iPS/ZWintwmANF4Tm5LDeOTX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m0cfFzgC; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717236617; x=1748772617;
  h=date:from:to:cc:subject:message-id;
  bh=L2Fb0cA6egvQk7LSOeuXnq+6wOfz3vlPMZBefyOFWoU=;
  b=m0cfFzgCKaVaFaz7DfeAaX1Ch011HLbdJZwaiE0jbK0m87Zn5XupWJji
   QAOuh/9V52MoNhTPT5fIMo7Jl6cU31mwE1mT9mXjHPA2jWm27BrZQH5kT
   vaEWh+qd2b8m+CBJ5oKdeWRsDo/Q826KNL7cdFyO83bmu6dr3Z8cMcXp0
   pdv3huUG5tOeU760gxKscNCjf7Y7NxjIiV1dO+64wz+9Tnf013uLDO4UK
   tHnM3FIsMZy57GXgIhDtacTYZXkd0Ny6wlQUFQQu2XLP6grF6h4j5UgPj
   0icQJxIkjV1yZSGCOadZmgDptZgC+oBo1UvpTHrno34aLnfEHR//pGOpr
   w==;
X-CSE-ConnectionGUID: aU1dSee4QPOVORFvcRYhTQ==
X-CSE-MsgGUID: JNYzyoIQTOaDZQmyWCjVTA==
X-IronPort-AV: E=McAfee;i="6600,9927,11089"; a="17610817"
X-IronPort-AV: E=Sophos;i="6.08,207,1712646000"; 
   d="scan'208";a="17610817"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2024 03:10:16 -0700
X-CSE-ConnectionGUID: GtDHBXNmSceh5tcEEb0PaQ==
X-CSE-MsgGUID: U3R2FK/fQ4SAdNIIGLl0ZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,207,1712646000"; 
   d="scan'208";a="36317969"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 01 Jun 2024 03:10:15 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sDLgi-000IgV-2e;
	Sat, 01 Jun 2024 10:10:12 +0000
Date: Sat, 01 Jun 2024 18:09:43 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 0c2f6d04619ec2b53ad4b0b591eafc9389786e86
Message-ID: <202406011841.3Agkafsx-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 0c2f6d04619ec2b53ad4b0b591eafc9389786e86  x86/topology/intel: Unlock CPUID before evaluating anything

elapsed time: 891m

configs tested: 96
configs skipped: 135

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240601   gcc  
arc                   randconfig-002-20240601   gcc  
arm                   randconfig-003-20240601   gcc  
arm                   randconfig-004-20240601   gcc  
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240601   gcc  
arm64                 randconfig-004-20240601   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240601   gcc  
csky                  randconfig-002-20240601   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240601   clang
i386         buildonly-randconfig-002-20240601   gcc  
i386         buildonly-randconfig-003-20240601   gcc  
i386         buildonly-randconfig-004-20240601   gcc  
i386         buildonly-randconfig-005-20240601   gcc  
i386         buildonly-randconfig-006-20240601   clang
i386                                defconfig   clang
i386                  randconfig-001-20240601   clang
i386                  randconfig-002-20240601   gcc  
i386                  randconfig-003-20240601   clang
i386                  randconfig-004-20240601   gcc  
i386                  randconfig-005-20240601   clang
i386                  randconfig-006-20240601   gcc  
i386                  randconfig-011-20240601   gcc  
i386                  randconfig-012-20240601   gcc  
i386                  randconfig-013-20240601   gcc  
i386                  randconfig-014-20240601   gcc  
i386                  randconfig-015-20240601   clang
i386                  randconfig-016-20240601   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240601   gcc  
loongarch             randconfig-002-20240601   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240601   gcc  
nios2                 randconfig-002-20240601   gcc  
parisc                randconfig-001-20240601   gcc  
parisc                randconfig-002-20240601   gcc  
powerpc               randconfig-001-20240601   gcc  
powerpc               randconfig-002-20240601   gcc  
powerpc               randconfig-003-20240601   gcc  
powerpc64             randconfig-003-20240601   gcc  
riscv                 randconfig-002-20240601   gcc  
s390                  randconfig-001-20240601   gcc  
s390                  randconfig-002-20240601   gcc  
sh                    randconfig-001-20240601   gcc  
sh                    randconfig-002-20240601   gcc  
sparc64               randconfig-001-20240601   gcc  
sparc64               randconfig-002-20240601   gcc  
um                               allyesconfig   gcc  
um                    randconfig-001-20240601   gcc  
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240601   clang
x86_64       buildonly-randconfig-002-20240601   clang
x86_64       buildonly-randconfig-004-20240601   gcc  
x86_64       buildonly-randconfig-005-20240601   clang
x86_64       buildonly-randconfig-006-20240601   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-002-20240601   clang
x86_64                randconfig-003-20240601   clang
x86_64                randconfig-004-20240601   clang
x86_64                randconfig-006-20240601   clang
x86_64                randconfig-011-20240601   clang
x86_64                randconfig-012-20240601   clang
x86_64                randconfig-013-20240601   clang
x86_64                randconfig-071-20240601   clang
x86_64                randconfig-073-20240601   clang
x86_64                randconfig-075-20240601   clang
x86_64                          rhel-8.3-rust   clang
xtensa                randconfig-001-20240601   gcc  
xtensa                randconfig-002-20240601   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

