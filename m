Return-Path: <linux-kernel+bounces-397172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4799BD7A5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 22:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A06F81C22915
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 21:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D39821621D;
	Tue,  5 Nov 2024 21:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EunV2Yw+"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90892161EF
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 21:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730842204; cv=none; b=tljax/mUJKAeScZHnCctCzSP1qsr63a6Hbw2rX5QmSl/MtLlePYVfhdGI+/aoAna1h5wn7VGOGY/IHnZpb/kGHNazdeF8o0N6/AUfcaxFF1AOwOGDOQyC3ppSv/5kZnmYCok1PTqNL/8RYcs6jEFV0KXdyNzioTcUT+iqA54lNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730842204; c=relaxed/simple;
	bh=h7AwGN4io3/uPTbQx+qrX5kizmH08R1HDFUD/HNRelQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iQsE4t+7E+9KPaxt2+7YXByJjQ9XPrqVW4G6Z3qv9eLYlytfrWE7WIMLU3rcToxiD76G1QocIIuOI/0F3HeGlwzjc276bcR9QKUr2X4juMbex17lZiaLlXirzeKKrf3tSJTsEt0Vbk6PyGk7GSMpTfAmck0bLyFk6VdUr21SKw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EunV2Yw+; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539fe76e802so6938680e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 13:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730842198; x=1731446998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Tfp+kt6EeLErLEVv0I8PpE8RVWyGWlaG6f1mvrWPCE=;
        b=EunV2Yw+iHAzERIxYmyRCHjRAJjXIR4xU01NfAtho+Vr3cXDsqsD8TbVuqzk/Jdp2P
         4qSc+lqrJ86ajlvyF/RlzKWbgFJ/+3lTlL5keWWkKMsT14jFOMZ5To6XRNLl0bdg05Xo
         EzoGyMOVl9IoLMg8quYH13egi1Vsvd88JoQF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730842198; x=1731446998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Tfp+kt6EeLErLEVv0I8PpE8RVWyGWlaG6f1mvrWPCE=;
        b=A9cLPW2mHbHcbbdQ6KcittzfEkw2AgqItUPFhPEhbFiO7pZdVY/dRLb8wzvOk7oqZr
         HSmwAK4fy930oT4Pl0iVg5QcRW3IA3lQvuRSzdEHBBdAH82uZmPU5R4L4mddPIwFY0Gz
         EogmZit25VJ8Y/RTLkyLiLRy8J6lv+0grKoOa7tQSaRhDwuf05WvoJNYfjPBI+VXRLml
         Gak3CC7cFjfLRtUn4XxdP2EUGytY0PB8qv1Zoe6aDO6FkWLzZK2z+sl2jQF1GuckfRyY
         2yhkp98PUcI7+s3xgrFwnM2J4vDMtq/F973MK+P9qjVlqkeDOoenvemJUB6VodkBwk/e
         JtTQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0K/kpjF2FbWExIGhZmTRr6h5IY010g0C9ffrMrg84nmZKgsswrUC1tFPPVVc6apU0l6nStEgtsC6sNDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiKFCBgRaZ6O22q20hgfRjAE4R3/W4DtkYpIEM44p3IsQrDjNm
	LDzbKstnbwP2qRUjcM3ITHe5VUo26IxVS20boUMSewDqHsxQ/bOV+qcpXtJ7LXqLu+TQlf5dRBA
	rWQ==
X-Google-Smtp-Source: AGHT+IEsiSPme8MbnfI3be2W0Eg+b/vW6hi+3HDId9r4eYB8mWgpk04wS/inqRlZXfOvnK7JpbH5Rg==
X-Received: by 2002:a05:6512:3ba4:b0:52c:9468:c991 with SMTP id 2adb3069b0e04-53d65de495bmr8366961e87.14.1730842197856;
        Tue, 05 Nov 2024 13:29:57 -0800 (PST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bcce4c2sm2261179e87.174.2024.11.05.13.29.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2024 13:29:56 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fb5014e2daso55284721fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 13:29:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUUssnMrUd1Ba2sN04Y4usYzwWSkTfsNLerD4IJFc1I9RfzjI0cZlXwE8AdorbbggYGYNZBNuRTVAu4ZhU=@vger.kernel.org
X-Received: by 2002:a2e:bd08:0:b0:2fa:cf5b:1e8e with SMTP id
 38308e7fff4ca-2fedb758b32mr81564941fa.2.1730842195431; Tue, 05 Nov 2024
 13:29:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105161820.32512-1-jiashengjiangcool@gmail.com> <20241105161820.32512-3-jiashengjiangcool@gmail.com>
In-Reply-To: <20241105161820.32512-3-jiashengjiangcool@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 5 Nov 2024 13:29:40 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VzqKa=fo4KRw4FSpPcH4mVnt8jBMo=FMzsGkdGrXCfxg@mail.gmail.com>
Message-ID: <CAD=FV=VzqKa=fo4KRw4FSpPcH4mVnt8jBMo=FMzsGkdGrXCfxg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] i2c: rk3x: Add check for clk_enable()
To: Jiasheng Jiang <jiashengjiangcool@gmail.com>
Cc: andi.shyti@kernel.org, rmk@dyn-67.arm.linux.org.uk, max.schwarz@online.de, 
	david.wu@rock-chips.com, heiko@sntech.de, vz@mleia.com, wsa@kernel.org, 
	manabian@gmail.com, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Nov 5, 2024 at 8:18=E2=80=AFAM Jiasheng Jiang
