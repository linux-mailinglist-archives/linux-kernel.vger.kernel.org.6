Return-Path: <linux-kernel+bounces-313387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE3496A4D1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 18:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08D89B26C68
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 16:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8575A18CBEE;
	Tue,  3 Sep 2024 16:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RRadP83q"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5947C17BED3
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 16:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725382118; cv=none; b=WKvc0/PposzsblD4yUc/dDXrpTNO02r5Yxtpj0BM6jk15kxaCzyN9p6CF5sVjwr41ceCJ9HlSMfztTJX1C34FzYOFniEoOhNaaQv+LaG0ZC6R2JgCHAwnHboVAjLn2rQehXH9aCDUXBCSlUnzZyewCumvnI/XuEks5pP8NnBrjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725382118; c=relaxed/simple;
	bh=JUABkBov1BTpP8X1cXy8Wu9gRM5Z5iLqdXxeMqPSSEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cuOyBRXx+B3xYcp1eZzXasEF8+7KVyR7dL1vbUZv+uhQ0HGEdnu2IOAzXxyLhL8xZTp6+FnCn/3FHXy4cfCAOca7J14gI0Ug0CnAuOqc7IkNrhi0Ynqn/6apSq9czedASmFKxZqs7Yk6JOZN24flaNVj3YgtDce3YXHwNoeloEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=RRadP83q; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53349d3071eso7322785e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 09:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725382114; x=1725986914; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/N3PvcbOxJEyoCocEYxC10jX1CQUHnVIF3e6bgsLpns=;
        b=RRadP83qchmqTrBI5ZVG95Q2hnh8TvQM14nO49o4T8Bwm2qKXjEtGfhYsPl91HSXWm
         JsFpAF61CcykPOOReGalF2sbHCmwiXm4DmMO1Ekh/iTghQMjUs1c/Ayl0BaMfDRyqr3A
         Bm0fainJQzpBVNHMyYr2TdRMkM2VUcJ/JyNpsf4j/QZXx/2jyO6evCPDTO56REImlGCE
         JGwY67FXtw7PNf6mf37S/AfTPa/xV/cGAww9Shysif65M568cl+kMY6qaIsMaeWBBKIA
         DH1P/mbz/16MbMVcNvmxnb1cdQT4A82Ha0Dladng6kTe266/50IdBNM9AgUYD0zWH3i+
         BgkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725382114; x=1725986914;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/N3PvcbOxJEyoCocEYxC10jX1CQUHnVIF3e6bgsLpns=;
        b=lLzjKSBiSZkUMBFooiR3AI9SVJIoySnEb/fnCaj8W8epblTyXkQxHnTGCvKy6bOc8H
         BVdFU5gGaugSkMGM9pQz3HIkH25C4M8hxOzhUxqIcnFd5a61LZNzqyxobh4k+vIoTxm8
         3AAQ/a6HpNw96vPJ9W/dl0IcohIJyFlEnhea1R/Xt5ZOGAJn3SbjKZ6KVdrf3h/Oq32I
         bKaagvXJVNOlU+x8MEuD89WBd6S94GMcg438r2abhURKmu9fsszXKyMpyko1jx6G3w05
         vBJiiGQavpV/V4CJoP0tRJThF5reMTnAyMAZkGnjM4lNPKco1b/8G9CSQ/JBUxY2xo72
         x5Ow==
X-Forwarded-Encrypted: i=1; AJvYcCVN68tlIR6kITiTDmbSDAlig4WY1bh8PMv3MtxL66l4Lj6KiZsECDhz8xhiFIgYiJLpS3cAGFCPerK/KtY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRKUOITIIcJfVCusnB3VaMmBFqVZM6AXaRd75OFNiq+x8k4sRK
	t1i8WyAULI90HyyTuTHIRkdpEhH2lH10VrwEoUphYy6kBav8xm7+27LFH5OkZzL2PTiOuFN5iR9
	L
