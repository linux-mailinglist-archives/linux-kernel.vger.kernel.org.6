Return-Path: <linux-kernel+bounces-403999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BE59C3DC7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 12:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0447BB231FA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 11:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7323818A93E;
	Mon, 11 Nov 2024 11:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="cjKbOj34"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EAF18B493
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 11:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731325993; cv=none; b=Hgk3LjoU92q9hd0KiMaguEYILW7Eq+uuNVlDmq7epTq13LrWuWYDfwi8wX+xdrENycppVVwvicJakB759KTBkG6Fd4XPZ/wr7MvDWqjTIibTf3ev4uzy36f6p3Cd/P+fa1QgDQcfkM4LQW//HFjjdHqeiIMwh4AA3xewQKUUGM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731325993; c=relaxed/simple;
	bh=2jO+hHAo2zaWunTfHYmIa9Rr+ZQoaqA8wl7u31R1Reo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LggKQt+N+F3Z1BxQO3IFnYec4bbgOUGlkLi9Zfs5eWARolHDwdTaJBA2eAL6+d1gffkwna5m8byIwc6CUDqmaa6k+e6XdHS33pne6QCE/PcoO7wIRXvpHhffgqPoa6loOczJszOegIZWv4AmzrdraS30Z4Zex/KM224LGjfeAi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=cjKbOj34; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4315e62afe0so42036635e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 03:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731325990; x=1731930790; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/R0jIiMzJGgFn/fcNhSqiwXAU49AEe6L4AYFJaeHz7k=;
        b=cjKbOj34OMSIqrA6YwrkmPnUwy+7CEtuRR0kaBb1kvckTEiG7L9WOrmyJEVJrIQSt6
         kOAqkKH/I85XpQPIv9dIlvarVIlM6lQv+W5wrFr8JMPGI/8hDF2S4a7GZGt3xDdflU4g
         kC58r+UbrAFYHZY2YbflVSN+B0xgIch8pvpBIFAo5F7HatPMYXslwWS3FsdhWqGsufxV
         O3R4NJn9+gCufgaflwF7tjNoSbT1FoeQPSCcn9jzV95IA5fF5mDlOA1o142UcDeYAIHD
         ekAgZX00CeaZm9o2NQzH4iSZYx5EklFXSM6N/w9OvmKlLXJGUhDWUu+hwOBr7Sw1WzhR
         0uQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731325990; x=1731930790;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/R0jIiMzJGgFn/fcNhSqiwXAU49AEe6L4AYFJaeHz7k=;
        b=dRGJtSyKB54c2ZQnpDmO85RXNFcIS3lPyLXTYHPi8XhU1Yw5/OcZsMdzBwW8XsVavo
         ciRfquDNiNdLcoftRGQVV6/deROmEqQq7WUvOfdyXXw2REWvt8kvC4WQ86mqM+wr79xs
         ZC5KWdtM4DgIPdvQy8Jwx/I4OUVtgn0AXTh1PfiT6bzNVgpRdXj0lx31BTNbHepKHAzl
         cvTVLnjN1ENY0BhVA8NKKJi+3oyWHiXIF/nOurUUhevSccmT5AkZqmwDDDH5nsY9/xfX
         9ukgQgQ0l2l8EqAFjmgpVExKvuQyYUZyGfulj9fUott7dvTnZJz5TRpyn+7EpAVRtt+V
         jBRA==
X-Forwarded-Encrypted: i=1; AJvYcCU3pDzlaIwwHAPElGWuZc/wmMId8TpwX15fp4GZv2+ZTntBO7VJ61ZhAqudYRtfj41QEZLRiXHg4e/kirw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsHf0yKvFzOc85VlIWqMCDAWyQxKwb/9d5Qxblh8wipeFh/oz1
	S3nvFt2Qi36GcPqlCgW57ZHKzm2fB9rCBKbD0hCMnGigB1Rqd4CIvsZO5h6wQns=
