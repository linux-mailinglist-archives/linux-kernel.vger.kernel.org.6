Return-Path: <linux-kernel+bounces-389995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0909B7448
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 07:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3736D1F24DF4
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 06:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F107013D53A;
	Thu, 31 Oct 2024 06:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DLOQNh3/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206008C07
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 06:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730354762; cv=none; b=ISaoj/U5YNhGGJ7OpMbgjLcQfY33DIN6203GtPKqhgBDEg01ZhizPuosngzfsaL16jRLEG2IH/1WFwDJd5zPiI7tF4mSq+5Aig59tB3LwbXB3tTVRuDLpWRLsnbDKqtEN8rhtdPaKqe4LXi5UpJ4oEAMTN+eisn+rF7Gphx6lvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730354762; c=relaxed/simple;
	bh=8GajnpRQ1AtwYLd4JVoGZLf9lnDyQzw8Y0nfnlBOFL0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=UEqCyy7Kcwp4E1V5a1TTg1OfqSrHIkOLxv5DOlpTe6J+wRcEvDqA8sCiJpr8StlGD9I2yAyWmkUwazHEKJC9YLrKWHjNVcLx/c2TN3tNhRDM+sDzFT22RTYjGG0bo+ruVZBtdEczNbK/kUenU7ZfWHi+VVCIrTq/8jXQoPMeeMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DLOQNh3/; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730354760; x=1761890760;
  h=date:from:to:cc:subject:message-id;
  bh=8GajnpRQ1AtwYLd4JVoGZLf9lnDyQzw8Y0nfnlBOFL0=;
  b=DLOQNh3/9KAr/f22LQccoTVDVPMwfKXj0ijIFBc4dkABLpzCRV0z1mpG
   H2JX8SwdeLsZ8vEjxcLxxkVbtzoNgP8ltQN83BKKBFrao/yOMlZhA9pha
   Kza0n2y7CbP6Yk6yuxJo1/UhNuN+8HPYBvBp0SD6G4Lhdo21Lv1TBeNUX
   2QspmVaBvLtVNIuFxpJwaIZg+5pMNSBRtEKjQ3yTEelKQuXrtmJ/S3ZmI
   1JPUg802VmpfaUWbS1i2J8NXYyfEKeV4fGchfZI1Q6CZry1N+lAW6w8DH
   wtSbg1N4xZS8L8q1gqSv0fIThARuYLwwdvGLemj4Lo/XxZZtBqmWT7Vht
   w==;
X-CSE-ConnectionGUID: eoLo+qN3TLO3Hz1cMFsuSw==
X-CSE-MsgGUID: xwNPj4IbQLOsTEHNErDP7Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="40693012"
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="40693012"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 23:05:59 -0700
X-CSE-ConnectionGUID: hdGsY2f/Q4WTCGR55NM/6w==
X-CSE-MsgGUID: bYqBgLhyQ0CtxwsGFxkpFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="82644398"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 30 Oct 2024 23:05:57 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t6OJe-000fjf-2g;
	Thu, 31 Oct 2024 06:05:54 +0000
Date: Thu, 31 Oct 2024 14:05:09 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/wfamnae-next20241028] BUILD SUCCESS
 0bc2809fe2a6c11dd4c8a9a10d9bd65cccdb559b
Message-ID: <202410311456.FD63kXOl-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/wfamnae-next20241028
branch HEAD: 0bc2809fe2a6c11dd4c8a9a10d9bd65cccdb559b  net: ethtool: Avoid thousands of -Wflex-array-member-not-at-end warnings

elapsed time: 1821m

configs tested: 107
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-13.3.0
alpha                            allyesconfig    gcc-13.3.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20241031    gcc-13.2.0
arc                   randconfig-002-20241031    gcc-13.2.0
arm                              allmodconfig    gcc-14.1.0
arm                               allnoconfig    clang-20
arm                              allyesconfig    gcc-14.1.0
arm                   randconfig-001-20241031    clang-17
arm                   randconfig-002-20241031    clang-20
arm                   randconfig-003-20241031    gcc-14.1.0
arm                   randconfig-004-20241031    gcc-14.1.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                 randconfig-001-20241031    clang-20
arm64                 randconfig-002-20241031    clang-20
arm64                 randconfig-003-20241031    clang-15
arm64                 randconfig-004-20241031    clang-17
csky                              allnoconfig    gcc-14.1.0
csky                  randconfig-001-20241031    gcc-14.1.0
csky                  randconfig-002-20241031    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                          allyesconfig    clang-20
hexagon               randconfig-001-20241031    clang-14
hexagon               randconfig-002-20241031    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241031    gcc-12
i386        buildonly-randconfig-002-20241031    clang-19
i386        buildonly-randconfig-003-20241031    gcc-12
i386        buildonly-randconfig-004-20241031    gcc-12
i386        buildonly-randconfig-005-20241031    clang-19
i386        buildonly-randconfig-006-20241031    gcc-11
i386                                defconfig    clang-19
i386                  randconfig-001-20241031    gcc-12
i386                  randconfig-002-20241031    clang-19
i386                  randconfig-003-20241031    gcc-11
i386                  randconfig-004-20241031    clang-19
i386                  randconfig-005-20241031    gcc-12
i386                  randconfig-006-20241031    clang-19
i386                  randconfig-011-20241031    clang-19
i386                  randconfig-012-20241031    clang-19
i386                  randconfig-013-20241031    clang-19
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch             randconfig-001-20241031    gcc-14.1.0
loongarch             randconfig-002-20241031    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                 randconfig-001-20241031    gcc-14.1.0
nios2                 randconfig-002-20241031    gcc-14.1.0
openrisc                          allnoconfig    gcc-14.1.0
openrisc                         allyesconfig    gcc-14.1.0
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    gcc-14.1.0
parisc                           allyesconfig    gcc-14.1.0
parisc                randconfig-001-20241031    gcc-14.1.0
parisc                randconfig-002-20241031    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    gcc-14.1.0
powerpc                          allyesconfig    clang-20
powerpc               randconfig-001-20241031    gcc-14.1.0
powerpc               randconfig-002-20241031    gcc-14.1.0
powerpc               randconfig-003-20241031    clang-20
powerpc64             randconfig-001-20241031    clang-15
powerpc64             randconfig-002-20241031    gcc-14.1.0
powerpc64             randconfig-003-20241031    clang-20
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    gcc-14.1.0
riscv                            allyesconfig    clang-20
riscv                 randconfig-001-20241031    clang-20
riscv                 randconfig-002-20241031    clang-20
s390                             allmodconfig    clang-20
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                  randconfig-001-20241031    gcc-14.1.0
s390                  randconfig-002-20241031    gcc-14.1.0
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                    randconfig-001-20241031    gcc-14.1.0
sh                    randconfig-002-20241031    gcc-14.1.0
sparc                            allmodconfig    gcc-14.1.0
sparc64               randconfig-001-20241031    gcc-14.1.0
sparc64               randconfig-002-20241031    gcc-14.1.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                               allyesconfig    gcc-12
um                    randconfig-001-20241031    clang-20
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                               rhel-8.3    gcc-12
xtensa                            allnoconfig    gcc-14.1.0
xtensa                randconfig-001-20241031    gcc-14.1.0
xtensa                randconfig-002-20241031    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

