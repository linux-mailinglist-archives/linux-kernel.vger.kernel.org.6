Return-Path: <linux-kernel+bounces-232703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3187491AD42
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 18:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4B16288BB5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 16:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD99199EA9;
	Thu, 27 Jun 2024 16:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IuXh3y9i"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1E114EC40
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 16:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719507318; cv=none; b=ELoL+J8a1sSDU/B/zIGImRkb4/6+C5W9Y7nxrgPF1gUNBMUykjS0hhvMrpyLYpzAhLQCo/a9A0+Dy8zP4qnlmll7Os2V6bitQsy0SO2KQgZiDjimZsPG2Px3QP/Qr5S4c7LgQgQ6rAPSNfnzYPkSQGu9DrPk13b8GIDsuANd71c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719507318; c=relaxed/simple;
	bh=TWpfBUkrmZcTYP6kalJEGUrCqZR0g9FhtBW0ShSfuI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BBKlZVRVglQRHbOtgP8K/36pVt8QR0rzVCPAFbETrSvBdv/bYU9qOrREUH8KRf7BwWSUhdB8KCISaAP45OvFrwRr8sh2xNeuSaHr0kvShfPyndsHtFn+rVb+l7gDa8+nQ97L+rAGFJUdQkliE7cGYsWOz7fPEW+AQqxrF6XLN3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IuXh3y9i; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a724598cfe3so732705966b.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 09:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719507315; x=1720112115; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=niteNh3TbVLu7eb0D9sBMdcI9GkHgkcpq+/w6gXTGSU=;
        b=IuXh3y9i3mYkv1cTaOBmvBrJFXxxAudaNixbB73uYKWkGw0jF67GGcnHnE5t6QhS8w
         kl6KQzyEdzgYp0+jjBOab4yT2uFme36qfcp9rWBTvperM7KOJpXeN7mYQ25GsdO2gjyH
         3dBvf9YgrfkAdMhtwKFqw6vehhyhdzt4a8Pr1X26DGYiQ6gykxXpOaREfaLScLQN4ZKo
         K70Ky48Ylxr9HBNT1EKafsgXLrwN2AYRm4jji8yOlJyjiOcaY+QeootQj34+mewHImby
         p7Gy9UxKa/60K2xUTw3nwTHZxp3BYAAq0X/Qobt5lyt+a1eX4/Ymq3zubfWofqGmqKB2
         IOhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719507315; x=1720112115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=niteNh3TbVLu7eb0D9sBMdcI9GkHgkcpq+/w6gXTGSU=;
        b=u45j7lOIrs/N5FdhCuRbpqi50cG/sHOqLmp9jlKyUzZSEWjlQjY2goOA2+pruaYhzG
         ViLQXNObAlOXdgaJdUSv5UFs2b1SFpwVUDhMKOpNOlkV4bUdLFK5B7DBhbH/bp3o6MEx
         WycKfUiEOklcSHH86BeT0KmiL0uthC7fPkZiPs7D44ERKxcDYFnM01y4JQ8OtFuUQRA9
         Ko2rgox7eqLtTUmvXXO3ZkZCoe6zRWs0QWI7eZlAz3wbbl96/lsxsms1UioAjt/ixK2U
         eSKNwKqnaKu8GC+nOLoVMMsxHtpWvwVtvITC4MgkSL3kVpC3SlsyFDtXeLLp2SOqb28S
         Pzkg==
X-Forwarded-Encrypted: i=1; AJvYcCUvhinCB3LS4NN+7k/lq66Wp3pgmvSFa3IEDTRieWjIwdSDSUhFlUWYDfG+DYcsLzSIZfQBeuUjI/KN8f2UzqEVO+0x/9wuq1zc3pWU
X-Gm-Message-State: AOJu0YxUxjSyBFvL/jg1nm4fSFLUP67mzGzK06WLs3uoamzP6+zRfSIN
	7dZGUxOBQzOxNmXEsI34y3lA6OQzVJ5RZIbZHtWMl+XjfdYl3sgkcgo5NFBlrzhE8NJmWgVC/e2
	/QyXc3CBk7H8iYrQHAXzZupW1zes=
X-Google-Smtp-Source: AGHT+IH0dIKUR/haFbE60cInxlDg0jpKpfwKboTD7Ew46GpSk6YvqS7ECQ1CFI021YcGgAHu64qodhxqduXhre2e1pk=
X-Received: by 2002:a17:906:6a22:b0:a72:a206:ddc2 with SMTP id
 a640c23a62f3a-a72a206df24mr160444366b.36.1719507314776; Thu, 27 Jun 2024
 09:55:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202406270912.633e6c61-oliver.sang@intel.com> <CAGudoHF7ys8bTCE0G6vLzEbo+_NyQXmAEEGPJ4hx1yoYmBsoUA@mail.gmail.com>
 <CAGudoHFrMkdo1CoVxJUiEvQ_DyW3hzaCz18GjvLi4ny=o-q9ZQ@mail.gmail.com> <CAHk-=wg7PXo_QbBo8gv27OpbMgAwLh9H46kJRxAmp0FL0QD7HA@mail.gmail.com>
