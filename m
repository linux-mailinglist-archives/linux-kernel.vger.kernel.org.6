Return-Path: <linux-kernel+bounces-524690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C24C8A3E5D7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 21:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9846F17E4E3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 20:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBF92638A0;
	Thu, 20 Feb 2025 20:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IoB8Fajw"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9451E9B28
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 20:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740083253; cv=none; b=FiCaTTgZFl5gwxtYokUNw7kt4ujwlTj2WLHSc9hxYhQlDu9bqq0805fAm3fC7LgwUI5EUfoipxd7++9o8Q1WlvbTO3+8yiwN31Tpf+Hwhai4oqwzl6n5cz0AmkO2DXg86QnFMHpd3kdegX1zNvvW1zaKUb3E/gYSj1bj2DvTk+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740083253; c=relaxed/simple;
	bh=ZZYRX1szbwqrHQhPPSjkDoX0HCeTh2Z5cpehiI9E+hE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ar+eS32BD4x3G0ySMAeyCw5bQ7HAoGu+R5AfsFy1N3IYgTGhdE/DDQ2tuWAzp7hi/Cj178+kQbo14cFugnwocYbnZ1QG0RpfUySpvqSHKTDIASHV5bLbPjvhvAev8jSjz1AcncyNVKu4CZ0hQGZ/7SvRjgqovONS7Wv6b8ZULDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IoB8Fajw; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43690d4605dso9110695e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 12:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740083249; x=1740688049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OtfmfrXV4Fenqpt6KK3zaAtg3JmCzHplb9SYG8vsTp0=;
        b=IoB8FajwgOLgfc/ul73y8eDfrhCkP+NY/bPJQHfFt/nt+BK4WpEGPZ0VhOhrP8m40P
         sIgXmVDJQkl7Dyjp4PYlSi0NqKJwXBEufjf/R8ZomhatpGHxubDGj0huHUgaG8HAXa5v
         uQPdQZSHenE9LuACxAsgL7DpXTa82w6xWqW4bO+fXlhgpTFAN6qLotcqXH6ONL/0D0ly
         0KFTUpNR3Z6hAnY0XCsZvfwz+mOkuYP64dFp8JoZBQfLds2eDpdvEyZ1q8uWPVJbLrAr
         ifrdrD7widjH02StH9vXVwPo0k29RuhxLrB3c199msL4YSZarof7HHVv5uX70ngxeRH0
         1F0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740083249; x=1740688049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OtfmfrXV4Fenqpt6KK3zaAtg3JmCzHplb9SYG8vsTp0=;
        b=NxW03+TrXBKhM5cv/AE94bcU/WDXGUdoq3oEjbcWo8LxnRjM0fgACY+mMY87En5GTR
         xUJZ9vsiVN/e+c6Yy/DN32imEZjFuEd/mv2e818teVb1fANcfGemqcImePQ2gSyVC7TU
         aWJetdA5REuSTbwhyVSJfb3F4GfeoRPM+LjE1BVegX3n0W5dvNgFCKJSZr+3dP6sXIPc
         qxdVr6uC406cLoGGr7HsZ0R+HXUervSq9DLrO7gZixrCjbHYwlJ/ZJkF9jYntqfS3H0i
         QUf0e6YRS8YrPjADTvVnX2dmYQdc+Uzlmecjo4zYJ9LYtxaRFuIzTh2nFf52TZbxcfhD
         D5hA==
X-Forwarded-Encrypted: i=1; AJvYcCVaIlX2QMcOoWQYEi/oBilXlcoggz+7SNJPs7VVaKMKo+EK5VaTwR9XFXpsDbuYU7Cu8mw1WPLV20totq8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT5cGNuANtzKTJIl7YVLw+15Ge35i5AaWbvix7La9ydrB+hMjv
	SxSHETXT2qxzgW4jn72ZoptQNltzPgsAC/YPG4txRZYblGCURt48
X-Gm-Gg: ASbGncsu9LX2tlCaZIiVlL/fxu1zQloqdBtWf6kFfq05hRh7IGICM2lDOZxKO2aQyps
	atLEogvVZZ+sm3klUXIfM37Xvgpa3wyAoRoJHVoJkmsKHt68Ib67P4iY6mM1WykqyCQeAanne1V
	6ihwxMkRj3P+VNG+7C6q+sdJY9CLF6v7syZvGRte5T9uuHIRmoahZyOJPDbeIKZ/yWd5pTEE7xf
	fQYGl7GzdPQDYTYSAEoP4eKCWiOxTnkyga2NPxAiDPYW85OHfqpFFAh5AYzofcKtLks3QyF6VkX
	/PRnIvyNKp+ArmiCbvPBxMuLYZKIYTCIF1FVgx0X8BAUVObnanhD2sF9dApdp70qcco=
