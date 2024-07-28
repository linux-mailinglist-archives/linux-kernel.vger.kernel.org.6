Return-Path: <linux-kernel+bounces-264482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4586E93E3F8
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 09:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8372281DB6
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 07:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC6FBA39;
	Sun, 28 Jul 2024 07:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eqNia8+M"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97876C2E9
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 07:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722152400; cv=none; b=Gh+zEOJGOglUHtQSBT65a8fLSb3kJbZ4Kb57IyB0Df1/lgqj/x4ym70GoordbYNgMT54oTGGb8n1BIUR2TX/pVnS1KrVYYDG/HBul6VNHv6oqnAkK1JsCDHpZjVrexnVZYMc3XAO1nN5bhh9a3ElSASZ17RuJUyN8WggZh2L3AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722152400; c=relaxed/simple;
	bh=0ArqdZgP5penroh2IbnnCqv8ddHSSI84iVj2kyJcmA8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ffKqVv33P8rXEAQd1nf2op6mxlkL4lZifQwTju9lBwbPnzjE1JLQ/x3yR0aHIzHfFRJRhGPQDxncLkcTqZKZFx1Z+fk62BodjpFXIPd5IKdvIDhSTwo0VjnvEYiMQhNvfKCOqTzbxZh/VSvpNO0psgG0IWDg9m+qAMiIFS0rcCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eqNia8+M; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722152398; x=1753688398;
  h=date:from:to:cc:subject:message-id;
  bh=0ArqdZgP5penroh2IbnnCqv8ddHSSI84iVj2kyJcmA8=;
  b=eqNia8+MHpWUvBNu7+LNCRSyZM53OD0E8rFRUJzr3ZZCiaQ4k5gZ4QKC
   KzjMg2DgufpsnbPdaGwKiwIyVr0DkKFyw0bRMWzOAVZGaKHDcUsEPp0i7
   lP3AnSMq2rGXf4OUfgS1GOs143ekFw7nCHM0qvfGCrFw7FNe8eeHcny+b
   M1uJiBm5OJdathDs8qp33Hz4dFiCSoC6pb+ZdkvMya1HOH6JKnPw3G5bg
   HIM8H/Yxf+i9hlG9jZQfp9tgqjFa5NqrfnYEUdYtGu7/SH7NeTFekfogk
   m//wfZbHRm8F6v05nTA0gfQ94ae6sXTV9EkzgQq2ZkBzMXH2k90lVX1Z6
   g==;
X-CSE-ConnectionGUID: hVwojBTsSNKnpEVhUapxhw==
X-CSE-MsgGUID: 1TRrhHMNR1i+ZoU2+4sLKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11146"; a="30556846"
X-IronPort-AV: E=Sophos;i="6.09,243,1716274800"; 
   d="scan'208";a="30556846"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2024 00:39:57 -0700
X-CSE-ConnectionGUID: nUmvh8S2Q/CePLwT5JXiqQ==
X-CSE-MsgGUID: mQGvkuJ+RhOPZkwdver/hA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,243,1716274800"; 
   d="scan'208";a="53323609"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 28 Jul 2024 00:39:55 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sXyVV-000qcd-1o;
	Sun, 28 Jul 2024 07:39:53 +0000
Date: Sun, 28 Jul 2024 15:39:18 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/wfamnae-next20240726-cbc] BUILD
 REGRESSION bd10b39e2b713a2f9fe8715278e9d4bee9253e24
Message-ID: <202407281514.vcOv0mry-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/wfamnae-next20240726-cbc
branch HEAD: bd10b39e2b713a2f9fe8715278e9d4bee9253e24  ethtool: Avoid -Wflex-array-member-not-at-end warning

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202407281233.Rlzs3LRF-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

usr/include/linux/ethtool.h:1645:15: error: expected parameter declarator

Error/Warning ids grouped by kconfigs:

recent_errors
`-- x86_64-allyesconfig
    `-- usr-include-linux-ethtool.h:error:expected-parameter-declarator

elapsed time: 928m

configs tested: 166
configs skipped: 8

