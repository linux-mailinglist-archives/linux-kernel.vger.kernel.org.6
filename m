Return-Path: <linux-kernel+bounces-197967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA328D7153
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 19:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CE101C20B08
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 17:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DFA1154BFA;
	Sat,  1 Jun 2024 17:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nyuTJsmD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F9D8473;
	Sat,  1 Jun 2024 17:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717262160; cv=none; b=FkcXgTg66ULbGy7SLBrADcQJ3P5ytq2Vm5rMzfF1xT/3HBdjk/ihYGzv8U3DFBmbGHndiVIYQROR3EnHCjw5034hz8SL83dJeExgAVef1LukQwBGQxtOX6Xfc9NrH1wDbPJgB65AbqphGLwcpLZ0C9cCmVDD9A6FcUv9E5Wbcww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717262160; c=relaxed/simple;
	bh=QT0/E9Yiy8jGP3WrJjpfhCJZG2LSMCz7oy8UufZ8jHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X18YfFtibB+GPejJyGxorSl2F2eLm5fy93Mz1nUl8eY6YQmIfS+3W3EJi+G9qOyBQ4O6qFKh6uJ/zp8t833GlqT/nywCRcsORZRZroKPWvJOZ+lLcNEI3zL2unaOf25HFyJOOiEljlhZ19uf5QOBBAFD3CH9KvyYNwggYS2JYfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nyuTJsmD; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717262157; x=1748798157;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QT0/E9Yiy8jGP3WrJjpfhCJZG2LSMCz7oy8UufZ8jHo=;
  b=nyuTJsmD08wZLC41cgbD6WdO6BTD3iM9k8Ms8DOYLt3oR8yJxursp4Ix
   SSBm8t7pdkQzWi3NGPkS2MI+wytQa9DBNnGVBa5tWIYmqvZBKZ/Ac3/dQ
   /Daq+pnIw7CLVF4y5Ws0bUdU7ABd2mF1NmXKZzzxOkd9AnLMWCIObstxh
   7wusBhbXV76LVRbSMY57geESbVZZa85/BqcDJ7ErPgvepjREiopL2aG4M
   aEXLWq8/i/n1ylfOMi+mpyCc8GGl9U0sgv/gFpS75l65sjUFoNhHMs38y
   Fln1vYMfjk0K3WusMMY1zc90syvrasHLxx4RvKx9ox4G4MlWrWrfj/3Cp
   g==;
X-CSE-ConnectionGUID: sLRsKSMNQcmXdcizwc3Dpg==
X-CSE-MsgGUID: 7D4AdwiuQEqbQaBZVh7eIA==
X-IronPort-AV: E=McAfee;i="6600,9927,11090"; a="39200154"
X-IronPort-AV: E=Sophos;i="6.08,207,1712646000"; 
   d="scan'208";a="39200154"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2024 10:15:57 -0700
X-CSE-ConnectionGUID: fh2X1d6hTGqjZBpzWWpz1g==
X-CSE-MsgGUID: EPn/z0lATWOf0HFkYD5mSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,207,1712646000"; 
   d="scan'208";a="41004444"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 01 Jun 2024 10:15:50 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sDSKZ-000JAV-2x;
	Sat, 01 Jun 2024 17:15:47 +0000
Date: Sun, 2 Jun 2024 01:15:38 +0800
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
	Mark Yao <markyao0591@gmail.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
	kernel@collabora.com, Alexandre ARNOUD <aarnoud@me.com>,
	Luis de Arquer <ldearquer@gmail.com>,
	Algea Cao <algea.cao@rock-chips.com>
Subject: Re: [PATCH 14/14] drm/rockchip: dw_hdmi: Add basic RK3588 support
Message-ID: <202406020122.7LHytbS3-lkp@intel.com>
References: <20240601-b4-rk3588-bridge-upstream-v1-14-f6203753232b@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240601-b4-rk3588-bridge-upstream-v1-14-f6203753232b@collabora.com>

Hi Cristian,

kernel test robot noticed the following build errors:

[auto build test ERROR on 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0]

