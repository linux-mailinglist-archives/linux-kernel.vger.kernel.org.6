Return-Path: <linux-kernel+bounces-393544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D169BA226
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 20:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA872B21454
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 19:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10491AAE08;
	Sat,  2 Nov 2024 19:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nUpuj9cP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vdiySSlk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF0A13BAF1
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 19:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730576518; cv=none; b=Ddq6AQ2A/OLN59clnJFG3xZYB15pQjdUTdpjhPkK76pjhipiWDp1zrp3DfnfaCBF75gGJwaxnogNIdWspYazYlQb9WV7zAwO3h9Qxna8LSJAXpGiAlunPPzisT7/9NKwpSz50iecNw3x2UirOGYIhg7aNLee4dCFpRAtiMkAWTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730576518; c=relaxed/simple;
	bh=l7c6p6cpaJWPhJnZGsgr1f1q2lwRninkKIvPVfslVPA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ipV3BJnLVeEPkSlHgPVtrffINfKYZSlC8f/YJfx6800u6kNoFwV5FVs4j8ugcgwQTbgsmlPcyayq4GCiC/9inP6telrl5ffpPfG4WwLHoQeGswYAXVT7jaBelbLxJ5qfwilzVfw/9jslVtlUDmfuZGbK16EdBz0Fo+3N0uDpW1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nUpuj9cP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vdiySSlk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730576514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RXdugMz85LcRuV3jjUT8/GZXvivTb/Wu2h55WIpWlYk=;
	b=nUpuj9cPUEMQKkLJx7lloLnnb7U2RO/HlPVZi7SRXtEjOngBm6TImKpFsUYg92ZeMeZTK2
	w7RHRcCwvBKCFL9Ru7h5Y7AfIWqmmJ4CNTvg+k9RERaGsgnV1v2M6dejU+e4fp68BPBHD+
	7mwd/6aywy0xOv8R3jZEniBp6IIv+dBn2XR6nx3YaWG3QnLqQQd21hUbpgrnZf7waggLZy
	HHMF/i0AeZJMdU8LHXMO7T5G2zf/CVfncuFdhuvT0J4EWWQvA4YjPyqjKwLiPMRlgYc4/R
	blAmwGXidMty57JlrNyurXsC2aAiuqML8xALGgqFxob7ulNA2Z53rW1Jh44qTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730576514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RXdugMz85LcRuV3jjUT8/GZXvivTb/Wu2h55WIpWlYk=;
	b=vdiySSlk9UNqUk1amAkKfBE84X3fKtKwFwucqZaRi/5o4EQ5a+Af4eAMamyTqYRcPNfd4T
	UFYu0tQvcRp44cCA==
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, John Stultz <jstultz@google.com>, Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Stephen
 Boyd <sboyd@kernel.org>, Eric Biederman <ebiederm@xmission.com>, Oleg
 Nesterov <oleg@redhat.com>
Subject: Re: [patch v6 02/20] posix-timers: Make signal overrun accounting
 sensible
In-Reply-To: <877c9mvgh7.ffs@tglx>
References: <20241031151625.361697424@linutronix.de>
 <20241031154424.677253735@linutronix.de>
 <ZyTO7mFZWRZf7sNv@localhost.localdomain> <877c9mvgh7.ffs@tglx>
Date: Sat, 02 Nov 2024 20:41:53 +0100
Message-ID: <878qu1qv7i.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 01 2024 at 21:36, Thomas Gleixner wrote:
> On Fri, Nov 01 2024 at 13:51, Frederic Weisbecker wrote:
>> Le Thu, Oct 31, 2024 at 04:46:25PM +0100, Thomas Gleixner a =C3=A9crit :
>>> @@ -1968,15 +1968,9 @@ int send_sigqueue(struct sigqueue *q, st
>>>=20=20
>>>  	ret =3D 0;
>>>  	if (unlikely(!list_empty(&q->list))) {
>>> -		/*
>>> -		 * If an SI_TIMER entry is already queue just increment
>>> -		 * the overrun count.
>>> -		 */
>>> -		q->info.si_overrun++;
>>>  		result =3D TRACE_SIGNAL_ALREADY_PENDING;
>>>  		goto out;
>>>  	}
>>> -	q->info.si_overrun =3D 0;
>>
>> So it's not cleared anymore on signal queue?
>>
>> Not sure if it's a big problem but if an interval timer gets a signal wi=
th
>> overruns and then the timer is reset later as non interval, the resulting
>> upcoming signals will still carry the previous non-zero overruns?
>
> Duh. Yes.
>
>> However it's better to keep the overrun update on a single place so
>> perhaps this?
>>
>> diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
>> index 66ed49efc02f..f06c52731d65 100644
>> --- a/kernel/time/posix-timers.c
>> +++ b/kernel/time/posix-timers.c
>> @@ -282,6 +282,8 @@ bool posixtimer_deliver_signal(struct kernel_siginfo=
 *info)
>>  		++timr->it_signal_seq;
>>=20=20
>>  		info->si_overrun =3D timer_overrun_to_int(timr);
>> +	} else {
>> +		info->si_overrun =3D 0;
>>  	}
>>  	ret =3D true;
>>=20=20
>> Other than that:
>
> Let me fold that.

Actually no. info is the siginfo which was allocated by the signal
delivery code on stack.

collect_signal() copies timer->sigqueue.info into that siginfo
struct. As timer->sigqueue.info.si_overrun is zero and never written to,
this else path is pointless.

Thanks,

        tglx



