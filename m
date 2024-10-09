Return-Path: <linux-kernel+bounces-356460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 407DD996166
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 09:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB7B81F2164A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 07:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF6813AD39;
	Wed,  9 Oct 2024 07:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VArRZVCI"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B3E13B5A0
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 07:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728460216; cv=none; b=VqjpqpeEH8j03VQpGIgAgU2z7huxXgTCjfbOHZ93fg1LmvlzD2fodtnEldJZMWmXowBsdBQ4BTAY6/dvfvp7tadvtPbcu0jks4qVWD54KyA5PZLRTewOhbhQ9jyLSF4YYFHoQXj6T1nToOmwh7+mMNnnTAKjtrS+RiIoDHJaf9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728460216; c=relaxed/simple;
	bh=5x55/08d462FYxOjcK0FvLQICBYvfjVVslgvjMLUgWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=agSvr834M/nUub++9bJpD6nPCkK+58NSXexssF2E4F3vQWHD+b56lMssEQ/xIX+f/E6PlWCjmSvTaz1ItUETAFOtT+2QGZHfdE9cf3lHUrcQN7b1KbHtpoN8UFjpBaKFWWJu/ne2vh08YyBm+SqL4ijQUxg7BjT6u48Unsal5GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=VArRZVCI; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a993302fa02so505997066b.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 00:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728460213; x=1729065013; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MfO7/CdyTSaSdDUH8300s0Lf+paI5a7n8TXHV5lBIng=;
        b=VArRZVCIU4rvaFKHRIE9BVna8CvLQ6Ivba4vIi4N21HovmLm/Tg1Hu0jhvaKkoLjlT
         x3vaE9rSVyoJvosqmzz7QDbMj+Cz61FOm9N5IemI0hSyjtgo3YZJe1oUfBhWdxDVMXsN
         rYQMojK2XzsJ162ZZcl/rA15QFvUY3RSlXgnvyWGuWMqIXYs95j8DzD7ozUNUwC/Io31
         UpAlN0Qb9Q8RTWP+TOzKlvnjpxkqjIhQJ1vEXx8VwJhiqAlxb4k/ZjZQdMyvWRIRqSZs
         7dhKHx9VMNXyl7etQ+9VB3KJ1w0nTLHBJv0ViehP4zlTqCiiC1XO2I9jOy11NXbequbV
         4CXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728460213; x=1729065013;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MfO7/CdyTSaSdDUH8300s0Lf+paI5a7n8TXHV5lBIng=;
        b=o+OTujCCn+SJ1wxqKENen4NA97mdNPtdcPBS2BIf94SUmAj3+kDCATcL9SwOcD+Fkj
         87FVyrSWsb5qnDkFAURn4oITkzx/B2LsD1ldbI8YIACHQZW7tii+mtpYS5tYDQwMlunk
         eaEx3Cjxay/DgChIjpS51xpi1EUefULY8dGBoO+fXM9/hcvR9MDjyuOUqk1sQLNv9ipz
         4BgBN6zt+ekv+7GI5fOxHN2be2wib6vmL/N4EzeIv0FZhDumN9vRp6tTUSEvYXSH++kp
         mk5k5eeLVJVYs+07cQLK0x5SP+YUC58HYa7/sysJePQzxGIBjef7Y5ulPH+uHTaUURZD
         7g8g==
X-Forwarded-Encrypted: i=1; AJvYcCUZMRk3EL94Os3tekNKHg19jCFIRmzVonGUp8nCTDLF8V2BYziPJBjus0o/FAy0aLWUEB4yBfgTvqenN0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxAFH7Z05Rx4mVkYu27FOIGTPnwVvcg/HYCQVSDStu63sVhEU3
	c9u4vT7CTRffXpbZlSq1E9iyc/2xfJTmeSEr4pz5lndEwwDGQH4y9F9CRwmlsbE=
X-Google-Smtp-Source: AGHT+IELkJha79eNO85lN2ia3GPVqHwF4PlD+FNkuvqkfUBcPiLqrkXjVGjtvNtH+Ngh14I9Ck87wQ==
X-Received: by 2002:a17:907:c7d6:b0:a99:33dd:d8a0 with SMTP id a640c23a62f3a-a998d220fd7mr124352766b.38.1728460212845;
        Wed, 09 Oct 2024 00:50:12 -0700 (PDT)
