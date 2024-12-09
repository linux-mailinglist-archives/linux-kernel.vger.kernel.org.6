Return-Path: <linux-kernel+bounces-436774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB109E8A82
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 05:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F1EC161C90
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 04:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336271925B3;
	Mon,  9 Dec 2024 04:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SaXjNIEl"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31C215A856
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 04:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733719664; cv=none; b=PlRRLQ8OQXBLO4H+lVMVhT0jGY6xd+Mn+sJ7cyS66439jmsHJ6J4GMYWaCn0+N9cztg1zZ+nqUkc2lB8Kfrzj9QlARKAWU/MRVvUpkhwg4tcf1EuRMgRHbrksLOI0VRlZtN19SZuq2px30HBctigZEn+GTFiC1Z77rNv019QRyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733719664; c=relaxed/simple;
	bh=99kaYuCOUajpbij+XCian1hGHYmihIXy4fjv7Bv7JEY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=A9HgspSzoZELWrqFLVMP4Ero2cFinsybS8L0TzqG2TSaSwXvN7FTg9oofcheHT2iOhYlFHvMuQCrFjC3NjJnK4DGyAS+z0247/cdeJgd4eNoreCBIGLp/E1C/ZcQLKbZPtUCqojJt3Y5M15ts00LUX3rWG3a/w9Fy3n7h4Ro59A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SaXjNIEl; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733719663; x=1765255663;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=99kaYuCOUajpbij+XCian1hGHYmihIXy4fjv7Bv7JEY=;
  b=SaXjNIElQeUQ4Qbs9McoAJV//6Z3wL8Nh9zTR0IGlrdymqj3kBbzvLxT
   Q6Pb4oZvTbFdhbH1cZAL9tNavNgUpUTPnnsW9dUW8BB5CssVbP7/+8bIY
   rUv+cqtW6e7xKuDginFORVaczlHhw8Y0zkwhTv1CLZjL2zoderlyelylD
   DKHuBnybWhGlpwf/EmKHa3ED68GsVHNagpNimzsOZUG0FkF0WDZroGBOj
   bs9gwYgOC0IbgpHU+RORy1W0QKn2FLEU4sbUZuw+pm6abrhIsMs9h8vn1
   pFR4W2FIBYvmZmTVKR4FxOOlk/39ObhEptwAX1JgEGiIy3DFGfENhdE0o
   A==;
X-CSE-ConnectionGUID: q5f5ovdESceXqcy0wWts9A==
X-CSE-MsgGUID: guL4L9oiQD6WeYZ8ODQE+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11280"; a="34060164"
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="34060164"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2024 20:47:41 -0800
X-CSE-ConnectionGUID: RLSDeYHFSjG8RH12ZbpoQQ==
X-CSE-MsgGUID: 4/H3Pv2sQqGMs/gIlzaZzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="99012423"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 08 Dec 2024 20:47:39 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tKVgG-0003uy-33;
	Mon, 09 Dec 2024 04:47:36 +0000
Date: Mon, 9 Dec 2024 12:47:33 +0800
From: kernel test robot <lkp@intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Subject: arch/arm64/kernel/signal.c:1046:36: sparse: sparse: cast removes
 address space '__user' of expression
