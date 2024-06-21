Return-Path: <linux-kernel+bounces-225204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD95912D8E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 20:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09C731F24D91
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 18:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779BB17B423;
	Fri, 21 Jun 2024 18:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WXPQ0n0C"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F758C1E
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 18:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718996006; cv=none; b=uFJe4h7alWIhEhCS1Ztfkg38Pc6lHvPjw/7OJKmYzdxoqvSFCMBXCNm6NfVmgXkpK+c1N4TSMBlr197109XPLcBAs4k+uJvcvppU5nCUgvYBC4SZg1y6OPxddOQTjR3N49KXpPiqqWIV07JD7ixhN3ZYBmBHO1VIVemHyrwTwew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718996006; c=relaxed/simple;
	bh=dECGrhLa+sA8i7PbZJNOksBc4B7KR5A7aNDGwBvTNiQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=l0OMT8/L4rRQuOl+u7ZdE4fcSpCumaZCGpypsPOAxFMDZEjXHmQ7fM6iCiUQ29pRd4QbGs1xk3Yi5//Bo1TOauKA15G7EqZ7Y34V/bp7RRZnBy7mSmUnWf2QSn7cCdQbN+uzYpbxHSpI5w9vD88wOs/VDAYNDkP4bgtxcSbhHL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WXPQ0n0C; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718996005; x=1750532005;
  h=date:from:to:cc:subject:message-id;
  bh=dECGrhLa+sA8i7PbZJNOksBc4B7KR5A7aNDGwBvTNiQ=;
  b=WXPQ0n0CZGPIo78Tcm4eCVwMDVr0hNFxd7cXizzmNZpg/ARNEOoHyzTm
   AtTU7QTxGx56utGLhsyWxf6gU6qY4p52DaE30TYNifAta8pI/wL7aSLxa
   EKPHz93mnHrgNeZdpjK5r4QztM3iUmbXDwaeITZ33wrTIdS9le9wxiMqw
   x/U9D7+RlNIGJrnpePFIlPR6ez4EXgWr4hvL730p51P9o9iItOgCHitEi
   GedyGPzqkMZ7OyRg1DlTkJssbbWMYnyEZ1RexxJZqIsqufYv76Kujd18H
   9AGLiq50yzvsjm68fzjlYzFTIVrJhd0Qfiu2wTt8aKz0bPM2gMoyvlL4p
   Q==;
X-CSE-ConnectionGUID: 5KUJ34LPSP+AVDuGponzAQ==
X-CSE-MsgGUID: pS7wNM3LSlWOR0wAaX3y/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11110"; a="16276181"
X-IronPort-AV: E=Sophos;i="6.08,255,1712646000"; 
   d="scan'208";a="16276181"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2024 11:53:19 -0700
X-CSE-ConnectionGUID: ODh1HSDGT1KZ7vu0NIciUA==
X-CSE-MsgGUID: eGrFwo4fRgG8Pdir84xoEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,255,1712646000"; 
   d="scan'208";a="42581634"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 21 Jun 2024 11:53:18 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sKjNr-0008ti-0k;
	Fri, 21 Jun 2024 18:53:15 +0000
Date: Sat, 22 Jun 2024 02:52:58 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/cc] BUILD SUCCESS
 16df35946120fca2346c415fae429c821391eef8
Message-ID: <202406220255.Ix7co0ln-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cc
branch HEAD: 16df35946120fca2346c415fae429c821391eef8  ACPI: tables: Print MULTIPROC_WAKEUP when MADT is parsed

elapsed time: 4616m

