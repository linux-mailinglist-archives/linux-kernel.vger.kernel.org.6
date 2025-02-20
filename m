Return-Path: <linux-kernel+bounces-524472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED257A3E382
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 19:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3647179133
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 18:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC77214213;
	Thu, 20 Feb 2025 18:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VabyIUYV"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D8F1FAC30;
	Thu, 20 Feb 2025 18:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740075169; cv=none; b=ttUTWhWfUieiRePl/+1oQdXsXSjXnbpflkX6qHw//e+F7HH9l7UI6E1+5+1tUXBjpouLdUaJ5D/NK29bwLNjaOGCofeLb3UP2aaCcjO3wU8JEb6hq+J6S1YA/KsGb6GwakXVXkJ9VJy034lC77UeIa20BOX9JtawawezR+aNhDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740075169; c=relaxed/simple;
	bh=RVJ0Ui+e4wiQwjjazPtlbUqFxh8TiHfnG0fw+upHVBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YjOzCxot8W6bCl6UaqpZIuqlGIffwW2TAi8iaswnhWn74tOCn0tryAHjk2XLVrE/wpX60e+vFxP2HDhhP5Zq5UMoDGcP0BkVDLjAQILm/Hxye+VuahWQivN7NrfCcEtlERtFXraB0PiMrq+0r92Wu7K1x+wPDNbZ/rlyL+sO7/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VabyIUYV; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-38f286b5281so673262f8f.1;
        Thu, 20 Feb 2025 10:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740075166; x=1740679966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hf9BmegiktNtcY6HS4qZYakNRxia/v7+na1LdoL1VGI=;
        b=VabyIUYV3sVDetbVm7sSECrrdTE8/kD4Tp77zlnSdgwp11QJ+Qs40xTCtC2TjWrdeK
         /M+AfcrbRw8XB/mNrBjHaHB3S7TXMkGyABGt9ZOknh3MW06f3VQb6IYkqJEdxNvgOroz
         0cmvEoC2UT1GfmU+89DMVUq5zcl0Va8k/DoqDTZD8s9sswXJAt26t0P9gTc9HsCHxqE7
         aZ2VXaN10ccpKDCTiIqmiBD0tGOxanLhqYDoYiws4pqqmiTcZWlfXDkfO+7NwczVhuqx
         3C+n3tIea7jh6DpVXaYAQbaWwHDkYNDbv85mrDueNBR1VzZCU/3/NuvR1uLCM4IZuZNm
         ED0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740075166; x=1740679966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hf9BmegiktNtcY6HS4qZYakNRxia/v7+na1LdoL1VGI=;
        b=mbsgs33I0dNao/h5Vbl9CCN7U1GhyCwf1hKtXpYH9tN1by9m0z/QvXhh2s9o6qK/aw
         l6PRN8oGxEPMv2giya9UmZj09oZBnUhXs/W7peFc9jd97H6ZTDwzXZJns2uRt4m0CXXW
         yHtaGM2x5vsJhmiwd53qEgL4Vj1LsU5a6MkZt5YJXue2rFq+hJGljsvqxoKN7lfS2Aqv
         mGxj//qtLS1DorWRKF2cBhM/3a6Ctn0qJnfvN3UorteNs+VwRH9WzCHLm8c1IRLIMGdr
         x9iDj2zy1JoXl1hxR9y0GyNTzOSVoQJ/R6hxpPRVXuF7ugDg1zRGmK5KJ+QY5sewVf3e
         u96A==
X-Forwarded-Encrypted: i=1; AJvYcCVD7bligKGJArtFDKGAvwYfUOGFXMDS+3rBkkN6quuQZ/CJKMOJdN92s3sJ+5Q0PB6hl6757L8Rw3E=@vger.kernel.org, AJvYcCXYmUGJHiive6pwP8TVA21tz559i2xjpyBTQjusM1u2S24BttrQ/L/+qdzTWSZ6cT0qFvDAYzGDMXNST95s@vger.kernel.org
X-Gm-Message-State: AOJu0YxQLczEARdfIeSrJ+vH0q5E0CfO71G6rVqk8f8k5UTr3iSWEo4b
	oloCv4cqoD4fBUTvI+CabqEVXSd/j4ZutMPyozDLzpFatTzT9mP1