X-Google-Smtp-Source: AGHT+IECii+tVv+IZA8Kwcb9HLreQ7WkQqdHkR9yh3R3Vri6Dsiv8yRmWFnRoRF5/CwPCmIDOfBbOQ==
X-Received: by 2002:a05:600c:3b93:b0:439:96b2:e9b with SMTP id 5b1f17b1804b1-439ae1e6a3amr4585785e9.9.1740083249349;
        Thu, 20 Feb 2025 12:27:29 -0800 (PST)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a1b824dsm250156575e9.34.2025.02.20.12.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 12:27:28 -0800 (PST)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
 Philippe Simons <simons.philippe@gmail.com>,
 "open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>,
 "moderated list:ARM/Allwinner sunXi SoC support"
 <linux-arm-kernel@lists.infradead.org>,
 "open list:ARM/Allwinner sunXi SoC support" <linux-sunxi@lists.linux.dev>,
 open list <linux-kernel@vger.kernel.org>,
 Philippe Simons <simons.philippe@gmail.com>
Subject: Re: [RFC PATCH 1/3] phy: don't let controllers change vbus reg
Date: Thu, 20 Feb 2025 21:27:27 +0100
Message-ID: <2261426.ZfL8zNpBrT@jernej-laptop>
In-Reply-To: <20250118102207.9339-1-simons.philippe@gmail.com>
References: <20250118102207.9339-1-simons.philippe@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne sobota, 18. januar 2025 ob 11:22:04 Srednjeevropski standardni =C4=8Das=
 je Philippe Simons napisal(a):
> Allwinners SoCs share phy0 between the MUSB controller and HCI controller.
> If we let these controllers independently power on the vbus on that phy,
> peripheral mode is dangerous because HCI never power down the phy, result=
ing
> in 5v being applied against the host 5v.
>=20
> Override power_on/off for phy0 in that case, and let regulator be enabled=
/disabled
> based on id_det only.
>=20
> Signed-off-by: Philippe Simons <simons.philippe@gmail.com>

Is this fix for some observed issue? If so, Fixes tag would be appropriate.

> ---
>  drivers/phy/allwinner/phy-sun4i-usb.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>=20
> diff --git a/drivers/phy/allwinner/phy-sun4i-usb.c b/drivers/phy/allwinne=
r/phy-sun4i-usb.c
> index b0f19e950..24fbabe7a 100644
> --- a/drivers/phy/allwinner/phy-sun4i-usb.c
> +++ b/drivers/phy/allwinner/phy-sun4i-usb.c
> @@ -465,6 +465,10 @@ static int sun4i_usb_phy_power_on(struct phy *_phy)
>  	struct sun4i_usb_phy_data *data =3D to_sun4i_usb_phy_data(phy);
>  	int ret;
> =20
> +	/* phy0 power is controlled by sun4i_usb_phy0_reroute and id_det state =
*/
> +	if (phy->index =3D=3D 0 && data->cfg->phy0_dual_route)
> +		return 0;
> +
>  	if (!phy->vbus || phy->regulator_on)
>  		return 0;
> =20
> @@ -493,6 +497,10 @@ static int sun4i_usb_phy_power_off(struct phy *_phy)
>  	struct sun4i_usb_phy *phy =3D phy_get_drvdata(_phy);
>  	struct sun4i_usb_phy_data *data =3D to_sun4i_usb_phy_data(phy);
> =20
> +	/* phy0 power is controlled by sun4i_usb_phy0_reroute and id_det state =
*/
> +	if (phy->index =3D=3D 0 && data->cfg->phy0_dual_route)
> +		return 0;
> +
>  	if (!phy->vbus || !phy->regulator_on)
>  		return 0;
> =20
> @@ -573,9 +581,21 @@ static void sun4i_usb_phy0_reroute(struct sun4i_usb_=
phy_data *data, int id_det)
>  	if (id_det =3D=3D 0) {
>  		/* Host mode. Route phy0 to EHCI/OHCI */
>  		regval &=3D ~OTGCTL_ROUTE_MUSB;
> +
> +		/* Enable VBUS reg */
> +		if (phy->vbus && !phy->regulator_on) {

I don't see any "phy" variable in this function. Also, you should add same
protection as it is implemented in sun4i_usb_phy_power_on(). Skip enabling
regulator if:

sun4i_usb_phy0_have_vbus_det(data) && data->vbus_det

> +			regulator_enable(phy->vbus);
> +			phy->regulator_on =3D true;
> +		}
>  	} else {
>  		/* Peripheral mode. Route phy0 to MUSB */
>  		regval |=3D OTGCTL_ROUTE_MUSB;
> +	=09
> +		/* Disable VBUS reg */
> +		if (phy->vbus && phy->regulator_on) {
> +			regulator_disable(phy->vbus);
> +			phy->regulator_on =3D false;
> +		}
>  	}
>  	writel(regval, data->base + REG_PHY_OTGCTL);
>  }
> @@ -603,6 +623,12 @@ static void sun4i_usb_phy0_id_vbus_det_scan(struct w=
ork_struct *work)
>  		return;
>  	}
> =20
> +	/* Disable internal VBUS reg if there is an external VBUS */
> +	if (vbus_det !=3D 0 && phy->vbus && phy->regulator_on) {

Ideally, this should never happen.

Best regards,
Jernej

> +		regulator_disable(phy->vbus);
> +		phy->regulator_on =3D false;
> +	}
> +
>  	force_session_end =3D data->force_session_end;
>  	data->force_session_end =3D false;
> =20
>=20





