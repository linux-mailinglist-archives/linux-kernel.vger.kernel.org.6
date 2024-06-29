Return-Path: <linux-kernel+bounces-234992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5198191CE0B
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 17:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68D091C210F7
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 15:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B1385285;
	Sat, 29 Jun 2024 15:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sf6jj6Ii"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C955E4C99
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 15:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719676609; cv=none; b=U6vMUyHdVMM6tAajzp1nL5xsEo8nuUZqCXdqoJAYpP4IbbVAd0w3GV5OaqAh+jPVyFotd9qcMMQTJgwViGdULM8766Q86l+zijRvxl7akgTDZ7vbcYUupL1AWsk9y4ujoMDu7q4fnXYdI7Ba/J4DVFC/v6vIKc2xR0e7TEPkqaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719676609; c=relaxed/simple;
	bh=duVsCAV6a7856zLSoIZXU1stWtbIdnWVFiFmUoVHg70=;
	h=Date:From:To:Cc:Subject:Message-ID; b=o7EVc3B1FOwt2JucRwBb0m3XbVTIjppSOQwvecX0aczTP44kmlHSwleOdm+xPA0N7EVYMXbpXd72kuQZfrH/6eZ2A8hxOS4+HRFkW+PaWh2I9OU0AGC6WeqIc8GnnEqwKFW1uY2L8eaqqcvpzmoO4znxl+9UDwEk/CanKfoPeQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sf6jj6Ii; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719676608; x=1751212608;
  h=date:from:to:cc:subject:message-id;
  bh=duVsCAV6a7856zLSoIZXU1stWtbIdnWVFiFmUoVHg70=;
  b=Sf6jj6Iitgcp28oyd8ALb+lWZrbpc6m6dEnuxpld9r/eEBIWTpqNzjMK
   Oitk0hmItkcczohhvVaOOSQgRnPZUuZLEGfBQJbR7tPOYlbgJZTUJ/kjy
   9U6Ry1MyToW04nB6TAUc4XeQOzqJy4VO8M+FO6lIvlsQKlRvMDA5lkDmg
   YutRO2enp20HXXCxve7PI8BVD5LnT8ZjLgp4oYVCcK3amMw7Q4c/GHrez
   wNSAh66fuRMJ81qO+x30wQ0/K+72FDi7Pai9qV99rtKJS3sO8LjFerpmi
   VWKNgqFj7zQMDzoA9W8kE7HoYQnrqA+5BrZS1ufGEhWallnAr9fszynkS
   w==;
X-CSE-ConnectionGUID: QV6cHbAZQLKY4udoUy4KoQ==
X-CSE-MsgGUID: wcVvyfvdTLyrduaXDKTpdg==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="16580992"
X-IronPort-AV: E=Sophos;i="6.09,172,1716274800"; 
   d="scan'208";a="16580992"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2024 08:56:47 -0700
X-CSE-ConnectionGUID: ZSq1Y7duRgGCg8qOdvixyQ==
X-CSE-MsgGUID: AzbIq267RvCaxVULNdExgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,172,1716274800"; 
   d="scan'208";a="45778876"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 29 Jun 2024 08:56:46 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sNaRP-000JYk-0Y;
	Sat, 29 Jun 2024 15:56:43 +0000
Date: Sat, 29 Jun 2024 23:55:52 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/WFAMNAE-next20240621-CbC] BUILD SUCCESS
 9334c4d5e22a8aa6c4c4550fa27c5a424ed06f26
Message-ID: <202406292350.NY326PEK-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/WFAMNAE-next20240621-CbC
branch HEAD: 9334c4d5e22a8aa6c4c4550fa27c5a424ed06f26  scsi: fc: Avoid -Wflex-array-member-not-at-end warnings

elapsed time: 5580m

