Return-Path: <linux-kernel+bounces-227552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB73491531E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 18:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 759E2281016
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 16:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB44E19D889;
	Mon, 24 Jun 2024 16:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eFZzz4oO"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDD919D062
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 16:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719245237; cv=none; b=On4tFxmlM+jxL7LEvEjJ4UssEasxOI1WQomrXuCQNA+bxx/Qpd5j/x9KOQIc7MxZJ1eF1koIO0GwCSZqDGP1FjEmeUU/HEe2Vp+sTNXOfsD0tyJxd1ypgxGV/gK1ce2RJilrZg35BkaO+6AYxKBg4U1QiTGT0zBxJF7SLrCFK7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719245237; c=relaxed/simple;
	bh=zEuweJx1AKM92LXGEKRpaACBsz+30/WNNB8CqNEin9w=;
	h=Date:From:To:Cc:Subject:Message-ID; b=DG1RZFYBBpc5rbNJeAk1BlFOb5GyKNFysVIqeZ88crz1zuUxqbIesEcgStdlRuZL0ttTGmpN7Z8iaU+NR4N6MfEvR5PdL28oKF0b8TZg3XEPi/MYJja+iCqoK57xv+q8XaC3qL5U5Xbnf5Nau72kfJUjM5V1aicbn6CccPyIQEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eFZzz4oO; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719245237; x=1750781237;
  h=date:from:to:cc:subject:message-id;
  bh=zEuweJx1AKM92LXGEKRpaACBsz+30/WNNB8CqNEin9w=;
  b=eFZzz4oOMycUyg3DPjLUMqFFlubSe+hpEGz+IBuY2jtBuQDwSJqffolG
   D/PhEOomtMhO+E4RhnQXVeU1lcwU2dCC33OpHYNFstaNf14Wti55Wk41f
   SCECSxO1A2U628KAb1qr1XKXjr5zZFh2M+Ydv0vves/qd9lsf44Cn5KGI
   UfjgkztbAClb+yy5v5sfGAj5ZF7b2aQPI+7DrBofKJhhjGz7roOXHIzU9
   SH6tAeVNEAZ+IIGVwKXBJsPbyLzZSHywKLQyEZMgyFfguMn3B8mIvyD0l
   dzaxZKeToOiH/veY3WpfL+hhdGdkGguWzNvpqGhkHH5zWZENarGUqiDh3
   w==;
X-CSE-ConnectionGUID: dZETTQqcS96onnbgDkBuhw==
X-CSE-MsgGUID: glsTK34oRbKcsaIy0SVlhQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="12218214"
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="12218214"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 09:07:16 -0700
X-CSE-ConnectionGUID: 0ukW2efpTEmZDrfQ40aqog==
X-CSE-MsgGUID: 8vkTpyO+QPKDlplUi41FIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="44041100"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 24 Jun 2024 09:07:15 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sLmDo-000DVI-0q;
	Mon, 24 Jun 2024 16:07:12 +0000
Date: Tue, 25 Jun 2024 00:06:29 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:irq/urgent] BUILD SUCCESS
 a9c3ee5d0fdb069b54902300df6ac822027f3b0a
Message-ID: <202406250027.5YEtCyWV-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/urgent
branch HEAD: a9c3ee5d0fdb069b54902300df6ac822027f3b0a  irqchip/loongson-liointc: Set different ISRs for different cores

elapsed time: 1467m

configs tested: 108
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                   randconfig-001-20240624   gcc-13.2.0
arc                   randconfig-002-20240624   gcc-13.2.0
arm                               allnoconfig   clang-19
arm                   randconfig-001-20240624   clang-17
arm                   randconfig-002-20240624   gcc-13.2.0
arm                   randconfig-003-20240624   gcc-13.2.0
arm                   randconfig-004-20240624   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                 randconfig-001-20240624   clang-19
arm64                 randconfig-002-20240624   gcc-13.2.0
arm64                 randconfig-003-20240624   gcc-13.2.0
arm64                 randconfig-004-20240624   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                  randconfig-001-20240624   gcc-13.2.0
csky                  randconfig-002-20240624   gcc-13.2.0
hexagon                           allnoconfig   clang-19
hexagon               randconfig-001-20240624   clang-19
hexagon               randconfig-002-20240624   clang-19
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
loongarch             randconfig-001-20240624   gcc-13.2.0
loongarch             randconfig-002-20240624   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                 randconfig-001-20240624   gcc-13.2.0
nios2                 randconfig-002-20240624   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                            defconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                              defconfig   gcc-13.2.0
parisc                randconfig-001-20240624   gcc-13.2.0
parisc                randconfig-002-20240624   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc               randconfig-001-20240624   clang-19
powerpc               randconfig-002-20240624   gcc-13.2.0
powerpc               randconfig-003-20240624   clang-16
powerpc64             randconfig-001-20240624   clang-17
powerpc64             randconfig-002-20240624   clang-19
powerpc64             randconfig-003-20240624   clang-19
riscv                             allnoconfig   gcc-13.2.0
riscv                               defconfig   clang-19
riscv                 randconfig-001-20240624   clang-19
riscv                 randconfig-002-20240624   gcc-13.2.0
s390                              allnoconfig   clang-19
s390                                defconfig   clang-19
s390                  randconfig-001-20240624   clang-15
s390                  randconfig-002-20240624   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                                  defconfig   gcc-13.2.0
sh                    randconfig-001-20240624   gcc-13.2.0
sh                    randconfig-002-20240624   gcc-13.2.0
sparc64                             defconfig   gcc-13.2.0
sparc64               randconfig-001-20240624   gcc-13.2.0
sparc64               randconfig-002-20240624   gcc-13.2.0
um                                allnoconfig   clang-17
um                                  defconfig   clang-19
um                             i386_defconfig   gcc-13
um                    randconfig-001-20240624   clang-19
um                    randconfig-002-20240624   clang-19
um                           x86_64_defconfig   clang-15
x86_64       buildonly-randconfig-001-20240624   gcc-13
x86_64       buildonly-randconfig-002-20240624   gcc-13
x86_64       buildonly-randconfig-003-20240624   clang-18
x86_64       buildonly-randconfig-004-20240624   clang-18
x86_64       buildonly-randconfig-005-20240624   clang-18
x86_64       buildonly-randconfig-006-20240624   clang-18
x86_64                randconfig-001-20240624   clang-18
x86_64                randconfig-002-20240624   clang-18
x86_64                randconfig-003-20240624   clang-18
x86_64                randconfig-004-20240624   clang-18
x86_64                randconfig-005-20240624   gcc-11
x86_64                randconfig-006-20240624   gcc-13
x86_64                randconfig-011-20240624   clang-18
x86_64                randconfig-012-20240624   gcc-8
x86_64                randconfig-013-20240624   clang-18
x86_64                randconfig-014-20240624   gcc-8
x86_64                randconfig-015-20240624   gcc-13
x86_64                randconfig-016-20240624   clang-18
x86_64                randconfig-071-20240624   gcc-10
x86_64                randconfig-072-20240624   gcc-10
x86_64                randconfig-073-20240624   gcc-13
x86_64                randconfig-074-20240624   gcc-13
x86_64                randconfig-075-20240624   gcc-13
x86_64                randconfig-076-20240624   gcc-8
xtensa                            allnoconfig   gcc-13.2.0
xtensa                randconfig-001-20240624   gcc-13.2.0
xtensa                randconfig-002-20240624   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

