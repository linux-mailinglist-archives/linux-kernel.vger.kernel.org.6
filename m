Return-Path: <linux-kernel+bounces-379540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8D99AE026
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 11:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFC121C22127
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 09:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA691AF0C2;
	Thu, 24 Oct 2024 09:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zbe86Vtu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PtXIsATh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0289EA932
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 09:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729761014; cv=none; b=SCD3yMYdg78lUiYosYr0yalU2JKuIi9BPc4y/Lp2DV1/VBUP8X/knzKzYqo11vJrZHONfyAjWT8KKOq6/fD+N2JPZoyBXbF52r1cxSsBKHjS2+zBH3FvBPOq2tCQGPYZuhyBoRrELUkeddaXAUF8UYUEW90Lxx5ln3qpJW1ayLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729761014; c=relaxed/simple;
	bh=0eTQbIZ90mtviXEQfuNNzytevwlaCWhlPhhulerdYfI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ffbLeJhvdl7TY7oA2dlXfO5I5KSUBfblpU+oVlkBIiOfCsTpyDztzpKyssYWbhr9doHe1AMhxUOl8jqY7Y+dWV6dFGwbL9Lr8FjvHmK2s35T9Fr3QR8z3E6CbrBaJSSz0rZYAqjP0g10XJfJ4lZXqFdBVUNrWwNUMt6TCRdROv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zbe86Vtu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PtXIsATh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729761010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gXgmKK18IeSTWdw0F/MTBgv1LhHvnA+pLTDE8An4zzw=;
	b=zbe86VtuiFkPJBHf77FjrQ07VicxYHBlvv00H+s5Gj7s64x7aH8mic1iXvmgvXrafWq1gX
	G/3JBBNEzpGJ3WTXBMcMRQEq3lz3Z3TpOvU+4F28X5U7NneJBkFyrEf7sD7EqvZQ5SxynK
	gwKEeexf+0bxijH2YCD5QQOK/fhpI0G6U7KTKBdI3tzygjcoBFZ4JBJt+m51azo9hkFq/U
	RJjLWdakoA9h4YqMQKzAExdnuBuSNnWqFaKTRqFhp2zevH3S3kc3j+F/3se0i4uSouFGuh
	ZGqqZyhOvRCnaBnpvUajD2l07e1HBgBpTd/uZPFIGrPK/gdWh7swYUcLLdMzRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729761010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gXgmKK18IeSTWdw0F/MTBgv1LhHvnA+pLTDE8An4zzw=;
	b=PtXIsAThHfNwj+gtnfGHbnfCRGOVBTagx9vwEETsq7bjBsZ49l8shaCDP1seTemUGhZ4J+
	3Ev8asXCQaUqKpDA==
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, John Stultz <jstultz@google.com>, Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Stephen
 Boyd <sboyd@kernel.org>, Eric Biederman <ebiederm@xmission.com>, Oleg
 Nesterov <oleg@redhat.com>
Subject: Re: [patch V5 09/26] posix-timers: Make signal overrun accounting
 sensible
In-Reply-To: <87ldyd6fq8.ffs@tglx>
References: <20241001083138.922192481@linutronix.de>
 <20241001083835.790542522@linutronix.de> <ZxbNlw4F5tUI1a5D@pavilion.home>
 <87ldyd6fq8.ffs@tglx>
Date: Thu, 24 Oct 2024 11:10:09 +0200
Message-ID: <87ed456f4e.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24 2024 at 10:57, Thomas Gleixner wrote:
> On Mon, Oct 21 2024 at 23:54, Frederic Weisbecker wrote:
>> Le Tue, Oct 01, 2024 at 10:42:12AM +0200, Thomas Gleixner a =C3=A9crit :
>>> +	/*
>>> +	 * Set the overrun count to zero unconditionally. The posix timer
>>> +	 * code does not self rearm periodic timers. They are rearmed from
>>> +	 * dequeue_signal().
>>> +	 *
>>> +	 * But there is a situation where @q is already enqueued:
>>> +	 *
>>> +	 * 1) timer_settime()
>>> +	 *      arm_timer()
>>> +	 * 2) timer_expires()
>>> +	 *      send_sigqueue(@q)
>>> +	 *        enqueue(@q)
>>> +	 * 3) timer_settime()
>>> +	 *      arm_timer()
>>> +	 * 4) timer_expires()
>>> +	 *      send_sigqueue(@q) <- Observes @q already queued
>>> +	 *
>>> +	 * In this case incrementing si_overrun does not make sense because
>>> +	 * there is no relationship between timer_settime() #1 and #2.
>>> +	 *
>>> +	 * The POSIX specification is useful as always: "The effect of
>>> +	 * disarming or resetting a timer with pending expiration
>>> +	 * notifications is unspecified."
>>> +	 *
>>> +	 * Just do the sensible thing and reset the overrun.
>>> +	 */
>>> +	q->info.si_overrun =3D 0;
>>
>> So this means that in the above example case, no signal at all is going =
to be
>> delivered (because the seq will be impaired on the previously queued
>> signal) and no overrun count will be incremented either?
>
> So #2 queues the signal, but before delivery the timer is rearmed, which
> invalidates the signal via the sequence count. So #4 has to set the
> overrun counter which might be set already.

The signal will be delivered. It's either already marked as pending, but
not yet delivered or it is masked and will be marked pending on unmask.

>>> +
>>>  	ret =3D 1; /* the signal is ignored */
>>>  	result =3D TRACE_SIGNAL_IGNORED;
>>>  	if (!prepare_signal(sig, t, false))
>>> @@ -1968,15 +1996,9 @@ int send_sigqueue(struct sigqueue *q, st
>>>=20=20
>>>  	ret =3D 0;
>>>  	if (unlikely(!list_empty(&q->list))) {
>>> -		/*
>>> -		 * If an SI_TIMER entry is already queue just increment
>>> -		 * the overrun count.
>>> -		 */
>>> -		q->info.si_overrun++;
>>
>> Who is ever incrementing this after that? I'm a bit confused between the
>> timer overrun and the sigqueue overrun. Those seem to be two different
>> things without any link...
>
> Hmm. You're right. This should now never happen. Let me stare at it some
> moar.

Of course it can happen that the signal is queued. See above scenario :)

But q->info.si_overrun should never be anything else than 0. The timer code
increments the overrun counter and updates si_overrun on signal
delivery, but that's done on the siginfo which is a copy of q->info.

This seems to be a leftover from early posix-timer days... So that
change can be reduced to removing the increment.

Thanks,

        tglx

