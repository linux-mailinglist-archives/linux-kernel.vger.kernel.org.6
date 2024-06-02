Return-Path: <linux-kernel+bounces-198394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A548D779D
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 21:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 313C71F21C5D
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 19:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE457174F;
	Sun,  2 Jun 2024 19:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bw2UouR3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4E8262B6
	for <linux-kernel@vger.kernel.org>; Sun,  2 Jun 2024 19:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717356850; cv=none; b=j9A0zqITEhUDVc4FCHnfrR7tdVCu5r8XH1tUHp0ypBkuzhniA89btIxTTOlndNo5dMDaJBVSjDTCrWVZS7HC3KuJf9rvF6DV9fmfNh1x24WvEnMOjb528W0zgzyTsQ/Xx+8eOAHfBJIbrSrZAMecA4pIxd3+NDbvtTca37dW/kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717356850; c=relaxed/simple;
	bh=jU1KE6cNBFB8q2MqyQaMmOaoAHM28bYwChglFAXBwts=;
	h=Date:From:To:Cc:Subject:Message-ID; b=T4958WEHcPy0eHRTuLwCeFUznm6+PaHstQi2k3nso4k3MTtC8dS+/Fjer6hL01hn04q9h/wStnI9z8AYzZ3Ly4sryeOuT+56f1Hw8a24mjZ1gsuXwZL5ZwVf+20Ww5W5Ri3UtqhnFNu4qzwE6zC9YjuKNsywb4qNOXfcTgSYmjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bw2UouR3; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717356848; x=1748892848;
  h=date:from:to:cc:subject:message-id;
  bh=jU1KE6cNBFB8q2MqyQaMmOaoAHM28bYwChglFAXBwts=;
  b=Bw2UouR34UJ5cvXL8QBGZflvaSSU+oGw1TIC+4J+26N9aJ+/tM5KSwaK
   nd3crDnRqHn/R1gasGVLN4rZdRMFTxC7BVZX6MrSku4ekC+nxNzrByJiU
   wJlXjRHQ/ybTTSdehR4wUH9kQCiXf1ue56EGJNy8KC3ce9ZoFfkWocKdp
   UfesOHnDsls4SRIoOjVpyLEiNdd0P7Z5zeljcWJ/H9rXn4G7xYq3FSo/b
   F1K1K1UDVbMS045cb68QPEOKv1/TC1Cc99yKQP9enZOiYNkcjzQ5G3Nmi
   mOYyFP6CEIPVnenQiMlU5OwCxHnOiXIyFojHKVEb50miWIRVl+tBMKoBU
   Q==;
X-CSE-ConnectionGUID: kYVaIAaLR3yu+cPJO5Pwbg==
X-CSE-MsgGUID: U8Bb3+MNTGeJsdutYFvvjQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11091"; a="13715899"
X-IronPort-AV: E=Sophos;i="6.08,210,1712646000"; 
   d="scan'208";a="13715899"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2024 12:34:08 -0700
X-CSE-ConnectionGUID: 4t9qS947SGKtOl6INu3+OQ==
X-CSE-MsgGUID: Rs8m886oTkic7PgNevGFmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,210,1712646000"; 
   d="scan'208";a="37276056"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 02 Jun 2024 12:34:06 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sDqxw-000KLb-09;
	Sun, 02 Jun 2024 19:34:04 +0000
Date: Mon, 03 Jun 2024 03:34:03 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/cpu] BUILD SUCCESS
 eb9d3c0bb065e55af6ec88e82a94b57fa1bb6e5d
Message-ID: <202406030300.Rof7K4V9-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cpu
branch HEAD: eb9d3c0bb065e55af6ec88e82a94b57fa1bb6e5d  x86/mce/inject: Add missing MODULE_DESCRIPTION() line

elapsed time: 728m

configs tested: 117
configs skipped: 135

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240602   gcc  
arc                   randconfig-002-20240602   gcc  
arm                   randconfig-003-20240602   gcc  
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-002-20240602   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240602   gcc  
csky                  randconfig-002-20240602   gcc  
hexagon                          allmodconfig   clang
hexagon                          allyesconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240602   clang
i386         buildonly-randconfig-002-20240602   gcc  
i386         buildonly-randconfig-003-20240602   clang
i386         buildonly-randconfig-004-20240602   clang
i386         buildonly-randconfig-005-20240602   clang
i386         buildonly-randconfig-006-20240602   clang
i386                                defconfig   clang
i386                  randconfig-001-20240602   clang
i386                  randconfig-002-20240602   clang
i386                  randconfig-003-20240602   clang
i386                  randconfig-004-20240602   gcc  
i386                  randconfig-005-20240602   clang
i386                  randconfig-006-20240602   clang
i386                  randconfig-011-20240602   clang
i386                  randconfig-012-20240602   clang
i386                  randconfig-013-20240602   clang
i386                  randconfig-014-20240602   gcc  
i386                  randconfig-015-20240602   gcc  
i386                  randconfig-016-20240602   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240602   gcc  
loongarch             randconfig-002-20240602   gcc  
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
nios2                 randconfig-001-20240602   gcc  
nios2                 randconfig-002-20240602   gcc  
openrisc                          allnoconfig   gcc  
openrisc                            defconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240602   gcc  
parisc                randconfig-002-20240602   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-002-20240602   gcc  
powerpc64             randconfig-002-20240602   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
s390                             allmodconfig   clang
s390                             allyesconfig   gcc  
s390                  randconfig-001-20240602   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240602   gcc  
sh                    randconfig-002-20240602   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240602   gcc  
sparc64               randconfig-002-20240602   gcc  
um                               allmodconfig   clang
um                               allyesconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20240602   gcc  
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-002-20240602   clang
x86_64       buildonly-randconfig-003-20240602   clang
x86_64       buildonly-randconfig-005-20240602   clang
x86_64       buildonly-randconfig-006-20240602   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-002-20240602   clang
x86_64                randconfig-003-20240602   clang
x86_64                randconfig-005-20240602   clang
x86_64                randconfig-006-20240602   clang
x86_64                randconfig-012-20240602   clang
x86_64                randconfig-013-20240602   clang
x86_64                randconfig-015-20240602   clang
x86_64                randconfig-072-20240602   clang
x86_64                randconfig-074-20240602   clang
x86_64                randconfig-075-20240602   clang
x86_64                randconfig-076-20240602   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240602   gcc  
xtensa                randconfig-002-20240602   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

