Return-Path: <linux-kernel+bounces-227335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB36914FB1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 16:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CEC01C20F41
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 14:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B732B14265E;
	Mon, 24 Jun 2024 14:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O9+LwR72"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB62A13B2BF
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 14:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719238544; cv=none; b=lrceD0Vz4wKOae/chWDsz6bLtk2w8+VHgrxH71mTepP/DPLSiy3Wc0DyYdz6u4UI6ACNVEdzSyY7gWpW6RwtSPDeK5nK1zG3lHQw/7nzhXH/5f+uIlR6m9zVrrGkZu8KHvA1k2mnT3makbggPymAcVdpvRQ5EBup8HDnVZyzPEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719238544; c=relaxed/simple;
	bh=kn+yYzQAQdjyMDqD9J92JKXjaLwPekFC2gZYv5WbnSQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=qE8+I0zbwzwxIsmnoCHLlC3R+k5L+FRBPb8To3yIRFWuYnvjZkwGRLBA+s4XUAWUQsOx7S8gq6v8MFEJxZsIEjr69WhjikGqjhTrO4HF9vU7pNaKRgeaNAt6/8b66vUUInNDjpL2L8CX+tGPuAUrsis5jY8MwelRbDqJbpvZTyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O9+LwR72; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719238542; x=1750774542;
  h=date:from:to:cc:subject:message-id;
  bh=kn+yYzQAQdjyMDqD9J92JKXjaLwPekFC2gZYv5WbnSQ=;
  b=O9+LwR72PdpGevHOE8oc2KLfdFGuZoGmuyO2f041pZ4KVciq6lyKkGOK
   SpSdwIKR1eAaFPux5jsY0HXyPW4qfjgXltY9Vb/RdL6/m2c6WS23uagAt
   9kpePgIIa2ve3fiW0bgha05neX38oUD7qSsyVlQ/YsWkGD4evl9pGpgqG
   26Ypv7OA4mF0vC3DFyHjJw0ys+QqAie/4x41oRjT7mq7YLtKJVoVv1wYW
   bXdaOYQ2h895Zu9lrnB6+dQJiRkBK3Pyxlz3J8+Twonzf1WmrQRoNnroo
   LwIHHU/DZq+W7L2Uf1y8SfWfO4WeB4R/LFux8ydLlExol0QXWsZQdLfWv
   g==;
X-CSE-ConnectionGUID: lOIYfOFyQ0qlH9aoZs3I8w==
X-CSE-MsgGUID: dpZD4/jjT9ihZt6gtSTAjg==
X-IronPort-AV: E=McAfee;i="6700,10204,11112"; a="15900537"
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="15900537"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 07:15:41 -0700
X-CSE-ConnectionGUID: GwZYCOOlR9WjFSQJvy80fQ==
X-CSE-MsgGUID: 5F2v/cxtQAqjXJPfrQfvWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="43754930"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 24 Jun 2024 07:15:40 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sLkTp-000CyU-2G;
	Mon, 24 Jun 2024 14:15:37 +0000
Date: Mon, 24 Jun 2024 22:14:42 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:irq/msi] BUILD SUCCESS
 6dca724d61a1d10f772dcd06948c30ceca027069
Message-ID: <202406242240.x3FYBWnf-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/msi
branch HEAD: 6dca724d61a1d10f772dcd06948c30ceca027069  irqdomain: Fix formatting irq_find_matching_fwspec() kerneldoc comment

elapsed time: 1501m

