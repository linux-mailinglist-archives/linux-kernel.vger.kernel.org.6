Return-Path: <linux-kernel+bounces-556928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8B8A5D0D7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 21:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C43E3B93A6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 20:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC9726462C;
	Tue, 11 Mar 2025 20:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d/WCa5R2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950FA263F37
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 20:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741725358; cv=none; b=QU7rtWy1w8bipNN6GXawjKYh1HtaD/ZgNYgdi4e2U7j1xo1Up40bwashXeuq+p2Ut4Q0dFFtGUp0tOeqmLPqXxla3rQv6v3BTQlwltlfCFv+UmwlI0jXqbFY1a/DJRdieOS7TPQmjBa9aRPm4LMoMJBVKzHLp6OJoUd+QxCudIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741725358; c=relaxed/simple;
	bh=AT+MzDiUP2gIgTbf6Yzq0oz5YDK36zYRHMjPG0ybCeo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=MFoNcJ2LDbglgnUy0i9k0vIwvFa/DL9oZkwxg1C3mtBbK0lhVIEuVKGrLiZuz4TnDALHfUvd2qVjy9zDPrgwuV+HpGrcY9NLW8tMdrwDPXpAT+ZjtgQTKRhK1dv5Cj456LxunUEgabG+NptkVdyZj5LjleFDk+B5wTEjMRPJpWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d/WCa5R2; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741725357; x=1773261357;
  h=date:from:to:cc:subject:message-id;
  bh=AT+MzDiUP2gIgTbf6Yzq0oz5YDK36zYRHMjPG0ybCeo=;
  b=d/WCa5R24sKYiIXLD7Sq13GC+Avsq5UWGtH6vGNmokVaPIWZINUJYieb
   hV20BuPkPMYpGa6ZYqmsiCUNuq+SDnqClD4HiFQnhhbTa4jaFmHn0O/96
   Zu+VD48GUVdpeIOhZ9Bcm/KQOw6dPNoNmo3Dyw1hbGCja7gQXHOXcE51q
   py9APOKDpQWq84PHnywXLNqQtKq302zMYp69H6sK/NvsOv3LQskPMCRsy
   FfyW0sdbqzXhadObhQBjXa9gmSofP7HHItTvo8/0mNTRK8FKQ5fY8ymNZ
   MRI5orIRUCWQsE2GINEiszgBMZFQqmgEHtTnXmbcX1VJ4Jyod0CR8N5+k
   Q==;
X-CSE-ConnectionGUID: gdA+rY5ETTmk2wcbNc37Kw==
X-CSE-MsgGUID: JBd7fFVrSt29ru2kfywxVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="46430458"
X-IronPort-AV: E=Sophos;i="6.14,240,1736841600"; 
   d="scan'208";a="46430458"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 13:35:55 -0700
X-CSE-ConnectionGUID: 4iQQHX6QT4mld3DITigBcg==
X-CSE-MsgGUID: 6XGapI+VQ7aI1IppoXnkfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,240,1736841600"; 
   d="scan'208";a="125463036"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 11 Mar 2025 13:35:54 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ts6KN-0007p0-0q;
	Tue, 11 Mar 2025 20:35:51 +0000
Date: Wed, 12 Mar 2025 04:35:40 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 ec73859d76db768da97ee799a91eb9c7d28974fe
Message-ID: <202503120434.RrlnoPlh-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cleanups
branch HEAD: ec73859d76db768da97ee799a91eb9c7d28974fe  x86/coco: Replace 'static const cc_mask' with the newly introduced cc_get_mask() function

elapsed time: 1458m

