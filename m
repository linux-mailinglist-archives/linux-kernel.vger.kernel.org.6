Return-Path: <linux-kernel+bounces-393952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB669BA7E0
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 21:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC27B1F215D7
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 20:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F96018BB84;
	Sun,  3 Nov 2024 20:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XBG74UOH"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5988715E5CA
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 20:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730665183; cv=none; b=nN6zwaLm0CAiHnXkmh0GnOPGbxouzPAsU6oNECa5vZMEyyEI/uW9wpvZn1YdPwipSazlHPkZZZKWUb5PZIjN2XsdcjhrVfKUuS8Hv2FRE37AeREAqlY0LBM818WQQgCIEDh5YTCWd9wQrbIkZfv28NDXHgP0s4d/3Smm8TRQwaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730665183; c=relaxed/simple;
	bh=hens1xIftorK4ZrqpMt+qKo/Cz5oKEsIOR94JjDV01s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sb+jZ/4c2VSR0aOHrcih67RPS8MDDCP2uW32LOR289vfKOJVN/lVtNfTK2gsFeRst2MH914yCF1nVcvonuqvIHHtveyzGsosIiNDE6QJOhjj58XzcRdPw3EX+duYpZ6PW90tTdqbxAGczURYZciik6tuCTWN5dQSg/GsoHxbrRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=XBG74UOH; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a99cc265e0aso578843666b.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2024 12:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730665179; x=1731269979; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hens1xIftorK4ZrqpMt+qKo/Cz5oKEsIOR94JjDV01s=;
        b=XBG74UOHqD3yYeqh0T8vK1u9S2CAu8NIGhI1C9xGXQ8pTR/wnLsfbtS8cTnnkOaHtL
         ZkwWKjko4SgfZqo0kdUjdUiuba/8VNt112RlKlydN/6FQamkUiO2Foe5WaT6cXE47Rrw
         /m/HWp2oZRZLwBhxSxVvald8rfzKZBfUUH9PW9YHKYApaVSVftBgy+mZ1F216s8kvWSz
         PW70ETLfWFNZyjCN/Pkwzciee/k3ZT4AL2FALwHYM4kVl1k52brfi8nsTLxJ8UlEXobO
         QHUnH/5F04R9Xvovc5k3ve5VXoPAu88eVrMkReesJcOichQd2PRikUeefezEz7phHnXm
         7GEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730665179; x=1731269979;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hens1xIftorK4ZrqpMt+qKo/Cz5oKEsIOR94JjDV01s=;
        b=P2jdHHIX/Vf3O+0tn6CNcOsl7IV9zRjDxmZW6WnNHVK2UOSHxOzZJsRDyHzSZ8Y6iM
         ALi98HhMx6cSiN4RenNzKWE6OYLJT3GJ+hnByUweBojOYenz9L7RnFWpLFaUUqmYgCcr
         Chw/0LL1n49GS3WJ8+yc+StDWZVqC2e0DEqTwafBBPHdBo+zXb5Ze4EpIwumm/rIZQKm
         /+oup+VFuwI+3y2OWXpioyc+IdtHwoJZQtSio3a+Tyo2PlG/0DnS1BDIWCKpyF587Mj4
         3iysfnqoRj5BOqFCXQ7Lb6esYpsuzdI49rDZFmiwCiM71riuVkuVw4WCs6MGI3Q89fDJ
         +DCA==
X-Forwarded-Encrypted: i=1; AJvYcCVdYmiqL1Fd+n+r5x2fMBx6LouMNnljvF62f+zQ1IVaNCtloXR3un4f/DHaYoT28VIyOy4yWLPXT7hjWM8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaKsn0cdHlx4/saSEbhG7I/puO+TAdl0GvcmY0otKRvksbVVMJ
	RzbkA6T8Gfa6aEkqmyOykxoA+k0aF1n6p6bNz3p15tt3jIwsCoKc/7xD0jzqHyc=
