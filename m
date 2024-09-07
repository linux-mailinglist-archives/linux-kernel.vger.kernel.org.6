Return-Path: <linux-kernel+bounces-319818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 249EC970298
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 16:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAD8B283166
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 14:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C52C15CD77;
	Sat,  7 Sep 2024 14:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I87eTDBV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35D74502F
	for <linux-kernel@vger.kernel.org>; Sat,  7 Sep 2024 14:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725717828; cv=none; b=q1359O0H2f/ho3351wT4Pj3bZyPrXo9UE31LCoxg4Ztktp9d7U9/0IxveYvnUl4s3M4cSkPjpgDRgvBHL//FDcOHEK52wFxuCTWi/wL3cFInJTlSS12aHqnato9kj+BSxE3xV695MuStRBUDst4v1ZbRQ8WisU+1i0K3XZwhy94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725717828; c=relaxed/simple;
	bh=rE8L14V5eeU690zyshASLtDf1RjWXasJx1v5dge0ok8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=aRGKeqFnHFMFDsUsyhDQR9IAIU2lTy+8xVf9A/p9S3emepL0GbBY3ZQ7hxKOL2HVPO8f6s0dPjh1QOB88BsWztM5cUoFAFmCIlOiAemqo79RtpYS5gEDhJLmTNRmrkqOY87/qua46flZAiTGLTWXkake22E0Kb4xab2wawMax9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I87eTDBV; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725717826; x=1757253826;
  h=date:from:to:cc:subject:message-id;
  bh=rE8L14V5eeU690zyshASLtDf1RjWXasJx1v5dge0ok8=;
  b=I87eTDBVdd8J7GoVaEu182I+k8ynqv6GUOiAhFLN+pOgcExuEyXSVeae
   hJjOvIFt0zkWI+uI+JGwwkwTy+WyIpbCCOQCcxPEQ3PTr/VGQYDZ0isVY
   uXaKuTQtvQoOhEThA6fymFdkAfeaJjK+KhH79JGrbmqtESvcCj4BRp8mi
   bP+B/nlXHP5OtPv6nc06JP+PTT0OhPY3ss2lq2IzA7smR7WFIegdODFMI
   exBQio2GiWYVnoHzqAXvdzG9ROfVM/HM2bbNCjhDCVl5Zr2ncu6CvnVKF
   v8BgT+pOZG4YozzOjVXw8L0zoJRcjFcGRIQJPytuVIkYZxubnJ/T7cDEM
   g==;
X-CSE-ConnectionGUID: k60Ggl92Qv6EfcuqBFbF3w==
X-CSE-MsgGUID: hbpuW12sR66faFevE1Ae2A==
X-IronPort-AV: E=McAfee;i="6700,10204,11188"; a="49875644"
X-IronPort-AV: E=Sophos;i="6.10,210,1719903600"; 
   d="scan'208";a="49875644"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2024 07:03:45 -0700
X-CSE-ConnectionGUID: aWYxC8h7TpaDBSgh6iA1dA==
X-CSE-MsgGUID: zDGaOfMjRFmbtYLu45BULA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,210,1719903600"; 
   d="scan'208";a="66205213"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 07 Sep 2024 07:03:44 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1smw2Q-000Cc7-2K;
	Sat, 07 Sep 2024 14:03:42 +0000
Date: Sat, 07 Sep 2024 22:03:28 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:irq/core] BUILD SUCCESS
 87b5a153b862b7d937fc1dd499368297a1feae87
Message-ID: <202409072226.zYqP2Hcf-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
branch HEAD: 87b5a153b862b7d937fc1dd499368297a1feae87  genirq/cpuhotplug: Use cpumask_intersects()

elapsed time: 1326m

