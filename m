Return-Path: <linux-kernel+bounces-391979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7DAC9B8E21
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 10:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07568B224FF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 09:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FECA15958A;
	Fri,  1 Nov 2024 09:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mr2AAU0y"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9851581F0
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 09:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730454516; cv=none; b=hFk0V1G5WfTXaCOSWqto26+7XADSCwTVPZm1u0FDohyaaSOksqMMCW6wx9E9joqTRERdnMwURltwAiS6pONLwQAv96fztkMDs2TndF+/hVo78GjcLHfzoWzEoPtnED0DR2JIPMx0ThWfJRFL4jjL1hMhsUr5N1wlqK8RiBE0kLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730454516; c=relaxed/simple;
	bh=ZfNOc6OFYx/IhVIlaGDNb8gAlZcyLkTpkFmqvGjzA9Y=;
	h=Date:From:To:Cc:Subject:Message-ID; b=oxfE3TLf8gFjTxpeEs2V+sh6M/a938P59uGEFVHZcmrGS50mXZe+YzXXHoroYb72TD+8xPoHdWZLiBfkePiCoOzyHvgU6Lg1fMt4XxbQqqcvpVlSzauwR1RwDFKh5tXFC/eQZH19D4pM9jUGHM3t0/3BKP5hY19lomg4T02hZg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mr2AAU0y; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730454514; x=1761990514;
  h=date:from:to:cc:subject:message-id;
  bh=ZfNOc6OFYx/IhVIlaGDNb8gAlZcyLkTpkFmqvGjzA9Y=;
  b=mr2AAU0yYkyyeTIc7DBB7x71qsCl7RXObziki8Mkfzg2n9+odKCdKr4m
   1VICObmon3327tckWYIsl2oPVEetZul8jyR/5OF7RpRDKO3ckYTLHjy9O
   nwxpvghGzzR7wR/4zh7MLID6JLnKw4B+tg8/UdJpA4DVkah55XifydUTm
   /blsjj822SfYvyLCjRn9zMRXHrwEofgQK4Ypvocde+S8gHoz7shWRdL9g
   slB0nNIPzsXsodRfhLybRijO29zLpGChYtl+eVH2axfKBNwC85BBiWWDu
   ITpRe8QVQcCrQ+QWWMSzCkUfyRlAAzc/eYvlvsQYn9VGFrW50BGSClkmz
   A==;
X-CSE-ConnectionGUID: Z94cu0gXSc+hu+lsic8SsA==
X-CSE-MsgGUID: KGKIBq1fTqG8UhDT19Jj0Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11242"; a="30431983"
X-IronPort-AV: E=Sophos;i="6.11,249,1725346800"; 
   d="scan'208";a="30431983"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 02:48:32 -0700
X-CSE-ConnectionGUID: RNQUfE+vQpigJfoyfC+UzQ==
X-CSE-MsgGUID: v0Z+xPXRRCOsUY2mwGu2LQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,249,1725346800"; 
   d="scan'208";a="106255713"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 01 Nov 2024 02:48:31 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t6oGa-000hNh-2k;
	Fri, 01 Nov 2024 09:48:28 +0000
Date: Fri, 01 Nov 2024 17:47:38 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:core/merge] BUILD SUCCESS
 c9694badf4f93d8eb07c00ec3434c337d36e205f
Message-ID: <202411011725.I1JqrWNT-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core/merge
branch HEAD: c9694badf4f93d8eb07c00ec3434c337d36e205f  Merge branch 'timers/core' into core/merge, to resolve conflict

elapsed time: 757m

configs tested: 83
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                             allyesconfig    clang-19
i386        buildonly-randconfig-001-20241101    gcc-12
i386        buildonly-randconfig-002-20241101    gcc-12
i386        buildonly-randconfig-003-20241101    gcc-12
i386        buildonly-randconfig-004-20241101    gcc-12
i386        buildonly-randconfig-005-20241101    gcc-12
i386        buildonly-randconfig-006-20241101    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20241101    gcc-12
i386                  randconfig-002-20241101    gcc-12
i386                  randconfig-003-20241101    gcc-12
i386                  randconfig-004-20241101    gcc-12
i386                  randconfig-005-20241101    gcc-12
i386                  randconfig-006-20241101    gcc-12
i386                  randconfig-011-20241101    gcc-12
i386                  randconfig-012-20241101    gcc-12
i386                  randconfig-013-20241101    gcc-12
i386                  randconfig-014-20241101    gcc-12
i386                  randconfig-015-20241101    gcc-12
i386                  randconfig-016-20241101    gcc-12
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.1.0
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64                              defconfig    clang-19
x86_64                                  kexec    clang-19
x86_64                                  kexec    gcc-12
x86_64                               rhel-8.3    gcc-12
xtensa                            allnoconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

