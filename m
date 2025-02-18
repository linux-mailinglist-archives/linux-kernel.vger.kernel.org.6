Return-Path: <linux-kernel+bounces-518953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B68A396B1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 10:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDCE83B6FBD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A792322F39C;
	Tue, 18 Feb 2025 09:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DUtEnXkQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zfTQVk84"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C28C22D7B1
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 09:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739869431; cv=none; b=TEpQ3HuoPHwGR+cKozgASQm9E0X8UlDCyazOpuEJnxIotPshzWxeJ/BIe2iiHat5C7hhhIRdgaEqvpnHoe232Jodh5/rmcbt0cCOwiNM2sflA1nWZ2ZWe90RogWVHjVlap1bZtIhiCXfg5OLSQ2wcfgFZ+VCZB/3k6js7W7Ikjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739869431; c=relaxed/simple;
	bh=A8M5OIt1A8haL0ANfazcjwGDE5o5/zvzY33OU08iPqo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rHdCaJuYeaCadiz0DrKkUwEhBD8rrPnM6RMy0EYackQOqV7XspDMZuoBLbyBj8naEAmPaAxYQTzsWt5XSTAF2v5fsd2H5szJhqtruDipb0NXSVYgs62TRypPlWBp6LS/vUpzRlZHzbuKgJcPd+BDFQmJlcY88x+Lj+f7q2ZmlFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DUtEnXkQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zfTQVk84; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739869427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YleaTUFwb+U28EVqnF7wPDY8Ikwa5wlJUueP+F/3THg=;
	b=DUtEnXkQ+lQw54IJaF9ZxrG+5GMaVXVaUYr2TxSaNVPmW3Za6neVU8A6OqJ6uuXIunKgT7
	qmKuAoh7qrZT8z4gyCltCJUy67QLPuozeNrCJI+TY4zK+dg8jzLnVgCGGSZ7Vuuu24E+Ev
	0C14Gc151lHunt1MqUmJRqz3+2CngOuJ7AYXanM63ah86WTPomA3YkZ/T8GKIcS4Kzuoyc
	0C8kunD5nAAej93WbTo9e03/VKT5UHpjqK8ajpPuWOQ5r1EKfMEABPXAmt7EdS4hhPxt/l
	GLClpAHFbKqAGrzgm/EeiX/lsKnd6zD7rH0naZFv1PKRovqk39JbDsIiRGUyUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739869427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YleaTUFwb+U28EVqnF7wPDY8Ikwa5wlJUueP+F/3THg=;
	b=zfTQVk84O+lnDFxlOaFy7UzXujCSD+zqdx24vBSCWRcYUaU1CZnNTmen7gQEKnCXr9+ZBg
	HaJsh6BSar1QlRDA==
To: Benjamin Segall <bsegall@google.com>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>,
 linux-kernel@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] posix-timers: cond_resched() during exit_itimers()
In-Reply-To: <xm2634gg2n23.fsf@google.com>
References: <xm2634gg2n23.fsf@google.com>
Date: Tue, 18 Feb 2025 10:03:47 +0100
Message-ID: <877c5nk4jw.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Feb 14 2025 at 14:12, Benjamin Segall wrote:
> exit_itimers() loops through every timer in the process to delete it.
> This requires taking the system-wide hash_lock for each of these locks,
> and contends with other processes trying to create or delete timers.
> When a process creates hundreds of thousands of timers, and then exits
> while other processes contend with it, this can trigger softlockups on
> CONFIG_PREEMPT=n.
>
> Ideally this will some day be better solved by eliminating the global
> hashtable, but until that point mitigate the issue by doing
> cond_resched in that loop.

It won't help for a PREEMPT_NONE kernel because the loop will be equally
long as before. Only the hash lock contention will be smaller, but that
does not mean that mopping up 100k timers won't be able to take ages.

We really need to get this PREEMPT_LAZY thing going and kill all of this
cond_resched() nonsense.

Thanks,

        tglx

