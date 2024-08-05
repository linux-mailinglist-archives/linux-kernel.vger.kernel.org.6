Return-Path: <linux-kernel+bounces-274333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BF39476E2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 10:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85498B21EA7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 08:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E521509B6;
	Mon,  5 Aug 2024 08:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zShhkMLm"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB4D14B968
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 08:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722845107; cv=none; b=dencK/Pc+HEmgToIzE13rA2g//Y0DTD3IrR1SV+97krZFyL5oPRJiRb/yTzL2hRyAOzdSa7IOMZcHZa/k/cPP6RmTYOLMEpk0sbmYcSMWlqThtghN96gZxKsBlPbtPuOk942VaSfk+EprvvBPmDVg6SC/2UdkBKDK4qQ4bMZKgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722845107; c=relaxed/simple;
	bh=6sXJ3WO3dFim8GApcSIrk/tXyaVvkV0bTNmi+2+R1Zw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HYNRh9w54wFF2LKKvC00h43cH0u0Yg0Mua9x3TEesja5n4pRIZV4vNFlXOKQjV/Itow1FC/OIU1jmSVah63UrntQDovjQonC3PyQQBWmMY+fdvhXnGJ0gyBgT3dW6oRUeyrztzrBODcMQ2VqaGbW/8+7z73rNjwvOHLiNk25ESU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zShhkMLm; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52f01993090so14140535e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 01:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722845104; x=1723449904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+vUo6X2UB32z9znfy1Y49G04XlyGtFJELqgfmxMvQuo=;
        b=zShhkMLmDtgbewDtCSCDCufn0hLfxDpfNlIUzrcvy74+QktlzYbNaMds5V57gz5Fpg
         WogQdSnR9Bw1+AlB9pHhj7XQmSQkMBH8h1aLjgY0VDRe5XmOlC/chNqEKTPicItYAvDn
         kvhDyZbHnhi7AdTVUZoFw5xRZQMt3MGyhc/ZE8oFSjdun0kK3O2indQTwUPHs9dILJIp
         O5f9GNjxo+ve7vG6n+zHdduFi1t4r8lDblZuwTW4pg0VYCOdjSm7uVyxCBsL39YlpYM5
         4wVsrHnDR/P6+RsNdTZ+L6xXg5AcbZe5LOLSqSE8nbavjmTOGdfU4Q5GQ9NhAxo2hOLa
         7UKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722845104; x=1723449904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+vUo6X2UB32z9znfy1Y49G04XlyGtFJELqgfmxMvQuo=;
        b=JrKd8T9f78mT1atblM5Yubm+j0WtWwszUgAqp/6QYWnL6t78MZLFT3NaebfkV40Sgk
         lIjRSCZm0tSJwZFN47beOYJG46fCIvmjXMC1DOcu6mWK+Xtfr+mZRIMOIRGW4fTB2Eab
         R9ljUSSAh/tbVuJYDu6gJDWmNZUa27ykn44ue+OrWTxn2CDwNL9uDz9a6KlRvRkHXa2a
         D3SaHRza3+3pZeP5fiSlIwC5dyEk5itHNBJqp6KD8k+3DIPLiJGnUumJF32ep76AAGcB
         b7NPb9Q3K8LD4i9Iijvnd/6zXZRs3FVIhVuVXyd6vwAaGqec2aGXyCzlSFPZDGpObFEb
         7h2w==
X-Gm-Message-State: AOJu0YySBKy2+yT+JIHwBNub++65b5Cz87uLh6pgAFhKSuDiATccyv8Y
	/qKRshrHZfAyXmtzGhy/Qje0WY2dShHxXuTQUgeRzffsrwpCgCuZwPNHFEEaCZj1xPC7Cel/+BQ
	PebgXMLkWpUPVOk12g5SRaRmOhSopG03lRWkskg==
X-Google-Smtp-Source: AGHT+IFGNovjX087F1QurhU0HQ7nruW2cdo46FHweA0PGGBWHf1HSVejhpZypq7DgKQTcYz6PkOVXwzgpSu/BA7Ep7U=
X-Received: by 2002:a05:6512:ba7:b0:52c:9e82:a971 with SMTP id
 2adb3069b0e04-530bb36640fmr7518778e87.7.1722845103835; Mon, 05 Aug 2024
 01:05:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240723-supervise-drown-d5d3b303e7fd@wendy> <20240723-underage-wheat-7dd65c2158e7@wendy>
In-Reply-To: <20240723-underage-wheat-7dd65c2158e7@wendy>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 5 Aug 2024 10:04:53 +0200
Message-ID: <CACRpkdbRE695f-+do1HYpOZ6e4qxgUBWJzEPO2hTCuZ3xxYHQg@mail.gmail.com>
Subject: Re: [RFC v7 4/6] gpio: mpfs: add polarfire soc gpio support
To: Conor Dooley <conor.dooley@microchip.com>
Cc: linux-kernel@vger.kernel.org, conor@kernel.org, 
	Marc Zyngier <maz@kernel.org>, Daire McNamara <daire.mcnamara@microchip.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	linux-riscv@lists.infradead.org, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, Lewis Hanly <lewis.hanly@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 1:28=E2=80=AFPM Conor Dooley <conor.dooley@microchi=
p.com> wrote:


> From: Lewis Hanly <lewis.hanly@microchip.com>
>
> Add a driver to support the Polarfire SoC gpio controller
>
> Signed-off-by: Lewis Hanly <lewis.hanly@microchip.com>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>

Just a comment on second thought:

> +config GPIO_POLARFIRE_SOC
> +       bool "Microchip FPGA GPIO support"
> +       depends on OF_GPIO
> +       select GPIOLIB_IRQCHIP

select GPIO_GENERIC?

> +static int mpfs_gpio_direction_input(struct gpio_chip *gc, unsigned int =
gpio_index)
> +{
> +       struct mpfs_gpio_chip *mpfs_gpio =3D gpiochip_get_data(gc);
> +       u32 gpio_cfg;
> +       unsigned long flags;
> +
> +       raw_spin_lock_irqsave(&mpfs_gpio->lock, flags);
> +
> +       gpio_cfg =3D readl(mpfs_gpio->base + MPFS_GPIO_CTRL(gpio_index));
> +       gpio_cfg |=3D MPFS_GPIO_EN_IN;
> +       gpio_cfg &=3D ~(MPFS_GPIO_EN_OUT | MPFS_GPIO_EN_OUT_BUF);

OK this part is unique...

> +static int mpfs_gpio_direction_output(struct gpio_chip *gc, unsigned int=
 gpio_index, int value)
> +{
> +       struct mpfs_gpio_chip *mpfs_gpio =3D gpiochip_get_data(gc);
> +       u32 gpio_cfg;
> +       unsigned long flags;
> +
> +       raw_spin_lock_irqsave(&mpfs_gpio->lock, flags);
> +
> +       gpio_cfg =3D readl(mpfs_gpio->base + MPFS_GPIO_CTRL(gpio_index));
> +       gpio_cfg |=3D MPFS_GPIO_EN_OUT | MPFS_GPIO_EN_OUT_BUF;

Also here

> +static int mpfs_gpio_get_direction(struct gpio_chip *gc,
> +                                  unsigned int gpio_index)
> +static int mpfs_gpio_get(struct gpio_chip *gc,
> +                        unsigned int gpio_index)
> +static void mpfs_gpio_set(struct gpio_chip *gc, unsigned int gpio_index,=
 int value)

But these are just MMIO functions.

Is it possible to use augmented generic MMIO, i.e just override these
two functions that
need special handling?

Yours,
Linus Walleij

