Return-Path: <linux-kernel+bounces-275344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 437849483B1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 22:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE182284937
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 20:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A53B14A092;
	Mon,  5 Aug 2024 20:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eMSc//PT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998828469
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 20:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722890743; cv=none; b=eR1tXXf6KSmiBWZWlOEtc7bQdN18HK2g7Gv9tq7VaIl19vhQHFeHP0sS3lJmiCMiKVDCn/50vEnksdDFZ8ibIbsnrv545FKHMR3jL5BKThej5dV4/tBsfhuNaLkaDM4QxjesU3wUv143etpjGqy82AYe0XlIoMy2yIvHShv2LW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722890743; c=relaxed/simple;
	bh=dBLKVJeJgRi9g6TWBGIfssaou/TRTj3it0asplBSPc0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=DXzhrPh3IzvS1H6gtWBejCjs7IRj2FmBg9B69Y3s5j5NpeiqxRA+Hn5qxiD1UAHJzviMwbeXttfTzbYfnzw7VDKeEExbJrFf4nT2areDn49WzyXhCyJnLXmtkJc0NA/i1ZOg+zFJTZX4aymRfntHZK8U+n9xkQPNxJSJiugfdXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eMSc//PT; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722890742; x=1754426742;
  h=date:from:to:cc:subject:message-id;
  bh=dBLKVJeJgRi9g6TWBGIfssaou/TRTj3it0asplBSPc0=;
  b=eMSc//PT6PQ91dnXfXeOKnlPQdVFTzgqRdg1oJy1hFx60H8LA0hSMQcu
   2Z39gwkwS+tRA4Jrh5htr0iKFXD9QnLqR++mCBY4c3d0oV4O1oteLx+/8
   b7JZWmDsLKKBufpyyGIhl08nyoXYipnAD6FURmkv0AD57ZX4+cc+8Hb7X
   0+w1vX6TsSYl0ixcVAMGmeMc16YtH4zveDC65H44jnjsexdj/f7h+ZIRA
   4ITtxXgje9SQLANEVQsUfGou66YP8pQmjBocj8KeVO5mcfFKgeVB2Fgrg
   2Sd4YrpRlcpIzLHvXFVxH+vwrJiNP8aJUdN8+vr7jHc+tqmf7qOWt9GXK
   g==;
X-CSE-ConnectionGUID: GdJLEFEXRwqJQio/8Jt4lw==
X-CSE-MsgGUID: sO+g8I0FTzSOXNqFUtzNTQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="20758240"
X-IronPort-AV: E=Sophos;i="6.09,265,1716274800"; 
   d="scan'208";a="20758240"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 13:45:39 -0700
X-CSE-ConnectionGUID: f0nTNMlvQeauyhhHi9hn5g==
X-CSE-MsgGUID: nBZg2q+pScO9NV8Uwu5rCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,265,1716274800"; 
   d="scan'208";a="79537866"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 05 Aug 2024 13:45:38 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sb4aG-0003hL-1J;
	Mon, 05 Aug 2024 20:45:36 +0000
Date: Tue, 06 Aug 2024 04:44:39 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:master] BUILD SUCCESS
 7615396c7edc02ce2e155c6b089932cd30821b5a
Message-ID: <202408060437.t7PXX1kY-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://github.com/paulmckrcu/linux master
branch HEAD: 7615396c7edc02ce2e155c6b089932cd30821b5a  Merge branches 'neeraj.2024.07.31a' and 'non-rcu.2024.08.02a' into HEAD

elapsed time: 789m

