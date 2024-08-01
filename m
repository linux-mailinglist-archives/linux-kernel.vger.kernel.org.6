Return-Path: <linux-kernel+bounces-270913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0959446F6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 10:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A97F285BEB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 08:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A0A16D4DC;
	Thu,  1 Aug 2024 08:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T+7yhOEL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FE94503A
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 08:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722502108; cv=none; b=jmpRQFIZoD/qwL3o0MHGHJm50dwv4uuNKFHMWInaolEXROYkr3tFUksN89BsX/V7g9ay4ZEiZc/TnqdJrzMTeEwjBv8eKJl349i517nBi4RaBT9Jq560RLyABagTYeO9pxWnsc46RI3hrqpUr/hf5PiSbocG9iAOyQzTQhi3mxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722502108; c=relaxed/simple;
	bh=Ot/zBqdtEyD2RX2fJISXuHDFZFgaa+W2wG8G9b4yueE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=a0ty9Hdaf+5R4pXTpmUOkZ02tmd2kjIWEASNNAX84H7V+vyW9Tn9VxcnrM6POWMjEUu1OFTKCt2Yh93ZXKxsXOA0TNbBoML26nkDSS2KCBaKggQ9DuZhqZItYaqZMEheb4fj1Wk1pLYzVNOzXBcRzlvhK/4PX24Yljv0rjxqCM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T+7yhOEL; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722502106; x=1754038106;
  h=date:from:to:cc:subject:message-id;
  bh=Ot/zBqdtEyD2RX2fJISXuHDFZFgaa+W2wG8G9b4yueE=;
  b=T+7yhOEL6TmiFJD6XD1kc5DKEZWy2exT6F+2B/61RG/+Z9v1Bs4nzG2u
   h9puGav8eEWkOOrX+R8T3iGRKOKNwF750oZjOYIpzac3NEonwhbwwXz5x
   XbLyvNdRoJrFSSYRyUuS3VuvSKMecFuSbPUffds0fqF3uKlEaXsSNXvc2
   WxqOjYJYkpsq6wJCS7NrUV4Hm34ST+m5iZCJKBEIaSLPRxP7HGDze0f9n
   u+XSNgrMNnnv0YaRoCZvMviloK253FOSdcxfWvXqCmeeEvZcNejuqaWJf
   5ASYcevzKJc0r3KeGNAaD58+vZc6zUOyuQwUhUu3Zc43Q9lrTt+B0ahhL
   A==;
X-CSE-ConnectionGUID: 8rJUy78iRMinNiNaWykaXQ==
X-CSE-MsgGUID: YyfhjdQaT2apgSW4mkSEyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11150"; a="20573206"
X-IronPort-AV: E=Sophos;i="6.09,254,1716274800"; 
   d="scan'208";a="20573206"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2024 01:48:25 -0700
X-CSE-ConnectionGUID: pHPZnXJSTkq/Z8ONq9h75Q==
X-CSE-MsgGUID: x4sV//4ITZy/YTRE8B9HjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,254,1716274800"; 
   d="scan'208";a="85867451"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 01 Aug 2024 01:48:25 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sZRTx-000vOO-2q;
	Thu, 01 Aug 2024 08:48:21 +0000
Date: Thu, 01 Aug 2024 16:47:51 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 bf514327c324bc8af64f359b341cc9b189c096fd
Message-ID: <202408011648.mJ2SPMzY-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: bf514327c324bc8af64f359b341cc9b189c096fd  x86/setup: Parse the builtin command line before merging

elapsed time: 730m

