Return-Path: <linux-kernel+bounces-534970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C073A46D65
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 22:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5C961888B92
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 21:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90202257AD7;
	Wed, 26 Feb 2025 21:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VvvEOims"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B0B21ABB4
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 21:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740605230; cv=none; b=hi6RFNrUozFnR4QBTn6O6y8AXF2k3amtp4bQGbsJ+y7BS0RI8pLk3PjV6u+n1yTfHm2d3GeMTUcelgUMKYkLGzzpC1sGuhsMk4wfXblH1Phu6bV0yORWAdSuXuRbhiBLw/nrM1T94hUbG/v7sF3bu7RbFwXS38SCx30HGpZ4FQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740605230; c=relaxed/simple;
	bh=61ANiR1iehyO0k28G1LeSomHl280SCXwJSq1uVzIqVc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=o+BzTkG7Y+JvfjxNR3pBYRUcbQQxJ3XXz5Lgg0MTxeoUlQ87oENWT9+HKIW1DVuNzZZ/TGC55DxEfti//U20iLhIZIbqgQeMrSzRtX1PLWPJS+3ANPiNMlR0HaPiSCrcA+otHy/FtkAThHUI5HMDCsBtrqK8kws4N5pRRmmTqdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VvvEOims; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740605229; x=1772141229;
  h=date:from:to:cc:subject:message-id;
  bh=61ANiR1iehyO0k28G1LeSomHl280SCXwJSq1uVzIqVc=;
  b=VvvEOimsWwfQenGHGsT/XOYaYg7kqQr3Apfhr6ZV2Al6LOVRs+W6r1Ga
   h6AvkrJ52ggjgfT2pRalzauGQpSv5kdJBJqFVTu0Aq5CIXpZpyB5xLb2k
   3xo/r2SDpxhcDhM6joeu+xPXiIYMJ6AUSx3hD/LECpBmg1VYjJgUOET4D
   s8UeKHLadEEgldiaKlGTlOrS1WiL8mmWE29viIS8oSyhYaTX2DZlZAuRv
   bPFi5FXh7QF61c6QbNwSVj30qkFB6FKOPWrF4BHrzU4z0AE7tkHpnwZJ4
   hi8oth3GFhNF+SjwvR6u7YDx5n3LnNmf4FLxxfv9baZtqdP7MgPamcx05
   A==;
X-CSE-ConnectionGUID: ZLpkF1yWSICrg3jOcbpy5g==
X-CSE-MsgGUID: 6/DtNFvzRf2Wux9/61GtaQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="41674294"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="41674294"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 13:27:08 -0800
X-CSE-ConnectionGUID: yEW1sl6rSrOBSmsdGLc3vw==
X-CSE-MsgGUID: poGoCTPSSL6bp1Bv+x/9pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,318,1732608000"; 
   d="scan'208";a="140043999"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 26 Feb 2025 13:27:06 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tnOvn-000CTZ-0q;
	Wed, 26 Feb 2025 21:27:03 +0000
Date: Thu, 27 Feb 2025 05:26:52 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/asm] BUILD SUCCESS
 79165720f31868d9a9f7e5a50a09d5fe510d1822
Message-ID: <202502270547.KhgIqJjs-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/asm
branch HEAD: 79165720f31868d9a9f7e5a50a09d5fe510d1822  x86/percpu: Construct __percpu_seg_override from __percpu_seg

elapsed time: 1452m

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

