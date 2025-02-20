Return-Path: <linux-kernel+bounces-523606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C49A3D91A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 12:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E20A3A85A6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 11:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE961F3D2C;
	Thu, 20 Feb 2025 11:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kdWxwYT4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B67C1F3D20
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 11:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740051892; cv=none; b=uXK06/UJjWRXP9JWCHulCiH/D42XEkBi8KnY0Hdvi2Q0GqbdsYOb1ts/57/HErjBQ9ZX9Tr0fAtGj35sgXb329qgaSNVlKvk2LvoTxnrsOCpjnSaNCTvUkVfvpfE3UCYuqCls6vYB30hjdbMOHBJGU9qzOfifOtLbVEYuFrmbxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740051892; c=relaxed/simple;
	bh=j7oUgAr194ldPjOe7CnpcilB7J+0su/COvJrMzapXUE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Zw//uMWNCsNGBIUooO0MuVHnJnni0lHtCm2Fge8s8yMcNqN0FHqpFoP1LUhWxy1F78CBxEAwp3+JWUaBsqrALSoiKqoZqJMVPOk2TOvngDFFPsKb2wU7CM6bJ+cgRO1iefZ26OReW0vcABjrIoojjw74kBelfQvhZFu3fO92hCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kdWxwYT4; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740051891; x=1771587891;
  h=date:from:to:cc:subject:message-id;
  bh=j7oUgAr194ldPjOe7CnpcilB7J+0su/COvJrMzapXUE=;
  b=kdWxwYT4T4XrmFYcEoxLwEt5hmZ0GNqfxQ1t5VScCVhrogcub8ec0LyV
   X4EQVY5/65UCWi73axylxbXyTrODAkgVZZoIGrRW7Ho2AxqJkTMCKyxU+
   LfqElEzSCX/1tKqO1B5Qqs+fndyDRmFLuZg6A2BE5qkNS4FX1ZfSEaLK+
   WGLZx0VbUmFO6n0+KjXPn4wUiDTQWFBVGFxOwOkdkoPtUS8N5O85Mc4bP
   YIB5Q0tyItDGt4G8raSOS1rCu3WYOR6wWrH3Mn2MCblbdCqzi6kBySnJ1
   uO+Aq6YXTVlPunpBZ38THEUedvRmCiq2z6FCIL2e/Py6LTMoU+7PAI74C
   Q==;
X-CSE-ConnectionGUID: VbGS7jzRSn2Q57PM94Rulg==
X-CSE-MsgGUID: VytfAg0WTD+GIE6uqHH+jA==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="58369473"
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; 
   d="scan'208";a="58369473"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 03:44:50 -0800
X-CSE-ConnectionGUID: MSHQE5bwSd+Rbl8Q3KXjnQ==
X-CSE-MsgGUID: VCGSP9mmSrmtgI1fUURQsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="152216294"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 20 Feb 2025 03:44:48 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tl4yz-0004Eh-2H;
	Thu, 20 Feb 2025 11:44:45 +0000
Date: Thu, 20 Feb 2025 19:43:54 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/wfamnae-next20250210-2] BUILD SUCCESS
 987bc66d587f719478850fce6270d713a37747d1
Message-ID: <202502201949.Y0hBKoBt-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/wfamnae-next20250210-2
branch HEAD: 987bc66d587f719478850fce6270d713a37747d1  bcache: Avoid -Wflex-array-member-not-at-end warnings

elapsed time: 1451m

configs tested: 103
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250219    gcc-13.2.0
arc                   randconfig-002-20250219    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                   randconfig-001-20250219    gcc-14.2.0
arm                   randconfig-002-20250219    clang-17
arm                   randconfig-003-20250219    clang-15
arm                   randconfig-004-20250219    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250219    clang-21
arm64                 randconfig-002-20250219    gcc-14.2.0
arm64                 randconfig-003-20250219    gcc-14.2.0
arm64                 randconfig-004-20250219    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250219    gcc-14.2.0
csky                  randconfig-002-20250219    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250219    clang-14
hexagon               randconfig-002-20250219    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250219    clang-19
i386        buildonly-randconfig-002-20250219    clang-19
i386        buildonly-randconfig-003-20250219    gcc-12
i386        buildonly-randconfig-004-20250219    clang-19
i386        buildonly-randconfig-005-20250219    clang-19
i386        buildonly-randconfig-006-20250219    gcc-12
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250219    gcc-14.2.0
loongarch             randconfig-002-20250219    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250219    gcc-14.2.0
nios2                 randconfig-002-20250219    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250219    gcc-14.2.0
parisc                randconfig-002-20250219    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc               randconfig-001-20250219    clang-15
powerpc               randconfig-002-20250219    clang-17
powerpc               randconfig-003-20250219    gcc-14.2.0
powerpc64             randconfig-001-20250219    gcc-14.2.0
powerpc64             randconfig-002-20250219    gcc-14.2.0
powerpc64             randconfig-003-20250219    gcc-14.2.0
riscv                             allnoconfig    gcc-14.2.0
riscv                 randconfig-001-20250219    clang-21
riscv                 randconfig-002-20250219    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250219    clang-18
s390                  randconfig-002-20250219    clang-21
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250219    gcc-14.2.0
sh                    randconfig-002-20250219    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250219    gcc-14.2.0
sparc                 randconfig-002-20250219    gcc-14.2.0
sparc64               randconfig-001-20250219    gcc-14.2.0
sparc64               randconfig-002-20250219    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                    randconfig-001-20250219    clang-21
um                    randconfig-002-20250219    clang-21
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250219    gcc-12
x86_64      buildonly-randconfig-002-20250219    clang-19
x86_64      buildonly-randconfig-003-20250219    gcc-12
x86_64      buildonly-randconfig-004-20250219    clang-19
x86_64      buildonly-randconfig-005-20250219    gcc-12
x86_64      buildonly-randconfig-006-20250219    clang-19
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250219    gcc-14.2.0
xtensa                randconfig-002-20250219    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

