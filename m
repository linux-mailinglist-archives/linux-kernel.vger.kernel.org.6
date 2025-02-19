Return-Path: <linux-kernel+bounces-521562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F62A3BF37
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 319EF7A392D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 12:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81E21F3D56;
	Wed, 19 Feb 2025 12:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ecYMrc2X"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941C11EB182
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 12:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739969787; cv=none; b=e2YUso9jUuYzdlhKlGZHMNaYx/e1CGTMqF41HX1f7SyNNk16AelC6xsvl/a3Jhym5ZfMMbddVjRzEClac47iV/iJTAewp73Gdgy5P5m52FvSpNzy6BiznlEyoeFSAeBnFDh8dtDx61S+LWF6WyHONxSXf6REQy3Nip//LmnDPQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739969787; c=relaxed/simple;
	bh=djm3bSqqMFiJPZXoFKOM5o9qiWNrV5HfpcFW0n6az2Q=;
	h=Date:From:To:Cc:Subject:Message-ID; b=AoKvhAUbn6LMFGBiWxiRRv5g3DJNqDSI849d1QjS9nE6347cldT+Y0+qBnwYUsg4JOW9qZ6eZMjpbSJIMrqduFxDAKD/R0Nb6MFp9EHBGS0BEmB0VcAsv/UiFggpnEwrGi3aH//DHUkrBbU54Ez33jeqZBtSvfjuyZ7EAcQCWJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ecYMrc2X; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739969786; x=1771505786;
  h=date:from:to:cc:subject:message-id;
  bh=djm3bSqqMFiJPZXoFKOM5o9qiWNrV5HfpcFW0n6az2Q=;
  b=ecYMrc2X+jcrzQl1Fo9CZu/RSkDlsSZ60IOBrKoDBQ7qGC3EQ84OerzY
   TQUvjm05ari82zcFoHnLdvKfdLQAGC7aDyXVMTKbCnGRamEJ0Ce2PJVex
   cdnzwrAtgwyW1BMQWciAcANPoftTze0ZmIdxHp6UTS16QSLbUVR0Zq63H
   wK9f8AWFP6TvaifqBEqc+1JwDAOTXypH+hLKFJAaCR8WcJplmkFm0H3mZ
   iZAEB5wbSOysFdLkI3hfh77HgN+KLb/UjoX48SiETm4oiG3hOHQ83v/iu
   cIbJQNRKnA5SpfpYIhb4mnn0eJgI+A1jXQkmabkCMt9Bl2q/Pqp9NX0ro
   w==;
X-CSE-ConnectionGUID: TtG4gEMtRFe9s7SDCTaFfw==
X-CSE-MsgGUID: /xc/u2olRIi3Qi+/HApE8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="40843867"
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="40843867"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 04:56:25 -0800
X-CSE-ConnectionGUID: Nn0IO18xRfOwjIVba7fSUw==
X-CSE-MsgGUID: PPHugwYaRFSK+VJ2DGV3eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="119682197"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 19 Feb 2025 04:56:24 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tkjcj-0002yW-1H;
	Wed, 19 Feb 2025 12:56:21 +0000
Date: Wed, 19 Feb 2025 20:56:03 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/asm] BUILD SUCCESS
 01157ddc58dc2fe428ec17dd5a18cc13f134639f
Message-ID: <202502192057.xnlg5huT-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/asm
branch HEAD: 01157ddc58dc2fe428ec17dd5a18cc13f134639f  kallsyms: Remove KALLSYMS_ABSOLUTE_PERCPU

elapsed time: 1461m

configs tested: 101
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250218    gcc-13.2.0
arc                   randconfig-002-20250218    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                   randconfig-001-20250218    gcc-14.2.0
arm                   randconfig-002-20250218    gcc-14.2.0
arm                   randconfig-003-20250218    gcc-14.2.0
arm                   randconfig-004-20250218    clang-21
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250218    clang-21
arm64                 randconfig-002-20250218    clang-21
arm64                 randconfig-003-20250218    gcc-14.2.0
arm64                 randconfig-004-20250218    clang-16
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250218    gcc-14.2.0
csky                  randconfig-002-20250218    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250218    clang-17
hexagon               randconfig-002-20250218    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250218    gcc-12
i386        buildonly-randconfig-002-20250218    gcc-12
i386        buildonly-randconfig-003-20250218    gcc-12
i386        buildonly-randconfig-004-20250218    clang-19
i386        buildonly-randconfig-005-20250218    clang-19
i386        buildonly-randconfig-006-20250218    gcc-12
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250218    gcc-14.2.0
loongarch             randconfig-002-20250218    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250218    gcc-14.2.0
nios2                 randconfig-002-20250218    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                randconfig-001-20250218    gcc-14.2.0
parisc                randconfig-002-20250218    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc               randconfig-001-20250218    gcc-14.2.0
powerpc               randconfig-002-20250218    gcc-14.2.0
powerpc               randconfig-003-20250218    clang-21
powerpc64             randconfig-001-20250218    gcc-14.2.0
powerpc64             randconfig-002-20250218    clang-16
powerpc64             randconfig-003-20250218    clang-18
riscv                             allnoconfig    gcc-14.2.0
riscv                 randconfig-001-20250218    gcc-14.2.0
riscv                 randconfig-002-20250218    clang-21
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250218    clang-21
s390                  randconfig-002-20250218    clang-15
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250218    gcc-14.2.0
sh                    randconfig-002-20250218    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250218    gcc-14.2.0
sparc                 randconfig-002-20250218    gcc-14.2.0
sparc64               randconfig-001-20250218    gcc-14.2.0
sparc64               randconfig-002-20250218    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                    randconfig-001-20250218    clang-21
um                    randconfig-002-20250218    gcc-11
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250218    clang-19
x86_64      buildonly-randconfig-002-20250218    gcc-12
x86_64      buildonly-randconfig-003-20250218    clang-19
x86_64      buildonly-randconfig-004-20250218    gcc-12
x86_64      buildonly-randconfig-005-20250218    clang-19
x86_64      buildonly-randconfig-006-20250218    clang-19
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250218    gcc-14.2.0
xtensa                randconfig-002-20250218    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

