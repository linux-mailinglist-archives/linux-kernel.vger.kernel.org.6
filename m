Return-Path: <linux-kernel+bounces-169675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7B28BCC19
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 12:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D27CE283BFC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 10:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8F14205F;
	Mon,  6 May 2024 10:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CxJ6SmLu"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC21B101C8
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 10:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714991803; cv=none; b=SvCY54ColliWVTQBZ/o3fno5JpQX87gz9cRx+n/XQCPjp5hC5DBaTISGu8TH9xrmbtn+2UBXuUd8CZGfZJLpTeX3DP93NWQPUR0P8OXg3nVp77m3e3VaSQD0hQj2mm+aB5e+8uLN9htZtWVDwqzaBAO0o5RY35JNzuibzAIQd0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714991803; c=relaxed/simple;
	bh=f5FuZwO+MKPKX+harEgFy8Dh9f/mr78JHk/hvTY/C80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U+i1xa4rLp3PjJJpEjFJCY6+07XScJTXZXUzWp09HJxcJcM2kRzsNruEWxdwnOnMd1dZBU2cDmB2WkKJ82oS4EzuttEt8Qwepyrjz//6EEvZM+Jb/T53BW8qJIG824NEBM76Wog6eK3uBBKDP8rcQNi8YXaWTgw8Id9wao6Ngj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CxJ6SmLu; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=G+EKeG5lmQSIPvzwSIB/xbVPGJg7u7Z8HVLDlPsO+Kc=; b=CxJ6SmLubh1k7f7/C6+rUViNDw
	mFKZ59aENl0agch5F/t6Zqj1nRInyqDvhbvaLGb+KVyESz2JapTBlJTokwRKbkZbMnkk0im5txIP9
	Y/Xzk9Pbf+16jcnrIaGKM9JXa5nf60vBQz63N//PxYzRc0Vmz7aQPYHuUg9pazAFG+usNZenw4viw
	LTxzbptWKlejjgdxHdIUMyBeNNBANn7XkQgt4rs7O/+vzHG9ru6NMt63xylisdXrI+3Zxi/5X7zbs
	cuCgdx4ywM6XGOb01uqqTDVvk1VORK8NCyHMN/wIe35ZZXqQzX32l7PQZGFp3PqIL3ThIw385i3Vy
	mQCqsFRw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3vi1-00000001gGK-1oms;
	Mon, 06 May 2024 10:36:38 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1C563300362; Mon,  6 May 2024 12:36:37 +0200 (CEST)
Date: Mon, 6 May 2024 12:36:37 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Waiman Long <longman@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
	Vernon Lovejoy <vlovejoy@redhat.com>
Subject: Re: [PATCH v2] locking/qspinlock: Save previous node & owner CPU
 into mcs_spinlock
Message-ID: <20240506103637.GM40213@noisy.programming.kicks-ass.net>
References: <20240504024106.654319-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240504024106.654319-1-longman@redhat.com>

On Fri, May 03, 2024 at 10:41:06PM -0400, Waiman Long wrote:

Not much of a fan of this thing, but I suppose it won't hurt too much ...

> diff --git a/kernel/locking/mcs_spinlock.h b/kernel/locking/mcs_spinlock.h
> index 85251d8771d9..cbe6f07dff2e 100644
> --- a/kernel/locking/mcs_spinlock.h
> +++ b/kernel/locking/mcs_spinlock.h
> @@ -13,12 +13,19 @@
>  #ifndef __LINUX_MCS_SPINLOCK_H
>  #define __LINUX_MCS_SPINLOCK_H
>  
> +/*
> + * Save an encoded version of the current MCS lock owner CPU to the
> + * mcs_spinlock structure of the next lock owner.
> + */
> +#define MCS_LOCKED	(smp_processor_id() + 1)
> +
>  #include <asm/mcs_spinlock.h>
>  
>  struct mcs_spinlock {
>  	struct mcs_spinlock *next;
> -	int locked; /* 1 if lock acquired */
> -	int count;  /* nesting count, see qspinlock.c */
> +	int locked;	 /* non-zero if lock acquired */
> +	short count;	 /* nesting count, see qspinlock.c */
> +	short prev_node; /* encoded previous node value */

Strictly speaking, count shouldn't ever go much higher than 4, so I
suppose a byte should be sufficient. That would then leave 24bit for the
prev thing, but you'll get to use bitfields or some other horrible
thing.

>  };
>  
>  #ifndef arch_mcs_spin_lock_contended
> @@ -42,7 +49,7 @@ do {									\
>   * unlocking.
>   */
>  #define arch_mcs_spin_unlock_contended(l)				\
> -	smp_store_release((l), 1)
> +	smp_store_release((l), MCS_LOCKED)

This leaves ARM up a creek I suppose... Also, there's but a single
MCS_LOCKED user.

>  #endif
>  
>  /*
> diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
> index ebe6b8ec7cb3..df78d13efa3d 100644
> --- a/kernel/locking/qspinlock.c
> +++ b/kernel/locking/qspinlock.c
> @@ -436,6 +436,7 @@ void __lockfunc queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
>  
>  	node->locked = 0;
>  	node->next = NULL;
> +	node->prev_node = 0;
>  	pv_init_node(node);
>  
>  	/*
> @@ -463,6 +464,13 @@ void __lockfunc queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
>  	old = xchg_tail(lock, tail);
>  	next = NULL;
>  
> +	/*
> +	 * The prev_node value is saved for crash dump analysis purpose only,
> +	 * it is not used within the qspinlock code. The encoded node value
> +	 * may be truncated if there are 16k or more CPUs in the system.
> +	 */
> +	node->prev_node = old >> _Q_TAIL_IDX_OFFSET;
> +
>  	/*
>  	 * if there was a previous node; link it and wait until reaching the
>  	 * head of the waitqueue.
> -- 
> 2.39.3
> 

