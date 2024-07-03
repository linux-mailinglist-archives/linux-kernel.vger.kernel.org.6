Return-Path: <linux-kernel+bounces-239474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4332592608B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 14:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A10D287D2C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 12:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E00178360;
	Wed,  3 Jul 2024 12:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RPVe0fdv"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC5A176ADE
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 12:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720010347; cv=none; b=KQVuT52+g5NBjh57YyuNTTYHJAEokpnyVaXcXhYe782r49sGvokaZWwoP6a0W31VxE07XO3SdDG44R0LVVb+yqn6fEHQBCtQ0rC6qbJ4qAF8svvjkdj7CAYMmGkuBznYTjt7XKn9cFD7zQqmCd6F80PrKVxrHKGMqRwsaSVZCts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720010347; c=relaxed/simple;
	bh=KIKwYU58rsJ1T9IBinHX1xe/hBk/3PpX2oCC4eEavbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F2+HYlBmmpXqjhlwDTe6QHzFDuWEKtLry+mG3KSuYB81o7mT/KfG2Ry9FjD6Gyhq5aYNZtitjw4ii2M2oCVVz97YZLoBM9nbLaYPrnPtjnL1Yn491ihOtE4S0zuOKSqaM/IR0nTQ1Xb00fjWm1nK+jWKERBuDzON/MXaIlS6+fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RPVe0fdv; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e0360f890a1so493714276.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 05:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720010345; x=1720615145; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sxc0I0zpiwPou1XOXc6rXOn/i1v3KiOE8O+RryADI0Y=;
        b=RPVe0fdv56UR9MGfbDw+5xeFw9RKWIjW5v0xWdZ+e3Xldkhi28M+eyK+GMTellp2P0
         TLuNz9oKXbgZJvO1TBUwA+jnqxVPO2tMK5p/5Rdps9BdoD9HGVskD2teFP2prHdAjOnE
         qT0nhqHc4lLu81ySDj9DP1Vt8CiK2XTDMTpln1T18cLc8E1/hCHEM4JAoBA40pVspN1m
         Uwev7d7TtRLR+PFDc4YpTT4UjvlbvoLSZOScYzqKdc0O85aECJWbpL/W8ECdBDeYzufz
         0ZGTYDcjJIQHsGj9TZTvUS5vuoYIp7OF8NZievb7IVRQThWg1dG9nKN7dcC8nILVXnuc
         MoEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720010345; x=1720615145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sxc0I0zpiwPou1XOXc6rXOn/i1v3KiOE8O+RryADI0Y=;
        b=ZqsUsmStqeG7MOoppVJBbQ6tR5i3/dbAU8LOU9rkskDh4qRfH2ONpACGyKUsnKrJTT
         7uYcEJPjyRL2VT2ym0YxaD1nJaqWsL378Cb/x+9iTWX/ebjZjKHo+EugnJoG8kPv9rpX
         dtjuVEHD7bqJwRfNdyA4q5jcmdol7AENmUxwJli3/zd1GKi6zpGBj1PqExDzDf8FzKXz
         VpMSDtcqgMFa6t6aAxKBQ6vj0mqfXp48Cocncezn63YUHNKUYIkSdT6abdtqcwVTQmog
         I8A7ScKQ6kTR0Qb9lJ0BU1AZ6YvH3+u3Olyfu7mJSgl1CWOv7AUHK9rpRVP8LWiGXrdd
         7lUA==
X-Forwarded-Encrypted: i=1; AJvYcCXuH3RAlKLQwV0ig7X6M7KvZ/U8TNSnvM5y9+nt5uboL/j3YI1qZaMHKjYadhrKlNov+gogDLXZqcx1xJKM9odVC7ZG+gyI5OHk3cZ5
X-Gm-Message-State: AOJu0YxukA9hNLa8Odz46f6Y/E9M7PyiJuv19zi7FqvDZroiL/c2Q3LC
	YM3ogeo3kYc2Q/rXmLcLDxGTI9CnrtB8ol6mPLVNTIrdxb9CLS6g/cd50HK6U3Sm7tw49L2fgzD
	0dO9GxDNLO0U+CofBJJ3co3unVJTk8dzzcvPu8g==
X-Google-Smtp-Source: AGHT+IErCXkheRkAn8ztkA/4kbD3Vv8IgTYgskL5ABtY5Vnv1K9cr9jJhnKN+uszLloHhOBi6LlCRBFwVa1CpPDfSNk=
X-Received: by 2002:a5b:2c7:0:b0:e02:b68e:177a with SMTP id
 3f1490d57ef6-e03ad95ec1emr913514276.27.1720010345301; Wed, 03 Jul 2024
 05:39:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <TYCP286MB089577B47D70F0AB25ABA6F5BCD52@TYCP286MB0895.JPNP286.PROD.OUTLOOK.COM>
In-Reply-To: <TYCP286MB089577B47D70F0AB25ABA6F5BCD52@TYCP286MB0895.JPNP286.PROD.OUTLOOK.COM>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 3 Jul 2024 14:38:52 +0200
Message-ID: <CACRpkdZf033WftaRXpE2=dzs8cyuMfKVqGqoM6y3+EoqWG8Y-A@mail.gmail.com>
Subject: Re: [PATCH] gpio: mmio: do not calculate bgpio_bits via "ngpios"
To: Shiji Yang <yangshiji66@outlook.com>, Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, Asmaa Mnebhi <asmaa@nvidia.com>, 
	Andy Shevchenko <andy.shevchenko@gmail.com>, linux-kernel@vger.kernel.org, 
	Mark Mentovai <mark@mentovai.com>, Jonas Gorski <jonas.gorski@gmail.com>, 
	=?UTF-8?B?TMOzcsOhbmQgSG9ydsOhdGg=?= <lorand.horvath82@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

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

I'm convinced this is the right thing to do. (By Jonas Gorski.)
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Bart, can you apply it for fixes?
(Or for -next if you wanna be really careful.)

Yours,
Linus Walleij

