Return-Path: <linux-kernel+bounces-380714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 681859AF4DE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 23:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB3DEB215E9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 21:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49BD9218335;
	Thu, 24 Oct 2024 21:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZROsey+s"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BD92170C5
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 21:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729807055; cv=none; b=d2txtv4+lec3BdKIhErfuT/xmCyX2hiYrAXR5hkyEzcJ7ISYQACRdEtg8Fy7vjrqBf7TJtiCD99fSiZrbGurm1RlwDmzRg4vdxoJB7zKZtUH7MxfkQt3Mn2fb7hdLEp7h9XlpMKJVh8R4Lg03bbw/nBks42FCZ0V70ZVqMhKN3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729807055; c=relaxed/simple;
	bh=oU+osqWD1T/M3fyItT5JIcN8z7hbeHiy8gijEE0LMVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZPMfHJgNlICnFvkoscD3fFyJcgecJzGqggmR4Xwk7ZAp5/161LfSuoJBGPodhbQe9rxXJnrfVhnCwiRbs6IAET6X04eVygBn5ZcTa+kfDbmO7XiV6EO1W6VoX9t2g2YR22zbQnrh427tn23zVqiWFo/6/DaPV/ROoghuplE/cig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZROsey+s; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9a6acac4c3so209180466b.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 14:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729807052; x=1730411852; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2XPtMimke7xlifXTS8YFtou/PQ3ismYYKccQSehKOLo=;
        b=ZROsey+siL+i1cr2uXw1zBSG8BSYbxZbAqJo7pmOWrs2k3ftQW3XwsKMxyRcNgS6TQ
         XfMpKW7K4wTohdUYU7XfsOZOQTFsX28a3K9NpJVkDVnmpMCTonlwaFBUqV16WMhYj+61
         sRwgBPXO5vjhMwKVGXsLOnfs/gl51dWdsvkS82TPTbV8g6tDcMoMbosQCJkAe5pHIxHU
         oMoXcJK0kqDvxEB9OYzJTnB/TrrvL2I8abMYnC2G7OUixhz51l5wkeGnbhVqBovUmEO7
         Z17eGknDIXUukhATvuxyjSVekAyG8rCG68rTqMqUoQqxfdynk2cSwW6u0GHtj3OMSkrv
         4wUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729807052; x=1730411852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2XPtMimke7xlifXTS8YFtou/PQ3ismYYKccQSehKOLo=;
        b=oMnraatdT7sX9+j1dQQ/qZOP0olZ3eAQqUh5pauQnyXt7byr0Jnt4s2l8FiA8YKOkY
         rUBF+N2nk+5z/mroWmNMo6Ed/vc/QDVQ5vDPnroX52i/7dXI4M/ixKpFaFJ7WcpZDeNe
         vwDUuC9ykC2scnFn6yw+IhLVGtuB1Cr/2ybWJLGQdi8UsNV0ITwsGocwB3iKHMqE7GIc
         fyw1qp6UO+36j92uj7FD+AasG4W5hB3KTR0gZxUEYZtJG47Vr/fPbFziRpwJ7RsYmttK
         xIuIPPGI4icSffemDG/5oWKWe8XK5glDt+kh5qHhIQ7KpK5lmt+1+G7BSBudlx+rS59f
         blNg==
X-Forwarded-Encrypted: i=1; AJvYcCW0cya7mNuf79JTwxT+He7OeycMAJVRcipNepdqxvOGaaf4nROCEkMJ/c3M1c4dIpZTBG8cFtKoPRPQHKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPYhrWQTJwbY/ERJCLcNl305a2Bz+dUzByANHugDmxnnhm9ds8
	zWAtIxoGGY33EjpE2V3cxKtN30XUV4NvGmUks/lO9J/v8qkmS49F1AeWa1opEayGtKSfGz7Hdll
	JTsg9WEeYDCECC3dyo2g9MYq4Ml5nUxKu4Zc=
X-Google-Smtp-Source: AGHT+IHfz0mDqH2DIIIAjuKf+Iqn9Q/PMAlfD1gYhYBDCjkGU+5Zep1mNn/Drpmcn4kdvwj318Aa+nRFz6XTkEdPrA4=
X-Received: by 2002:a17:907:9484:b0:a9a:1565:1051 with SMTP id
 a640c23a62f3a-a9ad27127c7mr311137966b.10.1729807051416; Thu, 24 Oct 2024
 14:57:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-0-554456a44a15@linutronix.de>
 <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-17-554456a44a15@linutronix.de>
In-Reply-To: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-17-554456a44a15@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Thu, 24 Oct 2024 14:57:20 -0700
Message-ID: <CANDhNCrwaJZr4XyqSAaWMgY98NkPnjKGoeZxaBMY5Z-dP6rf=Q@mail.gmail.com>
Subject: Re: [PATCH v2 17/25] timekeeping: Rework timekeeping_inject_offset()
 to use shadow_timekeeper
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
> Convert timekeeping_inject_offset() to use this scheme.
>
> That allows to use a scoped_guard() for locking the timekeeper lock as th=
e
> usage of the shadow timekeeper allows a rollback in the error case instea=
d
> of the full timekeeper update of the original code.
>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> ---
>  kernel/time/timekeeping.c | 41 ++++++++++++++++-------------------------
>  1 file changed, 16 insertions(+), 25 deletions(-)
>
> diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
> index cc01ad53d96d..051041e92e54 100644
> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c
> @@ -1519,40 +1519,31 @@ EXPORT_SYMBOL(do_settimeofday64);
>   */
>  static int timekeeping_inject_offset(const struct timespec64 *ts)
>  {
> -       struct timekeeper *tk =3D &tk_core.timekeeper;
> -       unsigned long flags;
> -       struct timespec64 tmp;
> -       int ret =3D 0;
> -
>         if (ts->tv_nsec < 0 || ts->tv_nsec >=3D NSEC_PER_SEC)
>                 return -EINVAL;
>
> -       raw_spin_lock_irqsave(&tk_core.lock, flags);
> -       write_seqcount_begin(&tk_core.seq);
> -
> -       timekeeping_forward_now(tk);
> -
> -       /* Make sure the proposed value is valid */
> -       tmp =3D timespec64_add(tk_xtime(tk), *ts);
> -       if (timespec64_compare(&tk->wall_to_monotonic, ts) > 0 ||
> -           !timespec64_valid_settod(&tmp)) {
> -               ret =3D -EINVAL;
> -               goto error;
> -       }
> +       scoped_guard (raw_spinlock_irqsave, &tk_core.lock) {
> +               struct timekeeper *tk =3D &tk_core.shadow_timekeeper;

Nit: Same suggestion of naming this tk_shadow for added clarity.

Otherwise,
Acked-by: John Stultz <jstultz@google.com>

