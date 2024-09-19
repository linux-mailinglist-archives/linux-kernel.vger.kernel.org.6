Return-Path: <linux-kernel+bounces-333541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0AD997CA85
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 15:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5DC02861CC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 13:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6C019EED7;
	Thu, 19 Sep 2024 13:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Z/J+RY3q"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502DE1DFF0
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 13:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726754038; cv=none; b=XhGyNWYHtLYpgv3TWUidzY0qV4taQZ5+JCx3gzmJImyFZj7re+ZDQKypLEWK/PqR17WZgnBws9yrz8evkdBZRYOcHxW6qKLxDoJjVj4WMR/YElgBx5C0IQ70cF5t0ytLz+xGGtMOaSxQ6ZvQw9/BOjtKgUS4/Vm43au1Dc1xGoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726754038; c=relaxed/simple;
	bh=7gEmw2y9ALNc1z4q3KCruNUPoOfopCSe5Hleoao9w04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ttoZGuLg4FYYVsQMFw+FWY5UcV9oPYjKs3UDOCO9SsY5QEM2sE5fFlZTAe5kWADnGvw2X0nEiXGVvuSoTuLGdnoRNCy1FzcLugWEDU4tUaMAPsATF+sSEZQR1fjlAChmK72e3wiQDDy0jxpJ9RinfAlLGG6eh3fovb67r8nSKbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Z/J+RY3q; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2f754d4a6e4so9600561fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 06:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1726754035; x=1727358835; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lZ7C+kdc8awhvK8nyEsAW9cEkfOev2bLaZCfNgaDnt4=;
        b=Z/J+RY3qEP8K7+WrBgOGNymFoomS3N4grtpq1VVI+Mh48w8rzlGwInA+KJcREtsjFT
         Kq7UE6BWl07MQoRKB6mxLxrSDFf+Tn5EtzHRQsUqkNj/Bx0hajUP66Y8+pv2lt3PSPMS
         SYXRn9VLzcn2YeuQeD9GYr8ttS14NW+jAcCxK8KMYLkh/a5LZMyMpHK8rDhSLO/DZpXI
         Q9KHxvF1Xw9QWneTZ5s224FTobdIvFVLObJPL0xs2vplPdS2ZrxgU4xiWiJzCPxCkZX6
         Yub+WhOONh99eONV04R0iaYIiJDsHmY8RTjFBugPpNnmL3ebd8FHjms5dK9T5p2tJQ4P
         9P3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726754035; x=1727358835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lZ7C+kdc8awhvK8nyEsAW9cEkfOev2bLaZCfNgaDnt4=;
        b=Wxh2CUDMBzO1KVLUSBbgLd5wPLOpgV9LF92fN93tTpnrJOjyeG5KV59BL8Zx6xL8Fb
         H34XIHFlBZHE8NFf9t0zyOpMJPGKMXb1jFe7b0aXA2AmT1Rt78dT3xny9+M/iFetLl67
         zIYRurSk2U2nQ31ej2VxRvZnc2Fo7d1lGnqDuEhgegkd46tnUH7Qk3F0e+eUzHsuBW1J
         yaujACR/2BMyaER49M5xmBYe+JXVqVaq7v+v7rc4Qq6K4pqGViiZeRX5lbhcX2BeS2Ao
         Lje+yGpNLkeO0Btqlfy9sXZv9YxBhKWUozjpTlVw3R4oe8zWYJSAR/s7LJlGZXnQ+W6a
         0gXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLEifMopLJKQ6DZxT5i/n9yZdKMfdL91GsERQqdPH72iI6hvSXQpaOHiXW/TnTBj711jHknMsGpH4Xt7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRHhW3BeV3vaW8a2aoprtgyOQCBKlpXEH2Kr5q2Bsp7xxiRWVn
	pa+61JORdDBkYHbQ3/OJKipglKp5KruSKV5KJMV1qOMQzwuL0oTsFbVkxtxTgHYB6kPP8Txt3SZ
	1oGOsAZITCRllLCOOYv51ehtw+JMNOhY1RSBZFXbIhMnJqwr48TVlIg==
X-Google-Smtp-Source: AGHT+IEAqPvenK1Z5TacImTAUNgsMUVHe3xRbK2jF1vErNhwsnJosPXPzIqcaRnxUXR9nRojEUUj8o4NpdSjKFv5AFg=
X-Received: by 2002:a2e:be86:0:b0:2f5:2e2:eafb with SMTP id
 38308e7fff4ca-2f787dad3c6mr152309911fa.7.1726754035268; Thu, 19 Sep 2024
 06:53:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240919111324.10117-1-brgl@bgdev.pl>
In-Reply-To: <20240919111324.10117-1-brgl@bgdev.pl>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 19 Sep 2024 15:53:43 +0200
Message-ID: <CAMRc=McyND+2SN_uNJMiveCPm7RJxF3V55GU2NLhkydoG9m0Hw@mail.gmail.com>
Subject: Re: [PATCH] gpio: free irqs that are still requested when the chip is
 being removed
To: Herve Codina <herve.codina@bootlin.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 19, 2024 at 1:13=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> If we remove a GPIO chip that is also an interrupt controller with users
> not having freed some interrupts, we'll end up leaking resources as
> indicated by the following warning:
>
>   remove_proc_entry: removing non-empty directory 'irq/30', leaking at le=
ast 'gpio'
>
> As there's no way of notifying interrupt users about the irqchip going
> away and the interrupt subsystem is not plugged into the driver model and
> so not all cases can be handled by devlinks, we need to make sure to free
> all interrupts before the complete the removal of the provider.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
> Herve: if I say I'll do something, then I'll do it, no need to remind me =
every
> six months. :) Anyway, this is a proposition of fixing the resource leak =
you
> reported with gpiomon in a more generic way so we also address the same i=
ssue
> for in-kernel users.
>

I noticed a problem here so I sent an improved version[1].

Bart

[1] https://lore.kernel.org/linux-gpio/20240919135104.3583-1-brgl@bgdev.pl/

