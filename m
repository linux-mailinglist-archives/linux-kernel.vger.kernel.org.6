Return-Path: <linux-kernel+bounces-512638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 678AEA33BEF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 11:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1010162F36
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 10:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F955210F58;
	Thu, 13 Feb 2025 10:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OxnvmkgF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F180B206F31
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 10:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739441117; cv=none; b=DaGfrGPrvzFy3xNjtyD9yjaHi5fJGflG5ZYwSN1374mKubLi2MOrtCvj2T0qyYcrGWfkI2mCLIIcJ6ew7si/IWimmRo/8nWepRZ9E150Gphlr/qqelFhh1xiMnLDO4Zz9L/KItVcA8a/KvzIYb4XW7oOBT3CIGI9NsFx+X71kD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739441117; c=relaxed/simple;
	bh=0406GFPtDEjE5dIMqr9miDjxVI9YA3p9INMJF/p9PUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TnFAz9qveftp7rEtOjcJldPq/x0kxeJT0JVJvSmeaUjJvMxSZpdmT6CERUGpVwDnTFOo867u7fad/5Vj8UQgGocZCyXi7u4EMFR+yosDNHrtsifOcrEQu68nY1otN4WYrpWcwVdpTraYWg5v4RJVa1Hv5lE6AFFVwLElmomFaoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OxnvmkgF; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739441116; x=1770977116;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0406GFPtDEjE5dIMqr9miDjxVI9YA3p9INMJF/p9PUQ=;
  b=OxnvmkgFuQaeAM+L+ORo1Ok4Sr9Qdxqcw/4ZsCKLnCadxIOhYmKGWHd9
   +O1JxG9i5lZLCEBH9uYMoXEbj4JCOWUQUxsuwb+s/3CleQWdu/faTQEY5
   s3opnKDtG3yOXXXXNbDPLvxQt7nUD8WycQ9KuPZqcjJLPCYj0cvbn6LfN
   PbsPrEGP8lMcUHdyPDq/DK389ZNs8efiDrDuUcCndyLsnp/F2IHj1DeU9
   88xP5gcDcfIP18oi3+nMtLsagpI+gbnURtCVGyQTne7dp79jXRIxXP531
   j+S24ppEAGkXrudlmz4ZTFnwwti5YeSgMblMrF4BJEhhhqCg/Ks2JCTmy
   w==;
X-CSE-ConnectionGUID: BzNh4Q5+SRqYjjmeQynEnA==
X-CSE-MsgGUID: 9K4SJvseTL6QlG2N6eEmzA==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="65488297"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="65488297"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 02:05:15 -0800
X-CSE-ConnectionGUID: ndRMcKpXS8KLBnxiHfgZzQ==
X-CSE-MsgGUID: K4k22xYdSIuGToVNQnMcmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="112864984"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 13 Feb 2025 02:05:13 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tiW5m-0016tm-1X;
	Thu, 13 Feb 2025 10:05:10 +0000
Date: Thu, 13 Feb 2025 18:05:00 +0800
From: kernel test robot <lkp@intel.com>
To: Wang Qing <wangqing@vivo.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Tony Lindgren <tony@atomide.com>
Subject: arch/arm/mach-omap2/clockdomain.c:1303: warning: Function parameter
 or struct member 'unused' not described in '_clkdm_save_context'