X-Google-Smtp-Source: AGHT+IGIIEAHdipgKQyS1aLmp1UDkIbcGQhT6P+qz86TQguUuILVSngulEZEFM4YCq3fntFPAHVrnw==
X-Received: by 2002:a17:907:7e89:b0:a9a:26a1:1963 with SMTP id a640c23a62f3a-a9de5d6ebbfmr2920761666b.7.1730665179427;
        Sun, 03 Nov 2024 12:19:39 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:711f:c21d:28dc:9f01])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e5667d1aesm459803666b.196.2024.11.03.12.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 12:19:38 -0800 (PST)
Date: Sun, 3 Nov 2024 21:19:36 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] pwm: add support for NXPs high-side switch
 MC33XS2410
Message-ID: <atkj7wnhl4n6frl5swjwrto6r6dhofjtnqisqrn5z6w3cmfl3h@dgqgdxovrqb4>
References: <20240927125745.38367-1-dima.fedrau@gmail.com>
 <20240927125745.38367-3-dima.fedrau@gmail.com>
 <oppdnsda4tqjcpsb26j5ew62t4bkkmtxuu7e2fpinnazubk5ky@tmz76o5xdrlj>
 <20241023125221.GA197308@debian>
 <eyom32milbbqp6floun4r5bpozuewbe5kk2htvhp5cmcytj2oy@bpcrd2aiwk6m>
 <20241103190709.GA466098@debian>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jnr2zqzujd7wjwx6"
Content-Disposition: inline
In-Reply-To: <20241103190709.GA466098@debian>


--jnr2zqzujd7wjwx6
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 2/2] pwm: add support for NXPs high-side switch
 MC33XS2410
MIME-Version: 1.0

Hello Dimitri,

On Sun, Nov 03, 2024 at 08:07:09PM +0100, Dimitri Fedrau wrote:
> Am Thu, Oct 24, 2024 at 11:19:16PM +0200 schrieb Uwe Kleine-K=F6nig:
> > What breaks if you drop the check for state->enabled?
> > =20
> The device is unable to generate a 0% duty cycle, to support this you
> proposed in an earlier review to disable the output. Without checking if
> the output is disabled, the mc33xs2410_pwm_get_state function returns the
> wrong duty cycle for a previously setted 0% duty cycle. A "0" value in the
> MC33XS2410_PWM_DC register means that the relative duty cylce is 1/256. As
> a result there are complaints if PWM_DEBUG is enabled.

I fail to follow. If .enabled=3Dtrue + .duty_cycle=3D0 is requested you
disable. That's fine. However it shouldn't be necessary to use
state->enabled in .get_state(). I didn't look at the actual code, but if
you provide a sequence of writes to /sys that trigger a PWM_DEBUG
output, I'll take another look.

Best regards
Uwe

--jnr2zqzujd7wjwx6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmcn2tAACgkQj4D7WH0S
/k5+bggAgl8Geywor2S7f3FoUh/cNsP/r1b6UFqQgt52E11PPn/n2GZZvyFXsMY+
Gpa1iGahqeInYPgE/8AAzT8h00mmQaLkYwvtNlNCUyoB6JrqkxPdoL4/gG2aPaM1
pPrD/JBjcNdmmqEPFoWF5adBqPs4s2E73uXbMfhO3uEfAAuMMfKOCIIOPSBDgQhy
dbZAzyR75jVPSIzSO7HaroRO+ceOKMf8WuZs6hn3B7YmiIgx1QBrAqh+fkWpjbXb
dlvsZ2GQR+vgOvUoc8ivMJRt6BwlQNOZB1JtjpLu0DkrustIY0C1W071fMfbbJBv
XLKXFBY8gdm7w4IcL0W30dVPuK7UEA==
=IMZH
-----END PGP SIGNATURE-----

--jnr2zqzujd7wjwx6--

