Return-Path: <linux-kernel+bounces-436737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF12F9E8A19
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 05:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DAFB1885473
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 04:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85E11553A3;
	Mon,  9 Dec 2024 04:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cp9U9vez"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5251C320B
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 04:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733717065; cv=none; b=ks0Mz9qSpD/VK8siV+7V82gQkpDQUNJVBne7+zebHNuQ0rI5cgdlehi3FgAHtIxHsN//MTv15EEKG72vuZDJvPA3L0Pluttn4m9szPQtoj/7CwdVlvMIBtIdbG1bT7pH4tZJ6WXIC3TxyeAE1KynjgZ+iv7/MXhXu6qplfCksdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733717065; c=relaxed/simple;
	bh=6fs1FITLlf7v01OxhmlAAm4QY2CxESnZvJyHcF1Hrvg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QnWWfwiXDWggOa18mgkRe+KVdgXBi19bOj6sUgLJbgC3Juo8SD6nC3qAJYQ3pfcEuHas4LyrlNz7uVI188ccyjqcDg37knka4DIu5eih2o7brLPTlguwPvqVSshdDCOekPZSfva7U10iXFd41DP2s+EB2ZetFXC3sp8z4+m4d2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cp9U9vez; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733717064; x=1765253064;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=6fs1FITLlf7v01OxhmlAAm4QY2CxESnZvJyHcF1Hrvg=;
  b=Cp9U9vezEPBQP35xC3fJs+8on6v6ZwAReg9E+E9DWeqT6ElQK+tSPz53
   NaE7rqZ99Hfr3DaGOhoKZSSyPnJlXRbTHqgG1GNiYmHxLhf1yBHrN3ilI
   rXeV/+VnQiIWD1O02vO1+fqPL2EeVcFlSEQzaDt7ZCAqHfI/8veNeZejU
   NOuFuIYdvXiQdhFwrz+MrcrYUBB2mbvZZzWfC0Op/s2SOwHiN5rq/0Kh6
   IRDW6gLWBV5LnVsuZVljEaaQWzCb4KMMYfvF1xZO03B7IGOdD/+JnGf1C
   nbTJG/ZJ8361uOfLcxfM7j65OnmJKLo6R3urdYePWYmOk6A6hd9srKw83
   Q==;
X-CSE-ConnectionGUID: /30skJ2UTNaNDWq8LZ0Leg==
X-CSE-MsgGUID: U4WUAQu4RdS+tmWhQiRCkQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11280"; a="33923673"
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="33923673"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2024 20:04:07 -0800
X-CSE-ConnectionGUID: uHI4zN9VQ+u5QPRjCRWFyg==
X-CSE-MsgGUID: 2EK0bpPYRhWwLD7AKp4s0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="95150830"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 08 Dec 2024 20:04:04 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tKV06-0003mV-04;
	Mon, 09 Dec 2024 04:04:02 +0000
