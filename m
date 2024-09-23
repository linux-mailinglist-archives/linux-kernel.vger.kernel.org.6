Return-Path: <linux-kernel+bounces-333023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77AA997C24E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 02:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D22F728200E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 00:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5612FB6;
	Thu, 19 Sep 2024 00:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SpDotOrk"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220ACA50
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 00:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726704810; cv=none; b=YoYiOffSYIjnZmXkQJkYqjmrl2QLX6ZCzRjxGrFYGiJ2IUFM93mR7UJZb0Kg5mLfmWy+lR4cSPr/QAW8YNZ29yfIXKtldwd7bGmYJiuXUEwm72rdyeRzAn1isBupGqdMeWTsJYtZfxrWJEe7Wscsv78cagdofjYHxMZrSLrttco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726704810; c=relaxed/simple;
	bh=T/7mdh3geBainvCyl5Xts817J7o54G0HCjkdqpWCRb0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pFnjxJ/f49fXKVFAdtVIPYs2eATE2feL/zFn+ZAqTLbXxJyKIbyZjFq8ZdueHETBmE08jNbpKHRFsWzHEUuj60zPI9MjPQTD1gHqkgafaU/Y2cjkNGwelNxCzINtUu5ndgZL14Dyr26UtxHzN3yqaiqwtR+aJYnnPnCTaMHCZ0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SpDotOrk; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53690eb134bso37367e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 17:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726704807; x=1727309607; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d+8DakgAQqt4SQhUht3h9GkR0aukfPFngDOzdJJ0d8E=;
        b=SpDotOrkTZFt15lPtauH3CeJt6sbj/K9tqDrV2IlIPf0lFIY7Q7KwgF3JZa4jzI7aK
         mhVmL3Wux+mn7tFH0IdBxKKhrh4bJfK0nKPPA0DCJWfhwKek7k8ol6xJBAqwdGKELHTj
         aGUs8oA3PfjJbBACYsOcv53qMCR/bVonOjohLWf2LEYHbLnhzoGOvFrT9Y3LNEc2+hE+
         DJwQ1S4cssS2m4uj6uDKHoXM19utGdlgBknL06Nzfif73/E7Q8X0PRj1CC+Q7H4HRwb5
         ho1b60wcwI72saP/hY3pnmSKB5jfYmFOrOG1MQhqQEmedctN3bTv/yHnL+qf4o3+QQhS
         AeAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726704807; x=1727309607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d+8DakgAQqt4SQhUht3h9GkR0aukfPFngDOzdJJ0d8E=;
        b=iSRTFFbgWOSDkHm04WfkjimtFdL1VsTTfIeOucFgdh1kjsho5PtVbUJlbJpLZ2k+MJ
         TgR/oIYw5vZusAiZZ4BHaioOgbCwtEknvrptDOABSa6IZ3TcEEjv/1+rw5AFsEFxC3W5
         uqgJloLbU6wclReRiuURBf/82rXI6ALEnrUszI0lyXV8Gq3z7xY4dMvbbO6JwCzCkME1
         W6fggwCwZa6RMe9LjryXQezGbwl3MZPhvpNaHM+o8Ds/WeQvOIHoTf3bZ7+u/YjdW3qj
         BzDpNzifINa7n+Dybx1ipdPM2rhieWL+VOl1JYor8Fc1uEJ6Z/ui15NCk70tBnQ9yGfj
         JRcA==
X-Gm-Message-State: AOJu0YzEMXQ7mJttgHnJdvdueiop6aKUcjkfla02kSTTglFrbvCPMS+f
	nE1AquAaEGVnlLavQQvRqHFVuV/FicjnVkDMsh5pvSxxFGeooNQeuhpLjCaCZJQdsZW9rPowicN
	ko2fQQ2Y/wavjgxrE9dOcAAPFIf7zsNHk5ds5
X-Google-Smtp-Source: AGHT+IEx+DSA61LMo7F7C1PLH+vJWUY14tFKsCWTJNw6Hkr3gKYEnXZ988BJj+EtKWbVgAwQ18MS//3CsYJHyCGcRwQ=
X-Received: by 2002:a05:6512:3f26:b0:52c:dd94:73f3 with SMTP id
 2adb3069b0e04-536a7bfa7b6mr37667e87.3.1726704806347; Wed, 18 Sep 2024
 17:13:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240917143402.930114-1-boqun.feng@gmail.com> <20240917143402.930114-2-boqun.feng@gmail.com>
