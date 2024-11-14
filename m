Return-Path: <linux-kernel+bounces-408683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D84D39C8246
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 06:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B032283449
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 05:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A291E7C16;
	Thu, 14 Nov 2024 05:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P4OZD4+6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26074137932
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 05:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731560452; cv=none; b=kpHzqrrtoPdoHQtQlOckogUl7ohxWG0NDJFGbk8RnPHNREp9vs6Qg9TRzeEKT14wjVt+vFBM/V+OLlTu01Oj38M6pq9RM4yE7PjDJ8xYet9FmC2894MewC/NjIHnL5zVmrxZNq5Ii7VdFg02XXLIb2S6g6ZElSdUz6RUd7ZWJv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731560452; c=relaxed/simple;
	bh=mfOtjGr2s/azK+Iv/LVOoRXjhB7ygtNEeOSfJUVLRws=;
	h=Date:From:To:Cc:Subject:Message-ID; b=cRM1Wu2Lwp3pBBGdsTfzFMqSVPFBVVAFbXTnZXWEh0kCV2MxkAw5fpoAQf+Vb9+ZOJAMGyBANuHY653IGDbqgaj547Tvq75wxqTohmv43DKqT7gve1auq8qhqosYXU7TufYGsuvQLqko9R0nJcClYo/F9S2Qa8Ujx95uJjm7+tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P4OZD4+6; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731560450; x=1763096450;
  h=date:from:to:cc:subject:message-id;
  bh=mfOtjGr2s/azK+Iv/LVOoRXjhB7ygtNEeOSfJUVLRws=;
  b=P4OZD4+6tEP9rbpshKll7A18nVqx43rvM3USr6ipNycHnZxRojcLrZSz
   gSaw4WjSsya4u+S56OcHUm9Af1rRCH6XqUTAmF+EgK3ECT5l8VBTVu6i6
   QULP9r0sFq3Z5XDYunzWfW2os6P8YdxOJXnXzvu0lQ0IgVn4c9wiecSq5
   nGngzr0asg/uT8OgRhXrcZeA4208FNOjveumgt8c3X4SQ03SOb7q1lncL
   NwX30KruzmVM6KtjimrC2e0nR0emsjlHQrQRbdQHqfcnr6nOIwBQyzAow
   jq2YS36jfS4EWrF4aluGTGEiSW5bT15vs+bayMOeALtJKz5bDVIaD7GTP
   w==;
X-CSE-ConnectionGUID: zRV5ACn/T9qu6IbzJAjRKg==
X-CSE-MsgGUID: 37VsF3s9TYqorapv3yd5ZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11255"; a="48987011"
X-IronPort-AV: E=Sophos;i="6.12,153,1728975600"; 
   d="scan'208";a="48987011"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 21:00:49 -0800
X-CSE-ConnectionGUID: eTeSt1pdSfabU9Ir6VQqjA==
X-CSE-MsgGUID: wktN/8QRQaS/KZ1m5e35zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,153,1728975600"; 
   d="scan'208";a="88067600"
Received: from lkp-server01.sh.intel.com (HELO b014a344d658) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 13 Nov 2024 21:00:48 -0800
Received: from kbuild by b014a344d658 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tBRyI-00008r-0e;
	Thu, 14 Nov 2024 05:00:46 +0000
Date: Thu, 14 Nov 2024 13:00:00 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:irq/core] BUILD SUCCESS
 f9ed1f7c2e26fcd19781774e310a6236d7525c11
Message-ID: <202411141251.9lNhBzrW-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
branch HEAD: f9ed1f7c2e26fcd19781774e310a6236d7525c11  genirq/proc: Use seq_put_decimal_ull_width() for decimal values

elapsed time: 733m

