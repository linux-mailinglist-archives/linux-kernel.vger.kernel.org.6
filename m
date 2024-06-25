Return-Path: <linux-kernel+bounces-229665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3038917292
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 22:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3966B28280C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 20:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF3517D37C;
	Tue, 25 Jun 2024 20:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TX5YN5aY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36154C6E
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 20:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719347890; cv=none; b=ErAWW51XwzEoN5+xsFHFfUq6E8XsepALt/WM1fzEOnQ2ZEiCmKacDfLWD6cOCEZl/McO+OMHB8cOewokBEHRhJ6C9HKy2RHKkS+7V1YF+D4H631/7VviLr07vuohaJEv9cXTzNguUZVdvapgLOQS0MAZvdGEGqN/eTvUooCgMh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719347890; c=relaxed/simple;
	bh=0Jqrl/qlVfq1gy0QWHy/E56JtqX6xRFcKBK8/J54FbY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=k7nhPU0SQhBTlISdcFXX3uJwtfQKuUBbFXKs4VC1U9aG69DWCsworof7Ul7WBTqReP2jc17ee0jZx0f1rqapVkgGQC7J8Ew1niukYgKJcfownSoe8Jqr7mjEMHvGgitntH2pETfYvyY3r1CvHhlE7T1XjG58aifxVlLXRe7iA+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TX5YN5aY; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719347887; x=1750883887;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0Jqrl/qlVfq1gy0QWHy/E56JtqX6xRFcKBK8/J54FbY=;
  b=TX5YN5aYmhQVjZyRv48l7VqcQ/lr5ywjEgXZRCemx+SuWhXZOdE/HDdF
   JBkda6MbEtQeQIyYcSEMzREJpti8US+4HzP9wIzGWT/pvgHiTq9EtJl9y
   vJfwn3SlRQe0N+tnIPu07efFqmGkfs7gf9H5l/HsV2ayHyxKN0CtLH9+T
   nGOjmZN407F70OYDtsO1Jh4a8FhAvIrIbX1GzmNfGkwf71M1WmQjGWtxy
   HPfUcIcPbBCq82FUfpIur694zj/voGek1I84a0y792azPj8hOWL3KO7Dw
   8HlG8Nec2EuHRdxw9nREXh/PtUxzGANuXZcKiOW96rYe5f43dOAk837lz
   w==;
X-CSE-ConnectionGUID: OmFMo5gWSCmElUYPtUDQnQ==
X-CSE-MsgGUID: 8+Xm4mVnRsasDuWC5ZkMSg==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="16073767"
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="16073767"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 13:38:06 -0700
X-CSE-ConnectionGUID: A+WG40+ZRBKiJOXGn88kHw==
X-CSE-MsgGUID: dLkWVpYzRl+4oT3dKRuWxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="48216201"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 25 Jun 2024 13:38:04 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sMCvS-000EiE-1w;
	Tue, 25 Jun 2024 20:38:02 +0000
Date: Wed, 26 Jun 2024 04:37:00 +0800
From: kernel test robot <lkp@intel.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Sami Tolvanen <samitolvanen@google.com>
Subject: arch/arm/mm/proc.c:82:6: error: conflicting types for
 'cpu_arm920_reset'
