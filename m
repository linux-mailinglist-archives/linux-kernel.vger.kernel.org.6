Return-Path: <linux-kernel+bounces-235342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1654091D42B
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 23:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB43A2813D7
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 21:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DCDB47F60;
	Sun, 30 Jun 2024 21:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f6VVLouC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AAC10F2
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 21:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719783218; cv=none; b=NYTTtNpaTYsOMpGmeppNqsMqNA9siQxj4AavTSP08ZBJp8zuu0DArmmq773ta3Vy1TxWiz3+F8W8yZeUK58U/ilbnLCmZQFSgDyVaxIusxYbeaORag49WHVkcyJLBUVb2f/uuTdakLWtfu6X2us88E9rTgrJtUdO5ee3vQb8uh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719783218; c=relaxed/simple;
	bh=YnLP08AqbkejhCRLnJ6fJo8OyCAlyCmircuGpXHy4Ww=;
	h=Date:From:To:Cc:Subject:Message-ID; b=C/MsDt+r5AUSAPX1IYriCEaa15evngTmj7bJJscN2/t0MNLC4Ix46xfKNtGho8tid9uEezAHMHZbvj3oDJMvQQ23T0Wd0oy5Zd992Xw4DfXYPjUld6PKuosdlIpXLQH5qcq1+bsjoEenWwIiKlUn7oUczCe6moNrBzjn8fm0WY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f6VVLouC; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719783217; x=1751319217;
  h=date:from:to:cc:subject:message-id;
  bh=YnLP08AqbkejhCRLnJ6fJo8OyCAlyCmircuGpXHy4Ww=;
  b=f6VVLouCRSOruwxcJTa/jztyYHeBlVWFkIdZ7fzQQ3aSkmBKKBViGp0U
   aKf024R3hCJGroDIJE1vOiBAYn4mf3DEUXfTfcBXNy9mFJWB5mTgegc0n
   pGaz16Nwdb//ygjtqGvhumiJd1jx8mcK/jNfqKXOZhNd1+7g3OpDW5/IT
   0jAmg+6ZouQWcpHmmAwA7TljQepLk4Z843ssYayrM/vIS4nbP5+FYSvPi
   iL5Sh+cOWMi03WZjlaNLaZsgqig6xZtfQ75I14hIZkTTs/WU4UV4hxXd/
   n3L5g1lIK+xolif52lh2dILe9CRz9m9xoX2T+sxo6RFG55qM6VlHtMzBb
   g==;
X-CSE-ConnectionGUID: K4nUu6oNSXKWyh9JsAn7lg==
X-CSE-MsgGUID: 1zm9dWI7R2Sc3176Ss4TDw==
X-IronPort-AV: E=McAfee;i="6700,10204,11119"; a="27577359"
X-IronPort-AV: E=Sophos;i="6.09,174,1716274800"; 
   d="scan'208";a="27577359"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2024 14:33:36 -0700
X-CSE-ConnectionGUID: IWxRiTFPQxSHlNd3LQZxRQ==
X-CSE-MsgGUID: 5zhrD7HyR+OH/YQnmF5sxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,174,1716274800"; 
   d="scan'208";a="82842771"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 30 Jun 2024 14:33:35 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sO2Au-000M1x-33;
	Sun, 30 Jun 2024 21:33:32 +0000
Date: Mon, 01 Jul 2024 05:33:15 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 3e60034e1aca36058cd5033c5f4edb6e8a5e7b37
Message-ID: <202407010514.dax8ssvf-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 3e60034e1aca36058cd5033c5f4edb6e8a5e7b37  Merge branch into tip/master: 'x86/vmware'

elapsed time: 745m

configs tested: 78
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240701   gcc-13.2.0
arc                   randconfig-002-20240701   gcc-13.2.0
arm                               allnoconfig   clang-19
arm                          ep93xx_defconfig   clang-14
arm                       imx_v6_v7_defconfig   clang-19
arm                   randconfig-001-20240701   gcc-13.2.0
arm                   randconfig-002-20240701   gcc-13.2.0
arm                   randconfig-003-20240701   clang-19
arm                   randconfig-004-20240701   clang-15
arm                             rpc_defconfig   clang-19
arm64                             allnoconfig   gcc-13.2.0
arm64                 randconfig-001-20240701   gcc-13.2.0
arm64                 randconfig-002-20240701   clang-19
arm64                 randconfig-003-20240701   gcc-13.2.0
arm64                 randconfig-004-20240701   clang-19
csky                              allnoconfig   gcc-13.2.0
csky                  randconfig-001-20240701   gcc-13.2.0
csky                  randconfig-002-20240701   gcc-13.2.0
hexagon                           allnoconfig   clang-19
hexagon               randconfig-001-20240701   clang-19
hexagon               randconfig-002-20240701   clang-19
i386         buildonly-randconfig-001-20240630   clang-18
i386         buildonly-randconfig-002-20240630   clang-18
i386         buildonly-randconfig-003-20240630   clang-18
i386         buildonly-randconfig-004-20240630   gcc-7
i386         buildonly-randconfig-005-20240630   clang-18
i386         buildonly-randconfig-006-20240630   gcc-13
i386                  randconfig-001-20240630   gcc-13
i386                  randconfig-002-20240630   gcc-13
i386                  randconfig-003-20240630   clang-18
i386                  randconfig-004-20240630   gcc-13
i386                  randconfig-005-20240630   clang-18
i386                  randconfig-006-20240630   clang-18
i386                  randconfig-011-20240630   gcc-13
i386                  randconfig-012-20240630   clang-18
i386                  randconfig-013-20240630   gcc-8
i386                  randconfig-014-20240630   gcc-8
i386                  randconfig-015-20240630   gcc-10
i386                  randconfig-016-20240630   gcc-13
loongarch                         allnoconfig   gcc-13.2.0
loongarch             randconfig-001-20240701   gcc-13.2.0
loongarch             randconfig-002-20240701   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
m68k                        mvme16x_defconfig   gcc-13.2.0
m68k                        stmark2_defconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                           gcw0_defconfig   clang-19
mips                       lemote2f_defconfig   gcc-13.2.0
mips                     loongson1b_defconfig   clang-15
nios2                             allnoconfig   gcc-13.2.0
nios2                 randconfig-001-20240701   gcc-13.2.0
nios2                 randconfig-002-20240701   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                            defconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                              defconfig   gcc-13.2.0
parisc                randconfig-001-20240701   gcc-13.2.0
parisc                randconfig-002-20240701   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc                      cm5200_defconfig   clang-19
powerpc                      ep88xc_defconfig   gcc-13.2.0
powerpc                     sequoia_defconfig   clang-19
riscv                             allnoconfig   gcc-13.2.0
riscv                               defconfig   clang-19
riscv                    nommu_k210_defconfig   clang-19
s390                              allnoconfig   clang-19
s390                                defconfig   clang-19
sh                                allnoconfig   gcc-13.2.0
sh                                  defconfig   gcc-13.2.0
sparc64                             defconfig   gcc-13.2.0
um                                allnoconfig   clang-17
um                                  defconfig   clang-19
um                             i386_defconfig   gcc-13
xtensa                            allnoconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

