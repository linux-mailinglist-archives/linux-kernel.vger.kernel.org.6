Return-Path: <linux-kernel+bounces-538399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25410A49826
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 12:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92DFB7A5039
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 11:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BEDC2620CD;
	Fri, 28 Feb 2025 11:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VXt/I3mx"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779C626038A
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 11:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740741172; cv=none; b=KK5XlGF96ou/psSj+VeMQLuWYIFKMipgJk4iJG6ysOkPA+8OtS1s9GLrBZrxvgivMsggJ1Rez68S+ZiHSuTPJwtbN5kdD3qfqbNgwvtVpyBloHQziOIj8WpzCpqrxQcwrqzCQuuB1xmaAIOXzy9fzSHSLdQj9Wr2uXj3ASbl8Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740741172; c=relaxed/simple;
	bh=1JWldVHt1VVgfCSGKh2WVpkPReDi0s3j3JifpXieDfg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ZON2sc09U3FXFPBbryd61SOzNG/HXzPK8tuDCpcd89iCKlkS8EKn+6Cra07T6Z58d0fTEjLfTknoIGIBT/to/StOGa68i/2d0F5Sghqn0sLb21gEv9SFhzAL7zeTEqsWiJYiwake83G6EdDNR3tu5s4412z9gZ/LjZjwieOS+u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VXt/I3mx; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740741170; x=1772277170;
  h=date:from:to:cc:subject:message-id;
  bh=1JWldVHt1VVgfCSGKh2WVpkPReDi0s3j3JifpXieDfg=;
  b=VXt/I3mxkhhY/KzFuigu3iE0iOywZriUV5dc7C55kY6HXv+TYfYtCLns
   vmVos2sq1HcUxsTLq0eDI1H2E9dYkRPvyguMTEGuuJNrdZTbhDercdg7m
   SWFXPGNXYtdzYi+Tym17QjHgG8LuowQ4ghvXJEDodrMfefYXvCrhf+Rhn
   7VKgAy+B8XnNb6jyUGq0TY+/DVZ3Q/5AjYJywYj93LixHgrVwKFBtye3s
   mUnICNnKISY2qbLZULoCk3TW1SKJoYqFj/fve65F5e/BnjBJSuql4s3Tw
   uWpDidNPBy98sxhte3dJzRzHmB9HAh5BZkWpPO1z7xWPEuR45VnGDBA8t
   Q==;
X-CSE-ConnectionGUID: eIhbDqioSIWoi3UVBtJEdQ==
X-CSE-MsgGUID: ETec4xx7Qn6cuQTEQfKUCg==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="52652348"
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; 
   d="scan'208";a="52652348"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 03:12:50 -0800
X-CSE-ConnectionGUID: NCcFD0dwQ3mgV6eEeo4a0Q==
X-CSE-MsgGUID: 9VJQkreHQ4egX5FcQNFLvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="122543637"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 28 Feb 2025 03:12:49 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tnyIQ-000Emw-2S;
	Fri, 28 Feb 2025 11:12:46 +0000
Date: Fri, 28 Feb 2025 19:12:20 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/bugs] BUILD SUCCESS
 8f64eee70cdd3bb8c3ec7d30f0d1f52922aaef7c
Message-ID: <202502281912.gzFdZeGq-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/bugs
branch HEAD: 8f64eee70cdd3bb8c3ec7d30f0d1f52922aaef7c  x86/bugs: Remove X86_FEATURE_USE_IBPB

elapsed time: 1479m

