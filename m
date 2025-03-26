Return-Path: <linux-kernel+bounces-576351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E37A70E28
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 01:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FA933B106A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 00:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7772563;
	Wed, 26 Mar 2025 00:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BOOPphk3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8919EBE
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 00:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742948345; cv=none; b=X3KOVLaApXRaBg+0deoqQjHyZwJj/dq84mqv+XZLzb/e+AAf/u41AcmnbCQNkXtgtROYeM8xt9OcIiylFi/sIg9esTX7NOfTbHfaXB2QK2zleJmQamGjLLHQSVXdWJJLIudaTJRGqFr5xovDP8J0mWNP/ysdpoIqY6p23sQXeqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742948345; c=relaxed/simple;
	bh=DIa5JrphLzDLlq69xQ2Orirc4rhT7kxJMGAQJFzZ9FA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lvlugbup5lIPgOs2P9XTdQ+ALSsne3fmu3erpHRlm8S/SVyFJ+MWZZURILw2oYYguDFvVJK/yjMvkCzoqby+E0B8+tVumtDjAanyI8xavyaq7qPn4ZtK/QyjDhVcLZRRboK34jkreCV1aXTrl5xqGgvuL+43r/iegclaaE314sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BOOPphk3; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742948343; x=1774484343;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DIa5JrphLzDLlq69xQ2Orirc4rhT7kxJMGAQJFzZ9FA=;
  b=BOOPphk3IeMk5mSMWA5KLeqW7kiH+QgPHMDyJE9+fgm239ukSSB38teT
   pBd2Wb4u2XOV0JgLIKY296e3xO5Ur6BugcOxoa0Wu61xJO/zOJzK5q3wg
   BgmNPfP1/V5Dy70DFTBZFPRvTXD6ULKq0YShlNLXYnnHcvb42dgP81k0p
   RD3QdU+C3u/y/0BE5fU+TthQf/3uHxmK+fmU6t3eE9Mhd1UzaKVWjp6Xb
   ToQkStZfEFYrTAQSagtZoBK+vhpEcdvkQSSD+ra8BDocl7ZxJYdlcrpio
   tMZCLYPpgApuAU5DA/3kWQrfilApFH+2g96/l5BLco+bqSCeM85Ng2fX0
   g==;
X-CSE-ConnectionGUID: 78B7FI1YREm4J1atlYB/qw==
X-CSE-MsgGUID: rR1QTXTdTC+uPg5eOFMcew==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="43946401"
X-IronPort-AV: E=Sophos;i="6.14,276,1736841600"; 
   d="scan'208";a="43946401"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 17:19:03 -0700
X-CSE-ConnectionGUID: KmClavU2Sl+wLvV8+URyzw==
X-CSE-MsgGUID: W+aDdoV1SJKzO+z7ytAZMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,276,1736841600"; 
   d="scan'208";a="147719246"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 25 Mar 2025 17:18:59 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1txETq-0005KN-3D;
	Wed, 26 Mar 2025 00:18:52 +0000
Date: Wed, 26 Mar 2025 08:18:07 +0800
From: kernel test robot <lkp@intel.com>
To: Anusha Srivatsa <asrivats@redhat.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: oe-kbuild-all@lists.linux.dev, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Anusha Srivatsa <asrivats@redhat.com>
Subject: Re: [PATCH 3/5] drm/panel: get/put panel reference in
 drm_panel_add/remove()
Message-ID: <202503260710.gDo7vXVR-lkp@intel.com>
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
config: xtensa-randconfig-001-20250326 (https://download.01.org/0day-ci/archive/20250326/202503260710.gDo7vXVR-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250326/202503260710.gDo7vXVR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503260710.gDo7vXVR-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in arch/xtensa/platforms/iss/simdisk.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/slub_kunit.o
>> ERROR: modpost: "drm_panel_put" [drivers/gpu/drm/drm.ko] undefined!
>> ERROR: modpost: "drm_panel_get" [drivers/gpu/drm/drm.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

