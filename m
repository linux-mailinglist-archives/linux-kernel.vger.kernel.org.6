Return-Path: <linux-kernel+bounces-557002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2D2A5D23D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 23:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA6C017C17E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 22:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CECF264FAA;
	Tue, 11 Mar 2025 22:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W2UEnNsr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KX7TT/O4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03423199FBA
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 22:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741730738; cv=none; b=MMeeSBzomMqMztidcDHMwpkOhN6vzbuM/JhfaFMpOcTg6UOEN/7BEVu84p7gG8zShgIjs8wn1mC3Fuqx/nrNvETY37eMqsuWb96DI1uzx4yYeIEGSr9xBzHx63ZdgLUCHwlhU8urG13V1f/gDNVL++92f9ROTaO3NIL99KV8COQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741730738; c=relaxed/simple;
	bh=AnPeBV9v0eQavJOTunchPujDNLwoucDO6rKl+JbAnAk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Keqviosz43OCTSjphD7vfvIwlZCz8OhG674ticdPTY6sCnKUQMoK4Na2goFKXekDcS6k79jOjdaAUXDc91+RSen9NivW9ovmunvDfhIZxaikuJBuxcMa6Lu4tvj5NytdxWC3RsvGSGphosrrHa/kYkorEhz0aXT7jyDLZRmT2bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W2UEnNsr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KX7TT/O4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741730734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vACigLEGtHhpuAQOGkUduRRDHEuvNOA0vqBD9eiwbdE=;
	b=W2UEnNsrbcqKiBlx1jnNei4XFM4kWebJa27VSv0WuuDk1C+sR/LtZVv3xxGmcUSuVz6bI6
	bEGvhVhBu/7Mg1CuarPePAiMNgX0zSwh4KkDlNYUfjMqKXQFnwKCrKPiddIKN+t/Vf3Hkk
	+AwSQO2p1zkPPstFUnPTd+QhbCYoexpm1OIF9bsBsxG1EzWagtYzckHWtOYr3XcPPRkkTg
	Oaj3hTRWNgJB+xGH7JQJNFP10xmAKFMApzHtLc6kKcu+b8RcMNX7lUXHNIh+k6V5b6mp3b
	2FDFqzo2mtP3eK31PKftLoG/sRYzem08zo7WD2WrLbt3hvHsvz3E8vbN7k6R+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741730734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vACigLEGtHhpuAQOGkUduRRDHEuvNOA0vqBD9eiwbdE=;
	b=KX7TT/O44LA48Z/wBKbKU3MOhO6fy8FmwUXCBFHqAK+j6HvjmP+am4vOJNMBCQG5RkxWlx
	dX9SfdXPY3sx1ZBw==
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Benjamin Segall <bsegall@google.com>, Eric
 Dumazet <edumazet@google.com>, Andrey Vagin <avagin@openvz.org>, Pavel
 Tikhomirov <ptikhomirov@virtuozzo.com>, Peter Zijlstra
 <peterz@infradead.org>, Cyrill Gorcunov <gorcunov@gmail.com>
Subject: Re: [patch V3 17/18] posix-timers: Provide a mechanism to allocate
 a given timer ID
In-Reply-To: <Z9CsstMf-EVZpsiH@pavilion.home>
References: <20250308155501.391430556@linutronix.de>
 <20250308155624.526740902@linutronix.de> <Z9CsstMf-EVZpsiH@pavilion.home>
Date: Tue, 11 Mar 2025 23:05:34 +0100
Message-ID: <87msdrz0i9.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11 2025 at 22:35, Frederic Weisbecker wrote:
> Le Sat, Mar 08, 2025 at 05:48:47PM +0100, Thomas Gleixner a =C3=A9crit :
>> @@ -364,6 +389,16 @@ static enum hrtimer_restart posix_timer_
>>  	return HRTIMER_NORESTART;
>>  }
>>=20=20
>> +long posixtimer_create_prctl(unsigned long ctrl)
>> +{
>> +	if (ctrl > PR_TIMER_CREATE_RESTORE_IDS_ON)
>> +		return -EINVAL;
>> +
>> +	guard(spinlock_irq)(&current->sighand->siglock);
>> +	current->signal->timer_create_restore_ids =3D ctrl =3D=3D PR_TIMER_CRE=
ATE_RESTORE_IDS_ON;
>
> Is the locking necessary here? It's not used on the read side.
> It only makes sense if more flags are to be added later in struct signal =
and the
> fields write can race.

True.

> Also do we want to carry this PR_TIMER_CREATE_RESTORE_IDS_ON accross exec=
? Posix
> timers are removed then anyway.

Indeed, we should clear that.

