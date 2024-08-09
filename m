Return-Path: <linux-kernel+bounces-281568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8069C94D83C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 22:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42391285C86
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 20:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BAA916B39E;
	Fri,  9 Aug 2024 20:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kkG67kbi"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AAE167DA8;
	Fri,  9 Aug 2024 20:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723236539; cv=none; b=Q42IRL2JUkK5/C5UN1/DGyDqMN9unRvgA+BIFVzWNzVKE0EXZj3/0XU4dUpWQ+LP839RI6HWMu0ZEegy+yAe4g5dE3cWLosAvkgMti+tKWO1u1ytnLYU1tarIiI4zUIjAFbcG4uxHzFDFjlIFyM8drY7rDn65uFB2dQJH9WFnaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723236539; c=relaxed/simple;
	bh=LQRpGUBrP4WLVH27RipF1PGbuYLU8ZOry99cQeZsWgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FWEwN/OeswbdIzgqdHyJfmPnM7SYbVxqosfd4cH0cXCLXSqlmax8deE1QAN8SBY9MNU1Jd32uc/QekOWffNFWaVeAP4vL6ZhAbRbjkR1UZWd/fWvsZncGH+tQWQbtMPjVlnn7/Xm1kEuCd3evAra+5/tMNaS3Azrq3L9vqJrsa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kkG67kbi; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723236538; x=1754772538;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LQRpGUBrP4WLVH27RipF1PGbuYLU8ZOry99cQeZsWgc=;
  b=kkG67kbi+AmK42UkUQbQ+l6W+i4z7RlhA4g9mHawUoTK8sUZiqFpOb6M
   sgyRRMxvg8BPC+pMHUHAd7QzE3sqcB/DK+Sv6N3DhFkwhewVqna0IaPlI
   fvo4ZXqr8CszCndrdcIxc/WfQ/i45jjYOw9e8tVqnOdqXIofITceXW6aU
   L0X9/t6rZafFhj0VMLeMXijcbuzowHcIxVW0pNpMBGhLYiuB7wSAvSxQ2
   JJDuroIlogLKyKiqTcK3u19MnXcXPo5xK2MfzO/THUyvKXdqo99pD/Zu0
   NK4/1lKei8FJJK9ZvirdWV1lqBokCm65cEYfQv61AyOvNgupFmiGoFW11
   A==;
X-CSE-ConnectionGUID: jSbrKuEERuSzNiosA4Brlw==
X-CSE-MsgGUID: M7etKZk3Tn+gRkKaDNxWMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11159"; a="21086007"
X-IronPort-AV: E=Sophos;i="6.09,277,1716274800"; 
   d="scan'208";a="21086007"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 13:48:57 -0700
X-CSE-ConnectionGUID: nZZWNeEBS0uGLtOZIanY+w==
X-CSE-MsgGUID: UOaZEDifTu2Qhnfc1lsqJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,277,1716274800"; 
   d="scan'208";a="88528687"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 09 Aug 2024 13:48:52 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1scWXZ-0009Fz-0o;
	Fri, 09 Aug 2024 20:48:49 +0000
Date: Sat, 10 Aug 2024 04:48:46 +0800
From: kernel test robot <lkp@intel.com>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Sandy Huang <hjc@rock-chips.com>,
	Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mark Yao <markyao0591@gmail.com>,
	Sascha Hauer <s.hauer@pengutronix.de>
Cc: oe-kbuild-all@lists.linux.dev, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
	kernel@collabora.com, Alexandre ARNOUD <aarnoud@me.com>,
	Luis de Arquer <ldearquer@gmail.com>,
	Algea Cao <algea.cao@rock-chips.com>
Subject: Re: [PATCH v2 3/3] drm/rockchip: Add basic RK3588 HDMI output support
Message-ID: <202408100456.yY6K40pK-lkp@intel.com>
References: <20240801-b4-rk3588-bridge-upstream-v2-3-9fa657a4e15b@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801-b4-rk3588-bridge-upstream-v2-3-9fa657a4e15b@collabora.com>

Hi Cristian,

kernel test robot noticed the following build errors:

[auto build test ERROR on 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0]

url:    https://github.com/intel-lab-lkp/linux/commits/Cristian-Ciocaltea/dt-bindings-display-rockchip-Add-schema-for-RK3588-HDMI-TX-Controller/20240802-173018
base:   1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
patch link:    https://lore.kernel.org/r/20240801-b4-rk3588-bridge-upstream-v2-3-9fa657a4e15b%40collabora.com
patch subject: [PATCH v2 3/3] drm/rockchip: Add basic RK3588 HDMI output support
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20240810/202408100456.yY6K40pK-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240810/202408100456.yY6K40pK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408100456.yY6K40pK-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c:18:10: fatal error: drm/bridge/dw_hdmi_qp.h: No such file or directory
      18 | #include <drm/bridge/dw_hdmi_qp.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.


vim +18 drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c

    17	
  > 18	#include <drm/bridge/dw_hdmi_qp.h>
    19	#include <drm/drm_bridge_connector.h>
    20	#include <drm/drm_of.h>
    21	#include <drm/drm_probe_helper.h>
    22	#include <drm/drm_simple_kms_helper.h>
    23	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

