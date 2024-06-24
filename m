Return-Path: <linux-kernel+bounces-227897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A6B9157DD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 22:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93540287DB0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 20:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B751A0710;
	Mon, 24 Jun 2024 20:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ob53JGNN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5CD19D88F
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 20:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719260428; cv=none; b=HMkScVVz3ViIaZFmM6mC64ZMVsE066mcEfR1hpsBMtV4etJBzHclDsZ2nWMQ7s8KDxnHnp+oMpZuGQyKipSl0d1Azxxi8dvSIIBcXhMUDE61CuZDQdeHj6bBDGUOjlTln+AjqnackIOgeVggyy7Fb8GqcuPzi0NID+EqgXgH4/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719260428; c=relaxed/simple;
	bh=KKH23Ihc7jE/IBgJcmJ7Xne9a8fP+1pfryMZLibGyaU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=RIUKr7JzBbGFpJcv/adkXFtrTxW0CZazphdJ/R/wNFeOCA3P4WSI1jBEErAWGULPDUkwv6r4fTfnIlKWTY1sZfhX2neju/kOp3/tZUXBj0mDs0AI/7tbSpK1TnN/bCie4QQiaHNStwzCOclMg5FVBjerOxrCulTLIBeqAp2CdOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ob53JGNN; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719260427; x=1750796427;
  h=date:from:to:cc:subject:message-id;
  bh=KKH23Ihc7jE/IBgJcmJ7Xne9a8fP+1pfryMZLibGyaU=;
  b=Ob53JGNNonrmTdeN3wDukdWed6FWgrKIvDj1gCx7LLmXyiMk8FsXrrf9
   prZk9Jego9ZakeeBhqoMfJFs2M7iziKokERBbSWh+8h9bfq13EXSKkXXG
   XQTFqndd5mzKGfBGNHjzPSyjPfr6jt7akvaA9jPXw0UopfzR0SEbQ0trV
   uYsxfnOt8lq+P/ECQ6pmtCom+dH4+K8reRDEef3K1oJ+b5d1+jmNEj4BT
   yow9WluL97v8rJ6wdtltsf92xSX9wlaViODaTdEW6laMN0U6WLlOIDpTX
   aCSWpyk4b7iK0YsgZ5C6uGp8IlVUvE+lzz4v2UNm7GDeB+hGkCPbbXtXF
   w==;
X-CSE-ConnectionGUID: XVZFclzbSiGngsWxvje9BA==
X-CSE-MsgGUID: 8AcY+WGpS3yLeMNUefXIpw==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="16397568"
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="16397568"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 13:20:26 -0700
X-CSE-ConnectionGUID: qJK3vtdJTlGi5rYWGqv+ng==
X-CSE-MsgGUID: SxlzvwUMS4C0iWj4E3uQyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="48357483"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 24 Jun 2024 13:20:25 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sLqAo-000DhA-33;
	Mon, 24 Jun 2024 20:20:22 +0000
Date: Tue, 25 Jun 2024 04:19:43 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:smp/urgent] BUILD SUCCESS
 6ef8eb5125722c241fd60d7b0c872d5c2e5dd4ca
Message-ID: <202406250441.b1sVkFgQ-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp/urgent
branch HEAD: 6ef8eb5125722c241fd60d7b0c872d5c2e5dd4ca  cpu: Fix broken cmdline "nosmp" and "maxcpus=0"

elapsed time: 1504m