Message-ID: <202502131858.NrCAEuh6-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Wang,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4dc1d1bec89864d8076e5ab314f86f46442bfb02
commit: 320f6f90cbe4818cf0d0f9441772d23aa441c506 ARM: OMAP2+: fix spellint typo
date:   4 years, 1 month ago
config: arm-randconfig-r011-20220722 (https://download.01.org/0day-ci/archive/20250213/202502131858.NrCAEuh6-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250213/202502131858.NrCAEuh6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502131858.NrCAEuh6-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/arm/mach-omap2/clockdomain.c:546: warning: Function parameter or struct member 'user' not described in 'clkdm_for_each'
   arch/arm/mach-omap2/clockdomain.c:1003: warning: expecting prototype for clkdm_deny_idle(). Prototype was for clkdm_deny_idle_nolock() instead
   arch/arm/mach-omap2/clockdomain.c:1165: warning: Function parameter or struct member 'unused' not described in 'clkdm_clk_enable'
   arch/arm/mach-omap2/clockdomain.c:1165: warning: Excess function parameter 'clk' description in 'clkdm_clk_enable'
   arch/arm/mach-omap2/clockdomain.c:1303: warning: Function parameter or struct member 'clkdm' not described in '_clkdm_save_context'
>> arch/arm/mach-omap2/clockdomain.c:1303: warning: Function parameter or struct member 'unused' not described in '_clkdm_save_context'
   arch/arm/mach-omap2/clockdomain.c:1316: warning: Function parameter or struct member 'clkdm' not described in '_clkdm_restore_context'
>> arch/arm/mach-omap2/clockdomain.c:1316: warning: Function parameter or struct member 'unused' not described in '_clkdm_restore_context'


vim +1303 arch/arm/mach-omap2/clockdomain.c

d459bfe01f5239 Paul Walmsley 2008-08-19  1295  
1096d1c10bb3d8 Russ Dill     2018-05-16  1296  /**
1096d1c10bb3d8 Russ Dill     2018-05-16  1297   * _clkdm_save_context - save the context for the control of this clkdm
1096d1c10bb3d8 Russ Dill     2018-05-16  1298   *
1096d1c10bb3d8 Russ Dill     2018-05-16  1299   * Due to a suspend or hibernation operation, the state of the registers
1096d1c10bb3d8 Russ Dill     2018-05-16  1300   * controlling this clkdm will be lost, save their context.
1096d1c10bb3d8 Russ Dill     2018-05-16  1301   */
320f6f90cbe481 Wang Qing     2020-09-17  1302  static int _clkdm_save_context(struct clockdomain *clkdm, void *unused)
1096d1c10bb3d8 Russ Dill     2018-05-16 @1303  {
1096d1c10bb3d8 Russ Dill     2018-05-16  1304  	if (!arch_clkdm || !arch_clkdm->clkdm_save_context)
1096d1c10bb3d8 Russ Dill     2018-05-16  1305  		return -EINVAL;
1096d1c10bb3d8 Russ Dill     2018-05-16  1306  
1096d1c10bb3d8 Russ Dill     2018-05-16  1307  	return arch_clkdm->clkdm_save_context(clkdm);
1096d1c10bb3d8 Russ Dill     2018-05-16  1308  }
1096d1c10bb3d8 Russ Dill     2018-05-16  1309  
1096d1c10bb3d8 Russ Dill     2018-05-16  1310  /**
1096d1c10bb3d8 Russ Dill     2018-05-16  1311   * _clkdm_restore_context - restore context for control of this clkdm
1096d1c10bb3d8 Russ Dill     2018-05-16  1312   *
1096d1c10bb3d8 Russ Dill     2018-05-16  1313   * Restore the register values for this clockdomain.
1096d1c10bb3d8 Russ Dill     2018-05-16  1314   */
320f6f90cbe481 Wang Qing     2020-09-17  1315  static int _clkdm_restore_context(struct clockdomain *clkdm, void *unused)
1096d1c10bb3d8 Russ Dill     2018-05-16 @1316  {
1096d1c10bb3d8 Russ Dill     2018-05-16  1317  	if (!arch_clkdm || !arch_clkdm->clkdm_restore_context)
1096d1c10bb3d8 Russ Dill     2018-05-16  1318  		return -EINVAL;
1096d1c10bb3d8 Russ Dill     2018-05-16  1319  
1096d1c10bb3d8 Russ Dill     2018-05-16  1320  	return arch_clkdm->clkdm_restore_context(clkdm);
1096d1c10bb3d8 Russ Dill     2018-05-16  1321  }
1096d1c10bb3d8 Russ Dill     2018-05-16  1322  

:::::: The code at line 1303 was first introduced by commit
:::::: 1096d1c10bb3d869b5630dfa88f4c18f3d579752 ARM: OMAP2+: Add functions to save and restore clockdomain context en-masse.

:::::: TO: Russ Dill <Russ.Dill@ti.com>
:::::: CC: Tony Lindgren <tony@atomide.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

