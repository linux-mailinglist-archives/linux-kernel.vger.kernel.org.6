Return-Path: <linux-kernel+bounces-319179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E773896F907
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 18:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 110551C21EDD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 16:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD261D31B9;
	Fri,  6 Sep 2024 16:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GQqX5L2a"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73299156880
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 16:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725638928; cv=none; b=IPLHl3DCuFgulTQoqHwz/DzIVhHQmdr4trJBAy58jCAqEqFkrItF9yAwG0ksWE6OGjJ++I5s+1IpbSk2/kBaBTVR6QL2PCbWgYbulRiLgGLiYA6XDitEsY3jP4jQWsMh7g05QnJ/zk9Q0aSJXJcmvgNdNLpGsFyiQfs/TeQNtOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725638928; c=relaxed/simple;
	bh=EEPnW6LB4zj+vyT061YrwlUkBzbpRmsKB9QKu4Z1gh8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=kITqdCm5TraKYi40udxKbtgeZmm1+hRck0ZsLsEnQwHfntRozpMpMVBWa614U1ptjQacqPj5Bm3wi7/qF3EkTK2EXHJQcTSFNRZyWyWIhs17e2/ZtBP7Wl3+jMZ2x1ATsuRG1cmV5VwQ2EKTyrRvHtsMnb61vn2QTzZ4+iIpYMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GQqX5L2a; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725638926; x=1757174926;
  h=date:from:to:cc:subject:message-id;
  bh=EEPnW6LB4zj+vyT061YrwlUkBzbpRmsKB9QKu4Z1gh8=;
  b=GQqX5L2aeTZdPdfe/ZTR18Ub9Weo7nHeI/KyybEQ4BtuzzIf3kbI46bf
   Py75rwHB/BQnxjEPRJ7D/JeIMVzS6p8U3Lra/cNQ/BRVmp6YUuUfEEBDF
   SCX8sWC2Zk4cS9+FVjrMwGDmvwTBeYto2e/kyb2MfzpToyoYp9Ouf6vQe
   vAp2Mz61YHfuQXBJkXdIH5el8f/ChjiLytR02O8fyC3SB35vhhwzgL/AQ
   mRBiiPERPDKqHVvGBg4dEpgQHr8oKCEO/K0hrmFwiQH/wO1k0wcRtbCbc
   4fB9QzrsRlprCQKO5Az1Oe2TJshokHQPr5HBCeogy2vjsuqQ2MvmoJVhl
   Q==;
X-CSE-ConnectionGUID: 7CB3C6tLTNCszUhjk1Mr4Q==
X-CSE-MsgGUID: FbXSgNnVRNqyCBL3AFmVGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11187"; a="24352671"
X-IronPort-AV: E=Sophos;i="6.10,208,1719903600"; 
   d="scan'208";a="24352671"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 09:08:31 -0700
X-CSE-ConnectionGUID: 7ZdgmZctQ0KiKC9KFnmKHw==
X-CSE-MsgGUID: cUgtkkpATai6XXWG2CJOWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,208,1719903600"; 
   d="scan'208";a="70941798"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 06 Sep 2024 09:08:31 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1smbVc-000BSw-1U;
	Fri, 06 Sep 2024 16:08:28 +0000
Date: Sat, 07 Sep 2024 00:08:22 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/bugs] BUILD SUCCESS
 1dbb6b1495d472806fef1f4c94f5b3e4c89a3c1d
Message-ID: <202409070020.AgqtX5td-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/bugs
branch HEAD: 1dbb6b1495d472806fef1f4c94f5b3e4c89a3c1d  x86/bugs: Fix handling when SRSO mitigation is disabled

elapsed time: 1796m

