Return-Path: <linux-kernel+bounces-548443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9E0A544EB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 09:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B5223A7168
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 08:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CF420764E;
	Thu,  6 Mar 2025 08:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="wrJTbzNt"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D24C1BC20
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 08:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741249924; cv=none; b=rx93/aXKYRv+ta4CAkdhSxxrLDpR+RyjJGA3ofUsCAgr/n8Hz/MenWdcZJG/533upfbpiES9rypaAtyH5weXrbFMOybUVV7tDEkjVkDAeMYb4nJVkbvOF9mqWbcJ6psgnb7dfWy+0ECJ/Cn2ZardkfjkBET4J/Pgm/bfyrarHBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741249924; c=relaxed/simple;
	bh=SwvE53D8LO9O66Du6/G6NXlLZ1dfuMWV9VLqaZWM5f8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mk2GjvIwHbEv3/gT2D662BqinE/jckF9WgwXadu8vlRI9ptyqB9nVoi+oyAMsCxYxXNKIfTC6aXsOSmUUy9wlxzFqPgqL17WtVEyX4nxRzXW54er64BXdLTCKKrKhQAjLATl8NJnitqvN99iDahcgN8WJAGmXraMFJKaknypnsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=wrJTbzNt; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4394a823036so2903205e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 00:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741249919; x=1741854719; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SwvE53D8LO9O66Du6/G6NXlLZ1dfuMWV9VLqaZWM5f8=;
        b=wrJTbzNtcoKkBt4kz8wc3LTje4bNgPaaK/KW9h1B7tj4ImHJBV3UWsxZ8tVDOoNCuh
         yu737YxHnZIXnCu4NdQc38n25ZGp0/thnDpoqY1Tq8iPDkdW8RodQjiOl3WHxqjz9QhQ
         6vqgRwyoFM2yQi1qdcyr48ac3G46XuCxJdf09nTazYZ943dHaSdaeW21JxMOHAqaSlqR
         wZIgYXYfPA15vcaOOggw6jUn1dn8Cs39kn81PaPxpl94KwjUvyV1mwrJgaA2l0LqNBa4
         4vhuQCkUYk4flbwL8fA/muQZPl2cAPnHV4dQcQrwXQBv6/0fiuAetS1nI5Ek/ANKceV3
         RX7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741249919; x=1741854719;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SwvE53D8LO9O66Du6/G6NXlLZ1dfuMWV9VLqaZWM5f8=;
        b=XUMHeCaLxhdVCS4x5XFnPRjGGAaVhcA+woIa0yMPiIaEX9VDBE6If6HHe/0ZxQWZpz
         hTRst7Hdzj8BkpLFrLpeJMM4SjjFTRhTZvvyK8WoDvap9qkRt4jCS8ncJHmSZMJMdLsK
         pcYNqOoAlpgyAFEe9BiVLOPf7momNjmpW/85+K8FBHUTrG0lw4fhwNdb6nrBo5Imn6/I
         KnT8rDmcqVnvk86Xd7d/fC+0fFmtFnSoO+faMBDz+FEpdKc7tzoJCAob7BFgH/do8Oca
         lwJzi+20hN5N9BeNpaNzc5WD1q64uJKhAGmRcV5MiGXfeUipZt8SESpW3mncHH9JC8rq
         1QKw==
X-Forwarded-Encrypted: i=1; AJvYcCWsxKZq4qd1OoqvelxlEPUJvKfg5YgVps/qODfMLqRsQsvSynd9LStldegbZE0MYwp53ApyvR+1EfXVEio=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLaq80VD05jwVHVuS353e4Xf4yrJdlOtnW8eYcw45dItRNhNKL
	6fL/OOLcr8iW0FS+C5cCvjdw04EHaNGgSKXQx4aySavj0O8HdeSSOVbfubmKCuo=
