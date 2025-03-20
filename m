Return-Path: <linux-kernel+bounces-569584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB90EA6A4F2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 12:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07C163B5AFC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 11:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299E921CC40;
	Thu, 20 Mar 2025 11:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FJ/YcgtM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C707C21C9EB
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 11:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742470128; cv=none; b=gpy83vBcvqK81BCmAwEs4vIpgwtFEhbo/Q5XYcXEqDh7JNUm2MYT7UNQTkb5p/S9bI0GE8qKR6eC5+4YbfG/ediVWbsuAMbiQDuAJPDvDpBIuDZ7jXNWZdoBF4DoCuHwXFJnd273sml7F4Gjh95sXanbpMP1imSHNZgwndtyLdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742470128; c=relaxed/simple;
	bh=cT4HV/yY11F4rioq/TI57BDF5x72EqQqY6Ra9v3mbJg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ezlQD8fpnjgIGxTkz8L0VVxzgq3/5mosg3GQV2z/eWzetyhArSfGa/giUJLBvw1s630TnUX1Fi+GlK56aiRssrYj/Y76Mq3colDpq1aqmKpLdF34Iwm7qTsaQVD5LKhEZMhKNCbi7kwByrlJ4JrZ9pMBjEeNRAQMLRcrVbwqIX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FJ/YcgtM; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742470127; x=1774006127;
  h=date:from:to:cc:subject:message-id;
  bh=cT4HV/yY11F4rioq/TI57BDF5x72EqQqY6Ra9v3mbJg=;
  b=FJ/YcgtMoKmArj3PFU/VIlxI/4BXUi9EcFDvd6v6JPRjyYdM8oOirDkn
   AH7s76/pNe2XzrppbaD+S9+1pbxiTZTLN5/7GnxSHAuR0SLc5yaBQ16Fg
   ZMbTYcvkCeegpTPAii1sZigr5NTC0YtmzrRsK7nXGYfbODBI+qUHvOxTs
   UR++QxdEh7K41BsCNI2I/9uvhkRZDWVc4Hzjc3NKf34sRCMxxLv3FqDt7
   M8lglYtpGoDS4s6WjHIj0rBSqVnBZTT/i+h32cLv6YynKYJo2NQzKq08O
   rfLAAshWTznABXTWwOcD36Yg/mdJm/G3mXXY561vcdbsB5PFY6yF3U8sW
   A==;
X-CSE-ConnectionGUID: W3ZKXwubQxaUa+neSsh19A==
X-CSE-MsgGUID: Kg/dQxsFTCyPsxWgRbNK+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="43580017"
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; 
   d="scan'208";a="43580017"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 04:28:46 -0700
X-CSE-ConnectionGUID: iTzlBR9rTdih+k3i+btnyg==
X-CSE-MsgGUID: MNeX3i95Rw+K+20o842xrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; 
   d="scan'208";a="128158797"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 20 Mar 2025 04:28:45 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tvE4o-0000Og-2i;
	Thu, 20 Mar 2025 11:28:42 +0000
Date: Thu, 20 Mar 2025 19:27:49 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:timers/merge] BUILD SUCCESS
 65039511ff3d775e4e0875c477f1c9d9b840ff6d
Message-ID: <202503201942.Ya0rLLgE-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/merge
branch HEAD: 65039511ff3d775e4e0875c477f1c9d9b840ff6d  Merge branch 'x86/core' into timers/merge, to resolve conflict and ease integration testing

elapsed time: 1452m

