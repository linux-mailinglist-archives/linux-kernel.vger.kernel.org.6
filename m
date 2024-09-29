Return-Path: <linux-kernel+bounces-343136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB7598971E
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 21:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39FDEB220EB
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 19:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDC874059;
	Sun, 29 Sep 2024 19:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PM4nIeh4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B411EA84;
	Sun, 29 Sep 2024 19:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727638696; cv=none; b=uQk2ThgkaXmbURi8PudeDXu0FsVy5SGHHhFsifnbHlGNrnT27l5QpWwFBr/mXrUAvI0rkqBFwlYxtPhbsCo59MFrDwFyGzFyXX4LjOtSsmKIK4lfjkW36dm1Gq0NWRpx4TkB14wncU2lb8mXxP0TgMXIOZTqM+58Y4IRaZZKGIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727638696; c=relaxed/simple;
	bh=Gwtszj5Nk759k9PZ2OEt04obFCWbH2CndmW7h6sywWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A/8L/F8RBtWtfhpyPbIaa8r86K5JG44cSydExkQLBP0xiRvFV4Xn+jtsl2bk/otyXCaLNivY37hCjQw2BT0CZs7jZtxCOgxdEjecWGKiS6nxlNJksqcyv5JowIsDYQATSNJfJSZIDvfmu6qMKCt4WDPdvJZxKGniUQNEXHo7ov8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PM4nIeh4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36016C4CEC5;
	Sun, 29 Sep 2024 19:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727638696;
	bh=Gwtszj5Nk759k9PZ2OEt04obFCWbH2CndmW7h6sywWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PM4nIeh4tSMrUdjBaRa7EO+aHT+o5nET9fptg9WxWpnBXKGRR0sEsFvrEb+xV2+QL
	 uAstDXDO0IiOQ+gI3wseh2m4WVVK57KlDukySnGh+Y7xHpQg0Qrbzi6cFAClLYbC0W
	 w5KeO/iq4Xtuhob2563mQGoLdZ9atNrF+Gtv0oFC1fuacGWLLTOllrDZ9Ja/jTiHVp
	 eCZWxZdqKe4cicY0frmV+YIG+LQA7YJ4a06isnbPeSDulMnwqIzP3f9s+w9qnnWiM5
	 9mzB5VxbBVKxhkJrD6tDsqksk0JEkJOhUpqNrR+yyAE8RJ8B12T6eDCsLVcjFcU9WR
	 mvAEsS8FuQZXQ==
Date: Sun, 29 Sep 2024 21:38:12 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Frank Wang <frawang.cn@gmail.com>
Cc: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de, 
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, william.wu@rock-chips.com, 
	tim.chen@rock-chips.com, frank.wang@rock-chips.com
Subject: Re: [PATCH v4 1/3] phy: rockchip: inno-usb2: convert clock
 management to bulk
Message-ID: <jx55slsincpzq6mugfsyc6qpbku2555azj7lithwggo733ggnb@rkqsxpsyoaw7>
References: <20240929061025.3704-1-frawang.cn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240929061025.3704-1-frawang.cn@gmail.com>

On Sun, Sep 29, 2024 at 02:10:23PM +0800, Frank Wang wrote:
> From: Frank Wang <frank.wang@rock-chips.com>
> 
> Since some Rockchip SoCs (e.g RK3576) have more than one clock,
> this converts the clock management from single to bulk method to
> make the driver more flexible.
> 
> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
> ---
> Changelog:
> v4:
>  - a new patch split from the [PATCH v3 2/2], suggestions from Heiko.
> 
> v1-v3:
>  - none
> 
>  drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 43 ++++++++++++++++---
>  1 file changed, 36 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> index 4f71373ae6e1..ad3e65dc6aa4 100644
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
> @@ -1406,18 +1424,29 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
>  	if (IS_ERR(rphy->phy_reset))
>  		return PTR_ERR(rphy->phy_reset);
>  
> -	rphy->clk = devm_clk_get_optional_enabled(dev, "phyclk");
> -	if (IS_ERR(rphy->clk)) {
> -		return dev_err_probe(&pdev->dev, PTR_ERR(rphy->clk),
> +	ret = devm_clk_bulk_get_all(dev, &rphy->clks);
> +	if (ret == -EPROBE_DEFER) {

This does not make much sense. Why would you proceed on other critical
errors?

You want to use optional variant, I guess?

Best regards,
Krzysztof


