Return-Path: <linux-kernel+bounces-440159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4369EB991
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 19:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A9CB188627C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 18:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BBF226883;
	Tue, 10 Dec 2024 18:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yErILQKC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4obryJTV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F7A21421C
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 18:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733856360; cv=none; b=nToihP1lq9Ei7VpfBG6K0sCpVykDYnOPYCjTM2CQCqJWVlxgIHNYVAMDPOj+zBwnytM1QHXnpl491LQ3fso1ooNmsPLGYaiZwRKRt4qkaRsT2DVjsPccu8ZcWZzphe+1w9uLcldKCXzEtwMvER1wph2+t/Q/cljxMma+BikHW7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733856360; c=relaxed/simple;
	bh=4miuncITiXk84unFNzyl4D3ZJsGhSaGcGXn3L7TveOY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RbYcHO5QJ7PG9h0AAFwVcdC237gxELmQk69x4MTel+y6c5zoDJhIDUN0ww/lkdClTYoQPlY1eMyy5Ti1haYuAFkKBt/oP7noePnrNCh1azLe5eSAVfGnCIi7UfnK3Uh8cunPj+GnuSQihP3gjhU225QAfKR7caMuRZMi2IwJWSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yErILQKC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4obryJTV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733856356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LpSJ/4fjpGCpsxAcyDPRCSRkef4FRPQxJKLbfG0zCN4=;
	b=yErILQKC+AUJ77ifvDc9m9gUoDZdXlrsXH0ETnrzhvjhRVGDSV9QgcXBu4iashnfP11JXN
	d9Bjp7t7CSlN1lko1Tpwf4Gf8pODZM/riicDFj6lmSCen2bSm4DqBOrMdT5onm6Q03lMap
	K3sv73KQyGtJfmVphYC8eLY8uJvuPSH4KObEJbSyZF5ZKl12HDEmu2ihDcDYvfwRdzHBya
	6Fyj1b6Tu1J7bORGn0wzjIZDXLDGhpW2vUARYCfWdZZj8tgafr/Fn5m22H2/+E7SPWFSfA
	4gr9SCqlSLcdUrG/u4HEcZeOZu7DbCa6whFhINNocMymJghxMNR874DsDEtBHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733856356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LpSJ/4fjpGCpsxAcyDPRCSRkef4FRPQxJKLbfG0zCN4=;
	b=4obryJTVME5TL7a9LpOP0ZEyPrVKEb5+cffU2jME6BBTIpZj9VfVMoPP/dileL87sIdWXl
	mWZpNRRWb+BHRAAA==
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org
Cc: =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>, Darren Hart
 <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar
 <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>, Valentin Schneider <vschneid@redhat.com>, Waiman
 Long <longman@redhat.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>
Subject: Re: [PATCH v4 05/11] futex: Track the futex hash bucket.
In-Reply-To: <20241203164335.1125381-6-bigeasy@linutronix.de>
References: <20241203164335.1125381-1-bigeasy@linutronix.de>
 <20241203164335.1125381-6-bigeasy@linutronix.de>
Date: Tue, 10 Dec 2024 19:45:56 +0100
Message-ID: <87a5d3cr6j.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Dec 03 2024 at 17:42, Sebastian Andrzej Siewior wrote:
> Add futex_hash_get/put() to keep the assigned hash_bucket around while a
> futex operation is performed. Have RCU lifetime guarantee for
> futex_hash_bucket_private.
>
> This is should have the right amount of gets/ puts so that the private

This is should have? This either has or not :)

>  struct futex_hash_bucket *futex_hash(union futex_key *key)
>  {
> -	struct futex_hash_bucket *fhb;
> +	struct futex_hash_bucket_private *hb_p = NULL;
>  	u32 hash;
>  
> -	fhb = current->mm->futex_hash_bucket;
> -	if (fhb && futex_key_is_private(key)) {
> -		u32 hash_mask = current->mm->futex_hash_mask;
> +	if (futex_key_is_private(key)) {
> +		guard(rcu)();
> +
> +		do {
> +			hb_p = rcu_dereference(current->mm->futex_hash_bucket);
> +		} while (hb_p && !rcuref_get(&hb_p->users));

This loop really wants an explanation about the potential loop
duration.

> +void futex_hash_put(struct futex_hash_bucket *hb)
> +{
> +	struct futex_hash_bucket_private *hb_p;
> +
> +	if (hb->hb_slot == 0)
> +		return;
> +	hb_p = container_of(hb, struct futex_hash_bucket_private,
> +			    queues[hb->hb_slot - 1]);

Duh. This off by one abuse of hb_slot is really counter intuitive. It
took me a while to wrap my head around it.

The structure has a 4 byte hole, so adding a private flag or such is
feasible without going over a cache line, unless lockdep or rt is
enabled, but in that case it expands into a second cache line anyway.

> +	futex_hash_priv_put(hb_p);
> +}
> +
> +void futex_hash_get(struct futex_hash_bucket *hb)
> +{
> +	struct futex_hash_bucket_private *hb_p;
> +
> +	if (hb->hb_slot == 0)
> +		return;
> +
> +	hb_p = container_of(hb, struct futex_hash_bucket_private,
> +			    queues[hb->hb_slot - 1]);
> +	/* The ref needs to be owned by the caller so this can't fail */

reference please. This is not twatter. But see below.

> +	WARN_ON_ONCE(!rcuref_get(&hb_p->users));
> +}
>  
>  /**
>   * futex_setup_timer - set up the sleeping hrtimer.
> @@ -599,7 +642,10 @@ int futex_unqueue(struct futex_q *q)
>  	 */
>  	lock_ptr = READ_ONCE(q->lock_ptr);
>  	if (lock_ptr != NULL) {
> +		struct futex_hash_bucket *hb;
> +
>  		spin_lock(lock_ptr);
> +		hb = futex_hb_from_futex_q(q);
>  		/*
>  		 * q->lock_ptr can change between reading it and
>  		 * spin_lock(), causing us to take the wrong lock.  This
> @@ -622,6 +668,7 @@ int futex_unqueue(struct futex_q *q)
>  		BUG_ON(q->pi_state);
>  
>  		spin_unlock(lock_ptr);
> +		futex_hash_put(hb);

This is invoked from futex_wait_multiple() which means you are
are holding the reference count accross schedule(),

I'm not convinced that this is the right thing to do. Let me look at
your actual resize implementation...

>  		futex_q_unlock(hb);
> +		futex_hash_put(hb);

This pattern is there in a gazillion instances. Can't we have a single
function doing all of it?

Thanks,

        tglx

