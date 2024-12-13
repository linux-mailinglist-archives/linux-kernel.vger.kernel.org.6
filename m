Return-Path: <linux-kernel+bounces-444319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 645D59F04B0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 07:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71FF616A179
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 06:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CC0188724;
	Fri, 13 Dec 2024 06:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I30Obzwf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4239013DDAA
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 06:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734070730; cv=none; b=BvZ1a9+kVCVE9SeI49mYx9IKyHY5/7CsBKkZ9+kMebw2WNpRm3UkZK+JGfgM/44cPJCygwX/5YljXXxoZ+2eQvyVpANN+CC+N4ZHrrLsR4tQ6UFOgE9dQFyeEK1DJ9VpK391KaaMEdWQymBUZSKaKrSFVB+iqmBKaOp9jJinTjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734070730; c=relaxed/simple;
	bh=drtcX21JOmp6hMkeDHBjYCxz3n43lkTpeHqANyabxBU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=O6SsAZ9nZGsNO5fbojh3iz0Le7Nk6+TOMfV0hD6JrSXpOt5iFpQwt2BaL8M9WaoKbs5zaOsfX/9yoipMJkgP250q9s42QwC389klKgfL/D8/cmu46C+UAHl1GM/bEOYzSFglsYwRWhUi/N9R69jZD5YzqMqJysFU7O+fP6VOvaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I30Obzwf; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734070728; x=1765606728;
  h=date:from:to:cc:subject:message-id;
  bh=drtcX21JOmp6hMkeDHBjYCxz3n43lkTpeHqANyabxBU=;
  b=I30ObzwfwJS5klpT1AZekQSN6M4keAJQW2Hz/OMpmtdrg3YgYBBz8pw1
   wqhcdpWSbYtA+KD3fqRqJCuNp8NDEZQ+VX7XcElqBdgkGsBrKFMRBdp4S
   NiQef36IjitTReQk2zrkyK97sp8zFHAUyMz4jSVuuqrVtiNrBmL2s2xyc
   08sFPhHTQiiNzEY1VAJhPL9z6onp4yHAtIz8vjgQCmza7bPX5f4SXW3kM
   D7Gspa1bfzuK8NdNAs5euvgX9+KhO0/aYFa3R4rRnfqG/hrDYxhR8VBOa
   PAS83OcLZrF5jdErKnShwbfzAC1yfbdQBwxtPOsx0DduizkPahgI6e/VA
   A==;
X-CSE-ConnectionGUID: A/OlU6LvSP6G6AC3DRI6YQ==
X-CSE-MsgGUID: H7KG7pNQTmicC1cxb9HRjg==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="45125676"
X-IronPort-AV: E=Sophos;i="6.12,230,1728975600"; 
   d="scan'208";a="45125676"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 22:18:47 -0800
X-CSE-ConnectionGUID: 3/BMn3L4RS645vCW/B+V/g==
X-CSE-MsgGUID: TQnsYCy+SbSY4x0gauJ3rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,230,1728975600"; 
   d="scan'208";a="96330959"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 12 Dec 2024 22:18:46 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tLz0e-000Bkh-1u;
	Fri, 13 Dec 2024 06:18:44 +0000
Date: Fri, 13 Dec 2024 14:17:49 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2024.12.11a] BUILD SUCCESS
 07b53c4c27e8e21c505b0d58e604ba123d24452e
Message-ID: <202412131441.MpAliQ1R-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2024.12.11a
branch HEAD: 07b53c4c27e8e21c505b0d58e604ba123d24452e  stop_machine: Fix rcu_momentary_eqs() call in multi_cpu_stop()

elapsed time: 1456m

configs tested: 66
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
arc                  randconfig-001-20241212    gcc-13.2.0
arc                  randconfig-002-20241212    gcc-13.2.0
arm                  randconfig-001-20241212    gcc-14.2.0
arm                  randconfig-002-20241212    clang-20
arm                  randconfig-003-20241212    clang-19
arm                  randconfig-004-20241212    clang-20
arm64                randconfig-001-20241212    clang-20
arm64                randconfig-002-20241212    clang-15
arm64                randconfig-003-20241212    clang-20
arm64                randconfig-004-20241212    gcc-14.2.0
csky                 randconfig-001-20241213    gcc-14.2.0
csky                 randconfig-002-20241213    gcc-14.2.0
hexagon              randconfig-001-20241213    clang-20
hexagon              randconfig-002-20241213    clang-20
i386                            allmodconfig    gcc-12
i386                             allnoconfig    gcc-12
i386       buildonly-randconfig-001-20241212    clang-19
i386       buildonly-randconfig-002-20241212    clang-19
i386       buildonly-randconfig-003-20241212    clang-19
i386       buildonly-randconfig-004-20241212    clang-19
i386       buildonly-randconfig-005-20241212    clang-19
i386       buildonly-randconfig-006-20241212    gcc-12
loongarch                       allmodconfig    gcc-14.2.0
loongarch            randconfig-001-20241213    gcc-14.2.0
loongarch            randconfig-002-20241213    gcc-14.2.0
m68k                            allmodconfig    gcc-14.2.0
m68k                            allyesconfig    gcc-14.2.0
nios2                randconfig-001-20241213    gcc-14.2.0
nios2                randconfig-002-20241213    gcc-14.2.0
parisc               randconfig-001-20241213    gcc-14.2.0
parisc               randconfig-002-20241213    gcc-14.2.0
powerpc              randconfig-001-20241213    gcc-14.2.0
powerpc              randconfig-002-20241213    clang-20
powerpc              randconfig-003-20241213    gcc-14.2.0
powerpc64            randconfig-001-20241213    gcc-14.2.0
powerpc64            randconfig-002-20241213    gcc-14.2.0
powerpc64            randconfig-003-20241213    gcc-14.2.0
riscv                randconfig-001-20241212    clang-17
riscv                randconfig-002-20241212    clang-20
s390                            allmodconfig    clang-19
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20241212    clang-18
s390                 randconfig-002-20241212    clang-20
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20241212    gcc-14.2.0
sh                   randconfig-002-20241212    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20241212    gcc-14.2.0
sparc                randconfig-002-20241212    gcc-14.2.0
sparc64              randconfig-001-20241212    gcc-14.2.0
sparc64              randconfig-002-20241212    gcc-14.2.0
um                   randconfig-001-20241212    gcc-12
um                   randconfig-002-20241212    clang-20
x86_64                           allnoconfig    clang-19
x86_64     buildonly-randconfig-001-20241213    gcc-12
x86_64     buildonly-randconfig-002-20241213    gcc-12
x86_64     buildonly-randconfig-003-20241213    gcc-12
x86_64     buildonly-randconfig-004-20241213    gcc-12
x86_64     buildonly-randconfig-005-20241213    gcc-12
x86_64     buildonly-randconfig-006-20241213    clang-19
x86_64                             defconfig    gcc-11
x86_64                                 kexec    clang-19
x86_64                              rhel-9.4    gcc-12
xtensa               randconfig-001-20241212    gcc-14.2.0
xtensa               randconfig-002-20241212    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

