Return-Path: <linux-kernel+bounces-312183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C86F969328
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 07:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9366283BA3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 05:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33351CEAAA;
	Tue,  3 Sep 2024 05:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QGP5fWPq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571781A302B
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 05:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725340545; cv=none; b=IIrhRdoofwfF29Y7rdT0ubNdsRdfe3f+c6K2ZMTAZHeaVlqRPuGF3nWzyfuSlyxujPxGxmeuwqiA3EyR5qY94ZgF19tyun3mi73gcbqoM5tmSPBMcRV3DsIgK+S9ijCfDflOB5PuXqNL8XB6k+sBWMAzyxVW3L0WThUObUsOYTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725340545; c=relaxed/simple;
	bh=R8ZT1d6M3NmbOQ7US/THdBJdJJL/5Ar1UHtdlsFBp3o=;
	h=Date:From:To:Cc:Subject:Message-ID; b=fHHsEY7r3j6EJT1m02YiwDq/dSLRSlj/APwUcflJS4+ZwfPCd26i6zS2wBEhLhztfNOl+y8hi5Q3PHqRYGE3rrU2c0eVtsaMbSL2tOVGhEzqo5Ym505DAzgNf7lIk3WlSVA1RVYMCgLhEnMYZseSE8FIFyjAk1NlR7LcPGFMEq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QGP5fWPq; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725340543; x=1756876543;
  h=date:from:to:cc:subject:message-id;
  bh=R8ZT1d6M3NmbOQ7US/THdBJdJJL/5Ar1UHtdlsFBp3o=;
  b=QGP5fWPqc22P9VDfbdNNxXiQG+kMuooogCbjuuQ5V9EtWgl+Fv1mXMnR
   JcEZkHbTB/sb6zE+O3yzMUoXbjg6dkXL3ec5MXo6iRgS40EACCTREyH5s
   jSXLLLCKSu23Sdqkutu1WLAYOmKt90JoAd+inTwfn0u7bRmKf+39ieNsz
   W0UJxAa4dIYceEtGhSdzu6/BGCMBsfFa57JatRMebuvzLxAk8GAHGv2az
   K/9aw+j3yxWUqOPNGt3kRCC5mrYc7Gb0M0zB/PGiakbo30HgY1I0DDG1r
   26jBVmTx35scvXsOB2xydvOzZQQHa5+6JFyvhD87b6kSRF3k2lH5Mo3I9
   Q==;
X-CSE-ConnectionGUID: shNxrQC1RtuNneSzvJiGsg==
X-CSE-MsgGUID: zIoVR95fTMOc72ZHnpVUgA==
X-IronPort-AV: E=McAfee;i="6700,10204,11183"; a="27670447"
X-IronPort-AV: E=Sophos;i="6.10,197,1719903600"; 
   d="scan'208";a="27670447"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 22:15:43 -0700
X-CSE-ConnectionGUID: 0EQvLemBRHOqHgdXZYORyg==
X-CSE-MsgGUID: z8h48X/GTzq+SFz+b6PtqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,197,1719903600"; 
   d="scan'208";a="65511962"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 02 Sep 2024 22:15:41 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1slLtD-0006Fm-1Z;
	Tue, 03 Sep 2024 05:15:39 +0000
Date: Tue, 03 Sep 2024 13:15:06 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:timers/urgent] BUILD SUCCESS
 342123d6913c62be17e5ca1bb325758c5fd0db34
Message-ID: <202409031304.N6lcyJgj-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/urgent
branch HEAD: 342123d6913c62be17e5ca1bb325758c5fd0db34  Merge tag 'timers-v6.11-rc7' of https://git.linaro.org/people/daniel.lezcano/linux into timers/urgent

elapsed time: 1124m

