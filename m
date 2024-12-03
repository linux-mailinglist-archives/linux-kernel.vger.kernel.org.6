Return-Path: <linux-kernel+bounces-430150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF369E2D05
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 21:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE61E28123F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 20:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C30205E2E;
	Tue,  3 Dec 2024 20:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="FXV902lo"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCB11B0F09
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 20:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733257648; cv=none; b=a2EDhCI8Wb/VJvlXFrtFD6K1zv0AKQfkyxfyHUUe6bFWYOkEqzMoY5R4r7BXX7O4Ke5SrJ/Be3zzFaizDLPrZkwo8VFbIkGi0OvaOES3TDQXjQwch1jPh41u7s6rSHuRF5s91v2TYPKJBptbsAdNjjnOHJSjWtRBbAy0FdVqkjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733257648; c=relaxed/simple;
	bh=0nDNLU0QqS5naP5m8r89FpLO0RTYBNZNYYgROoCW2E4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RyJufET/gAUGVinLp5N145OOK9vusRoplAzcelgZjIizKpWVKwuDBzXfjFD4oGdDgR+MghryFBqpP0ORxpd2ZZLOLjqf+9pPTimotMfYvO3631XcGDnjVcJEJpu2O7zEWzeBzN8LfTzXHslAtdK4LlJLxHt+g5CQ0cX4k947p9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=FXV902lo; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53e152731d0so167279e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 12:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1733257645; x=1733862445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7mYLgWRx19EhLntfJHR6XQME2VsuqQ9Oja4sZu+CCPU=;
        b=FXV902loB3Eke6CtlkagAXU6BL650DWw6DbzCzvhak7Fb3IHlyIMmXyOE9ckWeLsQO
         piYlMxIwMXOnZoJSkfW6u8Lgdl1BVYOv2GrkxOzCqYbJ130AfJ3d7cgOWn2jjSLqI1xI
         Uve+XNLkLZD2KtmMuVV541ApqWSdICEXLNwef/xYdjVqSWF9PuihSqBX4PC+YFnM6Wmo
         iJQjRkh/PAbnu1Y+q6Fc0Efg+FcX77fSbaqrmShTQ7rulFSwMNYkxJ9q2JBIjepUBO0l
         LuPdvvwqQs6S6TIZtT9hpvEalETv+zKi9RwMtmHifiY6YX1DOA1Fepjln7yE7dWZ6iP2
         xEiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733257645; x=1733862445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7mYLgWRx19EhLntfJHR6XQME2VsuqQ9Oja4sZu+CCPU=;
        b=VhhrMBH6sGbyBimg8iAXEPav7Qv/uQi2jJkZguypNrYr11+6KAa+2epphFc0y14vRm
         uM8vVgKYK6X29lRokXB999oXfQTtQLe8paz++VBnF9HzdxxzuGxHbN5i1IxxQAgNXWat
         XwIDZMEqM+R28O5+Dj3RBf3w32l5NjfR4C8NCXgDRHhg11X3LC9BlcSFYlJYnGWoFvJA
         sF60slONkBHyIwC9/m/fVwJUJ2si8I0dhsTct5yFCwcCAVG0qMqvFY6dKPvDQb0ervz/
         p4Hjn7Q2qxTZCCG5tzGHzLvNDb714hn8LbnezlZiF/bDaywK1LGkuTh6P9Z0dYNUsNCv
         LX+Q==
X-Forwarded-Encrypted: i=1; AJvYcCU+JDSAkPTGhVVCz/pFEvojIZlsQrJt3wYWL0vORj556u3iyLP0aNWV7r0gd+cnLjAcl6tymOAgeoje6Kw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXcunCziWV0Mofw9xDEx9hE2iss0A4mdqjmkC0imX8Q9w4jdSe
	OI0kIEU30E9kakQgRGklBDiFYT89XVpJEMTif7piDanzvMKrHbvKWXlSIo6lpxuRcG23JGAaLjH
	1771fm2oRNcRmbh+hAzII3OFcUbOsMhni23UstA==
X-Gm-Gg: ASbGnctVHcQ2Y+zBfEYLknJGI8KH6IbU1gOgSdgX22cBuOR5xO7wVS44V/g+jzyBRyg
	nOwHURI3A+rDDw0M5rlRHdkw1+e/ZdvU=
X-Google-Smtp-Source: AGHT+IHTJDxVt4kVp1R1qLjhVx/yNmiNeG07rAAd6X/haudry/By7fRJmRzYReE4NmWiWYuDtOH6tXvmTboOfqMnWHw=
X-Received: by 2002:a05:6512:3f06:b0:53d:dfbd:3e68 with SMTP id
 2adb3069b0e04-53e12db7668mr1445334e87.7.1733257644249; Tue, 03 Dec 2024
 12:27:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203180553.16893-1-ebiggers@kernel.org>
