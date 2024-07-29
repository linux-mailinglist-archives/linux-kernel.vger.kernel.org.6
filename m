Return-Path: <linux-kernel+bounces-265972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8378593F878
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 16:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 101BE1F211FA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 14:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8DE015532A;
	Mon, 29 Jul 2024 14:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="3aV5L0ST"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8791527AC
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 14:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722264141; cv=none; b=mVZA9WahKZH4XePdbUXZMLRm9Iicmdw+tXxXLNMn8nnmKCUkhyM3BGDYbQekmNcbbVlU0qu+TAMOwtMRQL6WmID0QrmhfdtsxR0Tdof6vwR3HZCnEEAa66Srl7lI6m2yh6pOLNQiqagvAVXlXTvOC7CoKcV1brDvEl7fd2rCjrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722264141; c=relaxed/simple;
	bh=Pa38IDDz14ZyF1Kf+6NrTlL3LquE/bkSNCFq2Fv3qCA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ZH8H8xfZ1DPlsCtTOGI5n03yy+3XVsi6X2nXQVU74RQRRnwLB3kCGa9ZveAdxVfJ49wH2prPaXod8he3c6ktrgS+E7OwgQxCeN6tt+TR3tPqKPBzIDEQBXq205wjHnZwVWPpbJxnPtSnSL49y+3vvev5KFMj4UalEDN8dfFTMcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=3aV5L0ST; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-427fc97a88cso17640185e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 07:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722264137; x=1722868937; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/vryNgyzMsFde+cbe622LWwyKPkGWCTER1RhK0F4O8U=;
        b=3aV5L0STHV2sWsoHNVwh6zESYw2eZIPKDKksAey+bUownSMc/x2fCHgzwmlXRWcVWa
         xRR2TCgM2ZvmrFlsar+JLWKHFN48M9eKTyfU5CIijuqcyxXFluxYV11lfWst4UA/ak7b
         eA990enPPF6ayq5QMKjH6yaH2r3RRTZ6fYUUZfsSbp2tbvcKq3Pa6njmIxsrCo+G+yuG
         KypqNb35RN/CbV6+hYMxh/utbxbi7OHW4Eulgbpg3fQQ4yTBoUtzVAmpU6/0FJmpSLix
         YtWsYUCC5SlABEtkwb/D5kxIetv0mZU7lu2KOBPiTnDzQ9HsyNNnCKitO/2DAe04ETzh
         LmCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722264137; x=1722868937;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/vryNgyzMsFde+cbe622LWwyKPkGWCTER1RhK0F4O8U=;
        b=prg76CZcAbKfyVmBQ24G90j5KrLbE+Bj83EmAFAM/5Fc2OAqqRxZdTGu2Kyh0yOwq7
         mWYTFyVuUv7kV9svrPICFxPugfmwt3FQA1wfq4+85GOUYIcbYfIgCco0cKBJqXy9cHCE
         PfJxSHeRMCkzgIGkJ2HoeopAWrVN/lI597FdQvLYxyhR9KMbTsA2yoWVYZ9C5VDOEbTe
         Bh6/V0Uep6ktdKw9u7C6H5Zpbdxwvsh209kiKtpJJ/Sd6M1us2QmXjO9NzHFBDFNA/QY
         R5DN6NUM7q2qxe1WloUvmgjCJX0BGCuB18t5MvASrkuzD/mM5dmaYeecttJHvvpVrwwX
         usbQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+GQQ3jeAOV6brNjBlVWkiUcljs1KtEpR2ys/TfZz6aO58D/bSkBFLVqDFWecgEWG5whtQFQIyehAiZO97KTYj9VEvRtmTg/jNyGDx
X-Gm-Message-State: AOJu0YxbFjJQcT+MAL54qTkDV8Aqo4f3YDUNQbFIe8Nek8CnxIt7+SYq
	8Z055SXGRXQ5c8/NPED6sjJM+f2PZl/bc9ocAap+3wo2tGIX0SxCXZjPeIztYAo=
X-Google-Smtp-Source: AGHT+IFZFxS6E27mnr9vmlBnL/tw27bvTGWht1x8YDq/zlbnhtJdSomwiir8f5bX62qkw+iQQ586Rg==
X-Received: by 2002:a05:600c:3505:b0:426:67ad:38e3 with SMTP id 5b1f17b1804b1-42811d73aa0mr55232845e9.3.1722264137354;
        Mon, 29 Jul 2024 07:42:17 -0700 (PDT)
Received: from localhost (amontpellier-556-1-151-252.w109-210.abo.wanadoo.fr. [109.210.7.252])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428057a635csm180606715e9.30.2024.07.29.07.42.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jul 2024 07:42:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 29 Jul 2024 16:42:16 +0200
Message-Id: <D323OLK1T0CG.1OGNBVY1FDVJT@baylibre.com>
Cc: "Lars-Peter Clausen" <lars@metafoo.de>, "Michael Hennerich"
 <Michael.Hennerich@analog.com>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Nuno Sa" <nuno.sa@analog.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "David
 Lechner" <dlechner@baylibre.com>
