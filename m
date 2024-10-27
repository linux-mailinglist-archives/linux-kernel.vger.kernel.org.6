Return-Path: <linux-kernel+bounces-383589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BB09B1DA4
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 13:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA7221C20A3E
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 12:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE591442F4;
	Sun, 27 Oct 2024 12:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M0QWY4C8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Rwbf7BkK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4B425765
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 12:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730031599; cv=none; b=iNFTzAKGTAsiQr7M7jU+2FBXj5gBxr967+5LIDJq0rpNYyEVdoo8jHorme1akISqhVOQRldh6qTWwXnofkJzAjLFuRsaZikGwgTg+RB7hvQZsZ/8zNpbP5ZKMLiZV1YdnClE4NqUoj8S0spz195WrREFR32WAieaExtJy/djuXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730031599; c=relaxed/simple;
	bh=YQ7azCnxaImPcCIewOCvGbk4jEe5p2xk6IdqYkN9Geg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WzzZmmjDf7paq+LPRf/u5rgcNzDwFePT8AEdgPYbpDCMjGpxv9rSpCjDCFcR9xNKK58R2ZQi85dYL3g+0z7uTuVDoIdyIr8Ty1opLaDIG3mFE88BLNDWVnuEc72xrInAntf5nt7+8CScXcAstkF6QuJ20RtWU3M4LmXSmqHpUrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M0QWY4C8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Rwbf7BkK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730031595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NDP3AQMMEBCfoAbRnh/VrgKt1eBjGpE/RoJHgMjzps0=;
	b=M0QWY4C8eMlcA/muBzTGKFhPFqOQVvvsQRBS/JptQYYmPtzIKL+CDkwzJMzaTbfu7B5oNW
	xsKRELghKdVoI1funHMa94fycDN8bhvQ2e80rZ3TB8oRINwinB537YjLcY9vWQwtYFMvFI
	FYCa/HeDdu6eoGWs/qAzaBrKF5+Mwoo0fMAaXpZ5qg3THyorD7EqE2sCwX6UIrff6lQYXj
	GM0va0DxyzG+fXQEDJ1pPvKK746i3x5h5ikCqzqVaLgkCpJ7L7t+agKodUDGodaQv5TTOo
	v8s1GqJE8b2W85n9nA18Fva5HrZglfETtmO84Eq0xr0ZQzg3XjVyMWi+v7L0tA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730031595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NDP3AQMMEBCfoAbRnh/VrgKt1eBjGpE/RoJHgMjzps0=;
	b=Rwbf7BkK3Zxu3O0uWvi9Xl244FzPbIG2wa5gGtxwVg2wxxZCIB0psrbJziLCDtUeZZtLS5
	aAvKLeaOxfU4QyCg==
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org
Cc: =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>, Darren Hart
 <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar
 <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>, Valentin Schneider <vschneid@redhat.com>, Waiman
 Long <longman@redhat.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>
Subject: Re: [RFC PATCH 2/3] futex: Add basic infrastructure for local task
 local hash.
In-Reply-To: <20241026224306.982896-3-bigeasy@linutronix.de>
References: <20241026224306.982896-1-bigeasy@linutronix.de>
 <20241026224306.982896-3-bigeasy@linutronix.de>
Date: Sun, 27 Oct 2024 13:19:54 +0100
Message-ID: <87cyjl4u1h.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Oct 27 2024 at 00:34, Sebastian Andrzej Siewior wrote:
>  static void futex_cleanup(struct task_struct *tsk)
>  {
> +	struct futex_hash_table *fht;
> +	bool need_free = false;
> +
>  	if (unlikely(tsk->robust_list)) {
>  		exit_robust_list(tsk);
>  		tsk->robust_list = NULL;
> @@ -1054,6 +1064,23 @@ static void futex_cleanup(struct task_struct *tsk)
>  
>  	if (unlikely(!list_empty(&tsk->pi_state_list)))
>  		exit_pi_state_list(tsk);
> +
> +	rcu_read_lock();
> +	fht = rcu_dereference(current->futex_hash_table);
> +	if (fht) {
> +
> +		spin_lock(&fht->lock);

I don't think you need a spin lock for this.

> +		fht->users--;
> +		WARN_ON_ONCE(fht->users < 0);
> +		if (fht->users == 0)
> +			need_free = true;
> +		spin_unlock(&fht->lock);
> +		rcu_assign_pointer(current->futex_hash_table, NULL);
> +	}
> +	rcu_read_unlock();

	scoped_guard (rcu) {
        	fht = rcu_dereference(current->futex_hash_table);
                if (fht && rcuref_put_rcusafe(&fht->refcnt)
			rcu_assign_pointer(current->futex_hash_table, NULL);
                else
                        fht = NULL;
	}
	kfree_rcu_mightsleep(fht);

Hmm? But see below

> +static int futex_hash_allocate(unsigned long arg3, unsigned long arg4,
> +			       unsigned long arg5)
> +{
> +	unsigned int hash_slots = arg3;
> +	struct futex_hash_table *fht;
> +	size_t struct_size;
> +	int i;
> +
> +	if (hash_slots == 0)
> +		hash_slots = 4;
> +	if (hash_slots < 2)
> +		hash_slots = 2;
> +	if (hash_slots > 16)
> +		hash_slots = 16;
> +	if (!is_power_of_2(hash_slots))
> +		hash_slots = rounddown_pow_of_two(hash_slots);
> +
> +	if (current->futex_hash_table)
> +		return -EALREADY;

You also need to check whether a hash table exists already in the
process. The table must be process shared to make sense. So it should
live in current->signal, which is a valid pointer in the context of
current.

So this needs some more thoughts especially vs. automatic creation and
sharing.

The first question is whether the hash table might have been already
created when the application reaches main(). If so then this call will
fail.

To make this work correctly, this needs proper serialization as well.

Assume a situation where the application does not allocate a table
upfront and the first futex use happens late when threads are running
already.

CPU0                            CPU1
T1                              T2        
sys_futex()                     sys_futex()
  create_hash()                   create_hash()

So T1 and T2 create their local hash and the subsequent usage will fail
because they operate on different hashs. You have the same problem
vs. your allocation scheme when two threads do prctl(ALLOC). We really
want to make this as simple as possible.

sys_futex()
   ...
   if (private)
      hash = private_hash(current);
   else
      hash = &global_hash;

private_hash()
   hash = READ_ONCE(current->signal->futex_hash);
   if (hash)
      return hash;
       
   guard(spinlock_irq)(&task->sighand->siglock);
   hash = current->signal->futex_hash;
   if (hash))
   	 return hash;

   hash = alloc_hash();
   WRITE_ONCE(current->signal->futex_hash, hash);
   return hash;

alloc_hash()
   if (!local_hash_enabled)
   	return &global_hash;
   hash = alloc();
   return hash ?: &global_hash;

futex_cleanup_hash()
   scoped_guard(spinlock_irq, &current->sighand->siglock) {
       	hash = current->signal->futex_hash;
        if (!hash || current->signal->nr_threads > 1)
           return;

        current->signal->futex_hash = NULL;
	if (hash == &global_hash)
           return;
   }

   kfree_rcu_mightsleep(hash);

Or something like that.

Thanks,

        tglx

