Return-Path: <linux-kernel+bounces-379466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7BA9ADEFD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 10:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26B2128A51D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 08:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B001CB9FD;
	Thu, 24 Oct 2024 08:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0jMdAfXt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LSxLfKbB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F111CB33E;
	Thu, 24 Oct 2024 08:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729757858; cv=none; b=P7Uq3O6kjMovYiJBWTFkND7e7E+sohjO5wcMV9KVvtlEzhgvQ9qhdYe6SfukqLFHFQUqHX5p72iI2ramSLNTV6E+ame1eQ8gi0ZYsFbAbBsEW/x2DK9WftS8jIyiw/YYm80NxHKrmQtgANiZRE+pi0WQasgXldxQZpmgWpq0oCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729757858; c=relaxed/simple;
	bh=9E/DsnuVB9UMNxDvRm78ZugZBCzTVrchqbXuWcs7kGQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LY9V6uUPPbRginyPJ2vPhu1L9sbWt+zJJFs6FgoGZlaJUM8a3p9DK2sGI3TUih5BTH1Se6R9rGvCOrL6ayCm+NPfDaPhcUY6cBUDBu4M5+QMwogwYFeGMHfgvfChByouQnB05ZkKhAxxrTJhNOh6SlDM0pDi0asAdFNbiS0BFNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0jMdAfXt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LSxLfKbB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729757854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IRJgU4eNasgp3CwItJtcihGQh5qaQF4uTiJjQeDr1q8=;
	b=0jMdAfXt+tlJ4A22h0DkBJ9ldaPq++kXVt0NESUqX4xrHL0MiuepHgoRxwH+/7/NCA1LJN
	P9mI47McoH1sLG16zrymRiu5LQRHyDUXCg5Qyg5vRTmJWF1d3/3Zoxu1Gceaepje/t0H4v
	HIUBwCBJmbDyRNVy6iqCdcSZ9jwHUY78BFz6XAHRYoUQcE1c0QgGvycpNVpau2rpUHPpS0
	3ndeiO2aZSUQ2qgLLzUchM6xPFwKmugq2opp1asaR9mk2pMVuMLE77Nfa06yS5bwbpN3ET
	yqKvrPPIH2UKwcPb6kdSuqCxC9UpyEfQ8YcY99mW1rS+CgVSrLRfNhgfL2VlAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729757854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IRJgU4eNasgp3CwItJtcihGQh5qaQF4uTiJjQeDr1q8=;
	b=LSxLfKbB3uncxadkjDqNb5h9bIl978ikT3jvRYHp/Vwe4fGI44lz2CBZRU2I9XRRjWSckh
	vf+Y+XCb/EFAZIDQ==
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Dirk Behme <dirk.behme@gmail.com>, Lyude Paul <lyude@redhat.com>,
 rust-for-linux@vger.kernel.org, Danilo Krummrich <dakr@redhat.com>,
 airlied@redhat.com, Ingo Molnar <mingo@redhat.com>, will@kernel.org,
 Waiman Long <longman@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor
 <alex.gaynor@gmail.com>, wedsonaf@gmail.com, Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin
 <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>,
 aliceryhl@google.com, Trevor Gross <tmgross@umich.edu>
Subject: Re: [POC 1/6] irq & spin_lock: Add counted interrupt
 disabling/enabling
In-Reply-To: <ZxnVmCqk2PzsOj2h@Boquns-Mac-mini.local>
References: <20241018055125.2784186-2-boqun.feng@gmail.com>
 <87a5eu7gvw.ffs@tglx> <ZxnVmCqk2PzsOj2h@Boquns-Mac-mini.local>
Date: Thu, 24 Oct 2024 10:17:33 +0200
Message-ID: <87zfmt6hk2.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Oct 23 2024 at 22:05, Boqun Feng wrote:
> On Wed, Oct 23, 2024 at 09:34:27PM +0200, Thomas Gleixner wrote:
>> local_interrupt_enable()
>> {
>>         if ((preempt_count() & LOCALIRQ_MASK) == LOCALIRQ_OFFSET) {
>>         	local_irq_restore(this_cpu_read(...flags);
>>                 preempt_count_sub_test_resched(LOCALIRQ_OFFSET);
>>         } else {
>>                 // Does not need a resched test because it's not going
>>                 // to 0
>>                 preempt_count_sub(LOCALIRQ_OFFSET);
>>         }
>> }
>> 
>
> Yes, this looks nice, one tiny problem is that it requires
> PREEMPT_COUNT=y ;-) Maybe we can do: if PREEMPT_COUNT=y, we use preempt
> count, otherwise use a percpu?
>
> Hmm... but this will essentially be: we have a irq_disable_count() which
> is always built-in, and we also uses it as preempt count if
> PREEMPT_COUNT=y. This doesn't look too bad to me.

The preempt counter is always there even when PREEMPT_COUNT=n. It's
required for tracking hard/soft interrupt and NMI context.

The only difference is that preempt_disable()/enable() are NOOPs. So in
that case preempt_count_sub_test_resched() becomes a plain preempt_count_sub().

>> and then the lock thing becomes
>> 
>> spin_lock_irq_disable()
>> {
>>         local_interrupt_disable();
>>         lock();
>> }
>> 
>> spin_unlock_irq_enable()
>> {
>>         unlock();
>>         local_interrupt_enable();
>> }
>> 
>> instead having to do:
>> 
>> spin_unlock_irq_enable()
>> {
>>         unlock();
>>         local_interrupt_enable();
>>         preempt_enable();
>> }
>> 
>> Which needs two distinct checks, one for the interrupt and one for the
>
> No? Because now since we fold the interrupt disable count into preempt
> count, so we don't need to care about preempt count any more if we we
> local_interrupt_{disable,enable}(). For example, in the above
> local_interrupt_enable(), interrupts are checked at local_irq_restore()
> and preemption is checked at preempt_count_sub_test_resched(). Right?

Correct. That's what I pointed out. By folding it into preempt count
this becomes one operation, while in your POC it's two distinct checks
and operations.

Thanks,

        tglx

