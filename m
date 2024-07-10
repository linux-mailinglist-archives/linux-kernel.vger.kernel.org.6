Return-Path: <linux-kernel+bounces-247628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E3C92D22B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 15:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B59DF1F2566B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 13:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF9B1922C1;
	Wed, 10 Jul 2024 13:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Xy58D14g"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F4183CD4
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 13:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720616511; cv=none; b=lwJ7dQQHJmU6LdvFM4fpLJg7Kq4rxlmeJSOpvQ12cgX2KYIZsGz95+xUAHpO/bT3tkopyULvvVC+f02zd3K2zkcRdVDHU412UFQrFdfekROZldAxUwuTKKNDbYZLx7PdpM1GCNeIOU09tmNKPBGELqhcG9AvKWUA2eTumOG/LCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720616511; c=relaxed/simple;
	bh=2d66L5ahiRMoRzJ9PyAUmzuSdTlKiBmpZb5ozGnaye8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bwb/fPQa+51IXz3wmRVWVKx0iNOr4xtJ1NDv7U6a25zKgh8T+tdQxOd3dC9SLRUXWJVcnmsD01vP2LvBlctWUHAW0HCtI0x9xRTIWYdjqrGStzfGyUTrwc7O9PRps047sjHjLtz0NKncxslB7m3FEGcMeM0N1a2s24Hnp9xJtqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Xy58D14g; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2eebc76119aso14741821fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 06:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1720616508; x=1721221308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rgPvKbl/DpWtkCekApAA14wU8fcbrtteujl0vdZjSi0=;
        b=Xy58D14g6xEOImqnPC5nvqBR8SsbiznRJY/a/41GfZjdDSQq5GYdIBSNM4b6ouLs1/
         lT8M5+Veyl7RqvLbk6eJLtQdafOtlgpPmwLk6wWMJjxwDXMsAYko8C0YYkvKlSwdxFhh
         TwutqjqAsALbsdt8fVjBo4ufOOTdQN6BZHOTxVjgCzFrZ70AOS8Tv0QJyqg/1Sw3smz8
         DaS4UvzFASCycJr47WhDzZ68zYGanhzySwg11VZr+ES9SwnzxaA1dGxnTWOC9dmCs6s9
         iKZtRSH0jTFWQbjLPB2Px6bWoNTnE1QGEtxCk4T6F2zNvVs4g9tJpXcYflBkgqOZCp+I
         sN9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720616508; x=1721221308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rgPvKbl/DpWtkCekApAA14wU8fcbrtteujl0vdZjSi0=;
        b=dvaws3TyytUeorMK67Z5xNXA47IdshddV5fFz1YxJe+02lnaQMF56INP3mAO8Q6w3z
         CmPUlNY5HBfwjd/4Ouv/jcryF/3c3I/AqdGMYZ2Nb45zcM5o+0IdsXluWhnPuLQ02cVS
         6CFCuVvn1oN98EHvoCqqdOpCSKyzxZLnDAlsFi+p9iz5T5rzcRMi8TBiORNLx/RV4Fkb
         qpgrRJHd/kJhwvsvonz6T9TnfPBxsSMAWt98PGySl4e10igW8X/dxZzC6FJwSs8+EjEk
         uVMGWr9Tk10dvYnLwejyJFQbjxhulPcq8afmS0YUk7GP7GpN+t3918BicY+axHv2fMCi
         FKgg==
X-Forwarded-Encrypted: i=1; AJvYcCVw44FsUGb58MkgmtfLbb6zHR/vMzmWz+/wjMAOsVhYB1/6lxkIMkeGJscMbzSDBWbsEgaKhkLbbFyZwHKdcG30qmA1UKZwuvp+ih9i
X-Gm-Message-State: AOJu0Ywnc+W6GQnIB9sVwdJsmcgs4MCpO/tscq39QzofLEMsoqKgjtpQ
	L9ISxpL6FGWH+1hA4LlU9/llLdHUjAcF9yqp42C33KzdkPhBlpBjmykPGAWcx0CpiHZ5m+g84mN
	3twz1L0hRsDaUAb6ofM7NBPEl9kGPm9rbLOtLzQ==
X-Google-Smtp-Source: AGHT+IG9uQnRstTU+hfvtOAs/5Njs0CsI0p3bo7tKoSX7ThALyJCaNKuhTjRfXwL0taHgQQ3JWmz1aGTu9TnTyuUHpQ=
X-Received: by 2002:a2e:9b0f:0:b0:2ec:550e:24f3 with SMTP id
 38308e7fff4ca-2eeb30bc603mr41090301fa.10.1720616508276; Wed, 10 Jul 2024
 06:01:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710081648.2286573-1-nichen@iscas.ac.cn>
In-Reply-To: <20240710081648.2286573-1-nichen@iscas.ac.cn>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 10 Jul 2024 15:01:36 +0200
Message-ID: <CAMRc=Mcp=hjTLmwKNPvBEVdSrV5W23M9a-vO2OXRLkKN5318jA@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: davinci: Convert comma to semicolon
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux@armlinux.org.uk, khilman@deeprootsystems.com, nsekhar@ti.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Chen Ni <nichen@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 10:17=E2=80=AFAM Chen Ni <nichen@iscas.ac.cn> wrote=
:
>
> Replace a comma between expression statements by a semicolon.
>
> Fixes: efc1bb8a6fd5 ("davinci: add power management support")
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
> Changelog:
>
> v1 -> v2:
>
> 1. Add Fixes tag.
> ---
>  arch/arm/mach-davinci/pm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-davinci/pm.c b/arch/arm/mach-davinci/pm.c
> index 8aa39db095d7..2c5155bd376b 100644
> --- a/arch/arm/mach-davinci/pm.c
> +++ b/arch/arm/mach-davinci/pm.c
> @@ -61,7 +61,7 @@ static void davinci_pm_suspend(void)
>
>         /* Configure sleep count in deep sleep register */
>         val =3D __raw_readl(pm_config.deepsleep_reg);
> -       val &=3D ~DEEPSLEEP_SLEEPCOUNT_MASK,
> +       val &=3D ~DEEPSLEEP_SLEEPCOUNT_MASK;
>         val |=3D pm_config.sleepcount;
>         __raw_writel(val, pm_config.deepsleep_reg);
>
> --
> 2.25.1
>

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Arnd,

I don't want to spam you with a late PR with just this oneliner. Can
you pick it up directly if it's not too late in this cycle?

Bart

