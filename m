Return-Path: <linux-kernel+bounces-389714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ABD39B705C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 00:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B5722815BA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 23:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B6E1F4288;
	Wed, 30 Oct 2024 23:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ylZR2V1z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9jOp/HEz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9DB1BD9EA
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 23:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730330063; cv=none; b=Qp84eqljnPbpOPvid720NR7ss+Me+tVruoih5wb1My9dw9rNJ6iuHb1Dq3TVJprCJnwAKg543dU6YAtUL9gT4zglVNe5sYUggjyuaAAI6RUfRKIz9ImsdGBAHvXTvr3gwFJAUQryIX1eWbLfZNy8Fqdx9RFZ+2JoUHQBMixYVUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730330063; c=relaxed/simple;
	bh=HthewGc6yWJqZUR+pk2aaPnaGA0tsR4m4I9vgfdQRXw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OZq3rgoznpe5fratPVO+id8kV4x8qbBRikM6KpWouAzbP4ApfKKSQqGp+6g5KNa0Fah+YO35gDq/+fgun1IIi0NOtMIzJS8MEwBm/9aWxaIKNpztH1gkMkjG4LjS7HCXrLKhsrhKrPGaYr2aMpIDp1KqL0uNAuqCZsxpg+sgaWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ylZR2V1z; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9jOp/HEz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730330058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8+sCbk3iEyX9mBVByKLXAT6EPqlq5QQnP8ljhUjyM7M=;
	b=ylZR2V1zRB6LSiMbiTeMpkT6aErT+Gg3cVTth5tHzG2AUMAZzKE6V/8wGj6KTzGTGCTyhX
	TyH/2AgtnMQaD2G1nCB879olvE8T3elRrzvm0sz+Ep5LkO07OuI2i1R5WWnTOXORIb2000
	faSHKRlMYt/5d+8Dc1XMvP8J+bLbiJKes44qNK+al7Bh1dqCTAohVa+oENko6WxK+9exYu
	HQnyyLWSphQXNyvIPmCAJKoqwVlGh/yZuwaR2ys31Dt/n3WUB5t2fcLtiqUOv6J74UkH9I
	81LAq1a8ADi7ZK2il7aq8TmVnJJ0jzIhlXnDaFKnod/oN64q5hXXvGPHcx18/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730330058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8+sCbk3iEyX9mBVByKLXAT6EPqlq5QQnP8ljhUjyM7M=;
	b=9jOp/HEzyeqYgMNUXc5j4wyg9gSyuF6at4B/JGaIJeZqUzF8L70pc1dXtxOyS9vjJKl/nm
	tbCP0WjujgLkQ7Aw==
To: Peter Zijlstra <peterz@infradead.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org, =?utf-8?Q?Andr=C3=A9?= Almeida
 <andrealmeid@igalia.com>,
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
 Valentin Schneider <vschneid@redhat.com>, Waiman Long <longman@redhat.com>
Subject: Re: [RFC PATCH 2/3] futex: Add basic infrastructure for local task
 local hash.
In-Reply-To: <20241030210819.GS9767@noisy.programming.kicks-ass.net>
References: <20241026224306.982896-1-bigeasy@linutronix.de>
 <20241026224306.982896-3-bigeasy@linutronix.de> <87cyjl4u1h.ffs@tglx>
 <20241028103058.tERYBWZu@linutronix.de> <87y128335h.ffs@tglx>
 <20241028110035.GQ9767@noisy.programming.kicks-ass.net>
 <87r080306d.ffs@tglx>
 <20241030210819.GS9767@noisy.programming.kicks-ass.net>
Date: Thu, 31 Oct 2024 00:14:16 +0100
Message-ID: <878qu5xjxz.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Oct 30 2024 at 22:08, Peter Zijlstra wrote:
> On Mon, Oct 28, 2024 at 01:02:34PM +0100, Thomas Gleixner wrote:
>
>> That's what we did with the original series, but with this model it's
>> daft. What we maybe could do there is:
>
> Not sure what's daft -- a single JVM running on 400+ CPUs with 4
> hashbuckets sounds awesome.

Hahaha. You're right and I discussed this with Sebastian earlier
today. He's going to do some research on scaling of the hash vs. number
of threads (manually for now).

