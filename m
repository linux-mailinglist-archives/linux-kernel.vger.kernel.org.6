Return-Path: <linux-kernel+bounces-216687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F7990A30E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 06:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE0351C20F37
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 04:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC42416E88D;
	Mon, 17 Jun 2024 04:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QqLnJ94P"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668C9819
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 04:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718598656; cv=none; b=gy71WANgTvF8/cpW3TcdbWBAhdc4K6ufHC2WO9/z79PZ/0C+dOswEesczPEmxFWo5JIB0RgZLA4uqJ7hTxJ5bX5RpeB+VJi3FJE7sjUbJ52yn9ZXdXJat0UiD6BHYGzVQ/xOuueHLbTZobYtjpfHO60zmOekDgON489E+ZSPsbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718598656; c=relaxed/simple;
	bh=SvLwFlhdBig9nNwHKS++ukdBST+SOBZ7pHekqjC4A0Q=;
	h=Date:From:To:Cc:Subject:Message-ID; b=WeCVgoOQRMsweZH3tZToNHi/UuwBD6ez08r0vRlGwg82Aou7CNWn9Wdmm0mOH5i8Z2NPM43XnX9jQ86Tuh8Bu12VL/Nr2TMk0cHvuv2qw38nI4qmAU2I0cGBIN1eNIorBJ1guvlyEHtALg3uq5c7xyNj8FhGqr14uyO3hpBiBQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QqLnJ94P; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718598654; x=1750134654;
  h=date:from:to:cc:subject:message-id;
  bh=SvLwFlhdBig9nNwHKS++ukdBST+SOBZ7pHekqjC4A0Q=;
  b=QqLnJ94Pbkrjh8+ntQ+6LuOQ/FazPnBGslM7Ki1HNvdObzxjlfJ114Ur
   +q1ZT5rWdqdO2Yxm3F4kqmrurRjyfW2Hi4aQDj1s5pYyBiMvrrhKl6OpZ
   mEMxyx28PQUDfMNayo2QbWxU+mO/Xo93IdjdB2Vt8KOD5Rf4DjjLpJJ6j
   +QEkTwPIlYQTv6Bfl0D40/VbgAZMSN+yNirQhGlih/uKcSnpPoy6bW+SN
   OjjsUuUTZsx1sAvHUnIRrgIBB5TXcj6HkCQLeyxMh2NKYcjmGfpSYMtTA
   aJOMZVfwreK1ThhCXyoRwDVP3yFvqeu7+YQLRJIhXA22d2wAUmHSvIxPt
   Q==;
X-CSE-ConnectionGUID: yE9yNy51QQGaezCZJe2TGA==
X-CSE-MsgGUID: mK+sz1cBQTSy73+/Az4sNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11105"; a="15535987"
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="15535987"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2024 21:30:54 -0700
X-CSE-ConnectionGUID: o2IbPgWoRwCIoS37dXC3bw==
X-CSE-MsgGUID: kj0iqosdTuGxzJRWweYohA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="40929732"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 16 Jun 2024 21:30:53 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sJ414-0003oB-2q;
	Mon, 17 Jun 2024 04:30:50 +0000
Date: Mon, 17 Jun 2024 12:30:14 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 49b33979e3bf0a5424420d14f026de12f34e8b1e
Message-ID: <202406171212.ZZzawwQc-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 49b33979e3bf0a5424420d14f026de12f34e8b1e  Merge branch into tip/master: 'x86/percpu'

elapsed time: 2512m

