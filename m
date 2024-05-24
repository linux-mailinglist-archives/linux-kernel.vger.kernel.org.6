Return-Path: <linux-kernel+bounces-189174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C2D8CEC78
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 00:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 082B41C20B57
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 22:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D829128385;
	Fri, 24 May 2024 22:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="SiVdYy9C"
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7671582487
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 22:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716590629; cv=none; b=K+bkAoZccqR97isozwgIlDjz9OFI57FylwYF0ISKZJeSvuUUb2MHV3RbbnMzLkWggLMeTUzJDYyn2YWHfmraJCGeRiCRHhh1kEIBrD13DVk8dBwJ6F7wYDSOoK/FFQnfrxLe9KtD+3ZSuam6PN9Su+6sHU6fpih6vKc1wcNVH24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716590629; c=relaxed/simple;
	bh=ucFbGWz6mMVoDnnPzwBRuL8Yb/nGgWE428XQaqRqtRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SwOXrtRVhSQPCOreTLBeBt0uY132XNEGtNqqaXQQS1+duqteV83JOSKXhaaR2vQUZ1h4AGPzGXhNjGEKuKKzX+rsCGZboIBz+tfrOyMGqANSAB68lBbeWA7aHJNalq7DRv+oP/VNlUYjEUzuA7r1EyvlxaXePjiBwCc7tmN3/pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SiVdYy9C; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-48a396a30c0so442904137.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 15:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716590627; x=1717195427; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ymFK2RObdNjzPsJxP220O5+71BNflb8CNq7Wj8mqDgk=;
        b=SiVdYy9C+Lh5VCRx2n2IsuyZB6xVlAX5N53nl8OgWDdhG2kjOQmGkqRYwQAFS+Mj67
         BTvPnCzPosLoYY3JZxtn0UB3lYFNvpiulvJdh5EPhkJwBej5LxL9lyPEvPlLIElOJ1Br
         aKdh1SBtCZsMC8V5ud0JRnWKIqlSSNFa/TW6l/yqcQHzwJnO6h9JsBPKjPOOthLHZEjV
         Sn35e4bIbVC8guq9wMiF5LNBFn+fbirTeWTO0U4CGstBZbFW4FfgIrOS0+XBxXBCUIrS
         T11bJKG9udlKifs6RssNbvSVHxRjAuXydkeU5td8ALr7EmB+12U37eNndB3R83uCrlfa
         gPsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716590627; x=1717195427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ymFK2RObdNjzPsJxP220O5+71BNflb8CNq7Wj8mqDgk=;
        b=RZSWRdoLW0zq6fyH4ojS/0MADm95eldghFARIBDv7kWAnfytba+BZCchSxlIP/OZJl
         EpvkSbVTcYKWxE9reSybnE281BBpyJAcY2AWO1+gPzgg+uREkt9SWHTIsrolmrWdH5FY
         C2+TIekltGZsYbDwirMNSJSpVKL5xK/dyqn54w59fO0QhsbY0x95fW3KFnrOKngFgtM2
         SsZotqlI+VtAOuJXyKgpzRN0bgbtXx/RXgZZxErPquA08dEwvV9yb7pPMADXhHJULksr
         Bq/K8EO0moYi1JXXLYEOLHx0EtWN/bXr6mlOREskLgyPyhZsofjXcV7zydjxuNSJNeP+
         83Og==
X-Forwarded-Encrypted: i=1; AJvYcCUfp1ubYbp5bGZuSNSQsJOBaxXa2M8br88cppgiNBe3QDpQXKCn8Tl69gBKCa+Rq+iFa4S8YyhEFlo5asLgSzx/HDOjdmP4ic5rPeLS
X-Gm-Message-State: AOJu0YzbiZ+306lD/sBudzb2qvU7JvRRDt+GBY2OMkz26q8rGkVssroN
	9MQ+TueCCPphxwFJ857L5W9pHQfMujEaA3e6QmiP2XjQMu7Em0+9lJ1ccYAB4Y6ONPRSFZm7A2V
	O0GM1TW12Bh+RiFLJ8b+db7wlnNQcNjvlSHfj
X-Google-Smtp-Source: AGHT+IEUGTDNkD54qyJg80rQHwEyHmm7B9lB9DQteWkSaz9UWWF3L+6g5cloJy/CNjqKhEMoxrKZcnEAYLz5ilTnrYs=
X-Received: by 2002:a05:6102:2e7:b0:47b:f5ce:569d with SMTP id
 ada2fe7eead31-48a385134d2mr4040126137.3.1716590627119; Fri, 24 May 2024
 15:43:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240517-b4-sio-ntp-usec-v2-1-d539180f2b79@google.com> <87ed9re7i4.ffs@tglx>
In-Reply-To: <87ed9re7i4.ffs@tglx>
From: Justin Stitt <justinstitt@google.com>
Date: Fri, 24 May 2024 15:43:35 -0700
Message-ID: <CAFhGd8o0eFh0sqXtOcw=E+WBaKCTatpv18fA1Pzr_M1aC9OQ=A@mail.gmail.com>
Subject: Re: [PATCH v2] ntp: remove accidental integer wrap-around
To: Thomas Gleixner <tglx@linutronix.de>
Cc: John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org, 
	Miroslav Lichvar <mlichvar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thomas,

I appreciate you reviewing my patches.

On Fri, May 24, 2024 at 5:09=E2=80=AFAM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> On Fri, May 17 2024 at 20:22, Justin Stitt wrote:
> > time_maxerror is unconditionally incremented and the result is checked
> > against NTP_PHASE_LIMIT, but the increment itself can overflow,
> > resulting in wrap-around to negative space.
> >
> > The user can supply some crazy values which is causing the overflow. Ad=
d
> > an extra validation step checking that maxerror is reasonable.
>
> The user can supply any value which can cause an overflow as the input
> is unchecked. Add ...
>
> Hmm?
>
> > diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
> > index b58dffc58a8f..321f251c02aa 100644
> > --- a/kernel/time/timekeeping.c
> > +++ b/kernel/time/timekeeping.c
> > @@ -2388,6 +2388,11 @@ static int timekeeping_validate_timex(const stru=
ct __kernel_timex *txc)
> >               }
> >       }
> >
> > +     if (txc->modes & ADJ_MAXERROR) {
> > +             if (txc->maxerror < 0 || txc->maxerror > NTP_PHASE_LIMIT)
> > +                     return -EINVAL;
> > +     }
>
> I dug into history to find a Fixes tag. That unearthed something
> interesting.  Exactly this check used to be there until commit
> eea83d896e31 ("ntp: NTP4 user space bits update") which landed in
> 2.6.30. The change log says:

Thanks for doing the archaeology.

>
>     "If some values for adjtimex() are outside the acceptable range, they
>      are now simply normalized instead of letting the syscall fail."
>
> The problem with that commit is that it did not do any normalization at
> all and just relied on the actual time_maxerror handling in
> second_overflow(), which is both insufficient and also prone to that
> overflow issue.
>
> So instead of turning the clock back, we might be better off to actually
> put the normalization in place at the assignment:
>
>     time_maxerror =3D min(max(0, txc->maxerror), NTP_PHASE_LIMIT);

A saturating resolution strategy is one that I've taken with some of
my other overflow patches.

.. but how about: clamp(txc->maxerror, 0, NTP_PHASE_LIMIT)

>
> or something like that.
>
> Miroslav: Any opinion on that?
>
> Thanks,
>
>         tglx

Anyways, I'm waiting to see how the whole overflow/wraparound
discussion in general evolves and, of course, how the local discussion
about this patch shapes up.

Thanks
Justin

