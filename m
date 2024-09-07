Return-Path: <linux-kernel+bounces-319963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D10970468
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 00:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86838B21955
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 22:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31DF1684A1;
	Sat,  7 Sep 2024 22:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bKXWKffS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462B315CD58
	for <linux-kernel@vger.kernel.org>; Sat,  7 Sep 2024 22:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725748233; cv=none; b=HzO47iJYnUOpQeeRY4Sz2yTT2dixY1Qzv204wkqgwjHk+M+Q5t5vhc5kGCOxfQr1dlDNG+HWEqYvKLAVNPZDOWUhhSO30Oya12nNGOkFMrhtyqLgFWl3GroyC0KTV4esjKcvDowOLMcZQePKyTCwMoSwZMs4EeZd0FSWtOgb17c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725748233; c=relaxed/simple;
	bh=XGJqb6HC4iaeuEdA5n6cYu9SrUFHw61FrYM1LhbHtQM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BplTsIwNZrtdonw6ug6DcU/Ouo/B35uDm/CAeYBzW/Kzx+wazFVArUHZ9z9U/BS4RRqaFa5N3bKJGvvroYP7ODoWGWpJxSIFU3CsbVN3Z7YwZoRQgGnTIsLwOdvmZshvfugRAGVujCnY2V8uAJDf2VJpWsES/L6Ytzb46dSJzPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bKXWKffS; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725748231; x=1757284231;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XGJqb6HC4iaeuEdA5n6cYu9SrUFHw61FrYM1LhbHtQM=;
  b=bKXWKffSvNuhQCnePf5pDFr824soX/5ms/xtR5mgj4nQVBOWgkZYT+Jg
   tdN/NwgE6Pa6hJ7bPLaLy8QURW6CJ/gzuG3tx+jdhN+Gcv4pgde9h8sLV
   IUBGf0E1reSWJrWlfZuu1f7n5qXbTiKCEqZcwqWb85wLpGRz+/WrK/CJd
   i+Lo7pz2MfDsKT8UtyJFu38ajNaehf4ZNRYOGjkdSv6faIlHra+oY7RcD
   5Sw9egJx+lliOawiLtgdA1pAUsyzg7J+6qKpPy6qH2jwJOTVP9qbGSDnY
   9VR4um6hx9TW8l/blWynGRD4A9SFSyxu6UHces0ZpjpN5iESL3Kpng7XG
   w==;
X-CSE-ConnectionGUID: XqC6dQhcR2G5L3+SJGabbg==
X-CSE-MsgGUID: Vx4kor/HQDKdrh08XQOPjQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11188"; a="24620124"
X-IronPort-AV: E=Sophos;i="6.10,211,1719903600"; 
   d="scan'208";a="24620124"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2024 15:30:30 -0700
X-CSE-ConnectionGUID: /nyVoW6aQZaxBbbhxFVMhA==
X-CSE-MsgGUID: rrn40a26RDON9snzMjjswA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,211,1719903600"; 
   d="scan'208";a="97000816"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 07 Sep 2024 15:30:29 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sn3wp-000D3v-0I;
	Sat, 07 Sep 2024 22:30:27 +0000
Date: Sun, 8 Sep 2024 06:30:14 +0800
From: kernel test robot <lkp@intel.com>
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Martin Krastev <martin.krastev@broadcom.com>
Subject: drivers/gpu/drm/vmwgfx/vmwgfx_blit.c:533:2-8: WARNING: NULL check
 before some freeing functions is not needed.
