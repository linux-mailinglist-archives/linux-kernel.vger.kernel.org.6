Return-Path: <linux-kernel+bounces-173795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DF88C0578
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 22:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D26628183C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 20:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C084130AF2;
	Wed,  8 May 2024 20:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B/PzK2Ac"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F0785633
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 20:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715199557; cv=none; b=rzgBFJQd/2vDqG9TWT5nBe5l24LDLtcNsWt123auxHBRIaJf+9RjxGDz3DpeHXSNn7EyphUsX9CQNFD+OmSd1z1ADG/1jOWAeAWq0WJHxTvfmRRzSswzskdUZzMMDidCBcLFcBCEg67zRt/4LgHsxdjtqSLIoHq2SLvJmO47r94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715199557; c=relaxed/simple;
	bh=41hJBTDAnSuYjl9aw2wOZYbUyRGrfKfA/5ueJmBhR28=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Bs+BRt37FCZzml0HQcIUF3lcSbMWpDxpMFkMBywiXjxQDLGZ8pmOe9QIiBZ0hYwCagwONOSXe+F4qdQcvV03YjKVw/12b1Hl5k/UtPU5gSBST1ZhJpi/twsYoWrZQJfwaY11XU5I7bLxyRTAppDHb6P5dwqvOE7uw1nfoIzS3EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B/PzK2Ac; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715199547; x=1746735547;
  h=date:from:to:cc:subject:message-id;
  bh=41hJBTDAnSuYjl9aw2wOZYbUyRGrfKfA/5ueJmBhR28=;
  b=B/PzK2Ac+bOqvHCQM2T8nqcxd+L7QtKABgQFPFWvo6oeeC9CwF1xq3Uy
   v2cLtowc3nITeeaUI+AjxTeWiiTrCDp/YxbOVm5pkROqX9CKa+emj+/F5
   2Y04E6mdFEtxzX/ehDxXdVX3upjuA3aONZ0HVTAT0EJ+V1Jr2lAJ7i3xY
   Rc/u8FJSf0OKKzq+H0uwPlgox5amhaDKNrWgRKwRe9qZZS5v9GB/laynv
   B+p464PWf8nWRZ2Bj30DvfKYRStUwHys5edOAalhraSEB9Q3agHwMtQYA
   +FP4XETGV75KPOVGDj4LtuvxhhRm5dDRLqQA3YAz375DOJpn0PUdZUCPN
   g==;
X-CSE-ConnectionGUID: SCD3aCD6RNueZxDL5C8j5A==
X-CSE-MsgGUID: kR2e8Ki2S3q+u0zukxGMqw==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="33596261"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="33596261"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 13:19:07 -0700
X-CSE-ConnectionGUID: cq1PsKEJQ4aaa6EZKgOpPw==
X-CSE-MsgGUID: Su1q1EHESliNtr1YUcBIYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="33837676"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 08 May 2024 13:19:06 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s4nkl-00044m-19;
	Wed, 08 May 2024 20:19:03 +0000
Date: Thu, 09 May 2024 04:18:30 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 ad3bd7659b68add28920982e02233b5dc4b483c3
Message-ID: <202405090428.0AiE3vjb-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cleanups
branch HEAD: ad3bd7659b68add28920982e02233b5dc4b483c3  x86/pci/ce4100: Remove unused 'struct sim_reg_op'

elapsed time: 768m

configs tested: 45
configs skipped: 150

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arm                     am200epdkit_defconfig   gcc  
arm                       spear13xx_defconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386                                defconfig   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                          multi_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                  decstation_64_defconfig   gcc  
mips                 decstation_r4k_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
powerpc                     ep8248e_defconfig   gcc  
powerpc                  storcenter_defconfig   gcc  
powerpc                         wii_defconfig   gcc  
um                               allyesconfig   gcc  
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                       common_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

