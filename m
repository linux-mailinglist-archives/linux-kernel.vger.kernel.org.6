Return-Path: <linux-kernel+bounces-392919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC499B99A4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 21:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 905941F22350
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 20:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9281E2007;
	Fri,  1 Nov 2024 20:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="deZjujUr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5qKfZ6iw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8F11D0F77
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 20:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730494039; cv=none; b=nSgutkqFSlTyM5LQjzf7uo8n8CGnk+Zgpb6fBoiWFggWovfTyi/TiDxSv1S3/9hY9ZjCedfejQf0JVurZOUJXQL7LxbeLiBXEEyTixFUySbXt412NGrb6UfKUt8iKpZyw9ZyDg1u3s8YRggC6RNPPcpMUEEZIKz74rGfub8FE50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730494039; c=relaxed/simple;
	bh=0tnK6nEbmuYG541l5Lx8ax5b3m2A7/Mv34Ahf+Bc64E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e/cUzC1ZZgSOQVRgeCR12mnuXnECnqzYbWbKNqBq9Li8SC5WaFtkh6gfjShqiG8J6Yt9Qw0bftHeNBnBFGbqTcadW6hXXDc7TX0761cQg7ZzsejqIR0jj0/ITtoCXkRue3VqFRpeOjkhCB1h6/Yt1fqE6FsVbAbwWhkaBbFDUMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=deZjujUr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5qKfZ6iw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730494035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d7EQLbcFgM5NFHnvUBAmrYEoDMdjisGi8IXkoXIatbQ=;
	b=deZjujUr+KIMEUtrcOkgIHhIK60NbgLHSQ+HXu3wBQoWFpgsMaQdXeOWxGgIRXZUjBdaGk
	aCzRx29613lWi7BplwkOpuKSl84hm7qAzIq5ivF24+4QHYubUC0qd17ZZQ403cZK5cgV+A
	sC910I4eqZ+vaC8xvi+LThdOsTanqm8yPzGpACFVGq662NnX+7F1B47RgYB9AuGIn9uehG
	DojaY+YPxwXNMeeG+SdhRkR4QZJjXC4Le3xmyEwNsSGEHkczi4Dsv5hunh+BumnnKKvamQ
	RYqr/JVCMysT9EPzD/61Rv2y4kq3Us2PyMX6Wcmm2Zxipxy3rdaaFAGy+fnHgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730494035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d7EQLbcFgM5NFHnvUBAmrYEoDMdjisGi8IXkoXIatbQ=;
	b=5qKfZ6iwIaifC+kaqmQEeUc/sVer7ce/83EAUxIxXhiD+y9VIPDKpTtWf7CIELi4C/19PK
	BsptZBLStP6e4LDA==
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, John Stultz <jstultz@google.com>, Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Stephen
 Boyd <sboyd@kernel.org>, Eric Biederman <ebiederm@xmission.com>, Oleg
 Nesterov <oleg@redhat.com>
Subject: Re: [patch v6 17/20] signal: Queue ignored posixtimers on ignore list
In-Reply-To: <ZyTj2W8Jndv0nzga@localhost.localdomain>
References: <20241031151625.361697424@linutronix.de>
 <20241031154425.624061922@linutronix.de>
 <ZyTj2W8Jndv0nzga@localhost.localdomain>
Date: Fri, 01 Nov 2024 21:47:15 +0100
Message-ID: <871pzuvfzg.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 01 2024 at 15:21, Frederic Weisbecker wrote:
> Le Thu, Oct 31, 2024 at 04:46:43PM +0100, Thomas Gleixner a =C3=A9crit :
>> +static void sigqueue_free_ignored(struct task_struct *tsk, struct sigqu=
eue *q)
>> +{
>> +	if (likely(!(q->flags & SIGQUEUE_PREALLOC) || q->info.si_code !=3D SI_=
TIMER))
>> +		__sigqueue_free(q);
>> +	else
>> +		posixtimer_sig_ignore(tsk, q);
>
> So this happens when the signal is ignored and delays it to when it will =
be
> unignored. But the comment on do_sigaction() says:
>
> 		/*
> 		 * POSIX 3.3.1.3:
> 		 *  "Setting a signal action to SIG_IGN for a signal that is
> 		 *   pending shall cause the pending signal to be discarded,
> 		 *   whether or not it is blocked."
> 		 *
> 		 */
>
> Are posix timers an exception to that rule?
>
> Also I see flush_sigqueue_mask() called on other occasions, for example
> when a STOP signal happens to remove pending CONT, not sure if posix
> timers can set SIGCONT...

No. The problem with posix timers is that they are magically different
from regular signals in the case of periodic timers.

When the signal is ignored at expiry, then the signal is not delivered
and is 'dropped'. But when SIG_IGN is removed then the following period
expiry has to deliver the signal.

Right now the kernel ensures that by keeping the timer self rearming and
rate limiting it for obvious reasons. That's a completely pointless
exercise up to the point where SIG_IGN is removed.

The only way to avoid the self rearming is to actually stop the timer
when the signal is ignored and rearm it when SIG_IGN for the specific
signal is removed.

That's what this magic does...

Thanks,

        tglx