X-Google-Smtp-Source: AGHT+IEpu3Q/jFO70kBzSh93T6Qwv4WexikxqzsC65yGsBSq1beGHqeLzWkh9GJIUhCSyIDtKtfsQw==
X-Received: by 2002:a05:6512:6d2:b0:52f:cffd:39f9 with SMTP id 2adb3069b0e04-53546b2c596mr10142123e87.24.1725382114159;
        Tue, 03 Sep 2024 09:48:34 -0700 (PDT)
Received: from localhost (p5dc68f76.dip0.t-ipconnect.de. [93.198.143.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891a3e52sm693125766b.116.2024.09.03.09.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 09:48:33 -0700 (PDT)
Date: Tue, 3 Sep 2024 18:48:32 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Rob Herring <robh@kernel.org>, linux-pwm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, Trevor Gamblin <tgamblin@baylibre.com>
Subject: Re: [PATCH] pwm: lp3943: Fix signedness bug in lp3943_pwm_parse_dt()
Message-ID: <e42tqtowldqybyqf33xgkj5lc6u4bmmxkv7dr6mnqswicsinql@mevowrbo2umz>
References: <5e74df19-4469-4a10-8b87-e918769a2f9f@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4xrlgwefelnzgxs6"
Content-Disposition: inline
In-Reply-To: <5e74df19-4469-4a10-8b87-e918769a2f9f@stanley.mountain>


--4xrlgwefelnzgxs6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 09:43:11AM +0300, Dan Carpenter wrote:
> The "num_outputs" variable needs to be signed for the error checking for
> of_property_count_u32_elems() to work correctly.  If the property is not
> present then we're supposed to continue, but in the current code we will
> try to allocate negative bytes, which will fail and it returns -ENOMEM.
>=20
> Fixes: d6a56f3bb650 ("pwm: lp3943: Use of_property_count_u32_elems() to g=
et property length")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/pwm/pwm-lp3943.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/pwm/pwm-lp3943.c b/drivers/pwm/pwm-lp3943.c
> index f0e94c9e5956..803ecd6435cc 100644
> --- a/drivers/pwm/pwm-lp3943.c
> +++ b/drivers/pwm/pwm-lp3943.c
> @@ -219,7 +219,7 @@ static int lp3943_pwm_parse_dt(struct device *dev,
>  	struct lp3943_pwm_map *pwm_map;
>  	enum lp3943_pwm_output *output;
>  	int i, err, count =3D 0;
> -	u32 num_outputs;
> +	int num_outputs;
> =20
>  	if (!node)
>  		return -EINVAL;

This issue is fixed since next-20240812 with the similar commit
adef9a535479 ("pwm: lp3943: Fix an incorrect type in
lp3943_pwm_parse_dt()"). (Up to next-20240830 the commit id was
861a4272660a, I rewrote that commit because I got the Fixes line wrong.)

For this reason I marked this patch as "Not Applicable" in patchwork.

Best regards
Uwe

--4xrlgwefelnzgxs6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmbXPd0ACgkQj4D7WH0S
/k7B9QgAp0kiihdPrzH5PDixrMEQeS8JDzUGoLQxGPzbSd/on3WPnuh593JQi8Fb
JlFjK8jldFhAOFuBoHU7eyg5MyyycNhILBHPWz1WUbYEe9mwjMyHUs6lSSFGlmpC
A3YP+yCv1lxQ1Da7fm+xdZsRLiHFhcY9udJhA4TLh7WT2KKwl7+YKvD80nhd60x2
BTgJgJiIDO+Gm0iHYxSuOB4ConG8ywXOTMZ9mfi0yE6OJpTiGIcx/M0NLTOm5RCF
fiyBpnNctEHaqn1HKEnLSiZJ37F+IunkjtjYj8pKYRgLAen86jQSfJ8JKMqmfnVF
NwG2o9aYbLJ3+sofyKQ8zHmGfiFh8g==
=n4Cp
-----END PGP SIGNATURE-----

--4xrlgwefelnzgxs6--