configs tested: 171
configs skipped: 5

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
arc                        nsim_700_defconfig   clang-20
arc                        nsimosci_defconfig   clang-20
arc                   randconfig-001-20240903   clang-20
arc                   randconfig-002-20240903   clang-20
arm                              allmodconfig   clang-20
arm                               allnoconfig   gcc-14.1.0
arm                              allyesconfig   clang-20
arm                     davinci_all_defconfig   clang-20
arm                                 defconfig   gcc-14.1.0
arm                      jornada720_defconfig   clang-20
arm                   randconfig-001-20240903   clang-20
arm                   randconfig-002-20240903   clang-20
arm                   randconfig-003-20240903   clang-20
arm                   randconfig-004-20240903   clang-20
arm64                            allmodconfig   clang-20
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-14.1.0
arm64                 randconfig-001-20240903   clang-20
arm64                 randconfig-002-20240903   clang-20
arm64                 randconfig-003-20240903   clang-20
arm64                 randconfig-004-20240903   clang-20
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-14.1.0
csky                  randconfig-001-20240903   clang-20
csky                  randconfig-002-20240903   clang-20
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   gcc-14.1.0
hexagon                          allyesconfig   clang-20
hexagon                             defconfig   gcc-14.1.0
hexagon               randconfig-001-20240903   clang-20
hexagon               randconfig-002-20240903   clang-20
i386                             allmodconfig   clang-18
i386                              allnoconfig   clang-18
i386                             allyesconfig   clang-18
i386         buildonly-randconfig-001-20240903   gcc-12
i386         buildonly-randconfig-002-20240903   gcc-12
i386         buildonly-randconfig-003-20240903   gcc-12
i386         buildonly-randconfig-004-20240903   gcc-12
i386         buildonly-randconfig-005-20240903   gcc-12
i386         buildonly-randconfig-006-20240903   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240903   gcc-12
i386                  randconfig-002-20240903   gcc-12
i386                  randconfig-003-20240903   gcc-12
i386                  randconfig-004-20240903   gcc-12
i386                  randconfig-005-20240903   gcc-12
i386                  randconfig-006-20240903   gcc-12
i386                  randconfig-011-20240903   gcc-12
i386                  randconfig-012-20240903   gcc-12
i386                  randconfig-013-20240903   gcc-12
i386                  randconfig-014-20240903   gcc-12
i386                  randconfig-015-20240903   gcc-12
i386                  randconfig-016-20240903   gcc-12
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-14.1.0
loongarch             randconfig-001-20240903   clang-20
loongarch             randconfig-002-20240903   clang-20
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
mips                         db1xxx_defconfig   clang-20
mips                     loongson1b_defconfig   clang-20
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-14.1.0
nios2                 randconfig-001-20240903   clang-20
nios2                 randconfig-002-20240903   clang-20
openrisc                          allnoconfig   clang-20
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-12
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   clang-20
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-12
parisc                randconfig-001-20240903   clang-20
parisc                randconfig-002-20240903   clang-20
parisc64                            defconfig   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   clang-20
powerpc                          allyesconfig   gcc-14.1.0
powerpc                        fsp2_defconfig   clang-20
powerpc                       maple_defconfig   clang-20
powerpc                 mpc834x_itx_defconfig   clang-20
powerpc                      pcm030_defconfig   clang-20
powerpc               randconfig-002-20240903   clang-20
powerpc64                        alldefconfig   clang-20
powerpc64             randconfig-001-20240903   clang-20
powerpc64             randconfig-002-20240903   clang-20
powerpc64             randconfig-003-20240903   clang-20
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   clang-20
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-12
riscv                 randconfig-001-20240903   clang-20
riscv                 randconfig-002-20240903   clang-20
s390                             allmodconfig   gcc-14.1.0
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-12
s390                  randconfig-001-20240903   clang-20
s390                  randconfig-002-20240903   clang-20
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-12
sh                ecovec24-romimage_defconfig   clang-20
sh                        edosk7760_defconfig   clang-20
sh                          r7780mp_defconfig   clang-20
sh                    randconfig-001-20240903   clang-20
sh                    randconfig-002-20240903   clang-20
sh                           se7619_defconfig   clang-20
sh                           se7721_defconfig   clang-20
sh                   sh7724_generic_defconfig   clang-20
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-12
sparc64               randconfig-001-20240903   clang-20
sparc64               randconfig-002-20240903   clang-20
um                               allmodconfig   clang-20
um                                allnoconfig   clang-20
um                               allyesconfig   clang-20
um                                  defconfig   gcc-12
um                             i386_defconfig   gcc-12
um                    randconfig-001-20240903   clang-20
um                    randconfig-002-20240903   clang-20
um                           x86_64_defconfig   gcc-12
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240903   gcc-12
x86_64       buildonly-randconfig-002-20240903   gcc-12
x86_64       buildonly-randconfig-003-20240903   gcc-12
x86_64       buildonly-randconfig-004-20240903   gcc-12
x86_64       buildonly-randconfig-005-20240903   gcc-12
x86_64       buildonly-randconfig-006-20240903   gcc-12
x86_64                              defconfig   clang-18
x86_64                                  kexec   gcc-12
x86_64                randconfig-001-20240903   gcc-12
x86_64                randconfig-002-20240903   gcc-12
x86_64                randconfig-003-20240903   gcc-12
x86_64                randconfig-004-20240903   gcc-12
x86_64                randconfig-005-20240903   gcc-12
x86_64                randconfig-006-20240903   gcc-12
x86_64                randconfig-011-20240903   gcc-12
x86_64                randconfig-012-20240903   gcc-12
x86_64                randconfig-013-20240903   gcc-12
x86_64                randconfig-014-20240903   gcc-12
x86_64                randconfig-015-20240903   gcc-12
x86_64                randconfig-016-20240903   gcc-12
x86_64                randconfig-071-20240903   gcc-12
x86_64                randconfig-072-20240903   gcc-12
x86_64                randconfig-073-20240903   gcc-12
x86_64                randconfig-074-20240903   gcc-12
x86_64                randconfig-075-20240903   gcc-12
x86_64                randconfig-076-20240903   gcc-12
x86_64                          rhel-8.3-rust   clang-18
x86_64                               rhel-8.3   gcc-12
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240903   clang-20
xtensa                randconfig-002-20240903   clang-20

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