url:    https://github.com/intel-lab-lkp/linux/commits/Cristian-Ciocaltea/drm-bridge-dw-hdmi-Simplify-clock-handling/20240601-211531
base:   1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
patch link:    https://lore.kernel.org/r/20240601-b4-rk3588-bridge-upstream-v1-14-f6203753232b%40collabora.com
patch subject: [PATCH 14/14] drm/rockchip: dw_hdmi: Add basic RK3588 support
config: arm-defconfig (https://download.01.org/0day-ci/archive/20240602/202406020122.7LHytbS3-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240602/202406020122.7LHytbS3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406020122.7LHytbS3-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c:280:26: error: implicit declaration of function 'devm_gpiod_get_optional' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                   hdmi->qp_enable_gpio = devm_gpiod_get_optional(hdmi->dev, "enable",
                                          ^
   drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c:280:26: note: did you mean 'devm_clk_get_optional'?
   include/linux/clk.h:597:13: note: 'devm_clk_get_optional' declared here
   struct clk *devm_clk_get_optional(struct device *dev, const char *id);
               ^
>> drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c:281:15: error: use of undeclared identifier 'GPIOD_OUT_HIGH'
                                                                  GPIOD_OUT_HIGH);
                                                                  ^
>> drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c:364:3: error: implicit declaration of function 'gpiod_set_value' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                   gpiod_set_value(hdmi->qp_enable_gpio, 1);
                   ^
   3 errors generated.


