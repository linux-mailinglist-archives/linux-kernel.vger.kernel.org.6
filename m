Return-Path: <linux-kernel+bounces-387302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4512A9B4F31
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 17:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0959828681C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 16:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADC91991A4;
	Tue, 29 Oct 2024 16:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lECBT0Mk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xykm1G3w"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5D71990A8
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 16:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730218941; cv=none; b=hUkFpWFGOaIFcRt4UfM/Srk3PFHgmnccfFKLPnMQu6s0SHi3y3+7NW8TcrE9IiT9zGSlTZbjhE7zyUysE30au3r6FmjoNsl+j1SJmILHaJIBp0KM2yyHRO47nDaiz0lDgKSZ7UoWbzkGluZr0NNoHW9VI3ms/ibJjPIe4SVizIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730218941; c=relaxed/simple;
	bh=07an0G/64GljmQ+GmjMfVWkMNPhQ8FMeEXsC3BfUCBw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W1gdN+vuRcB2YF3x6GJ/kvXDdPtWS+/MPrWlMQhY5lxqCL3FkHIcLD6AntreIkHKBUUf+XqS6h5HTJKp6M9FWxcXPFTHx8SbPp8SULff3aELr6AYXrTff5QQoL9ASuwX1gUL4rvXfaWPw4+jbyMKFFWb8Orbl/89bo6LpW+d+gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lECBT0Mk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xykm1G3w; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730218938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ofyEkQTKwgapYSctzGgwrycN31tm2SvNVeH5sEeVtr8=;
	b=lECBT0MkMblsU3Rkzzg9PUlZCij4QxSojvjNReGFOZ0w9U8b5VLJ2sZ4GExZ+xD4dJq8Oe
	MKQdynj8ik1/a0IhsFnopdVHM3X46kEkDQpmqAIk7AJyxnjgeqw8AlhNR6s+G2PYUtZEZ4
	nG21iF/4wEfjnjTwAaJQtjuGQD4O2gcOUrB/7WW6xACItG7U47sSBGiQPHuXwSIZ7y+wC6
	gt/utAy2t4qkWZfQX1EIyov5MAGmbldu4ZU82fRR/FYOc569W3ib64NXoeNRMSa7VwKzei
	Ce044KWQl10DsmtDfAltho0QO1mHUt2sZTrwEMRSl53oQuVJv5H9dzp897Jqbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730218938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ofyEkQTKwgapYSctzGgwrycN31tm2SvNVeH5sEeVtr8=;
	b=xykm1G3wGaWDsQ1tO+JUkhZv0ZIjHz/YdCCaDv0gTVVabNA7MefklV5Ogk0uqIWADJhGfd
	FL+mqzwlBlpPYXBA==
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, John Stultz <jstultz@google.com>, Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Stephen
 Boyd <sboyd@kernel.org>, Eric Biederman <ebiederm@xmission.com>, Oleg
 Nesterov <oleg@redhat.com>
Subject: Re: [patch V5 16/26] signal: Replace resched_timer logic
In-Reply-To: <ZyEFyV28jcz85V1q@localhost.localdomain>
References: <20241001083138.922192481@linutronix.de>
 <20241001083836.220867629@linutronix.de>
 <ZyEFyV28jcz85V1q@localhost.localdomain>
Date: Tue, 29 Oct 2024 17:22:17 +0100
Message-ID: <87ttcu281y.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Oct 29 2024 at 16:56, Frederic Weisbecker wrote:
>> @@ -568,10 +568,10 @@ static void collect_signal(int sig, stru
>>  		list_del_init(&first->list);
>>  		copy_siginfo(info, &first->info);
>>  
>> -		*resched_timer = (first->flags & SIGQUEUE_PREALLOC) &&
>> -				 (info->si_code == SI_TIMER);
>> -
>> -		__sigqueue_free(first);
>> +		if (unlikely((first->flags & SIGQUEUE_PREALLOC) && (info->si_code == SI_TIMER)))
>> +			*timer_sigq = first;
>> +		else
>> +			__sigqueue_free(first);
>
> So this isn't calling __sigqueue_free() unconditionally anymore. What if
> the timer has been freed already, what is going to free the sigqueue?

__sigqueue_free() does not free timers marked with SIGQUEUE_PREALLOC.

sigqueue_free() takes care of that, which is invoked from
posixtimer_free_timer(). It clears SIGQUEUE_PREALLOC and if it is queued
it lets it pending and delivery will free it.

That's not any different from before this change.

Though thinking more about it. As we drop the signal in that case
anyway, we could remove it from pending in sigqueue_free() directly. Let
me look into that.

Thanks,

        tglx