Message-ID: <202409080613.QLumunSL-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b31c4492884252a8360f312a0ac2049349ddf603
commit: b32233accefff1338806f064fb9b62cf5bc0609f drm/vmwgfx: Fix prime import/export
date:   5 months ago
config: i386-randconfig-054-20240907 (https://download.01.org/0day-ci/archive/20240908/202409080613.QLumunSL-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409080613.QLumunSL-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/vmwgfx/vmwgfx_blit.c:533:2-8: WARNING: NULL check before some freeing functions is not needed.
   drivers/gpu/drm/vmwgfx/vmwgfx_blit.c:535:2-8: WARNING: NULL check before some freeing functions is not needed.

vim +533 drivers/gpu/drm/vmwgfx/vmwgfx_blit.c

   422	
   423	/**
   424	 * vmw_bo_cpu_blit - in-kernel cpu blit.
   425	 *
   426	 * @dst: Destination buffer object.
   427	 * @dst_offset: Destination offset of blit start in bytes.
   428	 * @dst_stride: Destination stride in bytes.
   429	 * @src: Source buffer object.
   430	 * @src_offset: Source offset of blit start in bytes.
   431	 * @src_stride: Source stride in bytes.
   432	 * @w: Width of blit.
   433	 * @h: Height of blit.
   434	 * @diff: The struct vmw_diff_cpy used to track the modified bounding box.
   435	 * return: Zero on success. Negative error value on failure. Will print out
   436	 * kernel warnings on caller bugs.
   437	 *
   438	 * Performs a CPU blit from one buffer object to another avoiding a full
   439	 * bo vmap which may exhaust- or fragment vmalloc space.
   440	 * On supported architectures (x86), we're using kmap_atomic which avoids
   441	 * cross-processor TLB- and cache flushes and may, on non-HIGHMEM systems
   442	 * reference already set-up mappings.
   443	 *
   444	 * Neither of the buffer objects may be placed in PCI memory
   445	 * (Fixed memory in TTM terminology) when using this function.
   446	 */
   447	int vmw_bo_cpu_blit(struct ttm_buffer_object *dst,
   448			    u32 dst_offset, u32 dst_stride,
   449			    struct ttm_buffer_object *src,
   450			    u32 src_offset, u32 src_stride,
   451			    u32 w, u32 h,
   452			    struct vmw_diff_cpy *diff)
   453	{
   454		struct ttm_operation_ctx ctx = {
   455			.interruptible = false,
   456			.no_wait_gpu = false
   457		};
   458		u32 j, initial_line = dst_offset / dst_stride;
   459		struct vmw_bo_blit_line_data d = {0};
   460		int ret = 0;
   461		struct page **dst_pages = NULL;
   462		struct page **src_pages = NULL;
   463	
   464		/* Buffer objects need to be either pinned or reserved: */
   465		if (!(dst->pin_count))
   466			dma_resv_assert_held(dst->base.resv);
   467		if (!(src->pin_count))
   468			dma_resv_assert_held(src->base.resv);
   469	
   470		if (!ttm_tt_is_populated(dst->ttm)) {
   471			ret = dst->bdev->funcs->ttm_tt_populate(dst->bdev, dst->ttm, &ctx);
   472			if (ret)
   473				return ret;
   474		}
   475	
   476		if (!ttm_tt_is_populated(src->ttm)) {
   477			ret = src->bdev->funcs->ttm_tt_populate(src->bdev, src->ttm, &ctx);
   478			if (ret)
   479				return ret;
   480		}
   481	
   482		if (!src->ttm->pages && src->ttm->sg) {
   483			src_pages = kvmalloc_array(src->ttm->num_pages,
   484						   sizeof(struct page *), GFP_KERNEL);
   485			if (!src_pages)
   486				return -ENOMEM;
   487			ret = drm_prime_sg_to_page_array(src->ttm->sg, src_pages,
   488							 src->ttm->num_pages);
   489			if (ret)
   490				goto out;
   491		}
   492		if (!dst->ttm->pages && dst->ttm->sg) {
   493			dst_pages = kvmalloc_array(dst->ttm->num_pages,
   494						   sizeof(struct page *), GFP_KERNEL);
   495			if (!dst_pages) {
   496				ret = -ENOMEM;
   497				goto out;
   498			}
   499			ret = drm_prime_sg_to_page_array(dst->ttm->sg, dst_pages,
   500							 dst->ttm->num_pages);
   501			if (ret)
   502				goto out;
   503		}
   504	
   505		d.mapped_dst = 0;
   506		d.mapped_src = 0;
   507		d.dst_addr = NULL;
   508		d.src_addr = NULL;
   509		d.dst_pages = dst->ttm->pages ? dst->ttm->pages : dst_pages;
   510		d.src_pages = src->ttm->pages ? src->ttm->pages : src_pages;
   511		d.dst_num_pages = PFN_UP(dst->resource->size);
   512		d.src_num_pages = PFN_UP(src->resource->size);
   513		d.dst_prot = ttm_io_prot(dst, dst->resource, PAGE_KERNEL);
   514		d.src_prot = ttm_io_prot(src, src->resource, PAGE_KERNEL);
   515		d.diff = diff;
   516	
   517		for (j = 0; j < h; ++j) {
   518			diff->line = j + initial_line;
   519			diff->line_offset = dst_offset % dst_stride;
   520			ret = vmw_bo_cpu_blit_line(&d, dst_offset, src_offset, w);
   521			if (ret)
   522				goto out;
   523	
   524			dst_offset += dst_stride;
   525			src_offset += src_stride;
   526		}
   527	out:
   528		if (d.src_addr)
   529			kunmap_atomic(d.src_addr);
   530		if (d.dst_addr)
   531			kunmap_atomic(d.dst_addr);
   532		if (src_pages)
 > 533			kvfree(src_pages);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

