Return-Path: <linux-kernel+bounces-545607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 302CEA4EF33
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 22:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7BB61726CC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 21:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2010269B0B;
	Tue,  4 Mar 2025 21:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="LwuGfFrD"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1731FDA9D
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 21:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741122701; cv=none; b=Bv1YOaj+BOGrsBKX8QQT+V5lTCC2S3sqLKx4q7JyS1KZ6hYuwEO1feIOtAJgswHExQc3nA24jpFwrXRyCl9BhjWppagm0ailUmQmsxNpK9n/WIdDOVpNnXIJMXU23HlRwI+hsK5Xdhlc1D7t/8xtD11Aw8jgQdbon3DS8P5SdU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741122701; c=relaxed/simple;
	bh=p+8hy8VGG6oNXRm42Coqsgu/DaL8zW2N++i9D71OlnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JjVfN2wOEDHVVfVhiWMVTmz5Jp0SnreN5oP4xfw119f2DWox7YrEbaqZa7rjZev/280fmpRguYO+68f4Z9+bOzm80F8eDAAV3cOxOE/2DLq+qdXfGuKlWkpYQIDttffn15jwDGd+SQMsNiHwQN7MpxfhmLrjr6A4FgixxsGzeQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=LwuGfFrD; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=67iaMe7dRzqdmdTZ5v9Y4GVdBIwy//hSn3Sql8CF+no=; b=LwuGfFrDvpwUU2B/5O/ULqbrDV
	oEVLnfpfhFu69Ah2JLQbY0xkmgJLtF02XMOjjT+j6hUtQIjF1n2zEuxMw03K//2AjsxukLhZmm8/s
	0G47epspd1m/oEAqwB74vAgVd3OX5Zx1Xalh6MS2jAD+6NsQn0v+nMPM6rEKT9YW/U+mFI6b+UIsW
	CVqjoYsJn1RnQwgi6WfPvIX4FjYoavZEyP+Ep5Q82IpxQY6Aq2IJUCN6mypnZKaXbZ1riCOfg+3T0
	G7qnvSdnpDszk21aAuNc4yp9TebRb9TxEl9Oo92/0IN5T4vCu8I9lOXD0j2YXWa5GuC+MhNaT0phF
	pcsq8BkA==;
Received: from i53875a38.versanet.de ([83.135.90.56] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tpZXr-0006Cf-7O; Tue, 04 Mar 2025 22:11:19 +0100
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Dragan Simic <dsimic@manjaro.org>
Cc: andy.yan@rock-chips.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, quentin.schulz@cherry.de,
 Heiko Stuebner <heiko.stuebner@cherry.de>
Subject:
 Re: [PATCH v3 1/3] drm/rockchip: lvds: move pclk preparation in with clk_get
Date: Tue, 04 Mar 2025 22:11:18 +0100
Message-ID: <3048640.Lt9SDvczpP@diego>
In-Reply-To: <041c5f0e2371817a27577bd0989b9dca@manjaro.org>
References:
 <20250304124418.111061-1-heiko@sntech.de>
 <20250304124418.111061-2-heiko@sntech.de>
 <041c5f0e2371817a27577bd0989b9dca@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Dienstag, 4. M=C3=A4rz 2025, 21:30:22 MEZ schrieb Dragan Simic:
> Hello Heiko,
>=20
> On 2025-03-04 13:44, Heiko Stuebner wrote:
> > diff --git a/drivers/gpu/drm/rockchip/rockchip_lvds.c
> > b/drivers/gpu/drm/rockchip/rockchip_lvds.c
> > index 385cf6881504..ecfae8d5da89 100644
> > --- a/drivers/gpu/drm/rockchip/rockchip_lvds.c
> > +++ b/drivers/gpu/drm/rockchip/rockchip_lvds.c
> > @@ -448,15 +448,13 @@ struct drm_encoder_helper_funcs
> > px30_lvds_encoder_helper_funcs =3D {
> >  static int rk3288_lvds_probe(struct platform_device *pdev,
> >  			     struct rockchip_lvds *lvds)
> >  {
> > -	int ret;
> > -
> >  	lvds->regs =3D devm_platform_ioremap_resource(pdev, 0);
> >  	if (IS_ERR(lvds->regs))
> >  		return PTR_ERR(lvds->regs);
> >=20
> > -	lvds->pclk =3D devm_clk_get(lvds->dev, "pclk_lvds");
> > +	lvds->pclk =3D devm_clk_get_prepared(lvds->dev, "pclk_lvds");
> >  	if (IS_ERR(lvds->pclk)) {
> > -		DRM_DEV_ERROR(lvds->dev, "could not get pclk_lvds\n");
> > +		DRM_DEV_ERROR(lvds->dev, "could not get or prepare pclk_lvds\n");
>=20
> I'm wondering why this patch isn't replacing deprecated DRM
> logging macros with their preferred successors in a couple of
> places, just like what the patch 2/3 from this series does?

because this patch is about reorganizing the clock handling :-)

Changing the logging functions is a different topic and so has no place
in _this_ patch.

And of course drm-logging is a separate beast to tame altogether.
drm_err vs. dev_err; lvds->dev vs. drm_dev (there was an argument over
what belongs where recently) .

And I had neither the capacity nor time to delve into all that, so limited
myself to stuff I understood :-)

Heiko




