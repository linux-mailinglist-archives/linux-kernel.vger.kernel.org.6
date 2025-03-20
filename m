Return-Path: <linux-kernel+bounces-569004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E2EA69D51
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 01:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31BE718910EE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 00:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE1117A2E2;
	Thu, 20 Mar 2025 00:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jy909zEb"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB902F28
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 00:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742430720; cv=none; b=bgp91NCHxxObs8/R/K9iPPPrfK/gu6mBIZwNEBHJLvTC831Djp2wcAcYEDrwwmVTOizq6f0E9O4qEEKGhzLe1Gr0mHgTNijWBb9O7bnZ8lb+yMWKxBKq3taCj9s5oyzsNFnJazSorUkCztkPHCLK6EWuUTpBUztRD3VUu8WHWAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742430720; c=relaxed/simple;
	bh=wjysitPSMVw6M79WzncihDa7Tcx1VK6OSk2ms6Klo5I=;
	h=Date:From:To:Cc:Subject:Message-ID; b=R5OqsMAhlyJpAPVlomS6brIQpK3J8JbS4dfbEreMHUouSITd1y/lE5pPSKxEeVjlPQVh6vLZRwdHl53hqIyJuNlOgpyr02cnJW9tJO5MXH1O1GqH4WaDqQmds3q54ifD17Y+p4R3hMNi/mjwf9KOcLktGEFzVuOpX/42SR1t2M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jy909zEb; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742430716; x=1773966716;
  h=date:from:to:cc:subject:message-id;
  bh=wjysitPSMVw6M79WzncihDa7Tcx1VK6OSk2ms6Klo5I=;
  b=Jy909zEbjtfjr7f0QsoM5Cry9L42c23C9cn2myMb8VcrrZvsULSuRBFj
   RhkmMjY6SMQZtonM7Fg+cozue/yvTPOyB0VtfQZTOVl4ZRwJO4VLPa4Sv
   npmV/+dfqCMjgKu9rEoQ+x3tVRKOIscAL/Cu2Nobj8Ie2CnpTJjsRe9Ck
   7lbsIk2dkcZQFJWu5Dr2chodmWgnH/NzzWB2BBHf34yViGEjQajHAGEFM
   6wc7XBT1xScbsA04gwrLD7SKKMqGRWkP3DXN1bBjTrkPvII7Bd6DJ5eeF
   OYxUb+wBFCjzxnPe+U4TKSHQZu2TyxRqrCw7nV1l+iBF4ZBVvmuVyL5Mm
   A==;
X-CSE-ConnectionGUID: 6wDaFEzFT1Oo6LOAjuDD3Q==
X-CSE-MsgGUID: 5jGmt/UgTp+73vLHIbEn+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="54310463"
X-IronPort-AV: E=Sophos;i="6.14,260,1736841600"; 
   d="scan'208";a="54310463"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 17:31:55 -0700
X-CSE-ConnectionGUID: 56wDuJEJRFCLTCb0Q3UGog==
X-CSE-MsgGUID: Zv/SzQuPQAaDgcl9W+4CEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,260,1736841600"; 
   d="scan'208";a="122865054"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 19 Mar 2025 17:31:54 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tv3p4-00002f-2W;
	Thu, 20 Mar 2025 00:31:48 +0000
Date: Thu, 20 Mar 2025 08:30:52 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2025.03.17a] BUILD SUCCESS
 594028c4b9138d1babdb7b0abf143e9a5ad5076f
Message-ID: <202503200846.583TANE7-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2025.03.17a
branch HEAD: 594028c4b9138d1babdb7b0abf143e9a5ad5076f  drm/amd/pm: Avoid open-coded use of ratelimit_state structure's ->missed field

elapsed time: 2644m

