Return-Path: <linux-kernel+bounces-547690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67686A50C6C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 21:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7897C1890632
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 20:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DD5254878;
	Wed,  5 Mar 2025 20:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HSdYE21N"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4702117B50B
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 20:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741206302; cv=none; b=AUzfKkFnAAuCG9MV4TlAH3MQTeNZdsQR+UWpfVftwh/K0jJUOp65srF5/tqlt7uJyEC9RO1g7at8eONQzWw0/9r6+zlghlegtziU/7EJvP4S6p0nbbm1amgm4zu3rivVvUtS/P8vI7wThLTPvujQ5iLV6GgGcoamNyzXpwXhmqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741206302; c=relaxed/simple;
	bh=LITcmbYOmX1Ef3agqaz8UzAYkxEuMuSsqMVXF4imVfk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=XZ98HPE7vV4209e7BcG4DHhQ3e9dEwyIJr4IH52JsJm7I3RVKQ+Ld83HbmGTPSsB+oG5qjoPe009flcVXK9K6CW3VmmO0WelbSFiVhK+zZOuXiw1lnKC9oXaW45RvAoG4UrJYVc0ngVmFpSU2/D+/BSSXIr2hYGNv2wEler42k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HSdYE21N; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741206300; x=1772742300;
  h=date:from:to:cc:subject:message-id;
  bh=LITcmbYOmX1Ef3agqaz8UzAYkxEuMuSsqMVXF4imVfk=;
  b=HSdYE21Ns2KbGgGFt9WtWiu1jjhCKuoneW2/k/XUg47OpFKIt15K1yC9
   /pM6IjaVBjl9EvzAe5AqycxYvwS9y+3n97C1ADPMHyidVpS6vYlMCbxqX
   VPA4aZF2+NKk2PdkveWwyjuOWpSFLUkuYDSjZ2wzBOMvTwUC8M1CQwNa+
   sQTqSNFsJ4Q9AtdcUp2hgLxqctSDsnA0e+K9XSqUbDdlnWmCSeQDL/Mem
   0TgfEg7iWRLVG/0LXHkoRn8TtEMYpwKBM9yyURg5oZqzDzeEVXMIelSE0
   PK7HEAACLjtgamtaqwaoh2/4DMeVuyh4sX7cp1JIWbrN2p3snmB4i92cc
   g==;
X-CSE-ConnectionGUID: 9RptVMN3QLSay/JEfXYNFw==
X-CSE-MsgGUID: MB+f1u5aTMWj2bq2NvtN4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="52837950"
X-IronPort-AV: E=Sophos;i="6.14,224,1736841600"; 
   d="scan'208";a="52837950"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 12:24:59 -0800
X-CSE-ConnectionGUID: cDou8CVZRB2jKLmCpMg6DA==
X-CSE-MsgGUID: p/LfVUSJRQmO0KpYeu1AjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119304676"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 05 Mar 2025 12:24:59 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tpvIW-000MAf-0J;
	Wed, 05 Mar 2025 20:24:56 +0000
Date: Thu, 06 Mar 2025 04:24:54 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/core] BUILD SUCCESS
 6d536cad0d55e71442b6d65500f74eb85544269e
Message-ID: <202503060448.Cfx2vElf-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/core
branch HEAD: 6d536cad0d55e71442b6d65500f74eb85544269e  x86/percpu: Fix __per_cpu_hot_end marker

elapsed time: 1456m

configs tested: 87
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250305    gcc-13.2.0
arc                   randconfig-002-20250305    gcc-13.2.0
arm                               allnoconfig    clang-17
arm                   randconfig-001-20250305    gcc-14.2.0
arm                   randconfig-002-20250305    clang-19
arm                   randconfig-003-20250305    gcc-14.2.0
arm                   randconfig-004-20250305    gcc-14.2.0
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250305    clang-15
arm64                 randconfig-002-20250305    gcc-14.2.0
arm64                 randconfig-003-20250305    clang-21
arm64                 randconfig-004-20250305    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250305    gcc-14.2.0
csky                  randconfig-002-20250305    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250305    clang-21
hexagon               randconfig-002-20250305    clang-18
i386                              allnoconfig    gcc-12
i386        buildonly-randconfig-001-20250305    clang-19
i386        buildonly-randconfig-002-20250305    clang-19
i386        buildonly-randconfig-003-20250305    clang-19
i386        buildonly-randconfig-004-20250305    clang-19
i386        buildonly-randconfig-005-20250305    clang-19
i386        buildonly-randconfig-006-20250305    gcc-12
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250305    gcc-14.2.0
loongarch             randconfig-002-20250305    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250305    gcc-14.2.0
nios2                 randconfig-002-20250305    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                randconfig-001-20250305    gcc-14.2.0
parisc                randconfig-002-20250305    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc               randconfig-001-20250305    clang-17
powerpc               randconfig-002-20250305    gcc-14.2.0
powerpc               randconfig-003-20250305    gcc-14.2.0
powerpc64             randconfig-001-20250305    clang-19
powerpc64             randconfig-002-20250305    clang-17
powerpc64             randconfig-003-20250305    clang-19
riscv                             allnoconfig    gcc-14.2.0
riscv                 randconfig-001-20250305    clang-19
riscv                 randconfig-002-20250305    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250305    gcc-14.2.0
s390                  randconfig-002-20250305    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250305    gcc-14.2.0
sh                    randconfig-002-20250305    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250305    gcc-14.2.0
sparc                 randconfig-002-20250305    gcc-14.2.0
sparc64               randconfig-001-20250305    gcc-14.2.0
sparc64               randconfig-002-20250305    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                    randconfig-001-20250305    clang-19
um                    randconfig-002-20250305    gcc-12
x86_64                            allnoconfig    clang-19
x86_64      buildonly-randconfig-001-20250305    clang-19
x86_64      buildonly-randconfig-002-20250305    gcc-12
x86_64      buildonly-randconfig-003-20250305    clang-19
x86_64      buildonly-randconfig-004-20250305    gcc-12
x86_64      buildonly-randconfig-005-20250305    clang-19
x86_64      buildonly-randconfig-006-20250305    clang-19
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250305    gcc-14.2.0
xtensa                randconfig-002-20250305    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

