Return-Path: <linux-kernel+bounces-512343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7448EA337CD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 07:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C76EB3A7853
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 06:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56787207675;
	Thu, 13 Feb 2025 06:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h+XGnuLS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6B3207640
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 06:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739427407; cv=none; b=l2xefaaCn4XGh2i1yijimZ0fVDsQRNAOpg7L/kfxuyncr+O9NCIbAMWSHtc++XU94/qFLUmrzvdPUSK3dMS/v2hxyx8dIbt4sIy94S7ruuEHz+Ue0aZ5oTX1WTeWXWo0gNxPRjbzSmCMlEHgCZrnDdD2mCKrPJiQgiJgZQ0ou9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739427407; c=relaxed/simple;
	bh=p2/RwPpGumFzZT/xk4cLp2wbpLwMfx5fCcN6WXvpTmQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=LLhUSj9OK2Qc+6toZjFBI7/rs5bqoKwXNFHtTwrkrEv9HHAeWnToIojzZ8ffPcsi8LnphVqqegrwC3C3AtNyv8J8tJnAokYSf6Ftkh54eolrhVPgroal5F1+oNzVRpIwZqdpI0/oldlZ+Y3lByXEqf6nQpfNtEsjQqFTiTGcjYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h+XGnuLS; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739427405; x=1770963405;
  h=date:from:to:cc:subject:message-id;
  bh=p2/RwPpGumFzZT/xk4cLp2wbpLwMfx5fCcN6WXvpTmQ=;
  b=h+XGnuLSu/cLJ10n/h0pP1RnEFST/sYjpof1EWFzoRnLmYhlUf1X88//
   wT/uEWnyKkpMiyQklEfkzmx8otom8SdGa6N3wKsdw5yqP5G1n5AYfC1DJ
   ximByxcuY5a2E+rW7Ui8NezlpKKHY9AieGLH275V3OySzCbDyT867g7rI
   ihEYdpkO/3dDLKWjxsFytTOFoW2nWd4daaBJ6GCmkRvYB9XdLg3/UK1bs
   gtw2BUFJVJ3OmAQc/B4ahVAILOpjBAvZhF5Vsmidng0MnNn+Z/jt2PHEN
   MrS/R4BMc+xEWd7mPpwR2X51iIKc9dmImDyauFLVCOEGhzT7qugKW18qp
   w==;
X-CSE-ConnectionGUID: TNXTPARRTjOa4MBpM3xNtA==
X-CSE-MsgGUID: l3KBggIzQ7qFZkJyaba9ow==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="40229636"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="40229636"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 22:16:44 -0800
X-CSE-ConnectionGUID: AISeVwh2TSKuIzy8BKxQnw==
X-CSE-MsgGUID: mkesTFepQUaU70ofAddakQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118230195"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 12 Feb 2025 22:16:44 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tiSWf-0016cz-1m;
	Thu, 13 Feb 2025 06:16:41 +0000
Date: Thu, 13 Feb 2025 14:16:01 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 d6678139cd9d2cfa12ae7be337c3da1051c7f5a1
Message-ID: <202502131455.Tl9MTPFC-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: d6678139cd9d2cfa12ae7be337c3da1051c7f5a1  Merge branch into tip/master: 'x86/mm'

elapsed time: 1390m

