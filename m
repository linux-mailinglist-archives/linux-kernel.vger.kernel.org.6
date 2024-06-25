Return-Path: <linux-kernel+bounces-229103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B405E916AF5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 16:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D853F1C230C6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8703116D9DA;
	Tue, 25 Jun 2024 14:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qYfM3O/c"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C61216D31C
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 14:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719327015; cv=none; b=jUyuN7AnfbM8nJj3lILO6AJxfMsTWtOHfNbrCY0/sZ7EGQW+bSOIXR4PHsianPUDwPNuG7fFNEZBnKYCQ8GpE1viKZRplRvvA/Uotul3zxf72PJe1AIH+ZCeCykM+0ADiVmxSh0UWetR0Tj6iybtpxyXs7pi604t2Dq9zw5hn0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719327015; c=relaxed/simple;
	bh=jWqxo3mchFiP1MenyU8LEUTbrCGM0e3VDgqj6/yFdZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j+1ecaubJopSKgnjIT8uHK4tB8amGW5SOP+wEyMen6+FBYj8UX9q+F2sSZ6gdU4RoLY/G0XTDyHMUAYkvd/tprF+KuLGjC0wQ5zJucf7GNn8c8hxml5anCci5tZLz4Bjj3N9zyVF6OXgWgZXP96LFUS9Sg0eEpKz+DtjMLbxBQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qYfM3O/c; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a72510ebc3fso346743166b.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 07:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719327012; x=1719931812; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jWqxo3mchFiP1MenyU8LEUTbrCGM0e3VDgqj6/yFdZw=;
        b=qYfM3O/cTetPun2wmSIA5WBfU5YLvzRKVPMT5RZezoyhxu09FO6WTaC1JPSrVY/89k
         /c/iKot5HxBCtuoIT3djg6QuDV+4qDcFuUwVOlQcsNqZpgY/7oCMCMmOsDKrSOYsugj/
         cUtOM9O21jY7HeEzeoq44hj0eCGDwnXa5moL/VwvBmXs71aC0lGpz5UDnsiub/6Yol52
         eddjPhLGU1vjTOMMQGLjijo6tC0xXyaHLpDuJIUm53mKatOD0GXx924mSMvybTPWG98v
         gRFkcTIF/aK13mtBhIuMf9YySXZUkMZyliDvy3atp+KN5TC/XIY5Sat4k/7zcWntDVf5
         Eryg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719327012; x=1719931812;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jWqxo3mchFiP1MenyU8LEUTbrCGM0e3VDgqj6/yFdZw=;
        b=oYibcVPxQC5Yyf816t8xSfU5XILuQjo8lcH8tZmUuTRJnnqz61vrD3J5T3pVPvE5h+
         rTas6cfLpylelr8c8xBJEgaNTMY8nHAoYrCDPQOrissBHFEzJriH5tywJap11r5RFBPN
         FOX1fPyxU+Zfqk9SHx1wB19CYYP83TvBp2AlgGUjEWqwu6PNvNu7KUxCmSS8RELLOXIK
         xc1/hy+IShu3h5V+Ks4RtRVYfiZ3mrvK7oI61JEmKy/PvjjGReGXbOy979xmTo87Vwtq
         9BHK8oHbGDWN+fq5CvvKRm+DNWCzRVGX6hZqcxDqeRutcCfI3JAvBbQ0m7zDEcDxUeO7
         MY1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWAsO8jjyF9WxGsPhvkXkvQXu2vqZHXInYVV0oUh+bk/z5beeWoX1qnaTkiKdQXxTrjFl7OXpQiODD/z0xQ1oeDjt6omThMjkzPPdp/
X-Gm-Message-State: AOJu0YwETMwMqZ2CmP88iiuFUicKZ9vkrzvl5zlk/aaS4ZtFABMrV9O9
	+zUIisvsYCUnmrI+v6TdXv8GYFvRLYPrW9lbcf8l0ZNQNBGT3Rwfy3BKDe7QmjQ=
