Return-Path: <linux-kernel+bounces-312265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F42C969436
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 08:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81AB6B21F76
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 06:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD3E1D6185;
	Tue,  3 Sep 2024 06:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="l5t9RuLo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CfbMUA97"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584261CE6EA
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 06:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725346555; cv=none; b=jYZmUdHuwPqxwfmnsyH+/StqvKh3VJoMTzIvCKVs5AKV9ELoKqvqwIZHfSiB7HXVMQxIW16ZcJb9UxRNWxCqTGnTpAascOwqwMqPEQC/PjtJEX9EVBidp4d2Bxhdurenz2qDAYDz5eK4jKk1bG1xV0ShI4j8kk2dMOJZ4ZCuKH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725346555; c=relaxed/simple;
	bh=0vmj/cNONX3DmzcnvCouQ67TnIZa5vTOa9JsvrZkCQ8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K/ht2QRuYn2EwTc9Ee5DUI8ON6eK2Wtq8lnbU4C5ybAG4TquAxY1R09wXEe9XNDiSyTx9BIPjvhV3KUN2oUGhCASTgvrcFEu+5biGrIG3JkEmyv+BBwl9SZ8QdPmupmom2o/jCp7lDyVTrizqjNkakiwUw0w4lnAvNUeLedsAoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=l5t9RuLo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CfbMUA97; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725346551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nk/pW7zET6cplsPd9M+1gUJe1+6NAXfQlmcUQnLJuFU=;
	b=l5t9RuLoThDUJrVQsdCHo+ZNkjCnY4UUGxAONKRIBhGm4qvgLFWr7mAC60uhSLuaaAx4fk
	iiVhnzzfinmBbUQtuOutMW4bgooYfXl3USEa/wD4oPjdYRLLrArbMDMiUD/nudFoFA8r6c
	QoWTBTPlXMYVt+95S3zxlOBzm7WFf/m3/BdKEJPteOhKSuSg5Kkrojbc5MerdouAzK1FR7
	RbYNmCHnq9AzXovC0bU/PJPbuT0zYPBTLyf9Ld7dKbLUIf4K3xer5eW9jmg62r+lVAB25w
	ThWDnesgxlRRhz2155M/Eb4Rajdf3yBHWpE4oZppjzryNJBTRUQO/iAdd5H2Pg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725346551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nk/pW7zET6cplsPd9M+1gUJe1+6NAXfQlmcUQnLJuFU=;
	b=CfbMUA976RU9PH1kARDHb3EWmATf1nrJggoebSJVCPvv33XhcSIdS+gcuSgsqe1UIyfZmS
	0OPvwUnhKNFC0DAA==
To: Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] timers: Annotate possible non critical data race of
 next_expiry
In-Reply-To: <ZtTo0wB_Jccoi0oM@pavilion.home>
References: <000000000000916e55061f969e14@google.com>
 <20240829154305.19259-1-anna-maria@linutronix.de>
 <ZtTo0wB_Jccoi0oM@pavilion.home>
Date: Tue, 03 Sep 2024 08:55:50 +0200
Message-ID: <87o755b4zt.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Frederic Weisbecker <frederic@kernel.org> writes:

> Le Thu, Aug 29, 2024 at 05:43:05PM +0200, Anna-Maria Behnsen a =C3=A9crit=
 :
>> Global timers could be expired remotely when the target CPU is idle. Aft=
er
>> a remote timer expiry, the remote timer_base->next_expiry value is updat=
ed
>> while holding the timer_base->lock. When the formerly idle CPU becomes
>> active at the same time and checks whether timers need to expire, this
>> check is done lockless as it is on the local CPU. This could lead to a d=
ata
>> race, which was reported by sysbot:
>>=20
>>   https://lore.kernel.org/r/000000000000916e55061f969e14@google.com
>>=20
>> When the value is read lockless but changed by the remote CPU, only two =
non
>> critical scenarios could happen:
>>=20
>> 1) The already update value is read -> everything is perfect
>>=20
>> 2) The old value is read -> a superfluous timer soft interrupt is raised
>>=20
>> The same situation could happen when enqueueing a new first pinned timer=
 by
