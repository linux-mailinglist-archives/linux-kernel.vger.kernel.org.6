Return-Path: <linux-kernel+bounces-417182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 200139D5012
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 16:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E5CCB25569
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 15:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC15814387B;
	Thu, 21 Nov 2024 15:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Q7p0WCZH"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA84817BD3
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 15:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732204115; cv=none; b=ag4uEoO8iLRmfoGqsUDqg286obYf9zqkUf3AiM5J0lllmP4YzDFhpMKUbwEGTs4ygqlb+3OyEhtHwoVoXefmU6dQI7Nx6se0FHGT3DysZNnz1OvKKEairiKRz+a2Zxqhp3OoTBCkTdA2BLTjBJrjo2so7Br20MuG5dg43lz5mdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732204115; c=relaxed/simple;
	bh=8NFwVbeSbIu4xuIL/+vn6mzdssua9mKA0pw8CxsYgrE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H1q4ms4fxMKrMAOV15aNvCMq5kT9B6k+XX2shnvpUzG/PDaoeFt/UNBTp5zGkWLVdKhM0sBu9fhUsaFmyDRh9t8YoAyp1fkeQG+k+rNmzlxOG3mRhDAcYmQ6TjbSvNjYfZBJGu+ngaz/SJV8x/6f119+/vQUKfPoLMZXfif2dZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Q7p0WCZH; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2fb599aac99so12471171fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 07:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1732204111; x=1732808911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H/fhuOHTRRX8STr/F3eYtDuHLZMSXIOyEsTCLQHBch0=;
        b=Q7p0WCZHQdZU6/KsbJuhLtUGHYs9W+eIOB18SxBRjyDccK+bNugbcQtfbDbomKPwfT
         bojNLzTdvSaW++yKwlzW21j81gqK5YjEVNFLjpRheNKnrOqy8oodLn7j/CTAS6LZpggW
         EahY8ad4Xn27h3YGp8j/+qrvRGYLrNttk2KWawbKOcRgZtINqDxIe6ZStu5WjFRER98+
         7XzJplFFyhlUHLGDo9J0UZNRlGH9SqadlljFXTXglO/lNKcd/FllKLnZgF59CFdLMz5h
         UlwMK0weVK7Ye0TmnKgcaRBr+10cwPIxJTEzy+xvnxFmm3GzLMejveQl1o2OJ/+6tVyq
         uZew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732204111; x=1732808911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H/fhuOHTRRX8STr/F3eYtDuHLZMSXIOyEsTCLQHBch0=;
        b=rWtU3dCrnqlChoJE7Z2CEE1odm71OM13z5aA4bN1cjdUEt4f8znUDRfi7HFDUxceRN
         9mTao94Za4cTjLt1SB7BJ32H4qDZMpPxda8NOwo/qj1lhUbsNQ1xT90bXq6bVU7M2weH
         wvZEJ7KCbIgPEpsGMTHyjvTbPOCCfSbio2V8xc8qG8DiJZGJ1uJzhvgrSQMPtLid3R0W
         Z0PwbiE4AS+5E/EIsUKofSKIKHZkQUbctuaPIJYwnN7Kttlj5SWPAU24adh/pDhaUhdv
         VbxSErnCFtGX+qTeRzXvtdEItsxJ8w+HDheYcogIHaZZ27VcaaibXC5geyYDYZmoWiPF
         TStQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWya+DhqCUrxP6j1MBUhNeN1ze+2QP0clU5Zs7qErCmjiTgj47Zw9xkogKvsh72ZMufCPwam89nghUinU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnWaXtXfd/lKVXzxIkYMwC2c1pF1OrvAD19Rw68NWePaHQy0Tf
	4mjJDxcblGlqVAInrIcfCrkOqSPLpjHUFFhaq8pS1c2DpOOPEqyhrBGfYJb0XG/sCGLondqMSGc
	ZDazktBpgvQUiBWxe+AIDihspKa01aW5wfxddLs2JEPXqsJfpNDc=
X-Gm-Gg: ASbGncvh9FBZ4lKFYeSeYfFrjhsQ1K1fPS2yP0q77xz9UaEsG4Y+3xbXS35Wz9KVXDv
	cT0tS0AfhyYtRWPghPXcOrJ2mh5Sucut+hSodOcbhjz7nh4rIP87sDhaPXbI1jA==
X-Google-Smtp-Source: AGHT+IF75pNvGuAMuobLXcs8bP8ekOwdEpxBPncCEjd34YEVOCl2sVnSjJwi89Y6maf0VEbLr9RMuf/EN/VgtXWldTA=
X-Received: by 2002:a2e:a9a4:0:b0:2ff:59e6:b9af with SMTP id
 38308e7fff4ca-2ff8dd08555mr47569501fa.33.1732204110665; Thu, 21 Nov 2024
 07:48:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241121145515.3087855-1-catalin.popescu@leica-geosystems.com>
In-Reply-To: <20241121145515.3087855-1-catalin.popescu@leica-geosystems.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 21 Nov 2024 16:48:19 +0100
Message-ID: <CAMRc=MdRPe1PRAQ1vwsMXynR02PRDqbxNeQHg1fXBiBxe-s8vw@mail.gmail.com>
Subject: Re: [PATCH] gpio: mxc: fix warning about static allocation of GPIO base
To: Catalin Popescu <catalin.popescu@leica-geosystems.com>
Cc: linus.walleij@linaro.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bsp-development.geo@leica-geosystems.com, 
	m.felsch@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 3:55=E2=80=AFPM Catalin Popescu
<catalin.popescu@leica-geosystems.com> wrote:
>
> Static allocation of GPIO base is deprecated, let gpiolib perform the
> dynamic allocation. This is done by initializing base to a negative
> value before the registration of the gpio controller.
>
> Signed-off-by: Catalin Popescu <catalin.popescu@leica-geosystems.com>
> ---
>  drivers/gpio/gpio-mxc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpio/gpio-mxc.c b/drivers/gpio/gpio-mxc.c
> index 4cb455b2bdee..a7418a4814d6 100644
> --- a/drivers/gpio/gpio-mxc.c
> +++ b/drivers/gpio/gpio-mxc.c
> @@ -490,8 +490,7 @@ static int mxc_gpio_probe(struct platform_device *pde=
v)
>         port->gc.request =3D mxc_gpio_request;
>         port->gc.free =3D mxc_gpio_free;
>         port->gc.to_irq =3D mxc_gpio_to_irq;
> -       port->gc.base =3D (pdev->id < 0) ? of_alias_get_id(np, "gpio") * =
32 :
> -                                            pdev->id * 32;
> +       port->gc.base =3D -1;
>
>         err =3D devm_gpiochip_add_data(&pdev->dev, &port->gc, port);
>         if (err)
>
> base-commit: decc701f41d07481893fdea942c0ac6b226e84cd
> prerequisite-patch-id: 0000000000000000000000000000000000000000
> --
> 2.34.1
>

Sorry, no can do[1]. :(

Bart

https://lore.kernel.org/all/f891bb06-4fc6-7b4b-464d-50235c1cff48@pengutroni=
x.de/

