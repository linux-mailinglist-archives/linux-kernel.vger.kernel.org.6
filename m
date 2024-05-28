Return-Path: <linux-kernel+bounces-192272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7808D1AEA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 14:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 307342833C5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 12:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E885016A39B;
	Tue, 28 May 2024 12:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l+Gr6dzq"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C251373445
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 12:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716898665; cv=none; b=ZN9CGjjY9Lot/xQJiupUmLHEGKfQxegX8UtmC4DYOIiF0DnXnFx54Cbfw0Uo+4GQTmxpICiOEWkBMIh7z39sLOmQMMRr0F2bZwfaPOzjF8OJqhkzB/6oDxNur4dw5YvNSjS0dQApIeLlUQMva++mIO2I6EmW5CdTwE7Nd8aoAxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716898665; c=relaxed/simple;
	bh=PI3B8JAnrwoddvWTVgBZJ1muYwpegH+idzo35ur6rg8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o2Lxo4LdP0axwm2BXbu/VC7hpQOdTCeIsKpctwywbHPlL3aAysmYTahpw3bZUYrgd38Sn0Nz6uWU/mQmJFdkE5D5g1q25EVSmGK+UXldYlxm8uXysrcVCWAQ+cxW3xmsWbhJz5NoPZiiyZQ7GczKkNNx7vZttnnTzEIMjflKHFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l+Gr6dzq; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-df79380ffceso1822417276.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 05:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716898663; x=1717503463; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PI3B8JAnrwoddvWTVgBZJ1muYwpegH+idzo35ur6rg8=;
        b=l+Gr6dzq/bhxV/uSJAjMJihPC4VabgY9kkj6okgApPO7VzWqctC1UEatWd71WkADy6
         djmWNOG0jKx80T280ePL4kQlazXZSiq5M7hxfVPbQna5SsVqpXM0ZVcWe9gm7P/5wnMC
         4v92C1Manb5o/a3G5EGJ1orQWin6np0anfo8BPHzim/a9KmrYLsRkJaqg+3MPsIvVY5+
         f77nlQodTqqdL17VZ+4V2dMakE+IW8dmXZeYM3BcUre5Rf/aTs1EVTXapGtnJX9qPori
         FlZ15hUPStDv5V1MesXTL9xVYjHT3R5ZzI2OX/xYw0XJ6xHwTEv87G9dB5t1fAc7EE38
         alRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716898663; x=1717503463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PI3B8JAnrwoddvWTVgBZJ1muYwpegH+idzo35ur6rg8=;
        b=UJARNB1aHNKtvqL/XngLQ2A9aZevOrUlHRwqKyTvMvOZ3cNDxK7TCkHRTx387VtcVh
         aadb0h0/aGQ514u/8X282v4RuD6lXYHdx94ndb6NZB6GVxmDtUqAl/tq98KOylS2Uz5x
         Z8qEl19l5npzFwLaksXSDX0dDyCDMMDsEDg1W5vTFjozzc5rkxhvdVU4PLVEK1l4s1NJ
         T6TQV1vlt6fwVQ2oKZueAXe8mMA1GNlEVTjzQvhaxTI7IKX64KLcp7WojmC/9oTuhwbo
         h4YkKaP3xHiC6ZXV339n1m5o/cWlf23QzJRbevn9aNy48Cln23mGPRPqF58i3A/reN4c
         Yt7w==
X-Forwarded-Encrypted: i=1; AJvYcCXk7IsdkxOTBM5l8J6KJvMKFQj4r94TUt0WIO7xMVKexavfOaqy+vV6NMS+kgARvbuzOGF5LPF++fYyyBV70BeTDEnGH8u5jmBR49zW
X-Gm-Message-State: AOJu0YyIuRnUnQzLxFBJoQatscyH5ZUIzp+saWgY1M22e/yUDWm3KFO7
	oRjF6qbPzCbqzrd/9BlZMVp8tRKzDRfLln4Rm5CEJD3PfzLo4tnYM3FZPDxvgZgN1KiBkGzlyQY
	UKLr9am7atbMwKHDNB6dPVS14261EPvyjScXumA==
X-Google-Smtp-Source: AGHT+IGvsFoMYbnYzlrb/IviX0m6kKqlmur3ghtnR8h0iN8Ytd3BwhIi9utxvp0TVkhi0U0AYD2Xq7u0TY+PDcGFpRA=
X-Received: by 2002:a25:8446:0:b0:df1:cdf5:d2c1 with SMTP id
 3f1490d57ef6-df770815db9mr8598857276.0.1716898662695; Tue, 28 May 2024
 05:17:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528120424.3353880-1-arnd@kernel.org>
In-Reply-To: <20240528120424.3353880-1-arnd@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 28 May 2024 14:17:31 +0200
Message-ID: <CACRpkdYsFBw907rH4pmgmA6R=0FsOac7-_2xzqP8vu=aVS5JJQ@mail.gmail.com>
Subject: Re: [PATCH] net: dsa: realtek: add LEDS_CLASS dependency
To: Arnd Bergmann <arnd@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Arnd Bergmann <arnd@arndb.de>, 
	=?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Luiz Angelo Daros de Luca <luizluca@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 2:04=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:

> From: Arnd Bergmann <arnd@arndb.de>
>
> This driver fails to link when LED support is disabled:
>
> ERROR: modpost: "led_init_default_state_get" [drivers/net/dsa/realtek/rtl=
8366.ko] undefined!
> ERROR: modpost: "devm_led_classdev_register_ext" [drivers/net/dsa/realtek=
/rtl8366.ko] undefined!
>
> Add a dependency that prevents this configuration.
>
> Fixes: 32d617005475 ("net: dsa: realtek: add LED drivers for rtl8366rb")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

The QCA driver in drivers/net/dsa/qca/* instead makes the feature
optional on LED class, so it is in a separate file with stubs if the
LED class is not selected.

Luiz do you wanna try this or should I make a patch like that?

Yours,
Linus Walleij

