Return-Path: <linux-kernel+bounces-432699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B359E4EF3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 08:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09C3F28516B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 07:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA2F1B87DC;
	Thu,  5 Dec 2024 07:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KN3QlKvr"
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAE11917EE
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 07:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733385063; cv=none; b=UUD5A/iVgcBEUO5aI+hnZGXIuR1QWVVPmKR4rt8AcCujHCbYEbqJCEPoyu49vIOHnmKc3LqqUWxGedPbkZd+ejpb5w1lcCqzuXGXj20wHraxs33RgNLQDCMeu/7Ml8niY2GhUyUQ4dUUlwdKpSICEed3P2UmIe5qXsDubCCgnlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733385063; c=relaxed/simple;
	bh=cx/iToduiSsa0dCL27tca+J1223hdtzPxMNXY7DvcIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tPCz7qItH5ZEAtMvvKhYk8zaFN603LPSm08xPPBg9e2OSIfo69Y6ZQRJpSoesa5+5ysOTL1E6zXTZrVNPWYZNaz8rc7CMA2EPAP80AnrS5F8zukHsUrVIZ3F/SagPWzcww8X9IUUmRC+RGc7yeLHbBqnz7Xjb6uruUAqeFsYfEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=KN3QlKvr; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-434a45f05feso5951625e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 23:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733385058; x=1733989858; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YVBbEJzRe8Tuzy04VImUvtsNsr8Xe5Ruhv/wGnr/GSc=;
        b=KN3QlKvrtRSaM/fDub4TW1rGTYE+Td/6GDuReAtSbQXr1VekEFjT1xHHPsoER3jwit
         h68ebxKLgQBuzNBjmkMn1OoNFvt1qS3Fp2HFEhdGjsYkrYRu491zF4MlCZR7RJu6zgfl
         Rl/p+fX+MDYyHSxt2F+68jurOWAeoLXb8qhb7rj4Ek26iMtDPJndzmLCBRyb6hgIJIPr
         9QKPbgRGoh/MADi0LKqON4ziWVkI96740+HzjlK2QpZ73oj+Kqt7Ied5iNrLAD+vn2Jl
         V/EjTzloNn+CqK0x05HyDxgXD8Ma74EIlCa7HA5az+c0Q01SpVJTBDr4PCs7vvR+gQbH
         o3Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733385058; x=1733989858;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YVBbEJzRe8Tuzy04VImUvtsNsr8Xe5Ruhv/wGnr/GSc=;
        b=A55hHqTZck0s+hXNxEhgQog5pVfiSW9biygiQsTneALF9LN30Zu0tB67xxHq/jpPYJ
         EF5EvDxcgulsLFxc+eePsbPPAWpuMBQ//rK1yyH97gEPJ0/VreyP1lyfC+H2ygfDepTq
         fRwcoIYH5mlKvGJOtRUWLPhLcJmAUmtCy/fJCw7rwZgIffHS337ma3NkiJQrxu7MjS1g
         7Ej6Ys8IVW55tKv+ryvSJdFroqweBMd9QP6p0vGkWYNqk1KG95ebXeKvA9sWuTm4wNw9
         nMgy/Fs0uFpiEncQQoX5D4R4tLq6/J/k7ib3gnzrMxaOqwjFSmDR9ST/Jfz3kuEcu2yg
         5GfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtXKZQYOBkaWbXjsGoFaqmw4IJPh2dTxUjISg+KUwfy+pt+bnZt49LOcOLFCbNsKjhg3mA/z30u9RpMY8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf3sRYbwGVfAq95pP3uYGG1oQYaAlSTGXRqiey9+HiAvCx7VJT
	yM4omjlbX4pawxJNubxER+Upkw05OqW8SDh1E3VPMRWfqEWeDHdXLhaBKxvI85yu2qRrMKznIkO
	Jzi9dKJyq
X-Gm-Gg: ASbGncs8lxbrqA4wK0I7UkHAPO0s+ZA/kcwf/6ur3t2XKhu3ya0zx7FXwaPnGgTfZn6
	yHNADfziw/Zqg0rQ3XAoAhuDR2p9Y3Y9E/u0Oo1+z8bx/TzGirmb+Z77dW0huboHTenTQuaI60f
	ljVG7/pavalVy2jJgmGKSMyZJAgSn260vb0OBBBf32bzYR+UovuH6/EOmJ0W0qI/zIH2D/yFtVK
	XJ5Y0Othit62DtN84lUYdu3nQ5KQ+YW/D98mRIcl3BPehxY1MBinXM=
X-Google-Smtp-Source: AGHT+IHNc5xbzNsScrqEe/TQLEpLL4QOgP5FhmHYTruI1Dw81M/NNc0heHFys55zo64a3qy+kBzuBg==
X-Received: by 2002:a05:600c:4f03:b0:434:a852:ba77 with SMTP id 5b1f17b1804b1-434d09d0432mr89782455e9.15.1733385058218;
        Wed, 04 Dec 2024 23:50:58 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:e7dd:2bae:cea6:49d0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d5280120sm50645405e9.20.2024.12.04.23.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 23:50:57 -0800 (PST)
Date: Thu, 5 Dec 2024 08:50:55 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] extcon: Drop explicit initialization of struct
 i2c_device_id::driver_data to 0
