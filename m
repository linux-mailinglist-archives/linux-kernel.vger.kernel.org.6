Return-Path: <linux-kernel+bounces-552378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB55A57953
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 09:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3E9A1895853
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 08:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A457F1AC882;
	Sat,  8 Mar 2025 08:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sLALVWf3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="43f7u0Ky"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3242B1AB50D
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 08:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741422853; cv=none; b=kyhd5pDKrHGAVgDhvC82i2/dydz+nOOWnJg2jY77uZJ93clfinYXuHWORb2hQ4xdwFnRiGOYAsGlPYQNNEa+H9pFaaezGdr5vjBYKeTTik0o5B3UW5ajJmNKtD+svL1OS2ny5vvpeze8mfeBbYh/yi0QEphw0tsHwVClLqNzQOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741422853; c=relaxed/simple;
	bh=Ia4rygiYDwBDuX9UThFnnAwiVlwJ6yuacJdmi3N8aYo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nBGHxU3BaBlFgBKVVVghZzAFnI1KRPMgC2by0lEXobhtO+jDGIZw5Mn6cJ/JybrO+/zcHzjO2+AO6rNo6IF2yOSVTu9rJa8a2QOWnw+hiEz74QnL5B+yVvLHVjU5cW4wlTBCSzZRXqgZESUk+oIx4VCb9Py77wpIck+bgxVt7wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sLALVWf3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=43f7u0Ky; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741422847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3pyJB2EkvU93W8U+oMPUHBSwgPRMhuya9aSbYAnGSQQ=;
	b=sLALVWf3kp7IZOuzrIE/kW/sFeghlYz8I8AqbxFYNMzEGC70iOHO5kKwuST2Vxyrv9IRyg
	nh8oFR5MYNWUJRKZQLdYEr7zzKj0cS1zZFE9oqTJUnHmHOtV26jscSfKSswt4OCaygfQaW
	qGSljy0/AJkZ51cAOOl6agCHt0UUnOu17ARBKIy+YONdnyFI+kwr0cAd4oRDaZuA6nvRiE
	r9e04TSZsedzPN3V08XI+i9qHoiLhILQrEcBHuGelZJkpVxCCY66EY3eHbg5CLr/fmH8zg
	d3tEZJhF/PdbiV5UylCYqvih5AUUUWnRc6cqvxxuUCUFb7W4LQqt3n0gfCdQrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741422847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3pyJB2EkvU93W8U+oMPUHBSwgPRMhuya9aSbYAnGSQQ=;
	b=43f7u0KyHu7QpjCN5BQiS03zvnwfne4dAP6FwvdWcbseSJAO9VeqWsjbu3IyuDTjlckFCr
	q0RfmK9VPD8r7yCg==
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Benjamin Segall <bsegall@google.com>, Eric
 Dumazet <edumazet@google.com>, Andrey Vagin <avagin@openvz.org>, Pavel
 Tikhomirov <ptikhomirov@virtuozzo.com>, Peter Zijlstra
 <peterz@infradead.org>
Subject: Re: [patch V2 08/17] posix-timers: Rework timer removal
In-Reply-To: <Z8t7UJUd9SLT0Ytj@pavilion.home>
References: <20250302185753.311903554@linutronix.de>
 <20250302193627.416552300@linutronix.de> <Z8t7UJUd9SLT0Ytj@pavilion.home>
Date: Sat, 08 Mar 2025 09:34:06 +0100
Message-ID: <8734fn53b5.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 08 2025 at 00:03, Frederic Weisbecker wrote:
> Le Sun, Mar 02, 2025 at 08:36:56PM +0100, Thomas Gleixner a =C3=A9crit :
>> --- a/include/linux/posix-timers.h
>> +++ b/include/linux/posix-timers.h
>> @@ -240,6 +240,13 @@ static inline void posixtimer_sigqueue_p
>>=20=20
>>  	posixtimer_putref(tmr);
>>  }
>> +
>> +static inline bool posixtimer_valid(const struct k_itimer *timer)
>> +{
>> +	unsigned long val =3D (unsigned long)timer->it_signal;
>> +
>> +	return !(val & 0x1UL);
>> +}
>>  #else  /* CONFIG_POSIX_TIMERS */
>>  static inline void posixtimer_sigqueue_getref(struct sigqueue *q) { }
>>  static inline void posixtimer_sigqueue_putref(struct sigqueue *q) { }
>> --- a/kernel/signal.c
>> +++ b/kernel/signal.c
>> @@ -2092,7 +2092,7 @@ static inline void posixtimer_sig_ignore
>>  	 * from a non-periodic timer, then just drop the reference
>>  	 * count. Otherwise queue it on the ignored list.
>>  	 */
>> -	if (tmr->it_signal && tmr->it_sig_periodic)
>> +	if (posixtimer_valid(tmr) && tmr->it_sig_periodic)
>>  		hlist_add_head(&tmr->ignored_list, &tsk->signal->ignored_posix_timers=
);
>>  	else
>>  		posixtimer_putref(tmr);
>> --- a/kernel/time/posix-timers.c
>> +++ b/kernel/time/posix-timers.c
>> @@ -279,7 +279,7 @@ static bool __posixtimer_deliver_signal(
>>  	 * since the signal was queued. In either case, don't rearm and
>>  	 * drop the signal.
>>  	 */
>> -	if (timr->it_signal_seq !=3D timr->it_sigqueue_seq || WARN_ON_ONCE(!ti=
mr->it_signal))
>> +	if (timr->it_signal_seq !=3D timr->it_sigqueue_seq || !posixtimer_vali=
d(timr))
>
> Hmm, should it still warn here? ie: WARN_ON_ONCE(!posixtimer_valid(timr))=
 ?

No, because the timer is invalidated early now.

Thanks,

        tglx