configs tested: 162
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-6.5.0
alpha                            allyesconfig    gcc-9.3.0
alpha                               defconfig    gcc-7.5.0
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-8.5.0
arc                              allyesconfig    gcc-14.2.0
arc                                 defconfig    gcc-14.2.0
arc                   randconfig-001-20250319    gcc-14.2.0
arc                   randconfig-001-20250320    gcc-10.5.0
arc                   randconfig-002-20250319    gcc-14.2.0
arc                   randconfig-002-20250320    gcc-8.5.0
arc                        vdk_hs38_defconfig    gcc-12.4.0
arm                              allmodconfig    gcc-8.5.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-6.5.0
arm                     am200epdkit_defconfig    gcc-9.3.0
arm                         nhk8815_defconfig    clang-21
arm                   randconfig-001-20250319    clang-18
arm                   randconfig-001-20250320    clang-20
arm                   randconfig-002-20250319    clang-21
arm                   randconfig-002-20250320    clang-16
arm                   randconfig-003-20250319    clang-20
arm                   randconfig-003-20250320    gcc-8.5.0
arm                   randconfig-004-20250319    clang-16
arm                   randconfig-004-20250320    gcc-6.5.0
arm                           stm32_defconfig    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-8.5.0
arm64                               defconfig    gcc-6.5.0
arm64                 randconfig-001-20250319    gcc-7.5.0
arm64                 randconfig-002-20250319    gcc-7.5.0
arm64                 randconfig-003-20250319    gcc-7.5.0
arm64                 randconfig-004-20250319    gcc-7.5.0
csky                              allnoconfig    gcc-9.3.0
csky                  randconfig-001-20250319    gcc-14.2.0
csky                  randconfig-001-20250320    gcc-10.5.0
csky                  randconfig-002-20250319    gcc-10.5.0
csky                  randconfig-002-20250320    gcc-14.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250319    clang-21
hexagon               randconfig-001-20250320    clang-18
hexagon               randconfig-002-20250319    clang-16
hexagon               randconfig-002-20250320    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250319    gcc-12
i386        buildonly-randconfig-002-20250319    gcc-12
i386        buildonly-randconfig-003-20250319    gcc-12
i386        buildonly-randconfig-004-20250319    clang-20
i386        buildonly-randconfig-005-20250319    gcc-12
i386        buildonly-randconfig-006-20250319    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-12.4.0
loongarch                         allnoconfig    gcc-13.3.0
loongarch             randconfig-001-20250319    gcc-14.2.0
loongarch             randconfig-002-20250319    gcc-14.2.0
m68k                             allmodconfig    gcc-8.5.0
m68k                              allnoconfig    gcc-5.5.0
m68k                             allyesconfig    gcc-6.5.0
m68k                        m5307c3_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-9.3.0
microblaze                        allnoconfig    gcc-11.5.0
microblaze                       allyesconfig    gcc-9.3.0
mips                              allnoconfig    gcc-10.5.0
mips                           gcw0_defconfig    clang-14
mips                           ip30_defconfig    gcc-5.5.0
mips                       lemote2f_defconfig    gcc-5.5.0
mips                        omega2p_defconfig    clang-21
mips                        vocore2_defconfig    clang-15
nios2                             allnoconfig    gcc-8.5.0
nios2                 randconfig-001-20250319    gcc-14.2.0
nios2                 randconfig-001-20250320    gcc-6.5.0
nios2                 randconfig-002-20250319    gcc-10.5.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-10.5.0
parisc                            allnoconfig    gcc-10.5.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250319    gcc-10.5.0
parisc                randconfig-002-20250319    gcc-5.5.0
powerpc                          allmodconfig    gcc-5.5.0
powerpc                           allnoconfig    gcc-8.5.0
powerpc                          allyesconfig    clang-21
powerpc                   bluestone_defconfig    clang-21
powerpc                        cell_defconfig    gcc-8.5.0
powerpc                      pmac32_defconfig    clang-21
powerpc               randconfig-001-20250319    gcc-9.3.0
powerpc               randconfig-002-20250319    clang-21
powerpc               randconfig-003-20250319    clang-21
powerpc64             randconfig-001-20250319    clang-20
powerpc64             randconfig-002-20250319    gcc-5.5.0
powerpc64             randconfig-003-20250319    clang-21
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-7.5.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                 randconfig-001-20250319    clang-20
riscv                 randconfig-001-20250320    clang-21
riscv                 randconfig-002-20250319    clang-17
riscv                 randconfig-002-20250320    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-8.5.0
s390                                defconfig    clang-15
s390                  randconfig-001-20250319    gcc-11.5.0
s390                  randconfig-001-20250320    gcc-5.5.0
s390                  randconfig-002-20250319    gcc-8.5.0
s390                  randconfig-002-20250320    gcc-7.5.0
sh                               alldefconfig    gcc-14.2.0
sh                               allmodconfig    gcc-9.3.0
sh                                allnoconfig    gcc-10.5.0
sh                               allyesconfig    gcc-7.5.0
sh                                  defconfig    gcc-11.5.0
sh                    randconfig-001-20250319    gcc-11.5.0
sh                    randconfig-001-20250320    gcc-14.2.0
sh                    randconfig-002-20250319    gcc-14.2.0
sh                    randconfig-002-20250320    gcc-10.5.0
sh                        sh7757lcr_defconfig    gcc-9.3.0
sparc                            allmodconfig    gcc-6.5.0
sparc                             allnoconfig    gcc-6.5.0
sparc                 randconfig-001-20250319    gcc-6.5.0
sparc                 randconfig-001-20250320    gcc-7.5.0
sparc                 randconfig-002-20250319    gcc-13.3.0
sparc                 randconfig-002-20250320    gcc-7.5.0
sparc64                             defconfig    gcc-10.5.0
sparc64               randconfig-001-20250319    gcc-14.2.0
sparc64               randconfig-001-20250320    gcc-5.5.0
sparc64               randconfig-002-20250319    gcc-14.2.0
sparc64               randconfig-002-20250320    gcc-13.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250319    gcc-12
um                    randconfig-001-20250320    gcc-12
um                    randconfig-002-20250319    gcc-11
um                    randconfig-002-20250320    clang-16
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250319    clang-20
x86_64      buildonly-randconfig-001-20250320    clang-20
x86_64      buildonly-randconfig-002-20250319    clang-20
x86_64      buildonly-randconfig-002-20250320    gcc-12
x86_64      buildonly-randconfig-003-20250319    gcc-12
x86_64      buildonly-randconfig-003-20250320    clang-20
x86_64      buildonly-randconfig-004-20250319    gcc-11
x86_64      buildonly-randconfig-005-20250319    clang-20
x86_64      buildonly-randconfig-005-20250320    clang-20
x86_64      buildonly-randconfig-006-20250319    clang-20
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250319    gcc-10.5.0
xtensa                randconfig-001-20250320    gcc-9.3.0
xtensa                randconfig-002-20250319    gcc-14.2.0
xtensa                randconfig-002-20250320    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

