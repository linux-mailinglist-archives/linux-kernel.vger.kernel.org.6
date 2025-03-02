Return-Path: <linux-kernel+bounces-540791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9658A4B4E1
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 22:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C90781891438
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 21:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D6C1EB9ED;
	Sun,  2 Mar 2025 21:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q+FGqOJd"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E192AEF1
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 21:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740949700; cv=none; b=UsRH1iQHfyEwi/C481+CvpX7gcxYSeWNPPno27ctLXLrOuYYvlDllFlYTcfY8jLzc6g6ILlCk0ONmkn0CQhP4ZPlB4zzKaCIxsquzLb8glMtQD35jEIF6MGXmAwlUUQe3kKh97lxx3iZReo0oXj9cA0YM0USufAh0pad9iU8DIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740949700; c=relaxed/simple;
	bh=PVAlmWWGwBTfXHnCDRBOeSAPwua231gSQq3dyUHgQDo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=qx+V7j/TIcaHPZ6ibARBXryjk6/akIXDIL1yBRVCK+O1nm7qIBPSxpL0hXCy7M7cFi+u4MOmEm11hRVDg2LaBQFigdnBsJReJRk6NCMhfLytNEfXO9s9D8qVYPvOzhqnj/v2jd8V7Iig5krvbOSpdqUrJCLrVO9iCNyrpcA+Xa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q+FGqOJd; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740949698; x=1772485698;
  h=date:from:to:cc:subject:message-id;
  bh=PVAlmWWGwBTfXHnCDRBOeSAPwua231gSQq3dyUHgQDo=;
  b=Q+FGqOJdHN8Q27peks+P5S/IGAk4PKg68nMkedKrA5xNCVPwI5ECdUtN
   K0elF6U3xoOYo+hJPrx/QP0wQuhmcbJu151dloti9ynYdN/rw+lc02B9I
   WS3Y7QPRtF1oW0QWTk5emGsVTqtPMs+Pnx41AqI9KGdiI4hqp83IR8qlN
   fkGnHyqtk8P/F31yubKPr/rxIvFXExV1eLF8cR70yQeuLaG4vkVphOeCV
   3juHhUS36sThIbM/4C57dD5SUCs4UwNOs9OoiVElVdpx1YOktultDQYP/
   DUCQRFkta08+MfE+an4xbMvh/1+IWAJ2VtO8VcUDU2WkymyLQqPGhiFfN
   w==;
X-CSE-ConnectionGUID: HiBn84NWRyyfrcRoG7H3YQ==
X-CSE-MsgGUID: UMsZFa8vRZSFvJGsAK4ywA==
X-IronPort-AV: E=McAfee;i="6700,10204,11361"; a="52461599"
X-IronPort-AV: E=Sophos;i="6.13,328,1732608000"; 
   d="scan'208";a="52461599"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2025 13:08:14 -0800
X-CSE-ConnectionGUID: Qd0fPNltQz2RDwtXysCdWA==
X-CSE-MsgGUID: 6kO/o+QQRweRiBe8wy30Iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,328,1732608000"; 
   d="scan'208";a="117852675"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 02 Mar 2025 13:08:14 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1toqXj-000HdW-1B;
	Sun, 02 Mar 2025 21:08:11 +0000
Date: Mon, 03 Mar 2025 05:07:12 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:perf/urgent] BUILD SUCCESS
 003659fec9f6d8c04738cb74b5384398ae8a7e88
Message-ID: <202503030505.7y08lZLY-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/urgent
branch HEAD: 003659fec9f6d8c04738cb74b5384398ae8a7e88  perf/core: Fix perf_pmu_register() vs. perf_init_event()

elapsed time: 1448m

configs tested: 126
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250302    gcc-13.2.0
arc                   randconfig-002-20250302    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                      integrator_defconfig    clang-15
arm                   randconfig-001-20250302    gcc-14.2.0
arm                   randconfig-002-20250302    clang-21
arm                   randconfig-003-20250302    gcc-14.2.0
arm                   randconfig-004-20250302    clang-21
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250302    clang-18
arm64                 randconfig-002-20250302    gcc-14.2.0
arm64                 randconfig-003-20250302    gcc-14.2.0
arm64                 randconfig-004-20250302    clang-16
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250302    gcc-14.2.0
csky                  randconfig-002-20250302    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250302    clang-21
hexagon               randconfig-002-20250302    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250302    gcc-12
i386        buildonly-randconfig-002-20250302    clang-19
i386        buildonly-randconfig-003-20250302    gcc-12
i386        buildonly-randconfig-004-20250302    gcc-12
i386        buildonly-randconfig-005-20250302    gcc-12
i386        buildonly-randconfig-006-20250302    gcc-12
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250302    gcc-14.2.0
loongarch             randconfig-002-20250302    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                        mvme16x_defconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                        bcm47xx_defconfig    clang-21
mips                         bigsur_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250302    gcc-14.2.0
nios2                 randconfig-002-20250302    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250302    gcc-14.2.0
parisc                randconfig-002-20250302    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                      cm5200_defconfig    clang-21
powerpc                      ep88xc_defconfig    gcc-14.2.0
powerpc                    gamecube_defconfig    clang-16
powerpc                      pasemi_defconfig    clang-21
powerpc                     ppa8548_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250302    gcc-14.2.0
powerpc               randconfig-002-20250302    gcc-14.2.0
powerpc               randconfig-003-20250302    clang-16
powerpc                     tqm8540_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250302    gcc-14.2.0
powerpc64             randconfig-003-20250302    gcc-14.2.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-21
riscv                               defconfig    clang-19
riscv                 randconfig-001-20250302    clang-21
riscv                 randconfig-002-20250302    clang-16
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                          debug_defconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20250302    clang-17
s390                  randconfig-002-20250302    clang-19
sh                               alldefconfig    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                             espt_defconfig    gcc-14.2.0
sh                    randconfig-001-20250302    gcc-14.2.0
sh                    randconfig-002-20250302    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250302    gcc-14.2.0
sparc                 randconfig-002-20250302    gcc-14.2.0
sparc64                          alldefconfig    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250302    gcc-14.2.0
sparc64               randconfig-002-20250302    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250302    gcc-12
um                    randconfig-002-20250302    clang-16
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250302    clang-19
x86_64      buildonly-randconfig-002-20250302    clang-19
x86_64      buildonly-randconfig-003-20250302    gcc-12
x86_64      buildonly-randconfig-004-20250302    gcc-12
x86_64      buildonly-randconfig-005-20250302    gcc-12
x86_64      buildonly-randconfig-006-20250302    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250302    gcc-14.2.0
xtensa                randconfig-002-20250302    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

