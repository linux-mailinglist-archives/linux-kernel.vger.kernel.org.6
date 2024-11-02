Return-Path: <linux-kernel+bounces-393454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 816069BA0DA
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 15:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C0881F21B09
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 14:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4EC166F0C;
	Sat,  2 Nov 2024 14:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BODplK6g";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MjBJVy2X"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98D582890
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 14:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730558994; cv=none; b=KNTb1K5bSsqfVoeidx30mhbT24qJ3ezxxYYwNrzlENk9y5VVl+96arkPcqkFYrKR4q8Oj5eUr046XlNxp2FHNwbpqqzxEKfG97Kz9XX8gDJ/jhRgXJ6YbDWWVe0OGx7xMHOMDISb+230UePxMKs8JVV7dJ4ko7rwS8T5THb9bPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730558994; c=relaxed/simple;
	bh=Q2YcYcVi4AZ2gQXmpt8UIWfTiBvaN85/dOPRp5ItsOo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D7Ov8a/BJZmKg35ctJq34jAfsfaD4JjODFxhRrBfM/X9uhvuEM98zMVOEJa//5yLr6g9mtHjvgXr5mMsCkcV4pGXn2EAvua4HdkdIZJ+5FuDufDZZRBTRsOp8bJXykPNzl4ly1fGwrjRMtJaS3Mbq5IlPjSbU9Zvq5YkdeHTe8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BODplK6g; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MjBJVy2X; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730558991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t+teOnb3WyPyNnvinDVx2vmnpsGTy1zfxJqgp2ZHy0o=;
	b=BODplK6gNr5F1pmh1/O+1JtzqD8WzhOs+E/wt/c2nA4ElHgD5DsIdbSB6nSVQFvlWT+hLL
	dodHiT0UxvxJx/ez4AH4Zg3Md9mjhpSDtP5Y/oxBuSQeY2FHkZG8rJVVBFOTNdrsgJBezx
	Tml6CbL/B7ULWQDUTta+9GTXfHMba9BdgEFMaPDY3h7K+VQEhW8U2EqMNEfkfRmpjcL8Jc
	tBk4GlDGwTPopodRJBlORGo5pCqYb8iyKj0s/fRzPxvWhBIZDwXmc5A4+sYDxMAU0ZhRhf
	93hCjGrx5C77ujuh75Y8HoafNc62bUvV3wo/j9eqIJg3lfjDkON988PR+pJAiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730558991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t+teOnb3WyPyNnvinDVx2vmnpsGTy1zfxJqgp2ZHy0o=;
	b=MjBJVy2Xt7s7fs5LoJnqE5uIwtLKjObAdwnK10rgyX/SHjFUdiMBFfBQt9/0JdPZVMQG0o
	G754+M75oNBiILBg==
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, John Stultz <jstultz@google.com>, Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Stephen
 Boyd <sboyd@kernel.org>, Eric Biederman <ebiederm@xmission.com>, Oleg
 Nesterov <oleg@redhat.com>
Subject: Re: [patch v6 17/20] signal: Queue ignored posixtimers on ignore list
In-Reply-To: <871pzuvfzg.ffs@tglx>
References: <20241031151625.361697424@linutronix.de>
 <20241031154425.624061922@linutronix.de>
 <ZyTj2W8Jndv0nzga@localhost.localdomain> <871pzuvfzg.ffs@tglx>
Date: Sat, 02 Nov 2024 15:49:50 +0100
Message-ID: <87bjyxr8q9.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 01 2024 at 21:47, Thomas Gleixner wrote:
> On Fri, Nov 01 2024 at 15:21, Frederic Weisbecker wrote:
>> Le Thu, Oct 31, 2024 at 04:46:43PM +0100, Thomas Gleixner a =C3=A9crit :
>>> +static void sigqueue_free_ignored(struct task_struct *tsk, struct sigq=
ueue *q)
>>> +{
>>> +	if (likely(!(q->flags & SIGQUEUE_PREALLOC) || q->info.si_code !=3D SI=
_TIMER))
>>> +		__sigqueue_free(q);
>>> +	else
>>> +		posixtimer_sig_ignore(tsk, q);
>>
>> So this happens when the signal is ignored and delays it to when it will=
 be
>> unignored. But the comment on do_sigaction() says:
>>
>> 		/*
>> 		 * POSIX 3.3.1.3:
>> 		 *  "Setting a signal action to SIG_IGN for a signal that is
>> 		 *   pending shall cause the pending signal to be discarded,
>> 		 *   whether or not it is blocked."
>> 		 *
>> 		 */
>>
>> Are posix timers an exception to that rule?
>>
>> Also I see flush_sigqueue_mask() called on other occasions, for example
>> when a STOP signal happens to remove pending CONT, not sure if posix
>> timers can set SIGCONT...
>
> No. The problem with posix timers is that they are magically different
> from regular signals in the case of periodic timers.
>
> When the signal is ignored at expiry, then the signal is not delivered
> and is 'dropped'. But when SIG_IGN is removed then the following period
> expiry has to deliver the signal.
>
> Right now the kernel ensures that by keeping the timer self rearming and
> rate limiting it for obvious reasons. That's a completely pointless
> exercise up to the point where SIG_IGN is removed.
>
> The only way to avoid the self rearming is to actually stop the timer
> when the signal is ignored and rearm it when SIG_IGN for the specific
> signal is removed.
>
> That's what this magic does...

But it does not exclude oneshot timers from this. Their signal has to be
dropped for real.

Delta patch below.

Thanks,

        tglx
---
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -731,7 +731,7 @@ void signal_wake_up_state(struct task_st
 		kick_process(t);
 }
=20
-static inline void posixtimer_sig_ignore(struct task_struct *tsk, struct s=
igqueue *q);
+static inline bool posixtimer_sig_ignore(struct task_struct *tsk, struct s=
igqueue *q);
=20
 static void sigqueue_free_ignored(struct task_struct *tsk, struct sigqueue=
 *q)
 {
@@ -1999,8 +1999,8 @@ int posixtimer_send_sigqueue(struct k_it
 			goto out;
=20
 		if (hlist_unhashed(&tmr->ignored_list)) {
-			hlist_add_head(&tmr->ignored_list, &t->signal->ignored_posix_timers);
-			posixtimer_sigqueue_getref(q);
+			if (posixtimer_sig_ignore(t, tmr))
+				posixtimer_sigqueue_getref(q);
 		}
 		goto out;
 	}
@@ -2024,11 +2024,15 @@ int posixtimer_send_sigqueue(struct k_it
 	return 0;
 }
=20
-static inline void posixtimer_sig_ignore(struct task_struct *tsk, struct s=
igqueue *q)
+static inline bool posixtimer_sig_ignore(struct task_struct *tsk, struct s=
igqueue *q)
 {
 	struct k_itimer *tmr =3D container_of(q, struct k_itimer, sigq);
=20
+	/* Only queue periodic timer signals */
+	if (tmr->status !=3D POSIX_TIMER_REQUEUE_PENDING)
+		return false;
 	hlist_add_head(&tmr->ignored_list, &tsk->signal->ignored_posix_timers);
+	return true;
 }
=20
 static void posixtimer_sig_unignore(struct task_struct *tsk, int sig)

