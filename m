Return-Path: <linux-kernel+bounces-524698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3928A3E5FA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 21:38:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FFC416C682
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 20:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8896626388E;
	Thu, 20 Feb 2025 20:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hH22Rwws"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448531E9B29;
	Thu, 20 Feb 2025 20:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740083929; cv=none; b=Gn3vq2arNfvrBtOV01knXOZgCjkRd+zcZcKBkx1tEqMKC41CztjVfoOpfjRY2Y0xearJrddtLn4Pxo3lDwNSnOPe0Q1ZfN7gLzBi9JJkOmumQ/Jq1UpscA1xVbXpybFQwhHr24Hkp9ij3CI8UYBc64cH+V7tKNaSjHfHjZWI5MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740083929; c=relaxed/simple;
	bh=QwsMW6iVNU91lHWFEwdgOCeBu4Y7rQxQ6qUYUGztHYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eqKMrQPkochODNOmMUtX/Xq4tG4kRnXRYuLWQAwrsvWXBKXOwfNu6m1n6mVUvc+oAoOOIT0jOkOxgScV/r2mnmL2Shpp5yg3TuibTvJKsqtFZHJS7RHhVQVpK7LYnF6odL/Lu98xG+7cEI/XsdWkPGNA/PkONEPWLBBFDH6XtVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hH22Rwws; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4398c8c8b2cso14182525e9.2;
        Thu, 20 Feb 2025 12:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740083926; x=1740688726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L/oPr+uhiMwVLonfT4r87s8BLvEv5cJUIRCGxgmU+Z4=;
        b=hH22Rwws8YbHyBI2Ka8KheG4KNeJix2nFRmroQiJqt1Uyr2tpSS1myQDG/PqsJTUvm
         ktfZDgf2gbhf2oQD1FCyoIObEjpUOgv6IIsgp6X0UXOrjCRHlQtO+II7iMNEpsXmJpbu
         K500XocgGeCodc8t6aFLsj4NkeYXhJfj8pgJcUZWdq9AVPer2Dpui3+TZlwourEP2OhF
         rOg6F/fjFAUZ07mWhfvJV4zNEIeO/9QhbuUlheG6zG0zdxWH5vHX3vjllCO0VH7WWOnc
         s8arfPazIzae4OuzbZZiP7Fz854gR2ca2AMLFDYc2M/UbMMYJJto011ZCkJ70bT67qv/
         Iktg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740083926; x=1740688726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L/oPr+uhiMwVLonfT4r87s8BLvEv5cJUIRCGxgmU+Z4=;
        b=Dx3NXz0P3jGuq8n5EnzciFNZL4Gdg+XwA+huih6AMOXnlNINHhJz16+inhfr67uReM
         LtlhEsDynwnhDZafujq8k5tdtRDRvhk+qdJKaGQj3v1/SoFz0HTi2k1oDeRoi4hDEzM0
         4D4MHLWoxjxHYb7YiPU9PxJT10FjQ8ton5F4/tT+gPe094fVjDsS997xLmF4nMm+LMLE
         wcvfJcpnjJv2FuP+zqAOoyi7jAKQltvB7/xg7jTPy5oRG5U71d3robUjIKtb6BtuP8yp
         d22LaNBv58GeOo1Iy7Guy235C62Ut2c7g4/zHhgTgGR8H1rYG+Kd6Ay4ZyKd84HbsqR8
         WUPA==
X-Forwarded-Encrypted: i=1; AJvYcCVhyTls+Mbvvj11hA9avdICZ7j8HfVbneClZqmVbgRl/JUwMdyz1A4/9zboMbORz34dv6qVEt9rNGku@vger.kernel.org, AJvYcCVjcwsWe2f5u2B6Ju5etYtpwYM27ckz5YtJcXkTjjVcCioY71ku8z7zt3kspRPhdpsjCXYCg7flQnf3CzwS@vger.kernel.org
X-Gm-Message-State: AOJu0YwpnUKmY0SrBabXLu3axidVG13V5JjCt6Et7HJfQ8FWlB85CsYv
	2iDNQ4QaDQxZVgUY6P7tvEjS7/g2gI2ee/jL3dORdByah5jPp6cA
