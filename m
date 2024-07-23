Return-Path: <linux-kernel+bounces-259755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F508939C9D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 10:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0FCB1F22A8B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 08:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8250A14BF90;
	Tue, 23 Jul 2024 08:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QAh6ZOFU"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BE514B07A
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 08:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721723246; cv=none; b=Z3rqDxOS9mruHaRD2PxF74eQqa4slgqtiBUoBTHrdvyWscJpFJzPDYVGHxnbRTahdxzVd8L2C2Hg+dNJVTDT0tMqyMuU7MPSONHkcAicCHII85uum6Xi6Bu5/C9uexkQO1houQu7qr3e+wT+EnEZO815xbf+kDH3YdJkR1x6gB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721723246; c=relaxed/simple;
	bh=5LnIp+rL+Kw3aUDzKdZWOp7wbOn4QPzI1Dk1xl+xuSE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Fy3R32rUfk1ghqlVH0R+mUI+4F4XR8hyQoJBPnddF3t1zgGCdSuOOAvngRrXxJorKmI2W/Pb7yyrDX5QsxtBGgFpdG397W9WrMxhn6I8nX0kEiiRvzqct8ZWwapxCQA61t+1RJs93aosADnN0AwvIZKlFvJSoApVBvRXX7UcXus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QAh6ZOFU; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721723244; x=1753259244;
  h=date:from:to:cc:subject:message-id;
  bh=5LnIp+rL+Kw3aUDzKdZWOp7wbOn4QPzI1Dk1xl+xuSE=;
  b=QAh6ZOFUl29tDui/ZEoW9KkkVH7e01YBzQMMZ9voIkqU9OMGNyoqar9j
   +sy5tfc5NxiE2u6sjLWKgpW8YWfEsMw5JoThxobL/L+Ry1H38VWXfMlzC
   IjoFATjScK1aTyLSiqwYOglQAO81Txu9JFFmJ9UVIs0Q/1cJHKX+8iNSF
   CkIgdEVO7Vne64u8qdoUhEXg8f5SEJ0e8ZWQhCKsD69ZOTl/HVnJ6GGWf
   iJQygabhySRxg6YwkPOsXi9u2GHdyeGclBHCafr8+VzCuwsN1epHGG6sZ
   DIH9D5bUPNHRR5hpAJuHtKyjqAWgAccAoagNWlZLfDQQ6yxbRHJNGeDy5
   Q==;
X-CSE-ConnectionGUID: 7EbNkcIgSAOkn65Cf+cqLw==
X-CSE-MsgGUID: POiRUEa1Rz+BZbGeIri+mQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11141"; a="29923579"
X-IronPort-AV: E=Sophos;i="6.09,230,1716274800"; 
   d="scan'208";a="29923579"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2024 01:27:24 -0700
X-CSE-ConnectionGUID: 1VrlYuydTjGr+9Cahb/0oQ==
X-CSE-MsgGUID: dnef7Nz0QR2yxj1wZKUxiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,230,1716274800"; 
   d="scan'208";a="52902855"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 23 Jul 2024 01:27:22 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sWArf-000lmY-2N;
	Tue, 23 Jul 2024 08:27:19 +0000
Date: Tue, 23 Jul 2024 16:26:52 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:timers/urgent] BUILD SUCCESS
 f004bf9de057004f7ccea4239317aec2fbd8240b
Message-ID: <202407231649.VqNJPXbz-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/urgent
branch HEAD: f004bf9de057004f7ccea4239317aec2fbd8240b  timers/migration: Fix grammar in comment

elapsed time: 723m