configs tested: 157
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250311    gcc-13.2.0
arc                   randconfig-001-20250312    clang-21
arc                   randconfig-002-20250311    gcc-13.2.0
arc                   randconfig-002-20250312    clang-21
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    gcc-14.2.0
arm                   randconfig-001-20250311    gcc-14.2.0
arm                   randconfig-001-20250312    clang-21
arm                   randconfig-002-20250311    clang-16
arm                   randconfig-002-20250312    clang-21
arm                   randconfig-003-20250311    gcc-14.2.0
arm                   randconfig-003-20250312    clang-21
arm                   randconfig-004-20250311    gcc-14.2.0
arm                   randconfig-004-20250312    clang-21
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250311    gcc-14.2.0
arm64                 randconfig-001-20250312    clang-21
arm64                 randconfig-002-20250311    gcc-14.2.0
arm64                 randconfig-002-20250312    clang-21
arm64                 randconfig-003-20250311    gcc-14.2.0
arm64                 randconfig-003-20250312    clang-21
arm64                 randconfig-004-20250311    gcc-14.2.0
arm64                 randconfig-004-20250312    clang-21
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250311    gcc-14.2.0
csky                  randconfig-002-20250311    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250311    clang-21
hexagon               randconfig-002-20250311    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250311    gcc-12
i386        buildonly-randconfig-001-20250312    gcc-12
i386        buildonly-randconfig-002-20250311    clang-19
i386        buildonly-randconfig-002-20250312    gcc-12
i386        buildonly-randconfig-003-20250311    clang-19
i386        buildonly-randconfig-003-20250312    gcc-12
i386        buildonly-randconfig-004-20250311    clang-19
i386        buildonly-randconfig-004-20250312    gcc-12
i386        buildonly-randconfig-005-20250311    clang-19
i386        buildonly-randconfig-005-20250312    gcc-12
i386        buildonly-randconfig-006-20250311    gcc-11
i386        buildonly-randconfig-006-20250312    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20250312    clang-19
i386                  randconfig-002-20250312    clang-19
i386                  randconfig-003-20250312    clang-19
i386                  randconfig-004-20250312    clang-19
i386                  randconfig-005-20250312    clang-19
i386                  randconfig-006-20250312    clang-19
i386                  randconfig-007-20250312    clang-19
i386                  randconfig-011-20250312    gcc-11
i386                  randconfig-012-20250312    gcc-11
i386                  randconfig-013-20250312    gcc-11
i386                  randconfig-014-20250312    gcc-11
i386                  randconfig-015-20250312    gcc-11
i386                  randconfig-016-20250312    gcc-11
i386                  randconfig-017-20250312    gcc-11
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250311    gcc-14.2.0
loongarch             randconfig-002-20250311    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                           ip28_defconfig    gcc-14.2.0
nios2                         10m50_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250311    gcc-14.2.0
nios2                 randconfig-002-20250311    gcc-14.2.0
openrisc                          allnoconfig    clang-15
openrisc                          allnoconfig    gcc-14.2.0
parisc                            allnoconfig    clang-15
parisc                            allnoconfig    gcc-14.2.0
parisc                randconfig-001-20250311    gcc-14.2.0
parisc                randconfig-002-20250311    gcc-14.2.0
powerpc                           allnoconfig    clang-15
powerpc                           allnoconfig    gcc-14.2.0
powerpc                        fsp2_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250311    clang-21
powerpc               randconfig-002-20250311    clang-16
powerpc               randconfig-003-20250311    gcc-14.2.0
powerpc64             randconfig-001-20250311    gcc-14.2.0
powerpc64             randconfig-002-20250311    clang-18
powerpc64             randconfig-003-20250311    gcc-14.2.0
riscv                             allnoconfig    clang-15
riscv                             allnoconfig    gcc-14.2.0
riscv                 randconfig-001-20250311    gcc-14.2.0
riscv                 randconfig-001-20250312    gcc-14.2.0
riscv                 randconfig-002-20250311    gcc-14.2.0
riscv                 randconfig-002-20250312    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250311    clang-15
s390                  randconfig-001-20250312    gcc-14.2.0
s390                  randconfig-002-20250311    gcc-14.2.0
s390                  randconfig-002-20250312    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                          r7780mp_defconfig    gcc-14.2.0
sh                    randconfig-001-20250311    gcc-14.2.0
sh                    randconfig-001-20250312    gcc-14.2.0
sh                    randconfig-002-20250311    gcc-14.2.0
sh                    randconfig-002-20250312    gcc-14.2.0
sh                            shmin_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250311    gcc-14.2.0
sparc                 randconfig-001-20250312    gcc-14.2.0
sparc                 randconfig-002-20250311    gcc-14.2.0
sparc                 randconfig-002-20250312    gcc-14.2.0
sparc                       sparc32_defconfig    gcc-14.2.0
sparc64               randconfig-001-20250311    gcc-14.2.0
sparc64               randconfig-001-20250312    gcc-14.2.0
sparc64               randconfig-002-20250311    gcc-14.2.0
sparc64               randconfig-002-20250312    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-15
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                    randconfig-001-20250311    gcc-12
um                    randconfig-001-20250312    gcc-14.2.0
um                    randconfig-002-20250311    gcc-12
um                    randconfig-002-20250312    gcc-14.2.0
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250311    gcc-12
x86_64      buildonly-randconfig-001-20250312    gcc-12
x86_64      buildonly-randconfig-002-20250311    gcc-12
x86_64      buildonly-randconfig-002-20250312    gcc-12
x86_64      buildonly-randconfig-003-20250311    clang-19
x86_64      buildonly-randconfig-003-20250312    gcc-12
x86_64      buildonly-randconfig-004-20250311    clang-19
x86_64      buildonly-randconfig-004-20250312    gcc-12
x86_64      buildonly-randconfig-005-20250311    gcc-12
x86_64      buildonly-randconfig-005-20250312    gcc-12
x86_64      buildonly-randconfig-006-20250311    gcc-12
x86_64      buildonly-randconfig-006-20250312    gcc-12
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                               rhel-9.4    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250311    gcc-14.2.0
xtensa                randconfig-001-20250312    gcc-14.2.0
xtensa                randconfig-002-20250311    gcc-14.2.0
xtensa                randconfig-002-20250312    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

