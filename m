Return-Path: <linux-kernel+bounces-303692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F38189613CB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 18:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 240BF1C2344D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 16:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2047B1C6896;
	Tue, 27 Aug 2024 16:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VMzNBhRt"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7876B1C8FBB
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 16:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724775302; cv=none; b=qklQEeqyZ1mBsuME3tAGuJf1snh7HZtESIjakaw204J9GslCylGMwbytOcphetr7rnyUjhjLZN1/QTfaLIHeHc1zFRAsGWO1RSWMA3M/hlyT7RimAOlGJaPElmR2aJ3DaFdphnvIaawudp8L+MeZyqQE3gzEQZ13zT1rusUjtX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724775302; c=relaxed/simple;
	bh=IaEmR/LMdzGwp5aDzRS9OLm8ySuq2Ld+mY5QB22Q71w=;
	h=Date:From:To:Cc:Subject:Message-ID; b=f7rc3DM3JWRYDoAQye/Unh4nZTZQdNEPa7qhxRLJPp9KJwuvl2oLbf0z95KMCAmUel1p586te7/xZNfXl0ne+VuB0F/NRMpRPYBYsceojWL4YPKispeFkSgyl6OQqTw1wVuuXot1k7XIGuaVf5O9OExPVFedrxelAI+7J2ruGoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VMzNBhRt; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724775301; x=1756311301;
  h=date:from:to:cc:subject:message-id;
  bh=IaEmR/LMdzGwp5aDzRS9OLm8ySuq2Ld+mY5QB22Q71w=;
  b=VMzNBhRtMYeU+F0l6d3xrQ3wk7PuslDhKRLAilAwGHMJrN5Pms9Tjw3A
   GUXq9kLNhngpecWN4f0KGqy1SNDgKywiNCDszywIfKOGIBYVFG5Xe+8xn
   IiXf7Q9V5Y1ZCJ1TCOe+1SZZbBuaBODhVIcubpl1vAEZ8MiI372Et/kHH
   XcMDbaIiNyfW5St2QXFqkl13KKukcZjJaNbzu86cTci/AdtokHREKU8T1
   y+SSHvbIM9jVAksvqdpzrlaBp2GITUTx/QCCMpwCY/yitV+EYJ5R5qKy5
   UXX3NlhhF/GJJidj4i+p0dkO5I+iCUvD+dD/uMnRIXG/RPhYzhP251c/z
   g==;
X-CSE-ConnectionGUID: qbl5nd6yTCqqZmPz2hex7A==
X-CSE-MsgGUID: hlBOKunsRrCjLhAwlkWZ7Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="40738892"
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="40738892"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 09:15:00 -0700
X-CSE-ConnectionGUID: JF0EIm1kRDG/+JdMgOImgA==
X-CSE-MsgGUID: MQrAStcZRZmM+YY6pzwE5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="62875822"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 27 Aug 2024 09:14:59 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1siyqO-000Jou-0l;
	Tue, 27 Aug 2024 16:14:56 +0000
Date: Wed, 28 Aug 2024 00:14:45 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 b6fb565a2d15277896583d471b21bc14a0c99661
Message-ID: <202408280043.qlaaC6qP-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: b6fb565a2d15277896583d471b21bc14a0c99661  x86/tdx: Fix data leak in mmio_read()

elapsed time: 1171m

configs tested: 103
configs skipped: 134

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                               defconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arm                               allnoconfig   gcc-13.2.0
arm                                 defconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-12
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-12
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240827   gcc-12
i386         buildonly-randconfig-002-20240827   gcc-12
i386         buildonly-randconfig-003-20240827   gcc-12
i386         buildonly-randconfig-004-20240827   gcc-12
i386         buildonly-randconfig-005-20240827   gcc-12
i386         buildonly-randconfig-006-20240827   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240827   gcc-12
i386                  randconfig-002-20240827   gcc-12
i386                  randconfig-003-20240827   gcc-12
i386                  randconfig-004-20240827   gcc-12
i386                  randconfig-005-20240827   gcc-12
i386                  randconfig-006-20240827   clang-18
i386                  randconfig-006-20240827   gcc-12
i386                  randconfig-011-20240827   clang-18
i386                  randconfig-011-20240827   gcc-12
i386                  randconfig-012-20240827   clang-18
i386                  randconfig-012-20240827   gcc-12
i386                  randconfig-013-20240827   clang-18
i386                  randconfig-013-20240827   gcc-12
i386                  randconfig-014-20240827   gcc-12
i386                  randconfig-015-20240827   gcc-12
i386                  randconfig-016-20240827   clang-18
i386                  randconfig-016-20240827   gcc-12
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc64                            defconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                               defconfig   gcc-14.1.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-20
s390                                defconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                                  defconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
um                                allnoconfig   gcc-14.1.0
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-14.1.0
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240827   clang-18
x86_64       buildonly-randconfig-002-20240827   clang-18
x86_64       buildonly-randconfig-003-20240827   clang-18
x86_64       buildonly-randconfig-004-20240827   clang-18
x86_64       buildonly-randconfig-005-20240827   clang-18
x86_64       buildonly-randconfig-006-20240827   clang-18
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-11
x86_64                randconfig-001-20240827   clang-18
x86_64                randconfig-002-20240827   clang-18
x86_64                randconfig-003-20240827   clang-18
x86_64                randconfig-004-20240827   clang-18
x86_64                randconfig-005-20240827   clang-18
x86_64                randconfig-006-20240827   clang-18
x86_64                randconfig-011-20240827   clang-18
x86_64                randconfig-012-20240827   clang-18
x86_64                randconfig-013-20240827   clang-18
x86_64                randconfig-014-20240827   clang-18
x86_64                randconfig-015-20240827   clang-18
x86_64                randconfig-016-20240827   clang-18
x86_64                randconfig-071-20240827   clang-18
x86_64                randconfig-072-20240827   clang-18
x86_64                randconfig-073-20240827   clang-18
x86_64                randconfig-074-20240827   clang-18
x86_64                randconfig-075-20240827   clang-18
x86_64                randconfig-076-20240827   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

