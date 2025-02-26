Return-Path: <linux-kernel+bounces-535142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A0DA46F7E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 00:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 257AE188D392
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 23:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05EA225DB1E;
	Wed, 26 Feb 2025 23:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mwz4xeBN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CA625FA23
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 23:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740612770; cv=none; b=QL55klZg3wgbZ/ZMDHNGDTnKhMd2aSk4ld6cT459af9Lh/+M+t/89RZPPvJgf9Ol66LnxWiubiHr+lLYTihLkYLVw6lJoHykF4vQUkeIL6In4kLV6JoYTXF5wcIEaDVxz2ovzutPWm98QrY0DexRwqo3wMFjFFMajVmtUp80NKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740612770; c=relaxed/simple;
	bh=Z6oczsRL4Qrk5EsGGblA1Gkj/yW1zjMf4xn/yAa7B9I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=clgfmmB1eHpuh8PM1/9O/fNYg8+aWiQmRsqUkvDCU8ySwPpWiy1X+rfNEzuuN2uFfTix/cN2OzlLz9MtwhidqUV3eUt2+2Oygd2FXFbogOm3QF7yCTFwqbUCi0X/MXPvtYFwyEf/TRYCnSdaYwoxX3IMze9329+ASoJhosQgbTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mwz4xeBN; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740612768; x=1772148768;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Z6oczsRL4Qrk5EsGGblA1Gkj/yW1zjMf4xn/yAa7B9I=;
  b=Mwz4xeBNL4nzowOdzZ5WHaR8OY9BskpslLKhFDwPEXVsyy6d1+3jFrYE
   D+yqHkrOt6Y7U1tg7u2JwuxAznn8hEcON/YDiZqbVBFFTSbq99JbqTmk0
   CZsJBiie+ec+aFEGQr+tDEgUOc7AAYE6Fo9OrRpxBZn9MXIt/lCrPizFb
   VbLByBzeKugQvCaOtcafADQJuv9yWorxlcTtFAokm8UXRG2VGxObMDiEJ
   ee2kDPOgCRJqakpo5LBBAKAcFTpuVi2CxvHiHi23wGpNE+570SpoMpa2E
   z5YQ9lIro2icyzIsyTAAwRaYwoEGSUfXsOU1pLgKeE7wXntfPIOjOL4VG
   A==;
X-CSE-ConnectionGUID: orii6lwxTAGZ/0Lci9Ms2g==
X-CSE-MsgGUID: 20BKOZkYQ1GTDYs8p4Qk0w==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="41336703"
X-IronPort-AV: E=Sophos;i="6.13,318,1732608000"; 
   d="scan'208";a="41336703"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 15:32:47 -0800
X-CSE-ConnectionGUID: UtUeZGWzTd+f5l7j9Ye9cQ==
X-CSE-MsgGUID: 5rlCpWIfREu4T+JXR89SoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="120970563"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 26 Feb 2025 15:32:45 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tnQtA-000CbJ-1I;
	Wed, 26 Feb 2025 23:32:33 +0000
Date: Thu, 27 Feb 2025 07:30:54 +0800
From: kernel test robot <lkp@intel.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>
Subject: drivers/video/fbdev/pxafb.c:913:24: sparse: sparse: incorrect type
 in assignment (different address spaces)
