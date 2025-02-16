Return-Path: <linux-kernel+bounces-516614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D47A374BB
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 15:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9075C3AD4FF
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 14:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3130C195985;
	Sun, 16 Feb 2025 14:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CndOuKr2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B29F18BC1D
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 14:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739716821; cv=none; b=QgxwkX5flixhrDyZ7nWG/JeInejW5uHCYOhrX3vAmdvx8aE1Ixx2G1I8Yr1EBa9bhH2BED25QhBrSIG20ttllOoQ/D9iGrKqVp6ZL2q75i+Jj7GtwcaowPIu8b1QfyhcSaYFdypkz+phi9u5LaDPh7Md+NHxDV4dwkff/WfoX5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739716821; c=relaxed/simple;
	bh=Zw0wRHBl0lw//iHfVDMLwTNa1O0pBU0scNuWvJQwysU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BMfVQZXWzDg54AfeRX9K/Qe24bondwa2qWJ2gRJcyTaO+ZfFxgly8VGM48OEQFJJJR/uKtyDFbMSkVPWA+gux7qYzmYfsKhZTUijbPW0dRcDrB1a46epSYbq1gis/XBLMaTzrNLaFsg4HE3kfKrne/bGa2C5y32PCAgRg2ekrzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CndOuKr2; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739716819; x=1771252819;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Zw0wRHBl0lw//iHfVDMLwTNa1O0pBU0scNuWvJQwysU=;
  b=CndOuKr2EO0l+0Y/7UpT3DJKYSKs2ghgFxjaWFtlYmmvLDndySEmH5wo
   lvIjiNp+x+450YrtLO4MXBqc2yC8ajhsoJ5+PZ6QyHjX9/6qb4+rJVKdg
   SXW2X7DMVtjzMCou/vKtdiyfdjb7P8orIVDYYld0flkuplzfx2icuG75v
   lLY0weX6Vg6/qS0TIYh8hmTG0N2fl06zoUP+U40uSj/sY7mxHu7LGFTAb
   13irvwCna52kHFaP8YTqSIQYe+vTZKayVu8WaPp+BE76CqE9+Y099C4u7
   eThJYbrU6+kf+h2GU8qcz/JaZotWYBTc2KZ7/Hyf6FI/L5+bbcxVEWVgL
   w==;
X-CSE-ConnectionGUID: zV4lPBbzSEuPflN9nguUhQ==
X-CSE-MsgGUID: xJTuuMpzRbiJY/gbmuLrxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11347"; a="40334642"
X-IronPort-AV: E=Sophos;i="6.13,291,1732608000"; 
   d="scan'208";a="40334642"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 06:40:19 -0800
X-CSE-ConnectionGUID: qdRkRrobTYKXHenfjFGnKw==
X-CSE-MsgGUID: 6u9+4BgwQTicfsQWSPbLNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="114794971"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 16 Feb 2025 06:40:18 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tjfod-001Bzj-0p;
	Sun, 16 Feb 2025 14:40:15 +0000
Date: Sun, 16 Feb 2025 22:39:48 +0800
From: kernel test robot <lkp@intel.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	"Michael S. Tsirkin" <mst@redhat.com>
Subject: drivers/virtio/virtio_ring.c:3125 virtqueue_dma_map_single_attrs()
 warn: unsigned '_x' is never less than zero.
Message-ID: <202502162211.cxOr2wqP-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ad1b832bf1cf2df9304f8eb72943111625c7e5a7
commit: 840b2d39a2dc1b96deb3f5c7fef76c9b24f08f51 virtio_ring: fix KMSAN error for premapped mode
date:   8 months ago
config: riscv-randconfig-r073-20250213 (https://download.01.org/0day-ci/archive/20250216/202502162211.cxOr2wqP-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 14.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502162211.cxOr2wqP-lkp@intel.com/

New smatch warnings:
drivers/virtio/virtio_ring.c:3125 virtqueue_dma_map_single_attrs() warn: unsigned '_x' is never less than zero.

Old smatch warnings:
include/asm-generic/io.h:1005 virt_to_phys() warn: unsigned '_x' is never less than zero.
include/linux/dma-mapping.h:388 dma_map_single_attrs() warn: unsigned '_x' is never less than zero.
drivers/virtio/virtio_ring.c:1516 virtqueue_add_packed() error: uninitialized symbol 'prev'.
drivers/virtio/virtio_ring.c:1524 virtqueue_add_packed() error: uninitialized symbol 'head_flags'.
drivers/virtio/virtio_ring.c:645 virtqueue_add_split() error: uninitialized symbol 'prev'.

vim +/_x +3125 drivers/virtio/virtio_ring.c

  3103	
  3104	/**
  3105	 * virtqueue_dma_map_single_attrs - map DMA for _vq
  3106	 * @_vq: the struct virtqueue we're talking about.
  3107	 * @ptr: the pointer of the buffer to do dma
  3108	 * @size: the size of the buffer to do dma
  3109	 * @dir: DMA direction
  3110	 * @attrs: DMA Attrs
  3111	 *
  3112	 * The caller calls this to do dma mapping in advance. The DMA address can be
  3113	 * passed to this _vq when it is in pre-mapped mode.
  3114	 *
  3115	 * return DMA address. Caller should check that by virtqueue_dma_mapping_error().
  3116	 */
  3117	dma_addr_t virtqueue_dma_map_single_attrs(struct virtqueue *_vq, void *ptr,
  3118						  size_t size,
  3119						  enum dma_data_direction dir,
  3120						  unsigned long attrs)
  3121	{
  3122		struct vring_virtqueue *vq = to_vvq(_vq);
  3123	
  3124		if (!vq->use_dma_api) {
> 3125			kmsan_handle_dma(virt_to_page(ptr), offset_in_page(ptr), size, dir);
  3126			return (dma_addr_t)virt_to_phys(ptr);
  3127		}
  3128	
  3129		return dma_map_single_attrs(vring_dma_dev(vq), ptr, size, dir, attrs);
  3130	}
  3131	EXPORT_SYMBOL_GPL(virtqueue_dma_map_single_attrs);
  3132	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

