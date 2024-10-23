Return-Path: <linux-kernel+bounces-378747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4653F9AD4E5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 21:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B36D9B22D2F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 19:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8651DE4CE;
	Wed, 23 Oct 2024 19:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M3/Zjr4H";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="80AmFc+f"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7621D47CB;
	Wed, 23 Oct 2024 19:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729712072; cv=none; b=nomUX+22lufxeoCUGwwuuE8trbi9fvlpJGP8NyH2tkv+cd3fOXwIAHaLyS6ioJw8tRCDnrZctm5CENTiKLbrsfUw2YFnKzkAYhXwc6DWI1lppkIxxV3BsV7gJe2Y9sibjnG9MW1X0Jbnn4FEJK//jRFi5vb0lu3dL+0Fr4CQkhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729712072; c=relaxed/simple;
	bh=keEtpzn12wH3jYAScIGBjUyx/oN5KkajtGOKvPK5oV0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=hh+H3LRs151iPaDFeqqa06VuFtj2nydV0GW4fTFNm95lxa9eEDpnfXd6ySqt9nn5CzaIUkD0Cf+cgwryCstahHP1iua+SN5XQl70zu1CL9KFAayFQzlTkyxcNBqEjPx/8oEF+wpNf772LRS0VuS3l5fKclBNoqzK4DLdlbeP91Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M3/Zjr4H; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=80AmFc+f; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729712068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=UKIaAPZQV2NhEf5qtKaNoRvOAmY1eWGmO5suz4rUei0=;
	b=M3/Zjr4HzJi1dr2+mXP+zcICt1DEHerfYJUYgKcV9RQvajGhYU672t9+p6yuUPSNyR6CZr
	QtqBDo3ADc0YlhQnAVuuy+kluJUH1fRCNvOCVRIGn63NkoX0n5vTtJZMagfYiRmHNJLa+p
	/aEYwYNjv0GS537iwgH+FcjIXshp8DxCJ+skhELwVweLTuOdh1FU3BjIe5V97xZ4Ff0NAW
	DchCZVoM9wW4r6wedkExE4CVDdxP09rgb0Go7wh+aI9SkcRpUzvULeLkuDeklqr+Jit0Ze
	Df4+mGmpvJRwbQ+md4tZbfABQjce8zG5gcQm9Py3yQGtCpDPLTDt1USudo+vNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729712068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=UKIaAPZQV2NhEf5qtKaNoRvOAmY1eWGmO5suz4rUei0=;
	b=80AmFc+fW6GvGUEnvwawa5hPbCSOwMkH75v9fvjR1MyyXRZLVimM7LBJ8pg4FYx9XV4W5M
	yGMhy+R/fXRLI9Ag==
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Dirk Behme <dirk.behme@gmail.com>, Lyude Paul <lyude@redhat.com>,
 rust-for-linux@vger.kernel.org, Danilo Krummrich <dakr@redhat.com>,
 airlied@redhat.com, Ingo Molnar <mingo@redhat.com>, will@kernel.org,
 Waiman Long <longman@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor
 <alex.gaynor@gmail.com>, wedsonaf@gmail.com, Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin
 <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>,
 aliceryhl@google.com, Trevor Gross <tmgross@umich.edu>, Boqun Feng
 <boqun.feng@gmail.com>
Subject: Re: [POC 1/6] irq & spin_lock: Add counted interrupt
 disabling/enabling
In-Reply-To: <20241018055125.2784186-2-boqun.feng@gmail.com>
Date: Wed, 23 Oct 2024 21:34:27 +0200
Message-ID: <87a5eu7gvw.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Oct 17 2024 at 22:51, Boqun Feng wrote:
> Currently the nested interrupt disabling and enabling is present by
> Also add the corresponding spin_lock primitives: spin_lock_irq_disable()
> and spin_unlock_irq_enable(), as a result, code as follow:
>
> 	spin_lock_irq_disable(l1);
> 	spin_lock_irq_disable(l2);
> 	spin_unlock_irq_enable(l1);
> 	// Interrupts are still disabled.
> 	spin_unlock_irq_enable(l2);
>
> doesn't have the issue that interrupts are accidentally enabled.
>
> This also makes the wrapper of interrupt-disabling locks on Rust easier
> to design.

Clever!

> +DECLARE_PER_CPU(struct interrupt_disable_state, local_interrupt_disable_state);
> +
> +static inline void local_interrupt_disable(void)
> +{
> +	unsigned long flags;
> +	long new_count;
> +
> +	local_irq_save(flags);
> +
> +	new_count = raw_cpu_inc_return(local_interrupt_disable_state.count);

Ideally you make that part of the preemption count. Bit 24-30 are free
(or we can move them around as needed). That's deep enough and you get
the debug sanity checking of the preemption counter for free (might need
some extra debug for this...)

So then this becomes:

local_interrupt_disable()
{
        cnt = preempt_count_add_return(LOCALIRQ_OFFSET);
        if ((cnt & LOCALIRQ_MASK) == LOCALIRQ_OFFSET) {
        	local_irq_save(flags);
                this_cpu_write(..., flags);
        }
}

and

local_interrupt_enable()
{
        if ((preempt_count() & LOCALIRQ_MASK) == LOCALIRQ_OFFSET) {
        	local_irq_restore(this_cpu_read(...flags);
                preempt_count_sub_test_resched(LOCALIRQ_OFFSET);
        } else {
                // Does not need a resched test because it's not going
                // to 0
                preempt_count_sub(LOCALIRQ_OFFSET);
        }
}

and then the lock thing becomes

spin_lock_irq_disable()
{
        local_interrupt_disable();
        lock();
}

spin_unlock_irq_enable()
{
        unlock();
        local_interrupt_enable();
}

instead having to do:

spin_unlock_irq_enable()
{
        unlock();
        local_interrupt_enable();
        preempt_enable();
}

Which needs two distinct checks, one for the interrupt and one for the
preemption counter. Hmm?

Thanks,

        tglx

