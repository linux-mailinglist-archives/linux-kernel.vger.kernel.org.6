Return-Path: <linux-kernel+bounces-212275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB20905D9B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 23:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9223D1F2290D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 21:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FBE986136;
	Wed, 12 Jun 2024 21:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="En9z3ZzA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F290B175A5
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 21:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718227636; cv=none; b=OV0XRCypopOZCjycQCfeX+Z5XnIF11yhg8Bpdol9D4zod3GXdewTwVAegjbw8GoJ6SO6gsO3QLuYCmGnFyX2SHqWiuE8Q26ibf9+AOKX4tFfAtI7w+d7zxYmrHoYF8o352DrL+fst1WHTJRcz7ZuiFJYmCL0JP410o0UQeXL51k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718227636; c=relaxed/simple;
	bh=S8TmWW1UZi6W/FiFxlq4RcIrmhx2US4Srex/Y6k9Lss=;
	h=Date:From:To:Cc:Subject:Message-ID; b=bsrJ8JH0vjyGk1nHKXwqMoTbeyCaOfgMJ3R3zgdpM1GTKK/JvPDKCjlU0sutz9GaN0sv5Sj/2mA4fQkX+rFqyjBUl48fZ6oLlnPdIyuFUinhQBNwDASbuZ4dSokBI8UGiGR8CqIBmj3c3OoVwAn326dBHr9f9fVOHuNg9b5zKuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=En9z3ZzA; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718227635; x=1749763635;
  h=date:from:to:cc:subject:message-id;
  bh=S8TmWW1UZi6W/FiFxlq4RcIrmhx2US4Srex/Y6k9Lss=;
  b=En9z3ZzAg6QRFwGsBTq4ERtDQpzr5lnLb1MuRB4Z0T5zcsxmj4U+GYlQ
   RdyRA3RPiXNQyrx9OosJ2iw4fl4jwDZdJBit3+0E/BTtwSVdvfV9OFAx6
   oJc4rC++vXbL97QQO6pTnYN/Yx/PCMAPfpYmm4H9XPVWMrnjtNO+zgEgY
   zAsb0o4eb+Br7u8EbhhuaSedM5LKPeEM06wHGsH9a/hZoTaujeTblsyJu
   Om17GRBpNFUQ97obIKWYJM6smiMDeiFTjdbQiCmnOssJaM9Mu+vVGBglS
   ma3anUAV7aJU//eCm/qWnvcM1XpmZskD2s1g/337mzk5QKHNxFaQgUbFu
   A==;
X-CSE-ConnectionGUID: dO4TL4plSCyoa2IX7tABtA==
X-CSE-MsgGUID: 6P49bHsBTG+fbELPeUYXoA==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="18797948"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="18797948"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 14:27:15 -0700
X-CSE-ConnectionGUID: ilocWHP+SVOxkWXLxbsORw==
X-CSE-MsgGUID: Jh1ztmeIR128HvuDYxKjMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="44461121"
Received: from lkp-server01.sh.intel.com (HELO 628d7d8b9fc6) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 12 Jun 2024 14:27:14 -0700
Received: from kbuild by 628d7d8b9fc6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sHVUt-0001vz-2A;
	Wed, 12 Jun 2024 21:27:11 +0000
Date: Thu, 13 Jun 2024 05:26:31 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:WIP.x86/fpu] BUILD SUCCESS
 c3418375f1dff3389b51905ee04fd36bd5234ab2
Message-ID: <202406130529.Qnow1spw-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git WIP.x86/fpu
branch HEAD: c3418375f1dff3389b51905ee04fd36bd5234ab2  x86/fpu: Fix stale comment in ex_handler_fprestore()

elapsed time: 2162m

configs tested: 73
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                            allyesconfig   gcc-13.2.0
alpha                               defconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arm                               allnoconfig   clang-19
arm                                 defconfig   clang-14
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
hexagon                          allmodconfig   clang-19
hexagon                           allnoconfig   clang-19
hexagon                          allyesconfig   clang-19
hexagon                             defconfig   clang-19
i386                              allnoconfig   gcc-13
loongarch                        allmodconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
m68k                             allmodconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-13.2.0
m68k                                defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-13.2.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                             allyesconfig   gcc-13.2.0
nios2                            allmodconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                            allyesconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                         allyesconfig   gcc-13.2.0
openrisc                            defconfig   gcc-13.2.0
parisc                           allmodconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                           allyesconfig   gcc-13.2.0
parisc                              defconfig   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc                          allyesconfig   clang-19
riscv                            allmodconfig   clang-19
riscv                             allnoconfig   gcc-13.2.0
riscv                            allyesconfig   clang-19
riscv                               defconfig   clang-19
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                             allyesconfig   gcc-13.2.0
s390                                defconfig   clang-19
sh                               allmodconfig   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                               allyesconfig   gcc-13.2.0
sh                                  defconfig   gcc-13.2.0
sparc                            allmodconfig   gcc-13.2.0
sparc                             allnoconfig   gcc-13.2.0
sparc                               defconfig   gcc-13.2.0
sparc64                          allmodconfig   gcc-13.2.0
sparc64                          allyesconfig   gcc-13.2.0
sparc64                             defconfig   gcc-13.2.0
um                               allmodconfig   clang-19
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-13
um                                  defconfig   clang-19
um                             i386_defconfig   gcc-13
um                           x86_64_defconfig   clang-15
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64                              defconfig   gcc-13
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

