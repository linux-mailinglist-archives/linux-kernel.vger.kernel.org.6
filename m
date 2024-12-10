Return-Path: <linux-kernel+bounces-440432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3715F9EBDD5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 23:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBC1618843FA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 22:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755892451F3;
	Tue, 10 Dec 2024 22:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2jnrstkL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Eni29Z82"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262B62451C3
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 22:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733869657; cv=none; b=LEugJccNCT+Gd05aH3K3IGawsSuIbRDM2tNgmIHUfvjdjsIaRNSVIP0P0kJJL4uuaW9dbPw9MNMRpGVw6B1+498/IgRqkOTP+gXsd3pIkUw7XT8pwQlFsqNcg25CTVRGamvPzknKQMNN3a1aG/xAbwEhRZi0v6Ljxr4DL7g9C1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733869657; c=relaxed/simple;
	bh=oI5Wv3SQUuxtwKDGlOH1HmQBxdy7pECKfwozCj9lLsE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MYljI8iovNBvcG0jKBl3FVNKaodlBsuZL3YFjw/E1anX7i5ESqra7rPPg9/1QHigYC6zXdyI+/3G+smSwGBj4Ffpjd10My03n8QE+lFN2NHdkt5bcS4oHHINlU2UQpu8IpbMo2jCFfWvLuqPGEeNlb++XsFc9xBtoaVSQIIXo2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2jnrstkL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Eni29Z82; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733869652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mpDF44urF3ROvcdxwxcr1K36mH6V2lpUOgpiztAj7fE=;
	b=2jnrstkLM7iHJVuUzgPGuPJS5hXnDQosYdskM2GTnPxRi0436EFxPzeXw0R7t/CoDeS08g
	iTTjmSwWA3oGlHfHTbFEnEFdd4SkCNgdI55cjEsLK3b4qFd+/appsuSabilFi3c7CRfQ8F
	L+mzmYM6nKex1WMDUFBaeDxSSzipVilSsfHrBLai6aO1yf5cJAbZxAcJZp+DQZV5n7cKRD
	mZEbWcy5KWQqP0i1NXnaCnXhe1OL7UeXwfkN3hBXgkJdKLctpODOEteReTh9Cow0tJG+5V
	wRzlPvigcJAZHzXvuKmyezcsvppPASjdlX1hUrIpQrPqduXA/Kc4DJDNTV5Bbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733869652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mpDF44urF3ROvcdxwxcr1K36mH6V2lpUOgpiztAj7fE=;
	b=Eni29Z82OpzO492YenUjDO2hXVbiC14mocwtw34NeMo6V63E4Oy0GjOnRIq4ZN5mn6RdHC
	24jA29BGHnyD2ECQ==
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org
Cc: =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>, Darren Hart
 <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar
 <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>, Valentin Schneider <vschneid@redhat.com>, Waiman
 Long <longman@redhat.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>
Subject: Re: [PATCH v4 06/11] futex: Allow to re-allocate the private hash
 bucket.
In-Reply-To: <20241203164335.1125381-7-bigeasy@linutronix.de>
References: <20241203164335.1125381-1-bigeasy@linutronix.de>
 <20241203164335.1125381-7-bigeasy@linutronix.de>