configs tested: 83
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                           allyesconfig    gcc-14.2.0
arc                             allmodconfig    gcc-13.2.0
arc                             allyesconfig    gcc-13.2.0
arc                  randconfig-001-20250227    gcc-13.2.0
arc                  randconfig-002-20250227    gcc-13.2.0
arm                             allmodconfig    gcc-14.2.0
arm                             allyesconfig    gcc-14.2.0
arm                  randconfig-001-20250227    gcc-14.2.0
arm                  randconfig-002-20250227    clang-17
arm                  randconfig-003-20250227    gcc-14.2.0
arm                  randconfig-004-20250227    clang-21
arm64                           allmodconfig    clang-18
arm64                randconfig-001-20250227    gcc-14.2.0
arm64                randconfig-002-20250227    clang-19
arm64                randconfig-003-20250227    gcc-14.2.0
arm64                randconfig-004-20250227    gcc-14.2.0
csky                 randconfig-001-20250227    gcc-14.2.0
csky                 randconfig-002-20250227    gcc-14.2.0
hexagon                         allmodconfig    clang-21
hexagon                         allyesconfig    clang-18
hexagon              randconfig-001-20250227    clang-14
hexagon              randconfig-002-20250227    clang-16
i386                            allmodconfig    gcc-12
i386                             allnoconfig    gcc-12
i386                            allyesconfig    gcc-12
i386       buildonly-randconfig-001-20250227    gcc-12
i386       buildonly-randconfig-002-20250227    gcc-11
i386       buildonly-randconfig-003-20250227    clang-19
i386       buildonly-randconfig-004-20250227    gcc-12
i386       buildonly-randconfig-005-20250227    gcc-11
i386       buildonly-randconfig-006-20250227    clang-19
i386                               defconfig    clang-19
loongarch            randconfig-001-20250227    gcc-14.2.0
loongarch            randconfig-002-20250227    gcc-14.2.0
nios2                randconfig-001-20250227    gcc-14.2.0
nios2                randconfig-002-20250227    gcc-14.2.0
openrisc                         allnoconfig    gcc-14.2.0
openrisc                        allyesconfig    gcc-14.2.0
parisc                           allnoconfig    gcc-14.2.0
parisc                          allyesconfig    gcc-14.2.0
parisc               randconfig-001-20250227    gcc-14.2.0
parisc               randconfig-002-20250227    gcc-14.2.0
powerpc                          allnoconfig    gcc-14.2.0
powerpc                         allyesconfig    clang-16
powerpc              randconfig-001-20250227    clang-19
powerpc              randconfig-002-20250227    gcc-14.2.0
powerpc              randconfig-003-20250227    clang-19
powerpc64            randconfig-001-20250227    clang-17
powerpc64            randconfig-002-20250227    clang-21
powerpc64            randconfig-003-20250227    gcc-14.2.0
riscv                            allnoconfig    gcc-14.2.0
riscv                randconfig-001-20250227    gcc-14.2.0
riscv                randconfig-002-20250227    gcc-14.2.0
s390                            allmodconfig    clang-19
s390                             allnoconfig    clang-15
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20250227    clang-18
s390                 randconfig-002-20250227    gcc-14.2.0
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20250227    gcc-14.2.0
sh                   randconfig-002-20250227    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20250227    gcc-14.2.0
sparc                randconfig-002-20250227    gcc-14.2.0
sparc64              randconfig-001-20250227    gcc-14.2.0
sparc64              randconfig-002-20250227    gcc-14.2.0
um                              allmodconfig    clang-21
um                               allnoconfig    clang-18
um                              allyesconfig    gcc-12
um                   randconfig-001-20250227    clang-17
um                   randconfig-002-20250227    gcc-12
x86_64                           allnoconfig    clang-19
x86_64                          allyesconfig    clang-19
x86_64     buildonly-randconfig-001-20250227    clang-19
x86_64     buildonly-randconfig-002-20250227    clang-19
x86_64     buildonly-randconfig-003-20250227    gcc-12
x86_64     buildonly-randconfig-004-20250227    gcc-12
x86_64     buildonly-randconfig-005-20250227    clang-19
x86_64     buildonly-randconfig-006-20250227    gcc-12
x86_64                             defconfig    gcc-11
xtensa               randconfig-001-20250227    gcc-14.2.0
xtensa               randconfig-002-20250227    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

