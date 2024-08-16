Return-Path: <linux-kernel+bounces-289433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ECBF954624
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 11:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17645B2451A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 09:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55804171E74;
	Fri, 16 Aug 2024 09:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="OQgKgx1T"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F067116F8EB
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 09:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723801776; cv=none; b=KO7cBoA171zV5tiJE+9aCiSJgmtETb0cQDgulr18DC0JvexZbVsfeoX2EbDjpX/5prz7Rwk4IhK80vw/Po4ye7oG3noZGY+pm1LkBx/InnfhlryUF7B+wnwEWjRRQEOhrNTdZ+oiM0hcFjhyd6DT066iwhQQsatlSdFDw2haKJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723801776; c=relaxed/simple;
	bh=3E06hR/kE/+jOyW51rmSiRalV0WxldTLJOqbtbpW77o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YAqbUCLUOeMRD1kS5iqQOlifJBnHhP5FDip9sdNbrYue1QV+ju07EY+jBa85B6YwhdDNaId8lP+1O83KMoRYVpIdqx6VzPz0QVUsMGdJnMQaxtYT5ECFBqUG5UqNZTHOtckSUfQc52w2jVnmJNBQ/aILpWqCDOyeX+j8QYAxtUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=OQgKgx1T; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53212e0aa92so1990832e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 02:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1723801773; x=1724406573; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rDRicemMaQ9tmYiX6MN/UubXh4KqHsRzOY0h3TLIrbw=;
        b=OQgKgx1TG6sEeKv5p+J8mgGcQqwgWMvlCgpM+rFA4/11dYiqRhsrhFACSYYvApmxir
         XOyb2dcAGBCzlG1IhhmbnSzH4VYOzW8O4hw6YR1uC5geX6fDeZyICNgEEfYG2ARLDOaZ
         QrCqKMBt93mou6sRFGvKlwiqZaVjT6lBJNn5fyCgxwb2Go/BOyoP40IPL9sr93jrfqWS
         SixGeCQmBcgkPehi5H32z7zbQJHtKjqFzwFixdD2EC/C4mNSp6h3YSu8WTQpOc51oos/
         qIorXZCfBCv1QTitI3Ckf1YnHG+DOoAzCmR59MOG67N2dqjazhBDFeNrfdFRCFXswI2v
         YaHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723801773; x=1724406573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rDRicemMaQ9tmYiX6MN/UubXh4KqHsRzOY0h3TLIrbw=;
        b=TFekCJW8IjA++ovkJ5F+mi15ff0FKtDKRXaXC1wtdxPvbx7tyN7MjckPJfmH4fM6db
         F2JxYoJIS7Jd6V9D29FrJG1PInkqZYAfwvFgvXJgsF7qCIE/An2RdafNkMrdptxzzFRm
         5ZmAF/c+xgHUO676WwHMhBymSJBMgFO97Zh5PrUEID4c7uk72/fEreP6kWWeKihPBfYh
         JHA/PdmRq7T3Z8/YVvioVDGpQmXUFHLIzyHU2GujgoT6jEiFTSkBFjk0Trb+YBq4fwTL
         4O9ltMQZgUwI3ThceouFUex0bSwidlr3+3b0FHVlTrxXHVXGjIUNlLPv0C75KhPp9lva
         Tw7w==
X-Forwarded-Encrypted: i=1; AJvYcCXnrMNWo1PlIFiVRkxspllfnP7YTJeKc3b9Zaq2/ZYfG8TrmRpltgEalY1p7TTcFINdJHC17jyE4I+KPbEiNT5+WIN1ui62nlCHwGVy
X-Gm-Message-State: AOJu0YyBN5S+cs/6PvSNjmczaNcHCL/LW62nrWThMZ+JmoetOIQ/vtjb
	pbhn6sffZRdNjndVu/mkxeJ+zLUR/7nZKXe1SgS0p9Oqu9kGG9ygEBSCXZ/qSN8JtYPgQ2PKUh9
	Gw29iWc5VYEJAJnWhsyda45FUPaTTnKXbTjKdNg==
X-Google-Smtp-Source: AGHT+IHmg3osOqkxcBCw6cd7nvM2A++r8/levkFNphPgMqmwsQ1uao1fGoTVrUEpZE7F0Rv9IbVTyfY3p5N41sjhPZo=
X-Received: by 2002:a05:6512:3044:b0:530:ae22:a6f0 with SMTP id
 2adb3069b0e04-5331c6927bemr1824198e87.5.1723801772449; Fri, 16 Aug 2024
 02:49:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815071651.3645949-1-ye.zhang@rock-chips.com> <20240815071651.3645949-4-ye.zhang@rock-chips.com>
In-Reply-To: <20240815071651.3645949-4-ye.zhang@rock-chips.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 16 Aug 2024 11:49:21 +0200
Message-ID: <CAMRc=Me6XHGsmoRLBK3rb90=v7j9ChABMZjkVn4j5WQdzVv96A@mail.gmail.com>
Subject: Re: [PATCH v1 3/5] gpio: rockchip: Set input direction in irq_request_resources
To: Ye Zhang <ye.zhang@rock-chips.com>
Cc: linus.walleij@linaro.org, heiko@sntech.de, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org, tao.huang@rock-chips.com, 
	finley.xiao@rock-chips.com, tim.chen@rock-chips.com, 
	elaine.zhang@rock-chips.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 9:17=E2=80=AFAM Ye Zhang <ye.zhang@rock-chips.com> =
wrote:
>
> Set input direction to avoid FLAG_IS_OUT in gpiochip_lock_as_irq
>

That I can tell from the code. The commit message should say *why*
you're doing something.

Bart

> Signed-off-by: Ye Zhang <ye.zhang@rock-chips.com>
> ---
>  drivers/gpio/gpio-rockchip.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpio/gpio-rockchip.c b/drivers/gpio/gpio-rockchip.c
> index b2f26a16b1f6..8949324ed816 100644
> --- a/drivers/gpio/gpio-rockchip.c
> +++ b/drivers/gpio/gpio-rockchip.c
> @@ -475,6 +475,8 @@ static int rockchip_irq_reqres(struct irq_data *d)
>         struct irq_chip_generic *gc =3D irq_data_get_irq_chip_data(d);
>         struct rockchip_pin_bank *bank =3D gc->private;
>
> +       rockchip_gpio_direction_input(&bank->gpio_chip, d->hwirq);
> +
>         return gpiochip_reqres_irq(&bank->gpio_chip, d->hwirq);
>  }
>
> --
> 2.34.1
>

