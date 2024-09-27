Return-Path: <linux-kernel+bounces-342113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C91E2988AB7
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 21:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A5C728314C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 19:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB301C2335;
	Fri, 27 Sep 2024 19:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qix9VuY3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H328Pc8C"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3DD1C2323
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 19:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727465085; cv=none; b=dqBPVc2o+Qe4E/9+jso6vkdMkyOQjFBa1128txNQ82iP3magoqj39wzULEsj0tninjfFgtF5+UQ9casshsrTEmRsAb2e4Mb9585KlR2u6WwA9q1m4KXIOsMlFuhg+2qJKXb/MtTBq/4ArKhUq3QTGcjKuZhaYokij1gkm1Tm2Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727465085; c=relaxed/simple;
	bh=BnVvJPg0q+ucLQBn9QzNWpsLwSSHsWnQ0QJjvTi8wzw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AEloD9bo9qHAVfpssa6CVldXYC6PgqTnHwPjBn+KBjX3w8uXrY9lg68MJF1lUpAJK2AIyxUyolGt+PSu3BC/rHHFeRT/vPOSTG36MAJFF9G5LJQLED2EdmTY2FnFFi810Xv5OVTIvYsmvv0AmK2UW3YRwpcSP+m/ax01xr+a1Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qix9VuY3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H328Pc8C; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727465081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F1ga0MGIrO4qo0RmiWY7ZcyKIypxbEhP6no11WpHP7A=;
	b=qix9VuY3aFkNjQpp09NLUS2qB1mlJXInvnXBod9UTswORzrLn+eFNubpLKEd9OpZrK9uHv
	PZ1LHsx01LwPEhtaqXJa3Gh0jBu6e1C1XXEicTo5w8Js+gD60qmXCXq9JgU8glVxTwAbku
	4fujbPYWn/VlmajiIzzL+2+U+PMrY4cgHtN3FDMo9crLyboIMK4xfXR4gPoe3m4ReBN6JZ
	Hjv+LhgC7rCYbeuJ7G4yG+5PwMbuYqBSM3vYCaNUB/aiYJN2x3PZ/JJmV12XegYduhAvrb
	aH8lMtKHGDlPyKYBYYxoB49aGpzowOn/DLIyg4POI7h9TBHKPuQm1t1fGrGtWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727465081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F1ga0MGIrO4qo0RmiWY7ZcyKIypxbEhP6no11WpHP7A=;
	b=H328Pc8CzP228AFK3jQSywn8u9AUmTDD4C1tpcAS0d9fQJQb5rtGXHPVeXvlhQWqU41cIP
	OTglQKznu/9mDrCg==
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>,
 John Stultz <jstultz@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Oleg
 Nesterov <oleg@redhat.com>
Subject: Re: [patch v4 00/27] posix-timers: Cure the SIG_IGN mess
In-Reply-To: <87o749xisy.fsf@email.froward.int.ebiederm.org>
References: <20240927083900.989915582@linutronix.de>
 <87o749xisy.fsf@email.froward.int.ebiederm.org>
Date: Fri, 27 Sep 2024 21:24:41 +0200
Message-ID: <87y13c293a.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Sep 27 2024 at 09:39, Eric W. Biederman wrote:
> I have stopped looking at this after patch 4.
>
> The current code can and does handle userspace injecting a signal with
> si_sys_private sent to an non-zero value using rt_sigqueueinfo(2) and
> that value will be delivered to userspace.
>
> I think the at least the ability to inject such a signal (ignoring
> si_sys_private) is very interesting for debuggers and checkpoint restart
> applications.
>
> I get the feeling the rest of the patch series depends upon not
> supporting userspace injecting signals with si_code == SI_TIMER.  That
> seems unnecessary.
>
> It seems reasonable to depend upon something like the SIGQUEUE_PREALLOC
> in the flags field of struct sigqueue to detect a kernel generated
> signal.  Rather than adding various hacks to make everything work
> with just a struct kernel_siginfo_t.  Especially as the timer signals
> today are the only signals that are preallocated.

Fair enough.

> Is there any chance 18/27 posix-timers: Embed sigqueue in struct k_itimer
> can be moved up?
>
> That should allow removing the reliance on si_sys_private.
>
> That should prevent the need to add another hack with sys_private_ptr in
> struct kernel_siginfo
>
> Perhaps what needs to happen is to update collect_signal to return the
> sigqueue entry (if it was preallocated), instead of the resched_timer.
> Then the timer code can just use container_of to get the struct
> k_itimer?
>
> After that si_sys_private can move into struct k_itimer, and the code
> won't need to worry about userspace setting that value, or about needing
> to clear that value.  As si_sys_private will always be 0 in preallocated
> signals.

Let me try that.

Thanks for taking a look!

       tglx

