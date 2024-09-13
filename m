Return-Path: <linux-kernel+bounces-328994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52083978BD3
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 01:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FAB2B2275F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 23:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93EC3185B47;
	Fri, 13 Sep 2024 23:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HLuctxIP"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA2B18732E
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 23:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726269684; cv=none; b=IxrUpKdbPCiKFk2ExbXkTbp9OyuxcD3byjq0ON4moP2BYrGnOd4J7tc6Sa3bfqmRQgI6Qww/u9zjBD29riou/467azJX82vvjlvukqlhrfQn93DG2e9MAu09rPH+FTepOkTzCD8s1HByoDcQAzrStSp0bIu+53AaXQzXxBSewFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726269684; c=relaxed/simple;
	bh=fXShCPOpZz52eO91jyJt6+04d4urWyr5XmecZWpUQZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sNA149BVnMok7e+i4mYDw2ta3fmv9woNSiegAfNq7SHkHW44g0gNts1daf6oNPnF7wC0MekQPUZjYxB7AaDSMrXcQakjVbCwv3VsohnVDkzaI+6GW35aLE0GEunFdH7C3o+1uXlSQ5m/pXA63e/ec3v29jMzK0h0jVTrs7K7kOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HLuctxIP; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c241feb80dso7125983a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 16:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726269680; x=1726874480; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5gHrUsCpR6q/vcDy94msssmKj/tbR9miRFAu8ZGicdg=;
        b=HLuctxIPn+x+eirrotxm4vGfMlKKAGm1I6loe3AKuWoto4gylEdR3R2jA+vAG9BGIK
         w1cWEnHGrduJC0ZdKxeERNndQV7m3G8prVz0RVkXGhFGRek2nW7JN+Zhfj4IBuSQCGxr
         QXMNeWvzqTLvuJ+APbhlw9DacFGL9eQePL7rRh2R08NCJzP1S6uq5/BYra+vVRhwDZVZ
         GiTQC+fpl6nqY14umx9L2+7w07ESmW0w0Y/m9CZGDzjVBqKkZ17DY5oJgcO5WTFO7ao3
         hKNwSoMUCHKmJzhuqX2FNFTZD7yB0suYMGCrsMXX9UL/wjc1fGTeSFa0yWO1YoW57INH
         u/3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726269680; x=1726874480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5gHrUsCpR6q/vcDy94msssmKj/tbR9miRFAu8ZGicdg=;
        b=lVQP4TXt6orsKQLb44UT79yFxZfxeQ7W+Ugk+lrm72w+u8qC6p7t0/pHuuixFehQ3q
         b2fi+/1GV+rU7w32COOThl2u3tFBBVMvVrMvqUPAXQUKmOv+aeSQmpznpc01DL3nS5N5
         c4iAcHymNvWuSuzHSag8UPRte1FIrMRIuN79HdRkMuzcWoPapCIB5ub797iJ8ia8/4Zv
         OksyQBRVTCW5d9ieQBVTIumct4xmqkpzzTN7j6YNhGDfIbNE4/sf7Ih9tCwUlKypBN32
         81G6K/PxzM8bR/h/N7t0gLjLlTJW1X61VPrp1p3LfdpfJestQXgo6w52Ji6RUbY65qjk
         xYmQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1x9+1vSlmR48lPmRBzkQdLOod5+NWfMxWdsnNlLH6jZKmx3sPu+Nvz1hNWHd64JfPxiQUk0QmUxDOyeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcY1+utWCsdh0yUW60PMctbHeWysDsncLQd+52yWu/aO95c0m+
	cc2f+n83AR5tzSdWIhTPHmyZyH9NJHuANsEtxOe+2llxCrHYxKVG/8x1LCOPFV0Ddxrly8Gf/l5
	NErdXTvzZOOaHUYqeGhZAEiTlih7b3MJ3A4Y=
X-Google-Smtp-Source: AGHT+IGvxiSn6JWS9N9/EAoj59xcTC5zKLV9vZxugR8jrHol8xrwnt7BBpr6nBUOCxwG9AGyWxa1x9nBJUY4B0O9e8k=
X-Received: by 2002:a17:907:1c22:b0:a80:9c1b:554f with SMTP id
 a640c23a62f3a-a902a8c3963mr879630266b.27.1726269678841; Fri, 13 Sep 2024
 16:21:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911093029.3279154-1-vdonnefort@google.com> <20240911093029.3279154-10-vdonnefort@google.com>
