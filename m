Return-Path: <linux-kernel+bounces-344977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D96D398B0D4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 01:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CA452823C1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 23:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF2E188A3B;
	Mon, 30 Sep 2024 23:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FlKrPkQP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F381C5339F
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 23:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727738950; cv=none; b=hyNFSPusphfdHx6MXZxgtIp/HxGDCH5/WDy7YoRFri/Ywr+nYMQB+OHCWE3ZLOUlYaJ21DH9NTsqsrl2Gs5h7BHAHiAiZv6kdquBkzbUV2S3dyiml0oW7B5W8fubmOILpn7D5yvSBuRbDMdcGWpUx3Ne3kvJ7gfY0YVxBMxZd1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727738950; c=relaxed/simple;
	bh=rH1letg4GnSr0xvghPc+KuZkGk+4QoR4de1kzFtirA8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=l+2HE+nh2Dh+CoRejtBfCsSQ7IT/+4Qr/nbCZbl7cby04ZuweR3GZbBrcaaUp+HxyhPxbmVoJ0MsIHyi7mwzNndW3qsL4bYyjfSBaYdiONi0yDcESdYbib0epiPTsj9jot1umyaXyYfvUK00hqPhQWTXOPBLgedEJQ5yLRnwsN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FlKrPkQP; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727738949; x=1759274949;
  h=date:from:to:cc:subject:message-id;
  bh=rH1letg4GnSr0xvghPc+KuZkGk+4QoR4de1kzFtirA8=;
  b=FlKrPkQPIh1VD+FvqY64PNNEoLfAOHntsbfVGBA7TxVw+W14oajFF1sn
   4+LcKtsCqORP7RKoOJsDSLY2LrJSA6sssvKVPGdrVOrhfGiKWR5g4nbD3
   dxqqC5rMmtzkymV9UMXocMNnjmhWEcv0RLpaspZUlg6qnTO7T0uk+DqXo
   0yjrpnGWVDrtsOMLExY6rH6F328jwsOglwdh4FSXU5KuUL3s7TpWU0uug
   m9Yu+EM+fCOm3ftQdNWUEADslERQRJ7nLsS6zzfb+pk5y9HQFCcRe2WIt
   TGCRjDHQ/R0sJ3LCBwZhEot7/zXLTLEnrS+ccQdtDW2s1F0a0CA8hu9Xq
   Q==;
X-CSE-ConnectionGUID: iEBvLIqrRDuXXGYqIM/Edg==
X-CSE-MsgGUID: itIsADXGQ/6dMTviAmNMPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="26735883"
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="26735883"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 16:29:00 -0700
X-CSE-ConnectionGUID: evb6jIm/RmqmFsRGQJFrAQ==
X-CSE-MsgGUID: M+3njpjVRE6hfFYixZaZCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="96806345"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 30 Sep 2024 16:28:43 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1svPom-000Q2D-2b;
	Mon, 30 Sep 2024 23:28:40 +0000
Date: Tue, 01 Oct 2024 07:28:22 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 5b0c5f05fb2fe41eff7ef769db8f712e6a679f1d
Message-ID: <202410010708.QvLFGSeR-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 5b0c5f05fb2fe41eff7ef769db8f712e6a679f1d  Merge branch into tip/master: 'x86/splitlock'

elapsed time: 1094m

