Return-Path: <linux-kernel+bounces-272408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B73945B67
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 11:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 057DCB22DAB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 09:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3721DAC7D;
	Fri,  2 Aug 2024 09:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rxdp9shE"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B21256D
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 09:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722592147; cv=none; b=G4BrGoPqQumcoUF/8lu+vlK+Bm5xExLc+7YupL2SHLTxmaI6ng56qCfrnRH5kPmlccBcodB+N78Ed3MUWROtO4xhsRnODhXmXRLcn8f2ojoDgvsWJonLMurlo0cxkl23cMiWfC4rHUsohRnKwrVUYsGh3PqEROhZJxKGIWxrlXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722592147; c=relaxed/simple;
	bh=Z7nMKHlIb2uUmAY3cME2BDbMycpRjtI2Mp22W4VALDw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=sIpuLPam5usrBYxCQIkzd3/co6ChAysHeyIF2vbV/6/8zxPZNtOKjxsdGCsvXelUY0yQMT79H2HiQSQX72WR2OegTSrCYG4X75JgbCdlvhushCn/gyt/YhsQgGfs9L03Aoo86/AHt71XS7HdX0GifwsNTDT6gL//Btf9WZskWOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rxdp9shE; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722592146; x=1754128146;
  h=date:from:to:cc:subject:message-id;
  bh=Z7nMKHlIb2uUmAY3cME2BDbMycpRjtI2Mp22W4VALDw=;
  b=Rxdp9shEY9KlZz0te5D3ybROQiB7niRQgM5sPiZTJ+BK2GoxjfbFqctt
   RVaSRjPYXgui7uCqZTFlGISz6/mDa/VZcPkPdK3/tTZqOJ11fXiOSR9wI
   2q8pT1EguI+m2Kb/xPBQRHiaP3wHMrIbdHG46ov7vrupplFQAAS5/eMhG
   Jtot2klBFGkyzgFrNvIywk38V5v05+BNbG5njRK5l2EujFmka7QyBRnQU
   +VuaNzROnh3hWgTwOlpKWI6hkafqeBLCsAINkZ9Swqinbg6scJem0PAA+
   BzJFLzQqRII5rVTOOLt6z+lGafcKbmPTu0EjPWGAiFj5E+IIllU268xjU
   w==;
X-CSE-ConnectionGUID: ibKvT2XuQ1OWL1v2wBPtGw==
X-CSE-MsgGUID: fi+fJkfSReGNdZO1v6rMAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11151"; a="38063905"
X-IronPort-AV: E=Sophos;i="6.09,257,1716274800"; 
   d="scan'208";a="38063905"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2024 02:49:05 -0700
X-CSE-ConnectionGUID: c4pS4ZocR3Os3dB2v51/ug==
X-CSE-MsgGUID: JaZyBHi0R8qEF3pGugnCcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,257,1716274800"; 
   d="scan'208";a="55283802"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 02 Aug 2024 02:49:04 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sZouD-000wc2-2q;
	Fri, 02 Aug 2024 09:49:01 +0000
Date: Fri, 02 Aug 2024 17:48:42 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 dd35a0933269c636635b6af89dc6fa1782791e56
Message-ID: <202408021739.Qy6GLfQq-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: dd35a0933269c636635b6af89dc6fa1782791e56  x86/uaccess: Zero the 8-byte get_range case on failure on 32-bit

elapsed time: 851m

configs tested: 79
configs skipped: 130

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                        nsimosci_defconfig   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                        clps711x_defconfig   gcc-13.2.0
arm                                 defconfig   gcc-13.2.0
arm                          exynos_defconfig   gcc-13.2.0
arm                        mvebu_v7_defconfig   gcc-13.2.0
arm                             rpc_defconfig   gcc-13.2.0
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
i386                             allmodconfig   clang-18
i386                              allnoconfig   clang-18
i386                             allyesconfig   clang-18
i386         buildonly-randconfig-001-20240802   gcc-13
i386         buildonly-randconfig-002-20240802   gcc-12
i386         buildonly-randconfig-003-20240802   clang-18
i386         buildonly-randconfig-004-20240802   gcc-13
i386         buildonly-randconfig-006-20240802   clang-18
i386                                defconfig   clang-18
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
microblaze                      mmu_defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                        bcm63xx_defconfig   gcc-13.2.0
mips                           ip30_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                generic-64bit_defconfig   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                       maple_defconfig   gcc-13.2.0
powerpc                   microwatt_defconfig   gcc-13.2.0
powerpc                         wii_defconfig   gcc-13.2.0
riscv                             allnoconfig   gcc-14.1.0
riscv                               defconfig   gcc-14.1.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-20
s390                                defconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                                  defconfig   gcc-14.1.0
sh                          sdk7786_defconfig   gcc-13.2.0
sh                   sh7770_generic_defconfig   gcc-13.2.0
sparc64                             defconfig   gcc-14.1.0
um                                allnoconfig   gcc-14.1.0
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-13.2.0
um                             i386_defconfig   gcc-14.1.0
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64                              defconfig   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                  nommu_kc705_defconfig   gcc-13.2.0
xtensa                         virt_defconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

