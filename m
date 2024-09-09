Return-Path: <linux-kernel+bounces-320770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6B0971002
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 09:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 196D2B222AD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 07:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5420C1B011D;
	Mon,  9 Sep 2024 07:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T+EdojA9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B741B0111
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 07:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725867646; cv=none; b=mKUt0BIi9yNrFDnthvCvHhSiLRc68y+aZGsyu/RSsh8uHIMt15zbwI+Yw2EurVqWg5Rwl9sbK7c4EHkiquqJvJQK3fVVPytLsdJqjM7hfmtN2VHJEoEaKQGDwNbOr+ZKaFcMM9ICj45hlcICHE0+Ul4LN7FAeFcF+KS4R8fw5Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725867646; c=relaxed/simple;
	bh=KyTWQq0oxziVLaDtjdxiKRO/8Dce9Qn70XLzCSSOMDI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ciMbt8QhHYcPz1WOKjraVF5SCQUQfbSYWtQnJytlEJgTejKt01SkNIJKBcjZGL6iV45kQ+4Aywe43IVFap0b+k7kMlGIbi3xE78cZ00jzxrdN9MqvrQ50NAXKUXu3dQkZSIFxmRA6TMVtTUWav5sHsv+wgoiTKJXEq3VrjcMhxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T+EdojA9; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725867645; x=1757403645;
  h=date:from:to:cc:subject:message-id;
  bh=KyTWQq0oxziVLaDtjdxiKRO/8Dce9Qn70XLzCSSOMDI=;
  b=T+EdojA9ge2zYAukcT6s03V2Z0ymXFcujjgfEUNYbxrup7fQSeNV4pQv
   fQmIfJGJUL7zUwnf/kWQ6lbUMRReY+Aqqy7J2V9PWsuxhZPfsfF8ikXwW
   SKPlNt83wSkG68mGI+3rMm6TFwp3S0l+vlWdPw+Xtva0Xb660zz9MUzIw
   FDVVh284+cFB6opDhoxk9AbmOgbFNx7m6EsOAjSiaL9wDimXFeL1DLpL8
   5d3c9vnUZdJtWTjjxMY9IHMdlyLy9gx1GEmA45RtCXD+mNNjY1s9xxnhQ
   zQu2aFqLfD1exYHUMrSgeGaAZouWp1ae+QcyirRyI3KaXCtIvpctOhvoH
   g==;
X-CSE-ConnectionGUID: FTY2NT7nR62v3uZE4ZcWcA==
X-CSE-MsgGUID: MVRlW+4zQVeRF5wPqroASA==
X-IronPort-AV: E=McAfee;i="6700,10204,11189"; a="35135468"
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="35135468"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 00:40:44 -0700
X-CSE-ConnectionGUID: m/9kxzbUTqGia1pz47qvjg==
X-CSE-MsgGUID: 3IfGtgdjTzexix3/62wbvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="71377665"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 09 Sep 2024 00:40:44 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1snZ0r-000ETG-12;
	Mon, 09 Sep 2024 07:40:41 +0000
Date: Mon, 09 Sep 2024 15:40:15 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:smp/core] BUILD SUCCESS
 1d07085402d122f223bda3f8b72bea37a46ee0c9
Message-ID: <202409091513.asGL2w3A-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp/core
branch HEAD: 1d07085402d122f223bda3f8b72bea37a46ee0c9  smp: Mark smp_prepare_boot_cpu() __init

elapsed time: 1013m

configs tested: 128
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
arm                                 defconfig   gcc-14.1.0
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
i386                             allmodconfig   gcc-12
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-12
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240909   clang-18
i386         buildonly-randconfig-002-20240909   clang-18
i386         buildonly-randconfig-002-20240909   gcc-12
i386         buildonly-randconfig-003-20240909   clang-18
i386         buildonly-randconfig-003-20240909   gcc-12
i386         buildonly-randconfig-004-20240909   clang-18
i386         buildonly-randconfig-004-20240909   gcc-12
i386         buildonly-randconfig-005-20240909   clang-18
i386         buildonly-randconfig-006-20240909   clang-18
i386         buildonly-randconfig-006-20240909   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240909   clang-18
i386                  randconfig-002-20240909   clang-18
i386                  randconfig-002-20240909   gcc-12
i386                  randconfig-003-20240909   clang-18
i386                  randconfig-004-20240909   clang-18
i386                  randconfig-004-20240909   gcc-12
i386                  randconfig-005-20240909   clang-18
i386                  randconfig-006-20240909   clang-18
i386                  randconfig-011-20240909   clang-18
i386                  randconfig-012-20240909   clang-18
i386                  randconfig-013-20240909   clang-18
i386                  randconfig-013-20240909   gcc-12
i386                  randconfig-014-20240909   clang-18
i386                  randconfig-015-20240909   clang-18
i386                  randconfig-016-20240909   clang-18
i386                  randconfig-016-20240909   gcc-12
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
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
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-12
um                               allmodconfig   clang-20
um                                allnoconfig   clang-20
um                               allyesconfig   clang-20
um                                  defconfig   gcc-12
um                             i386_defconfig   gcc-12
um                           x86_64_defconfig   gcc-12
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240909   gcc-12
x86_64       buildonly-randconfig-002-20240909   gcc-12
x86_64       buildonly-randconfig-003-20240909   gcc-12
x86_64       buildonly-randconfig-004-20240909   gcc-12
x86_64       buildonly-randconfig-005-20240909   gcc-12
x86_64       buildonly-randconfig-006-20240909   gcc-12
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-11
x86_64                randconfig-001-20240909   gcc-12
x86_64                randconfig-002-20240909   gcc-12
x86_64                randconfig-003-20240909   gcc-12
x86_64                randconfig-004-20240909   gcc-12
x86_64                randconfig-005-20240909   gcc-12
x86_64                randconfig-006-20240909   gcc-12
x86_64                randconfig-011-20240909   gcc-12
x86_64                randconfig-012-20240909   gcc-12
x86_64                randconfig-013-20240909   gcc-12
x86_64                randconfig-014-20240909   gcc-12
x86_64                randconfig-015-20240909   gcc-12
x86_64                randconfig-016-20240909   gcc-12
x86_64                randconfig-071-20240909   gcc-12
x86_64                randconfig-072-20240909   gcc-12
x86_64                randconfig-073-20240909   gcc-12
x86_64                randconfig-074-20240909   gcc-12
x86_64                randconfig-075-20240909   gcc-12
x86_64                randconfig-076-20240909   gcc-12
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