X-Google-Smtp-Source: AGHT+IGGeLBRlpmJAyKRcjDha6kGt2TTY4dbvpp0DM5LOvcfKSTrhefyDpfbWmlvXteOSBMPU5eh/w==
X-Received: by 2002:a05:600c:1f93:b0:42c:e0da:f15c with SMTP id 5b1f17b1804b1-432b75168b0mr96904475e9.20.1731325989967;
        Mon, 11 Nov 2024 03:53:09 -0800 (PST)
Received: from localhost (p200300f65f28bb0063ffae39110fa2df.dip0.t-ipconnect.de. [2003:f6:5f28:bb00:63ff:ae39:110f:a2df])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa6c1205sm213426295e9.26.2024.11.11.03.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 03:53:09 -0800 (PST)
Date: Mon, 11 Nov 2024 12:53:08 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	Mircea Caprioru <mircea.caprioru@analog.com>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: adc: ad7124: Don't create more channels than
 the hardware is capable of
Message-ID: <25w34mtjiy2t6t44xa4sewan6qrqettsfrcxjv7cnfhoxfnbnp@mcwrqo2hikrc>
References: <20241108181813.272593-4-u.kleine-koenig@baylibre.com>
 <20241108181813.272593-5-u.kleine-koenig@baylibre.com>
 <b91ccaa161b962336324af31cd507fd1255e5c5c.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hwrf6qnj7nanlwtq"
Content-Disposition: inline
In-Reply-To: <b91ccaa161b962336324af31cd507fd1255e5c5c.camel@gmail.com>


--hwrf6qnj7nanlwtq
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/2] iio: adc: ad7124: Don't create more channels than
 the hardware is capable of
MIME-Version: 1.0

Hello Nuno,

On Mon, Nov 11, 2024 at 11:37:46AM +0100, Nuno S=E1 wrote:
> On Fri, 2024-11-08 at 19:18 +0100, Uwe Kleine-K=F6nig wrote:
> > @@ -821,6 +822,11 @@ static int ad7124_parse_channel_config(struct iio_=
dev
> > *indio_dev,
> > =A0	if (!st->num_channels)
> > =A0		return dev_err_probe(dev, -ENODEV, "no channel children\n");
> > =A0
> > +	if (st->num_channels > AD7124_MAX_CHANNELS) {
> > +		dev_warn(dev, "Limit number of channels to "
> > __stringify(AD7124_MAX_CHANNELS) "\n");
> > +		st->num_channels =3D AD7124_MAX_CHANNELS;
> > +	}
>=20
> Hmmm, I would treat it as an error...

Well, it probably results in an error further below when the first child
is hit that uses a too high reg property. I considered erroring out
here, but thought this might not be justified if some children are not
logical channels. I'm not sure either way, but can rework accordingly if
all other concerns are resolved.

Best regards
Uwe

--hwrf6qnj7nanlwtq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmcx8CEACgkQj4D7WH0S
/k6ASQgAub3i5oIlX9u91Q0IQRkzI6EcgzfwBHa9Hd4RKWIQnCVzEjnWB2NFGLs0
0+IPYH4mJbzbYzdc42D0z2YHPNBFsmw3awweAAPvBmhDE2g3uWNDFzwfn89j+O6+
NsOMOcWjlKciHT8XwqtnCkEYYxjpDj0fhEnauLSWtjQCng7kN/PPYYCBUqc3rX+u
T4jpx9Z6emS6NQubqjjfTvYVj0mTY2S9D0Z95zjsOiXKtQr6iJTQ45gJYPYYQ263
NVkd5tImzpfezsfnQfOZMBnBM69B2YUdo/0RlMnfPcI1VeOvd/09Lz05OO8dJN/3
5tjpr5+Wl/ZLRz6M8OhDw22J1v3rpw==
=x9w+
-----END PGP SIGNATURE-----

--hwrf6qnj7nanlwtq--