configs tested: 87
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                               defconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240628   gcc-13.2.0
arc                   randconfig-002-20240628   gcc-13.2.0
arm                       aspeed_g4_defconfig   clang-19
arm                                 defconfig   clang-14
arm                             pxa_defconfig   gcc-13.2.0
arm                   randconfig-001-20240628   gcc-13.2.0
arm                   randconfig-002-20240628   gcc-13.2.0
arm                   randconfig-003-20240628   gcc-13.2.0
arm                   randconfig-004-20240628   clang-19
arm                         s3c6400_defconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240628   gcc-13.2.0
arm64                 randconfig-002-20240628   gcc-13.2.0
arm64                 randconfig-003-20240628   clang-19
arm64                 randconfig-004-20240628   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240628   gcc-13.2.0
csky                  randconfig-002-20240628   gcc-13.2.0
hexagon                             defconfig   clang-19
hexagon               randconfig-001-20240628   clang-19
hexagon               randconfig-002-20240628   clang-19
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240628   gcc-13.2.0
loongarch             randconfig-002-20240628   gcc-13.2.0
m68k                                defconfig   gcc-13.2.0
microblaze                          defconfig   gcc-13.2.0
mips                     decstation_defconfig   gcc-13.2.0
mips                           ip32_defconfig   clang-19
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240628   gcc-13.2.0
nios2                 randconfig-002-20240628   gcc-13.2.0
openrisc                            defconfig   gcc-13.2.0
parisc                              defconfig   gcc-13.2.0
parisc                randconfig-001-20240628   gcc-13.2.0
parisc                randconfig-002-20240628   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc               randconfig-001-20240628   gcc-13.2.0
powerpc               randconfig-002-20240628   gcc-13.2.0
powerpc               randconfig-003-20240628   gcc-13.2.0
powerpc64             randconfig-001-20240628   gcc-13.2.0
powerpc64             randconfig-002-20240628   gcc-13.2.0
powerpc64             randconfig-003-20240628   clang-19
riscv                               defconfig   clang-19
riscv                 randconfig-001-20240628   gcc-13.2.0
riscv                 randconfig-002-20240628   gcc-13.2.0
s390                                defconfig   clang-19
s390                  randconfig-001-20240628   clang-19
s390                  randconfig-002-20240628   clang-19
sh                                  defconfig   gcc-13.2.0
sh                    randconfig-001-20240628   gcc-13.2.0
sh                    randconfig-002-20240628   gcc-13.2.0
sparc64                             defconfig   gcc-13.2.0
sparc64               randconfig-001-20240628   gcc-13.2.0
sparc64               randconfig-002-20240628   gcc-13.2.0
um                                  defconfig   clang-19
um                             i386_defconfig   gcc-13
um                    randconfig-001-20240628   gcc-13
um                    randconfig-002-20240628   clang-19
um                           x86_64_defconfig   clang-15
x86_64       buildonly-randconfig-001-20240627   clang-18
x86_64       buildonly-randconfig-002-20240627   clang-18
x86_64       buildonly-randconfig-003-20240627   clang-18
x86_64       buildonly-randconfig-004-20240627   gcc-13
x86_64       buildonly-randconfig-005-20240627   gcc-13
x86_64       buildonly-randconfig-006-20240627   clang-18
x86_64                randconfig-001-20240627   clang-18
x86_64                randconfig-002-20240627   gcc-13
x86_64                randconfig-003-20240627   clang-18
x86_64                randconfig-004-20240627   clang-18
x86_64                randconfig-005-20240627   gcc-13
x86_64                randconfig-006-20240627   clang-18
x86_64                randconfig-011-20240627   clang-18
x86_64                randconfig-012-20240627   clang-18
x86_64                randconfig-013-20240627   gcc-13
x86_64                randconfig-014-20240627   clang-18
x86_64                randconfig-015-20240627   gcc-13
x86_64                randconfig-016-20240627   clang-18
x86_64                randconfig-071-20240627   clang-18
x86_64                randconfig-072-20240627   gcc-13
x86_64                randconfig-073-20240627   clang-18
x86_64                randconfig-074-20240627   gcc-13
x86_64                randconfig-075-20240627   gcc-13
x86_64                randconfig-076-20240627   clang-18
xtensa                randconfig-001-20240628   gcc-13.2.0
xtensa                randconfig-002-20240628   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

