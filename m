Return-Path: <linux-kernel+bounces-205013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 267878FF62A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 22:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E9071C2275F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 20:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E632413A89B;
	Thu,  6 Jun 2024 20:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nce+23rA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D39112AAC9
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 20:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717707372; cv=none; b=l6hTiIOU0P29LSfyyDbCsnEma2tXttWp4xHZ9ZIQi2GLr+xGztlBiVkJWzxnfNYsRlSQhhZd4IuAq45bLcu9jGRdt+LmUUb9Itsz2ooXXDgHiT/sf+0vcwO4VirKAmeJy7x3bF5ZzJFuHzdSdx0HqsPWRjCG6xLMpN92OnKmbbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717707372; c=relaxed/simple;
	bh=4ow+aBJaAcuMTW5flp5fXja6q1Fflsv4kDwUcEkG9MQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=RTetQmKXrfF612huIGQnC91GYEx282mAJKIvjnWkgUdZa9mAjaE6mZgkvzjnxl2l3+MqeCx5t8E7FPWajR2MCseaSpOgYHtCscT+i1x/1PaADqIvl3N44mGltDMFEZxjepBp4fXWguibxyAPYfssccJZKzM3H3+SU+CnHrSGpgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nce+23rA; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717707370; x=1749243370;
  h=date:from:to:cc:subject:message-id;
  bh=4ow+aBJaAcuMTW5flp5fXja6q1Fflsv4kDwUcEkG9MQ=;
  b=nce+23rAZQcCVQnaDGA316dlXnQxBDgHkkSg/NkJmrDqWW9moHEDZ4ak
   /YYmA9Y2oa5V+um18BmFGOxfE0/ZI00mG3JqT+r0piXbfARcgcHH+CYT6
   7IhHhXTBO+ZsWl8YIOOTfLOAUEVxWUMX5/6OEgLMdpdi1R9ttkQuz/YTF
   hQmgFdGrmL+IXdc6wgFHcRMrjhF24WMKSAhcO53KFrwMVDaiW363NU2hc
   vBVMdLYeVKUF1Ay9xnWJ4Wy5yi+uURmTPzBhqR+FXHc18A+EP2dCwwuqg
   brDYtQuxZdTrXYcebZyltBHCcByQU+4lArqaEWyQ3sfD0dNXFSaQrvBlN
   g==;
X-CSE-ConnectionGUID: PwfhXDSKSta8kyhWbmPkrg==
X-CSE-MsgGUID: 9Y9GfxiURq+xFeniHGJkOw==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="14146917"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="14146917"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 13:56:09 -0700
X-CSE-ConnectionGUID: fKw926pwQPui2ZyK5SFt3A==
X-CSE-MsgGUID: e78w4aQBRDWZM9PDMmgRHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="38772042"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 06 Jun 2024 13:56:09 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sFK9W-0003hP-0K;
	Thu, 06 Jun 2024 20:56:06 +0000
Date: Fri, 07 Jun 2024 04:55:12 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 c625dabbf1c4a8e77e4734014f2fde7aa9071a1f
Message-ID: <202406070409.DfAFxBuY-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: c625dabbf1c4a8e77e4734014f2fde7aa9071a1f  x86/amd_nb: Check for invalid SMN reads

elapsed time: 1490m

configs tested: 74
configs skipped: 134

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
hexagon                          allmodconfig   clang
hexagon                          allyesconfig   clang
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
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                                defconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                               defconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                            defconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                             allnoconfig   gcc  
sh                                allnoconfig   gcc  
sh                                  defconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                             i386_defconfig   gcc  
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240607   gcc  
x86_64       buildonly-randconfig-002-20240607   gcc  
x86_64       buildonly-randconfig-003-20240607   clang
x86_64       buildonly-randconfig-004-20240607   gcc  
x86_64       buildonly-randconfig-005-20240607   gcc  
x86_64       buildonly-randconfig-006-20240607   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240607   gcc  
x86_64                randconfig-002-20240607   gcc  
x86_64                randconfig-003-20240607   clang
x86_64                randconfig-004-20240607   clang
x86_64                randconfig-005-20240607   clang
x86_64                randconfig-006-20240607   gcc  
x86_64                randconfig-011-20240607   gcc  
x86_64                randconfig-012-20240607   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

