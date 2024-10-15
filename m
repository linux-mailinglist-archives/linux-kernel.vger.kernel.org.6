Return-Path: <linux-kernel+bounces-365085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E5299DD52
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 06:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBB9E2829C3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 04:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FAB175D34;
	Tue, 15 Oct 2024 04:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Py9yH+gR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDD216EB56;
	Tue, 15 Oct 2024 04:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728968078; cv=none; b=J8pSABFiS3VvIWWeXkIpWslzmmnV5lfwxKNBBQ4L4k5IC5WUSN5dXIZGBilXCA6qMj8YDOqo5g4j/sRWc0hS3RuIz0wGn0c1ibI4TWkZP6p2ghiieG2w/hyhbXLjghFeQLRvr2CA76+o8p7gWVmrcgWWCpra/piKU4cXItEel0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728968078; c=relaxed/simple;
	bh=oVz47PuMBIBfEu4mr/NH3wXzWsFTytrvHYSGy9yzmwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bE/S1UfB7FvWLaprc18t1RO+/Lz66YX0EJKdmAuaB6OAIq0DUpCnPCsKMUDA26mOTKs2Pne7jGbEeXryranvM/RuObQ0mX6i1YW60LTHIrxujTiFyneoB3+vgG3ldZKBlq5re7d1jsDOO1WeN3p0ZAbwPFfWqZB2Jh4m6i9vw9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Py9yH+gR; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728968076; x=1760504076;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oVz47PuMBIBfEu4mr/NH3wXzWsFTytrvHYSGy9yzmwc=;
  b=Py9yH+gRtMT1ruwBTz5aEwoKBed6KKSxOKRttDKOSKaA9hje2ZzZhHsj
   suFg4ItcHaqOxCmqd9XjaLPD+DAlRcB04HnCMeBRHG9avG4V09oEaFHnE
   zyWur4NlmmUXNWYfBk4rDPfZbLwRnsBL44OhonKIFWBKmjhF7S4rHPk8h
   r80gYJO9YDMZc69vUqDeHQVYDFYdbwbvpplUHACRPExnYwhUTamwvey7E
   BF6AeJyTPfUem0+pe+XlwaQ8YxAIylMEcTeFixkX/7z0VZ7kT5nv8iuW8
   eWmLFyUg/Sr7kcOwT+QEl83+6YnDyaflrLlYwyZJqsyraJX5flMXqWNZr
   g==;
X-CSE-ConnectionGUID: HPRdToMKQ76q9c73mksyuA==
X-CSE-MsgGUID: dxQHfK54RwynUBRdQqz+RQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="45845458"
X-IronPort-AV: E=Sophos;i="6.11,204,1725346800"; 
   d="scan'208";a="45845458"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 21:54:35 -0700
X-CSE-ConnectionGUID: neUJbXNaRCiM7QAbRmJjQA==
X-CSE-MsgGUID: dLERMooTToO/skjvgMDaBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,204,1725346800"; 
   d="scan'208";a="77637593"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 14 Oct 2024 21:54:28 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t0ZZi-000Hdb-0C;
	Tue, 15 Oct 2024 04:54:26 +0000
Date: Tue, 15 Oct 2024 12:54:15 +0800
From: kernel test robot <lkp@intel.com>
To: Liu Ying <victor.liu@nxp.com>, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, andrzej.hajda@intel.com,
	neil.armstrong@linaro.org, rfoss@kernel.org,
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
	jernej.skrabec@gmail.com, airlied@gmail.com, simona@ffwll.ch,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, catalin.marinas@arm.com,
	will@kernel.org, quic_bjorande@quicinc.com, geert+renesas@glider.be,
	dmitry.baryshkov@linaro.org, arnd@arndb.de, nfraprado@collabora.com
Subject: Re: [PATCH v2 6/9] drm/bridge: Add ITE IT6263 LVDS to HDMI converter
Message-ID: <202410151230.DwfMNFO5-lkp@intel.com>
References: <20241012073543.1388069-7-victor.liu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241012073543.1388069-7-victor.liu@nxp.com>

Hi Liu,

kernel test robot noticed the following build warnings:

