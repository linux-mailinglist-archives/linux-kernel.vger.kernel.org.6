Return-Path: <linux-kernel+bounces-186827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DD78CC9B9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 01:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 587A41F221DA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 23:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9F014C58C;
	Wed, 22 May 2024 23:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QacuUVjV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3D1824B1
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 23:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716420915; cv=none; b=Ohl6MAjKN2PX9aKVvswrRF8Wxp98FI/0UfeRQFT4IqUDlpP2gz7BonHkj3Q8AGpVjgTBsS8Nn8c8G+9X2BD8eVLG5tT37o0FRhQwQ65RDZZrRtNxApC1KWN6FRUoTAyOr5t2mGGsB6zHKM6Yrs7CDMFEvyk4+m9YYaZpm7dEc4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716420915; c=relaxed/simple;
	bh=jVdLvYTaBrUfUTywQdqyz7aiCAuaNK0kvSc8XchDUCU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Jk5nuOyafwRwC9UG/Oi6wKWYUSr7pDMz7SU6JOOulZsllBXs6g7b+iXuOqy+HzpiQgdqd7hQ/cisXWT+TkFJy2AX/aGKy1SCbk257rEw4rvNjemIyUPVSNUySBKFcGvGJVVRs60LsbS3Cg8k1PGZpc+opIi8cmw8zYsHgrxDdko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QacuUVjV; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716420914; x=1747956914;
  h=date:from:to:cc:subject:message-id;
  bh=jVdLvYTaBrUfUTywQdqyz7aiCAuaNK0kvSc8XchDUCU=;
  b=QacuUVjVerqRcyJ37w8DtoYR4XQoHWQBG7uumsIiASI4kUm6p7WAkDBG
   RgIWwBbMwQ8UybIIDrkTq3ij0rgD/TG3Wj9U5rp6bLtDo66qy9rBjDE91
   Zhsfq+XSqY9dG1reg2eR6o+sbpqtneNgHdUupoPKYmgD6bxEu93YNHzmM
   OB1X8Vzd2eV5e7ZAknkMi+zpFgCxevs0BWUzRasg0EXv90tQpoN+aa7fX
   4qO7EdniaD3ZQ7fZ8lmxaRgKMUcRbcLI4a7901AogkRsXLd+AKupOiBo7
   oJOJEO4naXOtD9BIln4bbP9mVfDaHZ+ltzA4BMqeF06sCCf42zg5MkB54
   Q==;
X-CSE-ConnectionGUID: v0//wZ+hQkG6qbjIq/AVPw==
X-CSE-MsgGUID: FqnlINj+QfmUGbT2SY0Oog==
X-IronPort-AV: E=McAfee;i="6600,9927,11080"; a="16498409"
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="16498409"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 16:35:13 -0700
X-CSE-ConnectionGUID: FnsXcpTARImq/N47B9czIw==
X-CSE-MsgGUID: R/ME7pNQQJK0BJGwU4QADA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="56700124"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 22 May 2024 16:35:11 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s9vUC-0002FH-2E;
	Wed, 22 May 2024 23:35:08 +0000
Date: Thu, 23 May 2024 07:35:07 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2024.05.18a] BUILD SUCCESS
 0e3eb8082184e066eb389f5e6f9c7b8c2d452d66
Message-ID: <202405230704.WUaMdtJy-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2024.05.18a
branch HEAD: 0e3eb8082184e066eb389f5e6f9c7b8c2d452d66  rcu/exp: Remove redundant full memory barrier at the end of GP

elapsed time: 1500m

configs tested: 103
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                        nsimosci_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240522   clang
i386         buildonly-randconfig-002-20240522   clang
i386         buildonly-randconfig-002-20240523   gcc  
i386         buildonly-randconfig-003-20240522   gcc  
i386         buildonly-randconfig-004-20240522   clang
i386         buildonly-randconfig-005-20240522   clang
i386         buildonly-randconfig-006-20240522   gcc  
i386         buildonly-randconfig-006-20240523   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240522   clang
i386                  randconfig-001-20240523   gcc  
i386                  randconfig-002-20240522   clang
i386                  randconfig-003-20240522   clang
i386                  randconfig-004-20240522   clang
i386                  randconfig-005-20240522   clang
i386                  randconfig-005-20240523   gcc  
i386                  randconfig-006-20240522   clang
i386                  randconfig-011-20240522   clang
i386                  randconfig-011-20240523   gcc  
i386                  randconfig-012-20240522   gcc  
i386                  randconfig-013-20240522   gcc  
i386                  randconfig-014-20240522   gcc  
i386                  randconfig-014-20240523   gcc  
i386                  randconfig-015-20240522   gcc  
i386                  randconfig-015-20240523   gcc  
i386                  randconfig-016-20240522   gcc  
i386                  randconfig-016-20240523   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                          hp300_defconfig   gcc  
m68k                            mac_defconfig   gcc  
m68k                        mvme16x_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                            defconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                     tqm8560_defconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                                defconfig   clang
sh                                allnoconfig   gcc  
sh                                  defconfig   gcc  
sh                          rsk7264_defconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                           alldefconfig   gcc  
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