In-Reply-To: <CAHk-=wg7PXo_QbBo8gv27OpbMgAwLh9H46kJRxAmp0FL0QD7HA@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 27 Jun 2024 18:55:02 +0200
Message-ID: <CAGudoHFfH7d2AnWOeTNWF_BvF8qizxp+FMK6e1CyeOfTk0fLGQ@mail.gmail.com>
Subject: Re: [linux-next:master] [lockref] d042dae6ad: unixbench.throughput
 -33.7% regression
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	Linux Memory Management List <linux-mm@kvack.org>, Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	ying.huang@intel.com, feng.tang@intel.com, fengwei.yin@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 6:32=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, 27 Jun 2024 at 00:00, Mateusz Guzik <mjguzik@gmail.com> wrote:
> >
> > I'm arranging access to a 128-way machine to prod, will report back
> > after I can profile on it.
>
> Note that the bigger problem is probably not the 128-way part, but the
> "two socket" part.
>

I know mate, I'm painfully aware of NUMA realities.

The bigger stuff I have intermittent access to is all multi socket,
the above is basically "need to use something bigger than my usual
trusty small core setup".

> From a quick look at the profile data, we have for self-cycles:
>
>   shell1 subtest:
>       +4.2   lockref_get_not_dead
>       +4.5   lockref_put_return
>      +16.8   native_queued_spin_lock_slowpath
>
>   getdent subtest:
>       +4.1   lockref_put_return
>       +5.7   lockref_get_not_dead
>      +68.0   native_queued_spin_lock_slowpath
>
> which means that the spin lock got much more expensive, _despite_ the
> "fast path" in lockref being more aggressive.
>
> Which in turn implies that the problem may be at least partly simply
> due to much more cacheline ping-pong. In particular, the lockref
> routines may be "fast", but they hit that one cacheline over and over
> again and have a thundering herd issue, while the queued spinlocks on
> their own actually try to avoid that for multiple CPU's.
>
> IOW, the queue in the queued spinlocks isn't primarily about fairness
> (although that is a thing), it's about not having all CPU cores
> accessing the same spinlock cacheline.
>
> Note that a lot of the other numbers seem "incidental". For example,
> for the getdents subtest we have a lot of the numbers going down by
> ~55%, but while that looks like a big change, it's actually just a
> direct result of this:
>
>      -56.5%  stress-ng.getdent.ops
>
> iow, the benchmark fundamentally did 56% less work.
>
> IOW, I think this may all be fundamental, and we just can't do the
> "wait for spinlock" thing, because that whole loop with a cpu_relax()
> is just deadly.
>
> And we've seen those kinds of busy-loops be huge problems before. When
> you have this kind of busy-loop:
>
>     old.lock_count =3D READ_ONCE(lockref->lock_count);
>     do {
>         if (lockref_locked(old)) {
>             cpu_relax();
>             old.lock_count =3D READ_ONCE(lockref->lock_count);
>             continue;
>         }
>
> the "cpu_relax()" is horrendously expensive, but not having it is not
> really an option either, since it will just cause a tight core-only
> loop.
>
> I suspect removing the cpu_relax() would help performance, but I
> suspect the main help would come from it effectively cutting down the
> wait cycles to practically nothing.
>

As far as lockref goes I had 2 ideas to test:
1. cpu_relax more than once, backoff style. Note the the total spin
count would still be bound before the routine gives up and locks. this
should reduce pulling
2. check how many spins would be needed to wait for before lockref
decides to fall back to locking

When messing around not automatically taking the lock I measured spin
counts with an artificially high limit. It was something like < 300 to
cover the cases I ran into (not this benchmark). For all I know the
limit can be bumped to -- say 256 -- and numerous acquires will
disappear at that scale, which should be good enough for
everybody(tm). All while forward progress is guaranteed.

That aside even that getdent thing uses mutexes and there is something
odd going on there. I verified workers go to sleep when it is
avoidable, which disfigures the result. I don't know the scale of it,
it may be it is a tiny fraction of consumers, but I do see them on
offcpu tracing.

That's that for handwaving. I'm going to get the hw and get hard
profiling data + results.

--=20
Mateusz Guzik <mjguzik gmail.com>

