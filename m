Return-Path: <linux-kernel+bounces-426373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6769DF247
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 18:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94C94281379
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 17:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DE81A706A;
	Sat, 30 Nov 2024 17:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="P9wOGpeb"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E6B18660C
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 17:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732988258; cv=none; b=g6Ly7m8SG83s7+swmLOP2LiIm63zPMQcKxl9BdS8rpRcpt3JVWJVk1hIMb3VM+wyzhwpqc4ymRlxzjNeOX77JsB9RLeWD0ztG3dX4+2X4o4ktetmUrELfuOk4iVATyMrI5VcLPotFBZawENqZ/o6P8R4Gilq5tev1/gBjnWIpE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732988258; c=relaxed/simple;
	bh=7CM5G7Xn+7l5Qz3KuLpZNfYg9HsfB3Hv+/ezrxcQa9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q5x+t6yz7eyvtLpSFJLFop08iTUlw7dRxsvnDF9LMiEPVX2TxoKueEuE+2iYUlZbUX+N4zXzSs2sKwpQshuMz3qtSFAmur0i//pfYUYNgKHlGMtcKCAFOxXT8ePqaVFjd7MjK+GwabUQ0+I5JAScaAQYMEaUN9DNlGrve1aKy9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=P9wOGpeb; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-385d7f19f20so1080232f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 09:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732988255; x=1733593055; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OHsN6TaNp1079VuBOcy+ma3PsSKaKXviIRckoZ4F6Sg=;
        b=P9wOGpebPU0n4F6Cr/ZL1Syb2uCLqR0bTIDj9rUDtFuaBKgAS3zxYwN3Bu1J1MC8RC
         EggD43qeOtDjPT/w5ZpqGhtgChY5NBn4Z8hcp8VVjZRqlRrSURSHXaLy9qiQkMpR064g
         MbsEriTrCg951DZ8fCtGZntBFiUtMTm0lR1ypZnbbV+2Knx9x/gXwu106ht9wTD9Vz9J
         Z0zfrsY9VEoHYQEDb3lUKxgVnu5pRu6h7q3d53K71wh7zhg2TyObi9g2O4SGOnNFe2U4
         frw6c9zRdJF+pl7bnb1xSRl72rb9KisMBvErwv43naOw3ygBtxRghoMfuVIwr6/YcQhI
         nlFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732988255; x=1733593055;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OHsN6TaNp1079VuBOcy+ma3PsSKaKXviIRckoZ4F6Sg=;
        b=NJRWPyB5IZQVCHAWPer93kOlSlz6pTY5zTRAzrn2kRxhc5nuCu84ZuVz6bhxpyl1m8
         YpZ6s65TAK3GAU0ga8gTO/rTNiXZBtwpWanBiDUpGBXs4fGJ1NlOAVk9q/56J8N8ttEw
         g4JyDweUITENRhtBCedH7U9EMj0Tmn7Zi/b0D1uaLpj/kz5M3rM4jTm7ZsoeG4zohGMh
         inU6RljUTEfNYVvIVPZZ4TIGSIP2ndNuYcfd3AxJgoCp8DK/udtoDCfoCd+F3O2MLadL
         nfOxNvJm4IJJHULUpdh3zwkm5rjecV/Z3zxQm4lxSNLrzdHgrBc4X8vEc7MJsxZlNU27
         rYZg==
X-Forwarded-Encrypted: i=1; AJvYcCVi4omMD+31UhZVRKRgdzIl86vmzsOy8C2QZXrQyW7B0UptssLtji05kS5jjPTHG6Q3lAEHp4dgG1uyjTA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfTtfKk6yrHHLZMkHztX4eD8+KuTTQS3pHG3PGXPBiBVayS4bx
	8W0xe4nbeQBhvSjWCP2OHSXJdR7eTKe9cjujewykAW5VAbCMicikporD867z1DY=