X-Gm-Gg: ASbGncvv5azwBEamM4W8UNvEH+hcxv8dHmy8z4SydMoEBF42LVl3zbqhCS/2gFEUeOl
	d+H9HAmD188t5GNt4fnKuETT9HruRKwvZnPM0mjR7EpFTO2YUSc1iBuUdoJ/D/sMK6FZg5wqb6D
	JkEKKfmre8co5gY7DOxDXUfFXOPE3cAZRQJFO7goC/BUaszKmJcJUhamR0u9Ken9pCTL2wcBJxG
	i84xSLpy/4GKpQ5k2pPWf7CVqs+XhJJAKXdEZAqE4Xdq+6Ui4HLERApnDAN8MWKAQnBPQWCFN3N
	1L6g+ZeGaZ12DJrACmHZuasDDFCGUjil2pleYbsWuV8dg/ed1n375GKK2OYU120OJY8xj3L7yzi
	KY5FIg3hIKq/OA/zB0CZxgz3xRQ==
X-Google-Smtp-Source: AGHT+IH6emTBfuS6zYPJHpRkTM8aN/IAHFmDZVmPdQiHiAOmQcw3zT+zE5ArnNtVc6O2TACIlk7aSw==
X-Received: by 2002:a05:600c:3ba8:b0:43b:c0fa:f9dc with SMTP id 5b1f17b1804b1-43bd298f98fmr56970425e9.10.1741249919415;
        Thu, 06 Mar 2025 00:31:59 -0800 (PST)
Received: from localhost (amontpellier-556-1-148-206.w109-210.abo.wanadoo.fr. [109.210.4.206])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bdd8c314asm12381045e9.10.2025.03.06.00.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 00:31:58 -0800 (PST)
Date: Thu, 6 Mar 2025 09:31:56 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, 
	Cosmin Tanislav <cosmin.tanislav@analog.com>, Dumitru Ceclan <mitrutzceclan@gmail.com>, 
	Guillaume Ranquet <granquet@baylibre.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Michael Walle <michael@walle.cc>, Nuno Sa <nuno.sa@analog.com>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 9/8] iio: adc: ad7124: Benefit of dev =
 indio_dev->dev.parent in ad7124_parse_channel_config()
Message-ID: <guodm26yvsrihuznuw27ff44iy2xt3bklpwaazbzvrbdky4ffi@3c6tyyzofo7c>
References: <v7l2skqj65vbku3ebjsfndfj3atl6iqpodamios2do6q6kcagf@whmuir6fwede>
 <20250306001013.7cd5d00c@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="g6tlflhbd5cz6eft"
Content-Disposition: inline
In-Reply-To: <20250306001013.7cd5d00c@jic23-huawei>


--g6tlflhbd5cz6eft
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 9/8] iio: adc: ad7124: Benefit of dev =
 indio_dev->dev.parent in ad7124_parse_channel_config()
MIME-Version: 1.0

On Thu, Mar 06, 2025 at 12:10:13AM +0000, Jonathan Cameron wrote:
> On Tue, 4 Mar 2025 10:41:09 +0100
> Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> wrote:
> > this is a patch opportunity I noticed while backporting my original
> > series to an older kernel to please my customer.
> > I chose to sneak it into the series in the hope to not offend maintainer
> > tools :-)
> Leads to b4 getting rather confused, but doing the right thing in the end.

Oh, I failed to pass
`--in-reply-to 20250303114659.1672695-10-u.kleine-koenig@baylibre.com`
to really do what I intended. =F0=9F=99=84

Anyhow, good that it didn't confuse b4 enough to refuse application even
the way I did it.

Thanks
Uwe

--g6tlflhbd5cz6eft
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmfJXXoACgkQj4D7WH0S
/k5EswgArOTpP0RPKXnd/syJq+w2+iwB6i9Ajk6iY976qSkSIDeRLTRshq7WvYYG
b8RNmZSkU9scmJsS333+DMOsTN9G+u2wySdfsgWYnJefRFtW5cPw/ePkig8rlSYn
t8xPKL8gxyCjvDWszUipxZR0SjFMl4fLC8HGtlmYR+FGzQyc4dnLptDiA/pjWqA0
BjJLGIPLolQH8hD27VWFIVFInOF5kzEN/1WQHpefy+K8NKRDJBcOaY1QG0DWGNKH
sal6Q2sFZEo0hknQ5ExZR6vLs5Ueq33oTf3GkfyCJT/l4mIK9U8e+zaPyuuET/0X
91A4RiTGdMd3B5FCJFhDSHx5XNys+Q==
=XpdY
-----END PGP SIGNATURE-----

--g6tlflhbd5cz6eft--

