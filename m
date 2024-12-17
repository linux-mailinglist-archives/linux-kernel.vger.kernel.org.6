Return-Path: <linux-kernel+bounces-449273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC469F4C91
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 14:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DCAD1880598
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 13:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4931F3D5A;
	Tue, 17 Dec 2024 13:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WTTmyvx4"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949ED1F3D2C
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 13:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734442758; cv=none; b=T9Ehu/J76FpTRJ9nSXdTnND6j8gWuBvo25twbtQFIyVy/+stFrfGlgGUkJGLzB1JaTUI7JC1tdZigCnDiLWdlbX2XOD9Kw/m/FWOcMuKGqmUc0Wkd56bYsQ5UN5MNWheZV25p1Sv2gCc/jrFDQ4KtqtmmlmIFICixK+mtnCjDuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734442758; c=relaxed/simple;
	bh=+BHHgz6jyTf+Pk7wqxnrYIMZ4vqcIxReE5ZMVRAFZY4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vuabs3ybPD9prNpQsQEtQNrafF5eoC2DnezdwmH/3qVu1dmPAAvxCo08BKU7qUuDGxxkyCzLyOanbkpr1tLOqBXQxLYXNh/eG/hAcTI26/0lVaLOurepoUoGezWwxNSZbkBaliQWXBjhx5TFmpcWZN/pN4LvlsVXxTKgmMyxLWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WTTmyvx4; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53e3778bffdso5520984e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 05:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734442755; x=1735047555; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HMjCYKV984QoRr28xf3w0OYwbaOYhzni2D5iyXZ+XqY=;
        b=WTTmyvx4d4xcEQzsZ/MUKx1cj15YgPutz6oRXrE0aSdAn8Ahhvu2C7bjca6RZr9Qee
         Ls2mYrIwhY6TMwJ4d5ktDa03MJUFrU5Kzj4AUJQNDq7FNkHuFa5CZdd3yfpInGBLWYcp
         YUBNMor5qB58XtWJZfxYMhGx5C/YN4zeZhsB1GVwxqrEiHtYNwvAUxrUML9SUvKVgG/x
         5cwd4i0iYsa8z3Lciqbt31RY3DhTE45DLRZErVCe0qXusms8AODr9tn0J/houjPH9ExK
         GaQea/rTStCrXMje6ZrUrA2kakgleMEMKQA4S7pPfI7dHlOSr5sJWulampkjAVw50isM
         S/DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734442755; x=1735047555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HMjCYKV984QoRr28xf3w0OYwbaOYhzni2D5iyXZ+XqY=;
        b=Stpjfhs3xeZkZMcySZSuPItcm2bZwFqvcTgUbEJZubuD0djliaBBOsFhIQSNS2TdGw
         T3mYmLnrqp9JKtskCMJs9jyFkbRqCBwAB8WfFDQWVP0aJChw7rGcqIqJUMD6yGUDkwo0
         87bcp5GLXISPDtom3zvItMyowXu0hjlhc7sVPydL13AU0XPGQV/S2V1A0damJ5S2bYBJ
         rKrNWTZNIZDV+EBl+CR27FUITE7Wuy0CX0Ho34sf1yd1nFDWiJnxjR0ySckvC7JMMwxQ
         fFAu9fDCTKlMSZUsbXjlw63awSZUyLpt0TRBMxTlL3PMrUppIp7D5ctpd7os+1nNa/01
         25PQ==
X-Forwarded-Encrypted: i=1; AJvYcCVB56KGqsUed7Ed2H6dHW+5kwDb9jEy3RbadHOOzoWJq8FYrASqtUbNkcLguc3AEoJ4ML+kcDIIRcSaSpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWj13G/ntyyEgdzIz17vwxQVheidM4xXKCYwkRRLurA46Vdnjn
	3Bh5lM+Uy/EupTZ6HIfChwhNtCPEKdQuxTRbrpk7MroJKjR5Yoh1ac+i6FR6PKI5yY17CiI1oUm
	McAJD+Uez1fubMxUDsjNcAcKxFFMnTMZ86IL59g==