Message-ID: <202406260432.6WGV2jCk-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   55027e689933ba2e64f3d245fb1ff185b3e7fc81
commit: 1a4fec49efe5273eb2fcf575175a117745f76f97 ARM: 9392/2: Support CLANG CFI
date:   8 weeks ago
config: arm-randconfig-002-20240626 (https://download.01.org/0day-ci/archive/20240626/202406260432.6WGV2jCk-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project ad79a14c9e5ec4a369eed4adf567c22cc029863f)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240626/202406260432.6WGV2jCk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406260432.6WGV2jCk-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/arm/mm/proc.c:82:6: error: conflicting types for 'cpu_arm920_reset'
      82 | void cpu_arm920_reset(void);
         |      ^
   arch/arm/include/asm/proc-fns.h:96:13: note: previous declaration is here
      96 | extern void cpu_reset(unsigned long addr, bool hvc) __attribute__((noreturn));
         |             ^
   arch/arm/include/asm/glue-proc.h:251:21: note: expanded from macro 'cpu_reset'
     251 | #define cpu_reset                       __glue(CPU_NAME,_reset)
         |                                         ^
   arch/arm/include/asm/glue.h:20:26: note: expanded from macro '__glue'
      20 | #define __glue(name,fn)         ____glue(name,fn)
         |                                 ^
   arch/arm/include/asm/glue.h:16:27: note: expanded from macro '____glue'
      16 | #define ____glue(name,fn)       name##fn
         |                                 ^
   <scratch space>:70:1: note: expanded from here
      70 | cpu_arm920_reset
         | ^
   1 error generated.


vim +/cpu_arm920_reset +82 arch/arm/mm/proc.c

393999fa96273b Linus Walleij 2024-04-23  76  
393999fa96273b Linus Walleij 2024-04-23  77  #ifdef CONFIG_CPU_ARM920T
393999fa96273b Linus Walleij 2024-04-23  78  void cpu_arm920_proc_init(void);
393999fa96273b Linus Walleij 2024-04-23  79  __ADDRESSABLE(cpu_arm920_proc_init);
393999fa96273b Linus Walleij 2024-04-23  80  void cpu_arm920_proc_fin(void);
393999fa96273b Linus Walleij 2024-04-23  81  __ADDRESSABLE(cpu_arm920_proc_fin);
393999fa96273b Linus Walleij 2024-04-23 @82  void cpu_arm920_reset(void);
393999fa96273b Linus Walleij 2024-04-23  83  __ADDRESSABLE(cpu_arm920_reset);
393999fa96273b Linus Walleij 2024-04-23  84  int cpu_arm920_do_idle(void);
393999fa96273b Linus Walleij 2024-04-23  85  __ADDRESSABLE(cpu_arm920_do_idle);
393999fa96273b Linus Walleij 2024-04-23  86  void cpu_arm920_dcache_clean_area(void *addr, int size);
393999fa96273b Linus Walleij 2024-04-23  87  __ADDRESSABLE(cpu_arm920_dcache_clean_area);
393999fa96273b Linus Walleij 2024-04-23  88  void cpu_arm920_switch_mm(phys_addr_t pgd_phys, struct mm_struct *mm);
393999fa96273b Linus Walleij 2024-04-23  89  __ADDRESSABLE(cpu_arm920_switch_mm);
393999fa96273b Linus Walleij 2024-04-23  90  void cpu_arm920_set_pte_ext(pte_t *ptep, pte_t pte, unsigned int ext);
393999fa96273b Linus Walleij 2024-04-23  91  __ADDRESSABLE(cpu_arm920_set_pte_ext);
393999fa96273b Linus Walleij 2024-04-23  92  #ifdef CONFIG_ARM_CPU_SUSPEND
393999fa96273b Linus Walleij 2024-04-23  93  void cpu_arm920_do_suspend(void *);
393999fa96273b Linus Walleij 2024-04-23  94  __ADDRESSABLE(cpu_arm920_do_suspend);
393999fa96273b Linus Walleij 2024-04-23  95  void cpu_arm920_do_resume(void *);
393999fa96273b Linus Walleij 2024-04-23  96  __ADDRESSABLE(cpu_arm920_do_resume);
393999fa96273b Linus Walleij 2024-04-23  97  #endif /* CONFIG_ARM_CPU_SUSPEND */
393999fa96273b Linus Walleij 2024-04-23  98  #endif /* CONFIG_CPU_ARM920T */
393999fa96273b Linus Walleij 2024-04-23  99  

:::::: The code at line 82 was first introduced by commit
:::::: 393999fa96273bab8d6efb2f4724030916afd61b ARM: 9389/2: mm: Define prototypes for all per-processor calls

:::::: TO: Linus Walleij <linus.walleij@linaro.org>
:::::: CC: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

