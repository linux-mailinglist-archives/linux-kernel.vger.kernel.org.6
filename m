Return-Path: <linux-kernel+bounces-411982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A19B19D01FF
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 05:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78C8B286BEB
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 04:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B81125DF;
	Sun, 17 Nov 2024 04:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZqD+zqxS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302E6372
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 04:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731818154; cv=none; b=aFIcy1OqhrY1mLqE95y7Y9qiB1DNU12eC7UQSumlwVnRcN4r42s8Y0sIjOhS2RyJYj8RAPuJmCK5gi5dmvpHFTeMx6gGE6dnNUoJMgnsXjGuoVCcZB2GUXZXJhoUonPlwQHohJQfQANP957JgJWdCHEbhkUpNz1wfalFqK/LM+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731818154; c=relaxed/simple;
	bh=whrUJLjDJcYFwh7FYcGSPRZbdP/xKCedBNNwDfTm4qU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=G7PDcrGvqoLAeYH7fWLFmzrD6WogilfVEmyV7YgFlW56DR/fP3Vhq607QKy7gNR/zTidoRwo8XbkfXkNVivvvIW5znBK4WD3f3BynpKLNTcTXweLNR4Q3YkxPxIPlFF1dKy8E473SKnr5oC4vCJavXOgkZVcMZhYnM/pTo/hL3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZqD+zqxS; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731818153; x=1763354153;
  h=date:from:to:cc:subject:message-id;
  bh=whrUJLjDJcYFwh7FYcGSPRZbdP/xKCedBNNwDfTm4qU=;
  b=ZqD+zqxSnyxnBcCnp4AMgkdKLo8AsIfAf1rNLQsLx7hTKhVH9sOiCxol
   LiMlnVPGYrPb2gWtqqyrFpEIn1PiHGrg+OPXcZnIDxVsEo8my9kJgvhA/
   V88jWu5/Mw8Ng9Wnm4XIlDbUmOvfUE7BDZetWB3uxDDr/ZrNiIWK+X5he
   +5Yovw36u1x3/pZL5bBBHBboJNjhma2zShtmCQMWSldvSIPE7VE5zBDNu
   QeTQKI2HrKVrtCyBWp4YbnaOhq+jMecgT9NBFPeQoY0hiuHz286w3acRs
   w6jURIrP1Knjw0mHOfwN4a2aoAfc+epnENkSf1wFEzIc+M88rjx2otoLh
   A==;
X-CSE-ConnectionGUID: ZHTSyf/dSu64SdsfTSze3Q==
X-CSE-MsgGUID: pygU17eyReWLwmzbENYK3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11258"; a="31174436"
X-IronPort-AV: E=Sophos;i="6.12,161,1728975600"; 
   d="scan'208";a="31174436"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2024 20:35:52 -0800
X-CSE-ConnectionGUID: krJ/+9+SSRGkCynZrAMxOA==
X-CSE-MsgGUID: Q/ukeDsIRHGBp3xSaiBDVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,161,1728975600"; 
   d="scan'208";a="89322578"
Received: from lkp-server01.sh.intel.com (HELO 1e3cc1889ffb) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 16 Nov 2024 20:35:52 -0800
Received: from kbuild by 1e3cc1889ffb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tCX0n-0001TH-0M;
	Sun, 17 Nov 2024 04:35:49 +0000
Date: Sun, 17 Nov 2024 12:35:09 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:tip/urgent] BUILD SUCCESS
 c8df2d2a9199e221808177b7450a86a15915440c
Message-ID: <202411171203.49eNeeHS-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tip/urgent
branch HEAD: c8df2d2a9199e221808177b7450a86a15915440c  Merge branch into tip/master: 'x86/urgent'

elapsed time: 771m

configs tested: 49
configs skipped: 166

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arm                               allnoconfig    gcc-14.2.0
arm64                             allnoconfig    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
hexagon                           allnoconfig    gcc-14.2.0
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                             allyesconfig    clang-19
i386        buildonly-randconfig-001-20241117    clang-19
i386        buildonly-randconfig-002-20241117    clang-19
i386        buildonly-randconfig-003-20241117    clang-19
i386        buildonly-randconfig-004-20241117    clang-19
i386        buildonly-randconfig-005-20241117    clang-19
i386        buildonly-randconfig-006-20241117    clang-19
i386                                defconfig    clang-19
i386                  randconfig-001-20241117    clang-19
i386                  randconfig-002-20241117    clang-19
i386                  randconfig-003-20241117    clang-19
i386                  randconfig-004-20241117    clang-19
i386                  randconfig-005-20241117    clang-19
i386                  randconfig-006-20241117    clang-19
i386                  randconfig-011-20241117    clang-19
i386                  randconfig-012-20241117    clang-19
i386                  randconfig-013-20241117    clang-19
i386                  randconfig-014-20241117    clang-19
i386                  randconfig-015-20241117    clang-19
i386                  randconfig-016-20241117    clang-19
loongarch                         allnoconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
parisc                              defconfig    gcc-12
riscv                               defconfig    gcc-12
s390                                defconfig    gcc-12
sh                                allnoconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sparc64                             defconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64                              defconfig    clang-19
x86_64                                  kexec    gcc-12
x86_64                               rhel-8.3    gcc-12
xtensa                            allnoconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

