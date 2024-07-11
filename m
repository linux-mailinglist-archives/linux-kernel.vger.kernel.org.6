Return-Path: <linux-kernel+bounces-248717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA17F92E10A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 09:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D06DC1C21997
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 07:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BE514B095;
	Thu, 11 Jul 2024 07:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="N2dnexUb"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BB7148FE8
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 07:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720683781; cv=none; b=i2LOt8KYZz3HK12cFn7crswFfHitawY9ys5qEkLqhlnJTyRYYK4wXcDagWbX8k+ltBhlUNlYFCyCgus7uNlAt4nfK1CaC7hyxd00eqPjRGmmGBFXXKZ/KRq4H0+Zg+hlSDXBoLRSPhVtZt6eY2F8/SL06Z4x+RakC5kvD8OFjEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720683781; c=relaxed/simple;
	bh=G81cigNbMK6zWyW2W1HCYkHinVRR6rcbhQNJ6dX3Y30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VAuHo5DMnHydGbWSZmvpiLmPfCAk1RTc3Dp+scUIgTypueJSJ7i1fYXTOPAjJmZ+Ov1ndFwhpEwk/m1GckB8WMG7WaHcveyq5ShAedc6jX1iKQQsJsG57zaDYZ2uVXqaAwLkHu6BO9B2cXAoqFk3mzL1NibTew98jv6bjEVCd68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=N2dnexUb; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a77af4cd570so46444266b.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 00:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720683777; x=1721288577; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h+0UinpQWYDjXlEY0DNC8WhJW4LGHBJDtPZ/QPhsn/c=;
        b=N2dnexUbiqGCFvm0Lq3uHVQ1PdaOmdTuNnJIskMtHNNo+3DdD81L9nx5HZMpPSdBbW
         1V3E6+IDkNheCEKqq1swGimhT53ln4wd+99mgN1TkSZHC7ODyiWQsFTsMfx7gQte+J1h
         QXEul4/DSYK9i4EX3Xt0ecrnzXS7cuoP1FK2A6WUiR+yXfy65BWFQ98v+QIIDs8rbTB3
         HpaQ/aCgKsB/Erx0Sxc1PnI91gEYQQZP/c673NPimvECzzOeDmg2EHDra73wN/4MyAs/
         AgezgWRnz/qJbELhMzkA1jK6Ga46X9DMtM9h+Nx6BcW7pjh99oo+Img2kNS2L+OZalMw
         5YOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720683777; x=1721288577;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h+0UinpQWYDjXlEY0DNC8WhJW4LGHBJDtPZ/QPhsn/c=;
        b=BsMTa7yEUpB2NvsqV61TY6nwBC63PoaES3xE7UhXbohNoB+ip2ap31OcsTH4g+W0Js
         gjo9e/iIrFxo4flLt+EYDnb2ngcUbkqnlJ3Vfm763e3UxXYbNulCFFVEN9bx9lB0lf9P
         KPMVUU/OZdttLAsVIQWO3hlCb5B1HyGFnUmMJJWFGZcwkteZE57QPKnDYplQWQl8SaS4
         JOD7QwaVNNfv6gGFmOa1re8M9tSFYF4y4kiQKM6FIokHIMsP3GSMu0wlL/IW7CiirUTb
         Y6JZdUZY/STC2shdW7599YC6BwEdVCKenFbs7BryvllM5quCJYVLKCiS29t4YABXHKCN
         kMgA==
X-Forwarded-Encrypted: i=1; AJvYcCWqKbqYggVxFG8BfxV0vtLzwPf5xB1DKR93ubOYHKNLSavQ8XP9+40OlaJH+QEae7mZUucu+3G+uouR6F88UIB2veHC/JNpJVzSly1N
X-Gm-Message-State: AOJu0YxCEBRDLeoGnZDMcq4M6Nclroq4c0YC0edbQxmYqWrH6OPEbWMY
	m+4Qp4a82/26EZniilFtvMrZnSQARQAFDRCw0zdLbe6qOqsBOVxspHUhwJw7hUg=
X-Google-Smtp-Source: AGHT+IFvTTSzRQIgpI5QuDDZSPJrH8SBm7+DLvvTVS9+yUrzFasx2IRMegwpJIpw057IqeT0V73jnA==
X-Received: by 2002:a05:6402:31aa:b0:58f:44fa:a2b9 with SMTP id 4fb4d7f45d1cf-594bb1816femr6223127a12.16.1720683777236;
        Thu, 11 Jul 2024 00:42:57 -0700 (PDT)
Received: from localhost (p50915eb1.dip0.t-ipconnect.de. [80.145.94.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a7ff7aesm230826666b.102.2024.07.11.00.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 00:42:56 -0700 (PDT)
Date: Thu, 11 Jul 2024 09:42:55 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: nicolas.ferre@microchip.com
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Conor Dooley <conor.dooley@microchip.com>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pwm: at91: Add sama7d65 compatible string
Message-ID: <mcbg5x3a6h2qt3ivtmve3xrhczg5juwzht7vjhzhactskpateg@7cffoor3avcr>
References: <20240710163651.343751-1-nicolas.ferre@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ua36aif6vqcebhyw"
Content-Disposition: inline
In-Reply-To: <20240710163651.343751-1-nicolas.ferre@microchip.com>


--ua36aif6vqcebhyw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 06:36:51PM +0200, nicolas.ferre@microchip.com wrote:
> From: Nicolas Ferre <nicolas.ferre@microchip.com>
>=20
> Add compatible string for sama7d65. Like sama7g5, it currently binds to
> "atmel,sama5d2-pwm" compatibility string for this driver, so add an
> "enum" to reflect that.
>=20
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Applied to

	https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for=
-next

with Krzysztof's Ack.

Thanks
Uwe

--ua36aif6vqcebhyw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmaPjP0ACgkQj4D7WH0S
/k4aFAgAjIU4ou60T/qTFOuMU6WCiCdJUwxmT3ZcyfcnqyXCF7wodIP0pXLAi3y0
Yos6AbIDdjYfeV9gWG7S8yHpKLlg9kYaLmwZQDsJn5gr6OXg79QOwHeuYBf/hqjy
IzB2LIojtcYGtB1GFNV5Ta8TF57vziklAPmFv7vdENreaIxS/0/6jfiX5uQmopLG
a53zjm5Bnr2NmeGyoGdPuQy7/8JJogeCCpjWkGuELq62Zr/42dN/1SojCmTss1Yi
xYhikLMnXypFHKcdgX77hBX+6rm7Cik7QqEN6UJHaACFl/KTI3x2cFKPDyIZfgZz
YQdGsL6NqaiFAIX/KIyRmM+7ZFZDzg==
=1TOl
-----END PGP SIGNATURE-----

--ua36aif6vqcebhyw--

