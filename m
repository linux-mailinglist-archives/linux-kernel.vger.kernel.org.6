Return-Path: <linux-kernel+bounces-387364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3329B4FF5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 17:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3BA91C21E3A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 16:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747391D2796;
	Tue, 29 Oct 2024 16:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dlXzreRX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G5gk51kD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC365C96
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 16:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730221151; cv=none; b=WfNJmtnGV4DrSBG6mXCRByifNAFo9NWRut7Hbuca8imRlZsORohiXKxyYKxwGR3HA2DKbUoADgvmbZ55vXBPhtkMRhgxDEnRrjvOk2rdpDdQNXYYyhexGevRpmJZ8TgTLv5JzcTkV9zCqQyssQ28iR+46pNtnQU3bao3MJDR60c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730221151; c=relaxed/simple;
	bh=2faW62Qcotnlgy2aU9eqyQKoGYV2/vNZJOpxgTEltkw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jhUX208fwra0cM9UUvQaOVD8eGIukv3zdrB9o8mPAp2rUlN/0WLyRopkENulu+cMUA9kdzAq3aUY2qD8fyjGNWzQZBvDKNq0xn1/Q/6udi5bEWGHE2dwMtY22kqbhO+clbRp15fm2MfZ690OhsmC7Xb5xMo5EXUYFTpDbQw1VUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dlXzreRX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G5gk51kD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730221148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gCnVY+3/A62iimJ2BPTslgfnEG+nXBZ0G2OhUJrU2Nc=;
	b=dlXzreRXswoOstuOSsRyewOzCvzQWmHG29bj5XFePrajXmrNR2iO1I88v9k8NhLXRKHGTH
	x0V3d3xleud9uOCouO3vlSFvHJ+QGPphJmOYPjy7VC23vKum722CRbmohNKpXMYvLclJaV
	zH9EvUD/ehPCEgu9GNjfPs0TAaVv89HBGv+vePgXjE3WJb1xH56AOs375Fe9pR45JSUb0G
	6MUNI3gmWkuZOzraC3A4ej9vfAz0mA+KttNQLGILkNe+efwgq/GzqetIYBXs/Bj/eejGKy
	fAuPe7dB0XseW8Yj03dmPfpmkrIUSpOQRU3xWs9PIHSPzVzVmXQxdqn7PvEgug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730221148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gCnVY+3/A62iimJ2BPTslgfnEG+nXBZ0G2OhUJrU2Nc=;
	b=G5gk51kDOP7HWcL85HHTquxCYlCtP6pvn+P8xAIuj+fGTptRVvhyF1zzl1F6OAmqwHRDK5
	/wH9C1a+/h+mCxCg==
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, John Stultz <jstultz@google.com>, Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Stephen
 Boyd <sboyd@kernel.org>, Eric Biederman <ebiederm@xmission.com>, Oleg
 Nesterov <oleg@redhat.com>
Subject: Re: [patch V5 16/26] signal: Replace resched_timer logic
In-Reply-To: <ZyEHgU73mo4ekJ9R@localhost.localdomain>
References: <20241001083138.922192481@linutronix.de>
 <20241001083836.220867629@linutronix.de>
 <ZyEHgU73mo4ekJ9R@localhost.localdomain>
Date: Tue, 29 Oct 2024 17:59:08 +0100
Message-ID: <87h68u26cj.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29 2024 at 17:04, Frederic Weisbecker wrote:
> Le Tue, Oct 01, 2024 at 10:42:21AM +0200, Thomas Gleixner a =C3=A9crit :
>> @@ -604,19 +604,19 @@ static int __dequeue_signal(struct sigpe
>>   */
>>  int dequeue_signal(sigset_t *mask, kernel_siginfo_t *info, enum pid_typ=
e *type)
>>  {
>> +	struct sigqueue *timer_sigq =3D NULL;
>>  	struct task_struct *tsk =3D current;
>> -	bool resched_timer =3D false;
>>  	int signr;
>>=20=20
>>  	lockdep_assert_held(&tsk->sighand->siglock);
>>=20=20
>>  again:
>>  	*type =3D PIDTYPE_PID;
>> -	signr =3D __dequeue_signal(&tsk->pending, mask, info, &resched_timer);
>> +	signr =3D __dequeue_signal(&tsk->pending, mask, info, &timer_sigq);
>>  	if (!signr) {
>>  		*type =3D PIDTYPE_TGID;
>>  		signr =3D __dequeue_signal(&tsk->signal->shared_pending,
>> -					 mask, info, &resched_timer);
>> +					 mask, info, &timer_sigq);
>>=20=20
>>  		if (unlikely(signr =3D=3D SIGALRM))
>>  			posixtimer_rearm_itimer(tsk);
>> @@ -642,8 +642,8 @@ int dequeue_signal(sigset_t *mask, kerne
>>  		current->jobctl |=3D JOBCTL_STOP_DEQUEUED;
>>  	}
>>=20=20
>> -	if (IS_ENABLED(CONFIG_POSIX_TIMERS) && unlikely(resched_timer)) {
>> -		if (!posixtimer_deliver_signal(info))
>> +	if (IS_ENABLED(CONFIG_POSIX_TIMERS) && unlikely(timer_sigq)) {
>> +		if (!posixtimer_deliver_signal(info, timer_sigq))
>>  			goto again;
>
> If the signal has been refused, it goes goto again without clearing
> timer_sigq.

That's right. timer_sigq needs to be set to NULL after again:

Good catch!

Thanks,

        tglx

