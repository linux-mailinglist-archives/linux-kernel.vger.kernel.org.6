Return-Path: <linux-kernel+bounces-576488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 505BBA70FE9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 05:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76561189E044
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 04:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D7215DBB3;
	Wed, 26 Mar 2025 04:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OQQ9WJWG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2464C2E403
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 04:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742963751; cv=none; b=M80yjgC9Q9NAlBjnm45rfBfbC0NnD5NmaE2p9SBkjR2P5Hx7YfuX7EkS5tl7g6CNLaYX6SmRVbnv9sH3m2rmJcyI+ZnBJ6ybOqMGPMydj1cIbMA+3tccjRgLR2+iCiMXqg98fN1Rgw07fGJruMyiMSI17s5EiG4t/ciRhJMNjK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742963751; c=relaxed/simple;
	bh=GQ1oIpQGfgsBC45qDuxDMKJrmn5EAfssdGCXeqH/9ZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=je1FkD/c0E15Eoin5xQBH/96+589lTiBkBkJ+WSMQbvLhPJUxqncts1ynjyfqcIFCR/mys/j55n2J2gSbBRM4npiv7LT8wkMMfWV6G0dfNpFTrXMkcVKlyVHZr1SfVMyN3xdQG3a8yNNWz1SE12OvmBAPZ5Q+e+OX2UeZ/u9hb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OQQ9WJWG; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742963749; x=1774499749;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GQ1oIpQGfgsBC45qDuxDMKJrmn5EAfssdGCXeqH/9ZQ=;
  b=OQQ9WJWGn93EFDwnaC2Kz+TK0rZ36jGoHdyL39FQRjdwx4ejR/ccRiOi
   o1ulmTZnAM823LhbM9Rp2sSlWLGjb+gJPu99gIYZ2t5V2hxyzOG2J2BDK
   VT+LFHVGLeoqnChThNjlrM0rhFx6HHBARlWEvnRDOTh/6+va0z7nU8elW
   qHCBLY0iaPhtSNa6WjvwvMqJXgMR0P0aMJIZCu1zwL5vpLhqteEbEUJbm
   NGh4yA2G928A1JpCxeDmFmqWduWbmmxWPpNTv3pxtd9wZwaHsNKqgAADl
   RIqqUFwlZolPlejystmJJCJnarzju1tbW3YeL5MbSwkrhDSl9jkvu0l5F
   A==;
X-CSE-ConnectionGUID: MJWvG0EiThG/VvBfx7t2bg==
X-CSE-MsgGUID: dxXSJ9zUR4aCQcyotQc1DQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="43389821"
X-IronPort-AV: E=Sophos;i="6.14,276,1736841600"; 
   d="scan'208";a="43389821"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 21:35:48 -0700
X-CSE-ConnectionGUID: uCbjFf2DRSWx3lTfQGASBg==
X-CSE-MsgGUID: tnfpUoa8QleNuum3sJ8qdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,276,1736841600"; 
   d="scan'208";a="161827195"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 25 Mar 2025 21:35:45 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1txIUQ-0005SR-24;
	Wed, 26 Mar 2025 04:35:42 +0000
Date: Wed, 26 Mar 2025 12:35:29 +0800
From: kernel test robot <lkp@intel.com>
To: Anusha Srivatsa <asrivats@redhat.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Anusha Srivatsa <asrivats@redhat.com>
Subject: Re: [PATCH 3/5] drm/panel: get/put panel reference in
 drm_panel_add/remove()
Message-ID: <202503261119.h0EEYLFA-lkp@intel.com>
References: <20250325-b4-panel-refcounting-v1-3-4e2bf5d19c5d@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325-b4-panel-refcounting-v1-3-4e2bf5d19c5d@redhat.com>

Hi Anusha,

kernel test robot noticed the following build errors:

[auto build test ERROR on c8ba07caaecc622a9922cda49f24790821af8a71]

url:    https://github.com/intel-lab-lkp/linux/commits/Anusha-Srivatsa/drm-panel-Add-new-helpers-for-refcounted-panel-allocatons/20250326-012651
base:   c8ba07caaecc622a9922cda49f24790821af8a71
patch link:    https://lore.kernel.org/r/20250325-b4-panel-refcounting-v1-3-4e2bf5d19c5d%40redhat.com
patch subject: [PATCH 3/5] drm/panel: get/put panel reference in drm_panel_add/remove()
config: hexagon-randconfig-002-20250326 (https://download.01.org/0day-ci/archive/20250326/202503261119.h0EEYLFA-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project c2692afc0a92cd5da140dfcdfff7818a5b8ce997)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250326/202503261119.h0EEYLFA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503261119.h0EEYLFA-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: drm_panel_get
   >>> referenced by drm_panel.c:82 (drivers/gpu/drm/drm_panel.c:82)
   >>>               drivers/gpu/drm/drm_panel.o:(drm_panel_add) in archive vmlinux.a
   >>> referenced by drm_panel.c:82 (drivers/gpu/drm/drm_panel.c:82)
   >>>               drivers/gpu/drm/drm_panel.o:(drm_panel_add) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: drm_panel_put
   >>> referenced by drm_panel.c:100 (drivers/gpu/drm/drm_panel.c:100)
   >>>               drivers/gpu/drm/drm_panel.o:(drm_panel_remove) in archive vmlinux.a
   >>> referenced by drm_panel.c:100 (drivers/gpu/drm/drm_panel.c:100)
   >>>               drivers/gpu/drm/drm_panel.o:(drm_panel_remove) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

