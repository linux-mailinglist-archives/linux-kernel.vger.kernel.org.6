Return-Path: <linux-kernel+bounces-327851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A710A977BEC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 11:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 294841F27641
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 09:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C05D18FDCD;
	Fri, 13 Sep 2024 09:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RZ3iWnvM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257ED1D6DD5
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 09:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726218589; cv=none; b=mWUXXN8Hn7ydaH2gCbQXiTvvE1oEQAk/euM/yhDIFnEIhaboKj8TOeiQBznft79hD5S96w7fUsssR8QiuhJnWMxutmIPU8Fd08WZ5ex6ih+5EbBqCyTK2LcjwDWQKUgh/kWRHoTqF0qhB2JRThpYCi1MexXdh8YoeDn6FyKKDqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726218589; c=relaxed/simple;
	bh=D0AdRvyCVJel+xUsRJ4Kn8G/JM/ITMTJJYKV8gi1kPQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ncsWRKJovBiWFsronxVVriASpBVDkwEcb8ZXHd7rTckGaiqummWavC/XXLn84pWqq2dUV6CKLj/9PbOYSxQs6sJnnGWOhvFtDuDNr1TbPf7JTs4vOhYxAuQoE7MG/T1mJv6DkEIGDYES2FIFHiQhbIepXoxjzaWG/tgKdcaJIvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RZ3iWnvM; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726218587; x=1757754587;
  h=date:from:to:cc:subject:message-id;
  bh=D0AdRvyCVJel+xUsRJ4Kn8G/JM/ITMTJJYKV8gi1kPQ=;
  b=RZ3iWnvMjw1r3/A5SvnwtPAJS4NxqOXG7sikW4t6cipqYYJTefdr88oY
   8Qq7zJmpSzq9ryPKZ4YjrXYQAWz8T5wfbh3k57NqmX4L61V4891UIAQT7
   YEeoT9ZHqIKVpFxBTU4naS3oh3Wz7ldalYI2I/qiUmqWnzQb4z0luJXHd
   CZaXMgdudZ7loqB+uwcoAHEod5irdhnUY2cKXLS+xLXQP8dtLzeHDgeVr
   RCV1MEuLPo9w9vCcDUuVAbopkHJAa7VzZT1m5/UyQAhXvibLs6U/DlsqS
   O6Bh4bIFCCVcIl3JGkhGoGUoPNPj0c8az9oihXD+AM+EjcW68VrDdpqba
   A==;
X-CSE-ConnectionGUID: zLr4PuWuSxeN3yGTIwHO0w==
X-CSE-MsgGUID: hYVYk9dbTKaTKJllAYRyUw==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="25208178"
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="25208178"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 02:09:45 -0700
X-CSE-ConnectionGUID: waewOVHvRI6Yadl85NW0UA==
X-CSE-MsgGUID: yRC+b4wOS1e4zcLugJ9zNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="68761858"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 13 Sep 2024 02:09:45 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sp2JC-0006HK-1D;
	Fri, 13 Sep 2024 09:09:42 +0000
Date: Fri, 13 Sep 2024 17:09:33 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 4c293d0fa3159f5062483ef981d77f455589cfda
Message-ID: <202409131724.Kp8oJQ43-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 4c293d0fa3159f5062483ef981d77f455589cfda  Merge branch into tip/master: 'x86/timers'

elapsed time: 1393m

configs tested: 96
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
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-18
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-18
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20240913    clang-18
i386        buildonly-randconfig-002-20240913    clang-18
i386        buildonly-randconfig-003-20240913    clang-18
i386        buildonly-randconfig-004-20240913    clang-18
i386        buildonly-randconfig-005-20240913    clang-18
i386        buildonly-randconfig-006-20240913    clang-18
i386                                defconfig    clang-18
i386                  randconfig-001-20240913    clang-18
i386                  randconfig-002-20240913    clang-18
i386                  randconfig-003-20240913    clang-18
i386                  randconfig-004-20240913    clang-18
i386                  randconfig-005-20240913    clang-18
i386                  randconfig-006-20240913    clang-18
i386                  randconfig-011-20240913    clang-18
i386                  randconfig-012-20240913    clang-18
i386                  randconfig-013-20240913    clang-18
i386                  randconfig-014-20240913    clang-18
i386                  randconfig-015-20240913    clang-18
i386                  randconfig-016-20240913    clang-18
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
x86_64                              defconfig    gcc-11
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

