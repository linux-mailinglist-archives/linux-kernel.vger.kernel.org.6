Return-Path: <linux-kernel+bounces-412569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C39F9D0AC1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 09:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80F76B220B0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 08:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F257A170A11;
	Mon, 18 Nov 2024 08:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mrxk7IjG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBAE14A08E
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 08:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731918096; cv=none; b=hCdU3fOmwapBC25zgShUS9XM2Q0ZCz8oujOCTFt77lfp2Sff4YBnlKt008lvOiDriJOtbk5mzW0NP53X7/PjD7YF1IMJgBRq6rxGslm0SjjHtfiNTGzSgjDK6wCPPXrrwQE3b9Atvfi5verE++ENCUgCU5elo+4wX1WYEZaWFmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731918096; c=relaxed/simple;
	bh=aQZwFwYXGT4Q6/+dUVYyDREO3AIOtF17pRAx0OVk1Uw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Sj4EHsuqRliedMuFVVto5IehqC2AVnv8M5cA6AeKGZN8v4rO6rEy+rCTETX80XdbcwQYRdeV4kvZ9ptk4Kv2SF6t6Ihom8Hw3hG/Rb8hv7JaWkkZDtw8yPjaZjI7JQc82Ed1NPw3cxBVQuEt2nRoUh/ZJDWlLFzws8NNpa29VMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mrxk7IjG; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731918094; x=1763454094;
  h=date:from:to:cc:subject:message-id;
  bh=aQZwFwYXGT4Q6/+dUVYyDREO3AIOtF17pRAx0OVk1Uw=;
  b=mrxk7IjG+/fNR38NDoceuG4Pnq4yMFBRjctD+leI63sCrbqHToCxckOB
   KDptdAWGWy20DGbchQqFM+B8xHSgA6vkCxmOQgRH1/xyNDt/PvNsED4/V
   gMEWM1eohQ8spmeTVBlpPVLXg7LsdcfSD+QZ0N7KDzWWg2TY/61wEoNc4
   U/V8wZTJWS2IdxCvEBvTEkyyS4EROZ9AiMmaF8KIXExNheRxOJjzg0yoG
   i9euI4Ecp9RkTI1BpjsU4tWB76yqHtGg6+ZJNoGKCfRezQJNyKc9+lPAt
   1t7GYkcSfIleSwkQWkfz7Omau8wrfX/xZfxahkniuOjnECq9U1hZqK9ts
   Q==;
X-CSE-ConnectionGUID: vfscRZdHTXCLu63FLYjYtw==
X-CSE-MsgGUID: fCPPVC75QuGb5WTr9Mi2Pw==
X-IronPort-AV: E=McAfee;i="6700,10204,11259"; a="42490041"
X-IronPort-AV: E=Sophos;i="6.12,163,1728975600"; 
   d="scan'208";a="42490041"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 00:21:31 -0800
X-CSE-ConnectionGUID: TJ+ry6gRSzGO37CEO6P7MQ==
X-CSE-MsgGUID: mP5+GuzsSG236fAbgTrZ6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="94204281"
Received: from lkp-server01.sh.intel.com (HELO 1e3cc1889ffb) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 18 Nov 2024 00:21:30 -0800
Received: from kbuild by 1e3cc1889ffb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tCx0h-0002KW-2u;
	Mon, 18 Nov 2024 08:21:27 +0000
Date: Mon, 18 Nov 2024 16:20:56 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev] BUILD SUCCESS
 9861a4952a3a33d834b9fa5e5e8075cb9531dd99
Message-ID: <202411181650.0YHQnzTL-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev
branch HEAD: 9861a4952a3a33d834b9fa5e5e8075cb9531dd99  rcutorture: Include grace-period sequence numbers in failure/close-call

elapsed time: 724m