configs tested: 127
configs skipped: 128

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                   randconfig-001-20240801   gcc-13.2.0
arc                   randconfig-002-20240801   gcc-13.2.0
arm                               allnoconfig   gcc-13.2.0
arm                        keystone_defconfig   gcc-14.1.0
arm                             pxa_defconfig   gcc-14.1.0
arm                   randconfig-001-20240801   gcc-13.2.0
arm                   randconfig-002-20240801   gcc-13.2.0
arm                   randconfig-003-20240801   gcc-13.2.0
arm                   randconfig-004-20240801   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                 randconfig-001-20240801   gcc-13.2.0
arm64                 randconfig-002-20240801   gcc-13.2.0
arm64                 randconfig-003-20240801   gcc-13.2.0
arm64                 randconfig-004-20240801   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                  randconfig-001-20240801   gcc-13.2.0
csky                  randconfig-002-20240801   gcc-13.2.0
i386                             allmodconfig   clang-18
i386                              allnoconfig   clang-18
i386                             allyesconfig   clang-18
i386         buildonly-randconfig-001-20240801   gcc-9
i386         buildonly-randconfig-002-20240801   gcc-9
i386         buildonly-randconfig-003-20240801   gcc-9
i386         buildonly-randconfig-004-20240801   gcc-9
i386         buildonly-randconfig-005-20240801   gcc-9
i386         buildonly-randconfig-006-20240801   gcc-9
i386                                defconfig   clang-18
i386                  randconfig-001-20240801   gcc-9
i386                  randconfig-002-20240801   gcc-9
i386                  randconfig-003-20240801   gcc-9
i386                  randconfig-004-20240801   gcc-9
i386                  randconfig-005-20240801   gcc-9
i386                  randconfig-006-20240801   gcc-9
i386                  randconfig-011-20240801   gcc-9
i386                  randconfig-012-20240801   gcc-9
i386                  randconfig-013-20240801   gcc-9
i386                  randconfig-014-20240801   gcc-9
i386                  randconfig-015-20240801   gcc-9
i386                  randconfig-016-20240801   gcc-9
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch             randconfig-001-20240801   gcc-13.2.0
loongarch             randconfig-002-20240801   gcc-13.2.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-14.1.0
m68k                          amiga_defconfig   gcc-14.1.0
m68k                          atari_defconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-14.1.0
mips                              allnoconfig   gcc-13.2.0
mips                           ci20_defconfig   gcc-14.1.0
mips                        maltaup_defconfig   gcc-14.1.0
mips                           mtx1_defconfig   gcc-14.1.0
mips                         rt305x_defconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-13.2.0
nios2                 randconfig-001-20240801   gcc-13.2.0
nios2                 randconfig-002-20240801   gcc-13.2.0
openrisc                          allnoconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                randconfig-001-20240801   gcc-13.2.0
parisc                randconfig-002-20240801   gcc-13.2.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                 mpc834x_itx_defconfig   gcc-14.1.0
powerpc                      pcm030_defconfig   gcc-14.1.0
powerpc               randconfig-001-20240801   gcc-13.2.0
powerpc               randconfig-002-20240801   gcc-13.2.0
powerpc               randconfig-003-20240801   gcc-13.2.0
powerpc                     tqm5200_defconfig   gcc-14.1.0
powerpc64             randconfig-001-20240801   gcc-13.2.0
powerpc64             randconfig-002-20240801   gcc-13.2.0
powerpc64             randconfig-003-20240801   gcc-13.2.0
riscv                             allnoconfig   gcc-14.1.0
riscv                 randconfig-001-20240801   gcc-13.2.0
riscv                 randconfig-002-20240801   gcc-13.2.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-20
s390                  randconfig-001-20240801   gcc-13.2.0
s390                  randconfig-002-20240801   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                         apsh4a3a_defconfig   gcc-14.1.0
sh                ecovec24-romimage_defconfig   gcc-14.1.0
sh                    randconfig-001-20240801   gcc-13.2.0
sh                    randconfig-002-20240801   gcc-13.2.0
sh                   rts7751r2dplus_defconfig   gcc-14.1.0
sh                           se7751_defconfig   gcc-14.1.0
sparc                       sparc64_defconfig   gcc-14.1.0
sparc64               randconfig-001-20240801   gcc-13.2.0
sparc64               randconfig-002-20240801   gcc-13.2.0
um                                allnoconfig   gcc-14.1.0
um                    randconfig-001-20240801   gcc-13.2.0
um                    randconfig-002-20240801   gcc-13.2.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240801   clang-18
x86_64       buildonly-randconfig-002-20240801   clang-18
x86_64       buildonly-randconfig-003-20240801   clang-18
x86_64       buildonly-randconfig-004-20240801   clang-18
x86_64       buildonly-randconfig-005-20240801   clang-18
x86_64       buildonly-randconfig-006-20240801   clang-18
x86_64                              defconfig   clang-18
x86_64                randconfig-001-20240801   clang-18
x86_64                randconfig-002-20240801   clang-18
x86_64                randconfig-003-20240801   clang-18
x86_64                randconfig-004-20240801   clang-18
x86_64                randconfig-005-20240801   clang-18
x86_64                randconfig-006-20240801   clang-18
x86_64                randconfig-011-20240801   clang-18
x86_64                randconfig-012-20240801   clang-18
x86_64                randconfig-013-20240801   clang-18
x86_64                randconfig-014-20240801   clang-18
x86_64                randconfig-015-20240801   clang-18
x86_64                randconfig-016-20240801   clang-18
x86_64                randconfig-071-20240801   clang-18
x86_64                randconfig-072-20240801   clang-18
x86_64                randconfig-073-20240801   clang-18
x86_64                randconfig-074-20240801   clang-18
x86_64                randconfig-075-20240801   clang-18
x86_64                randconfig-076-20240801   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                randconfig-001-20240801   gcc-13.2.0
xtensa                randconfig-002-20240801   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

