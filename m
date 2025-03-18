Return-Path: <linux-kernel+bounces-566121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A16A67375
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 13:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F18C188A3E4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 12:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED0820AF98;
	Tue, 18 Mar 2025 12:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nbFbj6Bc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B02D202F8E
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 12:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742299571; cv=none; b=EktKzWi56wvk4Pfn2NtkV52Pq+oBvetkh3dvhPFQvsLqLHr3tHncrp/0OM4f80Pj23TpyhgU4E2pGnw7I09ogAgLm+8SUr05FLpENZSKaGXdaNKLvVqalXkKQsqSseXsZh3auNKfnstedR7rxJXtARluzvP1NwEKshJnNgmO6HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742299571; c=relaxed/simple;
	bh=VfPwRuGYVN525gojjUjFNEEOjX4llgFlWxeMzGA/EYc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=rocfXzRtQxkTzMMhFvK7PdMpRv400mVR+cbU+NZ0Gu2+jbvqs2cH9rishkXWiSZKMFbP6IWt0PheZMtCJVvS7kW9M+H76VcBnNSlW8YD/33wuH+jWy/HDqOfE1PBRcTfj4dSMzeZkcINs3y3UOTlnPaVEKziQf4QDmxyfLuE5Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nbFbj6Bc; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742299570; x=1773835570;
  h=date:from:to:cc:subject:message-id;
  bh=VfPwRuGYVN525gojjUjFNEEOjX4llgFlWxeMzGA/EYc=;
  b=nbFbj6BcinTrBzfuCbNV4BMFjiWczQd+ndhg5VnkQ+/5+MmMHq5OuMu0
   yitVRzsas9HNhcALrIsYz9hu4S37I4bzdyK07cB6T3YJCkuq1XUQ2u/+Y
   hOjD/7s82kpC+d4WWE+spXlF3r+SEh/b2g0+zqm764xgfZ0a5KF9xwTod
   FEXiVakWI5e/gT0biOPPtp8HY9PiHWsh+S3bGy3TarII08zQmGzjfwpnF
   IfuplW4/iS9W6JnjmWzjkzrzcWLrkxxrbFS5Mc2plAlCh4Q7EdBOhv+yp
   DW+j3T7AcpKlaz01XV8w8qcomcOgCC459KKwm9BNM5FJBZw9AGpg7AHab
   Q==;
X-CSE-ConnectionGUID: TtPQ1/ksSWGYQ4x4+1eRmA==
X-CSE-MsgGUID: XYF0ZpGISCal+OuIuDznDw==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="54428021"
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; 
   d="scan'208";a="54428021"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 05:06:09 -0700
X-CSE-ConnectionGUID: eTReKuCSRY+HUZl+pBxuug==
X-CSE-MsgGUID: ZgxgERJaS2iUd6+/MSG+7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; 
   d="scan'208";a="121971994"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 18 Mar 2025 05:06:08 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tuVht-000DjJ-0h;
	Tue, 18 Mar 2025 12:06:05 +0000
Date: Tue, 18 Mar 2025 20:05:46 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:objtool/core] BUILD REGRESSION
 73070466ed3b5e4620e03c159ee12a570b171d08
Message-ID: <202503182025.DlkuWWdm-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool/core
branch HEAD: 73070466ed3b5e4620e03c159ee12a570b171d08  objtool: Use O_CREAT with explicit mode mask

Error/Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202503181736.zkZUBv4N-lkp@intel.com

    arch/x86/mm/fault.o: warning: objtool: do_user_addr_fault+0x1e1: skipping duplicate warning(s)

Error/Warning ids grouped by kconfigs:

recent_errors
`-- x86_64-randconfig-074-20250318
    `-- arch-x86-mm-fault.o:warning:objtool:do_user_addr_fault:skipping-duplicate-warning(s)

elapsed time: 1448m

