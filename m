Return-Path: <linux-kernel+bounces-235005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCFAA91CE32
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 18:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54D6C282F3F
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 16:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D76132113;
	Sat, 29 Jun 2024 16:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ua2N9FxN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426B912FB3F
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 16:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719679621; cv=none; b=HZb6gsWSrnIfkMxPsa3WE/OwoR7QnX4pX6WZQDFRGQ96f7nH8snmyewYKyT7Fw6z0869woCnVQl9WelEUnTQbIxZvC2pPqsVKSNVCWoUjovRaG/tMtImMDwA6A3L8ppxkCz6wSjnF45sfuQaHWxQF3D/eI8s9HOpuiO3NYElhKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719679621; c=relaxed/simple;
	bh=NdwDYXy90DzmNJ9UeuXmr+nGjsI/yHOxnXcY6RirEsQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=VPn6/NC6b6J79dljD6ENrzDTdHldSS0Ua8yq9rZwWDmCPrsqLMQZmWuy9mIAq0MTj0f5oM+7HwTcpEh62UPlrl0fppk8oiGd9YWt9nGoZG4D4glth8b+p0crokdrIDBwWR8IO7pL6veEsCE2kZ6CqqVRKoZcsQs339Qa0SAVaEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ua2N9FxN; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719679620; x=1751215620;
  h=date:from:to:cc:subject:message-id;
  bh=NdwDYXy90DzmNJ9UeuXmr+nGjsI/yHOxnXcY6RirEsQ=;
  b=Ua2N9FxNEXZr4Os8vb9KozwKl1v1AYy9GPgYE6cFG8cFCUrDtEneRWUZ
   QSvxGqhRLmRhhfV9K66s30DNijmKaBm3NV7sMCOLiNC5xV2p9px+C5BCv
   QDj+UvjB013S7yJj7wy/CQkO39042VEmJipx7yaOLf8zC/gvCEZucI87W
   uEpaNlxOezEr1q5ARv0zG8fzeFYJbbDUtkkT4TZIfH2dIz86uyK85o7Xk
   ty7uENZcvOjtPSeaR6qbf4+lgeFTPonqM9C7HJAYaYa5XDBn97oi1woDu
   6nYC71Ho6S34xBDgFI7OFaTjLWL4T4vMwi7AeqiSVWjsvhqK/sLUePxYQ
   A==;
X-CSE-ConnectionGUID: Ay32/KoMTw+5qzU9oQNhDQ==
X-CSE-MsgGUID: rGBNZRARSwO+/ZsY2NGWSA==
X-IronPort-AV: E=McAfee;i="6700,10204,11118"; a="20666084"
X-IronPort-AV: E=Sophos;i="6.09,172,1716274800"; 
   d="scan'208";a="20666084"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2024 09:46:59 -0700
X-CSE-ConnectionGUID: NSnkV4GGTv2kIVz8sufIiw==
X-CSE-MsgGUID: pgbCrVIORtKNQcettnd+6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,172,1716274800"; 
   d="scan'208";a="45800994"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 29 Jun 2024 09:46:57 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sNbDz-000Jr2-1s;
	Sat, 29 Jun 2024 16:46:55 +0000
Date: Sun, 30 Jun 2024 00:46:26 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/vmware] BUILD SUCCESS
 57b7b6acb41b51087ceb40c562efe392ec8c9677
Message-ID: <202406300024.4XdHdHsQ-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/vmware
branch HEAD: 57b7b6acb41b51087ceb40c562efe392ec8c9677  x86/vmware: Add TDX hypercall support

elapsed time: 5782m

configs tested: 73
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                               defconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240627   gcc-13.2.0
arc                   randconfig-002-20240627   gcc-13.2.0
arm                                 defconfig   clang-14
arm                          exynos_defconfig   clang-17
arm                   randconfig-001-20240627   gcc-13.2.0
arm                   randconfig-002-20240627   clang-19
arm                   randconfig-003-20240627   gcc-13.2.0
arm                   randconfig-004-20240627   clang-19
arm                       versatile_defconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240627   gcc-13.2.0
arm64                 randconfig-002-20240627   clang-19
arm64                 randconfig-003-20240627   clang-17
arm64                 randconfig-004-20240627   clang-19
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240627   gcc-13.2.0
csky                  randconfig-002-20240627   gcc-13.2.0
hexagon                             defconfig   clang-19
hexagon               randconfig-001-20240627   clang-17
hexagon               randconfig-002-20240627   clang-19
loongarch                           defconfig   gcc-13.2.0
loongarch                 loongson3_defconfig   gcc-13.2.0
loongarch             randconfig-001-20240627   gcc-13.2.0
loongarch             randconfig-002-20240627   gcc-13.2.0
m68k                                defconfig   gcc-13.2.0
microblaze                          defconfig   gcc-13.2.0
mips                        bcm63xx_defconfig   clang-17
mips                 decstation_r4k_defconfig   gcc-13.2.0
mips                           ip27_defconfig   gcc-13.2.0
mips                           ip32_defconfig   clang-19
mips                          rm200_defconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240627   gcc-13.2.0
nios2                 randconfig-002-20240627   gcc-13.2.0
openrisc                            defconfig   gcc-13.2.0
parisc                           alldefconfig   gcc-13.2.0
parisc                              defconfig   gcc-13.2.0
parisc                randconfig-001-20240627   gcc-13.2.0
parisc                randconfig-002-20240627   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                  iss476-smp_defconfig   gcc-13.2.0
powerpc               randconfig-001-20240627   gcc-13.2.0
powerpc               randconfig-002-20240627   clang-19
powerpc               randconfig-003-20240627   gcc-13.2.0
powerpc                    socrates_defconfig   gcc-13.2.0
powerpc                     tqm8548_defconfig   clang-19
powerpc64             randconfig-001-20240627   gcc-13.2.0
powerpc64             randconfig-002-20240627   gcc-13.2.0
powerpc64             randconfig-003-20240627   gcc-13.2.0
riscv                               defconfig   clang-19
riscv                 randconfig-001-20240627   gcc-13.2.0
riscv                 randconfig-002-20240627   clang-19
s390                                defconfig   clang-19
s390                  randconfig-001-20240627   clang-16
s390                  randconfig-002-20240627   clang-15
sh                                  defconfig   gcc-13.2.0
sh                 kfr2r09-romimage_defconfig   gcc-13.2.0
sh                    randconfig-001-20240627   gcc-13.2.0
sh                    randconfig-002-20240627   gcc-13.2.0
sh                          rsk7201_defconfig   gcc-13.2.0
sh                           se7750_defconfig   gcc-13.2.0
sparc64                             defconfig   gcc-13.2.0
sparc64               randconfig-001-20240627   gcc-13.2.0
sparc64               randconfig-002-20240627   gcc-13.2.0
um                                  defconfig   clang-19
um                             i386_defconfig   gcc-13
um                    randconfig-001-20240627   clang-19
um                    randconfig-002-20240627   clang-19
um                           x86_64_defconfig   clang-15
xtensa                randconfig-001-20240627   gcc-13.2.0
xtensa                randconfig-002-20240627   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

