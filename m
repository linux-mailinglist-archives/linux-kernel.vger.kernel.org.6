Return-Path: <linux-kernel+bounces-401615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2D39C1CF0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 13:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1052BB22022
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 12:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4651E883D;
	Fri,  8 Nov 2024 12:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dwENQZk8"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03731E7C17
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 12:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731068891; cv=none; b=PM6ZfN+w5XZ2Jhfz44D8Mr8obI5RMqgBThkiFLl50uCSd5tvFFNCLy7KfMlc5pP7/RW7ngaO0/9Zdz96d3uA8UUcrrPo6nqtJQ0DuhS5a8ETJ+ChojSs0g+A5e0/6VFfaJ5+K2Fecb2Lx5+hK37yMbN6GcXt/stmleshp3xHlsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731068891; c=relaxed/simple;
	bh=brAxYrXkgy8Rolsfy2hb+T8lT/zK43deaysaN3Vylmk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EwT+WM2KhvPsW80nEq8MBkOCFcIv2/pOtQSjCgSA2Lth0wU8Lbt7bxt/sLPl2i1Wf8ddUKnuXjf7LEkEFWAgoTNePmSJfIN59pR0h1DxA0Rw7TCpFlB82RsBJIH1VjfftAcn0uxh/jHGT2fPA4vTUJs/dVFLoYXnvv8NsykBal4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dwENQZk8; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731068889; x=1762604889;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=brAxYrXkgy8Rolsfy2hb+T8lT/zK43deaysaN3Vylmk=;
  b=dwENQZk8xWoMOBtWrkx1nvVfLk1BRwH2DhzI1aSLvy1K/wNvf2J4DJIK
   BPdlHN9eOy+B1hmCGYMpoECADXGz9PC3J4KkEQM0Gw0I4c11BdPREOK3A
   3xFwsPMsEV+Qf0RtiHkFXY4xhME0SNgSjrQGGgvpLdirQ0a96TDE2hmv1
   LIDOGGH8baaDr7nJDePvPjfsliwBUdHNSAxmVIZgbhxdvFO81bgEOs4nK
   LJqDhO1FsU3q7aw7/rgeyRxhVuTgoHLfhbdBqxoqT9tk2o3PMuwrKX9C1
   dOL/ZzeTNPQ98L4GJZfuZZ8mqKc3bbrz3ae5VerZXECn7KYDuFeZ7Bajx
   A==;
X-CSE-ConnectionGUID: bAF5aRsEQmKLhID6sIJ6Ng==
X-CSE-MsgGUID: cJIRQuvHQ7WNXdlMKHwSBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="41509123"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="41509123"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 04:28:09 -0800
X-CSE-ConnectionGUID: NZCpqOE9QByTj9pJ60h9kQ==
X-CSE-MsgGUID: IuOqzpVsRKeWo8qmGxFBPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,137,1728975600"; 
   d="scan'208";a="90083762"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 08 Nov 2024 04:28:05 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t9O5q-000rPs-0G;
	Fri, 08 Nov 2024 12:28:02 +0000
Date: Fri, 8 Nov 2024 20:27:16 +0800
From: kernel test robot <lkp@intel.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Helge Deller <deller@gmx.de>
Subject: drivers/video/fbdev/sh7760fb.c:363:31: sparse: sparse: incorrect
 type in argument 3 (different address spaces)