configs tested: 205
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    clang-18
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-18
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250212    gcc-13.2.0
arc                   randconfig-001-20250213    gcc-14.2.0
arc                   randconfig-002-20250212    gcc-13.2.0
arc                   randconfig-002-20250213    gcc-14.2.0
arm                              allmodconfig    clang-18
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-18
arm                              allyesconfig    gcc-14.2.0
arm                   randconfig-001-20250212    clang-18
arm                   randconfig-001-20250213    gcc-14.2.0
arm                   randconfig-002-20250212    clang-16
arm                   randconfig-002-20250213    gcc-14.2.0
arm                   randconfig-003-20250212    clang-21
arm                   randconfig-003-20250213    gcc-14.2.0
arm                   randconfig-004-20250212    clang-16
arm                   randconfig-004-20250213    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250212    gcc-14.2.0
arm64                 randconfig-001-20250213    gcc-14.2.0
arm64                 randconfig-002-20250212    gcc-14.2.0
arm64                 randconfig-002-20250213    gcc-14.2.0
arm64                 randconfig-003-20250212    clang-16
arm64                 randconfig-003-20250213    gcc-14.2.0
arm64                 randconfig-004-20250212    gcc-14.2.0
arm64                 randconfig-004-20250213    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250212    gcc-14.2.0
csky                  randconfig-001-20250213    clang-21
csky                  randconfig-002-20250212    gcc-14.2.0
csky                  randconfig-002-20250213    clang-21
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250212    clang-21
hexagon               randconfig-001-20250213    clang-21
hexagon               randconfig-002-20250212    clang-21
hexagon               randconfig-002-20250213    clang-21
i386                             allmodconfig    clang-19
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-19
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-19
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250212    clang-19
i386        buildonly-randconfig-001-20250213    clang-19
i386        buildonly-randconfig-002-20250212    gcc-12
i386        buildonly-randconfig-002-20250213    clang-19
i386        buildonly-randconfig-003-20250212    gcc-12
i386        buildonly-randconfig-003-20250213    clang-19
i386        buildonly-randconfig-004-20250212    gcc-12
i386        buildonly-randconfig-004-20250213    clang-19
i386        buildonly-randconfig-005-20250212    gcc-12
i386        buildonly-randconfig-005-20250213    clang-19
i386        buildonly-randconfig-006-20250212    gcc-12
i386        buildonly-randconfig-006-20250213    clang-19
i386                                defconfig    clang-19
i386                  randconfig-011-20250213    gcc-12
i386                  randconfig-012-20250213    gcc-12
i386                  randconfig-013-20250213    gcc-12
i386                  randconfig-014-20250213    gcc-12
i386                  randconfig-015-20250213    gcc-12
i386                  randconfig-016-20250213    gcc-12
i386                  randconfig-017-20250213    gcc-12
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250212    gcc-14.2.0
loongarch             randconfig-001-20250213    clang-21
loongarch             randconfig-002-20250212    gcc-14.2.0
loongarch             randconfig-002-20250213    clang-21
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250212    gcc-14.2.0
nios2                 randconfig-001-20250213    clang-21
nios2                 randconfig-002-20250212    gcc-14.2.0
nios2                 randconfig-002-20250213    clang-21
openrisc                          allnoconfig    clang-21
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-21
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250212    gcc-14.2.0
parisc                randconfig-001-20250213    clang-21
parisc                randconfig-002-20250212    gcc-14.2.0
parisc                randconfig-002-20250213    clang-21
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-21
powerpc                          allyesconfig    clang-16
powerpc               randconfig-001-20250212    gcc-14.2.0
powerpc               randconfig-001-20250213    clang-21
powerpc               randconfig-002-20250212    clang-16
powerpc               randconfig-002-20250213    clang-21
powerpc               randconfig-003-20250212    gcc-14.2.0
powerpc               randconfig-003-20250213    clang-21
powerpc64             randconfig-001-20250212    clang-16
powerpc64             randconfig-001-20250213    clang-21
powerpc64             randconfig-002-20250212    gcc-14.2.0
powerpc64             randconfig-002-20250213    clang-21
powerpc64             randconfig-003-20250212    gcc-14.2.0
powerpc64             randconfig-003-20250213    clang-21
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    clang-21
riscv                            allyesconfig    clang-21
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250212    clang-21
riscv                 randconfig-001-20250213    clang-21
riscv                 randconfig-002-20250212    clang-18
riscv                 randconfig-002-20250213    clang-21
s390                             allmodconfig    clang-19
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250212    clang-15
s390                  randconfig-001-20250213    clang-21
s390                  randconfig-002-20250212    clang-17
s390                  randconfig-002-20250213    clang-21
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250212    gcc-14.2.0
sh                    randconfig-001-20250213    clang-21
sh                    randconfig-002-20250212    gcc-14.2.0
sh                    randconfig-002-20250213    clang-21
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250212    gcc-14.2.0
sparc                 randconfig-001-20250213    clang-21
sparc                 randconfig-002-20250212    gcc-14.2.0
sparc                 randconfig-002-20250213    clang-21
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250212    gcc-14.2.0
sparc64               randconfig-001-20250213    clang-21
sparc64               randconfig-002-20250212    gcc-14.2.0
sparc64               randconfig-002-20250213    clang-21
um                               allmodconfig    clang-21
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250212    clang-16
um                    randconfig-001-20250213    clang-21
um                    randconfig-002-20250212    gcc-12
um                    randconfig-002-20250213    clang-21
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250212    gcc-11
x86_64      buildonly-randconfig-001-20250213    gcc-12
x86_64      buildonly-randconfig-002-20250212    clang-19
x86_64      buildonly-randconfig-002-20250213    gcc-12
x86_64      buildonly-randconfig-003-20250212    clang-19
x86_64      buildonly-randconfig-003-20250213    gcc-12
x86_64      buildonly-randconfig-004-20250212    clang-19
x86_64      buildonly-randconfig-004-20250213    gcc-12
x86_64      buildonly-randconfig-005-20250212    gcc-12
x86_64      buildonly-randconfig-005-20250213    gcc-12
x86_64      buildonly-randconfig-006-20250212    clang-19
x86_64      buildonly-randconfig-006-20250213    gcc-12
x86_64                              defconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20250213    clang-19
x86_64                randconfig-002-20250213    clang-19
x86_64                randconfig-003-20250213    clang-19
x86_64                randconfig-004-20250213    clang-19
x86_64                randconfig-005-20250213    clang-19
x86_64                randconfig-006-20250213    clang-19
x86_64                randconfig-007-20250213    clang-19
x86_64                randconfig-008-20250213    clang-19
x86_64                randconfig-071-20250213    gcc-12
x86_64                randconfig-072-20250213    gcc-12
x86_64                randconfig-073-20250213    gcc-12
x86_64                randconfig-074-20250213    gcc-12
x86_64                randconfig-075-20250213    gcc-12
x86_64                randconfig-076-20250213    gcc-12
x86_64                randconfig-077-20250213    gcc-12
x86_64                randconfig-078-20250213    gcc-12
x86_64                               rhel-9.4    clang-19
x86_64                           rhel-9.4-bpf    clang-19
x86_64                         rhel-9.4-kunit    clang-19
x86_64                           rhel-9.4-ltp    clang-19
x86_64                          rhel-9.4-rust    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250212    gcc-14.2.0
xtensa                randconfig-001-20250213    clang-21
xtensa                randconfig-002-20250212    gcc-14.2.0
xtensa                randconfig-002-20250213    clang-21

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

