Return-Path: <linux-kernel+bounces-421999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF449D9315
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 09:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB03E283A7B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 08:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68526195FEF;
	Tue, 26 Nov 2024 08:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QJiaRvGr"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA9B194C78
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 08:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732608513; cv=none; b=keNTiHY+TE7nDCD3O3aU3OmOrBMFvbhyN1KzK+O9Gdhf5T9UF8z47ln3VeL4OgSVi9vbYcez7DKXeAVIeIC2Sh38hkmZfdABQrJVCdtnrNfaIM82+qTXfX9/JyOiFuwnEa0cwksb52SWZJ70S0BmfmLkmXexmqLriS75qb9/85s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732608513; c=relaxed/simple;
	bh=jkeljPLfrEpojU1eb20valfuJzKAWnOgVQg12Lj7VQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tgRuwIP/AJiF+w62KzbuhR7gRDTkqKbFiCSlZ+iCroSb6XtQfRVzBUWKntP2JxfhzNovUbqSlwXvUkTcTJPFzEuvbl+KBz5tDr0cwGCqGzTtCSXx/5qh6dtWbEOHdb6uQ/kz6/3G5wYzOE4gFDol3ip3CJiAuk9RTM37RXByb4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QJiaRvGr; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5cf9ef18ae9so11813471a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 00:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732608510; x=1733213310; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gmcqT3bZQMcjsucg2dQtWpXidNuyx+XXM3544HAZF0U=;
        b=QJiaRvGrqDfEdJRnp9XDrhyQJVu+qINFn2Gq75nljpMdh7d9h04Bz503UtyHUKOZqz
         3exdPegcKpb5OesyCk63CHLhwGPdrNaTdhuCwB1Sjmh3f1atusuI8Aq2FEGlO8BnZJhn
         mtINLhi+xWKyhGOGRB1CiowAfdTN7ufifsKYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732608510; x=1733213310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gmcqT3bZQMcjsucg2dQtWpXidNuyx+XXM3544HAZF0U=;
        b=mfebnFeGYf8Tds2dtKhLQy1bxBiATqT6Uchc5CiI3n+zteJTdAq0Iv4HHHk6Tu1F8t
         wUMGkPxXFapFMhCaRl3cng8cQGWGcn0nOXFX8/oG9hMy+tx1zbxKBDQ02LdtcIP2mO11
         I0xVOErJE3XszUW6qwg3Hoz8MSSI2yLdhFGpOwKBPyArm5zlnFZ32YCyln026hnxBrsj
         VlWVQjxSbftDgDFVUFWd3+drZCBdN4wamzPYQEtT6HDHf8mvBKYG31tVYByJ2XGJvPeD
         ri08u2B+MdMGQmxcVxMi3kmn9/LUSdXqeOiAJ0pTxbknP2iwItm0p94Bo3qOa56B6gMr
         0img==
X-Forwarded-Encrypted: i=1; AJvYcCX8NXlh1U9wGyead2vRlov3nlUg1h25GCyotgQFpHWrP03QdnglboUNsF3sMjV1ajUs3+zvwMixbkbhTQA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK66txrA7767pGEMFrTCHUbugOaQ3N9LMjerChhDvjKSwmxcPU
	AWl8I7vs12JFJxCivycv1Q+r05mwPNARePe4mKTvyh88M9ee3N4c07w7w1Ww9hfxN5KYxSGcvrg
	=
X-Gm-Gg: ASbGnctP4mpku+bqeEU/xAWKSrz8p+AQwIi/OMtx8Hkaiv1gDlfbqst6jpmwsWyIuej
	jYoHr6qX2iCM/FoBiiMfhmBfETqB985ctQd7YkIZddirKO8c+Bxgrwv832OqN26M7dzYKXkQ3hA
	jQWwQu/8F0Q11zCN6fslbAXQp6qENYyswhfkySTydz48/8zmwg9LPBCiD7RLhVmWB7UwIqeCTBO
	VD7YFDwOx7gwPyVRNyt1khm/9DN3VPtt0Srge64cXd/9vXs7fsjx8GMJ8eDBaPW0emshuUv/qEX
	3Wx0ayg2+EnPY2eK
