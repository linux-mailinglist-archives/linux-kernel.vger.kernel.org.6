Return-Path: <linux-kernel+bounces-528452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E44DFA417CB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FC5A16A972
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 08:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7B0191F6D;
	Mon, 24 Feb 2025 08:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="U0o6eDBf"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DE118A6D5
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 08:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740387068; cv=none; b=j0J+E9rqapxGdJssOTcXAsyTqqO0ZF+sTOSEntTLrQ7SFwoCLSxbqumukwxntcKZ9mFsRa2BPulcrzcjginELGG88MVdfwlwqRKPA6E/JUcU9BncH5fvvhlWxVsM17Ye88XtWhqN2rrVYF0ihC78zYDycs9jaxvaD67NoG2m7VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740387068; c=relaxed/simple;
	bh=AWpVnDdHPnLjlBgLHsI5jv6cR6R9p5fUnRdwZCiqPx0=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O4/4OOBhSyBxXPc7mHh5T75G4kNVpjO4xdZlqE8Cx4i7QAmZ9fytW4tPZMHKmmXVY4dr4gG9abenGjRTcbJm18tlR0HdaGHxUZ3qUAkKmFX9LJl6PjndvC/O55Gbyac4h/zeC0GLVZQ6c2Nekr8HRRHVlg+rpWjpKwnaHyNyprc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=U0o6eDBf; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-543e4bbcd86so4919526e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 00:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1740387064; x=1740991864; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:references
         :mime-version:in-reply-to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7BhzG4nBQaS6pZEmDj6jN7Om9fMKvu1IxUm1+KATAIU=;
        b=U0o6eDBf4CTWZalsLcxcxJVcAX5wAsdjLGqmZPj+bRI6urB1sGLoUXU5BU6vm5ShJu
         wot0MVgdw+KRahCZYkBGrwbOJ+J5HkTxRjdTjpgRBJIuRCcHpcYgGMCGDXbYUyGzpcY9
         O+Ebf6ovM4IiFtExJjBGKxsO43ku6ygUBCdDVP4rGHlqaS8EpZXDE6z2Iq6ZvUNrE979
         fDYO81esnF/SKC/h77m4XUifqeofMANV+WidrFQyFV5jxHcJ2kehYrBY8H9n1fAInJjY
         7TYYHLJvlUnEyCxLbePlmNZ+zZsK9nB/FqQZcNZrCaF+cKyaqFjiihf2AdtbYLRYvQyX
         Q3iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740387064; x=1740991864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:references
         :mime-version:in-reply-to:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7BhzG4nBQaS6pZEmDj6jN7Om9fMKvu1IxUm1+KATAIU=;
        b=XvtGA7sbVcn5VGDt274knzIK61mg1UvKrjdM3mVFUVR6oVXnjTYGRJ8/siTzVxYtZ8
         rAB8pcUQqCuFdB3YAA2Sld52jiGa278wW0lqc9AtPaqnwb2ipdPJ3oCPR0MF2olO5cOp
         F6b7CQHKPDnvcVXAdYgTyqKdJ7rqPGtwwMqiYjo/RkehLKdQqARcnNR9HmysV6of8Qt8
         VHxEC+wCrwdQKjSCWSA5TL4lItATkaU3qI0NFrOrU/oraIzxoLRDTZ7j5SOvfamrEhWc
         DoyAZdx1fFwuYabNjVJXSRlLm83or5WE74athSiAs/HbMIpCNjVbYQAPbSiRUhzHTdW2
         SBug==
X-Forwarded-Encrypted: i=1; AJvYcCWuidBNg9KYCJ2KSacg95TIz3zXSxFGtf1HxzA1OYC+DtdkKt4XotdPN25XYsiHhwY3JSL7adHVBGNN9l8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9pfDHe7GA+5aB3LkknoIIF7eJj+Ymsh8NONnfUQjfsYJBudp2
	t/78ID443OSIZwPKIVYIBF/jaPFXKTzu0pvowHgov2X9CTHVVP30kpO3PoAjnjMfpzGTm3Hzxk9
	h7fg1ZvcQJ39djnMoy3rph5c2/2ajmHaxym3G0Q==
X-Gm-Gg: ASbGnctjJvHBjBGdpSieB7/Q77H11rm0PJ0izMYxFSU0yWFpRM1C7vTVvgQttrrIKJs
	2KgYnj4OmVTmfYiFzckdMmsvlugcwW46smDZeO9kHC7DiQeU9UibYsatMhyNFqg1N24aeaLjF4F
	0eweKFsqoSVoTIdf8FzB+Is0Q3gn7VW3tFqmz1OQ==
