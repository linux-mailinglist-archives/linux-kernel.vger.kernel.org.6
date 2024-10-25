Return-Path: <linux-kernel+bounces-381203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4669AFBEC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 10:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F387A284A92
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 08:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750DF1C174E;
	Fri, 25 Oct 2024 08:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hquiGkH0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39D322B657
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 08:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729843432; cv=none; b=GOqtNfqTr2GcP6XPJgN6Xi3yAP2jFSLWL2H1oRI3Bq8zL9+t10dbMorrK5qon3YS8QGEpZMjGpscavUqgCXAKfarhH5MNEFTzOMFgtJ/Uygcj2rB6gZM5Rq/r5+ivbtJMA/Ue1xTV9lfsUsS6eRh09M1SX73c4pwLDEGStZAjMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729843432; c=relaxed/simple;
	bh=tfvJwP5ajtaYGD6JgT9vwynz7y50nDofL8/Gb01m0e4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=GGwe4DUxtZ1Jz6qtcRaIT8rRaSlBHF3BK14FS8q5J0QH37BRYcEs/wrTewS1fOnbwN+1I87sVoOEtdOMcnSqFxZbOzt511XDowTpgJZ9mmUG3GNdiM7bYM0qIDXuCzM4Bt/luvLd26lOOM2SRLD5I9FsM1sBXpTK1ZxR7fq2Kjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hquiGkH0; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729843431; x=1761379431;
  h=date:from:to:cc:subject:message-id;
  bh=tfvJwP5ajtaYGD6JgT9vwynz7y50nDofL8/Gb01m0e4=;
  b=hquiGkH04h0EoHBJFAzjw49aqh3AqdgmRbEyatopww5ViaseOZVoEixs
   kT4dGgFX49cVMsWYvy5OL183biGbLO15nsDYx551zCjq8l8/eDg/8xm14
   ttR2n3w1Qm5n+lfjqCqovm5/umvIj4y84rSPTEKuXJn2hj9oZ+e2NlxtB
   BMjXCZRAGbrwNZ/T8AK51iBXWNQFzUfnp59yBY3hRLtc7Tnx3Em718T5o
   px/LMWDRCorE/WlTwLVFLzscLAoYLYsPmYYIiM3P1MkrKISOdUq8Wawz8
   V3AkMIhaIWe4UtTIS6wlyeSgrDB834BzGP6BRMhSyJrJxTWUmEAXJ3lm9
   w==;
X-CSE-ConnectionGUID: 6hxfSojqRgyYc43I6uR92A==
X-CSE-MsgGUID: Tg1ZcuqOTeSeJQcnMqMMVQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="54907748"
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="54907748"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 01:03:50 -0700
X-CSE-ConnectionGUID: 314KEzZzQ0mr+fF9QUKSlQ==
X-CSE-MsgGUID: M9hg9PHgTKKgk9DbESIMHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="81675336"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 25 Oct 2024 01:03:49 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t4FIQ-000Xom-1P;
	Fri, 25 Oct 2024 08:03:46 +0000
Date: Fri, 25 Oct 2024 16:03:14 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:core/merge] BUILD SUCCESS
 d14017f4b399c3deb0ffcb03ffa826fdb140a5db
Message-ID: <202410251606.KpdVZubr-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core/merge
branch HEAD: d14017f4b399c3deb0ffcb03ffa826fdb140a5db  Merge branch 'locking/core' into core/merge, to resolve conflicts

elapsed time: 956m

