Return-Path: <linux-kernel+bounces-447960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A46C09F393B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 19:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5C6216A454
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 18:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31BA20764E;
	Mon, 16 Dec 2024 18:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Cv2POJKu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gEBIWvvc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92744206F19
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 18:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734374897; cv=none; b=YKoioJ21Kd7AtBxBC6gXgYb4sOj1YjpZXVnOhapAvCvtCd0LyOVYGn4b+WDruVldiWh7/a9u+qD3TYdVLkwG7EjlRPkTLd9BxL7defbU/faya0Fmj2/zpxGjVOvQObyJhfQjJCQDcNQ27+fLwmBjLHpPZuwBBuvIZovj0yy1BtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734374897; c=relaxed/simple;
	bh=Q7wkvJLnrrcwdHrPC9SrXsQNlKtuizmmonOp7ufhVoc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AdL3/nm5QcxSCEC2jU3UXZHvVM8ODikbLyMJ6mxaNanWByHqrt2HuvCyeA2iIeC3JWgAU9fNSsjcRsQTZCUd7JgVLTK1MugT5o95Uk2+HG39p1isRNK7FgC1xMSC+BjdsMTVQuCvTWNFbTMASngRJZlUe7f8DEL/t4WkLNwJvkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Cv2POJKu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gEBIWvvc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734374887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nNm+kbLR+AwtgRjnsI0eiJWH7Z9SSugB6GpXdN42y9c=;
	b=Cv2POJKuvvXEjlWx9VweXe/Zh+Sz7Cwn5q9FdBbTFK4teItryuslOrS448hLIkkrtyt3Du
	/J+A7W2sgxQfzpMxnMv+V2QFI+zDBZAsV+XcoZrv0lCBndVklN0Oy6NtnNECHB8hLMH+mX
	EIIJRsA7uU6FX0d4a8M3hIe0gP6ovcxqsxIm2Q05+QMbnhMfLjI0ghdsVwnP7MyOB6P4uB
	vZXwdeBqBCA5MA4QtDVTTwF5TZyTHSwb5wTFWwBF/28czxFeUfjsLOtku+Qh+Wv/bNvKm8
	sZLIRV++r+HCfXUpbGd7HnGP8kns2wZKg+ui1qwDwIUaf/xTQ0xo47MiAfYyAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734374887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nNm+kbLR+AwtgRjnsI0eiJWH7Z9SSugB6GpXdN42y9c=;
	b=gEBIWvvcS2q8PxyTx3dl6Jl7FPxWfvlvTY6Op9GEaHW6zLNjrPzAzj5kBP3Vt2YapsMJl6
	4faNhumkQ4jKuAAA==
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org
Cc: =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>, Darren Hart
 <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar
 <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>, Valentin Schneider <vschneid@redhat.com>, Waiman
 Long <longman@redhat.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>
Subject: Re: [PATCH v5 06/14] futex: Add helper which include the put of a
 hb after end of operation.
In-Reply-To: <20241215230642.104118-7-bigeasy@linutronix.de>
References: <20241215230642.104118-1-bigeasy@linutronix.de>
 <20241215230642.104118-7-bigeasy@linutronix.de>
Date: Mon, 16 Dec 2024 19:48:07 +0100
Message-ID: <87wmfz79co.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Dec 16 2024 at 00:00, Sebastian Andrzej Siewior wrote:
> With the planned schema of resize of hb, a reference count will be
> obtained during futex_hash() and will be dropped after the hb is
> unlocked. Once the reference is dropped, the hb must not be used because
> it will disappear after a resize.
> To prepare the integration, rename
> - futex_hb_unlock() to futex_hb_unlock_put()
> - futex_queue() to futex_queue_put()
> - futex_q_unlock() to futex_q_unlock_put()
> - double_unlock_hb() to double_unlock_hb_put()
>
> which is additionally includes futex_hb_unlock_put(), an empty stub.
> Introduce futex_hb_unlock_put() which is the unlock plus the reference
> drop. Move futex_hb_waiters_dec() before the reference drop, if needed
> before the unlock.
> Update comments referring to the functions accordingly.

If I didn't know what you are talking about, it would have taken me a
while to decode the word salad above. It starts with the usage of 'hb',
an acronym which might be understandable for people familiar with the
futex code, but otherwise it's an arbitrary reference to nothing.

Assuming that 'hb' stands for hashbucket, the usage here is wrong:

      With the planned schema of resize of hb...

This is about resizing the hash not the hashbucket, right?

So something like this might be more to the point:

   futex: Prepare for reference counting of the process private hash

   To support runtime resizing of the process private hash, it's
   required to add a reference count to the hash structure. The
   reference count ensures that the hash cannot be resized or freed
   while a task is operating on it.

   The reference count will be obtained within futex_hash() and dropped
   once the hash bucket is unlocked and not longer required for the
   particular operation (queue, unqueue, wakeup etc.).

   This is achieved by:

    - appending _put() to existing functions so it's clear that they
      also put the hash reference and fixing up the usage sites

    - providing new helpers, which combine common operations (unlock,
      put), and using them at the appropriate places

    - providing new helper for standalone reference counting
      functionality and using them at places, where the unlock operation
      needs to be separate.
   
Hmm?
> -void futex_q_unlock(struct futex_hash_bucket *hb)
> +void futex_q_unlock_put(struct futex_hash_bucket *hb)
>  	__releases(&hb->lock)
>  {
>  	spin_unlock(&hb->lock);
>  	futex_hb_waiters_dec(hb);
> +	futex_hash_put(hb);

You missed a place to move the waiter_dec() before the unlock. Actually
this move should be in a separate preparatory patch, which does only
that. It also needs a proper change log which explains why this done,
why it is equivalent and not introducing a change in terms of ordering
rules. This:

> Move futex_hb_waiters_dec() before the reference drop, if needed
> before the unlock.

does not really give any clue at all.

>  		if (unlikely(ret)) {
> -			double_unlock_hb(hb1, hb2);
>  			futex_hb_waiters_dec(hb2);
> +			double_unlock_hb_put(hb1, hb2);

And having this move before the _put() change makes the latter a purely
mechanical change which let's the reader/reviewer focus on the reference
count rules and not be distracted by the waiter count changes.
  
> -	/* futex_queue and wait for wakeup, timeout, or a signal. */
> +	/* futex_queue_put and wait for wakeup, timeout, or a signal. */

When you fix up these comments, can you please use the fn() notation?

>  	futex_wait_queue(hb, &q, to);
>  
>  	/* If we were woken (and unqueued), we succeeded, whatever. */

Thanks,

        tglx

