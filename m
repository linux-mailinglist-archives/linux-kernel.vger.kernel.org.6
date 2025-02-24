Return-Path: <linux-kernel+bounces-528637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA333A41A09
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 11:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 927861892DE4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320B225745F;
	Mon, 24 Feb 2025 09:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nOR8uHi6"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556E9256C90
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 09:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740391152; cv=none; b=R6NQ2EBVCBaUNE0RcKK4WoeQSbl8so5wgnVjpLDibVZlKa80a4H7PzSex+5V8jKBdjzoumjLVT/5Q1MyA2PVdUmC7bsFl2+WgF5m/5HODNtOn7TTgsuaTPXwrdcF3t+g+uA00R4Zbp9+ED4mgGw36wuqeUNlDXjR3Au15EKm2v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740391152; c=relaxed/simple;
	bh=BOtn3MGlo52rs8cqxTSQaZysCuePGfoOADlO0Vr133I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K1WmjYHUF0HAwqZCnQOz+gnZ7mBs+Xdj6CHIShfo597RPlsm2utrz/o8gHdVvjVJj3qJN773YjBDKoUXcOVPnCBmmp1GXZI9+GQ58xYZcWQJ2eEMZVXHGVEICHJbJdCRv20TFXoBRhUSS3HC9Xnk1pY8JyiJkwgxUgrfYEvBoBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nOR8uHi6; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e0939c6456so6630213a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 01:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740391148; x=1740995948; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n5dazKD4QC/TIVa6aN3EHegVDPitOmt2Ng6fIVYYdh0=;
        b=nOR8uHi6XAwU+Z/h6LMgdn0dwd5APLAEvuGkQw/YAA84NBjnOoL/KPL6/n4PdRc1HF
         adchGgi1H2ja1cLoliW7LtBEC3cACblezHs+iWmwUC5xGSjkdWeGE2wsFOkELJqyR1rV
         d/oQxt6ihoDe4BDUZy9JMdlm7VjPiiIekERQ8G674YF2x3fSkwLJxQv0mErsXtwik0YN
         te4y8MhRXfrFJqj2eybMp0/PVWOQ7xzZRvj1UYEvUPxyY82BXFp/uuqwYTMiCCYUM1ht
         q8DtPOwvM2l5VyqHjCq2QJBw03ViL3hTrOkir14hMoxz2/u6NjCoSikBTVGkjFOuyTd9
         wDdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740391148; x=1740995948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n5dazKD4QC/TIVa6aN3EHegVDPitOmt2Ng6fIVYYdh0=;
        b=ACe/WVq7h8ka1WKtSjLnn6PIz7VAF2U+EmnxRo0suo1/wv1dOi4ZhhJSHk5t2ICMWL
         y9dei2g2LN37JcAPkq+KYgBIcDkbMgMAqwJk2X7pgSPG53j8IVbT8jKGDiCSSnTmnoK/
         3rWYv8S9gG3RD9PzTKxZR8YQUiFVqWvw7aWaE2WsTiE1ppar1K4ZnBS130C07vQNIgxU
         7qpESaGzBB5k3ZXR3tmGamfiZKTPr4dZ2YSlB5dB1Hc1zzg2wdeoPOSRI2Uw3m6Fvgzb
         Y6R7y/IQzu1t9/k1/tx3I7lcD2YmDInvRXcK792RFgJHhpEX+4JPCfQK8QvkSllX2+DF
         Baag==
X-Forwarded-Encrypted: i=1; AJvYcCVmJq7cq30zsG1WqPFiylkzAxfzrRmIfg757FVRmp2NYsKRG3oxyFKJp2gNf6GC0zWK5C2vJMd4LWNELPI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5SISEJguR+9oIwrtIx27zkaXQzzzo2mwnkzZW0iiwGEcXZr1B
	fYb5XafcWqgFGiitDkSw1LiTCTCub3IY7Cen62cMkFbiNunL3NcjYTll2c2LAmKbL3yjMI0C4ze
	7/mx2ia5kZAEWhX28oir9kOP5cKu4GJUIZMdO
X-Gm-Gg: ASbGncsE8bh2zIFtfQScM9EgJW9YOJWnKbNlMnWwqj0jlolx6cVvFNADVxtDubZPntP
	ZdaUJWrrh8s6oJIedNQuiCVEojjJRFqVFYDtuh49u4UwISCeuXhdPwMYhCDaBIsUzcUGCKRSNr1
	0WLoUx1A==
X-Google-Smtp-Source: AGHT+IEGC725n5n950DijqEK6wq+DJJ9Hfpij6OtgfR2ySt0nqxIJq+h3PyD0ArF+JJKYI/8s0r/PIqGZP8KncuFGRs=
X-Received: by 2002:a05:6402:5415:b0:5df:6de2:1e38 with SMTP id
 4fb4d7f45d1cf-5e0b70f3327mr10581313a12.17.1740391148398; Mon, 24 Feb 2025
 01:59:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219125522.2535263-1-edumazet@google.com> <20250219125522.2535263-5-edumazet@google.com>
 <871pvnheky.ffs@tglx>