configs tested: 211
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                            allyesconfig    gcc-13.3.0
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                                 defconfig    gcc-14.1.0
arc                     haps_hs_smp_defconfig    clang-20
arc                   randconfig-001-20240930    clang-15
arc                   randconfig-002-20240930    clang-15
arc                           tb10x_defconfig    clang-20
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                                 defconfig    gcc-14.1.0
arm                          ep93xx_defconfig    clang-20
arm                      integrator_defconfig    clang-20
arm                         orion5x_defconfig    clang-20
arm                   randconfig-001-20240930    clang-15
arm                   randconfig-002-20240930    clang-15
arm                   randconfig-003-20240930    clang-15
arm                   randconfig-004-20240930    clang-15
arm                        realview_defconfig    clang-20
arm                          sp7021_defconfig    clang-20
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
arm64                 randconfig-003-20240930    clang-15
arm64                 randconfig-004-20240930    clang-15
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
csky                  randconfig-001-20240930    clang-15
csky                  randconfig-002-20240930    clang-15
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
hexagon               randconfig-001-20240930    clang-15
hexagon               randconfig-002-20240930    clang-15
i386                             allmodconfig    clang-18
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-18
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-18
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20240930    clang-18
i386        buildonly-randconfig-001-20240930    gcc-12
i386        buildonly-randconfig-001-20241001    clang-18
i386        buildonly-randconfig-002-20240930    clang-18
i386        buildonly-randconfig-002-20241001    clang-18
i386        buildonly-randconfig-003-20240930    clang-18
i386        buildonly-randconfig-003-20241001    clang-18
i386        buildonly-randconfig-004-20240930    clang-18
i386        buildonly-randconfig-004-20240930    gcc-12
i386        buildonly-randconfig-004-20241001    clang-18
i386        buildonly-randconfig-005-20240930    clang-18
i386        buildonly-randconfig-005-20241001    clang-18
i386        buildonly-randconfig-006-20240930    clang-18
i386        buildonly-randconfig-006-20241001    clang-18
i386                                defconfig    clang-18
i386                  randconfig-001-20240930    clang-18
i386                  randconfig-001-20241001    clang-18
i386                  randconfig-002-20240930    clang-18
i386                  randconfig-002-20241001    clang-18
i386                  randconfig-003-20240930    clang-18
i386                  randconfig-003-20240930    gcc-12
i386                  randconfig-003-20241001    clang-18
i386                  randconfig-004-20240930    clang-18
i386                  randconfig-004-20241001    clang-18
i386                  randconfig-005-20240930    clang-18
i386                  randconfig-005-20241001    clang-18
i386                  randconfig-006-20240930    clang-18
i386                  randconfig-006-20241001    clang-18
i386                  randconfig-011-20240930    clang-18
i386                  randconfig-011-20241001    clang-18
i386                  randconfig-012-20240930    clang-18
i386                  randconfig-012-20241001    clang-18
i386                  randconfig-013-20240930    clang-18
i386                  randconfig-013-20240930    gcc-12
i386                  randconfig-013-20241001    clang-18
i386                  randconfig-014-20240930    clang-18
i386                  randconfig-014-20240930    gcc-12
i386                  randconfig-014-20241001    clang-18
i386                  randconfig-015-20240930    clang-18
i386                  randconfig-015-20241001    clang-18
i386                  randconfig-016-20240930    clang-18
i386                  randconfig-016-20240930    gcc-12
i386                  randconfig-016-20241001    clang-18
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
loongarch                 loongson3_defconfig    clang-20
loongarch             randconfig-001-20240930    clang-15
loongarch             randconfig-002-20240930    clang-15
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
m68k                          sun3x_defconfig    clang-20
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                           ci20_defconfig    clang-20
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
nios2                 randconfig-001-20240930    clang-15
nios2                 randconfig-002-20240930    clang-15
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.1.0
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.1.0
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20240930    clang-15
parisc                randconfig-002-20240930    clang-15
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.1.0
powerpc                          allyesconfig    clang-20
powerpc                          allyesconfig    gcc-14.1.0
powerpc                   bluestone_defconfig    clang-20
powerpc                      cm5200_defconfig    clang-20
powerpc                     ep8248e_defconfig    clang-20
powerpc               randconfig-001-20240930    clang-15
powerpc               randconfig-002-20240930    clang-15
powerpc               randconfig-003-20240930    clang-15
powerpc64             randconfig-001-20240930    clang-15
powerpc64             randconfig-002-20240930    clang-15
powerpc64             randconfig-003-20240930    clang-15
riscv                            allmodconfig    clang-20
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.1.0
riscv                            allyesconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20240930    clang-15
riscv                 randconfig-002-20240930    clang-15
s390                             allmodconfig    clang-20
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20240930    clang-15
s390                  randconfig-002-20240930    clang-15
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                            hp6xx_defconfig    clang-20
sh                    randconfig-001-20240930    clang-15
sh                    randconfig-002-20240930    clang-15
sh                           se7619_defconfig    clang-20
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20240930    clang-15
sparc64               randconfig-002-20240930    clang-15
um                               alldefconfig    clang-20
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    clang-20
um                             i386_defconfig    gcc-12
um                    randconfig-001-20240930    clang-15
um                    randconfig-002-20240930    clang-15
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64      buildonly-randconfig-001-20240930    gcc-11
x86_64      buildonly-randconfig-002-20240930    gcc-11
x86_64      buildonly-randconfig-003-20240930    gcc-11
x86_64      buildonly-randconfig-004-20240930    gcc-11
x86_64      buildonly-randconfig-005-20240930    gcc-11
x86_64      buildonly-randconfig-006-20240930    gcc-11
x86_64                              defconfig    clang-18
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-18
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20240930    gcc-11
x86_64                randconfig-002-20240930    gcc-11
x86_64                randconfig-003-20240930    gcc-11
x86_64                randconfig-004-20240930    gcc-11
x86_64                randconfig-005-20240930    gcc-11
x86_64                randconfig-006-20240930    gcc-11
x86_64                randconfig-011-20240930    gcc-11
x86_64                randconfig-012-20240930    gcc-11
x86_64                randconfig-013-20240930    gcc-11
x86_64                randconfig-014-20240930    gcc-11
x86_64                randconfig-015-20240930    gcc-11
x86_64                randconfig-016-20240930    gcc-11
x86_64                randconfig-071-20240930    gcc-11
x86_64                randconfig-072-20240930    gcc-11
x86_64                randconfig-073-20240930    gcc-11
x86_64                randconfig-074-20240930    gcc-11
x86_64                randconfig-075-20240930    gcc-11
x86_64                randconfig-076-20240930    gcc-11
x86_64                               rhel-8.3    gcc-12
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0
xtensa                randconfig-001-20240930    clang-15
xtensa                randconfig-002-20240930    clang-15

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