X-Google-Smtp-Source: AGHT+IEwnwBd/P6t2ddwhrLb8bvz6kYx+1hLSg0mmfREs2jeseCHj5DRkS89BkTTTiW651tXR4AAuQ==
X-Received: by 2002:a17:906:70d6:b0:a6f:e8ee:9e3c with SMTP id a640c23a62f3a-a7242c39107mr509610266b.22.1719327012436;
        Tue, 25 Jun 2024 07:50:12 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:aab0:97bd:4d50:ddf1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7120187c22sm373994466b.110.2024.06.25.07.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 07:50:12 -0700 (PDT)
Date: Tue, 25 Jun 2024 16:50:10 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Kelvin Zhang <kelvin.zhang@amlogic.com>
Cc: Junyi Zhao <junyi.zhao@amlogic.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, 
	Kelvin Zhang via B4 Relay <devnull+kelvin.zhang.amlogic.com@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v8 1/2] pwm: meson: Add support for Amlogic S4 PWM
Message-ID: <coriionza2db7jqz23bcig3zwufktgdbfakixcrlllxrqkomcj@zle67mswm346>
References: <20240613-s4-pwm-v8-0-b5bd0a768282@amlogic.com>
 <20240613-s4-pwm-v8-1-b5bd0a768282@amlogic.com>
 <1jfrtgj0so.fsf@starbuckisacylon.baylibre.com>
 <tnwdnwiruoty5yd42bmkupgg6hjxib5lblhqcyouoyx5y3zvnq@2d7cnrei24m4>
 <1jbk44htqr.fsf@starbuckisacylon.baylibre.com>
 <948ba34a-1e05-45c4-8ba7-66c72bdb6fa5@amlogic.com>
 <6bzysc3jwugo3epcxsef7uupk536prsc3phlf3m64n3jjwpxus@2uigg44uotuh>
 <9b457c30-6093-437b-b9af-44c3a768020f@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="be37srvqrjutjyvd"
Content-Disposition: inline
In-Reply-To: <9b457c30-6093-437b-b9af-44c3a768020f@amlogic.com>


--be37srvqrjutjyvd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Kelvin,

On Tue, Jun 25, 2024 at 05:33:22PM +0800, Kelvin Zhang wrote:
> On 2024/6/17 22:11, Uwe Kleine-K=F6nig wrote:
> > On Mon, Jun 17, 2024 at 04:44:13PM +0800, Junyi Zhao wrote:
> > > > > So yes, please use dev_err_probe() also to handle
> > > > > devm_add_action_or_reset().
> > > > My point here is also that devm_add_action_or_reset() can only fail=
 on
> > > > memory allocation, like (devm_)kzalloc. Looking around the kernel, =
we
> > > > tend to not add messages for that and just return the error code,
> > > > presumably because those same 'out of memory' messages would prolif=
erate
> > > > everywhere.
> > > Hi Uwe, I didnt get the clear point.
> > > So, if we need "return ret" directly? or keep "dev_err_probe()" to pr=
int?
> > Please keep the dev_err_probe(). There is a problem with that approach
> > (as Jerome pointed out), but that is about to be addressed in driver
> > core code.

FTR, this is done in
https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git/comm=
it/?h=3Ddriver-core-next&id=3D2f3cfd2f4b7cf3026fe6b9b2a5320cc18f4c184e

> For this patchset, is there anything that needs improvement?

It's on my (not particularily short) todo list to review this patch. I'm
aware there are several people waiting for that one. I intend to work on
this one later this week.

Best regards
Uwe

--be37srvqrjutjyvd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmZ62R8ACgkQj4D7WH0S
/k5S+Qf/SNvnQBfAaVksxx8eIEYT2jY0QUITMY+QWmZsieNi/glkSoIaiy+VWXyg
Pzfhjo4Z+GwYudqoI7gq/mzllhM1I4H2O4poOEw6YXjZxjdAbq2FfBdljtlOzHIn
W1uQnE6r0UYEPpfMQH4GIZ1VrxhluhAzz7dPcn7Ja71Tqj34pCP7Z2zFI6vXlJHa
AHEx28lK05wnnWMYqBElrZsEe0Jqj0KfrL9Dc87NNzvA/MAdqqe9MUIt6/8V59D1
VRpFgVhCGXve2l+TtRvB5gpkRAJ4DaBV9WNxoph8+9Tis+IB5efxsCFXrDR/ym5f
Xxco7/DhoBatXM8sLd8EYHf73vxhmQ==
=87Qb
-----END PGP SIGNATURE-----

--be37srvqrjutjyvd--

