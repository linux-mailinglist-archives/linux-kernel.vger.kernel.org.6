Return-Path: <linux-kernel+bounces-381193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1829AFBD0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 10:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0007284A99
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 08:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB3B1CF28B;
	Fri, 25 Oct 2024 08:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y8HH13wg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C593518C029
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 08:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729843252; cv=none; b=km+7OKTQlNEX1cX3Dn0wRA+vchecKr1BugM/g+dSlLJyIzbFFyJk+7w5BNRFqL6am2ncghgr2A3KtkUr9aL4nnXYV9iOwJ09rHYO5Enaxqc7MQeyB+EDAn6FbFUN5vTwJaMaS0+X8hN7jVIz9diqXBlgVEWyHgf5oU5dbFuqp0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729843252; c=relaxed/simple;
	bh=zv30xYKrNCQuaF2zMBjZdO40MgzF+2o3jMkB3kTNlzQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=sJT8O85S7fuumuz5yVBqPlxTzyTrbCH9/MAMV0LbykGH0M6/zgn6XTH17zxRdsvCJ6mwug/7a0oG1aKfIR370FdVaY/zjhLK4YXqvor6bYJurUdGg9haHK+QoZogq5Mossc61B9ldxKuRhc+zIa3BNMbDX4+fG51j3zDUwbcQ/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y8HH13wg; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729843250; x=1761379250;
  h=date:from:to:cc:subject:message-id;
  bh=zv30xYKrNCQuaF2zMBjZdO40MgzF+2o3jMkB3kTNlzQ=;
  b=Y8HH13wgcPA2pP5xfZqyy3QDMGHYm74ZTdjbzJTHuutX7zHkVk/mLKiG
   3ZcJr9sngchAfc8B3Ghi1xBAwoTrqyt2AntUOHTARF2IJ9sgtNlYv7nnl
   bFdN+I43nC+OeF+Cd8EsX7CqA1C0dhl9PDCRBFB2wxElvq41GC9nKkLt+
   p17QHCbHaP28eWi3qH1jknOLeU659oUfdqiNdINK5p+AIHQoJVGiqdYN3
   hrRUITPpX3KWnrXz6V2Bs+Q6Xggd2y7lUEPu1xlw1/PzrB5/KA/Mo3DbX
   UHhGLHlnE2Qt7aDWnt5hriCBUhGi83A0CjCdsh4HYmKcVyXQ3tt2FoJ/i
   Q==;
X-CSE-ConnectionGUID: RpGvKmlbSBORNmNqR1o0vg==
X-CSE-MsgGUID: 8tyEPagFQXukd1OPw3X4AQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29448929"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29448929"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 01:00:50 -0700
X-CSE-ConnectionGUID: n6d1om5JR8C26DZQkyVvjw==
X-CSE-MsgGUID: lUieayMRRsWUcAur/FHQMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="85430391"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 25 Oct 2024 01:00:49 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t4FFW-000XoG-0Q;
	Fri, 25 Oct 2024 08:00:46 +0000
Date: Fri, 25 Oct 2024 15:59:47 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:irq/core] BUILD SUCCESS
 2396eefa075a31884d3336e1e94db47a0bd2a456
Message-ID: <202410251539.TYjZ7YR8-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
branch HEAD: 2396eefa075a31884d3336e1e94db47a0bd2a456  genirq/devres: Don't free interrupt which is not managed by devres

elapsed time: 1354m

