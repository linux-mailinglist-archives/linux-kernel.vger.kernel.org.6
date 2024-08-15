Return-Path: <linux-kernel+bounces-288262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2F8953809
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 18:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BFB41C2128E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 16:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5441B29A9;
	Thu, 15 Aug 2024 16:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="y/mgYsQz"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FB11AC89F
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 16:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723738381; cv=none; b=fgEDCIVW1VXROtBTEK7WuD260dLTYbG+02Ac5GkAISFY5xyVK0jDMPpgIIecdKoTC5LFhFsLoyIxoyZiLxTW9Bycr7QsUC1g+PDHDo0ituHzwjChf9VsZaHTr0/+3Iket5EaC4fkd5ISzosY2DbIcnFCACJPZ6L+gYKjJuhSd4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723738381; c=relaxed/simple;
	bh=GBcFGVUeVA5D/CrjFjXzZnJNgb26b2nvgdXx03lZUo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UnEytzBz06woU2DRFgnIzK53eZhyot8JvsXTtFmsAMkei3GAizF9vA8GqwIPZrkBCddgL8LQ8mBXKc4ZCd5ss200+HEKH729Pu18ds7IdNHDt9R9OZ7B+KvnDmiHznJSrRoKYVrTtpYnoVQ5s2kL18+44NPxcVpvqF4a1bbkT6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=y/mgYsQz; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/+Gq5JqbMy1Ohz5FGdcJwbNyFqGLttXx8PyGPZaul8c=; b=y/mgYsQzJGaqPJP0WAZ2WUBVDL
	JquQwfK8Y8T21O0vy3IlMBc1Ib4g10MVY713tLJJ7asTjmdOJ1N6V2gO7e8qHmICD4C6AxGn2xOSH
	bd+IkJmC305GG9v8V5Y8Py/NUHSFNJrAcpNzJJCS6+RNl2kHTi+mJHRUUvbYCdRh9Uaesq4M4FsdM
	+x+HtclWRw9qtiuRrWCNH4QLNFpHoV8JIuuYjU2AbB6FkFBhWE91o8ZL/A/xkxqOKGUlaVocAtIgq
	jnYLRJXt0tcyyVeDWsKKJkZOFQfKA/SqQu8TPygXtS8r4eBafY1lzKv9CRq3wP1PUizesjbJLQCQh
	mn0xdG6g==;
Received: from i53875a9f.versanet.de ([83.135.90.159] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sed5l-00056j-5O; Thu, 15 Aug 2024 18:12:49 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: linux-rockchip@lists.infradead.org, linux-phy@lists.infradead.org,
 Dragan Simic <dsimic@manjaro.org>
Cc: vkoul@kernel.org, kishon@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH] phy: phy-rockchip-inno-usb2: Handle failed extcon allocation
 better
Date: Thu, 15 Aug 2024 18:12:48 +0200
Message-ID: <4927264.xgNZFEDtJV@diego>
In-Reply-To:
 <5fa7796d71e2f46344e972bc98a54539f55b6109.1723551599.git.dsimic@manjaro.org>
References:
 <5fa7796d71e2f46344e972bc98a54539f55b6109.1723551599.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Dienstag, 13. August 2024, 20:38:17 CEST schrieb Dragan Simic:
> Return the actual error code upon failure to allocate extcon device, instead
> of hardcoding -ENOMEM.  While there, produce an appropriate error message.
> 
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> ---
>  drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> index 4f71373ae6e1..d33418a1e7a8 100644
> --- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> +++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> @@ -434,8 +434,10 @@ static int rockchip_usb2phy_extcon_register(struct rockchip_usb2phy *rphy)
>  		edev = devm_extcon_dev_allocate(rphy->dev,
>  						rockchip_usb2phy_extcon_cable);
>  
> -		if (IS_ERR(edev))
> -			return -ENOMEM;
> +		if (IS_ERR(edev)) {
> +			dev_err(rphy->dev, "failed to allocate extcon device\n");
> +			return PTR_ERR(edev);
> +		}

maybe even use dev_err_probe?

rockchip_usb2phy_extcon_register() gets called from the probe function,
so even using it is also sematically correct ;-) .


Heiko

>  
>  		ret = devm_extcon_dev_register(rphy->dev, edev);
>  		if (ret) {
> 





