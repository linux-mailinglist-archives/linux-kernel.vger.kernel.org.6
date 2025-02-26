Return-Path: <linux-kernel+bounces-535166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EDFBA46FB8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 00:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0A0C7A3357
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 23:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1417225BABA;
	Wed, 26 Feb 2025 23:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UGTlOc+S"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E361E27004B
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 23:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740614024; cv=none; b=H26pYVDKewxDNSFCnP70l68pufWok3DB12j19PYn43R4Cyvgr9cohyJA5ckUvCb6murSSmHXdKvm42yZaiHHtsdcajTHlNcU+Unni2adIo8mtwt3lqEGUzK89SrcmEOhtjCKTIdUR+4BiqGX2w1GgIu87wNaUEtUwMB2swHnis0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740614024; c=relaxed/simple;
	bh=PpixIuc7c9S8Znm6fEduLybMhupHbzKyiowTmier0F8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=q4cIJsof4VK9gnBfuE6cvvCw3rWsdP1GBGjetjrSxk6TRmu+1bye0TTuTm2xH/p1q1TNl8KEdNt9EO9w657j8bSVTuCHbfJKrQt3AOMadSnIKBlnc210XU58Exc+ERv12dG1MmE+9H0McaOSLpoXg5JnGWzhZRjoQT4yExs/Fyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UGTlOc+S; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740614023; x=1772150023;
  h=date:from:to:cc:subject:message-id;
  bh=PpixIuc7c9S8Znm6fEduLybMhupHbzKyiowTmier0F8=;
  b=UGTlOc+SDfSKRS8loo6PehFpTbcs2eVu1Vlp1Cu5Sa349OgHrP82+taS
   gKwOEk+NBYp1+2xgO4hCb/mUU7wktClE6CFOwkFdZBhh3mJLbLy2mniog
   J3e+6tyVOIDQkKNJkG9D0Ov7xZDwxNE9yXBMCEOi3pQvXRtL9LfeXJnOq
   DdEA0Tf/9fjFVxLSUetEvZxYJZBbAJ8rDtl3iUKMIcEmQtarHoAy/TGg7
   z/noaSlnrxJer2s3ZVx5hhw3oC64U/+X0qysDeBW+jZG0Js+DmPFekn1P
   RV/U3W0E4PF5YTl9eNQ5JN1VKIv1uvfJuNC1H8SccwGBVxZABH9PD/iJ/
   g==;
X-CSE-ConnectionGUID: dp+zQYlsQz6Kh1bXMhQapQ==
X-CSE-MsgGUID: GavE7akyTEG1zU8FuMh7bw==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="41508831"
X-IronPort-AV: E=Sophos;i="6.13,318,1732608000"; 
   d="scan'208";a="41508831"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 15:53:42 -0800
X-CSE-ConnectionGUID: 5vJBm1kEQg+mN7ylKazjhw==
X-CSE-MsgGUID: 6eQpmwJYRFGpS/m5UtKf/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,318,1732608000"; 
   d="scan'208";a="116852250"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 26 Feb 2025 15:53:39 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tnRDZ-000CcA-38;
	Wed, 26 Feb 2025 23:53:35 +0000
Date: Thu, 27 Feb 2025 07:53:04 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:perf/urgent] BUILD SUCCESS
 f8c857238a392f21d5726d07966f6061007c8d4f
Message-ID: <202502270759.UC9vXWXL-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/urgent
branch HEAD: f8c857238a392f21d5726d07966f6061007c8d4f  uprobes: Remove too strict lockdep_assert() condition in hprobe_expire()

elapsed time: 1454m

configs tested: 80
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-14.2.0
alpha                           allyesconfig    gcc-14.2.0
arc                             allmodconfig    gcc-13.2.0
arc                              allnoconfig    gcc-13.2.0
arc                             allyesconfig    gcc-13.2.0
arc                  randconfig-001-20250226    gcc-13.2.0
arc                  randconfig-002-20250226    gcc-13.2.0
arm                              allnoconfig    clang-17
arm                        assabet_defconfig    clang-21
arm                          h3600_defconfig    gcc-14.2.0
arm                           mps2_defconfig    clang-15
arm                  randconfig-001-20250226    gcc-14.2.0
arm                  randconfig-002-20250226    clang-21
arm                  randconfig-003-20250226    gcc-14.2.0
arm                  randconfig-004-20250226    gcc-14.2.0
arm                          spitz_defconfig    gcc-14.2.0
arm64                            allnoconfig    gcc-14.2.0
arm64                randconfig-001-20250226    gcc-14.2.0
arm64                randconfig-002-20250226    gcc-14.2.0
arm64                randconfig-003-20250226    clang-21
arm64                randconfig-004-20250226    gcc-14.2.0
csky                             allnoconfig    gcc-14.2.0
csky                 randconfig-001-20250226    gcc-14.2.0
csky                 randconfig-002-20250226    gcc-14.2.0
hexagon                          allnoconfig    clang-21
hexagon                         allyesconfig    clang-18
hexagon              randconfig-001-20250226    clang-21
hexagon              randconfig-002-20250226    clang-21
i386       buildonly-randconfig-001-20250226    gcc-12
i386       buildonly-randconfig-002-20250226    gcc-12
i386       buildonly-randconfig-003-20250226    gcc-12
i386       buildonly-randconfig-004-20250226    clang-19
i386       buildonly-randconfig-005-20250226    gcc-12
i386       buildonly-randconfig-006-20250226    gcc-12
loongarch                        allnoconfig    gcc-14.2.0
loongarch            randconfig-001-20250226    gcc-14.2.0
loongarch            randconfig-002-20250226    gcc-14.2.0
m68k                         hp300_defconfig    gcc-14.2.0
nios2                randconfig-001-20250226    gcc-14.2.0
nios2                randconfig-002-20250226    gcc-14.2.0
parisc               randconfig-001-20250226    gcc-14.2.0
parisc               randconfig-002-20250226    gcc-14.2.0
parisc64                        alldefconfig    gcc-14.1.0
powerpc              mpc834x_itxgp_defconfig    clang-18
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
sh                          se7751_defconfig    gcc-14.2.0
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

