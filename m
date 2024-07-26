Return-Path: <linux-kernel+bounces-263669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEF793D8E4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 21:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82D4D281B0C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 19:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1837C3D38E;
	Fri, 26 Jul 2024 19:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eN7QWQa+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C16924205
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 19:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722021371; cv=none; b=Brjb65QMSisanVckP28wXwmJaHXnbi8Uac2BBeoe1kCZWrP8lJjtw8oLVihORzeqOX/UpPDt+kc5oPD5NX2BHYssKArZF0DlMAPhpjuKsaKlkEh/vvYidtK9Jqy7VO2zg2+4JAZQxye33TuL2gZcvnYMgEhvwzWJ5YQSjXpwaKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722021371; c=relaxed/simple;
	bh=+QkJ2h43K3tHluJR4rRsIPqoydRwN3dY2pQSkX+NqfA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=AGfNZHHKdMxnmx3KpFOHh+09fP091tTdaOWRyJI6JIMv05vXvgvD4y0WFdjLxmrUTxpxV1q2jnaT1szNACiTQUrRVP+BY+5reosNJTgFVP8Hy17v5lAvxBq/JdoB9n7LI2k6yyHs10BRRvJFeKcD/hJ9XNTBAK8H/L+ZnGCyAuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eN7QWQa+; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722021368; x=1753557368;
  h=date:from:to:cc:subject:message-id;
  bh=+QkJ2h43K3tHluJR4rRsIPqoydRwN3dY2pQSkX+NqfA=;
  b=eN7QWQa+uYr4I6B5bnePkkGoW7yvfgArtQ1c30Urj0RLG0iMdxm8P7Z1
   fuMtn655ouofIkctVNctuFmBF+Sro02E9qa3zxQXDCrJSI4Or6OlrSWP9
   715c5ZU6g2Am1rEY2f9AdZZPMtAxE4tNZT3480vrX+I1YL2/kI7GMZBer
   WYQeO28xbVNvGRTgQx/Lfgae+allyJQdasMpZzHz6n2X7sPqm2Alo/ja7
   W9q3sSqW53t9B+8XJKwWJx+eGJSXVrVqHYYiMt9GOieUR39VGgqF4gxIv
   liDzbJpOCI+PPIANvVhpkmNt4Idrjj4T7WLeGh28zgwwps5maA44n+WbW
   Q==;
X-CSE-ConnectionGUID: SXJAlFnnTfqBYz/AJU2H1g==
X-CSE-MsgGUID: 9e7QYsQIRFq7m9F9f2Id6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11145"; a="37342041"
X-IronPort-AV: E=Sophos;i="6.09,239,1716274800"; 
   d="scan'208";a="37342041"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2024 12:16:07 -0700
X-CSE-ConnectionGUID: tWPOfbynT+69EoaifhLCVQ==
X-CSE-MsgGUID: lH1TWZkTStav7OP5X63C4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,239,1716274800"; 
   d="scan'208";a="83997063"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 26 Jul 2024 12:16:03 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sXQQ5-000pKa-19;
	Fri, 26 Jul 2024 19:16:01 +0000
Date: Sat, 27 Jul 2024 03:15:33 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2024.07.18b] BUILD SUCCESS
 a6c7779283d67a409b81616a5b485ac21637d7e7
Message-ID: <202407270328.WWO8ILcU-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://github.com/paulmckrcu/linux dev.2024.07.18b
branch HEAD: a6c7779283d67a409b81616a5b485ac21637d7e7  exit: Sleep at TASK_IDLE when waiting for application core dump

Unverified Warning (likely false positive, please contact us if interested):

kernel/rcu/rcutorture.c:1502 rcu_torture_writer() error: we previously assumed 'cur_ops->get_comp_state' could be null (see line 1436)
kernel/rcu/rcutorture.c:1522 rcu_torture_writer() error: we previously assumed 'cur_ops->get_comp_state_full' could be null (see line 1451)

Warning ids grouped by kconfigs:

recent_errors
`-- i386-randconfig-141-20240726
    |-- kernel-rcu-rcutorture.c-rcu_torture_writer()-error:we-previously-assumed-cur_ops-get_comp_state-could-be-null-(see-line-)
    `-- kernel-rcu-rcutorture.c-rcu_torture_writer()-error:we-previously-assumed-cur_ops-get_comp_state_full-could-be-null-(see-line-)

elapsed time: 1141m

