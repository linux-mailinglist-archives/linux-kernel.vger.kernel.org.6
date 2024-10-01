Return-Path: <linux-kernel+bounces-345821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0966798BB7E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 13:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47495B21A60
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 11:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50CDF1BFE0A;
	Tue,  1 Oct 2024 11:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D57CNCLs"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61543209
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 11:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727783416; cv=none; b=WAaWAFIq4rNmiQFhtI3W+Ixod7rZiYhi/zSMwysZmEdxshLFDimld2WYQ2iZ3CB/foE7kFEqfz/jJUwP65CQbWYyUUb2dTx9evZMHdEyRbSs+sonvkw0i5PnV1vu3xylk9ZPlllog5a21P2DKH5A6v4AKw2AojczEMFF+0/SGXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727783416; c=relaxed/simple;
	bh=vtB23zFTm9kT7DFFu5Zw3Mo1HhkPyxDU+zN4zG16ytE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=YP6VHE0VQaMTNleAbbH3v91VETFbbSZWDzThdjaKu8nBF183XcpkgGNyo3weaH98q/hoKtFZ3hNdi5vJtiMU4xNYNvjMxzbuLcusPENmAJtiU9djOX7Oz/zAY3hE8x8q+ijFG1w9WKAkQ+aZsrsClYVgEaSJF3WePZeu6KyXfD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D57CNCLs; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727783415; x=1759319415;
  h=date:from:to:cc:subject:message-id;
  bh=vtB23zFTm9kT7DFFu5Zw3Mo1HhkPyxDU+zN4zG16ytE=;
  b=D57CNCLsEXZTowJ9NJ0XOGBcQpkmy4igODqRKh+dztL6WIdltlmlMep9
   aDxoIWQKdF+QLiO7AqwNHOo0HMrD1ItpB6n9jBlvrscbvbUZ2NJJKJBKj
   Kb3UnYK6BJAQJVWr0WIF/+t4/29hp6WlQLWpw7/GJVZMxRV/y2ymekP7H
   AHGTV2gPcRV22/Q79qbqyHFtYWbmiWxGYkujgKWz06BvF7+HB99x0bl+P
   beaKnioko8mLOeMyt+42va72oNWEZhMFRdmGA6aFzX3Qj2zAnki2/O3M/
   usvg5QVW4Mse8A0GQ+AaXo36z9uLcPwYi1mjj5gns6N3ePwIjLZsfZtlE
   A==;
X-CSE-ConnectionGUID: qkFwWHuWSseMnZcuaoZOew==
X-CSE-MsgGUID: 14eLxFvPTHm941kk0kyklQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="30706007"
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="30706007"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 04:50:15 -0700
X-CSE-ConnectionGUID: pvbiwyDvQ3eUpouu5ck03w==
X-CSE-MsgGUID: wp87xVrXTxaUWzBjAXtdJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="104472529"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 01 Oct 2024 04:50:13 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1svbOM-000QdJ-2k;
	Tue, 01 Oct 2024 11:50:10 +0000
Date: Tue, 01 Oct 2024 19:49:27 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev] BUILD SUCCESS
 3ad89520895aa3a428fb41517e2f066167122d85
Message-ID: <202410011922.y6nCysR0-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev
branch HEAD: 3ad89520895aa3a428fb41517e2f066167122d85  EXP rcutorture: Limit callback flooding for Tiny SRCU in preemptible kernels

elapsed time: 1076m

