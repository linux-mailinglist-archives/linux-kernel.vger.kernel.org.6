Return-Path: <linux-kernel+bounces-207272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4499014E0
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 09:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC68B1F217B0
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 07:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776CE1B28D;
	Sun,  9 Jun 2024 07:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UUp53Rrd"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35831BF2A
	for <linux-kernel@vger.kernel.org>; Sun,  9 Jun 2024 07:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717919640; cv=none; b=tXS9z2XLEVgeSAr5xCbWMMSoWFHFyNJqxM+ya0pune3wFFkVlPpnUsuKPJp1rG+mhpDP+z9c02FhHpHh70wg5TBZlER0btmF3IQCt7L/yxzKKRXC+TGUGUvSAjDRyS9WtNAUhkXcG7FL43IvokUgnqGtVZLP9AZwUYJz7aJkowk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717919640; c=relaxed/simple;
	bh=hKt2tbMbPsT+WdQ0/MZQmCtDLUEjEnAa0OPgsC1Rk0M=;
	h=Date:From:To:Cc:Subject:Message-ID; b=UxxBVzC8L410O00IExDwnde0fICH2BrewzMJ62AIyvf7cGcOlR+s2/1Jdj8tknI5HqkYOBZl2zqwRclqpQkaJjpVkEL9Gg2FR4vFvo22rm5cyTg9iQhGMcH5JYQ/KXS6kvc/6EALaggIMrS94t/GFLRYm5h6UaUva2SXWNaS8aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UUp53Rrd; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717919639; x=1749455639;
  h=date:from:to:cc:subject:message-id;
  bh=hKt2tbMbPsT+WdQ0/MZQmCtDLUEjEnAa0OPgsC1Rk0M=;
  b=UUp53RrdzZDtaN3RqIPQXSQSfNPF/0J5L7Bx0lQgTCz4qIS9+EhCWZuP
   pWOv3Fwnn2urMAgKq6nK6WtnmLCz8djXmmOKBo3PUmuNkiABS2Yov5j4Z
   ewBv3CE8a+50gEYs51ZZvlOrApNRPU1+vJdOf3F2CwfgkHSoavfKBP+xq
   PxIzHpdnWTmBcVNlckdlGtNiL3mZWPPyCHNO1A2ygd6V+5nbIVc7n3lRv
   Zdo5pcs/kHs+sCC+/4WPlFkrxzW7N1DcmWc9gmDmKKt1Q/nhbNWmmRmf7
   G1UDwWqbx3VNa6usM/TFOd7WcQUYC2EOJ4DM31zh0ca3bp0jSe692Wf1C
   g==;
X-CSE-ConnectionGUID: wBhUnG7aRBW0KYFqeo8Kzw==
X-CSE-MsgGUID: 07ZnZNBISCGnUZ8SPmCVwA==
X-IronPort-AV: E=McAfee;i="6600,9927,11097"; a="14428162"
X-IronPort-AV: E=Sophos;i="6.08,225,1712646000"; 
   d="scan'208";a="14428162"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2024 00:53:58 -0700
X-CSE-ConnectionGUID: qIxW9JOMS76d/F9HR7hvew==
X-CSE-MsgGUID: 8Gcf7Bd7ReaaCX3YIiwsbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,225,1712646000"; 
   d="scan'208";a="69923378"
Received: from lkp-server01.sh.intel.com (HELO 8967fbab76b3) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 09 Jun 2024 00:53:56 -0700
Received: from kbuild by 8967fbab76b3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sGDNC-0000xu-0q;
	Sun, 09 Jun 2024 07:53:54 +0000
Date: Sun, 09 Jun 2024 15:53:53 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:WIP.x86/fpu] BUILD SUCCESS
 5a4cac0ba89bf31be7ffb19f0ac5d677eda4bd90
Message-ID: <202406091551.dlPfniRr-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git WIP.x86/fpu
branch HEAD: 5a4cac0ba89bf31be7ffb19f0ac5d677eda4bd90  x86/fpu: Fix stale comment in ex_handler_fprestore()

elapsed time: 1450m

configs tested: 50
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
hexagon                          allmodconfig   clang
hexagon                          allyesconfig   clang
i386         buildonly-randconfig-001-20240609   gcc  
i386         buildonly-randconfig-002-20240609   gcc  
i386         buildonly-randconfig-003-20240609   gcc  
i386         buildonly-randconfig-004-20240609   gcc  
i386         buildonly-randconfig-005-20240609   clang
i386         buildonly-randconfig-006-20240609   gcc  
i386                  randconfig-001-20240609   clang
i386                  randconfig-002-20240609   clang
i386                  randconfig-003-20240609   gcc  
i386                  randconfig-004-20240609   gcc  
i386                  randconfig-005-20240609   clang
i386                  randconfig-006-20240609   clang
i386                  randconfig-011-20240609   clang
i386                  randconfig-012-20240609   clang
i386                  randconfig-013-20240609   clang
i386                  randconfig-014-20240609   clang
i386                  randconfig-015-20240609   gcc  
i386                  randconfig-016-20240609   clang
openrisc                          allnoconfig   gcc  
openrisc                            defconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   clang
s390                              allnoconfig   clang
s390                                defconfig   clang
sh                                allnoconfig   gcc  
sh                                  defconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
x86_64       buildonly-randconfig-001-20240609   clang
x86_64       buildonly-randconfig-002-20240609   clang
x86_64       buildonly-randconfig-003-20240609   clang
x86_64       buildonly-randconfig-004-20240609   gcc  
x86_64       buildonly-randconfig-005-20240609   clang
x86_64       buildonly-randconfig-006-20240609   gcc  
x86_64                randconfig-001-20240609   gcc  
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

