Return-Path: <linux-kernel+bounces-380949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2FD19AF830
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 05:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE596B210F4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 03:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C250E18BC37;
	Fri, 25 Oct 2024 03:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jRw/8DNn"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3264E18B49F
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 03:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729827105; cv=none; b=MZ4DYqh/ebCDVKqKozrCAOtrscrClCsv7Fi8U7s0Vv2i+G/AqqTfBmCyN/xnqEagad0MMm2jAfYWruToP4kqB4zBhb4+IdaZ6hSZ/YlbCe5pYt7olTkhLuIf4ViaUmDvQT5hemfVhwipD1h7bYGQXxmzANG9Lc8dfsJ4sLVbN+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729827105; c=relaxed/simple;
	bh=yKWhaHoKwMvKgUCvzoCF4HnRBfeVm1f1O/hBJcEF5YI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tQGhblVGMwLA0tI3RmTz9GNJfAJ9TBE+7tk2wf0RJ+5Kz5NH6N56Q4tQlyrRukvZOTYG21xkz8G6LDULVIdpmsoyLt8xAhln62c6hmZZDZcGSWi1PA+0ZV9/EWlmEIyv5MPbb+cTpV0aw9h1xR3N+E9p445TcJQQnzeYNJ5e8cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jRw/8DNn; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729827104; x=1761363104;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yKWhaHoKwMvKgUCvzoCF4HnRBfeVm1f1O/hBJcEF5YI=;
  b=jRw/8DNneGIYWmiXGj/cBSixqme+E1u6acjjF8LI4Ri3hrGarDa0YOzd
   RuXOIUMUKdZlxoXbbT9lWll/exIJP0NQBZ+30qTb6iJreYIqQVg+aRUDp
   z6t/byP9toAMHSeKYBhFSz8rWpsJLkLdG20cps9YNCF6C/RgMWOcWJL1y
   KCQFOGunsfBIne9drYiI/zncm3eo7xYqrADt2c3wjHtITCHL9398LkfY/
   maSsSkzYW5jeVJ3P1v0zlLqzBn+m+mkZETSSz6jCJ+utYtfCzkRatHyEG
   7WLeCD2GWeqBaW/Y2nURWthn/LoylYm2tPL0vvk/0rRAfdEA+1VlfnuFL
   A==;
X-CSE-ConnectionGUID: 2mPSVaI+Szu7l/+aymQBzQ==
X-CSE-MsgGUID: Tdsg85c2SIqD3xY392Rskw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="40031846"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="40031846"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 20:31:43 -0700
X-CSE-ConnectionGUID: EIGL+UZNTIOmbDWB+69qkQ==
X-CSE-MsgGUID: xYWNKBsnTZeV8O9mUQFEhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="118257848"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 24 Oct 2024 20:31:38 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t4B31-000XXC-3D;
	Fri, 25 Oct 2024 03:31:35 +0000
Date: Fri, 25 Oct 2024 11:30:41 +0800
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
Subject: Re: [PATCH V2 drm-dp 4/4] drm/hisilicon/hibmc: add dp module in hibmc
Message-ID: <202410251136.1m7BlR68-lkp@intel.com>
References: <20241022124148.1952761-5-shiyongbang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022124148.1952761-5-shiyongbang@huawei.com>

Hi Yongbang,

kernel test robot noticed the following build errors:

[auto build test ERROR on drm-misc/drm-misc-next]
[also build test ERROR on linus/master v6.12-rc4 next-20241024]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yongbang-Shi/drm-hisilicon-hibmc-add-dp-aux-in-hibmc/20241022-204925
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/20241022124148.1952761-5-shiyongbang%40huawei.com
patch subject: [PATCH V2 drm-dp 4/4] drm/hisilicon/hibmc: add dp module in hibmc
config: powerpc-randconfig-003-20241024 (https://download.01.org/0day-ci/archive/20241025/202410251136.1m7BlR68-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241025/202410251136.1m7BlR68-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410251136.1m7BlR68-lkp@intel.com/

All errors (new ones prefixed by >>):

   powerpc-linux-ld: drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.o: in function `dp_link_cfg':
>> dp_hw.c:(.text.dp_link_cfg+0x250): undefined reference to `__udivdi3'
>> powerpc-linux-ld: dp_hw.c:(.text.dp_link_cfg+0x340): undefined reference to `__udivdi3'
   powerpc-linux-ld: dp_hw.c:(.text.dp_link_cfg+0x384): undefined reference to `__udivdi3'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

