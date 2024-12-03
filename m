Return-Path: <linux-kernel+bounces-429211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 278079E18D6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 11:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD507166ABC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D765D1E0B77;
	Tue,  3 Dec 2024 10:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UWhiOVTF"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147DE1E0DA7
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 10:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733220493; cv=none; b=b4hZKwK6HpX4ERKB+pOnj6Gg+bd9dH3nr65AGOK7NaO21gcarLNj5DPWC52fJOm4fXk0UaAcwGr5OmCTMGaOqKQc0mVYM3/x8bgyWQyGS4Maj40NyYoONEZRtP8POLZAB3J37t7+Lckw29e/QajnlP2b+c9ZpVWJ6r82VdUI5fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733220493; c=relaxed/simple;
	bh=BHqRaVfc7tN4rHQ7YVrYeiJePGGG6pWV15o1/pcM6HI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YH4lgyo9Q0a1VI+snkhFiCCNWLqcF+C57DDfFofz4hSA461dBic8TmeOzQkK4nPUDiBMSv+mJZou7gEUs2ayzsMZr08aiG92MRKcfE8m5J64nPUSNqalNR9KPTi6/mYexE+5/1vPGhBFQ1peJpEMfOtAPRefyJSetZCX45pqWSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UWhiOVTF; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1qwiw93w4KUHaVr81ssStA672Mi72xx31+mXTQRYpN0=; b=UWhiOVTFSRCc1rIXNPlWarYCLX
	eTBveI+s8uH2R17Qe1XLXq5JLQLjGgyin7oCGLB6ukcu6PJ6s9uwydtIBvitNEFHEKa7hmXkVHFjC
	mKAe8V8ljXgJ807hCIJthJXxMpSoUR8QDuKJbxR4zqwMLpno4LaNzbrxkXwmXBsFrE8nTUkZnP/Sy
	zcPc5/bHsAlcv7xNg50vmJ6KlYIOXO6f/Ro1OqW129wvATUA7EMajqHA87qtsjyVZaiMXrlXCFzGX
	fQSAdQ8YPy5ngBgt6nWwLAqgvRBmuw+eDltKd9LmvK8644wPjz7dpmF1sbH3jyx41+zAWU7iofm5U
	c+mp4LEA==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tIPp0-00000002LiL-2SHc;
	Tue, 03 Dec 2024 10:07:58 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B2391300327; Tue,  3 Dec 2024 11:07:57 +0100 (CET)
Date: Tue, 3 Dec 2024 11:07:57 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Seohyeon Maeng <msh1307@theori.io>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	jgross@suse.com, leitao@debian.org, linux-kernel@vger.kernel.org,
	bioloidgp@gmail.com
Subject: Re: [Report] Race Condition in text_poke_bp_batch/poke_int3_handler
Message-ID: <20241203100757.GG8562@noisy.programming.kicks-ass.net>
References: <674eba3e.620a0220.127f52.7e92@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <674eba3e.620a0220.127f52.7e92@mx.google.com>

On Tue, Dec 03, 2024 at 04:58:50PM +0900, Seohyeon Maeng wrote:

> [   24.729808] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014

What QEMU version and setup are you using? 

There have been QEMU bugs around there. Can you reproduce on real
hardware? Because I can't seem to trigger this...


