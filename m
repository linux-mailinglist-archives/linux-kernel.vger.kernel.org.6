Return-Path: <linux-kernel+bounces-259379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C228693950A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 23:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 471C22823AD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 21:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24EBB3BBEF;
	Mon, 22 Jul 2024 21:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V2exUegN"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DF9219FF
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 21:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721682219; cv=none; b=X+AkVJBnpx12SFVPBnYXKxMwtoZGUiNSyneKJp67gDPaY+9W3x234Ymf22t7CQQGO6ofL62VrZTvQ3Xdgz5YFfcZjwV0Wr6kyf3h7la0NqtPIVllo7hh2B7l0HzTPBiHMWE+1ZBYVXNpNQZ2X2f6I5LbdXr4Bo03ZUinSj9SOOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721682219; c=relaxed/simple;
	bh=Dyyk0UtQI2s2zXdEck3cub2Ha7fMt1dkCLqj3rtntB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G8Tu/na5lXnE4Zhz1Ty3/BnAvEC+a1Q6GgxgDRuVUTk+FiBJXqANpxSBKS8niJkMuKb7+MZ4mecTi3VYeBGupiZQvUaV9y94QDHS+UooshWmgK7WpPEfYXurIhKWnUvwthoblBqwW7UoEYaJk5Tj8OrqLnmT4EFLY4aMwGCV5Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V2exUegN; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6510c0c8e29so46085897b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 14:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721682215; x=1722287015; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pA4esXho/xY3wZIC+Ikl7BfsGHq8cUkOJbqTEXw5Avw=;
        b=V2exUegN7I9SekyttHLhYmve+BtdeM182f9LUQU1mKkHwqaQHN33I9QgOun/Pi1Spe
         QagmJkLved/znjKgCt9QxVnnNCSvvdenbgfzVPWlO96gyvmXGeRsrq2lfWdikB0BHG3Z
         iWsTn9j9MxsdU/wkQMoxvozA8diza4GgnP70oOLwgcohpEpTxFBuNDfULEoe7AG/dhNZ
         ty08b3bpHxEU75ompqBMPWcK5NoxmvApQu6HwSRDTxLJWjfqUl/rMGcYIEGJW06GXssc
         gar7Y9dI3WT7dBBdeQQp6JQ9SY61A8VgSEZ4s1s5nZwq50e8YqlPzv7ZFFMBI0Wj6Sz+
         PSVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721682215; x=1722287015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pA4esXho/xY3wZIC+Ikl7BfsGHq8cUkOJbqTEXw5Avw=;
        b=n4+mO+Sdltu93O0ygLnEnkZBczvd1mDApizP84auSi+dhnexDOHDJ2UMfE7RNpmZyA
         twDXKyWlPQSmMvOYYhql90GRPAcJMjBJU0fpLgdxdgitltMJBCgBREXLgrAb1lG9DFGM
         rOm/MSv9BrOPtD44i9oS55TjqSS7VPUEWG09bFCZTRqcmERizmyKvotHwk0YzpADgy5b
         e6Wq8iYATSxbzgvPgEuqp+tgP6gAy8PhGpQ7NVggSqtJFqMW9msJSxtIknzbiJCQF4q0
         uRELN4Ys9cqA9hy19Kg6DNJTCAao8KanJQ7iuaar9ZminxmS/Cxc16KOUem4359i7/66
         WdCg==
X-Forwarded-Encrypted: i=1; AJvYcCXNE7T3FyinYlINlp9YX3VxGhhWHbexwPDTQVvkVP0KDXexWGePIOEaTo8Rw8j00qE9ig5qd2Pa3+8KkhyDIFDdYn3ORmuXmr5eJwuz
X-Gm-Message-State: AOJu0YzwLmKC6SZxFiNJd4rJNUlxBK56k2329BTRJObBUjzNm1D2Hh7I
	gB4Tsi3Pd0VrbJIq7c3Q6VQi0KUDF1g0HIMORCna6jRJvlZQxuHs8rPCiXbJN3TQIKaWYH2+N+l
	kfkvZVhjuLnBT3t4JpMovBmJjWNSDjvmkr7E9Hg==
X-Google-Smtp-Source: AGHT+IEWo/FcymcxuKvd1CVhLXPm4DiTgZ0Eqln9Cdibw/tKHuRALX2Zj2KevZfouYq2gVU9dAICph9qA8nd1/w2PEo=
X-Received: by 2002:a05:690c:399:b0:625:1090:b54f with SMTP id
 00721157ae682-66e4ded5f93mr15022127b3.39.1721682215174; Mon, 22 Jul 2024
 14:03:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20240719120946eucas1p1b565fa653d33aa2155cd3bb172c29d14@eucas1p1.samsung.com>
 <20240719120853.1924771-1-m.majewski2@samsung.com> <20240719120853.1924771-4-m.majewski2@samsung.com>
