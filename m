Return-Path: <linux-kernel+bounces-380879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 598F69AF73B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 04:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E54AB1F229E0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 02:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9299132111;
	Fri, 25 Oct 2024 02:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I+QhADaB"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222614436A
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 02:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729822063; cv=none; b=HAHHipvz4WceO39L6YYKSlfR8qr7xnwBTQqrjPz4iBMuB7nMM6podooopHxQFl+9MBqb9MWgvvdQoI2qZuP+nLxZ7qdwhDw3/JHx8IuDjwQLuOaAjPB7F7cF7JnPtr9kyzkp5jNvzhdzLRU108a+kElCZXqLJdyUR77TBTify3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729822063; c=relaxed/simple;
	bh=eDa0JoCTkZ7sT5p8NIJ1IUizt1fk8CCVwX2LEkWEMls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xq8Cb8X3H1rQnFy2a00+0vpBFVhipTeAISWPox797mLXYeJLqXSjgcc/THxeO4SIsMLSzLtoH6MFcXCpRC9QwkOG+uBZqi95aot60/suqBMG8HE2EwHl0yJ7G7ccNFXz7/0BzJVqpO6UWnSISkjXAlcjqFiTiHGoBkoNiBplQfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I+QhADaB; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729822061; x=1761358061;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eDa0JoCTkZ7sT5p8NIJ1IUizt1fk8CCVwX2LEkWEMls=;
  b=I+QhADaB50YuFCmXfrm+qow6TEjYnSe76tvXxi423ca4U2Hx/zKIrE9B
   g6hgi79Un/PD/d+cSXkWSGsm0dQMnhRJ+hgUv/3zqWTazg8QkhhNEGBlT
   s+015hGIp2HC4HsR6JtR+vVSfdaON/+qfCHQYKGTNI8eNuzs/3kci7O/W
   gbkiubIG/D00XBgX3aQkfpIMBS0rbQHWZDY9YHATl2AOVO9vAruFS9GgK
   YvsTtCKiaECrqB18lu0hCtqIsmgEQ3wJlCLitKvLLm2nyeX6ibWZNaqer
   SUqCyxbQl2UlGybqnnQ3FVmoCbdBLja2Vybw1A2vZwNYAPbE+WbGWYD7j
   g==;
X-CSE-ConnectionGUID: Qqebla9VRWy4vrGFeNMsyA==
X-CSE-MsgGUID: nAEsdmBeQ0qJXJf1yPnEcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="54885118"
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="54885118"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 19:07:40 -0700
X-CSE-ConnectionGUID: J77VyAOeRp6effboy0MFbQ==
X-CSE-MsgGUID: 2cdvWipwRfyICN8D7KYDwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="85328157"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 24 Oct 2024 19:07:35 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t49jf-000XPQ-1t;
	Fri, 25 Oct 2024 02:07:31 +0000
Date: Fri, 25 Oct 2024 10:07:18 +0800
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
Subject: Re: [PATCH V2 drm-dp 3/4] drm/hisilicon/hibmc: add dp hw moduel in
 hibmc
Message-ID: <202410250931.UDQ9s66H-lkp@intel.com>
References: <20241022124148.1952761-4-shiyongbang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022124148.1952761-4-shiyongbang@huawei.com>

Hi Yongbang,

kernel test robot noticed the following build errors:

[auto build test ERROR on drm-misc/drm-misc-next]
[also build test ERROR on linus/master v6.12-rc4 next-20241024]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yongbang-Shi/drm-hisilicon-hibmc-add-dp-aux-in-hibmc/20241022-204925
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/20241022124148.1952761-4-shiyongbang%40huawei.com
patch subject: [PATCH V2 drm-dp 3/4] drm/hisilicon/hibmc: add dp hw moduel in hibmc
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20241025/202410250931.UDQ9s66H-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241025/202410250931.UDQ9s66H-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410250931.UDQ9s66H-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/bridge/imx/imx-legacy-bridge.o
>> ERROR: modpost: "__divdi3" [drivers/gpu/drm/hisilicon/hibmc/hibmc-drm.ko] undefined!
ERROR: modpost: "__udivdi3" [drivers/gpu/drm/hisilicon/hibmc/hibmc-drm.ko] undefined!

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [m]:
   - RESOURCE_KUNIT_TEST [=m] && RUNTIME_TESTING_MENU [=y] && KUNIT [=m]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

