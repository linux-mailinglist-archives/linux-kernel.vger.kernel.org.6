Return-Path: <linux-kernel+bounces-368559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B799A1150
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 20:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE784B25137
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 18:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1C9210C1B;
	Wed, 16 Oct 2024 18:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H7WxejpA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FAE18A933
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 18:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729102419; cv=none; b=VlFzFV75t/egPLzWPzvKA+SIMFcyymTGwkAqz5gq1yRNrs2O2EYUhSoNrEgdcUKuZ8KUbFSM0W3V8w6h8FC5gRMI/Lxqj0vEyqAfdcPqXAlGVPTYZ7NyfKhdzFURph+M63LCydYNST3p2w9nWqvtD1Fb4eJTH0FiYTKk1CkSQHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729102419; c=relaxed/simple;
	bh=3fWqLZ8/cKyEB9d/VXMXRwpRVNKHL6GCJ7yAv+Rpg7Y=;
	h=Date:From:To:Cc:Subject:Message-ID; b=uKH/onPjnc5GQXcerHBtKMtVgNOvrHCM2SxmrZ2GDP+uBkEo8lYDlK6nEOj3YhkwAuOT8jdH8shi/LpxDx+Rl63cL1x3YZTS3eGjDi2ihJdhWPc6NS8W63rEIIWT+tdbtKe8+iV2K4PI4cWL/ZFAJL94+pPeK7cqSbZX1L/KZGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H7WxejpA; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729102417; x=1760638417;
  h=date:from:to:cc:subject:message-id;
  bh=3fWqLZ8/cKyEB9d/VXMXRwpRVNKHL6GCJ7yAv+Rpg7Y=;
  b=H7WxejpAILSlOV1A/YS/0fPrE7iEl6S6szXbXtyCKHrE6MfAsojRAV3e
   hiXgp9lQoq+eMblDP1E6FGH64q4k3WrkGLpXDfJwTQwBnkW7g09+eZ0Oa
   Hlf3z0BgWheVRI8GuDFwW50FlZ7y2q6Xxj+hs3/RxXMR5mEtHdJ/GaGyv
   R9pO5POsMmJ/LwWAOCDpvyuoOfAqDlR1QoEk9xGsnrM92a4UJ8LlBDdbP
   CXeKUu+F2Kbk/22wTUW4mWuZ629PWP5I51314HlYZCLiYivuzg64q8WPg
   YWh6tz5CQ5Sw2/bnE1bmlHpLHewhK/xZWbwDqBauQs7UEzGlfzWUBADO1
   w==;
X-CSE-ConnectionGUID: TSr+E3twSMOnLeO4U2Iklg==
X-CSE-MsgGUID: fhAIkWfaSjODO+5FWCpZlA==
X-IronPort-AV: E=McAfee;i="6700,10204,11226"; a="28656547"
X-IronPort-AV: E=Sophos;i="6.11,208,1725346800"; 
   d="scan'208";a="28656547"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 11:13:37 -0700
X-CSE-ConnectionGUID: Ay/z8ywBSZWI5xdpNV34+Q==
X-CSE-MsgGUID: +yLuqgKlRm2cLY1c4Ukigw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,208,1725346800"; 
   d="scan'208";a="83377802"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 16 Oct 2024 11:13:37 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t18Wc-000LER-08;
	Wed, 16 Oct 2024 18:13:34 +0000
Date: Thu, 17 Oct 2024 02:12:34 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:irq/urgent] BUILD SUCCESS
 d038109ac1c6bf619473dda03a16a6de58170f7f
Message-ID: <202410170224.rbrEqSgM-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/urgent
branch HEAD: d038109ac1c6bf619473dda03a16a6de58170f7f  irqchip/renesas-rzg2l: Fix missing put_device

elapsed time: 1164m

configs tested: 97
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                                 defconfig    gcc-14.1.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                                 defconfig    gcc-14.1.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
i386                             allmodconfig    clang-18
i386                              allnoconfig    clang-18
i386                             allyesconfig    clang-18
i386        buildonly-randconfig-001-20241016    gcc-11
i386        buildonly-randconfig-002-20241016    gcc-11
i386        buildonly-randconfig-003-20241016    gcc-11
i386        buildonly-randconfig-004-20241016    gcc-11
i386        buildonly-randconfig-005-20241016    gcc-11
i386        buildonly-randconfig-006-20241016    gcc-11
i386                                defconfig    clang-18
i386                  randconfig-001-20241016    gcc-11
i386                  randconfig-002-20241016    gcc-11
i386                  randconfig-003-20241016    gcc-11
i386                  randconfig-004-20241016    gcc-11
i386                  randconfig-005-20241016    gcc-11
i386                  randconfig-006-20241016    gcc-11
i386                  randconfig-011-20241016    gcc-11
i386                  randconfig-012-20241016    gcc-11
i386                  randconfig-013-20241016    gcc-11
i386                  randconfig-014-20241016    gcc-11
i386                  randconfig-015-20241016    gcc-11
i386                  randconfig-016-20241016    gcc-11
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.1.0
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64                              defconfig    clang-18
x86_64                                  kexec    gcc-12
x86_64                               rhel-8.3    gcc-12
x86_64                           rhel-8.3-bpf    clang-18
x86_64                         rhel-8.3-kunit    clang-18
x86_64                           rhel-8.3-ltp    clang-18
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

