Return-Path: <linux-kernel+bounces-394041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E169BA995
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 00:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3539281992
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 23:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F1F18BBA3;
	Sun,  3 Nov 2024 23:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MGcFqUSc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D46015B13C
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 23:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730677203; cv=none; b=UGO3KxVMrZBnDQ0Q/jh+XdOxBi7F8SwapHb5ySnjJ34neOJerPC22jNWcIgAOOVXiWA3sZsb8beiglHHVoqEbrg5Rg/p+SchAGM3PR9eP9YsJOrbbKh8UKWjGik6YCVjL/uGpaa3JJQ6EjfagpBaZI5+PLCWGh9uNtmzXsZbfuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730677203; c=relaxed/simple;
	bh=AgMAytFD6mOfZ8EleKgFBj8q4jKZfEy7E5l5B7tI+oU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=khBSWjY2dEXbmTUjFWAYtAYI+t+5dGZxGvF7z7D2S5dpl0ZMieZfO4+/P2nGVrPoLMRyfFu6khSYyJnRpwjzmDfsPjOniIUKCoMEEjHftSo4exrD2UnJPZrw7bakMhTL/LM6Xm+adOFvcO+CMvmsLaskur3Be1nWdE3NNWTMyWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MGcFqUSc; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730677201; x=1762213201;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=AgMAytFD6mOfZ8EleKgFBj8q4jKZfEy7E5l5B7tI+oU=;
  b=MGcFqUSc2YRG9TqSNd15rE9dIYhCr2WrUKwy56+hJ18rK5+vyCNtnZ3J
   5a1gsC1zc5HTHofwFGAU9XGJF+TUbN0eFRU0m5riQJdRI+RIUtyMSDGBG
   liguC5C5x01df52m2rpIBGQzKr4DJh3Mw9SVZ2l8Scp5VBw2q3Z2xil6j
   YMsGccgY7s1CllDa0XlBs7Vr8hJ518HIjIJMqKlaxZg85GZ57QCDe43Fk
   3mQzU2JqKfBtaRFHTB+cNijbwtlQwFXxUpYzol3oojC+oswVRTyoAHl3g
   DDACJRrB1UPGBa22xj0/ZJ8C/g8RAiCQm5Lwm+ivj6TFR8aJH1V+qS+UH
   A==;
X-CSE-ConnectionGUID: wRaJfRplTKae+ideVv4hEw==
X-CSE-MsgGUID: 6dGKfH5PTvWLyN/o9OdcxQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30525340"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30525340"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2024 15:40:01 -0800
X-CSE-ConnectionGUID: f0ptDYsFTtyysaQ2xZ19Pg==
X-CSE-MsgGUID: fvKMrsloTcCT9ACbcEdW5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="83933616"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 03 Nov 2024 15:39:59 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t7kCK-000kI1-2w;
	Sun, 03 Nov 2024 23:39:56 +0000
Date: Mon, 4 Nov 2024 07:39:36 +0800
From: kernel test robot <lkp@intel.com>
To: Jian Shen <shenjian15@huawei.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Peiyang Wang <wangpeiyang1@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>
Subject: drivers/net/ethernet/hisilicon/hns3/hns3_enet.c:395:21: error:
 'struct iommu_iotlb_gather' has no member named 'start'
Message-ID: <202411040704.UsG2WLc7-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a8cc7432728d019a10cb412401ebc15ed7504289
commit: f2c14899caba76da93ff3fff46b4d5a8f43ce07e net: hns3: add sync command to sync io-pgtable
date:   4 days ago
config: sparc64-randconfig-002-20241104 (https://download.01.org/0day-ci/archive/20241104/202411040704.UsG2WLc7-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241104/202411040704.UsG2WLc7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411040704.UsG2WLc7-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/ethernet/hisilicon/hns3/hns3_enet.c: In function 'hns3_dma_map_sync':
>> drivers/net/ethernet/hisilicon/hns3/hns3_enet.c:395:21: error: 'struct iommu_iotlb_gather' has no member named 'start'
     395 |         iotlb_gather.start = iova;
         |                     ^
>> drivers/net/ethernet/hisilicon/hns3/hns3_enet.c:396:21: error: 'struct iommu_iotlb_gather' has no member named 'end'
     396 |         iotlb_gather.end = iova + granule - 1;
         |                     ^
>> drivers/net/ethernet/hisilicon/hns3/hns3_enet.c:397:21: error: 'struct iommu_iotlb_gather' has no member named 'pgsize'
     397 |         iotlb_gather.pgsize = granule;
         |                     ^


vim +395 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c

   380	
   381	#define HNS3_INVALID_PTYPE \
   382			ARRAY_SIZE(hns3_rx_ptype_tbl)
   383	
   384	static void hns3_dma_map_sync(struct device *dev, unsigned long iova)
   385	{
   386		struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
   387		struct iommu_iotlb_gather iotlb_gather;
   388		size_t granule;
   389	
   390		if (!domain || !iommu_is_dma_domain(domain))
   391			return;
   392	
   393		granule = 1 << __ffs(domain->pgsize_bitmap);
   394		iova = ALIGN_DOWN(iova, granule);
 > 395		iotlb_gather.start = iova;
 > 396		iotlb_gather.end = iova + granule - 1;
 > 397		iotlb_gather.pgsize = granule;
   398	
   399		iommu_iotlb_sync(domain, &iotlb_gather);
   400	}
   401	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

