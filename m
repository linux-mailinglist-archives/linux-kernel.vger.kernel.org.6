Return-Path: <linux-kernel+bounces-379515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C37649ADF91
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 10:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4D781C21730
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 08:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE4B1B2181;
	Thu, 24 Oct 2024 08:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3MNcFKZq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LaFVov5w"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53065258
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 08:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729760227; cv=none; b=J/icES0ct0DYKTIPyYuPofKKnBoP9Ijo6YY7msdBqgwJh83hryyOVia1JKxW+HzcL64xSnkzDMafuipcrXti8Dfqne57b3Fdeib7gvmLyYBMWCjk2+ehPc+QoC6zuhlMlu7b5cbZkwO0Sneoon2Bd9TVo3jIcwwGsaRTFnZitCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729760227; c=relaxed/simple;
	bh=Pw6FJosMejIFSDmfEmMu0ZzLX7Maw3+lCwFAqfIqBBI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jHEA9QE0O/szuqWvdU9rXJkX3ABocfPqB7Zc4/GnOPOSaNtfF2+63NpdjZyjPOgJDKa63+mHs0Bd3VKfnX/BDiy51Pl72VHCorp7VYWCF0EECTc/G4Q+eYfrUstlPD+jqs1vzRYK6tEh4/hm0oPMjZf4mj5ZPmFN/qs6YvR4ZRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3MNcFKZq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LaFVov5w; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729760224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8csvGl6+uTEFF4hb7wWV+oNN3A8Arzdk1CAP2JjMvBM=;
	b=3MNcFKZqa0xrK1ZEKJmCqozp3DjCcD3RLmc2zL+mFSf9fjLo96d4c0/hbto5ukaWQbZtvJ
	yTK93+N4prvakhxl4xlDqeyzuehYlCeqTv1COPHWFSab6XoSdIjAtDYlv40dGwGA48wA3M
	U2iNTAgP2cInJAFclkqNIJ1uAPFCwtxn1HE3RdyB8OS6tYXmuC/2kP21laC8+kZ/7qLj0v
	UdOnoMJz2oi1eUiuKJ5Q1TWV6FF+WdB/MI+1ttg2ZP773QaW0yG2tBPODpsZbRYVFiBp76
	Vn+LYZrUgOEUHGUbcEKMScVlcZSY6jjQKTxQM6Lwc4G7Q8huUDP1lxYQhjuJVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729760224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8csvGl6+uTEFF4hb7wWV+oNN3A8Arzdk1CAP2JjMvBM=;
	b=LaFVov5wPebqtBSYRz+0d5ESOfSUH0H1P7JBfXtTAZHdLzkVEOoXUL3bYEYdxrg2TeJ/RV
	1wBnPYY0I2v2LqBw==
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, John Stultz <jstultz@google.com>, Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Stephen
 Boyd <sboyd@kernel.org>, Eric Biederman <ebiederm@xmission.com>, Oleg
 Nesterov <oleg@redhat.com>
Subject: Re: [patch V5 09/26] posix-timers: Make signal overrun accounting
 sensible
In-Reply-To: <ZxbNlw4F5tUI1a5D@pavilion.home>
References: <20241001083138.922192481@linutronix.de>
 <20241001083835.790542522@linutronix.de> <ZxbNlw4F5tUI1a5D@pavilion.home>
Date: Thu, 24 Oct 2024 10:57:03 +0200
Message-ID: <87ldyd6fq8.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21 2024 at 23:54, Frederic Weisbecker wrote:
> Le Tue, Oct 01, 2024 at 10:42:12AM +0200, Thomas Gleixner a =C3=A9crit :
>> +	/*
>> +	 * Set the overrun count to zero unconditionally. The posix timer
>> +	 * code does not self rearm periodic timers. They are rearmed from
>> +	 * dequeue_signal().
>> +	 *
>> +	 * But there is a situation where @q is already enqueued:
>> +	 *
>> +	 * 1) timer_settime()
>> +	 *      arm_timer()
>> +	 * 2) timer_expires()
>> +	 *      send_sigqueue(@q)
>> +	 *        enqueue(@q)
>> +	 * 3) timer_settime()
>> +	 *      arm_timer()
>> +	 * 4) timer_expires()
>> +	 *      send_sigqueue(@q) <- Observes @q already queued
>> +	 *
>> +	 * In this case incrementing si_overrun does not make sense because
>> +	 * there is no relationship between timer_settime() #1 and #2.
>> +	 *
>> +	 * The POSIX specification is useful as always: "The effect of
>> +	 * disarming or resetting a timer with pending expiration
>> +	 * notifications is unspecified."
>> +	 *
>> +	 * Just do the sensible thing and reset the overrun.
>> +	 */
>> +	q->info.si_overrun =3D 0;
>
> So this means that in the above example case, no signal at all is going t=
o be
> delivered (because the seq will be impaired on the previously queued
> signal) and no overrun count will be incremented either?

So #2 queues the signal, but before delivery the timer is rearmed, which
invalidates the signal via the sequence count. So #4 has to set the
overrun counter which might be set already.

>> +
>>  	ret =3D 1; /* the signal is ignored */
>>  	result =3D TRACE_SIGNAL_IGNORED;
>>  	if (!prepare_signal(sig, t, false))
>> @@ -1968,15 +1996,9 @@ int send_sigqueue(struct sigqueue *q, st
>>=20=20
>>  	ret =3D 0;
>>  	if (unlikely(!list_empty(&q->list))) {
>> -		/*
>> -		 * If an SI_TIMER entry is already queue just increment
>> -		 * the overrun count.
>> -		 */
>> -		q->info.si_overrun++;
>
> Who is ever incrementing this after that? I'm a bit confused between the
> timer overrun and the sigqueue overrun. Those seem to be two different
> things without any link...

Hmm. You're right. This should now never happen. Let me stare at it some
moar.

Thanks,

        tglx

