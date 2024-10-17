Return-Path: <linux-kernel+bounces-369119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3699A1936
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 05:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADFBE1F212A5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 03:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C6313AA4E;
	Thu, 17 Oct 2024 03:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K1N0D1Wo"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB88B7DA8C
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 03:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729134717; cv=none; b=roNvSn3y8nUoxhR2IWjt5IjVo12rMLYq5gMlv1bFkx6CTZdqTKVl2qztZftNQJcm4EFd09qD1GuzMB3Ew0QtPGL8F0lPH7qmBjy48wpNT9csKTekuZaANw9LHX8N0rySBSYqeO9ezSx0CrK2q3Jwplh098iH7iNXUwRgY5TZlYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729134717; c=relaxed/simple;
	bh=q9/f9BqG4HOJegcMwezPMQOSmiCgD6gYb4MQTpkbGnE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=JR3/5tOAS18OVDwog6+z5DjLnJNsAUbStNmM3HvmjpEIvbGedsAMFd7tM17jF/RPauM4cXiGWSXS0hAggdnOEwE7VXcu18a+k9iNhiOeUF3kY76uzDu4mlAEWi9LNhJv823dgb5Wi7VHZy+KJvIsIJP0nz6zk9NXdQpVW6T88C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K1N0D1Wo; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729134715; x=1760670715;
  h=date:from:to:cc:subject:message-id;
  bh=q9/f9BqG4HOJegcMwezPMQOSmiCgD6gYb4MQTpkbGnE=;
  b=K1N0D1Wou1PcrXjn6PmcTwXbs3RnPj/W5tEURhCmX/ReXu9IuXSX3BNN
   vyUBuKu2O3IsfQyh9rhZmaFygmdtq9aC3jHrqi+3nGPjbEjDeZOYSv8xp
   YRAongwrc+lV2vr8INiCvjWptZJvRZYHbVRI+KBgvH0+ED+q/VeBNPFKD
   xxZGyCa721qtD3ZoFAQVsDVRCmZhxLQEhijuBWXRIm0sasagmmUDpfdVf
   xgwjiEMAX/ZMbNgeDrLrWZ+iRXLUQ4CcycukdccJUn1eFLY4szj4qZ73O
   auWdg9R0RU7ibCVy/HIZj2tgNQZXM5+mkIwgrKSN6VE5O7ie8XOKsplEx
   w==;
X-CSE-ConnectionGUID: NWQUmO7HQPGl4irmDwsKEA==
X-CSE-MsgGUID: 99Us0t4bTaSBfJKudkcKlA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28703479"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28703479"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 20:11:54 -0700
X-CSE-ConnectionGUID: Z1+HNX2XThKkLX1/pT6Gjw==
X-CSE-MsgGUID: xH9SZ1XzTXqz3ydnzLZLyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; 
   d="scan'208";a="78070803"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 16 Oct 2024 20:11:53 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t1GvX-000Lfr-2T;
	Thu, 17 Oct 2024 03:11:51 +0000
Date: Thu, 17 Oct 2024 11:11:41 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:timers/core] BUILD SUCCESS WITH WARNING
 1f455f601e2060497f9883991e8d5e79fbc7b047
Message-ID: <202410171126.mBISirgQ-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
branch HEAD: 1f455f601e2060497f9883991e8d5e79fbc7b047  timers/Documentation: Cleanup delay/sleep documentation

Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202410161059.a0f6IBwj-lkp@intel.com

    Warning: drivers/regulator/core.c references a file that doesn't exist: Documentation/timers/timers-howto.rst

Warning ids grouped by kconfigs:

recent_errors
`-- x86_64-allnoconfig
    `-- Warning:drivers-regulator-core.c-references-a-file-that-doesn-t-exist:Documentation-timers-timers-howto.rst

elapsed time: 1702m