Date: Mon, 9 Dec 2024 12:02:59 +0800
From: kernel test robot <lkp@intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Jonathan Cavitt <jonathan.cavitt@intel.com>
Subject: drivers/gpu/drm/drm_fb_helper.c:756:undefined reference to
 `fb_set_suspend'
Message-ID: <202412071129.GeWL4VvN-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b5f217084ab3ddd4bdd03cd437f8e3b7e2d1f5b6
commit: dadd28d4142f9ad39eefb7b45ee7518bd4d2459c drm/client: Add client-lib module
date:   7 weeks ago
config: nios2-randconfig-002-20241207 (https://download.01.org/0day-ci/archive/20241207/202412071129.GeWL4VvN-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241207/202412071129.GeWL4VvN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412071129.GeWL4VvN-lkp@intel.com/

All errors (new ones prefixed by >>):

   nios2-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_set_suspend':
>> drivers/gpu/drm/drm_fb_helper.c:756:(.text+0x334): undefined reference to `fb_set_suspend'
>> drivers/gpu/drm/drm_fb_helper.c:756:(.text+0x334): relocation truncated to fit: R_NIOS2_CALL26 against `fb_set_suspend'
   nios2-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_resume_worker':
   drivers/gpu/drm/drm_fb_helper.c:355:(.text+0x364): undefined reference to `fb_set_suspend'
   drivers/gpu/drm/drm_fb_helper.c:355:(.text+0x364): relocation truncated to fit: R_NIOS2_CALL26 against `fb_set_suspend'
   nios2-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_alloc_info':
>> drivers/gpu/drm/drm_fb_helper.c:509:(.text+0x40c): undefined reference to `framebuffer_alloc'
>> drivers/gpu/drm/drm_fb_helper.c:509:(.text+0x40c): relocation truncated to fit: R_NIOS2_CALL26 against `framebuffer_alloc'
>> nios2-linux-ld: drivers/gpu/drm/drm_fb_helper.c:516:(.text+0x430): undefined reference to `fb_alloc_cmap'
>> drivers/gpu/drm/drm_fb_helper.c:516:(.text+0x430): relocation truncated to fit: R_NIOS2_CALL26 against `fb_alloc_cmap'
>> nios2-linux-ld: drivers/gpu/drm/drm_fb_helper.c:527:(.text+0x46c): undefined reference to `framebuffer_release'
>> drivers/gpu/drm/drm_fb_helper.c:527:(.text+0x46c): relocation truncated to fit: R_NIOS2_CALL26 against `framebuffer_release'
   nios2-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_release_info':
>> drivers/gpu/drm/drm_fb_helper.c:551:(.text+0x4a0): undefined reference to `framebuffer_release'
   drivers/gpu/drm/drm_fb_helper.c:551:(.text+0x4a0): relocation truncated to fit: R_NIOS2_CALL26 against `framebuffer_release'
>> nios2-linux-ld: drivers/gpu/drm/drm_fb_helper.c:550:(.text+0x4b8): undefined reference to `fb_dealloc_cmap'
>> drivers/gpu/drm/drm_fb_helper.c:550:(.text+0x4b8): relocation truncated to fit: R_NIOS2_CALL26 against `fb_dealloc_cmap'
   nios2-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_unregister_info':
>> drivers/gpu/drm/drm_fb_helper.c:570:(.text+0x4cc): undefined reference to `unregister_framebuffer'
>> drivers/gpu/drm/drm_fb_helper.c:570:(.text+0x4cc): relocation truncated to fit: R_NIOS2_CALL26 against `unregister_framebuffer'
   nios2-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_set_suspend_unlocked':
   drivers/gpu/drm/drm_fb_helper.c:801:(.text+0x1500): undefined reference to `fb_set_suspend'
   drivers/gpu/drm/drm_fb_helper.c:801:(.text+0x1500): relocation truncated to fit: R_NIOS2_CALL26 against `fb_set_suspend'
   nios2-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `__drm_fb_helper_initial_config_and_unlock':
>> drivers/gpu/drm/drm_fb_helper.c:1839:(.text+0x1b5c): undefined reference to `register_framebuffer'
>> drivers/gpu/drm/drm_fb_helper.c:1839:(.text+0x1b5c): relocation truncated to fit: R_NIOS2_CALL26 against `register_framebuffer'
   nios2-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_fini':
   drivers/gpu/drm/drm_fb_helper.c:551:(.text+0x1ed0): undefined reference to `framebuffer_release'
   drivers/gpu/drm/drm_fb_helper.c:551:(.text+0x1ed0): additional relocation overflows omitted from the output
   nios2-linux-ld: drivers/gpu/drm/drm_fb_helper.c:550:(.text+0x1f3c): undefined reference to `fb_dealloc_cmap'


vim +756 drivers/gpu/drm/drm_fb_helper.c

