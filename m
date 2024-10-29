Return-Path: <linux-kernel+bounces-387362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9299B4FE5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 17:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61AF71C22721
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 16:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866241D8E0D;
	Tue, 29 Oct 2024 16:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="blc+bjdu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T+Lfc19P"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF7D19992C
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 16:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730220944; cv=none; b=kwvJ6+eaLqWHcd0V5R2CBBaQjaxQ9tedPNm5RxvV0/mJ/b9t5uSzxrRhvlX0Po9xrrOJoLDh4dMKpy+VH2zothvqKL//f84D8c/JeyeT/q/WER1ijwxFEkNuKqPRwjNKtXLEQLXKMuPhTPOHqs37KAONTt9s0Jl/a+GGFUGgI3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730220944; c=relaxed/simple;
	bh=R5eCvl7du1Y0ll208Q1e9al+4xGrXnELKPOKT/IPt2U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lYwnhus5aw4r1NwHKgc5HGge1Lct5/eVENQ6tdS7UNtdGfVuI46D9YtvZ33xCJ49YIGsVWSqCtaYnrrjSsN0Utc6YfAjX0NnG1YLnTFw8pB4FQ0UIBBSzY1Mxuz7C0tq19d3CfJd7HzxGGzUrFbvw09vx7jixfUK+84sUU7ndfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=blc+bjdu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T+Lfc19P; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730220939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GPXhAj4plb/VaugiiQVa5PHiH+TY7cG/EDvtnrbR5IA=;
	b=blc+bjduxvSpAIyWJ4aIxuHkYqDJparOyX/wwNGCcquKSFwE0Jt98oOS52j+GuW5ZBGH7g
	627pfy5eOnq/+ql99nnHpT3Hi7qXPaemOisvaTrhIf9q837OB4DLItAna+kc7xINGiPmQ6
	jTFIu8itpJrvtc+klKIRp3xVzjJElO+f9SrlB6hMLUbTQoyjpGSC/0HL+2GWDPjPpWWgMx
	bSNDmzFOuKw1I8OCvg2Pu05O0AbS0JU4x5xy5/o5d1UB/du2BUQOtBQJ6+uVlWVxXNrRbn
	80RjLN7+87+xx8LkUCaYxs1vHsfwp0joHdzFuiA7zQfrUsNRVZSKl7o+ARiWyw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730220939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GPXhAj4plb/VaugiiQVa5PHiH+TY7cG/EDvtnrbR5IA=;
	b=T+Lfc19PFdNBEL9s1PeaKJSJtSJxJMgVB6ffw9nWv2z1K//PiuT7h08FtBaKgmEqY5xEn4
	I1swC5b9JDuMJYDQ==
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, John Stultz <jstultz@google.com>, Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Stephen
 Boyd <sboyd@kernel.org>, Eric Biederman <ebiederm@xmission.com>, Oleg
 Nesterov <oleg@redhat.com>
Subject: Re: [patch V5 16/26] signal: Replace resched_timer logic
In-Reply-To: <ZyEOeqkSYWR2XTp_@localhost.localdomain>
References: <20241001083138.922192481@linutronix.de>
 <20241001083836.220867629@linutronix.de>
 <ZyEFyV28jcz85V1q@localhost.localdomain> <87ttcu281y.ffs@tglx>
 <ZyEOeqkSYWR2XTp_@localhost.localdomain>
Date: Tue, 29 Oct 2024 17:55:38 +0100
Message-ID: <87jzdq26id.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29 2024 at 17:34, Frederic Weisbecker wrote:

> Le Tue, Oct 29, 2024 at 05:22:17PM +0100, Thomas Gleixner a =C3=A9crit :
>> On Tue, Oct 29 2024 at 16:56, Frederic Weisbecker wrote:
>> >> @@ -568,10 +568,10 @@ static void collect_signal(int sig, stru
>> >>  		list_del_init(&first->list);
>> >>  		copy_siginfo(info, &first->info);
>> >>=20=20
>> >> -		*resched_timer =3D (first->flags & SIGQUEUE_PREALLOC) &&
>> >> -				 (info->si_code =3D=3D SI_TIMER);
>> >> -
>> >> -		__sigqueue_free(first);
>> >> +		if (unlikely((first->flags & SIGQUEUE_PREALLOC) && (info->si_code =
=3D=3D SI_TIMER)))
>> >> +			*timer_sigq =3D first;
>> >> +		else
>> >> +			__sigqueue_free(first);
>> >
>> > So this isn't calling __sigqueue_free() unconditionally anymore. What =
if
>> > the timer has been freed already, what is going to free the sigqueue?
>>=20
>> __sigqueue_free() does not free timers marked with SIGQUEUE_PREALLOC.
>>=20
>> sigqueue_free() takes care of that, which is invoked from
>> posixtimer_free_timer(). It clears SIGQUEUE_PREALLOC and if it is queued
>> it lets it pending and delivery will free it.
>
> But the delivery freeing used to be done with the __sigqueue_free()
> above, which doesn't happen anymore, right?

It still happens because SIGQUEUE_PREALLOC is cleared in sigqueue_free()

__sigqueue_free() has
       if (q->flags & PREALLOC)
       	     return;

So the old code called __sigqueue_free() unconditionally which just
returned. But now we have a condition to that effect already, so why
call into __sigqueue_free() for nothing?

Let me add a comment.

Thanks,

        tglx

