Return-Path: <linux-kernel+bounces-401265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C78359C17F5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 09:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04CBB1C22CF9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 08:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7DA1DE8B9;
	Fri,  8 Nov 2024 08:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ya2h7S/Y"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DF21DD55B
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 08:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731054582; cv=none; b=S1xzL7+NfLuafKwUOvwLbLdqWyOJhbQ7bM8OlG4mP5lA/NeE8sU/gpdyxBynMOQja3UwLLeIwnanRvuOurfRDDMs4+anAK6wsL1Q2lSa95T4H6i2cBbihqjT/GhKGJC4+WS9R77H7SMF3wZaiIsd8v05x8PVBDg//D664+MXU5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731054582; c=relaxed/simple;
	bh=NcnPKxuoTZu4QcepzzkfkZ6URfzy3g7lXsQ5uVtS0eM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mRtq27An5SBYiy1ZPjcb9tk8CHF2O1z/XVSRc7RsrY9YaHLOdMMrE2M2o+MNa1x35M7a5P5CiHzFr/HLgL5H0azCvSYlm9nJWRWMyqe9NOgBPYdGD6gaF6CdO2KzMaeuLb4gIlYztEuXfrcvY5kuOxxLcuHc0mqMVSCfFc/DzUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ya2h7S/Y; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539eb97f26aso1633471e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 00:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731054578; x=1731659378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NcnPKxuoTZu4QcepzzkfkZ6URfzy3g7lXsQ5uVtS0eM=;
        b=Ya2h7S/Y6UDtD5Ih4cBErT+XuggmfByoxWEicnE27DkOuuy+NkbY2dvI5k1IhI2yFr
         5LqWpjV/CQwG3syEab+n8MATv44h4yoT6QVYoYtLaMwoxltI+kkF0FV9miz6cOHL3UgX
         jC0L3zUqDUaDM491YzgbLgODiz10RiM9XONK+tWLRnStmioAj9gnUO0e9oibbyCb/Ky/
         h6hgfF/O7pXNGLptMrpdDOZyj+RVSa1ph9cp8CCZmhMM7Oq+2/lidNGJ67t7eFn2UjE0
         +8dMthQKGF9tnNpulrP0vB0ArqcAsSffGko+5A8e3B1SiLAYDtu9kf2qlBPJbAtupBbz
         1cZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731054578; x=1731659378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NcnPKxuoTZu4QcepzzkfkZ6URfzy3g7lXsQ5uVtS0eM=;
        b=Iw7DdYcK/NUP2aNPduIj2LhnInQK6PGd+E5FbGmTi53h+b+da7KTu6lM8lQ+zCODNI
         q8QoxdtVICunMSSBfhAW8VNVB+4P9KeBC3C14iMjaxHC0BvWNdn83OI2IaS8UwTS8QST
         2Y+HSExU+T6YjNeYfLw8z+0w0EnysWOpfIs3jhT5OVWZ80KGcAnnZth9rJDboLSfP70G
         1hLY2kGz9CePe4f7IHsWw4+5peVPLbkUWDYWgsrHl3sx7oAjazcjCDnrKyuT54fAEs2k
         vUd5MZkOxrB+/8or7S/hoTYyxS/2Sq+ZX4Xki81u60jkECc0+YBaEw1LM7Vllrb/IEJj
         SDLg==
X-Forwarded-Encrypted: i=1; AJvYcCUqBcMfQr4p4V7kUA1heloxeB3GYcj1p+WWLIE0avrQoRulOWC5kFhsbi8rPYb8fE6IMdSXtnkXusYfmyA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3y1ZVvqaP2YSme7yIGRL+JEnLFmCo42ytlmEeHClED6hPr/rQ
	QmBp7Wf/vsFEkN1Ig4RDuc1iVST1hhGBy5qmcOvgIB1MCZQMgJE0dq0OXdT+Q5kSvAfCwHuxgul
	KRYC5cyiyrNw/QrW+sUJmJUYafNnWMIvGfTrRRw==
X-Google-Smtp-Source: AGHT+IENM6vfeCH9jGfRGzsvajDFe9k4SE9omtWG0eiWqQPEFEarMA3/0+sqGJR+WelYaCDndudO9wf9Qnll7perQ3o=
X-Received: by 2002:a05:651c:881:b0:2fb:6465:3183 with SMTP id
 38308e7fff4ca-2ff201e7398mr8693241fa.3.1731054577786; Fri, 08 Nov 2024
 00:29:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104093609.156059-1-andriy.shevchenko@linux.intel.com> <20241104093609.156059-7-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20241104093609.156059-7-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 8 Nov 2024 09:29:26 +0100
Message-ID: <CACRpkdY9VMRQftH_eqxikpKSh+a7yFKsHa9fANZUkZx6Md3vpw@mail.gmail.com>
Subject: Re: [PATCH v1 6/6] gpio: Get rid of GPIOF_ACTIVE_LOW
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Tony Lindgren <tony@atomide.com>, Lee Jones <lee@kernel.org>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Pavel Machek <pavel@ucw.cz>, 
	Dominik Brodowski <linux@dominikbrodowski.net>, Daniel Mack <daniel@zonque.org>, 
	Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 10:36=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> No more users.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

If the series flies, by all means:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks for working on this!

Yours,
Linus Walleij

