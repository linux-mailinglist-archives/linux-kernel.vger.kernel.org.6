Return-Path: <linux-kernel+bounces-552614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A420A57C07
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 17:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1BAF3B10DA
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 16:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E431E51EF;
	Sat,  8 Mar 2025 16:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="momRytpo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Fh4QSoZW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD60C7E0E4
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 16:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741451938; cv=none; b=QlN0fj1rDMmkzE4ncSeWjPeGuz7GEXwZip9n0lMjztXWjjlM8luYeq1op2wScAQrd3ktYGXoDy/i57CdSqK1Pp/G5c0YRVp2yeZV9uiEMMfYbE6uJKkNQ5A8JGniiYoidUXnV81u0PRY31FfLUdlyw5MqqkStbVEgO8RBTAdk1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741451938; c=relaxed/simple;
	bh=2SDWDPaomnElzG+WD7yqrOl9G7sw1Nd/mfcdsQzBWeU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IiCHI547iDEIOgN6gd+tQ0CJ7vfUfY+mZAfRzi5cXWNRKkxwyspERJiV5jVVxq94liVvNMXMmA6rfRigjU25ZTn57n3G0efWl7IWybvOR1bXf6I6r5oMSmqqcrSRYCn9lCUbOVSFtf8l2AxsWRPuxG/Udop9ncHVsQAJRV1MFCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=momRytpo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Fh4QSoZW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741451932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1n4yktSAr4HEnt8a6SZkHziuG3cHf/Ek25Ap8+tZPko=;
	b=momRytpo1UCNPzFc7xJZxEqiy5nSlSOivXS8jQWTi55FA0Es8FEivoVt4oNH5oHU/dUdBR
	rYa1mbdT9/mq5642I5mCBlwfGU0Ae0HbqtIyD2gg8D9I012zFf2OrRI4KmzytC/f73+PUK
	10GCIf4BIHuQDPtnTXNSr1Wp4DcRoAkbmuK0QgTRQru9tmsRQDF7uB4vN+l4liOzI7wAp8
	G/wyVG9irClE+JknN7hqmqhrpLBbjXSwC4d8qwPibXmj53wC0ulMpHEYLSeI8LS0HyPW0n
	PmuAbJ6H8uBf0SozqrHz10Bu5BhYCiL0OZFcaduf130NR2Tsz7uA7rUkf5PnAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741451932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1n4yktSAr4HEnt8a6SZkHziuG3cHf/Ek25Ap8+tZPko=;
	b=Fh4QSoZWpp4kpijMN+eTbAhO+g2nn8yChBw/4V6vstJPoJ0U9IuUiUNtvExPBMPZIE+9HF
	ZJaJtYSxA2gOMfDw==
To: paulmck@kernel.org, linux-kernel@vger.kernel.org
Cc: jstultz@google.com, sboyd@kernel.org, christian@heusel.eu,
 kernel-team@meta.com, Peter Zijlstra <peterz@infradead.org>, Yafang Shao
 <laoar.shao@gmail.com>, Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
 Vincent Guittot
 <vincent.guittot@linaro.org>
Subject: Re: [PATCH v2] clocksource: Defer marking clocksources unstable to
 kthread
In-Reply-To: <11d36fdd-55c2-4f3b-96b1-dd442f759ba0@paulmck-laptop>
References: <11d36fdd-55c2-4f3b-96b1-dd442f759ba0@paulmck-laptop>
Date: Sat, 08 Mar 2025 17:38:51 +0100
Message-ID: <87plir32as.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Mar 06 2025 at 08:06, Paul E. McKenney wrote:
> The clocksource watchdog marks clocksources unstable from within a timer
> handler.  On x86, this marking involves an on_each_cpu_cond_mask(),
> which in turn invokes smp_call_function_many_cond(), which may not be
> invoked from a timer handler.  Doing so results in:
>
> WARNING: CPU: 3 PID: 0 at kernel/smp.c:815 smp_call_function_many_cond+0x46b/0x4c0
>
> Fix this by deferring the marking to the clocksource watchdog kthread.
> Note that marking unstable is already deferred, so deferring it a bit
> more should be just fine.

While this can be done, that's papering over the underlying problem,
which was introduced with:

  8722903cbb8f ("sched: Define sched_clock_irqtime as static key")

That added the static key switch, which is causing the problem. And
"fixing" this in the clocksource watchdog is incomplete because the same
problem exists during CPU hotplug when the TSC synchronization declares
the TSC unstable. It's the exactly same problem as was fixed via:

 6577e42a3e16 ("sched/clock: Fix up clear_sched_clock_stable()")

So as this got introduced in the 6.14 merge window, the proper fix is to
revert commit 8722903cbb8f and send it back to the drawing board. It was
clearly never tested with the various possibilities which invoke
mark_tsc*_unstable().

Thanks,

        tglx



