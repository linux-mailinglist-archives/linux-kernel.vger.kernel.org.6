Return-Path: <linux-kernel+bounces-208569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7F49026E9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 18:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BA8E28654A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 16:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4139814D6E4;
	Mon, 10 Jun 2024 16:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NwpyE9ZS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4Nz0FNd5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0497B147C79
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 16:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718037740; cv=none; b=LfY4fItyir8yISckXVTFz3EV1HboKHGcMXDFLIyIeed2IgBh1TxSfOduCVlsIYAjFbwlumSCfkc4UIn9rF9LeDv+Jgr7sSUhgx2M+f3B+U61K4JyEGwLasRdQMHOKFVidjpGKdo/BNB1EOJOADDFc80dzqdcibc0GAvmyF4pPAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718037740; c=relaxed/simple;
	bh=5E5SF6djGIEJs9V+wAgKePOcQC5ojpZdVLcsv/5ENUo=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=kNpNeL/k+K6KPyNChNgTUypOj9G5LmXHv4iGFVWs13HPidv3dC78XjHBNMkqyTZkMF7RJCSOTE99500pzcgLjqnyE3LN2i8JY72T+hjDseaozW6FvLgutQ4VS2A5aRRuVy5LYYsJUUmqVIWNy9yiot+rO9ypar8qba8P7JO3ZLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NwpyE9ZS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4Nz0FNd5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240610164025.906237276@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718037734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=+/WP0ANjczawtPlZe0Ru3wamTdkxabLE/EGLxYuvFcc=;
	b=NwpyE9ZSbI7SUhvVCW4pjpWpoAPKEG4zEymUB9t6tfyuRF1KDxS5/4IAB+JiTuyAOvelIZ
	0oVv4fjWkf/jgb7H2RaAc1NB9c/NFFhwJCPt6hTO9Cae170e+imtVZ6mVXdCbggt6gZ7V7
	OA9P5msoUWFDA9YPH1nbe3qJzSFXp7NQ9BPFqX2rAzH37Jg1d08CglEdoJQZW9gqdTlmcw
	zQRfSA6zRTjymFcObtvNkTEe0P9h3o1P+RQ0iwGXSXGp11rl/O9yQfQozZAJWVu5kjwtAb
	jz7AAn9PWWtBdYNiu67WjndBkL79d7V4EikFDIJKEw+bZt4EHNs9cWbJWZeY0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718037734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=+/WP0ANjczawtPlZe0Ru3wamTdkxabLE/EGLxYuvFcc=;
	b=4Nz0FNd5QnnxPf9j+V5uVBhIAG0wtvFCbMZDOchf8xsLZIDkRZZXn0tMT6+bEFhP9B+3VG
	1GxxZzq4eI3GVWCg==
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
Subject: [patch V3 07/51] posix-cpu-timers: Split up posix_cpu_timer_get()
References: <20240610163452.591699700@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Jun 2024 18:42:14 +0200 (CEST)

In preparation for addressing issues in the timer_get() and timer_set()
functions of posix CPU timers.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Split out into new patch to make review simpler - Frederic
---
 kernel/time/posix-cpu-timers.c |   51 +++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 27 deletions(-)

--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -785,33 +785,9 @@ static int posix_cpu_timer_set(struct k_
 	return ret;
 }
 
-static void posix_cpu_timer_get(struct k_itimer *timer, struct itimerspec64 *itp)
+static void __posix_cpu_timer_get(struct k_itimer *timer, struct itimerspec64 *itp, u64 now)
 {
-	clockid_t clkid = CPUCLOCK_WHICH(timer->it_clock);
-	struct cpu_timer *ctmr = &timer->it.cpu;
-	u64 now, expires = cpu_timer_getexpires(ctmr);
-	struct task_struct *p;
-
-	rcu_read_lock();
-	p = cpu_timer_task_rcu(timer);
-	if (!p)
-		goto out;
-
-	/*
-	 * Easy part: convert the reload time.
-	 */
-	itp->it_interval = ktime_to_timespec64(timer->it_interval);
-
-	if (!expires)
-		goto out;
-
-	/*
-	 * Sample the clock to take the difference with the expiry time.
-	 */
-	if (CPUCLOCK_PERTHREAD(timer->it_clock))
-		now = cpu_clock_sample(clkid, p);
-	else
-		now = cpu_clock_sample_group(clkid, p, false);
+	u64 expires = cpu_timer_getexpires(&timer->it.cpu);
 
 	if (now < expires) {
 		itp->it_value = ns_to_timespec64(expires - now);
@@ -823,7 +799,28 @@ static void posix_cpu_timer_get(struct k
 		itp->it_value.tv_nsec = 1;
 		itp->it_value.tv_sec = 0;
 	}
-out:
+}
+
+static void posix_cpu_timer_get(struct k_itimer *timer, struct itimerspec64 *itp)
+{
+	clockid_t clkid = CPUCLOCK_WHICH(timer->it_clock);
+	struct task_struct *p;
+	u64 now;
+
+	rcu_read_lock();
+	p = cpu_timer_task_rcu(timer);
+	if (p) {
+		itp->it_interval = ktime_to_timespec64(timer->it_interval);
+
+		if (cpu_timer_getexpires(&timer->it.cpu)) {
+			if (CPUCLOCK_PERTHREAD(timer->it_clock))
+				now = cpu_clock_sample(clkid, p);
+			else
+				now = cpu_clock_sample_group(clkid, p, false);
+
+			__posix_cpu_timer_get(timer, itp, now);
+		}
+	}
 	rcu_read_unlock();
 }
 


