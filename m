Return-Path: <linux-kernel+bounces-554633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2407A59AB2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F0087A30B7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4B822F392;
	Mon, 10 Mar 2025 16:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vtEH831t"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFB8221F26
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 16:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741623168; cv=none; b=ieZN9OMiEcc5vzHb0JLh12nCKx+2/qHApgmhv76gFdlZYSeUu1TXi2qxpjktJWR/Blbxm1BJrKaXDjE5InubOq68fLVNuysNsQVDTQTk5VyIu4ZuG4GL5WlxdUCUN79etd1LNGP8pVowHzoUKU0L6omP7xm0pXKHQNL52Fw0jAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741623168; c=relaxed/simple;
	bh=GvXTzlRKlAbofNa+lbT2BMK1UdR2zHsco8fZgqhFdv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pF9dMdcFRKFJ6ofB2H0feoPF63wNytobuO4YW74s8jFc0amo3evTqasTuHpGUNdsKGb6i4PmfYpsAdDV7pdN0ceGSHTuOqLR4K7qZrnsN0YsEwz6HQzHlDkPHDYLMsvRUy3GeMhw2N0H3n2jONBExMQAvnb9DnkWY/bJUMX/cu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vtEH831t; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3913d129c1aso1355966f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 09:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741623164; x=1742227964; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GvXTzlRKlAbofNa+lbT2BMK1UdR2zHsco8fZgqhFdv4=;
        b=vtEH831teuQCeHel8KYvXIMhG5xQBMhcVaegpJAYPQqS87/WhEamc6YpBAUug/lNi6
         X2YMscU2iL2b/G7xdvQE1q+YY0Zy9oSs17oV39GjfnoYIDrKV4tUu65XIi0JPcXj+Q0t
         D04OdaiWMM6MmzMDA8OPCCVC00w1Atx2inbK4YbKM7ff7Eql6Md9f8DG8swQ0tKRcJ8O
         I1/STyUbLLS6hWhP9ZDMoWHFys5EW34tl3EMGUc3kId+R7WMYMLRzlYFELOrs7ub9jm3
         c60Y181+2iidAStsTKol4e/v1JBJz44jtf2fpMon+8T0JUdeI0srFcZEq3+vHZ/HIJUN
         msrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741623164; x=1742227964;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GvXTzlRKlAbofNa+lbT2BMK1UdR2zHsco8fZgqhFdv4=;
        b=YQ7JDWFeHbi9AdVLgVboqMvZfyft2PVMzbmLyV0bBYeIzXg1k2BVut9PCefVVdbPWe
         60fCd2ItPjtFWfiDaUCaySJM/eZbDS8KqljY/DwQvAI5Kqf2UKIYAkLlsoonUXB3Vl0p
         zMmLpxjS1j/FU6JbtV5Yhk4XH8HxP+m1MMaFVKAEWnc4NDzgiRsZZcMD+a6lyK1uUTeF
         +CQC/X5PaRDrT6KmogRdp42yIE0PkfnOI3WtarfeQkPWTNTi0I2f4U+2ykSlYheXxmGi
         K8SZ910ZRyyzeNtchGKzRy/aRwVSBOmvYaaHLLr+3HJSaGMpcUcgGmrs91RJTKI5X2Ob
         pJxA==
X-Forwarded-Encrypted: i=1; AJvYcCVNe4kjq5rkGB/5e9r3ijsIyTWpmsnao4wWxdgkCwmpJX69HTxmPVG6rqE3uAsC+WupfyjeFOJX4vXqn5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZjA2HGAQJpKF6QMEj91DPTV1lGN6rgWwjAy6kZPb477lsXQIK
	bxgIJo8XbwYy6GX5eR8nHORtHU+6LoNSOGmZ+ylScdRbD1oTU6FK8MUxGCSh+zs=
