Return-Path: <linux-kernel+bounces-384695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C74A99B2D52
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 11:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64860B21759
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 10:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FD61D31B2;
	Mon, 28 Oct 2024 10:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a4vCtvoH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lPGH5J01"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA9518800D
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 10:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730112648; cv=none; b=PjKa2Qw2+tuqU35/vraEhpOresQ8ZJMaZIqIK3B91lS2i4yjO53zVYBKI1to5rsIbtLClfZiqBngTAjP9lpiWpY2oRBc9rcMCb+TBhTzDRw/vWJWTA6gjfwUi577Wgc+JdqZo+jPM97P91PmJVU+Q2QGyCPmxkwLGGDBFrAEhEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730112648; c=relaxed/simple;
	bh=wqGwTO/B9VLq+ufockMh1tjLLRCCtGr8xfuPjuvwMiI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=idv8phz5LYgRsScOmhor7Z9TR38eSQ7bAPd4mnhzfvIw1Bq4miFvIwhkDB7M77kzs9u+ljARQGSiVzhI7tDtibEPOddocPRa81PSjNUCJ93E9Cg6mF3r4d34oHk0gOTZq5VQ28iXGmcQ62DgYsAJdwn40NYfeqVdYTK/A2ydGRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a4vCtvoH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lPGH5J01; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730112644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nqQG03k8oEOKsEUJfrDOlwgggVXYfbII+l2kN5wTX7U=;
	b=a4vCtvoHx00dy+wnVAVjTy93dsHLAhOYAxPg4lkShdLG9fXdbqg+X5j4Dhpmr9JJh26xb+
	/jjzqzRCO52fEzJGkRDV1I3WdJ8QBSLzYz2zZq5gQ+eYrlvJb5uO7gFwpgXwnisN63yEKc
	3+fy3xyySNhv4PCiXAdjpvF2e5P/zVTCUe976ZjHQLDR5G3fqGnX4IwgJBGo9ChFCuAujQ
	5vBJL8YaptVAm0KMs4uuD/h6EsZdczhDIASEXieamwoiAJE5D1A7mYVGtMXL9PNC0TLFWC
	J/fuaWrdWQRGX7M0dy9Tvx1YszAPxVSgqwtcMGGs2G6yEVLRWXbivcnu5GA+Jg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730112644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nqQG03k8oEOKsEUJfrDOlwgggVXYfbII+l2kN5wTX7U=;
	b=lPGH5J01BFztScHBkoBl0Lbw5rOgAhicuJ5XwFxPYM/evQfyFRtljKsRzIIJsMzUIDJhmg
	2kLvo6W0wnhDqHDA==
To: Peter Zijlstra <peterz@infradead.org>, Nam Cao <namcao@linutronix.de>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker
 <frederic@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, Alice
 Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Kees Cook
 <kees@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 18/21] sched/idle: Switch to use hrtimer_setup_on_stack()
In-Reply-To: <20241028090927.GI9767@noisy.programming.kicks-ass.net>
References: <cover.1729864615.git.namcao@linutronix.de>
 <db5daed82f8ba69eb155171ed96f3a5a83cd483b.1729864615.git.namcao@linutronix.de>
 <20241028090927.GI9767@noisy.programming.kicks-ass.net>
Date: Mon, 28 Oct 2024 11:50:44 +0100
Message-ID: <871q004i2j.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Oct 28 2024 at 10:09, Peter Zijlstra wrote:
> On Mon, Oct 28, 2024 at 08:29:37AM +0100, Nam Cao wrote:
>> There is a newly introduced function hrtimer_setup_on_stack(), which will
>> replace hrtimer_init_on_stack(). In addition to what
>> hrtimer_init_on_stack() does, this new function also sanity-checks and
>> initializes the callback function pointer.
>> 
>> Switch to use the new function.
>> 
>> Patch was created by using Coccinelle.
>> 
>> Signed-off-by: Nam Cao <namcao@linutronix.de>
>> ---
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> ---
>>  kernel/sched/idle.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
>> index d2f096bb274c..631e42802925 100644
>> --- a/kernel/sched/idle.c
>> +++ b/kernel/sched/idle.c
>> @@ -399,8 +399,8 @@ void play_idle_precise(u64 duration_ns, u64 latency_ns)
>>  	cpuidle_use_deepest_state(latency_ns);
>>  
>>  	it.done = 0;
>> -	hrtimer_init_on_stack(&it.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
>> -	it.timer.function = idle_inject_timer_fn;
>> +	hrtimer_setup_on_stack(&it.timer, idle_inject_timer_fn, CLOCK_MONOTONIC,
>> +			       HRTIMER_MODE_REL_HARD);
>
> WTF is hrtimer_setup_on_stack() ?
>
> Do NOT send partial series. How the hell am I supposed to review things
> if I don't even get to see the implementation of things,eh?

Can you tone down a bit? This was an oversight and I did not notice when
going over it. The full thread is in your LKML inbox, so can you just
move on?

Thanks,

        tglx