configs tested: 210
configs skipped: 4

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.3.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250317    gcc-13.2.0
arc                   randconfig-002-20250317    gcc-13.2.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-14.2.0
arm                      integrator_defconfig    gcc-14.2.0
arm                      jornada720_defconfig    clang-21
arm                          pxa3xx_defconfig    gcc-14.2.0
arm                   randconfig-001-20250317    gcc-14.2.0
arm                   randconfig-002-20250317    gcc-14.2.0
arm                   randconfig-003-20250317    gcc-14.2.0
arm                   randconfig-004-20250317    clang-21
arm                         socfpga_defconfig    gcc-14.2.0
arm                        spear3xx_defconfig    clang-17
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                             allnoconfig    gcc-8.5.0
arm64                 randconfig-001-20250317    gcc-14.2.0
arm64                 randconfig-002-20250317    gcc-14.2.0
arm64                 randconfig-003-20250317    gcc-14.2.0
arm64                 randconfig-004-20250317    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250317    gcc-14.2.0
csky                  randconfig-001-20250318    gcc-8.5.0
csky                  randconfig-002-20250317    gcc-14.2.0
csky                  randconfig-002-20250318    gcc-8.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250317    clang-21
hexagon               randconfig-001-20250318    gcc-8.5.0
hexagon               randconfig-002-20250317    clang-21
hexagon               randconfig-002-20250318    gcc-8.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250317    gcc-12
i386        buildonly-randconfig-002-20250317    clang-20
i386        buildonly-randconfig-003-20250317    clang-20
i386        buildonly-randconfig-004-20250317    clang-20
i386        buildonly-randconfig-005-20250317    gcc-12
i386        buildonly-randconfig-006-20250317    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250318    clang-20
i386                  randconfig-002-20250318    clang-20
i386                  randconfig-003-20250318    clang-20
i386                  randconfig-004-20250318    clang-20
i386                  randconfig-005-20250318    clang-20
i386                  randconfig-006-20250318    clang-20
i386                  randconfig-007-20250318    clang-20
i386                  randconfig-011-20250318    clang-20
i386                  randconfig-012-20250318    clang-20
i386                  randconfig-013-20250318    clang-20
i386                  randconfig-014-20250318    clang-20
i386                  randconfig-015-20250318    clang-20
i386                  randconfig-016-20250318    clang-20
i386                  randconfig-017-20250318    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250317    gcc-14.2.0
loongarch             randconfig-001-20250318    gcc-8.5.0
loongarch             randconfig-002-20250317    gcc-14.2.0
loongarch             randconfig-002-20250318    gcc-8.5.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-11.5.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                       m5475evb_defconfig    gcc-6.5.0
m68k                        mvme147_defconfig    gcc-14.2.0
m68k                            q40_defconfig    gcc-11.5.0
m68k                           virt_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-9.3.0
microblaze                        allnoconfig    gcc-11.5.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-11.5.0
mips                              allnoconfig    gcc-14.2.0
mips                         rt305x_defconfig    clang-15
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250317    gcc-14.2.0
nios2                 randconfig-001-20250318    gcc-8.5.0
nios2                 randconfig-002-20250317    gcc-14.2.0
nios2                 randconfig-002-20250318    gcc-8.5.0
openrisc                         alldefconfig    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-5.5.0
openrisc                            defconfig    gcc-12
openrisc                       virt_defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-5.5.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-5.5.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250317    gcc-14.2.0
parisc                randconfig-001-20250318    gcc-8.5.0
parisc                randconfig-002-20250317    gcc-14.2.0
parisc                randconfig-002-20250318    gcc-8.5.0
powerpc                    adder875_defconfig    gcc-13.3.0
powerpc                          allmodconfig    gcc-10.5.0
powerpc                          allmodconfig    gcc-5.5.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                          allyesconfig    gcc-5.5.0
powerpc                        cell_defconfig    gcc-14.2.0
powerpc                      ppc44x_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250317    clang-15
powerpc               randconfig-001-20250318    gcc-8.5.0
powerpc               randconfig-002-20250317    clang-21
powerpc               randconfig-002-20250318    gcc-8.5.0
powerpc               randconfig-003-20250317    gcc-14.2.0
powerpc               randconfig-003-20250318    gcc-8.5.0
powerpc64             randconfig-001-20250317    gcc-14.2.0
powerpc64             randconfig-001-20250318    gcc-8.5.0
powerpc64             randconfig-002-20250317    gcc-14.2.0
powerpc64             randconfig-002-20250318    gcc-8.5.0
powerpc64             randconfig-003-20250317    clang-21
powerpc64             randconfig-003-20250318    gcc-8.5.0
riscv                            allmodconfig    clang-21
riscv                            allmodconfig    gcc-5.5.0
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-5.5.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250317    gcc-14.2.0
riscv                 randconfig-002-20250317    gcc-14.2.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250317    clang-15
s390                  randconfig-002-20250317    clang-15
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-11.5.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                         ecovec24_defconfig    gcc-14.2.0
sh                          lboxre2_defconfig    gcc-14.2.0
sh                    randconfig-001-20250317    gcc-14.2.0
sh                    randconfig-002-20250317    gcc-14.2.0
sh                      rts7751r2d1_defconfig    gcc-14.2.0
sh                        sh7785lcr_defconfig    gcc-14.2.0
sh                              ul2_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-11.5.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250317    gcc-14.2.0
sparc                 randconfig-002-20250317    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250317    gcc-14.2.0
sparc64               randconfig-002-20250317    gcc-14.2.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250317    gcc-12
um                    randconfig-002-20250317    clang-21
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250317    gcc-12
x86_64      buildonly-randconfig-002-20250317    clang-20
x86_64      buildonly-randconfig-003-20250317    gcc-12
x86_64      buildonly-randconfig-004-20250317    gcc-12
x86_64      buildonly-randconfig-005-20250317    gcc-12
x86_64      buildonly-randconfig-006-20250317    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250318    gcc-12
x86_64                randconfig-002-20250318    gcc-12
x86_64                randconfig-003-20250318    gcc-12
x86_64                randconfig-004-20250318    gcc-12
x86_64                randconfig-005-20250318    gcc-12
x86_64                randconfig-006-20250318    gcc-12
x86_64                randconfig-007-20250318    gcc-12
x86_64                randconfig-008-20250318    gcc-12
x86_64                randconfig-071-20250318    gcc-12
x86_64                randconfig-072-20250318    gcc-12
x86_64                randconfig-073-20250318    gcc-12
x86_64                randconfig-074-20250318    gcc-12
x86_64                randconfig-075-20250318    gcc-12
x86_64                randconfig-076-20250318    gcc-12
x86_64                randconfig-077-20250318    gcc-12
x86_64                randconfig-078-20250318    gcc-12
x86_64                               rhel-9.4    clang-20
xtensa                            allnoconfig    gcc-11.5.0
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250317    gcc-14.2.0
xtensa                randconfig-002-20250317    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

