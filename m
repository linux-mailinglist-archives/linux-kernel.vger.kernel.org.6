Return-Path: <linux-kernel+bounces-370007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8C49A25B5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 16:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A4E01F22955
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 14:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CD41DE8A4;
	Thu, 17 Oct 2024 14:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H4maT4JG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D441DE894
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 14:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729177051; cv=none; b=MRsWKjA9c3k4ttzWq7rMN8Bk34a9k3BQpoZP2IW47atOoJm296qH4UcrxqZ0snlZmHl2NxNFFagYeLOP0Cwoba7/P6Z36EgYKA0WMttGUvfTFL/G1WnaAKbFwICLfu12R7vnagCjdTVdGEbLzwMkjRqGUlo7aEK54zhrOFBtuyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729177051; c=relaxed/simple;
	bh=p+vHUuiBWNtygenf7Gg+ffIbR+B+f5e2WNiqdmrh7hk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=IxKr63CvSBAdyxS1/v0haKKk6RAqi/Q0WhdImvb0mo7t7ogVTKc7BEinWiWgopY+FddcVRmIZXQdW5mua1ts0HWU1L8/3toqIZ2qHAx/XF7FL/v/RDhVC5O50uP1bJK5wyEOMtEQyP4xH4anBc+xSS5yuWQpmTs7SbmVVnZBzkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H4maT4JG; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729177049; x=1760713049;
  h=date:from:to:cc:subject:message-id;
  bh=p+vHUuiBWNtygenf7Gg+ffIbR+B+f5e2WNiqdmrh7hk=;
  b=H4maT4JGzRbrhgAgvWBfcXMPUc1A9RNYfSsyRzD0N2MuLEln8ZduivYJ
   30vI4H5skeflq+22VyY/XmZpTOnwxVHxgRXs8mhk3Vl8QBSaRtmnAuPfo
   wnsRu0vwN5lru4GJXxopwQKrzpA0cIu++svd2jnm2qtNbW6d74OnN6f1d
   mNVqQlZUfgpPvWFWsmQWIYdnhgoM1O4IR/iSRVzjtciblh8UjjbrvwFL+
   n8yUmLsmbw7qaImj3Z/wiIUSDeOZde3+mNRx56KUwVTPu28qyRpltYMfG
   Z5kGuhB3IbysUv/0eQXg6tz7++LuRQ2YR8eb9HUFr9Wi4yANoFMMPfNJx
   w==;
X-CSE-ConnectionGUID: L/ABNIDHQjCvDSqePJRjlA==
X-CSE-MsgGUID: FrDdQiA9QR28WhKMt2oLdw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39790249"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="39790249"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 07:57:29 -0700
X-CSE-ConnectionGUID: IzORX6iGQGOvrgTXzSXqvw==
X-CSE-MsgGUID: AYsiI5IxSYqbH5RtNeCLZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,211,1725346800"; 
   d="scan'208";a="109374400"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 17 Oct 2024 07:57:28 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t1RwL-000MUR-2f;
	Thu, 17 Oct 2024 14:57:25 +0000
Date: Thu, 17 Oct 2024 22:56:33 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:irq/core] BUILD SUCCESS
 ef4c675dc2961ee533bdc1ea20390761df0af5be
Message-ID: <202410172225.v04FfK7v-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
branch HEAD: ef4c675dc2961ee533bdc1ea20390761df0af5be  genirq: Unexport nr_irqs

elapsed time: 1093m

configs tested: 97
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                           tb10x_defconfig    clang-20
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                         bcm2835_defconfig    clang-20
arm                      integrator_defconfig    clang-20
arm                   milbeaut_m10v_defconfig    clang-20
arm                        mvebu_v5_defconfig    clang-20
arm                        spear3xx_defconfig    clang-20
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
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
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                           mtx1_defconfig    clang-20
nios2                             allnoconfig    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.1.0
powerpc                       maple_defconfig    clang-20
powerpc                      mgcoge_defconfig    clang-20
powerpc                     taishan_defconfig    clang-20
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                          debug_defconfig    clang-20
s390                                defconfig    gcc-12
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                             espt_defconfig    clang-20
sh                            migor_defconfig    clang-20
sh                   sh7770_generic_defconfig    clang-20
sparc                            allmodconfig    gcc-14.1.0
sparc                       sparc32_defconfig    clang-20
sparc64                             defconfig    gcc-12
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64                              defconfig    clang-18
x86_64                                  kexec    gcc-12
x86_64                               rhel-8.3    gcc-12
xtensa                            allnoconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

