Return-Path: <linux-kernel+bounces-384206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BD89B2854
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:04:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55C5A28237E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3654318E749;
	Mon, 28 Oct 2024 07:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kgnwPEv+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D338318D625
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730099077; cv=none; b=Ois4J93JF3oBNKo8nxTEbSdVaGHY9tG8yVuDvyFDDdM9eeW7mCugRqZNoqualhj2wH9JWZOCMvj/PEfEHzghb/64PZoywGQAJEBn/phVtXS+D1U4clHPPoNLaEI83+ktW6i1IX39O+gtA/VOL6t46PzBRruJEwsW+Lw7/xzUZUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730099077; c=relaxed/simple;
	bh=LqWbyJmafcjDZRGB8+FlfOMVClgfUMehb9R+1A8DVNg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=NRuAb+yxldlg+QQ66gM/mG65iFMzNocIMoG6WGxTf8bF0n7QioqSd+IjgENVDlBjgwwO8zen3uFpTikZzx+toBGTjkXi0WvlsJKvdPgUP1awUtClelYm3/9HMvLzZvM4ljZ+Ud+jcLUgojvxcdPlC01D2HJ3vDXHZWD/yEVZXMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kgnwPEv+; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730099075; x=1761635075;
  h=date:from:to:cc:subject:message-id;
  bh=LqWbyJmafcjDZRGB8+FlfOMVClgfUMehb9R+1A8DVNg=;
  b=kgnwPEv+miAXjduA8NJHaZH/OfSEC5MrDKs97jsGN2MCHpBKp6fhWwm2
   0NjIKqcfvWBtZa0C/w/KMu8atpjU8F3KZdGSjWpThMEp+1ZHzWoLG+qU9
   n1jYxD/EMbDCUKyhu2mZZylQZWDqldGR6BAdk39a4rmepVXKN+10mMmiw
   UVBrsCGd1bVyy+y/IIqxjaUO8zeMjbENKNldFBmjb8EPacYGyVgMx4c/A
   59DhWzJoBxi6EXfk5ab0l8wlLTxBbz69C9Wk0lxkJi2hYfHcWH/BBqt13
   3fTAw4GWZOJUr8lL7ECGPFKAbyYnrqm/lAveVbJRifKXLxbRyFoUOy/yq
   Q==;
X-CSE-ConnectionGUID: 3Ts8ZfvYTP2pzi8gTFENUw==
X-CSE-MsgGUID: MC58rWVLQUqx3B0sVlhPJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11238"; a="40305853"
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="40305853"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 00:04:34 -0700
X-CSE-ConnectionGUID: E4h5DxeyT4amVZZNG89jUA==
X-CSE-MsgGUID: 6PkxsYfUTRK9Dhl4zFU/XQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="112364803"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 28 Oct 2024 00:04:33 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t5Jnj-000c00-0F;
	Mon, 28 Oct 2024 07:04:31 +0000
Date: Mon, 28 Oct 2024 15:04:16 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2024.10.23a] BUILD SUCCESS
 f00c45080b27e6a836d346cc94492f8cd27b4d0f
Message-ID: <202410281509.kTfDhwy2-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2024.10.23a
branch HEAD: f00c45080b27e6a836d346cc94492f8cd27b4d0f  fixup! rcu: Make expedited grace periods wait for initialization

elapsed time: 1064m

