Return-Path: <linux-kernel+bounces-289905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B65954D2C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 16:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 672031C232E4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 14:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8B91C0DE6;
	Fri, 16 Aug 2024 14:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hd4QD3WM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938D71C0DCC
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 14:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723819806; cv=none; b=arPcwRDeMd+FJNAfcKzmV4L15qH6R2Z4+Hi5a3J6QUsi4r3sRRsiDn4EjpguZZGZiVm8KQ1ToSsHXZZ0CmexE//UPE8VR07zcIIUCdt14p1YUSYra7JFFex9HB7Msl5fcB/FT4jMmitEenDbKrV7btuiijerifP/Yz+bBJ/pOPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723819806; c=relaxed/simple;
	bh=3gD5ToTItYGXHm2guLP/pG1xUMWuTFfof0u1x2SG9Gk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Vmp1AZjEEDnpub0lzvwGfEwk3baF46P1hMoWYmd7WHkBXobrw4fAnXLKtvYTo53WiafR+TuxZ3PSPN1qJ6MYWTlpRiHaoA6fX0rh5ilT2VfBstqh+gpDF484byWz4qxIjUW6QVVvrfg3jZavEoV6iyhkUe5afDlIKpkgXzlS7/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hd4QD3WM; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723819805; x=1755355805;
  h=date:from:to:cc:subject:message-id;
  bh=3gD5ToTItYGXHm2guLP/pG1xUMWuTFfof0u1x2SG9Gk=;
  b=Hd4QD3WMQk1T9+1HWm7rOKMZ/XY9lUE6oZbbVs/biQc43Jsj2eZwBAbU
   +8ZuFkqKEgz8ZJHwYre20EiLYThJkf/AjsfHbxQcJw6LxzTkEAK81Jj2H
   3zKIzS5tG8U9IrzhiMxfEb0TF50i6YqZdOKwSi9qnoDjyDuJT0ra+gI3E
   muNpck6UVKyC09A/vzQ/vhvo5ILUqbDKvSxdpjIFDkXeSGtnDb2vdyRWg
   QnphQ2IGLYMrSUborekIXehPiFpp3WunFBedCBsBE9CS23w+VCz5MHaE+
   wRJ7rfiX2w0qTLVA5Ij0asJCr/biH6RaoV66K98rbiO6Nq4WooHyCLmM0
   g==;
X-CSE-ConnectionGUID: d1TgrYd7Qsi+XtyTyc10Mg==
X-CSE-MsgGUID: 8bxpc/aBSruxYjI/83exOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="22277691"
X-IronPort-AV: E=Sophos;i="6.10,152,1719903600"; 
   d="scan'208";a="22277691"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 07:50:00 -0700
X-CSE-ConnectionGUID: fGXVpAImQ8WDR2rXaH8i/w==
X-CSE-MsgGUID: ip0ICyorSGqJ2y45pwr92w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,152,1719903600"; 
   d="scan'208";a="59659340"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 16 Aug 2024 07:49:59 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1seyH6-0006Wi-1s;
	Fri, 16 Aug 2024 14:49:56 +0000
Date: Fri, 16 Aug 2024 22:49:47 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:locking/urgent] BUILD SUCCESS
 d33d26036a0274b472299d7dcdaa5fb34329f91b
Message-ID: <202408162245.7KnJL9JJ-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/urgent
branch HEAD: d33d26036a0274b472299d7dcdaa5fb34329f91b  rtmutex: Drop rt_mutex::wait_lock before scheduling

elapsed time: 1371m

