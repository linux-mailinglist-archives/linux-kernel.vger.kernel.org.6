Return-Path: <linux-kernel+bounces-317117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1CE96D96D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E03E28223C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 12:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4168D19C57B;
	Thu,  5 Sep 2024 12:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="US1UX+cO"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918D819AD48
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 12:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725540840; cv=none; b=tMwXt4VEt7Qi6d6EFtHPn/fg1m3cHP355Uu7s7zxgYL8l/PLMA2eQ9aRDCoimKiZpBJHvqK1/gRcBqoqF9e33qadyEpNzs7x7gKnO6fuv6vPDeYAOBmbL1albwaCjWLoj1hyu3OSlrmQMNYcH9Fy3Z92Us0hEJozUECjGfxi/jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725540840; c=relaxed/simple;
	bh=xcNGimpP0DoVf7wYB3B1frx5+5jwqczGOXstNVlbPAk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=uyahEtPRkcdKgxXhtXJGYrElxVy8OFQiN5l/1mrCS0tSiivDefH+0dOrYn4f0BKMurgq1n7Cfj12hqu2K8Lo55OFe0S4E9twH3DkqceCS2AJhxLQQ9oKuV0qJQYVnffVRQ9f6eFE16jsET1nIoPvkGmnlqVXpJnZ8gTo3CU+gLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=US1UX+cO; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725540839; x=1757076839;
  h=date:from:to:cc:subject:message-id;
  bh=xcNGimpP0DoVf7wYB3B1frx5+5jwqczGOXstNVlbPAk=;
  b=US1UX+cO5lOSl1wNG/mgCFXbcc8vDWQWUmVkdqilTNYdLswYAOBjf6mh
   qUhKuvWckAJ0urHEq82SkvSGbe9BmPXqUAGJZWUvYW2lx0cxIY7bu/6JJ
   EF3jRzBSkdXLBqcdMgPxR1FrgoCafol8GEKtbFM2/g7ebXzyCC0f2ickd
   9LZd21Hoh4Wb3MBAoSszO7lV+E0r3iJcpljqpZauc0HasEIon1/ZKVtiV
   xwhpKBDlvMJc6hW66pM/YLTsGDna/xE4SUbeUPcuUXXkzatrBstIFbZBw
   19cqi+l6nPP7v1oIWrgGPPDq7n3ryH4n5FsxasirXdFthTRQ3MgCHIRcU
   A==;
X-CSE-ConnectionGUID: HkmVtR0SQQ+Smj9p8vFU7A==
X-CSE-MsgGUID: KVk17MmLSIW/kPghNK1OJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="23760232"
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="23760232"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 05:53:58 -0700
X-CSE-ConnectionGUID: 3WwQ+H1TTSqUNivUjvVvzQ==
X-CSE-MsgGUID: lBVI6oyZRluYFqP/xu9W/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="65596219"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 05 Sep 2024 05:53:57 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1smBzm-0009tE-1r;
	Thu, 05 Sep 2024 12:53:54 +0000
Date: Thu, 05 Sep 2024 20:53:33 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:irq/core] BUILD SUCCESS
 59fc20ba70294d2c5f620ad6206aa661ce7718d6
Message-ID: <202409052030.ujZ5Z7zk-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
branch HEAD: 59fc20ba70294d2c5f620ad6206aa661ce7718d6  irqchip/apple-aic: Only access system registers on SoCs which provide them

elapsed time: 1032m

