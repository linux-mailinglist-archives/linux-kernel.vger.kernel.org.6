Return-Path: <linux-kernel+bounces-555873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF79A5BDB1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 11:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1D3C1899E34
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 10:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05EE522B8D9;
	Tue, 11 Mar 2025 10:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Lc8tyR3T"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D6622F3A8
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 10:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741688485; cv=none; b=p2Haz16TTokpQyc084e+PCIGNXqQMR72Z10xU0fz247AcgVi+2FNxDpIOH/Yx1KlYuGgTQZPpyvyib20B1IWlYTxRqS9crGbi7bMLI6f1Ix7peUm85dTwLVUsSOPCbaYzhDbovAJs0nNoStqv4ZTt/4qc4h3jZBcTIWL20n2IdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741688485; c=relaxed/simple;
	bh=qFuZvUC7TOqU9SduHNs/PMCAxK1aOpCzKeMcc0YihlM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EbsfeueS1lGrlgj2J65cCH7MyALiDv1/I4uCQk8x/8Uy89O827/idc9tWrPjJ2s7MSpjRx9G/V0MRHZUfMNuE6As9CNsP+A2NhEqh1ZqJe36L6xuVNBnR5LxfsCal0URFLE7NLoH6J5OZYsAuNfMTEyf2byUFbq8VJyNbKUxdQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Lc8tyR3T; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5498d2a8b89so5307278e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 03:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1741688482; x=1742293282; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=foWyTmy8PqiEjMoKnDTPdqja2PZrapAQLo9RLC3uipw=;
        b=Lc8tyR3Tt3KgPjatg6oAhFfx67vvKRMHmChjv5m3kyrZ7zOX8ZnrGAGcmLFQqO++Kx
         GDivUqWPsdnWgz+T0cbYiy8VYB3cjrECtB7YDH1oOkjeNrTJMSwrHrZ9YwDsROZiA2Ap
         rr+AA3zszR4DHFsLAxJg7KiZMFeAWn7bqPhI1Sc4wdon8sn6d4fSJjDk8D0ZsLFGo3Yj
         YLtq3jyCzIjeI0jmgTbnP+GiD91sMs/c9JT4jEdz4XGQgFl5iwE4jo+2uzq4iukEEsFA
         HhcvazwMibXZLA0LLh2ppoaHqZeFpYXpKZ4j3DKK2XQQ4dHNQja6YJtWFYr1oaYYaIup
         g2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741688482; x=1742293282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=foWyTmy8PqiEjMoKnDTPdqja2PZrapAQLo9RLC3uipw=;
        b=Q3/pBwcTIp+iKFFtlmiavuI3pTFmS37SJpQfqymWqaI8CDqrNjZPwZ74OYKfY4u2e/
         C6qALtgRWcHG9c9cOFx21q7L4QReFU1yLZkuZ/PFlGiqKyTUzAQsG1xGX+Gq1K2ur3dV
         7hkuxHzWsCJo03JOeiQK3Ac2OaZoBeoDPfsl2pu01l6BryBTdilbkVEX/xlkmBYv5XXK
         jTHeEqr+l7C2MIQR7azU/r3daCbUQ6fV+Vg48ZpzjwUXetZZxxRvg9YLCePNcEfrB2hC
         5KJcxxPCSdHgpijilwiYKjHiG+xJSHgaZfxqPBaR1yYQzUR85KROyjmrEQWaBIjf98iy
         f0/Q==
X-Forwarded-Encrypted: i=1; AJvYcCX8jZjXKiTvNwx0LtfxeLYYRFmL6mSbI3nyiWyHRxkb9UNSkatSjikFLN1UsDfugtXu4h6nojvZ/0qn3eY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRB/FvcQ8E9MNua/Lv/wcjlou2ybX97xuI2O7ymF2BZt8FdqEC
	ZSGDNqPIS0aGrGplwNgzO+BFixzlhvd4N6semDmKcl7cabbh2WMevuTLtZ7N/qe3nvQ30m7jT0m
	YboydGdqW1CtlRRlnDal8uyF9N2LoZ2y/p1RXGA==
