Return-Path: <linux-kernel+bounces-390361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2539B78E2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 11:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94DA61F23503
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 10:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C62199EB0;
	Thu, 31 Oct 2024 10:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gCWTZaSm"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C619F199E81
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 10:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730371373; cv=none; b=cRFkvqrIri1BVQeHP718iXTeMoQGrySE2v72qQeg9Pu7jG3DyBW/LGIqhF6hTte6YX3kKeTe4iLBF4LwxBuFgdZBTls25V6bm1dM5BPWIszFEFG3vVucyttdgv5kJH8ER9k8x1E7BS7+BnS/LNMI4+CWIq83LB+Why8QNNPxctY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730371373; c=relaxed/simple;
	bh=h1EbepRwORafz4QvAsQccvMuAxqd52e/hAeVw51HNgs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ewO8cneehHJr0zMxXCttBd5A6uRZoHoK6pS/ZPWEjkQbyCDEQ8L1T2PErIWH1zlzxIbxcVRYKyK2Pxh23BuJdXfZumBsVybG1II99wD/h9diNrrqVlOdVWEc4D5m3Sxxw8YmX0ED1WRP1CUgKAXXm7JmZQfo+UvkqhFKbQS+Ieo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gCWTZaSm; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6ea50585bf2so8525997b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 03:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730371369; x=1730976169; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oMMEeFMPWK3k1Mj3t6erHGHrl705TGgxaOatuH/c4Nw=;
        b=gCWTZaSmCs/c71HaKGqGr3sVpdamuI8o566NBsdpHcJ4O18cUqeWn6f9H3ZBb/29JJ
         OAypna0UjKMznbU4pyWQPP75IfvFmSx8XNepecbNXuTF1a/pTmq+3r6Wo8zK4FbIg5iy
         iUPH8207HrtP8KJezYGygr9Cb50yF738FJxDhKSOiDsK3UNiuwg7AhSCC82gg7Zpv4ad
         JjcMMy3h5Q9tXiofCRNT6PUhM8V8henSji1zjOo40PrM0wopl8zn8zW/IMcSoPY9XoCP
         1KLgZ1ivkEQYXVeUoaGijfHRWb5hKDmckKDoiWSjR0Wm4lsEyB9oGJGj/wkaHU6RPqGz
         QXWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730371369; x=1730976169;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oMMEeFMPWK3k1Mj3t6erHGHrl705TGgxaOatuH/c4Nw=;
        b=If7PNz5TsIjbWcBjpzk6HLydUQeyxXBqfDEXVhIHB7nNhyUoF0WY5LhVH+zK/FqRRV
         1qXpD9EiY1tKkalEwifDypSXjarFjychWw1UuQfaGYXtmACPRQoasXlJdFJgIYH+1LKb
         YnBjvp4tzDg1oW3+HwUYqCvLg82TtahjqK4hnuwvmcuEUiPHPLm09AWI3VCBPwLQpbhg
         82pm2CES/OOIJsPQ3u4d/GTC1oha6LaXqepvscc3G1P985eYF+8uH4uXgSoD2+cfBqq1
         MwIjP22JgsJdNFEIS9++ykobV0PuBjtLaJQW5iakhjJFO/ETmKxanhHSKUFqD2M1iFnu
         MBYA==
X-Gm-Message-State: AOJu0YzuW/kjv2oCdfuF7PNi5A0iE26WsWJm65TZPzqaOWw6FlrU0MzV
	X67wK05j39zqeCcEqkshHq6ENkKTIH7DLVTy7waqo0VK0lra2RequwXgkHaIFDb/6ovlRUtSbYO
	Xuiuuc9S5gkQS+le31pEFtDu6NPkfEZomq7jpgA==
X-Google-Smtp-Source: AGHT+IGyiL6eL7R/DPiVFZpGqii4rrnifN6ppsdutYkmenhnXdSBL9hr48zxfp3pOkfOu5iicApNUvdcgoemDUYz7Tg=
X-Received: by 2002:a05:690c:4989:b0:6db:deb7:d693 with SMTP id
 00721157ae682-6e9d8a6ce53mr203324727b3.22.1730371368586; Thu, 31 Oct 2024
 03:42:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025160430.4113467-1-dario.binacchi@amarulasolutions.com>
In-Reply-To: <20241025160430.4113467-1-dario.binacchi@amarulasolutions.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 31 Oct 2024 11:42:12 +0100
Message-ID: <CAPDyKFqeibF4JAzYZgimUgRN0Lj9K8qSdorxx6DA=j_c5PE9bw@mail.gmail.com>
Subject: Re: [PATCH v2] pmdomain: imx: gpcv2: replace dev_err() with dev_err_probe()
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com, 
	Michael Trimarchi <michael@amarulasolutions.com>, Marco Felsch <m.felsch@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Shawn Guo <shawnguo@kernel.org>, Shengjiu Wang <shengjiu.wang@nxp.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 25 Oct 2024 at 18:04, Dario Binacchi
<dario.binacchi@amarulasolutions.com> wrote:
>
> The patch standardizes the probe() code by replacing the two occurrences
> of dev_err() with dev_err_probe(). Indeed, dev_err_probe() was used in all
> other error paths of the probe() function.
> Note that dev_err_probe() has advantages even if the error code is not
> EPROBE_DEFER, such as the symbolic output of the error code. Therefore,
> it should generally be preferred over dev_err().
>
> Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>

Applied for next, thanks!

Kind regards
Uffe

>
> ---
>
> Changes in v2:
> - Improve the commit message.
> - Add 'Reviewed-by' tag of Marco Felsch.
>
>  drivers/pmdomain/imx/gpcv2.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pmdomain/imx/gpcv2.c b/drivers/pmdomain/imx/gpcv2.c
> index 963d61c5af6d..6e6ecbf2e152 100644
> --- a/drivers/pmdomain/imx/gpcv2.c
> +++ b/drivers/pmdomain/imx/gpcv2.c
> @@ -1356,7 +1356,7 @@ static int imx_pgc_domain_probe(struct platform_device *pdev)
>
>         ret = pm_genpd_init(&domain->genpd, NULL, true);
>         if (ret) {
> -               dev_err(domain->dev, "Failed to init power domain\n");
> +               dev_err_probe(domain->dev, ret, "Failed to init power domain\n");
>                 goto out_domain_unmap;
>         }
>
> @@ -1367,7 +1367,7 @@ static int imx_pgc_domain_probe(struct platform_device *pdev)
>         ret = of_genpd_add_provider_simple(domain->dev->of_node,
>                                            &domain->genpd);
>         if (ret) {
> -               dev_err(domain->dev, "Failed to add genpd provider\n");
> +               dev_err_probe(domain->dev, ret, "Failed to add genpd provider\n");
>                 goto out_genpd_remove;
>         }
>
> --
> 2.43.0
>

