Return-Path: <linux-kernel+bounces-537997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C07FA4935B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92FA91889920
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 08:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8335B245017;
	Fri, 28 Feb 2025 08:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="it1AR6gi"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9401F583E
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 08:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740731014; cv=none; b=oLXigaJZEBfDTV6u8E0p+6uougO3sKgUS75Jjk5CiHRKJdjs3eJZXvR4k3/Q1RsBXUPFj3pcXD+twGmKQnQNeE3Z4N5Na/UL7mS873Q4i+/c7Gw/OanXIW+fTnEjE0WigDa/KGzaQ7GoaiwlE++zEOAT97ReO44tq5nDi4IbO9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740731014; c=relaxed/simple;
	bh=R2MRTRMr+W9eU/udrGmceJQKzw74JG9DRcT8CxcYlD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X32MLjQcyqdu86oD7wFHH62D3KF7zOqhnfS42Lurt9hJQCK2xJQpY6bt6JnywbxUetTXriAjwrpCShPWZoHimYbtyMnvMQcSMoopZ8PSGr9sSAOBvN3kkW221shqSBVq6msScHhcq8j4QqGfbu0hjvwNrPGZVvEH7mK0LdTlIIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=it1AR6gi; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-30a303a656aso19398981fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 00:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740731010; x=1741335810; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y6CmQnr9nJmjwVIpC9L7TXMlfKzgO8vBaB5ebrTKh4k=;
        b=it1AR6giXuMT7UtAuCHfdr7Hp59a7tatYQXOAdc1a+NFxw0ZwwasC1mn3f9XN9qGNX
         AnZ/HHKSTe69tD7E0GUIxoBsPcAw21lpfZbLQzovdXrTm0DhSleY5eGnyapDYDcocksc
         8xqujCNmMY5wKyp3PLRr7opt3mqh7GCg9Nv74lTBXBlSe0gYyv3uZbOwfb6cpAHTVUCB
         ksL3oArmiHmCtX1I11Q7m0oUE9lAvvtr46vIyuhfyKvz6p4enDg8kUtZyW8V/F10/Dih
         m1dqFjNCHG0STE0iKEzHsEzIMksvI9N0v5CGBueekluEPfEnazCb0W+dS1PxUrbbRvCO
         FC4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740731010; x=1741335810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y6CmQnr9nJmjwVIpC9L7TXMlfKzgO8vBaB5ebrTKh4k=;
        b=ngQJC6Kwb95L+eGLOLFLm7gwSokFIwObZQtaF9fS4knBmkdMkMIij86zfrxkTSXcNb
         R62BVi4FpuzpAQQtc3LLC+MH2YAuxBFpa8OTVOaeBNLKH4oF0OuJfeZODffai1MUA/uF
         4a09iyhYBK48JJGsmziQ2f0NOibvxIDgZfZ58ErC3cXMElVe6Jtk33ZJbDFHD3crBrs4
         bJ09GnAbOGFCcs9yCV9I+bkbdnq5q6xWek7jU5V/sw0MSTN8h0sVS/h973VHeK+PpaUl
         Vrvgn5lHg7VxNjCL5nKxRz+x3F3M5kxdlbBneCnD/QR5l4tfGDC44cZI7k5SUYOcbul/
         6BAw==
X-Forwarded-Encrypted: i=1; AJvYcCVnN1krpbYKMxFFLzZhuS9XVqzWn+4+oLLFf5r3SW2wYhjLMqkIeUVpvkwrjrxlu8sa/pyiBzth//A0zFs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7cF+gV8uxjJhuqVYnjQdvYxSPJRlMoA4qeXrQmSlWTyfZCKSK
	swCT25xFm0fM7Y+6tjEBBovFNBY1T2Vt2ovPMfpAb3QxCg9+2D/bHRJhJy2V7gAPQtKBbPa7JlP
	B/L14yGQ0pWBGgHdeU2mw6lZh++3CgnMtbV/oVQ==
