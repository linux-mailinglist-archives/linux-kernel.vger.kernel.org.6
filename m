Return-Path: <linux-kernel+bounces-536407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1329A47F35
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DF131889B15
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395BA2356C3;
	Thu, 27 Feb 2025 13:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W0Ta88iu"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBCA2356C0
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 13:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740662813; cv=none; b=VqjdXFyXYADjtRWocqC5zlZ6/w8UhwUxrzuXgvXfrLLIUTZk4rjY2dTmH9U7hpsm7eur0fWWSCPu3WpAhx6AP44jsAsfuBh9OliMrdqYFKPPyliY4dmpJbhRgoDdW4G4wA2v9tTv4D4D10wwKfV/iWJsJqBSgaRSbsl4N0xFLwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740662813; c=relaxed/simple;
	bh=4B35fmDEzZqql9YmZjw5vZ/pcL///qBcV9SAfQqRYLI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=VwCPfRWPTarB0H3vOlaK0pmF3SfNVABa76ebzLEP/quqRa2FOFVb3HZJL/benZayW2jXr7Qg0rq4DNt1Lwx7M8UHUFhNlarDDsChQ63FztI24hNfTAyuP2nxrHm+m5j4nyA8o2diGDLEDpeB15hK1i+U2456rkFtN5GI7eoYJuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W0Ta88iu; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740662811; x=1772198811;
  h=date:from:to:cc:subject:message-id;
  bh=4B35fmDEzZqql9YmZjw5vZ/pcL///qBcV9SAfQqRYLI=;
  b=W0Ta88iuZUaNb2qwSTkvdvH++iDyQyyIc2eMrzJLLuE3UMwB7xOrTuum
   ibb+N1jMk613opFBuBY/kYJUu+TYiPlm3MWWxCqYi5DgmqcthOsPcKtpQ
   qCab4j7GCa4WDERO56bd0GCD1vfP63xgvu/0Rxxd7Ar8KSTCe3YAf3vEB
   kDYJPSx9H0UnQMHHvRaAA/LeMG9w6hA/YAXg4JkGDV4FHWpGVA+48Db2M
   dskZv2383dYx0JixTLbzqLUP1XsZRDXC4YxUz3n72uFVqMROW94vwJi6z
   Ii2pri5i4dRU6K3KdHluUuMRh6hpfbZQqNXx8HAoPmQ+NM655cotNz/mL
   Q==;
X-CSE-ConnectionGUID: eDFA1p0EQ1qeoT+nGzWu/w==
X-CSE-MsgGUID: ic2KnLJDQNaJJlIQmZUvnA==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="51757711"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="51757711"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 05:26:51 -0800
X-CSE-ConnectionGUID: +97dFZXJScaNQXVMkSx24g==
X-CSE-MsgGUID: l0c/FCE+QXWe4eitNunCfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="116821379"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 27 Feb 2025 05:26:50 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tnduZ-000DPE-36;
	Thu, 27 Feb 2025 13:26:47 +0000
Date: Thu, 27 Feb 2025 21:24:41 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/core] BUILD REGRESSION
 dfebe7362f6f461d771cdb9ac2c5172a4721f064
Message-ID: <202502272134.xIfaoU0x-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/core
branch HEAD: dfebe7362f6f461d771cdb9ac2c5172a4721f064  x86/ibt: Optimize the fineibt-bhi arity 1 case

Error/Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202502270859.WfFkfHBC-lkp@intel.com

    vmlinux.o: warning: objtool: do_jit+0x597: relocation to !ENDBR: memcpy_orig+0x0

Error/Warning ids grouped by kconfigs:

recent_errors
`-- x86_64-buildonly-randconfig-002-20250227
    `-- vmlinux.o:warning:objtool:do_jit:relocation-to-ENDBR:memcpy_orig

elapsed time: 1451m

configs tested: 66
configs skipped: 2

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
csky                 randconfig-001-20250227    gcc-14.2.0
csky                 randconfig-002-20250227    gcc-14.2.0
hexagon                         allmodconfig    clang-21
hexagon                         allyesconfig    clang-18
hexagon              randconfig-001-20250227    clang-14
hexagon              randconfig-002-20250227    clang-16
i386       buildonly-randconfig-001-20250226    gcc-12
i386       buildonly-randconfig-002-20250226    gcc-12
i386       buildonly-randconfig-003-20250226    gcc-12
i386       buildonly-randconfig-004-20250226    clang-19
i386       buildonly-randconfig-005-20250226    gcc-12
i386       buildonly-randconfig-006-20250226    gcc-12
loongarch            randconfig-001-20250227    gcc-14.2.0
loongarch            randconfig-002-20250227    gcc-14.2.0
nios2                randconfig-001-20250227    gcc-14.2.0
nios2                randconfig-002-20250227    gcc-14.2.0
openrisc                         allnoconfig    gcc-14.2.0
parisc                           allnoconfig    gcc-14.2.0
parisc               randconfig-001-20250227    gcc-14.2.0
parisc               randconfig-002-20250227    gcc-14.2.0
powerpc                          allnoconfig    gcc-14.2.0
powerpc              randconfig-001-20250227    clang-19
powerpc              randconfig-002-20250227    gcc-14.2.0
powerpc              randconfig-003-20250227    clang-19
powerpc64            randconfig-001-20250227    clang-17
powerpc64            randconfig-002-20250227    clang-21
powerpc64            randconfig-003-20250227    gcc-14.2.0
riscv                            allnoconfig    gcc-14.2.0
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

