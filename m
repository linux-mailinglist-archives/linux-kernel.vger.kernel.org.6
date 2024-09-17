Return-Path: <linux-kernel+bounces-331240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C32B497AA47
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 03:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 507ED1F2663C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 01:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9E619BBC;
	Tue, 17 Sep 2024 01:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CQMnIWez"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40D4134B6
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 01:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726537785; cv=none; b=hmdUmi87a/SD+MUWMgq6VIflXrUP1jmlp++izLi/g/6TunhQnIROaR5wEibrfPaD6rEmPPz9Lewm/QEE/821dLSTnL61NnBUscT29K4b2nnHPp59lrnE+7YZAwMpgzVz3tuNySjbZR0sUUug6+KsJApM8MwBCnlKuBhFtu+O1t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726537785; c=relaxed/simple;
	bh=NbOMlFHD53WxzHeq7t15Hgu47c3rGVA32W5Nuk5iMDg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XBYxFA+rukzFZqD6pZEUcm2Hrk1cHXw5LhkgTMO/oTQkwaXz8NXUKRhywN8BW/H2JWqJSq7STWV1ON8umOcy1PMNV9QCFX4zSm1qw4zQcVHlDmum4H5wmdGFY7p30iMgWzk1yt/c7v04mP8auFMi3DeNi6vsYKMkrvABvu5f4qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CQMnIWez; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726537783; x=1758073783;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=NbOMlFHD53WxzHeq7t15Hgu47c3rGVA32W5Nuk5iMDg=;
  b=CQMnIWezo9wlUD7LbwTBtCPDBw7oi5PxcuYXgYCQZhJviSMjJ9+1Jgcz
   K7lIrv0dYnP1v00D/psLwyuSjXN+Z9+Pe8kFlcAd2ahIadzkCqO42hL3K
   KDoJh6aY+ajLEnAF3bYqc2NnsWYZN8EkNN5q7VXYvZuxrnn+3/TSCNboS
   G7f1fngEhOKjm5XVkYEckm6xlw0etfyB9HOc84X51Wlnxwi0sHOA7zXoZ
   uyHXV1FY8frh9h1FnO0iNvMqeZFH+2jQAUQElS6Uq1cw1sO90OhcegeWA
   TVq/mdj/DvQLgVMJqWA2XHlfKAMX8TbWFSR7aTLkAA/LXXuGsQpwu9n9W
   A==;
X-CSE-ConnectionGUID: WEIwY3W5SoGJt7Xp45N0+Q==
X-CSE-MsgGUID: G/E8xopYSImw1vJi3W3dfA==
X-IronPort-AV: E=McAfee;i="6700,10204,11197"; a="25505117"
X-IronPort-AV: E=Sophos;i="6.10,234,1719903600"; 
   d="scan'208";a="25505117"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2024 18:49:43 -0700
X-CSE-ConnectionGUID: bmmvkZ59RIKGUlSuf180dA==
X-CSE-MsgGUID: B3uKY8UiRcWW3M1pkD1oyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,234,1719903600"; 
   d="scan'208";a="73405343"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 16 Sep 2024 18:49:41 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sqNLW-000Ah6-30;
	Tue, 17 Sep 2024 01:49:38 +0000
Date: Tue, 17 Sep 2024 09:48:51 +0800
From: kernel test robot <lkp@intel.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: arch/powerpc/platforms/44x/uic.c:40:12: sparse: sparse: symbol
 'primary_uic' was not declared. Should it be static?
