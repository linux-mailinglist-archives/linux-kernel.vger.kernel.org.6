Return-Path: <linux-kernel+bounces-440974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 610189EC75A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 09:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 619F6164023
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 08:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB211C4A1B;
	Wed, 11 Dec 2024 08:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I5qzaJmG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8533A2451EB
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 08:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733905886; cv=none; b=M41U6ah1zeQY/NygeOmP/4JxdXQ26e+5iFpxhmuLZlqsv4NKCEfnRVosR0k/3WyaNCAmR9r/OMCLN5zWk/Ha2IXi5lj15PZG+njXe38ydrOnkWMe8T5NI+VR9qwJ87M0PJ5/+Ze8WcqDWkQXoQoFjCJuoBfjxHHMQleyIFe7qBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733905886; c=relaxed/simple;
	bh=oCQUGfdcJyRGpaPeg9Xbl4BN6a85gzkbh0KBStG26pw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Pe85CgHueE7cL9Hey3SBPFwPcSNdsCorqhoi4B7gMVUSu/AKDBUthBfqY72ZlvNCyWnEPNh7QZzORPtb4QgNPPflD00XNhi30dtFJqoKuOopkheJTZaVDpPhvwWSx4RegNHVTtMxWwQNonsHgAWT5FIoLLw7Zz9glZmsytMLK9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I5qzaJmG; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733905884; x=1765441884;
  h=date:from:to:cc:subject:message-id;
  bh=oCQUGfdcJyRGpaPeg9Xbl4BN6a85gzkbh0KBStG26pw=;
  b=I5qzaJmGx7aCfDWIFQcizKRQnDoHEqZyLeFDLgpXFaCqbDM3Dvr+bY7T
   wh+f3UAFY3vOrbGBJ9q2xPnBgAjbWnxg/JsHRmtjgG2XHQQGrxqnP2h2n
   I1Y1F1gtVyYh/xLs9cioZ+CDDpv1UShKGVCsHQWk5noxmtLAUgG417gu+
   JDwnfb7IZpk4clK0/a/2toOYXLJ+rkMSX5z6NCiC1dSr8e508U47wuJ4C
   h1yL8+08xWTrwMYTJHWmZl0fL4+Onf0UOihPZgaffhiFU0r1N7CtZ1hV2
   8wPwIv9Q20dmP9RfAJI6Ss3p3IW5AVwEhCQdrjCx/30hR5Y0HgKvj6Dv9
   A==;
X-CSE-ConnectionGUID: xeB4U8HvSuOftxPEi6Y7/A==
X-CSE-MsgGUID: YSHK/IPrSdGiXsJBVJoDmA==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="34153198"
X-IronPort-AV: E=Sophos;i="6.12,225,1728975600"; 
   d="scan'208";a="34153198"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 00:31:24 -0800
X-CSE-ConnectionGUID: xI8bLdXqRbix1lSjA4p9lA==
X-CSE-MsgGUID: 94tKWQJRQNWjA7M9L/838g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="133102150"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 11 Dec 2024 00:31:23 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tLI7s-0006RV-1E;
	Wed, 11 Dec 2024 08:31:20 +0000
Date: Wed, 11 Dec 2024 16:30:51 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/cpu] BUILD SUCCESS
 4bf610499c429fa0bfb3fa94be450f01016224c5
Message-ID: <202412111642.wcSh5M4f-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cpu
branch HEAD: 4bf610499c429fa0bfb3fa94be450f01016224c5  x86/cpufeature: Document cpu_feature_enabled() as the default to use

elapsed time: 906m

