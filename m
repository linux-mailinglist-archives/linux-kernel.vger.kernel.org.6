Return-Path: <linux-kernel+bounces-230686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF0D91808A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 14:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DED31F24C01
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 12:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD48180A9E;
	Wed, 26 Jun 2024 12:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AF/doiyb"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61907180A7C
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 12:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719403602; cv=none; b=BIdsx5d+FybWOU0yKVFc1iVwBKU42dBj1qvXxUYbicRgod9+dxb/y08GJ8WE5bvJzU4Ibc5ner3aMi3wedgLV4PkLSq/iSc7fB5dBG9HSLknBLjyQ+j3Aq4uRMiP38D9ebO8d9+LeHMnSvvdsqZsZLJW9VUTVepIl77frVH2yQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719403602; c=relaxed/simple;
	bh=OzHbeL5WtJqCPBFNWo2wRad/ZDM5wcfh7viKbjMBt04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tySii4tlxM1TvlRQoK0Nu6Rxvhyzt7uw4mnlTkqiwcsmyjKdeFjEsza4JKDNEmfUawjv7FdlQDkGZ+7rVW2R6524QzHgQk1qlttEgpOh9EuMKlvsMHVCWv3NME+39g2U/hF0ky/Zi2LhZ+PMHHn+ZCHnZHo6HjZVQUuuWSLJl84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AF/doiyb; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52cdb0d816bso431395e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 05:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719403598; x=1720008398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u2+2NLpsRBb/A1mZr1EFBFFtwdFUpWW1fRqczPXb5as=;
        b=AF/doiybsyEhy9bOJW3nzxbhIhqRaVGQ4yJ5TsaHEIOEbA2q+PqCXgqrkL/5w67cGq
         UJpQjB06ns+INe+KEq4PJoKaNIauW2pOUyofBRmrUNdkQO9rokbO2Rf8LPsInC8koT4r
         Hj2NZUWfJ6A1z7X7YgJt31kBwIEatI3HWP9AmogKuPp1LdfGmby7Rv1hREz0J5DRMkkr
         x4Eho4fjClZ9YhaalzfPO5V14xocGjalACJvnKDw5HageK23/+UIlrrpvb6UtGb/ZSsg
         DuoctC6jlqU6v6Bq5oMF2l/gJ3yMW840bsPTzxGEtKii87DjS1UaSRdr3tX16flWjMHH
         LX6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719403598; x=1720008398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u2+2NLpsRBb/A1mZr1EFBFFtwdFUpWW1fRqczPXb5as=;
        b=CshKvNU4svFrjZ6w3nnXbmEQLCXXAI70g9SpAo5Ev9rtYuTZPSatfF+/Dk3wpvzWmy
         RhXiK0vP49iVKxJ0uBm6bwGJbhY1IrZ4TQaqeehYxF1Zevv6HW/nNblBVD+YZTAMlNYI
         7Oi065M3ZUnBs7Ank+Z8MnDPsTVXrEQLpOmQPSaBizWFOA6iOxkSzysddkyCVCWzGGPq
         F3oH6gSFbm6/+HYaiaZbx6mZKXH8OpuflfA8vXmGRCi3u9h9dC51MbyKWedidrZQKc5m
         Qiqhl7n+T3DmRU6aYX/1tU+tzvEeugxJLid/ncKH6YyXJyRfRGReaNQRFqWPEGPbMoEP
         Yt6A==
X-Forwarded-Encrypted: i=1; AJvYcCWzzMJDl1MbcOl40j0zfwdHU59Ylp2ojjbFh1uXF6YqqPG81476zT2hAh8QauXN0WqzSwn9UFO3SWk/X4fWWFS1CshlJbu0tmb1Fk+O
X-Gm-Message-State: AOJu0YzI3cZxMbR5QF607DcrJw098CzkV7BpZpnnkScOqZUN5qwcDgh1
	xShHQYAtsvFfQ8i9QMWVJOpzYogzk7iR6XkOpX6U4eOFziL1Me44A+E96HQHOBBGjmnG4RTQOUY
	bJJ1hGP0sHvotHn41x6IES1lCmL25gNnKry5qzA==
X-Google-Smtp-Source: AGHT+IGNXOPWzj1X7QU8se3idG/m9LeRfsovZgHLg/ViLLaROhPSd8hd4XH038GACB9qaHOrbJO17dJiAmpUbT0kK+I=
X-Received: by 2002:a19:9115:0:b0:52b:963d:277c with SMTP id
 2adb3069b0e04-52cdf25da2amr3552489e87.33.1719403598599; Wed, 26 Jun 2024
 05:06:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <TYCP286MB089577B47D70F0AB25ABA6F5BCD52@TYCP286MB0895.JPNP286.PROD.OUTLOOK.COM>
In-Reply-To: <TYCP286MB089577B47D70F0AB25ABA6F5BCD52@TYCP286MB0895.JPNP286.PROD.OUTLOOK.COM>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 26 Jun 2024 14:06:27 +0200
Message-ID: <CACRpkdY=xAKNz5S+sbJXYRs9EoivJS_nZEtYHKc2m4UDkLvscA@mail.gmail.com>
Subject: Re: [PATCH] gpio: mmio: do not calculate bgpio_bits via "ngpios"
To: Shiji Yang <yangshiji66@outlook.com>
Cc: linux-gpio@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Asmaa Mnebhi <asmaa@nvidia.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, 
	linux-kernel@vger.kernel.org, Mark Mentovai <mark@mentovai.com>, 
	Jonas Gorski <jonas.gorski@gmail.com>, =?UTF-8?B?TMOzcsOhbmQgSG9ydsOhdGg=?= <lorand.horvath82@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shiji,

thanks for your patch!

On Tue, Jun 25, 2024 at 3:22=E2=80=AFAM Shiji Yang <yangshiji66@outlook.com=
> wrote:

> bgpio_bits must be aligned with the data bus width. For example, on a
> 32 bit big endian system and we only have 16 GPIOs. If we only assume
> bgpio_bits=3D16 we can never control the GPIO because the base address
> is the lowest address.
>
> low address                          high address
> -------------------------------------------------
> |   byte3   |   byte2   |   byte1   |   byte0   |
> -------------------------------------------------
> |    NaN    |    NaN    |  gpio8-15 |  gpio0-7  |
> -------------------------------------------------
>
> Fixes: 55b2395e4e92 ("gpio: mmio: handle "ngpios" properly in bgpio_init(=
)")
> Fixes: https://github.com/openwrt/openwrt/issues/15739
> Reported-by: Mark Mentovai <mark@mentovai.com>
> Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
> Suggested-By: Mark Mentovai <mark@mentovai.com>
> Reviewed-by: Jonas Gorski <jonas.gorski@gmail.com>
> Tested-by: L=C3=B3r=C3=A1nd Horv=C3=A1th <lorand.horvath82@gmail.com>

Commit  55b2395e4e92 also contains this:

@@ -614,10 +616,15 @@ int bgpio_init(struct gpio_chip *gc, struct device *d=
ev,
        gc->parent =3D dev;
        gc->label =3D dev_name(dev);
        gc->base =3D -1;
-       gc->ngpio =3D gc->bgpio_bits;
        gc->request =3D bgpio_request;

After this patch gc->ngpio will be unset for any GPIO chip that
provides a ngpios property, so restore the above line too.

But maybe a better fix is:

+ #include <linux/types.h>
(...)
+  else
+               gc->bgpio_bits =3D round_up(gc->ngpio, sizeof(phys_addr_t) =
* 8);

?

Yours,
Linus Walleij

