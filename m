Return-Path: <linux-kernel+bounces-233770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA6391BCE0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 12:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 275621C2200A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 10:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A85D155A32;
	Fri, 28 Jun 2024 10:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KeHDYMX6"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738F72139A8
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 10:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719571908; cv=none; b=nicW7yhDsoo57KNZZl20PIczl/c4hgtO4K2ayBEGSsPC9rPULja4lDo8bPIantHLF0rAwfUF1MNTcLoaI7dI2lkLOktrCYNSwj8pquio0/Xa73w7TeXBA4tLroTWkrYRfCrkAV5YqgfFrI58qvQrlNuSbiRG2RshvYjCfS8R3tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719571908; c=relaxed/simple;
	bh=yC3zrmJsDFn4NNsURX00uMCRtNgsdOVTIJqhvdm5cQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mpKAFojxJYT4rrsTShC+KB5zF8GFCnzaKCNeOeipeqtQbwt9qLXA1CRVw1oFOFdhp+9QZ/FaaN+ECXCZORthhXp6PSqquGzx2bHPgB9OHkiKSec3KftGlrIji1BC5ro6MxF0A+NZ+5jUUQapcQObB7GGZppCrxZzTky9TWwnuG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=KeHDYMX6; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-425624255f3so2994995e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 03:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719571905; x=1720176705; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=24rzTIfM+vOUQFqHFBXjGKtWGaOLrsXGcAgDzPUbzu4=;
        b=KeHDYMX6sQHen7GTIcU1mBqop+EEf9dirb6BXudSsp0MJhwdeSSBkzShPfDBCqcPLp
         rMUC0tp+ExwNPUYJ03ULsuoF0h1JLbWLHgTLmCMimR+rjCSa4LdgnYZ/+FAxS2EuO5Ai
         oTZ/a3aFE4ge5NGdiVRBNQVydkpAo8jEG64BfqK3Am4MNOzLdewBryW6oDyg4hAT5WOi
         +Mk1kGmJgjPllI80jERykJ+VmQdAyiHZ9dACo0unenWC9RzIP/kGNxAV9Thn0ifIkYot
         UdYOMTowTQTMGVF5GoCxLRzU5MoRSvizg0/YQFc/QAtZxWW71n+/ZaBYADPm5eGp2Ayg
         +GyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719571905; x=1720176705;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=24rzTIfM+vOUQFqHFBXjGKtWGaOLrsXGcAgDzPUbzu4=;
        b=J1OdbroM8nBlOX1JRGEdghDpwZfcQ97oFKPeLEcqhN9j4Cb6S1DmtuevQYX2uYrzAe
         Bt85O8ZgXbORoToe0veKsWxptWO82+fQmRJYhRAVLHRDFxVkNelncA5Lp7xAC6NvsKs5
         8ZSblvysQyEnkaQm5ioTDTI55eRSKzdAJxEWlL2tRT4NaJQ9QSk4xreCeDrqzhnGnCO/
         ZADy0TQ61xlJisWGiIYGEc2r4AkIBf7CRMC6yb2VbTedaxSzScXvQXwOPwmX4RPHfvp9
         9GHy2Teud0ZMlJmdUm/Uy/lhdP+1S8Xv7Q3eqmwedc8Yc/Jul+pegwvmnoQz9TONjcdL
         3xbg==
X-Forwarded-Encrypted: i=1; AJvYcCXSmoTTsNHMb3gkc7fQvXVwRAw0qemNhaApSVawNMTf8X1wdSYh3pyNEdBfAalZxm+bejAp1P6fnKV0qbU1UCAh2zJRnU2N7DgFlx+n
X-Gm-Message-State: AOJu0YwrSCVqfG+T1lXyxCXqdi0c8GBnVQr26wYroJake8hiAYPfOvtW
	Y2ZgSCM/758R93jOCks/zAN0jdk11Z3hD9MCHN/q5++8YVcyJQhsbXIjzG+va/E=
X-Google-Smtp-Source: AGHT+IEk/iGdd84gJ4j2qvNNhASVwVZ9UV0L9RuSnlH6TwRAjAnRiiHru5Ptw881AQ0IzfYy6F1GzQ==
X-Received: by 2002:a05:600c:1616:b0:421:b65d:2235 with SMTP id 5b1f17b1804b1-4256d4246f3mr13155895e9.0.1719571904866;
        Fri, 28 Jun 2024 03:51:44 -0700 (PDT)
Received: from localhost (p50915e7b.dip0.t-ipconnect.de. [80.145.94.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4249b4233b3sm84824425e9.0.2024.06.28.03.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 03:51:44 -0700 (PDT)
Date: Fri, 28 Jun 2024 12:51:43 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: linus.walleij@linaro.org, dan.carpenter@linaro.org, 
	linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, aisheng.dong@nxp.com, festevam@gmail.com, shawnguo@kernel.org, 
	kernel@pengutronix.de, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V3 1/3] pinctrl: ti: iodelay: Use scope based
 of_node_put() cleanups
Message-ID: <dldl7dkdcsuajjjpg2pczfnupqrsghmpz27i45xi5beeou5ntg@y2ysounw3pqq>
References: <20240627131721.678727-1-peng.fan@oss.nxp.com>
 <20240627131721.678727-2-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fbfmjvvswzyejj4y"
Content-Disposition: inline
In-Reply-To: <20240627131721.678727-2-peng.fan@oss.nxp.com>


--fbfmjvvswzyejj4y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Peng,

On Thu, Jun 27, 2024 at 09:17:19PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
>=20
> Use scope based of_node_put() cleanup to simplify code.
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/pinctrl/ti/pinctrl-ti-iodelay.c | 43 +++++++++----------------
>  1 file changed, 15 insertions(+), 28 deletions(-)
>=20
> diff --git a/drivers/pinctrl/ti/pinctrl-ti-iodelay.c b/drivers/pinctrl/ti=
/pinctrl-ti-iodelay.c
> index ef9758638501..f5e5a23d2226 100644
> --- a/drivers/pinctrl/ti/pinctrl-ti-iodelay.c
> +++ b/drivers/pinctrl/ti/pinctrl-ti-iodelay.c
> @@ -822,53 +822,48 @@ MODULE_DEVICE_TABLE(of, ti_iodelay_of_match);
>  static int ti_iodelay_probe(struct platform_device *pdev)
>  {
>  	struct device *dev =3D &pdev->dev;
> -	struct device_node *np =3D of_node_get(dev->of_node);
> +	struct device_node *np __free(device_node) =3D of_node_get(dev->of_node=
);

of_node_put? -------------------------------------------^

Best regards
Uwe

--fbfmjvvswzyejj4y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmZ+lbwACgkQj4D7WH0S
/k507QgAp3CUpkL3MAeTxcSbGb2q3fYllnUF2w6t16mJ9xh6+hDLS9FBcJ6O4AyY
kfpU0V1qpde9069gwMOiEFDkWetC+p0oivQ5VP5/+qesfrOrP/Xlr+TRL1zTtv84
OoV+pxdYC5nFaHgtymb4Sj9ixL4HpxAdlZ1gwF99BtJK/qW9JymS3K/DOVzsvmwe
7uIdatoBkLDNIf+QsByESnmWnWsdv0qeUq00WBUCX62TlAcZuzjLhROUz1Odgy75
no4hamGZVW4Q/fXIFEyWWgAu5YLTGDZx5c5bI4nKYuwscGDwRbQ7xiGfjIcYgEOZ
AfMzaxHv9AbFEoueeQ6q0rfMts8XsA==
=uBDP
-----END PGP SIGNATURE-----

--fbfmjvvswzyejj4y--

