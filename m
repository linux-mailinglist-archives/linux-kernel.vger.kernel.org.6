Return-Path: <linux-kernel+bounces-446130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 243239F2021
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 18:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 961AE1887FA7
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 17:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D049719993D;
	Sat, 14 Dec 2024 17:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EFG0CETf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697D1193425
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 17:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734197918; cv=none; b=a5Eb/whA9F2kFX6FjCMdyKmj/HMZ7snfNR6u/MUfCIAGxDRRUvMkFwuKfvETDnER0ObQzk/Qso4GbGPHmDLcdYzSbbjmTFs1riP8R+1Qhliy6uoHvuo64l9WYoPuvl7RdYq5SyN1Wb+Ub0d1SUpIkEeG9IKAJsFib/dLzbYLxaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734197918; c=relaxed/simple;
	bh=9Df8iwC25hzI2S1jmPrXWtDZytyWIQwVzNen4nMI7ok=;
	h=Date:From:To:Cc:Subject:Message-ID; b=qPvFbQlNmYvUXdNxn10sZPh/mbhjdHEPw8oPYzaKIb5BShRJoWmH3Fvq58OXwvTkRED5KOhQpZ3d41aW9nMDFqOLxkY9EHQY+jCllmaj1UDoK5D6x3O4PiZmvZadKhwL0LQC0xjpS9HCIqZvzNcSLnFav9K93BJFGEl3IS/uHrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EFG0CETf; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734197916; x=1765733916;
  h=date:from:to:cc:subject:message-id;
  bh=9Df8iwC25hzI2S1jmPrXWtDZytyWIQwVzNen4nMI7ok=;
  b=EFG0CETfp1woQZEF7VpKssTbfEnpW20TickHXeRSjVba9jbmBcQ/vruM
   yy7mAXumI8pgRJ8cUkbm+W+1KJUQItps6PFOJaov6dpFknNgagIABBFIe
   4mTmZkhqemGuIgZngGDk35QqHbWH1bDB2YA7WXgz29rf6ogsj8SzNIPhe
   7SzKiv553FoOxot7WYZtbno7BjZd7TPZ92tkqlSr164vTYMo4vbyFghEb
   uOLXtLMzWSdYPnk9Pp6Qw+ltcxIA6AC9n1wc/TNBlxkSAiIDg6YYSoh2V
   K4cq6dmaj7jMaqFpqScgmhUnsCG9NHCHtal3nzWi4GTtzyGG7mIGHVCK5
   Q==;
X-CSE-ConnectionGUID: FxrPcjfOQvKJUqRkSf5gdw==
X-CSE-MsgGUID: 8RO3cjoMSPiOAbHmuiK0zg==
X-IronPort-AV: E=McAfee;i="6700,10204,11286"; a="34867273"
X-IronPort-AV: E=Sophos;i="6.12,234,1728975600"; 
   d="scan'208";a="34867273"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2024 09:38:36 -0800
X-CSE-ConnectionGUID: Tfrog3TvQTaFgrqcHvY+VA==
X-CSE-MsgGUID: ++ay/12xQYmDYL+NwQD2ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="101908941"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 14 Dec 2024 09:38:35 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tMW64-000D6c-1O;
	Sat, 14 Dec 2024 17:38:32 +0000
Date: Sun, 15 Dec 2024 01:38:31 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:irq/urgent] BUILD SUCCESS
 773c05f417fa14e1ac94776619e9c978ec001f0b
Message-ID: <202412150125.okYRVbyb-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/urgent
branch HEAD: 773c05f417fa14e1ac94776619e9c978ec001f0b  irqchip/gic-v3: Work around insecure GIC integrations

elapsed time: 1445m

configs tested: 67
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
arc                  randconfig-001-20241214    gcc-13.2.0
arc                  randconfig-002-20241214    gcc-13.2.0
arm                  randconfig-001-20241214    gcc-14.2.0
arm                  randconfig-002-20241214    clang-15
arm                  randconfig-003-20241214    gcc-14.2.0
arm                  randconfig-004-20241214    gcc-14.2.0
arm64                randconfig-001-20241214    clang-15
arm64                randconfig-002-20241214    clang-20
arm64                randconfig-003-20241214    clang-15
arm64                randconfig-004-20241214    gcc-14.2.0
csky                 randconfig-001-20241214    gcc-14.2.0
csky                 randconfig-002-20241214    gcc-14.2.0
hexagon              randconfig-001-20241214    clang-20
hexagon              randconfig-002-20241214    clang-14
i386       buildonly-randconfig-001-20241214    gcc-12
i386       buildonly-randconfig-002-20241214    gcc-12
i386       buildonly-randconfig-003-20241214    clang-19
i386       buildonly-randconfig-004-20241214    clang-19
i386       buildonly-randconfig-005-20241214    gcc-11
i386       buildonly-randconfig-006-20241214    gcc-12
loongarch                       allmodconfig    gcc-14.2.0
loongarch            randconfig-001-20241214    gcc-14.2.0
loongarch            randconfig-002-20241214    gcc-14.2.0
m68k                            allmodconfig    gcc-14.2.0
m68k                            allyesconfig    gcc-14.2.0
nios2                randconfig-001-20241214    gcc-14.2.0
nios2                randconfig-002-20241214    gcc-14.2.0
openrisc                         allnoconfig    gcc-14.2.0
openrisc                 or1klitex_defconfig    gcc-14.2.0
parisc                           allnoconfig    gcc-14.2.0
parisc               randconfig-001-20241214    gcc-14.2.0
parisc               randconfig-002-20241214    gcc-14.2.0
powerpc                          allnoconfig    gcc-14.2.0
powerpc                    kmeter1_defconfig    gcc-14.2.0
powerpc              randconfig-001-20241214    clang-20
powerpc              randconfig-002-20241214    clang-15
powerpc              randconfig-003-20241214    clang-20
powerpc64            randconfig-001-20241214    gcc-14.2.0
powerpc64            randconfig-003-20241214    clang-20
riscv                            allnoconfig    gcc-14.2.0
riscv                randconfig-001-20241214    clang-20
riscv                randconfig-002-20241214    clang-20
s390                            allmodconfig    clang-19
s390                             allnoconfig    clang-20
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20241214    gcc-14.2.0
s390                 randconfig-002-20241214    gcc-14.2.0
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20241214    gcc-14.2.0
sh                   randconfig-002-20241214    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20241214    gcc-14.2.0
sparc                randconfig-002-20241214    gcc-14.2.0
sparc64              randconfig-001-20241214    gcc-14.2.0
sparc64              randconfig-002-20241214    gcc-14.2.0
um                               allnoconfig    clang-18
um                   randconfig-001-20241214    clang-20
um                   randconfig-002-20241214    clang-17
x86_64     buildonly-randconfig-001-20241214    gcc-11
x86_64     buildonly-randconfig-002-20241214    clang-19
x86_64     buildonly-randconfig-003-20241214    gcc-12
x86_64     buildonly-randconfig-004-20241214    gcc-12
x86_64     buildonly-randconfig-005-20241214    gcc-12
x86_64     buildonly-randconfig-006-20241214    clang-19
xtensa               randconfig-001-20241214    gcc-14.2.0
xtensa               randconfig-002-20241214    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

