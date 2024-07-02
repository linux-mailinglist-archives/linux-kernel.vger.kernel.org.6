Return-Path: <linux-kernel+bounces-237597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E05923B4C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 12:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 605E11F22A1B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 10:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EED1581EF;
	Tue,  2 Jul 2024 10:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="De7gUpaA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CFD154449
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 10:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719915742; cv=none; b=qHIj32e6JvtNDYbLKMJC2/Q0Vkis292/+jFfRziCaQm5GQKfnuto7bno1YZpVcF+DKa7iv+2XCIdjTiH8Sr1FNoeatXAAch04p9vdxNyRVVPpfs9ydfsIyom4k6ubLhY0U4XmRUDwmZVyUwl1AiJqPJvwglMgnMkupfdJ7HYGEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719915742; c=relaxed/simple;
	bh=WfqZyi4LoGrbzK3MHSstHyqh1YnCzCGBkGU9duvXvH8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=hRA6zkBm1xl1QreWMr8a6HqJfLcRTvq/ee8eH05RA8i5qN3vOQQb7FTtz++LyzLW/QSriM8eiJguMzvqcq/vKCFmWK26VNND0Px0ZlTNeOfDJU7a9FaCJV96tMxpvjubZOUCw2hHCvu968oH8v1Y33hZok5likYx/BYBQ1SmcBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=De7gUpaA; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719915740; x=1751451740;
  h=date:from:to:cc:subject:message-id;
  bh=WfqZyi4LoGrbzK3MHSstHyqh1YnCzCGBkGU9duvXvH8=;
  b=De7gUpaAyssCRT7blMWHi1ayrK30jLyKuXoCZsujSyXGQKgFWf6YQNFs
   GNPhLg1Xk0RqLa9VHl5/vthysikxL8oEp/IpWx6VkrpbVcQgjx2btMsuO
   x32k7DMfVZJu/BwQK0KwP40mAYIRegq5ta/5qGsY39xu6IaCQq63C7GJu
   EW/EJKqXhQpFCQfIwqSKoFFkHBVe48HckvUxCaRQcleS57YL/wCK5onCh
   C8sOwGqFTgQdlMOK3I2tKngfsW10s2wPpF8GwAUXX/l8LIy5mVRowKw3J
   GYCI1CC3n9HCx5L0sRhd4quxl+Ia+3dx55V1iqDqO9W06Nv10s84q9IQO
   A==;
X-CSE-ConnectionGUID: Rzz0CiGNSTmUBsbHQ6MRmw==
X-CSE-MsgGUID: QlIO28L2Qra36T1mb5+0yg==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="17295034"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="17295034"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 03:22:20 -0700
X-CSE-ConnectionGUID: a1Gk7CepSv29TyXkxbALNw==
X-CSE-MsgGUID: 8m6NFuWnSn6YkjjZ7zOt2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="77022919"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 02 Jul 2024 03:22:19 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sOaeO-000O1Y-2w;
	Tue, 02 Jul 2024 10:22:17 +0000
Date: Tue, 02 Jul 2024 18:22:00 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:non-rcu/next] BUILD SUCCESS
 f5d5a3bc7a6922244b5e28f11224f1861d4ff094
Message-ID: <202407021856.JoE3XhSu-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git non-rcu/next
branch HEAD: f5d5a3bc7a6922244b5e28f11224f1861d4ff094  tools/memory-model: simple.txt: Fix stale reference to recipes-pairs.txt

elapsed time: 2531m