configs tested: 203
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-13.3.0
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                                 defconfig    gcc-14.1.0
arc                   randconfig-001-20241028    gcc-13.2.0
arc                   randconfig-001-20241028    gcc-14.1.0
arc                   randconfig-002-20241028    gcc-13.2.0
arc                   randconfig-002-20241028    gcc-14.1.0
arc                           tb10x_defconfig    clang-20
arm                              allmodconfig    clang-20
arm                               allnoconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                                 defconfig    gcc-14.1.0
arm                          ep93xx_defconfig    clang-20
arm                         nhk8815_defconfig    clang-20
arm                   randconfig-001-20241028    gcc-14.1.0
arm                   randconfig-002-20241028    clang-20
arm                   randconfig-002-20241028    gcc-14.1.0
arm                   randconfig-003-20241028    clang-20
arm                   randconfig-003-20241028    gcc-14.1.0
arm                   randconfig-004-20241028    clang-20
arm                   randconfig-004-20241028    gcc-14.1.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
arm64                 randconfig-001-20241028    gcc-14.1.0
arm64                 randconfig-002-20241028    gcc-14.1.0
arm64                 randconfig-003-20241028    clang-20
arm64                 randconfig-003-20241028    gcc-14.1.0
arm64                 randconfig-004-20241028    clang-20
arm64                 randconfig-004-20241028    gcc-14.1.0
csky                             alldefconfig    clang-20
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
csky                  randconfig-001-20241028    gcc-14.1.0
csky                  randconfig-002-20241028    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
hexagon               randconfig-001-20241028    clang-20
hexagon               randconfig-001-20241028    gcc-14.1.0
hexagon               randconfig-002-20241028    clang-20
hexagon               randconfig-002-20241028    gcc-14.1.0
i386                             allmodconfig    clang-19
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-19
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-19
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241028    clang-19
i386        buildonly-randconfig-001-20241028    gcc-12
i386        buildonly-randconfig-002-20241028    clang-19
i386        buildonly-randconfig-003-20241028    clang-19
i386        buildonly-randconfig-004-20241028    clang-19
i386        buildonly-randconfig-005-20241028    clang-19
i386        buildonly-randconfig-006-20241028    clang-19
i386                                defconfig    clang-19
i386                  randconfig-001-20241028    clang-19
i386                  randconfig-002-20241028    clang-19
i386                  randconfig-002-20241028    gcc-12
i386                  randconfig-003-20241028    clang-19
i386                  randconfig-003-20241028    gcc-12
i386                  randconfig-004-20241028    clang-19
i386                  randconfig-005-20241028    clang-19
i386                  randconfig-006-20241028    clang-19
i386                  randconfig-011-20241028    clang-19
i386                  randconfig-011-20241028    gcc-11
i386                  randconfig-012-20241028    clang-19
i386                  randconfig-013-20241028    clang-19
i386                  randconfig-014-20241028    clang-19
i386                  randconfig-015-20241028    clang-19
i386                  randconfig-015-20241028    gcc-12
i386                  randconfig-016-20241028    clang-19
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
loongarch             randconfig-001-20241028    gcc-14.1.0
loongarch             randconfig-002-20241028    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
m68k                        m5307c3_defconfig    clang-20
m68k                        m5407c3_defconfig    clang-20
m68k                            q40_defconfig    clang-20
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                          ath79_defconfig    clang-20
mips                        bcm63xx_defconfig    clang-20
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
nios2                 randconfig-001-20241028    gcc-14.1.0
nios2                 randconfig-002-20241028    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc                generic-32bit_defconfig    clang-20
parisc                randconfig-001-20241028    gcc-14.1.0
parisc                randconfig-002-20241028    gcc-14.1.0
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.1.0
powerpc               randconfig-001-20241028    gcc-14.1.0
powerpc               randconfig-002-20241028    clang-15
powerpc               randconfig-002-20241028    gcc-14.1.0
powerpc               randconfig-003-20241028    clang-20
powerpc               randconfig-003-20241028    gcc-14.1.0
powerpc64             randconfig-001-20241028    clang-20
powerpc64             randconfig-001-20241028    gcc-14.1.0
powerpc64             randconfig-002-20241028    gcc-14.1.0
powerpc64             randconfig-003-20241028    gcc-14.1.0
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    clang-20
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20241028    gcc-14.1.0
riscv                 randconfig-002-20241028    gcc-14.1.0
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20241028    gcc-14.1.0
s390                  randconfig-002-20241028    gcc-14.1.0
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                               j2_defconfig    clang-20
sh                            migor_defconfig    clang-20
sh                    randconfig-001-20241028    gcc-14.1.0
sh                    randconfig-002-20241028    gcc-14.1.0
sh                          rsk7264_defconfig    clang-20
sh                          sdk7780_defconfig    clang-20
sh                           se7343_defconfig    clang-20
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20241028    gcc-14.1.0
sparc64               randconfig-002-20241028    gcc-14.1.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241028    clang-20
um                    randconfig-001-20241028    gcc-14.1.0
um                    randconfig-002-20241028    clang-20
um                    randconfig-002-20241028    gcc-14.1.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241028    gcc-12
x86_64      buildonly-randconfig-002-20241028    gcc-12
x86_64      buildonly-randconfig-003-20241028    gcc-12
x86_64      buildonly-randconfig-004-20241028    gcc-12
x86_64      buildonly-randconfig-005-20241028    gcc-12
x86_64      buildonly-randconfig-006-20241028    gcc-12
x86_64                              defconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20241028    gcc-12
x86_64                randconfig-002-20241028    gcc-12
x86_64                randconfig-003-20241028    gcc-12
x86_64                randconfig-004-20241028    gcc-12
x86_64                randconfig-005-20241028    gcc-12
x86_64                randconfig-006-20241028    gcc-12
x86_64                randconfig-011-20241028    gcc-12
x86_64                randconfig-012-20241028    gcc-12
x86_64                randconfig-013-20241028    gcc-12
x86_64                randconfig-014-20241028    gcc-12
x86_64                randconfig-015-20241028    gcc-12
x86_64                randconfig-016-20241028    gcc-12
x86_64                randconfig-071-20241028    gcc-12
x86_64                randconfig-072-20241028    gcc-12
x86_64                randconfig-073-20241028    gcc-12
x86_64                randconfig-074-20241028    gcc-12
x86_64                randconfig-075-20241028    gcc-12
x86_64                randconfig-076-20241028    gcc-12
x86_64                               rhel-8.3    gcc-12
x86_64                           rhel-8.3-bpf    clang-19
x86_64                         rhel-8.3-kunit    clang-19
x86_64                           rhel-8.3-ltp    clang-19
x86_64                          rhel-8.3-rust    clang-19
xtensa                            allnoconfig    gcc-14.1.0
xtensa                generic_kc705_defconfig    clang-20
xtensa                randconfig-001-20241028    gcc-14.1.0
xtensa                randconfig-002-20241028    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

