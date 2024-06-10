Return-Path: <linux-kernel+bounces-207935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A0677901E19
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 11:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C4A9B27BB4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 09:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B0B7406D;
	Mon, 10 Jun 2024 09:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QM15Pxg1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBC77405F
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 09:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718011463; cv=none; b=Gxgw4CXNRxhiK97Si2i6OPYohvjIjiLM7kPfNj37TkfIyyoKFfhD0uF/z84gqtGcWT0rV4E7bAjOpiPxlsjdsQUeHMX1OrsLGXvACzoce1d7g3x8MXJCeySYSouCB3R3SZGqwVvEsJSBWlE89eCXAbLD6nCX2ZAIQCFVfw1J6qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718011463; c=relaxed/simple;
	bh=cyQYreqSp0oATKJgHiSWQ/syY8BF72g75iZ51kHtlH0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=SuYdRgKXHBsOM0hQezVyi4L9F9r3Is6SnF7gM9k1tSW3zbWwoHcLb9SINV2dMdtt/yEsEzxG3u7JcUamsRpxOEP87rVU8x9RZFBRYWHQ5C8ssSlDpLzO1LVZ+iuVQwAlJ+e5V7XAGCaBgmKriy7OmJUPEQ1myBZmDjAKeLD6src=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QM15Pxg1; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718011462; x=1749547462;
  h=date:from:to:cc:subject:message-id;
  bh=cyQYreqSp0oATKJgHiSWQ/syY8BF72g75iZ51kHtlH0=;
  b=QM15Pxg14mCsDwdJOFuW1aNePCZUTvEZpKn2q7fVok/jjh+LiCEL1yp1
   lQQfg816/vloGIX+K5D1Cogh6NpnvYXTsF7b9xLqbfSGP79M1OP+fiVQ3
   mvMQzKFMJOjxZte92i0CJ0SBkFGqQXg6oz3J7bzrnm6IFe2y9Hzn9Fb5K
   2oRzPFqws7Tba0XTanD9NYYUuXOuTKj0odLrfnrCiPkkW//I0lkapZcM1
   kCDoe+9K4f45paI9vtUeCBeZB1pItZvUDg8seZaTClZSS5ttKqlB5rBgG
   nE7K5WgAiBa7I9R822RLoCU4X5tOsek2MCOD3Wcye9f7Ys0mi26gDRwEY
   g==;
X-CSE-ConnectionGUID: 6F6oTciLSFmzg+oOJcCycA==
X-CSE-MsgGUID: U9qC/EodTEKfNz8Wk8xwiA==
X-IronPort-AV: E=McAfee;i="6600,9927,11098"; a="25280711"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="25280711"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 02:24:22 -0700
X-CSE-ConnectionGUID: eSTDiSzlSRmvGzIx0PeofQ==
X-CSE-MsgGUID: KzeUBPHKRPW0huS/AeSBKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="69788882"
Received: from lkp-server01.sh.intel.com (HELO 8967fbab76b3) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 10 Jun 2024 02:24:20 -0700
Received: from kbuild by 8967fbab76b3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sGbGE-00021b-10;
	Mon, 10 Jun 2024 09:24:18 +0000
Date: Mon, 10 Jun 2024 17:24:05 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 6046cfb8cbf7d7b7c1c2da1ac7278bf9e333b22b
Message-ID: <202406101701.tzdHCMtW-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 6046cfb8cbf7d7b7c1c2da1ac7278bf9e333b22b  Merge branch into tip/master: 'x86/percpu'

elapsed time: 1449m

configs tested: 134
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arc                     nsimosci_hs_defconfig   gcc  
arc                   randconfig-001-20240610   gcc  
arc                   randconfig-002-20240610   gcc  
arm                               allnoconfig   clang
arm                       aspeed_g5_defconfig   gcc  
arm                                 defconfig   clang
arm                       imx_v4_v5_defconfig   clang
arm                           imxrt_defconfig   clang
arm                             mxs_defconfig   clang
arm                   randconfig-001-20240610   gcc  
arm                   randconfig-002-20240610   gcc  
arm                   randconfig-003-20240610   clang
arm                   randconfig-004-20240610   gcc  
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240610   gcc  
arm64                 randconfig-002-20240610   gcc  
arm64                 randconfig-003-20240610   gcc  
arm64                 randconfig-004-20240610   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240610   gcc  
csky                  randconfig-002-20240610   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240610   clang
hexagon               randconfig-002-20240610   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240610   clang
i386         buildonly-randconfig-002-20240610   gcc  
i386         buildonly-randconfig-003-20240610   gcc  
i386         buildonly-randconfig-004-20240610   clang
i386         buildonly-randconfig-005-20240610   gcc  
i386         buildonly-randconfig-006-20240610   clang
i386                                defconfig   clang
i386                  randconfig-001-20240610   gcc  
i386                  randconfig-002-20240610   gcc  
i386                  randconfig-003-20240610   gcc  
i386                  randconfig-004-20240610   gcc  
i386                  randconfig-005-20240610   clang
i386                  randconfig-006-20240610   gcc  
i386                  randconfig-011-20240610   clang
i386                  randconfig-012-20240610   clang
i386                  randconfig-013-20240610   clang
i386                  randconfig-014-20240610   clang
i386                  randconfig-015-20240610   clang
i386                  randconfig-016-20240610   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240610   gcc  
loongarch             randconfig-002-20240610   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5307c3_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                        bcm63xx_defconfig   clang
mips                     loongson2k_defconfig   gcc  
mips                      pic32mzda_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240610   gcc  
nios2                 randconfig-002-20240610   gcc  
openrisc                          allnoconfig   gcc  
openrisc                            defconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-32bit_defconfig   gcc  
parisc                randconfig-001-20240610   gcc  
parisc                randconfig-002-20240610   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                   bluestone_defconfig   clang
powerpc                        icon_defconfig   gcc  
powerpc                  mpc885_ads_defconfig   clang
powerpc                      ppc64e_defconfig   gcc  
powerpc               randconfig-001-20240610   clang
powerpc               randconfig-002-20240610   clang
powerpc               randconfig-003-20240610   clang
riscv                             allnoconfig   gcc  
riscv                               defconfig   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                               j2_defconfig   gcc  
sh                           se7724_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64       buildonly-randconfig-002-20240610   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-003-20240610   clang
x86_64                randconfig-006-20240610   clang
x86_64                randconfig-011-20240610   clang
x86_64                randconfig-015-20240610   clang
x86_64                randconfig-016-20240610   clang
x86_64                randconfig-072-20240610   clang
x86_64                randconfig-073-20240610   clang
x86_64                randconfig-075-20240610   clang
x86_64                randconfig-076-20240610   clang
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

