Return-Path: <linux-kernel+bounces-399079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9FDB9BFAC7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 01:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1656FB22528
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 00:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71DFD1854;
	Thu,  7 Nov 2024 00:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WmDWVprD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F2C36D
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 00:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730939460; cv=none; b=Q5MTmHiwObK9NdZU+LF/VUvJwr+SFCJr5KVPOsMvfmpHzc99P02y3XhCFBNxUtrIFtTvX9WuSO69+bGcx+kdUbDcCsRyAXNK/eTKGvTrGWcJ60FKRwICWQHKs8ClFrAsjqklMms/AoW9+Xc9mM3ZW6CJTQgSSwaQdI+hb06jhkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730939460; c=relaxed/simple;
	bh=Mrqh0c9l0agsQy969CYefJ7OPst2U7rWRPU5+s2QLCk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=cUrvN74XN4FqbgMKen8vmTPR7ysPJug42iAcZajLFdP2zclZvpxqHkMgPgeKKx3tmuUimTM2d2LvUIS6fB8VpmWOwWBe62PpOl4gMxG9cULusiBbt899qrjs5YwIxqatw+WvNLg8OgC2FmQZ6QWFAKTzfIr4Q7olJ8JkDn6/kis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WmDWVprD; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730939459; x=1762475459;
  h=date:from:to:cc:subject:message-id;
  bh=Mrqh0c9l0agsQy969CYefJ7OPst2U7rWRPU5+s2QLCk=;
  b=WmDWVprDK4MJjh1zMvQPZPzD14VNYG4Om5EhpA3F2yy0zxP124maUXBz
   uPOpcsJ+ziupwwb/828ADLm1D/XjFt1mtqH8DdKUek9AyFfQF0uqR1mIO
   6FuR46b1KgW3SakJlKLyckq1JMWjgtYb4RFpWT3f8ObS7gXZa8Ecc4Dlo
   qiHmWbMquXIYQvr77v3Ai09ebqOIlOpoIgoR+41sFcaFaP9ExwhPGVrr2
   diMJpUB4R8MMVGJVy9BMVj5vyzQc1/WPpWf02K7Rr+43mCraaFihVN9TC
   FKhmkiSVA35mXJ6ZIkjrv/G8VV9+cehomakcrf1kvKsU5Xjx0F1tgYR2k
   w==;
X-CSE-ConnectionGUID: JUPGLyFTSVu9bhJ1bsf3/g==
X-CSE-MsgGUID: oAoSMo89RYyQSaCEhOU/oQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11248"; a="48280251"
X-IronPort-AV: E=Sophos;i="6.11,264,1725346800"; 
   d="scan'208";a="48280251"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 16:30:46 -0800
X-CSE-ConnectionGUID: B6CG1MWMSdSDKDADPC0gXA==
X-CSE-MsgGUID: rO1kf+pVRua4BTkwAKLe5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="89624316"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 06 Nov 2024 16:30:43 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t8qQ5-000pZE-10;
	Thu, 07 Nov 2024 00:30:41 +0000
Date: Thu, 07 Nov 2024 08:30:12 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/wfamnae-next20241104-inet-sock] BUILD
 REGRESSION 0b4bf4f4d944d1418ba00462cef8ddf022c3ea60
Message-ID: <202411070805.FXG0X9lk-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/wfamnae-next20241104-inet-sock
branch HEAD: 0b4bf4f4d944d1418ba00462cef8ddf022c3ea60  net: inet_sock.h: Avoid thousands of -Wflex-array-member-not-at-end warnings

Error/Warning (recently discovered and may have been fixed):

    include/linux/build_bug.h:78:41: error: static assertion failed: "struct member likely outside of struct_group_tagged()"

Error/Warning ids grouped by kconfigs:

