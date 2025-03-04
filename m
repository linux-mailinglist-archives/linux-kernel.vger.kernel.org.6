Return-Path: <linux-kernel+bounces-544048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4D4A4DCD9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:44:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43685174A6E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB874200BB5;
	Tue,  4 Mar 2025 11:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vRw1+VEA"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E2B1FDE06
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 11:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741088635; cv=none; b=L/m2lbWzAgGFeo/gPlu/nIpyROz911R4OArN3MqKiGwqHiWOOAx4hJmOhgdDlzjUQrFF5plxEBAMrgNuTcbc/8sQKVe1u/iG6dXiU9DgDmdTw1u9EAzhf+DM0Sntv0aXJtbTob1M9llLyX6jmwilGQvGrh4sc8nnQl9U86Gq3Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741088635; c=relaxed/simple;
	bh=7JMGCeJF/Dp3pl5kzpMvrUbvwzv+GjyKlzt033ZLbrw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JyIqcV+lN1RUL2+VPDpHNMkC1FV9PcWMZ33KvFqasbGDfUgM1MBdv7vONZwIoeyLDNmzHTzuhLabGNtk0DpLqjQ9gFIZWPhMo0O+mYM4uNq5ZNCVTVAJgLTy3WNRsEpLxKXldieRjcXChu6Z1ELH9ivQHUDX6ciX2T8KSanohAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vRw1+VEA; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22356471820so87254765ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 03:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741088633; x=1741693433; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QR5Fe2yNdtUQN8MYBySGOzmABqc40NGzK767K+eex7I=;
        b=vRw1+VEAt4PRU3DtY9BxsLnStXiAXNOfV90ci4wjIKGuhoSBuH4MFSbK46UhUXb1Vb
         TMxvBaJYaQ6H7RdAaVca8BaFQloCSWXsk3yjbL1Z+tGkihJszaZ6IvMTBxHI1oULOCi+
         8ODVdWAzTUTrlOJB/f00hKvFqNAZ+lT/lrG5aYjKnx+AJ9zcAIZIWIztaiRXizmG4u7w
         RdA1uO92AMD23sXxsQP4ufauZ60qCFHuRgFwosnGOjs+rPsegvul1OZnuh5nyRHsMIV9
         iwqmqxAqeuMyz4AUWWTz1AJnOPsWvb14n8C6RaMKOpBZg1Trj3bwfYv7q+CnlQVzU2Ju
         m18w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741088633; x=1741693433;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QR5Fe2yNdtUQN8MYBySGOzmABqc40NGzK767K+eex7I=;
        b=J7HJqGxE7DLyCQdTMywsfQmO/EigtiPW9tLPoPZlYTmIZASJtNtk5a+K6fpPkemYxY
         8/z1xNfXBrsXnwPRHMuT1tQYn12xl8FsYWuVG5hObHMGLJfDo4XUDa3u2wP7qhzIyXr4
         96iXHwRcAGiBElA7gwHjonJJkTZVlFSEI6JX1p4V72NrFK8y6tdxi1zJgMpMWwkwDlsi
         LUrE38SRKTmGPPNimW4J0XmiFiCvEUhDak4VGsDAUdDvtaC2YULdUXuIyo3LlI6fKSaD
         dUuazGFx+2u4f9HJ/fT+DBxNsbmLJX8/QO/bczIp5rvPg/Q+HN8omG5SZd2pXogJtXYb
         5DzA==
X-Forwarded-Encrypted: i=1; AJvYcCV4k1GYbNmBloUeo9u9Hl6XyedrPDeu0Ye0JiXDiArxDE6x8jDWQh79FOsZ2IzRlQYmvZljRGf9EHKZ+co=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT/vn3RdU/kiMlNwu0snZVLTL9qrbkx8b3J0JSL+rvgf/mHStM
	kxZyQUth5To6mRuJj4F0aT/hpNeau6BjqPsREJTLKszmSx9z871lIOupcLkSxBi4iPyR5eL5dhW
	GEoilv1x7u0ntYuGfUiODxyQJSyXjLRqd+3Yv
X-Gm-Gg: ASbGncsukViOpI36vqYM4HLfly9ruhg4LckYMda/jEu1K3clgOryk27PRbnmTbzisy1
	tthi/QWpe7HjFZfhLGtyQtx7ZkBU8kFm14JM5l4JrC4NUfwvrlEhx1eGuk0jn7eWq6nczdnI+IB
	pSIg7dG52vCtwn69kZ4yaVFfNKDEa3KR25GbFbwDtqqhHqp5d5nrMN7Cfm
