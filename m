Return-Path: <linux-kernel+bounces-293490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E16958071
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 10:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93D101C2389B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 08:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A2C189F35;
	Tue, 20 Aug 2024 08:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a9AzR7td"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E0B4F5FB;
	Tue, 20 Aug 2024 08:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724141013; cv=none; b=llTyEqBVuXV0aetpi50l0vYYK2jV+J430sKDZ4B11Aeozoucn601rL2sVjHfPMD7Bviu9g1UOZWNJg8wvxw+faEB0ezpsgJYGz1fUXIyL0ookKVNBn99eq++7B3waoX4sdjZaB4P3X7V4W6yhCHJX0bKCnO5Qy5yUvR1gTvw5tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724141013; c=relaxed/simple;
	bh=ehM0NKwiBkTIIUiFMDl0KPxkSLKa1rAvt/NK3ByI314=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fTx2LAqMvhph0eaJ+7QxVkUgaUqrRhdbZAIDtREw4/6eJUqiaEwuSeimjgr+u7TO/h6q126DhKnnDDksFnfE8qOY3IbvVpOc/Z0B+NZN26X+d3loJXeiFrQPF3jGaKRe2w237THTVq1n/DDKIxy/C06smJGXbq+7OOkbWkv2P+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a9AzR7td; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724141010; x=1755677010;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ehM0NKwiBkTIIUiFMDl0KPxkSLKa1rAvt/NK3ByI314=;
  b=a9AzR7tdlfrJlARSCJZ0E056gIPSIsmIFz+45OSGo00ATlKAA8XaWsiz
   4U2ISANt8+pELRJtUkGtkur6MWx8y8MfEhDsUsu1PJkiEgiAQnfE40i/G
   O526lSZF0zWHBmgALZo6vUltowhcLE46PVcbWYPs14DVV9tiZeB75Mz20
   t//7HPDB1cV9j7VEuThL6GEPtvyevxOTMql7DRY7tutxovVARSbebHsm5
   gFtCBjpreLk0aAVj+tgeaH0Ore6bZjUFFunSBRIqZYm+BY41AmzlSLFjc
   IIB7xYtOP25QxIs7ZcQj2X/RkHz25dkmec+bNS7GdVz6T70mF8a1fgXT/
   Q==;
X-CSE-ConnectionGUID: Wv2ErQGSThinIZ8vVLd5gQ==
X-CSE-MsgGUID: 44ANQ70ATaa42uNy/V/0Ew==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="33845021"
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="33845021"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 01:03:29 -0700
X-CSE-ConnectionGUID: d4QBBVZ/Si+EYhPrzZwcng==
X-CSE-MsgGUID: fwAHWuJaTW64gjlfkMyo/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="60624946"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 20 Aug 2024 01:03:22 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sgJpo-0009se-0L;
	Tue, 20 Aug 2024 08:03:20 +0000
Date: Tue, 20 Aug 2024 16:02:51 +0800
From: kernel test robot <lkp@intel.com>
To: Stephen Boyd <swboyd@chromium.org>, chrome-platform@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	patches@lists.linux.dev, devicetree@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>,
	Pin-yen Lin <treapking@chromium.org>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Benson Leung <bleung@chromium.org>,
	Conor Dooley <conor+dt@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	dri-devel@lists.freedesktop.org,
	Guenter Roeck <groeck@chromium.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Lee Jones <lee@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Prashant Malani <pmalani@chromium.org>,
	Robert Foss <rfoss@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>
Subject: Re: [PATCH v3 07/17] drm/bridge: dp_typec: Support USB Type-C
 orientation
Message-ID: <202408201530.jPGxBSCk-lkp@intel.com>
References: <20240819223834.2049862-8-swboyd@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819223834.2049862-8-swboyd@chromium.org>

Hi Stephen,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 8400291e289ee6b2bf9779ff1c83a291501f017b]

url:    https://github.com/intel-lab-lkp/linux/commits/Stephen-Boyd/drm-atomic-helper-Introduce-lane-remapping-support-to-bridges/20240820-064107
base:   8400291e289ee6b2bf9779ff1c83a291501f017b
patch link:    https://lore.kernel.org/r/20240819223834.2049862-8-swboyd%40chromium.org
patch subject: [PATCH v3 07/17] drm/bridge: dp_typec: Support USB Type-C orientation
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20240820/202408201530.jPGxBSCk-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240820/202408201530.jPGxBSCk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408201530.jPGxBSCk-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/bridge/aux-hpd-bridge.c:60: warning: Function parameter or struct member 'orientation_switch' not described in 'drm_dp_typec_bridge_typec_port'


vim +60 drivers/gpu/drm/bridge/aux-hpd-bridge.c

c77d47cea15ad1 Stephen Boyd 2024-08-19  46  
c77d47cea15ad1 Stephen Boyd 2024-08-19  47  /**
c77d47cea15ad1 Stephen Boyd 2024-08-19  48   * struct drm_dp_typec_bridge_typec_port - USB type-c port associated with DP bridge
c77d47cea15ad1 Stephen Boyd 2024-08-19  49   * @lane_mapping: Physical (array index) to logical (array value) USB type-C lane mapping
9edcc62024ff61 Stephen Boyd 2024-08-19  50   * @orientation: Orientation of USB type-c port
c77d47cea15ad1 Stephen Boyd 2024-08-19  51   * @mode_switch: DP altmode switch
c77d47cea15ad1 Stephen Boyd 2024-08-19  52   * @typec_data: Back pointer to type-c bridge data
c77d47cea15ad1 Stephen Boyd 2024-08-19  53   */
c77d47cea15ad1 Stephen Boyd 2024-08-19  54  struct drm_dp_typec_bridge_typec_port {
c77d47cea15ad1 Stephen Boyd 2024-08-19  55  	u32 lane_mapping[NUM_USB_SS];
9edcc62024ff61 Stephen Boyd 2024-08-19  56  	enum typec_orientation orientation;
c77d47cea15ad1 Stephen Boyd 2024-08-19  57  	struct typec_mux_dev *mode_switch;
9edcc62024ff61 Stephen Boyd 2024-08-19  58  	struct typec_switch_dev *orientation_switch;
c77d47cea15ad1 Stephen Boyd 2024-08-19  59  	struct drm_dp_typec_bridge_data *typec_data;
c77d47cea15ad1 Stephen Boyd 2024-08-19 @60  };
c77d47cea15ad1 Stephen Boyd 2024-08-19  61  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

