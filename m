Return-Path: <linux-kernel+bounces-379509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 398979ADF81
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 10:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68BEA1C2175A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 08:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DFCB1B0F10;
	Thu, 24 Oct 2024 08:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EYDXUAZp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vbw4Y72h"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D561716133C
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 08:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729759961; cv=none; b=nzuhaJhB4KfVtJwdNlZmfLJc7KpZBIRCplQOPP3YKoDR+1tEjmBSpBgVAxuVBxrfYQZZWTuEbN92AX9Vsr2Re4icuxw6P3AtjZSIh4s7yCzy3BInmny7uxNAdwmlcgexSnvwf2GWgaSQXDrrNSZp+3a9dqVes4I2Z3XSZlbIWyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729759961; c=relaxed/simple;
	bh=z0wdPe+PdQsB6H/hIv+XNRSHZha6CBKBef8/H137lJI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HqVxc8nqkBzap1Rse0hlfLpl0I7DSAjoHPtaQ6CXh1g77Q7806vIMIjcMtPItp/bHqaq+yxBGumdlL36n/+fJUpjRmr5MYOXH0Hgn/Z2R75DblcPaH+xg4weP2o/dUhvCuf3v7tBdel5Ncu6dcYUj3rpSMjBw+pYSwHXp3x+UNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EYDXUAZp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vbw4Y72h; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729759958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vO1x52qiJPMmVXO9d4njem3wDaP4CO3DkA/dPoclxh8=;
	b=EYDXUAZpAaN0vX+MetHClN+eR7nfwGrqUsT98cnERO3Nvlhp9hYNqyyzrJzmP//voKIMe4
	hErWmLI4h4csXeYHgO+iHND7ulcagLMt5hFIXgXFfyXyWl8HPzfciVi32rsdDM6e1j7LSk
	WqKqauaCwN5loNO0tNisgn59gU32WdFGLvcYCrFGiPlLO7iEkroor2+5eqfXEY8dQ1XWJM
	SHiF4vZQR5djLgEC0pVlIRvF4wLhRZa09Y1NqrL4Hrsl/4GUSqZqdYUcGUdcvLNqTQlev0
	5dwZFJW8w4tDvzmBO/mXiKGspuovle80hMQt5fmw4jymZdtIbMsDC8D7sQN0dA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729759958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vO1x52qiJPMmVXO9d4njem3wDaP4CO3DkA/dPoclxh8=;
	b=vbw4Y72hj5752xZlNUFw8p1pG3X31m6n5NDDk+oMXxNIWeF8Vd3gkF0uGFkT9LRp9UokhB
	F7kChl5WboapqCCA==
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, John Stultz <jstultz@google.com>, Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Stephen
 Boyd <sboyd@kernel.org>, Eric Biederman <ebiederm@xmission.com>, Oleg
 Nesterov <oleg@redhat.com>
Subject: Re: [patch V5 08/26] posix-timers: Make signal delivery consistent
In-Reply-To: <ZxZn9gwnk4Vr5L6k@localhost.localdomain>
References: <20241001083138.922192481@linutronix.de>
 <20241001083835.730528613@linutronix.de>
 <ZxZn9gwnk4Vr5L6k@localhost.localdomain>
Date: Thu, 24 Oct 2024 10:52:38 +0200
Message-ID: <87o7396fxl.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21 2024 at 16:40, Frederic Weisbecker wrote:
> Le Tue, Oct 01, 2024 at 10:42:10AM +0200, Thomas Gleixner a =C3=A9crit :
>> --- a/kernel/time/posix-timers.c
>> +++ b/kernel/time/posix-timers.c
>> @@ -269,7 +269,10 @@ bool posixtimer_deliver_signal(struct ke
>>  	if (!timr)
>>  		goto out;
>>=20=20
>> -	if (timr->it_interval && timr->it_signal_seq =3D=3D info->si_sys_priva=
te) {
>> +	if (timr->it_signal_seq !=3D info->si_sys_private)
>> +		goto out_unlock;
>> +
>> +	if (timr->it_interval && timr->it_status =3D=3D POSIX_TIMER_REQUEUE_PE=
NDING) {
>
> Can it be something else than POSIX_TIMER_REQUEUE_PENDING actually?
> And if not, should it be a WARN_ON() ?

Good point. It should not be anything else than pending.

>>  		timr->kclock->timer_rearm(timr);
>>=20=20
>>  		timr->it_status =3D POSIX_TIMER_ARMED;
>> @@ -281,6 +284,7 @@ bool posixtimer_deliver_signal(struct ke
>>  	}
>>  	ret =3D true;
>>=20=20
>> +out_unlock:
>>  	unlock_timer(timr, flags);
>>  out:
>>  	spin_lock(&current->sighand->siglock);
>> @@ -293,19 +297,19 @@ bool posixtimer_deliver_signal(struct ke
>>  int posix_timer_queue_signal(struct k_itimer *timr)
>>  {
>>  	enum posix_timer_state state =3D POSIX_TIMER_DISARMED;
>> -	int ret, si_private =3D 0;
>>  	enum pid_type type;
>> +	int ret;
>>=20=20
>>  	lockdep_assert_held(&timr->it_lock);
>>=20=20
>>  	if (timr->it_interval) {
>> +		timr->it_signal_seq++;
>
> Is the increment here is still needed then, since it's done
> from del and set?

Probably not. Let me stare at it.

Thanks,

        tglx

