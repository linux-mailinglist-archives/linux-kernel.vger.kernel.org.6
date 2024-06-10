Return-Path: <linux-kernel+bounces-208587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2DC9026FD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 18:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62E6F285361
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 16:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1FA155C83;
	Mon, 10 Jun 2024 16:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IIlphI4D";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4VIlzY69"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C250155340
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 16:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718037758; cv=none; b=lRIgCeFeb1JAsqKLtCkJDYNo7dnvUc6UHK04vkw2ckcSDf/0DT/tltP8edNloqpa1JKREQ1IItZ0Gy1gpY9IZG8Gfjn8UPfbwoEW4jpWufe5y8aTICxG7ilOeYAerslR7choTZblLuI1IboVMpItH+dL2a9RsQgOb/kFB9eGi1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718037758; c=relaxed/simple;
	bh=ur+O419OtXBNtUIZuacqd+BURpp8/MYytOmiM6ylieg=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=olbS/Jn9ZmQQhIvpSgkvZg9HmbRT8zKB571FsYk1JZVF4xGa2GWwUWAcK7fKNHKaD0emT9bsA6wZgYQ2K3UK698mKV+mF6NJPlMBVlsNOoRkkdBQ9vxGGJ1zfq6hOUzk0qns5NvAs+UquDTP0bTe/MzzNAmO8EBlVrM/odMZDlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IIlphI4D; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4VIlzY69; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240610164026.867722692@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718037752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=uSjFneRht2ixPq2dOvLaSspY3kohFRB8UKUX6K60b2g=;
	b=IIlphI4DxXo76Kiv1YYbaSFV6tFfDDQl3uEarQkXuuPW9elSA5qNR8Tk91E9zUKeuQkGWG
	+CB7i/1a/QK5TRqkbf8NORCHyhn7/h65demDoE+ZTYU+/V8PBOpa7EfSNx04BarTUdWCMh
	9FfXaRYaPMvg4hfcS3fJcu+d/XqKtyEUa0TooJ1MBNJM++wRry4H3mUek00ufuKSL03CE+
	XK4bGp4pQp3FYO99Xc6KcvM4Mre4zyx0T48CyowT4f9Lhzu2PAFrAkbTSfNFQWdOHKRQvB
	F1fMd0LLmXchGBG6253zwfXqHHBDTadGlHQmpSHBXxOuznDLw6ZukmK1vGar1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718037752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=uSjFneRht2ixPq2dOvLaSspY3kohFRB8UKUX6K60b2g=;
	b=4VIlzY69qSPCMQ+KPst1EN9isAxCf76erVBfmxSdOShcJHy6bV8RfHbMBh+j9b42wxCkmb
	HPSR34lSK89OcUAw==
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
Subject: [patch V3 22/51] posix-timers: Consolidate signal queueing
References: <20240610163452.591699700@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Jun 2024 18:42:32 +0200 (CEST)

Rename posix_timer_event() to posix_timer_queue_signal() as this is what
the function is about.

Consolidate the requeue pending and deactivation updates into that function
as there is no point in doing this in all incarnations of posix timers.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/alarmtimer.c       |    7 +------
 kernel/time/posix-cpu-timers.c |    4 ++--
 kernel/time/posix-timers.c     |   21 +++++++++++----------
 kernel/time/posix-timers.h     |    2 +-
 4 files changed, 15 insertions(+), 19 deletions(-)

--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -574,15 +574,10 @@ static enum alarmtimer_restart alarm_han
 					    it.alarm.alarmtimer);
 	enum alarmtimer_restart result = ALARMTIMER_NORESTART;
 	unsigned long flags;
-	int si_private = 0;
 
 	spin_lock_irqsave(&ptr->it_lock, flags);
 
-	ptr->it_active = 0;
-	if (ptr->it_interval)
-		si_private = ++ptr->it_requeue_pending;
-
-	if (posix_timer_event(ptr, si_private) && ptr->it_interval) {
+	if (posix_timer_queue_signal(ptr) && ptr->it_interval) {
 		/*
 		 * Handle ignored signals and rearm the timer. This will go
 		 * away once we handle ignored signals proper. Ensure that
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -598,9 +598,9 @@ static void cpu_timer_fire(struct k_itim
 		/*
 		 * One-shot timer.  Clear it as soon as it's fired.
 		 */
-		posix_timer_event(timer, 0);
+		posix_timer_queue_signal(timer);
 		cpu_timer_setexpires(ctmr, 0);
-	} else if (posix_timer_event(timer, ++timer->it_requeue_pending)) {
+	} else if (posix_timer_queue_signal(timer)) {
 		/*
 		 * The signal did not get queued because the signal
 		 * was ignored, so we won't get any callback to
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -277,10 +277,17 @@ void posixtimer_rearm(struct kernel_sigi
 	unlock_timer(timr, flags);
 }
 
-int posix_timer_event(struct k_itimer *timr, int si_private)
+int posix_timer_queue_signal(struct k_itimer *timr)
 {
+	int ret, si_private = 0;
 	enum pid_type type;
-	int ret;
+
+	lockdep_assert_held(&timr->it_lock);
+
+	timr->it_active = 0;
+	if (timr->it_interval)
+		si_private = ++timr->it_requeue_pending;
+
 	/*
 	 * FIXME: if ->sigq is queued we can race with
 	 * dequeue_signal()->posixtimer_rearm().
@@ -309,19 +316,13 @@ int posix_timer_event(struct k_itimer *t
  */
 static enum hrtimer_restart posix_timer_fn(struct hrtimer *timer)
 {
+	struct k_itimer *timr = container_of(timer, struct k_itimer, it.real.timer);
 	enum hrtimer_restart ret = HRTIMER_NORESTART;
-	struct k_itimer *timr;
 	unsigned long flags;
-	int si_private = 0;
 
-	timr = container_of(timer, struct k_itimer, it.real.timer);
 	spin_lock_irqsave(&timr->it_lock, flags);
 
-	timr->it_active = 0;
-	if (timr->it_interval != 0)
-		si_private = ++timr->it_requeue_pending;
-
-	if (posix_timer_event(timr, si_private)) {
+	if (posix_timer_queue_signal(timr)) {
 		/*
 		 * The signal was not queued due to SIG_IGN. As a
 		 * consequence the timer is not going to be rearmed from
--- a/kernel/time/posix-timers.h
+++ b/kernel/time/posix-timers.h
@@ -36,7 +36,7 @@ extern const struct k_clock clock_proces
 extern const struct k_clock clock_thread;
 extern const struct k_clock alarm_clock;
 
-int posix_timer_event(struct k_itimer *timr, int si_private);
+int posix_timer_queue_signal(struct k_itimer *timr);
 
 void common_timer_get(struct k_itimer *timr, struct itimerspec64 *cur_setting);
 int common_timer_set(struct k_itimer *timr, int flags,