In-Reply-To: <20240917143402.930114-2-boqun.feng@gmail.com>
From: Jann Horn <jannh@google.com>
Date: Thu, 19 Sep 2024 02:12:48 +0200
Message-ID: <CAG48ez0VN8oZcqhdzkWQgNv6bwUN=MUu5EacLg5iPvMQL+R-Qg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] hazptr: Add initial implementation of hazard pointers
To: Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, linux-mm@kvack.org, 
	lkmm@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joel@joelfernandes.org>, 
	Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Kent Overstreet <kent.overstreet@gmail.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, maged.michael@gmail.com, 
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 17, 2024 at 4:33=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
> Hazard pointers [1] provide a way to dynamically distribute refcounting
> and can be used to improve the scalability of refcounting without
> significant space cost.

> +static inline void *__hazptr_tryprotect(hazptr_t *hzp,
> +                                       void *const *p,
> +                                       unsigned long head_offset)
> +{
> +       void *ptr;
> +       struct callback_head *head;
> +
> +       ptr =3D READ_ONCE(*p);
> +
> +       if (ptr =3D=3D NULL)
> +               return NULL;
> +
> +       head =3D (struct callback_head *)(ptr + head_offset);
> +
> +       WRITE_ONCE(*hzp, head);
> +       smp_mb();
> +
> +       ptr =3D READ_ONCE(*p); // read again
> +
> +       if (ptr + head_offset !=3D head) { // pointer changed
> +               WRITE_ONCE(*hzp, NULL);  // reset hazard pointer
> +               return NULL;
> +       } else
> +               return ptr;
> +}

I got nerdsniped by the Plumbers talk. So, about that smp_mb()...

I think you should be able to avoid the smp_mb() using relaxed atomics
(on architectures that have those), at the cost of something like a
cmpxchg-acquire sandwiched between a load-acquire and a relaxed load?
I'm not sure how their cost compares to an smp_mb() though.

Something like this, *assuming there can only be one context at a time
waiting for a given hazptr_t*:


typedef struct {
  /* consists of: marker bit in least significant bit, rest is normal point=
er */
  atomic_long_t value;
} hazptr_t;

/* assumes that hzp is currently set to NULL (but it may contain a
marker bit) */
static inline void *__hazptr_tryprotect(hazptr_t *hzp, void *const *p) {
  /* note that the loads of these three operations are ordered using
acquire semantics */
  void *ptr =3D smp_load_acquire(p);
  /* set pointer while leaving marker bit intact */
  unsigned long hazard_scanning =3D
atomic_long_fetch_or_acquire((unsigned long)ptr, &hzp->value);
  if (unlikely(hazard_scanning)) {
    BUG_ON(hazard_scanning !=3D 1);
    /* slowpath, concurrent hazard pointer waiter */
    smp_mb();
  }
  if (READ_ONCE(*p) =3D=3D ptr) { /* recheck */
    atomic_long_and(~1UL, &hzp->value);
    return NULL;
  }
  return ptr;
}

/* simplified for illustration, assumes there's only a single hazard
pointer @hzp that could point to @ptr */
static void remove_pointer_and_wait_for_hazard(hazptr_t *hzp, void
*ptr, void *const *p) {
  WRITE_ONCE(*p, NULL);
  smb_mb();
  /* set marker bit */
  atomic_long_or(1UL, &hzp->value);
  while ((void*)(atomic_long_read(&hzp->value) & ~1UL) =3D=3D ptr))
    wait();
  /* clear marker bit */
  atomic_long_and(~1UL, &hzp->value);
}


The idea would be that the possible orderings when these two functions
race against each other are:

Ordering A: The atomic_long_fetch_or_acquire() in
__hazptr_tryprotect() happens after the atomic_long_or(), two
subcases:
Ordering A1 (slowpath): atomic_long_fetch_or_acquire() is ordered
before the atomic_long_and() in remove_pointer_and_wait_for_hazard(),
so the marker bit is observed set, "hazard_scanning" is true. We go on
the safe slowpath which is like the original patch, so it's safe.
Ordering A2 (recheck fails): atomic_long_fetch_or_acquire() is ordered
after the atomic_long_and() in remove_pointer_and_wait_for_hazard(),
so the subsequent READ_ONCE(*p) is also ordered after the
atomic_long_and(), which is ordered after the WRITE_ONCE(*p, NULL), so
the READ_ONCE(*p) recheck must see a NULL pointer and fail.
Ordering B (hazard pointer visible): The
atomic_long_fetch_or_acquire() in __hazptr_tryprotect() happens before
the atomic_long_or(). In that case, it also happens before the
atomic_long_read() in remove_pointer_and_wait_for_hazard(), so the
hazard pointer will be visible to
remove_pointer_and_wait_for_hazard().

But this seems pretty gnarly/complicated, so even if my 2AM reasoning
ability is correct, actually implementing this might not be a good
idea... and it definitely wouldn't help on X86 at all, since X86
doesn't have such nice relaxed RMW ops.