configs tested: 147
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                   randconfig-001-20240723   gcc-13.2.0
arc                   randconfig-002-20240723   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-19
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-14.1.0
arm                   randconfig-001-20240723   gcc-14.1.0
arm                   randconfig-002-20240723   gcc-14.1.0
arm                   randconfig-003-20240723   gcc-14.1.0
arm                   randconfig-004-20240723   clang-19
arm64                            allmodconfig   clang-19
arm64                             allnoconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-14.1.0
arm64                 randconfig-001-20240723   gcc-14.1.0
arm64                 randconfig-002-20240723   gcc-14.1.0
arm64                 randconfig-003-20240723   clang-19
arm64                 randconfig-004-20240723   clang-16
csky                              allnoconfig   gcc-13.2.0
csky                              allnoconfig   gcc-14.1.0
csky                  randconfig-001-20240723   gcc-14.1.0
csky                  randconfig-002-20240723   gcc-14.1.0
hexagon                          allmodconfig   clang-19
hexagon                           allnoconfig   clang-19
hexagon                          allyesconfig   clang-19
hexagon               randconfig-001-20240723   clang-19
hexagon               randconfig-002-20240723   clang-19
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-13
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-13
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240723   gcc-8
i386         buildonly-randconfig-002-20240723   gcc-8
i386         buildonly-randconfig-003-20240723   gcc-13
i386         buildonly-randconfig-004-20240723   gcc-12
i386         buildonly-randconfig-005-20240723   clang-18
i386         buildonly-randconfig-006-20240723   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240723   clang-18
i386                  randconfig-002-20240723   gcc-12
i386                  randconfig-003-20240723   gcc-13
i386                  randconfig-004-20240723   gcc-10
i386                  randconfig-005-20240723   gcc-13
i386                  randconfig-006-20240723   gcc-13
i386                  randconfig-011-20240723   gcc-11
i386                  randconfig-012-20240723   clang-18
i386                  randconfig-013-20240723   clang-18
i386                  randconfig-014-20240723   gcc-7
i386                  randconfig-015-20240723   gcc-13
i386                  randconfig-016-20240723   clang-18
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch             randconfig-001-20240723   gcc-14.1.0
loongarch             randconfig-002-20240723   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
mips                              allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-14.1.0
nios2                 randconfig-001-20240723   gcc-14.1.0
nios2                 randconfig-002-20240723   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240723   gcc-14.1.0
parisc                randconfig-002-20240723   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-19
powerpc               randconfig-001-20240723   gcc-14.1.0
powerpc               randconfig-002-20240723   gcc-14.1.0
powerpc               randconfig-003-20240723   gcc-14.1.0
powerpc64             randconfig-001-20240723   gcc-14.1.0
powerpc64             randconfig-002-20240723   gcc-14.1.0
powerpc64             randconfig-003-20240723   clang-14
riscv                            allmodconfig   clang-19
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-19
riscv                               defconfig   clang-19
riscv                 randconfig-001-20240723   gcc-14.1.0
riscv                 randconfig-002-20240723   clang-17
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   clang-19
s390                  randconfig-001-20240723   clang-19
s390                  randconfig-002-20240723   clang-19
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                    randconfig-001-20240723   gcc-14.1.0
sh                    randconfig-002-20240723   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240723   gcc-14.1.0
sparc64               randconfig-002-20240723   gcc-14.1.0
um                               allmodconfig   clang-19
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-13
um                                  defconfig   clang-19
um                             i386_defconfig   gcc-13
um                    randconfig-001-20240723   gcc-10
um                    randconfig-002-20240723   gcc-8
um                           x86_64_defconfig   clang-15
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240723   gcc-10
x86_64       buildonly-randconfig-002-20240723   gcc-10
x86_64       buildonly-randconfig-003-20240723   gcc-12
x86_64       buildonly-randconfig-004-20240723   gcc-8
x86_64       buildonly-randconfig-005-20240723   gcc-12
x86_64       buildonly-randconfig-006-20240723   gcc-10
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240723   clang-18
x86_64                randconfig-002-20240723   clang-18
x86_64                randconfig-003-20240723   clang-18
x86_64                randconfig-004-20240723   clang-18
x86_64                randconfig-005-20240723   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240723   gcc-14.1.0
xtensa                randconfig-002-20240723   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

