Return-Path: <linux-kernel+bounces-527234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D49FA408BB
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 14:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F81119C26EE
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 13:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453C38634D;
	Sat, 22 Feb 2025 13:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N5y+kkwG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06C778F24
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 13:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740231313; cv=none; b=R0hLNThuiUXw0UOjIvcB/nPD+cqKn6TgFqX+dhyJrs2OFyGq5mWfYyRNGXx2Bd8NbyT5ULgfaT0SmXqBAVRDgoEoGeW6q9+bsAl/JcuTessKPgb2lucjEhXqouvn0RiSbwlAAhWJvpSRKcNgHlhZ+0F+ze1jEQkkAn0HVjDMJVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740231313; c=relaxed/simple;
	bh=ivoRmojhBzn3vXBNQkuQLI2ONk8O5BQ/u1QixnTP0fM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=joUmBaOwk6JmRcpYwUBkBtlrLwmb6i9WpGvBVkqu2tUvUtIplrgTcK4EQ6ArSTypfMhUIgSNobi6Q2kf4tLImVWiKREWHRPLbwMuOaDZYMKmQkH6S2DMGbNQo8uZclE0JWe9yVUiPMvo4o5rhdvnXdpTHOCkH40VUR+J4a40TUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N5y+kkwG; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740231311; x=1771767311;
  h=date:from:to:cc:subject:message-id;
  bh=ivoRmojhBzn3vXBNQkuQLI2ONk8O5BQ/u1QixnTP0fM=;
  b=N5y+kkwGSe86cS26Z9BGLLCh5InkCeFxqlmsYPBJKI1xwvwywgBbCgJ3
   8/7DhPsh1r14t3WYQRaKxt8ZmyLzj74+Ru3D4PG98JloNqHb613q8vA0V
   CBic49rBvj8HFESo82yL/lnUDJ6PPmJsjHhcD1zbEEen4wpthsD7XPO0e
   /+XQAysIP4zm+r135WFtIXzkXUxzQVaWxhp+20MpqIIzGGK2L38XEMIvg
   8zl1lI92L+Nj7YlVGUuAowASyKV8MNu9D9D+jHALG75m/qk+ZRVWzMVo3
   Jj7uBVRu4/J1aQha1wKim+fTCI7mx1kxJskGelYrGPA+KHUZ9syAGaw4h
   w==;
X-CSE-ConnectionGUID: UT2idMqxSpOdEWAipKHF1g==
X-CSE-MsgGUID: RDGhET/6SQizSmdCQZBE6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11353"; a="40275462"
X-IronPort-AV: E=Sophos;i="6.13,308,1732608000"; 
   d="scan'208";a="40275462"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2025 05:35:11 -0800
X-CSE-ConnectionGUID: we76KykeSeajYDK2ZCgkwA==
X-CSE-MsgGUID: QCtCOef4R823/9VuTngsxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,308,1732608000"; 
   d="scan'208";a="138848046"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 22 Feb 2025 05:35:10 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tlpeu-0006c3-0w;
	Sat, 22 Feb 2025 13:35:08 +0000
Date: Sat, 22 Feb 2025 21:34:38 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/asm] BUILD SUCCESS
 7861640aac52bbbb3dc2cd40fb93dfb3b3d0f43c
Message-ID: <202502222132.fUaoyzLQ-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/asm
branch HEAD: 7861640aac52bbbb3dc2cd40fb93dfb3b3d0f43c  x86/build: Raise the minimum LLVM version to 15.0.0

elapsed time: 1453m

configs tested: 62
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                           allyesconfig    gcc-14.2.0
arc                  randconfig-001-20250221    gcc-13.2.0
arc                  randconfig-002-20250221    gcc-13.2.0
arm                  randconfig-001-20250221    gcc-14.2.0
arm                  randconfig-002-20250221    clang-19
arm                  randconfig-003-20250221    gcc-14.2.0
arm                  randconfig-004-20250221    clang-21
arm64                randconfig-001-20250221    clang-15
arm64                randconfig-002-20250221    clang-21
arm64                randconfig-003-20250221    clang-21
arm64                randconfig-004-20250221    gcc-14.2.0
csky                 randconfig-001-20250222    gcc-14.2.0
csky                 randconfig-002-20250222    gcc-14.2.0
hexagon                         allmodconfig    clang-21
hexagon                         allyesconfig    clang-18
hexagon              randconfig-001-20250222    clang-17
hexagon              randconfig-002-20250222    clang-19
i386       buildonly-randconfig-001-20250221    gcc-12
i386       buildonly-randconfig-002-20250221    gcc-12
i386       buildonly-randconfig-003-20250221    gcc-12
i386       buildonly-randconfig-004-20250221    gcc-12
i386       buildonly-randconfig-005-20250221    clang-19
i386       buildonly-randconfig-006-20250221    clang-19
loongarch            randconfig-001-20250222    gcc-14.2.0
loongarch            randconfig-002-20250222    gcc-14.2.0
nios2                randconfig-001-20250222    gcc-14.2.0
nios2                randconfig-002-20250222    gcc-14.2.0
parisc               randconfig-001-20250222    gcc-14.2.0
parisc               randconfig-002-20250222    gcc-14.2.0
powerpc              randconfig-001-20250222    gcc-14.2.0
powerpc              randconfig-002-20250222    gcc-14.2.0
powerpc              randconfig-003-20250222    gcc-14.2.0
powerpc64            randconfig-001-20250222    gcc-14.2.0
powerpc64            randconfig-002-20250222    clang-16
powerpc64            randconfig-003-20250222    clang-18
riscv                randconfig-001-20250222    clang-21
riscv                randconfig-002-20250222    gcc-14.2.0
s390                            allmodconfig    clang-19
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20250222    gcc-14.2.0
s390                 randconfig-002-20250222    clang-15
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20250222    gcc-14.2.0
sh                   randconfig-002-20250222    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20250222    gcc-14.2.0
sparc                randconfig-002-20250222    gcc-14.2.0
sparc64              randconfig-001-20250222    gcc-14.2.0
sparc64              randconfig-002-20250222    gcc-14.2.0
um                              allmodconfig    clang-21
um                              allyesconfig    gcc-12
um                   randconfig-001-20250222    gcc-12
um                   randconfig-002-20250222    gcc-12
x86_64     buildonly-randconfig-001-20250222    clang-19
x86_64     buildonly-randconfig-002-20250222    gcc-12
x86_64     buildonly-randconfig-003-20250222    gcc-12
x86_64     buildonly-randconfig-004-20250222    clang-19
x86_64     buildonly-randconfig-005-20250222    clang-19
x86_64     buildonly-randconfig-006-20250222    gcc-12
xtensa               randconfig-001-20250222    gcc-14.2.0
xtensa               randconfig-002-20250222    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