[auto build test WARNING on shawnguo/for-next]
[also build test WARNING on arm64/for-next/core drm/drm-next drm-exynos/exynos-drm-next drm-intel/for-linux-next drm-intel/for-linux-next-fixes drm-misc/drm-misc-next drm-tip/drm-tip linus/master v6.12-rc3 next-20241014]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Liu-Ying/arm64-dts-imx8mp-skov-revb-mi1010ait-1cp1-Add-panel-timing-node-to-panel-node/20241012-154239
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git for-next
patch link:    https://lore.kernel.org/r/20241012073543.1388069-7-victor.liu%40nxp.com
patch subject: [PATCH v2 6/9] drm/bridge: Add ITE IT6263 LVDS to HDMI converter
config: i386-randconfig-052-20241015 (https://download.01.org/0day-ci/archive/20241015/202410151230.DwfMNFO5-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410151230.DwfMNFO5-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/bridge/ite-it6263.c:683:57-62: WARNING: conversion to bool not needed here

vim +683 drivers/gpu/drm/bridge/ite-it6263.c

   655	
   656	static void
   657	it6263_bridge_atomic_enable(struct drm_bridge *bridge,
   658				    struct drm_bridge_state *old_bridge_state)
   659	{
   660		struct drm_atomic_state *state = old_bridge_state->base.state;
   661		struct it6263 *it = bridge_to_it6263(bridge);
   662		const struct drm_crtc_state *crtc_state;
   663		struct regmap *regmap = it->hdmi_regmap;
   664		const struct drm_display_mode *mode;
   665		struct drm_connector *connector;
   666		bool is_stable = false;
   667		struct drm_crtc *crtc;
   668		unsigned int val;
   669		bool pclk_high;
   670		int i, ret;
   671	
   672		connector = drm_atomic_get_new_connector_for_encoder(state,
   673								     bridge->encoder);
   674		crtc = drm_atomic_get_new_connector_state(state, connector)->crtc;
   675		crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
   676		mode = &crtc_state->adjusted_mode;
   677	
   678		regmap_write(regmap, HDMI_REG_HDMI_MODE, TX_HDMI_MODE);
   679	
   680		it6263_hdmi_avi_infoframe_configure(it, connector, mode);
   681	
   682		/* HDMI AFE setup */
 > 683		pclk_high = mode->clock > HIGH_PIXEL_CLOCK_KHZ ? true : false;
   684		regmap_write(regmap, HDMI_REG_AFE_DRV_CTRL, AFE_DRV_RST);
   685		if (pclk_high)
   686			regmap_write(regmap, HDMI_REG_AFE_XP_CTRL,
   687				     AFE_XP_GAINBIT | AFE_XP_RESETB);
   688		else
   689			regmap_write(regmap, HDMI_REG_AFE_XP_CTRL,
   690				     AFE_XP_ER0 | AFE_XP_RESETB);
   691		regmap_write(regmap, HDMI_REG_AFE_ISW_CTRL, 0x10);
   692		if (pclk_high)
   693			regmap_write(regmap, HDMI_REG_AFE_IP_CTRL,
   694				     AFE_IP_GAINBIT | AFE_IP_RESETB);
   695		else
   696			regmap_write(regmap, HDMI_REG_AFE_IP_CTRL,
   697				     AFE_IP_ER0 | AFE_IP_RESETB);
   698	
   699		/* HDMI software video reset */
   700		regmap_write_bits(regmap, HDMI_REG_SW_RST, SOFTV_RST, SOFTV_RST);
   701		fsleep(1000);
   702		regmap_write_bits(regmap, HDMI_REG_SW_RST, SOFTV_RST, 0);
   703	
   704		/* reconfigure LVDS and retry several times in case video is instable */
   705		for (i = 0; i < 3; i++) {
   706			ret = regmap_read_poll_timeout(regmap, HDMI_REG_SYS_STATUS, val,
   707						       val & TXVIDSTABLE,
   708						       20000, 500000);
   709			if (!ret) {
   710				is_stable = true;
   711				break;
   712			}
   713	
   714			it6263_lvds_config(it);
   715		}
   716	
   717		if (!is_stable)
   718			dev_warn(it->dev, "failed to wait for video stable\n");
   719	
   720		/* HDMI AFE reset release and power up */
   721		regmap_write(regmap, HDMI_REG_AFE_DRV_CTRL, 0);
   722	
   723		regmap_write_bits(regmap, HDMI_REG_GCP, AVMUTE, 0);
   724	
   725		regmap_write(regmap, HDMI_REG_PKT_GENERAL_CTRL, ENABLE_PKT | REPEAT_PKT);
   726	}
   727	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