configs tested: 95
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                allnoconfig    gcc-14.2.0
alpha               allyesconfig    clang-20
alpha               allyesconfig    gcc-14.2.0
alpha                  defconfig    gcc-14.2.0
arc                 allmodconfig    clang-20
arc                  allnoconfig    gcc-14.2.0
arc                 allyesconfig    clang-20
arc                    defconfig    gcc-14.2.0
arc           vdk_hs38_defconfig    gcc-14.2.0
arm                 alldefconfig    gcc-14.2.0
arm                 allmodconfig    clang-20
arm                  allnoconfig    gcc-14.2.0
arm                 allyesconfig    clang-20
arm                    defconfig    gcc-14.2.0
arm               dove_defconfig    gcc-14.2.0
arm            socfpga_defconfig    gcc-14.2.0
arm64               allmodconfig    clang-20
arm64                allnoconfig    gcc-14.2.0
arm64                  defconfig    gcc-14.2.0
csky                 allnoconfig    gcc-14.2.0
csky                   defconfig    gcc-14.2.0
hexagon             allmodconfig    clang-20
hexagon              allnoconfig    gcc-14.2.0
hexagon             allyesconfig    clang-20
hexagon                defconfig    gcc-14.2.0
i386                allmodconfig    clang-19
i386                 allnoconfig    clang-19
i386                allyesconfig    clang-19
i386                   defconfig    clang-19
loongarch           allmodconfig    gcc-14.2.0
loongarch            allnoconfig    gcc-14.2.0
loongarch              defconfig    gcc-14.2.0
m68k                allmodconfig    gcc-14.2.0
m68k                 allnoconfig    gcc-14.2.0
m68k                allyesconfig    gcc-14.2.0
m68k                   defconfig    gcc-14.2.0
m68k           m5272c3_defconfig    gcc-14.2.0
m68k           m5307c3_defconfig    gcc-14.2.0
m68k               q40_defconfig    gcc-14.2.0
microblaze          allmodconfig    gcc-14.2.0
microblaze           allnoconfig    gcc-14.2.0
microblaze          allyesconfig    gcc-14.2.0
microblaze             defconfig    gcc-14.2.0
mips                 allnoconfig    gcc-14.2.0
mips         bmips_stb_defconfig    gcc-14.2.0
mips        loongson1b_defconfig    gcc-14.2.0
nios2                allnoconfig    gcc-14.2.0
nios2                  defconfig    gcc-14.2.0
openrisc             allnoconfig    clang-20
openrisc            allyesconfig    gcc-14.2.0
openrisc               defconfig    gcc-12
openrisc     or1klitex_defconfig    gcc-14.2.0
parisc              allmodconfig    gcc-14.2.0
parisc               allnoconfig    clang-20
parisc              allyesconfig    gcc-14.2.0
parisc                 defconfig    gcc-12
parisc64               defconfig    gcc-14.2.0
powerpc             allmodconfig    gcc-14.2.0
powerpc              allnoconfig    clang-20
powerpc             allyesconfig    gcc-14.2.0
powerpc           cell_defconfig    gcc-14.2.0
powerpc          ebony_defconfig    gcc-14.2.0
powerpc        mpc83xx_defconfig    gcc-14.2.0
powerpc       socrates_defconfig    gcc-14.2.0
riscv               allmodconfig    gcc-14.2.0
riscv                allnoconfig    clang-20
riscv               allyesconfig    gcc-14.2.0
riscv                  defconfig    gcc-12
s390                allmodconfig    clang-20
s390                allmodconfig    gcc-14.2.0
s390                 allnoconfig    clang-20
s390                allyesconfig    gcc-14.2.0
s390                   defconfig    gcc-12
sh                  allmodconfig    gcc-14.2.0
sh                   allnoconfig    gcc-14.2.0
sh                  allyesconfig    gcc-14.2.0
sh                     defconfig    gcc-12
sh              se7721_defconfig    gcc-14.2.0
sparc               allmodconfig    gcc-14.2.0
sparc64                defconfig    gcc-12
um                  allmodconfig    clang-20
um                   allnoconfig    clang-20
um                  allyesconfig    clang-20
um                  allyesconfig    gcc-12
um                     defconfig    gcc-12
um                i386_defconfig    gcc-12
um              x86_64_defconfig    gcc-12
x86_64               allnoconfig    clang-19
x86_64              allyesconfig    clang-19
x86_64                 defconfig    clang-19
x86_64                     kexec    clang-19
x86_64                     kexec    gcc-12
x86_64                  rhel-8.3    gcc-12
xtensa               allnoconfig    gcc-14.2.0
xtensa             iss_defconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