X-Google-Smtp-Source: AGHT+IEVXXLrKnpkIy+GQHgCDOyqfRoqXWkok7n4CEJmqUNtrw4OipvJO9eUgzweAGOK6LFHiiUO/kAFxvZ/Vg2r6rk=
X-Received: by 2002:a17:903:17cf:b0:215:89a0:416f with SMTP id
 d9443c01a7336-22368fc97c4mr252442495ad.30.1741088632488; Tue, 04 Mar 2025
 03:43:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304092417.2873893-1-elver@google.com> <20250304112114.GE11590@noisy.programming.kicks-ass.net>
In-Reply-To: <20250304112114.GE11590@noisy.programming.kicks-ass.net>
From: Marco Elver <elver@google.com>
Date: Tue, 4 Mar 2025 12:43:15 +0100
X-Gm-Features: AQ5f1Jq8MTV2B3C5aow9x7Sg78yjoK0kjhHzTC3jNgyCezrqQgZfKxcyrD8i65c
Message-ID: <CANpmjNP6N0d0dnGjDUGLeH4FQ2-G5YAuWrSPp+bvDR==0hYykw@mail.gmail.com>
Subject: Re: [PATCH v2 00/34] Compiler-Based Capability- and Locking-Analysis
To: Peter Zijlstra <peterz@infradead.org>
Cc: "David S. Miller" <davem@davemloft.net>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Alexander Potapenko <glider@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Bart Van Assche <bvanassche@acm.org>, Bill Wendling <morbo@google.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Eric Dumazet <edumazet@google.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Ingo Molnar <mingo@kernel.org>, 
	Jann Horn <jannh@google.com>, Jiri Slaby <jirislaby@kernel.org>, 
	Joel Fernandes <joel@joelfernandes.org>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Triplett <josh@joshtriplett.org>, Justin Stitt <justinstitt@google.com>, 
	Kees Cook <kees@kernel.org>, Kentaro Takeda <takedakn@nttdata.co.jp>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Thomas Gleixner <tglx@linutronix.de>, 
	Uladzislau Rezki <urezki@gmail.com>, Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, rcu@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Mar 2025 at 12:21, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Mar 04, 2025 at 10:20:59AM +0100, Marco Elver wrote:
>
> > === Initial Uses ===
> >
> > With this initial series, the following synchronization primitives are
> > supported: `raw_spinlock_t`, `spinlock_t`, `rwlock_t`, `mutex`,
> > `seqlock_t`, `bit_spinlock`, RCU, SRCU (`srcu_struct`), `rw_semaphore`,
> > `local_lock_t`, `ww_mutex`.
>
> Wasn't there a limitation wrt recursion -- specifically RCU is very much
> a recursive lock and TS didn't really fancy that?

Yup, I mentioned that in the rcu patch. Make it more prominent in documentation?

> >   - Rename __var_guarded_by to simply __guarded_by. Initially the idea
> >     was to be explicit about if the variable itself or the pointed-to
> >     data is guarded, but in the long-term, making this shorter might be
> >     better.
> >
> >   - Likewise rename __ref_guarded_by to __pt_guarded_by.
>
> Shorter is better :-)
>
> Anyway; I think I would like to start talking about extensions for these
> asap.
>
> Notably I feel like we should have a means to annotate the rules for
> access/read vs modify/write to a variable.
>
> The obvious case is RCU; where holding RCU is sufficient to read, but
> modification requires a 'real' lock. This is not something that can be
> currently expressed.

It can. It distinguishes between holding shared/read locks and
exclusive/read-write locks.

RCU is is a bit special because we also have rcu_dereference() and
rcu_assign_pointer() and such, but in general if you only hold a
"shared capability" e.g. the RCU read lock only, it won't let you
write to __guarded_by variables. Again, the RCU case is special
because updating RCU-guarded can be done any number of ways, so I had
to make rcu_assign_pointer() a bit more relaxed.

But besides RCU, the distinction between holding a lock exclusively or
shared does what one would expect: holding the lock exclusively lets
you write, and holding it shared only lets you only read a
__guarded_by() member.

> The other is the lock pattern I touched upon the other day, where
> reading is permitted when holding one of two locks, while writing
> requires holding both locks.
>
> Being able to explicitly write that in the __guarded_by() annotations is
> the cleanest way I think.

Simpler forms of this are possible if you stack __guarded_by(): you
must hold both locks exclusively to write, otherwise you can only read
(but must still hold both locks "shared", or "shared"+"exclusive").

The special case regarding "hold lock A -OR- B to read" is problematic
of course - that can be solved by designing lock-wrappers that "fake
acquire" some lock, or we do design some extension. We can go off and
propose something to the Clang maintainers, but I fear that there are
only few cases where we need __guarded_by(A OR B). If you say we need
an extension, then we need a list of requirements that we can go and
design a clear and implementable extension.

In general, yes, the analysis imposes additional constraints, and not
all kernel locking patterns will be expressible (if ever). But a lot
of the "regular" code (drivers!) can be opted in today.

Thanks,
-- Marco