In-Reply-To: <20240719120853.1924771-4-m.majewski2@samsung.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Mon, 22 Jul 2024 16:03:24 -0500
Message-ID: <CAPLW+4=NnmSNp30mm04-38j8r9Uy2MUbq28Ua7=aT13uo=NH=Q@mail.gmail.com>
Subject: Re: [PATCH 3/6] drivers/thermal/exynos: check IS_ERR(data->clk) consistently
To: Mateusz Majewski <m.majewski2@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2024 at 7:10=E2=80=AFAM Mateusz Majewski
<m.majewski2@samsung.com> wrote:
>
> This will be needed for Exynos 850 support, which does not require this
> clock.
>
> It would also be possible to set data->clk to NULL instead, but doing it
> like this is consistent with what we do with data->clk_sec.
>
> Signed-off-by: Mateusz Majewski <m.majewski2@samsung.com>
> ---
>  drivers/thermal/samsung/exynos_tmu.c | 58 ++++++++++++++++++----------
>  1 file changed, 38 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsu=
ng/exynos_tmu.c
> index 61606a9b9a00..f0de72a62fd7 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -257,7 +257,8 @@ static int exynos_tmu_initialize(struct platform_devi=
ce *pdev)
>         int ret =3D 0;
>
>         mutex_lock(&data->lock);
> -       clk_enable(data->clk);
> +       if (!IS_ERR(data->clk))
> +               clk_enable(data->clk);

Hmm, it looks like it's better to rework this clock obtaining using
devm_clk_get_optional() API, or even devm_clk_get_optional_prepared()
in this case. It'll simplify its further usage, i.e. it'll be possible
to just call clk_enable() without checking the clock with IS_ERR()
each time. You can check these drivers for pointers on optional API
usage:

  - drivers/i2c/busses/i2c-exynos5.c
  - drivers/watchdog/s3c2410_wdt.c

Also, if it's only optional for Exynos850 (and not optional for other
chips), maybe it would be a good idea to use *_optional_* API only for
Exynos850 case, so that the driver's behavior for those chips stays
unchanged.

Btw, from the downstream kernel code [1] I can see that the only TMU
clock present in Exynos850 is
GOUT_BLK_PERI_UID_BUSIF_TMU_IPCLKPORT_PCLK (which I was able to
confirm in TRM). But it's not enabled in clk-exynos850.c driver right
now. Do you want me by chance to send the patch adding it?

[1] https://gitlab.com/Linaro/96boards/e850-96/kernel/-/blob/android-exynos=
-5.10-linaro/drivers/soc/samsung/cal-if/s5e3830/cmucal-node.c?ref_type=3Dhe=
ads#L1196

>         if (!IS_ERR(data->clk_sec))
>                 clk_enable(data->clk_sec);
>
> @@ -271,7 +272,8 @@ static int exynos_tmu_initialize(struct platform_devi=
ce *pdev)
>
>         if (!IS_ERR(data->clk_sec))
>                 clk_disable(data->clk_sec);
> -       clk_disable(data->clk);
> +       if (!IS_ERR(data->clk))
> +               clk_disable(data->clk);
>         mutex_unlock(&data->lock);
>
>         return ret;
> @@ -295,11 +297,13 @@ static int exynos_thermal_zone_configure(struct pla=
tform_device *pdev)
>         }
>
>         mutex_lock(&data->lock);
> -       clk_enable(data->clk);
> +       if (!IS_ERR(data->clk))
> +               clk_enable(data->clk);
>
>         data->tmu_set_crit_temp(data, temp / MCELSIUS);
>
> -       clk_disable(data->clk);
> +       if (!IS_ERR(data->clk))
> +               clk_disable(data->clk);
>         mutex_unlock(&data->lock);
>
>         return 0;
> @@ -328,10 +332,12 @@ static void exynos_tmu_control(struct platform_devi=
ce *pdev, bool on)
>         struct exynos_tmu_data *data =3D platform_get_drvdata(pdev);
>
>         mutex_lock(&data->lock);
> -       clk_enable(data->clk);
> +       if (!IS_ERR(data->clk))
> +               clk_enable(data->clk);
>         data->tmu_control(pdev, on);
>         data->enabled =3D on;
> -       clk_disable(data->clk);
> +       if (!IS_ERR(data->clk))
> +               clk_disable(data->clk);
>         mutex_unlock(&data->lock);
>  }
>
> @@ -648,7 +654,8 @@ static int exynos_get_temp(struct thermal_zone_device=
 *tz, int *temp)
