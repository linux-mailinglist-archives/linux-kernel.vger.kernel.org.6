Return-Path: <linux-kernel+bounces-381205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED299AFBEF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 10:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A20551C2280A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 08:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CABC1D14EF;
	Fri, 25 Oct 2024 08:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fo25qhI0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47AD1CACE8
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 08:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729843435; cv=none; b=LX9wLKXFr92W9OTvBvk9cuGOM8xNfy0U4jbf9RTWKO5QtfNheSBlG7yIw/fpqXs1zuVYcr8MI/yGJS8hP/jR4r0n1aG6z5DcAaRtDyKErvzd4ttQ29CkvTwhJBcGC08PBOnCAhwqxuhM/lVIFsiK+oD6W9euIDnhrvyWVs+hE70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729843435; c=relaxed/simple;
	bh=I54EJe/yaZ8GDC96m9swyqz+J5aArZdcEVN43tK6NRo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=uByjqrMcXhVAN2dF6g5TEsBkhyWhE6iaKpTmy5yNanXcUeJ3I5J7n+EqU+a60edB6GCwId2LMfVMrm6ed7C/lL9hj5WHCxV4tZe5cx9J7WKzQdhO7i6Iai4d7KxeSQCXwhR9gonEpPNPd55tkSW5/c5II4TK7eRPKIQ3vK2EZzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fo25qhI0; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729843433; x=1761379433;
  h=date:from:to:cc:subject:message-id;
  bh=I54EJe/yaZ8GDC96m9swyqz+J5aArZdcEVN43tK6NRo=;
  b=Fo25qhI0Ietyamy1K50YqmaB4DQDuV+NtmVTGn94eKBcFMqrNRvsi0gk
   7q8XSlAThuHSq3f+3n2kP3RQ3vZpKbTReuUXpLWFxxrvtpNp4x97wYuK7
   3/V8XwU/CPtoJSQGkYzziPrrAR0lJPfnuZBeSy1p9fUAYj62bK4B5UTt0
   8U3VTCsUdoUjzzUM0eYmgnh/NG7nnPzalHZn69DJYm56mLqdr1aSMeZZ9
   foOAa+XO6RJzqG2XYjtoBtypUQcjYSGLvscOrrWh1KAGEWVXNDSKJBvPy
   IkhnUQU2ObIJZSCjeoogjtcFxtU+DEMy5X7xSvoBzcHV44629CS+Kjiqd
   Q==;
X-CSE-ConnectionGUID: hfn74K3hQS2rWl3V3JpjAw==
X-CSE-MsgGUID: PiqgvY37Rp20osE+if0Lgg==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="54907750"
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="54907750"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 01:03:50 -0700
X-CSE-ConnectionGUID: W9Jmgp1xRsGr1xqfW1rwtA==
X-CSE-MsgGUID: pyN3GIAuRym2DM9D2QUKAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="81675335"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 25 Oct 2024 01:03:49 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t4FIQ-000Xou-1g;
	Fri, 25 Oct 2024 08:03:46 +0000
Date: Fri, 25 Oct 2024 16:03:05 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:timers/core] BUILD SUCCESS
 2e529e637cef39057d9cf199a1ecb915d97ffcd9
Message-ID: <202410251656.9iPER6cF-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
branch HEAD: 2e529e637cef39057d9cf199a1ecb915d97ffcd9  posix-timers: Replace call_rcu() by kfree_rcu() for simple kmem_cache_free() callback

Warning ids grouped by kconfigs:

recent_errors
`-- x86_64-allnoconfig
    `-- Warning:drivers-regulator-core.c-references-a-file-that-doesn-t-exist:Documentation-timers-timers-howto.rst

elapsed time: 1356m

