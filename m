Return-Path: <linux-kernel+bounces-380750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9979AF587
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 00:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9224C282E72
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 22:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD262185BC;
	Thu, 24 Oct 2024 22:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vVWYG4YR"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904C122B641
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 22:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729809694; cv=none; b=IJoIPcIXvEFpjbjwkdCU551hX0o/7SYUbN5PxZHnUfKOWSu8v6VL9HXPsQSzf7MmGfl6cb5vuhW3rVrkin+eCyP6Yp/XVmjpIpM5t/7ZQ9vOqLQRgqCPwV31fHbRJmk30gvtxafnOdWUvZrmX/3V66Lgtaa5ob0lHZEXaWaDTjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729809694; c=relaxed/simple;
	bh=Jl12nz369VYuGP1luOWuXZxpYCLrPVDlDRhUE4vjT+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gBMrgaV+HZaWpyLN+gZr6vNMTf4SVoiYaKIIEfOTzCFl0W8jYZ1dFCYtKxdMzvILMwWa2SZALHENDYFwtoWFPxYLvN04pBPXkM/4ZLYynBwPufhNT1GmTnpXjHwTnHZSpEcDnZEkWoxcfEsyPirA5etL+isfhmrnPodba/rR8ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vVWYG4YR; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9a2209bd7fso178595666b.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 15:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729809691; x=1730414491; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Yt5Cgkc4G7tTz07LApg3hXjFp6M5pGm/7kpNHdbJzI=;
        b=vVWYG4YRbkDCc6Z9p52/mF8HO2ritPwBzzGI+qrS9gzbmaPtz8+BBKWcMuqWjCyo5D
         niJTQekyhxm0eAS1+LcYLVJZdmGuZ1//9vwC1/YjHMqxb4BYKJ4cLT8C8ycgqGNA58fv
         KFtu2nu9KKrUBhZStuOuGqRKHHwWAiAgxNOSYIsM4nN2EzX8OkqczlnIHX3afQUmMl38
         2TAHt75kReFef4NVB0fOS11I6ndxaj7LsjP/spa5RZP9LuHVjPWQCmzjiY8+zMeTFRQ4
         OM5meYgpRk+KlFWtzbm21ddjll3cIH3Q0lPSaF+qho2xRBiHqCPbTDb4zSe5EVtVJnKV
         uPvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729809691; x=1730414491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Yt5Cgkc4G7tTz07LApg3hXjFp6M5pGm/7kpNHdbJzI=;
        b=MpLQpQvJyPgjMxAXwk5dQvRAqaGVK7siQ3X8MYoj1BF+iCY/gPmZC/KzwAZvB4R75I
         MxuNzYGQT/dVcagcTipTN+Xbe4guPSt9U8OtL7GOsyTgVaSl4ji5WM96lZkL9PIhNv5R
         /yyIo5KYwuMpL7K05KfyR6J80HWrBOTuxi9ZMHEtl+WIl3Yz4KOfSva2OWqDPnW7+3D9
         VUZBJ3I2NrpS1x+o/2+z4zqEolLtRVRB/Ym8MbUJjhBjPeGHXcvKNv9ibBEfvAXjAzKT
         fguktVxyFWD348FOulUqbqyViuJBEEvG+H478bRNsvRB20m2Myy22FkhsrDJLgQ8+XRB
         Iztw==
X-Forwarded-Encrypted: i=1; AJvYcCV9kwM0xjiTgg3MKWiGWU0WqqBNSxODp267Da6XibM4uKPowuDk+ScJZLDXrJaaxRbra+ogJ8fOvzrjO/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YybPh02vQQErjz/PSjaCDBMO8cQ3uCsoKqZf7ULpVXYjRjTa/0g
	xQequi2VPRcZ1tehTXKpSdZYpL9BUswPlZ3fh9KOIfH32txkuQPqfq2NFqhBh+Ucaz6VOz4E+OH
	zG8BdT2R/W2b+YU2DyT4m2mLep/Gyjy+ZkwE=
X-Google-Smtp-Source: AGHT+IEMUoIBtLKwgTVwxkC0PUhRKX+6wO7n6u1dbecUrsdWz5Dsy9p2MJfLwx1u4mMOKUMKDFSBgbFY8/9/OaDyPps=
X-Received: by 2002:a17:906:d552:b0:a9a:c651:e7d9 with SMTP id
 a640c23a62f3a-a9ad2815503mr269633866b.46.1729809690489; Thu, 24 Oct 2024
 15:41:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-0-554456a44a15@linutronix.de>
 <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-25-554456a44a15@linutronix.de>
In-Reply-To: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-25-554456a44a15@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Thu, 24 Oct 2024 15:41:19 -0700
Message-ID: <CANDhNCpFFRoj6O_0WP0yZt-A+hk7QAkQXjd9ekxvsgUT+yYXiQ@mail.gmail.com>
Subject: Re: [PATCH v2 25/25] timekeeping: Merge timekeeping_update_staged()
 and timekeeping_update()
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
> timekeeping_update_staged() is the only call site of timekeeping_update()=
.
>
> Merge those functions. No functional change.
>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> ---
>  kernel/time/timekeeping.c | 31 ++++++++++++++-----------------
>  1 file changed, 14 insertions(+), 17 deletions(-)
>
> diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
> index 67d7be2e02fb..d07eb1946ff1 100644
> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c
> @@ -529,7 +529,7 @@ EXPORT_SYMBOL_GPL(ktime_get_raw_fast_ns);
>   *    timekeeping_inject_sleeptime64()
>   *    __timekeeping_inject_sleeptime(tk, delta);
>   *                                                 timestamp();
> - *    timekeeping_update(tkd, tk, TK_CLEAR_NTP...);
> + *    timekeeping_update_staged(tkd, TK_CLEAR_NTP...);
>   *
>   * (2) On 32-bit systems, the 64-bit boot offset (tk->offs_boot) may be
>   * partially updated.  Since the tk->offs_boot update is a rare event, t=
his
> @@ -775,10 +775,21 @@ static void timekeeping_restore_shadow(struct tk_da=
ta *tkd)
>         memcpy(&tkd->shadow_timekeeper, &tkd->timekeeper, sizeof(tkd->tim=
ekeeper));
>  }
>
> -static void timekeeping_update(struct tk_data *tkd, struct timekeeper *t=
k, unsigned int action)
> +static void timekeeping_update_staged(struct tk_data *tkd, unsigned int =
action)

I still think timekeeping_update_from_shadow would be a better name.

>  {
> +       struct timekeeper *tk =3D &tk_core.shadow_timekeeper;
> +

Same naming nit, as its easy to mix up what tk is modifying.

Other than those,
Acked-by: John Stultz <jstultz@google.com>

Thanks so much for these really nice cleanups! They are a great
improvement to the code!
And again, my apologies for jumping off to other things midway through
reviewing these and not getting back to them until now.

thanks
-john

