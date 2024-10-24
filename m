Return-Path: <linux-kernel+bounces-380394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC599AEDD8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 19:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2767F2884FD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 17:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666971FE106;
	Thu, 24 Oct 2024 17:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CtNIwoQa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LRMrOuJM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04281FE0ED;
	Thu, 24 Oct 2024 17:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729790543; cv=none; b=TBlkAqmX2gsLb4DQTiP7QOuF/alicv8K7ajeiztIfpNSXh1A9riax9a9gmpoZ+3nXLk7rnYIEACea2VJVlb+s4IbLUodQIHQ0nlikJ8bMW5fPWZM7E5/9ERIZSWqbFbLo1yggk5DnWQPY34Q7oJ5x6cMAwTFcBOKvFK5CFh3fLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729790543; c=relaxed/simple;
	bh=wIuVCwuQSmU9TT+eX/r6kAmocD1hUdlcNmxwdd/zI90=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iBnaIcfgCdsBDPau9PZAU5RkDPxdwbDQHOm7GCAsa1kTmQkUIxttotQJBN3RhpDQGi8rfyp0jpVoUrFd9OaR01jTegqOwzh4q/daUgmtgY0mtJSLO1lwB59RgV2H1uo3g5rgul5z1suHjuRRzotimn3KHpKDOie5Nai9N5KQ5gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CtNIwoQa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LRMrOuJM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729790539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TbyQ/C9SYHe3bdpUj5IPx6bVXUYJHaelwqgH9B9vyKo=;
	b=CtNIwoQatLcjHjHLFgb696snT0vMTnx02tc7ZoJWNowgXceusSOgVDg/SbQFiB6MCrzIei
	EYYZt9kQFMrfdoYeF0MVVTseKxyXbSuhzw3yHG1H/mQhmcXr8Lq+VCYxXed9W6wCLqKKJE
	edSQkQjWUn+7HyyHSBSanWRARyqDdbnVNWIR2MBK2EenZH5tcJzdQFvQBIu3Im5k9zn/1C
	hKvRU8fEPuQ9KG5P5VErThnTb39+VezVrnDEJjSRAUBFerejz0hBUjWfPm6YSYUR5qyNo1
	vc+8MV/f+Ov9YQ8xk3Rpk9dvWD5a4E63zBmvqDrJWoqmI7V8og6UX1uiW1uAeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729790539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TbyQ/C9SYHe3bdpUj5IPx6bVXUYJHaelwqgH9B9vyKo=;
	b=LRMrOuJM2taEpAtgcl7W4IdEOJ+ZoheVTXXOGixx/0FJirgFZGiTiaQEtIjqNShNjV41y6
	qOCAhGGWf89gYmBA==
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
In-Reply-To: <20241024100538.GE9767@noisy.programming.kicks-ass.net>
References: <20241018055125.2784186-2-boqun.feng@gmail.com>
 <87a5eu7gvw.ffs@tglx>
 <20241023195152.GE11151@noisy.programming.kicks-ass.net>
 <877c9y7dwx.ffs@tglx>
 <20241024100538.GE9767@noisy.programming.kicks-ass.net>
Date: Thu, 24 Oct 2024 19:22:19 +0200
Message-ID: <87bjz95sc4.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Oct 24 2024 at 12:05, Peter Zijlstra wrote:
> On Wed, Oct 23, 2024 at 10:38:38PM +0200, Thomas Gleixner wrote:
>> But if we want to support insanity then we make preempt count 64 bit and
>> be done with it. But no, I don't think that encouraging insanity is a
>> good thing.
>
> The problem is that in most release builds the overflow will be silent
> and cause spurious weirdness that is a pain in the arse to debug :/
>
> That is my only concern -- making insane code crash hard is good, making
> it silently mostly work but cause random weirdness is not.

I wish we could come up with a lightweight check for that.

Thanks,

        tglx