configs tested: 99
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                     allnoconfig    gcc-14.1.0
alpha                    allyesconfig    clang-20
alpha                       defconfig    gcc-14.1.0
arc                      allmodconfig    clang-20
arc                       allnoconfig    gcc-14.1.0
arc                      allyesconfig    clang-20
arm                      allmodconfig    clang-20
arm                       allnoconfig    gcc-14.1.0
arm                      allyesconfig    clang-20
arm               aspeed_g5_defconfig    clang-20
arm                 lpc32xx_defconfig    gcc-14.1.0
arm                 s3c6400_defconfig    gcc-14.1.0
arm                   sama5_defconfig    clang-20
arm                  sp7021_defconfig    gcc-14.1.0
arm            vt8500_v6_v7_defconfig    gcc-14.1.0
arm64                    allmodconfig    clang-20
arm64                     allnoconfig    gcc-14.1.0
csky                      allnoconfig    gcc-14.1.0
hexagon                  allmodconfig    clang-20
hexagon                   allnoconfig    gcc-14.1.0
hexagon                  allyesconfig    clang-20
i386                     alldefconfig    gcc-14.1.0
i386                     allmodconfig    clang-19
i386                      allnoconfig    clang-19
i386                     allyesconfig    clang-19
i386                        defconfig    clang-19
loongarch                allmodconfig    gcc-14.1.0
loongarch                 allnoconfig    gcc-14.1.0
m68k                     allmodconfig    gcc-14.1.0
m68k                      allnoconfig    gcc-14.1.0
m68k                     allyesconfig    gcc-14.1.0
m68k                   sun3_defconfig    clang-20
microblaze               allmodconfig    gcc-14.1.0
microblaze                allnoconfig    gcc-14.1.0
microblaze               allyesconfig    gcc-14.1.0
mips                      allnoconfig    gcc-14.1.0
mips                bcm63xx_defconfig    clang-20
mips                 bigsur_defconfig    clang-20
mips                    gpr_defconfig    clang-20
mips                    gpr_defconfig    gcc-14.1.0
mips                   jazz_defconfig    gcc-14.1.0
mips                omega2p_defconfig    clang-20
nios2                     allnoconfig    gcc-14.1.0
openrisc                  allnoconfig    clang-20
openrisc                 allyesconfig    gcc-14.1.0
openrisc                    defconfig    gcc-12
parisc                   allmodconfig    gcc-14.1.0
parisc                    allnoconfig    clang-20
parisc                   allyesconfig    gcc-14.1.0
parisc                      defconfig    gcc-12
powerpc            adder875_defconfig    clang-20
powerpc                  allmodconfig    gcc-14.1.0
powerpc                   allnoconfig    clang-20
powerpc                  allyesconfig    gcc-14.1.0
powerpc            ge_imp3a_defconfig    clang-20
powerpc         mpc832x_rdb_defconfig    clang-20
powerpc             sequoia_defconfig    gcc-14.1.0
powerpc             tqm8560_defconfig    clang-20
powerpc              tqm8xx_defconfig    gcc-14.1.0
powerpc                warp_defconfig    gcc-14.1.0
riscv                    allmodconfig    gcc-14.1.0
riscv                     allnoconfig    clang-20
riscv                    allyesconfig    gcc-14.1.0
riscv                       defconfig    gcc-12
s390                     allmodconfig    gcc-14.1.0
s390                      allnoconfig    clang-20
s390                     allyesconfig    gcc-14.1.0
s390                        defconfig    gcc-12
s390               zfcpdump_defconfig    clang-20
sh                       allmodconfig    gcc-14.1.0
sh                        allnoconfig    gcc-14.1.0
sh                       allyesconfig    gcc-14.1.0
sh                          defconfig    gcc-12
sh                 ecovec24_defconfig    gcc-14.1.0
sh                edosk7705_defconfig    gcc-14.1.0
sh                  kfr2r09_defconfig    gcc-14.1.0
sh             magicpanelr2_defconfig    gcc-14.1.0
sh              rts7751r2d1_defconfig    clang-20
sh                   se7619_defconfig    gcc-14.1.0
sh                   se7705_defconfig    clang-20
sh                   se7705_defconfig    gcc-14.1.0
sh          sh7785lcr_32bit_defconfig    clang-20
sh                     shx3_defconfig    clang-20
sparc                    allmodconfig    gcc-14.1.0
sparc64                     defconfig    gcc-12
um                       allmodconfig    clang-20
um                        allnoconfig    clang-20
um                       allyesconfig    clang-20
um                          defconfig    gcc-12
um                     i386_defconfig    gcc-12
um                   x86_64_defconfig    gcc-12
x86_64                    allnoconfig    clang-19
x86_64                   allyesconfig    clang-19
x86_64                      defconfig    clang-19
x86_64                          kexec    clang-19
x86_64                          kexec    gcc-12
x86_64                       rhel-8.3    gcc-12
xtensa                    allnoconfig    gcc-14.1.0
xtensa          cadence_csp_defconfig    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