<jiashengjiangcool@gmail.com> wrote:
>
> Add check for the return value of clk_enable() in order to catch the
> potential exception. Moreover, convert the return type of
> rk3x_i2c_adapt_div() into int and add the check.
>
> Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
> ---
> Changelog:
>
> v1 -> v2:
>
> 1. Remove the Fixes tag.
> 2. Use dev_err_probe to simplify error handling.
> ---
>  drivers/i2c/busses/i2c-rk3x.c | 51 +++++++++++++++++++++++++----------
>  1 file changed, 37 insertions(+), 14 deletions(-)

Wow, this is a whole lot of code to add to check for an error that
can't really happen as far as I'm aware. Turning on a clock is just
some MMIO writes and can't fail, right? Is this really worth it? Maybe
just wrap clk_enable() and spam an error to the logs if it fails? If
we ever see that error we can figure out what's going on and if
there's a sensible reason it could fail we could add the more complex
code.


> @@ -883,7 +883,9 @@ static void rk3x_i2c_adapt_div(struct rk3x_i2c *i2c, =
unsigned long clk_rate)
>         ret =3D i2c->soc_data->calc_timings(clk_rate, t, &calc);
>         WARN_ONCE(ret !=3D 0, "Could not reach SCL freq %u", t->bus_freq_=
hz);
>
> -       clk_enable(i2c->pclk);
> +       ret =3D clk_enable(i2c->pclk);
> +       if (ret)
> +               return dev_err_probe(i2c->dev, ret, "Can't enable bus clk=
 for rk3399: %d\n", ret);

Officially you're only supposed to use "dev_err_probe()" from probe or
calls indirectly called from probe. You're now using it in a whole lot
of other places.

...also note that dev_err_probe() already prints the error so you
don't need to include it in your error message.


> @@ -942,19 +946,27 @@ static int rk3x_i2c_clk_notifier_cb(struct notifier=
_block *nb, unsigned long
>                         return NOTIFY_STOP;
>
>                 /* scale up */
> -               if (ndata->new_rate > ndata->old_rate)
> -                       rk3x_i2c_adapt_div(i2c, ndata->new_rate);
> +               if (ndata->new_rate > ndata->old_rate) {
> +                       if (rk3x_i2c_adapt_div(i2c, ndata->new_rate))
> +                               return NOTIFY_STOP;
> +               }
>
>                 return NOTIFY_OK;
>         case POST_RATE_CHANGE:
>                 /* scale down */
> -               if (ndata->new_rate < ndata->old_rate)
> -                       rk3x_i2c_adapt_div(i2c, ndata->new_rate);
> +               if (ndata->new_rate < ndata->old_rate) {
> +                       if (rk3x_i2c_adapt_div(i2c, ndata->new_rate))
> +                               return NOTIFY_STOP;
> +               }
> +
>                 return NOTIFY_OK;
>         case ABORT_RATE_CHANGE:
>                 /* scale up */
> -               if (ndata->new_rate > ndata->old_rate)
> -                       rk3x_i2c_adapt_div(i2c, ndata->old_rate);
> +               if (ndata->new_rate > ndata->old_rate) {
> +                       if (rk3x_i2c_adapt_div(i2c, ndata->old_rate))
> +                               return NOTIFY_STOP;

I'm not convinced you can actually return NODIFY_STOP from the
POST_RATE_CHANGE or ABORT_RATE_CHANGE. Have you confirmed that is
actually sensible?


> @@ -1365,9 +1385,12 @@ static int rk3x_i2c_probe(struct platform_device *=
pdev)
>         }
>
>         clk_rate =3D clk_get_rate(i2c->clk);
> -       rk3x_i2c_adapt_div(i2c, clk_rate);
> +       ret =3D rk3x_i2c_adapt_div(i2c, clk_rate);
>         clk_disable(i2c->clk);
>
> +       if (ret)
> +               goto err_clk_notifier;

This one seems especially comical to add since the only way
rk3x_i2c_adapt_div() could fail would be if a nested clk_enable()
failed. ...and I'm 99% sure that's not possible.

-Doug

