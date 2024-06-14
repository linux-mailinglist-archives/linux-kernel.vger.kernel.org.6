Return-Path: <linux-kernel+bounces-214731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB1A908948
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 12:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DE48B25C6E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 10:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08CFB192B96;
	Fri, 14 Jun 2024 10:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fOO6itz1"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C32181AC7
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 10:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718359570; cv=none; b=ctGBTWFm5N94Gtbr9SmeymSprGYSJGRCl2OOh4Wq66rv2S5TGo7AhReizMwDCrslejUm6LIbX/u//UwfPrLVg90aoRFv2lXrsUr21ZP+ffSa+Ta+tU9yuY07qh72vr5Q2yi1Yc0G2pV1qnUGwcPKQv2YbezU7vueMzuTBywZJzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718359570; c=relaxed/simple;
	bh=VLNaXn/lm7t6E5mAaLknHXlsRSaNaczlupRMV67F4k4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pySx8xs9Sp13L2Qcum2HcdL3ix/o9Ma6x0W3+Ogjn5xnUAQ2vktuEYMcLsmkGyOrIhaRdBSg6MfoAaOQXr++jn+OE06HvBFVlrYY5Uv7XRNQjvnrZIlcXNr53DIEn59WoiX9CnUnHsV/QDV0Dq52wYzyRdfIay74ZQ4Adw28BBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=fOO6itz1; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57c61165af6so2361675a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 03:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718359565; x=1718964365; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n1RQFOycNLmuTPDyek4OedVGRn07iS0hgYarPk74x8U=;
        b=fOO6itz1JGVm+jifQifYwXqfsKjeYsHHIZm/6CALtts4/ag6IXCshseaMwRdxbXnWg
         8nF2XTkkuPBKnAVRVA2wnaJwd4eYfZlaz9sa+ByMzDF4g5mUwB1lZGKPQbhtReHMXck2
         3d6u5NyR4XtuKVNK/FIFnRBZuNFqlBB3pkIJUByG9G69bdn+jDcxT/fVwyK+EsCEcDo1
         Lwpr3rgV/FRZ8OFyvk2tQwtiV65I1UpzSmGyUQIxVCla4iKSI0Z0BVgmBZaNN1168zkS
         2InG0OOO1L2BZX+WsEW1k5h2Fdx1eNSX9tk4qwH+BOsZ4IBkoA6kMhubpj1Nxv2Bo1rf
         Lseg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718359565; x=1718964365;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n1RQFOycNLmuTPDyek4OedVGRn07iS0hgYarPk74x8U=;
        b=YxkDIHSlUiqc+S/ppfbFvHh6D1Aoq1EgHJaQ7nSjHobecMp8mNYov7VBAcMP+KSRr/
         BfzUwzEN2J5ijVzUJ4HPt7p1cRk3M0ghTEqhwjnOvo8lXDbKVIrhbBv/UrGBDIAthA25
         r1h1dSf53neI7tQJJL/oCZTNyI9JAPxONBmzWlEN2qity/Jz+wCNbvVFtGwxbQikhCKE
         uoYyVsx8NCzwnGNkbqrcS0ECGb2srEC867k+SBVS6507byaQMVhilmq58vsr14xVh2ge
         +cEvc4t1NRefbBnuQ7fLuP+mJY2VfJIiRR55kp4yNQJh5nc/wNrjxA34RKhCK4FN/oke
         3/0A==
X-Gm-Message-State: AOJu0YyRdda2YwKMRiZAW9r/TWOxBhO3tAQW6XRf2jHl91h4DAcPNyiz
	Pa2+Axl6SZRxhYyXfSTvh+JnvMfxRHzdJaUD3HBRDX9StMUYRpspHWe9pLSp0tQ=
X-Google-Smtp-Source: AGHT+IEBKcircL4D5yvI1Uh0Bdlj+m1RTUCtN9vKd4L45BNE7heuj8fMqHurvRePVoeMMv4jFlhDyw==
X-Received: by 2002:a17:906:184a:b0:a6f:5a9d:37f9 with SMTP id a640c23a62f3a-a6f60dc5128mr122290766b.48.1718359565241;
        Fri, 14 Jun 2024 03:06:05 -0700 (PDT)
Received: from localhost (p509153eb.dip0.t-ipconnect.de. [80.145.83.235])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56ecb46fsm167018666b.129.2024.06.14.03.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 03:06:04 -0700 (PDT)
Date: Fri, 14 Jun 2024 12:06:03 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Sean Young <sean@mess.org>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH] bus: ts-nbus: Use pwm_apply_might_sleep()
Message-ID: <xj5mqnte5dgs4yzuku6g7gnprgm43tdbunxmo6o4thzreyraok@kttvkz5dhaei>
References: <20240614090829.560605-1-sean@mess.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="56vgrc46vq6e7trh"
Content-Disposition: inline
In-Reply-To: <20240614090829.560605-1-sean@mess.org>


--56vgrc46vq6e7trh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

[To: +=3D Arnd]

On Fri, Jun 14, 2024 at 10:08:29AM +0100, Sean Young wrote:
> pwm_apply_state() is deprecated since commit c748a6d77c06a ("pwm: Rename
> pwm_apply_state() to pwm_apply_might_sleep()").
>=20
> Signed-off-by: Sean Young <sean@mess.org>
> ---
>  drivers/bus/ts-nbus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/bus/ts-nbus.c b/drivers/bus/ts-nbus.c
> index baf22a82c47a7..b8af44c5cdbd0 100644
> --- a/drivers/bus/ts-nbus.c
> +++ b/drivers/bus/ts-nbus.c
> @@ -294,7 +294,7 @@ static int ts_nbus_probe(struct platform_device *pdev)
>  	state.duty_cycle =3D state.period;
>  	state.enabled =3D true;
> =20
> -	ret =3D pwm_apply_state(pwm, &state);
> +	ret =3D pwm_apply_might_sleep(pwm, &state);
>  	if (ret < 0)
>  		return dev_err_probe(dev, ret, "failed to configure PWM\n");

Thanks. I guess the patch becoming
8129d25e32b7fd0f77bc664252321f3a16bb26b8 was created a while before
pwm_apply_might_sleep() was a thing.

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>

Arnd, you merged the last changes to that driver. Do you want to care
for that one, too? If not I can apply it via my pwm tree.

Best regards
Uwe

--56vgrc46vq6e7trh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmZsFgcACgkQj4D7WH0S
/k6Ciwf/V640UlA3t7jmkjfZ8cO8YihHm54XgFoqLTh48Akc4MU9mW4UaZWM+IC3
3hMfpLUzyPmUGsupnsfcyKOWa8trOtzTaiwB6M33NqO6qkdnQfPlOUzSLoYzwXqX
xUMlUF9MKxCu0BoOiqgRq+AJLn5Egurwt3MmTSfqolf3dZd7GijmIzVCUh/KM6bq
vt/NoG2nks4bUURM4Kn+jz2yNoSIVmFZx7IwEeekV5NpxMldCbJQ5LdK6opvnyRR
0ebjw1qXO2wxucowDaXYNJcC6K2qOlwvxlONZFiO7E/7H/tmWnD6f7KM/fEG1hvC
r+D+dyMoPviFNgnheoCEVCqjKGcm1w==
=6gnx
-----END PGP SIGNATURE-----

--56vgrc46vq6e7trh--

