Return-Path: <linux-kernel+bounces-314958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CDB96BB89
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 14:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 188011C22B98
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 12:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024731D6DDE;
	Wed,  4 Sep 2024 12:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e89vgAAo"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585C51D67B1
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 12:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725451534; cv=none; b=h+hucV58c9SIWLBw1jbIOjFWdGiWi3oWwNqp4v8LCxIJm2ycLi2p7uJNygqTE8+oQa3NY/l0fjOAYGKXFl84WjDNANKYs0DkqCU8yF4gbZPpNjZPhCRzJgi8XS3HBB7xHBI7GMk2gKdG7uNy2EJ7sPmPafC+9YeG+7LSscySRJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725451534; c=relaxed/simple;
	bh=uMxnbCBq+HbYovLNg/Dum1eEjvxvG1ArFr5Nf8f1zwM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=udaJKqrXqUn5+x2Rkv+jlcOfx7oeMAhg7fgu3udg/s5vEpjzMZbjsoS3WvODWkZuJa7vc5+h1BgNcT2Sk7XdopW0MLzusGl+hyZSi9r8Llj4WB8aXxA3Jn5UKmFU3VJ/g7Uxk98bUwqC3VbZPDnp7I5a7R5v5oj8sUVCekIVXPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e89vgAAo; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725451532; x=1756987532;
  h=date:from:to:cc:subject:message-id;
  bh=uMxnbCBq+HbYovLNg/Dum1eEjvxvG1ArFr5Nf8f1zwM=;
  b=e89vgAAoTGyegKiN0M8i5kcPhhRPtnTRG+y1Aas0DtpdqvyfVeReUF+l
   G6Ew78EAadEUJ3rQT0RmQ8ZHcZPwzmpLepcAU8k9ut+xZGl4FVwTrGfkI
   vhHInnqV5MD1crbhW8b/yiw2VIqLWghVQ1oIgvS3soRvHQw94LwxkZxxL
   8pfZKtslvCBHr9pghMIwlGnshL8uySAstmGP91dafZhfjwev+NQTuR3hx
   TAXIgThiEc6JOr2d9J0Uct+hyxfDj8+Scfc2U1x8bMu/OwUunxRf4BEvw
   29AwV/mS+jViYMWC8QvRF4sHV6soQFz81wnewsdjBYCFVvFlhkJPNf48B
   g==;
X-CSE-ConnectionGUID: U7fEbyraSSiVOeMDTnGwaQ==
X-CSE-MsgGUID: sG0az+wDSoKDhC4VWbfb3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="41605191"
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="41605191"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 05:05:12 -0700
X-CSE-ConnectionGUID: B0Nyq5tpRt6Ou19tJ8qukw==
X-CSE-MsgGUID: yMQIVpKKSH2D7nW1YZ9a5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="65589842"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 04 Sep 2024 05:05:11 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1slol3-0007xF-1B;
	Wed, 04 Sep 2024 12:05:09 +0000
Date: Wed, 04 Sep 2024 20:04:27 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2024.08.31a] BUILD SUCCESS
 01c732e108f6ea51e1660ad6bd59fff36e653ddb
Message-ID: <202409042024.iSdLaNQm-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2024.08.31a
branch HEAD: 01c732e108f6ea51e1660ad6bd59fff36e653ddb  squash! srcu: Add srcu_read_lock_lite() and srcu_read_unlock_lite()

elapsed time: 1223m

configs tested: 110
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-14.1.0
alpha                            allyesconfig   clang-20
alpha                               defconfig   gcc-14.1.0
arc                              allmodconfig   clang-20
arc                               allnoconfig   gcc-14.1.0
arc                              allyesconfig   clang-20
arc                                 defconfig   gcc-14.1.0
arm                              allmodconfig   clang-20
arm                               allnoconfig   gcc-14.1.0
arm                              allyesconfig   clang-20
arm                                 defconfig   gcc-14.1.0
arm                        neponset_defconfig   gcc-14.1.0
arm                         socfpga_defconfig   gcc-14.1.0
arm64                            allmodconfig   clang-20
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-14.1.0
csky                             alldefconfig   gcc-14.1.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-14.1.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   gcc-14.1.0
hexagon                          allyesconfig   clang-20
hexagon                             defconfig   gcc-14.1.0
i386                             allmodconfig   clang-18
i386                              allnoconfig   clang-18
i386                             allyesconfig   clang-18
i386         buildonly-randconfig-001-20240904   gcc-12
i386         buildonly-randconfig-002-20240904   gcc-12
i386         buildonly-randconfig-003-20240904   gcc-12
i386         buildonly-randconfig-004-20240904   gcc-12
i386         buildonly-randconfig-005-20240904   gcc-12
i386         buildonly-randconfig-006-20240904   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240904   gcc-12
i386                  randconfig-002-20240904   gcc-12
i386                  randconfig-004-20240904   gcc-12
i386                  randconfig-005-20240904   gcc-12
i386                  randconfig-006-20240904   gcc-12
i386                  randconfig-011-20240904   gcc-12
i386                  randconfig-012-20240904   gcc-12
i386                  randconfig-013-20240904   gcc-12
i386                  randconfig-014-20240904   gcc-12
i386                  randconfig-015-20240904   gcc-12
i386                  randconfig-016-20240904   gcc-12
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-14.1.0
m68k                          multi_defconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
mips                           gcw0_defconfig   gcc-14.1.0
mips                           ip28_defconfig   gcc-14.1.0
mips                           jazz_defconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-14.1.0
openrisc                          allnoconfig   clang-20
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-12
openrisc                 simple_smp_defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   clang-20
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-12
parisc64                            defconfig   gcc-14.1.0
powerpc                     akebono_defconfig   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   clang-20
powerpc                          allyesconfig   gcc-14.1.0
powerpc                      ep88xc_defconfig   gcc-14.1.0
powerpc                          g5_defconfig   gcc-14.1.0
powerpc                    ge_imp3a_defconfig   gcc-14.1.0
powerpc                 xes_mpc85xx_defconfig   gcc-14.1.0
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   clang-20
riscv                            allyesconfig   gcc-14.1.0
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
sh                          sdk7786_defconfig   gcc-14.1.0
sh                           se7724_defconfig   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc                       sparc32_defconfig   gcc-14.1.0
sparc64                             defconfig   gcc-12
um                               allmodconfig   clang-20
um                                allnoconfig   clang-20
um                               allyesconfig   clang-20
um                                  defconfig   gcc-12
um                             i386_defconfig   gcc-12
um                           x86_64_defconfig   gcc-12
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64                              defconfig   clang-18
x86_64                                  kexec   gcc-12
x86_64                          rhel-8.3-rust   clang-18
x86_64                               rhel-8.3   gcc-12
xtensa                            allnoconfig   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