vim +/devm_gpiod_get_optional +280 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c

   226	
   227	static int rockchip_hdmi_parse_dt(struct rockchip_hdmi *hdmi)
   228	{
   229		static const char * const qp_clk_names[] = {
   230			"pclk", "hdp", "earc", "aud", "hclk_vo1",
   231		};
   232		struct device_node *np = hdmi->dev->of_node;
   233		struct clk *qp_clk;
   234		int ret, i;
   235	
   236		hdmi->regmap = syscon_regmap_lookup_by_phandle(np, "rockchip,grf");
   237		if (IS_ERR(hdmi->regmap)) {
   238			drm_err(hdmi, "Unable to get rockchip,grf\n");
   239			return PTR_ERR(hdmi->regmap);
   240		}
   241	
   242		hdmi->ref_clk = devm_clk_get_optional_enabled(hdmi->dev, "ref");
   243		if (!hdmi->ref_clk)
   244			hdmi->ref_clk = devm_clk_get_optional_enabled(hdmi->dev, "vpll");
   245	
   246		if (IS_ERR(hdmi->ref_clk)) {
   247			ret = PTR_ERR(hdmi->ref_clk);
   248			if (ret != -EPROBE_DEFER)
   249				drm_err(hdmi, "failed to get reference clock\n");
   250			return ret;
   251		}
   252	
   253		hdmi->grf_clk = devm_clk_get_optional(hdmi->dev, "grf");
   254		if (IS_ERR(hdmi->grf_clk)) {
   255			ret = PTR_ERR(hdmi->grf_clk);
   256			if (ret != -EPROBE_DEFER)
   257				drm_err(hdmi, "failed to get grf clock\n");
   258			return ret;
   259		}
   260	
   261		if (hdmi->is_hdmi_qp) {
   262			hdmi->vo1_regmap = syscon_regmap_lookup_by_phandle(np, "rockchip,vo1_grf");
   263			if (IS_ERR(hdmi->vo1_regmap)) {
   264				drm_err(hdmi, "Unable to get rockchip,vo1_grf\n");
   265				return PTR_ERR(hdmi->vo1_regmap);
   266			}
   267	
   268			for (i = 0; i < ARRAY_SIZE(qp_clk_names); i++) {
   269				qp_clk = devm_clk_get_optional_enabled(hdmi->dev, qp_clk_names[i]);
   270	
   271				if (IS_ERR(qp_clk)) {
   272					ret = PTR_ERR(qp_clk);
   273					if (ret != -EPROBE_DEFER)
   274						drm_err(hdmi, "failed to get %s clock: %d\n",
   275							qp_clk_names[i], ret);
   276					return ret;
   277				}
   278			}
   279	
 > 280			hdmi->qp_enable_gpio = devm_gpiod_get_optional(hdmi->dev, "enable",
 > 281								       GPIOD_OUT_HIGH);
   282			if (IS_ERR(hdmi->qp_enable_gpio)) {
   283				ret = PTR_ERR(hdmi->qp_enable_gpio);
   284				drm_err(hdmi, "failed to request enable GPIO: %d\n", ret);
   285				return ret;
   286			}
   287		}
   288	
   289		ret = devm_regulator_get_enable(hdmi->dev, "avdd-0v9");
   290		if (ret)
   291			return ret;
   292	
   293		ret = devm_regulator_get_enable(hdmi->dev, "avdd-1v8");
   294	
   295		return ret;
   296	}
   297	
   298	static enum drm_mode_status
   299	dw_hdmi_rockchip_mode_valid(struct dw_hdmi *dw_hdmi, void *data,
   300				    const struct drm_display_info *info,
   301				    const struct drm_display_mode *mode)
   302	{
   303		struct rockchip_hdmi *hdmi = data;
   304		const struct dw_hdmi_mpll_config *mpll_cfg = rockchip_mpll_cfg;
   305		int pclk = mode->clock * 1000;
   306		bool exact_match = hdmi->plat_data->phy_force_vendor;
   307		int i;
   308	
   309		if (hdmi->ref_clk) {
   310			int rpclk = clk_round_rate(hdmi->ref_clk, pclk);
   311	
   312			if (abs(rpclk - pclk) > pclk / 1000)
   313				return MODE_NOCLOCK;
   314		}
   315	
   316		for (i = 0; mpll_cfg[i].mpixelclock != (~0UL); i++) {
   317			/*
   318			 * For vendor specific phys force an exact match of the pixelclock
   319			 * to preserve the original behaviour of the driver.
   320			 */
   321			if (exact_match && pclk == mpll_cfg[i].mpixelclock)
   322				return MODE_OK;
   323			/*
   324			 * The Synopsys phy can work with pixelclocks up to the value given
   325			 * in the corresponding mpll_cfg entry.
   326			 */
   327			if (!exact_match && pclk <= mpll_cfg[i].mpixelclock)
   328				return MODE_OK;
   329		}
   330	
   331		return MODE_BAD;
   332	}
   333	
   334	static void dw_hdmi_rockchip_encoder_disable(struct drm_encoder *encoder)
   335	{
   336	}
   337	
   338	static bool
   339	dw_hdmi_rockchip_encoder_mode_fixup(struct drm_encoder *encoder,
   340					    const struct drm_display_mode *mode,
   341					    struct drm_display_mode *adj_mode)
   342	{
   343		return true;
   344	}
   345	
   346	static void dw_hdmi_rockchip_encoder_mode_set(struct drm_encoder *encoder,
   347						      struct drm_display_mode *mode,
   348						      struct drm_display_mode *adj_mode)
   349	{
   350		struct rockchip_hdmi *hdmi = to_rockchip_hdmi(encoder);
   351	
   352		clk_set_rate(hdmi->ref_clk, adj_mode->clock * 1000);
   353	}
   354	
   355	static void dw_hdmi_rockchip_encoder_enable(struct drm_encoder *encoder)
   356	{
   357		struct rockchip_hdmi *hdmi = to_rockchip_hdmi(encoder);
   358		struct drm_crtc *crtc = encoder->crtc;
   359		u32 val;
   360		int ret, rate;
   361	
   362		if (hdmi->is_hdmi_qp) {
   363			/* Unconditionally switch to TMDS as FRL is not yet supported */
 > 364			gpiod_set_value(hdmi->qp_enable_gpio, 1);
   365	
   366			if (crtc && crtc->state) {
   367				clk_set_rate(hdmi->ref_clk,
   368					     crtc->state->adjusted_mode.crtc_clock * 1000);
   369				/*
   370				 * FIXME: Temporary workaround to pass pixel clock rate
   371				 * to the PHY driver until phy_configure_opts_hdmi
   372				 * becomes available in the PHY API. See also the related
   373				 * comment in rk_hdptx_phy_power_on() from
   374				 * drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
   375				 */
   376				if (hdmi->phy) {
   377					rate = crtc->state->mode.clock * 10;
   378					phy_set_bus_width(hdmi->phy, rate);
   379					drm_dbg(hdmi, "%s set bus_width=%u\n",
   380						__func__, rate);
   381				}
   382			}
   383		}
   384	
   385		if (hdmi->chip_data->lcdsel_grf_reg < 0)
   386			return;
   387	
   388		ret = drm_of_encoder_active_endpoint_id(hdmi->dev->of_node, encoder);
   389		if (ret)
   390			val = hdmi->chip_data->lcdsel_lit;
   391		else
   392			val = hdmi->chip_data->lcdsel_big;
   393	
   394		ret = clk_prepare_enable(hdmi->grf_clk);
   395		if (ret < 0) {
   396			drm_err(hdmi, "failed to enable grfclk %d\n", ret);
   397			return;
   398		}
   399	
   400		ret = regmap_write(hdmi->regmap, hdmi->chip_data->lcdsel_grf_reg, val);
   401		if (ret != 0)
   402			drm_err(hdmi, "Could not write to GRF: %d\n", ret);
   403	
   404		clk_disable_unprepare(hdmi->grf_clk);
   405		drm_dbg(hdmi, "vop %s output to hdmi\n", ret ? "LIT" : "BIG");
   406	}
   407	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

