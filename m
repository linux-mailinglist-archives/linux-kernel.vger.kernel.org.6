Return-Path: <linux-kernel+bounces-449190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 380B99F4B3A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 13:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1AF77A0FFE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 12:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8C91F238D;
	Tue, 17 Dec 2024 12:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TqGzr4+d"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B511F03D5
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 12:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734439682; cv=none; b=sJ6vmmMBZNAv7FFe8iZzpi/r4VMecrLq/lQBkaqIyLEwzCY6P46gkjdCWnKy7nwjBYxODDdzdIiiLpul4OOtWM8ADuCwasl5jxOykO2xV/vWk1AbQUfcnBp473ww+AZjDF6NL42OTCl6ooqqp9/Qj4v40akFlX3sy8JAiAX4oSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734439682; c=relaxed/simple;
	bh=tdgli3SZLzt1J8EXqaw5Yd2MPpv7GyeTjdkcnePcAvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KZDo9dBHzluclo076Of7ZGDu2ETsQ+Hfc75ZKH00KwQpueqNao+fIMquwPDDZcpdIVlycvijGLDUv4/5b2r0h610ydB89FmpfVS5qxPs16oA5CJAaSwv25+TKg8Vms4CY+Y/YAuGsaiW1BL0JovN4+fB7JXw9KJRDKfJg4+Yqbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TqGzr4+d; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734439680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wFrk9B4Z7mdoTzpBnuLcBenrDHv77JNnBq7+6dFbTlI=;
	b=TqGzr4+dT7Kn75qbvqCgkvyV5DIUWltkhJna89MiMYDOqZr+92xcTgXAz+xnKULBvEVWUv
	YgMIyENzPYLJHc//QFkD+02khStXz5TX36BswY3fZUe4slPgBfGLbFHKs2/d7kquHBpONn
	ukezN7EWTcR4uVmztHYygYHD+yfloc0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-IzxNkj8DN-6YPEfHiALekw-1; Tue, 17 Dec 2024 07:47:56 -0500
X-MC-Unique: IzxNkj8DN-6YPEfHiALekw-1
X-Mimecast-MFC-AGG-ID: IzxNkj8DN-6YPEfHiALekw
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-38634103b0dso2836063f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 04:47:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734439675; x=1735044475;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wFrk9B4Z7mdoTzpBnuLcBenrDHv77JNnBq7+6dFbTlI=;
        b=DivI3HhIj9XN1f5L3AIuttbJblGvxN43ApOb+HqzPD0ZDdE7EMbGso1Dajw7ZPj1wX
         5i9tpjXHm0IV+rVG3jS/k5qOWwZ/iFjbUv9Cj/328HXiQ1g9qN6WKiO3dwI+0h0zc6jh
         8FkOLpGVZXUJA41QILLhV6tKjmBjqdsnnWXzq8iYzaiOVUy4pY6uA6B/i7j/HtsSA0Hz
         BQirRhxjqzi/A4s+tRM4ZjN/Qei1uZ8Cg+TZEYptqoeGdF/2Fp4GYsfw7QaDZgrIhzYH
         cbLkpqv+Vz2sXeXkVRJXb99igLVKGHYDM8EZyGv+d1i5Mn0zkFcKj6gOJOi3ODIcMZE5
         o5vw==
X-Forwarded-Encrypted: i=1; AJvYcCUVaN9eEeNW0QL3iKYZ6z7QpPWkD/tkj4vkFd4R36zH9utCSoGikbe1h/bEwoSUFYckxTeSHIL5TnPul8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmPExc6piMmivzYPeiu9s0AxCGHIc6i2COSpqYUmFJ5HC8FcEm
	k0Bunj5WacQN/IagqhoGg/dxoXSJV9GPxEXZ4cufEr8vGmOSqYPoS8I2OUzn/5PhLuYNV+eA8KS
	3K24nI1vKH7gCku0MbAPHGR3HDKfVMcoYbO1N0Ar1itSrQZY15jw7pa7Vfspcfg==
X-Gm-Gg: ASbGncuW+tg2MnCfISMws4wwPsIW7aMhlgtwGnEyOG0uWMJ/xaRIIkhPuE07ECRO6q6
	viZB+hB5zVlrHiGbS6I1L/LUK4azuOZImsOTPTA8CerPcLaJFgUHaJ2jxI3Rb7ZO2bGRJ7lmpPR
	WnCEpPwyXgz/4tATMJQpYAHbE/fRpgybKyu4ARzWaEwmrhx3wWiKXnVbrzt03rrVLuDYZnJVYz4
	3cI/N909aWsdJuEFHCvvBNlfvRybMo9
X-Received: by 2002:a05:6000:4026:b0:385:f07b:93da with SMTP id ffacd0b85a97d-3888e0ac2f9mr14313191f8f.47.1734439675427;
        Tue, 17 Dec 2024 04:47:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFHwsMdejiDMGaW3ubV5E8L0Ddxnjtm2Ra+UQjEkInSvg2c1ns6wObShSkwv0I/OwFbb7T5qA==
X-Received: by 2002:a05:6000:4026:b0:385:f07b:93da with SMTP id ffacd0b85a97d-3888e0ac2f9mr14313145f8f.47.1734439674844;
        Tue, 17 Dec 2024 04:47:54 -0800 (PST)
