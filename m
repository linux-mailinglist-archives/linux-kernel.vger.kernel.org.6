Return-Path: <linux-kernel+bounces-204570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C878FF11D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 17:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B57E7B3180D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77E2197A81;
	Thu,  6 Jun 2024 15:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OG/jdByn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9640160883
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 15:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717687476; cv=none; b=BAYawR2P4wRB0yUZQOSJpclfUZKqHRRTuIIRxEWHm1RiAttQ/UPL56D8Xw8dXHRLWaDx6NUhrm9OTiR8s+rUMR7a5yQhAqwB+iSl44lF2+No/9NDrmLrpu09/m+RoxxmAXCkC2Y+dM20iWhXLMJ7hjcVkAmeaAN8hruiooE1vtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717687476; c=relaxed/simple;
	bh=kh1ZRq7+mQwAXyeWRTRpXkFxDV3IdN1rrcsYL+c6s/o=;
	h=Date:From:To:Cc:Subject:Message-ID; b=LWfsU26/XSu7mPiN9xtiaWX5IIB8sNuZ/R5CV/Ra7Cvuw/Z20V1e34EZy60Qw0EmZ84xyDYF9wfmkZ9BU+LhOdiGrd6tnXHi+LOBusJF6MLWr18VQAfh9R2FdIuC+6CcmQWuic2k91oqKc0hf74uZD8S+69EM332EMKi0ic708U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OG/jdByn; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717687475; x=1749223475;
  h=date:from:to:cc:subject:message-id;
  bh=kh1ZRq7+mQwAXyeWRTRpXkFxDV3IdN1rrcsYL+c6s/o=;
  b=OG/jdBynMtvcx138aWBmDNI5Bi2q9BuEfb6J/BJcq1NJvqSHAwX4EhVy
   oiCGnkk8G2NkyMm0FOyHW9LIOaibdyeLMz5TEl2LhwWaNzVhIiY+IEI+s
   pKkduN/A8/DO+IRZTdKyue/vSgES6ZSWp0+nzMg6CZy5BwUWt4SPGgsNP
   8GSUQuh9CqNk2VS7wZfFjO8kBj10OImA+F9KkW9MeS6fPH1tuqhLVwa2V
   cnhZlV0UjNDG43GHYQSd+EVyNaFcw6ddEWX1iVwZ7jiHzp+zMjb9K8Dl8
   FGICirSHoZx6urZAqTeJC0w3/VaGDYhfV4PNtdThUWu1rpan2OA+BR4HC
   w==;
X-CSE-ConnectionGUID: o6CZsh9aQsWSIqqU7dEqvA==
X-CSE-MsgGUID: deVBfENiRNC/HA1YYZjLfA==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="14587627"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="14587627"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 08:24:34 -0700
X-CSE-ConnectionGUID: Xrl8b00RSMmDwP+M+CculQ==
X-CSE-MsgGUID: p56ckk1ZT8Kcux3XPGAeTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="69156412"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 06 Jun 2024 08:24:33 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sFEyd-0003HW-0H;
	Thu, 06 Jun 2024 15:24:31 +0000
Date: Thu, 06 Jun 2024 23:23:36 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD SUCCESS
 f90cc919f9e5cbfcd0b952290c57ef1317f4e91e
Message-ID: <202406062333.SikrtcyW-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
branch HEAD: f90cc919f9e5cbfcd0b952290c57ef1317f4e91e  sched/balance: Skip unnecessary updates to idle load balancer's flags

elapsed time: 1459m

configs tested: 134
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240606   gcc  
arc                   randconfig-002-20240606   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                                 defconfig   clang
arm                   randconfig-001-20240606   clang
arm                   randconfig-002-20240606   clang
arm                   randconfig-003-20240606   clang
arm                   randconfig-004-20240606   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240606   clang
arm64                 randconfig-002-20240606   gcc  
arm64                 randconfig-003-20240606   clang
arm64                 randconfig-004-20240606   clang
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240606   gcc  
csky                  randconfig-002-20240606   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240606   clang
hexagon               randconfig-002-20240606   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240606   clang
i386         buildonly-randconfig-002-20240606   clang
i386         buildonly-randconfig-003-20240606   clang
i386         buildonly-randconfig-004-20240606   gcc  
i386         buildonly-randconfig-005-20240606   clang
i386         buildonly-randconfig-006-20240606   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240606   clang
i386                  randconfig-002-20240606   clang
i386                  randconfig-003-20240606   clang
i386                  randconfig-004-20240606   clang
i386                  randconfig-005-20240606   clang
i386                  randconfig-006-20240606   clang
i386                  randconfig-011-20240606   clang
i386                  randconfig-012-20240606   gcc  
i386                  randconfig-013-20240606   gcc  
i386                  randconfig-014-20240606   gcc  
i386                  randconfig-015-20240606   gcc  
i386                  randconfig-016-20240606   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240606   gcc  
loongarch             randconfig-002-20240606   gcc  
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
nios2                 randconfig-001-20240606   gcc  
nios2                 randconfig-002-20240606   gcc  
openrisc                          allnoconfig   gcc  
openrisc                            defconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240606   gcc  
parisc                randconfig-002-20240606   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc               randconfig-001-20240606   gcc  
powerpc               randconfig-002-20240606   gcc  
powerpc               randconfig-003-20240606   gcc  
powerpc64             randconfig-001-20240606   clang
powerpc64             randconfig-002-20240606   clang
powerpc64             randconfig-003-20240606   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   clang
riscv                 randconfig-001-20240606   gcc  
riscv                 randconfig-002-20240606   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240606   gcc  
s390                  randconfig-002-20240606   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240606   gcc  
sh                    randconfig-002-20240606   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240606   gcc  
sparc64               randconfig-002-20240606   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240606   clang
um                    randconfig-002-20240606   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240606   gcc  
x86_64       buildonly-randconfig-002-20240606   clang
x86_64       buildonly-randconfig-003-20240606   gcc  
x86_64       buildonly-randconfig-004-20240606   gcc  
x86_64       buildonly-randconfig-005-20240606   gcc  
x86_64       buildonly-randconfig-006-20240606   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240606   gcc  
xtensa                randconfig-002-20240606   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