X-Google-Smtp-Source: AGHT+IGJUguXGJKpeBE7PfOW0x1i38GshOmr4oabfnWWPRN7xFoQCCjbLZq7tN5p972Bi+c4LXaf/H95WQaopgTHhSw=
X-Received: by 2002:a05:6512:ac3:b0:545:f69:1d10 with SMTP id
 2adb3069b0e04-54838ee1c94mr4275057e87.8.1740387063972; Mon, 24 Feb 2025
 00:51:03 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 24 Feb 2025 03:51:03 -0500
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 24 Feb 2025 03:51:03 -0500
From: brgl@bgdev.pl
In-Reply-To: <a8c9b81c-bc0d-4ed5-845e-ecbf5e341064@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9ded85ef-46f1-4682-aabd-531401b511e5@molgen.mpg.de>
 <CAMRc=McJpGMgaUDM2fHZUD7YMi2PBMcWhDWN8dU0MAr911BvXw@mail.gmail.com>
 <36cace3b-7419-409d-95a9-e7c45d335bef@molgen.mpg.de> <CAMRc=Mf-ObnFzau9OO1RvsdJ-pj4Tq2BSjVvCXkHgkK2t5DECQ@mail.gmail.com>
 <a8c9b81c-bc0d-4ed5-845e-ecbf5e341064@molgen.mpg.de>
Date: Mon, 24 Feb 2025 03:51:03 -0500
X-Gm-Features: AWEUYZlDQScCnGqmGbQZrje1sb8Ipabug5b7HPQ3I9vkOhxdFZWYtY64UwmbNKc
Message-ID: <CAMRc=MdNnJZBd=eCa5ggATmqH4EwsGW3K6OgcF=oQrkEj_5S_g@mail.gmail.com>
Subject: Re: Linux logs new warning `gpio gpiochip0: gpiochip_add_data_with_key:
 get_direction failed: -22`
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, 
	regressions@lists.linux.dev, Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 23 Feb 2025 23:04:05 +0100, Paul Menzel <pmenzel@molgen.mpg.de> sai=
d:
> Dear Bortosz,
>
>
> Am 23.02.25 um 21:54 schrieb Bartosz Golaszewski:
>> On Fri, Feb 21, 2025 at 10:02=E2=80=AFPM Paul Menzel <pmenzel@molgen.mpg=
.de> wrote:
>>>
>>>> What GPIO driver is it using? It's likely that it's not using the
>>>> provider API correctly and this change uncovered it, I'd like to take
>>>> a look at it and fix it.
>>>
>>> How do I find out? The commands below do not return anything.
>>>
>>>       $ lsmod | grep gpio
>>>       $ lspci -nn | grep -i gpio
>>>       $ sudo dmesg | grep gpio
>>>       [    5.150955] gpio gpiochip0: gpiochip_add_data_with_key: get_di=
rection failed: -22
>>>       [Just these lines match.]
>
>> If you have libgpiod-tools installed, you can post the output of
>> gpiodetect here.
>
>      $ sudo gpiodetect
>      gpiochip0 [INT344B:00] (152 lines)
>

So it's pinctrl-intel, specifically this function in
drivers/pinctrl/intel/pinctrl-intel.c:

static int intel_gpio_get_direction(struct gpio_chip *chip, unsigned int of=
fset)
{
	struct intel_pinctrl *pctrl =3D gpiochip_get_data(chip);
	void __iomem *reg;
	u32 padcfg0;
	int pin;

	pin =3D intel_gpio_to_pin(pctrl, offset, NULL, NULL);
	if (pin < 0)
		return -EINVAL;

	reg =3D intel_get_padcfg(pctrl, pin, PADCFG0);
	if (!reg)
		return -EINVAL;

	scoped_guard(raw_spinlock_irqsave, &pctrl->lock)
		padcfg0 =3D readl(reg);

	if (padcfg0 & PADCFG0_PMODE_MASK)
		return -EINVAL;

	if (__intel_gpio_get_direction(padcfg0) & PAD_CONNECT_OUTPUT)
		return GPIO_LINE_DIRECTION_OUT;

	return GPIO_LINE_DIRECTION_IN;
}

Can you add some logs and see which -EINVAL is returned here specifically?

In any case: Linus: what should be our policy here? There are some pinctrl
drivers which return EINVAL if the pin in question is not in GPIO mode. I d=
on't
think this is an error. Returning errors should be reserved for read failur=
es
and so on. Are you fine with changing the logic here to explicitly default =
to
INPUT as until recently all errors would be interpreted as such anyway?

Bart

