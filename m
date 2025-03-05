Return-Path: <linux-kernel+bounces-546221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7DDA4F7E8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 08:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 246371891458
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 07:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8541E5B77;
	Wed,  5 Mar 2025 07:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LOBOfodC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UEwvgAjg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A0586324
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 07:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741159886; cv=none; b=mtvAZVU5pdQgCbPshwsBcCPCv1jKiTJuwf964EjXXY48D0sOz4z9/sTyfnKG5ktPEE1rpRxnqfCKsacnieRgP2/rIwpe/1JHWE+KwyQB9rgJBw+3oYiw1BlQvlP4CBuN5YDdcdD+K+dpn6bENKjaaN0IvKGmUShjsJ6tm+KxFlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741159886; c=relaxed/simple;
	bh=h1ukL8h+idcHbYmFwGUozNuabQ0xV65z3NJ9fuWnrd4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a5GkV+jMcrfkT2EGzWlLmw8XJDAnG878Gs+HJ0S9FF4drHM6aaG5QH4SN3/fVM/V8FnfWeDt8mxJeAIirKEaD5utMcTjx8P6oEtDyQ7a1dCm70i20vS99KknMSEEiQPtU0evzs9grEcVTzqS8hzqkZZPwxYF4XioZA05YgYv2aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LOBOfodC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UEwvgAjg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741159882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nv6VQH3XVI7rHHwM0E+Y/dVIwpHwxGqTFlb/SG6F8Io=;
	b=LOBOfodCqnd92Z8A2vYc6SRrWQI/FE/5NsHviZjpaRhqw+RrVK/cHEA7bKGI4zAsTEKhZJ
	omstvC+6TxtPcsMdP45E1ROvpNJ/Win2QoFpXuHdg6vqeIAtJO62KdU5Ps8JORyOBiV3gG
	D6IT5BbHCyXuDnPrIrP5b4KG2G3qlCGJrFT3L2fWcWi91Lckma+YWILmJq3dulTNW2TcoK
	T3klLolqrxnUy8/wQGDiBNjknsKCI0W8KnwYDJYYPwWuZCteCMs4wdzjlKh2FUug1m6yp8
	KGfc3Gj+gM5KVFqyy0tKdKlHisjhSHjKoNZb+GpfBEtD1L/XWfxwog4YffE2Wg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741159882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nv6VQH3XVI7rHHwM0E+Y/dVIwpHwxGqTFlb/SG6F8Io=;
	b=UEwvgAjgKP6ja3o8UtuXYJuJBDQrGK/kQXlrxJpWG5InQDcRyx3W+oSEKsCNbysIZhH3NJ
	Y3fpw0+/diVY5jDw==
To: Cyrill Gorcunov <gorcunov@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>,
 Benjamin Segall <bsegall@google.com>, Eric Dumazet <edumazet@google.com>,
 Andrey Vagin <avagin@openvz.org>, Pavel Tikhomirov
 <ptikhomirov@virtuozzo.com>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch V2 10/17] posix-timers: Make
 signal_struct::next_posix_timer_id an atomic_t
In-Reply-To: <Z8d7tm5dQN6dZEvu@grain>
References: <20250302185753.311903554@linutronix.de>
 <20250302193627.543399558@linutronix.de> <Z8YPQn0UpxucZLJP@grain>
 <87sentbyer.ffs@tglx> <Z8c-vvnMpPjYRvOn@grain> <87mse05yk3.ffs@tglx>
 <Z8d7tm5dQN6dZEvu@grain>
Date: Wed, 05 Mar 2025 08:31:21 +0100
Message-ID: <87ikoo53xy.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Mar 05 2025 at 01:16, Cyrill Gorcunov wrote:
> Thanks for handling this) Also looking into this series I wonder why can't
> we instead of mangling ::it_signal zero bit just use ::it_id with negative
> value as a sign of not yet fully initialized timer? This would allow to not
> read-modify action while traversing bucket hash chain. I mean we could do
>
> static bool posix_timer_add_at(struct k_itimer *timer, struct signal_struct *sig, unsigned int id)
> {
> 	struct timer_hash_bucket *bucket = hash_bucket(sig, id);
>
> 	scoped_guard (spinlock, &bucket->lock) {
> 		if (!posix_timer_hashed(bucket, sig, id)) {
> --->			timer->it_id = -(timer_t)id;
> 			timer->it_signal = (struct signal_struct *)((unsigned long)sig | 1UL);
> 			hlist_add_head_rcu(&timer->t_hash, &bucket->head);
> 			return true;
> 		}
> 	}
> 	return false;
> }
>
> Then hash traverse won't find the timer until the do_timer_create will do
>
> 	scoped_guard (spinlock_irq, &current->sighand->siglock) {
> 		WRITE_ONCE(new_timer->it_id, abs(new_timer->it_id));
> 		hlist_add_head_rcu(&new_timer->list, &current->signal->posix_timers);
> 	}
>
> Or I miss something obvious? (Of course when deleting timer we will have to pass
> abs it_id for hash traversing).
>
> It looks that in case of many many timers present in the system traversing hash
> in read-modify way might be heavy (though I didn't measure of course).

The traversal does not RMW the timer itself, it unmangles the signal
pointer for comparison in posix_timer_hashed(). posix_timer_by_id() does
straight comparisons. So both only read.

Sure, we can mangle timer ID instead of the signal pointer, but the
outcome is pretty much the same. The only difference is in
posix_timer_hashed(), which must detect a taken timer ID independent of
the timers valid state to prevent collisions.

With the signal pointer mangling we have:

   if ((timer->signal & ~1) == sig && timer->id == id)

and with the negative ID value this becomes:

   if (timer->signal == sig && (timer->id == id || timer->id == -id))

which is obviously worse. You'd need to do:

      timer->id = id | (1 << 31);

and then the posix_timer_hashed() check becomes:

   if (timer->signal == sig && (timer->id & ~(1 << 31)) == id)

Granted, the timer ID mangling spares the AND operation on the signal in
case the timer is not owned by the currrent process, but I doubt that
this is even measurable.

Thanks,

        tglx

