Return-Path: <linux-kernel+bounces-411754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 420139CFF35
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 15:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 390CAB2532C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 14:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667A6101E6;
	Sat, 16 Nov 2024 14:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="bvbxlky3"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86F96AA7
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 14:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731766343; cv=none; b=WcAmmZEHR6RChffE7Kb/tYf2zM5MxjcpYNT6xJFKwiaB+qT3/5dTQo1Hkyu+rLPhcSb1oCKcHATR63Ah9SOgP2t8HGMoEAMi1PPeVeh0VRoDqhQT+RNj0K0Gl341rNuFBBLEw+0QHtJXuG87ZS4l6kgwE7EOkT9ICmB20q5XWMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731766343; c=relaxed/simple;
	bh=Ei4hNc2W7w0BschPL49y66f/AldtB3jsM3bkhJI4ohU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NzYLtmfWc658NgQCQHfi4zylulGu6g6QRrXPQJnKKR8Vaqmmd/GwwPw5NBGMVciETivkkMf5CG2AI9IyFNcYdzAWhhMr2IHOaY9nbPivQ+5MdvC0mIezU338aRdCtfZBr2wbbK6LytPyv3puizxC3JrwSv7HRPsmR4vboaPW2jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=bvbxlky3; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-53da24e9673so3089185e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 06:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1731766340; x=1732371140; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nSOMDGJBHqykq0W0MO0tKTZ9jaOMkcUQd2K0fa+ZeiM=;
        b=bvbxlky3FgM5Zl1rvLy6f/WYblZis2xzURkgAVXYUseecVwWztO+vzpIBlRoRPOQ2x
         qkx5NO640wRfUmnuHKAKtkASdmIdYxrpidGhT63jP+zT/YUdYNNkNYv/XOx6KOuL04yN
         6gGM2Ka0Ile89EAlBkNXf0w5cnyK64FYr3IKPoptPcz819HUPoIHl///lsWVASr5hBA8
         gG2nOzYuM8WqdTuv8sf5K0q/9dBXpTd5cczObPnkWlRBvdeMHM+xECBndY9JUWURQASr
         qehCV9MHpiOXgn5XniK/YacNCiiopvlOveqvb2LI2yvno7F23XYhmH9uzMHVVtivDxpn
         Dvkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731766340; x=1732371140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nSOMDGJBHqykq0W0MO0tKTZ9jaOMkcUQd2K0fa+ZeiM=;
        b=cfQf6xra8u7l5NZ7ZYZy4+GUPx949dLndO1PGO561GpZzc+zw4bp2HHrbM6OOQMEFY
         ieF9Qe2UD/9ecmUxoLpnbd431VnFjj27yxVko54DlKUgb3LmMP4AryyV4V+otwNBB8gh
         8uvrUgcN2ubMIw/FierNASx994Jdwkhu1ljK5KOvwvNWIjOKLAm5lbZSBBAwPlBLHT/8
         gOJCTagCxPonL7bbWDa+EjmDqL9ElBnMNXap5IprDGdTOEXUEtemtBir6KaapOcb3KIC
         un/K+CscD8T2O1a7fgbJAj0l9+RkfksNKJwP74c3LLmUj/pXE8/6+a1BNnVC0h7Rt66u
         mcWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxJTEMBrDZKteGVAP/N9Ej5yYUj3LzQ8HX6S4DjUfzR+AYQVw5pQjZ9scqM7/tw3rYFooAQ8zGzY4tIZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG6lvLsTDpaOFkDpSyztL38Sy4+O50Q1AOcKa8cIMGjgguj5IV
	hsz5LepeLuJB1+brZuNLMwykwn0+UXhIFpHQwCwRbcADX+1vkdgfO5zQL0GJGa33882eSLpny4y
	RXGnAYQFSYiPosJayA3M9bUKCQS62uukQu83xMg==
X-Google-Smtp-Source: AGHT+IEq16DP00C8W20dPuD2ZQPQr24sgXffkVKh2QM8Z8F5nnmTdl7N8bDwpNO/QbjBz4VCkdBEUw7imEt3gY6tYo8=
X-Received: by 2002:ac2:4bc1:0:b0:539:efdb:4324 with SMTP id
 2adb3069b0e04-53dab29dc16mr2803482e87.21.1731766339676; Sat, 16 Nov 2024
 06:12:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241115123028.3904126-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20241115123028.3904126-1-andriy.shevchenko@linux.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Sat, 16 Nov 2024 15:12:08 +0100
Message-ID: <CAMRc=MfF=jrJNMcJ=yBPp_=atEt+isrJEDUwgx6gaBeQP+H=hQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpio: altera: Add missed base and label initialisations
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mun Yew Tham <mun.yew.tham@intel.com>, Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2024 at 1:30=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> During conversion driver to modern APIs the base field initial value
> of the GPIO chip was moved from -1 to 0, which triggers a warning.
> Add missed base initialisation as it was in the original code.
>
> Also initialise the GPIO chip label correctly.
>
> Fixes: 50dded8d9d62 ("gpio: altera: Drop legacy-of-mm-gpiochip.h header")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>
> Can be folded into the mentioned change, up to you and sorry for missing
> these in the first place.
>
>  drivers/gpio/gpio-altera.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpio/gpio-altera.c b/drivers/gpio/gpio-altera.c
> index 039fef26546e..73e660c5e38a 100644
> --- a/drivers/gpio/gpio-altera.c
> +++ b/drivers/gpio/gpio-altera.c
> @@ -261,6 +261,11 @@ static int altera_gpio_probe(struct platform_device =
*pdev)
>         altera_gc->gc.set               =3D altera_gpio_set;
>         altera_gc->gc.owner             =3D THIS_MODULE;
>         altera_gc->gc.parent            =3D &pdev->dev;
> +       altera_gc->gc.base              =3D -1;

This does in fact fix commit 50dded8d9d62 ("gpio: altera: Drop
legacy-of-mm-gpiochip.h header") and should go together with it
upstream.

> +
> +       altera_gc->gc.label =3D devm_kasprintf(dev, GFP_KERNEL, "%pfw", d=
ev_fwnode(dev));
> +       if (!altera_gc->gc.label)
> +               return -ENOMEM;

This is a separate thing and I would argue it's not even a fix per se.
Lack of label doesn't make it entirely impossible to use the chip. I'm
willing to send it as a fix but please make it a separate commit as it
doesn't fix anything from 50dded8d9d62.

The commit message for it could also use some explanation why it's
better to set label (so that the chip will not figure as "unknown" in
the kernel).

Bart

>
>         altera_gc->regs =3D devm_platform_ioremap_resource(pdev, 0);
>         if (IS_ERR(altera_gc->regs))
> --
> 2.43.0.rc1.1336.g36b5255a03ac
>

