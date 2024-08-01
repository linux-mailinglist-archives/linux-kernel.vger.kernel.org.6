Return-Path: <linux-kernel+bounces-270245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE7B943DAE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 03:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D01AE1C20E14
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 01:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E1D1CD66F;
	Thu,  1 Aug 2024 00:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iRxRnx3w"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E92A1CD657
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 00:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471972; cv=none; b=B9z3Q42BLyQKyIT/APM/RayF4MaIUjCuzN2OnoYBNmX+L+UXne5q9ceNUK04YvNASKdVZ5ZgEXz5ANCdGF4NVxSeSLCM6JpQn2c9Tnla7WYj4X6irDYlfMvN8bOb+2FMYv1KiNzp5ooz1EfFZKI0oDjYW19qdS/2uZkXCfnbSgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471972; c=relaxed/simple;
	bh=wJdiZfJDsWswP13NeAvM4KqYSTlIFDzmpZyEFchDtd0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=HLTsN5NQQYcFore0LPdEg0Q/1SUTwfynDHZTPR99EyA/y+qttofsmguhxCM2/n3nwjodYeJWIGUmAK72453kY0nEdxsdlJMlogN0Xwy63raOj/phRbzvSrcjI/hYRMuIJWaIwR/4yHj721DWD2XxDqVbIK29KaT6KUIP2TfSN24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iRxRnx3w; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722471970; x=1754007970;
  h=date:from:to:cc:subject:message-id;
  bh=wJdiZfJDsWswP13NeAvM4KqYSTlIFDzmpZyEFchDtd0=;
  b=iRxRnx3w4yeateiqWkmo5bLJ2k7/bN7MKzo/404TjIqU6Mco5zaRNCb8
   Ma6gRwOrwX+gKLCmiLlZvvBjlwmebiCceiuUZyg1JR7Nto594zNP5dGj5
   GjK1XMQD8ZWPMV1KIemxcrgxa8TpWkhM/DZUxHtWLtZxqJ1FuBFpOp2ny
   HuVY1d/zOu90gyTSb9e1aKIlkSM9jqp8EmawVBZwX3wj8cNndtGY4oIkK
   j0x5W+/Dbp70PfK3+HU+wS6vuxBKM8tfcDDWidtOYa8Wuc1KpcV5xG6P5
   0q7iRm7IH/B4/o3Pg13razG7PV/hmtYD5R5u2Sol7vE1Vd4ZcaoFDsZny
   A==;
X-CSE-ConnectionGUID: ce+0f3HvRNiuRhAKb8d2+Q==
X-CSE-MsgGUID: LWu/rhWtTWitfLZY4+kKrg==
X-IronPort-AV: E=McAfee;i="6700,10204,11150"; a="37904784"
X-IronPort-AV: E=Sophos;i="6.09,253,1716274800"; 
   d="scan'208";a="37904784"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 17:26:10 -0700
X-CSE-ConnectionGUID: +tgyV/vsTkeweYFec/pBvw==
X-CSE-MsgGUID: hDrMI2hFQ4es72A6gxkYfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,253,1716274800"; 
   d="scan'208";a="59902417"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 31 Jul 2024 17:26:09 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sZJdu-000v1J-1d;
	Thu, 01 Aug 2024 00:26:06 +0000
Date: Thu, 01 Aug 2024 08:26:00 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:perf/urgent] BUILD SUCCESS
 f73cefa3b72eaa90abfc43bf6d68137ba059d4b1
Message-ID: <202408010857.dfzwtcwV-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/urgent
branch HEAD: f73cefa3b72eaa90abfc43bf6d68137ba059d4b1  perf/x86: Fix smp_processor_id()-in-preemptible warnings

elapsed time: 736m

configs tested: 67
configs skipped: 145

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                               defconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arm                               allnoconfig   gcc-13.2.0
arm                                 defconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
i386                             allmodconfig   gcc-13
i386                              allnoconfig   gcc-13
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240801   gcc-9
i386         buildonly-randconfig-002-20240801   clang-18
i386         buildonly-randconfig-002-20240801   gcc-9
i386         buildonly-randconfig-003-20240801   gcc-7
i386         buildonly-randconfig-003-20240801   gcc-9
i386         buildonly-randconfig-004-20240801   clang-18
i386         buildonly-randconfig-004-20240801   gcc-9
i386         buildonly-randconfig-005-20240801   clang-18
i386         buildonly-randconfig-005-20240801   gcc-9
i386         buildonly-randconfig-006-20240801   clang-18
i386         buildonly-randconfig-006-20240801   gcc-9
i386                                defconfig   clang-18
i386                  randconfig-001-20240801   gcc-13
i386                  randconfig-001-20240801   gcc-9
i386                  randconfig-002-20240801   clang-18
i386                  randconfig-002-20240801   gcc-9
i386                  randconfig-003-20240801   clang-18
i386                  randconfig-003-20240801   gcc-9
i386                  randconfig-004-20240801   clang-18
i386                  randconfig-004-20240801   gcc-9
i386                  randconfig-005-20240801   gcc-13
i386                  randconfig-005-20240801   gcc-9
i386                  randconfig-006-20240801   gcc-13
i386                  randconfig-006-20240801   gcc-9
i386                  randconfig-011-20240801   gcc-13
i386                  randconfig-011-20240801   gcc-9
i386                  randconfig-012-20240801   clang-18
i386                  randconfig-012-20240801   gcc-9
i386                  randconfig-013-20240801   gcc-13
i386                  randconfig-013-20240801   gcc-9
i386                  randconfig-014-20240801   gcc-13
i386                  randconfig-014-20240801   gcc-9
i386                  randconfig-015-20240801   gcc-12
i386                  randconfig-015-20240801   gcc-9
i386                  randconfig-016-20240801   clang-18
i386                  randconfig-016-20240801   gcc-9
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
m68k                                defconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
s390                             allmodconfig   clang-20
s390                             allyesconfig   clang-20
sh                                allnoconfig   gcc-13.2.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64                              defconfig   gcc-13
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

