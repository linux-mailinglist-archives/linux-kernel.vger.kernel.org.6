Return-Path: <linux-kernel+bounces-383401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA079B1B4D
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 00:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9FBA28224E
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 22:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770601D7E26;
	Sat, 26 Oct 2024 22:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hhX4dlUC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B314C83
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 22:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729982490; cv=none; b=Dc/1qJ8KFTWf1G1P9TcCLnacs+05ROKVaRXIQhcvvL78t4wC5V0mT1yf5ux/CEBEzzDTCL+Ha2vi1OwKXEdibwebjJWCcsikIkG6TcSqLdjCjM/FK5rUHXnXhs9Va+COyMzADxfn6YHCece1FGHQ6zfS6u7H1H14ysDR+1bpfHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729982490; c=relaxed/simple;
	bh=STGu924wNILVvWaR7K90zp/Qh3tTSQf2aZF2VDvpu/Q=;
	h=Date:From:To:Cc:Subject:Message-ID; b=UBkTJu82E3WhpfB05s5LCJawin6YVMZSRDTk6FLZDOwLhZeyuVJANgU6LhuJsEvL1WYUF4oN8JgtyUWNmSab4bi2FfiItyNWU897VTN28IRKAwPASxpj5MznbfmPOXdTWw7Uw9SxL9mdiFoLEm5jq0pgSn+VK/zTwgz3BPqO2GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hhX4dlUC; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729982489; x=1761518489;
  h=date:from:to:cc:subject:message-id;
  bh=STGu924wNILVvWaR7K90zp/Qh3tTSQf2aZF2VDvpu/Q=;
  b=hhX4dlUCaZzXzWKjE9oWfvHxfpRRxWMVrLU1Kcy5lsbx4gi9R2GgQgYJ
   sLEcqRwMgS+Sut7N+WbJzg5FPcFaw41PY9SVwZ4bw7BYXsiBpiccXCgQa
   thlBEMkSay4yqXOy+lS/oz2GgvuYdiYR+zhc9FjKty991BP4dKOu+cio+
   Dd92QVf/rXwtTHqI3yLfESHiIylxb7Qgfldy5ASBDaoG4qJ2g7gk6K3x6
   432SFdlwNBxuYlSpLdVffMzC4wdPdVO9/JEfQIR994rFw3jZCHf07ao6E
   IfTXD70F2U3NIEZk07BtUQaEQxAtkqSP+xwxPNER0QqzcJhAAoLNKJHrX
   g==;
X-CSE-ConnectionGUID: EgZ0Ba+2QnWYxwx/1OB2Jw==
X-CSE-MsgGUID: 63jDa1TpRvC1dsMz5m4RrA==
X-IronPort-AV: E=McAfee;i="6700,10204,11237"; a="47112260"
X-IronPort-AV: E=Sophos;i="6.11,236,1725346800"; 
   d="scan'208";a="47112260"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2024 15:41:28 -0700
X-CSE-ConnectionGUID: zFva+uIIT9CtJ5uNW8L89Q==
X-CSE-MsgGUID: EEKvdmG2SwKX2VRjS8Y5Vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,236,1725346800"; 
   d="scan'208";a="81205665"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 26 Oct 2024 15:41:27 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t4pTI-000a88-1b;
	Sat, 26 Oct 2024 22:41:24 +0000
Date: Sun, 27 Oct 2024 06:40:33 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 3a889e9fc2f9ddd7697239fe52753e4a7c3a02d4
Message-ID: <202410270625.c3ncrP9r-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 3a889e9fc2f9ddd7697239fe52753e4a7c3a02d4  Merge branch into tip/master: 'x86/sev'

elapsed time: 1593m

configs tested: 109
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-13.3.0
alpha                            allyesconfig    gcc-13.3.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20241026    gcc-13.2.0
arc                   randconfig-002-20241026    gcc-13.2.0
arm                              allmodconfig    gcc-14.1.0
arm                               allnoconfig    clang-20
arm                              allyesconfig    gcc-14.1.0
arm                   randconfig-001-20241026    gcc-14.1.0
arm                   randconfig-002-20241026    clang-20
arm                   randconfig-003-20241026    gcc-14.1.0
arm                   randconfig-004-20241026    gcc-14.1.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                 randconfig-001-20241026    gcc-14.1.0
arm64                 randconfig-002-20241026    clang-20
arm64                 randconfig-003-20241026    clang-20
arm64                 randconfig-004-20241026    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                  randconfig-001-20241026    gcc-14.1.0
csky                  randconfig-002-20241026    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                          allyesconfig    clang-20
hexagon               randconfig-001-20241026    clang-20
hexagon               randconfig-002-20241026    clang-17
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241026    clang-19
i386        buildonly-randconfig-002-20241026    clang-19
i386        buildonly-randconfig-003-20241026    gcc-12
i386        buildonly-randconfig-004-20241026    clang-19
i386        buildonly-randconfig-005-20241026    gcc-12
i386        buildonly-randconfig-006-20241026    clang-19
i386                                defconfig    clang-19
i386                  randconfig-001-20241026    clang-19
i386                  randconfig-002-20241026    clang-19
i386                  randconfig-003-20241026    clang-19
i386                  randconfig-004-20241026    gcc-12
i386                  randconfig-005-20241026    clang-19
i386                  randconfig-006-20241026    clang-19
i386                  randconfig-011-20241026    gcc-12
i386                  randconfig-012-20241026    gcc-12
i386                  randconfig-013-20241026    gcc-12
i386                  randconfig-014-20241026    gcc-12
i386                  randconfig-015-20241026    gcc-12
i386                  randconfig-016-20241026    gcc-12
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch             randconfig-001-20241026    gcc-14.1.0
loongarch             randconfig-002-20241026    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                 randconfig-001-20241026    gcc-14.1.0
nios2                 randconfig-002-20241026    gcc-14.1.0
openrisc                          allnoconfig    gcc-14.1.0
openrisc                         allyesconfig    gcc-14.1.0
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    gcc-14.1.0
parisc                           allyesconfig    gcc-14.1.0
parisc                randconfig-001-20241026    gcc-14.1.0
parisc                randconfig-002-20241026    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    gcc-14.1.0
powerpc                          allyesconfig    clang-20
powerpc               randconfig-001-20241026    gcc-14.1.0
powerpc               randconfig-002-20241026    gcc-14.1.0
powerpc               randconfig-003-20241026    clang-20
powerpc64             randconfig-001-20241026    clang-20
powerpc64             randconfig-002-20241026    clang-20
powerpc64             randconfig-003-20241026    gcc-14.1.0
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    gcc-14.1.0
riscv                            allyesconfig    clang-20
riscv                 randconfig-001-20241026    gcc-14.1.0
riscv                 randconfig-002-20241026    clang-20
s390                             allmodconfig    clang-20
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                  randconfig-001-20241026    gcc-14.1.0
s390                  randconfig-002-20241026    gcc-14.1.0
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                    randconfig-001-20241026    gcc-14.1.0
sh                    randconfig-002-20241026    gcc-14.1.0
sparc                            allmodconfig    gcc-14.1.0
sparc64               randconfig-001-20241026    gcc-14.1.0
sparc64               randconfig-002-20241026    gcc-14.1.0
um                               allmodconfig    clang-20
um                    randconfig-001-20241026    clang-20
um                    randconfig-002-20241026    clang-20
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                               rhel-8.3    gcc-12
xtensa                            allnoconfig    gcc-14.1.0
xtensa                randconfig-001-20241026    gcc-14.1.0
xtensa                randconfig-002-20241026    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