configs tested: 91
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                       allnoconfig    gcc-14.1.0
alpha                      allyesconfig    clang-20
alpha                         defconfig    gcc-14.1.0
arc                        allmodconfig    clang-20
arc                         allnoconfig    gcc-14.1.0
arc                        allyesconfig    clang-20
arc                    axs103_defconfig    gcc-14.1.0
arc                           defconfig    gcc-14.1.0
arm                        allmodconfig    clang-20
arm                         allnoconfig    gcc-14.1.0
arm                        allyesconfig    clang-20
arm                    collie_defconfig    gcc-14.1.0
arm               davinci_all_defconfig    gcc-14.1.0
arm                           defconfig    gcc-14.1.0
arm                   lpc18xx_defconfig    gcc-14.1.0
arm                 versatile_defconfig    gcc-14.1.0
arm64                      allmodconfig    clang-20
arm64                       allnoconfig    gcc-14.1.0
arm64                         defconfig    gcc-14.1.0
csky                        allnoconfig    gcc-14.1.0
csky                          defconfig    gcc-14.1.0
hexagon                    allmodconfig    clang-20
hexagon                     allnoconfig    gcc-14.1.0
hexagon                    allyesconfig    clang-20
hexagon                       defconfig    gcc-14.1.0
i386                       allmodconfig    clang-18
i386                        allnoconfig    clang-18
i386                       allyesconfig    clang-18
i386                          defconfig    clang-18
loongarch                  allmodconfig    gcc-14.1.0
loongarch                   allnoconfig    gcc-14.1.0
loongarch                     defconfig    gcc-14.1.0
m68k                       allmodconfig    gcc-14.1.0
m68k                        allnoconfig    gcc-14.1.0
m68k                       allyesconfig    gcc-14.1.0
m68k                          defconfig    gcc-14.1.0
microblaze                 allmodconfig    gcc-14.1.0
microblaze                  allnoconfig    gcc-14.1.0
microblaze                 allyesconfig    gcc-14.1.0
microblaze                    defconfig    gcc-14.1.0
mips                        allnoconfig    gcc-14.1.0
mips                   db1xxx_defconfig    gcc-14.1.0
mips                     rs90_defconfig    gcc-14.1.0
nios2                       allnoconfig    gcc-14.1.0
nios2                         defconfig    gcc-14.1.0
openrisc                    allnoconfig    clang-20
openrisc                   allyesconfig    gcc-14.1.0
openrisc                      defconfig    gcc-12
openrisc            or1klitex_defconfig    gcc-14.1.0
parisc                     allmodconfig    gcc-14.1.0
parisc                      allnoconfig    clang-20
parisc                     allyesconfig    gcc-14.1.0
parisc                        defconfig    gcc-12
parisc64                      defconfig    gcc-14.1.0
powerpc                    allmodconfig    gcc-14.1.0
powerpc                     allnoconfig    clang-20
powerpc                    allyesconfig    gcc-14.1.0
powerpc           canyonlands_defconfig    gcc-14.1.0
powerpc                  cell_defconfig    gcc-14.1.0
powerpc                  fsp2_defconfig    gcc-14.1.0
powerpc         mpc834x_itxgp_defconfig    gcc-14.1.0
powerpc                   wii_defconfig    gcc-14.1.0
riscv                      allmodconfig    gcc-14.1.0
riscv                       allnoconfig    clang-20
riscv                      allyesconfig    gcc-14.1.0
riscv                         defconfig    gcc-12
s390                       allmodconfig    gcc-14.1.0
s390                        allnoconfig    clang-20
s390                       allyesconfig    gcc-14.1.0
s390                          defconfig    gcc-12
sh                         alldefconfig    gcc-14.1.0
sh                         allmodconfig    gcc-14.1.0
sh                          allnoconfig    gcc-14.1.0
sh                         allyesconfig    gcc-14.1.0
sh                            defconfig    gcc-12
sh          ecovec24-romimage_defconfig    gcc-14.1.0
sh                      titan_defconfig    gcc-14.1.0
sh                        ul2_defconfig    gcc-14.1.0
sparc                      allmodconfig    gcc-14.1.0
sparc64                       defconfig    gcc-12
um                         allmodconfig    clang-20
um                          allnoconfig    clang-20
um                         allyesconfig    clang-20
um                            defconfig    gcc-12
um                       i386_defconfig    gcc-12
um                     x86_64_defconfig    gcc-12
x86_64                      allnoconfig    clang-18
x86_64                     allyesconfig    clang-18
x86_64                        defconfig    clang-18
x86_64                    rhel-8.3-rust    clang-18
xtensa                      allnoconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

