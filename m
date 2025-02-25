Return-Path: <linux-kernel+bounces-532584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BB2A44F8A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 23:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3682B19C24FA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 22:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0AA2210180;
	Tue, 25 Feb 2025 22:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="mYYa5x6n"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D8E19415E
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 22:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740521272; cv=none; b=iGnL8Xf/sA//jexgCoHnMico4k7uUyshjCoyhcqL2654Z2fcCdRSbsN9sOuAOC3lXC+m/G8sLQmrmmQdnqvO3OSOpXkErBPUqyXuB2xmvyLQCZuYRVWRX91jM+XsW6aHnWu0ko2eFVnb+hGX86cua9lq0Q6/CuaOrstqPqhk3KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740521272; c=relaxed/simple;
	bh=ba0j2m9trbko/enX/FXNnTMvVwBjeGanAzmodk9Ois4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VuEnV0aoXHNxQjFPpiU0Ri+CQVeStoQ3Z5DBj2hYKgQkUCOxhus1cQrRwrliX4h6cbzz2B7zRZEYbZQhaCRGe1DRBNayIh/mueEKMrVhhdeRiFbDsE/+0yR+KlYPQabepsBN2uJG5OD27rKojASLl08xsnXD8C8KdrCmlbbcq2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=mYYa5x6n; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9y5sTKYEXLQagcrQ08sowh0qtFj8xpcMz2E6G6v/6/w=; b=mYYa5x6nqhBuI09Hs4BwIXoyme
	BEl+PH9xRCyB3e6jQJu2QydrZ6WGmEeLV29u7ZUKGy9aErUM8gIQTLHJZl2JzfPCMatot48tIF9MZ
	TqGoegyZqDL6BgKJekpCqJyCq+AItqpL1WUrBYyMaXhqhA1vxJvR2bkONd5LzuML6iJj2LplatPok
	XYfWpaewm0Ovlg6pXQvkTNsjuKvSYg9VXKxfyg6hgRuiZkUDQ/PfHGuhxBkFnBeNGs313a/p7EZW2
	CyELE4ZinuHnn2toOFlBM8b7i30e2U/n6DfMvlDztb1JF4Wi4w9YKlJXqd49kkjnMjEUqGAGIiZci
	G6B68apQ==;
Received: from i53875b47.versanet.de ([83.135.91.71] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tn35c-0008Bd-Ut; Tue, 25 Feb 2025 23:07:44 +0100
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: vkoul@kernel.org, kishon@kernel.org
Cc: linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 quentin.schulz@cherry.de, sebastian.reichel@collabora.com,
 Heiko Stuebner <heiko.stuebner@cherry.de>
Subject:
 Re: [PATCH 2/2] phy: rockchip: usbdp: re-init the phy on orientation-change
Date: Tue, 25 Feb 2025 23:07:44 +0100
Message-ID: <10951990.zapYfy813O@diego>
In-Reply-To: <20250225184519.3586926-3-heiko@sntech.de>
References:
 <20250225184519.3586926-1-heiko@sntech.de>
 <20250225184519.3586926-3-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Am Dienstag, 25. Februar 2025, 19:45:19 MEZ schrieb Heiko Stuebner:
> diff --git a/drivers/phy/rockchip/phy-rockchip-usbdp.c b/drivers/phy/rockchip/phy-rockchip-usbdp.c
> index 7b17c82ebcfc..b63259a90d85 100644
> --- a/drivers/phy/rockchip/phy-rockchip-usbdp.c
> +++ b/drivers/phy/rockchip/phy-rockchip-usbdp.c
> @@ -1277,6 +1277,7 @@ static int rk_udphy_orien_sw_set(struct typec_switch_dev *sw,
>  				 enum typec_orientation orien)
>  {
>  	struct rk_udphy *udphy = typec_switch_get_drvdata(sw);
> +	int ret = 0;
>  
>  	mutex_lock(&udphy->mutex);
>  
> @@ -1292,6 +1293,12 @@ static int rk_udphy_orien_sw_set(struct typec_switch_dev *sw,
>  	rk_udphy_set_typec_default_mapping(udphy);
>  	rk_udphy_usb_bvalid_enable(udphy, true);
>  
> +	/* re-init the phy if already on */
> +	if (udphy->status != UDPHY_MODE_NONE) {
> +		rk_udphy_disable(udphy);
> +		ret = rk_udphy_setup(udphy);
> +	}
> +

just realized that 

	if (udphy->status != UDPHY_MODE_NONE)
		ret = rk_udphy_init(udphy);

does the same, and we really don't need to disable and re-enable the
phy's clocks that are the added via rk_udphy_disable and _setup.

So will give it a day and send a v2 then.


Heiko