configs tested: 134
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-14.1.0
alpha                            allyesconfig   clang-20
alpha                               defconfig   gcc-14.1.0
arc                              allmodconfig   clang-20
arc                               allnoconfig   gcc-14.1.0
arc                              allyesconfig   clang-20
arc                                 defconfig   gcc-14.1.0
arm                              allmodconfig   clang-20
arm                               allnoconfig   gcc-14.1.0
arm                              allyesconfig   clang-20
arm                                 defconfig   gcc-14.1.0
arm                        neponset_defconfig   clang-15
arm                          pxa168_defconfig   clang-15
arm64                            allmodconfig   clang-20
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-14.1.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-14.1.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   gcc-14.1.0
hexagon                          allyesconfig   clang-20
hexagon                             defconfig   gcc-14.1.0
i386                             allmodconfig   clang-18
i386                              allnoconfig   clang-18
i386                             allyesconfig   clang-18
i386         buildonly-randconfig-001-20240907   gcc-12
i386         buildonly-randconfig-002-20240907   gcc-12
i386         buildonly-randconfig-003-20240907   gcc-12
i386         buildonly-randconfig-004-20240907   gcc-12
i386         buildonly-randconfig-005-20240907   gcc-12
i386         buildonly-randconfig-006-20240907   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240907   gcc-12
i386                  randconfig-002-20240907   gcc-12
i386                  randconfig-003-20240907   gcc-12
i386                  randconfig-004-20240907   gcc-12
i386                  randconfig-005-20240907   gcc-12
i386                  randconfig-006-20240907   gcc-12
i386                  randconfig-011-20240907   gcc-12
i386                  randconfig-012-20240907   gcc-12
i386                  randconfig-013-20240907   gcc-12
i386                  randconfig-014-20240907   gcc-12
i386                  randconfig-015-20240907   gcc-12
i386                  randconfig-016-20240907   gcc-12
loongarch                        alldefconfig   clang-15
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                          atari_defconfig   clang-15
m68k                                defconfig   gcc-14.1.0
m68k                        m5407c3_defconfig   clang-15
m68k                       m5475evb_defconfig   clang-15
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
mips                        vocore2_defconfig   clang-15
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-14.1.0
openrisc                          allnoconfig   clang-20
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-12
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   clang-20
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-12
parisc64                            defconfig   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   clang-20
powerpc                          allyesconfig   gcc-14.1.0
powerpc                      cm5200_defconfig   clang-15
powerpc                       eiger_defconfig   clang-15
powerpc                  iss476-smp_defconfig   clang-15
powerpc                         ps3_defconfig   clang-15
powerpc                     tqm8555_defconfig   clang-15
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   clang-20
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-12
riscv             nommu_k210_sdcard_defconfig   clang-15
s390                             allmodconfig   gcc-14.1.0
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-12
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-12
sh                               j2_defconfig   clang-15
sh                           se7750_defconfig   clang-15
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-12
um                               allmodconfig   clang-20
um                                allnoconfig   clang-20
um                               allyesconfig   clang-20
um                                  defconfig   gcc-12
um                             i386_defconfig   clang-15
um                             i386_defconfig   gcc-12
um                           x86_64_defconfig   gcc-12
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240907   gcc-12
x86_64       buildonly-randconfig-002-20240907   gcc-12
x86_64       buildonly-randconfig-003-20240907   gcc-12
x86_64       buildonly-randconfig-004-20240907   gcc-12
x86_64       buildonly-randconfig-005-20240907   gcc-12
x86_64       buildonly-randconfig-006-20240907   gcc-12
x86_64                              defconfig   clang-18
x86_64                                  kexec   gcc-12
x86_64                randconfig-001-20240907   gcc-12
x86_64                randconfig-002-20240907   gcc-12
x86_64                randconfig-003-20240907   gcc-12
x86_64                randconfig-004-20240907   gcc-12
x86_64                randconfig-005-20240907   gcc-12
x86_64                randconfig-006-20240907   gcc-12
x86_64                randconfig-011-20240907   gcc-12
x86_64                randconfig-012-20240907   gcc-12
x86_64                randconfig-013-20240907   gcc-12
x86_64                randconfig-014-20240907   gcc-12
x86_64                randconfig-015-20240907   gcc-12
x86_64                randconfig-016-20240907   gcc-12
x86_64                randconfig-071-20240907   gcc-12
x86_64                randconfig-072-20240907   gcc-12
x86_64                randconfig-073-20240907   gcc-12
x86_64                randconfig-074-20240907   gcc-12
x86_64                randconfig-075-20240907   gcc-12
x86_64                randconfig-076-20240907   gcc-12
x86_64                          rhel-8.3-rust   clang-18
x86_64                               rhel-8.3   gcc-12
xtensa                            allnoconfig   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