6a4fef21816be4 Thomas Zimmermann 2023-03-20  554  
b8017d6c33be98 Archit Taneja     2015-07-22  555  /**
afb0ff78c13c51 Thomas Zimmermann 2022-11-03  556   * drm_fb_helper_unregister_info - unregister fb_info framebuffer device
02257549daf7ff Thomas Zimmermann 2024-09-24  557   * @fb_helper: driver-allocated fbdev helper, must not be NULL
b8017d6c33be98 Archit Taneja     2015-07-22  558   *
b8017d6c33be98 Archit Taneja     2015-07-22  559   * A wrapper around unregister_framebuffer, to release the fb_info
ed84e2542d2278 Simona Vetter     2017-02-07  560   * framebuffer device. This must be called before releasing all resources for
ed84e2542d2278 Simona Vetter     2017-02-07  561   * @fb_helper by calling drm_fb_helper_fini().
b8017d6c33be98 Archit Taneja     2015-07-22  562   */
afb0ff78c13c51 Thomas Zimmermann 2022-11-03  563  void drm_fb_helper_unregister_info(struct drm_fb_helper *fb_helper)
b8017d6c33be98 Archit Taneja     2015-07-22  564  {
02257549daf7ff Thomas Zimmermann 2024-09-24  565  	struct fb_info *info = fb_helper->info;
02257549daf7ff Thomas Zimmermann 2024-09-24  566  	struct device *dev = info->device;
02257549daf7ff Thomas Zimmermann 2024-09-24  567  
02257549daf7ff Thomas Zimmermann 2024-09-24  568  	if (dev_is_pci(dev))
02257549daf7ff Thomas Zimmermann 2024-09-24  569  		vga_switcheroo_client_fb_set(to_pci_dev(dev), NULL);
9877d8f6bc3749 Thomas Zimmermann 2022-11-03 @570  	unregister_framebuffer(fb_helper->info);
b8017d6c33be98 Archit Taneja     2015-07-22  571  }
afb0ff78c13c51 Thomas Zimmermann 2022-11-03  572  EXPORT_SYMBOL(drm_fb_helper_unregister_info);
b8017d6c33be98 Archit Taneja     2015-07-22  573  
b8017d6c33be98 Archit Taneja     2015-07-22  574  /**
da7bdda2afdf1a Simona Vetter     2017-02-07  575   * drm_fb_helper_fini - finialize a &struct drm_fb_helper
c777990fb45b57 Noralf Trønnes    2017-10-30  576   * @fb_helper: driver-allocated fbdev helper, can be NULL
b8017d6c33be98 Archit Taneja     2015-07-22  577   *
6821603aa0ae3b Thomas Zimmermann 2019-11-14  578   * This cleans up all remaining resources associated with @fb_helper.
b8017d6c33be98 Archit Taneja     2015-07-22  579   */
da7bdda2afdf1a Simona Vetter     2017-02-07  580  void drm_fb_helper_fini(struct drm_fb_helper *fb_helper)
b8017d6c33be98 Archit Taneja     2015-07-22  581  {
29ad20b22c8f3a Noralf Trønnes    2017-10-30  582  	if (!fb_helper)
29ad20b22c8f3a Noralf Trønnes    2017-10-30  583  		return;
29ad20b22c8f3a Noralf Trønnes    2017-10-30  584  
29ad20b22c8f3a Noralf Trønnes    2017-10-30  585  	fb_helper->dev->fb_helper = NULL;
29ad20b22c8f3a Noralf Trønnes    2017-10-30  586  
29ad20b22c8f3a Noralf Trønnes    2017-10-30  587  	if (!drm_fbdev_emulation)
da7bdda2afdf1a Simona Vetter     2017-02-07  588  		return;
da7bdda2afdf1a Simona Vetter     2017-02-07  589  
b52f09c494507a Noralf Trønnes    2017-08-28  590  	cancel_work_sync(&fb_helper->resume_work);
7aa3d63e1ad56c Thomas Zimmermann 2022-11-18  591  	cancel_work_sync(&fb_helper->damage_work);
b52f09c494507a Noralf Trønnes    2017-08-28  592  
6a4fef21816be4 Thomas Zimmermann 2023-03-20  593  	drm_fb_helper_release_info(fb_helper);
f64c5573d253ab Simona Vetter     2015-08-25  594  
a53ca63502e62c Chris Wilson      2016-11-29  595  	mutex_lock(&kernel_fb_helper_lock);
4abe35204af82a Dave Airlie       2010-03-30  596  	if (!list_empty(&fb_helper->kernel_fb_list)) {
4abe35204af82a Dave Airlie       2010-03-30  597  		list_del(&fb_helper->kernel_fb_list);
4b4f99f57febb9 Thierry Reding    2017-03-29  598  		if (list_empty(&kernel_fb_helper_list))
4abe35204af82a Dave Airlie       2010-03-30  599  			unregister_sysrq_key('v', &sysrq_drm_fb_helper_restore_op);
4abe35204af82a Dave Airlie       2010-03-30  600  	}
a53ca63502e62c Chris Wilson      2016-11-29  601  	mutex_unlock(&kernel_fb_helper_lock);
4abe35204af82a Dave Airlie       2010-03-30  602  
d81294afeecdac Noralf Trønnes    2019-05-31  603  	if (!fb_helper->client.funcs)
d81294afeecdac Noralf Trønnes    2019-05-31  604  		drm_client_release(&fb_helper->client);
4abe35204af82a Dave Airlie       2010-03-30  605  }
4abe35204af82a Dave Airlie       2010-03-30  606  EXPORT_SYMBOL(drm_fb_helper_fini);
785b93ef8c3097 Dave Airlie       2009-08-28  607  
b1be5ba29374aa Thomas Zimmermann 2022-11-15  608  static void drm_fb_helper_add_damage_clip(struct drm_fb_helper *helper, u32 x, u32 y,
eaa434defaca17 Noralf Trønnes    2016-04-28  609  					  u32 width, u32 height)
eaa434defaca17 Noralf Trønnes    2016-04-28  610  {
9622349ea1b623 Thomas Zimmermann 2020-11-20  611  	struct drm_clip_rect *clip = &helper->damage_clip;
eaa434defaca17 Noralf Trønnes    2016-04-28  612  	unsigned long flags;
eaa434defaca17 Noralf Trønnes    2016-04-28  613  
9622349ea1b623 Thomas Zimmermann 2020-11-20  614  	spin_lock_irqsave(&helper->damage_lock, flags);
eaa434defaca17 Noralf Trønnes    2016-04-28  615  	clip->x1 = min_t(u32, clip->x1, x);
eaa434defaca17 Noralf Trønnes    2016-04-28  616  	clip->y1 = min_t(u32, clip->y1, y);
eaa434defaca17 Noralf Trønnes    2016-04-28  617  	clip->x2 = max_t(u32, clip->x2, x + width);
eaa434defaca17 Noralf Trønnes    2016-04-28  618  	clip->y2 = max_t(u32, clip->y2, y + height);
9622349ea1b623 Thomas Zimmermann 2020-11-20  619  	spin_unlock_irqrestore(&helper->damage_lock, flags);
b1be5ba29374aa Thomas Zimmermann 2022-11-15  620  }
b1be5ba29374aa Thomas Zimmermann 2022-11-15  621  
b1be5ba29374aa Thomas Zimmermann 2022-11-15  622  static void drm_fb_helper_damage(struct drm_fb_helper *helper, u32 x, u32 y,
b1be5ba29374aa Thomas Zimmermann 2022-11-15  623  				 u32 width, u32 height)
b1be5ba29374aa Thomas Zimmermann 2022-11-15  624  {
833cd3e9ad8360 Qiuxu Zhuo        2024-07-03  625  	/*
833cd3e9ad8360 Qiuxu Zhuo        2024-07-03  626  	 * This function may be invoked by panic() to flush the frame
833cd3e9ad8360 Qiuxu Zhuo        2024-07-03  627  	 * buffer, where all CPUs except the panic CPU are stopped.
833cd3e9ad8360 Qiuxu Zhuo        2024-07-03  628  	 * During the following schedule_work(), the panic CPU needs
833cd3e9ad8360 Qiuxu Zhuo        2024-07-03  629  	 * the worker_pool lock, which might be held by a stopped CPU,
833cd3e9ad8360 Qiuxu Zhuo        2024-07-03  630  	 * causing schedule_work() and panic() to block. Return early on
833cd3e9ad8360 Qiuxu Zhuo        2024-07-03  631  	 * oops_in_progress to prevent this blocking.
833cd3e9ad8360 Qiuxu Zhuo        2024-07-03  632  	 */
833cd3e9ad8360 Qiuxu Zhuo        2024-07-03  633  	if (oops_in_progress)
833cd3e9ad8360 Qiuxu Zhuo        2024-07-03  634  		return;
833cd3e9ad8360 Qiuxu Zhuo        2024-07-03  635  
b1be5ba29374aa Thomas Zimmermann 2022-11-15  636  	drm_fb_helper_add_damage_clip(helper, x, y, width, height);
eaa434defaca17 Noralf Trønnes    2016-04-28  637  
8b83e1a455382d Thomas Zimmermann 2022-11-18  638  	schedule_work(&helper->damage_work);
eaa434defaca17 Noralf Trønnes    2016-04-28  639  }
eaa434defaca17 Noralf Trønnes    2016-04-28  640  
ae25885bdf59fd Thomas Zimmermann 2022-06-21  641  /*
ae25885bdf59fd Thomas Zimmermann 2022-06-21  642   * Convert memory region into area of scanlines and pixels per
ae25885bdf59fd Thomas Zimmermann 2022-06-21  643   * scanline. The parameters off and len must not reach beyond
ae25885bdf59fd Thomas Zimmermann 2022-06-21  644   * the end of the framebuffer.
ae25885bdf59fd Thomas Zimmermann 2022-06-21  645   */
67b723f5b74254 Thomas Zimmermann 2022-02-09  646  static void drm_fb_helper_memory_range_to_clip(struct fb_info *info, off_t off, size_t len,
67b723f5b74254 Thomas Zimmermann 2022-02-09  647  					       struct drm_rect *clip)
67b723f5b74254 Thomas Zimmermann 2022-02-09  648  {
c8687694bb1f5c Sui Jingfeng      2023-04-20  649  	u32 line_length = info->fix.line_length;
c8687694bb1f5c Sui Jingfeng      2023-04-20  650  	u32 fb_height = info->var.yres;
67b723f5b74254 Thomas Zimmermann 2022-02-09  651  	off_t end = off + len;
67b723f5b74254 Thomas Zimmermann 2022-02-09  652  	u32 x1 = 0;
c8687694bb1f5c Sui Jingfeng      2023-04-20  653  	u32 y1 = off / line_length;
67b723f5b74254 Thomas Zimmermann 2022-02-09  654  	u32 x2 = info->var.xres;
c8687694bb1f5c Sui Jingfeng      2023-04-20  655  	u32 y2 = DIV_ROUND_UP(end, line_length);
c8687694bb1f5c Sui Jingfeng      2023-04-20  656  
c8687694bb1f5c Sui Jingfeng      2023-04-20  657  	/* Don't allow any of them beyond the bottom bound of display area */
c8687694bb1f5c Sui Jingfeng      2023-04-20  658  	if (y1 > fb_height)
c8687694bb1f5c Sui Jingfeng      2023-04-20  659  		y1 = fb_height;
c8687694bb1f5c Sui Jingfeng      2023-04-20  660  	if (y2 > fb_height)
c8687694bb1f5c Sui Jingfeng      2023-04-20  661  		y2 = fb_height;
67b723f5b74254 Thomas Zimmermann 2022-02-09  662  
ded74cafeea931 Thomas Zimmermann 2022-02-09  663  	if ((y2 - y1) == 1) {
ded74cafeea931 Thomas Zimmermann 2022-02-09  664  		/*
ded74cafeea931 Thomas Zimmermann 2022-02-09  665  		 * We've only written to a single scanline. Try to reduce
ded74cafeea931 Thomas Zimmermann 2022-02-09  666  		 * the number of horizontal pixels that need an update.
ded74cafeea931 Thomas Zimmermann 2022-02-09  667  		 */
c8687694bb1f5c Sui Jingfeng      2023-04-20  668  		off_t bit_off = (off % line_length) * 8;
c8687694bb1f5c Sui Jingfeng      2023-04-20  669  		off_t bit_end = (end % line_length) * 8;
ded74cafeea931 Thomas Zimmermann 2022-02-09  670  
ded74cafeea931 Thomas Zimmermann 2022-02-09  671  		x1 = bit_off / info->var.bits_per_pixel;
ded74cafeea931 Thomas Zimmermann 2022-02-09  672  		x2 = DIV_ROUND_UP(bit_end, info->var.bits_per_pixel);
ded74cafeea931 Thomas Zimmermann 2022-02-09  673  	}
ded74cafeea931 Thomas Zimmermann 2022-02-09  674  
67b723f5b74254 Thomas Zimmermann 2022-02-09  675  	drm_rect_init(clip, x1, y1, x2 - x1, y2 - y1);
67b723f5b74254 Thomas Zimmermann 2022-02-09  676  }
67b723f5b74254 Thomas Zimmermann 2022-02-09  677  
c51b36207c04ba Thomas Zimmermann 2023-05-30  678  /* Don't use in new code. */
c51b36207c04ba Thomas Zimmermann 2023-05-30  679  void drm_fb_helper_damage_range(struct fb_info *info, off_t off, size_t len)
c51b36207c04ba Thomas Zimmermann 2023-05-30  680  {
c51b36207c04ba Thomas Zimmermann 2023-05-30  681  	struct drm_fb_helper *fb_helper = info->par;
c51b36207c04ba Thomas Zimmermann 2023-05-30  682  	struct drm_rect damage_area;
c51b36207c04ba Thomas Zimmermann 2023-05-30  683  
c51b36207c04ba Thomas Zimmermann 2023-05-30  684  	drm_fb_helper_memory_range_to_clip(info, off, len, &damage_area);
c51b36207c04ba Thomas Zimmermann 2023-05-30  685  	drm_fb_helper_damage(fb_helper, damage_area.x1, damage_area.y1,
c51b36207c04ba Thomas Zimmermann 2023-05-30  686  			     drm_rect_width(&damage_area),
c51b36207c04ba Thomas Zimmermann 2023-05-30  687  			     drm_rect_height(&damage_area));
c51b36207c04ba Thomas Zimmermann 2023-05-30  688  }
c51b36207c04ba Thomas Zimmermann 2023-05-30  689  EXPORT_SYMBOL(drm_fb_helper_damage_range);
c51b36207c04ba Thomas Zimmermann 2023-05-30  690  
c51b36207c04ba Thomas Zimmermann 2023-05-30  691  /* Don't use in new code. */
c51b36207c04ba Thomas Zimmermann 2023-05-30  692  void drm_fb_helper_damage_area(struct fb_info *info, u32 x, u32 y, u32 width, u32 height)
c51b36207c04ba Thomas Zimmermann 2023-05-30  693  {
c51b36207c04ba Thomas Zimmermann 2023-05-30  694  	struct drm_fb_helper *fb_helper = info->par;
c51b36207c04ba Thomas Zimmermann 2023-05-30  695  
c51b36207c04ba Thomas Zimmermann 2023-05-30  696  	drm_fb_helper_damage(fb_helper, x, y, width, height);
c51b36207c04ba Thomas Zimmermann 2023-05-30  697  }
c51b36207c04ba Thomas Zimmermann 2023-05-30  698  EXPORT_SYMBOL(drm_fb_helper_damage_area);
c51b36207c04ba Thomas Zimmermann 2023-05-30  699  
eaa434defaca17 Noralf Trønnes    2016-04-28  700  /**
eaa434defaca17 Noralf Trønnes    2016-04-28  701   * drm_fb_helper_deferred_io() - fbdev deferred_io callback function
eaa434defaca17 Noralf Trønnes    2016-04-28  702   * @info: fb_info struct pointer
e80eec1b871a2a Thomas Zimmermann 2022-04-29  703   * @pagereflist: list of mmap framebuffer pages that have to be flushed
eaa434defaca17 Noralf Trønnes    2016-04-28  704   *
6806cdf9aa1c82 Simona Vetter     2017-01-25  705   * This function is used as the &fb_deferred_io.deferred_io
eaa434defaca17 Noralf Trønnes    2016-04-28  706   * callback function for flushing the fbdev mmap writes.
eaa434defaca17 Noralf Trønnes    2016-04-28  707   */
e80eec1b871a2a Thomas Zimmermann 2022-04-29  708  void drm_fb_helper_deferred_io(struct fb_info *info, struct list_head *pagereflist)
eaa434defaca17 Noralf Trønnes    2016-04-28  709  {
93e81e38e19760 Thomas Zimmermann 2022-11-03  710  	struct drm_fb_helper *helper = info->par;
24dc4f4c2a5cc9 Thomas Zimmermann 2023-03-20  711  	unsigned long start, end, min_off, max_off, total_size;
56c134f7f1b58b Thomas Zimmermann 2022-04-29  712  	struct fb_deferred_io_pageref *pageref;
67b723f5b74254 Thomas Zimmermann 2022-02-09  713  	struct drm_rect damage_area;
eaa434defaca17 Noralf Trønnes    2016-04-28  714  
ae25885bdf59fd Thomas Zimmermann 2022-06-21  715  	min_off = ULONG_MAX;
ae25885bdf59fd Thomas Zimmermann 2022-06-21  716  	max_off = 0;
e80eec1b871a2a Thomas Zimmermann 2022-04-29  717  	list_for_each_entry(pageref, pagereflist, list) {
56c134f7f1b58b Thomas Zimmermann 2022-04-29  718  		start = pageref->offset;
a3c286dcef7f8b Thomas Zimmermann 2022-02-09  719  		end = start + PAGE_SIZE;
ae25885bdf59fd Thomas Zimmermann 2022-06-21  720  		min_off = min(min_off, start);
ae25885bdf59fd Thomas Zimmermann 2022-06-21  721  		max_off = max(max_off, end);
eaa434defaca17 Noralf Trønnes    2016-04-28  722  	}
eaa434defaca17 Noralf Trønnes    2016-04-28  723  
ae25885bdf59fd Thomas Zimmermann 2022-06-21  724  	/*
ae25885bdf59fd Thomas Zimmermann 2022-06-21  725  	 * As we can only track pages, we might reach beyond the end
ae25885bdf59fd Thomas Zimmermann 2022-06-21  726  	 * of the screen and account for non-existing scanlines. Hence,
ae25885bdf59fd Thomas Zimmermann 2022-06-21  727  	 * keep the covered memory area within the screen buffer.
ae25885bdf59fd Thomas Zimmermann 2022-06-21  728  	 */
24dc4f4c2a5cc9 Thomas Zimmermann 2023-03-20  729  	if (info->screen_size)
24dc4f4c2a5cc9 Thomas Zimmermann 2023-03-20  730  		total_size = info->screen_size;
24dc4f4c2a5cc9 Thomas Zimmermann 2023-03-20  731  	else
24dc4f4c2a5cc9 Thomas Zimmermann 2023-03-20  732  		total_size = info->fix.smem_len;
24dc4f4c2a5cc9 Thomas Zimmermann 2023-03-20  733  	max_off = min(max_off, total_size);
ae25885bdf59fd Thomas Zimmermann 2022-06-21  734  
9b7232400d4e6a Thomas Zimmermann 2022-11-15  735  	if (min_off < max_off) {
ae25885bdf59fd Thomas Zimmermann 2022-06-21  736  		drm_fb_helper_memory_range_to_clip(info, min_off, max_off - min_off, &damage_area);
e3ddd2d25533d1 Thomas Zimmermann 2022-11-18  737  		drm_fb_helper_damage(helper, damage_area.x1, damage_area.y1,
67b723f5b74254 Thomas Zimmermann 2022-02-09  738  				     drm_rect_width(&damage_area),
67b723f5b74254 Thomas Zimmermann 2022-02-09  739  				     drm_rect_height(&damage_area));
eaa434defaca17 Noralf Trønnes    2016-04-28  740  	}
93e81e38e19760 Thomas Zimmermann 2022-11-03  741  }
eaa434defaca17 Noralf Trønnes    2016-04-28  742  EXPORT_SYMBOL(drm_fb_helper_deferred_io);
eaa434defaca17 Noralf Trønnes    2016-04-28  743  
fdefa58a5097b3 Archit Taneja     2015-07-31  744  /**
fdefa58a5097b3 Archit Taneja     2015-07-31  745   * drm_fb_helper_set_suspend - wrapper around fb_set_suspend
c777990fb45b57 Noralf Trønnes    2017-10-30  746   * @fb_helper: driver-allocated fbdev helper, can be NULL
28579f37467cd1 Simona Vetter     2016-08-23  747   * @suspend: whether to suspend or resume
fdefa58a5097b3 Archit Taneja     2015-07-31  748   *
cfe63423d9be3e Noralf Trønnes    2016-08-23  749   * A wrapper around fb_set_suspend implemented by fbdev core.
cfe63423d9be3e Noralf Trønnes    2016-08-23  750   * Use drm_fb_helper_set_suspend_unlocked() if you don't need to take
cfe63423d9be3e Noralf Trønnes    2016-08-23  751   * the lock yourself
fdefa58a5097b3 Archit Taneja     2015-07-31  752   */
28579f37467cd1 Simona Vetter     2016-08-23  753  void drm_fb_helper_set_suspend(struct drm_fb_helper *fb_helper, bool suspend)
fdefa58a5097b3 Archit Taneja     2015-07-31  754  {
9877d8f6bc3749 Thomas Zimmermann 2022-11-03  755  	if (fb_helper && fb_helper->info)
9877d8f6bc3749 Thomas Zimmermann 2022-11-03 @756  		fb_set_suspend(fb_helper->info, suspend);
fdefa58a5097b3 Archit Taneja     2015-07-31  757  }
fdefa58a5097b3 Archit Taneja     2015-07-31  758  EXPORT_SYMBOL(drm_fb_helper_set_suspend);
fdefa58a5097b3 Archit Taneja     2015-07-31  759  

:::::: The code at line 756 was first introduced by commit
:::::: 9877d8f6bc374912b08dfe862cddbb78b395a5ef drm/fb_helper: Rename field fbdev to info in struct drm_fb_helper

:::::: TO: Thomas Zimmermann <tzimmermann@suse.de>
:::::: CC: Thomas Zimmermann <tzimmermann@suse.de>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

