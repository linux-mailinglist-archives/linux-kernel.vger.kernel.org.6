Return-Path: <linux-kernel+bounces-355256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6BE994E7D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 15:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BBC21C25356
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 13:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55071DEFDD;
	Tue,  8 Oct 2024 13:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nLr63Qz3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92541D3653
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 13:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728393458; cv=none; b=HwmUiDqYTAppvu08DPxrcUY1s5DnekswdoofdapXSTrsdWyZHNXUCUZaiNUgZvKEqeDqE7Vu/rXs2oiHNIyxLJ+X0C/ZdRukjtNp6abhY9olkAhXYi/Z6gNCxnSp/hZzzsNCumm62rwI4aW5l+jeiCb2WMi0j7D4018n9uyEVSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728393458; c=relaxed/simple;
	bh=8SnIwfgR4kv6Vq6j7k2ZE7q37IMzaL8/3EAll6ES23o=;
	h=Date:From:To:Cc:Subject:Message-ID; b=fCwzCwxvGmDQfL3W3fY5NnEmVzr+3l6hE4Szm3jjW/+zzZMLW3PiasYr8tBvM264yt+nrkcVqAonBCDHFnOiz2B8KGlYQhW2ZGxvuaugU31hR8T+Uh5wlBcT2HMmGpqKommYcgUwYpgutk52lG+mWkUgSfxEJ2gWB2RsDm1AN50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nLr63Qz3; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728393456; x=1759929456;
  h=date:from:to:cc:subject:message-id;
  bh=8SnIwfgR4kv6Vq6j7k2ZE7q37IMzaL8/3EAll6ES23o=;
  b=nLr63Qz30KkLrrWRVm0+yEhlktqIm6R9Zt/lf71ZS0X6zFiHbz0vqdqe
   /z48WXqhtdoKGOFajj7VWqan9qwdhmhF21/kRZDoVNRJFLc+22iE15BeG
   u5xiP09m90o1XNiOB8reT9x/vyYggnPKsbvY2T8mhPAvosDt5DBcVZ44d
   7HSce657hs3CnRFeuj6pDYhFxV2QLmsZLoxOSxy9WK3L6FQDNa4cvu+EK
   XsWEcDILPXN5mQuWcrAxwIxuZ0NRkku5iRczNuA4TAEsFJxW+obc7l9jv
   7c9TPKkxz8JEu7f5IpOFqKONZBuN7O2OtLdb9xY+0I6JLjodku5PM87Ez
   g==;
X-CSE-ConnectionGUID: xrrOe+E3SRO39HROh4hrwQ==
X-CSE-MsgGUID: O4lRVCpOQMqLP5pfPj2EKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="27678644"
X-IronPort-AV: E=Sophos;i="6.11,187,1725346800"; 
   d="scan'208";a="27678644"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 06:17:36 -0700
X-CSE-ConnectionGUID: 0s6iQc58TziRyY6RaJ63yA==
X-CSE-MsgGUID: LEIYfQlXTe6AFOIUE8D1sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,187,1725346800"; 
   d="scan'208";a="75792283"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 08 Oct 2024 06:17:36 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1syA5l-0007aN-0j;
	Tue, 08 Oct 2024 13:17:33 +0000
Date: Tue, 08 Oct 2024 21:16:42 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 f8bc84b6096f1ffa67252f0f88d86e77f6bbe348
Message-ID: <202410082134.xl8f07uw-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: f8bc84b6096f1ffa67252f0f88d86e77f6bbe348  x86/amd_nb: Add new PCI ID for AMD family 1Ah model 20h

elapsed time: 1051m

configs tested: 79
configs skipped: 133

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
hexagon                           allnoconfig    gcc-14.1.0
i386                             allmodconfig    clang-18
i386                              allnoconfig    clang-18
i386                             allyesconfig    clang-18
i386        buildonly-randconfig-001-20241008    clang-18
i386        buildonly-randconfig-002-20241008    clang-18
i386        buildonly-randconfig-002-20241008    gcc-12
i386        buildonly-randconfig-003-20241008    clang-18
i386        buildonly-randconfig-003-20241008    gcc-12
i386        buildonly-randconfig-004-20241008    clang-18
i386        buildonly-randconfig-004-20241008    gcc-12
i386        buildonly-randconfig-005-20241008    clang-18
i386        buildonly-randconfig-006-20241008    clang-18
i386                                defconfig    clang-18
i386                  randconfig-001-20241008    clang-18
i386                  randconfig-002-20241008    clang-18
i386                  randconfig-002-20241008    gcc-12
i386                  randconfig-003-20241008    clang-18
i386                  randconfig-003-20241008    gcc-12
i386                  randconfig-004-20241008    clang-18
i386                  randconfig-005-20241008    clang-18
i386                  randconfig-005-20241008    gcc-12
i386                  randconfig-006-20241008    clang-18
i386                  randconfig-006-20241008    gcc-12
i386                  randconfig-011-20241008    clang-18
i386                  randconfig-012-20241008    clang-18
i386                  randconfig-013-20241008    clang-18
i386                  randconfig-013-20241008    gcc-12
i386                  randconfig-014-20241008    clang-18
i386                  randconfig-014-20241008    gcc-12
i386                  randconfig-015-20241008    clang-18
i386                  randconfig-016-20241008    clang-18
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.1.0
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.1.0
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sparc                            allmodconfig    gcc-14.1.0
um                                allnoconfig    clang-20
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64                              defconfig    clang-18
x86_64                                  kexec    clang-18
x86_64                                  kexec    gcc-12
x86_64                               rhel-8.3    gcc-12
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

