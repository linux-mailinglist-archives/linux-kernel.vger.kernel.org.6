Return-Path: <linux-kernel+bounces-406552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 670829C60F5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 20:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 380C8BA2ED9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 18:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7DA219CAC;
	Tue, 12 Nov 2024 18:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h39XCgrR"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA99219C95
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 18:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731437073; cv=none; b=fePrPKf1WTPubobbXpqGXrkSv3dYJOIG/ecLH9ssozRgomPhutKFX8qpJymwMYvLT7unXO4kfmsqGtjgKIjIWu1r9XgSzvj6jmY3ji8JI6MZ3q6/ZL0yGIflMMV9QvtLViQ6m7AWs8nin2aG2k7jXK6CSVTKRQxNkYZLlDgrFE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731437073; c=relaxed/simple;
	bh=jnzdl+fbVVcTTbZj2P9A5xsyzaZA7Tie8/2XgiKueJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j+jPGpvulqJZYxuI9IPRNoTpuKpZOM967QovYISuU9muuBq7IdYzlI3QFR2E2EnWdVEdbhfjL/TUYDznB+6ofvKwVKPXPjCHlGXyAjfNNb6MyV3U3lEjhBVIxbP3hEedWOj7XRvl6c7ICebPWDqNUfHB80FZNkKbGGmuO6/S28E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h39XCgrR; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6e5e5c43497so47084227b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 10:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731437071; x=1732041871; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tr6REDhXVt1opvineUair86Kv+hNXCwWuTG4wc24Uvg=;
        b=h39XCgrRThI+G2VlCLMORW6c/AndWOX6SR5PdJ690jPeJ+kumPHQSA76Ev4Zigl8Dl
         WrnMjfQtZlVMd7SiThDO+MZo7ZbOVrMMgTrRLU33b299A5y0+sD5ksWVf3xFHJxwziBi
         j5OYBfsjqxPcbRw25zy6zLvdu7Qhak60dUKSF/RBALu7msPUGNqlWo3dDWrS4KgSkbE2
         MKPMzWaHwPY++dZi8N/eEz2tBZPgeURXlgt55HiA80MZFKXTZJE4SCBhSeuVADZ0t8uv
         9CPVSZodA+TO9GvXfO0DRVe1N5SmUXkhbBkQR9Qa79zVO6uKxQSH65kbbJvmRa1jtZ2e
         192g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731437071; x=1732041871;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tr6REDhXVt1opvineUair86Kv+hNXCwWuTG4wc24Uvg=;
        b=UC11sHlC1Vbe3O+RAhmRnJ8bsCjNhJEBp1bfr87vMcTsCvhF3BDfv953vyrmJKdiHJ
         +pvfCfT7nw/ekFuaRwJDvyQtNdNyTXxV1YY7meLlPSxnQbY2T3NeokHsQgk9nIE52oOC
         CMk9gNfYba3pWgERa1RaXmmMPljSkRhONQXiYx+80WAydOO7mgK8eGCRaHYRiXjdEBUo
         Q26pgMMrBRb5erIGAeKEzxiE0N9/LagT0cvwMV+f7dX0tFGHr/1RU4ptD1IThcfg9seD
         UijjS76a9uOLFZTsf5EGUbq4wpF03ubuZK+o4/iKvj+za/aC5XlaLbxlstFEAt28RySF
         j00g==
X-Forwarded-Encrypted: i=1; AJvYcCWA2CeLXJb9GuaMquQfuO9W9NnDUP3twKqRqqieokgFORaEROUcdDkffn+84xzpDDry33rKKZ84OT9FPeY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBegHDpe0J6GiCae8gMuj1YNizxmf7aJj+77uVp3pj3xwzYeW6
	SFlRmeVtx4qzsNSkzuMuiXCbsSetnlll9PNUXlwlbuMFIQ3aDspp5bDrGWAKs7X/Ht2+oTWFBs6
	egRxW//KWhbRcY7eAkdEEAc/Pi93XWzddeVQUZA==
X-Google-Smtp-Source: AGHT+IH44Q8MD0K4pqUKXUCjf2JqplnFw2dHro4nArL34sMNY7ms7UeoYKZIVy0yhJb2ir9HCSb3HgO2REJ9e9FblRM=
X-Received: by 2002:a05:690c:7090:b0:6ea:5da9:2f7c with SMTP id
 00721157ae682-6ecb32cb110mr719877b3.12.1731437071000; Tue, 12 Nov 2024
 10:44:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108130647.8281-1-wahrenst@gmx.net>
