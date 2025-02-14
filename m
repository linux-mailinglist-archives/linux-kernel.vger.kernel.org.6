Return-Path: <linux-kernel+bounces-514942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2496AA35DC6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 13:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A65C6188F278
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 12:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A20D263F48;
	Fri, 14 Feb 2025 12:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mMf5VmCu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE56263F25
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 12:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739536874; cv=none; b=IxQMGO4UG5nih/r/Fq9RdEHSGhqlqDqfQozZx/0R+/QRznd6dZ2ZHreCfi6xCZ0NAbE5EEqt3LAxiYsEoaOKXzxzopgKyRebvfX/ovhigYc+TlBQ1vc0Q6yauREqN2kZE1TlF4hZXa3SPB2BhAJ1zeIhJFrfKbAfJYOWzxG3kq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739536874; c=relaxed/simple;
	bh=/FH2XrQU17rF5Rr1trJmxLbpNy/83iwilk892uZsryo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=pPGWqioHz5ZOwCToF+4CF74D/GBSFHw27daPiF3SeyW/2+SsYn4MpVuSViS8QtVMjOEBBtPIoGg5LjGHQFB5Sjqdl6ehlbY8AD7wd+bfY34vTbKCN89RFGEpLruxHiLrDeg7S63BM8Umj2U0ww9KUNsavfuEih6pmbrEBkxuJaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mMf5VmCu; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739536873; x=1771072873;
  h=date:from:to:cc:subject:message-id;
  bh=/FH2XrQU17rF5Rr1trJmxLbpNy/83iwilk892uZsryo=;
  b=mMf5VmCu0m/Z/FzHs4yF0BnDrvaLG7JSeLQjejTGGUJDmd/aDXbuujPQ
   ELamKtr4zy+n676tPTpfhPRgbpOMb35c4VHak65agaa1A4nsUi+kjGJeX
   NXZnGItpCs0kwYOUntRNc/xNZzl/hzET1Bk2LncvVglUvasV+dzxmWryZ
   DTIAYG2Uxba2vfKyZAf0pSpi1Y0ezkBLOdRM4wp8DOZbsEoNt+xGdxVY1
   dDz5OBf0ZwleUmDnAt0f3UN8tFypr/f3/LJtjFTRJFPnYFbARorwIYrCf
   WXQWPdKUdCysmpSvcKHO7JFYUXCUB4VvjHIPrCPUSFFtdVbALA25dtzS8
   g==;
X-CSE-ConnectionGUID: jMS6Hz5NRIuH3MU+cu6FtQ==
X-CSE-MsgGUID: Z8sIHsoKRdWFmnngJ/rjPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="40155650"
X-IronPort-AV: E=Sophos;i="6.13,285,1732608000"; 
   d="scan'208";a="40155650"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 04:41:12 -0800
X-CSE-ConnectionGUID: 5T8m9fPRTYCCrOpviaCX0A==
X-CSE-MsgGUID: /sGWQQqkSOWvmaKAoeyeKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118071854"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 14 Feb 2025 04:41:11 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tiv0H-0019Xv-18;
	Fri, 14 Feb 2025 12:41:09 +0000
Date: Fri, 14 Feb 2025 20:40:37 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:irq/urgent] BUILD SUCCESS
 4cf7d58620bfc2ebe934e3dfa97208f13f14ab8b
Message-ID: <202502142031.uoywDsIQ-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/urgent
branch HEAD: 4cf7d58620bfc2ebe934e3dfa97208f13f14ab8b  genirq: Remove unused CONFIG_GENERIC_PENDING_IRQ_CHIPFLAGS

elapsed time: 1446m

configs tested: 126
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250213    gcc-13.2.0
arc                   randconfig-002-20250213    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                              allyesconfig    gcc-14.2.0
arm                   randconfig-001-20250213    clang-17
arm                   randconfig-002-20250213    clang-15
arm                   randconfig-003-20250213    clang-21
arm                   randconfig-004-20250213    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                 randconfig-001-20250213    clang-19
arm64                 randconfig-002-20250213    gcc-14.2.0
arm64                 randconfig-003-20250213    gcc-14.2.0
arm64                 randconfig-004-20250213    clang-21
csky                  randconfig-001-20250213    gcc-14.2.0
csky                  randconfig-002-20250213    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250213    clang-21
hexagon               randconfig-002-20250213    clang-18
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250213    gcc-12
i386        buildonly-randconfig-002-20250213    clang-19
i386        buildonly-randconfig-003-20250213    clang-19
i386        buildonly-randconfig-004-20250213    clang-19
i386        buildonly-randconfig-005-20250213    clang-19
i386        buildonly-randconfig-006-20250213    clang-19
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch             randconfig-001-20250213    gcc-14.2.0
loongarch             randconfig-002-20250213    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250213    gcc-14.2.0
nios2                 randconfig-002-20250213    gcc-14.2.0
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                randconfig-001-20250213    gcc-14.2.0
parisc                randconfig-002-20250213    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc               randconfig-001-20250213    clang-17
powerpc               randconfig-002-20250213    gcc-14.2.0
powerpc               randconfig-003-20250213    gcc-14.2.0
powerpc64             randconfig-001-20250213    clang-19
powerpc64             randconfig-002-20250213    clang-21
powerpc64             randconfig-003-20250213    gcc-14.2.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-21
riscv                 randconfig-001-20250213    clang-19
riscv                 randconfig-002-20250213    clang-17
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250213    gcc-14.2.0
s390                  randconfig-002-20250213    clang-21
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250213    gcc-14.2.0
sh                    randconfig-002-20250213    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250213    gcc-14.2.0
sparc                 randconfig-002-20250213    gcc-14.2.0
sparc64               randconfig-001-20250213    gcc-14.2.0
sparc64               randconfig-002-20250213    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                    randconfig-001-20250213    clang-19
um                    randconfig-002-20250213    clang-21
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250213    gcc-11
x86_64      buildonly-randconfig-001-20250214    gcc-12
x86_64      buildonly-randconfig-002-20250213    gcc-12
x86_64      buildonly-randconfig-002-20250214    gcc-12
x86_64      buildonly-randconfig-003-20250213    clang-19
x86_64      buildonly-randconfig-003-20250214    gcc-12
x86_64      buildonly-randconfig-004-20250213    gcc-12
x86_64      buildonly-randconfig-004-20250214    gcc-12
x86_64      buildonly-randconfig-005-20250213    gcc-12
x86_64      buildonly-randconfig-005-20250214    gcc-12
x86_64      buildonly-randconfig-006-20250213    gcc-12
x86_64      buildonly-randconfig-006-20250214    gcc-12
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20250214    clang-19
x86_64                randconfig-002-20250214    clang-19
x86_64                randconfig-003-20250214    clang-19
x86_64                randconfig-004-20250214    clang-19
x86_64                randconfig-005-20250214    clang-19
x86_64                randconfig-006-20250214    clang-19
x86_64                randconfig-007-20250214    clang-19
x86_64                randconfig-008-20250214    clang-19
x86_64                randconfig-071-20250214    gcc-12
x86_64                randconfig-072-20250214    gcc-12
x86_64                randconfig-073-20250214    gcc-12
x86_64                randconfig-074-20250214    gcc-12
x86_64                randconfig-075-20250214    gcc-12
x86_64                randconfig-076-20250214    gcc-12
x86_64                randconfig-077-20250214    gcc-12
x86_64                randconfig-078-20250214    gcc-12
x86_64                               rhel-9.4    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250213    gcc-14.2.0
xtensa                randconfig-002-20250213    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

