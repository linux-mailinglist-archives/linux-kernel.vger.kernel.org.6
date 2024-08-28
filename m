Return-Path: <linux-kernel+bounces-304992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 582769627DB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 14:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EEA928132D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 12:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F919178CF2;
	Wed, 28 Aug 2024 12:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U1QnseCh"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A7913B79F
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 12:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724849596; cv=none; b=X7tvVtC1RCURqAQgJKZ/oGph50YUurWSJOvgb6P0YK5IsyYNn+9SFGqFt2uF3BbXwEztqrkQey0+L+6N/CFMNR21sGHXNG81ReAwscBhrocFitjp1o0DQZsjO2yk3at9r8hGS2pWyXMRnsZj/aEdwpiS6qjWjWkp0aET36bZ0E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724849596; c=relaxed/simple;
	bh=yumZ/Kwt+jkIL912DATW6pzyNOhlQ8eLi6qsdDdaRAo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=kKBOTI+78KuOz0W/iSdIRNsbp/7rJgFRgydpta9SiL6iNXIuHbAB7KqbR+0plT8ftWucnSr2dRFJTKaEYAt+L+IqC+72jETSI1/4kifygL7Y8+monVNO/eOyEMugUwzZ3S/lRiPceeydJTJclj6Q00mkrBGNPmktoERn23kFPRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U1QnseCh; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724849594; x=1756385594;
  h=date:from:to:cc:subject:message-id;
  bh=yumZ/Kwt+jkIL912DATW6pzyNOhlQ8eLi6qsdDdaRAo=;
  b=U1QnseChysEDFiSIe2/+PM5wVs9sde4SCfRx+NhKaIcm2KKoM7tYoMay
   NwjpDzlN1KbLmD2AmJD7qLTxIOuARY0PzkqvflKE5DQxHAEMX0sbE6tEH
   ZkLKY5sDOX0ld//35/7+9mokgHp/en5Y8I00MHuNHBTboKsNebbmMbyY2
   hmW6lzyD9Nm3WSbrpkJkl8HCPp00kwRmZnwrTYZUul+jrgmT/jiyP9Odr
   5IURJiLJ9OwmGwmfvkfS6FDlCz4JBN84Er471Hkm4VYE90wQtt23Q9gYy
   U/KEraSS5R73D6PcLg7ha1yf9hGwD67H1dLZizXNt5n2LmuwVs28JCVUn
   w==;
X-CSE-ConnectionGUID: OC2KKo9fTZildPD63zZcxg==
X-CSE-MsgGUID: aunwKZoVQmahA+lZRxrVHQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="40849741"
X-IronPort-AV: E=Sophos;i="6.10,182,1719903600"; 
   d="scan'208";a="40849741"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 05:53:14 -0700
X-CSE-ConnectionGUID: cFEy8mrkTZiJH9HAJMgTIA==
X-CSE-MsgGUID: 4+j6fTM9QQ6SG5J9g07AEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,182,1719903600"; 
   d="scan'208";a="86407690"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 28 Aug 2024 05:53:13 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sjIAg-000Kxu-2J;
	Wed, 28 Aug 2024 12:53:10 +0000
Date: Wed, 28 Aug 2024 20:52:19 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:irq/core] BUILD SUCCESS
 92f9d825b12fa3f6c14b42405489880d0694c96f
Message-ID: <202408282017.NdaWZjaS-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
branch HEAD: 92f9d825b12fa3f6c14b42405489880d0694c96f  genirq/procfs: Correctly set file permissions for affinity control files

elapsed time: 1467m

configs tested: 149
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig   gcc-13.2.0
alpha                             allnoconfig   gcc-13.2.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                          axs101_defconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                              allyesconfig   gcc-14.1.0
arm                                 defconfig   gcc-13.2.0
arm                      footbridge_defconfig   gcc-13.2.0
arm                            mmp2_defconfig   gcc-13.2.0
arm                         s5pv210_defconfig   gcc-13.2.0
arm64                            allmodconfig   clang-20
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
hexagon                          allmodconfig   clang-20
hexagon                          allyesconfig   clang-20
i386                             allmodconfig   clang-18
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-12
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240828   gcc-12
i386         buildonly-randconfig-002-20240828   clang-18
i386         buildonly-randconfig-002-20240828   gcc-12
i386         buildonly-randconfig-003-20240828   clang-18
i386         buildonly-randconfig-003-20240828   gcc-12
i386         buildonly-randconfig-004-20240828   gcc-12
i386         buildonly-randconfig-005-20240828   gcc-12
i386         buildonly-randconfig-006-20240828   clang-18
i386         buildonly-randconfig-006-20240828   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240828   clang-18
i386                  randconfig-001-20240828   gcc-12
i386                  randconfig-002-20240828   gcc-12
i386                  randconfig-003-20240828   clang-18
i386                  randconfig-003-20240828   gcc-12
i386                  randconfig-004-20240828   clang-18
i386                  randconfig-004-20240828   gcc-12
i386                  randconfig-005-20240828   clang-18
i386                  randconfig-005-20240828   gcc-12
i386                  randconfig-006-20240828   gcc-12
i386                  randconfig-011-20240828   gcc-12
i386                  randconfig-012-20240828   gcc-12
i386                  randconfig-013-20240828   clang-18
i386                  randconfig-013-20240828   gcc-12
i386                  randconfig-014-20240828   gcc-11
i386                  randconfig-014-20240828   gcc-12
i386                  randconfig-015-20240828   gcc-12
i386                  randconfig-016-20240828   gcc-11
i386                  randconfig-016-20240828   gcc-12
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
microblaze                      mmu_defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                     cu1000-neo_defconfig   gcc-13.2.0
mips                      malta_kvm_defconfig   gcc-13.2.0
mips                      maltasmvp_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   gcc-14.1.0
powerpc                    socrates_defconfig   gcc-13.2.0
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-14.1.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                             allyesconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-14.1.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                         ecovec24_defconfig   gcc-13.2.0
sh                            migor_defconfig   gcc-13.2.0
sh                          rsk7203_defconfig   gcc-13.2.0
sh                           se7712_defconfig   gcc-13.2.0
sh                   secureedge5410_defconfig   gcc-13.2.0
sh                             shx3_defconfig   gcc-13.2.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
um                               allmodconfig   clang-20
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-12
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-14.1.0
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240828   clang-18
x86_64       buildonly-randconfig-002-20240828   clang-18
x86_64       buildonly-randconfig-003-20240828   clang-18
x86_64       buildonly-randconfig-004-20240828   clang-18
x86_64       buildonly-randconfig-005-20240828   clang-18
x86_64       buildonly-randconfig-006-20240828   clang-18
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-11
x86_64                randconfig-001-20240828   clang-18
x86_64                randconfig-002-20240828   clang-18
x86_64                randconfig-003-20240828   clang-18
x86_64                randconfig-004-20240828   clang-18
x86_64                randconfig-005-20240828   clang-18
x86_64                randconfig-006-20240828   clang-18
x86_64                randconfig-011-20240828   clang-18
x86_64                randconfig-012-20240828   clang-18
x86_64                randconfig-013-20240828   clang-18
x86_64                randconfig-014-20240828   clang-18
x86_64                randconfig-015-20240828   clang-18
x86_64                randconfig-016-20240828   clang-18
x86_64                randconfig-071-20240828   clang-18
x86_64                randconfig-072-20240828   clang-18
x86_64                randconfig-073-20240828   clang-18
x86_64                randconfig-074-20240828   clang-18
x86_64                randconfig-075-20240828   clang-18
x86_64                randconfig-076-20240828   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