configs tested: 155
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
arm                         lpc32xx_defconfig    gcc-14.1.0
arm                       multi_v4t_defconfig    clang-20
arm                            qcom_defconfig    clang-20
arm                         s3c6400_defconfig    gcc-14.1.0
arm                          sp7021_defconfig    gcc-14.1.0
arm                        vexpress_defconfig    clang-20
arm                    vt8500_v6_v7_defconfig    gcc-14.1.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
i386                             alldefconfig    gcc-14.1.0
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                             allyesconfig    clang-19
i386        buildonly-randconfig-001-20241025    gcc-12
i386        buildonly-randconfig-002-20241025    gcc-12
i386        buildonly-randconfig-003-20241025    gcc-12
i386        buildonly-randconfig-004-20241025    gcc-12
i386        buildonly-randconfig-005-20241025    gcc-12
i386        buildonly-randconfig-006-20241025    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20241025    gcc-12
i386                  randconfig-002-20241025    gcc-12
i386                  randconfig-003-20241025    gcc-12
i386                  randconfig-004-20241025    gcc-12
i386                  randconfig-005-20241025    gcc-12
i386                  randconfig-006-20241025    gcc-12
i386                  randconfig-011-20241025    gcc-12
i386                  randconfig-012-20241025    gcc-12
i386                  randconfig-013-20241025    gcc-12
i386                  randconfig-014-20241025    gcc-12
i386                  randconfig-015-20241025    gcc-12
i386                  randconfig-016-20241025    gcc-12
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
m68k                       m5208evb_defconfig    clang-20
m68k                       m5475evb_defconfig    clang-20
m68k                        stmark2_defconfig    clang-20
microblaze                       alldefconfig    clang-20
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                         db1xxx_defconfig    clang-20
mips                           gcw0_defconfig    clang-20
mips                            gpr_defconfig    gcc-14.1.0
mips                           jazz_defconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.1.0
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.1.0
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.1.0
powerpc                          allyesconfig    gcc-14.1.0
powerpc                      cm5200_defconfig    clang-20
powerpc                 mpc834x_itx_defconfig    clang-20
powerpc                     sequoia_defconfig    gcc-14.1.0
powerpc                     tqm5200_defconfig    clang-20
powerpc                      tqm8xx_defconfig    gcc-14.1.0
powerpc                        warp_defconfig    gcc-14.1.0
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.1.0
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                          debug_defconfig    clang-20
s390                                defconfig    gcc-12
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                         ecovec24_defconfig    gcc-14.1.0
sh                        edosk7705_defconfig    gcc-14.1.0
sh                          kfr2r09_defconfig    gcc-14.1.0
sh                     magicpanelr2_defconfig    gcc-14.1.0
sh                           se7619_defconfig    clang-20
sh                           se7619_defconfig    gcc-14.1.0
sh                           se7705_defconfig    gcc-14.1.0
sh                              ul2_defconfig    clang-20
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241025    gcc-12
x86_64      buildonly-randconfig-002-20241025    gcc-12
x86_64      buildonly-randconfig-003-20241025    gcc-12
x86_64      buildonly-randconfig-004-20241025    gcc-12
x86_64      buildonly-randconfig-005-20241025    gcc-12
x86_64      buildonly-randconfig-006-20241025    gcc-12
x86_64                              defconfig    clang-19
x86_64                                  kexec    clang-19
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20241025    gcc-12
x86_64                randconfig-002-20241025    gcc-12
x86_64                randconfig-003-20241025    gcc-12
x86_64                randconfig-004-20241025    gcc-12
x86_64                randconfig-005-20241025    gcc-12
x86_64                randconfig-006-20241025    gcc-12
x86_64                randconfig-011-20241025    gcc-12
x86_64                randconfig-012-20241025    gcc-12
x86_64                randconfig-013-20241025    gcc-12
x86_64                randconfig-014-20241025    gcc-12
x86_64                randconfig-015-20241025    gcc-12
x86_64                randconfig-016-20241025    gcc-12
x86_64                randconfig-071-20241025    gcc-12
x86_64                randconfig-072-20241025    gcc-12
x86_64                randconfig-073-20241025    gcc-12
x86_64                randconfig-074-20241025    gcc-12
x86_64                randconfig-075-20241025    gcc-12
x86_64                randconfig-076-20241025    gcc-12
x86_64                               rhel-8.3    gcc-12
xtensa                            allnoconfig    gcc-14.1.0
xtensa                  audio_kc705_defconfig    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