configs tested: 112
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   clang-20
alpha                            allyesconfig   gcc-13.3.0
arc                              allmodconfig   clang-20
arc                              allmodconfig   gcc-13.2.0
arc                              allyesconfig   clang-20
arc                              allyesconfig   gcc-13.2.0
arc                   randconfig-001-20240906   gcc-13.2.0
arc                   randconfig-002-20240906   gcc-13.2.0
arm                              allmodconfig   clang-20
arm                              allmodconfig   gcc-14.1.0
arm                              allyesconfig   clang-20
arm                              allyesconfig   gcc-14.1.0
arm                   randconfig-001-20240906   clang-20
arm                   randconfig-002-20240906   gcc-14.1.0
arm                   randconfig-003-20240906   gcc-14.1.0
arm                   randconfig-004-20240906   gcc-14.1.0
arm64                            allmodconfig   clang-20
arm64                 randconfig-001-20240906   clang-20
arm64                 randconfig-002-20240906   clang-17
arm64                 randconfig-003-20240906   gcc-14.1.0
arm64                 randconfig-004-20240906   gcc-14.1.0
csky                  randconfig-001-20240906   gcc-14.1.0
csky                  randconfig-002-20240906   gcc-14.1.0
hexagon                          allmodconfig   clang-20
hexagon                          allyesconfig   clang-20
hexagon               randconfig-001-20240906   clang-20
hexagon               randconfig-002-20240906   clang-14
i386                             allmodconfig   gcc-12
i386                              allnoconfig   gcc-12
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240906   clang-18
i386         buildonly-randconfig-002-20240906   gcc-12
i386         buildonly-randconfig-003-20240906   clang-18
i386         buildonly-randconfig-004-20240906   gcc-12
i386         buildonly-randconfig-005-20240906   clang-18
i386         buildonly-randconfig-006-20240906   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240906   gcc-12
i386                  randconfig-002-20240906   clang-18
i386                  randconfig-003-20240906   gcc-12
i386                  randconfig-004-20240906   clang-18
i386                  randconfig-005-20240906   clang-18
i386                  randconfig-006-20240906   gcc-12
i386                  randconfig-011-20240906   gcc-12
i386                  randconfig-012-20240906   clang-18
i386                  randconfig-013-20240906   gcc-12
i386                  randconfig-014-20240906   gcc-12
i386                  randconfig-015-20240906   gcc-12
i386                  randconfig-016-20240906   gcc-12
loongarch                        allmodconfig   gcc-14.1.0
loongarch             randconfig-001-20240906   gcc-14.1.0
loongarch             randconfig-002-20240906   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
nios2                 randconfig-001-20240906   gcc-14.1.0
nios2                 randconfig-002-20240906   gcc-14.1.0
openrisc                          allnoconfig   clang-20
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   clang-20
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                randconfig-001-20240906   gcc-14.1.0
parisc                randconfig-002-20240906   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   clang-20
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-20
powerpc                          allyesconfig   gcc-14.1.0
powerpc               randconfig-001-20240906   clang-17
powerpc               randconfig-002-20240906   gcc-14.1.0
powerpc               randconfig-003-20240906   clang-15
powerpc64             randconfig-001-20240906   clang-20
powerpc64             randconfig-002-20240906   clang-15
powerpc64             randconfig-003-20240906   clang-20
riscv                            allmodconfig   clang-20
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   clang-20
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-20
riscv                            allyesconfig   gcc-14.1.0
riscv                 randconfig-001-20240906   gcc-14.1.0
riscv                 randconfig-002-20240906   clang-20
s390                             allmodconfig   clang-20
s390                             allmodconfig   gcc-14.1.0
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                  randconfig-001-20240906   clang-20
s390                  randconfig-002-20240906   clang-20
sh                               allmodconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                    randconfig-001-20240906   gcc-14.1.0
sh                    randconfig-002-20240906   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64               randconfig-001-20240906   gcc-14.1.0
sparc64               randconfig-002-20240906   gcc-14.1.0
um                               allmodconfig   clang-20
um                                allnoconfig   clang-17
um                                allnoconfig   clang-20
um                               allyesconfig   clang-20
um                               allyesconfig   gcc-12
um                    randconfig-001-20240906   clang-20
um                    randconfig-002-20240906   clang-20
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64                              defconfig   gcc-11
x86_64                          rhel-8.3-rust   clang-18
xtensa                randconfig-001-20240906   gcc-14.1.0
xtensa                randconfig-002-20240906   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