In-Reply-To: <20240911093029.3279154-10-vdonnefort@google.com>
From: John Stultz <jstultz@google.com>
Date: Fri, 13 Sep 2024 16:21:05 -0700
Message-ID: <CANDhNCqvwn7W8JgdzY=2PrEk0unm3E0Kso7h2CCZBPO+hzLaOw@mail.gmail.com>
Subject: Re: [PATCH 09/13] KVM: arm64: Add clock for hyp tracefs
To: Vincent Donnefort <vdonnefort@google.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	kvmarm@lists.linux.dev, will@kernel.org, qperret@google.com, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
	"Christopher S. Hall" <christopher.s.hall@intel.com>, Richard Cochran <richardcochran@gmail.com>, 
	Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 2:31=E2=80=AFAM Vincent Donnefort <vdonnefort@googl=
e.com> wrote:
>
> Configure the hypervisor tracing clock before starting tracing. For
> tracing purpose, the boot clock is interesting as it doesn't stop on
> suspend. However, it is corrected on a regular basis, which implies we
> need to re-evaluate it every once in a while.
>
> Cc: John Stultz <jstultz@google.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Christopher S. Hall <christopher.s.hall@intel.com>
> Cc: Richard Cochran <richardcochran@gmail.com>
> Cc: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
>
...
> +static void __hyp_clock_work(struct work_struct *work)
> +{
> +       struct delayed_work *dwork =3D to_delayed_work(work);
> +       struct hyp_trace_buffer *hyp_buffer;
> +       struct hyp_trace_clock *hyp_clock;
> +       struct system_time_snapshot snap;
> +       u64 rate, delta_cycles;
> +       u64 boot, delta_boot;
> +       u64 err =3D 0;
> +
> +       hyp_clock =3D container_of(dwork, struct hyp_trace_clock, work);
> +       hyp_buffer =3D container_of(hyp_clock, struct hyp_trace_buffer, c=
lock);
> +
> +       ktime_get_snapshot(&snap);
> +       boot =3D ktime_to_ns(snap.boot);
> +
> +       delta_boot =3D boot - hyp_clock->boot;
> +       delta_cycles =3D snap.cycles - hyp_clock->cycles;
> +
> +       /* Compare hyp clock with the kernel boot clock */
> +       if (hyp_clock->mult) {
> +               u64 cur =3D delta_cycles;
> +
> +               cur *=3D hyp_clock->mult;

Mult overflow protection (I see you already have a max_delta value) is
probably needed here.

> +               cur >>=3D hyp_clock->shift;
> +               cur +=3D hyp_clock->boot;
> +
> +               err =3D abs_diff(cur, boot);
> +
> +               /* No deviation, only update epoch if necessary */
> +               if (!err) {
> +                       if (delta_cycles >=3D hyp_clock->max_delta)
> +                               goto update_hyp;
> +
> +                       goto resched;
> +               }
> +
> +               /* Warn if the error is above tracing precision (1us) */
> +               if (hyp_buffer->tracing_on && err > NSEC_PER_USEC)
> +                       pr_warn_ratelimited("hyp trace clock off by %lluu=
s\n",
> +                                           err / NSEC_PER_USEC);

I'm curious in practice, does this come up often? If so, does it
converge down nicely? Have you done much disruption testing using
adjtimex?

> +       }
> +
> +       if (delta_boot > U32_MAX) {
> +               do_div(delta_boot, NSEC_PER_SEC);
> +               rate =3D delta_cycles;
> +       } else {
> +               rate =3D delta_cycles * NSEC_PER_SEC;
> +       }
> +
> +       do_div(rate, delta_boot);
> +
> +       clocks_calc_mult_shift(&hyp_clock->mult, &hyp_clock->shift,
> +                              rate, NSEC_PER_SEC, CLOCK_MAX_CONVERSION_S=
);
> +
> +update_hyp:
> +       hyp_clock->max_delta =3D (U64_MAX / hyp_clock->mult) >> 1;
> +       hyp_clock->cycles =3D snap.cycles;
> +       hyp_clock->boot =3D boot;
> +       kvm_call_hyp_nvhe(__pkvm_update_clock_tracing, hyp_clock->mult,
> +                         hyp_clock->shift, hyp_clock->boot, hyp_clock->c=
ycles);
> +       complete(&hyp_clock->ready);

I'm very forgetful, so maybe it's unnecessary, but for future-you or
just other's like me, it might be worth adding some extra comments to
clarify the assumptions in these calculations.


thanks
-john