configs tested: 107
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                               defconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240702   gcc-13.2.0
arc                   randconfig-002-20240702   gcc-13.2.0
arm                               allnoconfig   clang-19
arm                         at91_dt_defconfig   clang-19
arm                         bcm2835_defconfig   clang-19
arm                           h3600_defconfig   gcc-13.2.0
arm                   randconfig-001-20240702   gcc-13.2.0
arm                   randconfig-002-20240702   gcc-13.2.0
arm                   randconfig-003-20240702   gcc-13.2.0
arm                   randconfig-004-20240702   gcc-13.2.0
arm                         s3c6400_defconfig   gcc-13.2.0
arm                    vt8500_v6_v7_defconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                 randconfig-001-20240702   gcc-13.2.0
arm64                 randconfig-002-20240702   clang-19
arm64                 randconfig-003-20240702   gcc-13.2.0
arm64                 randconfig-004-20240702   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240702   gcc-13.2.0
csky                  randconfig-002-20240702   gcc-13.2.0
hexagon                           allnoconfig   clang-19
hexagon               randconfig-001-20240702   clang-19
hexagon               randconfig-002-20240702   clang-19
i386                             alldefconfig   gcc-13
i386         buildonly-randconfig-001-20240701   clang-18
i386         buildonly-randconfig-002-20240701   clang-18
i386         buildonly-randconfig-003-20240701   clang-18
i386         buildonly-randconfig-004-20240701   clang-18
i386         buildonly-randconfig-005-20240701   gcc-13
i386         buildonly-randconfig-006-20240701   gcc-9
i386                  randconfig-001-20240701   clang-18
i386                  randconfig-002-20240701   clang-18
i386                  randconfig-003-20240701   clang-18
i386                  randconfig-004-20240701   gcc-7
i386                  randconfig-005-20240701   clang-18
i386                  randconfig-006-20240701   gcc-13
i386                  randconfig-011-20240701   gcc-13
i386                  randconfig-012-20240701   clang-18
i386                  randconfig-013-20240701   clang-18
i386                  randconfig-014-20240701   gcc-8
i386                  randconfig-015-20240701   gcc-10
i386                  randconfig-016-20240701   clang-18
loongarch                         allnoconfig   gcc-13.2.0
loongarch             randconfig-001-20240702   gcc-13.2.0
loongarch             randconfig-002-20240702   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                          eyeq5_defconfig   gcc-13.2.0
mips                           ip27_defconfig   gcc-13.2.0
mips                      malta_kvm_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                 randconfig-001-20240702   gcc-13.2.0
nios2                 randconfig-002-20240702   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                randconfig-001-20240702   gcc-13.2.0
parisc                randconfig-002-20240702   gcc-13.2.0
powerpc                     akebono_defconfig   clang-19
powerpc                           allnoconfig   gcc-13.2.0
powerpc                      ppc6xx_defconfig   gcc-13.2.0
powerpc               randconfig-001-20240702   gcc-13.2.0
powerpc               randconfig-002-20240702   clang-16
powerpc               randconfig-003-20240702   gcc-13.2.0
powerpc                     tqm5200_defconfig   gcc-13.2.0
powerpc64             randconfig-001-20240702   clang-19
powerpc64             randconfig-002-20240702   gcc-13.2.0
powerpc64             randconfig-003-20240702   clang-19
riscv                             allnoconfig   gcc-13.2.0
riscv                               defconfig   clang-19
riscv                 randconfig-001-20240702   gcc-13.2.0
riscv                 randconfig-002-20240702   gcc-13.2.0
s390                              allnoconfig   clang-19
s390                  randconfig-001-20240702   clang-19
s390                  randconfig-002-20240702   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                            migor_defconfig   gcc-13.2.0
sh                    randconfig-001-20240702   gcc-13.2.0
sh                    randconfig-002-20240702   gcc-13.2.0
sh                          sdk7780_defconfig   gcc-13.2.0
sh                          sdk7786_defconfig   gcc-13.2.0
sh                        sh7763rdp_defconfig   gcc-13.2.0
sparc64               randconfig-001-20240702   gcc-13.2.0
sparc64               randconfig-002-20240702   gcc-13.2.0
um                                allnoconfig   clang-17
um                    randconfig-001-20240702   gcc-8
um                    randconfig-002-20240702   gcc-13
x86_64       buildonly-randconfig-001-20240702   gcc-8
x86_64       buildonly-randconfig-002-20240702   clang-18
x86_64       buildonly-randconfig-003-20240702   clang-18
x86_64       buildonly-randconfig-004-20240702   clang-18
x86_64       buildonly-randconfig-005-20240702   gcc-13
x86_64       buildonly-randconfig-006-20240702   clang-18
x86_64                randconfig-001-20240702   clang-18
x86_64                randconfig-002-20240702   gcc-11
x86_64                randconfig-003-20240702   gcc-13
x86_64                randconfig-004-20240702   gcc-9
x86_64                randconfig-005-20240702   clang-18
x86_64                randconfig-006-20240702   gcc-13
xtensa                            allnoconfig   gcc-13.2.0
xtensa                randconfig-001-20240702   gcc-13.2.0
xtensa                randconfig-002-20240702   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

