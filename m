Return-Path: <linux-kernel+bounces-268913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BEA942B13
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 11:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 810DD1F236F1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 09:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6201A4B47;
	Wed, 31 Jul 2024 09:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ke/9Txiz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B9A18CC18
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 09:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722419134; cv=none; b=tHZWQA3yPONoGrpI/mPbdmVDLCtDTQyPyP7/AVkJZSZrK+JNZxI3eyF95dehjsp4WzQdnfRR0kEE3dxKHK8SrAiOOaF+W0Yrxw9/CdMdAgVoT6q0usDpsGBuklzjQJtqw+EANWGfVwRiwBNxKStIHyUy3rPTjX/qW0BD7LTvlDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722419134; c=relaxed/simple;
	bh=N9cpiHwPH6B/BQy0IXPvykEu79bonXwgSf3iSkoHJ0U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eCHtbhAR4iq00N4Kbx2yeHZ3MC0Drkl5LSytFhsjSIfK66NxMXVa1FET5yGotfsUGFQfSLHnq+8oGGDSxWntzEjiNna+VKWZEXGJ4LGPj3cR1Pf79cClzdXwVG+e83h37rr3NDsuIpSe8jAfTokZD3AMVGsIByYGzFuLdepM3UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ke/9Txiz; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722419133; x=1753955133;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=N9cpiHwPH6B/BQy0IXPvykEu79bonXwgSf3iSkoHJ0U=;
  b=ke/9TxizL9S6DbRGEywMHFUrvnJuf/5mzJfGVKKgbDOfOFOcSTK0+2pF
   xs4M4wRW0pL1Bc10+3amSZ5zE6DS6nK5kygC7/ll2QyA9xKXBFSYQUoxy
   Pc58FNOn3E/0bU9wszqd66CHMDgBcVlyCY7ZcG7oMSHoX+IKdohv8ITvd
   EsSlDgI38F+BAnH+yc2dtrD+JIBfhXEFx5xsX/C4uZfeFURCz0AE1nckj
   4+B7HPlW/6td9puDH7+ETvOCL/76vOn3J19mvwEWt4H5ivhmgLHb2mDhe
   2cN/imHxlEQv5aEoV/VOlq4ZntUDzH53G3SZ/i3zVAtV3kmjvZd22sHhO
   w==;
X-CSE-ConnectionGUID: pwC2qTzxQqqJ2DNwHyaXtQ==
X-CSE-MsgGUID: ckQDChbFRT+ODmLS+t6k9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11149"; a="20234423"
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="20234423"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 02:45:32 -0700
X-CSE-ConnectionGUID: xhgO8kKTSgius7anbTgDBQ==
X-CSE-MsgGUID: QbGZUC3DRdiJZCXLjnseTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="85264680"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 31 Jul 2024 02:45:30 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sZ5tf-000u6S-1i;
	Wed, 31 Jul 2024 09:45:27 +0000
Date: Wed, 31 Jul 2024 17:44:41 +0800
From: kernel test robot <lkp@intel.com>
To: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: drivers/gpu/drm/omapdrm/omap_dmm_tiler.c:122:16: sparse: sparse:
 incorrect type in argument 1 (different address spaces)
