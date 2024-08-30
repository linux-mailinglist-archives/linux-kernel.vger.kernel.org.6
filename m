Return-Path: <linux-kernel+bounces-307968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0BA9655B1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 05:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 697FB1C2221A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 03:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD5813633B;
	Fri, 30 Aug 2024 03:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jxgtuYUl"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33F2196
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 03:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724988776; cv=none; b=j7dE/h3Kq0pmYKYQy/1AxoEUo2OZpW/kHPUEj3VFjnsTrYa3C6jaZrzlTtCV696IkySg2ORn9bCw4DTHRkZQXfuh7lUeR70vtsYQj4+BLV2AElHBRV73JPqdeunVS7uGRhywu285cvrzaqQWxlw/kLVlwfsT1EUkIfIRAQ8KAJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724988776; c=relaxed/simple;
	bh=7hPMGw1Q7gCQwIe5TyrKJoEOedBtXBQoxHY3evEeJhc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=nyanEA8aFT1FauQTmv+baKb+5/4yaw2CvBlWfdKbiwJHsRkJCvDKx6X65dNW3Nm5hRERF+9cAvzWbqzywRZOHKrc4MyIFwgcYKKyJcIyrXxE0YTKwpXXkJ/vJmfvKBAddVTfBXdTyzeZFYHj+hR+HfDZSDwr7/eJPL2pfgwEGZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jxgtuYUl; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724988774; x=1756524774;
  h=date:from:to:cc:subject:message-id;
  bh=7hPMGw1Q7gCQwIe5TyrKJoEOedBtXBQoxHY3evEeJhc=;
  b=jxgtuYUlfhEzudtcL7PoxHLFXM7lr9wrBfsZbul9WOZQNZjNh4HzY+8p
   ZAsKC04sV8Ue6nJ+wxyKW+Q9ObZpUFJqrgA6z31wqD+xfC6s25r1kgD7L
   M3+oEhcYIf7wn+qZu+p0qGxUS8rHcrnDVLekyS2+nUuKvmfuRhORR9Fmj
   3VoIwq0vJbWvdL+v2mVH7K0XKPOFCzQoAFmT5VJdzZy3eCt+DDfkilaAS
   QyzKQk8OkzMwb+66ZM2CjHuyIX4J9jWcqauKRL1vI+9S7cf1c5/Kea5Pg
   pko+L1czCHsdvlXVzcfA7vaNl0My5fBB1gjXlsKsk5E6XwVbIx4CY1Wff
   Q==;
X-CSE-ConnectionGUID: m2mP0MTgS+6S7k766w1BCw==
X-CSE-MsgGUID: KIE7SZyNSsKN/v4wuhyusQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="34991722"
X-IronPort-AV: E=Sophos;i="6.10,187,1719903600"; 
   d="scan'208";a="34991722"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 20:32:50 -0700
X-CSE-ConnectionGUID: /lmNGF85TJCWOR9M3GWhIA==
X-CSE-MsgGUID: XJ/muRMnQSWPk1RbhbxAsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,187,1719903600"; 
   d="scan'208";a="63965276"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 29 Aug 2024 20:32:48 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sjsNR-0000xu-2e;
	Fri, 30 Aug 2024 03:32:45 +0000
Date: Fri, 30 Aug 2024 11:32:40 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 a547a5880cba6f287179135381f1b484b251be31
Message-ID: <202408301138.MRbzEuF7-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: a547a5880cba6f287179135381f1b484b251be31  x86/resctrl: Fix arch_mbm_* array overrun on SNC

elapsed time: 2460m

configs tested: 124
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-14.1.0
alpha                            allyesconfig   clang-20
alpha                               defconfig   gcc-14.1.0
arc                               allnoconfig   gcc-14.1.0
arc                                 defconfig   gcc-14.1.0
arm                               allnoconfig   gcc-14.1.0
arm                                 defconfig   gcc-14.1.0
arm                   milbeaut_m10v_defconfig   gcc-14.1.0
arm                        multi_v7_defconfig   gcc-14.1.0
arm                           tegra_defconfig   gcc-14.1.0
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-14.1.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-14.1.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   gcc-14.1.0
hexagon                          allyesconfig   clang-20
hexagon                             defconfig   gcc-14.1.0
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-12
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-12
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240830   gcc-12
i386         buildonly-randconfig-002-20240830   gcc-12
i386         buildonly-randconfig-003-20240830   gcc-12
i386         buildonly-randconfig-005-20240830   gcc-12
i386         buildonly-randconfig-006-20240830   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240830   clang-18
i386                  randconfig-002-20240830   gcc-12
i386                  randconfig-003-20240830   gcc-12
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-14.1.0
m68k                          hp300_defconfig   gcc-14.1.0
m68k                       m5275evb_defconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
mips                      fuloong2e_defconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-14.1.0
openrisc                          allnoconfig   clang-20
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-12
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   clang-20
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-12
parisc64                            defconfig   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   clang-20
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   gcc-14.1.0
powerpc                      bamboo_defconfig   gcc-14.1.0
powerpc                   bluestone_defconfig   gcc-14.1.0
powerpc                 mpc836x_rdk_defconfig   gcc-14.1.0
powerpc                      pmac32_defconfig   gcc-14.1.0
powerpc                       ppc64_defconfig   gcc-14.1.0
powerpc                     tqm5200_defconfig   gcc-14.1.0
powerpc64                        alldefconfig   gcc-14.1.0
riscv                             allnoconfig   clang-20
riscv                             allnoconfig   gcc-14.1.0
riscv                               defconfig   gcc-12
s390                             allmodconfig   gcc-14.1.0
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-12
s390                                defconfig   gcc-14.1.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-12
sh                             shx3_defconfig   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-12
um                               allmodconfig   clang-20
um                                allnoconfig   clang-17
um                                allnoconfig   clang-20
um                               allyesconfig   clang-20
um                                  defconfig   gcc-12
um                             i386_defconfig   gcc-12
um                           x86_64_defconfig   gcc-12
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240830   clang-18
x86_64       buildonly-randconfig-002-20240830   clang-18
x86_64       buildonly-randconfig-003-20240830   clang-18
x86_64       buildonly-randconfig-004-20240830   clang-18
x86_64       buildonly-randconfig-005-20240830   clang-18
x86_64       buildonly-randconfig-006-20240830   clang-18
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-11
x86_64                randconfig-001-20240830   clang-18
x86_64                randconfig-002-20240830   clang-18
x86_64                randconfig-003-20240830   clang-18
x86_64                randconfig-004-20240830   clang-18
x86_64                randconfig-005-20240830   clang-18
x86_64                randconfig-006-20240830   clang-18
x86_64                randconfig-011-20240830   clang-18
x86_64                randconfig-012-20240830   clang-18
x86_64                randconfig-013-20240830   clang-18
x86_64                randconfig-014-20240830   clang-18
x86_64                randconfig-015-20240830   clang-18
x86_64                randconfig-016-20240830   clang-18
x86_64                randconfig-071-20240830   clang-18
x86_64                randconfig-072-20240830   clang-18
x86_64                randconfig-073-20240830   clang-18
x86_64                randconfig-074-20240830   clang-18
x86_64                randconfig-075-20240830   clang-18
x86_64                randconfig-076-20240830   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-14.1.0
xtensa                          iss_defconfig   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