configs tested: 129
configs skipped: 5

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                                 defconfig    gcc-14.1.0
arc                         haps_hs_defconfig    clang-14
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                                 defconfig    gcc-14.1.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
i386                             allmodconfig    clang-18
i386                              allnoconfig    clang-18
i386                             allyesconfig    clang-18
i386        buildonly-randconfig-001-20241017    clang-18
i386        buildonly-randconfig-002-20241017    clang-18
i386        buildonly-randconfig-003-20241017    clang-18
i386        buildonly-randconfig-004-20241017    clang-18
i386        buildonly-randconfig-005-20241017    clang-18
i386        buildonly-randconfig-006-20241017    clang-18
i386                                defconfig    clang-18
i386                  randconfig-001-20241017    clang-18
i386                  randconfig-002-20241017    clang-18
i386                  randconfig-003-20241017    clang-18
i386                  randconfig-004-20241017    clang-18
i386                  randconfig-005-20241017    clang-18
i386                  randconfig-006-20241017    clang-18
i386                  randconfig-011-20241017    clang-18
i386                  randconfig-012-20241017    clang-18
i386                  randconfig-013-20241017    clang-18
i386                  randconfig-014-20241017    clang-18
i386                  randconfig-015-20241017    clang-18
i386                  randconfig-016-20241017    clang-18
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
m68k                       m5208evb_defconfig    clang-14
m68k                           virt_defconfig    clang-14
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                           ip28_defconfig    clang-14
mips                           jazz_defconfig    clang-14
mips                      maltaaprp_defconfig    clang-14
mips                          rb532_defconfig    clang-14
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                            defconfig    gcc-12
parisc                            allnoconfig    clang-20
parisc                              defconfig    gcc-12
parisc64                            defconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                      bamboo_defconfig    clang-14
powerpc                     ksi8560_defconfig    clang-14
riscv                             allnoconfig    clang-20
riscv                               defconfig    gcc-12
riscv                    nommu_virt_defconfig    clang-14
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                        edosk7760_defconfig    clang-14
sh                           se7705_defconfig    clang-14
sh                           se7750_defconfig    clang-14
sh                  sh7785lcr_32bit_defconfig    clang-14
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64      buildonly-randconfig-001-20241017    gcc-12
x86_64      buildonly-randconfig-002-20241017    gcc-12
x86_64      buildonly-randconfig-003-20241017    gcc-12
x86_64      buildonly-randconfig-004-20241017    gcc-12
x86_64      buildonly-randconfig-005-20241017    gcc-12
x86_64      buildonly-randconfig-006-20241017    gcc-12
x86_64                              defconfig    clang-18
x86_64                                  kexec    clang-18
x86_64                randconfig-001-20241017    gcc-12
x86_64                randconfig-002-20241017    gcc-12
x86_64                randconfig-003-20241017    gcc-12
x86_64                randconfig-004-20241017    gcc-12
x86_64                randconfig-005-20241017    gcc-12
x86_64                randconfig-006-20241017    gcc-12
x86_64                randconfig-011-20241017    gcc-12
x86_64                randconfig-012-20241017    gcc-12
x86_64                randconfig-013-20241017    gcc-12
x86_64                randconfig-014-20241017    gcc-12
x86_64                randconfig-015-20241017    gcc-12
x86_64                randconfig-016-20241017    gcc-12
x86_64                randconfig-071-20241017    gcc-12
x86_64                randconfig-072-20241017    gcc-12
x86_64                randconfig-073-20241017    gcc-12
x86_64                randconfig-074-20241017    gcc-12
x86_64                randconfig-075-20241017    gcc-12
x86_64                randconfig-076-20241017    gcc-12
x86_64                               rhel-8.3    gcc-12
x86_64                           rhel-8.3-bpf    clang-18
x86_64                         rhel-8.3-kunit    clang-18
x86_64                           rhel-8.3-ltp    clang-18
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0
xtensa                generic_kc705_defconfig    clang-14

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

