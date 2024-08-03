Return-Path: <linux-kernel+bounces-273591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5FD946B26
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 23:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FF7A1C2139B
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 21:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8C833CF1;
	Sat,  3 Aug 2024 21:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZZMsmaZx"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E3C101EC
	for <linux-kernel@vger.kernel.org>; Sat,  3 Aug 2024 21:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722718908; cv=none; b=PpEnCNAk5NfyL8zEMKpa6IlZkDgYEbgQPFy10yt34TYWpVd/x978T1+4F78bs7+N+vD0efaHJvWsupxATKnmIDAWX4RGVblyS/ptFJtsLHRilIIxR1BFotEnewvo5al9ssHr6nFGYOPucah69/XRTg2At2iYwzDQZTGCCm6SUDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722718908; c=relaxed/simple;
	bh=VPxNM54Y2Z+EfXCIZyrFZa6kMRIu3XNBDoAwRHThmac=;
	h=Date:From:To:Cc:Subject:Message-ID; b=oSb6qkgGU04BVa7OA9JcDuF/c8g8gbbEOn7WO40cHYAD2yJS7OXPQCdpZErjlDIPVglzPFhEHEzIyryI0kx9b2ZyailZ3HwVW8RVAMk3dtjsc2lUDjJ/QN40YI0OfFYWvg5q65MfYhtHc4iaKW1bjjiCAryMAfrCUNKI5bCHIog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZZMsmaZx; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722718906; x=1754254906;
  h=date:from:to:cc:subject:message-id;
  bh=VPxNM54Y2Z+EfXCIZyrFZa6kMRIu3XNBDoAwRHThmac=;
  b=ZZMsmaZxpeTEDpldZ9m9zEXBuHnDdK53Zr2DsIOId3/FyFJZ+It43jcj
   gPjFVDCgL63k1KD9D6KMN7SCKUCvOBaSXDJSuzgq/sX8ebB9LRoTVpBdL
   RrPgDutoW93ngCantls3UydwyBe7jKSwGI2tYglkePke20xM3cYyFWXDv
   gK3Cd0ed67xYUvZ5kEFTCrj0VQ0xyz+4EdB/zoZhoQcNvW/tys6oTa8hP
   +q+DeRSOP0JJc+skcE6tdlcAEBg+XfTdXmjIljtKOulWZOzSqkPCTJI52
   17CULq/yeOaqZQf0okE7U6lWFm9fUMkO/pemN1fjNhbVGklR0BGbEOliI
   w==;
X-CSE-ConnectionGUID: WCn6qFNxTyGzABFViQMh7Q==
X-CSE-MsgGUID: SA2GeHVKRgSZ1eD7odWQEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11153"; a="20879193"
X-IronPort-AV: E=Sophos;i="6.09,261,1716274800"; 
   d="scan'208";a="20879193"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2024 14:01:45 -0700
X-CSE-ConnectionGUID: uD12a+D6R1O4f3FuOxVNGQ==
X-CSE-MsgGUID: QlZOfh94RV2JNF6bn7F2mA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,261,1716274800"; 
   d="scan'208";a="56363138"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 03 Aug 2024 14:01:45 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1saLsj-0000uK-2r;
	Sat, 03 Aug 2024 21:01:41 +0000
Date: Sun, 04 Aug 2024 05:01:09 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2024.08.01a] BUILD SUCCESS
 8de9756ef99527a4a5ea8fca632bfac20e624a77
Message-ID: <202408040507.usz1Lu04-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2024.08.01a
branch HEAD: 8de9756ef99527a4a5ea8fca632bfac20e624a77  doc: Add rcuog kthreads to kernel-per-CPU-kthreads.rst

elapsed time: 2674m