X-Gm-Gg: ASbGncshyzUqzcBgd2aQR00/3JxwTTiXpsYWtRvRfgjHoyrxcYHc0RpB78Tt+mfA3pQ
	y+yOypk4L4J7ncuIrLhdkNToVckbzN8ERHQzIyiiPO7ahJmLOI84f0uQlRJCbfhEwtHiTsb+VPZ
	9Fv1A5bzX8phDz7IJY8mQ2eZOpGcn0Wz5af1MiRcrIZx1dLmUPC+RHSBABJCREIAB1ba3SWh6yT
	51LSIR2s2WDsiyBqKKKvECfft5ZA4fy6B3tWhFwTC3G5ZqTYSJGS7QEycg34qh9Ok/A6UlqvWs8
	VJXSE4yP6KEYwt7glpsscglDMP3eXFILzIu5+0i2abeJTZ9+qHize/JHqh6AAesWUOyuWU1+dzw
	L9PK4zeQ=
X-Google-Smtp-Source: AGHT+IFBbTozIoHSsEjyOzqv8zgmaRteBxrQlNVCcmKEKPGV689kjbOrp1a7Gy8xkgnb4JfTfotxdQ==
X-Received: by 2002:a5d:5888:0:b0:391:27f1:fbf3 with SMTP id ffacd0b85a97d-3926d6e57ccmr78729f8f.27.1741623163982;
        Mon, 10 Mar 2025 09:12:43 -0700 (PDT)
Received: from localhost (p200300f65f2c000400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f2c:4::1b9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfb7934sm15566705f8f.12.2025.03.10.09.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 09:12:43 -0700 (PDT)
Date: Mon, 10 Mar 2025 17:12:41 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Dominique Martinet <dominique.martinet@atmark-techno.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Adam Ford <aford173@gmail.com>, 
	Frieder Schrempf <frieder.schrempf@kontron.de>, Marco Felsch <m.felsch@pengutronix.de>, 
	Lucas Stach <l.stach@pengutronix.de>, linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Makoto Sato <makoto.sato@atmark-techno.com>
Subject: Re: [PATCH] phy: freescale: fsl-samsung-hdmi: return closest rate
 instead LUT
Message-ID: <b2qwqacogz5vzfekhk5276owld6isgewu5a2iw3roag3lbtsgm@67vqf54c5tdh>
References: <20250310-8ulp_hdmi-v1-1-a2f231e31987@atmark-techno.com>
 <v57uy3gddzcoeg3refyv7h6j3ypx23mobctybt27xzdyqy6bgb@atzdlqlytz3c>
 <Z861gsaGY6bGSisf@atmark-techno.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mjffy452cs7bmfrg"
Content-Disposition: inline
In-Reply-To: <Z861gsaGY6bGSisf@atmark-techno.com>


--mjffy452cs7bmfrg
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH] phy: freescale: fsl-samsung-hdmi: return closest rate
 instead LUT
MIME-Version: 1.0

Hello Dominique,

On Mon, Mar 10, 2025 at 06:48:50PM +0900, Dominique Martinet wrote:
> [...] and I'm sure there are other improvements that could be made at
> the edges.

One thing that irritated me is the function names. `phy_clk_round_rate`
sounds too generic. `fsl_samsung_hdmi_phy_clk_round_rate` is long, but
I'd say would be a better match.

Best regards
Uwe

--mjffy452cs7bmfrg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmfPD3cACgkQj4D7WH0S
/k5R7Qf/VxOUrJge8JojL4BFpnMAkq1wOnQL4hVuzrN5LWBFTHDPnK+iAEFwkkSq
3jprj6qucTaOj1b/fweLyFX+FXjq6dlZBTJvX13h78SpjN5mQN9e5sUHWtQygHDT
iB02eNLLAiH+m4z68jbra3tRIThghGj4hL3rqalXOtohIYVrppmTv4AuyDDQKKT4
JEAUYqaUO36QRJwXjMcKmIrmdkvDfq3fVgLlrAF31xE9Bd9NqvDi91EFweu+9YDk
1RsJZCm474kggQRDwcoreI7qNxwOBUsv0qWZEyaTBKu3wx4kgLAhsegvIHK3EVYz
nLhtC3X5kNEZJhvQgfXfGRmiU1qcfQ==
=fsNW
-----END PGP SIGNATURE-----

--mjffy452cs7bmfrg--

