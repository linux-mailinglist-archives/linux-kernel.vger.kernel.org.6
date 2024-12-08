Return-Path: <linux-kernel+bounces-436311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 550BF9E8434
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 09:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DECA281AE9
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 08:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA33E7C6E6;
	Sun,  8 Dec 2024 08:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N/FFCoyF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4238D28691
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 08:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733646272; cv=none; b=DdRUPTG9+rgv+j6wHWey6bRoDeggapbMojcBEGTC7hi2OpF87c29n9NoYG9HUaYTcC9Ar7exshsrjGX3mLthz3KZP7+kWQcv8tocfrNVfJXeGu4IsaXk8nj2Nq6ooBXkcQJN6dxaioDakMz+2c7sghUzr7x/rAiQKFw4CVVlsko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733646272; c=relaxed/simple;
	bh=HkCVgspXai31wZKd1BMvY47rJ/DhRI9upSSOumY4WUk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=itjttDDRYjAgjDj9kwjdWGH8C55zYVSHxLBSaxRk18d0rtbys/NZQAGzGcmOPf10RyeHTT8zz8vfERHP86wNtHYz7gl0Ji0mAke5CuWK696WYwXGSBzLQfE743fs3zHFJR3CdXeLaxnE9G2n0blHopj+Wt6xSLBkmPPHgjk/rs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N/FFCoyF; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733646270; x=1765182270;
  h=date:from:to:cc:subject:message-id;
  bh=HkCVgspXai31wZKd1BMvY47rJ/DhRI9upSSOumY4WUk=;
  b=N/FFCoyFHPbv/1Ut88JRcEJ+n7o2YvInpd56IXFUpRqhqlyQitH+GIgq
   LfyfMHUmW99E2Tjrc4Crtfp3tPHFwdcFJisROXN5Z2Oe84+gftwro2w5m
   gn8ZlNmDRBA3/KlYjdf/urCEzdsykCAnzAyeXHXO7Z1Ng0jxxDe9ri/H6
   qrC9+cyJJdFtc2m0IAdWbMNz3ezYS6q6HlnefiDYER0t+w0e0/rTXPpXo
   8KTlyaLlgl0gLgERdYvbWtU7KbHxwpxVa+510okofgU0S0uTjiUIWm6Ja
   fkMAgv7k2j6CN8spRJUP9H6sobEeWfZyr3OR+RsaMqbASPAxN/RYdJVtU
   A==;
X-CSE-ConnectionGUID: ejQX58Z2QA+XKi1KOWSYuw==
X-CSE-MsgGUID: j5v4a8/zQXakvE6qBBv8Fw==
X-IronPort-AV: E=McAfee;i="6700,10204,11279"; a="34107263"
X-IronPort-AV: E=Sophos;i="6.12,216,1728975600"; 
   d="scan'208";a="34107263"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2024 00:24:30 -0800
X-CSE-ConnectionGUID: gCysyQ1oSkys9HRpuMxTUg==
X-CSE-MsgGUID: QbbxAuilSFWF4NsAjwZ+VA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,216,1728975600"; 
   d="scan'208";a="132182918"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 08 Dec 2024 00:24:28 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tKCaY-0003DC-1R;
	Sun, 08 Dec 2024 08:24:26 +0000
Date: Sun, 08 Dec 2024 16:20:41 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2024.12.06a] BUILD SUCCESS
 f63522f041948f5f7f0f9720e944e1f62bdab03a
Message-ID: <202412081631.DyyLKpj4-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2024.12.06a
branch HEAD: f63522f041948f5f7f0f9720e944e1f62bdab03a  rcutorture: Add ftrace-compatible timestamp to GP# failure/close-call output

elapsed time: 721m