Subject: Re: [PATCH RFC 2/5] iio: adc: ad4030: add driver for ad4030-24
From: "Esteban Blanc" <eblanc@baylibre.com>
To: "Jonathan Cameron" <jic23@kernel.org>
X-Mailer: aerc 0.17.0
References: <20240627-eblanc-ad4630_v1-v1-0-fdc0610c23b0@baylibre.com>
 <20240627-eblanc-ad4630_v1-v1-2-fdc0610c23b0@baylibre.com>
 <20240629173945.25b72bde@jic23-huawei>
In-Reply-To: <20240629173945.25b72bde@jic23-huawei>

On Sat Jun 29, 2024 at 6:39 PM CEST, Jonathan Cameron wrote:
> On Thu, 27 Jun 2024 13:59:13 +0200
> Esteban Blanc <eblanc@baylibre.com> wrote:
>
> > This adds a new driver for the Analog Devices INC. AD4030-24 ADC.
> >=20
> > The driver implements basic support for the AD4030-24 1 channel
> > differential ADC with hardware gain and offset control.
> >=20
> > Signed-off-by: Esteban Blanc <eblanc@baylibre.com>

...

> > +static int ad4030_spi_read(void *context, const void *reg, size_t reg_=
size,
> > +			   void *val, size_t val_size)
> > +{
> > +	struct ad4030_state *st =3D context;
> > +
> > +	struct spi_transfer xfer =3D {
> > +		.tx_buf =3D st->tx_data,
> > +		.rx_buf =3D st->rx_data.raw,
> > +		.len =3D reg_size + val_size,
> > +	};
> > +	int ret;
> > +
> > +	memcpy(st->tx_data, reg, reg_size);
> > +
> > +	ret =3D spi_sync_transfer(st->spi, &xfer, 1);
> > +	if (ret)
> > +		return ret;
> > +
> > +	memcpy(val, &st->rx_data.raw[reg_size], val_size);
>
> Can you just use spi_write_then_read() here?
>

I was planning on doing that. But I'm getting a timeout issue when
using `spi_write_then_read`. I can see the tx_data going out, rx_data
is recived but CS is kept asserted. I need to investigate more but in
the meantime I'm using this as it is working. I will remove this
workaround if I can find a fix and add a comment for now.

> > +	if (ret)
> > +		return ret;
> > +
> > +	if (st->chip->precision_bits =3D=3D 16)
> > +		offset <<=3D 16;
> > +	else
> > +		offset <<=3D 8;
>
> As below. This is hard tor read. Just use appropriate unaligned gets for =
the
> two cases to extract the write bytes directly.
>
> > +	*val =3D be32_to_cpu(offset);
> > +
> > +	return 0;
> > +}
> > +
> > +static int ad4030_set_chan_gain(struct iio_dev *indio_dev, int ch, int=
 gain_int,
> > +				int gain_frac)
> > +{
> > +	struct ad4030_state *st =3D iio_priv(indio_dev);
> > +	__be16 val;
> > +	u64 gain;
> > +
> > +	gain =3D mul_u32_u32(gain_int, MICRO) + gain_frac;
> > +
> > +	if (gain > AD4030_REG_GAIN_MAX_GAIN)
> > +		return -EINVAL;
> > +
> > +	val =3D cpu_to_be16(DIV_ROUND_CLOSEST_ULL(gain * 0x8000, MICRO));
> > +
> > +	return regmap_bulk_write(st->regmap, AD4030_REG_GAIN_CHAN(ch), &val,
> > +			  AD4030_REG_GAIN_BYTES_NB);
> > +}
> > +
> > +static int ad4030_set_chan_offset(struct iio_dev *indio_dev, int ch, i=
nt offset)
> > +{
> > +	struct ad4030_state *st =3D iio_priv(indio_dev);
> > +	__be32 val;
> > +
> > +	if (offset < st->min_offset || offset > st->max_offset)
> > +		return -EINVAL;
> > +
> > +	val =3D cpu_to_be32(offset);
> > +	if (st->chip->precision_bits =3D=3D 16)
> > +		val >>=3D 16;
> > +	else
> > +		val >>=3D 8;
>
> I 'think' I get what this is doing but not 100% sure as it's a bit too un=
usual
> and I'm not even sure what happens if we shift a __be32 value on a little=
 endian
> system. I would instead split this into appropriate cpu_to_be24() and cpu=
_to_be16()
> to put the value directly in the right place rather than shifting in plac=
e.

cpu_to_be24 does not exist yet. I will have a look on how to add them.


All the other comments will be addressed in V2.

Best regards,

--=20
Esteban "Skallwar" Blanc
BayLibre