configs tested: 151
configs skipped: 18

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.3.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240816   gcc-13.2.0
arc                   randconfig-002-20240816   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-20
arm                              allyesconfig   gcc-14.1.0
arm                         bcm2835_defconfig   clang-20
arm                                 defconfig   clang-14
arm                        realview_defconfig   clang-20
arm                          sp7021_defconfig   gcc-14.1.0
arm64                            allmodconfig   clang-20
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-14.1.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-14.1.0
csky                  randconfig-001-20240816   gcc-14.1.0
csky                  randconfig-002-20240816   gcc-14.1.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   clang-20
hexagon                          allyesconfig   clang-20
hexagon                             defconfig   clang-20
hexagon               randconfig-001-20240816   clang-20
hexagon               randconfig-002-20240816   clang-20
i386                             allmodconfig   gcc-12
i386                              allnoconfig   gcc-12
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240816   gcc-12
i386         buildonly-randconfig-002-20240816   clang-18
i386         buildonly-randconfig-003-20240816   clang-18
i386         buildonly-randconfig-004-20240816   clang-18
i386         buildonly-randconfig-005-20240816   gcc-11
i386         buildonly-randconfig-006-20240816   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240816   clang-18
i386                  randconfig-002-20240816   gcc-12
i386                  randconfig-003-20240816   gcc-11
i386                  randconfig-004-20240816   gcc-12
i386                  randconfig-005-20240816   clang-18
i386                  randconfig-006-20240816   gcc-11
i386                  randconfig-011-20240816   gcc-12
i386                  randconfig-012-20240816   clang-18
i386                  randconfig-013-20240816   clang-18
i386                  randconfig-014-20240816   gcc-12
i386                  randconfig-015-20240816   gcc-12
i386                  randconfig-016-20240816   gcc-12
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-14.1.0
loongarch             randconfig-001-20240816   gcc-14.1.0
loongarch             randconfig-002-20240816   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-14.1.0
m68k                       m5475evb_defconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
mips                        bcm63xx_defconfig   clang-17
mips                         cobalt_defconfig   gcc-13.2.0
mips                           ip32_defconfig   clang-20
nios2                            alldefconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-14.1.0
nios2                 randconfig-001-20240816   gcc-14.1.0
nios2                 randconfig-002-20240816   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240816   gcc-14.1.0
parisc                randconfig-002-20240816   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-20
powerpc                      arches_defconfig   gcc-14.1.0
powerpc                   currituck_defconfig   clang-20
powerpc                          g5_defconfig   gcc-14.1.0
powerpc                    gamecube_defconfig   clang-20
powerpc                  mpc866_ads_defconfig   clang-20
powerpc               randconfig-002-20240816   clang-20
powerpc64             randconfig-001-20240816   gcc-14.1.0
powerpc64             randconfig-003-20240816   gcc-14.1.0
riscv                            allmodconfig   clang-20
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-20
riscv                               defconfig   clang-20
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   clang-20
s390                  randconfig-001-20240816   gcc-14.1.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                             espt_defconfig   gcc-14.1.0
sh                    randconfig-001-20240816   gcc-14.1.0
sh                    randconfig-002-20240816   gcc-14.1.0
sh                            titan_defconfig   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240816   gcc-14.1.0
sparc64               randconfig-002-20240816   gcc-14.1.0
um                               allmodconfig   clang-20
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-12
um                                  defconfig   clang-20
um                             i386_defconfig   gcc-12
um                    randconfig-002-20240816   gcc-12
um                           x86_64_defconfig   clang-15
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240816   clang-18
x86_64       buildonly-randconfig-002-20240816   gcc-12
x86_64       buildonly-randconfig-003-20240816   gcc-12
x86_64       buildonly-randconfig-004-20240816   clang-18
x86_64       buildonly-randconfig-005-20240816   clang-18
x86_64       buildonly-randconfig-006-20240816   gcc-12
x86_64                              defconfig   gcc-11
x86_64                randconfig-001-20240816   gcc-12
x86_64                randconfig-002-20240816   clang-18
x86_64                randconfig-003-20240816   clang-18
x86_64                randconfig-004-20240816   clang-18
x86_64                randconfig-005-20240816   clang-18
x86_64                randconfig-006-20240816   gcc-12
x86_64                randconfig-011-20240816   clang-18
x86_64                randconfig-012-20240816   gcc-12
x86_64                randconfig-013-20240816   gcc-12
x86_64                randconfig-014-20240816   clang-18
x86_64                randconfig-015-20240816   clang-18
x86_64                randconfig-016-20240816   clang-18
x86_64                randconfig-071-20240816   clang-18
x86_64                randconfig-072-20240816   gcc-11
x86_64                randconfig-073-20240816   gcc-12
x86_64                randconfig-074-20240816   clang-18
x86_64                randconfig-075-20240816   clang-18
x86_64                randconfig-076-20240816   gcc-12
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240816   gcc-14.1.0
xtensa                randconfig-002-20240816   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