> A kernel panic occurs when the following code is executed during live
> patching. In this scenario, an int3 trap can be triggered.
> 
> static inline void perf_event_task_sched_out(struct task_struct *prev,
> 					     struct task_struct *next)
> {
> 	[...]
> 	if (static_branch_unlikely(&perf_sched_events))
> 		__perf_event_task_sched_out(prev, next);
> }
> 
> noinstr int poke_int3_handler(struct pt_regs *regs)
> {
> 	[...]
> 	desc = try_get_desc();    // [1]
> 	if (!desc)
> 		return 0;
> 	[...]
> 	if (unlikely(desc->nr_entries > 1)) {
> 		tp = __inline_bsearch(ip, desc->vec, desc->nr_entries,
> 				      sizeof(struct text_poke_loc),
> 				      patch_cmp);
> 		if (!tp)
> 			goto out_put;
> 	} else {
> 		tp = desc->vec;
> 		if (text_poke_addr(tp) != ip)
> 			goto out_put;
> 	}
> 	[...]
> out_put:
> 	put_desc();
> 	return ret;
> }
> 
> During the Interrupt Handler (poke_int3_handler) processing, the patch
> function may be entered, resulting in an improper reference count
> (refcount). This can cause the reference count to be incorrectly set,
> and the bp_desc.vec and bp_desc.nr_entries are reinitialized, leading
> to a loss of critical information and subsequent failures in handling
> the int3 trap.
> 
> static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries)
> {	
> 	[...]
> 	lockdep_assert_held(&text_mutex);
> 
> 	bp_desc.vec = tp;
> 	bp_desc.nr_entries = nr_entries;
> 
> 	/*
> 	 * Corresponds to the implicit memory barrier in try_get_desc() to
> 	 * ensure reading a non-zero refcount provides up to date bp_desc data.
> 	 */
> 	atomic_set_release(&bp_desc.refs, 1); // [2]
> 	[...]	
> 	/*
> 	 * Remove and wait for refs to be zero.
> 	 */
> 	if (!atomic_dec_and_test(&bp_desc.refs))   // [3]
> 		atomic_cond_read_acquire(&bp_desc.refs, !VAL);
> 	[...]
> }
> 
> As demonstrated above, bp_desc and its refcount can be modified while
> poke_int3_handler is executing, leading to unexpected behavior.
> 
> Consider a scenario where two CPUs concurrently execute the sequence
> [1] -> [2] -> [3] -> [1], with overlapping operations on the reference
> count.  When [3] is executed, the refcount may drop to zero. As a
> result, when [1] attempts to retrieve the descriptor, it fails,
> leading to a kernel panic.

I'm failing to see how this can happen. The text_poke_bp() caller should
hold text_mutex, there SHOULD be no concurrency on [2]/[3].

So there is a single CPU doing text_poke_bp():

  mutex_lock(&text_mutex);
  text_poke_bp_batch()
    lockdep_assert_held(&text_mutex);
    atomic_set_release(&bp_desc.refs, 1);	[2]
    smp_wmb();

    poke-first-byte-to-INT3			[A]

    text_poke_sync();

    poke-tail-bytes

    text_poke_sync();

    poke-first-byte

    text_poke_sync();				[B]
							
    if (!atomic_dec_and_test(&bp_desc.refs))	[3]
      atomic_cond_read_acquire(&bp_desc.refs, VAL);
  mutex_unlock(&text_mutex);


The only concurrency is multiple CPUs hitting the INT3, which exists
between [A] and [B], and notably, in that range the reference count
should be very much >= 1.

And [3] very specifically waits for all pre-existing interrupt handlers
to complete; at point [B] the INT3 is gone and no new handlers can
possibly start.

The INT3 handler (poke_int3_handler()) had the following cases:

 - the boring case, INT3 is observed right after A, it gets a ref, does
   the emulation and completes before 3.

 - the tail case, INT3 is observed somewhere before B, it gets a ref,
   does the emulation but complets after B, in which case 3 will wait
   for it.

Hmm, there *might* be an issue when:

 - INT3 triggers right before B, poke_int3_handler()'s try_get_desc() is
   delayed until after 3.

But that is not what you were describing, were you? I think that case is
made impossible by text_poke_sync() itself, that sends an IPI to all
CPUs, completion of that IPI would block on the completion of the INT3
which triggered right before B.

And after the sync-IPI that CPU must not observe INT3 anymore.


If you really think there is a problem here, please describe the code
flow in more detail. But given I can't trigger anything, nor actually
see a hole in the code, I'm going to assume you managed to tickle the
QEMU bug.



