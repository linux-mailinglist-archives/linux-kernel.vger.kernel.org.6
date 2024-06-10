Return-Path: <linux-kernel+bounces-208575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B32479026F1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 18:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C5D91F22BFA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 16:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D5C1514D0;
	Mon, 10 Jun 2024 16:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="351GCj/b";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vON8lXJ6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE4E14B95F
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 16:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718037742; cv=none; b=OLoQ/Pg1Xxry7u//YvGruY6AdupeyxqGoBaetBCHBzVq0a1zA6fkEZrWfWbXKipdCTUtpCNvFwb1k7OumfgAsLNvWz8cSEVZsokL/4MrWgM+67VCHYe7yNoUdxMHnxQucyexr9GdfYz2pr984YN2YUV1dZWZ8SWWZnwCwb6LPWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718037742; c=relaxed/simple;
	bh=tBM7wjzipNsnWNbyoaSXjOxN31IJ8Anu9Imn8eeRuXc=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=KXsJxElQ9MR6xKi3afJ8ZgHASza50sa06BDIfCvxd2354hfrS4v+NkAnFj/vJ8FDnKIAorBdjQ/5fWWWJopeceyCh+fXADZ2kEadIX3xmM/m26MVfhQQ2C0uLVRnVNXmJn/3Mck7I6wFVTNyPlMnNSiKdwGHNBzERzG8mUW78r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=351GCj/b; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vON8lXJ6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240610164026.036097741@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718037736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=bZ0w/TM6AE9SMRNm3Xm9JEw2iNfzEaEbkpBswlSbBEk=;
	b=351GCj/bR/40nMdJI8rjAQt25kbM1nWMcaza6ayspqb9bXegZVO8gDYHCm+SGSziHIb9Nk
	LhTgk3NIMkX+ayysJ2LW14zqQz5B81woD/CYn2P7HZo+O+9LVo8uuv3U9+hHrPcxY4yFF0
	N+9xNu8LUfJEulYKshSQ3GVn3FvHGnrshl9w2qemV55YpMR+PQbRsfXsmp/Bawz6G0IsRZ
	qA2K0DQjvlJcCHeJ36l6fbj4htPzN7mkk7rpeCgivnJfyjzhpi/pdB782lBe+LdNmD+O9H
	MnoZfkvVSEVLlmJTz0H+8GJALAHminllApN2GQhk8zpo51ffnhJkK4FBQE/o0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718037736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=bZ0w/TM6AE9SMRNm3Xm9JEw2iNfzEaEbkpBswlSbBEk=;
	b=vON8lXJ6+zui9Pu0J/0NdMU/sEOpftHBrE9jvM6wlg2JqHV2e8oOQg7BQvfYUhwMdZOpny
	sDSQjs9igFDbNGCA==
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
Subject: [patch V3 09/51] posix-cpu-timers: Handle interval timers correctly
 in timer_get()
References: <20240610163452.591699700@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Jun 2024 18:42:16 +0200 (CEST)

timer_gettime() must return the remaining time to the next expiry of a
timer or 0 if the timer is not armed and no signal pending, but posix CPU
timers fail to forward a timer which is already expired.

Add the required logic to address that.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Split out into new patch to make review simpler - Frederic
---
 kernel/time/posix-cpu-timers.c |   18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -787,8 +787,24 @@ static int posix_cpu_timer_set(struct k_
 
 static void __posix_cpu_timer_get(struct k_itimer *timer, struct itimerspec64 *itp, u64 now)
 {
-	u64 expires = cpu_timer_getexpires(&timer->it.cpu);
+	u64 expires, iv = timer->it_interval;
 
+	/*
+	 * Make sure that interval timers are moved forward for the
+	 * following cases:
+	 *  - Timers which expired, but the signal has not yet been
+	 *    delivered
+	 */
+	if (iv && (timer->it_requeue_pending & REQUEUE_PENDING))
+		expires = bump_cpu_timer(timer, now);
+	else
+		expires = cpu_timer_getexpires(&timer->it.cpu);
+
+	/*
+	 * Expired interval timers cannot have a remaining time <= 0.
+	 * The kernel has to move them forward so that the next
+	 * timer expiry is > @now.
+	 */
 	if (now < expires) {
 		itp->it_value = ns_to_timespec64(expires - now);
 	} else {


