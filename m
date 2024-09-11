Return-Path: <linux-kernel+bounces-324068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D02D97478D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 02:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 758EF1F25EC8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 00:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4D3125DB;
	Wed, 11 Sep 2024 00:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i3GEDFb8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A213D7A
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 00:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726015761; cv=none; b=U/lpnJ4vkRgNGdeduHPpKwDOLlzZQTakwubuhw1Hp4XYbBiE2A8ip/ZvhuzmWjbiV2NOxhQvlentXq3L+9X9QRVA21Tqefe6q49i6J0/79CRFAFFymCx7llDqbdiX/YJFCxd1bR62P6U50LftJNpmt9s8UTgrtVd70gs0nnYB2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726015761; c=relaxed/simple;
	bh=6dx4d2v74Mf0ycAzE2+u+3055a+M6cEPMZhCvEw0xIk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=RNywqdZDegQ37ygftyXXlURBU6tCUkOvnyLls+dw2LhJ6saPBjWccijxt7vSwnUv/hMmR3QUx/AXVqzgTXy23LauY0lF7HXFZ+6zpnWapUB02RHJdyX3mXPw9/MrNkRPcrBLapsVDlBNWGQUZqfoRzNg/eGL2kQjQuK6XgNVUyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i3GEDFb8; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726015759; x=1757551759;
  h=date:from:to:cc:subject:message-id;
  bh=6dx4d2v74Mf0ycAzE2+u+3055a+M6cEPMZhCvEw0xIk=;
  b=i3GEDFb8Dc2ECXj3KrCF8j4MdQeBJqCugaBw9d4w4mz7GdSZsxmn2WxM
   YTSPXtyrWvHqoMSIdBYQdaG6j2hlgpGzKwbTQU5I7tcgOjNapm9YEIaB1
   lCs5UqQQ0NO9/LErqWRS9e52ndgHPbqpYg2f1Z8QUwDm/ELPgjKvGbrUT
   shdmIItp81FJ+7PhlQzPKCMuvKnTFHv0eraYiUmG/97baJFPfBZktQA8N
   RKWJRV1ra419qV45b89m3rOmz2WigcfsY8Fm3YBEvNNcm2EIcGScm+p2M
   oG2uVEGxsWnxqSWJrI9a+6CF5UG4FON4nekT1mN7nw+yZyKY6BnrQmy8+
   A==;
X-CSE-ConnectionGUID: OESfXECMRBa+z/2znHj75w==
X-CSE-MsgGUID: OnX4e2gAQQ6ojmaz9lyl+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="13464629"
X-IronPort-AV: E=Sophos;i="6.10,218,1719903600"; 
   d="scan'208";a="13464629"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 17:49:19 -0700
X-CSE-ConnectionGUID: KE8AxvlET/iog4FKmtwVrg==
X-CSE-MsgGUID: PA+t1UIWQsmG18nTMr+d1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,218,1719903600"; 
   d="scan'208";a="71814562"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 10 Sep 2024 17:49:17 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1soBXn-0002tE-1v;
	Wed, 11 Sep 2024 00:49:15 +0000
Date: Wed, 11 Sep 2024 08:48:33 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:timers/core] BUILD SUCCESS
 35b603f8a78b0bd51566db277c4f7b56b3ff6bac
Message-ID: <202409110831.mvPymmRC-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
branch HEAD: 35b603f8a78b0bd51566db277c4f7b56b3ff6bac  ntp: Make sure RTC is synchronized when time goes backwards

elapsed time: 766m

configs tested: 111
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
arc                                 defconfig   gcc-14.1.0
arm                              allmodconfig   clang-20
arm                               allnoconfig   gcc-14.1.0
arm                              allyesconfig   clang-20
arm                       aspeed_g4_defconfig   gcc-14.1.0
arm                                 defconfig   gcc-14.1.0
arm                      footbridge_defconfig   gcc-14.1.0
arm                            hisi_defconfig   gcc-14.1.0
arm                           imxrt_defconfig   gcc-14.1.0
arm                            mmp2_defconfig   gcc-14.1.0
arm                        realview_defconfig   gcc-14.1.0
arm                         s5pv210_defconfig   gcc-14.1.0
arm                       spear13xx_defconfig   gcc-14.1.0
arm64                            allmodconfig   clang-20
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-14.1.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-14.1.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   gcc-14.1.0
hexagon                          allyesconfig   clang-20
hexagon                             defconfig   gcc-14.1.0
i386                             allmodconfig   clang-18
i386                              allnoconfig   clang-18
i386                             allyesconfig   clang-18
i386         buildonly-randconfig-001-20240911   gcc-12
i386         buildonly-randconfig-002-20240911   gcc-12
i386         buildonly-randconfig-003-20240911   gcc-12
i386         buildonly-randconfig-004-20240911   gcc-12
i386         buildonly-randconfig-005-20240911   gcc-12
i386         buildonly-randconfig-006-20240911   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240911   gcc-12
i386                  randconfig-002-20240911   gcc-12
i386                  randconfig-003-20240911   gcc-12
i386                  randconfig-004-20240911   gcc-12
i386                  randconfig-005-20240911   gcc-12
i386                  randconfig-006-20240911   gcc-12
i386                  randconfig-011-20240911   gcc-12
i386                  randconfig-012-20240911   gcc-12
i386                  randconfig-013-20240911   gcc-12
i386                  randconfig-014-20240911   gcc-12
i386                  randconfig-015-20240911   gcc-12
i386                  randconfig-016-20240911   gcc-12
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                          atari_defconfig   gcc-14.1.0
m68k                                defconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
mips                           ip32_defconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-14.1.0
openrisc                          allnoconfig   clang-20
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-12
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   clang-20
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-12
parisc64                            defconfig   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   clang-20
powerpc                          allyesconfig   gcc-14.1.0
powerpc                   currituck_defconfig   gcc-14.1.0
powerpc                       maple_defconfig   gcc-14.1.0
powerpc                 mpc834x_itx_defconfig   gcc-14.1.0
powerpc                     rainier_defconfig   gcc-14.1.0
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   clang-20
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-12
s390                             allmodconfig   gcc-14.1.0
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-12
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-12
sh                          sdk7780_defconfig   gcc-14.1.0
sh                           se7206_defconfig   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-12
um                               allmodconfig   clang-20
um                                allnoconfig   clang-20
um                               allyesconfig   clang-20
um                                  defconfig   gcc-12
um                             i386_defconfig   gcc-12
um                           x86_64_defconfig   gcc-12
x86_64                           alldefconfig   gcc-14.1.0
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