configs tested: 119
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                               defconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240623   gcc-13.2.0
arc                   randconfig-002-20240623   gcc-13.2.0
arm                               allnoconfig   clang-19
arm                                 defconfig   clang-14
arm                   randconfig-001-20240623   gcc-13.2.0
arm                   randconfig-002-20240623   gcc-13.2.0
arm                   randconfig-003-20240623   gcc-13.2.0
arm                   randconfig-004-20240623   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240623   clang-15
arm64                 randconfig-002-20240623   clang-19
arm64                 randconfig-003-20240623   clang-19
arm64                 randconfig-004-20240623   clang-19
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240623   gcc-13.2.0
csky                  randconfig-002-20240623   gcc-13.2.0
hexagon                           allnoconfig   clang-19
hexagon                             defconfig   clang-19
hexagon               randconfig-001-20240623   clang-19
hexagon               randconfig-002-20240623   clang-19
i386         buildonly-randconfig-001-20240623   clang-18
i386         buildonly-randconfig-002-20240623   clang-18
i386         buildonly-randconfig-003-20240623   clang-18
i386         buildonly-randconfig-004-20240623   gcc-13
i386         buildonly-randconfig-005-20240623   clang-18
i386         buildonly-randconfig-006-20240623   clang-18
i386                  randconfig-001-20240623   gcc-9
i386                  randconfig-002-20240623   clang-18
i386                  randconfig-003-20240623   gcc-13
i386                  randconfig-004-20240623   clang-18
i386                  randconfig-005-20240623   gcc-7
i386                  randconfig-006-20240623   clang-18
i386                  randconfig-011-20240623   clang-18
i386                  randconfig-012-20240623   gcc-8
i386                  randconfig-013-20240623   clang-18
i386                  randconfig-014-20240623   clang-18
i386                  randconfig-015-20240623   gcc-8
i386                  randconfig-016-20240623   clang-18
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240623   gcc-13.2.0
loongarch             randconfig-002-20240623   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
m68k                                defconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240623   gcc-13.2.0
nios2                 randconfig-002-20240623   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                            defconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                              defconfig   gcc-13.2.0
parisc                randconfig-001-20240623   gcc-13.2.0
parisc                randconfig-002-20240623   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc               randconfig-001-20240623   gcc-13.2.0
powerpc               randconfig-002-20240623   clang-15
powerpc               randconfig-003-20240623   clang-19
powerpc64             randconfig-001-20240623   gcc-13.2.0
powerpc64             randconfig-002-20240623   clang-19
powerpc64             randconfig-003-20240623   gcc-13.2.0
riscv                             allnoconfig   gcc-13.2.0
riscv                               defconfig   clang-19
riscv                 randconfig-001-20240623   clang-19
riscv                 randconfig-002-20240623   clang-19
s390                              allnoconfig   clang-19
s390                                defconfig   clang-19
s390                  randconfig-001-20240623   gcc-13.2.0
s390                  randconfig-002-20240623   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                                  defconfig   gcc-13.2.0
sh                    randconfig-001-20240623   gcc-13.2.0
sh                    randconfig-002-20240623   gcc-13.2.0
sparc64                             defconfig   gcc-13.2.0
sparc64               randconfig-001-20240623   gcc-13.2.0
sparc64               randconfig-002-20240623   gcc-13.2.0
um                                allnoconfig   clang-17
um                                  defconfig   clang-19
um                             i386_defconfig   gcc-13
um                    randconfig-001-20240623   gcc-7
um                    randconfig-002-20240623   clang-19
um                           x86_64_defconfig   clang-15
x86_64       buildonly-randconfig-001-20240623   clang-18
x86_64       buildonly-randconfig-002-20240623   clang-18
x86_64       buildonly-randconfig-003-20240623   clang-18
x86_64       buildonly-randconfig-004-20240623   clang-18
x86_64       buildonly-randconfig-005-20240623   clang-18
x86_64       buildonly-randconfig-006-20240623   clang-18
x86_64                randconfig-001-20240623   gcc-13
x86_64                randconfig-002-20240623   gcc-13
x86_64                randconfig-003-20240623   clang-18
x86_64                randconfig-004-20240623   gcc-13
x86_64                randconfig-005-20240623   gcc-8
x86_64                randconfig-006-20240623   clang-18
x86_64                randconfig-011-20240623   clang-18
x86_64                randconfig-012-20240623   gcc-13
x86_64                randconfig-013-20240623   clang-18
x86_64                randconfig-014-20240623   clang-18
x86_64                randconfig-015-20240623   gcc-13
x86_64                randconfig-016-20240623   clang-18
x86_64                randconfig-071-20240623   gcc-13
x86_64                randconfig-072-20240623   gcc-13
x86_64                randconfig-073-20240623   clang-18
x86_64                randconfig-074-20240623   clang-18
x86_64                randconfig-075-20240623   gcc-13
x86_64                randconfig-076-20240623   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                randconfig-001-20240623   gcc-13.2.0
xtensa                randconfig-002-20240623   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

