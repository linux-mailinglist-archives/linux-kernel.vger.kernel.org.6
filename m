Return-Path: <linux-kernel+bounces-296824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C74895AF81
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 09:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63590B21D60
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 07:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D7D154448;
	Thu, 22 Aug 2024 07:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PFyTifgt"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9513315351A
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 07:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724312520; cv=none; b=Dil05XH4+7kSl70R3cBeGl6oLVjOA1oa/Hohf4DwVjiTJkSLvYhP6ftr5PG6CbG5H1fNQlw7LCUIh0zS5uMYicdB4SURagneVZAQ5jmh5pKKeGcuO1oXyno89WoWHcoxbkKWHhL8t6aV4HETD0mO6LOxCmHVqxwZv2z8Ehxij44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724312520; c=relaxed/simple;
	bh=Or1rajALrSV7YECqXm9O1WUbrv85cQKW8oH61rd+ulU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=qydWxmam5kHLhOoSn2gYs+PWN7M2IpGaOKER0UeCo0vIEfNISp7jBr1nLAd1tLDTs0NXNzJUyuoEHOi+47INVIMyFGk18457sXs6hIP7Nk7JF3wwAuTuMDKHkdyVNjnntlni2WmkP7V9DX/Ij2hSK1u1lnUSeATWD+rPZWb93rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PFyTifgt; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724312518; x=1755848518;
  h=date:from:to:cc:subject:message-id;
  bh=Or1rajALrSV7YECqXm9O1WUbrv85cQKW8oH61rd+ulU=;
  b=PFyTifgt5P0cI+zbyrzSOKXyNKbx0Udx0pfJR2UiKaL8p7UzCEFTF575
   26atVPFzhuZc9bFHqJqQT4aa8pqFuwJ6JWOA7OM93mXrnAEWfY8YfTBmh
   ynLz5eny8MuYHGOR6aMnXS08cY2wj+4G0jTEEEwgQBqI+809vQPgcpocV
   qqWpGtCQIDNjaQFLNbeTUeZ6DD0kkAXAhCGIJnxFIEFVJe+c0MeZzbjky
   UOGa7ckXRrYcRjMiMUUkH8ekSrJ8eMRMXtg8jvAXx+UzHwWtrM6gTPwqB
   zRiaUbiuiHzXgD5VyzqWgpzoiirVw23+p04GWFE+GP8/W5G5o1JPelRxg
   w==;
X-CSE-ConnectionGUID: qPj1JMoBSTWmQWz4T02ApA==
X-CSE-MsgGUID: PU6RdEoeSRClx1UOQE2LNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="22580205"
X-IronPort-AV: E=Sophos;i="6.10,166,1719903600"; 
   d="scan'208";a="22580205"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 00:41:58 -0700
X-CSE-ConnectionGUID: UR9ESWJaQSCY/lBDaQJgFQ==
X-CSE-MsgGUID: iXK+1Nd8T7K6ss59j5qF0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,166,1719903600"; 
   d="scan'208";a="61506551"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 22 Aug 2024 00:41:57 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sh2SA-000CYA-1w;
	Thu, 22 Aug 2024 07:41:54 +0000
Date: Thu, 22 Aug 2024 15:41:50 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 b34bbe44b8222d43d6311d5caa1226ebddda4bfb
Message-ID: <202408221548.nJywZuz6-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: b34bbe44b8222d43d6311d5caa1226ebddda4bfb  Merge branch into tip/master: 'x86/timers'

elapsed time: 1409m

