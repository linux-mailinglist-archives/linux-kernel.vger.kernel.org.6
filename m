Return-Path: <linux-kernel+bounces-518254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A56A38C50
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 20:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F7BC3A438E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 19:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A963D237160;
	Mon, 17 Feb 2025 19:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z2ZY2fL7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H79F0NQM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A65137C35
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 19:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739820266; cv=none; b=i1t6h3G83rgDSnd9hpODUZZ4P6B+EmbBORbJ4+tZXRnFgASvWT7mn2oThrlGpcQXqdh1b3Qcl6OFyE42vyMv1nPtxis/pNVldMDFJtkPgIsPF8TWRua9Ry27Hd5zXT2zmZIVffyquHurH3m+dBknA/oIJD+9HgdLcxB2nQr9694=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739820266; c=relaxed/simple;
	bh=vIHTqWK9j9WXAjFmq9OEgy21vKZqc1YLHLOMuyhPLuE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=OplgLQEPHNOfFKR5QQeR1RqOimLKdVfG1he/FHh4fJY7BNQsYr8+1A5BIGwVHfqBOtP0j4857mM8aNwkUcBHIzUhUofvH/egdzJHagxNBTASuG3RIS5JhwJcRNlKaADb1XlAokEaslv0eD+slD6ium7Xk4bNLCob/wxCK1E1x6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z2ZY2fL7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H79F0NQM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739820262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=/TqzQth2rHU6nrGSCz9iEL/Qi0I5ib2q/ViqqbFc1Vs=;
	b=z2ZY2fL7WMmRIZflRjKEd+B00QvJ9IyYv/q5jUAqFWs6D8aObKrvlfRi/sqYNs6DAkBeQQ
	n9fW79OKJ39n/o9sNI92eihKVL7ZTuExMNxO3UPzy/4ej0wc08HgCqxWj4u1o1oQXEB/nO
	f64E1h3HRTUFn+dRQnb+kPjwucrLWaAmD88+Va91E7DfpsELgWrIR7Ma85FUD6MTApTjGo
	QGwhDnhZ8T5JjXU0nCEplsYSAt1c/R9125xaw1Im7EHIz4S1sYg20ehg+gIG9H/OZJ6mil
	oGbtdrPfDpxXopFWea00BLtkMDc4kD5IOKnXgf/8N7SR6g3LoyP1rGu1J2CT9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739820262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=/TqzQth2rHU6nrGSCz9iEL/Qi0I5ib2q/ViqqbFc1Vs=;
	b=H79F0NQMgipcsXcJjy1vlxbNIE1HnanJ/mzm6ZHeeFRT7b5nb4E+nrW5WUnMogalg7CIgA
	Wg9RPp5p3Dz0BaDg==
To: Eric Dumazet <edumazet@google.com>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Benjamin Segall
 <bsegall@google.com>, Eric Dumazet <eric.dumazet@gmail.com>, Eric Dumazet
 <edumazet@google.com>, Andrey Vagin <avagin@openvz.org>, Pavel Tikhomirov
 <ptikhomirov@virtuozzo.com>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/2] posix-timers: Use RCU in posix_timer_add()
In-Reply-To: <20250214135911.2037402-3-edumazet@google.com>
Date: Mon, 17 Feb 2025 20:24:21 +0100
Message-ID: <87o6z0jrx6.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Feb 14 2025 at 13:59, Eric Dumazet wrote:

> If many posix timers are hashed in posix_timers_hashtable,
> hash_lock can be held for long durations.
>
> This can be really bad in some cases as Thomas
> explained in https://lore.kernel.org/all/87ednpyyeo.ffs@tglx/

I really hate the horrible ABI which we can't get rid of w/o breaking
CRIU.

The global hash really needs to go away and be replaced by a per signal
xarray. That can be done, but due to CRIU there is no way to make this
non-sparse by reusing holes, which are created by deleted timers.

The sad truth is that the kernel has absolutely zero clue that this
happens in a CRIU restore operation context, unless I'm missing
something.

If it would be able to detect it, then we could work around it
somehow. But without that there is not much we can do aside of breaking
the ABI.

Though in the above thread the CRIU people already signaled that they
are willing to work out a migration scheme. I just forgot to revisit
this. Let me stare at it some more.

> We can perform all searches under RCU, then acquire
> the lock only when there is a good chance to need it,
> and after cpu caches were populated.
>
> I also added a cond_resched() in the possible long loop.

https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#changelog

> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  kernel/time/posix-timers.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
> index 204a351a2fd3..dd2f9016d3dc 100644
> --- a/kernel/time/posix-timers.c
> +++ b/kernel/time/posix-timers.c
> @@ -112,7 +112,19 @@ static int posix_timer_add(struct k_itimer *timer)
>  
>  		head = &posix_timers_hashtable[hash(sig, id)];
>  
> +		rcu_read_lock();
> +		if (__posix_timers_find(head, sig, id)) {
> +			rcu_read_unlock();
> +			cond_resched();
> +			continue;
> +		}
> +		rcu_read_unlock();
>  		spin_lock(&hash_lock);
> +		/*
> +		 * We must perform the lookup under hash_lock protection
> +		 * because another thread could have used the same id.

Hmm, that won't help and is broken already today as timer->id is set at
the call site after releasing hash_lock.

> +		 * This is very unlikely, but possible.

Only if the process is able to install INT_MAX - 1 timers and the stupid
search wraps around (INT_MAX loops) on the other thread and ends up at
the same number again. But yes, theoretically it's possible. :)

So the timer ID must be set _before_ adding it to the hash list, but
that wants to be a seperate patch.

> +		 */
>  		if (!__posix_timers_find(head, sig, id)) {
>  			hlist_add_head_rcu(&timer->t_hash, head);
>  			spin_unlock(&hash_lock);

Thanks,

        tglx