Message-ID: <3dgr7brrcsux4bhywmdu7v4ibmieb3wotb7t5qlent64su7z4x@qapri6zyjfbe>
References: <la6csftzuntp3w2etea5s2u63yjxvxcgicg7tbehnild4d736g@uqod6luq4bth>
 <20240918123150.1540161-6-u.kleine-koenig@baylibre.com>
 <CGME20241204103802epcas1p3bb95970c978894677e1087ac20dc8450@epcms1p4>
 <556725552.2924666.1733371094684@v8mail-kr1-0.v8mail-kr1.knoxportal-kr-prod-green.svc.cluster.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rvsi7ta2ttjctr7v"
Content-Disposition: inline
In-Reply-To: <556725552.2924666.1733371094684@v8mail-kr1-0.v8mail-kr1.knoxportal-kr-prod-green.svc.cluster.local>


--rvsi7ta2ttjctr7v
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] extcon: Drop explicit initialization of struct
 i2c_device_id::driver_data to 0
MIME-Version: 1.0

Hello MyungJoo,

On Thu, Dec 05, 2024 at 12:58:14PM +0900, MyungJoo Ham wrote:
> >On Wed, Sep 18, 2024 at 02:31:48PM +0200, Uwe Kleine-K=F6nig wrote:
> >> These drivers don't use the driver_data member of struct i2c_device_id,
> >> so don't explicitly initialize this member.
> >>=20
> >> This prepares putting driver_data in an anonymous union which requires
> >> either no initialization or named designators. But it's also a nice
> >> cleanup on its own.
> >>=20
> >> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> >
> >That patch got some positive feedback by Krzysztof but wasn't applied.
> >Is this still on someone's radar for application?
>=20
> Can you provide a link to a commit that requires this change?
>=20
> For now, I don't see any benefit from this change.

So the explicit initialisation of .driver_data that then isn't used
doesn't look strange enough to you to drop it?

Would you prefer=20

--- a/drivers/extcon/extcon-fsa9480.c
+++ b/drivers/extcon/extcon-fsa9480.c
@@ -350,7 +350,7 @@ static const struct dev_pm_ops fsa9480_pm_ops =3D {
 };

 static const struct i2c_device_id fsa9480_id[] =3D {
-	{ "fsa9480", 0 },
+	{ .name =3D "fsa9480", .driver_data =3D 0, },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, fsa9480_id);

then?

Anyhow: The most recent presentation of the quest is at
https://lore.kernel.org/linux-iio/20241204150036.1695824-2-u.kleine-koenig@=
baylibre.com.

For drivers/extcon/extcon-sm5502.c this would allow the following
cleanup:

diff --git a/drivers/extcon/extcon-sm5502.c b/drivers/extcon/extcon-sm5502.c
index 3f8cca528284..3eb8fe4f4af5 100644
--- a/drivers/extcon/extcon-sm5502.c
+++ b/drivers/extcon/extcon-sm5502.c
@@ -827,9 +827,9 @@ static SIMPLE_DEV_PM_OPS(sm5502_muic_pm_ops,
 			 sm5502_muic_suspend, sm5502_muic_resume);
=20
 static const struct i2c_device_id sm5502_i2c_id[] =3D {
-	{ .name =3D "sm5502", .driver_data =3D (kernel_ulong_t)&sm5502_data, },
-	{ .name =3D "sm5504", .driver_data =3D (kernel_ulong_t)&sm5504_data, },
-	{ .name =3D "sm5703-muic", .driver_data =3D (kernel_ulong_t)&sm5502_data,=
 },
+	{ .name =3D "sm5502", .driver_data_ptr =3D &sm5502_data, },
+	{ .name =3D "sm5504", .driver_data_ptr =3D &sm5504_data, },
+	{ .name =3D "sm5703-muic", .driver_data_ptr =3D &sm5502_data, },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, sm5502_i2c_id);

It doesn't benefit from further cleanups because the ugly cast it relies
on is done in i2c_get_match_data(), which can then be modified to:

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 7c810893bfa3..a050ead0b7d2 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -129,7 +129,7 @@ const void *i2c_get_match_data(const struct i2c_client =
*client)
 		if (!match)
 			return NULL;
=20
-		data =3D (const void *)match->driver_data;
+		data =3D match->driver_data_ptr;
 	}
=20
 	return data;

Best regards
Uwe

--rvsi7ta2ttjctr7v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmdRW1wACgkQj4D7WH0S
/k5NPAf/RC69KmaB9kq+B16gx7w5ljnJrljaEMEKVOJDmAlXa+hcZrJ3197ibV+B
g7IjPcVe8/kdKZxH1dOhkcfvhjqOiLw+Mw2dpLHT2sNmVgu2fFkMcP2c3ZtKGIsf
ytKtqbvm0uYcbIuUObx5sy4OSuNjTtEg//lnRY9Y1iuSPYdZcRCiil1yCM6ksQg6
3zPKmRAXFqMbWn9WBvaEzD5o126TuxjGmhXzMlYk1iSnoolSf9uLKdfxQfjzq15V
P+pp2L3pVeo0bUu5FtsMEnwoHweghgnHSKwMDJG7zN9CUxFQpRFOOv83nHkJ+szq
MJSM0/EPQk/w17X06HpTIHVJCPWVkw==
=PDju
-----END PGP SIGNATURE-----

--rvsi7ta2ttjctr7v--

