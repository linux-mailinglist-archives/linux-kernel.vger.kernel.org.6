Return-Path: <linux-kernel+bounces-380712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 489AC9AF4D9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 23:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA0C91F22A2E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 21:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368FA2178F1;
	Thu, 24 Oct 2024 21:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YrwhWteU"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EA81C7281
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 21:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729806897; cv=none; b=i6sOB8W2DeJ5bBxSG8UzBYRUGvwlaV1FaWlYWZxHk8lkWfEXvcEkGrwd4ykWUVUS21KfAWljuw4m62KTzf3sU84/f3Ronx0HDC/pQVNpYmcg64hXbcmDOfc5ZUNdA1JHDaY75RuHSXtEDDEYcOrf80ZFFLkQw/ILSVyy20aet2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729806897; c=relaxed/simple;
	bh=5UbODAlsq4Ad6QPz37YHAcHZB3oToSQdAEz+iE+GGS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jkrTFJIuJc7Nqo99n/JMUzSI1Xa4niy9j9vIUtwwrFnajEKYVke8UApCOuV0W1eQmdMO4PmUzrW7NZtm5GmaUX8iio/LSv2ujhVE19nG+BWeqvK2JuxiRx8cuaoQqpRS+eF/SgFXErw7yKXmqJC8jyym1BulGLMkXgBuhdH6Oac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YrwhWteU; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a9a0ec0a94fso185458566b.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 14:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729806892; x=1730411692; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WGWC+dNwv8ydzuQXg+CSwKCjsUbZv8vbUjXJY+36+fM=;
        b=YrwhWteUKJFNYNH4aXXdb9siSZIWrFZeUKT3qfY8S4Q/2RJFh75YC7OMgUWBcPFD9Q
         XlOHcwgHiQcEEy1ry86rKhxTUhCqPGQhfHfiZlfkZhlokR+4FbSt3APSTguD88i8oynP
         IfheqvtNqUSGWphnkZTsKCfR4CkqEwIQA0FQsxqD14Uc1BA2xPcTHaXrCuLV7ImikwI5
         pousUY9t/lCZa/PsihsGg4KYV7dDUXVZw+HHveZKR3v1gY2s3/VuWtOgz6aznA0AZbyQ
         BTihIaeNwsO/OnlC1tMqnsp72lY6J1abiuMsRQ8SMYYVsTjnohxnAKUfIBzG/YAX4srY
         eLSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729806892; x=1730411692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WGWC+dNwv8ydzuQXg+CSwKCjsUbZv8vbUjXJY+36+fM=;
        b=fgyrzbOaXmb02zmKZGP96PnmAznZTkrZm1p0xvDocYLi6a50BIBAXZuGmmp8NRk/Af
         khH17tGan2vokxhzumWPAndbKrlFSTqOwew5cSv5JpBucilve6o7Q52nnKzGzEhkYNUd
         Isoo2LPLzAX9nC9PxrNJ/bwpAyVzfx68XdVVI6SgFwRh95q4PaMRxT0o3/khxaRk4B59
         psOjYEEsrNFh3vJzCTF5GsFEclWQTpPY7oGqLJ5NwE8gdgG4sVzxO77NLQ6+WJLe2mvl
         Ifr1H7jqftNsEA+cftlO9Z3kB/2kG/QZRP6jacQfbYfDyzHF5kUw6dk9zXZxRpyi8O39
         MOyA==
X-Forwarded-Encrypted: i=1; AJvYcCW1qFuGewi29TN3IEPoeIjLJEPhHj8rxYH2iFE9sUGUM2HwW1Zqpi05lpV3OMmwm7L78wQttWLVa88nYvU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZoomUzL4xbIoCX2XspWJJ1lumGqZXWCCAhYAioVgYSfDX1ZQ+
	y6Dp3Hmkyyxb3MdjEaMsU6Ku9e0RjIL1PpytbJHkIo0VAHbhlSVacHbduxEkSKkeHAWDzXF2DpN
	4o7Qy4/pbE2m07u9Tpcza8D0ikHYau11bii8=
X-Google-Smtp-Source: AGHT+IHFBGg0dPX+vpqNJloNmtfsV6w2Lu0DOBBFKrBsz1+6gRhdEHWEmClxnB+eaAbPZTlD2vB40oOgH6MOlsqqQL4=
X-Received: by 2002:a17:907:7f24:b0:a9a:1094:55de with SMTP id
 a640c23a62f3a-a9ad27127d2mr330538566b.13.1729806891967; Thu, 24 Oct 2024
 14:54:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-0-554456a44a15@linutronix.de>
 <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-16-554456a44a15@linutronix.de>
In-Reply-To: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-16-554456a44a15@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Thu, 24 Oct 2024 14:54:40 -0700
Message-ID: <CANDhNCoN4Xug6XKSF+-cuXxRUiLhJPrBjiCmFmsTxxknvwN7nQ@mail.gmail.com>
Subject: Re: [PATCH v2 16/25] timekeeping: Rework do_settimeofday64() to use shadow_timekeeper
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Miroslav Lichvar <mlichvar@redhat.com>, Richard Cochran <richardcochran@gmail.com>, 
	Christopher S Hall <christopher.s.hall@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 1:29=E2=80=AFAM Anna-Maria Behnsen
<anna-maria@linutronix.de> wrote:
>
> From: Anna-Maria Behnsen <anna-maria@linutronix.de>
>
> Updates of the timekeeper can be done by operating on the shadow timekeep=
er
> and afterwards copying the result into the real timekeeper. This has the
> advantage, that the sequence count write protected region is kept as smal=
l
> as possible.
>
> Convert do_settimeofday64() to use this scheme.
>
> That allows to use a scoped_guard() for locking the timekeeper lock as th=
e
> usage of the shadow timekeeper allows a rollback in the error case instea=
d
> of the full timekeeper update of the original code.
>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> ---
>  kernel/time/timekeeping.c | 42 ++++++++++++++++-------------------------=
-
>  1 file changed, 16 insertions(+), 26 deletions(-)
>
> diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
> index 41d88f645868..cc01ad53d96d 100644
> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c
> @@ -1479,45 +1479,35 @@ EXPORT_SYMBOL_GPL(timekeeping_clocksource_has_bas=
e);
>   */
>  int do_settimeofday64(const struct timespec64 *ts)
>  {
> -       struct timekeeper *tk =3D &tk_core.timekeeper;
>         struct timespec64 ts_delta, xt;
> -       unsigned long flags;
> -       int ret =3D 0;
>
>         if (!timespec64_valid_settod(ts))
>                 return -EINVAL;
>
> -       raw_spin_lock_irqsave(&tk_core.lock, flags);
> -       write_seqcount_begin(&tk_core.seq);
> -
> -       timekeeping_forward_now(tk);
> -
> -       xt =3D tk_xtime(tk);
> -       ts_delta =3D timespec64_sub(*ts, xt);
> +       scoped_guard (raw_spinlock_irqsave, &tk_core.lock) {
> +               struct timekeeper *tk =3D &tk_core.shadow_timekeeper;

nit: maybe shadow_tk instead, so it is additionally clear in the
following logic which is being modified.

Otherwise,
Acked-by: John Stultz <jstultz@google.com>