recent_errors
|-- arm-allmodconfig
|   `-- include-linux-build_bug.h:error:static-assertion-failed:struct-member-likely-outside-of-struct_group_tagged()
|-- arm-allyesconfig
|   `-- include-linux-build_bug.h:error:static-assertion-failed:struct-member-likely-outside-of-struct_group_tagged()
|-- mips-allmodconfig
|   `-- include-linux-build_bug.h:error:static-assertion-failed:struct-member-likely-outside-of-struct_group_tagged()
|-- mips-allyesconfig
|   `-- include-linux-build_bug.h:error:static-assertion-failed:struct-member-likely-outside-of-struct_group_tagged()
|-- parisc-allmodconfig
|   `-- include-linux-build_bug.h:error:static-assertion-failed:struct-member-likely-outside-of-struct_group_tagged()
|-- parisc-allyesconfig
|   `-- include-linux-build_bug.h:error:static-assertion-failed:struct-member-likely-outside-of-struct_group_tagged()
|-- powerpc-randconfig-002-20241106
|   `-- include-linux-build_bug.h:error:static-assertion-failed:struct-member-likely-outside-of-struct_group_tagged()
`-- xtensa-randconfig-001-20241106
    `-- include-linux-build_bug.h:error:static-assertion-failed:struct-member-likely-outside-of-struct_group_tagged()

elapsed time: 1202m

configs tested: 150
configs skipped: 3

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                          axs103_defconfig    gcc-13.2.0
arc                   randconfig-001-20241106    gcc-13.2.0
arc                   randconfig-002-20241106    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-20
arm                              allyesconfig    gcc-14.2.0
arm                          gemini_defconfig    clang-20
arm                           h3600_defconfig    gcc-14.2.0
arm                           imxrt_defconfig    clang-20
arm                   randconfig-001-20241106    gcc-14.2.0
arm                   randconfig-002-20241106    clang-20
arm                   randconfig-003-20241106    clang-20
arm                   randconfig-004-20241106    clang-17
arm                             rpc_defconfig    clang-20
arm                       versatile_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20241106    gcc-14.2.0
arm64                 randconfig-002-20241106    gcc-14.2.0
arm64                 randconfig-003-20241106    clang-20
arm64                 randconfig-004-20241106    clang-20
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20241106    gcc-14.2.0
csky                  randconfig-002-20241106    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                          allyesconfig    clang-20
hexagon               randconfig-001-20241106    clang-14
hexagon               randconfig-002-20241106    clang-16
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241106    clang-19
i386        buildonly-randconfig-002-20241106    clang-19
i386        buildonly-randconfig-003-20241106    gcc-12
i386        buildonly-randconfig-004-20241106    clang-19
i386        buildonly-randconfig-005-20241106    clang-19
i386        buildonly-randconfig-006-20241106    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20241106    clang-19
i386                  randconfig-002-20241106    gcc-12
i386                  randconfig-003-20241106    gcc-12
i386                  randconfig-004-20241106    gcc-12
i386                  randconfig-005-20241106    clang-19
i386                  randconfig-006-20241106    clang-19
i386                  randconfig-011-20241106    gcc-12
i386                  randconfig-012-20241106    gcc-12
i386                  randconfig-013-20241106    gcc-12
i386                  randconfig-014-20241106    gcc-12
i386                  randconfig-015-20241106    clang-19
i386                  randconfig-016-20241106    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20241106    gcc-14.2.0
loongarch             randconfig-002-20241106    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                          atari_defconfig    gcc-14.2.0
m68k                          multi_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20241106    gcc-14.2.0
nios2                 randconfig-002-20241106    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                randconfig-001-20241106    gcc-14.2.0
parisc                randconfig-002-20241106    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-20
powerpc                      pcm030_defconfig    clang-20
powerpc               randconfig-001-20241106    gcc-14.2.0
powerpc               randconfig-002-20241106    gcc-14.2.0
powerpc               randconfig-003-20241106    gcc-14.2.0
powerpc                     sequoia_defconfig    clang-20
powerpc                     tqm8541_defconfig    clang-15
powerpc64             randconfig-001-20241106    clang-20
powerpc64             randconfig-002-20241106    clang-20
powerpc64             randconfig-003-20241106    gcc-14.2.0
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                 randconfig-001-20241106    gcc-14.2.0
riscv                 randconfig-002-20241106    clang-20
s390                             allmodconfig    clang-20
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20241106    gcc-14.2.0
s390                  randconfig-002-20241106    clang-20
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                          lboxre2_defconfig    gcc-14.2.0
sh                            migor_defconfig    gcc-14.2.0
sh                    randconfig-001-20241106    gcc-14.2.0
sh                    randconfig-002-20241106    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                       sparc32_defconfig    gcc-14.2.0
sparc64               randconfig-001-20241106    gcc-14.2.0
sparc64               randconfig-002-20241106    gcc-14.2.0
um                               alldefconfig    clang-20
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                               allyesconfig    gcc-12
um                    randconfig-001-20241106    clang-20
um                    randconfig-002-20241106    clang-17
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241106    clang-19
x86_64      buildonly-randconfig-002-20241106    clang-19
x86_64      buildonly-randconfig-003-20241106    clang-19
x86_64      buildonly-randconfig-004-20241106    gcc-12
x86_64      buildonly-randconfig-005-20241106    gcc-12
x86_64      buildonly-randconfig-006-20241106    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20241106    clang-19
x86_64                randconfig-002-20241106    gcc-11
x86_64                randconfig-003-20241106    gcc-12
x86_64                randconfig-004-20241106    gcc-12
x86_64                randconfig-005-20241106    clang-19
x86_64                randconfig-006-20241106    gcc-11
x86_64                randconfig-011-20241106    gcc-11
x86_64                randconfig-012-20241106    gcc-12
x86_64                randconfig-013-20241106    clang-19
x86_64                randconfig-014-20241106    gcc-12
x86_64                randconfig-015-20241106    gcc-12
x86_64                randconfig-016-20241106    gcc-12
x86_64                randconfig-071-20241106    gcc-12
x86_64                randconfig-072-20241106    gcc-12
x86_64                randconfig-073-20241106    clang-19
x86_64                randconfig-074-20241106    gcc-12
x86_64                randconfig-075-20241106    clang-19
x86_64                randconfig-076-20241106    gcc-12
x86_64                               rhel-8.3    gcc-12
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20241106    gcc-14.2.0
xtensa                randconfig-002-20241106    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

