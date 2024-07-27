Return-Path: <linux-kernel+bounces-264249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 520A893E0C3
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 22:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15F351C20D1F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 20:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FFD2D057;
	Sat, 27 Jul 2024 20:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wk6XRWXZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336E32F2F
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 20:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722110561; cv=none; b=PQ9vElWlolB1LhWAXbGl+PHo7U5PtxdrEYRexxkNM7wE2bVy17YdWgysbAVbaN6K8g0YQKMx1eVaDWbR8yxZeirpYon9C2xNomQimpbBKL1NN+msesJQ/E37i6Y/OTIj4E4RtyBQwVdD57/VO64lR7CxSfrfTTYOkPTC+9Urho4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722110561; c=relaxed/simple;
	bh=tIpMjeOAe+Ele/b+v4wea+kvWmd9tz52EeejXE1qJwg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Pr7m0wNlwqNndCv6dV+do3hXfCq7W1PxEqeSj8vO+fs8iDmR0IFydI8HDHBUknFYNQ3jD+E13TX3mwx80ykw1atqN0suLi8gCVjV9ebiGEbfFICWoSCgKWaR4nDKJ32bEm7kmvwRb2W7qa6yn5SLrXZChltX01ihnFdnPKT/Xl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wk6XRWXZ; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722110559; x=1753646559;
  h=date:from:to:cc:subject:message-id;
  bh=tIpMjeOAe+Ele/b+v4wea+kvWmd9tz52EeejXE1qJwg=;
  b=Wk6XRWXZe2lB30NonSrVT/52CRfoK/GfkI6TVcIqJ0ZZzXbLgtu93IQt
   OaegJk5xoXppQMG/Dun0fqu8En7b8S4raKCzSoQ12WrRy70l8oibfZcdI
   9Z76ay+my7Log2UgQ/dIQjz+AIXkehqoE7MzOayEfGgnsb4dEvmrtfe5r
   rf223dZ8rYavvVpqmt4m1Ni/TxH9lCwzIAUWKieu6tf61CibGkOU+md/Y
   JerTD3+5WOavLpIbpOKN5Hip7BvGH9dBUhUXG52OgL8bKWUCNVRT8HChf
   ikrO3maqBERlIBWISAFpqaNJpAoPJlbdVj12u18i07L0r62FZ4N8zEq73
   w==;
X-CSE-ConnectionGUID: 649uVlDmSkmUSarRPohrkQ==
X-CSE-MsgGUID: VV0zSLANTLuxcIojdeznyw==
X-IronPort-AV: E=McAfee;i="6700,10204,11146"; a="23639796"
X-IronPort-AV: E=Sophos;i="6.09,242,1716274800"; 
   d="scan'208";a="23639796"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2024 13:02:38 -0700
X-CSE-ConnectionGUID: W4CR+ra3QlyFCb5f1y9zAg==
X-CSE-MsgGUID: 20Oxf9+vT++D/WH3ct2MjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,242,1716274800"; 
   d="scan'208";a="76799856"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 27 Jul 2024 13:02:37 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sXnch-000qCU-1i;
	Sat, 27 Jul 2024 20:02:35 +0000
Date: Sun, 28 Jul 2024 04:02:32 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 c3188d3363745e320501ce7cdb50ba6e6ebd7a6a
Message-ID: <202407280429.dAGhTH0N-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: c3188d3363745e320501ce7cdb50ba6e6ebd7a6a  Merge branch into tip/master: 'x86/mm'

elapsed time: 739m

configs tested: 112
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                   randconfig-001-20240727   gcc-13.2.0
arc                   randconfig-002-20240727   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-20
arm                              allyesconfig   gcc-14.1.0
arm                        clps711x_defconfig   clang-20
arm                      integrator_defconfig   clang-20
arm                        mvebu_v5_defconfig   gcc-14.1.0
arm                          pxa910_defconfig   gcc-14.1.0
arm                   randconfig-001-20240727   gcc-14.1.0
arm                   randconfig-002-20240727   gcc-14.1.0
arm                   randconfig-003-20240727   clang-17
arm                   randconfig-004-20240727   gcc-14.1.0
arm                        shmobile_defconfig   gcc-14.1.0
arm64                            allmodconfig   clang-20
arm64                             allnoconfig   gcc-14.1.0
arm64                 randconfig-001-20240727   clang-20
arm64                 randconfig-002-20240727   gcc-14.1.0
arm64                 randconfig-003-20240727   gcc-14.1.0
arm64                 randconfig-004-20240727   clang-20
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-14.1.0
csky                  randconfig-001-20240727   gcc-14.1.0
csky                  randconfig-002-20240727   gcc-14.1.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   clang-20
hexagon                          allyesconfig   clang-20
hexagon               randconfig-001-20240727   clang-20
hexagon               randconfig-002-20240727   clang-20
i386                             allmodconfig   gcc-13
i386                              allnoconfig   gcc-13
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240727   gcc-13
i386         buildonly-randconfig-002-20240727   clang-18
i386         buildonly-randconfig-003-20240727   gcc-8
i386         buildonly-randconfig-004-20240727   gcc-10
i386         buildonly-randconfig-005-20240727   clang-18
i386         buildonly-randconfig-006-20240727   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240727   clang-18
i386                  randconfig-002-20240727   gcc-8
i386                  randconfig-003-20240727   clang-18
i386                  randconfig-004-20240727   clang-18
i386                  randconfig-005-20240727   clang-18
i386                  randconfig-006-20240727   gcc-13
i386                  randconfig-011-20240727   gcc-13
i386                  randconfig-012-20240727   gcc-13
i386                  randconfig-013-20240727   gcc-11
i386                  randconfig-014-20240727   gcc-13
i386                  randconfig-015-20240727   clang-18
i386                  randconfig-016-20240727   gcc-7
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch             randconfig-001-20240727   gcc-14.1.0
loongarch             randconfig-002-20240727   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                         amcore_defconfig   gcc-14.1.0
m68k                          amiga_defconfig   gcc-14.1.0
m68k                       m5275evb_defconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-14.1.0
nios2                 randconfig-001-20240727   gcc-14.1.0
nios2                 randconfig-002-20240727   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                randconfig-001-20240727   gcc-14.1.0
parisc                randconfig-002-20240727   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-20
powerpc                      arches_defconfig   gcc-14.1.0
powerpc                     ep8248e_defconfig   gcc-14.1.0
powerpc                 xes_mpc85xx_defconfig   gcc-14.1.0
powerpc64             randconfig-001-20240727   clang-20
powerpc64             randconfig-002-20240727   gcc-14.1.0
powerpc64             randconfig-003-20240727   gcc-14.1.0
riscv                            allmodconfig   clang-20
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-20
riscv             nommu_k210_sdcard_defconfig   gcc-14.1.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                        apsh4ad0a_defconfig   gcc-14.1.0
sh                 kfr2r09-romimage_defconfig   gcc-14.1.0
sh                            migor_defconfig   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
um                               allmodconfig   clang-20
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-13
um                           x86_64_defconfig   clang-15
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64                              defconfig   gcc-13
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

