Return-Path: <linux-kernel+bounces-278943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0526094B6E5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 08:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B13D72852B2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 06:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2D8143723;
	Thu,  8 Aug 2024 06:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VoUsJ1bg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CED081ACA
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 06:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723099532; cv=none; b=UG6jqNZtTeO+YxeIdYap3YHD38IWPBHs10wYcYhx2/RYQfNaq2R8ohlxD0aVxrh53G3EtlT8C8zgIKWTYpWVsNfBXaq9p3Dnz5TiNc3U+Ldok3u0FM4KRh0Hnw5LN43B76LlFJ11/+fMOrJ/QqPCeEq+BlGgrHBc88V8YzhMwIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723099532; c=relaxed/simple;
	bh=mAzCrwu1Dt+F7SGDVfJ9BhvtV8IgdaorM/Pkg4Es5bE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=j/xjGol2OPKDzsKEt+WQDPuHTgf6YVukpm2/3jGhF5QjjNnEnqtwCusIHPBKVqI7vvuQWtLKVSJXTBgHEMe0y05zQuq7xJz+Qy1m2iQL1chhBfPj7t/M3J90MTcrKKEyv1d1Wo29PhRNSSy4fllwzNr1L+IBqTD2DknKDFYDvkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VoUsJ1bg; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723099531; x=1754635531;
  h=date:from:to:cc:subject:message-id;
  bh=mAzCrwu1Dt+F7SGDVfJ9BhvtV8IgdaorM/Pkg4Es5bE=;
  b=VoUsJ1bgWbhEXk30EvzUGfe4LQDKbz9K/f5JihsUNYyaonbpyGFhrgEq
   acgV2zTYacYT6xbdOol10A76ClFpno2nOS9a528QaENW+mIak7b+iZ5zD
   pnbSnpPhVGr2fHmlTHbAp00mhi0d2SWBoHzzVaNYFqvsSDOeI+UwZl/iu
   j/XOZUo/gyhNgSapVbyyObHd0UImhJxgzUVr2DPR/2dhjTPoOT/oldzIN
   R+YomvKkVRkAbfe5m5ukQRIrwQ7jvQYiVo/aPvKM5jehtPiuvZtFNTkxL
   PZZAkP7FOcW5+zmJr/LTTYODaDIYKxbJ/+KLZUQw/koJMexnFhX9Nd0VE
   w==;
X-CSE-ConnectionGUID: iHH7Zls0RIOc5xDjJbFRNA==
X-CSE-MsgGUID: jcr33CIRSbiLK8P9wK58UA==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="24997462"
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="24997462"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 23:45:30 -0700
X-CSE-ConnectionGUID: AnqH/gNVQ8m1QiO4XlYOUQ==
X-CSE-MsgGUID: 70RCNeNiQHKTNeBOTFxm0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="57062928"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 07 Aug 2024 23:45:28 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sbwtq-0005zF-1B;
	Thu, 08 Aug 2024 06:45:26 +0000
Date: Thu, 08 Aug 2024 14:45:16 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 e639222a51196c69c70b49b67098ce2f9919ed08
Message-ID: <202408081414.WEFIVjE2-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: e639222a51196c69c70b49b67098ce2f9919ed08  x86/paravirt: Fix incorrect virt spinlock setting on bare metal

elapsed time: 723m

configs tested: 50
configs skipped: 128

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                             allmodconfig   gcc-12
i386                              allnoconfig   gcc-12
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240808   clang-18
i386         buildonly-randconfig-002-20240808   gcc-12
i386         buildonly-randconfig-003-20240808   clang-18
i386         buildonly-randconfig-004-20240808   clang-18
i386         buildonly-randconfig-005-20240808   clang-18
i386         buildonly-randconfig-006-20240808   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240808   gcc-12
i386                  randconfig-002-20240808   gcc-12
i386                  randconfig-003-20240808   clang-18
i386                  randconfig-004-20240808   gcc-12
i386                  randconfig-005-20240808   gcc-12
i386                  randconfig-006-20240808   gcc-12
i386                  randconfig-011-20240808   clang-18
i386                  randconfig-012-20240808   gcc-11
i386                  randconfig-013-20240808   clang-18
i386                  randconfig-014-20240808   gcc-11
i386                  randconfig-015-20240808   gcc-12
i386                  randconfig-016-20240808   gcc-12
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240808   gcc-12
x86_64       buildonly-randconfig-002-20240808   gcc-12
x86_64       buildonly-randconfig-003-20240808   clang-18
x86_64       buildonly-randconfig-004-20240808   clang-18
x86_64       buildonly-randconfig-005-20240808   clang-18
x86_64       buildonly-randconfig-006-20240808   clang-18
x86_64                              defconfig   gcc-11
x86_64                randconfig-001-20240808   gcc-12
x86_64                randconfig-002-20240808   clang-18
x86_64                randconfig-003-20240808   gcc-12
x86_64                randconfig-004-20240808   clang-18
x86_64                randconfig-005-20240808   clang-18
x86_64                randconfig-006-20240808   clang-18
x86_64                randconfig-011-20240808   clang-18
x86_64                randconfig-012-20240808   gcc-12
x86_64                randconfig-013-20240808   gcc-12
x86_64                randconfig-014-20240808   clang-18
x86_64                randconfig-015-20240808   gcc-12
x86_64                randconfig-016-20240808   clang-18
x86_64                randconfig-071-20240808   clang-18
x86_64                randconfig-072-20240808   clang-18
x86_64                randconfig-073-20240808   clang-18
x86_64                randconfig-074-20240808   gcc-12
x86_64                randconfig-075-20240808   clang-18
x86_64                randconfig-076-20240808   gcc-12
x86_64                          rhel-8.3-rust   clang-18

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

