Return-Path: <linux-kernel+bounces-554815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F8BA59F0A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 18:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFC857A7CDE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB53F233716;
	Mon, 10 Mar 2025 17:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gZPDXt9d";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ca8QtXAg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE6822ACDC
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 17:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741628182; cv=none; b=Wm5WcloAuAZ9a7vqttmkbJe1r0s5gMHhX+EpE8k0WMgtYSEGxNUWAeXZNcERphnjt528R+SZLQiofTrMtai+2KiXMJFVm0DfbBS5si2qCf+ojh8M9Qk8X+HcE7mhaBxQV2eV3aceE2aaKQxtYNhTkyre95caG1XjrzX6lLv9c0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741628182; c=relaxed/simple;
	bh=z5sUIvzdZ0AUC0NapioUuyYM7Y5jBE1sjAN+n8md1Ws=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IUWy0+o9rKhqt4GlX+A2EnBShVIpvYk/jPitIXPUvHWrxSeYfHqukHNIBikqqMMfuq++bxazInXsd9zlO8MEmUgxPu4/I7l5AUR6bINLHsQScTbyW+9JNWFKPK/hlouhnahsm8+n+SHtq97675NCLYbg7VmJo44F64IMBVxRvR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gZPDXt9d; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ca8QtXAg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741628179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YZnHsW8cWnv4gIIkwuFEngafSnbmEjJNlaPaEk7LW+Q=;
	b=gZPDXt9dmPGmZhUhIw6rVICIT5mTzAGWIPbY8MqqLil2yZpe1X91/VRDgarAV5/gwwqv8n
	nS2SUq9s+5sRH5GYq9Cvf5aCr2TeXc86CYwfz3jhwHsnjLK8h8KRHru5B0jPPmc0gz2YZd
	2XRqLhZiQH8gOsDf2UdfFR8kskbLLJWHtR6M0jYm23LouuKt/2ax1ry5UfStQRmGbrzt3H
	U4D5NS8WkLKf14tADOhw/IfdyIbrZ78mgOwWSC37KGeQRrdYUJDsonpmFV2YvM3WjSks04
	vsy0h4+E2qzbdOG6WhGf6MGm0rGDMTIcBiRRdmw/uEOXKFxqq9ITJRPkDFrfOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741628179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YZnHsW8cWnv4gIIkwuFEngafSnbmEjJNlaPaEk7LW+Q=;
	b=ca8QtXAgcM9A/mm6UkSWj/pIHIRDuJRfNJUstkO0ykH4QbYXIUsrRPgPezTaCnzJigsU9r
	yBx3rLsIzfkIVyAA==
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Benjamin Segall <bsegall@google.com>, Eric
 Dumazet <edumazet@google.com>, Andrey Vagin <avagin@openvz.org>, Pavel
 Tikhomirov <ptikhomirov@virtuozzo.com>, Peter Zijlstra
 <peterz@infradead.org>, Cyrill Gorcunov <gorcunov@gmail.com>
Subject: Re: [patch V3 10/18] posix-timers: Make lock_timer() use guard()
In-Reply-To: <Z87Tj5BryQd9Rya8@pavilion.home>
References: <20250308155501.391430556@linutronix.de>
 <20250308155624.087465658@linutronix.de> <Z87Tj5BryQd9Rya8@pavilion.home>
Date: Mon, 10 Mar 2025 18:36:18 +0100
Message-ID: <87o6y823fx.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10 2025 at 12:57, Frederic Weisbecker wrote:
> Le Sat, Mar 08, 2025 at 05:48:34PM +0100, Thomas Gleixner a =C3=A9crit :
>> --- a/kernel/time/posix-timers.c
>> +++ b/kernel/time/posix-timers.c
>> @@ -63,9 +63,18 @@ static struct k_itimer *__lock_timer(tim
>>=20=20
>>  static inline void unlock_timer(struct k_itimer *timr)
>>  {
>> -	spin_unlock_irq(&timr->it_lock);
>> +	if (likely((timr)))
>> +		spin_unlock_irq(&timr->it_lock);
>>  }
>>=20=20
>> +#define scoped_timer_get_or_fail(_id)					\
>> +	scoped_cond_guard(lock_timer, return -EINVAL, _id)
>
> I'm not really fond of the fact this hides a return.

I could drop the macro and let the call sites all do:

	scoped_cond_guard(lock_timer, return -EINVAL, $d)

But I'm not sure it's much better :)