configs tested: 169
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-20
arc                                 defconfig    gcc-14.2.0
arc                   randconfig-001-20241118    gcc-14.2.0
arc                   randconfig-002-20241118    gcc-14.2.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-20
arm                                 defconfig    gcc-14.2.0
arm                            mmp2_defconfig    gcc-14.2.0
arm                       omap2plus_defconfig    gcc-14.2.0
arm                   randconfig-001-20241118    gcc-14.2.0
arm                   randconfig-002-20241118    gcc-14.2.0
arm                   randconfig-003-20241118    gcc-14.2.0
arm                   randconfig-004-20241118    gcc-14.2.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20241118    gcc-14.2.0
arm64                 randconfig-002-20241118    gcc-14.2.0
arm64                 randconfig-003-20241118    gcc-14.2.0
arm64                 randconfig-004-20241118    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20241118    gcc-14.2.0
csky                  randconfig-002-20241118    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20241118    gcc-14.2.0
hexagon               randconfig-002-20241118    gcc-14.2.0
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                             allyesconfig    clang-19
i386        buildonly-randconfig-001-20241118    gcc-12
i386        buildonly-randconfig-002-20241118    gcc-12
i386        buildonly-randconfig-003-20241118    gcc-12
i386        buildonly-randconfig-004-20241118    gcc-12
i386        buildonly-randconfig-005-20241118    gcc-12
i386        buildonly-randconfig-006-20241118    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20241118    gcc-12
i386                  randconfig-002-20241118    gcc-12
i386                  randconfig-003-20241118    gcc-12
i386                  randconfig-004-20241118    gcc-12
i386                  randconfig-005-20241118    gcc-12
i386                  randconfig-006-20241118    gcc-12
i386                  randconfig-011-20241118    gcc-12
i386                  randconfig-012-20241118    gcc-12
i386                  randconfig-013-20241118    gcc-12
i386                  randconfig-014-20241118    gcc-12
i386                  randconfig-015-20241118    gcc-12
i386                  randconfig-016-20241118    gcc-12
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20241118    gcc-14.2.0
loongarch             randconfig-002-20241118    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                          multi_defconfig    gcc-14.2.0
m68k                            q40_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20241118    gcc-14.2.0
nios2                 randconfig-002-20241118    gcc-14.2.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20241118    gcc-14.2.0
parisc                randconfig-002-20241118    gcc-14.2.0
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.2.0
powerpc                   bluestone_defconfig    gcc-14.2.0
powerpc                      ppc44x_defconfig    gcc-14.2.0
powerpc                     rainier_defconfig    gcc-14.2.0
powerpc               randconfig-001-20241118    gcc-14.2.0
powerpc               randconfig-002-20241118    gcc-14.2.0
powerpc               randconfig-003-20241118    gcc-14.2.0
powerpc64             randconfig-001-20241118    gcc-14.2.0
powerpc64             randconfig-002-20241118    gcc-14.2.0
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20241118    gcc-14.2.0
riscv                 randconfig-002-20241118    gcc-14.2.0
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20241118    gcc-14.2.0
s390                  randconfig-002-20241118    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                        dreamcast_defconfig    gcc-14.2.0
sh                             espt_defconfig    gcc-14.2.0
sh                          kfr2r09_defconfig    gcc-14.2.0
sh                    randconfig-001-20241118    gcc-14.2.0
sh                    randconfig-002-20241118    gcc-14.2.0
sh                             shx3_defconfig    gcc-14.2.0
sh                          urquell_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20241118    gcc-14.2.0
sparc64               randconfig-002-20241118    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                             i386_defconfig    gcc-14.2.0
um                    randconfig-001-20241118    gcc-14.2.0
um                    randconfig-002-20241118    gcc-14.2.0
um                           x86_64_defconfig    gcc-12
um                           x86_64_defconfig    gcc-14.2.0
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241118    gcc-12
x86_64      buildonly-randconfig-002-20241118    gcc-12
x86_64      buildonly-randconfig-003-20241118    gcc-12
x86_64      buildonly-randconfig-004-20241118    gcc-12
x86_64      buildonly-randconfig-005-20241118    gcc-12
x86_64      buildonly-randconfig-006-20241118    gcc-12
x86_64                              defconfig    clang-19
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20241118    gcc-12
x86_64                randconfig-002-20241118    gcc-12
x86_64                randconfig-003-20241118    gcc-12
x86_64                randconfig-004-20241118    gcc-12
x86_64                randconfig-005-20241118    gcc-12
x86_64                randconfig-006-20241118    gcc-12
x86_64                randconfig-011-20241118    gcc-12
x86_64                randconfig-012-20241118    gcc-12
x86_64                randconfig-013-20241118    gcc-12
x86_64                randconfig-014-20241118    gcc-12
x86_64                randconfig-015-20241118    gcc-12
x86_64                randconfig-016-20241118    gcc-12
x86_64                randconfig-071-20241118    gcc-12
x86_64                randconfig-072-20241118    gcc-12
x86_64                randconfig-073-20241118    gcc-12
x86_64                randconfig-074-20241118    gcc-12
x86_64                randconfig-075-20241118    gcc-12
x86_64                randconfig-076-20241118    gcc-12
x86_64                               rhel-8.3    gcc-12
xtensa                           alldefconfig    gcc-14.2.0
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20241118    gcc-14.2.0
xtensa                randconfig-002-20241118    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