configs tested: 275
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                          axs101_defconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240802   gcc-13.2.0
arc                   randconfig-001-20240803   gcc-13.2.0
arc                   randconfig-002-20240802   gcc-13.2.0
arc                   randconfig-002-20240803   gcc-13.2.0
arc                        vdk_hs38_defconfig   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                         bcm2835_defconfig   clang-20
arm                        clps711x_defconfig   clang-20
arm                                 defconfig   gcc-13.2.0
arm                      integrator_defconfig   gcc-13.2.0
arm                      jornada720_defconfig   clang-20
arm                        keystone_defconfig   clang-20
arm                         lpc32xx_defconfig   gcc-14.1.0
arm                          moxart_defconfig   clang-20
arm                            mps2_defconfig   clang-20
arm                             mxs_defconfig   clang-20
arm                         nhk8815_defconfig   clang-20
arm                       omap2plus_defconfig   gcc-14.1.0
arm                   randconfig-001-20240802   gcc-13.2.0
arm                   randconfig-001-20240803   gcc-13.2.0
arm                   randconfig-002-20240802   gcc-13.2.0
arm                   randconfig-002-20240803   gcc-13.2.0
arm                   randconfig-003-20240802   gcc-13.2.0
arm                   randconfig-003-20240803   gcc-13.2.0
arm                   randconfig-004-20240802   gcc-13.2.0
arm                   randconfig-004-20240803   gcc-13.2.0
arm                             rpc_defconfig   clang-20
arm                         s3c6400_defconfig   gcc-13.2.0
arm                           sama5_defconfig   clang-20
arm                       spear13xx_defconfig   clang-20
arm                        spear3xx_defconfig   gcc-14.1.0
arm                           sunxi_defconfig   gcc-13.2.0
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240802   gcc-13.2.0
arm64                 randconfig-001-20240803   gcc-13.2.0
arm64                 randconfig-002-20240802   gcc-13.2.0
arm64                 randconfig-002-20240803   gcc-13.2.0
arm64                 randconfig-003-20240802   gcc-13.2.0
arm64                 randconfig-003-20240803   gcc-13.2.0
arm64                 randconfig-004-20240802   gcc-13.2.0
arm64                 randconfig-004-20240803   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240802   gcc-13.2.0
csky                  randconfig-001-20240803   gcc-13.2.0
csky                  randconfig-002-20240802   gcc-13.2.0
csky                  randconfig-002-20240803   gcc-13.2.0
i386                             allmodconfig   clang-18
i386                              allnoconfig   clang-18
i386                             allyesconfig   clang-18
i386         buildonly-randconfig-001-20240802   gcc-13
i386         buildonly-randconfig-001-20240803   clang-18
i386         buildonly-randconfig-002-20240802   gcc-13
i386         buildonly-randconfig-002-20240803   clang-18
i386         buildonly-randconfig-002-20240803   gcc-12
i386         buildonly-randconfig-003-20240802   gcc-13
i386         buildonly-randconfig-003-20240803   clang-18
i386         buildonly-randconfig-003-20240803   gcc-12
i386         buildonly-randconfig-004-20240802   gcc-13
i386         buildonly-randconfig-004-20240803   clang-18
i386         buildonly-randconfig-004-20240803   gcc-12
i386         buildonly-randconfig-005-20240802   gcc-13
i386         buildonly-randconfig-005-20240803   clang-18
i386         buildonly-randconfig-006-20240802   gcc-13
i386         buildonly-randconfig-006-20240803   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240802   gcc-13
i386                  randconfig-001-20240803   clang-18
i386                  randconfig-001-20240803   gcc-12
i386                  randconfig-002-20240802   gcc-13
i386                  randconfig-002-20240803   clang-18
i386                  randconfig-002-20240803   gcc-12
i386                  randconfig-003-20240802   gcc-13
i386                  randconfig-003-20240803   clang-18
i386                  randconfig-004-20240802   gcc-13
i386                  randconfig-004-20240803   clang-18
i386                  randconfig-004-20240803   gcc-12
i386                  randconfig-005-20240802   gcc-13
i386                  randconfig-005-20240803   clang-18
i386                  randconfig-006-20240802   gcc-13
i386                  randconfig-006-20240803   clang-18
i386                  randconfig-011-20240802   gcc-13
i386                  randconfig-011-20240803   clang-18
i386                  randconfig-011-20240803   gcc-12
i386                  randconfig-012-20240802   gcc-13
i386                  randconfig-012-20240803   clang-18
i386                  randconfig-012-20240803   gcc-11
i386                  randconfig-013-20240802   gcc-13
i386                  randconfig-013-20240803   clang-18
i386                  randconfig-014-20240802   gcc-13
i386                  randconfig-014-20240803   clang-18
i386                  randconfig-015-20240802   gcc-13
i386                  randconfig-015-20240803   clang-18
i386                  randconfig-015-20240803   gcc-12
i386                  randconfig-016-20240802   gcc-13
i386                  randconfig-016-20240803   clang-18
i386                  randconfig-016-20240803   gcc-12
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240802   gcc-13.2.0
loongarch             randconfig-001-20240803   gcc-13.2.0
loongarch             randconfig-002-20240802   gcc-13.2.0
loongarch             randconfig-002-20240803   gcc-13.2.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
m68k                        stmark2_defconfig   gcc-14.1.0
m68k                           virt_defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                         cobalt_defconfig   clang-20
mips                     cu1000-neo_defconfig   gcc-14.1.0
mips                     cu1830-neo_defconfig   clang-20
mips                  decstation_64_defconfig   gcc-14.1.0
mips                           gcw0_defconfig   clang-20
mips                malta_qemu_32r6_defconfig   gcc-13.2.0
mips                      maltasmvp_defconfig   clang-20
mips                      maltasmvp_defconfig   gcc-13.2.0
mips                        maltaup_defconfig   clang-20
mips                    maltaup_xpa_defconfig   clang-20
mips                      pic32mzda_defconfig   clang-20
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240802   gcc-13.2.0
nios2                 randconfig-001-20240803   gcc-13.2.0
nios2                 randconfig-002-20240802   gcc-13.2.0
nios2                 randconfig-002-20240803   gcc-13.2.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240802   gcc-13.2.0
parisc                randconfig-001-20240803   gcc-13.2.0
parisc                randconfig-002-20240802   gcc-13.2.0
parisc                randconfig-002-20240803   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   gcc-14.1.0
powerpc                      ep88xc_defconfig   clang-20
powerpc                        fsp2_defconfig   clang-20
powerpc                       holly_defconfig   gcc-14.1.0
powerpc                      katmai_defconfig   clang-20
powerpc                       maple_defconfig   gcc-13.2.0
powerpc                   microwatt_defconfig   gcc-14.1.0
powerpc                 mpc8313_rdb_defconfig   clang-20
powerpc                 mpc834x_itx_defconfig   gcc-14.1.0
powerpc               mpc834x_itxgp_defconfig   clang-20
powerpc                      pcm030_defconfig   clang-20
powerpc                       ppc64_defconfig   gcc-14.1.0
powerpc                     rainier_defconfig   gcc-13.2.0
powerpc               randconfig-001-20240802   gcc-13.2.0
powerpc               randconfig-001-20240803   gcc-13.2.0
powerpc               randconfig-003-20240802   gcc-13.2.0
powerpc               randconfig-003-20240803   gcc-13.2.0
powerpc                     sequoia_defconfig   gcc-13.2.0
powerpc                     tqm8560_defconfig   gcc-14.1.0
powerpc                      tqm8xx_defconfig   clang-20
powerpc64                        alldefconfig   clang-20
powerpc64             randconfig-001-20240802   gcc-13.2.0
powerpc64             randconfig-001-20240803   gcc-13.2.0
powerpc64             randconfig-002-20240802   gcc-13.2.0
powerpc64             randconfig-002-20240803   gcc-13.2.0
powerpc64             randconfig-003-20240802   gcc-13.2.0
powerpc64             randconfig-003-20240803   gcc-13.2.0
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-14.1.0
riscv                 randconfig-001-20240802   gcc-13.2.0
riscv                 randconfig-001-20240803   gcc-13.2.0
riscv                 randconfig-002-20240802   gcc-13.2.0
riscv                 randconfig-002-20240803   gcc-13.2.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240802   gcc-13.2.0
s390                  randconfig-001-20240803   gcc-13.2.0
s390                  randconfig-002-20240802   gcc-13.2.0
s390                  randconfig-002-20240803   gcc-13.2.0
s390                       zfcpdump_defconfig   clang-20
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                        edosk7760_defconfig   gcc-13.2.0
sh                             espt_defconfig   gcc-14.1.0
sh                          r7780mp_defconfig   gcc-14.1.0
sh                    randconfig-001-20240802   gcc-13.2.0
sh                    randconfig-001-20240803   gcc-13.2.0
sh                    randconfig-002-20240802   gcc-13.2.0
sh                    randconfig-002-20240803   gcc-13.2.0
sh                          rsk7269_defconfig   gcc-13.2.0
sh                           se7619_defconfig   gcc-14.1.0
sh                             sh03_defconfig   gcc-13.2.0
sh                            titan_defconfig   gcc-13.2.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240802   gcc-13.2.0
sparc64               randconfig-001-20240803   gcc-13.2.0
sparc64               randconfig-002-20240802   gcc-13.2.0
sparc64               randconfig-002-20240803   gcc-13.2.0
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240802   gcc-13.2.0
um                    randconfig-001-20240803   gcc-13.2.0
um                    randconfig-002-20240802   gcc-13.2.0
um                    randconfig-002-20240803   gcc-13.2.0
um                           x86_64_defconfig   clang-20
um                           x86_64_defconfig   gcc-14.1.0
x86_64                           alldefconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240803   gcc-12
x86_64       buildonly-randconfig-002-20240803   gcc-12
x86_64       buildonly-randconfig-003-20240803   gcc-12
x86_64       buildonly-randconfig-004-20240803   gcc-12
x86_64       buildonly-randconfig-005-20240803   gcc-12
x86_64       buildonly-randconfig-006-20240803   gcc-12
x86_64                              defconfig   clang-18
x86_64                                  kexec   clang-18
x86_64                randconfig-001-20240803   gcc-12
x86_64                randconfig-002-20240803   gcc-12
x86_64                randconfig-003-20240803   gcc-12
x86_64                randconfig-004-20240803   gcc-12
x86_64                randconfig-005-20240803   gcc-12
x86_64                randconfig-006-20240803   gcc-12
x86_64                randconfig-011-20240803   gcc-12
x86_64                randconfig-012-20240803   gcc-12
x86_64                randconfig-013-20240803   gcc-12
x86_64                randconfig-014-20240803   gcc-12
x86_64                randconfig-015-20240803   gcc-12
x86_64                randconfig-016-20240803   gcc-12
x86_64                randconfig-071-20240803   gcc-12
x86_64                randconfig-072-20240803   gcc-12
x86_64                randconfig-073-20240803   gcc-12
x86_64                randconfig-074-20240803   gcc-12
x86_64                randconfig-075-20240803   gcc-12
x86_64                randconfig-076-20240803   gcc-12
x86_64                          rhel-8.3-rust   clang-18
x86_64                               rhel-8.3   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                  audio_kc705_defconfig   gcc-13.2.0
xtensa                       common_defconfig   gcc-13.2.0
xtensa                randconfig-001-20240802   gcc-13.2.0
xtensa                randconfig-001-20240803   gcc-13.2.0
xtensa                randconfig-002-20240802   gcc-13.2.0
xtensa                randconfig-002-20240803   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

