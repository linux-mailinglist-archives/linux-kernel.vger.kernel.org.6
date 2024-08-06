Return-Path: <linux-kernel+bounces-276662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E280A9496AE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 19:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A166282D78
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 17:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF23F36AF5;
	Tue,  6 Aug 2024 17:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SCdmTYi9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CDE54656
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 17:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722965134; cv=none; b=LbHRxQuLMRX7mCgWnrKWGjDp8s+gEHG98w9xGMSjQqgosvlg5dHkaarqhN9gUoc8NfaeDuqExHzxTOBNy/xf2RpKH/KyQbk27o6oloKNmhW73N+0hRq5tHxAyiRkQ1cmju7FFiutUCt4zxjL7so0NaG4JsZXbx0yt9hgK6ykrDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722965134; c=relaxed/simple;
	bh=P3pNF0lwOkUKaINamdpPLqKqFJxy7ztSNEuq36kl+uA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=iIye7tGMu0ZFoak6WgGE2iWxAn+kjdFpzTtN5BQbnf9NOU4LKcuwIDr2JXpVS0iZxRMo3ZAPSqoGklU7nsj1JaNn1yjCmMJrXtFCR58WUiqzXz1EAJobEzTBncKLjC/VTESqdWbOSbZrvkdYTz2hvZoovdbcLtWUAfkaKW1njzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SCdmTYi9; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722965132; x=1754501132;
  h=date:from:to:cc:subject:message-id;
  bh=P3pNF0lwOkUKaINamdpPLqKqFJxy7ztSNEuq36kl+uA=;
  b=SCdmTYi9q1E457/A6eX6vACPUjSbTgWbKVHMa4ufb1eLyNvl4+0g4Dpk
   tb0xn6wVvW+Hz3nGXww4C17tbEOXNaZlWh7jvFYk6USzaa57c6zRM5/jv
   P4y0S3k5xIeaZ3gTGpOpF458F8NpIOg4wlrgK+82KJHVXpK8w58mb3lOc
   Co0+v6LH0AQ/ZBScN6LSxUF4PdhRcq+FGYua7mktoKmEMwP+In1FK57v6
   mX7yXBic4MB76fHmiz+JJiqavlSRy7N6lME/zxhA2bQrBmp5wXvnNSOqW
   dpJ0wBJGWzW2n/kt+NTbjlDdCwHpc43ci5MuWV4AlD0rY86QKnuEvK1++
   A==;
X-CSE-ConnectionGUID: AhcQ1j6AQhuEIejxvUN3hg==
X-CSE-MsgGUID: PpxcOXKGTmmJc3vpXh13hA==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="46402991"
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="46402991"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 10:25:32 -0700
X-CSE-ConnectionGUID: qn0xLx7PQKeAkgv/tAo4Tw==
X-CSE-MsgGUID: XcT5yWcrS/eQ9U+1JGlYbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="56552164"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 06 Aug 2024 10:25:30 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sbNw8-0004hU-1u;
	Tue, 06 Aug 2024 17:25:28 +0000
Date: Wed, 07 Aug 2024 01:25:01 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2024.08.02a] BUILD SUCCESS
 27ce39c5b85247ba5056b439811bfb7980d952ba
Message-ID: <202408070158.fjhHchac-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://github.com/paulmckrcu/linux dev.2024.08.02a
branch HEAD: 27ce39c5b85247ba5056b439811bfb7980d952ba  locking/csd-lock: Switch from sched_clock() to ktime_get_mono_fast_ns()

elapsed time: 1280m

