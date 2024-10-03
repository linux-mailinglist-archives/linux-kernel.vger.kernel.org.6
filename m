Return-Path: <linux-kernel+bounces-349493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D6298F6F0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 21:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC9D42817B8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 19:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0704D1ABEBD;
	Thu,  3 Oct 2024 19:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="El282CrN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24931A726D
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 19:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727983193; cv=none; b=PFE+gbfXfXVgQEv2J4Wx1bUMeLDbUQEqYUeioeucJo2fpeQAZceoj9ZlJO9KwIw1utjVSnOeCLO5Gjsm/sueeKKyFpWPWwh2jguDCfnYcP5S4FHna5fWK8w7rjEJiDzKrfa3cYN3djRgSKNvX+lXlemCtA0nACs4RiKs9aYWe04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727983193; c=relaxed/simple;
	bh=qp+B/Cgeqc+O6iNL2JkS/1KXeE+pOf/uQGoDfUIrv2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TYfDzzDW9LTC8V5ULxE1EMQyR/9BgqXM5GcM78Wwm7QUXPlxR9Bd+v3iYo19kEl0Uldu0vkDCaYjWZBVQYKY0eFwNvYwXB2SK68Rc9AL1O7LV6HlazYwHcDCmRmUkSwdDzOdsL3dxx74ccA8OtOGJ3zlbxxN/1HvXouuj5rKvSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=El282CrN; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727983192; x=1759519192;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qp+B/Cgeqc+O6iNL2JkS/1KXeE+pOf/uQGoDfUIrv2g=;
  b=El282CrN92wsPv0k7Zz7Z5alxAd5mnUESo4o+hnWg5sIh0v2sGvLd+Qs
   7bL/rL72sLUykniFOWE9UYOpa1g1xM2761wjzC/qep4+a/I4FNvDWexqt
   6Bb4Qf6z28fXX6TevUjJ2lLh2C+I8l1ihapTNnOgmA2O5zx42hkIRWyFu
   drUxnS0ron1fyRHPF0sEoQ3UBbU6lRlgtG7kBmjSfACp7ftExEALEudDb
   GTlGlHm02kTT6a6M9M4L2O3S+zeCsKsNd2f7HXVsB8Ci0G5Tl5SmMFgkq
   sGBKbbKS/igwzt2Hy0veuG46qosXVTeilMmY2zv0rjDzkYj+M+V7ib9HG
   w==;
X-CSE-ConnectionGUID: aIkQwOFyTp6T+6klByODdQ==
X-CSE-MsgGUID: qaLR/WLSTJ2XZwSGM5w2ow==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="52603338"
X-IronPort-AV: E=Sophos;i="6.11,175,1725346800"; 
   d="scan'208";a="52603338"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 12:19:51 -0700
X-CSE-ConnectionGUID: zDzhdysGRxedHv6dEHrW7w==
X-CSE-MsgGUID: eCwOPx0+R+WGR2ssXhKAmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,175,1725346800"; 
   d="scan'208";a="74773372"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 03 Oct 2024 12:19:47 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1swRMX-0000p8-0m;
	Thu, 03 Oct 2024 19:19:45 +0000
Date: Fri, 4 Oct 2024 03:19:33 +0800
From: kernel test robot <lkp@intel.com>
To: shiyongbang <shiyongbang@huawei.com>, xinliang.liu@linaro.org,
	tiantao6@hisilicon.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	daniel@ffwll.ch, kong.kongxinwei@hisilicon.com
Cc: oe-kbuild-all@lists.linux.dev, liangjian010@huawei.com,
	chenjianmin@huawei.com, lidongming5@huawei.com,
	shiyongbang@huawei.com, libaihan@huawei.com, shenjian15@huawei.com,
	shaojijie@huawei.com, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH drm-dp 3/4] drm/hisilicon/hibmc: add dp kapi moduel in
 hibmc drivers
Message-ID: <202410040328.VeVxM9yB-lkp@intel.com>
References: <20240930100610.782363-4-shiyongbang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930100610.782363-4-shiyongbang@huawei.com>

Hi shiyongbang,

kernel test robot noticed the following build errors:

[auto build test ERROR on drm-misc/drm-misc-next]
[also build test ERROR on linus/master v6.12-rc1 next-20241003]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/shiyongbang/drm-hisilicon-hibmc-add-dp-aux-in-hibmc-drivers/20240930-181437
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/20240930100610.782363-4-shiyongbang%40huawei.com
patch subject: [PATCH drm-dp 3/4] drm/hisilicon/hibmc: add dp kapi moduel in hibmc drivers
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20241004/202410040328.VeVxM9yB-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241004/202410040328.VeVxM9yB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410040328.VeVxM9yB-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/gpu/drm/hisilicon/hibmc/dp/dp_kapi.o: in function `hibmc_dp_link_cfg':
>> dp_kapi.c:(.text+0x233): undefined reference to `__udivdi3'
>> ld: dp_kapi.c:(.text+0x35a): undefined reference to `__udivdi3'
   ld: dp_kapi.c:(.text+0x3cd): undefined reference to `__udivdi3'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

