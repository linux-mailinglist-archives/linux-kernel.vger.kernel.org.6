Return-Path: <linux-kernel+bounces-351741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA57991589
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 11:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 309C61C21BA9
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 09:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59CC13DBBC;
	Sat,  5 Oct 2024 09:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Kri4+aiu"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86181535D8
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 09:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728121369; cv=none; b=uoneRlBhYZuQSy3kgsHXIXB5QQUM5d26TU5RtUzsI8zbh0u1/Ziop9wHDzt6Yuam9ZXDos/m03RNdTLknRwDTtk8qWNj4bw5x9Hp/ylhWnimKrJRX8+mw7nYLVBDUEQDGg9jrzsi5XnI5ai1Xch7PZIv8BBnJHkolvBc5Xzx6iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728121369; c=relaxed/simple;
	bh=NxrvFyuntEQwVjBBRVYeWExPk+obOMBT7dJskXKuJkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LQb/kPRMpgBjcOz+Zm9jr1x4Yhqr6wiAw1bv90gJng148zS5NL257P1lRPAC9enaaJDpI51EYVSSCunkPSfEzfQMxAMvd89ZPk2NSfVp3qK3YzRZjSWmWwYFnHnX7fba49E53VTU73eDmk7FNiTCEk3BO4BdH36UocUciXl7RZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Kri4+aiu; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2fad6de2590so45422361fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2024 02:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728121366; x=1728726166; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NxrvFyuntEQwVjBBRVYeWExPk+obOMBT7dJskXKuJkA=;
        b=Kri4+aiuFy+AqdMtZ6QAvn4oftOXv7adg27pw6UfpstRaYCFw7u7jDQIC9encoxScZ
         V6b702pVHT5RDDA04htarWyKwLpiq8lQHfqLIXBp8fZDLGTcuhZVAhIPNc0Z7Mqefa38
         ByanMSyjR9MoXRaT/vz4TafsALX6ZFHULGWBV0nd7+FvII+3JhVW1JWr+Y7mkF9Td1nH
         e2fLas5jnWjk4WuX5yDWYIqJmY3w3RZ6Hn6YthiD2df9jfqFmz4dwDqZXNfoFWgxT+OV
         0cj6NynDI4S4j31J6omiQP+ko3w1EO8fUqVseBvjp28EeiyWwShp/MyGph1jfSVOCXeP
         XeRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728121366; x=1728726166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NxrvFyuntEQwVjBBRVYeWExPk+obOMBT7dJskXKuJkA=;
        b=QPgvyeO+u1ToQNiRU108bnTi3WwiXp4e23avtPu/Q85DXMRqkthg+ozwQSS9CdxI7C
         sTh276xIWQyv4wWxvV/bmIsOAFpBEUL0wxLJaBFWATComtkQY/I0NHWxJxveLwRQ5PKA
         520yAAOtcn2YM52p55aIm7dUjBTDkhfa92GDs0tTqSoHL56JFZ8Gt7tsLy5B9BK1bale
         txSOReHs+I1Cju9kraNQk2RV1I2KURTfMiaAV4Y52KI18VsalFQ11UYKKhkL7eESVgmz
         t+zF6PpNSYt+oHbD6GkmWiKi5y4IHlOF5j/NLwyzUGBjq3irHpGKRsHHX46U6BNtvW7b
         7TcA==
X-Forwarded-Encrypted: i=1; AJvYcCUB4sJiuqjz5zVMa4GcBgVU9j4hVEG0Xxa0VrNmxkfjQ+0PHmJtRYNgNCSacquqn8w04Ff/LQeagO5K/4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSmekEz+22gObEhnGCKk5n3bYNocsN9SaGnV3I84BRqZrKlbXZ
	6v4zX3P45+9AvTasmmO0BAgxoddgz8Uk0wipZ1Q1hQNxULJKV2fE7sPpMcRASWqCd99/gSt3pmj
	OlWxL/O1oy2Yfn/+tkgT94oT7MIbJJrbBc1VC7w==
X-Google-Smtp-Source: AGHT+IHqOkRT1D3WHmPBicr1AJ+KDadiuZ8Lj75qlKYE2wf7re1jzBwT55ej67fmWxKCNSwSrbv53GLaYPmkgUnpRkg=
X-Received: by 2002:a2e:878a:0:b0:2f7:5a41:b0b with SMTP id
 38308e7fff4ca-2faf3c44dc5mr36096921fa.26.1728121365551; Sat, 05 Oct 2024
 02:42:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004-gpio-notify-in-kernel-events-v1-0-8ac29e1df4fe@linaro.org>
 <20241004-gpio-notify-in-kernel-events-v1-5-8ac29e1df4fe@linaro.org> <20241005074635.GA174602@rigel>
In-Reply-To: <20241005074635.GA174602@rigel>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Sat, 5 Oct 2024 11:42:34 +0200
Message-ID: <CAMRc=MdU5+AC4PyPjuXuG_S7R59OJ-DaaCdX2fZfoCcs5BveJg@mail.gmail.com>
Subject: Re: [PATCH 5/5] gpiolib: notify user-space about in-kernel line state changes
To: Kent Gibson <warthog618@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 5, 2024 at 9:46=E2=80=AFAM Kent Gibson <warthog618@gmail.com> w=
rote:
>
> On Fri, Oct 04, 2024 at 04:43:26PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > There is a problem with gpiod_direction_output/input(), namely the fact
> > that they can be called both from sleeping as well as atomic context. W=
e
> > cannot call the blocking notifier from atomic and we cannot switch to
> > atomic notifier because the pinctrl functions we call higher up the sta=
ck
> > take a mutex. Let's instead use a workqueue and schedule a task to emit
> > the event from process context on the unbound system queue for minimal
> > latencies.
> >
>
> So now there is a race between the state of the desc changing and the
> notified reading it?
>

Theoretically? Well, yes... In practice I don't think this would
matter. But I understand the concern and won't insist if it's a
deal-breaker for you.

Ideally we'd switch to an atomic notifier but I don't have a good idea
on how to handle pinctrl_gpio_can_use_line(). It digs deep into the
pinctrl code and it's all synchronized with a mutex. Unlike GPIO, it
doesn't make any sense to spend days converting pinctrl to SRCU for a
single corner-case.

I wanted to use in_atomic() to determine whether we can emit the event
immediately or (if we're in interrupt or with a spinlock taken) we
should use a workqueue as a fallback but checkpatch.pl is very adamant
about it being an error (in capital reds).

Bart