configs tested: 277
configs skipped: 8

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
arc                   randconfig-001-20240806   gcc-13.2.0
arc                   randconfig-002-20240806   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-20
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                              allyesconfig   gcc-14.1.0
arm                                 defconfig   gcc-13.2.0
arm                            dove_defconfig   gcc-13.2.0
arm                          ep93xx_defconfig   gcc-13.2.0
arm                           imxrt_defconfig   clang-20
arm                          ixp4xx_defconfig   clang-20
arm                         orion5x_defconfig   gcc-13.2.0
arm                          pxa3xx_defconfig   clang-20
arm                            qcom_defconfig   gcc-13.2.0
arm                   randconfig-001-20240806   clang-20
arm                   randconfig-001-20240806   gcc-13.2.0
arm                   randconfig-002-20240806   gcc-13.2.0
arm                   randconfig-002-20240806   gcc-14.1.0
arm                   randconfig-003-20240806   gcc-13.2.0
arm                   randconfig-003-20240806   gcc-14.1.0
arm                   randconfig-004-20240806   gcc-13.2.0
arm                   randconfig-004-20240806   gcc-14.1.0
arm                           spitz_defconfig   clang-20
arm64                            alldefconfig   clang-20
arm64                            allmodconfig   clang-20
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240806   clang-20
arm64                 randconfig-001-20240806   gcc-13.2.0
arm64                 randconfig-002-20240806   clang-20
arm64                 randconfig-002-20240806   gcc-13.2.0
arm64                 randconfig-003-20240806   clang-14
arm64                 randconfig-003-20240806   gcc-13.2.0
arm64                 randconfig-004-20240806   gcc-13.2.0
arm64                 randconfig-004-20240806   gcc-14.1.0
csky                              allnoconfig   gcc-13.2.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240806   gcc-13.2.0
csky                  randconfig-001-20240806   gcc-14.1.0
csky                  randconfig-002-20240806   gcc-13.2.0
csky                  randconfig-002-20240806   gcc-14.1.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   clang-20
hexagon                          allyesconfig   clang-20
hexagon               randconfig-001-20240806   clang-20
hexagon               randconfig-002-20240806   clang-17
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-12
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-12
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240806   gcc-11
i386         buildonly-randconfig-002-20240806   gcc-11
i386         buildonly-randconfig-002-20240806   gcc-12
i386         buildonly-randconfig-003-20240806   gcc-11
i386         buildonly-randconfig-003-20240806   gcc-12
i386         buildonly-randconfig-004-20240806   gcc-11
i386         buildonly-randconfig-004-20240806   gcc-12
i386         buildonly-randconfig-005-20240806   clang-18
i386         buildonly-randconfig-005-20240806   gcc-11
i386         buildonly-randconfig-006-20240806   gcc-11
i386         buildonly-randconfig-006-20240806   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240806   clang-18
i386                  randconfig-001-20240806   gcc-11
i386                  randconfig-002-20240806   gcc-11
i386                  randconfig-002-20240806   gcc-12
i386                  randconfig-003-20240806   gcc-11
i386                  randconfig-003-20240806   gcc-12
i386                  randconfig-004-20240806   gcc-11
i386                  randconfig-004-20240806   gcc-12
i386                  randconfig-005-20240806   clang-18
i386                  randconfig-005-20240806   gcc-11
i386                  randconfig-006-20240806   clang-18
i386                  randconfig-006-20240806   gcc-11
i386                  randconfig-011-20240806   clang-18
i386                  randconfig-011-20240806   gcc-11
i386                  randconfig-012-20240806   gcc-11
i386                  randconfig-012-20240806   gcc-12
i386                  randconfig-013-20240806   clang-18
i386                  randconfig-013-20240806   gcc-11
i386                  randconfig-014-20240806   clang-18
i386                  randconfig-014-20240806   gcc-11
i386                  randconfig-015-20240806   clang-18
i386                  randconfig-015-20240806   gcc-11
i386                  randconfig-016-20240806   clang-18
i386                  randconfig-016-20240806   gcc-11
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240806   gcc-13.2.0
loongarch             randconfig-001-20240806   gcc-14.1.0
loongarch             randconfig-002-20240806   gcc-13.2.0
loongarch             randconfig-002-20240806   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
m68k                        m5407c3_defconfig   gcc-14.1.0
m68k                          multi_defconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-14.1.0
mips                          ath25_defconfig   clang-20
mips                 decstation_r4k_defconfig   clang-20
mips                          eyeq5_defconfig   clang-20
mips                           ip28_defconfig   gcc-13.2.0
nios2                         10m50_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240806   gcc-13.2.0
nios2                 randconfig-001-20240806   gcc-14.1.0
nios2                 randconfig-002-20240806   gcc-13.2.0
nios2                 randconfig-002-20240806   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240806   gcc-13.2.0
parisc                randconfig-001-20240806   gcc-14.1.0
parisc                randconfig-002-20240806   gcc-13.2.0
parisc                randconfig-002-20240806   gcc-14.1.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-20
powerpc                          allyesconfig   gcc-14.1.0
powerpc                        cell_defconfig   clang-20
powerpc                       ebony_defconfig   gcc-13.2.0
powerpc                 mpc836x_rdk_defconfig   clang-20
powerpc                 mpc837x_rdb_defconfig   gcc-13.2.0
powerpc                  mpc866_ads_defconfig   gcc-13.2.0
powerpc                  mpc885_ads_defconfig   gcc-13.2.0
powerpc               randconfig-001-20240806   gcc-13.2.0
powerpc               randconfig-001-20240806   gcc-14.1.0
powerpc               randconfig-003-20240806   clang-20
powerpc               randconfig-003-20240806   gcc-13.2.0
powerpc                     tqm5200_defconfig   gcc-13.2.0
powerpc                     tqm8540_defconfig   gcc-13.2.0
powerpc                        warp_defconfig   clang-20
powerpc64             randconfig-001-20240806   gcc-13.2.0
powerpc64             randconfig-001-20240806   gcc-14.1.0
powerpc64             randconfig-002-20240806   clang-16
powerpc64             randconfig-002-20240806   gcc-13.2.0
powerpc64             randconfig-003-20240806   gcc-13.2.0
riscv                            allmodconfig   clang-20
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-20
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   clang-20
riscv                               defconfig   gcc-14.1.0
riscv                 randconfig-001-20240806   gcc-13.2.0
riscv                 randconfig-001-20240806   gcc-14.1.0
riscv                 randconfig-002-20240806   clang-20
riscv                 randconfig-002-20240806   gcc-13.2.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   clang-20
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240806   clang-20
s390                  randconfig-001-20240806   gcc-13.2.0
s390                  randconfig-002-20240806   clang-20
s390                  randconfig-002-20240806   gcc-13.2.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                        apsh4ad0a_defconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                    randconfig-001-20240806   gcc-13.2.0
sh                    randconfig-001-20240806   gcc-14.1.0
sh                    randconfig-002-20240806   gcc-13.2.0
sh                    randconfig-002-20240806   gcc-14.1.0
sh                           se7343_defconfig   gcc-13.2.0
sh                           se7751_defconfig   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc                       sparc32_defconfig   gcc-13.2.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240806   gcc-13.2.0
sparc64               randconfig-001-20240806   gcc-14.1.0
sparc64               randconfig-002-20240806   gcc-13.2.0
sparc64               randconfig-002-20240806   gcc-14.1.0
um                               allmodconfig   clang-20
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-12
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   clang-20
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-12
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240806   clang-20
um                    randconfig-001-20240806   gcc-13.2.0
um                    randconfig-002-20240806   gcc-12
um                    randconfig-002-20240806   gcc-13.2.0
um                           x86_64_defconfig   clang-15
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240806   clang-18
x86_64       buildonly-randconfig-002-20240806   clang-18
x86_64       buildonly-randconfig-003-20240806   clang-18
x86_64       buildonly-randconfig-004-20240806   clang-18
x86_64       buildonly-randconfig-005-20240806   clang-18
x86_64       buildonly-randconfig-005-20240806   gcc-12
x86_64       buildonly-randconfig-006-20240806   clang-18
x86_64       buildonly-randconfig-006-20240806   gcc-12
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-11
x86_64                randconfig-001-20240806   clang-18
x86_64                randconfig-001-20240806   gcc-12
x86_64                randconfig-002-20240806   clang-18
x86_64                randconfig-002-20240806   gcc-11
x86_64                randconfig-003-20240806   clang-18
x86_64                randconfig-003-20240806   gcc-12
x86_64                randconfig-004-20240806   clang-18
x86_64                randconfig-005-20240806   clang-18
x86_64                randconfig-006-20240806   clang-18
x86_64                randconfig-011-20240806   clang-18
x86_64                randconfig-011-20240806   gcc-12
x86_64                randconfig-012-20240806   clang-18
x86_64                randconfig-012-20240806   gcc-12
x86_64                randconfig-013-20240806   clang-18
x86_64                randconfig-014-20240806   clang-18
x86_64                randconfig-014-20240806   gcc-12
x86_64                randconfig-015-20240806   clang-18
x86_64                randconfig-015-20240806   gcc-12
x86_64                randconfig-016-20240806   clang-18
x86_64                randconfig-016-20240806   gcc-12
x86_64                randconfig-071-20240806   clang-18
x86_64                randconfig-071-20240806   gcc-12
x86_64                randconfig-072-20240806   clang-18
x86_64                randconfig-073-20240806   clang-18
x86_64                randconfig-073-20240806   gcc-11
x86_64                randconfig-074-20240806   clang-18
x86_64                randconfig-074-20240806   gcc-12
x86_64                randconfig-075-20240806   clang-18
x86_64                randconfig-075-20240806   gcc-12
x86_64                randconfig-076-20240806   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                           alldefconfig   gcc-13.2.0
xtensa                            allnoconfig   gcc-13.2.0
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240806   gcc-13.2.0
xtensa                randconfig-001-20240806   gcc-14.1.0
xtensa                randconfig-002-20240806   gcc-13.2.0
xtensa                randconfig-002-20240806   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

