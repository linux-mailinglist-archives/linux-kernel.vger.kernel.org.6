Return-Path: <linux-kernel+bounces-523165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1028CA3D2F7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 09:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08B11189BC98
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 08:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0725E1E9B06;
	Thu, 20 Feb 2025 08:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y0iH2cyh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Hw4/0TjS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EB51E47A9
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 08:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740039572; cv=none; b=g2hG/35mW8kHcQoL6qitvMMoU7IMLpas4bodL4Ti+UZhptQeLZJ5qZTrAKZksdpeDWSNC0S+T+YVgbK6Y0EIOmbxALt0i3naxQmk/hTRVytWsS0/AKgr3nnnN3EU42VpfCq6d6lbZGBVvr2tIrzkj+Ne9Kcr/rno30eJr75FCUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740039572; c=relaxed/simple;
	bh=AnxfGq1sBrpj+0AxbPEvMNfDTPZW33DoaXZnkynvupw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Zv6pvqSm/Ti4RWy7bxkspNdxeMHX83Ym9ROBKBUAf5Lf/Mt5Z8jwRMURq59zfNWcdXDuO/CcIa22tDfKRjMGeOPS/mw27qm+MWAM+/UnDxTaHisQlpl4WiTTayNwB8rXqRh93yPgmJ1aiD+UA0cbEbSQMSxAJrTFPWfHR9Wyt6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=y0iH2cyh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Hw4/0TjS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740039568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IBI/qr04EcfMpMz+CIEPlEAjb4rJHmUXuT6iedhH71Y=;
	b=y0iH2cyh3Ahm5fhmK8f1YNb1CvZmgEMUbwkM0iKBfdFuKUcqtvj+9ADA2t8f0DysmiHy0M
	23fWeR4Qz/Z6PgXvWEOQiIfJ1aR+ceAx7FRg+QE/jlm3BkwIXi+KJz98q8bkWcys/2Z4ee
	qQ0ErKVwppKNnmyqUPmYLPWqg8G0dlgjCMKqzCTXkhxPqoQri4Uo6UqWWn4qIlgAE6TCid
	Y+vEZz20X/QW8rKFc6NeZLoNhM2I9VBDXpzrlmFYDpPh9yuxl/4n9pEOF7X1ILaoEL9PpK
	54YMcVc35ubUkCUH2An2qUO5L7MyjgJf+ktNPyZuFxnEynW91HEjPKFYYMBniA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740039568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IBI/qr04EcfMpMz+CIEPlEAjb4rJHmUXuT6iedhH71Y=;
	b=Hw4/0TjSv/4cO8SzJ+1sDwFrmAd8PXYroJ1xfF7flOwaB69SyV1HIICgWLDsRPdGrDeTA2
	buig94TUdJNx9YBQ==
To: Eric Dumazet <edumazet@google.com>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Benjamin Segall
 <bsegall@google.com>, Eric Dumazet <eric.dumazet@gmail.com>, Eric Dumazet
 <edumazet@google.com>
Subject: Re: [PATCH V2 3/4] posix-timers: Initialise timer->it_signal in
 posix_timer_add()
In-Reply-To: <20250219125522.2535263-4-edumazet@google.com>
References: <20250219125522.2535263-1-edumazet@google.com>
 <20250219125522.2535263-4-edumazet@google.com>
Date: Thu, 20 Feb 2025 09:19:28 +0100
Message-ID: <87r03thvu7.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Feb 19 2025 at 12:55, Eric Dumazet wrote:
> Instead of leaving a NULL value in timer->it_signal,
> set it to the current sig pointer, but with the low order bit set.

And that low order bit set does what?

> This fixes a potential race, in the unlikely case a thread
> was preempted long enough that other threads created more than
> 2^31 itimers.

and then what happens?

> Rename __posix_timers_find() to posix_timers_find()

That's not what the patch does. It renames to posix_sig_owner(). Aside
of that the rename is not relevant to the problem itself.

> Mask the low order bit in posix_timers_find().

What for?

I pointed you before to the changelog documentation, which clearly says:

  A good structure is to explain the context, the problem and the
  solution in separate paragraphs and this order.

