Return-Path: <linux-kernel+bounces-363309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABFF199C064
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 08:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77CBF281C7B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 06:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8646D1448C7;
	Mon, 14 Oct 2024 06:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="E8v1l2Vk"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD1C13A24D;
	Mon, 14 Oct 2024 06:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728888665; cv=none; b=CsTJAKjKwFeLWm3q708giYF4Fiwcrh5kCgXcfafjmeL8Ah8TRNp68gX2bTvTUMQ0UKda6jyU22e6C/BTpCnNvWM2KIQBlIn9dMsZIBYNKpkS0/9bXSWHLkii+T0bw1nA49VX4kplPNBXDyTCMSEf9mFtluWjRHLb8fy7uwED1RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728888665; c=relaxed/simple;
	bh=6b8oLxcs9H9SAwiBm6vrXA0N5GfD9SIv1m9TpwWOC20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QFpUcCOsweLO/VeyjRAJ6f3pHQvJHGtEyBf07oOnSijrLaZIDY1VkMHaA5fYqFjojV+KaIJLXvTuWSOLz+k160muUcCDJlXeQbLcjjJdGDZCbgOhIi5QX5mNrUxXrg+AfsLio/RNyi2euvNGc6lwPwYf2JxXj7BasZxaXLeJWoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=E8v1l2Vk; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bDIJc0lzPWFuK32g4GsXmjt7r9miciNd9/zrnLYf/jQ=; b=E8v1l2Vk8bPbWumsFcQAJiVwME
	rnrK+33WV59LVA3WiXWQHpnWVLMlOiLK5r3sLOJlDiJ1sWT/6cTtMijybEkBzPiqNijepaEbGRnoz
	klaB+0dKyA1E7oLoT0FlW18xetZ00+U/1KnsnledyT7x7SwnbJmwm3O1TnX/gz9nCLcNEEUKZbh8p
	V0xGc46QoHsArYKdf/EJx4fZ4tK/RmcDLd9hqhc9CMYveJA/GrOfBBBp8KRFq0HEs1lG0NyuaODAv
	4e5Bxmr44e3L/TAZl36plB+YQhpa0qBxsMyNBLCWlRBu9vELtoCALZgDQLRgMu0JAKpyd9ZhRltNY
	+FhJISbw==;
Received: from i53875b34.versanet.de ([83.135.91.52] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1t0Euz-0005Vq-2C; Mon, 14 Oct 2024 08:51:01 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, Frank Wang <frawang.cn@gmail.com>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, william.wu@rock-chips.com,
 tim.chen@rock-chips.com, yubing.zhang@rock-chips.com,
 Frank Wang <frank.wang@rock-chips.com>
Subject: Re: [PATCH 2/2] phy: rockchip: usbdp: add rk3576 device match data
Date: Mon, 14 Oct 2024 08:50:59 +0200
Message-ID: <13616137.uLZWGnKmhe@diego>
In-Reply-To: <20241014020342.15974-2-frawang.cn@gmail.com>
References:
 <20241014020342.15974-1-frawang.cn@gmail.com>
 <20241014020342.15974-2-frawang.cn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Montag, 14. Oktober 2024, 04:03:42 CEST schrieb Frank Wang:
> From: Frank Wang <frank.wang@rock-chips.com>
> 
> This adds RK3576 device match data support.
> 
> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>

Nice, that the rk3576 support fits in so easily :-)

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

> ---
>  drivers/phy/rockchip/phy-rockchip-usbdp.c | 41 +++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/drivers/phy/rockchip/phy-rockchip-usbdp.c b/drivers/phy/rockchip/phy-rockchip-usbdp.c
> index 2c51e5c62d3e..5b1e8a3806ed 100644
> --- a/drivers/phy/rockchip/phy-rockchip-usbdp.c
> +++ b/drivers/phy/rockchip/phy-rockchip-usbdp.c
> @@ -1538,6 +1538,43 @@ static const char * const rk_udphy_rst_list[] = {
>  	"init", "cmn", "lane", "pcs_apb", "pma_apb"
>  };
>  
> +static const struct rk_udphy_cfg rk3576_udphy_cfgs = {
> +	.num_phys = 1,
> +	.phy_ids = { 0x2b010000 },
> +	.num_rsts = ARRAY_SIZE(rk_udphy_rst_list),
> +	.rst_list = rk_udphy_rst_list,
> +	.grfcfg	= {
> +		/* u2phy-grf */
> +		.bvalid_phy_con		= RK_UDPHY_GEN_GRF_REG(0x0010, 1, 0, 0x2, 0x3),
> +		.bvalid_grf_con		= RK_UDPHY_GEN_GRF_REG(0x0000, 15, 14, 0x1, 0x3),
> +
> +		/* usb-grf */
> +		.usb3otg0_cfg		= RK_UDPHY_GEN_GRF_REG(0x0030, 15, 0, 0x1100, 0x0188),
> +
> +		/* usbdpphy-grf */
> +		.low_pwrn		= RK_UDPHY_GEN_GRF_REG(0x0004, 13, 13, 0, 1),
> +		.rx_lfps		= RK_UDPHY_GEN_GRF_REG(0x0004, 14, 14, 0, 1),
> +	},
> +	.vogrfcfg = {
> +		{
> +			.hpd_trigger	= RK_UDPHY_GEN_GRF_REG(0x0000, 11, 10, 1, 3),
> +			.dp_lane_reg    = 0x0000,
> +		},
> +	},
> +	.dp_tx_ctrl_cfg = {
> +		rk3588_dp_tx_drv_ctrl_rbr_hbr_typec,
> +		rk3588_dp_tx_drv_ctrl_rbr_hbr_typec,
> +		rk3588_dp_tx_drv_ctrl_hbr2,
> +		rk3588_dp_tx_drv_ctrl_hbr3,
> +	},
> +	.dp_tx_ctrl_cfg_typec = {
> +		rk3588_dp_tx_drv_ctrl_rbr_hbr_typec,
> +		rk3588_dp_tx_drv_ctrl_rbr_hbr_typec,
> +		rk3588_dp_tx_drv_ctrl_hbr2,
> +		rk3588_dp_tx_drv_ctrl_hbr3,
> +	},
> +};
> +
>  static const struct rk_udphy_cfg rk3588_udphy_cfgs = {
>  	.num_phys = 2,
>  	.phy_ids = {
> @@ -1584,6 +1621,10 @@ static const struct rk_udphy_cfg rk3588_udphy_cfgs = {
>  };
>  
>  static const struct of_device_id rk_udphy_dt_match[] = {
> +	{
> +		.compatible = "rockchip,rk3576-usbdp-phy",
> +		.data = &rk3576_udphy_cfgs
> +	},
>  	{
>  		.compatible = "rockchip,rk3588-usbdp-phy",
>  		.data = &rk3588_udphy_cfgs
> 