configs tested: 155
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
arm                         lpc32xx_defconfig    gcc-14.1.0
arm                       multi_v4t_defconfig    clang-20
arm                            qcom_defconfig    clang-20
arm                         s3c6400_defconfig    gcc-14.1.0
arm                          sp7021_defconfig    gcc-14.1.0
arm                        vexpress_defconfig    clang-20
arm                    vt8500_v6_v7_defconfig    gcc-14.1.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
i386                             alldefconfig    gcc-14.1.0
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                             allyesconfig    clang-19
i386        buildonly-randconfig-001-20241025    gcc-12
i386        buildonly-randconfig-002-20241025    gcc-12
i386        buildonly-randconfig-003-20241025    gcc-12
i386        buildonly-randconfig-004-20241025    gcc-12
i386        buildonly-randconfig-005-20241025    gcc-12
i386        buildonly-randconfig-006-20241025    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20241025    gcc-12
i386                  randconfig-002-20241025    gcc-12
i386                  randconfig-003-20241025    gcc-12
i386                  randconfig-004-20241025    gcc-12
i386                  randconfig-005-20241025    gcc-12
i386                  randconfig-006-20241025    gcc-12
i386                  randconfig-011-20241025    gcc-12
i386                  randconfig-012-20241025    gcc-12
i386                  randconfig-013-20241025    gcc-12
i386                  randconfig-014-20241025    gcc-12
i386                  randconfig-015-20241025    gcc-12
i386                  randconfig-016-20241025    gcc-12
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
m68k                       m5208evb_defconfig    clang-20
m68k                       m5475evb_defconfig    clang-20
m68k                        stmark2_defconfig    clang-20
microblaze                       alldefconfig    clang-20
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                         db1xxx_defconfig    clang-20
mips                           gcw0_defconfig    clang-20
mips                            gpr_defconfig    gcc-14.1.0
mips                           jazz_defconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.1.0
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.1.0
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.1.0
powerpc                          allyesconfig    gcc-14.1.0
powerpc                      cm5200_defconfig    clang-20
powerpc                 mpc834x_itx_defconfig    clang-20
powerpc                     sequoia_defconfig    gcc-14.1.0
powerpc                     tqm5200_defconfig    clang-20
powerpc                      tqm8xx_defconfig    gcc-14.1.0
powerpc                        warp_defconfig    gcc-14.1.0
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.1.0
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                          debug_defconfig    clang-20
s390                                defconfig    gcc-12
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                         ecovec24_defconfig    gcc-14.1.0
sh                        edosk7705_defconfig    gcc-14.1.0
sh                          kfr2r09_defconfig    gcc-14.1.0
sh                     magicpanelr2_defconfig    gcc-14.1.0
sh                           se7619_defconfig    clang-20
sh                           se7619_defconfig    gcc-14.1.0
sh                           se7705_defconfig    gcc-14.1.0
sh                              ul2_defconfig    clang-20
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241025    gcc-12
x86_64      buildonly-randconfig-002-20241025    gcc-12
x86_64      buildonly-randconfig-003-20241025    gcc-12
x86_64      buildonly-randconfig-004-20241025    gcc-12
x86_64      buildonly-randconfig-005-20241025    gcc-12
x86_64      buildonly-randconfig-006-20241025    gcc-12
x86_64                              defconfig    clang-19
x86_64                                  kexec    clang-19
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20241025    gcc-12
x86_64                randconfig-002-20241025    gcc-12
x86_64                randconfig-003-20241025    gcc-12
x86_64                randconfig-004-20241025    gcc-12
x86_64                randconfig-005-20241025    gcc-12
x86_64                randconfig-006-20241025    gcc-12
x86_64                randconfig-011-20241025    gcc-12
x86_64                randconfig-012-20241025    gcc-12
x86_64                randconfig-013-20241025    gcc-12
x86_64                randconfig-014-20241025    gcc-12
x86_64                randconfig-015-20241025    gcc-12
x86_64                randconfig-016-20241025    gcc-12
x86_64                randconfig-071-20241025    gcc-12
x86_64                randconfig-072-20241025    gcc-12
x86_64                randconfig-073-20241025    gcc-12
x86_64                randconfig-074-20241025    gcc-12
x86_64                randconfig-075-20241025    gcc-12
x86_64                randconfig-076-20241025    gcc-12
x86_64                               rhel-8.3    gcc-12
xtensa                            allnoconfig    gcc-14.1.0
xtensa                  audio_kc705_defconfig    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