It's not asked too much to write proper change logs.

> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  kernel/time/posix-timers.c | 28 +++++++++++++++++++++-------
>  1 file changed, 21 insertions(+), 7 deletions(-)
>
> diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
> index 1f73ea955756..ed27c7eab456 100644
> --- a/kernel/time/posix-timers.c
> +++ b/kernel/time/posix-timers.c
> @@ -72,15 +72,22 @@ static int hash(struct signal_struct *sig, unsigned int nr)
>  	return hash_32(hash32_ptr(sig) ^ nr, HASH_BITS(posix_timers_hashtable));
>  }
>  
> -static struct k_itimer *__posix_timers_find(struct hlist_head *head,
> +static struct signal_struct *posix_sig_owner(const struct k_itimer *timer)
> +{
> +	/* timer->it_signal can be set concurrently */
> +	unsigned long val = (unsigned long)READ_ONCE(timer->it_signal);
> +
> +	return (struct signal_struct *)(val & ~1UL);
> +}
> +
> +static struct k_itimer *posix_timers_find(struct hlist_head *head,
>  					    struct signal_struct *sig,
>  					    timer_t id)
>  {
>  	struct k_itimer *timer;
>  
>  	hlist_for_each_entry_rcu(timer, head, t_hash, lockdep_is_held(&hash_lock)) {
> -		/* timer->it_signal can be set concurrently */
> -		if ((READ_ONCE(timer->it_signal) == sig) && (timer->it_id == id))
> +		if ((posix_sig_owner(timer) == sig) && (timer->it_id == id))
>  			return timer;
>  	}
>  	return NULL;
> @@ -90,8 +97,14 @@ static struct k_itimer *posix_timer_by_id(timer_t id)
>  {
>  	struct signal_struct *sig = current->signal;
>  	struct hlist_head *head = &posix_timers_hashtable[hash(sig, id)];
> +	struct k_itimer *timer;
>  
> -	return __posix_timers_find(head, sig, id);
> +	hlist_for_each_entry_rcu(timer, head, t_hash) {
> +		/* timer->it_signal can be set concurrently */
> +		if ((READ_ONCE(timer->it_signal) == sig) && (timer->it_id == id))
> +			return timer;
> +	}
> +	return NULL;
>  }
>  
>  static int posix_timer_add(struct k_itimer *timer)
> @@ -113,8 +126,9 @@ static int posix_timer_add(struct k_itimer *timer)
>  		head = &posix_timers_hashtable[hash(sig, id)];
>  
>  		spin_lock(&hash_lock);
> -		if (!__posix_timers_find(head, sig, id)) {
> +		if (!posix_timers_find(head, sig, id)) {
>  			timer->it_id = (timer_t)id;
> +			timer->it_signal = (struct signal_struct *)((unsigned long)sig | 1UL);
>  			hlist_add_head_rcu(&timer->t_hash, head);
>  			spin_unlock(&hash_lock);
>  			return id;
> @@ -453,7 +467,7 @@ static int do_timer_create(clockid_t which_clock, struct sigevent *event,
>  	}
>  	/*
>  	 * After succesful copy out, the timer ID is visible to user space
> -	 * now but not yet valid because new_timer::signal is still NULL.
> +	 * now but not yet valid because new_timer::signal low order bit is 1.
>  	 *
>  	 * Complete the initialization with the clock specific create
>  	 * callback.
> @@ -463,7 +477,7 @@ static int do_timer_create(clockid_t which_clock, struct sigevent *event,
>  		goto out;
>  
>  	spin_lock_irq(&current->sighand->siglock);
> -	/* This makes the timer valid in the hash table */
> +	/* This makes the timer valid in the hash table, clearing low order bit. */

Clearing the low order bit of what? This is a full write and not a clear
low order bit operation.

>  	WRITE_ONCE(new_timer->it_signal, current->signal);
>  	hlist_add_head(&new_timer->list, &current->signal->posix_timers);
>  	spin_unlock_irq(&current->sighand->siglock);

Thanks,

        tglx

