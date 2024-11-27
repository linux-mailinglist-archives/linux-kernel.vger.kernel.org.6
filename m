Return-Path: <linux-kernel+bounces-424004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D459DAF3B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 23:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED767B21B00
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 22:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21607201024;
	Wed, 27 Nov 2024 22:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C8BhfejY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9C11925BF
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 22:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732746278; cv=none; b=rog+rggTsJLAL4gtgzvYcK40kpzoycKJicqacBzO5pVs+Z/imG/CJ7FrGkx59g/FcP+4Rrjmh0K+ctDuQStTjNnkvfF8CvMwrs8goDEQCeBOYkSE2AhyVc5OG8YVl2DpmLhSshR+Zo/bpDcVLuHf4BuqPzvyDgBoBQJS96fu344=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732746278; c=relaxed/simple;
	bh=BpgYeGEShcUV50Ibyeh0m+MoaUeIrXUZqXAPcxx/G4k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sXbrlrHh99Rx9CnxsaljyneYbsTQeKK9yv7KP3TD+mRdGrs+pJeX2ntaTSaRgFNPX0bpZjyyiZ6NehgYcevJIVSqZBqkE6Todwe0IWFNtD+xc1Jcz/PEDYC+s8DSBqo77vHEUXJPck1cSumuszYcyIutoahvrD5rqtpq+mFDts4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C8BhfejY; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732746277; x=1764282277;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BpgYeGEShcUV50Ibyeh0m+MoaUeIrXUZqXAPcxx/G4k=;
  b=C8BhfejYYWCRs0lbdHAYFVyDkHNr6uzw7KRp4HH0Y44Z6V5vJ/tblUYT
   ta5bDMQ+xg6mp2Hxgl+oGjIxjYFva8P0bzfsQUKsVrbTutWALu/0JbG3A
   Ur63AycHd1tlV680fRsMnUNdSzH40de4hkqYORoE0DlQYt7FbUq+RA9zt
   T38h+HvGyGXukgWvxp8nWRQOki2KIqGVH2WrKyLDps8tWoQhoFlgO0C3b
   vQXgsLV8ZWcbbSUt791+0pWtDq8HjkKdQk+wnJ8Iv/c3sXTQOAjLEkgzP
   MoDZRBtL0JlFna/rev4SufFcfMd4d7YTCHUk3GnUv645k6ZitqKmpjL86
   Q==;
X-CSE-ConnectionGUID: gIyGFZ91QQG8/6XSaTwydQ==
X-CSE-MsgGUID: FIymT8g8RNetxPfKQGpFmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11269"; a="32918468"
X-IronPort-AV: E=Sophos;i="6.12,190,1728975600"; 
   d="scan'208";a="32918468"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2024 14:24:36 -0800
X-CSE-ConnectionGUID: I/jLG/sWTT2YYRtCH2gDvQ==
X-CSE-MsgGUID: B8SJyIw3S72IKv+1YBqECQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,190,1728975600"; 
   d="scan'208";a="96505398"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 27 Nov 2024 14:24:35 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tGQSX-0008PD-0F;
	Wed, 27 Nov 2024 22:24:33 +0000
Date: Thu, 28 Nov 2024 06:23:45 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: arch/arm/mach-mv78xx0/pcie.c:46:5: sparse: sparse: symbol
 'pcie_port_size' was not declared. Should it be static?
Message-ID: <202411280649.ZlacdSn2-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7d4050728c83aa63828494ad0f4d0eb4faf5f97a
commit: 7036440eab3e2d47a775d4616909f8235488d714 ARM: omap1: enable multiplatform
date:   2 years, 6 months ago
config: arm-randconfig-r131-20241123 (https://download.01.org/0day-ci/archive/20241128/202411280649.ZlacdSn2-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 592c0fe55f6d9a811028b5f3507be91458ab2713)
reproduce: (https://download.01.org/0day-ci/archive/20241128/202411280649.ZlacdSn2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411280649.ZlacdSn2-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/arm/mach-mv78xx0/pcie.c:46:5: sparse: sparse: symbol 'pcie_port_size' was not declared. Should it be static?
--
>> drivers/irqchip/irq-davinci-cp-intc.c:166:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem *req @@     got struct resource * @@
   drivers/irqchip/irq-davinci-cp-intc.c:166:13: sparse:     expected void [noderef] __iomem *req
   drivers/irqchip/irq-davinci-cp-intc.c:166:13: sparse:     got struct resource *

vim +/pcie_port_size +46 arch/arm/mach-mv78xx0/pcie.c

cfdeb6376e439c5 Lennert Buytenhek 2009-02-20  45  
0b9b18e0166d892 Rob Herring       2012-07-09 @46  u32 pcie_port_size[8] = {
0b9b18e0166d892 Rob Herring       2012-07-09  47  	0,
0b9b18e0166d892 Rob Herring       2012-07-09  48  	0x30000000,
0b9b18e0166d892 Rob Herring       2012-07-09  49  	0x10000000,
0b9b18e0166d892 Rob Herring       2012-07-09  50  	0x10000000,
0b9b18e0166d892 Rob Herring       2012-07-09  51  	0x08000000,
0b9b18e0166d892 Rob Herring       2012-07-09  52  	0x08000000,
0b9b18e0166d892 Rob Herring       2012-07-09  53  	0x08000000,
0b9b18e0166d892 Rob Herring       2012-07-09  54  	0x04000000,
0b9b18e0166d892 Rob Herring       2012-07-09  55  };
0b9b18e0166d892 Rob Herring       2012-07-09  56  

:::::: The code at line 46 was first introduced by commit
:::::: 0b9b18e0166d8925ed222335efbc3cfd66aa882f ARM: mv78xx0: use fixed pci i/o mapping

:::::: TO: Rob Herring <rob.herring@calxeda.com>
:::::: CC: Rob Herring <rob.herring@calxeda.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