X-Gm-Gg: ASbGncudxbJS1bIiLK7DTc2lL1ZscNkB96Q4QKsf/SIZPuK5D3ET7AjTXUukVcSHOrB
	im8vC9N1nErvQUkpo8Y2QpATzBlalA9wYnhn9smz7aYw7jlf0phJ5492y/tjoOjE4pqL3KvThR+
	4SxPGYNhQ+l3vv5chf+Ux7DDeIhOkAthtVtRoDC615RdNNumKjvrW+VoUaRTQ5hx59Lb+XjLJdI
	DbUcTW4mdwm24tnkjl6CYW4nUbnrGkOoiYVEQr/mGoKtXaxo90IPTrEnb5QuVc65dJqvndssKfh
	qv8SSQJIE//YNWrFHCmHQDLJpfjfEqyArKpvFFtMQmkGaDcxII+0/0yHpzo73zjQOdE=
X-Google-Smtp-Source: AGHT+IG8SxlEpGzhrbOAaMiZSLB6w/8BQXRpKpsCxpcNHWG6kyfbSzJtzHPfDd1frA7kH4B1Z2SqFw==
X-Received: by 2002:a5d:6dd1:0:b0:38f:4f25:14a3 with SMTP id ffacd0b85a97d-38f6e979d1amr195111f8f.30.1740075166029;
        Thu, 20 Feb 2025 10:12:46 -0800 (PST)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258f5efdsm21016778f8f.43.2025.02.20.10.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 10:12:45 -0800 (PST)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Emilio =?UTF-8?B?TMOzcGV6?= <emilio@elopez.com.ar>,
 David Laight <david.laight.linux@gmail.com>,
 Anastasia Belova <abelova@astralinux.ru>
Cc: Anastasia Belova <abelova@astralinux.ru>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
 Maxime Ripard <mripard@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
Subject: Re: [PATCH] clk: sunxi: clean up rate counting
Date: Thu, 20 Feb 2025 19:12:43 +0100
Message-ID: <2385242.n0HT0TaD9V@jernej-laptop>
In-Reply-To: <20250203112930.650813-1-abelova@astralinux.ru>
References: <20250203112930.650813-1-abelova@astralinux.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne ponedeljek, 3. februar 2025 ob 12:29:28 Srednjeevropski standardni =C4=
=8Das je Anastasia Belova napisal(a):
> If n =3D 255, the result of multiplication of n and 24000000
> may not fit int type. Swap division and shift with multiplication.
>=20
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>=20
> Fixes: 6424e0aeebc4 ("clk: sunxi: rewrite sun9i_a80_get_pll4_factors()")
> Signed-off-by: Anastasia Belova <abelova@astralinux.ru>

While this should work, should we try to remove (old) sunxi clock drivers
instead? Drivers we converted 8 years ago, except A20 GMAC and A80 PRCM clo=
cks.
Even if we convert them now, we need some transition time for them.

Best regards,
Jernej

> ---
>  drivers/clk/sunxi/clk-sun9i-core.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/clk/sunxi/clk-sun9i-core.c b/drivers/clk/sunxi/clk-s=
un9i-core.c
> index d93c7a53c6c0..639c83ed63b8 100644
> --- a/drivers/clk/sunxi/clk-sun9i-core.c
> +++ b/drivers/clk/sunxi/clk-sun9i-core.c
> @@ -25,12 +25,12 @@
> =20
>  static void sun9i_a80_get_pll4_factors(struct factors_request *req)
>  {
> -	int n;
> -	int m =3D 1;
> -	int p =3D 1;
> +	unsigned int n;
> +	unsigned int m =3D 1;
> +	unsigned int p =3D 1;
> =20
>  	/* Normalize value to a 6 MHz multiple (24 MHz / 4) */
> -	n =3D DIV_ROUND_UP(req->rate, 6000000);
> +	n =3D DIV_ROUND_UP(req->rate, 6000000ul);
> =20
>  	/* If n is too large switch to steps of 12 MHz */
>  	if (n > 255) {
> @@ -50,7 +50,11 @@ static void sun9i_a80_get_pll4_factors(struct factors_=
request *req)
>  	else if (n < 12)
>  		n =3D 12;
> =20
> -	req->rate =3D ((24000000 * n) >> p) / (m + 1);
> +	/* Division and shift should be done before multiplication to
> +	 * avoid overflow. The result will be correct because '>> p' and
> +	 * '/ (m + 1)' are both just conditional 'divide by 2'
> +	 */
> +	req->rate =3D ((24000000ul >> p) / (m + 1)) * n;
>  	req->n =3D n;
>  	req->m =3D m;
>  	req->p =3D p;
>=20