configs tested: 115
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                               defconfig   gcc-13.2.0
arc                     nsimosci_hs_defconfig   gcc-13.2.0
arc                   randconfig-001-20240616   gcc-13.2.0
arc                   randconfig-002-20240616   gcc-13.2.0
arm                        clps711x_defconfig   clang-19
arm                            hisi_defconfig   gcc-13.2.0
arm                            qcom_defconfig   clang-19
arm                   randconfig-001-20240616   gcc-13.2.0
arm                   randconfig-002-20240616   gcc-13.2.0
arm                   randconfig-003-20240616   clang-16
arm                   randconfig-004-20240616   clang-19
arm                           sama5_defconfig   gcc-13.2.0
arm64                 randconfig-001-20240616   gcc-13.2.0
arm64                 randconfig-002-20240616   clang-19
arm64                 randconfig-003-20240616   clang-19
arm64                 randconfig-004-20240616   clang-19
csky                  randconfig-001-20240616   gcc-13.2.0
csky                  randconfig-002-20240616   gcc-13.2.0
hexagon               randconfig-001-20240616   clang-19
hexagon               randconfig-002-20240616   clang-19
i386         buildonly-randconfig-001-20240615   clang-18
i386         buildonly-randconfig-002-20240615   gcc-9
i386         buildonly-randconfig-003-20240615   gcc-7
i386         buildonly-randconfig-004-20240615   clang-18
i386         buildonly-randconfig-005-20240615   clang-18
i386         buildonly-randconfig-006-20240615   gcc-13
i386                  randconfig-001-20240615   clang-18
i386                  randconfig-002-20240615   gcc-13
i386                  randconfig-003-20240615   clang-18
i386                  randconfig-004-20240615   clang-18
i386                  randconfig-005-20240615   clang-18
i386                  randconfig-006-20240615   clang-18
i386                  randconfig-011-20240615   clang-18
i386                  randconfig-012-20240615   gcc-12
i386                  randconfig-013-20240615   gcc-13
i386                  randconfig-014-20240615   clang-18
i386                  randconfig-015-20240615   clang-18
i386                  randconfig-016-20240615   gcc-13
loongarch                 loongson3_defconfig   gcc-13.2.0
loongarch             randconfig-001-20240616   gcc-13.2.0
loongarch             randconfig-002-20240616   gcc-13.2.0
mips                           gcw0_defconfig   clang-19
mips                malta_qemu_32r6_defconfig   gcc-13.2.0
nios2                 randconfig-001-20240616   gcc-13.2.0
nios2                 randconfig-002-20240616   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                            defconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                              defconfig   gcc-13.2.0
parisc                randconfig-001-20240616   gcc-13.2.0
parisc                randconfig-002-20240616   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc                     mpc5200_defconfig   clang-14
powerpc               randconfig-001-20240616   gcc-13.2.0
powerpc               randconfig-002-20240616   clang-19
powerpc               randconfig-003-20240616   gcc-13.2.0
powerpc                     tqm8541_defconfig   clang-15
powerpc64             randconfig-001-20240616   gcc-13.2.0
powerpc64             randconfig-002-20240616   clang-19
powerpc64             randconfig-003-20240616   gcc-13.2.0
riscv                             allnoconfig   gcc-13.2.0
riscv                               defconfig   clang-19
riscv                 randconfig-001-20240616   clang-14
riscv                 randconfig-002-20240616   gcc-13.2.0
s390                              allnoconfig   clang-19
s390                                defconfig   clang-19
s390                  randconfig-001-20240616   clang-19
s390                  randconfig-002-20240616   clang-19
sh                                allnoconfig   gcc-13.2.0
sh                                  defconfig   gcc-13.2.0
sh                          r7785rp_defconfig   gcc-13.2.0
sh                    randconfig-001-20240616   gcc-13.2.0
sh                    randconfig-002-20240616   gcc-13.2.0
sh                   rts7751r2dplus_defconfig   gcc-13.2.0
sparc                             allnoconfig   gcc-13.2.0
sparc                               defconfig   gcc-13.2.0
sparc                       sparc32_defconfig   gcc-13.2.0
sparc64                             defconfig   gcc-13.2.0
sparc64               randconfig-001-20240616   gcc-13.2.0
sparc64               randconfig-002-20240616   gcc-13.2.0
um                                allnoconfig   clang-17
um                                  defconfig   clang-19
um                             i386_defconfig   gcc-13
um                    randconfig-001-20240616   gcc-13
um                    randconfig-002-20240616   gcc-10
um                           x86_64_defconfig   clang-15
x86_64       buildonly-randconfig-001-20240616   clang-18
x86_64       buildonly-randconfig-002-20240616   clang-18
x86_64       buildonly-randconfig-003-20240616   clang-18
x86_64       buildonly-randconfig-004-20240616   clang-18
x86_64       buildonly-randconfig-005-20240616   gcc-13
x86_64       buildonly-randconfig-006-20240616   clang-18
x86_64                randconfig-001-20240616   gcc-13
x86_64                randconfig-002-20240616   clang-18
x86_64                randconfig-003-20240616   clang-18
x86_64                randconfig-004-20240616   clang-18
x86_64                randconfig-005-20240616   clang-18
x86_64                randconfig-006-20240616   clang-18
x86_64                randconfig-011-20240616   gcc-13
x86_64                randconfig-012-20240616   gcc-13
x86_64                randconfig-013-20240616   clang-18
x86_64                randconfig-014-20240616   gcc-10
x86_64                randconfig-015-20240616   clang-18
x86_64                randconfig-016-20240616   gcc-13
x86_64                randconfig-071-20240616   clang-18
x86_64                randconfig-072-20240616   clang-18
x86_64                randconfig-073-20240616   gcc-13
x86_64                randconfig-074-20240616   clang-18
x86_64                randconfig-075-20240616   gcc-13
x86_64                randconfig-076-20240616   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                  cadence_csp_defconfig   gcc-13.2.0
xtensa                randconfig-001-20240616   gcc-13.2.0
xtensa                randconfig-002-20240616   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