Date: Tue, 10 Dec 2024 23:27:32 +0100
Message-ID: <8734ivcgx7.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Dec 03 2024 at 17:42, Sebastian Andrzej Siewior wrote:
> +static void futex_put_old_hb_p(struct futex_hash_bucket_private *hb_p)
> +{
> +	unsigned int slots = hb_p->hash_mask + 1;
> +	struct futex_hash_bucket *hb;
> +	DEFINE_WAKE_Q(wake_q);
> +	unsigned int i;
> +
> +	for (i = 0; i < slots; i++) {
> +		struct futex_q *this;
> +
> +		hb = &hb_p->queues[i];
> +
> +		spin_lock(&hb->lock);
> +		plist_for_each_entry(this, &hb->chain, list)
> +			wake_q_add(&wake_q, this->task);
> +		spin_unlock(&hb->lock);
> +	}
> +	futex_hash_priv_put(hb_p);
> +
> +	wake_up_q(&wake_q);

So you wake up all queued waiters and let themself requeue on the new
hash.

How is that safe against the following situation:

    CPU 0                               CPU 1
    hb_p_old = mm->futex_hash_bucket;   hbp = mm->futex_hash_bucket;
    mm->futex_hash_bucket = new;
                                        // Referrence count succeeds!
                                        rcuref_get(&hpb->refcnt);
    futex_put_old_hb_p();
                                        // Queues on old hash and
                                        // is lost forever
                                        queue(hbp);

This scheme simply cannot work unless you take the rwsem read in the
wait path, which is a horrible idea. Aside of that taking the rwsem in
various code paths is counterproductive. For a big process where threads
operate on different locks heavily, you introduce a 'global'
serialization for no good reason.

I still think that the basic principle for any of this is to hold the
reference count only accross the actual hash bucket related operations
and not keep it accross schedule.

That obviously means that the hash bucket pointer is invalid after such
an operation block and needs re-evaluation if needed again, but that's
not the end of the world.

Let's look at wait() again:

wait()
{
retry:
        hb = hb_get_and_lock(key);	// Aqcuires a reference
        ret = futex_get_value_locked();
        if (ret) {
        	hb_unlock_and_put(hb);	// Drops the reference
                ...
                if (...)
                	goto retry;

        queue(hb, q, ...);
       	hb_unlock_and_put(hb);          // Drops the reference

        schedule();

        unqueue(q);                     // Does not require hb
}

Why does unqueue() work w/o a hash bucket reference?

unqueue(q)
{
retry:
	lock_ptr = READ_ONCE(q->lock_ptr);
        // Wake up ?
        if (!lock_ptr)
                return 0;

        spin_lock(lock_ptr);

        // This covers both requeue and rehash operations
        if (lock_ptr != q->lock_ptr) {
        	spin_unlock(lock_ptr);
                goto retry;
        }

        __unqueue(q);
        spin_unlock(lock_ptr);
}

Nothing in unqueue() requires a reference on the hash. The lock pointer
logic covers both requeue and rehash operations. They are equivalent,
no?

wake() is not really different. It needs to change the way how the
private retry works:

wake_op()
{
retry:
        get_key(key1);
        get_ket(key2);

retry_private:
        double_get_and_lock(&hb1, &hb2, &key1, &key2);
        .....
        double_unlock_and_put(&hb1, &hb2);
        .....
}

Moving retry private before the point where the hash bucket is retrieved
and locked is required in some other place too. And some places use
q.lock_ptr under the assumption that it can't change, which probably
needs reevaluation of the hash bucket. Other stuff like lock_pi() needs
a seperation of unlocking the hash bucket and dropping the reference.

But that are all minor changes.

All of them can be done on a per function basis before adding the actual
private hash muck, which makes the whole thing reviewable. This patch
definitely does not qualify for reviewable.

All you need are implementations for hb_get_and_lock/unlock_and_put()
plus the double variants and a hash_put() helper. Those implementations
use the global hash until all places are mopped up and then you can add
the private magic in exatly those places

There is not a single place where you need magic state fixups in the
middle of the functions or conditional locking, which turns out to be
not sufficient.

The required helpers are:

hb_get_and_lock(key)
{
        if (private(key))
        	hb = private_hash(key);		// Gets a reference
        else
                hb = hash_bucket(global_hash, key);
        hb_lock(hb);
        return hb;
}

hb_unlock_and_put(hb)
{
        hb_unlock(hb);
        if (private(hb))
        	hb_private_put(hb);
}

The double lock/unlock variants are equivalent.

private_hash(key)
{
        scoped_guard(rcu) {
 	       hash = rcu_deref(current->mm->futex.hash);
               if (rcuref_get(hash->ref))
               		return hash_bucket(hash, key);
	}
      
        guard(mutex)(current->mm->futex.hash_mutex);

        // Did reallocation win the race for the mutex ?
        hash = current->mm->futex.hash;
        if (!rcuref_get(hash->ref) {
        	hash = realloc_or_restore_hash();
                rcuref_get(hash);
        }
        return hash_bucket(hash, key);
}

hb_private_put(hb)
{
        hash = priv_hash(hb);
        hash_putref(hash);
}

hash_putref(hash)
{
        // Has fork dropped the initial reference to signal
        // that reallocation is required?
        //
        // If so, the last user hits the dead state
        if (!rcuref_put(&hash->ref))
        	return;

        guard(mutex)(current->mm->futex.hash_mutex);
	realloc_or_restore_hash();
}

realloc_or_restore_hash()
{
        old_hash = current->mm->futex.hash;
        new_hash = alloc_hash(current->mm->users);
        if (!new_hash) {
                // Make the old hash alive again
        	rcuref_init(old_hash->ref, 1);
                return cur_hash;
        }

        rehash(new_hash, old_hash);
        rcu_assign_pointer(current->mm->futex.hash, new_hash);
        rcu_free(old_hash);
}

rehash(new_hash, old_hash)
{
        // old_hash is marked dead, so new waiters cannot queue
        // themself and are stuck on the hash_mutex.

        for (i = 0; i < old_hash->size; i++) {
		hb1 = &old_hash->queues[i];

                // Protect the old bucket against unqueue(), as it does
                // not try to get a reference on the hash bucket. It
                // solely relies on q->lock_ptr.
                spin_lock(&hb1->lock);

		plist_for_each_entry_safe(q, tmp, hb1, list) {
			hb2 = hash_bucket(new_hash, &q->key);
			// Nesting is safe as this is a one time operation
                        spin_lock_nested(&hb2->lock);

                        plist_del(&q->list, &hb->chain);

                        // Redirect the lock pointer to the new hash
                        // bucket. See unqueue().
			q->lock_ptr = &hb2->lock;

                        plist_add(&q->list, &hb->chain);
                }
        }
}

fork()
{
        if (hash_needs_resize())
        	hash_putref(mm->futex.hash);
}

That should just work unless I'm missing something important. The charm
of utilizing rcuref for this is that there is close to zero impact on
the hotpaths, unless there is actually a reallocation in progress, which
is a rare event and applications can work around that by allocating the
appropriate hash size upfront.

Thanks,

        tglx



