Return-Path: <linux-kernel+bounces-392188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E559B90CF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 12:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E083281BEF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 11:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE3B19E7F3;
	Fri,  1 Nov 2024 11:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W+wvP0iR"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E4619D08F
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 11:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730462236; cv=none; b=TmqSPgZrkqWU7lbGMR6GsoLvW0YIUo771+YunKsqGZTTCNKeRUVTt9pMJjc6K/0TB5NC1RBDxKboAfBMvKHDY01CssJvTykjgHeIxbaaya8kTtRTtdx0/h0u7HOxNuHGGinDUJ6zztt6u3L/qDwW8p+85ByK1vih9QLM1fgLF3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730462236; c=relaxed/simple;
	bh=jcU/orumlgsJbKSrF/Nm/W+DgTU2zdH6jx1nkml6CZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HSsl8K4lOaqejnEDqNxfGoqgxXBm/H4+izHOES68LrNnWB+/z+LYEdicwl+iZfd41U4z6rsJTcJXayOR4c2LqbkPVAVeV7l537gA0mIjgbVJ4/Sz9QoQr7o3Kl1yfYdVzTNxRSI1lKhf5ZsX0RhzKYBrGuxOsUdKkwy1bbo2kMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W+wvP0iR; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6ea5b97e31cso12561567b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 04:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730462232; x=1731067032; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AyPmo8da7gVQeFsoekZ63qpPCKXE92H2RSDUtfff7nM=;
        b=W+wvP0iRisWC95frYnQDDKVpK1IMLAGryk7hBidywJfu6dWqh0qTrBWd/1yDWwbLqk
         FMTluEtPIuhOm/59QHNsaZToDcamu4m26DFzmgbWTer720MD65X5T1zwxtbiP9BqV+9d
         GAEcBXjl30mKOP3rKVyBaKqAqCbx1YDxyRGpB3Ax0pFpHpqVqDKXsDiQ3ZAy7ProAkRP
         hTNML4k1KyrvhmaBOWB6Frp+Jg2PTzmApvRlJlJVIHxJemh0zvtjyWGGR7f5eHzEg3yi
         w7iiJE6JIOLTRKgQvHUbEBlW82eYtoHWD0Hv3Yu2xsmvn3cY1qiwjXo0S+G6Rb+QcSEH
         L3yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730462232; x=1731067032;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AyPmo8da7gVQeFsoekZ63qpPCKXE92H2RSDUtfff7nM=;
        b=VYZ8ev2In3afhivZEXF1UfPpFFWjsetB1UsQNOKB0+u/HB9U7fBdv8vS6QMxtp+vHW
         fInnu01BUJxwVqWipZ5FE2yPTsNiOLU+Sc/doxrIdtRLNn+ooWCyk8dnGrQYNOfQiOfZ
         PeiJ4K+Dy18D2COF0x+7d1A1H8KMPMGCZFxN9ogdkk6f4Z7ZNXXjBGXGp4heLckqxUZl
         wMBgSJA5Pz0vtVHQTi+0cN3GpyOzcgNdR87bzb52OyI4i0pXSt3pyCGaaoI2BxQAktgu
         MnwBL99vLYHzEFniTSvhYetPuIsj66NVjeQpf5n4ZP5mqbBtfMd5ZPcCe+usSTNm6NXj
         aDCA==
X-Forwarded-Encrypted: i=1; AJvYcCWxyQ36KuzQ6Wc+FrHkGcHna5TaiaKm+Pz36lMnhq3loMnVnEzoFYROqSghs3c1b492W2Ny9caXywu0pf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaGMZ/FuzAKXSKcuX5307T8kJ+PsfsLxv/eGkq9Qs+PnpvCMmR
	M4Mpw8kqDzKcBfA+rmGI7YmicG5sEJ7HKBTyFS5H6eCC7dtZ0XSyfRZAOrrwdJ7CEBsPnIxGP/L
	MZhl5fcIVvnKniZvcgz5veatDT50EXHnsSbdnfw==
X-Google-Smtp-Source: AGHT+IGjFViHhhsIEjWSeBRVVF02vu14Au/x1uufAjiQ0eyy+Lk2WKoLfjrFanaJSgIrSL/w8V1/5Fi83AtDrIju8t8=
X-Received: by 2002:a05:690c:d18:b0:6db:d02f:b2c4 with SMTP id
 00721157ae682-6ea64308628mr27197277b3.7.1730462231906; Fri, 01 Nov 2024
 04:57:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101101252.1448466-1-peng.fan@oss.nxp.com>
In-Reply-To: <20241101101252.1448466-1-peng.fan@oss.nxp.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 1 Nov 2024 12:56:36 +0100
Message-ID: <CAPDyKFqmeCCkv5Yr0K9P9eToYTYsQmQUYmbbJvoOJ0O5t5tsjQ@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: imx93-blk-ctrl: correct remove path
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	"open list:GENERIC PM DOMAINS" <linux-pm@vger.kernel.org>, 
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>, 
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 1 Nov 2024 at 11:02, Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> The check condition should be 'i < bc->onecell_data.num_domains', not
> 'bc->onecell_data.num_domains' which will make the look never finish
> and cause kernel panic.
>
> Also disable runtime to address
> "imx93-blk-ctrl 4ac10000.system-controller: Unbalanced pm_runtime_enable!"
>
> Fixes: e9aa77d413c9 ("soc: imx: add i.MX93 media blk ctrl driver")
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/imx/imx93-blk-ctrl.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pmdomain/imx/imx93-blk-ctrl.c b/drivers/pmdomain/imx/imx93-blk-ctrl.c
> index 904ffa55b8f4..b10348ac10f0 100644
> --- a/drivers/pmdomain/imx/imx93-blk-ctrl.c
> +++ b/drivers/pmdomain/imx/imx93-blk-ctrl.c
> @@ -313,7 +313,9 @@ static void imx93_blk_ctrl_remove(struct platform_device *pdev)
>
>         of_genpd_del_provider(pdev->dev.of_node);
>
> -       for (i = 0; bc->onecell_data.num_domains; i++) {
> +       pm_runtime_disable(&pdev->dev);
> +
> +       for (i = 0; i < bc->onecell_data.num_domains; i++) {
>                 struct imx93_blk_ctrl_domain *domain = &bc->domains[i];
>
>                 pm_genpd_remove(&domain->genpd);
> --
> 2.37.1
>

