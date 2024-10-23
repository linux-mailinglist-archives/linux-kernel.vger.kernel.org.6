Return-Path: <linux-kernel+bounces-378800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D7D9AD59D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 22:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F2FE1F262D1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 20:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA711E25FC;
	Wed, 23 Oct 2024 20:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Zd8XRgGr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8Lqb+J2K"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD8775809;
	Wed, 23 Oct 2024 20:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729715922; cv=none; b=uvuq0UYj601qhh+bLTb/NKGlR3e2As5bULq29VbCgCU4PSmuB4OLgjf8Cp4OFXh6pLQ2Df6bex/R3jLvEFSBAGkpG+TsIzoACc1JexYcwAUORu7Xz2sI+A0dDEKiWeBj5zKOxE0KAPeWfSPqz7XUQTvQCLarYu1Un4FJl0BH35E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729715922; c=relaxed/simple;
	bh=JdrT2r/Q/HPycslCFnBZ4KhvLhXIEgfQ7+uUpB3QpbQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g7ktPFOt/EMIoUhYRQ9l9b5QVr00cs1gQUWrNKde9L/ODaohrygUiy4OeZFOvmekXR0jhKBnDnyygFVZbQfEAP8rFDcn3fJLeNPGFfULxL6UY4rAa6obgcFvOvHgHbHtgqEpIYIOHW9Ki/f0fh+ZJ9vY1aHu6816MWHr1Q5dgpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Zd8XRgGr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8Lqb+J2K; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729715918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ggPhMfQ4JszMhC7vaO8txWnmkqgZW1AsAbNGNIyZnUg=;
	b=Zd8XRgGrKYpxyVsod6djUebAh+0CqsLLhNgTkR0Mah4+sxeZATJFpJonZAw5XohxwvRtMm
	HzyydIh5EuHvOXrMEe/mtdnv6C3kgN+9NscBpz2+dvv2LiQGnhcxl1K1PKUG0e/LE6LQw9
	TkQe9R6KJh0gO9onlMXSLlsjasdgTamTRZ7vDA3WamFd/NrNuEJz16CA+kCpe7xe9YZEWW
	o7UXbO6MuZ7uYoXkUK1oiW7kTe+1l6C+nmjcGjkx72Ryw6I3OkVCFZMDZ6LqOP26cqtsr0
	CT4rdwO+RJYCxv8B9Sp+ZG7uIC72GfogF6aHjkOsMA08qR/lA/X7nuJD3oh6+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729715918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ggPhMfQ4JszMhC7vaO8txWnmkqgZW1AsAbNGNIyZnUg=;
	b=8Lqb+J2KM3OlJ/TPqzoHsxKKMNbW1oTj84++qCMtHgOIzWHWDlUzZrtFx3bxRsIOj54iEU
	26xg0wufahhu20Bw==
To: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Dirk Behme <dirk.behme@gmail.com>,
 Lyude Paul <lyude@redhat.com>, rust-for-linux@vger.kernel.org, Danilo
 Krummrich <dakr@redhat.com>, airlied@redhat.com, Ingo Molnar
 <mingo@redhat.com>, will@kernel.org, Waiman Long <longman@redhat.com>,
 linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor
 <alex.gaynor@gmail.com>, wedsonaf@gmail.com, Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin
 <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>,
 aliceryhl@google.com, Trevor Gross <tmgross@umich.edu>
Subject: Re: [POC 1/6] irq & spin_lock: Add counted interrupt
 disabling/enabling
In-Reply-To: <20241023195152.GE11151@noisy.programming.kicks-ass.net>
References: <20241018055125.2784186-2-boqun.feng@gmail.com>
 <87a5eu7gvw.ffs@tglx>
 <20241023195152.GE11151@noisy.programming.kicks-ass.net>
Date: Wed, 23 Oct 2024 22:38:38 +0200
Message-ID: <877c9y7dwx.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Oct 23 2024 at 21:51, Peter Zijlstra wrote:
> On Wed, Oct 23, 2024 at 09:34:27PM +0200, Thomas Gleixner wrote:
>> On Thu, Oct 17 2024 at 22:51, Boqun Feng wrote:
>> Ideally you make that part of the preemption count. Bit 24-30 are free
>> (or we can move them around as needed). That's deep enough and you get
>> the debug sanity checking of the preemption counter for free (might need
>> some extra debug for this...)
>
> Urgh, so we've already had trouble that nested spinlocks bust through
> the 0xff preempt mask (because lunacy).

Seriously? Such overflow should just panic the kernel. That's broken by
definition.

> You sure you want to be this stingy with bits?

Anything above 64 nest levels is beyond insane.

But if we want to support insanity then we make preempt count 64 bit and
be done with it. But no, I don't think that encouraging insanity is a
good thing.

> We still have a few holes in pcpu_hot iirc.

On x86. Sure.

But that's still an extra conditional while when you stick it into
preemption count it's _ONE_ conditional for both and not _TWO_

It actually makes a lot of sense even for the non rust case to avoid
local_irq_save/restore. We discussed that for years and I surely have
some half finished patch set to implement it somewhere in the poison
cabinet.

The reason why we did not go for it is that we wanted to implement a
lazy interrupt disable scheme back then, i.e. just rely on the counter
and when the interrupt comes in, disable interrupts for real and then
reinject them when the counter goes to zero. That turned out to be
horribly complex and not worth the trouble.

But this scheme is different as it only avoids nested irq_save() and
allows to use guards with the locking scheme Bogun pointed out.

It's even a win in C because you don't have to worry about lock_irq()
vs. lock_irqsave() anymore and just use lock_irq_disable() or whatever
the bike shed painting debate will decide on.

Thanks,

        tglx

