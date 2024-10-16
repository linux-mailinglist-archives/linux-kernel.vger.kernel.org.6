Return-Path: <linux-kernel+bounces-368555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8D49A1143
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 20:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43F80286B16
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 18:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36313210195;
	Wed, 16 Oct 2024 18:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bHnmoTPN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D755618870B
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 18:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729102179; cv=none; b=YgZXrlwMKiBG6iZGS52ymHxR8GEE7m1mMLi9gH4I8Lhh5/oc+B9uyvzjuf1sP8uUNueCShQefMepBpAAOcsrKL+C8pBp6eKno3zDw8BGpqZNnKt4sCoyX0sFX3+Y6fEXpoPPxN536JsL10PJUPKptoWfJH51xWZ/ES3L5bZ8LI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729102179; c=relaxed/simple;
	bh=SlAocYZ3mb0F45c+uVHzGbBW3wC1i9y/4nJTYKIStHw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=oQ5/mIwxVz9J9exBCigFEGj+z5ljv4JTRdLAqifhyCxCdP35dSNI1SM7sbZg/K/YYPFqBd/3XsI9vKLIULdxO4DjQcpsmqkTJFzDemhjNuixNwOTds7XkmpPeBuLhbt/82QloPF0sgrNcMy0TVwaYifzCItf7NfietfNcLyH53A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bHnmoTPN; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729102178; x=1760638178;
  h=date:from:to:cc:subject:message-id;
  bh=SlAocYZ3mb0F45c+uVHzGbBW3wC1i9y/4nJTYKIStHw=;
  b=bHnmoTPNef97NR88dQbPO7Me/XBosoHAmRLhMZ8noKWaJdP8rihawewv
   cyRR9K3f+ZInm0gLns2rihGMQhhE5MshAK6BN5UegGoB9CrexwzNblNRp
   WoKDDap8xmtWTaQlZAm+VGpIkHykoZJVx78uxGwlyvjz2TSbuU8ftvyWY
   gCjywnoyczHDAASNI7cM1YvbH9/o1g0zqgVn4HmohcpaVcgE36zAbIrKy
   cyrkxeP6kIkZknQsYktY88C56bBahY2B1L8c025/7CW2+OPJviiaMsp9F
   InLkaX9FtOQza8CvN5WRZD8+PL6LDEbJAcPkeosiRP4ljdIwKiC/bz56X
   w==;
X-CSE-ConnectionGUID: j5sXZU+wS7eHLZ9IY8DxTw==
X-CSE-MsgGUID: VE3FrNEjRUyd2v6k5vH1Jg==
X-IronPort-AV: E=McAfee;i="6700,10204,11226"; a="31430119"
X-IronPort-AV: E=Sophos;i="6.11,208,1725346800"; 
   d="scan'208";a="31430119"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 11:09:37 -0700
X-CSE-ConnectionGUID: Vt4iutw4SK24+5FA2jaVeA==
X-CSE-MsgGUID: UGAfSVg3RBOB/NoiwkpU9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="83129526"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 16 Oct 2024 11:09:36 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t18Sj-000LE4-2s;
	Wed, 16 Oct 2024 18:09:33 +0000
Date: Thu, 17 Oct 2024 02:08:59 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:timers/vdso] BUILD SUCCESS
 6febe0efb2df49105b839d6a3a45ab63d40f315a
Message-ID: <202410170250.Fxmg9iFp-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/vdso
branch HEAD: 6febe0efb2df49105b839d6a3a45ab63d40f315a  s390: Remove remaining _PAGE_* macros

elapsed time: 1160m

configs tested: 97
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                                 defconfig    gcc-14.1.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                                 defconfig    gcc-14.1.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
i386                             allmodconfig    clang-18
i386                              allnoconfig    clang-18
i386                             allyesconfig    clang-18
i386        buildonly-randconfig-001-20241016    gcc-11
i386        buildonly-randconfig-002-20241016    gcc-11
i386        buildonly-randconfig-003-20241016    gcc-11
i386        buildonly-randconfig-004-20241016    gcc-11
i386        buildonly-randconfig-005-20241016    gcc-11
i386        buildonly-randconfig-006-20241016    gcc-11
i386                                defconfig    clang-18
i386                  randconfig-001-20241016    gcc-11
i386                  randconfig-002-20241016    gcc-11
i386                  randconfig-003-20241016    gcc-11
i386                  randconfig-004-20241016    gcc-11
i386                  randconfig-005-20241016    gcc-11
i386                  randconfig-006-20241016    gcc-11
i386                  randconfig-011-20241016    gcc-11
i386                  randconfig-012-20241016    gcc-11
i386                  randconfig-013-20241016    gcc-11
i386                  randconfig-014-20241016    gcc-11
i386                  randconfig-015-20241016    gcc-11
i386                  randconfig-016-20241016    gcc-11
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc64                            defconfig    gcc-14.1.0
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
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64                              defconfig    clang-18
x86_64                                  kexec    gcc-12
x86_64                               rhel-8.3    gcc-12
x86_64                           rhel-8.3-bpf    clang-18
x86_64                         rhel-8.3-kunit    clang-18
x86_64                           rhel-8.3-ltp    clang-18
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