Message-ID: <202407311737.VsJ0Sr1w-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Ville,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e4fc196f5ba36eb7b9758cf2c73df49a44199895
commit: dc6fcaaba5a5411237d042a26c4d46689f3346bb drm/omap: Allow build with COMPILE_TEST=y
date:   3 months ago
config: sh-randconfig-r112-20240731 (https://download.01.org/0day-ci/archive/20240731/202407311737.VsJ0Sr1w-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.1.0
reproduce: (https://download.01.org/0day-ci/archive/20240731/202407311737.VsJ0Sr1w-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407311737.VsJ0Sr1w-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/omapdrm/omap_dmm_tiler.c:122:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int [usertype] *wa_dma_data @@
   drivers/gpu/drm/omapdrm/omap_dmm_tiler.c:122:16: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/gpu/drm/omapdrm/omap_dmm_tiler.c:122:16: sparse:     got unsigned int [usertype] *wa_dma_data
   drivers/gpu/drm/omapdrm/omap_dmm_tiler.c:130:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int [usertype] *wa_dma_data @@
   drivers/gpu/drm/omapdrm/omap_dmm_tiler.c:130:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/gpu/drm/omapdrm/omap_dmm_tiler.c:130:9: sparse:     got unsigned int [usertype] *wa_dma_data
>> drivers/gpu/drm/omapdrm/omap_dmm_tiler.c:414:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int * @@
   drivers/gpu/drm/omapdrm/omap_dmm_tiler.c:414:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/gpu/drm/omapdrm/omap_dmm_tiler.c:414:9: sparse:     got unsigned int *
   drivers/gpu/drm/omapdrm/omap_dmm_tiler.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/xarray.h, ...):
   include/linux/page-flags.h:241:46: sparse: sparse: self-comparison always evaluates to false
   include/linux/page-flags.h:241:46: sparse: sparse: self-comparison always evaluates to false

vim +122 drivers/gpu/drm/omapdrm/omap_dmm_tiler.c

f5b9930b85dc63 Tomi Valkeinen 2018-09-26  101  
f5b9930b85dc63 Tomi Valkeinen 2018-09-26  102  static u32 dmm_read_wa(struct dmm *dmm, u32 reg)
f5b9930b85dc63 Tomi Valkeinen 2018-09-26  103  {
f5b9930b85dc63 Tomi Valkeinen 2018-09-26  104  	dma_addr_t src, dst;
f5b9930b85dc63 Tomi Valkeinen 2018-09-26  105  	int r;
f5b9930b85dc63 Tomi Valkeinen 2018-09-26  106  
f5b9930b85dc63 Tomi Valkeinen 2018-09-26  107  	src = dmm->phys_base + reg;
f5b9930b85dc63 Tomi Valkeinen 2018-09-26  108  	dst = dmm->wa_dma_handle;
f5b9930b85dc63 Tomi Valkeinen 2018-09-26  109  
f5b9930b85dc63 Tomi Valkeinen 2018-09-26  110  	r = dmm_dma_copy(dmm, src, dst);
f5b9930b85dc63 Tomi Valkeinen 2018-09-26  111  	if (r) {
f5b9930b85dc63 Tomi Valkeinen 2018-09-26  112  		dev_err(dmm->dev, "sDMA read transfer timeout\n");
f5b9930b85dc63 Tomi Valkeinen 2018-09-26  113  		return readl(dmm->base + reg);
f5b9930b85dc63 Tomi Valkeinen 2018-09-26  114  	}
f5b9930b85dc63 Tomi Valkeinen 2018-09-26  115  
f5b9930b85dc63 Tomi Valkeinen 2018-09-26  116  	/*
f5b9930b85dc63 Tomi Valkeinen 2018-09-26  117  	 * As per i878 workaround, the DMA is used to access the DMM registers.
f5b9930b85dc63 Tomi Valkeinen 2018-09-26  118  	 * Make sure that the readl is not moved by the compiler or the CPU
f5b9930b85dc63 Tomi Valkeinen 2018-09-26  119  	 * earlier than the DMA finished writing the value to memory.
f5b9930b85dc63 Tomi Valkeinen 2018-09-26  120  	 */
f5b9930b85dc63 Tomi Valkeinen 2018-09-26  121  	rmb();
f5b9930b85dc63 Tomi Valkeinen 2018-09-26 @122  	return readl(dmm->wa_dma_data);
f5b9930b85dc63 Tomi Valkeinen 2018-09-26  123  }
f5b9930b85dc63 Tomi Valkeinen 2018-09-26  124  

:::::: The code at line 122 was first introduced by commit
:::::: f5b9930b85dc6319fd6bcc259e447eff62fc691c drm/omap: partial workaround for DRA7xx DMM errata i878

:::::: TO: Tomi Valkeinen <tomi.valkeinen@ti.com>
:::::: CC: Tomi Valkeinen <tomi.valkeinen@ti.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