>                 return -EAGAIN;
>
>         mutex_lock(&data->lock);
> -       clk_enable(data->clk);
> +       if (!IS_ERR(data->clk))
> +               clk_enable(data->clk);
>
>         value =3D data->tmu_read(data);
>         if (value < 0)
> @@ -656,7 +663,8 @@ static int exynos_get_temp(struct thermal_zone_device=
 *tz, int *temp)
>         else
>                 *temp =3D code_to_temp(data, value) * MCELSIUS;
>
> -       clk_disable(data->clk);
> +       if (!IS_ERR(data->clk))
> +               clk_disable(data->clk);
>         mutex_unlock(&data->lock);
>
>         return ret;
> @@ -723,9 +731,11 @@ static int exynos_tmu_set_emulation(struct thermal_z=
one_device *tz, int temp)
>                 goto out;
>
>         mutex_lock(&data->lock);
> -       clk_enable(data->clk);
> +       if (!IS_ERR(data->clk))
> +               clk_enable(data->clk);
>         data->tmu_set_emulation(data, temp);
> -       clk_disable(data->clk);
> +       if (!IS_ERR(data->clk))
> +               clk_disable(data->clk);
>         mutex_unlock(&data->lock);
>         return 0;
>  out:
> @@ -763,12 +773,14 @@ static irqreturn_t exynos_tmu_threaded_irq(int irq,=
 void *id)
>         thermal_zone_device_update(data->tzd, THERMAL_EVENT_UNSPECIFIED);
>
>         mutex_lock(&data->lock);
> -       clk_enable(data->clk);
> +       if (!IS_ERR(data->clk))
> +               clk_enable(data->clk);
>
>         /* TODO: take action based on particular interrupt */
>         data->tmu_clear_irqs(data);
>
> -       clk_disable(data->clk);
> +       if (!IS_ERR(data->clk))
> +               clk_disable(data->clk);
>         mutex_unlock(&data->lock);
>
>         return IRQ_HANDLED;
> @@ -979,7 +991,8 @@ static int exynos_set_trips(struct thermal_zone_devic=
e *tz, int low, int high)
>         struct exynos_tmu_data *data =3D thermal_zone_device_priv(tz);
>
>         mutex_lock(&data->lock);
> -       clk_enable(data->clk);
> +       if (!IS_ERR(data->clk))
> +               clk_enable(data->clk);
>
>         if (low > INT_MIN)
>                 data->tmu_set_low_temp(data, low / MCELSIUS);
> @@ -990,7 +1003,8 @@ static int exynos_set_trips(struct thermal_zone_devi=
ce *tz, int low, int high)
>         else
>                 data->tmu_disable_high(data);
>
> -       clk_disable(data->clk);
> +       if (!IS_ERR(data->clk))
> +               clk_disable(data->clk);
>         mutex_unlock(&data->lock);
>
>         return 0;
> @@ -1053,10 +1067,12 @@ static int exynos_tmu_probe(struct platform_devic=
e *pdev)
>                 }
>         }
>
> -       ret =3D clk_prepare(data->clk);
> -       if (ret) {
> -               dev_err(dev, "Failed to get clock\n");
> -               goto err_clk_sec;
> +       if (!IS_ERR(data->clk)) {
> +               ret =3D clk_prepare(data->clk);
> +               if (ret) {
> +                       dev_err(dev, "Failed to get clock\n");
> +                       goto err_clk_sec;
> +               }
>         }
>
>         switch (data->soc) {
> @@ -1113,7 +1129,8 @@ static int exynos_tmu_probe(struct platform_device =
*pdev)
>  err_sclk:
>         clk_disable_unprepare(data->sclk);
>  err_clk:
> -       clk_unprepare(data->clk);
> +       if (!IS_ERR(data->clk))
> +               clk_unprepare(data->clk);
>  err_clk_sec:
>         if (!IS_ERR(data->clk_sec))
>                 clk_unprepare(data->clk_sec);
> @@ -1127,7 +1144,8 @@ static void exynos_tmu_remove(struct platform_devic=
e *pdev)
>         exynos_tmu_control(pdev, false);
>
>         clk_disable_unprepare(data->sclk);
> -       clk_unprepare(data->clk);
> +       if (!IS_ERR(data->clk))
> +               clk_unprepare(data->clk);
>         if (!IS_ERR(data->clk_sec))
>                 clk_unprepare(data->clk_sec);
>  }
> --
> 2.45.1
>
>