Vs. daft: The original 'register first' model was trivial in that
regard. "Automagic" requires way more to get it right.

The global hash size is next_power_of_2(256 * num_possible CPUs). So
with 256 CPUs this ends up with 64k hash buckets (4M of memory).

As one thread of a multithreaded application can only have one futex
queued at a time, it's reasonable to size that according to the number
of threads.

But from my memory of investigating JVM and database muck there can be a
gazillion of futexes in the process. So depending on the scaling factor
(number of buckets per thread) the resulting hash distribution might be
truly bad and cause a vast amount of hash collisions if the hash size is
too small. Even if the bucket lock is not the problem, then the list
walk will show up as a cache miss sh*tshow.

Let's see what Sebastians experiments will unearth.

>> private_hash()
>>    scoped_guard(rcu) {
>>       hash = rcu_dereference(current->signal->futex_hash);
>
> So I really do think mm_struct is a better place for this than signal
> struct -- CLONE_SIGHAND is not mandatory when CLONE_VM.
>
> I've long forgotten which JVM used the naked CLONE_VM, but there is some
> creative code out there.
>
> And futexes fundamentally live in the memory address space.

Agreed.

>>       if (hash && rcuref_get(&hash->ref))
>>          return hash;
>>    }
>> 
>>    guard(spinlock_irq)(&task->sighand->siglock);
>>    hash = current->signal->futex_hash;
>>    if (hash && rcuref_get(&hash->ref))
>>        return hash;
>>    // Let alloc scale according to signal->nr_threads
>
>   mm->mm_users
>
>>    // alloc acquires a reference count
>>    ....
>
> It might make sense to have a prctl() setting that inhibits the hash
> allocation entirely, reverting back to the global hash tables.

Right. It might even be the default to begin with. See below.

> I'm not sure having that rehash under siglock is a fine idea. It's
> convenient, no doubt, but urgh, could get expensive.

If we move it to mm, then it will be a separate lock anyway, a mutex.

> Another scheme would be to have 2 concurrent hash-tables for a little
> while.

Thought about that before and discarded it as too complex, but now that
you mentioned it again, let me explain why and you can tell me that I'm
failing to see the obvious.

As that switch over needs to be lockless on the usage site, this opens
another can of worms.

struct mm_futex {
       struct futex_hash	__rcu *cur;
       struct futex_hash	__rcu *prev;
       mutex_t                  mutex;
       ....
};

The reallocation part becomes obviously trivial

    mutex_lock(&mm->futex.mutex);
    old = mm->futex.curr;
    new = alloc(...);
    rcu_assign_pointer(mm->futex.prev, old);
    rcu_assign_pointer(mm->futex.cur, new);
    if (rcuref_put(old->ref)) {
       // old is invalid now
       rcu_assign_pointer(mm->futex.prev, NULL);
       kfree_rcu(old);
    }
    mutex_unlock(&mm->futex.mutex);

So enqueue will always use mm->futex.cur which it sees when getting a
refcount. If the get() fails it has to retry. Trivial enough.

wake/requeue gets more interesting because it has to check the old hash
first ((if it exist)and move the entries in the hash bucket over,
otherwise we end up with dealing with that nonsense in the actual
wait/requeue guts. That needs to be done at _every_ operation ...

That might be actually doable (or not), but it requires a non-trivial
amount of complexity especially vs. the hb->waiters optimization.

If that's handled, then it falls flat when a futex is used as a wait
queue. There might be a thread sitting on it waiting for an event which
never happens, which means the old hash never gets removed. Then the
process gets another pile of threads and can't expand the hash because
there are already two instances.

Remember: Futex code consists of 5% functionality and 95% corner case
handling already. No need to up this to 98+% :)

I really want to start simple and let the process' futex usage come to a
grinding halt when the resizing and rehashing takes place.

Resizing won't happen every other millisecond especially as the hash
size has to double every time. And we'll never downsize.

Any smart application will resize on start or the admin will tweak the
hash size or disable it with whatever magic mechanism we will provide.

That said for the sake of least surprise, this might actually require to
be opt-in to begin with. At least at the system level it has to be
disabled by default (unless configured otherwise via config or command
line).

I really want to know who thought that futexes are a good idea to begin
with. Once we figured that out I need to find those who added all the
other complexity on top of that bad idea :)

Thanks,

        tglx