Message-ID: <202502270742.weTnX9Oe-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f4ce1f3318ad4bc12463698696ebc36b145a6aa3
commit: 07438779313caafe52ac1a1a6958d735a5938988 alloc_tag: avoid current->alloc_tag manipulations when profiling is disabled
date:   5 weeks ago
config: arm-randconfig-r132-20250227 (https://download.01.org/0day-ci/archive/20250227/202502270742.weTnX9Oe-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.2.0
reproduce: (https://download.01.org/0day-ci/archive/20250227/202502270742.weTnX9Oe-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502270742.weTnX9Oe-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/video/fbdev/pxafb.c:913:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem *video_mem @@     got void *[assigned] _res @@
   drivers/video/fbdev/pxafb.c:913:24: sparse:     expected void [noderef] __iomem *video_mem
   drivers/video/fbdev/pxafb.c:913:24: sparse:     got void *[assigned] _res
   drivers/video/fbdev/pxafb.c:918:47: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile *x @@     got void [noderef] __iomem *video_mem @@
   drivers/video/fbdev/pxafb.c:918:47: sparse:     expected void const volatile *x
   drivers/video/fbdev/pxafb.c:918:47: sparse:     got void [noderef] __iomem *video_mem
   drivers/video/fbdev/pxafb.c:974:53: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *virt @@     got void [noderef] __iomem *video_mem @@
   drivers/video/fbdev/pxafb.c:974:53: sparse:     expected void *virt
   drivers/video/fbdev/pxafb.c:974:53: sparse:     got void [noderef] __iomem *video_mem
   drivers/video/fbdev/pxafb.c:1711:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem *video_mem @@     got void *[assigned] _res @@
   drivers/video/fbdev/pxafb.c:1711:24: sparse:     expected void [noderef] __iomem *video_mem
   drivers/video/fbdev/pxafb.c:1711:24: sparse:     got void *[assigned] _res
   drivers/video/fbdev/pxafb.c:1715:47: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile *x @@     got void [noderef] __iomem *video_mem @@
   drivers/video/fbdev/pxafb.c:1715:47: sparse:     expected void const volatile *x
   drivers/video/fbdev/pxafb.c:1715:47: sparse:     got void [noderef] __iomem *video_mem
   drivers/video/fbdev/pxafb.c:2387:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *virt @@     got void [noderef] __iomem *video_mem @@
   drivers/video/fbdev/pxafb.c:2387:29: sparse:     expected void *virt
   drivers/video/fbdev/pxafb.c:2387:29: sparse:     got void [noderef] __iomem *video_mem
   drivers/video/fbdev/pxafb.c:2414:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *virt @@     got void [noderef] __iomem *video_mem @@
   drivers/video/fbdev/pxafb.c:2414:29: sparse:     expected void *virt
   drivers/video/fbdev/pxafb.c:2414:29: sparse:     got void [noderef] __iomem *video_mem

vim +913 drivers/video/fbdev/pxafb.c

782385ae176b30 drivers/video/pxafb.c Eric Miao          2009-03-19  906  
48c68c4f1b5424 drivers/video/pxafb.c Greg Kroah-Hartman 2012-12-21  907  static int pxafb_overlay_map_video_memory(struct pxafb_info *pxafb,
1b98d7c4491e5e drivers/video/pxafb.c Vasily Khoruzhick  2011-03-11  908  					  struct pxafb_layer *ofb)
1b98d7c4491e5e drivers/video/pxafb.c Vasily Khoruzhick  2011-03-11  909  {
1b98d7c4491e5e drivers/video/pxafb.c Vasily Khoruzhick  2011-03-11  910  	/* We assume that user will use at most video_mem_size for overlay fb,
1b98d7c4491e5e drivers/video/pxafb.c Vasily Khoruzhick  2011-03-11  911  	 * anyway, it's useless to use 16bpp main plane and 24bpp overlay
1b98d7c4491e5e drivers/video/pxafb.c Vasily Khoruzhick  2011-03-11  912  	 */
1b98d7c4491e5e drivers/video/pxafb.c Vasily Khoruzhick  2011-03-11 @913  	ofb->video_mem = alloc_pages_exact(PAGE_ALIGN(pxafb->video_mem_size),
1b98d7c4491e5e drivers/video/pxafb.c Vasily Khoruzhick  2011-03-11  914  		GFP_KERNEL | __GFP_ZERO);
1b98d7c4491e5e drivers/video/pxafb.c Vasily Khoruzhick  2011-03-11  915  	if (ofb->video_mem == NULL)
1b98d7c4491e5e drivers/video/pxafb.c Vasily Khoruzhick  2011-03-11  916  		return -ENOMEM;
1b98d7c4491e5e drivers/video/pxafb.c Vasily Khoruzhick  2011-03-11  917  
1b98d7c4491e5e drivers/video/pxafb.c Vasily Khoruzhick  2011-03-11  918  	ofb->video_mem_phys = virt_to_phys(ofb->video_mem);
1b98d7c4491e5e drivers/video/pxafb.c Vasily Khoruzhick  2011-03-11  919  	ofb->video_mem_size = PAGE_ALIGN(pxafb->video_mem_size);
1b98d7c4491e5e drivers/video/pxafb.c Vasily Khoruzhick  2011-03-11  920  
1b98d7c4491e5e drivers/video/pxafb.c Vasily Khoruzhick  2011-03-11  921  	mutex_lock(&ofb->fb.mm_lock);
1b98d7c4491e5e drivers/video/pxafb.c Vasily Khoruzhick  2011-03-11  922  	ofb->fb.fix.smem_start	= ofb->video_mem_phys;
1b98d7c4491e5e drivers/video/pxafb.c Vasily Khoruzhick  2011-03-11  923  	ofb->fb.fix.smem_len	= pxafb->video_mem_size;
1b98d7c4491e5e drivers/video/pxafb.c Vasily Khoruzhick  2011-03-11  924  	mutex_unlock(&ofb->fb.mm_lock);
1b98d7c4491e5e drivers/video/pxafb.c Vasily Khoruzhick  2011-03-11  925  
1b98d7c4491e5e drivers/video/pxafb.c Vasily Khoruzhick  2011-03-11  926  	ofb->fb.screen_base	= ofb->video_mem;
1b98d7c4491e5e drivers/video/pxafb.c Vasily Khoruzhick  2011-03-11  927  
1b98d7c4491e5e drivers/video/pxafb.c Vasily Khoruzhick  2011-03-11  928  	return 0;
1b98d7c4491e5e drivers/video/pxafb.c Vasily Khoruzhick  2011-03-11  929  }
1b98d7c4491e5e drivers/video/pxafb.c Vasily Khoruzhick  2011-03-11  930  

:::::: The code at line 913 was first introduced by commit
:::::: 1b98d7c4491e5eaba7c403ec1bc5997e6596e569 ARM: pxafb: rework pxafb overlay memory management

:::::: TO: Vasily Khoruzhick <anarsoul@gmail.com>
:::::: CC: Eric Miao <eric.y.miao@gmail.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

