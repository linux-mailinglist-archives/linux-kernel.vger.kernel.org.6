Return-Path: <linux-kernel+bounces-380582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA8A9AF2F6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 21:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6071E284314
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 19:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC8F19CC3A;
	Thu, 24 Oct 2024 19:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bi82nvVM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FA0147C91
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 19:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729799604; cv=none; b=mewEdOtNSJkmGLdjCwNjfyW9U7kmaGnS8hURavR/D8iBnrbGOGQRBTK/f7ku5DH9Ncxk8RFCq2jwOlTDsDMLjGKJVYomSsuu85kBuaj5VKncs7qcE9RJ7xnzsAtoJm7hrrhFsGUGxew0dopHxtnwqbmt6z2rbLtnZmX++zep21I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729799604; c=relaxed/simple;
	bh=lvLVXo93a81i5Obbkr1CZRd1nmDpE0nwCV4GyYMJa2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gQFTMx5nxbljEai4CRn5/Hhzu0ji0CkeuDpvBodreyNk6n/RyPuLyQ7Zh2YBEx2Tyb6vBX5dcnOjliKvyYG6OY321vkdvEFnHxxZRRuolIPipNbwdVbGnZ6bdiHxZ/vv0MDVR1E23Z/U1YwauIB0tRGGNr0Auadwx8i6qUxTwNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bi82nvVM; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729799602; x=1761335602;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lvLVXo93a81i5Obbkr1CZRd1nmDpE0nwCV4GyYMJa2o=;
  b=Bi82nvVMFBHFb4apRkVrALDnxA9WdMBB9xycHQmRSGuOcV4k6wQf+x5x
   jitDUfy5xh9aHU7K+NBGCgHRNjHo3em3jm+ydSBUgxlldmGOHKlv7rqKU
   igRv3SbMZjmMtbvZTn6Z65I9td4VlnJeXlwvP9ZttIbLbo6yCmUpoCGC+
   aKL3sgLXdPmW7JA9oYquAukFUhc2DCg0cgCjE1Wi7ifDWZ7+zbrbuK+K8
   KASO6d+8V4QNhKwSpsUkmF177ueP/dUP3n5ywxQlQWp0lNyObWRKPAqud
   NlRMvIrRr2xy7PWLZz05DKmUkz3RRgagl+wwA/SFunfZfsL9NmiGv2KYI
   g==;
X-CSE-ConnectionGUID: 5y+oXMTLTByaI2n7F3qSew==
X-CSE-MsgGUID: R4lQ71sKQOSjgM19UB+Wjw==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="29356711"
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="29356711"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 12:53:21 -0700
X-CSE-ConnectionGUID: isuh4ulTQgeARvpOgzNjiQ==
X-CSE-MsgGUID: bMPHJn2zR6GC2+EYd9gPVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="80874714"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 24 Oct 2024 12:53:17 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t43tS-000WyC-1M;
	Thu, 24 Oct 2024 19:53:14 +0000
Date: Fri, 25 Oct 2024 03:52:49 +0800
From: kernel test robot <lkp@intel.com>
To: Yongbang Shi <shiyongbang@huawei.com>, xinliang.liu@linaro.org,
	tiantao6@hisilicon.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	daniel@ffwll.ch, kong.kongxinwei@hisilicon.com
Cc: oe-kbuild-all@lists.linux.dev, liangjian010@huawei.com,
	chenjianmin@huawei.com, lidongming5@huawei.com,
	shiyongbang@huawei.com, libaihan@huawei.com, shenjian15@huawei.com,
	shaojijie@huawei.com, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 drm-dp 1/4] drm/hisilicon/hibmc: add dp aux in hibmc
Message-ID: <202410250305.UHKDhtxy-lkp@intel.com>
References: <20241022124148.1952761-2-shiyongbang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022124148.1952761-2-shiyongbang@huawei.com>

Hi Yongbang,

kernel test robot noticed the following build errors:

[auto build test ERROR on drm-misc/drm-misc-next]
[also build test ERROR on linus/master v6.12-rc4 next-20241024]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yongbang-Shi/drm-hisilicon-hibmc-add-dp-aux-in-hibmc/20241022-204925
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/20241022124148.1952761-2-shiyongbang%40huawei.com
patch subject: [PATCH V2 drm-dp 1/4] drm/hisilicon/hibmc: add dp aux in hibmc
config: arm64-randconfig-004-20241024 (https://download.01.org/0day-ci/archive/20241025/202410250305.UHKDhtxy-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241025/202410250305.UHKDhtxy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410250305.UHKDhtxy-lkp@intel.com/

All errors (new ones prefixed by >>):

   aarch64-linux-ld: drivers/gpu/drm/hisilicon/hibmc/dp/dp_aux.o: in function `dp_aux_init':
>> drivers/gpu/drm/hisilicon/hibmc/dp/dp_aux.c:154: multiple definition of `dp_aux_init'; drivers/gpu/drm/msm/dp/dp_aux.o:dp_aux.c:(.text+0x8a0): first defined here


vim +154 drivers/gpu/drm/hisilicon/hibmc/dp/dp_aux.c

   152	
   153	void dp_aux_init(struct dp_dev *dp)
 > 154	{

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