Received: from localhost (p509151f9.dip0.t-ipconnect.de. [80.145.81.249])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a994c1c4c57sm457157566b.208.2024.10.09.00.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 00:50:12 -0700 (PDT)
Date: Wed, 9 Oct 2024 09:50:11 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>, 
	Olivier Moysan <olivier.moysan@foss.st.com>, Andy Shevchenko <andy@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Marcelo Schmitt <marcelo.schmitt@analog.com>, 
	Mike Looijmans <mike.looijmans@topic.nl>, Marius Cristea <marius.cristea@microchip.com>, 
	Dumitru Ceclan <mitrutzceclan@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Alisa-Dariana Roman <alisadariana@gmail.com>, 
	Ivan Mikhaylov <fr0st61te@gmail.com>, Sergiu Cuciurean <sergiu.cuciurean@analog.com>, 
	Dragos Bogdan <dragos.bogdan@analog.com>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 6/7] iio: adc: ad485x: add ad485x driver
Message-ID: <mv2smx6m3iqocvplham74aqdcn2eaqmmj36tu7c7qzdjq7jlwu@w2zyijdslrpc>
References: <20241004140922.233939-1-antoniu.miclaus@analog.com>
 <20241004140922.233939-6-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zvp6fihhtexug34p"
Content-Disposition: inline
In-Reply-To: <20241004140922.233939-6-antoniu.miclaus@analog.com>


--zvp6fihhtexug34p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

On Fri, Oct 04, 2024 at 05:07:55PM +0300, Antoniu Miclaus wrote:
> +static int ad485x_set_sampling_freq(struct ad485x_state *st, unsigned int freq)
> +{
> +	struct pwm_state cnv_state = {
> +		.duty_cycle = AD485X_T_CNVH_NS,
> +		.enabled = true,
> +	};
> +	int ret;
> +
> +	freq = clamp(freq, 0, st->info->throughput);

freq == 0 will become a problem in the next code line. Increase the
lower limit of the clamp to 1?!

> +	cnv_state.period = DIV_ROUND_CLOSEST_ULL(GIGA, freq);

Is ROUND_CLOSEST really the right thing here? The resulting period might
result in a frequency higher than freq, still more given that
pwm_apply_might_sleep() might round the period further down.

> +	ret = pwm_apply_might_sleep(st->cnv, &cnv_state);
> +	if (ret)
> +		return ret;
> +
> +	st->sampling_freq = freq;
> +
> +	return 0;
> +}
> [...]
> +static int ad485x_probe(struct spi_device *spi)
> +{
> [...]
> +	st->cnv = devm_pwm_get(&spi->dev, NULL);
> +	if (IS_ERR(st->cnv))
> +		return PTR_ERR(st->cnv);

devm_pwm_get() is silent on error, so adding an error message here would
be appropriate. I think the same applies to spi_get_device_match_data()
below.

> +	st->info = spi_get_device_match_data(spi);
> +	if (!st->info)
> +		return -ENODEV;
> [...]

Best regards
Uwe

--zvp6fihhtexug34p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmcGNbAACgkQj4D7WH0S
/k79MAgAjXjh105N9kSxlycZQZdNxMqX57sWrLJQeFsKBrUH0z/v4SGfMejN2rYN
XT+RQLRrNMIAqOpU6Akg8g5j2be4UBcEWbSLNgGoqeNZZHsfee6cIwHbfiFtIBEp
mvVGWNGTjy0pExX3rui3t7Io/ox7/B0zYUa/UNDDuIED+7IVCAqrKAGxm/fCptzB
eHqVj6LL1olNfpBRNiq4Bt3GX6VXausnsJnUL++Q1uD/iMtf87GoOZlq9nKC3KnO
huG3IIJ/8XoDHCeSWk6hYYzivQKy9gop6jTojT5wBwrGo4KxWvDn/+/Dal5qnCIO
qZw+/0E9QyXg5UThi+T1evBJ35a1CA==
=sDLV
-----END PGP SIGNATURE-----

--zvp6fihhtexug34p--