Message-ID: <202409170900.BtJZbhrx-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Christophe,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a430d95c5efa2b545d26a094eb5f624e36732af0
commit: d5d1a1a55a7f227c0f41847b0598982f0a93170d powerpc/platforms: Move files from 4xx to 44x
date:   3 months ago
config: powerpc-randconfig-r132-20240916 (https://download.01.org/0day-ci/archive/20240917/202409170900.BtJZbhrx-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 14.1.0
reproduce: (https://download.01.org/0day-ci/archive/20240917/202409170900.BtJZbhrx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409170900.BtJZbhrx-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/powerpc/platforms/44x/uic.c:40:12: sparse: sparse: symbol 'primary_uic' was not declared. Should it be static?
   arch/powerpc/platforms/44x/uic.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/slab.h):
   include/linux/page-flags.h:240:46: sparse: sparse: self-comparison always evaluates to false
   include/linux/page-flags.h:240:46: sparse: sparse: self-comparison always evaluates to false
--
>> arch/powerpc/platforms/44x/pci.c:116:54: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __be32 const [usertype] *cell @@     got unsigned int const [usertype] * @@
   arch/powerpc/platforms/44x/pci.c:116:54: sparse:     expected restricted __be32 const [usertype] *cell
   arch/powerpc/platforms/44x/pci.c:116:54: sparse:     got unsigned int const [usertype] *
>> arch/powerpc/platforms/44x/pci.c:117:74: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected restricted __be32 const [usertype] *in_addr @@     got unsigned int const [usertype] * @@
   arch/powerpc/platforms/44x/pci.c:117:74: sparse:     expected restricted __be32 const [usertype] *in_addr
   arch/powerpc/platforms/44x/pci.c:117:74: sparse:     got unsigned int const [usertype] *
   arch/powerpc/platforms/44x/pci.c:118:52: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __be32 const [usertype] *cell @@     got unsigned int const [usertype] * @@
   arch/powerpc/platforms/44x/pci.c:118:52: sparse:     expected restricted __be32 const [usertype] *cell
   arch/powerpc/platforms/44x/pci.c:118:52: sparse:     got unsigned int const [usertype] *
>> arch/powerpc/platforms/44x/pci.c:1528:30: sparse: sparse: cast removes address space '__iomem' of expression
>> arch/powerpc/platforms/44x/pci.c:1528:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned char const volatile [noderef] [usertype] __iomem *addr @@     got unsigned char [usertype] * @@
   arch/powerpc/platforms/44x/pci.c:1528:30: sparse:     expected unsigned char const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/44x/pci.c:1528:30: sparse:     got unsigned char [usertype] *
   arch/powerpc/platforms/44x/pci.c:1531:33: sparse: sparse: cast removes address space '__iomem' of expression
>> arch/powerpc/platforms/44x/pci.c:1531:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned short const volatile [noderef] [usertype] __iomem *addr @@     got unsigned short [usertype] * @@
   arch/powerpc/platforms/44x/pci.c:1531:33: sparse:     expected unsigned short const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/44x/pci.c:1531:33: sparse:     got unsigned short [usertype] *
   arch/powerpc/platforms/44x/pci.c:1534:33: sparse: sparse: cast removes address space '__iomem' of expression
>> arch/powerpc/platforms/44x/pci.c:1534:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got unsigned int [usertype] * @@
   arch/powerpc/platforms/44x/pci.c:1534:33: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/44x/pci.c:1534:33: sparse:     got unsigned int [usertype] *
   arch/powerpc/platforms/44x/pci.c:1585:24: sparse: sparse: cast removes address space '__iomem' of expression
>> arch/powerpc/platforms/44x/pci.c:1585:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned char volatile [noderef] [usertype] __iomem *addr @@     got unsigned char [usertype] * @@
   arch/powerpc/platforms/44x/pci.c:1585:24: sparse:     expected unsigned char volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/44x/pci.c:1585:24: sparse:     got unsigned char [usertype] *
   arch/powerpc/platforms/44x/pci.c:1588:27: sparse: sparse: cast removes address space '__iomem' of expression
>> arch/powerpc/platforms/44x/pci.c:1588:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got unsigned short [usertype] * @@
   arch/powerpc/platforms/44x/pci.c:1588:27: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/44x/pci.c:1588:27: sparse:     got unsigned short [usertype] *
   arch/powerpc/platforms/44x/pci.c:1591:27: sparse: sparse: cast removes address space '__iomem' of expression
>> arch/powerpc/platforms/44x/pci.c:1591:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got unsigned int [usertype] * @@
   arch/powerpc/platforms/44x/pci.c:1591:27: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/44x/pci.c:1591:27: sparse:     got unsigned int [usertype] *
   arch/powerpc/platforms/44x/pci.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/xarray.h, ...):
   include/linux/page-flags.h:240:46: sparse: sparse: self-comparison always evaluates to false
   include/linux/page-flags.h:240:46: sparse: sparse: self-comparison always evaluates to false

vim +/primary_uic +40 arch/powerpc/platforms/44x/uic.c

e58923ed14370e arch/powerpc/sysdev/uic.c David Gibson 2007-04-18  39  
e58923ed14370e arch/powerpc/sysdev/uic.c David Gibson 2007-04-18 @40  struct uic *primary_uic;
e58923ed14370e arch/powerpc/sysdev/uic.c David Gibson 2007-04-18  41  

:::::: The code at line 40 was first introduced by commit
:::::: e58923ed14370e0facc5eb2c3923216adc3bf260 [POWERPC] Add arch/powerpc driver for UIC, PPC4xx interrupt controller

:::::: TO: David Gibson <david@gibson.dropbear.id.au>
:::::: CC: Paul Mackerras <paulus@samba.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

