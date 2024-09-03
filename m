Return-Path: <linux-kernel+bounces-313292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BD296A34D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 17:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 288E01C23EE1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 15:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E5818893F;
	Tue,  3 Sep 2024 15:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="I/8BUarG"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78571188900
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 15:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725378601; cv=none; b=Kq/lyMWiynz4ZrcdQrkCipPPFeEjB1nJMrYM8QdyazC3d8iNwNTv+IBZ/MGhT+VDTlFSPbo87H5A6jKX8jjkvG7GsiqsBvtTle6/0syryBSkcP9T0besYvmDILbQsT0AamdbB7dvYX2+AYotpE5MIIVqjTNL3Umxa/ViuOty77c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725378601; c=relaxed/simple;
	bh=bVviEKPveTmpcX7L/OUEFDloCUYNhXrJHYHWwks6MUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OStfgZpR3u/vtq+lyJ0kCbye2T1yqIqqK8M6okEt1CToqgGmHWjdmvI2HBSkL+9s6E2RvbMO+HlxCh1m5dAYF+NACplZ/rA+Cs8UDJb2zWWIGCPOCfNpjrRQYUWxi242bujm3tTYj+9FlHg8DWdA8nuWTULrh1WeHimYrDz4P9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=I/8BUarG; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a86e5e9ff05so634848266b.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 08:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725378598; x=1725983398; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aFhHwW1kAAGcV7OaaSbrjXWw+zX1uM2EQ/+cB02HHBY=;
        b=I/8BUarGh4WW1gmbpJ5o8y+e/K4cOeEA9TVwOLK8BggdSAUQdDiI9OVPk40tOEG7ry
         KvyGnANdJptjqcftsU+ChdII0/jcRZlkyrn2o5zOgMJ6U6N6wxXpYXN9PveExk13dodI
         cqtflnNr987AE1WR4Mrqy/wzj1DR0uCH5YyYgbmYY33mR/rfwuMBDJSehTVBhIvwbqDT
         dpNqST3f8vDXMDTo0TRy9DMdHePTqRbT0BvMFrjRUV9jBrhnM6Vjpi0VZZz/A6vmTokZ
         u/9nME2iwZoCT/eM9a1oe+0ynQwAeDShNxEnDkEkN5zZJ+CdhO+maWlfLPESUwKjCW/t
         a4mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725378598; x=1725983398;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aFhHwW1kAAGcV7OaaSbrjXWw+zX1uM2EQ/+cB02HHBY=;
        b=FPPiODlLLLC9HEDMSQ/WtCuvyQmfwJ5drS/hJAGldP/SiuB0WsMwoybOGfEK64MTQL
         Ahcnt9UUIGriKtDCJCeT+Lzz4ZKqu3jHg5NTueAYBweHziSPytSmFiGGujGTNfjjB0B3
         3IUhItkj6IwKQDalG2ORDIaPFNd9wrk/cRrQYDk5uktryR7wamJRKOF2qFISvwdubUgy
         vag+wQC20RXIXNbd/dqe+EMgn9i5Tet6h9J8xu/MOiLIe279VoXa3fpPFNC7GwgwS+Qx
         egYUrdsosdzd+bOjx46aOCKQ0emgIGOZw/VXhnL/4J/rxJuTCB52W3lQ5BTy8mJT9JBS
         seFQ==
X-Gm-Message-State: AOJu0Yx8GYktCr2YpGrcwnjoa3P5mxJ4Ng+qn8WaecWKDW9xFDopZr4s
	iXKcbQ8/CzXy0xNN7M0uH9JV5UslYGzfAeM6MoBA6D2EvCDCY86CNrDLX8GZYIs=
X-Google-Smtp-Source: AGHT+IEvdlu/j985eM+/rA5qaBqF1lyB3uR8LKAuX5UqTugImcvkKswP9Kfp18LHlYopPINQZZ8L0g==
X-Received: by 2002:a17:906:6a05:b0:a7a:a892:8e0b with SMTP id a640c23a62f3a-a8a32e717f8mr105078566b.19.1725378597538;
        Tue, 03 Sep 2024 08:49:57 -0700 (PDT)
Received: from localhost (p5dc68f76.dip0.t-ipconnect.de. [93.198.143.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891daf9dsm695490866b.164.2024.09.03.08.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 08:49:55 -0700 (PDT)
Date: Tue, 3 Sep 2024 17:49:54 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Liao Chen <liaochen4@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, gregkh@linuxfoundation.org, 
	jirislaby@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au, 
	andi.shyti@linux.intel.com, andriy.shevchenko@linux.intel.com, florian.fainelli@broadcom.com, 
	tglx@linutronix.de
Subject: Re: [PATCH -next] serial: 8250_aspeed_vuart: Enable module
 autoloading
Message-ID: <4nyenalsjnerwjwcuk5zwm52rptnc5jhjhz3yhsmo7qt3gffhs@qadnsjic7p24>
References: <20240903131503.961178-1-liaochen4@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oxnfsshwxceyq7si"
Content-Disposition: inline
In-Reply-To: <20240903131503.961178-1-liaochen4@huawei.com>


--oxnfsshwxceyq7si
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Sep 03, 2024 at 01:15:03PM +0000, Liao Chen wrote:
> Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded based
> on the alias from of_device_id table.
>=20
> Signed-off-by: Liao Chen <liaochen4@huawei.com>
> ---
>  drivers/tty/serial/8250/8250_aspeed_vuart.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c b/drivers/tty/se=
rial/8250/8250_aspeed_vuart.c
> index 53d8eee9b1c8..25c201cfb91e 100644
> --- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
> +++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
> @@ -561,6 +561,7 @@ static const struct of_device_id aspeed_vuart_table[]=
 =3D {
>  	{ .compatible =3D "aspeed,ast2500-vuart" },
>  	{ },
>  };
> +MODULE_DEVICE_TABLE(of, aspeed_vuart_table);

I wonder if you found this entry missing by code review, or if you have
a machine with that UART and so you actually benefit.

Otherwise looks right to me.

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>

Best regards
Uwe

--oxnfsshwxceyq7si
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmbXMCAACgkQj4D7WH0S
/k4lmwf7B8rCxzF0mqdiYNNkbNIL3ffkntFrgpHxTr7Sgi7iSyeFIXO7tcZuG+5a
2cit024915U223OcuPwrk/CSeOWMVzLMcOMeHtcw/45I4oFNOsP30p+0AiDVGrqg
+iOyyaK2sFMVHfp4yu1NlYaM64Ez2aW+bKrvaNWjI1vK0S1/rpdGvzTcqvxkrW8i
sKXg+rOE2QPCSliNu0t6goxHQOGMOnhrloktKH/+k/8/FjVpJ6KTNLqdogSmnycn
qbkruy1osW223l8UfYtw55w8idpmZmJCSePvmRrePJx3j3IMLKrzD8vROhpP2j0Y
s8lqi37r7SkeGx++B5ny1hfeBp8VJg==
=dQsN
-----END PGP SIGNATURE-----

--oxnfsshwxceyq7si--