Received: from localhost ([2a01:e0a:b25:f902::ff])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c80163b8sm10895392f8f.35.2024.12.17.04.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 04:47:54 -0800 (PST)
Date: Tue, 17 Dec 2024 13:47:53 +0100
From: Maxime Ripard <mripard@redhat.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Ying Liu <victor.liu@nxp.com>, Marek Vasut <marex@denx.de>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-clk@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	Abel Vesa <abel.vesa@linaro.org>, Herve Codina <herve.codina@bootlin.com>, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Ian Ray <ian.ray@ge.com>
Subject: Re: [PATCH 4/5] clk: Add flag to prevent frequency changes when
 walking subtrees
Message-ID: <20241217-brown-wapiti-of-promotion-e3bec6@houat>
References: <20241121-ge-ian-debug-imx8-clk-tree-v1-0-0f1b722588fe@bootlin.com>
 <20241121-ge-ian-debug-imx8-clk-tree-v1-4-0f1b722588fe@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="naq5whtgj6roz2n5"
Content-Disposition: inline
In-Reply-To: <20241121-ge-ian-debug-imx8-clk-tree-v1-4-0f1b722588fe@bootlin.com>


--naq5whtgj6roz2n5
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 4/5] clk: Add flag to prevent frequency changes when
 walking subtrees
MIME-Version: 1.0

On Thu, Nov 21, 2024 at 06:41:14PM +0100, Miquel Raynal wrote:
> There are mainly two ways to change a clock frequency.

There's much more than that :)

Off the top of my head, setting/clearing a min/max rate and changing the
parent might also result in a rate change.

And then, the firmware might get involved too.

> The active way requires calling ->set_rate() in order to ask "on
> purpose" for a frequency change. Otherwise, a clock can passively see
> its frequency being updated depending on upstream clock frequency
> changes. In most cases it is fine to just accept the new upstream
> frequency - which by definition will have an impact on downstream
> frequencies if we do not recalculate internal divisors. But there are
> cases where, upon an upstream frequency change, we would like to
> maintain a specific rate.

Why is clk_set_rate_exclusive not enough?

> As an example, on iMX8MP the video pipeline clocks are looking like this:
>=20
>     video_pll1
>        video_pll1_bypass
>           video_pll1_out
>              media_ldb
>                 media_ldb_root_clk
>              media_disp2_pix
>                 media_disp2_pix_root_clk
>              media_disp1_pix
>                 media_disp1_pix_root_clk
>=20
> media_ldb, media_disp2_pix and media_disp1_pix are simple divisors from
> which we might require 2 or 3 different rates, whereas video_pll1 is a
> very configurable PLL which can achieve almost any frequency. There are
> however relationships between them, typically the ldb clock must be 3.5
> or 7 times higher than the media_disp* clocks.
>=20
> Currently, if eg. media_disp2_pix is set to 71900000Hz, when media_ldb
> is (later) set to 503300000Hz, media_disp2_pix is updated to 503300000Hz
> as well, which clearly does not make sense. We want it to stay at
> 71900000Hz during the subtree walk.
>=20
> Achieving this is the purpose of the new clock flag:
> CLK_NO_RATE_CHANGE_DURING_PROPAGATION
>=20
> Please note, if the kernel was setting the ldb clock before a pixel
> clock, the result would be different, and this is also what this patch
> is trying to solve.
>=20
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
> In all cases, the LDB must be aware of the device configuration, and ask
> for a clever frequency, we will never cope with slightly aware drivers
> when addressing this kind of subtle situation.
> ---
>  drivers/clk/clk.c            | 9 +++++++--
>  include/linux/clk-provider.h | 2 ++
>  2 files changed, 9 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index adfc5bfb93b5a65b6f58c52ca2c432d651f7dd7d..94d93470479e77769e63e9746=
2b176261103b552 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -1927,7 +1927,6 @@ long clk_get_accuracy(struct clk *clk)
>  }
>  EXPORT_SYMBOL_GPL(clk_get_accuracy);
> =20
> -__maybe_unused
>  static unsigned long clk_determine(struct clk_core *core, unsigned long =
rate)
>  {
>  	struct clk_rate_request req =3D {};
> @@ -2272,7 +2271,13 @@ static void clk_calc_subtree(struct clk_core *core)
>  {
>  	struct clk_core *child;
> =20
> -	core->new_rate =3D clk_recalc(core, core->parent->new_rate);
> +	if (core->flags & CLK_NO_RATE_CHANGE_DURING_PROPAGATION) {
> +		core->new_rate =3D clk_determine(core, core->rate);
> +		if (!core->new_rate)
> +			core->new_rate =3D clk_recalc(core, core->parent->new_rate);
> +	} else {
> +		core->new_rate =3D clk_recalc(core, core->parent->new_rate);
> +	}

Sorry, it's not clear to me how it works. How will the parent clocks
will get notified to adjust their dividers in that scenario? Also, what
if they can't?

Maxime

--naq5whtgj6roz2n5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ2Fy9QAKCRAnX84Zoj2+
dpvBAYC0JG03qrT2KpyfhWHAqJ5sfZn8G59BZ1L3eb8a1FP1Ve8FJuWCBsWF9bVX
CXfoByQBf0rzds0VJsH7s7/WVkbIlNGw6T1cDMU2x6WW2ywBG8h0QGxr3b8AwMlw
5MsXjXxJHA==
=pi7k
-----END PGP SIGNATURE-----

--naq5whtgj6roz2n5--