configs tested: 138
configs skipped: 135

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
arc                              allmodconfig    clang-18
arc                              allyesconfig    clang-18
arc                   randconfig-001-20241211    gcc-14.2.0
arc                   randconfig-002-20241211    gcc-14.2.0
arm                              allmodconfig    clang-18
arm                              allyesconfig    clang-18
arm                   randconfig-001-20241211    gcc-14.2.0
arm                   randconfig-002-20241211    gcc-14.2.0
arm                   randconfig-003-20241211    gcc-14.2.0
arm                   randconfig-004-20241211    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                 randconfig-001-20241211    gcc-14.2.0
arm64                 randconfig-002-20241211    gcc-14.2.0
arm64                 randconfig-003-20241211    gcc-14.2.0
arm64                 randconfig-004-20241211    gcc-14.2.0
csky                  randconfig-001-20241211    gcc-14.2.0
csky                  randconfig-002-20241211    gcc-14.2.0
hexagon               randconfig-001-20241211    gcc-14.2.0
hexagon               randconfig-002-20241211    gcc-14.2.0
i386                             allmodconfig    clang-19
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-19
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-19
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241211    clang-19
i386        buildonly-randconfig-002-20241211    clang-19
i386        buildonly-randconfig-002-20241211    gcc-11
i386        buildonly-randconfig-003-20241211    clang-19
i386        buildonly-randconfig-004-20241211    clang-19
i386        buildonly-randconfig-004-20241211    gcc-11
i386        buildonly-randconfig-005-20241211    clang-19
i386        buildonly-randconfig-005-20241211    gcc-12
i386        buildonly-randconfig-006-20241211    clang-19
i386                                defconfig    clang-19
i386                  randconfig-001-20241211    gcc-12
i386                  randconfig-002-20241211    gcc-12
i386                  randconfig-003-20241211    gcc-12
i386                  randconfig-004-20241211    gcc-12
i386                  randconfig-005-20241211    gcc-12
i386                  randconfig-006-20241211    gcc-12
i386                  randconfig-007-20241211    gcc-12
i386                  randconfig-011-20241211    gcc-12
i386                  randconfig-012-20241211    gcc-12
i386                  randconfig-013-20241211    gcc-12
i386                  randconfig-014-20241211    gcc-12
i386                  randconfig-015-20241211    gcc-12
i386                  randconfig-016-20241211    gcc-12
i386                  randconfig-017-20241211    gcc-12
loongarch                        allmodconfig    gcc-14.2.0
loongarch             randconfig-001-20241211    gcc-14.2.0
loongarch             randconfig-002-20241211    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                          hp300_defconfig    gcc-14.2.0
m68k                        m5272c3_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                         bigsur_defconfig    gcc-14.2.0
mips                        omega2p_defconfig    gcc-14.2.0
nios2                 randconfig-001-20241211    gcc-14.2.0
nios2                 randconfig-002-20241211    gcc-14.2.0
openrisc                          allnoconfig    clang-20
openrisc                            defconfig    gcc-12
parisc                            allnoconfig    clang-20
parisc                              defconfig    gcc-12
parisc                randconfig-001-20241211    gcc-14.2.0
parisc                randconfig-002-20241211    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                    amigaone_defconfig    gcc-14.2.0
powerpc                    mvme5100_defconfig    gcc-14.2.0
powerpc               randconfig-001-20241211    gcc-14.2.0
powerpc               randconfig-002-20241211    gcc-14.2.0
powerpc               randconfig-003-20241211    gcc-14.2.0
powerpc64             randconfig-001-20241211    gcc-14.2.0
powerpc64             randconfig-002-20241211    gcc-14.2.0
powerpc64             randconfig-003-20241211    gcc-14.2.0
riscv                             allnoconfig    clang-20
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20241211    clang-20
riscv                 randconfig-002-20241211    clang-20
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20241211    clang-20
s390                  randconfig-002-20241211    clang-20
sh                               allmodconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20241211    clang-20
sh                    randconfig-002-20241211    clang-20
sparc                            alldefconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                 randconfig-001-20241211    clang-20
sparc                 randconfig-002-20241211    clang-20
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20241211    clang-20
sparc64               randconfig-002-20241211    clang-20
um                                allnoconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241211    clang-20
um                    randconfig-002-20241211    clang-20
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241211    gcc-12
x86_64      buildonly-randconfig-002-20241211    gcc-11
x86_64      buildonly-randconfig-002-20241211    gcc-12
x86_64      buildonly-randconfig-003-20241211    gcc-12
x86_64      buildonly-randconfig-004-20241211    gcc-12
x86_64      buildonly-randconfig-005-20241211    gcc-12
x86_64      buildonly-randconfig-006-20241211    clang-19
x86_64      buildonly-randconfig-006-20241211    gcc-12
x86_64                              defconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20241211    clang-19
x86_64                randconfig-002-20241211    clang-19
x86_64                randconfig-003-20241211    clang-19
x86_64                randconfig-004-20241211    clang-19
x86_64                randconfig-005-20241211    clang-19
x86_64                randconfig-006-20241211    clang-19
x86_64                randconfig-007-20241211    clang-19
x86_64                randconfig-008-20241211    clang-19
x86_64                randconfig-071-20241211    clang-19
x86_64                randconfig-072-20241211    clang-19
x86_64                randconfig-073-20241211    clang-19
x86_64                randconfig-074-20241211    clang-19
x86_64                randconfig-075-20241211    clang-19
x86_64                randconfig-076-20241211    clang-19
x86_64                randconfig-077-20241211    clang-19
x86_64                randconfig-078-20241211    clang-19
x86_64                               rhel-9.4    clang-19
xtensa                randconfig-001-20241211    clang-20
xtensa                randconfig-002-20241211    clang-20
xtensa                         virt_defconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

