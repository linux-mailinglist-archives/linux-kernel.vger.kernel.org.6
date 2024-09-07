Return-Path: <linux-kernel+bounces-319825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E249702AC
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 16:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFD971F229B4
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 14:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0CED15C13B;
	Sat,  7 Sep 2024 14:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B/oDijZg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117FE611E
	for <linux-kernel@vger.kernel.org>; Sat,  7 Sep 2024 14:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725718733; cv=none; b=JQrCxfLxt5nEtjqu5OVM3DIXVfwXUl9DHXuayJI2Qnbcu0nPYFfAtHq2BArc4VvpisyDZyuwcVB0cQCHPly1Btp0XoCGVfXJgAHXVn/RdRpoPyljY7dW2na6vUBGNoQ+YmlRWiUFsha5zXmOFS1fOI2qHL5IMXct8K5R2ocPVaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725718733; c=relaxed/simple;
	bh=uQozhLm+pbFrr6L5tufICCo/nQRXjrrcKZfepPqZQLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=abcJfBn+KOvzAOWA/BQeQXJJz90JstPaY5G88KN/Ek35aururewxjiwisuDg0tsZpb2fLqQtCE5Ct2cqvtJn/3uXUovoYru/QgEyg6A5LRIOwcrntWHOId8tkhPKTBW1QXOrJOmszCuywbyYWJJU2aET+nuMMQ2zo7xqQYaCc/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B/oDijZg; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725718730; x=1757254730;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uQozhLm+pbFrr6L5tufICCo/nQRXjrrcKZfepPqZQLo=;
  b=B/oDijZgcVurazcfYZMS0/VReylQx4UUia5sVIHutkuMB/9f//7dm72n
   Xux1fe681rD0H6wz5rAWyTOJNm/+PwmW4dduTNp5cvxwB9IYFbcxWKIrA
   CeDKN/ySFFjwa6G4LEBaNk4HU+fds4RHQ5nBzK2CG4iMOOhARKvQeQKdZ
   XOkvEVxPY53kLjgiMlDVZLRxU7bVzlmPwIRgEM/O1ITDABrnI5PKbW+RN
   mCL3XJV9Gl3pdo6gfJ9ojvqteWvFrUv4WfGaxoGdTtrAJkAgVQ/IOMwej
   8QkeVOWDvW0uL3Z/Ny9bkdUY32nJhzAobVVc0uypU7W+46RPcIlULzh+A
   g==;
X-CSE-ConnectionGUID: e0fIpW2mSaa4e50P25sr5w==
X-CSE-MsgGUID: paLSi0g5ShCtCgLiOXbQ5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11188"; a="24574794"
X-IronPort-AV: E=Sophos;i="6.10,210,1719903600"; 
   d="scan'208";a="24574794"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2024 07:18:49 -0700
X-CSE-ConnectionGUID: 48cMxYdJQreK9c9y+2SI+A==
X-CSE-MsgGUID: K0vScEDdR6aWxEC9TKewVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,210,1719903600"; 
   d="scan'208";a="66949831"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 07 Sep 2024 07:18:45 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1smwGx-000Ccn-15;
	Sat, 07 Sep 2024 14:18:43 +0000
Date: Sat, 7 Sep 2024 22:17:56 +0800
From: kernel test robot <lkp@intel.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] drm/imx: Add missing DRM_BRIDGE_CONNECTOR dependency
Message-ID: <202409072155.3p25ZqJu-lkp@intel.com>
References: <20240906063857.2223442-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906063857.2223442-1-alexander.stein@ew.tq-group.com>

Hi Alexander,

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20240905]
[cannot apply to v6.11-rc6 v6.11-rc5 v6.11-rc4 linus/master v6.11-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexander-Stein/drm-imx-Add-missing-DRM_BRIDGE_CONNECTOR-dependency/20240906-144116
base:   next-20240905
patch link:    https://lore.kernel.org/r/20240906063857.2223442-1-alexander.stein%40ew.tq-group.com
patch subject: [PATCH 1/1] drm/imx: Add missing DRM_BRIDGE_CONNECTOR dependency
config: alpha-kismet-CONFIG_DRM_BRIDGE_CONNECTOR-CONFIG_DRM_IMX_PARALLEL_DISPLAY-0-0 (https://download.01.org/0day-ci/archive/20240907/202409072155.3p25ZqJu-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20240907/202409072155.3p25ZqJu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409072155.3p25ZqJu-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for DRM_BRIDGE_CONNECTOR when selected by DRM_IMX_PARALLEL_DISPLAY
   WARNING: unmet direct dependencies detected for DRM_BRIDGE_CONNECTOR
     Depends on [n]: HAS_IOMEM [=y] && DRM [=y] && DRM_DISPLAY_HELPER [=n]
     Selected by [y]:
     - DRM_IMX_PARALLEL_DISPLAY [=y] && HAS_IOMEM [=y] && DRM [=y] && DRM_IMX [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