configs tested: 212
configs skipped: 10

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    clang-20
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-18
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-18
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-13.2.0
arc                                 defconfig    gcc-14.2.0
arc                   randconfig-001-20241208    gcc-13.2.0
arc                   randconfig-002-20241208    gcc-13.2.0
arm                              allmodconfig    clang-18
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-18
arm                              allyesconfig    gcc-14.2.0
arm                                 defconfig    clang-20
arm                                 defconfig    gcc-14.2.0
arm                          ep93xx_defconfig    clang-20
arm                   milbeaut_m10v_defconfig    clang-20
arm                       multi_v4t_defconfig    clang-18
arm                       multi_v4t_defconfig    clang-20
arm                        multi_v7_defconfig    gcc-14.2.0
arm                            qcom_defconfig    clang-15
arm                   randconfig-001-20241208    gcc-14.2.0
arm                   randconfig-002-20241208    clang-20
arm                   randconfig-003-20241208    gcc-14.2.0
arm                   randconfig-004-20241208    gcc-14.2.0
arm                         wpcm450_defconfig    gcc-14.2.0
arm64                            alldefconfig    clang-20
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20241208    gcc-14.2.0
arm64                 randconfig-002-20241208    gcc-14.2.0
arm64                 randconfig-003-20241208    gcc-14.2.0
arm64                 randconfig-004-20241208    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20241208    gcc-14.2.0
csky                  randconfig-002-20241208    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    clang-20
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-002-20241208    clang-20
i386                             allmodconfig    clang-19
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-19
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-19
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241208    gcc-12
i386        buildonly-randconfig-002-20241208    clang-19
i386        buildonly-randconfig-003-20241208    gcc-11
i386        buildonly-randconfig-004-20241208    gcc-12
i386        buildonly-randconfig-005-20241208    clang-19
i386        buildonly-randconfig-006-20241208    clang-19
i386                                defconfig    clang-19
i386                  randconfig-001-20241208    gcc-12
i386                  randconfig-002-20241208    gcc-12
i386                  randconfig-003-20241208    gcc-12
i386                  randconfig-004-20241208    gcc-12
i386                  randconfig-005-20241208    gcc-12
i386                  randconfig-006-20241208    gcc-12
i386                  randconfig-007-20241208    gcc-12
i386                  randconfig-011-20241208    clang-19
i386                  randconfig-012-20241208    clang-19
i386                  randconfig-013-20241208    clang-19
i386                  randconfig-014-20241208    clang-19
i386                  randconfig-015-20241208    clang-19
i386                  randconfig-016-20241208    clang-19
i386                  randconfig-017-20241208    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20241208    gcc-14.2.0
loongarch             randconfig-002-20241208    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                          atari_defconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                      bmips_stb_defconfig    clang-18
mips                            gpr_defconfig    clang-20
mips                           ip22_defconfig    clang-15
mips                           ip28_defconfig    clang-18
mips                           jazz_defconfig    clang-18
mips                         rt305x_defconfig    clang-19
mips                        vocore2_defconfig    clang-15
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20241208    gcc-14.2.0
nios2                 randconfig-002-20241208    gcc-14.2.0
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20241208    gcc-14.2.0
parisc                randconfig-002-20241208    gcc-14.2.0
parisc64                            defconfig    gcc-14.1.0
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                 canyonlands_defconfig    clang-18
powerpc                       holly_defconfig    clang-20
powerpc                      mgcoge_defconfig    clang-18
powerpc                  mpc885_ads_defconfig    clang-20
powerpc                    mvme5100_defconfig    clang-15
powerpc               randconfig-001-20241208    clang-20
powerpc               randconfig-002-20241208    gcc-14.2.0
powerpc               randconfig-003-20241208    clang-20
powerpc                     stx_gp3_defconfig    clang-20
powerpc                     tqm5200_defconfig    gcc-14.2.0
powerpc                     tqm8555_defconfig    clang-15
powerpc64             randconfig-001-20241208    gcc-14.2.0
powerpc64             randconfig-002-20241208    clang-18
powerpc64             randconfig-003-20241208    gcc-14.2.0
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                               defconfig    clang-19
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20241208    gcc-14.2.0
riscv                 randconfig-002-20241208    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                                defconfig    gcc-12
s390                  randconfig-001-20241208    gcc-14.2.0
s390                  randconfig-002-20241208    clang-17
s390                  randconfig-002-20241208    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                                  defconfig    gcc-14.2.0
sh                             espt_defconfig    clang-18
sh                          r7780mp_defconfig    clang-15
sh                          r7780mp_defconfig    gcc-14.2.0
sh                    randconfig-001-20241208    gcc-14.2.0
sh                    randconfig-002-20241208    gcc-14.2.0
sh                           se7712_defconfig    gcc-14.2.0
sh                           se7724_defconfig    gcc-14.2.0
sparc                            alldefconfig    clang-18
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20241208    gcc-14.2.0
sparc                 randconfig-002-20241208    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20241208    gcc-14.2.0
sparc64               randconfig-002-20241208    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-18
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241208    clang-16
um                    randconfig-001-20241208    gcc-14.2.0
um                    randconfig-002-20241208    gcc-12
um                    randconfig-002-20241208    gcc-14.2.0
um                           x86_64_defconfig    clang-15
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241208    gcc-12
x86_64      buildonly-randconfig-002-20241208    clang-19
x86_64      buildonly-randconfig-003-20241208    gcc-12
x86_64      buildonly-randconfig-004-20241208    clang-19
x86_64      buildonly-randconfig-005-20241208    clang-19
x86_64      buildonly-randconfig-006-20241208    gcc-12
x86_64                              defconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20241208    gcc-12
x86_64                randconfig-002-20241208    gcc-12
x86_64                randconfig-003-20241208    gcc-12
x86_64                randconfig-004-20241208    gcc-12
x86_64                randconfig-005-20241208    gcc-12
x86_64                randconfig-006-20241208    gcc-12
x86_64                randconfig-007-20241208    gcc-12
x86_64                randconfig-008-20241208    gcc-12
x86_64                               rhel-9.4    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                       common_defconfig    clang-20
xtensa                randconfig-001-20241208    gcc-14.2.0
xtensa                randconfig-002-20241208    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