In-Reply-To: <871pvnheky.ffs@tglx>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 24 Feb 2025 10:58:57 +0100
X-Gm-Features: AWEUYZl7G4h07hP1eOmZgqDJGjwNMmY9G0vuI4DzUWk0-RFzUNdevCmB6CpmCbE
Message-ID: <CANn89iKkeRV-TqQnCM-XeCkyiWCPFXNGLUAT4oge3i-Dpxu1aA@mail.gmail.com>
Subject: Re: [PATCH V2 4/4] posix-timers: Use RCU in posix_timer_add()
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, Benjamin Segall <bsegall@google.com>, 
	Eric Dumazet <eric.dumazet@gmail.com>, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 10:33=E2=80=AFAM Thomas Gleixner <tglx@linutronix.d=
e> wrote:
>
> On Wed, Feb 19 2025 at 12:55, Eric Dumazet wrote:
> > --- a/kernel/time/posix-timers.c
> > +++ b/kernel/time/posix-timers.c
> > @@ -125,7 +125,19 @@ static int posix_timer_add(struct k_itimer *timer)
> >
> >               head =3D &posix_timers_hashtable[hash(sig, id)];
> >
> > +             rcu_read_lock();
> > +             if (posix_timers_find(head, sig, id)) {
> > +                     rcu_read_unlock();
> > +                     cond_resched();
> > +                     continue;
> > +             }
> > +             rcu_read_unlock();
> >               spin_lock(&hash_lock);
> > +             /*
> > +              * We must perform the lookup under hash_lock protection
> > +              * because another thread could have used the same id.
> > +              * This is very unlikely, but possible.
> > +              */
> >               if (!posix_timers_find(head, sig, id)) {
> >                       timer->it_id =3D (timer_t)id;
> >                       timer->it_signal =3D (struct signal_struct *)((un=
signed long)sig | 1UL);
>
> So I played with that because I wanted understand what's going on.
>
> Actually this change is just voodoo programming. Why?
>
>   The only case where this lockless lookup would help is when the timer
>   ID wrapped around and the lookup has to validate a large range of
>   already occupied IDs, but even then the lookup is dropping hash_lock
>   after each ID search. I seriously doubt that this is the case at hand
>   because according to Ben this happens when a process is started or
>   restored, which means there is no timer ID wrap around and therefore
>   no timer ID collision in the process itself.
>
> In fact the extra lookup is counter productive in most cases:
>
>  With a single process, which creates 50000 timers in a loop, this
>  results in:
>
>  [1]        mainline     +lookup
>  create        98 ms      219 ms
>
>  and it gets worse with 100000 timers:
>
>  [2]        mainline     +lookup
>  create       313 ms      650 ms
>
> Why? Because with 100k timers the hash buckets contain ~200 timers each,
> which means in the worst case 200 timers have to be walked and
> checked. Doing this twice obviously at least doubles the time.
>
> Now there is a case where the change improves the situation, but for the
> very wrong reasons:
>
>  A process forks 63 times and all forks wait on a barrier before each
>  instance creates 20000 timers. The processes are pinned on seperate CPUs
>  to achive maximum concurrency. The numbers are the average times per
>  process:
>
>  [3]        mainline     +lookup
>  create    157253 ms    40008 ms
>
> But that improvement has absolutely nothing to do with the timer ID
> collision. The extra lookup (and I verified with tracing) creates just
> enough interleaving so that all CPUs can make progress on the hash lock
> instead of being stuck in a cache line bouncing shitshow. The very same
> can be achieved by:
>
>         ndelay(total_number_of_timers / $CONSTANT);
>
> So, no. This is not a solution. The proper solution is to replace the
> hash by a scaled hash with per hash bucket locks, like we have in the
> futex code already. I've implemented this and the result proves the
> point with the three test cases:
>
>  [1]        mainline     +lookup   scaled hash
>  create        98 ms      219 ms         20 ms
>
>  [2]        mainline     +lookup   scaled hash
>  create       313 ms      650 ms         48 ms
>
>  [3]        mainline     +lookup   scaled hash
>  create    157253 ms    40008 ms         83 ms
>
> This is really only a problem of the hash collisions and the resulting
> list walk length, which is easy to prove by extending the tests above.
>
> After creating the timer and synchronizing again (for the fork case),
> the test invokes timer_getoverrun(2) for all created timers in a loop.
>
>  [1]        mainline     +lookup   scaled hash
>  create        98 ms      219 ms         20 ms
>  getoverrun    62 ms       62 ms         10 ms
>
>  [2]        mainline     +lookup   scaled hash
>  create       313 ms      650 ms         48 ms
>  getoverrun   261 ms      260 ms         20 ms
>
>  [3]        mainline     +lookup   scaled hash
>  create    157253 ms    40008 ms         83 ms
>  getoverrun  2611 ms     2614 ms         40 ms
>
> I picked timer_getoverrun(2) because that's just doing the lookup and
> reading from the k_itimer struct after locking it. So the syscall has no
> contention on the timer lock nor on anything else. According to perf the
> vast majority of time is spent in the list walk to find the timer and of
> course the cache foot print becomes worse the larger the bucket lists
> become.
>
> Let me write proper changelogs and a cover letter and post that stuff.
>

Great, we are looking forward to your patches.

