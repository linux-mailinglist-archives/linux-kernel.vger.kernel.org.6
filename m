Return-Path: <linux-kernel+bounces-208627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE85902750
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 18:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 684C32878AE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 16:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B59214D2A3;
	Mon, 10 Jun 2024 16:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="LmDXmJ3Y"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BC614B970
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 16:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718038402; cv=none; b=eXOQGf7L1iu20MrKkAr2A7OtaLht7DBP3Rxn5Cxc0oFpe4BPiwiIkmSujBJUgLGg2TLhA9mC68+ndrQ2asSVTxxMjbRvPTbCl8im/gtkmQxnRwL4D4X10w9Gfv/WPnGMhZw3OZORT6v9QXPljz8duoMW3RwB+DVU7WJjOJ2uGgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718038402; c=relaxed/simple;
	bh=BES8ee5sXlc5zmrxJY2BlnRPRIoI2IPGXq+EX3VR1No=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A0bK1lyoOf31Ngq8/vbjcSOdAUdXs6F4WY8msclIm/BHrbe3qkEFEVjSETIE9vLnCDgygvKBfepARIzvl4zD/M+cIBjETKTsRrEsW9Co0Pf2zFi9pxsl2YJdTe1DlBmdbfdGJrYVe8ugd5IOwdFvm6b3wSbiA2yj84Cs2o5B1a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=LmDXmJ3Y; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a6f0e153eddso242820066b.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 09:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718038399; x=1718643199; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BES8ee5sXlc5zmrxJY2BlnRPRIoI2IPGXq+EX3VR1No=;
        b=LmDXmJ3Yzniv81WTRdsZrtyZG1y6KoqY2FzHq6MQ5drqhYzqqrl4x6g+Pq1dUZk11L
         N5m1aeKPAKW9+sdMceZiP9qUStPbxCZNKAsJOPl4bpq7ecpL7xUSi8empeWWkadyfDGE
         Lcow7q+hnKY8QXz1ifZnNRqqYBe206OMLOFWnjDDfbM6z+I8U1wQrr7au6g1ASJJl2up
         dM60+egFWlFm8MCe4C3VRaEfTtxs1CSENpAa2KTR5Rfi5EsbinMdIuWhy7orHbmiYUxA
         QZkJdzEnW6yBW1PKOnnVYmcjThZa0xIypG5MNpMJ//UsGGY7DJlC10ORrtS/Sppn3qYz
         eAkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718038399; x=1718643199;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BES8ee5sXlc5zmrxJY2BlnRPRIoI2IPGXq+EX3VR1No=;
        b=jDFTtw2rAeDoyWAfCqtQiSsj5IXYZuEHbA4hfgcR2hA75zLxH6MAJlQzuot2AdbOaU
         szUbpDtrAOSxx0MjFVhWh0UwlOf9+nTMIfnROymC8AToE+SfpjLimuIdr/fxq+9MiYZl
         Eucdyxq5whwj2HO0lbWcCYQTYC7SDLlKhV7cg7R0yEdQzYkC0ZoOG717JgEICx6D8zC7
         0RY17i+HfabjTdhrRx729d/KNb5MJm0fsXGK3uck35AzpcahaNoGbdE99bAAkJ908EMV
         UGBV/bMgBz5kEyGMylTtZpahKKXlGSgAIYccOOryXI5J010+EnMg6h1CWLeWsO+YGSZZ
         OMhg==
X-Forwarded-Encrypted: i=1; AJvYcCVBbN1SPcHz2IfVdgYb5qCc+fC+Jba/9mICUkqAvR6Bq4XQklqsaj1a77f0UWf+wqqdM1a45s5CZgsme01CXRC4mED6zxgW0YNvN0s9
X-Gm-Message-State: AOJu0YwENqVuh5P9v0G5qVVFdWJojjJC0SD5pdFWcfDVtuMVkH0Vp23Y
	vXHHUWt6Vugf3h2P0FZEwZWxfTNIs2axyf+zZcbG7gPD9BHQWuCIhzFEZc9tswY=
X-Google-Smtp-Source: AGHT+IFEYSFuraPOa+WYVzdaL+ESVBNKCRmo08LglRUMqvJEaK4g/mE7UxIj5Y6FmBNmUXmvs8sJdQ==
X-Received: by 2002:a17:906:e20c:b0:a6f:26a5:9f5f with SMTP id a640c23a62f3a-a6f26a5a0a5mr142869266b.42.1718038398698;
        Mon, 10 Jun 2024 09:53:18 -0700 (PDT)
Received: from localhost (p200300f65f283b00ca876ee5dd3d1e3b.dip0.t-ipconnect.de. [2003:f6:5f28:3b00:ca87:6ee5:dd3d:1e3b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f20563a26sm133567866b.129.2024.06.10.09.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 09:53:18 -0700 (PDT)
Date: Mon, 10 Jun 2024 18:53:16 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-pwm@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] pwm: add missing MODULE_DESCRIPTION() macros
Message-ID: <t4xkx7mmokgj3lqmcl222s223obdahpqp6sqxgwaohisbqlbib@vitt25ggsezf>
References: <20240610-md-drivers-pwm-v2-1-b337cfaa70ea@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lp35xxqvbjr4igp3"
Content-Disposition: inline
In-Reply-To: <20240610-md-drivers-pwm-v2-1-b337cfaa70ea@quicinc.com>


--lp35xxqvbjr4igp3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Jeff,

On Mon, Jun 10, 2024 at 07:51:15AM -0700, Jeff Johnson wrote:
> make allmodconfig && make W=3D1 C=3D1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pwm/pwm-imx1.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pwm/pwm-imx27.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pwm/pwm-intel-l=
gm.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pwm/pwm-mediate=
k.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pwm/pwm-pxa.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pwm/pwm-samsung=
=2Eo
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pwm/pwm-spear.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pwm/pwm-viscont=
i.o
>=20
> Add the missing invocations of the MODULE_DESCRIPTION() macro.
>=20
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Thanks for the respin. Applied for next to

https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next

Thanks
Uwe

--lp35xxqvbjr4igp3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmZnL3kACgkQj4D7WH0S
/k7Y/gf+Oi0+dsAnW1E2XuJ43To/HG6xmMhALT1XJIHtAS1SRiuCRQ/KVw0Y07Ik
Nr5ZJapzijm9o/YiKy3vJyMVEjozrO7E3AummZ24ZMBL7Ggz3EroPRAj8+l2v60k
oz7i+Vs34vCraZGsPucTn52EuCnRMBh53fhz6bsKVKtOzNUD33k6c4V/BN9bIHfd
MJpqwTO3ejnSMAUdC6ZPJc7ZTeddyiPi6u/I1UIm43Gud/1XGcnVXx7PL34kwB2R
ng5cjCPGoiBYXfftDskl72+f2upFM5eJfueti5qqlGaT/C+wUxXQG3w5TGadSPmM
00uycs1SX65h65o8xSssTRGIFQtOuQ==
=OGvB
-----END PGP SIGNATURE-----

--lp35xxqvbjr4igp3--

