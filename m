Return-Path: <linux-kernel+bounces-552966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A42F0A58199
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 09:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33CC41890303
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 08:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB5817BB3F;
	Sun,  9 Mar 2025 08:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4waA2xo0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BJTKeMwS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C39383A2
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 08:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741508514; cv=none; b=qbS530CYzmk6wSnBjgr+sNs8qL4jCAU7Ja66k3S9VDeQqHhvQhDxH4GM1z8jSbqCYXk1HpFJgaS7yLus0bweSwr/kO5jh360jaRhm6ffT0OgqYpMD7shQvGfs4SxV/rgcrYfUKrlS8Nh/WJ0zK1vc3Cxs7NXxZt04YzAjiMT0Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741508514; c=relaxed/simple;
	bh=TrZ7azIrzbMSkZBddckej2yJsiFDejtt8ghoGU2gH+A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=usoYBqhaRp/2tc0BAGJjxfN7OxYBSCUaEeynxFW4jYTymhQk1V1kM6y8KNpe2WvhJNbFBBBihnvEaUpxlC0YY8ZKxJlybACBgSlLfyM+f+TsyFrEHQ18IgzUzKzqUF//HjG0Bf5pCSzMTLMkMtX9u3oPsj+nXfY+0Kg0mGwDcEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4waA2xo0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BJTKeMwS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741508504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fbwmK4gTnd6mpuy9RKYPZlJJq01XNnEJiMFrXc5ggFo=;
	b=4waA2xo0yl+81huxniNyu0by6KET8Znv0va2nUMQSMYuOUYFnJ2Ocsg7lcLjY8wBjAl5Uo
	8J9fKk/1BSvCrPyDbBxiQYw8ClOg/lJhJTwJqtonJCdHd5bUi0KLrq+TWgqmgcnpAMGIvV
	+HHB5+fvKGTw+sOBWL0haVHBEeWQpP5Ukl1czc8j2u+qoKBXKE/HlIXmaC0CIkVANpa7Y+
	+VvXmjSGiwAPkecBS7a8DUbdwxNUhNBeZGT4SACJ9rrUy9hMoEepIZ90OLsYVpPE80VMfa
	ist3JsR8JTxEjXd9+Q3TKlKWbtkOOVPVQ4HgW121wobTHWZJfl1ceCYDzQFZBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741508504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fbwmK4gTnd6mpuy9RKYPZlJJq01XNnEJiMFrXc5ggFo=;
	b=BJTKeMwSfM597oZBERdNxIZuVn2vaq7XYVDw5nkMYI/EfFlNU8+2sIESKR/nLUWRRx+6WU
	rDVfeAWOmvV87vAQ==
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Benjamin Segall <bsegall@google.com>, Eric
 Dumazet <edumazet@google.com>, Andrey Vagin <avagin@openvz.org>, Pavel
 Tikhomirov <ptikhomirov@virtuozzo.com>, Peter Zijlstra
 <peterz@infradead.org>
Subject: Re: [patch V2 08/17] posix-timers: Rework timer removal
In-Reply-To: <Z8zJQtzLIliTNe2e@pavilion.home>
References: <20250302185753.311903554@linutronix.de>
 <20250302193627.416552300@linutronix.de> <Z8t7UJUd9SLT0Ytj@pavilion.home>
 <8734fn53b5.ffs@tglx> <Z8zJQtzLIliTNe2e@pavilion.home>
Date: Sun, 09 Mar 2025 09:21:44 +0100
Message-ID: <87msdu397r.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 08 2025 at 23:48, Frederic Weisbecker wrote:
> Le Sat, Mar 08, 2025 at 09:34:06AM +0100, Thomas Gleixner a =C3=A9crit :
>> >> --- a/kernel/time/posix-timers.c
>> >> +++ b/kernel/time/posix-timers.c
>> >> @@ -279,7 +279,7 @@ static bool __posixtimer_deliver_signal(
>> >>  	 * since the signal was queued. In either case, don't rearm and
>> >>  	 * drop the signal.
>> >>  	 */
>> >> -	if (timr->it_signal_seq !=3D timr->it_sigqueue_seq || WARN_ON_ONCE(=
!timr->it_signal))
>> >> +	if (timr->it_signal_seq !=3D timr->it_sigqueue_seq || !posixtimer_v=
alid(timr))
>> >
>> > Hmm, should it still warn here? ie: WARN_ON_ONCE(!posixtimer_valid(tim=
r)) ?
>>=20
>> No, because the timer is invalidated early now.
>
> But the signal can only be queued before posix_timer_delete(). So
> if the bit 0 of it_signal has been reset, it_signal_seq must have been
> incremented along, right?
>
> And if so then timr->it_signal_seq =3D=3D timr->it_sigqueue_seq must imply
> posixtimer_valid(). And if not we should warn. Or am I missing something?

You're just missing the fact, that I managed to confuse myself :)

