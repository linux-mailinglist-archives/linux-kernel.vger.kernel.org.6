Return-Path: <linux-kernel+bounces-412326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A259D079E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 02:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8270FB21331
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 01:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6002726281;
	Mon, 18 Nov 2024 01:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jtbAJzai"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B9B360
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 01:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731893803; cv=none; b=RKuyopcuXmCwgagFBIoUu7QBMr0m6z4tXZALWjF9lyTqOWsBtiJrREhKuDzuXn6AYNgjjsdoJRUI+yzFt2Kz50yMV8NSKLggP5PRn+wt9vHcZSlrkqtEQzG5WUc4Gc3JFfFD6emWFezatF/5im6wirlIlqGVIgh5WCIR7xKAEQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731893803; c=relaxed/simple;
	bh=xWOXsxKlZ/+AIhFgrFv27Muk0ZCdvC504mCU00d/htM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=kCJlqoKA4g+jdL6nSufLSIgoiPKfbvUzNcRh8ynfyHGX1ApBuWioVXce5S8s/+VcpgIY+6v2/EsLhIuEIDOden/lX6JBuS8Vg2nI5QMwwO+2GpWo0/i3rW8xq1a1V1OD42c3M+2uP8FpblQvJQwGS/nnIzqvqMdR7u35yPl6pGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jtbAJzai; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731893802; x=1763429802;
  h=date:from:to:cc:subject:message-id;
  bh=xWOXsxKlZ/+AIhFgrFv27Muk0ZCdvC504mCU00d/htM=;
  b=jtbAJzaiRih8haVNxnrnGwmxFnmXosP8+8RO8O+YrFsl8GjxEBWiksgI
   LOq1QgJXKB+waYEANEyaY2Y4khHg765QbXYc6O3zfDcsLWESZrTQHTOlp
   C1ln8rm8r1asYiZ6Fe7zMQTyZzCMaqf58Jupt94/E2Dx8PBXTA0ZGdgS5
   vGgNqPrtUTvaW4C3t8F5swD5XWnkFsGwB3hDnuRStsQ5Ch9OSt2gwq0xG
   KT6XTuQ22QWtdpXWYh3/L4VPzckQIVUPZKvjV6AiDx+8xR2LJJIeGucH3
   X5yS+fgSIoAEI7JvgZz+yoSNu9cMd/Lpm5RS6iNg/dYBlDVZnwzp6Q2OC
   g==;
X-CSE-ConnectionGUID: 5rwVqiz1TIWAU4QhyN8C5g==
X-CSE-MsgGUID: BCWZPRGYT02rDnNt+zpraA==
X-IronPort-AV: E=McAfee;i="6700,10204,11259"; a="35750064"
X-IronPort-AV: E=Sophos;i="6.12,163,1728975600"; 
   d="scan'208";a="35750064"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2024 17:36:41 -0800
X-CSE-ConnectionGUID: cquPUJEgQqKh+hMlxV0AiA==
X-CSE-MsgGUID: t0XuLHRqSHunUbnP9A+ZUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,163,1728975600"; 
   d="scan'208";a="112375343"
Received: from lkp-server01.sh.intel.com (HELO 1e3cc1889ffb) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 17 Nov 2024 17:36:40 -0800
Received: from kbuild by 1e3cc1889ffb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tCqgw-0002Bp-02;
	Mon, 18 Nov 2024 01:36:38 +0000
Date: Mon, 18 Nov 2024 09:35:56 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/wfamnae-next20241114] BUILD REGRESSION
 ffa0ea7cd2216fa4db0e24844e1675e94b7db1aa
Message-ID: <202411180948.TJVV0Xqq-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/wfamnae-next20241114
branch HEAD: ffa0ea7cd2216fa4db0e24844e1675e94b7db1aa  net/mlx5e: Avoid a hundred -Wflex-array-member-not-at-end warnings

