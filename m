Return-Path: <linux-kernel+bounces-571700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBCEA6C0E9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 18:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F37EC189C781
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 17:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC05522D794;
	Fri, 21 Mar 2025 17:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="q0aF4oSL"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A24322B8CF;
	Fri, 21 Mar 2025 17:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742576928; cv=none; b=c503eaRUgBCjgAq4sFZFoZYumqlLMdCM5BsgDISMn4+qGBQ7GfvbleEniZfIiVhZpZYsZ/sdxqRYmm+ynVcedjXSKLPyjcjDTNqLnItONkDpWHjQ/0Vdi6qLQ/ktO0zki4FJ2nj/ctupGN3c2VNwEUIN7V6FZGBaUPvzvya3O20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742576928; c=relaxed/simple;
	bh=ue+qpndRbnQIzc5aNIoYHd/I40V3i7kVLhxEB5EcUO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zj/r0hSJneC7iv07j1eiQRasRLZO5Jn2rEKo+IFzSHLxfW8E+QEpXl5mZw2Kq4AO29LWKWovRpMLGaEUUdbf74J2OAb/3wK2f9mxzXIJoQhLVZnq0sttVXvJl0FRy/M5fOQzs4H+/a9EwR6ie7tTwvVxJxN/gZy1sc/cQk+282A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=q0aF4oSL; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=rwsJ7KxnNGB85Kzql5aBpB16nToZe3gP5eTNRWMHdQs=; b=q0aF4oSLerS/auoS6KFBVj+xiA
	A3Mk3DHaREzMedV/GQNe5jEg4VnqUUMhmgLLTtR6HpsjffkFMU0wvA2P+MlrAma/E2v4LNn/tR+xZ
	l+zEeCTgkyPQgUmyXsi2kO63KbyGCWYqg0b/2PwwJexFRJK+AAXWjSADJtb5Mi0zmv62vCso9Yiv7
	s1npM5Siaq3ahMq8atgqnYwpJIInpKnIqomrF15Nnu4favedSObOu0OYxgOtMiZaoH+IT0WBUV1s0
	T6obiNiv4shlo6ogn5UV1LXMDSMODHLfjrkh/7uOvlEqPwHKQCQRsxL43zl1ZtYU6JNnjlEvVJtgx
	HRf67xDw==;
Received: from [192.145.10.73] (helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tvfrA-0003Qo-2G; Fri, 21 Mar 2025 18:08:28 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Heiko Stuebner <heiko.stuebner@cherry.de>,
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] phy: rockchip-samsung-dcphy: Add missing assignment
Date: Fri, 21 Mar 2025 18:08:26 +0100
Message-ID: <2181342.OBFZWjSADL@phil>
In-Reply-To: <e64265a4-9543-4728-a49f-ea910fccef7c@stanley.mountain>
References: <e64265a4-9543-4728-a49f-ea910fccef7c@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hey Dan,

Am Freitag, 21. M=C3=A4rz 2025, 15:36:14 MEZ schrieb Dan Carpenter:
> The "ret =3D " was accidentally dropped so the error handling doesn't wor=
k.
>=20
> Fixes: b2a1a2ae7818 ("phy: rockchip: Add Samsung MIPI D-/C-PHY driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

oh darn ... thanks so much for catching that

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

> ---
>  drivers/phy/rockchip/phy-rockchip-samsung-dcphy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-dcphy.c b/drivers/=
phy/rockchip/phy-rockchip-samsung-dcphy.c
> index 08c78c1bafc9..28a052e17366 100644
> --- a/drivers/phy/rockchip/phy-rockchip-samsung-dcphy.c
> +++ b/drivers/phy/rockchip/phy-rockchip-samsung-dcphy.c
> @@ -1653,7 +1653,7 @@ static __maybe_unused int samsung_mipi_dcphy_runtim=
e_resume(struct device *dev)
>  		return ret;
>  	}
> =20
> -	clk_prepare_enable(samsung->ref_clk);
> +	ret =3D clk_prepare_enable(samsung->ref_clk);
>  	if (ret) {
>  		dev_err(samsung->dev, "Failed to enable reference clock, %d\n", ret);
>  		clk_disable_unprepare(samsung->pclk);
>=20





