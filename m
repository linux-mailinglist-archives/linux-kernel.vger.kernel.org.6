Return-Path: <linux-kernel+bounces-393242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 173109B9E2D
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 10:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C22AD281433
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 09:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A076715D5CE;
	Sat,  2 Nov 2024 09:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eA7bVvYJ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C0115A856
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 09:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730539650; cv=none; b=hb8JgfAQ77VETF50dt9x4wudoaVr0WEhecSfcLM8C7XgghEl64FFNXDOgqU8ypAc6zyncYb8iPSPxIPo7yn3byUWNzyOg4abNtamM6Velt3m+opqb2UAAvvPjDJ3j+VzZQeEVTQMfcH4se9OQy10teC5/Mt1RjUujkHvqcuwY7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730539650; c=relaxed/simple;
	bh=a8FoY3rmi77J5IJ/vfD0THbJBagFR4J4VqZQ8muZAB0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=g2MgeAHNrtG2ET81xPCoAMgpWUv+uS0szWRGQUGL3DsaCN17qgllF8o1GT8tLwPDcQ1Hl+UuNPNTvflbH31/E9CNVphCTFixoJiO6mTEMT1l/3qUbCKThRAf4BxvS1OtvFE0mIPdq9czoDaXppz7cYjmwX5wL/cyYUwaj2oAfRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eA7bVvYJ; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730539649; x=1762075649;
  h=date:from:to:cc:subject:message-id;
  bh=a8FoY3rmi77J5IJ/vfD0THbJBagFR4J4VqZQ8muZAB0=;
  b=eA7bVvYJjNd/0kv3z5AkfF1oRzMcipieUtt0YzwXhpvsMcCONvAog81p
   QYc+QjnrkO/JtIk4mzjFSCM8xgbPCUi/IwrbJJr+ApeI8+qQ/fRv1d4Yb
   LrvvdHfa0Z6/JJSAxFXiv/Uh741z0TRuDRR+d7Hhfv9PvpL4rOX5+VV8N
   63qMkNT0qlZ7gxn1q+CeFAR2mmT276kcizWqQJuteAs4lQxl7kEyfL6FX
   8GCRiD3+Dzn2GpmFoyb34qKpXKZmZJzVHF5Qbg/xTcDwt2cTsYllA6zq6
   8m+B8I/hJjCP+V46BupPy04BLxDBvZqXhXhmDx1lNs6xQWraJ9FjussMO
   g==;
X-CSE-ConnectionGUID: Sw73D3BDRCiz+yMyIXsPzA==
X-CSE-MsgGUID: 7oJOUmRMT5ODPlWEhPIrIw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="33989608"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="33989608"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2024 02:27:28 -0700
X-CSE-ConnectionGUID: kOMqGwGJQZWLJAX6iMhzJA==
X-CSE-MsgGUID: 1qhuFUwSQzCpNemrKRVPBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,252,1725346800"; 
   d="scan'208";a="87119230"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 02 Nov 2024 02:27:26 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t7APk-000igH-0R;
	Sat, 02 Nov 2024 09:27:24 +0000
Date: Sat, 02 Nov 2024 17:26:41 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:non-rcu/next] BUILD SUCCESS
 7dc725efeb3031d69078f4630963a60fde0d7c4a
Message-ID: <202411021728.LPlgOkVl-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git non-rcu/next
branch HEAD: 7dc725efeb3031d69078f4630963a60fde0d7c4a  Merge branches 'csd-lock.2024.10.11a' and 'lkmm.2024.10.11a', tag 'nolibc.2024.11.01a' into HEAD

elapsed time: 845m