In-Reply-To: <20241108130647.8281-1-wahrenst@gmx.net>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 12 Nov 2024 19:43:54 +0100
Message-ID: <CAPDyKFrKTw16mfmMcnaz08vPJsAsC6KJj_j8j6UcbQif9VK1cA@mail.gmail.com>
Subject: Re: [PATCH V2] mmc: pwrseq_simple: Handle !RESET_CONTROLLER properly
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Marco Felsch <m.felsch@pengutronix.de>, 
	Catalin Popescu <catalin.popescu@leica-geosystems.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, linux-arm-kernel@lists.infradead.org, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 8 Nov 2024 at 14:06, Stefan Wahren <wahrenst@gmx.net> wrote:
>
> The recent introduction of reset control in pwrseq_simple introduced
> a regression for platforms without RESET_CONTROLLER support, because
> devm_reset_control_get_optional_shared() would return NULL and make all
> resets no-ops. Instead of enforcing this dependency, rely on this behavior
> to determine reset support. As a benefit we can get the rid of the
> use_reset flag.
>
> Fixes: 73bf4b7381f7 ("mmc: pwrseq_simple: add support for one reset control")
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/pwrseq_simple.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
>
> Changes in V2:
> - add explaining comment as suggested by Marco Felsch
>
> diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/mmc/core/pwrseq_simple.c
> index 24e4e63a5dc8..37cd858df0f4 100644
> --- a/drivers/mmc/core/pwrseq_simple.c
> +++ b/drivers/mmc/core/pwrseq_simple.c
> @@ -32,7 +32,6 @@ struct mmc_pwrseq_simple {
>         struct clk *ext_clk;
>         struct gpio_descs *reset_gpios;
>         struct reset_control *reset_ctrl;
> -       bool use_reset;
>  };
>
>  #define to_pwrseq_simple(p) container_of(p, struct mmc_pwrseq_simple, pwrseq)
> @@ -71,7 +70,7 @@ static void mmc_pwrseq_simple_pre_power_on(struct mmc_host *host)
>                 pwrseq->clk_enabled = true;
>         }
>
> -       if (pwrseq->use_reset) {
> +       if (pwrseq->reset_ctrl) {
>                 reset_control_deassert(pwrseq->reset_ctrl);
>                 reset_control_assert(pwrseq->reset_ctrl);
>         } else
> @@ -82,7 +81,7 @@ static void mmc_pwrseq_simple_post_power_on(struct mmc_host *host)
>  {
>         struct mmc_pwrseq_simple *pwrseq = to_pwrseq_simple(host->pwrseq);
>
> -       if (pwrseq->use_reset)
> +       if (pwrseq->reset_ctrl)
>                 reset_control_deassert(pwrseq->reset_ctrl);
>         else
>                 mmc_pwrseq_simple_set_gpios_value(pwrseq, 0);
> @@ -95,7 +94,7 @@ static void mmc_pwrseq_simple_power_off(struct mmc_host *host)
>  {
>         struct mmc_pwrseq_simple *pwrseq = to_pwrseq_simple(host->pwrseq);
>
> -       if (pwrseq->use_reset)
> +       if (pwrseq->reset_ctrl)
>                 reset_control_assert(pwrseq->reset_ctrl);
>         else
>                 mmc_pwrseq_simple_set_gpios_value(pwrseq, 1);
> @@ -137,15 +136,18 @@ static int mmc_pwrseq_simple_probe(struct platform_device *pdev)
>                 return dev_err_probe(dev, PTR_ERR(pwrseq->ext_clk), "external clock not ready\n");
>
>         ngpio = of_count_phandle_with_args(dev->of_node, "reset-gpios", "#gpio-cells");
> -       if (ngpio == 1)
> -               pwrseq->use_reset = true;
> -
> -       if (pwrseq->use_reset) {
> +       if (ngpio == 1) {
>                 pwrseq->reset_ctrl = devm_reset_control_get_optional_shared(dev, NULL);
>                 if (IS_ERR(pwrseq->reset_ctrl))
>                         return dev_err_probe(dev, PTR_ERR(pwrseq->reset_ctrl),
>                                              "reset control not ready\n");
> -       } else {
> +       }
> +
> +       /*
> +        * Fallback to GPIO based reset control in case of multiple reset lines
> +        * are specified or the platform doesn't have support for RESET at all.
> +        */
> +       if (!pwrseq->reset_ctrl) {
>                 pwrseq->reset_gpios = devm_gpiod_get_array(dev, "reset", GPIOD_OUT_HIGH);
>                 if (IS_ERR(pwrseq->reset_gpios) &&
>                     PTR_ERR(pwrseq->reset_gpios) != -ENOENT &&
> --
> 2.34.1
>