tested configs:
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.3.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240728   gcc-13.2.0
arc                   randconfig-002-20240728   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-20
arm                              allyesconfig   gcc-14.1.0
arm                         assabet_defconfig   clang-15
arm                                 defconfig   clang-14
arm                          gemini_defconfig   clang-20
arm                      integrator_defconfig   clang-20
arm                        neponset_defconfig   gcc-14.1.0
arm                   randconfig-001-20240728   clang-20
arm                   randconfig-002-20240728   clang-20
arm                   randconfig-003-20240728   gcc-14.1.0
arm                   randconfig-004-20240728   gcc-14.1.0
arm                        shmobile_defconfig   gcc-14.1.0
arm                           u8500_defconfig   gcc-14.1.0
arm64                            allmodconfig   clang-20
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-14.1.0
arm64                 randconfig-001-20240728   gcc-14.1.0
arm64                 randconfig-002-20240728   clang-20
arm64                 randconfig-003-20240728   gcc-14.1.0
arm64                 randconfig-004-20240728   gcc-14.1.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-14.1.0
csky                  randconfig-001-20240728   gcc-14.1.0
csky                  randconfig-002-20240728   gcc-14.1.0
hexagon                           allnoconfig   clang-20
hexagon                             defconfig   clang-20
hexagon               randconfig-001-20240728   clang-15
hexagon               randconfig-002-20240728   clang-17
i386                             allmodconfig   gcc-13
i386                              allnoconfig   gcc-13
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240728   clang-18
i386         buildonly-randconfig-002-20240728   gcc-13
i386         buildonly-randconfig-003-20240728   gcc-11
i386         buildonly-randconfig-004-20240728   gcc-13
i386         buildonly-randconfig-005-20240728   gcc-11
i386         buildonly-randconfig-006-20240728   gcc-9
i386                                defconfig   clang-18
i386                  randconfig-001-20240728   gcc-13
i386                  randconfig-002-20240728   gcc-13
i386                  randconfig-003-20240728   gcc-7
i386                  randconfig-004-20240728   gcc-13
i386                  randconfig-005-20240728   clang-18
i386                  randconfig-006-20240728   gcc-13
i386                  randconfig-011-20240728   gcc-13
i386                  randconfig-012-20240728   gcc-12
i386                  randconfig-013-20240728   clang-18
i386                  randconfig-014-20240728   gcc-13
i386                  randconfig-015-20240728   gcc-13
i386                  randconfig-016-20240728   clang-18
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-14.1.0
loongarch             randconfig-001-20240728   gcc-14.1.0
loongarch             randconfig-002-20240728   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                         apollo_defconfig   gcc-14.1.0
m68k                                defconfig   gcc-14.1.0
m68k                        m5307c3_defconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
mips                            gpr_defconfig   clang-20
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-14.1.0
nios2                 randconfig-001-20240728   gcc-14.1.0
nios2                 randconfig-002-20240728   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240728   gcc-14.1.0
parisc                randconfig-002-20240728   gcc-14.1.0
parisc64                            defconfig   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-20
powerpc                     asp8347_defconfig   clang-17
powerpc                 linkstation_defconfig   clang-20
powerpc                  mpc885_ads_defconfig   clang-20
powerpc                      pmac32_defconfig   clang-20
powerpc                         wii_defconfig   gcc-14.1.0
powerpc64             randconfig-001-20240728   clang-20
powerpc64             randconfig-002-20240728   gcc-14.1.0
powerpc64             randconfig-003-20240728   clang-17
riscv                            allmodconfig   clang-20
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-20
riscv                               defconfig   clang-20
riscv                 randconfig-001-20240728   clang-20
riscv                 randconfig-002-20240728   clang-15
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   clang-20
s390                  randconfig-001-20240728   clang-16
s390                  randconfig-002-20240728   gcc-14.1.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                 kfr2r09-romimage_defconfig   gcc-14.1.0
sh                          landisk_defconfig   gcc-14.1.0
sh                    randconfig-001-20240728   gcc-14.1.0
sh                    randconfig-002-20240728   gcc-14.1.0
sh                          sdk7786_defconfig   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240728   gcc-14.1.0
sparc64               randconfig-002-20240728   gcc-14.1.0
um                               allmodconfig   clang-20
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-13
um                                  defconfig   clang-20
um                             i386_defconfig   gcc-13
um                    randconfig-001-20240728   gcc-11
um                    randconfig-002-20240728   gcc-13
um                           x86_64_defconfig   clang-15
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240728   gcc-13
x86_64       buildonly-randconfig-002-20240728   clang-18
x86_64       buildonly-randconfig-003-20240728   clang-18
x86_64       buildonly-randconfig-004-20240728   gcc-13
x86_64       buildonly-randconfig-005-20240728   clang-18
x86_64       buildonly-randconfig-006-20240728   clang-18
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240728   clang-18
x86_64                randconfig-002-20240728   gcc-13
x86_64                randconfig-003-20240728   gcc-13
x86_64                randconfig-004-20240728   gcc-8
x86_64                randconfig-005-20240728   gcc-12
x86_64                randconfig-006-20240728   gcc-13
x86_64                randconfig-011-20240728   clang-18
x86_64                randconfig-012-20240728   clang-18
x86_64                randconfig-013-20240728   gcc-13
x86_64                randconfig-014-20240728   clang-18
x86_64                randconfig-015-20240728   gcc-11
x86_64                randconfig-016-20240728   clang-18
x86_64                randconfig-071-20240728   clang-18
x86_64                randconfig-072-20240728   gcc-13
x86_64                randconfig-073-20240728   clang-18
x86_64                randconfig-074-20240728   clang-18
x86_64                randconfig-075-20240728   clang-18
x86_64                randconfig-076-20240728   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240728   gcc-14.1.0
xtensa                randconfig-002-20240728   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