Message-ID: <202411082014.qSQ9A5ho-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Randy,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   906bd684e4b1e517dd424a354744c5b0aebef8af
commit: 51084f89d687e14d96278241e5200cde4b0985c7 fbdev: sh7760fb: allow modular build
date:   7 months ago
config: sh-randconfig-r132-20241108 (https://download.01.org/0day-ci/archive/20241108/202411082014.qSQ9A5ho-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.2.0
reproduce: (https://download.01.org/0day-ci/archive/20241108/202411082014.qSQ9A5ho-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411082014.qSQ9A5ho-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/video/fbdev/sh7760fb.c:363:31: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected void *cpu_addr @@     got char [noderef] __iomem *screen_base @@
   drivers/video/fbdev/sh7760fb.c:363:31: sparse:     expected void *cpu_addr
   drivers/video/fbdev/sh7760fb.c:363:31: sparse:     got char [noderef] __iomem *screen_base
>> drivers/video/fbdev/sh7760fb.c:423:27: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __iomem *screen_base @@     got void *[assigned] fbmem @@
   drivers/video/fbdev/sh7760fb.c:423:27: sparse:     expected char [noderef] __iomem *screen_base
   drivers/video/fbdev/sh7760fb.c:423:27: sparse:     got void *[assigned] fbmem
   drivers/video/fbdev/sh7760fb.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/xarray.h, ...):
   include/linux/page-flags.h:242:46: sparse: sparse: self-comparison always evaluates to false
   include/linux/page-flags.h:242:46: sparse: sparse: self-comparison always evaluates to false

vim +363 drivers/video/fbdev/sh7760fb.c

4a25e41831ee85 drivers/video/sh7760fb.c       Nobuhiro Iwamatsu 2008-07-23  354  
4a25e41831ee85 drivers/video/sh7760fb.c       Nobuhiro Iwamatsu 2008-07-23  355  static void sh7760fb_free_mem(struct fb_info *info)
4a25e41831ee85 drivers/video/sh7760fb.c       Nobuhiro Iwamatsu 2008-07-23  356  {
4a25e41831ee85 drivers/video/sh7760fb.c       Nobuhiro Iwamatsu 2008-07-23  357  	struct sh7760fb_par *par = info->par;
4a25e41831ee85 drivers/video/sh7760fb.c       Nobuhiro Iwamatsu 2008-07-23  358  
4a25e41831ee85 drivers/video/sh7760fb.c       Nobuhiro Iwamatsu 2008-07-23  359  	if (!info->screen_base)
4a25e41831ee85 drivers/video/sh7760fb.c       Nobuhiro Iwamatsu 2008-07-23  360  		return;
4a25e41831ee85 drivers/video/sh7760fb.c       Nobuhiro Iwamatsu 2008-07-23  361  
8404e56f4bc1d1 drivers/video/fbdev/sh7760fb.c Thomas Zimmermann 2023-06-13  362  	dma_free_coherent(info->device, info->screen_size,
4a25e41831ee85 drivers/video/sh7760fb.c       Nobuhiro Iwamatsu 2008-07-23 @363  			  info->screen_base, par->fbdma);
4a25e41831ee85 drivers/video/sh7760fb.c       Nobuhiro Iwamatsu 2008-07-23  364  
4a25e41831ee85 drivers/video/sh7760fb.c       Nobuhiro Iwamatsu 2008-07-23  365  	par->fbdma = 0;
4a25e41831ee85 drivers/video/sh7760fb.c       Nobuhiro Iwamatsu 2008-07-23  366  	info->screen_base = NULL;
4a25e41831ee85 drivers/video/sh7760fb.c       Nobuhiro Iwamatsu 2008-07-23  367  	info->screen_size = 0;
4a25e41831ee85 drivers/video/sh7760fb.c       Nobuhiro Iwamatsu 2008-07-23  368  }
4a25e41831ee85 drivers/video/sh7760fb.c       Nobuhiro Iwamatsu 2008-07-23  369  
4a25e41831ee85 drivers/video/sh7760fb.c       Nobuhiro Iwamatsu 2008-07-23  370  /* allocate the framebuffer memory. This memory must be in Area3,
4a25e41831ee85 drivers/video/sh7760fb.c       Nobuhiro Iwamatsu 2008-07-23  371   * (dictated by the DMA engine) and contiguous, at a 512 byte boundary.
4a25e41831ee85 drivers/video/sh7760fb.c       Nobuhiro Iwamatsu 2008-07-23  372   */
4a25e41831ee85 drivers/video/sh7760fb.c       Nobuhiro Iwamatsu 2008-07-23  373  static int sh7760fb_alloc_mem(struct fb_info *info)
4a25e41831ee85 drivers/video/sh7760fb.c       Nobuhiro Iwamatsu 2008-07-23  374  {
4a25e41831ee85 drivers/video/sh7760fb.c       Nobuhiro Iwamatsu 2008-07-23  375  	struct sh7760fb_par *par = info->par;
4a25e41831ee85 drivers/video/sh7760fb.c       Nobuhiro Iwamatsu 2008-07-23  376  	void *fbmem;
4a25e41831ee85 drivers/video/sh7760fb.c       Nobuhiro Iwamatsu 2008-07-23  377  	unsigned long vram;
4a25e41831ee85 drivers/video/sh7760fb.c       Nobuhiro Iwamatsu 2008-07-23  378  	int ret, bpp;
4a25e41831ee85 drivers/video/sh7760fb.c       Nobuhiro Iwamatsu 2008-07-23  379  
4a25e41831ee85 drivers/video/sh7760fb.c       Nobuhiro Iwamatsu 2008-07-23  380  	if (info->screen_base)
4a25e41831ee85 drivers/video/sh7760fb.c       Nobuhiro Iwamatsu 2008-07-23  381  		return 0;
4a25e41831ee85 drivers/video/sh7760fb.c       Nobuhiro Iwamatsu 2008-07-23  382  
4a25e41831ee85 drivers/video/sh7760fb.c       Nobuhiro Iwamatsu 2008-07-23  383  	/* get color info from register value */
f08c6c53b8e157 drivers/video/fbdev/sh7760fb.c Thomas Zimmermann 2023-06-13  384  	ret = sh7760fb_get_color_info(info, par->pd->lddfr, &bpp, NULL);
4a25e41831ee85 drivers/video/sh7760fb.c       Nobuhiro Iwamatsu 2008-07-23  385  	if (ret) {
4a25e41831ee85 drivers/video/sh7760fb.c       Nobuhiro Iwamatsu 2008-07-23  386  		printk(KERN_ERR "colinfo\n");
4a25e41831ee85 drivers/video/sh7760fb.c       Nobuhiro Iwamatsu 2008-07-23  387  		return ret;
4a25e41831ee85 drivers/video/sh7760fb.c       Nobuhiro Iwamatsu 2008-07-23  388  	}
4a25e41831ee85 drivers/video/sh7760fb.c       Nobuhiro Iwamatsu 2008-07-23  389  
4a25e41831ee85 drivers/video/sh7760fb.c       Nobuhiro Iwamatsu 2008-07-23  390  	/* min VRAM: xres_min = 16, yres_min = 1, bpp = 1: 2byte -> 1 page
4a25e41831ee85 drivers/video/sh7760fb.c       Nobuhiro Iwamatsu 2008-07-23  391  	   max VRAM: xres_max = 1024, yres_max = 1024, bpp = 16: 2MB */
4a25e41831ee85 drivers/video/sh7760fb.c       Nobuhiro Iwamatsu 2008-07-23  392  
4a25e41831ee85 drivers/video/sh7760fb.c       Nobuhiro Iwamatsu 2008-07-23  393  	vram = info->var.xres * info->var.yres;
4a25e41831ee85 drivers/video/sh7760fb.c       Nobuhiro Iwamatsu 2008-07-23  394  	if (info->var.grayscale) {
4a25e41831ee85 drivers/video/sh7760fb.c       Nobuhiro Iwamatsu 2008-07-23  395  		if (bpp == 1)
4a25e41831ee85 drivers/video/sh7760fb.c       Nobuhiro Iwamatsu 2008-07-23  396  			vram >>= 3;
4a25e41831ee85 drivers/video/sh7760fb.c       Nobuhiro Iwamatsu 2008-07-23  397  		else if (bpp == 2)
4a25e41831ee85 drivers/video/sh7760fb.c       Nobuhiro Iwamatsu 2008-07-23  398  			vram >>= 2;
4a25e41831ee85 drivers/video/sh7760fb.c       Nobuhiro Iwamatsu 2008-07-23  399  		else if (bpp == 4)
4a25e41831ee85 drivers/video/sh7760fb.c       Nobuhiro Iwamatsu 2008-07-23  400  			vram >>= 1;
4a25e41831ee85 drivers/video/sh7760fb.c       Nobuhiro Iwamatsu 2008-07-23  401  	} else if (bpp > 8)
4a25e41831ee85 drivers/video/sh7760fb.c       Nobuhiro Iwamatsu 2008-07-23  402  		vram *= 2;
4a25e41831ee85 drivers/video/sh7760fb.c       Nobuhiro Iwamatsu 2008-07-23  403  	if ((vram < 1) || (vram > 1024 * 2048)) {
46d86f3b3b1d22 drivers/video/fbdev/sh7760fb.c Thomas Zimmermann 2023-06-13  404  		fb_dbg(info, "too much VRAM required. Check settings\n");
4a25e41831ee85 drivers/video/sh7760fb.c       Nobuhiro Iwamatsu 2008-07-23  405  		return -ENODEV;
4a25e41831ee85 drivers/video/sh7760fb.c       Nobuhiro Iwamatsu 2008-07-23  406  	}
4a25e41831ee85 drivers/video/sh7760fb.c       Nobuhiro Iwamatsu 2008-07-23  407  
4a25e41831ee85 drivers/video/sh7760fb.c       Nobuhiro Iwamatsu 2008-07-23  408  	if (vram < PAGE_SIZE)
4a25e41831ee85 drivers/video/sh7760fb.c       Nobuhiro Iwamatsu 2008-07-23  409  		vram = PAGE_SIZE;
4a25e41831ee85 drivers/video/sh7760fb.c       Nobuhiro Iwamatsu 2008-07-23  410  
8404e56f4bc1d1 drivers/video/fbdev/sh7760fb.c Thomas Zimmermann 2023-06-13  411  	fbmem = dma_alloc_coherent(info->device, vram, &par->fbdma, GFP_KERNEL);
4a25e41831ee85 drivers/video/sh7760fb.c       Nobuhiro Iwamatsu 2008-07-23  412  
4a25e41831ee85 drivers/video/sh7760fb.c       Nobuhiro Iwamatsu 2008-07-23  413  	if (!fbmem)
4a25e41831ee85 drivers/video/sh7760fb.c       Nobuhiro Iwamatsu 2008-07-23  414  		return -ENOMEM;
4a25e41831ee85 drivers/video/sh7760fb.c       Nobuhiro Iwamatsu 2008-07-23  415  
4a25e41831ee85 drivers/video/sh7760fb.c       Nobuhiro Iwamatsu 2008-07-23  416  	if ((par->fbdma & SH7760FB_DMA_MASK) != SH7760FB_DMA_MASK) {
4a25e41831ee85 drivers/video/sh7760fb.c       Nobuhiro Iwamatsu 2008-07-23  417  		sh7760fb_free_mem(info);
8404e56f4bc1d1 drivers/video/fbdev/sh7760fb.c Thomas Zimmermann 2023-06-13  418  		dev_err(info->device, "kernel gave me memory at 0x%08lx, which is"
4a25e41831ee85 drivers/video/sh7760fb.c       Nobuhiro Iwamatsu 2008-07-23  419  			"unusable for the LCDC\n", (unsigned long)par->fbdma);
4a25e41831ee85 drivers/video/sh7760fb.c       Nobuhiro Iwamatsu 2008-07-23  420  		return -ENOMEM;
4a25e41831ee85 drivers/video/sh7760fb.c       Nobuhiro Iwamatsu 2008-07-23  421  	}
4a25e41831ee85 drivers/video/sh7760fb.c       Nobuhiro Iwamatsu 2008-07-23  422  
4a25e41831ee85 drivers/video/sh7760fb.c       Nobuhiro Iwamatsu 2008-07-23 @423  	info->screen_base = fbmem;
4a25e41831ee85 drivers/video/sh7760fb.c       Nobuhiro Iwamatsu 2008-07-23  424  	info->screen_size = vram;
537a1bf059fa31 drivers/video/sh7760fb.c       Krzysztof Helt    2009-06-30  425  	info->fix.smem_start = (unsigned long)info->screen_base;
537a1bf059fa31 drivers/video/sh7760fb.c       Krzysztof Helt    2009-06-30  426  	info->fix.smem_len = info->screen_size;
4a25e41831ee85 drivers/video/sh7760fb.c       Nobuhiro Iwamatsu 2008-07-23  427  
4a25e41831ee85 drivers/video/sh7760fb.c       Nobuhiro Iwamatsu 2008-07-23  428  	return 0;
4a25e41831ee85 drivers/video/sh7760fb.c       Nobuhiro Iwamatsu 2008-07-23  429  }
4a25e41831ee85 drivers/video/sh7760fb.c       Nobuhiro Iwamatsu 2008-07-23  430  

:::::: The code at line 363 was first introduced by commit
:::::: 4a25e41831ee851c1365d8b41decc22493b18e6d video: sh7760fb: SH7760/SH7763 LCDC framebuffer driver

:::::: TO: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