configs tested: 116
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-6.5.0
alpha                            allyesconfig    gcc-9.3.0
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-8.5.0
arc                              allyesconfig    gcc-14.2.0
arc                   randconfig-001-20250319    gcc-14.2.0
arc                   randconfig-002-20250319    gcc-14.2.0
arm                              allmodconfig    gcc-8.5.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-6.5.0
arm                         assabet_defconfig    clang-18
arm                   randconfig-001-20250319    clang-18
arm                   randconfig-002-20250319    clang-21
arm                   randconfig-003-20250319    clang-20
arm                   randconfig-004-20250319    clang-16
arm                        spear6xx_defconfig    clang-15
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-8.5.0
arm64                 randconfig-001-20250319    gcc-7.5.0
arm64                 randconfig-002-20250319    gcc-7.5.0
arm64                 randconfig-003-20250319    gcc-7.5.0
arm64                 randconfig-004-20250319    gcc-7.5.0
csky                              allnoconfig    gcc-9.3.0
csky                  randconfig-001-20250319    gcc-9.3.0
csky                  randconfig-002-20250319    gcc-14.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250319    clang-21
hexagon               randconfig-002-20250319    clang-16
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250319    gcc-12
i386        buildonly-randconfig-002-20250319    gcc-12
i386        buildonly-randconfig-003-20250319    gcc-12
i386        buildonly-randconfig-004-20250319    clang-20
i386        buildonly-randconfig-005-20250319    gcc-12
i386        buildonly-randconfig-006-20250319    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-12.4.0
loongarch                         allnoconfig    gcc-13.3.0
loongarch             randconfig-001-20250319    gcc-14.2.0
loongarch             randconfig-002-20250319    gcc-14.2.0
m68k                             allmodconfig    gcc-8.5.0
m68k                              allnoconfig    gcc-5.5.0
m68k                             allyesconfig    gcc-6.5.0
microblaze                       allmodconfig    gcc-9.3.0
microblaze                        allnoconfig    gcc-11.5.0
microblaze                       allyesconfig    gcc-9.3.0
mips                              allnoconfig    gcc-10.5.0
mips                        vocore2_defconfig    clang-15
nios2                             allnoconfig    gcc-8.5.0
nios2                 randconfig-001-20250319    gcc-11.5.0
nios2                 randconfig-002-20250319    gcc-5.5.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
openrisc                  or1klitex_defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-10.5.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250319    gcc-10.5.0
parisc                randconfig-002-20250319    gcc-10.5.0
powerpc                          allmodconfig    gcc-5.5.0
powerpc                          allyesconfig    clang-21
powerpc                    mvme5100_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250319    gcc-9.3.0
powerpc               randconfig-002-20250319    clang-21
powerpc               randconfig-003-20250319    clang-21
powerpc                      tqm8xx_defconfig    clang-19
powerpc64             randconfig-001-20250319    clang-20
powerpc64             randconfig-002-20250319    gcc-5.5.0
powerpc64             randconfig-003-20250319    clang-21
riscv                            allmodconfig    clang-21
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                 randconfig-001-20250319    clang-20
riscv                 randconfig-002-20250319    clang-17
s390                             allmodconfig    clang-18
s390                             allyesconfig    gcc-8.5.0
s390                                defconfig    clang-15
s390                  randconfig-001-20250319    gcc-6.5.0
s390                  randconfig-002-20250319    gcc-8.5.0
sh                               allmodconfig    gcc-9.3.0
sh                                allnoconfig    gcc-10.5.0
sh                               allyesconfig    gcc-7.5.0
sh                                  defconfig    gcc-14.2.0
sh                          polaris_defconfig    gcc-14.2.0
sh                    randconfig-001-20250319    gcc-11.5.0
sh                    randconfig-002-20250319    gcc-5.5.0
sparc                            allmodconfig    gcc-6.5.0
sparc                             allnoconfig    gcc-6.5.0
sparc                 randconfig-001-20250319    gcc-6.5.0
sparc                 randconfig-002-20250319    gcc-8.5.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250319    gcc-8.5.0
sparc64               randconfig-002-20250319    gcc-6.5.0
um                               allmodconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250319    gcc-12
um                    randconfig-002-20250319    gcc-11
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250319    clang-20
x86_64      buildonly-randconfig-002-20250319    clang-20
x86_64      buildonly-randconfig-003-20250319    gcc-12
x86_64      buildonly-randconfig-004-20250319    gcc-11
x86_64      buildonly-randconfig-005-20250319    clang-20
x86_64      buildonly-randconfig-006-20250319    clang-20
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250319    gcc-10.5.0
xtensa                randconfig-002-20250319    gcc-12.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

