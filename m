Return-Path: <linux-kernel+bounces-300834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC02A95E909
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 625B3281821
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 06:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15B88289A;
	Mon, 26 Aug 2024 06:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EjqTPvbC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D143778281
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 06:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724654073; cv=none; b=Bc+Yb1Cfb6k0+x74xbGSiheHPy62lk18ViHZrVU/NojRGVASFH+aPIJU+eCMPFWndeaG3Y/oDO8t7Ki0VloCT0wuAnKaK8swJuCcIIcl3SU39bw75d205B++sooXsmpW2XS79o/qwLb1knMkKdiLjzZxAlWg68BTglE4/UiV0Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724654073; c=relaxed/simple;
	bh=2aFmAD47ww83MBl4CWPNhIcUasgdViYhAwKKkS9ZAbM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=dUk7nWneDweMCqwJKq8NIQb8OKBQZxYhmaAUZ2T3fZPdERZW6jMEIJyDtU4LmKl5fgjjfu8hEha+e4EPtw3WKcPIhS8JadCEyxUOiKhZM6dcxcCUMchyFGJZkYMiAIJIcb1qRnm5UBpUtKttKxk2x2H+To9tukWaK+SwQLS85qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EjqTPvbC; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724654072; x=1756190072;
  h=date:from:to:cc:subject:message-id;
  bh=2aFmAD47ww83MBl4CWPNhIcUasgdViYhAwKKkS9ZAbM=;
  b=EjqTPvbCy6OBvB5Xi7cz9EMzLBJ+fQEjdKht+fBc2LmMK7I8x9EevJDa
   A1KkPvvEZM7f5mnQUB7anIz+MQvQZPhN8UkNJxwt69/W33GWuLoV1bHuH
   YSoMREWNxPO8mATscF5nr3p6B2NO+XPB1OXR9g+DWIHc5poRZ2UZHKaDb
   k+ZgEgMUDONl+ViqflJplB2Ov44bYRQwbnY6sRmY+cFgL168hhHd8S+b7
   z8HupcD/aOqpjotjgkY7PXZPIxhLfuoZe2+tTcmUirYXbbcj9vGvw19NW
   hyTw2ZNuaSYERE2P9tUJ8G2BJqnMp5alynVZBlz9Vy3Kr6m64URTDRF/s
   A==;
X-CSE-ConnectionGUID: uJAkKH8YQBy2wxYQOJVh0g==
X-CSE-MsgGUID: 1o85YSNGRS+aHlTl1Q+7hA==
X-IronPort-AV: E=McAfee;i="6700,10204,11175"; a="33623502"
X-IronPort-AV: E=Sophos;i="6.10,176,1719903600"; 
   d="scan'208";a="33623502"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2024 23:34:31 -0700
X-CSE-ConnectionGUID: dvXXEA1LR4WrB1Hb8gUhPA==
X-CSE-MsgGUID: stU/eRzwT7CLdM6H4cUZOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,176,1719903600"; 
   d="scan'208";a="63133066"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 25 Aug 2024 23:34:30 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1siTJ5-000GJB-1r;
	Mon, 26 Aug 2024 06:34:27 +0000
Date: Mon, 26 Aug 2024 14:33:34 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/fred] BUILD SUCCESS
 fe85ee391966c4cf3bfe1c405314e894c951f521
Message-ID: <202408261431.st4QT7R8-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/fred
branch HEAD: fe85ee391966c4cf3bfe1c405314e894c951f521  x86/entry: Set FRED RSP0 on return to userspace instead of context switch

elapsed time: 725m

configs tested: 83
configs skipped: 130

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                            allyesconfig   gcc-13.3.0
arc                               allnoconfig   gcc-13.2.0
arc                        nsimosci_defconfig   gcc-12.3.0
arm                               allnoconfig   gcc-13.2.0
arm                          ixp4xx_defconfig   gcc-12.3.0
arm                       netwinder_defconfig   gcc-12.3.0
arm                           stm32_defconfig   gcc-12.3.0
arm64                             allnoconfig   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
i386                             allmodconfig   gcc-12
i386                              allnoconfig   gcc-12
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240826   clang-18
i386         buildonly-randconfig-002-20240826   clang-18
i386         buildonly-randconfig-002-20240826   gcc-12
i386         buildonly-randconfig-003-20240826   clang-18
i386         buildonly-randconfig-004-20240826   clang-18
i386         buildonly-randconfig-005-20240826   clang-18
i386         buildonly-randconfig-006-20240826   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240826   clang-18
i386                  randconfig-001-20240826   gcc-12
i386                  randconfig-002-20240826   clang-18
i386                  randconfig-002-20240826   gcc-12
i386                  randconfig-003-20240826   clang-18
i386                  randconfig-004-20240826   clang-18
i386                  randconfig-004-20240826   gcc-12
i386                  randconfig-005-20240826   clang-18
i386                  randconfig-005-20240826   gcc-12
i386                  randconfig-006-20240826   clang-18
i386                  randconfig-011-20240826   clang-18
i386                  randconfig-011-20240826   gcc-12
i386                  randconfig-012-20240826   clang-18
i386                  randconfig-012-20240826   gcc-12
i386                  randconfig-013-20240826   clang-18
i386                  randconfig-013-20240826   gcc-12
i386                  randconfig-014-20240826   clang-18
i386                  randconfig-014-20240826   gcc-12
i386                  randconfig-015-20240826   clang-18
i386                  randconfig-015-20240826   gcc-12
i386                  randconfig-016-20240826   clang-18
i386                  randconfig-016-20240826   gcc-12
loongarch                         allnoconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                      bmips_stb_defconfig   gcc-12.3.0
nios2                             allnoconfig   gcc-13.2.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                 linkstation_defconfig   gcc-12.3.0
powerpc                  mpc866_ads_defconfig   gcc-12.3.0
powerpc                  mpc885_ads_defconfig   gcc-12.3.0
powerpc                      pcm030_defconfig   gcc-12.3.0
riscv                             allnoconfig   gcc-14.1.0
riscv                               defconfig   gcc-14.1.0
riscv                    nommu_virt_defconfig   gcc-12.3.0
s390                              allnoconfig   gcc-14.1.0
s390                                defconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                                  defconfig   gcc-14.1.0
sh                      rts7751r2d1_defconfig   gcc-12.3.0
sh                   rts7751r2dplus_defconfig   gcc-12.3.0
sh                           se7724_defconfig   gcc-12.3.0
sh                           sh2007_defconfig   gcc-12.3.0
sh                             shx3_defconfig   gcc-12.3.0
sparc64                             defconfig   gcc-14.1.0
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-14.1.0
um                           x86_64_defconfig   gcc-14.1.0
x86_64                           alldefconfig   gcc-12.3.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64                              defconfig   gcc-11
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