configs tested: 148
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-14.1.0
alpha                            allyesconfig   clang-20
alpha                               defconfig   gcc-14.1.0
arc                              allmodconfig   clang-20
arc                               allnoconfig   gcc-14.1.0
arc                              allyesconfig   clang-20
arc                      axs103_smp_defconfig   gcc-14.1.0
arc                                 defconfig   gcc-14.1.0
arc                     haps_hs_smp_defconfig   gcc-14.1.0
arc                        nsimosci_defconfig   gcc-14.1.0
arc                   randconfig-001-20240905   gcc-12
arc                   randconfig-002-20240905   gcc-12
arm                              allmodconfig   clang-20
arm                               allnoconfig   gcc-14.1.0
arm                              allyesconfig   clang-20
arm                                 defconfig   gcc-14.1.0
arm                          ixp4xx_defconfig   gcc-14.1.0
arm                             mxs_defconfig   gcc-14.1.0
arm                   randconfig-001-20240905   gcc-12
arm                   randconfig-002-20240905   gcc-12
arm                   randconfig-003-20240905   gcc-12
arm                   randconfig-004-20240905   gcc-12
arm                           sama5_defconfig   gcc-14.1.0
arm                    vt8500_v6_v7_defconfig   gcc-14.1.0
arm64                            allmodconfig   clang-20
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-14.1.0
arm64                 randconfig-001-20240905   gcc-12
arm64                 randconfig-002-20240905   gcc-12
arm64                 randconfig-003-20240905   gcc-12
arm64                 randconfig-004-20240905   gcc-12
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-14.1.0
csky                  randconfig-001-20240905   gcc-12
csky                  randconfig-002-20240905   gcc-12
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   gcc-14.1.0
hexagon                          allyesconfig   clang-20
hexagon                             defconfig   gcc-14.1.0
hexagon               randconfig-001-20240905   gcc-12
hexagon               randconfig-002-20240905   gcc-12
i386                             allmodconfig   clang-18
i386                              allnoconfig   clang-18
i386                             allyesconfig   clang-18
i386         buildonly-randconfig-001-20240905   gcc-12
i386         buildonly-randconfig-002-20240905   gcc-12
i386         buildonly-randconfig-003-20240905   gcc-12
i386         buildonly-randconfig-004-20240905   gcc-12
i386         buildonly-randconfig-005-20240905   gcc-12
i386         buildonly-randconfig-006-20240905   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240905   gcc-12
i386                  randconfig-002-20240905   gcc-12
i386                  randconfig-003-20240905   gcc-12
i386                  randconfig-004-20240905   gcc-12
i386                  randconfig-005-20240905   gcc-12
i386                  randconfig-006-20240905   gcc-12
i386                  randconfig-011-20240905   gcc-12
i386                  randconfig-012-20240905   gcc-12
i386                  randconfig-013-20240905   gcc-12
i386                  randconfig-014-20240905   gcc-12
i386                  randconfig-015-20240905   gcc-12
i386                  randconfig-016-20240905   gcc-12
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-14.1.0
loongarch             randconfig-001-20240905   gcc-12
loongarch             randconfig-002-20240905   gcc-12
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-14.1.0
m68k                            mac_defconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-14.1.0
microblaze                      mmu_defconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
mips                  decstation_64_defconfig   gcc-14.1.0
mips                           ip32_defconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-14.1.0
nios2                 randconfig-001-20240905   gcc-12
nios2                 randconfig-002-20240905   gcc-12
openrisc                          allnoconfig   clang-20
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-12
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   clang-20
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-12
parisc                generic-64bit_defconfig   gcc-14.1.0
parisc                randconfig-001-20240905   gcc-12
parisc                randconfig-002-20240905   gcc-12
parisc64                            defconfig   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   clang-20
powerpc                          allyesconfig   gcc-14.1.0
powerpc                      chrp32_defconfig   gcc-14.1.0
powerpc                 linkstation_defconfig   gcc-14.1.0
powerpc                 mpc8313_rdb_defconfig   gcc-14.1.0
powerpc               randconfig-001-20240905   gcc-12
powerpc               randconfig-002-20240905   gcc-12
powerpc               randconfig-003-20240905   gcc-12
powerpc64             randconfig-001-20240905   gcc-12
powerpc64             randconfig-002-20240905   gcc-12
powerpc64             randconfig-003-20240905   gcc-12
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   clang-20
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-12
riscv                 randconfig-001-20240905   gcc-12
riscv                 randconfig-002-20240905   gcc-12
s390                             allmodconfig   gcc-14.1.0
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-12
s390                  randconfig-001-20240905   gcc-12
s390                  randconfig-002-20240905   gcc-12
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-12
sh                          lboxre2_defconfig   gcc-14.1.0
sh                    randconfig-001-20240905   gcc-12
sh                    randconfig-002-20240905   gcc-12
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-12
sparc64               randconfig-001-20240905   gcc-12
sparc64               randconfig-002-20240905   gcc-12
um                               allmodconfig   clang-20
um                                allnoconfig   clang-20
um                               allyesconfig   clang-20
um                                  defconfig   gcc-12
um                             i386_defconfig   gcc-12
um                    randconfig-001-20240905   gcc-12
um                    randconfig-002-20240905   gcc-12
um                           x86_64_defconfig   gcc-12
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64                              defconfig   clang-18
x86_64                                  kexec   gcc-12
x86_64                          rhel-8.3-rust   clang-18
x86_64                               rhel-8.3   gcc-12
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240905   gcc-12
xtensa                randconfig-002-20240905   gcc-12

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