Message-ID: <202412082005.OBJ0BbWs-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7503345ac5f5e82fd9a36d6e6b447c016376403a
commit: 5d8b172e7005c6b42c16a0952c1d8873051d68ae arm64: Add Kconfig for Guarded Control Stack (GCS)
date:   9 weeks ago
config: arm64-randconfig-r133-20241208 (https://download.01.org/0day-ci/archive/20241208/202412082005.OBJ0BbWs-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 592c0fe55f6d9a811028b5f3507be91458ab2713)
reproduce: (https://download.01.org/0day-ci/archive/20241208/202412082005.OBJ0BbWs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412082005.OBJ0BbWs-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/arm64/kernel/signal.c:1046:36: sparse: sparse: cast removes address space '__user' of expression
   arch/arm64/kernel/signal.c:1054:9: sparse: sparse: cast removes address space '__user' of expression
   arch/arm64/kernel/signal.c:1461:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void ( [noderef] [usertype] __user *[assigned] [usertype] sigtramp )( ... ) @@     got void * @@
   arch/arm64/kernel/signal.c:1461:26: sparse:     expected void ( [noderef] [usertype] __user *[assigned] [usertype] sigtramp )( ... )
   arch/arm64/kernel/signal.c:1461:26: sparse:     got void *

vim +/__user +1046 arch/arm64/kernel/signal.c

2c020ed8d148f7 Catalin Marinas 2012-03-05  1010  
eaf62ce1563b85 Mark Brown      2024-10-01  1011  #ifdef CONFIG_ARM64_GCS
eaf62ce1563b85 Mark Brown      2024-10-01  1012  static int gcs_restore_signal(void)
eaf62ce1563b85 Mark Brown      2024-10-01  1013  {
eaf62ce1563b85 Mark Brown      2024-10-01  1014  	unsigned long __user *gcspr_el0;
eaf62ce1563b85 Mark Brown      2024-10-01  1015  	u64 cap;
eaf62ce1563b85 Mark Brown      2024-10-01  1016  	int ret;
eaf62ce1563b85 Mark Brown      2024-10-01  1017  
eaf62ce1563b85 Mark Brown      2024-10-01  1018  	if (!system_supports_gcs())
eaf62ce1563b85 Mark Brown      2024-10-01  1019  		return 0;
eaf62ce1563b85 Mark Brown      2024-10-01  1020  
eaf62ce1563b85 Mark Brown      2024-10-01  1021  	if (!(current->thread.gcs_el0_mode & PR_SHADOW_STACK_ENABLE))
eaf62ce1563b85 Mark Brown      2024-10-01  1022  		return 0;
eaf62ce1563b85 Mark Brown      2024-10-01  1023  
eaf62ce1563b85 Mark Brown      2024-10-01  1024  	gcspr_el0 = (unsigned long __user *)read_sysreg_s(SYS_GCSPR_EL0);
eaf62ce1563b85 Mark Brown      2024-10-01  1025  
eaf62ce1563b85 Mark Brown      2024-10-01  1026  	/*
eaf62ce1563b85 Mark Brown      2024-10-01  1027  	 * Ensure that any changes to the GCS done via GCS operations
eaf62ce1563b85 Mark Brown      2024-10-01  1028  	 * are visible to the normal reads we do to validate the
eaf62ce1563b85 Mark Brown      2024-10-01  1029  	 * token.
eaf62ce1563b85 Mark Brown      2024-10-01  1030  	 */
eaf62ce1563b85 Mark Brown      2024-10-01  1031  	gcsb_dsync();
eaf62ce1563b85 Mark Brown      2024-10-01  1032  
eaf62ce1563b85 Mark Brown      2024-10-01  1033  	/*
eaf62ce1563b85 Mark Brown      2024-10-01  1034  	 * GCSPR_EL0 should be pointing at a capped GCS, read the cap.
eaf62ce1563b85 Mark Brown      2024-10-01  1035  	 * We don't enforce that this is in a GCS page, if it is not
eaf62ce1563b85 Mark Brown      2024-10-01  1036  	 * then faults will be generated on GCS operations - the main
eaf62ce1563b85 Mark Brown      2024-10-01  1037  	 * concern is to protect GCS pages.
eaf62ce1563b85 Mark Brown      2024-10-01  1038  	 */
eaf62ce1563b85 Mark Brown      2024-10-01  1039  	ret = copy_from_user(&cap, gcspr_el0, sizeof(cap));
eaf62ce1563b85 Mark Brown      2024-10-01  1040  	if (ret)
eaf62ce1563b85 Mark Brown      2024-10-01  1041  		return -EFAULT;
eaf62ce1563b85 Mark Brown      2024-10-01  1042  
eaf62ce1563b85 Mark Brown      2024-10-01  1043  	/*
eaf62ce1563b85 Mark Brown      2024-10-01  1044  	 * Check that the cap is the actual GCS before replacing it.
eaf62ce1563b85 Mark Brown      2024-10-01  1045  	 */
eaf62ce1563b85 Mark Brown      2024-10-01 @1046  	if (!gcs_signal_cap_valid((u64)gcspr_el0, cap))
eaf62ce1563b85 Mark Brown      2024-10-01  1047  		return -EINVAL;
eaf62ce1563b85 Mark Brown      2024-10-01  1048  
eaf62ce1563b85 Mark Brown      2024-10-01  1049  	/* Invalidate the token to prevent reuse */
eaf62ce1563b85 Mark Brown      2024-10-01  1050  	put_user_gcs(0, (__user void*)gcspr_el0, &ret);
eaf62ce1563b85 Mark Brown      2024-10-01  1051  	if (ret != 0)
eaf62ce1563b85 Mark Brown      2024-10-01  1052  		return -EFAULT;
eaf62ce1563b85 Mark Brown      2024-10-01  1053  
eaf62ce1563b85 Mark Brown      2024-10-01  1054  	write_sysreg_s(gcspr_el0 + 1, SYS_GCSPR_EL0);
eaf62ce1563b85 Mark Brown      2024-10-01  1055  
eaf62ce1563b85 Mark Brown      2024-10-01  1056  	return 0;
eaf62ce1563b85 Mark Brown      2024-10-01  1057  }
eaf62ce1563b85 Mark Brown      2024-10-01  1058  

:::::: The code at line 1046 was first introduced by commit
:::::: eaf62ce1563b8557e3550acb97d5086120168750 arm64/signal: Set up and restore the GCS context for signal handlers

:::::: TO: Mark Brown <broonie@kernel.org>
:::::: CC: Catalin Marinas <catalin.marinas@arm.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