X-Gm-Gg: ASbGncsHIv4hjyZcNBMhqMmekL1iSMYC1wk/lRcSsGjEXAe0Mkg62ybi/MW/KWsFHJ7
	Dlnjk3DIy9CJeUs7zXVL/f9/Dd3PTtqfdFfMGmrboe7EPPIYZ714X25MBjoSO3fhbvOQRwvMtnw
	cDLmx7psq8SYaYQyVObIrRul7/NHy+EaUoT270s7le747ZRniQWN1zX+6DXKQ70vbhQQvKdFYDt
	yEvO795TM5JT2V3tUozi3Z7eDPwukn4JpwroA5Xvxnwg1GYPzi9VbTxStv6ZIa7p86uzSw3slk+
	BMpQUsSkvcB38NjMubyLICpThRYYR0LSOonraJfsnqaBbN3TaZuKpx6Xx98oh0+AmoM=
X-Google-Smtp-Source: AGHT+IH9AWEvVPP40afiEyTpAqrp+DWpZtEd4U6ccKRCJ9igZQuFw9ymkzn2FjL3McLqq0mzFVmoPw==
X-Received: by 2002:a05:600c:524a:b0:439:86c4:a8ec with SMTP id 5b1f17b1804b1-439ae1f1147mr6622885e9.15.1740083926326;
        Thu, 20 Feb 2025 12:38:46 -0800 (PST)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439a3cc9551sm31663025e9.39.2025.02.20.12.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 12:38:46 -0800 (PST)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "moderated list:ARM/Allwinner sunXi SoC support"
 <linux-arm-kernel@lists.infradead.org>,
 "open list:ARM/Allwinner sunXi SoC support" <linux-sunxi@lists.linux.dev>,
 open list <linux-kernel@vger.kernel.org>,
 Philippe Simons <simons.philippe@gmail.com>
Cc: Philippe Simons <simons.philippe@gmail.com>
Subject: Re: [RFC PATCH 3/3] arm64: dts: allwinner: h700: Enable USB OTG
Date: Thu, 20 Feb 2025 21:38:44 +0100
Message-ID: <3229934.fEcJ0Lxnt5@jernej-laptop>
In-Reply-To: <20250118102207.9339-3-simons.philippe@gmail.com>
References:
 <20250118102207.9339-1-simons.philippe@gmail.com>
 <20250118102207.9339-3-simons.philippe@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne sobota, 18. januar 2025 ob 11:22:06 Srednjeevropski standardni =C4=8Das=
 je Philippe Simons napisal(a):
> RG35XX have a GPIO controlled regulator for phy0 vbus, add it.
> Enable HCI0s controllers and otg for dr_mode.
> Add phy0 properties to descrive id_det, external vbus, and internal vbus
>=20
> Signed-off-by: Philippe Simons <simons.philippe@gmail.com>

This could work without previous two patches, right?

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  .../sun50i-h700-anbernic-rg35xx-2024.dts      | 25 +++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h700-anbernic-rg35xx-20=
24.dts b/arch/arm64/boot/dts/allwinner/sun50i-h700-anbernic-rg35xx-2024.dts
> index 80ccab7b5..5a6ae42de 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h700-anbernic-rg35xx-2024.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h700-anbernic-rg35xx-2024.dts
> @@ -175,6 +175,16 @@ reg_vcc5v: regulator-vcc5v { /* USB-C power input */
>  		regulator-min-microvolt =3D <5000000>;
>  		regulator-max-microvolt =3D <5000000>;
>  	};
> +
> +	reg_usb0_vbus: regulator-usb0-vbus {
> +		compatible =3D "regulator-fixed";
> +		enable-active-high;
> +		gpio =3D <&pio 8 16 GPIO_ACTIVE_HIGH>; /* PI16 */
> +		regulator-min-microvolt =3D <5000000>;
> +		regulator-max-microvolt =3D <5000000>;
> +		regulator-name =3D "usb0-vbus";
> +		vin-supply =3D <&reg_boost>;
> +	};
>  };
> =20
>  &cpu0 {
> @@ -337,12 +347,23 @@ &uart0 {
>  	status =3D "okay";
>  };
> =20
> -/* the AXP717 has USB type-C role switch functionality, not yet describe=
d by the binding */
> +/* the AXP717 has USB type-C role switch functionality */
>  &usbotg {
> -	dr_mode =3D "peripheral";   /* USB type-C receptable */
> +	dr_mode =3D "otg";   /* USB type-C receptable */
> +	status =3D "okay";
> +};
> +
> +&ehci0 {
> +	status =3D "okay";
> +};
> +
> +&ohci0 {
>  	status =3D "okay";
>  };
> =20
>  &usbphy {
> +	usb0_id_det-gpios =3D <&pio 8 4 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>; /* P=
I4 */
> +	usb0_vbus_power-supply =3D <&usb_power>;
> +	usb0_vbus-supply =3D <&reg_usb0_vbus>;
>  	status =3D "okay";
>  };
>=20





