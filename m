Return-Path: <linux-kernel+bounces-528902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F24A41D9C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 066A73ADE52
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 11:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F7125B666;
	Mon, 24 Feb 2025 11:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X9++iHzh"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB66725A2A4
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 11:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740396304; cv=none; b=tFc7CNh7/M8YAHGUBMwg9DOj9YZHr+tEB7ZFG70rBG7T9inAxaZwfKO7d4XpDuspfmFE0ok9IOlVrrXytzH6575kqodGEJPud+rLX1yNPw9UAAOQlt5v0YF8rQeAlnpa6WhTg2vR5H0HUnTzLNlEsp6iDDhXK8JfRmDTWkr6Y1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740396304; c=relaxed/simple;
	bh=0cZgaBH14NLpObEG68Tkv0TKdwmG7fhcGQvr/8yX8tM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=BGcuml8vcpD3ZDxymLrBa+ukROUNopm+OZmUVshauxQeJGXjL7FWCLZXtruDvS+Htdeo4/DR9Zn/Hgu4HaKaYxfLAV3xfBURbTfIgLiHTBtRAEaLPijTty+Hvju906NcmgxmmtaGtgR7lH8nrt6mMDnAHZcQsApxIqI2XCOAQWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X9++iHzh; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740396303; x=1771932303;
  h=date:from:to:cc:subject:message-id;
  bh=0cZgaBH14NLpObEG68Tkv0TKdwmG7fhcGQvr/8yX8tM=;
  b=X9++iHzhMDs98xa1HED4UdOJ2zsdcsabPsgFNW+bb3lYTxQo0LeCDIL+
   QGFTKxcc7F7CM7chgGpy3QIjoxvMnRT+lOtnGsYSDmdaeay4QlCkeCHuA
   04gmXzai8W/lmldQhML6Skk8McusaUpypMq8KRLIOvuWe2Ezo1f4Cdb9f
   6XMHUTpGASJ96OMQNzgLP29RwKUnDUekKRrgHYtQEjH2TBk8TYMC9XX60
   /RBpu0AjLoktxESmW1kT01H55KyM73z21TXJrI+thEKdsKRDJfUpFYsC8
   1WDdOP0WczVfaBHyrR1ZLy0yFXpqJE6M0mf0BGUWmIM5QsJzFh2NT1ojG
   A==;
X-CSE-ConnectionGUID: RI4tsUw4QjCxy3e+4y13Mg==
X-CSE-MsgGUID: zSAELnHKS6e1P4qBeXH5fQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11354"; a="51784469"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="51784469"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 03:25:02 -0800
X-CSE-ConnectionGUID: nDAPZpPGTw2Ppm7uG86sGA==
X-CSE-MsgGUID: 1EgMHyLwSlOlbG9uI/K5yQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="153234089"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 24 Feb 2025 03:25:01 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tmWZy-0008Du-00;
	Mon, 24 Feb 2025 11:24:55 +0000
Date: Mon, 24 Feb 2025 19:24:17 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 82ede9c3e341f31ee1a9725a470acfc370e35f41
Message-ID: <202502241911.0tkMIATN-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 82ede9c3e341f31ee1a9725a470acfc370e35f41  Merge branch into tip/master: 'x86/platform'

elapsed time: 982m

configs tested: 127
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250224    gcc-13.2.0
arc                   randconfig-002-20250224    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                      footbridge_defconfig    clang-17
arm                      jornada720_defconfig    clang-21
arm                   randconfig-001-20250224    gcc-14.2.0
arm                   randconfig-002-20250224    gcc-14.2.0
arm                   randconfig-003-20250224    gcc-14.2.0
arm                   randconfig-004-20250224    gcc-14.2.0
arm                        shmobile_defconfig    gcc-14.2.0
arm                         socfpga_defconfig    gcc-14.2.0
arm                        vexpress_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250224    gcc-14.2.0
arm64                 randconfig-002-20250224    clang-21
arm64                 randconfig-003-20250224    gcc-14.2.0
arm64                 randconfig-004-20250224    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250224    gcc-14.2.0
csky                  randconfig-002-20250224    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250224    clang-21
hexagon               randconfig-002-20250224    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250224    clang-19
i386        buildonly-randconfig-002-20250224    gcc-12
i386        buildonly-randconfig-003-20250224    clang-19
i386        buildonly-randconfig-004-20250224    gcc-12
i386        buildonly-randconfig-005-20250224    clang-19
i386        buildonly-randconfig-006-20250224    clang-19
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                 loongson3_defconfig    gcc-14.2.0
loongarch             randconfig-001-20250224    gcc-14.2.0
loongarch             randconfig-002-20250224    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250224    gcc-14.2.0
nios2                 randconfig-002-20250224    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250224    gcc-14.2.0
parisc                randconfig-002-20250224    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                       holly_defconfig    clang-21
powerpc                  mpc866_ads_defconfig    clang-21
powerpc                    mvme5100_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250224    gcc-14.2.0
powerpc               randconfig-002-20250224    gcc-14.2.0
powerpc               randconfig-003-20250224    gcc-14.2.0
powerpc64             randconfig-002-20250224    clang-18
powerpc64             randconfig-003-20250224    gcc-14.2.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-21
riscv                               defconfig    clang-19
riscv                 randconfig-001-20250224    gcc-14.2.0
riscv                 randconfig-002-20250224    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20250224    gcc-14.2.0
s390                  randconfig-002-20250224    clang-17
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                          landisk_defconfig    gcc-14.2.0
sh                    randconfig-001-20250224    gcc-14.2.0
sh                    randconfig-002-20250224    gcc-14.2.0
sh                           se7343_defconfig    gcc-14.2.0
sparc                            alldefconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250224    gcc-14.2.0
sparc                 randconfig-002-20250224    gcc-14.2.0
sparc                       sparc32_defconfig    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250224    gcc-14.2.0
sparc64               randconfig-002-20250224    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250224    gcc-12
um                    randconfig-002-20250224    gcc-12
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250224    gcc-11
x86_64      buildonly-randconfig-002-20250224    gcc-12
x86_64      buildonly-randconfig-003-20250224    clang-19
x86_64      buildonly-randconfig-004-20250224    gcc-12
x86_64      buildonly-randconfig-005-20250224    clang-19
x86_64      buildonly-randconfig-006-20250224    clang-19
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                  audio_kc705_defconfig    gcc-14.2.0
xtensa                randconfig-001-20250224    gcc-14.2.0
xtensa                randconfig-002-20250224    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