configs tested: 228
configs skipped: 15

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                          axs103_defconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                     nsimosci_hs_defconfig   gcc-13.2.0
arc                   randconfig-001-20240822   gcc-13.2.0
arc                   randconfig-002-20240822   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-20
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                              allyesconfig   gcc-14.1.0
arm                                 defconfig   gcc-13.2.0
arm                            dove_defconfig   gcc-14.1.0
arm                      footbridge_defconfig   gcc-13.2.0
arm                          ixp4xx_defconfig   gcc-13.2.0
arm                            mmp2_defconfig   gcc-13.2.0
arm                          moxart_defconfig   gcc-14.1.0
arm                           omap1_defconfig   gcc-14.1.0
arm                   randconfig-001-20240822   gcc-13.2.0
arm                   randconfig-002-20240822   gcc-13.2.0
arm                   randconfig-003-20240822   gcc-13.2.0
arm                   randconfig-004-20240822   gcc-13.2.0
arm                        shmobile_defconfig   gcc-13.2.0
arm64                            allmodconfig   clang-20
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240822   gcc-13.2.0
arm64                 randconfig-002-20240822   gcc-13.2.0
arm64                 randconfig-003-20240822   gcc-13.2.0
arm64                 randconfig-004-20240822   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240822   gcc-13.2.0
csky                  randconfig-002-20240822   gcc-13.2.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   clang-20
hexagon                          allyesconfig   clang-20
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-12
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-12
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240821   gcc-12
i386         buildonly-randconfig-001-20240822   gcc-12
i386         buildonly-randconfig-002-20240821   gcc-12
i386         buildonly-randconfig-002-20240822   gcc-12
i386         buildonly-randconfig-003-20240821   clang-18
i386         buildonly-randconfig-003-20240821   gcc-12
i386         buildonly-randconfig-003-20240822   gcc-12
i386         buildonly-randconfig-004-20240821   gcc-12
i386         buildonly-randconfig-004-20240822   gcc-12
i386         buildonly-randconfig-005-20240821   gcc-12
i386         buildonly-randconfig-005-20240822   gcc-12
i386         buildonly-randconfig-006-20240821   gcc-12
i386         buildonly-randconfig-006-20240822   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240821   gcc-12
i386                  randconfig-001-20240822   gcc-12
i386                  randconfig-002-20240821   gcc-12
i386                  randconfig-002-20240822   gcc-12
i386                  randconfig-003-20240821   gcc-12
i386                  randconfig-003-20240822   gcc-12
i386                  randconfig-004-20240821   gcc-12
i386                  randconfig-004-20240822   gcc-12
i386                  randconfig-005-20240821   clang-18
i386                  randconfig-005-20240821   gcc-12
i386                  randconfig-005-20240822   gcc-12
i386                  randconfig-006-20240821   gcc-12
i386                  randconfig-006-20240822   gcc-12
i386                  randconfig-011-20240821   gcc-11
i386                  randconfig-011-20240821   gcc-12
i386                  randconfig-011-20240822   gcc-12
i386                  randconfig-012-20240821   gcc-12
i386                  randconfig-012-20240822   gcc-12
i386                  randconfig-013-20240821   clang-18
i386                  randconfig-013-20240821   gcc-12
i386                  randconfig-013-20240822   gcc-12
i386                  randconfig-014-20240821   clang-18
i386                  randconfig-014-20240821   gcc-12
i386                  randconfig-014-20240822   gcc-12
i386                  randconfig-015-20240821   gcc-12
i386                  randconfig-015-20240822   gcc-12
i386                  randconfig-016-20240821   gcc-12
i386                  randconfig-016-20240822   gcc-12
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-13.2.0
loongarch                 loongson3_defconfig   gcc-13.2.0
loongarch             randconfig-001-20240822   gcc-13.2.0
loongarch             randconfig-002-20240822   gcc-13.2.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                         apollo_defconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
m68k                            q40_defconfig   gcc-13.2.0
m68k                          sun3x_defconfig   gcc-14.1.0
m68k                           virt_defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-14.1.0
mips                          ath25_defconfig   gcc-14.1.0
mips                        bcm47xx_defconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240822   gcc-13.2.0
nios2                 randconfig-002-20240822   gcc-13.2.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240822   gcc-13.2.0
parisc                randconfig-002-20240822   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-20
powerpc                          allyesconfig   gcc-14.1.0
powerpc                      bamboo_defconfig   gcc-13.2.0
powerpc                    gamecube_defconfig   gcc-14.1.0
powerpc                     kmeter1_defconfig   gcc-13.2.0
powerpc                     kmeter1_defconfig   gcc-14.1.0
powerpc                 linkstation_defconfig   gcc-13.2.0
powerpc                 mpc836x_rdk_defconfig   gcc-14.1.0
powerpc                     mpc83xx_defconfig   gcc-14.1.0
powerpc64             randconfig-001-20240822   gcc-13.2.0
powerpc64             randconfig-002-20240822   gcc-13.2.0
powerpc64             randconfig-003-20240822   gcc-13.2.0
riscv                            allmodconfig   clang-20
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-20
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-14.1.0
riscv                 randconfig-001-20240822   gcc-13.2.0
riscv                 randconfig-002-20240822   gcc-13.2.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240822   gcc-13.2.0
s390                  randconfig-002-20240822   gcc-13.2.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                        dreamcast_defconfig   gcc-14.1.0
sh                          landisk_defconfig   gcc-13.2.0
sh                          lboxre2_defconfig   gcc-14.1.0
sh                    randconfig-001-20240822   gcc-13.2.0
sh                    randconfig-002-20240822   gcc-13.2.0
sh                          rsk7269_defconfig   gcc-14.1.0
sh                          sdk7780_defconfig   gcc-14.1.0
sh                           se7724_defconfig   gcc-13.2.0
sh                             sh03_defconfig   gcc-13.2.0
sh                   sh7770_generic_defconfig   gcc-13.2.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240822   gcc-13.2.0
sparc64               randconfig-002-20240822   gcc-13.2.0
um                               allmodconfig   clang-20
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-12
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240822   gcc-13.2.0
um                    randconfig-002-20240822   gcc-13.2.0
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240822   gcc-12
x86_64       buildonly-randconfig-002-20240822   gcc-12
x86_64       buildonly-randconfig-003-20240822   gcc-12
x86_64       buildonly-randconfig-004-20240822   gcc-12
x86_64       buildonly-randconfig-005-20240822   gcc-12
x86_64       buildonly-randconfig-006-20240822   gcc-12
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-11
x86_64                randconfig-001-20240822   gcc-12
x86_64                randconfig-002-20240822   gcc-12
x86_64                randconfig-003-20240822   gcc-12
x86_64                randconfig-004-20240822   gcc-12
x86_64                randconfig-005-20240822   gcc-12
x86_64                randconfig-006-20240822   gcc-12
x86_64                randconfig-011-20240822   gcc-12
x86_64                randconfig-012-20240822   gcc-12
x86_64                randconfig-013-20240822   gcc-12
x86_64                randconfig-014-20240822   gcc-12
x86_64                randconfig-015-20240822   gcc-12
x86_64                randconfig-016-20240822   gcc-12
x86_64                randconfig-071-20240822   gcc-12
x86_64                randconfig-072-20240822   gcc-12
x86_64                randconfig-073-20240822   gcc-12
x86_64                randconfig-074-20240822   gcc-12
x86_64                randconfig-075-20240822   gcc-12
x86_64                randconfig-076-20240822   gcc-12
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240822   gcc-13.2.0
xtensa                randconfig-002-20240822   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

