Return-Path: <linux-kernel+bounces-320471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E20970AD4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 02:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4E88281D36
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 00:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32588B67F;
	Mon,  9 Sep 2024 00:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mYtcNi8F"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5453A7494;
	Mon,  9 Sep 2024 00:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725842599; cv=none; b=txKtTxA9Nxzh9/5AlwoTcDIrIzOlG5go0BOulihOlgddmEpcKP2DMobyBqIVXI7aQBN5xzwVJESMiErRdWkyQ1VCdntle0StCs7N7GQdzudOq+e18xAsJPLCZCljcTH64PNGXGrvcLbDJ8XOpSChgls7hTdpkZ1QY5p5oMpYjJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725842599; c=relaxed/simple;
	bh=XNNSjYDp2/vVWve1yWNzSRejqISxf3CiHc/EGOCbqS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rwEynkzmeG0xsypskFBy3o6VHebNw5H/TIaCWR2HlEuhu9TEPmOPnriyIXOQ9Lu7EXXaDSbnIU/CNtAFKC1rfVA9tNZrL5e8ZabrNLuxnI8s5cwTCsQgE8H8+O28Z/JM+Z/Hkqcb0bBvwLz5Ek/6glyHmSukR7jKQNPw5pJZSyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mYtcNi8F; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725842597; x=1757378597;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XNNSjYDp2/vVWve1yWNzSRejqISxf3CiHc/EGOCbqS8=;
  b=mYtcNi8Fi0UyHIm9oZ270oxhzjF+MX5BHyg3V5L5Ehjj3H3z5HLHpkSU
   a7uUn1gg3M7N4Jyi3o0MhUwdD73C+Y1R2m1iLVkAipzc+zXiYo37qBwaR
   Ns7XAHkQlko/jptamBV4CuRym+0eez96AkzWJmyvpVOionjWplBL0T/JN
   ZombqPQctjhJuAs5rJJ0AJsjgwiChxluJuI8qfbGNGnIRS0Gn43SONkNn
   /jfHJ42+Bx4tpmkyj2KmGAy5lf0g8uPlu62GhfJ7l5x3vcOaG7rskeP6o
   e76+NIabNj8SMu8oKLL25wsANK8Kst1vj7f+0X1Y1Twxfzdfks/zgRB23
   g==;
X-CSE-ConnectionGUID: 5lFTeKySRm6f5kn2PvZPHw==
X-CSE-MsgGUID: aBF2J85vRFCheoqKGMjmrQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11189"; a="24380700"
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="24380700"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2024 17:43:16 -0700
X-CSE-ConnectionGUID: 0TF1Qs4nRxmSO0LssqBdig==
X-CSE-MsgGUID: nHhGW951T3ePC2vI+90hZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="89764067"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 08 Sep 2024 17:43:10 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1snSUl-000E7t-2r;
	Mon, 09 Sep 2024 00:43:07 +0000
Date: Mon, 9 Sep 2024 08:42:58 +0800
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
Subject: Re: [PATCH v6 3/3] drm/rockchip: Add basic RK3588 HDMI output support
Message-ID: <202409090615.l6BkuR5K-lkp@intel.com>
References: <20240906-b4-rk3588-bridge-upstream-v6-3-a3128fb103eb@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906-b4-rk3588-bridge-upstream-v6-3-a3128fb103eb@collabora.com>

Hi Cristian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 8400291e289ee6b2bf9779ff1c83a291501f017b]

