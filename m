Return-Path: <linux-kernel+bounces-534868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7FEA46C16
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 21:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16F1616EB84
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 20:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BEB275613;
	Wed, 26 Feb 2025 20:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gU/OzMWB"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19912566F5
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 20:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740600511; cv=none; b=NxUQuDlbHzTB8cHvVflkZKT+ikB5I2ZVWoTXQtCWTTd0IFejYPbPTw7MDh6yu13lbkvIJsRF7HwAJGkoR9IMKxHOumpcuIhImiQ92IYJsKHJwH+hXSa2c7REh6yufGvFsHzUr3k/3LNl3/qg8zc3JJVxKSMoteLixbKpL2uBzNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740600511; c=relaxed/simple;
	bh=s0VlMDsy/CfwsULs14IStSBfX9tPP0S0+8e+uTLX5pE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=QYA59eTiTcAMDbVtfpfEGGZCRXGsHMKie6ALw8IV3YBZkFu+xQb4/YtJ/8rEAcOK+rdlhUbowPIrBGS6NQXmzCyg21ghwe6CpmrltsDHFpPMQ8lz99Vpqzy2y9hE/sWwdNDc7T80dMtwLfgr8db1gUqFAZEwoofTRJ5JV1D25Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gU/OzMWB; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740600510; x=1772136510;
  h=date:from:to:cc:subject:message-id;
  bh=s0VlMDsy/CfwsULs14IStSBfX9tPP0S0+8e+uTLX5pE=;
  b=gU/OzMWBnFP6mhoNKnnOGQ9c089DqP97dWoy5n9Rpv2j1+hGbsOrd572
   WE1aroDkrlhRgJC84+4ZGEJzsIQO8xXPvP9Tdw+mPezajEe5gCxNzQcT4
   ousXnuPF8G4qf/Ke2YLk4Hq/DFGyG9rCVCUe/8oXIIEpBZlCfxc6ZnXMF
   01n4oVC5jbTDJXXq+cbx6rlpHtyZx3X63cV2Yy/NkSUHyqsXkqaGQ79Rm
   oJ5gjmHnCC3xSvkRGv0+ZBkT8ArOjCwxd5jkMgeRwIsJ56Y1ZJeswGSqo
   iZUH9w+b4kqcaAbZ5YZZ+lADGuQWlpfYuF8EAGXQVSPU7lWYWuglT9lC5
   w==;
X-CSE-ConnectionGUID: vY/jsKm3R5a/yBM/gu6bEA==
X-CSE-MsgGUID: Bvwb+GlNToWJawXTstc8tQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="41599660"
X-IronPort-AV: E=Sophos;i="6.13,318,1732608000"; 
   d="scan'208";a="41599660"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 12:08:29 -0800
X-CSE-ConnectionGUID: aI144SUDQ/m1YHOeVTReZg==
X-CSE-MsgGUID: dcMRcUIJR86vgyFWUYsGFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="153985859"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 26 Feb 2025 12:08:27 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tnNhP-000CP3-2k;
	Wed, 26 Feb 2025 20:08:10 +0000
Date: Thu, 27 Feb 2025 04:07:03 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/mm] BUILD SUCCESS
 8e8f0306497dea58fb4e8e2558949daae5eeac5c
Message-ID: <202502270457.PkCVVcrr-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/mm
branch HEAD: 8e8f0306497dea58fb4e8e2558949daae5eeac5c  x86/mtrr: Remove unnecessary strlen() in mtrr_write()

elapsed time: 1446m

configs tested: 68
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                           allyesconfig    gcc-14.2.0
arc                  randconfig-001-20250226    gcc-13.2.0
arc                  randconfig-002-20250226    gcc-13.2.0
arm                  randconfig-001-20250226    gcc-14.2.0
arm                  randconfig-002-20250226    clang-21
arm                  randconfig-003-20250226    gcc-14.2.0
arm                  randconfig-004-20250226    gcc-14.2.0
arm64                randconfig-001-20250226    gcc-14.2.0
arm64                randconfig-002-20250226    gcc-14.2.0
arm64                randconfig-003-20250226    clang-21
arm64                randconfig-004-20250226    gcc-14.2.0
csky                 randconfig-001-20250226    gcc-14.2.0
csky                 randconfig-002-20250226    gcc-14.2.0
hexagon                         allmodconfig    clang-21
hexagon                         allyesconfig    clang-18
hexagon              randconfig-001-20250226    clang-21
hexagon              randconfig-002-20250226    clang-21
i386                             allnoconfig    gcc-12
i386       buildonly-randconfig-001-20250226    gcc-12
i386       buildonly-randconfig-002-20250226    gcc-12
i386       buildonly-randconfig-003-20250226    gcc-12
i386       buildonly-randconfig-004-20250226    clang-19
i386       buildonly-randconfig-005-20250226    gcc-12
i386       buildonly-randconfig-006-20250226    gcc-12
loongarch            randconfig-001-20250226    gcc-14.2.0
loongarch            randconfig-002-20250226    gcc-14.2.0
nios2                randconfig-001-20250226    gcc-14.2.0
nios2                randconfig-002-20250226    gcc-14.2.0
openrisc                         allnoconfig    gcc-14.2.0
parisc                           allnoconfig    gcc-14.2.0
parisc               randconfig-001-20250226    gcc-14.2.0
parisc               randconfig-002-20250226    gcc-14.2.0
powerpc                          allnoconfig    gcc-14.2.0
powerpc              randconfig-001-20250226    gcc-14.2.0
powerpc              randconfig-002-20250226    clang-18
powerpc              randconfig-003-20250226    clang-21
powerpc64            randconfig-001-20250226    clang-18
powerpc64            randconfig-002-20250226    gcc-14.2.0
powerpc64            randconfig-003-20250226    gcc-14.2.0
riscv                randconfig-001-20250226    clang-18
riscv                randconfig-002-20250226    gcc-14.2.0
s390                            allmodconfig    clang-19
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20250226    gcc-14.2.0
s390                 randconfig-002-20250226    clang-15
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20250226    gcc-14.2.0
sh                   randconfig-002-20250226    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20250226    gcc-14.2.0
sparc                randconfig-002-20250226    gcc-14.2.0
sparc64              randconfig-001-20250226    gcc-14.2.0
sparc64              randconfig-002-20250226    gcc-14.2.0
um                              allmodconfig    clang-21
um                              allyesconfig    gcc-12
um                   randconfig-001-20250226    clang-18
um                   randconfig-002-20250226    gcc-12
x86_64                           allnoconfig    clang-19
x86_64     buildonly-randconfig-001-20250226    clang-19
x86_64     buildonly-randconfig-002-20250226    clang-19
x86_64     buildonly-randconfig-003-20250226    gcc-12
x86_64     buildonly-randconfig-004-20250226    clang-19
x86_64     buildonly-randconfig-005-20250226    gcc-12
x86_64     buildonly-randconfig-006-20250226    gcc-12
x86_64                             defconfig    gcc-11
xtensa               randconfig-001-20250226    gcc-14.2.0
xtensa               randconfig-002-20250226    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