configs tested: 172
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                          axs101_defconfig   gcc-13.2.0
arc                          axs103_defconfig   gcc-13.2.0
arc                   randconfig-001-20240805   gcc-13.2.0
arc                   randconfig-002-20240805   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-20
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-14.1.0
arm                         axm55xx_defconfig   gcc-13.2.0
arm                      jornada720_defconfig   gcc-13.2.0
arm                        keystone_defconfig   gcc-13.2.0
arm                         nhk8815_defconfig   gcc-13.2.0
arm                   randconfig-001-20240805   gcc-14.1.0
arm                   randconfig-002-20240805   clang-20
arm                   randconfig-003-20240805   clang-20
arm                   randconfig-004-20240805   clang-20
arm64                            allmodconfig   clang-20
arm64                             allnoconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-14.1.0
arm64                 randconfig-001-20240805   clang-20
arm64                 randconfig-002-20240805   clang-20
arm64                 randconfig-003-20240805   clang-17
arm64                 randconfig-004-20240805   gcc-14.1.0
csky                              allnoconfig   gcc-13.2.0
csky                              allnoconfig   gcc-14.1.0
csky                  randconfig-001-20240805   gcc-14.1.0
csky                  randconfig-002-20240805   gcc-14.1.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   clang-20
hexagon                          allyesconfig   clang-20
hexagon               randconfig-001-20240805   clang-16
hexagon               randconfig-002-20240805   clang-20
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-12
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-12
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240805   clang-18
i386         buildonly-randconfig-002-20240805   clang-18
i386         buildonly-randconfig-003-20240805   clang-18
i386         buildonly-randconfig-004-20240805   clang-18
i386         buildonly-randconfig-005-20240805   clang-18
i386         buildonly-randconfig-006-20240805   clang-18
i386         buildonly-randconfig-006-20240805   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240805   clang-18
i386                  randconfig-002-20240805   clang-18
i386                  randconfig-003-20240805   clang-18
i386                  randconfig-004-20240805   clang-18
i386                  randconfig-005-20240805   clang-18
i386                  randconfig-005-20240805   gcc-12
i386                  randconfig-006-20240805   clang-18
i386                  randconfig-011-20240805   clang-18
i386                  randconfig-012-20240805   clang-18
i386                  randconfig-012-20240805   gcc-11
i386                  randconfig-013-20240805   clang-18
i386                  randconfig-013-20240805   gcc-12
i386                  randconfig-014-20240805   clang-18
i386                  randconfig-014-20240805   gcc-12
i386                  randconfig-015-20240805   clang-18
i386                  randconfig-015-20240805   gcc-12
i386                  randconfig-016-20240805   clang-18
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch             randconfig-001-20240805   gcc-14.1.0
loongarch             randconfig-002-20240805   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                        mvme147_defconfig   gcc-13.2.0
m68k                           virt_defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
mips                              allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-14.1.0
mips                     cu1000-neo_defconfig   gcc-13.2.0
mips                      maltasmvp_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-14.1.0
nios2                 randconfig-001-20240805   gcc-14.1.0
nios2                 randconfig-002-20240805   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240805   gcc-14.1.0
parisc                randconfig-002-20240805   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-20
powerpc                      cm5200_defconfig   gcc-13.2.0
powerpc                   currituck_defconfig   gcc-13.2.0
powerpc               randconfig-001-20240805   gcc-14.1.0
powerpc                    socrates_defconfig   gcc-13.2.0
powerpc64             randconfig-001-20240805   gcc-14.1.0
powerpc64             randconfig-002-20240805   clang-15
riscv                            alldefconfig   gcc-13.2.0
riscv                            allmodconfig   clang-20
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-20
riscv                               defconfig   clang-20
riscv                               defconfig   gcc-14.1.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   clang-20
s390                                defconfig   gcc-14.1.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                            shmin_defconfig   gcc-13.2.0
sh                            titan_defconfig   gcc-13.2.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
um                               allmodconfig   clang-20
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-12
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   clang-20
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-12
um                             i386_defconfig   gcc-14.1.0
um                           x86_64_defconfig   clang-15
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240805   gcc-12
x86_64       buildonly-randconfig-002-20240805   clang-18
x86_64       buildonly-randconfig-003-20240805   clang-18
x86_64       buildonly-randconfig-004-20240805   clang-18
x86_64       buildonly-randconfig-005-20240805   gcc-11
x86_64       buildonly-randconfig-006-20240805   clang-18
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-11
x86_64                randconfig-001-20240805   gcc-12
x86_64                randconfig-002-20240805   gcc-12
x86_64                randconfig-003-20240805   clang-18
x86_64                randconfig-004-20240805   gcc-12
x86_64                randconfig-005-20240805   clang-18
x86_64                randconfig-006-20240805   gcc-12
x86_64                randconfig-011-20240805   clang-18
x86_64                randconfig-012-20240805   clang-18
x86_64                randconfig-013-20240805   gcc-12
x86_64                randconfig-014-20240805   gcc-12
x86_64                randconfig-015-20240805   clang-18
x86_64                randconfig-016-20240805   clang-18
x86_64                randconfig-071-20240805   clang-18
x86_64                randconfig-072-20240805   gcc-12
x86_64                randconfig-073-20240805   clang-18
x86_64                randconfig-074-20240805   clang-18
x86_64                randconfig-075-20240805   clang-18
x86_64                randconfig-076-20240805   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                            allnoconfig   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

