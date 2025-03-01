Return-Path: <linux-kernel+bounces-540058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9E9A4AD1A
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 18:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C0381897090
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 17:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274A01E503C;
	Sat,  1 Mar 2025 17:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="COw/5Mbg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846DE1C5D61
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 17:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740849976; cv=none; b=hM+7sZKRZCZ1xG43DbAO8s+oxBtAJK4rwV44g6lY2QOkYWJh4t37wODG6dcKJiXG9l2biwsGQc3VULJRTo0ZIO3U6hgLCFaupous4wkiz/+mrln++5FwiY2FUzBlK+xbhxKBOMgrBiHSigM68Li+miivGDdRudcIXNeIuUJrjvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740849976; c=relaxed/simple;
	bh=Nmr7v9g4quCEmGSwh4pBJivQZd0lmQ+ul2uoKV7rldw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=nijG0PtxZCgPlHRX1dLKnVs7hIkPBKGJeOHsL9XqSmjU/n7auHCYeD6amUxWEwI4iuMAXnhPEIUv6exD/nAeSfvQmv9N6LEItuY/dxNYBSAhCvp6J90XzsfEJBWWFZ0CrBf95Vzqa+W87T/50GmS5QK5QZPAlUSabIc4B6w5EtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=COw/5Mbg; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740849974; x=1772385974;
  h=date:from:to:cc:subject:message-id;
  bh=Nmr7v9g4quCEmGSwh4pBJivQZd0lmQ+ul2uoKV7rldw=;
  b=COw/5Mbgxjbglyf5ujqtRnHiToG4+zJZCDuMrxx3MxWsccbJQ2qTNJp1
   cxSbO5vY+mbV9aSUjSHIR1p1GOj9MKvsQXjFQho0CXCuwyRzWrrVX9rL+
   LnxZ52vEjTTneWYb+XX1kBoks9kx4LJvzSdfZevZ280tR8rCd8UnzG4Jz
   xhMgpMP8Fi5lonIC8ZMoGrvrqhepHYZQUJDv1Aawhl7v4lRC5qE7Ly3xY
   JfIc0lBgeQD8mgCmdJzXA4XKm5OZCWJqHOY277o1MzjXMKukHtNc5ESgQ
   eAUVFNlcLamjWjSXumLhqmOq9I3FF5eXylPXuTSYULyGoCXnPjqdNR2za
   A==;
X-CSE-ConnectionGUID: FkUuvFKOTlKn7yUcr+6XsA==
X-CSE-MsgGUID: FtNTRDiuQpGHWX7SVaPRVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11360"; a="41791931"
X-IronPort-AV: E=Sophos;i="6.13,325,1732608000"; 
   d="scan'208";a="41791931"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2025 09:26:14 -0800
X-CSE-ConnectionGUID: T0VYsaWEQuuyyfWx5PUmmg==
X-CSE-MsgGUID: LcK94JNJTQqbmF+IQSY7kQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="122856260"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 01 Mar 2025 09:26:14 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1toQbK-000GUB-2J;
	Sat, 01 Mar 2025 17:26:10 +0000
Date: Sun, 02 Mar 2025 01:26:07 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/cpu] BUILD SUCCESS
 e85ef9aaa1cc2129e98cc935179f75ac8f250960
Message-ID: <202503020101.Ed6IhPk4-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cpu
branch HEAD: e85ef9aaa1cc2129e98cc935179f75ac8f250960  x86/cpufeatures: Use AWK to generate {REQUIRED|DISABLED}_MASK_BIT_SET

elapsed time: 1457m

configs tested: 66
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                           allyesconfig    gcc-14.2.0
arc                  randconfig-001-20250301    gcc-13.2.0
arc                  randconfig-002-20250301    gcc-13.2.0
arm                  randconfig-001-20250301    gcc-14.2.0
arm                  randconfig-002-20250301    gcc-14.2.0
arm                  randconfig-003-20250301    clang-21
arm                  randconfig-004-20250301    clang-21
arm64                randconfig-001-20250301    gcc-14.2.0
arm64                randconfig-002-20250301    clang-21
arm64                randconfig-003-20250301    clang-15
arm64                randconfig-004-20250301    clang-17
csky                 randconfig-001-20250301    gcc-14.2.0
csky                 randconfig-002-20250301    gcc-14.2.0
hexagon                         allmodconfig    clang-21
hexagon                         allyesconfig    clang-18
hexagon              randconfig-001-20250301    clang-21
hexagon              randconfig-002-20250301    clang-21
i386       buildonly-randconfig-001-20250301    clang-19
i386       buildonly-randconfig-002-20250301    clang-19
i386       buildonly-randconfig-003-20250301    clang-19
i386       buildonly-randconfig-004-20250301    clang-19
i386       buildonly-randconfig-005-20250301    gcc-12
i386       buildonly-randconfig-006-20250301    clang-19
loongarch            randconfig-001-20250301    gcc-14.2.0
loongarch            randconfig-002-20250301    gcc-14.2.0
nios2                randconfig-001-20250301    gcc-14.2.0
nios2                randconfig-002-20250301    gcc-14.2.0
openrisc                         allnoconfig    gcc-14.2.0
parisc                           allnoconfig    gcc-14.2.0
parisc               randconfig-001-20250301    gcc-14.2.0
parisc               randconfig-002-20250301    gcc-14.2.0
powerpc                          allnoconfig    gcc-14.2.0
powerpc              randconfig-001-20250301    clang-17
powerpc              randconfig-002-20250301    clang-19
powerpc              randconfig-003-20250301    clang-21
powerpc64            randconfig-001-20250301    gcc-14.2.0
powerpc64            randconfig-002-20250301    clang-21
powerpc64            randconfig-003-20250301    gcc-14.2.0
riscv                            allnoconfig    gcc-14.2.0
riscv                randconfig-001-20250301    gcc-14.2.0
riscv                randconfig-002-20250301    gcc-14.2.0
s390                            allmodconfig    clang-19
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20250301    clang-15
s390                 randconfig-002-20250301    gcc-14.2.0
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20250301    gcc-14.2.0
sh                   randconfig-002-20250301    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20250301    gcc-14.2.0
sparc                randconfig-002-20250301    gcc-14.2.0
sparc64              randconfig-001-20250301    gcc-14.2.0
sparc64              randconfig-002-20250301    gcc-14.2.0
um                              allmodconfig    clang-21
um                              allyesconfig    gcc-12
um                   randconfig-001-20250301    gcc-12
um                   randconfig-002-20250301    gcc-12
x86_64     buildonly-randconfig-001-20250301    clang-19
x86_64     buildonly-randconfig-002-20250301    clang-19
x86_64     buildonly-randconfig-003-20250301    gcc-11
x86_64     buildonly-randconfig-004-20250301    gcc-12
x86_64     buildonly-randconfig-005-20250301    gcc-12
x86_64     buildonly-randconfig-006-20250301    clang-19
xtensa               randconfig-001-20250301    gcc-14.2.0
xtensa               randconfig-002-20250301    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

