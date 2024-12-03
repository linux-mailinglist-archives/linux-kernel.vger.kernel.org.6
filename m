Return-Path: <linux-kernel+bounces-429515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D045C9E1DFE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 448C4B35F24
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 13:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6711EE01F;
	Tue,  3 Dec 2024 13:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R2gpCFAy"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BE819A297
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 13:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733231577; cv=none; b=f42Cva7mBQDiTYt8cxhTB3u+/sdlSmxuPoohEjIKUO3/L4LJdeafXEkufc64XKcmDHFR4HJVCoNYYJ5StaiXv0MvR2XLtApu+J2ektpPUnMFxW2Zl2qJWee19uMtu3OqTatXkFPLDTdqUHp/zjEvwcnBA6q0qR5YfvSdHvmasvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733231577; c=relaxed/simple;
	bh=MV9KIEDca/ZonJjDTNlYavudz+Qex36ZiDAyMFgD2HA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Bg81V36hdUjVtEOJByYqbn9klHHC3RgktTGUDU0bDRoHdEtL/vrmMvY32v2Jyi8EZxuX3weA6Fv9+sww/ywbf1FhZyVSJJA7tbZZxQ3R2KNypMnjcEc+RFP6rWXZZlxGVFnGQlqFr9t2+R3Gw3RafO9Mjqd/BqY6F1bKHq7UKAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R2gpCFAy; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733231575; x=1764767575;
  h=date:from:to:cc:subject:message-id;
  bh=MV9KIEDca/ZonJjDTNlYavudz+Qex36ZiDAyMFgD2HA=;
  b=R2gpCFAyku51MQwekaJZCWFYn8ZuIpxItGbCIKOILWilvtMJx3Y8dBkf
   7un20iw88mpJy7rEsnBd1Ec1xtVgcSmgAJzBWNR3s+IXAZkZK3JaG7D1l
   0DdBGJvx/6mTJ8BxHxJH5T3CwhhI2EPEGBcPNUry+DNMSWJ432lqF/vXU
   mavCivVb0KO2kdK6h6AilhQR+1XqHACEpWL1irV7KP7dIojzGZcwAGyV1
   u6XLfwPeyOS2NQeoVYMBdVE0PYcWDnpgwh1bK7rhUOeEpFReOBmsIZ+VU
   3pUcaYycsH6rkXItsapwjrirQsLOR55362pvbpxqv57FXNUmibRMaSBNg
   A==;
X-CSE-ConnectionGUID: rNmlmiUNQQKrhlmZ2KHdHw==
X-CSE-MsgGUID: DF2eymT3TB6+zHrjhTCJaQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="33500275"
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="33500275"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 05:12:55 -0800
X-CSE-ConnectionGUID: /9GPbROYT/Gi2qa4FtvnBw==
X-CSE-MsgGUID: 523smwjMQ/ejuHOZsy0i/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="93517231"
Received: from lkp-server01.sh.intel.com (HELO 388c121a226b) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 03 Dec 2024 05:12:55 -0800
Received: from kbuild by 388c121a226b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tIShw-0000hG-0M;
	Tue, 03 Dec 2024 13:12:52 +0000
Date: Tue, 03 Dec 2024 21:10:24 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 ae6012d72fa60c9ff92de5bac7a8021a47458e5b
Message-ID: <202412032114.JypYidtS-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: ae6012d72fa60c9ff92de5bac7a8021a47458e5b  x86/pkeys: Ensure updated PKRU value is XRSTOR'd

elapsed time: 720m

configs tested: 78
configs skipped: 98

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-20
arc                   randconfig-001-20241203    clang-20
arc                   randconfig-002-20241203    clang-20
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-20
arm                   randconfig-001-20241203    clang-20
arm                   randconfig-002-20241203    clang-20
arm                   randconfig-003-20241203    clang-20
arm                   randconfig-004-20241203    clang-20
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20241203    clang-20
arm64                 randconfig-002-20241203    clang-20
arm64                 randconfig-003-20241203    clang-20
arm64                 randconfig-004-20241203    clang-20
csky                              allnoconfig    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-20
i386        buildonly-randconfig-001-20241203    clang-19
i386        buildonly-randconfig-001-20241203    gcc-12
i386        buildonly-randconfig-002-20241203    clang-19
i386        buildonly-randconfig-002-20241203    gcc-12
i386        buildonly-randconfig-003-20241203    clang-19
i386        buildonly-randconfig-004-20241203    clang-19
i386        buildonly-randconfig-005-20241203    clang-19
i386        buildonly-randconfig-006-20241203    clang-19
i386        buildonly-randconfig-006-20241203    gcc-12
loongarch                         allnoconfig    gcc-14.2.0
loongarch                 loongson3_defconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                          hp300_defconfig    gcc-14.2.0
m68k                       m5275evb_defconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                         3c120_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.2.0
powerpc                      arches_defconfig    gcc-14.2.0
powerpc                    ge_imp3a_defconfig    gcc-14.2.0
powerpc                 mpc8315_rdb_defconfig    gcc-14.2.0
powerpc                     tqm8541_defconfig    gcc-14.2.0
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
sh                                allnoconfig    gcc-14.2.0
sh                        edosk7760_defconfig    gcc-14.2.0
sh                          kfr2r09_defconfig    gcc-14.2.0
sh                           se7722_defconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20241203    clang-19
x86_64      buildonly-randconfig-001-20241203    gcc-11
x86_64      buildonly-randconfig-002-20241203    clang-19
x86_64      buildonly-randconfig-002-20241203    gcc-11
x86_64      buildonly-randconfig-003-20241203    clang-19
x86_64      buildonly-randconfig-003-20241203    gcc-11
x86_64      buildonly-randconfig-004-20241203    gcc-11
x86_64      buildonly-randconfig-005-20241203    gcc-11
x86_64      buildonly-randconfig-005-20241203    gcc-12
x86_64      buildonly-randconfig-006-20241203    clang-19
x86_64      buildonly-randconfig-006-20241203    gcc-11
xtensa                            allnoconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