X-Gm-Gg: ASbGncuYvqfXIAzEGxZcgKBP3HR3pcUkzNKxscp2JpjikC/KTIXRVJ2aMmd1ptrHr4Z
	SNiBzdaQIf6+S7+DyCAsQN0Rs31pk+GLl+Z6dloKCgctNOwx5LF4ecjEkl8Gm/kABhOFKpC5vUi
	4TzOvgmUdWOYIeYd0UBWX0s5kKUk4nb5OySRNIZoXlCDSXz3y4eiy89DKV
X-Google-Smtp-Source: AGHT+IGllA6yhtds8VMT2lHADXWnS0biqa6Ag9pw1v5+ViCqZafTFWoccQ/gu6d8kouYvytw814JiHgaPZHWxthinyQ=
X-Received: by 2002:a05:6512:ba6:b0:549:8f21:bc0e with SMTP id
 2adb3069b0e04-54990eb1987mr5783501e87.32.1741688481654; Tue, 11 Mar 2025
 03:21:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311110034.53959031@erd003.prtnl>
In-Reply-To: <20250311110034.53959031@erd003.prtnl>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 11 Mar 2025 11:21:10 +0100
X-Gm-Features: AQ5f1JrWVQASCgzejqti64i4A72raQlwhGXInyikYOegJnvRZTGZ_KLvydvK8SE
Message-ID: <CAMRc=MeWp=m1Bi_t_FCrxFOtiv3s8fSjiBjDk4pOB+_RuN=KGg@mail.gmail.com>
Subject: Re: regression: gpiolib: switch the line state notifier to atomic
 unexpected impact on performance
To: David Jander <david@protonic.nl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Kent Gibson <warthog618@gmail.com>, 
	Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 11:01=E2=80=AFAM David Jander <david@protonic.nl> w=
rote:
>
>
> Dear Bartosz,
>
> I noticed this because after updating the kernel from 6.11 to 6.14 a
> user-space application that uses GPIOs heavily started getting extremely =
slow,
> to the point that I will need to heavily modify this application in order=
 to
> be usable again.
> I traced the problem down to the following patch that went into 6.13:
>
> fcc8b637c542 gpiolib: switch the line state notifier to atomic
>
> What happens here, is that gpio_chrdev_release() now calls
> atomic_notifier_chain_unregister(), which uses RCU, and as such must call
> synchronize_rcu(). synchronize_rcu() waits for the RCU grace time to expi=
re
> before returning and according to the documentation can cause a delay of =
up to
> several milliseconds. In fact it seems to take between 8-10ms on my syste=
m (an
> STM32MP153C single-core Cortex-A7).
>
> This has the effect that the time it takes to call close() on a /dev/gpio=
chipX
> takes now ~10ms each time. If I git-revert this commit, close() will take=
 less
> than 1ms.
>

Thanks for the detailed report!

> 10ms doesn't sound like much, but it is more ~10x the time it tool before=
,
> and unfortunately libgpiod code calls this function very often in some pl=
aces,
> especially in find_line() if your board has many gpiochips (mine has 16
> chardevs).

Yeah, I imagine it can affect the speed of execution of gpiofind,
gpiodetect and any other program that iterates over all character
devices.

>
> The effect can easily be reproduced with the gpiofind tool:
>
> Running on kernel 6.12:
>
> $ time gpiofind LPOUT0
> gpiochip7 9
> real    0m 0.02s
> user    0m 0.00s
> sys     0m 0.01s
>
> Running on kernel 6.13:
>
> $ time gpiofind LPOUT0
> gpiochip7 9
> real    0m 0.19s
> user    0m 0.00s
> sys     0m 0.01s
>
> That is almost a 10x increase in execution time of the whole program!!
>
> On kernel 6.13, after git revert -n fcc8b637c542 time is back to what it =
was
> on 6.12.
>
> Unfortunately I can't come up with an easy solution to this problem, that=
's
> why I don't have a patch to propose. Sorry for that.
>
> I still think it is a bit alarming this change has such a huge impact. IM=
HO it
> really shouldn't. What can be done about this? Is it maybe possible to de=
fer
> unregistering and freeing to a kthread and return from the release functi=
on
> earlier?
>

This was my first idea too. Alternatively we can switch to using a raw
notifier and provide a spinlock ourselves.

Bartosz

