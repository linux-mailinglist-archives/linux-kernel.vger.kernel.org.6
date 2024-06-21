Return-Path: <linux-kernel+bounces-223841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C1A911929
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 06:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 056EB1C21C11
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 04:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A2F127B62;
	Fri, 21 Jun 2024 04:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QtyhLh4u"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AB3259C
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 04:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718942543; cv=none; b=h7oh4y6uFWz3x3MaeK4h3Kql9zGYBwkdt2LHbPFQ+xVU6yCy6cPnnS5VaBkPx2B8YEbWsI6D14ISbL3nQEwdoLl8E80xJx6vt4KcrOxXBeJB6Yt0ckZVDBpk48WLN5NeDJzPCM7KmQVOYo/wFJXOR+aGyvMjNOOrye+Y/wrFoUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718942543; c=relaxed/simple;
	bh=eCmCU0/SXrxeDdS06XhUfnTQQfXn21PPa3ZGh/llRso=;
	h=Date:From:To:Cc:Subject:Message-ID; b=SJ15bYh2iC551F0dyZn129WjKxoJzWyZKqs9rER1pxGmNkEQJskdEVRfPs6+oJothiFw6U3wSv3LdvoWZelycbd139FPXoPYlng4nycYg2+BmjltYznx72FY6ODnN0GWYgJZqIcGX71jUDuBJM5cUecz62X/00+uxuYmGE3Y3iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QtyhLh4u; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718942542; x=1750478542;
  h=date:from:to:cc:subject:message-id;
  bh=eCmCU0/SXrxeDdS06XhUfnTQQfXn21PPa3ZGh/llRso=;
  b=QtyhLh4u5jRYe7O3ACetqIADZmSYMigYxeleMdEKwqB96YHk2thR5r5W
   M9WvVhQvCkS1sFtA6+pZKFmkgghjVU2CTz1t2l/apKWuNXyw/Dybmebb6
   o3kYUZeI/ziG3Pmy5xy3Dc3MO9blgexP3I05Mcv1E7luaIsg/JzoxU5mg
   zfyreCeGCh7pQlXbefvGZd2KuTmKM1bYDUHQp77VFBoRYf8XxDV5yxJoh
   Z1QDtsZUBLZpGGKUgjIZNlwQQuF2gzqHEvGYPN5FU2VkoIxGMOB/LIDNM
   BkIR5ZD6nlkoEoLZO6nv3vmaaHYAgHA4b+LQpjhOp8yUvGPZ17ydahfpu
   A==;
X-CSE-ConnectionGUID: lhMEaox9Txi923a3M7TSmg==
X-CSE-MsgGUID: 0xue1dX/RfOQzFYuJdbUvA==
X-IronPort-AV: E=McAfee;i="6700,10204,11109"; a="15721464"
X-IronPort-AV: E=Sophos;i="6.08,253,1712646000"; 
   d="scan'208";a="15721464"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 21:02:21 -0700
X-CSE-ConnectionGUID: QUIxpbSSSf2O+C321LEADg==
X-CSE-MsgGUID: rbIC5YdQTc+8jGYld6Yyag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,253,1712646000"; 
   d="scan'208";a="42379711"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 20 Jun 2024 21:02:20 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sKVTd-0008Bh-2t;
	Fri, 21 Jun 2024 04:02:17 +0000
Date: Fri, 21 Jun 2024 12:02:12 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:smp/core] BUILD SUCCESS
 fde78e4673afcb0bad382af8b81543476dc77655
Message-ID: <202406211209.J16shovr-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp/core
branch HEAD: fde78e4673afcb0bad382af8b81543476dc77655  cpu/hotplug: Reverse order of iteration in freeze_secondary_cpus()

elapsed time: 5178m