X-Gm-Gg: ASbGnct1NOX34yXXGwO2hO6xkWoJcAt7IWp6ObRN/8i7QfTzYEhivJzQjj15A4gc1oD
	GcDm/6KS+tmb2/+Dq+JiMbILg7Nqusxb4Hu5y0Sd8pWsPm0eZwNlBnZ46K3u4l/0nUX+8OX2Tit
	F3/Mn9iNM=
X-Google-Smtp-Source: AGHT+IH1bE/hdaIBMayw+gGpM9k5nGDh5XFnSS7BihMAS5lMqvifednGcS3mKS9CRv9UyLY40VYo/FzdFubU5gvJfnI=
X-Received: by 2002:a05:6512:3a90:b0:546:27f0:21a7 with SMTP id
 2adb3069b0e04-5494c38c10emr1014114e87.49.1740731010148; Fri, 28 Feb 2025
 00:23:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z71qphikHPGB0Yuv@mva-rohm> <CACRpkdYOGeDaDUuQQUGwvFNNk7ZuFjkXSMPXL3BJ=4jGEGPkoQ@mail.gmail.com>
 <ce0d802d-6bad-4028-bb57-18bddba5632d@gmail.com> <CACRpkdZtWLGAn0K+xENY+RF6CsWPn0m7R--W9EaH+xTKazALFg@mail.gmail.com>
 <8979f8d4-8768-40b0-a3a7-6638ddb626cd@gmail.com> <a7ab9d47-cd17-4098-b2ba-d53dfc19dbed@gmail.com>
In-Reply-To: <a7ab9d47-cd17-4098-b2ba-d53dfc19dbed@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 28 Feb 2025 09:23:19 +0100
X-Gm-Features: AQ5f1Jo20gvTk170DYVLWFd3aItRoAfaOdggSzyNA14E_0d2W-2xhzX4PDw9OD4
Message-ID: <CACRpkdafJfmuO++XXSFha51Q5=9DrqqRtxOpNeUsmvy7BHrC2g@mail.gmail.com>
Subject: Re: [PATCH] gpio: Document the 'valid_mask' being internal
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 9:24=E2=80=AFAM Matti Vaittinen
<mazziesaccount@gmail.com> wrote:

> I did some quick testing. I used:
(...)
> which left GPIO0 ... GPIO6 masked (pins used for ADC) and only GPIO7
> unmasked.
>
> Then I added:
> gpiotst {
>         compatible =3D "rohm,foo-bd72720-gpio";
>         rohm,dvs-vsel-gpios =3D <&adc 5 0>, <&adc 6 0>;
> };
>
> and a dummy driver which does:
> gpio_array =3D devm_gpiod_get_array(&pdev->dev, "rohm,dvs-vsel",
>                                   GPIOD_OUT_LOW);
>
> ...
>
> ret =3D gpiod_set_array_value_cansleep(gpio_array->ndescs,
>                 gpio_array->desc, gpio_array->info, values);
>
> As a result the bd79124 gpio driver got it's set_multiple called with
> masked pins. (Oh, and I had accidentally prepared to handle this as I
> had added a sanity check for pinmux register in the set_multiple()).

But... how did you mask of the pins 0..5 in valid_mask in this
example?

If this is device tree, I would expect that at least you set up
gpio-reserved-ranges =3D <0 5>; which will initialize the valid_mask.

You still need to tell the gpiolib that they are taken for other
purposes somehow.

I think devm_gpiod_get_array() should have failed in that case.

The call graph should look like this:

devm_gpiod_get_array()
    gpiod_get_array()
        gpiod_get_index(0...n)
            gpiod_find_and_request()
                gpiod_request()
                    gpiod_request_commit()
                        gpiochip_line_is_valid()

And gpiochip_line_is_valid() looks like this:

bool gpiochip_line_is_valid(const struct gpio_chip *gc,
                unsigned int offset)
{
    /* No mask means all valid */
    if (likely(!gc->valid_mask))
        return true;
    return test_bit(offset, gc->valid_mask);
}

So why is this not working?

Yours,
Linus Walleij

