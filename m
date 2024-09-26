Return-Path: <linux-kernel+bounces-340355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 490CC9871F9
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 12:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BE5D1C210A0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 10:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992181AD9F1;
	Thu, 26 Sep 2024 10:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="JRhBS/GN"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B421F95C;
	Thu, 26 Sep 2024 10:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727347724; cv=none; b=QVl+Jao0byAD06XUich2pbawRm6QudO+NY1ibzjm6rvHA1acROIlQUg2XCTjjnBGrzfRZck5BiXYV6ovD01O6cg8CcH3j/xYqX9F3rLspZfz/+mVEJ4wlN6P14bqylAHWI7MpBCyi1pjehulCq4YvOQWvvwo3keowlelIPiTjDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727347724; c=relaxed/simple;
	bh=I+cQCruRtcbgvl2B5ua7+vEXO+xfL7ptucecZqP1qrY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=poQ+QNX/nT+/p7vDKlpVLVU7PzJSHEvAhyCmKSy2HPIKNxGyXYHKmt8oiBLIVasl38A7gj12EEScL0vE4AmwElJyiwY93KSiOPmCNdKW8oAivdgNtcLmvzavVOMGb8yfR1R4aOxILNxxN8/vdHrVNMuUF0lYf+AxzoXWn41ksl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=JRhBS/GN; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ZXkf1wTdQhc/mYJKrKkTTXfk+s8Dy/Zc2oNs+XEaIEY=; b=JRhBS/GNZFIjJaYKgT9LpIVjGR
	Q9hFSbGvviFL+Zz5W355wtych5DzSBE2HiGSl+g+puZoiepARAau0zZEETJ7Sqn6uk7wbiBO3MvRC
	P8PnUkUOUP142QZ9bS42bZ2Po51jpUZ+ryW+ghO3vnbk6MJN5gByaZQQtzu0O/cHDu2NN+bbYOrWc
	WH02heJDAZtBUJI2byDL29nDsERDMfGOaXG3Pcu8c5YI5fTxbCAfvKVThr/RLsAVT2DVSaxIbmDOf
	GENzq2Of53KrmyTZ8Jp/7E8EVn+pT9+M3LvQxa+pGgBgHr7wFf4DwiFSDzl3t2Rtgmoh9WDelnq2q
	4f3Ea9QA==;
