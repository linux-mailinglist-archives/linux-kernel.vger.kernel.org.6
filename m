Return-Path: <linux-kernel+bounces-270805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E815394457C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 09:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 717E2B21CD4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 07:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70B316DC12;
	Thu,  1 Aug 2024 07:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nhr0Nzn3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C4322F19
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 07:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722497605; cv=none; b=tZchYgpSwOVCD7wX5d7Aa6rfjr+/o7zS8f9ifH3kW2pZzah439vdi1JcoPM4N1yEF6LIC2+K05LRblmEMe2wcrFP/V0Bqt2PXPwhfdQaTyNV3mgK4vGkf1b/hY/AwyasNOMj3nVTmrmDJBUZRE4NO0CZtaXijMxK1UlFDLg+pxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722497605; c=relaxed/simple;
	bh=Q/Sxk4TAA+tkQD/v7HT/NGRwyiw42m+aeZ1fW4Pnah0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=M/ICe4/vFVQLpM1LqJ1f7oPMp7Isc5bxeCSNQ2U32KSMCjNVq/z6vPuUpvnNt7dEIQAWyBLJIfIKV6oqHWVvxCs0cplb1R2clIge16tudp/zwwMgfLFdd2MJBWOkvZwC/oto8cjlH2XtuXPvhFEVDqe/lD+Vnn5MKeSzCg3kMo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nhr0Nzn3; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722497604; x=1754033604;
  h=date:from:to:cc:subject:message-id;
  bh=Q/Sxk4TAA+tkQD/v7HT/NGRwyiw42m+aeZ1fW4Pnah0=;
  b=nhr0Nzn3wiIQpJN5Bd4tEmMuOMbxURbaWwOGO9NFmHoCkEg+w3gUe0Y4
   AhnDmyBMQgoeP+QWIrJpRgFcQ7dhTDK7bp5Qet5TXMmy4U9I5/MAFPiXI
   MHp8J5IZpH7rLIw/BThRT26Ufm5QMEjBiLdITGgsQ1dsNvV6IxvCIZAv1
   rax7PnDwGHgz0NCrZmlLEMxtD60M4jq95eWLkHiQKJI/1nvaMY19ohdcw
   4BUetehX/Uq/03ko1N/iu1bCDId/bEmJRpT2BDemDdCZdQC7RsLzmpKBc
   gMn6PDMqbLmTdwvOYcftA6wTEEjxmDDtRKfRizpLsqGhbmPtK1u7uy6zf
   Q==;
X-CSE-ConnectionGUID: ux0bl7VPRhOlzVx/dF8xmg==
X-CSE-MsgGUID: 95qi/eQDQ1Ow6+/mAy0arQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11150"; a="31062169"
X-IronPort-AV: E=Sophos;i="6.09,253,1716274800"; 
   d="scan'208";a="31062169"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2024 00:33:23 -0700
X-CSE-ConnectionGUID: tcInSPZnRQqvBlLfmWvqZg==
X-CSE-MsgGUID: /SUxsvmXS2K2evQH29kdAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,253,1716274800"; 
   d="scan'208";a="54907068"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 01 Aug 2024 00:33:21 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sZQJL-000vKi-1N;
	Thu, 01 Aug 2024 07:33:19 +0000
Date: Thu, 01 Aug 2024 15:33:18 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/timers] BUILD SUCCESS
 b4bac279319d3082eb42f074799c7b18ba528c71
Message-ID: <202408011515.RcEfrkn8-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/timers
branch HEAD: b4bac279319d3082eb42f074799c7b18ba528c71  x86/tsc: Use topology_max_packages() to get package number

elapsed time: 727m

configs tested: 55
configs skipped: 128

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
arm                        keystone_defconfig   gcc-14.1.0
arm                             pxa_defconfig   gcc-14.1.0
i386                             allmodconfig   clang-18
i386                              allnoconfig   clang-18
i386                             allyesconfig   clang-18
i386         buildonly-randconfig-001-20240801   gcc-9
i386         buildonly-randconfig-002-20240801   gcc-9
i386         buildonly-randconfig-003-20240801   gcc-9
i386         buildonly-randconfig-004-20240801   gcc-9
i386         buildonly-randconfig-005-20240801   gcc-9
i386         buildonly-randconfig-006-20240801   gcc-9
i386                                defconfig   clang-18
i386                  randconfig-001-20240801   gcc-9
i386                  randconfig-002-20240801   gcc-9
i386                  randconfig-003-20240801   gcc-9
i386                  randconfig-004-20240801   gcc-9
i386                  randconfig-005-20240801   gcc-9
i386                  randconfig-006-20240801   gcc-9
i386                  randconfig-011-20240801   gcc-9
i386                  randconfig-012-20240801   gcc-9
i386                  randconfig-013-20240801   gcc-9
i386                  randconfig-014-20240801   gcc-9
i386                  randconfig-015-20240801   gcc-9
i386                  randconfig-016-20240801   gcc-9
loongarch                        allmodconfig   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                          amiga_defconfig   gcc-14.1.0
m68k                          atari_defconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
mips                           ci20_defconfig   gcc-14.1.0
mips                        maltaup_defconfig   gcc-14.1.0
mips                           mtx1_defconfig   gcc-14.1.0
mips                         rt305x_defconfig   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                 mpc834x_itx_defconfig   gcc-14.1.0
powerpc                      pcm030_defconfig   gcc-14.1.0
powerpc                     tqm5200_defconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-20
sh                         apsh4a3a_defconfig   gcc-14.1.0
sh                ecovec24-romimage_defconfig   gcc-14.1.0
sh                   rts7751r2dplus_defconfig   gcc-14.1.0
sh                           se7751_defconfig   gcc-14.1.0
sparc                       sparc64_defconfig   gcc-14.1.0
um                                allnoconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64                              defconfig   clang-18
x86_64                          rhel-8.3-rust   clang-18

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