configs tested: 121
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                               defconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240618   gcc-13.2.0
arc                   randconfig-002-20240618   gcc-13.2.0
arm                               allnoconfig   clang-19
arm                                 defconfig   clang-14
arm                   randconfig-001-20240618   gcc-13.2.0
arm                   randconfig-002-20240618   gcc-13.2.0
arm                   randconfig-003-20240618   clang-19
arm                   randconfig-004-20240618   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240618   clang-17
arm64                 randconfig-002-20240618   clang-19
arm64                 randconfig-003-20240618   clang-16
arm64                 randconfig-004-20240618   clang-19
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240618   gcc-13.2.0
csky                  randconfig-002-20240618   gcc-13.2.0
hexagon                           allnoconfig   clang-19
hexagon                             defconfig   clang-19
hexagon               randconfig-001-20240618   clang-19
hexagon               randconfig-002-20240618   clang-19
i386         buildonly-randconfig-001-20240618   gcc-13
i386         buildonly-randconfig-002-20240618   gcc-12
i386         buildonly-randconfig-003-20240618   gcc-8
i386         buildonly-randconfig-004-20240618   gcc-10
i386         buildonly-randconfig-005-20240618   gcc-10
i386         buildonly-randconfig-006-20240618   gcc-10
i386                  randconfig-001-20240618   clang-18
i386                  randconfig-002-20240618   gcc-13
i386                  randconfig-003-20240618   gcc-13
i386                  randconfig-004-20240618   clang-18
i386                  randconfig-005-20240618   clang-18
i386                  randconfig-006-20240618   clang-18
i386                  randconfig-011-20240618   gcc-13
i386                  randconfig-012-20240618   gcc-11
i386                  randconfig-013-20240618   gcc-7
i386                  randconfig-014-20240618   gcc-11
i386                  randconfig-015-20240618   clang-18
i386                  randconfig-016-20240618   clang-18
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240618   gcc-13.2.0
loongarch             randconfig-002-20240618   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
m68k                                defconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240618   gcc-13.2.0
nios2                 randconfig-002-20240618   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                            defconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                              defconfig   gcc-13.2.0
parisc                randconfig-001-20240618   gcc-13.2.0
parisc                randconfig-002-20240618   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc               randconfig-001-20240618   gcc-13.2.0
powerpc               randconfig-002-20240618   clang-19
powerpc               randconfig-003-20240618   clang-19
powerpc64             randconfig-001-20240618   clang-19
powerpc64             randconfig-002-20240618   clang-17
powerpc64             randconfig-003-20240618   clang-19
riscv                             allnoconfig   gcc-13.2.0
riscv                               defconfig   clang-19
riscv                 randconfig-001-20240618   gcc-13.2.0
riscv                 randconfig-002-20240618   clang-14
s390                              allnoconfig   clang-19
s390                                defconfig   clang-19
s390                  randconfig-001-20240618   clang-15
s390                  randconfig-002-20240618   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                                  defconfig   gcc-13.2.0
sh                    randconfig-001-20240618   gcc-13.2.0
sh                    randconfig-002-20240618   gcc-13.2.0
sparc                             allnoconfig   gcc-13.2.0
sparc                               defconfig   gcc-13.2.0
sparc64                             defconfig   gcc-13.2.0
sparc64               randconfig-001-20240618   gcc-13.2.0
sparc64               randconfig-002-20240618   gcc-13.2.0
um                                allnoconfig   clang-17
um                                  defconfig   clang-19
um                             i386_defconfig   gcc-13
um                    randconfig-001-20240618   clang-19
um                    randconfig-002-20240618   clang-19
um                           x86_64_defconfig   clang-15
x86_64       buildonly-randconfig-001-20240618   clang-18
x86_64       buildonly-randconfig-002-20240618   gcc-8
x86_64       buildonly-randconfig-003-20240618   clang-18
x86_64       buildonly-randconfig-004-20240618   gcc-13
x86_64       buildonly-randconfig-005-20240618   gcc-13
x86_64       buildonly-randconfig-006-20240618   gcc-12
x86_64                randconfig-001-20240618   clang-18
x86_64                randconfig-002-20240618   clang-18
x86_64                randconfig-003-20240618   gcc-11
x86_64                randconfig-004-20240618   clang-18
x86_64                randconfig-005-20240618   clang-18
x86_64                randconfig-006-20240618   clang-18
x86_64                randconfig-011-20240618   gcc-13
x86_64                randconfig-012-20240618   gcc-8
x86_64                randconfig-013-20240618   clang-18
x86_64                randconfig-014-20240618   clang-18
x86_64                randconfig-015-20240618   gcc-13
x86_64                randconfig-016-20240618   clang-18
x86_64                randconfig-071-20240618   gcc-13
x86_64                randconfig-072-20240618   clang-18
x86_64                randconfig-073-20240618   gcc-12
x86_64                randconfig-074-20240618   clang-18
x86_64                randconfig-075-20240618   gcc-8
x86_64                randconfig-076-20240618   gcc-13
xtensa                            allnoconfig   gcc-13.2.0
xtensa                randconfig-001-20240618   gcc-13.2.0
xtensa                randconfig-002-20240618   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