configs tested: 190
configs skipped: 4

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
arc                   randconfig-001-20241102    gcc-14.1.0
arc                   randconfig-002-20241102    gcc-14.1.0
arc                           tb10x_defconfig    clang-14
arc                           tb10x_defconfig    gcc-14.1.0
arc                        vdk_hs38_defconfig    clang-14
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                                 defconfig    gcc-14.1.0
arm                            dove_defconfig    gcc-14.1.0
arm                       imx_v4_v5_defconfig    clang-14
arm                        multi_v5_defconfig    gcc-14.1.0
arm                        mvebu_v5_defconfig    clang-14
arm                   randconfig-001-20241102    gcc-14.1.0
arm                   randconfig-002-20241102    gcc-14.1.0
arm                   randconfig-003-20241102    gcc-14.1.0
arm                   randconfig-004-20241102    gcc-14.1.0
arm                           sunxi_defconfig    clang-14
arm                           tegra_defconfig    gcc-14.1.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
arm64                 randconfig-001-20241102    gcc-14.1.0
arm64                 randconfig-002-20241102    gcc-14.1.0
arm64                 randconfig-003-20241102    gcc-14.1.0
arm64                 randconfig-004-20241102    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
csky                  randconfig-001-20241102    gcc-14.1.0
csky                  randconfig-002-20241102    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
hexagon               randconfig-001-20241102    gcc-14.1.0
hexagon               randconfig-002-20241102    gcc-14.1.0
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                             allyesconfig    clang-19
i386        buildonly-randconfig-001-20241102    gcc-12
i386        buildonly-randconfig-002-20241102    gcc-12
i386        buildonly-randconfig-003-20241102    gcc-12
i386        buildonly-randconfig-004-20241102    gcc-12
i386        buildonly-randconfig-005-20241102    gcc-12
i386        buildonly-randconfig-006-20241102    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20241102    gcc-12
i386                  randconfig-002-20241102    gcc-12
i386                  randconfig-003-20241102    gcc-12
i386                  randconfig-004-20241102    gcc-12
i386                  randconfig-005-20241102    gcc-12
i386                  randconfig-006-20241102    gcc-12
i386                  randconfig-011-20241102    gcc-12
i386                  randconfig-012-20241102    gcc-12
i386                  randconfig-013-20241102    gcc-12
i386                  randconfig-014-20241102    gcc-12
i386                  randconfig-015-20241102    gcc-12
i386                  randconfig-016-20241102    gcc-12
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
loongarch             randconfig-001-20241102    gcc-14.1.0
loongarch             randconfig-002-20241102    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                         apollo_defconfig    clang-14
m68k                                defconfig    gcc-14.1.0
m68k                        m5307c3_defconfig    gcc-14.1.0
m68k                        m5407c3_defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                        bcm63xx_defconfig    clang-14
mips                           ip30_defconfig    gcc-14.1.0
mips                        omega2p_defconfig    clang-14
nios2                            alldefconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
nios2                 randconfig-001-20241102    gcc-14.1.0
nios2                 randconfig-002-20241102    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                           alldefconfig    clang-14
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20241102    gcc-14.1.0
parisc                randconfig-002-20241102    gcc-14.1.0
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.1.0
powerpc                      arches_defconfig    gcc-14.1.0
powerpc                     mpc5200_defconfig    clang-14
powerpc                    mvme5100_defconfig    gcc-14.1.0
powerpc                      pasemi_defconfig    gcc-14.1.0
powerpc               randconfig-001-20241102    gcc-14.1.0
powerpc               randconfig-002-20241102    gcc-14.1.0
powerpc               randconfig-003-20241102    gcc-14.1.0
powerpc64             randconfig-001-20241102    gcc-14.1.0
powerpc64             randconfig-002-20241102    gcc-14.1.0
powerpc64             randconfig-003-20241102    gcc-14.1.0
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20241102    gcc-14.1.0
riscv                 randconfig-002-20241102    gcc-14.1.0
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20241102    gcc-14.1.0
s390                  randconfig-002-20241102    gcc-14.1.0
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                             espt_defconfig    gcc-14.1.0
sh                 kfr2r09-romimage_defconfig    clang-14
sh                          r7785rp_defconfig    clang-14
sh                    randconfig-001-20241102    gcc-14.1.0
sh                    randconfig-002-20241102    gcc-14.1.0
sh                           se7619_defconfig    clang-14
sh                           se7750_defconfig    clang-14
sh                        sh7785lcr_defconfig    gcc-14.1.0
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20241102    gcc-14.1.0
sparc64               randconfig-002-20241102    gcc-14.1.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    clang-14
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241102    gcc-14.1.0
um                    randconfig-002-20241102    gcc-14.1.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241102    clang-19
x86_64      buildonly-randconfig-002-20241102    clang-19
x86_64      buildonly-randconfig-003-20241102    clang-19
x86_64      buildonly-randconfig-004-20241102    clang-19
x86_64      buildonly-randconfig-005-20241102    clang-19
x86_64      buildonly-randconfig-006-20241102    clang-19
x86_64                              defconfig    clang-19
x86_64                                  kexec    clang-19
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20241102    clang-19
x86_64                randconfig-002-20241102    clang-19
x86_64                randconfig-003-20241102    clang-19
x86_64                randconfig-004-20241102    clang-19
x86_64                randconfig-005-20241102    clang-19
x86_64                randconfig-006-20241102    clang-19
x86_64                randconfig-011-20241102    clang-19
x86_64                randconfig-012-20241102    clang-19
x86_64                randconfig-013-20241102    clang-19
x86_64                randconfig-014-20241102    clang-19
x86_64                randconfig-015-20241102    clang-19
x86_64                randconfig-016-20241102    clang-19
x86_64                randconfig-071-20241102    clang-19
x86_64                randconfig-072-20241102    clang-19
x86_64                randconfig-073-20241102    clang-19
x86_64                randconfig-074-20241102    clang-19
x86_64                randconfig-075-20241102    clang-19
x86_64                randconfig-076-20241102    clang-19
x86_64                               rhel-8.3    gcc-12
x86_64                           rhel-8.3-bpf    clang-19
x86_64                         rhel-8.3-kunit    clang-19
x86_64                           rhel-8.3-ltp    clang-19
x86_64                          rhel-8.3-rust    clang-19
xtensa                            allnoconfig    gcc-14.1.0
xtensa                       common_defconfig    clang-14
xtensa                          iss_defconfig    gcc-14.1.0
xtensa                randconfig-001-20241102    gcc-14.1.0
xtensa                randconfig-002-20241102    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

