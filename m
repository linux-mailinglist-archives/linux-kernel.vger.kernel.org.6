Return-Path: <linux-kernel+bounces-171609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8AF78BE65E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B7D81F24DA1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 14:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C27747F;
	Tue,  7 May 2024 14:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="PCHoPc57"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CD22F50
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 14:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715093299; cv=none; b=D8KDTuEZvaLgOCceN1jUYETLLSYXjOKbWbLWBHWw29GMzUrptx6zfjKhRwaF6QYW+wCA9GIfooUKr4t8CaRW1Axp97Q41Kv9+EzOmpHhTcgaOlu2ZnRHbJS0GZXXg+Z0B5HA8wL1m+515J3qptQJ+XS7jPUHSSmV+ahe7wCfs7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715093299; c=relaxed/simple;
	bh=O9U7eifATy8AucP2fwKsqv2Qi7a/NxF2S8DlLhQxBOk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EomIPQ9YDNVdMdwmYVjE1cavpHoFlqydeKrFrAqAlsEYkuYYsXCzXRu13Ai2foJRjhptSXMnC/dwsJ3Tmb/s2OIre5o2FtlEJaLoD8YWDRE5zqwuBm2HRmTTzXHUUhs5qBKwy9SppcD7IlNhgagINJfUKRegjHTBa66IV9jV6DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=PCHoPc57; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2e43c481b53so1945381fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 07:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1715093296; x=1715698096; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6E2tOH2LZeelmKHGCVRYEwTjym6Omr1xato4eYpOm4E=;
        b=PCHoPc57NicYWeCbCLKQYtSzZ48TuQrqMCrl8LMUNj1+cWv5FFlocjDP5Ngpw3Xj6A
         /8O3ynUZRCUQnO7z8PJfGkD+AeDrPLCEzEk+AVONMHcEneXGaArld6X6WA3Ruc4aj1WE
         QfrZoxDS293sasejpLyGJFGL2JMNrQX12NRBu7NYcqFpg1z3v+qkf5VzNZksenEbbrbl
         mPBFHb0dDbkWG6ec0QgMx4EmflB1wo8dJhXIfllZD7DgxIXEY787uqhvgD0BCJ80uBTh
         5svbzqg8tseNOdKKzNBkyFi//p++C6BnsSiQOKXVWfpljM8AO/a7vaBdlSwR0wW1MIyX
         ttVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715093296; x=1715698096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6E2tOH2LZeelmKHGCVRYEwTjym6Omr1xato4eYpOm4E=;
        b=CJFhQ9Bww3DrmrcbKGApuXYVqsccMsADybCMMsJxyNRfBdaSLnrQPZfwdsE06SQno9
         Brog8yCXLt96LQ43VlIdZRuaLXKc1EgJVm+1bifqchKBYMlv15Y71z0QtumdV8TRDxgH
         daWHhQ7OlFyxzxGMILt39S6Hne0RyhxbJHfYBC7hLDE9aMX1d4ZCjKhvm8eV9UPkBQFj
         WL+EUV5udr5D0K082FWUiN57FK/FlPPrRBVIanaD56DP34etY3FiKmbAU8FwGW3Ocz0q
         nUj3askcKIrK2g8FsmEpk3K9nFOc2S1Aqyk2VBU99we/0DDz1UMo9+fxyuwlzjd/yL5S
         iYhw==
X-Forwarded-Encrypted: i=1; AJvYcCW0o0Fm9zZK+U1np3FvryEfQHwcqmZqVfMWsubGZp+5Yqk+gUb9Tte41xlcTrPYSFnDeBFzvJM1A3Y0L3Zeaw8h2nWcZflQj68sVZoV
X-Gm-Message-State: AOJu0YzovEiwaLhVV6gK/l1vkW56WdM/MdOF9Zm0im774USy22hzPdF8
	LbbA69ZmW3S4aXJ+IRhL+qylxFdvZwUU+R/rV1bjjyL5MUqfSXVLdkUclfbCf15zKXg2LikBFcb
	NZdEIiOx1vh9UI4c1lRNaf5I/rdTv8631fRL5sf/K2FKHGuqC
X-Google-Smtp-Source: AGHT+IEWf5bz0gIK/ChOYdDJ2AEL/N1lGY6OKBycVzHc97pVufGbuietFwGdydp8PqHnPhjEha+mXPz4acp5wASwKDE=
X-Received: by 2002:a2e:b0d5:0:b0:2e1:d94a:773f with SMTP id
 g21-20020a2eb0d5000000b002e1d94a773fmr8924737ljl.11.1715093295962; Tue, 07
 May 2024 07:48:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507121346.16969-1-brgl@bgdev.pl> <597f5da2-71be-4144-a570-fdc4f06c4cc6@paulmck-laptop>
In-Reply-To: <597f5da2-71be-4144-a570-fdc4f06c4cc6@paulmck-laptop>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 7 May 2024 16:48:04 +0200
Message-ID: <CAMRc=MexihBpLBcY-8aX06buUYmtE07ZpkMq0Ho3jrHb6VE7Sw@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: fix the speed of descriptor label setting with SRCU
To: paulmck@kernel.org
Cc: Kent Gibson <warthog618@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 4:24=E2=80=AFPM Paul E. McKenney <paulmck@kernel.org=
> wrote:
>
> On Tue, May 07, 2024 at 02:13:46PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Commit 1f2bcb8c8ccd ("gpio: protect the descriptor label with SRCU")
> > caused a massive drop in performance of requesting GPIO lines due to th=
e
> > call to synchronize_srcu() on each label change. Rework the code to not
> > wait until all read-only users are done with reading the label but
> > instead atomically replace the label pointer and schedule its release
> > after all read-only critical sections are done.
> >
> > To that end wrap the descriptor label in a struct that also contains th=
e
> > rcu_head struct required for deferring tasks using call_srcu() and stop
> > using kstrdup_const() as we're required to allocate memory anyway. Just
> > allocate enough for the label string and rcu_head in one go.
> >
> > Reported-by: Neil Armstrong <neil.armstrong@linaro.org>
> > Closes: https://lore.kernel.org/linux-gpio/CAMRc=3DMfig2oooDQYTqo23W3PX=
SdzhVO4p=3DG4+P8y1ppBOrkrJQ@mail.gmail.com/
> > Fixes: 1f2bcb8c8ccd ("gpio: protect the descriptor label with SRCU")
> > Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Looks good to me!
>
> Acked-by: Paul E. McKenney <paulmck@kernel.org>
>
> One semi-related question...  Why the per-descriptor srcu_struct?
>
> If the srcu_struct was shared among all of these, you could just do one
> synchronize_srcu() and one cleanup_srcu_struct() instead of needing to
> do one per gdev->desc[] entry.
>
> You might be able to go further and have one srcu_struct for all the
> gpio devices.
>
> Or did you guys run tests and find some performance problem with sharing
> srcu_struct structures?   (I wouldn't expect one, but sometimes the
> hardware has a better imagination than I do.)
>

I guess my goal was not to make synchronize_srcu() for descriptor X
wait for read-only operations on descriptor Y. But with that gone, I
suppose you're right, we can improve this patch further by switching
to a single SRCU descriptor.

I'll send a v2.

Bart

