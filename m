Return-Path: <linux-kernel+bounces-534738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D2FA46A95
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 20:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F049B188823A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AFEA23719E;
	Wed, 26 Feb 2025 19:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NRhtJ3Ma"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FE021E096
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 19:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740596701; cv=none; b=Bph+omq0QbdLKjTQZYZByEd6q/npIF68OE4SrCf5qRI43qNJ1+KM8nMHH6Q50irj3G7uWas8826hfySxfCsHIubG5CM1M+oB37wHTq4rcR8sI6NNSYiIX0RLg7g5LwDX9Kx830Q/zmXsPDVzR44eZHPLqG2OaTu/O63R4+FJzeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740596701; c=relaxed/simple;
	bh=oObld18sy9ycD1axG9R4X3r+PCnCflSuK4sPzqBaqzY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=HpxT7swLTBlR+pHPHkcFEAR9Nu3ybV2UYI3H9D7lGSO4Pu52X2ZkMzusKpKM5nNsWqMVnW/Wa+ickyoG+7lja0UAOdf+SrzLOJXOMxrnCRzTHJZYI+bHkGu7bOf3WVq0P0lkWksUYDIEZZWMT7Im5f9ooA+H98movs4vzpHJ/Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NRhtJ3Ma; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740596700; x=1772132700;
  h=date:from:to:cc:subject:message-id;
  bh=oObld18sy9ycD1axG9R4X3r+PCnCflSuK4sPzqBaqzY=;
  b=NRhtJ3MaPuK9svPyYascElnd5e+St6rRnkOCr2VXZ8XFTOAKEN4qokhA
   ry9AUG+v/J6542mqmdvpPm3LjlGhw75ENuAO3J1IPW/Y4Y5i5kSiYHcxQ
   S7yQPrrP9wbRt0asmuftvtXl4H20VjI0Dq/WbawCSRmGoGMPaqJ4r2bLq
   9qbKpuTltAqTTHll4JAeqt34AcOghU1JeSaodBY4S4eE2aJZD2wuJQcEV
   Nalq2SRVqe+zXKGDs2Gv0aCrfPKZe95QcPWCX90NhR5tjalCGfdTGFiAz
   h6bPxNWOKWlXJoz5YjABN19eEDYLpgUvOdtT9ejSEQ6a/qdJOlkMPrVmJ
   Q==;
X-CSE-ConnectionGUID: B1ttoZCDShywulWjPmMOEg==
X-CSE-MsgGUID: jb9RxUI1SQuCsfE/lY3mow==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="29062028"
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; 
   d="scan'208";a="29062028"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 11:04:59 -0800
X-CSE-ConnectionGUID: pHF2lCznQdm8MrQsY9eK+Q==
X-CSE-MsgGUID: LfTNifjQQG+pj2P5BCQu4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; 
   d="scan'208";a="117421641"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 26 Feb 2025 11:04:57 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tnMiG-000CH8-0s;
	Wed, 26 Feb 2025 19:04:56 +0000
Date: Thu, 27 Feb 2025 03:04:34 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2025.02.24a] BUILD SUCCESS
 d6558730a4def01aa55c442dbbc5b32640c06c0e
Message-ID: <202502270328.CwJRapr6-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2025.02.24a
branch HEAD: d6558730a4def01aa55c442dbbc5b32640c06c0e  EXP hrtimers: Force migrate away hrtimers queued after CPUHP_AP_HRTIMERS_DYING

elapsed time: 2637m

configs tested: 62
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
parisc               randconfig-001-20250226    gcc-14.2.0
parisc               randconfig-002-20250226    gcc-14.2.0
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
x86_64     buildonly-randconfig-001-20250226    clang-19
x86_64     buildonly-randconfig-002-20250226    clang-19
x86_64     buildonly-randconfig-003-20250226    gcc-12
x86_64     buildonly-randconfig-004-20250226    clang-19
x86_64     buildonly-randconfig-005-20250226    gcc-12
x86_64     buildonly-randconfig-006-20250226    gcc-12
xtensa               randconfig-001-20250226    gcc-14.2.0
xtensa               randconfig-002-20250226    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