configs tested: 170
configs skipped: 4

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
arc                                 defconfig   gcc-13.2.0
arc                        nsimosci_defconfig   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-20
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                              allyesconfig   gcc-14.1.0
arm                                 defconfig   gcc-13.2.0
arm                          gemini_defconfig   clang-20
arm                        keystone_defconfig   clang-20
arm                         mv78xx0_defconfig   gcc-13.2.0
arm                        mvebu_v5_defconfig   gcc-13.2.0
arm                       omap2plus_defconfig   gcc-13.2.0
arm                          pxa168_defconfig   clang-20
arm                         s3c6400_defconfig   clang-20
arm                           tegra_defconfig   gcc-13.2.0
arm64                            allmodconfig   clang-20
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-13.2.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   clang-20
hexagon                          allyesconfig   clang-20
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-13
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-13
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240726   gcc-13
i386         buildonly-randconfig-002-20240726   clang-18
i386         buildonly-randconfig-002-20240726   gcc-13
i386         buildonly-randconfig-003-20240726   gcc-13
i386         buildonly-randconfig-004-20240726   clang-18
i386         buildonly-randconfig-004-20240726   gcc-13
i386         buildonly-randconfig-005-20240726   gcc-13
i386         buildonly-randconfig-005-20240726   gcc-7
i386         buildonly-randconfig-006-20240726   gcc-13
i386                                defconfig   clang-18
i386                  randconfig-001-20240726   gcc-13
i386                  randconfig-002-20240726   gcc-13
i386                  randconfig-003-20240726   gcc-13
i386                  randconfig-004-20240726   gcc-13
i386                  randconfig-005-20240726   gcc-13
i386                  randconfig-006-20240726   gcc-13
i386                  randconfig-011-20240726   gcc-13
i386                  randconfig-012-20240726   gcc-13
i386                  randconfig-013-20240726   gcc-13
i386                  randconfig-014-20240726   gcc-13
i386                  randconfig-015-20240726   gcc-13
i386                  randconfig-016-20240726   gcc-13
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-13.2.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-14.1.0
mips                     decstation_defconfig   gcc-13.2.0
mips                          eyeq5_defconfig   clang-20
mips                           gcw0_defconfig   gcc-13.2.0
mips                           xway_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-13.2.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
openrisc                 simple_smp_defconfig   gcc-13.2.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-20
powerpc                          allyesconfig   gcc-14.1.0
powerpc                    amigaone_defconfig   gcc-13.2.0
powerpc                      arches_defconfig   gcc-13.2.0
powerpc                      bamboo_defconfig   clang-20
powerpc                       ebony_defconfig   clang-20
powerpc                 mpc832x_rdb_defconfig   clang-20
powerpc                  mpc885_ads_defconfig   clang-20
powerpc                     taishan_defconfig   gcc-13.2.0
riscv                            allmodconfig   clang-20
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-20
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-14.1.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-14.1.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                        dreamcast_defconfig   gcc-13.2.0
sh                          r7780mp_defconfig   gcc-13.2.0
sh                          rsk7269_defconfig   gcc-13.2.0
sh                          sdk7780_defconfig   gcc-13.2.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
um                               allmodconfig   clang-20
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-13
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-14.1.0
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240726   gcc-13
x86_64       buildonly-randconfig-002-20240726   gcc-13
x86_64       buildonly-randconfig-003-20240726   gcc-13
x86_64       buildonly-randconfig-004-20240726   gcc-13
x86_64       buildonly-randconfig-005-20240726   gcc-13
x86_64       buildonly-randconfig-006-20240726   gcc-13
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240726   gcc-13
x86_64                randconfig-002-20240726   gcc-13
x86_64                randconfig-003-20240726   gcc-13
x86_64                randconfig-004-20240726   gcc-13
x86_64                randconfig-005-20240726   gcc-13
x86_64                randconfig-006-20240726   gcc-13
x86_64                randconfig-011-20240726   gcc-13
x86_64                randconfig-012-20240726   gcc-13
x86_64                randconfig-013-20240726   gcc-13
x86_64                randconfig-014-20240726   gcc-13
x86_64                randconfig-015-20240726   gcc-13
x86_64                randconfig-016-20240726   gcc-13
x86_64                randconfig-071-20240726   gcc-13
x86_64                randconfig-072-20240726   gcc-13
x86_64                randconfig-073-20240726   gcc-13
x86_64                randconfig-074-20240726   gcc-13
x86_64                randconfig-075-20240726   gcc-13
x86_64                randconfig-076-20240726   gcc-13
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                            allnoconfig   gcc-14.1.0
xtensa                  audio_kc705_defconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