configs tested: 121
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                               defconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240620   gcc-13.2.0
arc                   randconfig-002-20240620   gcc-13.2.0
arm                               allnoconfig   clang-19
arm                                 defconfig   clang-14
arm                   randconfig-001-20240620   gcc-13.2.0
arm                   randconfig-002-20240620   clang-19
arm                   randconfig-003-20240620   gcc-13.2.0
arm                   randconfig-004-20240620   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240620   gcc-13.2.0
arm64                 randconfig-002-20240620   gcc-13.2.0
arm64                 randconfig-003-20240620   gcc-13.2.0
arm64                 randconfig-004-20240620   clang-19
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240620   gcc-13.2.0
csky                  randconfig-002-20240620   gcc-13.2.0
hexagon                           allnoconfig   clang-19
hexagon                             defconfig   clang-19
hexagon               randconfig-001-20240620   clang-19
hexagon               randconfig-002-20240620   clang-19
i386         buildonly-randconfig-001-20240619   clang-18
i386         buildonly-randconfig-002-20240619   clang-18
i386         buildonly-randconfig-003-20240619   clang-18
i386         buildonly-randconfig-004-20240619   clang-18
i386         buildonly-randconfig-005-20240619   gcc-7
i386         buildonly-randconfig-006-20240619   gcc-7
i386                  randconfig-001-20240619   gcc-7
i386                  randconfig-002-20240619   gcc-7
i386                  randconfig-003-20240619   clang-18
i386                  randconfig-004-20240619   gcc-7
i386                  randconfig-005-20240619   clang-18
i386                  randconfig-006-20240619   gcc-9
i386                  randconfig-011-20240619   clang-18
i386                  randconfig-012-20240619   clang-18
i386                  randconfig-013-20240619   gcc-13
i386                  randconfig-014-20240619   clang-18
i386                  randconfig-015-20240619   clang-18
i386                  randconfig-016-20240619   gcc-13
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240620   gcc-13.2.0
loongarch             randconfig-002-20240620   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
m68k                                defconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240620   gcc-13.2.0
nios2                 randconfig-002-20240620   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                            defconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                              defconfig   gcc-13.2.0
parisc                randconfig-001-20240620   gcc-13.2.0
parisc                randconfig-002-20240620   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc               randconfig-001-20240620   gcc-13.2.0
powerpc               randconfig-002-20240620   gcc-13.2.0
powerpc               randconfig-003-20240620   clang-17
powerpc64             randconfig-001-20240620   gcc-13.2.0
powerpc64             randconfig-002-20240620   gcc-13.2.0
powerpc64             randconfig-003-20240620   clang-17
riscv                             allnoconfig   gcc-13.2.0
riscv                               defconfig   clang-19
riscv                 randconfig-001-20240620   clang-19
riscv                 randconfig-002-20240620   clang-14
s390                              allnoconfig   clang-19
s390                                defconfig   clang-19
s390                  randconfig-001-20240620   gcc-13.2.0
s390                  randconfig-002-20240620   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                                  defconfig   gcc-13.2.0
sh                    randconfig-001-20240620   gcc-13.2.0
sh                    randconfig-002-20240620   gcc-13.2.0
sparc                             allnoconfig   gcc-13.2.0
sparc                               defconfig   gcc-13.2.0
sparc64                             defconfig   gcc-13.2.0
sparc64               randconfig-001-20240620   gcc-13.2.0
sparc64               randconfig-002-20240620   gcc-13.2.0
um                                allnoconfig   clang-17
um                                  defconfig   clang-19
um                             i386_defconfig   gcc-13
um                    randconfig-001-20240620   clang-19
um                    randconfig-002-20240620   gcc-13
um                           x86_64_defconfig   clang-15
x86_64       buildonly-randconfig-001-20240619   clang-18
x86_64       buildonly-randconfig-002-20240619   clang-18
x86_64       buildonly-randconfig-003-20240619   gcc-11
x86_64       buildonly-randconfig-004-20240619   clang-18
x86_64       buildonly-randconfig-005-20240619   clang-18
x86_64       buildonly-randconfig-006-20240619   gcc-13
x86_64                randconfig-001-20240619   gcc-13
x86_64                randconfig-002-20240619   clang-18
x86_64                randconfig-003-20240619   gcc-8
x86_64                randconfig-004-20240619   clang-18
x86_64                randconfig-005-20240619   clang-18
x86_64                randconfig-006-20240619   gcc-13
x86_64                randconfig-011-20240619   gcc-13
x86_64                randconfig-012-20240619   gcc-13
x86_64                randconfig-013-20240619   gcc-13
x86_64                randconfig-014-20240619   clang-18
x86_64                randconfig-015-20240619   clang-18
x86_64                randconfig-016-20240619   gcc-11
x86_64                randconfig-071-20240619   clang-18
x86_64                randconfig-072-20240619   clang-18
x86_64                randconfig-073-20240619   gcc-9
x86_64                randconfig-074-20240619   gcc-9
x86_64                randconfig-075-20240619   clang-18
x86_64                randconfig-076-20240619   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                randconfig-001-20240620   gcc-13.2.0
xtensa                randconfig-002-20240620   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