>> a remote CPU also with non critical scenarios:
>>=20
>> 1) The already update value is read -> everything is perfect
>>=20
>> 2) The old value is read -> when the CPU is idle, an IPI is executed
>> nevertheless and when the CPU isn't idle, the updated value will be visi=
ble
>> on the next tick and the timer might be late one jiffie.
>>=20
>> As this is very unlikely to happen, the overhead of doing the check under
>> the lock is a way more effort, than a superfluous timer soft interrupt o=
r a
>> possible 1 jiffie delay of the timer.
>>=20
>> Document and annotate this non critical behavior in the code by using
>> READ/WRITE_ONCE() pair when accessing timer_base->next_expiry.
>>=20
>> Reported-by: syzbot+bf285fcc0a048e028118@syzkaller.appspotmail.com
>> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
>> Closes: https://lore.kernel.org/lkml/000000000000916e55061f969e14@google=
.com
>
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
>
> Just a few nits:
>
>> ---
>>  kernel/time/timer.c | 41 ++++++++++++++++++++++++++++++++++++-----
>>  1 file changed, 36 insertions(+), 5 deletions(-)
>>=20
>> diff --git a/kernel/time/timer.c b/kernel/time/timer.c
>> index 18aa759c3cae..71b96a9bf6e8 100644
>> --- a/kernel/time/timer.c
>> +++ b/kernel/time/timer.c
>> @@ -672,7 +672,7 @@ static void enqueue_timer(struct timer_base *base, s=
truct timer_list *timer,
>>  		 * Set the next expiry time and kick the CPU so it
>>  		 * can reevaluate the wheel:
>>  		 */
>> -		base->next_expiry =3D bucket_expiry;
>> +		WRITE_ONCE(base->next_expiry, bucket_expiry);
>>  		base->timers_pending =3D true;
>>  		base->next_expiry_recalc =3D false;
>>  		trigger_dyntick_cpu(base, timer);
>> @@ -1964,7 +1964,7 @@ static void next_expiry_recalc(struct timer_base *=
base)
>>  		clk +=3D adj;
>>  	}
>>=20=20
>> -	base->next_expiry =3D next;
>> +	WRITE_ONCE(base->next_expiry, next);
>>  	base->next_expiry_recalc =3D false;
>>  	base->timers_pending =3D !(next =3D=3D base->clk + NEXT_TIMER_MAX_DELT=
A);
>>  }
>> @@ -2018,7 +2018,7 @@ static unsigned long next_timer_interrupt(struct t=
imer_base *base,
>>  	 * easy comparable to find out which base holds the first pending time=
r.
>>  	 */
>>  	if (!base->timers_pending)
>> -		base->next_expiry =3D basej + NEXT_TIMER_MAX_DELTA;
>> +		WRITE_ONCE(base->next_expiry, basej + NEXT_TIMER_MAX_DELTA);
>>=20=20
>>  	return base->next_expiry;
>>  }
>> @@ -2462,8 +2462,39 @@ static void run_local_timers(void)
>>  	hrtimer_run_queues();
>>=20=20
>>  	for (int i =3D 0; i < NR_BASES; i++, base++) {
>> -		/* Raise the softirq only if required. */
>> -		if (time_after_eq(jiffies, base->next_expiry) ||
>> +		/*
>> +		 * Raise the softirq only if required.
>> +		 *
>> +		 * timer_base::next_expiry can be written by a remote CPU while
>> +		 * holding the lock. If this write happens at the same time than
>> +		 * the lockless local read, sanity checker could complain about
>> +		 * data corruption.
>> +		 *
>> +		 * There are two possible situations where
>> +		 * timer_base::next_expiry is written by a remote CPU:
>> +		 *
>> +		 * 1. Remote CPU expires global timers of this CPU and updates
>> +		 * timer_base::next_expiry of BASE_LOCAL afterwards in
>
> BASE_GLOBAL ?
>
>> +		 * next_timer_interrupt() or timer_recalc_next_expiry(). The
>> +		 * worst outcome is a superfluous raise of the timer softirq
>> +		 * when the not yet updated value is read.
>> +		 *
>> +		 * 2. A new first pinned timer is enqueued by a remote CPU and
>> +		 * therefore timer_base::next_expiry of BASE_GLOBAL is
>
> BASE_LOCAL ?

Thanks for the review. Yes you are right, those base names should be
switched...

> Thanks.

Thanks,

	Anna-Maria


