Return-Path: <linux-kernel+bounces-513134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81865A341FB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 15:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 124CF188CA34
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5BB281360;
	Thu, 13 Feb 2025 14:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eHcN8Tyn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681F628134C
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739456744; cv=none; b=rRppWpSsHvpPQ/fqSunMh6PG7KGOfDFJ8Mrn28rDSUUttOK3P6CdBVGYTxD9ubSH/tlFPkFmC/0p0yuxEIRxB29q5OuxRqwYDhOIvw9IcNX6lRwQtl51frdaM1evdvldRSdWFZerRxjjzDrnX4TIjqfVfzFr6Q8hGEUHgvCsdNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739456744; c=relaxed/simple;
	bh=Fm0UqvgeCXFJhUsgtuGyEQ7ZeNYeibD2js7kd1cyvtg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Qm9fQhybuRKsaTc3PQ8IoxZqVbbOwsDtCNLroVVQ1PdQSNdw/Z2Sy4stpkqdGGQlgzknFavjrJPjVQudOIqFbpwHAtq24/oUIgO4ft/uQaNxR+hQ60aIbqMAyGGGELvNMU+qNAMZJ0rZyxRzyk+soFYhwgSlzUgDKbGEk1Pcqc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eHcN8Tyn; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739456742; x=1770992742;
  h=date:from:to:cc:subject:message-id;
  bh=Fm0UqvgeCXFJhUsgtuGyEQ7ZeNYeibD2js7kd1cyvtg=;
  b=eHcN8Tyn79wHYn2U4mQCIYrD+bd6kCpe6dJ/yC+Uy6vWtr2TuXFn2P0u
   2H+xcIlqh9P3RftdFf5NMenFi84LpEfdqJz5VuT1e/qQGZCGXxH4D9nsS
   24GHCUXaoHozWxUQxnUaK6du9F2mY1GpDexMaKQImOecfD+pwxrbQbiv/
   vpDa31Jsx3Bn6XoqnDOGnwBLwPnV0Mnc/jNxzed7MquD8Yyp6ff2PyNW8
   rxDrziy4m+rBY7kbA6ZkQlVaOI0lIPhWCxw/yR8jJaxwTYuFTUFKexRBP
   yy9YovplmBuQ8MA2Auv+WPnh8hpf+SZ+jQPzXxAsuz4yvXI5KYAzVSHO0
   w==;
X-CSE-ConnectionGUID: h70mE8UtS1+ZkMfcXLH/ww==
X-CSE-MsgGUID: sLRv6DLDS8m25QUUIp2aSg==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="44090796"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="44090796"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 06:25:41 -0800
X-CSE-ConnectionGUID: +pU3cm2tTx+GfE/ojFSOXg==
X-CSE-MsgGUID: tuCnPKE9Se25DnDJMIYhEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="112911548"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 13 Feb 2025 06:25:40 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tia9q-00178x-0z;
	Thu, 13 Feb 2025 14:25:38 +0000
Date: Thu, 13 Feb 2025 22:25:23 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev] BUILD SUCCESS
 0dbe27f7470315be0ac2acfd546a60c5af5adca0
Message-ID: <202502132216.GLtplRRJ-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev
branch HEAD: 0dbe27f7470315be0ac2acfd546a60c5af5adca0  rcutorture: Check for ->up_read() without matching ->down_read()

elapsed time: 1442m

configs tested: 54
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
arc                  randconfig-001-20250213    gcc-13.2.0
arc                  randconfig-002-20250213    gcc-13.2.0
arm                  randconfig-001-20250213    clang-17
arm                  randconfig-002-20250213    clang-15
arm                  randconfig-003-20250213    clang-21
arm                  randconfig-004-20250213    gcc-14.2.0
arm64                randconfig-001-20250213    clang-19
arm64                randconfig-002-20250213    gcc-14.2.0
arm64                randconfig-003-20250213    gcc-14.2.0
arm64                randconfig-004-20250213    clang-21
csky                 randconfig-001-20250213    gcc-14.2.0
csky                 randconfig-002-20250213    gcc-14.2.0
hexagon              randconfig-001-20250213    clang-21
hexagon              randconfig-002-20250213    clang-18
i386       buildonly-randconfig-001-20250213    gcc-12
i386       buildonly-randconfig-002-20250213    clang-19
i386       buildonly-randconfig-003-20250213    clang-19
i386       buildonly-randconfig-004-20250213    clang-19
i386       buildonly-randconfig-005-20250213    clang-19
i386       buildonly-randconfig-006-20250213    clang-19
loongarch            randconfig-001-20250213    gcc-14.2.0
loongarch            randconfig-002-20250213    gcc-14.2.0
nios2                randconfig-001-20250213    gcc-14.2.0
nios2                randconfig-002-20250213    gcc-14.2.0
parisc               randconfig-001-20250213    gcc-14.2.0
parisc               randconfig-002-20250213    gcc-14.2.0
powerpc              randconfig-001-20250213    clang-17
powerpc              randconfig-002-20250213    gcc-14.2.0
powerpc              randconfig-003-20250213    gcc-14.2.0
powerpc64            randconfig-001-20250213    clang-19
powerpc64            randconfig-002-20250213    clang-21
powerpc64            randconfig-003-20250213    gcc-14.2.0
riscv                randconfig-001-20250213    clang-19
riscv                randconfig-002-20250213    clang-17
s390                 randconfig-001-20250213    gcc-14.2.0
s390                 randconfig-002-20250213    clang-21
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20250213    gcc-14.2.0
sh                   randconfig-002-20250213    gcc-14.2.0
sparc                randconfig-001-20250213    gcc-14.2.0
sparc                randconfig-002-20250213    gcc-14.2.0
sparc64              randconfig-001-20250213    gcc-14.2.0
sparc64              randconfig-002-20250213    gcc-14.2.0
um                   randconfig-001-20250213    clang-19
um                   randconfig-002-20250213    clang-21
x86_64     buildonly-randconfig-001-20250213    gcc-11
x86_64     buildonly-randconfig-002-20250213    gcc-12
x86_64     buildonly-randconfig-003-20250213    clang-19
x86_64     buildonly-randconfig-004-20250213    gcc-12
x86_64     buildonly-randconfig-005-20250213    gcc-12
x86_64     buildonly-randconfig-006-20250213    gcc-12
xtensa               randconfig-001-20250213    gcc-14.2.0
xtensa               randconfig-002-20250213    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

