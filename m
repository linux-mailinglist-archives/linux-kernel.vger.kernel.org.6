Return-Path: <linux-kernel+bounces-552056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 793AEA574C9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 23:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0C9318840BA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 22:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A17A208973;
	Fri,  7 Mar 2025 22:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LG4SqV2n"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427EF23FC52
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 22:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741385578; cv=none; b=I5G5+tsNQwXGQtSqh+WpzOvKon6ZZt6Cr0GtQIarrD++5GAhxbpJO4f97tF680J1Y83odPZP/+DBPvjGMSmc0f6iDqkeyDkFBmPTfWHTl6OS8z0DYp9PuyDmRwhqoYHqaiHyzAI6h/5QYPD0jT/z+4Ox7JzbLr/gOrpJKV/S9Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741385578; c=relaxed/simple;
	bh=kTI7dHREt7t/KwTqadiBL9xTRq3dBehxPwWkugxa8Cg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=F4LEL9UBoS9IcWLYs4Zd5XCd8ZcKY2stStxPz7G5fcUsZ7vAN8EtiGdRi3YXrOdbUpTRVNqji9wt6oTDf8tEgmd5m/bt0Lody/FYYy+pQCGQRx0ssxkavCwMEcPgyqRwbERnNjwz94m/S+T6V7Gzo2AikVNXZrBEKcH0RiOc4IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LG4SqV2n; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741385577; x=1772921577;
  h=date:from:to:cc:subject:message-id;
  bh=kTI7dHREt7t/KwTqadiBL9xTRq3dBehxPwWkugxa8Cg=;
  b=LG4SqV2nOkTw0FkLlp6a/exs/rh/zaTV5ALoNA/GXGH0eSHzz5pWF6dn
   yVSgbvjbDYxV8p6B5DLJku6Fex259g+JcsGro7Sdtuzh6IIDbdefu/Q2G
   qmT0dh7MSsn1sJaVbxHAaxzzSHcSMy3MBbl6EbwoW5IrC8ZisB44BoHhY
   xsWs6cjp/KWkhfDe2ZF7P7q0VHCHZ6NxRo2if0ycy7pOnuSnizqIDWQVX
   ir2t+fxv8lerVYrrXJRnZO8lxQH3ufZAhuRUmsLH3ULqLnRIMNdtL4nfU
   3GbPEf9kfiJiMKcVzAXXHQ35TXbomATZeDfvs+4GPea1vMxePS3pD6Gld
   g==;
X-CSE-ConnectionGUID: UEEPFRFJSfiupban7E7SrQ==
X-CSE-MsgGUID: C4G6kDMqQEq1YvIFKUJcaw==
X-IronPort-AV: E=McAfee;i="6700,10204,11366"; a="59851116"
X-IronPort-AV: E=Sophos;i="6.14,230,1736841600"; 
   d="scan'208";a="59851116"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 14:12:57 -0800
X-CSE-ConnectionGUID: BLdsi9eqSYyzb6yepajrmQ==
X-CSE-MsgGUID: NadItwtgSD2jDjNslapCgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,230,1736841600"; 
   d="scan'208";a="119424551"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 07 Mar 2025 14:12:56 -0800
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tqfw5-00017t-1Q;
	Fri, 07 Mar 2025 22:12:53 +0000
Date: Sat, 08 Mar 2025 06:12:31 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:perf/core] BUILD SUCCESS
 7a310c644cf571fbdb1d447a1dc39cf048634589
Message-ID: <202503080626.RNicOZ2V-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core
branch HEAD: 7a310c644cf571fbdb1d447a1dc39cf048634589  perf/x86/intel/bts: Check if bts_ctx is allocated when calling BTS functions

elapsed time: 1454m

configs tested: 57
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
arc                  randconfig-001-20250307    gcc-13.2.0
arc                  randconfig-002-20250307    gcc-13.2.0
arm                  randconfig-001-20250307    clang-21
arm                  randconfig-002-20250307    gcc-14.2.0
arm                  randconfig-003-20250307    clang-19
arm                  randconfig-004-20250307    clang-21
arm64                randconfig-001-20250307    gcc-14.2.0
arm64                randconfig-002-20250307    clang-15
arm64                randconfig-003-20250307    gcc-14.2.0
arm64                randconfig-004-20250307    clang-15
csky                 randconfig-001-20250307    gcc-14.2.0
csky                 randconfig-002-20250307    gcc-14.2.0
hexagon              randconfig-001-20250307    clang-21
hexagon              randconfig-002-20250307    clang-21
i386       buildonly-randconfig-001-20250307    clang-19
i386       buildonly-randconfig-002-20250307    clang-19
i386       buildonly-randconfig-003-20250307    gcc-11
i386       buildonly-randconfig-004-20250307    clang-19
i386       buildonly-randconfig-005-20250307    gcc-12
i386       buildonly-randconfig-006-20250307    clang-19
loongarch            randconfig-001-20250307    gcc-14.2.0
loongarch            randconfig-002-20250307    gcc-14.2.0
nios2                randconfig-001-20250307    gcc-14.2.0
nios2                randconfig-002-20250307    gcc-14.2.0
parisc               randconfig-001-20250307    gcc-14.2.0
parisc               randconfig-002-20250307    gcc-14.2.0
powerpc              randconfig-001-20250307    gcc-14.2.0
powerpc              randconfig-002-20250307    clang-21
powerpc              randconfig-003-20250307    clang-19
powerpc64            randconfig-001-20250307    clang-21
powerpc64            randconfig-002-20250307    gcc-14.2.0
powerpc64            randconfig-003-20250307    gcc-14.2.0
riscv                randconfig-001-20250307    gcc-14.2.0
riscv                randconfig-002-20250307    clang-19
s390                            allmodconfig    clang-19
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20250307    gcc-14.2.0
s390                 randconfig-002-20250307    gcc-14.2.0
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20250307    gcc-14.2.0
sh                   randconfig-002-20250307    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20250307    gcc-14.2.0
sparc                randconfig-002-20250307    gcc-14.2.0
sparc64              randconfig-001-20250307    gcc-14.2.0
sparc64              randconfig-002-20250307    gcc-14.2.0
um                   randconfig-001-20250307    clang-17
um                   randconfig-002-20250307    clang-21
x86_64     buildonly-randconfig-001-20250307    clang-19
x86_64     buildonly-randconfig-002-20250307    gcc-12
x86_64     buildonly-randconfig-003-20250307    clang-19
x86_64     buildonly-randconfig-004-20250307    clang-19
x86_64     buildonly-randconfig-005-20250307    clang-19
x86_64     buildonly-randconfig-006-20250307    gcc-12
xtensa               randconfig-001-20250307    gcc-14.2.0
xtensa               randconfig-002-20250307    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

