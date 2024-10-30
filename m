Return-Path: <linux-kernel+bounces-389557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F109B6E67
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 22:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D54D11C20EB3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 21:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65A42139A4;
	Wed, 30 Oct 2024 21:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hjH0bsss"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD5114F90
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 21:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730322518; cv=none; b=EMz0WJkxXkK2WQkOdLh/5KlFJN/Kh20FrtnjWmmyBvHwwJSi1oWHAJ2VvK6WuemIYkjlIe4Cl8afUCVW8laDkHh0StUNPBnuJaQC6BR6mR6oFNLaNCW3g+LZKKTKqFJN3zXDF6wZSUbtBoyuUxL+e/o+QAMxByZAWQOh9QjaZWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730322518; c=relaxed/simple;
	bh=mRiPcb8LTpQ1yqZ+IolMpmS3kHGCYRwbV7GegnrGScc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sdanmptCOJ9WsskMvPADOR/USBi/dG7eR5RF01sjXbRTxwn3gNVNptAOxtQWPcSbVxZI7AGsnIUVGrzl9WKjsuyNgsPULwhTDYwvt0qMz3bzlgfV29lRi+PSIle1Afv7FJCLSb7TwyJs8Wb0q/L4wgo17hN1+vAMFNIt6fShHS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hjH0bsss; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/UfYIw4xl/0g0SK/g7tP0J3w64s6VesM8J5UWSobqMw=; b=hjH0bsssSTx5BLk8xQrT0DrUEa
	7ZNsFS9Qpbidry6IR0Nn6y37EtkYC0A6pLl5M2wrJ0n8Ob+gKph3tlrGsiqQjYCMuHI307l2ozGoG
	IWiLQBT9f55RQU4q8TdeeDuKXaB3RHs5zrZFTSl+q2Y5ytG2zvjy7QvNd005sCAtyuNistEEMh4Hi
	HVF3lFIK1aO8kGlFWtqajVn0UIl94VQZPwAGyU/PuQrAFWOQDqSsW+d4aAENtrhbSP0II1Kn0fgII
	cPfZlzoH/c520yEQcvqja23x/bYeS9T8tdEe8XWAkTEmUlbB3rBGKRD9TtQAs3ksHAECEZ1gpnd4p
	37bBRa2w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t6FvP-0000000Dup2-24TD;
	Wed, 30 Oct 2024 21:08:20 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2E103300ABE; Wed, 30 Oct 2024 22:08:19 +0100 (CET)
Date: Wed, 30 Oct 2024 22:08:19 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: Re: [RFC PATCH 2/3] futex: Add basic infrastructure for local task
 local hash.
Message-ID: <20241030210819.GS9767@noisy.programming.kicks-ass.net>
References: <20241026224306.982896-1-bigeasy@linutronix.de>
 <20241026224306.982896-3-bigeasy@linutronix.de>
 <87cyjl4u1h.ffs@tglx>
 <20241028103058.tERYBWZu@linutronix.de>
 <87y128335h.ffs@tglx>
 <20241028110035.GQ9767@noisy.programming.kicks-ass.net>
 <87r080306d.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r080306d.ffs@tglx>

On Mon, Oct 28, 2024 at 01:02:34PM +0100, Thomas Gleixner wrote:

> That's what we did with the original series, but with this model it's
> daft. What we maybe could do there is:

Not sure what's daft -- a single JVM running on 400+ CPUs with 4
hashbuckets sounds awesome.

> 
> private_hash()
>    scoped_guard(rcu) {
>       hash = rcu_dereference(current->signal->futex_hash);

So I really do think mm_struct is a better place for this than signal
struct -- CLONE_SIGHAND is not mandatory when CLONE_VM.

I've long forgotten which JVM used the naked CLONE_VM, but there is some
creative code out there.

And futexes fundamentally live in the memory address space.

>       if (hash && rcuref_get(&hash->ref))
>          return hash;
>    }
> 
>    guard(spinlock_irq)(&task->sighand->siglock);
>    hash = current->signal->futex_hash;
>    if (hash && rcuref_get(&hash->ref))
>        return hash;
>    // Let alloc scale according to signal->nr_threads

  mm->mm_users

>    // alloc acquires a reference count
>    ....

It might make sense to have a prctl() setting that inhibits the hash
allocation entirely, reverting back to the global hash tables.

> And on fork do the following:
> 
>    scoped_guard(spinlock_irq, &task->sighand->siglock) {
>       hash = current->signal->futex_hash;
>       if (!hash || hash_size_ok())
>    	return hash;
> 
>       // Drop the initial reference, which forces the last
>       // user and subsequent new users into the respective
>       // slow paths, where they get stuck on sighand lock.
>       if (!rcuref_put(&hash->ref))
>         return;
> 
>       // rcuref_put() dropped the last reference
>       old_hash = realloc_hash(hash);
>       hash = current->signal->futex_hash;
>    }
>    kfree_rcu(old_hash);
>    return hash;
> 
> A similar logic is required when putting the last reference
> 
> futex_hash_put()
> {
>    if (!rcuref_put(&hash->ref))
>       return;
> 
>    scoped_guard(spinlock_irq, &task->sighand->siglock) {
>       // Fork might have raced with this
>       if (hash != current->signal->futex_hash)
>       	 return;
>       old_hash = realloc_hash(hash);
>    }
>    kfree_rcu(old_hash);  
> }

I'm not sure having that rehash under siglock is a fine idea. It's
convenient, no doubt, but urgh, could get expensive.

Another scheme would be to have 2 concurrent hash-tables for a little
while.