Error/Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202411180931.Jr9Zovhz-lkp@intel.com

    kernel/sched/ext.c:3765:10: error: incompatible pointer types returning 'struct cgroup_hdr *' from a function with result type 'struct cgroup *' [-Werror,-Wincompatible-pointer-types]
    kernel/sched/ext.c:7533:17: error: incompatible pointer types initializing 'struct cgroup *' with an expression of type 'struct cgroup_hdr *' [-Werror,-Wincompatible-pointer-types]

Error/Warning ids grouped by kconfigs:

recent_errors
`-- powerpc64-randconfig-001-20241118
    |-- kernel-sched-ext.c:error:incompatible-pointer-types-initializing-struct-cgroup-with-an-expression-of-type-struct-cgroup_hdr-Werror-Wincompatible-pointer-types
    `-- kernel-sched-ext.c:error:incompatible-pointer-types-returning-struct-cgroup_hdr-from-a-function-with-result-type-struct-cgroup-Werror-Wincompatible-pointer-types

elapsed time: 1889m

configs tested: 103
configs skipped: 5

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20241118    gcc-13.2.0
arc                   randconfig-002-20241118    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-20
arm                              allyesconfig    gcc-14.2.0
arm                   milbeaut_m10v_defconfig    clang-16
arm                   randconfig-001-20241118    gcc-14.2.0
arm                   randconfig-002-20241118    gcc-14.2.0
arm                   randconfig-003-20241118    gcc-14.2.0
arm                   randconfig-004-20241118    clang-20
arm                           tegra_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20241118    clang-14
arm64                 randconfig-002-20241118    gcc-14.2.0
arm64                 randconfig-003-20241118    gcc-14.2.0
arm64                 randconfig-004-20241118    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20241118    gcc-14.2.0
csky                  randconfig-002-20241118    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                          allyesconfig    clang-20
hexagon               randconfig-001-20241118    clang-20
hexagon               randconfig-002-20241118    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241118    gcc-12
i386        buildonly-randconfig-002-20241118    gcc-12
i386        buildonly-randconfig-003-20241118    clang-19
i386        buildonly-randconfig-004-20241118    clang-19
i386        buildonly-randconfig-005-20241118    gcc-12
i386        buildonly-randconfig-006-20241118    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20241118    gcc-12
i386                  randconfig-002-20241118    gcc-12
i386                  randconfig-003-20241118    gcc-12
i386                  randconfig-004-20241118    clang-19
i386                  randconfig-005-20241118    gcc-12
i386                  randconfig-006-20241118    gcc-12
i386                  randconfig-011-20241118    clang-19
i386                  randconfig-012-20241118    gcc-12
i386                  randconfig-013-20241118    gcc-12
i386                  randconfig-014-20241118    gcc-11
i386                  randconfig-015-20241118    clang-19
i386                  randconfig-016-20241118    gcc-12
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20241118    gcc-14.2.0
loongarch             randconfig-002-20241118    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20241118    gcc-14.2.0
nios2                 randconfig-002-20241118    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20241118    gcc-14.2.0
parisc                randconfig-002-20241118    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc               randconfig-001-20241118    gcc-14.2.0
powerpc               randconfig-002-20241118    gcc-14.2.0
powerpc               randconfig-003-20241118    gcc-14.2.0
powerpc64             randconfig-001-20241118    clang-14
powerpc64             randconfig-002-20241118    gcc-14.2.0
riscv                             allnoconfig    gcc-14.2.0
riscv                               defconfig    clang-20
riscv                 randconfig-001-20241118    clang-14
riscv                 randconfig-002-20241118    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                                defconfig    clang-20
s390                  randconfig-001-20241118    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                               allyesconfig    gcc-12
um                                  defconfig    clang-20
um                             i386_defconfig    gcc-12
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241118    clang-19
x86_64      buildonly-randconfig-002-20241118    clang-19
x86_64      buildonly-randconfig-003-20241118    gcc-12
x86_64      buildonly-randconfig-004-20241118    clang-19
x86_64      buildonly-randconfig-005-20241118    clang-19
x86_64      buildonly-randconfig-006-20241118    gcc-12
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20241118    clang-19
x86_64                randconfig-002-20241118    clang-19
x86_64                               rhel-8.3    gcc-12
xtensa                            allnoconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

