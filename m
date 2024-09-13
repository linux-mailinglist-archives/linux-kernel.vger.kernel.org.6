Return-Path: <linux-kernel+bounces-328121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56EF9977F24
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 14:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9031F1C21E44
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 12:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B360C1D88D4;
	Fri, 13 Sep 2024 12:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TTl4UVu1"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AA01DA0E0
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 12:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726228945; cv=none; b=anrLTadX3fm4QtX6QXKwR4meR6sHqh6bcNZ2lBvvrRrwUIMQZIOTrKkrcCSUfujhJ3tWxXhcKjPHpg99uZOT0MQ764c7jWLnlWo5PBTv1hb6NrDNAVZefRjaQ4kijnGRKhgiO6DMeFy15hMwkc4nbbcSP1+qegJCzeMolT009Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726228945; c=relaxed/simple;
	bh=xq52X4izzTGGeGD0h4REXhT37n5h+HRXNX1b1mCLlps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AApwoviNY4MqbVdYkSgc+D+bR7PcesmpqJwWaWixh2oMHitqITiAplrPOS8hr/5ycyAp/cQKtU+lg6sEvYNy2LOWaY8zNXQz/XxEGxePy88V/Qw8AZaLo3So/lMTXR2JI98ak8f0WuvB5yaxXmGsRjuCqIVeD9srAPSbHaTw8NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TTl4UVu1; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e1a7e54b898so1821482276.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 05:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726228943; x=1726833743; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b5vJYLAw6LfW5JlVpNstXeXKwlbfZrfsNunfO3F9ncY=;
        b=TTl4UVu1IF7qcqnFySe/9jtRoYKQuPLRYpKIXzIuNvplB8YgNLVKY6GjJ4Ly8MXKHE
         JUQPCMye0+yJVWPXwN+32lW5EQBLTgpSK/T/58IWgb7g/5wf7r30Ss4OXqGvekoEV13a
         PeANltxPkczo/CggPSIix1Qs1XV2t3l65hsJEVy5AnPdEaCx4crWkFocZcBEp3CMQut7
         ReVd9OW9B3VrX8P4wHZEZBJzmiIgGr45+JdGLJHqHvcm5i40jTF9iUgSJugUhQNdHX8x
         BWGFR7cl+EVoxFgruaZvBCTAAmJoWC90xprDMeJkD/NDhpxp11HcrxyMNpxJaE9y3dTA
         wVXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726228943; x=1726833743;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b5vJYLAw6LfW5JlVpNstXeXKwlbfZrfsNunfO3F9ncY=;
        b=SHha0h9JYMKzVJJkF/dfKRKzs7Ps8zm28A1ACPs0S+SjheX0p0UqiEnNhL2f3waGIb
         D5R8qZNAVlYRDu9R9uq6OwG7ez2ISM18ki2yFWYZWXADNtM2994zoSE5qV5V4uVe56qY
         qq2i/AD8bduML8JeTIAlwKeH4zsv1qtaFYbCyQQJhwQvL428DBCxA4O4sj4dUL0upo3I
         eXNESLuhQaj/JgnZgoWJLybBbtVOtmFI+xJ5QFYQuUK3siviDezQQ4gkSwd9V2aa4vwl
         gpEjCzOt66WpdmI7tlCRpANnnRoPpSuQg9mVMtw51g6IAjUitE/spCERtH3J17pDWg8S
         ZpTA==
X-Gm-Message-State: AOJu0YxByhE96eGH4gpkCFVA+Qo5c3OMOfcuwCMeAsyZeaFJ21F4menA
	aoPuYhl+HGQUSpMMbU+50cWpdydEwuFGhYTTgxtnM9va0wb+O7kIlxWcec4gw8Il+kH6AkO5god
	koz9HOUwGVQRyVlTaZx3SCjauRgDbUmNf8f/yWg==
X-Google-Smtp-Source: AGHT+IFQpLMOb2ArVCK3W98VSnKdRZbVOJ4EKZFMdKxG+HpYDqytbv3LW6pkSdrJcbfv2WHNAhhoee60un7J4w7BPdg=
X-Received: by 2002:a05:690c:c9b:b0:6ae:e4b8:6a46 with SMTP id
 00721157ae682-6dbb6ba1112mr60834227b3.44.1726228942612; Fri, 13 Sep 2024
 05:02:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240825143428.556439-1-dario.binacchi@amarulasolutions.com>
In-Reply-To: <20240825143428.556439-1-dario.binacchi@amarulasolutions.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 13 Sep 2024 14:01:46 +0200
Message-ID: <CAPDyKFrY7ohfWw+boNEph9+NfTW7uEYKbuEnbk53Ne5XJPXuiw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] pmdomain: imx93-pd: replace dev_err() with dev_err_probe()
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com, 
	Arnd Bergmann <arnd@arndb.de>, Fabio Estevam <festevam@gmail.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Shawn Guo <shawnguo@kernel.org>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 25 Aug 2024 at 16:34, Dario Binacchi
<dario.binacchi@amarulasolutions.com> wrote:
>
> This way, the code becomes more compact, and dev_err_probe() is used in
> every error path of the probe() function.
>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

Applied for next, thanks!

Kind regards
Uffe


>
> ---
>
> Changes in v2:
> - Drop the extra { } to be even more compact.
>
>  drivers/pmdomain/imx/imx93-pd.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/pmdomain/imx/imx93-pd.c b/drivers/pmdomain/imx/imx93-pd.c
> index d750a7dc58d2..44daecbe5cc3 100644
> --- a/drivers/pmdomain/imx/imx93-pd.c
> +++ b/drivers/pmdomain/imx/imx93-pd.c
> @@ -125,11 +125,10 @@ static int imx93_pd_probe(struct platform_device *pdev)
>         /* Just to sync the status of hardware */
>         if (!domain->init_off) {
>                 ret = clk_bulk_prepare_enable(domain->num_clks, domain->clks);
> -               if (ret) {
> -                       dev_err(domain->dev, "failed to enable clocks for domain: %s\n",
> -                               domain->genpd.name);
> -                       return ret;
> -               }
> +               if (ret)
> +                       return dev_err_probe(domain->dev, ret,
> +                                            "failed to enable clocks for domain: %s\n",
> +                                            domain->genpd.name);
>         }
>
>         ret = pm_genpd_init(&domain->genpd, NULL, domain->init_off);
> --
> 2.43.0
>

