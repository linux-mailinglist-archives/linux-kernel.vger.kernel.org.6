Return-Path: <linux-kernel+bounces-328122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9CB977F27
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 14:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9904A1C214BA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 12:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA54D1D9332;
	Fri, 13 Sep 2024 12:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DAsUsGFc"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C931DA100
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 12:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726228950; cv=none; b=roa4eMHoApt5ierLMEkS7VouV+mQ97t+cySjN/rBFsMzn0pKUOy11hM60GAL0F3lgr0z3XfCqqnAv0UFUUO5vaKX9/VNIL+z8KB4t7qKguulNkQ8iP1fxdm5H9U3yC/bCWdItHhz1WHHTYe2TzhV+c+56tM9IkSzV6HInana0T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726228950; c=relaxed/simple;
	bh=5ecyZVpYI8q2kAC7DnbFHrixpgS8zfec8GgteQKL9vs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X0Km9v6gO9//0kwmHwnFdr6AiUbtPC00SDxhW1EbIdJalQWFrOjfm8lyNY0QlFgD+sUHk/jGWf7ni7uhYp60BWTyjErXEdtFQBvF95h1iO7aobfg+ehPYA2Lb1xDqBKqxuVvEzZl6VEGj9r3I6f1b9M440ZfLUy4o7M8TzrrbdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DAsUsGFc; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e1a7c25e350so835405276.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 05:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726228946; x=1726833746; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aUCJeUdbCtTzlTdC7hKAZDf0AYKIsmkYRDth/Vcc+GU=;
        b=DAsUsGFcP1p7seo84Vno61loKj4E953gsV2n2cPVRdfMqc/haFwPynwRc6H1O85qm7
         6oRRjp/UL3pCskdpQ1G6fnMC4WKAVEG5gwqY7KscgxDKArO187F/dAmHwmUDcDBzFIbB
         Ofem0beGLAGc2JYecwaZi04ZRxuSVrNhtCkuImSKZf/ZIl0Gx2S5UA+cv5A11EKRLQhq
         GWwqbyO1n4MHIMd3kuUnbzO48ZxHeFEo7AGsfEo/VGAXPwByWOIi4F61lB7o397GXFlX
         3T3sPNokUzM/DPLwAu6NYSuJDeC0MjvixAZeztGiIS/rCXOy2wqZjE4FG7QoiPzq1ueT
         IlCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726228946; x=1726833746;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aUCJeUdbCtTzlTdC7hKAZDf0AYKIsmkYRDth/Vcc+GU=;
        b=HGyKfRiqTfDINOaGeh/bKYokLzDZ7ogdD4pYqJfgZHPjoozaIEP6gXjWg1tI3Qz+hq
         K6Cb6gLZJ9QULaIF2pHy6w/2vWXTTi1rD+DrpVClg+rwDdj4ED1u61+jrBEtlQp7GBmF
         hm7Ex5RaSHC4+G4c7sknmk9Ub+WJlKu7GYAADIW/OTpewUYZY6AwcrfhYsneOpSEkRNT
         FkEWF2x9/gBgK7k0a8xRn6mHUFOAu8GXxPMEVKs1Y0gOfdXMQlc9OkO8iQwWwP7DgjUw
         wbUM+G3HGIGd/wAH/WFuCugb03y0It69E4TAaly3ebTLwS2hh7kLJ8aG420qtSxdWb+a
         tNgQ==
X-Gm-Message-State: AOJu0Yx2BgDhnsXvOauI+t0Kxa5xfd5+XoyT3t/wVndoa+h8AWL2Ap1E
	r/qugbTVCzjEQUAOQ0bckxTIiHySbbu8PEnbwnX6gAYVX5qfEPZmO+SuGrzd29gv60UwVSFjx5E
	EDAizk/Lt9OsQMHT2lUCFUkhznZoq9mo5CE30/Q==