configs tested: 108
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                   randconfig-001-20240624   gcc-13.2.0
arc                   randconfig-002-20240624   gcc-13.2.0
arm                               allnoconfig   clang-19
arm                   randconfig-001-20240624   clang-17
arm                   randconfig-002-20240624   gcc-13.2.0
arm                   randconfig-003-20240624   gcc-13.2.0
arm                   randconfig-004-20240624   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                 randconfig-001-20240624   clang-19
arm64                 randconfig-002-20240624   gcc-13.2.0
arm64                 randconfig-003-20240624   gcc-13.2.0
arm64                 randconfig-004-20240624   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                  randconfig-001-20240624   gcc-13.2.0
csky                  randconfig-002-20240624   gcc-13.2.0
hexagon                           allnoconfig   clang-19
hexagon               randconfig-001-20240624   clang-19
hexagon               randconfig-002-20240624   clang-19
i386         buildonly-randconfig-001-20240624   gcc-8
i386         buildonly-randconfig-002-20240624   gcc-13
i386         buildonly-randconfig-003-20240624   clang-18
i386         buildonly-randconfig-004-20240624   gcc-10
i386         buildonly-randconfig-005-20240624   clang-18
i386         buildonly-randconfig-006-20240624   clang-18
i386                  randconfig-001-20240624   clang-18
i386                  randconfig-002-20240624   clang-18
i386                  randconfig-003-20240624   gcc-13
i386                  randconfig-004-20240624   gcc-13
i386                  randconfig-005-20240624   gcc-13
i386                  randconfig-006-20240624   clang-18
i386                  randconfig-011-20240624   clang-18
i386                  randconfig-012-20240624   clang-18
i386                  randconfig-013-20240624   gcc-9
i386                  randconfig-014-20240624   clang-18
i386                  randconfig-015-20240624   clang-18
i386                  randconfig-016-20240624   gcc-9
loongarch                         allnoconfig   gcc-13.2.0
loongarch             randconfig-001-20240624   gcc-13.2.0
loongarch             randconfig-002-20240624   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                 randconfig-001-20240624   gcc-13.2.0
nios2                 randconfig-002-20240624   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                            defconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                              defconfig   gcc-13.2.0
parisc                randconfig-001-20240624   gcc-13.2.0
parisc                randconfig-002-20240624   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc               randconfig-001-20240624   clang-19
powerpc               randconfig-002-20240624   gcc-13.2.0
powerpc               randconfig-003-20240624   clang-16
powerpc64             randconfig-001-20240624   clang-17
powerpc64             randconfig-002-20240624   clang-19
powerpc64             randconfig-003-20240624   clang-19
riscv                             allnoconfig   gcc-13.2.0
riscv                               defconfig   clang-19
riscv                 randconfig-001-20240624   clang-19
riscv                 randconfig-002-20240624   gcc-13.2.0
s390                              allnoconfig   clang-19
s390                                defconfig   clang-19
s390                  randconfig-001-20240624   clang-15
s390                  randconfig-002-20240624   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                                  defconfig   gcc-13.2.0
sh                    randconfig-001-20240624   gcc-13.2.0
sh                    randconfig-002-20240624   gcc-13.2.0
sparc64                             defconfig   gcc-13.2.0
sparc64               randconfig-001-20240624   gcc-13.2.0
sparc64               randconfig-002-20240624   gcc-13.2.0
um                                allnoconfig   clang-17
um                                  defconfig   clang-19
um                             i386_defconfig   gcc-13
um                    randconfig-001-20240624   clang-19
um                    randconfig-002-20240624   clang-19
um                           x86_64_defconfig   clang-15
x86_64       buildonly-randconfig-001-20240624   gcc-13
x86_64       buildonly-randconfig-002-20240624   gcc-13
x86_64       buildonly-randconfig-003-20240624   clang-18
x86_64       buildonly-randconfig-004-20240624   clang-18
x86_64       buildonly-randconfig-005-20240624   clang-18
x86_64       buildonly-randconfig-006-20240624   clang-18
x86_64                randconfig-001-20240624   clang-18
x86_64                randconfig-002-20240624   clang-18
x86_64                randconfig-003-20240624   clang-18
x86_64                randconfig-004-20240624   clang-18
x86_64                randconfig-005-20240624   gcc-11
x86_64                randconfig-006-20240624   gcc-13
x86_64                randconfig-011-20240624   clang-18
x86_64                randconfig-012-20240624   gcc-8
x86_64                randconfig-013-20240624   clang-18
x86_64                randconfig-014-20240624   gcc-8
x86_64                randconfig-015-20240624   gcc-13
x86_64                randconfig-016-20240624   clang-18
x86_64                randconfig-071-20240624   gcc-10
x86_64                randconfig-072-20240624   gcc-10
x86_64                randconfig-073-20240624   gcc-13
x86_64                randconfig-074-20240624   gcc-13
x86_64                randconfig-075-20240624   gcc-13
x86_64                randconfig-076-20240624   gcc-8
xtensa                            allnoconfig   gcc-13.2.0
xtensa                randconfig-001-20240624   gcc-13.2.0
xtensa                randconfig-002-20240624   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

