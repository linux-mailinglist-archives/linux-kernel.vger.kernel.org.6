Return-Path: <linux-kernel+bounces-527284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2295A4092F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 15:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D13C517B043
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 14:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1458916B3A1;
	Sat, 22 Feb 2025 14:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ry9vqhQy"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7F327453
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 14:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740235370; cv=none; b=SzA+ITtAgBJSZev+O/f0YrI/3EU72xY1nFK1G+jp/TWN7AxnlH0rvZFyVm8pEnW+BrpvgayyMiU+wnU7VZqr6AiRwdiHFo2kHyfsMIcGAaGi83gvaF6C3LV3jCweKdTHp1Pjdws15O/ojt1f7qCAGRGUPcwNgKoHiI2nAsWOsFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740235370; c=relaxed/simple;
	bh=N3MnV/sXyakJ1+cwsEG2R7EKK9al8nNbIF7ZWRzQ160=;
	h=Date:From:To:Cc:Subject:Message-ID; b=mpTtsFBF+u7IAQcn6mDDdbYF4FtQoOGMiuKUct58CZkdgv4xT7SznyA8rxmCt8HSaH9KequrD5rP7xNCBFZfsvbQ+jVGiKEiL8tEIUPwUQq0Ko850+UqK+NMfaumSX/y2NX28U6Xb3jnqDrHBmSP1YIKI0GN/YK8Cntd2UlVLxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ry9vqhQy; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740235369; x=1771771369;
  h=date:from:to:cc:subject:message-id;
  bh=N3MnV/sXyakJ1+cwsEG2R7EKK9al8nNbIF7ZWRzQ160=;
  b=Ry9vqhQyifDsE9fIZ3kop0816+kwpA3vMlIfSr+azbpKM53ooHMGiOiH
   wZpW0r5uzQjL/2yvaK8zznES3wY8ebC//T0pLkaJdTqJp0+2RrgAbORAF
   Eemxjwo7fh4zHjM22nrJA5y/uq3NtRqu2yEtutpQsMB0Vp5orrKDwb+wX
   Fiab4on6fknaSRksGhip6rfkt409kDZ/fAys9lQ1NSI9xa7jzPqjCNDDM
   a60z3IMFQSZEUXgSgrvTVhRMDs/PFo+JqpIQEYOZWU8vQODH4gtTAwgGZ
   79K2m7wMvlRdT365dIjkU0exsiYzwWYkA5XNKqzVyiv7wGZ0RaJE4L15D
   A==;
X-CSE-ConnectionGUID: ryTkNJA9RnyTIxTjOvr0rA==
X-CSE-MsgGUID: hdEqIf07SWmMP4jEp3XpCA==
X-IronPort-AV: E=McAfee;i="6700,10204,11353"; a="43871578"
X-IronPort-AV: E=Sophos;i="6.13,308,1732608000"; 
   d="scan'208";a="43871578"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2025 06:42:48 -0800
X-CSE-ConnectionGUID: 0VxC1S3eTCWdKSxdybXorg==
X-CSE-MsgGUID: WuVzO2C3TkW13brIYJTVAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="115462870"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 22 Feb 2025 06:42:47 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tlqiJ-0006eh-27;
	Sat, 22 Feb 2025 14:42:43 +0000
Date: Sat, 22 Feb 2025 22:42:08 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:sched/urgent] BUILD SUCCESS
 dc0a241ceaf3b7df6f1a7658b020c92682b75bfc
Message-ID: <202502222202.8dqJ5RnZ-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/urgent
branch HEAD: dc0a241ceaf3b7df6f1a7658b020c92682b75bfc  rseq: Fix rseq registration with CONFIG_DEBUG_RSEQ

elapsed time: 1447m

configs tested: 69
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-14.2.0
alpha                           allyesconfig    gcc-14.2.0
arc                              allnoconfig    gcc-13.2.0
arc                  randconfig-001-20250222    gcc-13.2.0
arc                  randconfig-002-20250222    gcc-13.2.0
arm                              allnoconfig    clang-17
arm                  randconfig-001-20250222    gcc-14.2.0
arm                  randconfig-002-20250222    gcc-14.2.0
arm                  randconfig-003-20250222    clang-16
arm                  randconfig-004-20250222    gcc-14.2.0
arm64                            allnoconfig    gcc-14.2.0
arm64                randconfig-001-20250222    gcc-14.2.0
arm64                randconfig-002-20250222    clang-21
arm64                randconfig-003-20250222    clang-18
arm64                randconfig-004-20250222    clang-21
csky                             allnoconfig    gcc-14.2.0
csky                 randconfig-001-20250222    gcc-14.2.0
csky                 randconfig-002-20250222    gcc-14.2.0
hexagon                         allmodconfig    clang-21
hexagon                          allnoconfig    clang-21
hexagon                         allyesconfig    clang-18
hexagon              randconfig-001-20250222    clang-17
hexagon              randconfig-002-20250222    clang-19
i386       buildonly-randconfig-001-20250222    clang-19
i386       buildonly-randconfig-002-20250222    gcc-12
i386       buildonly-randconfig-003-20250222    gcc-12
i386       buildonly-randconfig-004-20250222    clang-19
i386       buildonly-randconfig-005-20250222    gcc-12
i386       buildonly-randconfig-006-20250222    clang-19
loongarch                        allnoconfig    gcc-14.2.0
loongarch            randconfig-001-20250222    gcc-14.2.0
loongarch            randconfig-002-20250222    gcc-14.2.0
nios2                randconfig-001-20250222    gcc-14.2.0
nios2                randconfig-002-20250222    gcc-14.2.0
parisc               randconfig-001-20250222    gcc-14.2.0
parisc               randconfig-002-20250222    gcc-14.2.0
powerpc              randconfig-001-20250222    gcc-14.2.0
powerpc              randconfig-002-20250222    gcc-14.2.0
powerpc              randconfig-003-20250222    gcc-14.2.0
powerpc64            randconfig-001-20250222    gcc-14.2.0
powerpc64            randconfig-002-20250222    clang-16
powerpc64            randconfig-003-20250222    clang-18
riscv                randconfig-001-20250222    clang-21
riscv                randconfig-002-20250222    gcc-14.2.0
s390                            allmodconfig    clang-19
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20250222    gcc-14.2.0
s390                 randconfig-002-20250222    clang-15
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20250222    gcc-14.2.0
sh                   randconfig-002-20250222    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20250222    gcc-14.2.0
sparc                randconfig-002-20250222    gcc-14.2.0
sparc64              randconfig-001-20250222    gcc-14.2.0
sparc64              randconfig-002-20250222    gcc-14.2.0
um                              allmodconfig    clang-21
um                              allyesconfig    gcc-12
um                   randconfig-001-20250222    gcc-12
um                   randconfig-002-20250222    gcc-12
x86_64     buildonly-randconfig-001-20250222    clang-19
x86_64     buildonly-randconfig-002-20250222    gcc-12
x86_64     buildonly-randconfig-003-20250222    gcc-12
x86_64     buildonly-randconfig-004-20250222    clang-19
x86_64     buildonly-randconfig-005-20250222    clang-19
x86_64     buildonly-randconfig-006-20250222    gcc-12
xtensa               randconfig-001-20250222    gcc-14.2.0
xtensa               randconfig-002-20250222    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

