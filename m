Return-Path: <linux-kernel+bounces-448941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3F99F4775
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 10:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DD00189336C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 09:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E921DF732;
	Tue, 17 Dec 2024 09:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RBH6ZtQ9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A398B1DF27F
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 09:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734427393; cv=none; b=CRzZevncBnXfwjIF/3T4u33EqVcapE7mjwKt/4kJPhpJ2H0Ue301+m43l/pKBMJfYdq7RxH8y13IGoFCPnz2TEIZVt20lR445mtgVyZLFXBdAIPtBe2T+Uq0J1m7PteG1PlWC4koLWL+6jwDbbgc7JJgYpcJrMMM2cLMbEFmx2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734427393; c=relaxed/simple;
	bh=OYVdretFenxLpITu7hToU0C0V+M2AJzYvmt4bdOnbqE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=uzGJLNQ8bfs6ZTP+HtmLoFjz8RoCWlCRB3pXJnhysbiOcbq+wl89mmDFTRLeUQqn4psZPriFXmbFt2r/7ecK+WZoDiPBbdmCkTAfK9nDvw4k5TageX/LLF/xmjQQbCZpWVWsEbDAtQhQ5SRb2KKUwNZvwt0PuxzgfafXT2eY90I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RBH6ZtQ9; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734427391; x=1765963391;
  h=date:from:to:cc:subject:message-id;
  bh=OYVdretFenxLpITu7hToU0C0V+M2AJzYvmt4bdOnbqE=;
  b=RBH6ZtQ9nBqaWeBYtARUjTS3MTRnVl+CqNNJX5b98HBbZHeU4G1hokKC
   bqtRu8BOQLP/O2DiFUtnVESD4d9cmAsnKP9Gbs5iFlIH30FUQc8qci2Og
   5kuBRAU952eE/xUX6qB+Ld3HZy+ZS0Ai+UXGYoXsZ+iEfgRqCPJHXv+Mm
   aNn+pPpVP5/T7ZZvNdQO/XE4WSh7YeZfKnduKWs8n3TRzYLQUs7mzXh3M
   N6PvXTPWOZ2mSECkxfwwKBqbdHl7//7X95Q31FdtNlV7S+iq1sy4fpCwV
   qnQ2PyZU9GDXVDhGgqztLTwenrQjfi1rArokwj36JgG6QbCgx3XBrEs2K
   w==;
X-CSE-ConnectionGUID: 1gTeuJ2uTMuUUMiLUyE3tQ==
X-CSE-MsgGUID: yEGlWrj3RNC2HpE2Wr2TZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="34133463"
X-IronPort-AV: E=Sophos;i="6.12,241,1728975600"; 
   d="scan'208";a="34133463"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2024 01:23:10 -0800
X-CSE-ConnectionGUID: 1W4qyIE6Toa5LAqihX0e+A==
X-CSE-MsgGUID: kFhXKSPZSnWWlV/hIoTMyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="128457325"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 17 Dec 2024 01:23:09 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tNTnH-000Erg-0P;
	Tue, 17 Dec 2024 09:23:07 +0000
Date: Tue, 17 Dec 2024 17:22:44 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:irq/urgent] BUILD SUCCESS
 a60b990798eb17433d0283788280422b1bd94b18
Message-ID: <202412171734.QEcQqpNe-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/urgent
branch HEAD: a60b990798eb17433d0283788280422b1bd94b18  PCI/MSI: Handle lack of irqdomain gracefully

elapsed time: 1390m

configs tested: 110
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20241216    gcc-13.2.0
arc                   randconfig-002-20241216    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                   randconfig-001-20241216    clang-15
arm                   randconfig-002-20241216    gcc-14.2.0
arm                   randconfig-003-20241216    clang-20
arm                   randconfig-004-20241216    clang-17
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20241216    gcc-14.2.0
arm64                 randconfig-002-20241216    clang-20
arm64                 randconfig-003-20241216    gcc-14.2.0
arm64                 randconfig-004-20241216    clang-15
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20241216    gcc-14.2.0
csky                  randconfig-002-20241216    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon               randconfig-001-20241216    clang-20
hexagon               randconfig-002-20241216    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241216    clang-19
i386        buildonly-randconfig-002-20241216    clang-19
i386        buildonly-randconfig-003-20241216    clang-19
i386        buildonly-randconfig-004-20241216    clang-19
i386        buildonly-randconfig-005-20241216    clang-19
i386        buildonly-randconfig-006-20241216    clang-19
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20241216    gcc-14.2.0
loongarch             randconfig-002-20241216    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20241216    gcc-14.2.0
nios2                 randconfig-002-20241216    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                randconfig-001-20241216    gcc-14.2.0
parisc                randconfig-002-20241216    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                          g5_defconfig    gcc-14.2.0
powerpc               randconfig-001-20241216    clang-20
powerpc               randconfig-002-20241216    clang-20
powerpc               randconfig-003-20241216    gcc-14.2.0
powerpc64             randconfig-001-20241216    clang-20
powerpc64             randconfig-002-20241216    clang-15
powerpc64             randconfig-003-20241216    gcc-14.2.0
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                 randconfig-001-20241216    clang-20
riscv                 randconfig-002-20241216    clang-15
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20241216    gcc-14.2.0
s390                  randconfig-002-20241216    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                         ap325rxa_defconfig    gcc-14.2.0
sh                        edosk7705_defconfig    gcc-14.2.0
sh                    randconfig-001-20241216    gcc-14.2.0
sh                    randconfig-002-20241216    gcc-14.2.0
sh                          urquell_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20241216    gcc-14.2.0
sparc                 randconfig-002-20241216    gcc-14.2.0
sparc64               randconfig-001-20241216    gcc-14.2.0
sparc64               randconfig-002-20241216    gcc-14.2.0
um                               alldefconfig    clang-19
um                               allmodconfig    clang-20
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                    randconfig-001-20241216    gcc-12
um                    randconfig-002-20241216    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241216    gcc-12
x86_64      buildonly-randconfig-002-20241216    gcc-12
x86_64      buildonly-randconfig-003-20241216    clang-19
x86_64      buildonly-randconfig-004-20241216    clang-19
x86_64      buildonly-randconfig-005-20241216    clang-19
x86_64      buildonly-randconfig-006-20241216    clang-19
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20241216    gcc-14.2.0
xtensa                randconfig-002-20241216    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

