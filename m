Return-Path: <linux-kernel+bounces-208594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24773902704
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 18:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AA751C20D6D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 16:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9624156F27;
	Mon, 10 Jun 2024 16:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FqXblgKu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k6ofh+DP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E9D156898
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 16:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718037767; cv=none; b=EfKMhw2sDW2lPt71X7CEX7iDKKmjJIvycjDH34EjMnY4Dx941Fx/zPEtNXL9cuHC1yTZANppN7lffoQwIpthjnFg1Z9N7UWyY1DyKH/2K+Mhev8t7uRvUq3TjZHGX2WI+TbSKp/zl2AptS8WwGH4rHRhKuZW4rgAKSRzTPTVHuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718037767; c=relaxed/simple;
	bh=5k+o9FSXZnXGzFOAjEfjafxS6KdlxmAI2+L7+gmWoPY=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=bYNqxUVcpNzH74bw1SmmZFWtFMxfNflq5mA5tYziCHxz+SMVUl7A0T3YSaaLOnzs8vzgPOTUb1OD/SXuKk7b504qF6668KeZhVs1v+YcYMbkAnPSMAGqF2CERdrTgWRfo7I6SUYJU8SjKWE9zFUeH2ebB1NeKZK/TzWAmBxLy20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FqXblgKu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=k6ofh+DP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240610164027.364129340@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718037762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=PVNa4KLijTQ7CcOYu3CDLgD0Q8pt6GmBRvk3JFfaO1Y=;
	b=FqXblgKuRlgHyqXKr1+nkH7FnQ5sV67sE3uyszHAkKTxQWdqZ4r+eA7+RM+rAxfR6Tvqt/
	6MVO4dj4JVhS6MHEjd0DUatdXprJF9GTwDCmMdDNQFLR7vb6oAu2RR64bqZs8ax5T8Bk/h
	8NY+LPTHoVC7iXIs9CqQPkmdDrnIdT14zbwhMTORnfiAX7+N5zgZ3ckXxV1/7fYtjVFH3A
	gmsSvW7bPonv9kGeSljHgp8YJ7S0qAYoRumw1krB20yEnR0Va/b9DuDwXxoAB6HVUU7VWc
	WU2KZVKSWWLkPVuPGAv5W0gQuvusOHQG+PwGA8d58fsBNTsvTGF17rdLir5K+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718037762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=PVNa4KLijTQ7CcOYu3CDLgD0Q8pt6GmBRvk3JFfaO1Y=;
	b=k6ofh+DPwY9Zlac2y5feg56pVoQUDqHibfKHTWQW9rUBwLoSspOxVzMlpE1hU7nbj1ECP7
	l6xUwgee4mSa0bDg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 John Stultz <jstultz@google.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>,
 Eric Biederman <ebiederm@xmission.com>,
 Oleg Nesterov <oleg@redhat.com>
Subject: [patch V3 30/51] posix-timers: Drop signal if timer has been deleted
 or reprogrammed
References: <20240610163452.591699700@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Jun 2024 18:42:42 +0200 (CEST)

No point in delivering a signal from the past. POSIX does not specify the
behaviour here:

 - "The effect of disarming or resetting a timer with pending expiration
    notifications is unspecified."

 - "The disposition of pending signals for the deleted timer is unspecified."

In both cases it is reasonable to expect that pending signals are
discarded. Especially in the reprogramming case it does not make sense to
account for previous overruns or to deliver a signal for a timer which has
been disarmed.

Drop the signal as that is conistent and understandable behaviour.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/posix-timers.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -250,14 +250,14 @@ static void common_hrtimer_rearm(struct
 }
 
 /*
- * This function is called from the signal delivery code if
- * info::si_sys_private is not zero, which indicates that the timer has to
- * be rearmed. Restart the timer and update info::si_overrun.
+ * This function is called from the signal delivery code. It decides
+ * whether the signal should be dropped and rearms interval timers.
  */
 bool posixtimer_deliver_signal(struct kernel_siginfo *info)
 {
 	struct k_itimer *timr;
 	unsigned long flags;
+	bool ret = false;
 
 	/*
 	 * Release siglock to ensure proper locking order versus
@@ -279,6 +279,7 @@ bool posixtimer_deliver_signal(struct ke
 
 		info->si_overrun = timer_overrun_to_int(timr, info->si_overrun);
 	}
+	ret = true;
 
 	unlock_timer(timr, flags);
 out:
@@ -286,7 +287,7 @@ bool posixtimer_deliver_signal(struct ke
 
 	/* Don't expose the si_sys_private value to userspace */
 	info->si_sys_private = 0;
-	return true;
+	return ret;
 }
 
 int posix_timer_queue_signal(struct k_itimer *timr)