In-Reply-To: <20241203180553.16893-1-ebiggers@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 3 Dec 2024 21:27:13 +0100
Message-ID: <CAMRc=MfMoZHW5qea4AkftGt=nZJGgBDF_Ws+ESVXmyA=cV_ECw@mail.gmail.com>
Subject: Re: [PATCH] crypto: qce - fix priority to be less than ARMv8 CE
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, stable@vger.kernel.org, 
	Neil Armstrong <neil.armstrong@linaro.org>, Thara Gopinath <thara.gopinath@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 7:06=E2=80=AFPM Eric Biggers <ebiggers@kernel.org> w=
rote:
>
> From: Eric Biggers <ebiggers@google.com>
>
> As QCE is an order of magnitude slower than the ARMv8 Crypto Extensions
> on the CPU, and is also less well tested, give it a lower priority.
> Previously the QCE SHA algorithms had higher priority than the ARMv8 CE
> equivalents, and the ciphers such as AES-XTS had the same priority which
> meant the QCE versions were chosen if they happened to be loaded later.
>
> Fixes: ec8f5d8f6f76 ("crypto: qce - Qualcomm crypto engine driver")
> Cc: stable@vger.kernel.org
> Cc: Bartosz Golaszewski <brgl@bgdev.pl>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Thara Gopinath <thara.gopinath@gmail.com>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  drivers/crypto/qce/aead.c     | 2 +-
>  drivers/crypto/qce/sha.c      | 2 +-
>  drivers/crypto/qce/skcipher.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/crypto/qce/aead.c b/drivers/crypto/qce/aead.c
> index 7d811728f047..97b56e92ea33 100644
> --- a/drivers/crypto/qce/aead.c
> +++ b/drivers/crypto/qce/aead.c
> @@ -784,11 +784,11 @@ static int qce_aead_register_one(const struct qce_a=
ead_def *def, struct qce_devi
>         alg->encrypt                    =3D qce_aead_encrypt;
>         alg->decrypt                    =3D qce_aead_decrypt;
>         alg->init                       =3D qce_aead_init;
>         alg->exit                       =3D qce_aead_exit;
>
> -       alg->base.cra_priority          =3D 300;
> +       alg->base.cra_priority          =3D 275;
>         alg->base.cra_flags             =3D CRYPTO_ALG_ASYNC |
>                                           CRYPTO_ALG_ALLOCATES_MEMORY |
>                                           CRYPTO_ALG_KERN_DRIVER_ONLY |
>                                           CRYPTO_ALG_NEED_FALLBACK;
>         alg->base.cra_ctxsize           =3D sizeof(struct qce_aead_ctx);
> diff --git a/drivers/crypto/qce/sha.c b/drivers/crypto/qce/sha.c
> index fc72af8aa9a7..71b748183cfa 100644
> --- a/drivers/crypto/qce/sha.c
> +++ b/drivers/crypto/qce/sha.c
> @@ -480,11 +480,11 @@ static int qce_ahash_register_one(const struct qce_=
ahash_def *def,
>         else if (IS_SHA256(def->flags))
>                 tmpl->hash_zero =3D sha256_zero_message_hash;
>
>         base =3D &alg->halg.base;
>         base->cra_blocksize =3D def->blocksize;
> -       base->cra_priority =3D 300;
> +       base->cra_priority =3D 175;
>         base->cra_flags =3D CRYPTO_ALG_ASYNC | CRYPTO_ALG_KERN_DRIVER_ONL=
Y;
>         base->cra_ctxsize =3D sizeof(struct qce_sha_ctx);
>         base->cra_alignmask =3D 0;
>         base->cra_module =3D THIS_MODULE;
>         base->cra_init =3D qce_ahash_cra_init;
> diff --git a/drivers/crypto/qce/skcipher.c b/drivers/crypto/qce/skcipher.=
c
> index 5b493fdc1e74..ffb334eb5b34 100644
> --- a/drivers/crypto/qce/skcipher.c
> +++ b/drivers/crypto/qce/skcipher.c
> @@ -459,11 +459,11 @@ static int qce_skcipher_register_one(const struct q=
ce_skcipher_def *def,
>                                           IS_DES(def->flags) ? qce_des_se=
tkey :
>                                           qce_skcipher_setkey;
>         alg->encrypt                    =3D qce_skcipher_encrypt;
>         alg->decrypt                    =3D qce_skcipher_decrypt;
>
> -       alg->base.cra_priority          =3D 300;
> +       alg->base.cra_priority          =3D 275;
>         alg->base.cra_flags             =3D CRYPTO_ALG_ASYNC |
>                                           CRYPTO_ALG_ALLOCATES_MEMORY |
>                                           CRYPTO_ALG_KERN_DRIVER_ONLY;
>         alg->base.cra_ctxsize           =3D sizeof(struct qce_cipher_ctx)=
;
>         alg->base.cra_alignmask         =3D 0;
>
> base-commit: ceb8bf2ceaa77fe222fe8fe32cb7789c9099ddf1
> --
> 2.47.1
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

But the QCE driver will still be worked on due to features that we
want to support that the CE don't have.

Bart