X-Google-Smtp-Source: AGHT+IECNxvcFi3ScZRYjWcQww81p9XEb9hR+bYUmttrCAW18q0cmnkWFae6PLyr/4yCBmR962PjB7HU9kMt0j8tTw8=
X-Received: by 2002:a05:690c:4989:b0:650:859b:ec8d with SMTP id
 00721157ae682-6dbcc29ef68mr21668657b3.10.1726228946301; Fri, 13 Sep 2024
 05:02:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240825143428.556439-1-dario.binacchi@amarulasolutions.com> <20240825143428.556439-3-dario.binacchi@amarulasolutions.com>
In-Reply-To: <20240825143428.556439-3-dario.binacchi@amarulasolutions.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 13 Sep 2024 14:01:50 +0200
Message-ID: <CAPDyKFoO4UUuJf6G7BTx-4LNpKVY8gJvZ0dj8tWP1E1aJiHYqg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] pmdomain: imx93-pd: drop the context variable "init_off"
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com, 
	Fabio Estevam <festevam@gmail.com>, Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 25 Aug 2024 at 16:34, Dario Binacchi
<dario.binacchi@amarulasolutions.com> wrote:
>
> This variable is only used within the probe() function, so let's remove
> it from the context and define it locally within the same function.
>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

Applied for next, thanks!

Kind regards
Uffe


>
> ---
>
> (no changes since v1)
>
>  drivers/pmdomain/imx/imx93-pd.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/pmdomain/imx/imx93-pd.c b/drivers/pmdomain/imx/imx93-pd.c
> index fb53a8e359bc..25ab592945bd 100644
> --- a/drivers/pmdomain/imx/imx93-pd.c
> +++ b/drivers/pmdomain/imx/imx93-pd.c
> @@ -28,7 +28,6 @@ struct imx93_power_domain {
>         void __iomem *addr;
>         struct clk_bulk_data *clks;
>         int num_clks;
> -       bool init_off;
>  };
>
>  #define to_imx93_pd(_genpd) container_of(_genpd, struct imx93_power_domain, genpd)
> @@ -99,6 +98,7 @@ static int imx93_pd_probe(struct platform_device *pdev)
>         struct device *dev = &pdev->dev;
>         struct device_node *np = dev->of_node;
>         struct imx93_power_domain *domain;
> +       bool init_off;
>         int ret;
>
>         domain = devm_kzalloc(dev, sizeof(*domain), GFP_KERNEL);
> @@ -118,9 +118,9 @@ static int imx93_pd_probe(struct platform_device *pdev)
>         domain->genpd.power_on = imx93_pd_on;
>         domain->dev = dev;
>
> -       domain->init_off = readl(domain->addr + MIX_FUNC_STAT_OFF) & FUNC_STAT_ISO_STAT_MASK;
> +       init_off = readl(domain->addr + MIX_FUNC_STAT_OFF) & FUNC_STAT_ISO_STAT_MASK;
>         /* Just to sync the status of hardware */
> -       if (!domain->init_off) {
> +       if (!init_off) {
>                 ret = clk_bulk_prepare_enable(domain->num_clks, domain->clks);
>                 if (ret)
>                         return dev_err_probe(domain->dev, ret,
> @@ -128,7 +128,7 @@ static int imx93_pd_probe(struct platform_device *pdev)
>                                              domain->genpd.name);
>         }
>
> -       ret = pm_genpd_init(&domain->genpd, NULL, domain->init_off);
> +       ret = pm_genpd_init(&domain->genpd, NULL, init_off);
>         if (ret)
>                 goto err_clk_unprepare;
>
> @@ -144,7 +144,7 @@ static int imx93_pd_probe(struct platform_device *pdev)
>         pm_genpd_remove(&domain->genpd);
>
>  err_clk_unprepare:
> -       if (!domain->init_off)
> +       if (!init_off)
>                 clk_bulk_disable_unprepare(domain->num_clks, domain->clks);
>
>         return ret;
> --
> 2.43.0
>

