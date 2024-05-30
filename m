Return-Path: <linux-kernel+bounces-195766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DAB8D519C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 20:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D32E41C21AE5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 18:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084974B5A6;
	Thu, 30 May 2024 18:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fEmKXiJ9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7C51D531;
	Thu, 30 May 2024 18:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717092248; cv=none; b=bDZP5hRTtTs/XvGYRQ0lZcjC33oVVdQWN+t5+9Hz1473dxpI8jMGIRbfbomDjGygYGWTePpQzu8o+yrHuSfPl+WCzpWVHaeh50eKjUwHQU2G2NtyUFvEuVJTHtZV2jgodDIY3sWhBu3ZcCg4cGnSoPGML2M1lWoVHvAmQgkw/os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717092248; c=relaxed/simple;
	bh=BEIEhrG9qX9RIUaoual1xQdHFV9ZgAZNbmY16Qsocp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aj30lVGyTE3JrzBG78vasgqdchlKVfmwg57M+ro3D4N7MZ1v+FYrA8PRF9066Mo59lRQFMTLqG8ZS1fNrFr6+EJADcpK9W+9K3URqND/Ii9QXcCvNDkPPpgU/v+K7IZt5P7+mHXQbKN3AnX8U2mGTKDKlzQ7w5IS7GIY4qDcvrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fEmKXiJ9; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717092245; x=1748628245;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BEIEhrG9qX9RIUaoual1xQdHFV9ZgAZNbmY16Qsocp4=;
  b=fEmKXiJ9a9KI3LhofMaAmYU2k8sEPfaU4GdHcnShcAfaj92M5ql6eyQz
   qYuHLiqLc2NopnOvRsmpXGECdwTY3ydpErSDRmmZYNV79Ke1i6YkLxTaE
   wtv1smQNGzQXt1So3L81lyo+f4N8AFlPI2NSfFZU9/99M4+ritZOvErL4
   /remByHzWARVQA1d7NqREm7RYQmo8RMmwLodlplc8cOWRx5maBK5I4ZAs
   5DynTB/V2Jm65MbCOTmEc1/PGyXo3w9hoxNcrdZ/1mBGBieqSzxVZy0Tg
   ilSFhqjQjHteY5LSWpauNhnP7PmZHpBnBbDRriqDqWmqdiUM3QittDvbO
   Q==;
X-CSE-ConnectionGUID: xXJLHjC1SDWX9ETATQY+NA==
X-CSE-MsgGUID: 6LRcVIqjT4+Oui8mue5SWg==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="13828132"
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="13828132"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 11:04:05 -0700
X-CSE-ConnectionGUID: zucVqWpJR0mBCJBFt7Bqzw==
X-CSE-MsgGUID: p3huy5JiRFKNX17xuU9R6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="36389437"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 30 May 2024 11:04:00 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sCk85-000For-1p;
	Thu, 30 May 2024 18:03:57 +0000
Date: Fri, 31 May 2024 02:03:33 +0800
From: kernel test robot <lkp@intel.com>
To: Chen-Yu Tsai <wenst@chromium.org>, Frank Binns <frank.binns@imgtec.com>,
	Matt Coster <matt.coster@imgtec.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: oe-kbuild-all@lists.linux.dev, Chen-Yu Tsai <wenst@chromium.org>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] clk: mediatek: Add mt8173-mfgtop driver
Message-ID: <202405310123.KWoPspRr-lkp@intel.com>
References: <20240530083513.4135052-3-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530083513.4135052-3-wenst@chromium.org>

Hi Chen-Yu,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0]

url:    https://github.com/intel-lab-lkp/linux/commits/Chen-Yu-Tsai/dt-bindings-clock-mediatek-Add-mt8173-mfgtop/20240530-163739
base:   1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
patch link:    https://lore.kernel.org/r/20240530083513.4135052-3-wenst%40chromium.org
patch subject: [PATCH 2/6] clk: mediatek: Add mt8173-mfgtop driver
config: x86_64-buildonly-randconfig-002-20240531 (https://download.01.org/0day-ci/archive/20240531/202405310123.KWoPspRr-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240531/202405310123.KWoPspRr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405310123.KWoPspRr-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/pmdomain/core.c:2965:34: warning: 'idle_state_match' defined but not used [-Wunused-const-variable=]
    2965 | static const struct of_device_id idle_state_match[] = {
         |                                  ^~~~~~~~~~~~~~~~

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for PM_GENERIC_DOMAINS_OF
   Depends on [n]: PM_GENERIC_DOMAINS [=y] && OF [=n]
   Selected by [y]:
   - COMMON_CLK_MT8173_MFGTOP [=y] && COMMON_CLK [=y] && (ARCH_MEDIATEK || COMPILE_TEST [=y]) && COMMON_CLK_MT8173 [=y]


vim +/idle_state_match +2965 drivers/pmdomain/core.c

5d6be70add65e3 drivers/base/power/domain.c Ulf Hansson 2018-06-29  2964  
30f604283e05d3 drivers/base/power/domain.c Lina Iyer   2016-10-14 @2965  static const struct of_device_id idle_state_match[] = {
598da548ef7892 drivers/base/power/domain.c Lina Iyer   2016-11-03  2966  	{ .compatible = "domain-idle-state", },
30f604283e05d3 drivers/base/power/domain.c Lina Iyer   2016-10-14  2967  	{ }
30f604283e05d3 drivers/base/power/domain.c Lina Iyer   2016-10-14  2968  };
30f604283e05d3 drivers/base/power/domain.c Lina Iyer   2016-10-14  2969  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

