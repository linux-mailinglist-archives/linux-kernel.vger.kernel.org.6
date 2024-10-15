Return-Path: <linux-kernel+bounces-365139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 378D699DE12
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 08:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBFAA1F22FE2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 06:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ACF417BEC1;
	Tue, 15 Oct 2024 06:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="feUZKtsv"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D851591EA;
	Tue, 15 Oct 2024 06:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728973122; cv=none; b=gOt+TZJlKAwReGmDXz8dZa4mFONqvb71BDoWiTaSjF6smlcBH4nKFG0OdVqrz+zw5r+fz31TDQgyr/hu/8ULO08dI6wTAl9bmCbHzawBzKa79p5yk62SQbqB4yye5MBkocWCb63Ktq6gurXuL2r68Og6g/NuC7i+i67clHCmFE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728973122; c=relaxed/simple;
	bh=wckPShOh8c1z2tXghFfgwmWNNePjpu8s1CRMTMX25KE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UxMsjMODih7OMx7FyK23mCXy9lxRGhK35Al5rvsGK99VWmdjCCJfY6z1rVcC9OFmBxklqQ4Y17W92GwbHYev5Uu5dkrdP6TduOxv4DwObP1v8fcwUlxBlSp14R8AgKbdxLLGfc0rEf97UTrH2L2pU6Suz4OAoRcsrPsuqiqB1So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=feUZKtsv; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JpaY+/UpnGaVq4x8TJTA0HpVZD8qxzs/9fsseqNkj9Q=; b=feUZKtsvuKh+yhuVqfh83v11HJ
	sUYUknCAZz9taBlFZ4BQCV1EyhGahG5R/+TAZh65pOsue13dprVozCWU2xJ98rdlGM3Os15Sgj0Xx
	AqIuzyc0eVBwE71rlwaeZm5qEbJb2qG5ZQ0LQx7N9yKrMJd2REMpwYGLNpcE5fn9QZFJN1o77Xm0H
	lNDie8C1Uun12fI3fievMu3GsjzlOZpFjwOUS8PrLaM/ABP6lwBco61JSs1mMUs3KtL16OiTIlY7T
	ZljHsbiI+ENNbw++Zc/LL+iOGEqf0VKiFEeNA5i2Ir08Rm3iO8mOK8cUpAeiMoSXHP9ioLDlBeEwm
	B+DRkvYg==;
Received: from i53875b34.versanet.de ([83.135.91.52] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1t0atB-00074Q-Jx; Tue, 15 Oct 2024 08:18:37 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, Frank Wang <frawang.cn@gmail.com>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, william.wu@rock-chips.com,
 tim.chen@rock-chips.com, Frank Wang <frank.wang@rock-chips.com>
Subject:
 Re: [PATCH v5 1/3] phy: rockchip: inno-usb2: convert clock management to bulk
Date: Tue, 15 Oct 2024 08:18:36 +0200
Message-ID: <7721470.EvYhyI6sBW@diego>
In-Reply-To: <20241011065140.19999-1-frawang.cn@gmail.com>
References: <20241011065140.19999-1-frawang.cn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Freitag, 11. Oktober 2024, 08:51:38 CEST schrieb Frank Wang:
> From: Frank Wang <frank.wang@rock-chips.com>
> 
> Since some Rockchip SoCs (e.g RK3576) have more than one clock,
> this converts the clock management from single to bulk method to
> make the driver more flexible.
> 
> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>

thanks a lot for all the work you did on this

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

> ---
> Changelog:
> V5:
>  - use dev_err_probe() in clock enable error path in probe.
> 
> v4:
>  - a new patch split from the [PATCH v3 2/2], suggestions from Heiko.
> 
> v1-v3:
>  - none
> 
>  drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 45 +++++++++++++++----
>  1 file changed, 37 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> index 6e5214862b8a3..f71266c27091e 100644
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
> @@ -310,6 +312,13 @@ static int rockchip_usb2phy_reset(struct rockchip_usb2phy *rphy)
>  	return 0;
>  }
>  
> +static void rockchip_usb2phy_clk_bulk_disable(void *data)
> +{
> +	struct rockchip_usb2phy *rphy = data;
> +
> +	clk_bulk_disable_unprepare(rphy->num_clks, rphy->clks);
> +}
> +
>  static int rockchip_usb2phy_clk480m_prepare(struct clk_hw *hw)
>  {
>  	struct rockchip_usb2phy *rphy =
> @@ -376,7 +385,9 @@ rockchip_usb2phy_clk480m_register(struct rockchip_usb2phy *rphy)
>  {
>  	struct device_node *node = rphy->dev->of_node;
>  	struct clk_init_data init;
> +	struct clk *refclk = NULL;
>  	const char *clk_name;
> +	int i;
>  	int ret = 0;
>  
>  	init.flags = 0;
> @@ -386,8 +397,15 @@ rockchip_usb2phy_clk480m_register(struct rockchip_usb2phy *rphy)
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
> @@ -1399,15 +1417,26 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
>  	if (IS_ERR(rphy->phy_reset))
>  		return PTR_ERR(rphy->phy_reset);
>  
> -	rphy->clk = devm_clk_get_optional_enabled(dev, "phyclk");
> -	if (IS_ERR(rphy->clk))
> -		return dev_err_probe(&pdev->dev, PTR_ERR(rphy->clk),
> -				     "failed to get phyclk\n");
> +	ret = devm_clk_bulk_get_all(dev, &rphy->clks);
> +	if (ret == -EPROBE_DEFER)
> +		return dev_err_probe(&pdev->dev, -EPROBE_DEFER,
> +				     "failed to get phy clock\n");
> +
> +	/* Clocks are optional */
> +	rphy->num_clks = ret < 0 ? 0 : ret;
>  
>  	ret = rockchip_usb2phy_clk480m_register(rphy);
>  	if (ret)
>  		return dev_err_probe(dev, ret, "failed to register 480m output clock\n");
>  
> +	ret = clk_bulk_prepare_enable(rphy->num_clks, rphy->clks);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to enable phy clock\n");
> +
> +	ret = devm_add_action_or_reset(dev, rockchip_usb2phy_clk_bulk_disable, rphy);
> +	if (ret)
> +		return ret;
> +
>  	if (rphy->phy_cfg->phy_tuning) {
>  		ret = rphy->phy_cfg->phy_tuning(rphy);
>  		if (ret)
> 