X-Gm-Gg: ASbGncsZfA7YzR7bdVcG8adCKDQ+x7a11Ih70qR2qbDjxpdNP7G0L489+DcTofvzrSP
	y14n38UODO4h0XynqeySIJdb70jGZHI6URFIgdA==
X-Google-Smtp-Source: AGHT+IEjrp870JNskf6bHNzYI2aNmKqs1NPMelQxcm9rfeKc8LyEkX5SdkkUq1R1luqQe2P7T5643ul/B1u9O9Mw0vc=
X-Received: by 2002:a05:6512:1287:b0:540:1ca7:4fe9 with SMTP id
 2adb3069b0e04-5409054e4b0mr4948477e87.22.1734442754678; Tue, 17 Dec 2024
 05:39:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241119140805.3345412-1-paulk@sys-base.io> <20241119-prudent-jasmine-lizard-195cef@houat>
 <ZzyoIABRArkGoZBn@collins>
In-Reply-To: <ZzyoIABRArkGoZBn@collins>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 17 Dec 2024 14:39:03 +0100
Message-ID: <CACRpkdbqufNVq4Ai6GQpgK2OY0rxLnp1wLQNmRoCv44T0xmFkQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: sunxi: Use minimal debouncing period as default
To: Paul Kocialkowski <paulk@sys-base.io>
Cc: Maxime Ripard <mripard@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Paul Kocialkowski <contact@paulk.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Some discussion here, and some emotions involved.

I can't seem to follow the technical matter because of all the
social matters :/

On Tue, Nov 19, 2024 at 4:00=E2=80=AFPM Paul Kocialkowski <paulk@sys-base.i=
o> wrote:

> My use-case here was hooking up a sparkfun sensor board by the way,
> not some very advanced corner-case.

Are you adding this as a DT overlay or by modifying an existing device
tree? Does this sensor have an established device tree binding?

Are you using that sparkfun sensor by a kernel driver or from userspace
using the GPIO character device?

I noticed that the sunxi GPIO driver is implementing the
.set_config() callback calling gpiochip_generic_config,
which makes it call down to the pin control driver to set up
the pin config.

which would in turn make it eligible to use
the gpiod_set_debounce() callback to push down the debounce
period.

But pinctrl-sunxi.c's sunxi_pconf_set() does *NOT* implement
support for setting up the debounce, because it is (as I understand
it) not part of the pin config hardware, but part of the interrupt
generator hardware, correct?

In that case I think we the gpiochip .set_config() callback should
be modified something like this (pseudo code):

sunxi_pinctrl_gpio_set_config()
{
    if (irq_is_in_use && param_is_debounce) {
        modify_irq_debounce_according_to_param()
        return 0;
    }
    gpiochip_generic_config()
}

pctl->chip->set_config =3D sunxi_pinctrl_gpio_set_config()

Maybe the debounce can also be set even if the line is not used
for IRQ? I'm not sure.

In either case the latter would give the GPIO driver a handle
on the debounce, which is good because the irqchip
generally does not.

There is a way it is possible to use the interrupt with desired debounce
setting by first getting the GPIO descriptor and modify the debounce
setting and then getting the interrupt from the GPIO descriptor:

struct gpio_desc *g;
int irq;

g =3D gpiod_get(dev, "dataready", GPIOD_IN);
gpiod_set_debounce(g, 1);
irq =3D gpiod_to_irq(g);
...request irq...

Here I assume the line out from the sensor is named "dataready"
the actual component likely has a name like that for the line.

This requires changes in the device tree as well, so that a GPIO
line is assigned to the sensor instead of "just" an interrupt:

sensor {
  dataready-gpios =3D <&gpio 14>;
  ...
};

instead of:

sensor {
  interrupt-parent =3D <&gpio>;
  interrupts =3D <14 IRQ_TYPE_EDGE_RISING>;
};

Unfortunately this is one of the areas where DT bindings are
a bit ambiguous. Some just assign the GPIO line as an interrupt
as both APIs are available, sometimes a proper GPIO line is
preferred for the above reasons.

Yours,
Linus Walleij