X-Google-Smtp-Source: AGHT+IFNY/gp1qd57hEY8ib0VodU4fzc6Gr+ALAOcoL/qEdo/lQDkTAsnWSd/h14bhr8n7aQb+s6Aw==
X-Received: by 2002:a17:906:c502:b0:aa5:438b:513e with SMTP id a640c23a62f3a-aa5648ff74bmr219726366b.30.1732608509977;
        Tue, 26 Nov 2024 00:08:29 -0800 (PST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b57d4d5sm565269666b.163.2024.11.26.00.08.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 00:08:29 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5d027dc53ccso4909a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 00:08:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUOBzzljU/cLEmPSALVcFpcTwP++fOyMF9VV7LY6tmG91vH9cyUp3yrvbO3uEdOgazU1a79ABwqQNW/Z6I=@vger.kernel.org
X-Received: by 2002:aa7:c48d:0:b0:5cf:c93f:36f3 with SMTP id
 4fb4d7f45d1cf-5d06f511712mr30786a12.7.1732608078885; Tue, 26 Nov 2024
 00:01:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125-mt8192-lvts-filtered-suspend-fix-v1-0-42e3c0528c6c@collabora.com>
 <20241125-mt8192-lvts-filtered-suspend-fix-v1-1-42e3c0528c6c@collabora.com>
In-Reply-To: <20241125-mt8192-lvts-filtered-suspend-fix-v1-1-42e3c0528c6c@collabora.com>
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Date: Tue, 26 Nov 2024 16:00:42 +0800
X-Gmail-Original-Message-ID: <CAHc4DNKmGA-MjTWdZhKygiaRwN7mHnMCf8UPUxH_V16uZifzFg@mail.gmail.com>
Message-ID: <CAHc4DNKmGA-MjTWdZhKygiaRwN7mHnMCf8UPUxH_V16uZifzFg@mail.gmail.com>
Subject: Re: [PATCH 1/5] thermal/drivers/mediatek/lvts: Disable monitor mode
 during suspend
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Alexandre Mergnat <amergnat@baylibre.com>, Balsam CHIHI <bchihi@baylibre.com>, kernel@collabora.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	Hsin-Te Yuan <yuanhsinte@chromium.org>, Chen-Yu Tsai <wenst@chromium.org>, 
	=?UTF-8?Q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 5:21=E2=80=AFAM N=C3=ADcolas F. R. A. Prado
<nfraprado@collabora.com> wrote:
>
> When configured in filtered mode, the LVTS thermal controller will
> monitor the temperature from the sensors and trigger an interrupt once a
> thermal threshold is crossed.
>
> Currently this is true even during suspend and resume. The problem with
> that is that when enabling the internal clock of the LVTS controller in
> lvts_ctrl_set_enable() during resume, the temperature reading can glitch
> and appear much higher than the real one, resulting in a spurious
> interrupt getting generated.
>
This sounds weird to me. On my end, the symptom is that the device
sometimes cannot suspend.
To be more precise, `echo mem > /sys/power/state` returns almost
immediately. I think the irq is more
likely to be triggered during suspension.


> Disable the temperature monitoring and give some time for the signals to
> stabilize during suspend in order to prevent such spurious interrupts.
>
> Cc: stable@vger.kernel.org
> Reported-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
> Closes: https://lore.kernel.org/all/20241108-lvts-v1-1-eee339c6ca20@chrom=
ium.org/
> Fixes: 8137bb90600d ("thermal/drivers/mediatek/lvts_thermal: Add suspend =
and resume")
> Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> ---
>  drivers/thermal/mediatek/lvts_thermal.c | 36 +++++++++++++++++++++++++++=
++++--
>  1 file changed, 34 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/me=
diatek/lvts_thermal.c
> index 1997e91bb3be94a3059db619238aa5787edc7675..a92ff2325c40704adc537af69=
95b34f93c3b0650 100644
> --- a/drivers/thermal/mediatek/lvts_thermal.c
> +++ b/drivers/thermal/mediatek/lvts_thermal.c
> @@ -860,6 +860,32 @@ static int lvts_ctrl_init(struct device *dev, struct=
 lvts_domain *lvts_td,
>         return 0;
>  }
>
> +static void lvts_ctrl_monitor_enable(struct device *dev, struct lvts_ctr=
l *lvts_ctrl, bool enable)
> +{
> +       /*
> +        * Bitmaps to enable each sensor on filtered mode in the MONCTL0
> +        * register.
> +        */
> +       u32 sensor_filt_bitmap[] =3D { BIT(0), BIT(1), BIT(2), BIT(3) };
> +       u32 sensor_map =3D 0;
> +       int i;
> +
> +       if (lvts_ctrl->mode !=3D LVTS_MSR_FILTERED_MODE)
> +               return;
> +
> +       if (enable) {
> +               lvts_for_each_valid_sensor(i, lvts_ctrl)
> +                       sensor_map |=3D sensor_filt_bitmap[i];
> +       }
> +
> +       /*
> +        * Bits:
> +        *      9: Single point access flow
> +        *    0-3: Enable sensing point 0-3
> +        */
> +       writel(sensor_map | BIT(9), LVTS_MONCTL0(lvts_ctrl->base));
> +}
> +
>  /*
>   * At this point the configuration register is the only place in the
>   * driver where we write multiple values. Per hardware constraint,
> @@ -1381,8 +1407,11 @@ static int lvts_suspend(struct device *dev)
>
>         lvts_td =3D dev_get_drvdata(dev);
>
> -       for (i =3D 0; i < lvts_td->num_lvts_ctrl; i++)
> +       for (i =3D 0; i < lvts_td->num_lvts_ctrl; i++) {
> +               lvts_ctrl_monitor_enable(dev, &lvts_td->lvts_ctrl[i], fal=
se);
> +               usleep_range(100, 200);
>                 lvts_ctrl_set_enable(&lvts_td->lvts_ctrl[i], false);
> +       }
>
>         clk_disable_unprepare(lvts_td->clk);
>
> @@ -1400,8 +1429,11 @@ static int lvts_resume(struct device *dev)
>         if (ret)
>                 return ret;
>
> -       for (i =3D 0; i < lvts_td->num_lvts_ctrl; i++)
> +       for (i =3D 0; i < lvts_td->num_lvts_ctrl; i++) {
>                 lvts_ctrl_set_enable(&lvts_td->lvts_ctrl[i], true);
> +               usleep_range(100, 200);
> +               lvts_ctrl_monitor_enable(dev, &lvts_td->lvts_ctrl[i], tru=
e);
> +       }
>
>         return 0;
>  }
>
> --
> 2.47.0
>

