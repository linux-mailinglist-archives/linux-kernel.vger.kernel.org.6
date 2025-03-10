Return-Path: <linux-kernel+bounces-554321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 507C2A59624
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 14:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E5971890B18
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 13:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E8922B5B8;
	Mon, 10 Mar 2025 13:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Vz+qn6jX"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00C322AE7C
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 13:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741612965; cv=none; b=eZGL0elIm2pmju0/7wxka4N/gFWn4eTg5ir4HSkCsMF02u1/JnQuXzWZUQljza+OWCDG7bZyTwjurNDyX/TeHmg6+VEIbmGcqpino1DXY4xlKX/dnurl9a+0HIhSYdhKKQAx9/eH/2o7132reLhe3ky9ZHGS987WrM23uzTfdYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741612965; c=relaxed/simple;
	bh=DPKb8ThpUtf/tZId/Di1QGFds3FHv0BZjzDL63AUYKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u8WhmERjyvnrSBvcj0hMwaAXdAQNo9rCvh1ousrR7spIClKLzvacpqEKDw+s+gO5YTqtWjDyk+C04rVk26vPFqDhnDNrC0KTe5zWmaY/NZthtqdVKNqJG4PjWCw8TwaskTj7iOjdHybSXr1pfjFjN/Nzlc0D9Gnc8nL7Oe0I9R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Vz+qn6jX; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5495078cd59so4912290e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 06:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1741612961; x=1742217761; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BIR94qx8xpSJrcrgyo8EcRbXb4tKFO0K352zXBNzI/Q=;
        b=Vz+qn6jXUoH0dwlwtlJsM/oxic8bB7UUO0LC2g4VJ1mDUGgmJBCTY1XsZxAWfWkkc7
         U8gXFUdVQeEuBr3TdBy1a1jQT8/dK4bDdI+RQ40ZG4xogl/S5s0zTqzVhCUg/+3N/xcL
         f65qFxW69HUKA19A2YE9B3B+qEZAbwn64BUj54AYkzLIvMLiQZgJkjeEL2r6rP1yIKUo
         OXNd9yZaod8dwVZlSrliQdIJajhAvdHq26HIn0DY8X0aRt95XG+bfbW9/qytrmUlCeT/
         oAwXm+OdVJ6V9sZeWtnyZPWc0gA7xTi+n+LQe4LZfH3q0DCY+kNes/4YZuvv9tgF7SI0
         /0hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741612961; x=1742217761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BIR94qx8xpSJrcrgyo8EcRbXb4tKFO0K352zXBNzI/Q=;
        b=IrjZo8rkLTyB80qJq59j0aOmx51agkqz5VjphgStamW+2wtVeVPGlCvkhOraiZr0aE
         VlJHn1dxODWqORd57YYcTuGwqJZQjduproC8X8jgdszY+PrtkjVlB7f3UeoCWecNbQ2g
         Dck484mdIJ4CjkJIfowuAOdnSpknH9fP63QQmMG23WyKvmNt3BFt0+hj/K+N+xwH4kLz
         msH6aVacdN3yGYPPwI0I35NrKZOSijWNMs0qAoCI12cZIT1Xa6bs1RoNWBoe3J2ol3v4
         pOkJ7xJhe328JsvcXBfqlhVdPAbxwNrSK2WKmD6vWZ64K19+YoNoma9khscyLx7Jm16n
         e7CQ==
X-Forwarded-Encrypted: i=1; AJvYcCVB93OI7kifXy2CGL2ZMjXAJWWFZkXOLxE6lbMdvzAgj1H0AYTXR+1bmhtNs8zJRCA5aA95cEf2RAOyYKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtTCXkSFMhQmsTgBuViPCnExEOL0yn31JfImayJ4WwPKUh/6b2
	bFqqXTSBP7DogPfCZbK/jCoRY5tfftHdAYW8/pN7HW0cGh9JbD7dtRCGVsFoLMb5l2SkCDgOpl8
	7Ai/DuD6nT80nFufuR2a3W8k3LN1fdzgLOS7Wmw==
X-Gm-Gg: ASbGncvodLKhcEyV1EPLpzA2GZ/416NXa+9BRvFPM5ymAkSa/zE0mxQVcx7VkFdjNag
	iO3kIsztmRZCOoHvWHA7wbXD6hbfSxpz71Yqzo2keZO5lfbisVZy5wPX868UpvFTVdQitLPHqVK
	1rcVJfyrjoeMiGIfatuz8hWxhg7EFuyFO+Foow+ynnKNRhTLssql3Ci+9s/Q==
X-Google-Smtp-Source: AGHT+IEt6orrR0LbnqijRHsXsXIoP9u4govV2U4kennnDAB8LKxqgLR624RGe5IQ9d0SgevP43EOtHRqT3+K9YyJF4I=
X-Received: by 2002:a05:6512:3b14:b0:545:2c2c:5802 with SMTP id
 2adb3069b0e04-54990ec1da0mr4456748e87.48.1741612960898; Mon, 10 Mar 2025
 06:22:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310-gpiochip-set-conversion-v1-0-03798bb833eb@linaro.org>
 <20250310-gpiochip-set-conversion-v1-4-03798bb833eb@linaro.org> <475375c9-9d72-4583-a21e-37b17c6b8c46@gmail.com>
In-Reply-To: <475375c9-9d72-4583-a21e-37b17c6b8c46@gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 10 Mar 2025 14:22:29 +0100
X-Gm-Features: AQ5f1Jr6exc6jnbdN8OgJKfOfnFqkqPylc587CtLf_MV91ith_zm5SakUGtCL8Q
Message-ID: <CAMRc=MfofTMnfCYenUTstWUeGN5RYzJTrg2nGSzCe8tdBMksmw@mail.gmail.com>
Subject: Re: [PATCH 04/15] gpio: bd71828: use new line value setter callbacks
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Ray Jui <rjui@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, Marek Vasut <marek.vasut+renesas@gmail.com>, 
	Michael Buesch <m@bues.ch>, Thomas Richard <thomas.richard@bootlin.com>, 
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Benson Leung <bleung@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>, Andy Shevchenko <andy@kernel.org>, 
	Support Opensource <support.opensource@diasemi.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	chrome-platform@lists.linux.dev, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 2:20=E2=80=AFPM Matti Vaittinen
<mazziesaccount@gmail.com> wrote:
>
> > @@ -28,12 +27,10 @@ static void bd71828_gpio_set(struct gpio_chip *chip=
, unsigned int offset,
> >        * we are dealing with - then we are done
> >        */
> >       if (offset =3D=3D HALL_GPIO_OFFSET)
> > -             return;
> > +             return 0;
>
> Should this be -EINVAL (or, can this check be just dropped?) Value of an
> input pin is tried to be set.
>

I don't want to break existing users but I did notice that and figured
that we should rather check this in core GPIO code not each individual
driver.

I put that on my TODO list.

Bart