Received: from 85-160-70-253.reb.o2.cz ([85.160.70.253] helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1stm34-0002XP-12; Thu, 26 Sep 2024 12:48:38 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, Frank Wang <frawang.cn@gmail.com>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, william.wu@rock-chips.com,
 tim.chen@rock-chips.com, frank.wang@rock-chips.com
Subject:
 Re: [PATCH v3 2/2] phy: rockchip: inno-usb2: Add usb2 phys support for rk3576
Date: Thu, 26 Sep 2024 12:48:36 +0200
Message-ID: <10867555.aFP6jjVeTY@phil>
In-Reply-To: <20240926103223.29538-2-frawang.cn@gmail.com>
References:
 <20240926103223.29538-1-frawang.cn@gmail.com>
 <20240926103223.29538-2-frawang.cn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Donnerstag, 26. September 2024, 12:32:23 CEST schrieb Frank Wang:
> From: William Wu <william.wu@rock-chips.com>
> 
> The RK3576 SoC has two independent USB2.0 PHYs, and each PHY has
> one port.
> 
> This change also converts the clock management from single to bulk
> as some Rockchip SoCs (e.g RK3576) have more than one clock.
> 
> Signed-off-by: William Wu <william.wu@rock-chips.com>
> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
> ---
> Changelog:
> v3:
>  - amend the commit log adds clocks converting.
>  - retrieve the clock by "clks.id" in *_clk480m_register() function.
> 
> v2:
>  - no changes.
> v1:
>  - https://patchwork.kernel.org/project/linux-phy/patch/20240923025326.10467-2-frank.wang@rock-chips.com/
> 
>  drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 139 +++++++++++++++++-
>  1 file changed, 131 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> index 4f71373ae6e1..642c7857c5ae 100644
> --- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> +++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> @@ -229,9 +229,10 @@ struct rockchip_usb2phy_port {
>   * @dev: pointer to device.
>   * @grf: General Register Files regmap.
>   * @usbgrf: USB General Register Files regmap.
> - * @clk: clock struct of phy input clk.
> + * @clks: array of phy input clocks.
>   * @clk480m: clock struct of phy output clk.
>   * @clk480m_hw: clock struct of phy output clk management.
> + * @num_clks: number of phy input clocks.
>   * @phy_reset: phy reset control.
>   * @chg_state: states involved in USB charger detection.
>   * @chg_type: USB charger types.
> @@ -246,9 +247,10 @@ struct rockchip_usb2phy {
>  	struct device	*dev;
>  	struct regmap	*grf;
>  	struct regmap	*usbgrf;
> -	struct clk	*clk;
> +	struct clk_bulk_data	*clks;
>  	struct clk	*clk480m;
>  	struct clk_hw	clk480m_hw;
> +	int			num_clks;
>  	struct reset_control	*phy_reset;
>  	enum usb_chg_state	chg_state;
>  	enum power_supply_type	chg_type;
> @@ -376,7 +378,9 @@ rockchip_usb2phy_clk480m_register(struct rockchip_usb2phy *rphy)
>  {
>  	struct device_node *node = rphy->dev->of_node;
>  	struct clk_init_data init;
> +	struct clk *refclk = NULL;
>  	const char *clk_name;
> +	int i;
>  	int ret = 0;
>  
>  	init.flags = 0;
> @@ -386,8 +390,15 @@ rockchip_usb2phy_clk480m_register(struct rockchip_usb2phy *rphy)
>  	/* optional override of the clockname */
>  	of_property_read_string(node, "clock-output-names", &init.name);
>  
> -	if (rphy->clk) {
> -		clk_name = __clk_get_name(rphy->clk);
> +	for (i = 0; i < rphy->num_clks; i++) {
> +		if (!strncmp(rphy->clks[i].id, "phyclk", 6)) {
> +			refclk = rphy->clks[i].clk;
> +			break;
> +		}
> +	}
> +
> +	if (!IS_ERR(refclk)) {
> +		clk_name = __clk_get_name(refclk);
>  		init.parent_names = &clk_name;
>  		init.num_parents = 1;
>  	} else {
> @@ -1406,22 +1417,29 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
>  	if (IS_ERR(rphy->phy_reset))
>  		return PTR_ERR(rphy->phy_reset);
>  
> -	rphy->clk = devm_clk_get_optional_enabled(dev, "phyclk");
> -	if (IS_ERR(rphy->clk)) {
> -		return dev_err_probe(&pdev->dev, PTR_ERR(rphy->clk),
> +	ret = devm_clk_bulk_get_all(dev, &rphy->clks);
> +	if (ret == -EPROBE_DEFER) {
> +		return dev_err_probe(&pdev->dev, -EPROBE_DEFER,
>  				     "failed to get phyclk\n");
>  	}
>  
> +	/* Clocks are optional */
> +	rphy->num_clks = ret < 0 ? 0 : ret;
> +
>  	ret = rockchip_usb2phy_clk480m_register(rphy);
>  	if (ret) {
>  		dev_err(dev, "failed to register 480m output clock\n");
>  		return ret;
>  	}
>  
> +	ret = clk_bulk_prepare_enable(rphy->num_clks, rphy->clks);
> +	if (ret)
> +		return ret;
> +

Do you actually need that separate enable step?
There exists devm_clk_bulk_get_all_enable() 

https://elixir.bootlin.com/linux/v6.11/source/include/linux/clk.h#L511

which you could use above. Especially as otherwise you'd need a remove
callback to disable the clock on driver unbind?


>  	if (rphy->phy_cfg->phy_tuning) {
>  		ret = rphy->phy_cfg->phy_tuning(rphy);
>  		if (ret)
> -			return ret;
> +			goto disable_clks;
>  	}
>  
>  	index = 0;
> @@ -1484,6 +1502,8 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
>  
>  put_child:
>  	of_node_put(child_np);
> +disable_clks:
> +	clk_bulk_disable_unprepare(rphy->num_clks, rphy->clks);
>  	return ret;
>  }
>  
> @@ -1495,6 +1515,30 @@ static int rk3128_usb2phy_tuning(struct rockchip_usb2phy *rphy)
>  				BIT(2) << BIT_WRITEABLE_SHIFT | 0);
>  }


I still maintain, that this maybe should be two separate patches.
And you even seem to have nice "cut-here" in it ;-)

The code above converts the driver to use clk_bulk to handle
multiple clocks for controller variants needing it.


And the code below adds the rk3576-specific data to the driver.



> +static int rk3576_usb2phy_tuning(struct rockchip_usb2phy *rphy)
> +{
> +	int ret;
> +	u32 reg = rphy->phy_cfg->reg;
> +
> +	/* Deassert SIDDQ to power on analog block */
> +	ret = regmap_write(rphy->grf, reg + 0x0010, GENMASK(29, 29) | 0x0000);
> +	if (ret)
> +		return ret;
> +
> +	/* Do reset after exit IDDQ mode */
> +	ret = rockchip_usb2phy_reset(rphy);
> +	if (ret)
> +		return ret;
> +
> +	/* HS DC Voltage Level Adjustment 4'b1001 : +5.89% */
> +	ret |= regmap_write(rphy->grf, reg + 0x000c, GENMASK(27, 24) | 0x0900);
> +
> +	/* HS Transmitter Pre-Emphasis Current Control 2'b10 : 2x */
> +	ret |= regmap_write(rphy->grf, reg + 0x0010, GENMASK(20, 19) | 0x0010);
> +
> +	return ret;
> +}
> +
>  static int rk3588_usb2phy_tuning(struct rockchip_usb2phy *rphy)
>  {
>  	int ret;
> @@ -1923,6 +1967,84 @@ static const struct rockchip_usb2phy_cfg rk3568_phy_cfgs[] = {
>  	{ /* sentinel */ }
>  };
>  
> +static const struct rockchip_usb2phy_cfg rk3576_phy_cfgs[] = {
> +	{
> +		.reg = 0x0,
> +		.num_ports	= 1,
> +		.phy_tuning	= rk3576_usb2phy_tuning,
> +		.clkout_ctl	= { 0x0008, 0, 0, 1, 0 },
> +		.port_cfgs	= {
> +			[USB2PHY_PORT_OTG] = {
> +				.phy_sus	= { 0x0000, 8, 0, 0, 0x1d1 },
> +				.bvalid_det_en	= { 0x00c0, 1, 1, 0, 1 },
> +				.bvalid_det_st	= { 0x00c4, 1, 1, 0, 1 },
> +				.bvalid_det_clr = { 0x00c8, 1, 1, 0, 1 },
> +				.ls_det_en	= { 0x00c0, 0, 0, 0, 1 },
> +				.ls_det_st	= { 0x00c4, 0, 0, 0, 1 },
> +				.ls_det_clr	= { 0x00c8, 0, 0, 0, 1 },
> +				.disfall_en	= { 0x00c0, 6, 6, 0, 1 },
> +				.disfall_st	= { 0x00c4, 6, 6, 0, 1 },
> +				.disfall_clr	= { 0x00c8, 6, 6, 0, 1 },
> +				.disrise_en	= { 0x00c0, 5, 5, 0, 1 },
> +				.disrise_st	= { 0x00c4, 5, 5, 0, 1 },
> +				.disrise_clr	= { 0x00c8, 5, 5, 0, 1 },
> +				.utmi_avalid	= { 0x0080, 1, 1, 0, 1 },
> +				.utmi_bvalid	= { 0x0080, 0, 0, 0, 1 },
> +				.utmi_ls	= { 0x0080, 5, 4, 0, 1 },
> +			}
> +		},
> +		.chg_det = {
> +			.cp_det		= { 0x0080, 8, 8, 0, 1 },
> +			.dcp_det	= { 0x0080, 8, 8, 0, 1 },
> +			.dp_det		= { 0x0080, 9, 9, 1, 0 },
> +			.idm_sink_en	= { 0x0010, 5, 5, 1, 0 },
> +			.idp_sink_en	= { 0x0010, 5, 5, 0, 1 },
> +			.idp_src_en	= { 0x0010, 14, 14, 0, 1 },
> +			.rdm_pdwn_en	= { 0x0010, 14, 14, 0, 1 },
> +			.vdm_src_en	= { 0x0010, 7, 6, 0, 3 },
> +			.vdp_src_en	= { 0x0010, 7, 6, 0, 3 },
> +		},
> +	},
> +	{
> +		.reg = 0x2000,
> +		.num_ports	= 1,
> +		.phy_tuning	= rk3576_usb2phy_tuning,
> +		.clkout_ctl	= { 0x2008, 0, 0, 1, 0 },
> +		.port_cfgs	= {
> +			[USB2PHY_PORT_OTG] = {
> +				.phy_sus	= { 0x2000, 8, 0, 0, 0x1d1 },
> +				.bvalid_det_en	= { 0x20c0, 1, 1, 0, 1 },
> +				.bvalid_det_st	= { 0x20c4, 1, 1, 0, 1 },
> +				.bvalid_det_clr = { 0x20c8, 1, 1, 0, 1 },
> +				.ls_det_en	= { 0x20c0, 0, 0, 0, 1 },
> +				.ls_det_st	= { 0x20c4, 0, 0, 0, 1 },
> +				.ls_det_clr	= { 0x20c8, 0, 0, 0, 1 },
> +				.disfall_en	= { 0x20c0, 6, 6, 0, 1 },
> +				.disfall_st	= { 0x20c4, 6, 6, 0, 1 },
> +				.disfall_clr	= { 0x20c8, 6, 6, 0, 1 },
> +				.disrise_en	= { 0x20c0, 5, 5, 0, 1 },
> +				.disrise_st	= { 0x20c4, 5, 5, 0, 1 },
> +				.disrise_clr	= { 0x20c8, 5, 5, 0, 1 },
> +				.utmi_avalid	= { 0x2080, 1, 1, 0, 1 },
> +				.utmi_bvalid	= { 0x2080, 0, 0, 0, 1 },
> +				.utmi_ls	= { 0x2080, 5, 4, 0, 1 },
> +			}
> +		},
> +		.chg_det = {
> +			.cp_det		= { 0x2080, 8, 8, 0, 1 },
> +			.dcp_det	= { 0x2080, 8, 8, 0, 1 },
> +			.dp_det		= { 0x2080, 9, 9, 1, 0 },
> +			.idm_sink_en	= { 0x2010, 5, 5, 1, 0 },
> +			.idp_sink_en	= { 0x2010, 5, 5, 0, 1 },
> +			.idp_src_en	= { 0x2010, 14, 14, 0, 1 },
> +			.rdm_pdwn_en	= { 0x2010, 14, 14, 0, 1 },
> +			.vdm_src_en	= { 0x2010, 7, 6, 0, 3 },
> +			.vdp_src_en	= { 0x2010, 7, 6, 0, 3 },
> +		},
> +	},
> +	{ /* sentinel */ }
> +};
> +
>  static const struct rockchip_usb2phy_cfg rk3588_phy_cfgs[] = {
>  	{
>  		.reg = 0x0000,
> @@ -2094,6 +2216,7 @@ static const struct of_device_id rockchip_usb2phy_dt_match[] = {
>  	{ .compatible = "rockchip,rk3366-usb2phy", .data = &rk3366_phy_cfgs },
>  	{ .compatible = "rockchip,rk3399-usb2phy", .data = &rk3399_phy_cfgs },
>  	{ .compatible = "rockchip,rk3568-usb2phy", .data = &rk3568_phy_cfgs },
> +	{ .compatible = "rockchip,rk3576-usb2phy", .data = &rk3576_phy_cfgs },
>  	{ .compatible = "rockchip,rk3588-usb2phy", .data = &rk3588_phy_cfgs },
>  	{ .compatible = "rockchip,rv1108-usb2phy", .data = &rv1108_phy_cfgs },
>  	{}
> 