X-Gm-Gg: ASbGncsbSkbSXVINDjNIr8uISrApCGey0DKP55uOre4L7gqF/mUbgW+V4LUjTJlQtEl
	QJlprvT7T/RyeodcxXkeWfLj6j71L6gb93ZSEAGcqyVafW1WYT9m3BzDavYr9uGT3SBim0S4g7W
	iutjpiqLPEQaYET9LR1/7BsLHkMByARVgYfDmxmCQgcks3C85YP2YErEx1LcTQ6z3kIlp8pkyvV
	ypSeEIlCQ9qQoD+ki8d7LH3xv36kZVwarx73jp2IW4zAJqdyYJ95+o=
X-Google-Smtp-Source: AGHT+IFwFQ2rSjeB0u3yaS6t10AI+CYIIMAsPZIeMkH7fQN0rD+w3+XGwsQFyRldnEvjiwCvxiOdhQ==
X-Received: by 2002:a5d:59a3:0:b0:385:cf9d:271d with SMTP id ffacd0b85a97d-385cf9d2858mr8248469f8f.21.1732988254848;
        Sat, 30 Nov 2024 09:37:34 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385eb10bf7esm453594f8f.14.2024.11.30.09.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2024 09:37:34 -0800 (PST)
Date: Sat, 30 Nov 2024 18:37:32 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Liu Ying <victor.liu@nxp.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, p.zabel@pengutronix.de, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, 
	simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, glx@linutronix.de, vkoul@kernel.org, kishon@kernel.org, 
	aisheng.dong@nxp.com, agx@sigxcpu.org, francesco@dolcini.it, frank.li@nxp.com, 
	dmitry.baryshkov@linaro.org
Subject: Re: [PATCH v4 09/19] drm/imx: Add i.MX8qxp Display Controller
 display engine
Message-ID: <gyt3z6jisr4cea4wwk32hgzbatbczibppgrv6copcl4qo2chlx@w5kcqulhoe2p>
References: <20241125093316.2357162-1-victor.liu@nxp.com>
 <20241125093316.2357162-10-victor.liu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4chv2ajqebpzf4n4"
Content-Disposition: inline
In-Reply-To: <20241125093316.2357162-10-victor.liu@nxp.com>


--4chv2ajqebpzf4n4
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v4 09/19] drm/imx: Add i.MX8qxp Display Controller
 display engine
MIME-Version: 1.0

Hello,

On Mon, Nov 25, 2024 at 05:33:06PM +0800, Liu Ying wrote:
> +struct platform_driver dc_de_driver = {
> +	.probe = dc_de_probe,
> +	.remove_new = dc_de_remove,

Please use .remove here. Also in a few other patches of this series.

Best regards
Uwe

> +	.driver = {
> +		.name = "imx8-dc-display-engine",
> +		.suppress_bind_attrs = true,
> +		.of_match_table = dc_de_dt_ids,
> +		.pm = pm_sleep_ptr(&dc_de_pm_ops),
> +	},
> +};

--4chv2ajqebpzf4n4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmdLTVoACgkQj4D7WH0S
/k4Tewf9EssJcTTmbhrMd+Z9OEMUakhfq+ufnw7+fdnL5bSz1UG4O6BpXKdSHEOG
3GVGRRTto7bFTDc8d6AjAymdKak5N9qoiKUvbjXBcqqw/yrQnatqoSbVaGXl1AhM
bC3ACa2Jk+hpxBLZ0ADQNIsiTHt1JsD25oyDT+LdjtBWwGcao8CWuPNQY9vu/+np
jeqbvSKy0ZxJyb9DtQkAErXp6TDgbDIus7W/t+SER/BSZVQuZQH1cZ/Il8Fyf41K
jlKO+ARu3pWEngcNyxZmR5mUzZdh6+0Gfoy31/tdmao58gaN/fLFirQ0NruQFDEM
3M2Ee3lQXE8MXaOGn2uhWj312eKAZw==
=RpIh
-----END PGP SIGNATURE-----

--4chv2ajqebpzf4n4--