url:    https://github.com/intel-lab-lkp/linux/commits/Cristian-Ciocaltea/drm-bridge-synopsys-Add-DW-HDMI-QP-TX-Controller-support-library/20240906-092027
base:   8400291e289ee6b2bf9779ff1c83a291501f017b
patch link:    https://lore.kernel.org/r/20240906-b4-rk3588-bridge-upstream-v6-3-a3128fb103eb%40collabora.com
patch subject: [PATCH v6 3/3] drm/rockchip: Add basic RK3588 HDMI output support
config: powerpc64-randconfig-r122-20240908 (https://download.01.org/0day-ci/archive/20240909/202409090615.l6BkuR5K-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce: (https://download.01.org/0day-ci/archive/20240909/202409090615.l6BkuR5K-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409090615.l6BkuR5K-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c:679:24: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected struct dw_hdmi_qp * @@     got void [noderef] __iomem *[assigned] regs @@
   drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c:679:24: sparse:     expected struct dw_hdmi_qp *
   drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c:679:24: sparse:     got void [noderef] __iomem *[assigned] regs

vim +679 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c

4ae2f13b217e6c Cristian Ciocaltea 2024-09-06  653  
4ae2f13b217e6c Cristian Ciocaltea 2024-09-06  654  struct dw_hdmi_qp *dw_hdmi_qp_bind(struct platform_device *pdev,
4ae2f13b217e6c Cristian Ciocaltea 2024-09-06  655  				   struct drm_encoder *encoder,
4ae2f13b217e6c Cristian Ciocaltea 2024-09-06  656  				   const struct dw_hdmi_qp_plat_data *plat_data)
4ae2f13b217e6c Cristian Ciocaltea 2024-09-06  657  {
4ae2f13b217e6c Cristian Ciocaltea 2024-09-06  658  	struct device *dev = &pdev->dev;
4ae2f13b217e6c Cristian Ciocaltea 2024-09-06  659  	struct dw_hdmi_qp *hdmi;
4ae2f13b217e6c Cristian Ciocaltea 2024-09-06  660  	void __iomem *regs;
4ae2f13b217e6c Cristian Ciocaltea 2024-09-06  661  	int ret;
4ae2f13b217e6c Cristian Ciocaltea 2024-09-06  662  
4ae2f13b217e6c Cristian Ciocaltea 2024-09-06  663  	if (!plat_data->phy_ops || !plat_data->phy_ops->init ||
4ae2f13b217e6c Cristian Ciocaltea 2024-09-06  664  	    !plat_data->phy_ops->disable || !plat_data->phy_ops->read_hpd) {
4ae2f13b217e6c Cristian Ciocaltea 2024-09-06  665  		dev_err(dev, "Missing platform PHY ops\n");
4ae2f13b217e6c Cristian Ciocaltea 2024-09-06  666  		return ERR_PTR(-ENODEV);
4ae2f13b217e6c Cristian Ciocaltea 2024-09-06  667  	}
4ae2f13b217e6c Cristian Ciocaltea 2024-09-06  668  
4ae2f13b217e6c Cristian Ciocaltea 2024-09-06  669  	hdmi = devm_kzalloc(dev, sizeof(*hdmi), GFP_KERNEL);
4ae2f13b217e6c Cristian Ciocaltea 2024-09-06  670  	if (!hdmi)
4ae2f13b217e6c Cristian Ciocaltea 2024-09-06  671  		return ERR_PTR(-ENOMEM);
4ae2f13b217e6c Cristian Ciocaltea 2024-09-06  672  
4ae2f13b217e6c Cristian Ciocaltea 2024-09-06  673  	INIT_DELAYED_WORK(&hdmi->scramb_work, dw_hdmi_qp_scramb_work);
4ae2f13b217e6c Cristian Ciocaltea 2024-09-06  674  
4ae2f13b217e6c Cristian Ciocaltea 2024-09-06  675  	hdmi->dev = dev;
4ae2f13b217e6c Cristian Ciocaltea 2024-09-06  676  
4ae2f13b217e6c Cristian Ciocaltea 2024-09-06  677  	regs = devm_platform_ioremap_resource(pdev, 0);
4ae2f13b217e6c Cristian Ciocaltea 2024-09-06  678  	if (IS_ERR(regs))
4ae2f13b217e6c Cristian Ciocaltea 2024-09-06 @679  		return regs;
4ae2f13b217e6c Cristian Ciocaltea 2024-09-06  680  
4ae2f13b217e6c Cristian Ciocaltea 2024-09-06  681  	hdmi->regm = devm_regmap_init_mmio(dev, regs, &dw_hdmi_qp_regmap_config);
4ae2f13b217e6c Cristian Ciocaltea 2024-09-06  682  	if (IS_ERR(hdmi->regm)) {
4ae2f13b217e6c Cristian Ciocaltea 2024-09-06  683  		dev_err(dev, "Failed to configure regmap\n");
4ae2f13b217e6c Cristian Ciocaltea 2024-09-06  684  		return ERR_CAST(hdmi->regm);
4ae2f13b217e6c Cristian Ciocaltea 2024-09-06  685  	}
4ae2f13b217e6c Cristian Ciocaltea 2024-09-06  686  
4ae2f13b217e6c Cristian Ciocaltea 2024-09-06  687  	hdmi->phy.ops = plat_data->phy_ops;
4ae2f13b217e6c Cristian Ciocaltea 2024-09-06  688  	hdmi->phy.data = plat_data->phy_data;
4ae2f13b217e6c Cristian Ciocaltea 2024-09-06  689  
4ae2f13b217e6c Cristian Ciocaltea 2024-09-06  690  	dw_hdmi_qp_init_hw(hdmi);
4ae2f13b217e6c Cristian Ciocaltea 2024-09-06  691  
4ae2f13b217e6c Cristian Ciocaltea 2024-09-06  692  	ret = devm_request_threaded_irq(dev, plat_data->main_irq,
4ae2f13b217e6c Cristian Ciocaltea 2024-09-06  693  					dw_hdmi_qp_main_hardirq, NULL,
4ae2f13b217e6c Cristian Ciocaltea 2024-09-06  694  					IRQF_SHARED, dev_name(dev), hdmi);
4ae2f13b217e6c Cristian Ciocaltea 2024-09-06  695  	if (ret)
4ae2f13b217e6c Cristian Ciocaltea 2024-09-06  696  		return ERR_PTR(ret);
4ae2f13b217e6c Cristian Ciocaltea 2024-09-06  697  
4ae2f13b217e6c Cristian Ciocaltea 2024-09-06  698  	hdmi->bridge.driver_private = hdmi;
4ae2f13b217e6c Cristian Ciocaltea 2024-09-06  699  	hdmi->bridge.funcs = &dw_hdmi_qp_bridge_funcs;
4ae2f13b217e6c Cristian Ciocaltea 2024-09-06  700  	hdmi->bridge.ops = DRM_BRIDGE_OP_DETECT |
4ae2f13b217e6c Cristian Ciocaltea 2024-09-06  701  			   DRM_BRIDGE_OP_EDID |
4ae2f13b217e6c Cristian Ciocaltea 2024-09-06  702  			   DRM_BRIDGE_OP_HDMI |
4ae2f13b217e6c Cristian Ciocaltea 2024-09-06  703  			   DRM_BRIDGE_OP_HPD;
4ae2f13b217e6c Cristian Ciocaltea 2024-09-06  704  	hdmi->bridge.of_node = pdev->dev.of_node;
4ae2f13b217e6c Cristian Ciocaltea 2024-09-06  705  	hdmi->bridge.type = DRM_MODE_CONNECTOR_HDMIA;
4ae2f13b217e6c Cristian Ciocaltea 2024-09-06  706  	hdmi->bridge.vendor = "Synopsys";
4ae2f13b217e6c Cristian Ciocaltea 2024-09-06  707  	hdmi->bridge.product = "DW HDMI QP TX";
4ae2f13b217e6c Cristian Ciocaltea 2024-09-06  708  
4ae2f13b217e6c Cristian Ciocaltea 2024-09-06  709  	hdmi->bridge.ddc = dw_hdmi_qp_i2c_adapter(hdmi);
4ae2f13b217e6c Cristian Ciocaltea 2024-09-06  710  	if (IS_ERR(hdmi->bridge.ddc))
4ae2f13b217e6c Cristian Ciocaltea 2024-09-06  711  		hdmi->bridge.ddc = NULL;
4ae2f13b217e6c Cristian Ciocaltea 2024-09-06  712  
4ae2f13b217e6c Cristian Ciocaltea 2024-09-06  713  	ret = devm_drm_bridge_add(dev, &hdmi->bridge);
4ae2f13b217e6c Cristian Ciocaltea 2024-09-06  714  	if (ret)
4ae2f13b217e6c Cristian Ciocaltea 2024-09-06  715  		return ERR_PTR(ret);
4ae2f13b217e6c Cristian Ciocaltea 2024-09-06  716  
4ae2f13b217e6c Cristian Ciocaltea 2024-09-06  717  	ret = drm_bridge_attach(encoder, &hdmi->bridge, NULL,
4ae2f13b217e6c Cristian Ciocaltea 2024-09-06  718  				DRM_BRIDGE_ATTACH_NO_CONNECTOR);
4ae2f13b217e6c Cristian Ciocaltea 2024-09-06  719  	if (ret)
4ae2f13b217e6c Cristian Ciocaltea 2024-09-06  720  		return ERR_PTR(ret);
4ae2f13b217e6c Cristian Ciocaltea 2024-09-06  721  
4ae2f13b217e6c Cristian Ciocaltea 2024-09-06  722  	return hdmi;
4ae2f13b217e6c Cristian Ciocaltea 2024-09-06  723  }
4ae2f13b217e6c Cristian Ciocaltea 2024-09-06  724  EXPORT_SYMBOL_GPL(dw_hdmi_qp_bind);
4ae2f13b217e6c Cristian Ciocaltea 2024-09-06  725  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

