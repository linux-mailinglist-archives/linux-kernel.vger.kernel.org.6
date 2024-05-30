Return-Path: <linux-kernel+bounces-195377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2A68D4BCB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 14:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 293041F22AB8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 12:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E8D132126;
	Thu, 30 May 2024 12:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="frX3mc7N"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE2018309F
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 12:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717073020; cv=none; b=P5MBR/OjCkDNhsc7zLN0kcnuJ9xvshGd6MyWpRK21gCQ7NMjnARTHEcu+bPjidym0HwK95j/sI5reYCo9FNeZRGUpmfUrOCCQ33mwqInk4m+rgWzlm7Gg8N9kkXnLhjpr/khaH+x9SowymPhpeeJohmcD/C3zeYC7DnjahSDFHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717073020; c=relaxed/simple;
	bh=lkMzy8caYhbIm4cIkAEbOIgxXgPW2TRXMPGpe3P/zqs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KNXffl0IH8hj4fu+RGKZeIEzPt4w+IJiF+ClWNkG1+e3tEw2yfiEPf+TtNRf5vDO3g+rClkiEdm/m3WJAKfQBZgdZf79wwVDHgA5kW9hnWNcINFe9V8xrxhS8YVOddmIJyH6DcQOvJodO2otPpCR08d5+sei0Jpyq/fvwfYFqcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=frX3mc7N; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717073017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=uekMYU9dsE6UOZKdasq/PXY2idUK8eOtyfiH2Ns6Eq4=;
	b=frX3mc7NHpB/DUV3p2VDP/xSLJvc2Ka+uCUUiVPlxRMsdaSw9R+gCmz9D2p1cVq2eJe4N/
	tlcLbx0ptF63WkPboanVXUYCnFtu+506VOaEEchHmbsrFpF3o4hAvIwYEnIqD7c1XDkYnm
	kZGwniQnZLTTkAV623ROlrIalVxZMQo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-dYmdLYK3OKq6HMHrD5f5RQ-1; Thu, 30 May 2024 08:43:34 -0400
X-MC-Unique: dYmdLYK3OKq6HMHrD5f5RQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D3F09812296;
	Thu, 30 May 2024 12:43:33 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.232])
	by smtp.corp.redhat.com (Postfix) with SMTP id 663D22870;
	Thu, 30 May 2024 12:43:32 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 30 May 2024 14:42:05 +0200 (CEST)
Date: Thu, 30 May 2024 14:42:03 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] tick: shift tick_nohz_switch_to_nohz() from
 tick_check_oneshot_change() to hrtimer_run_queues()
Message-ID: <20240530124203.GA26990@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

hrtimer_run_queues() calls tick_check_oneshot_change() to check if we
can switch to highres or nohz mode, but the current code looks very
confusing to me. In the highres=n or CONFIG_HIGH_RES_TIMERS=n cases
tick_check_oneshot_change() itself calls tick_nohz_switch_to_nohz()
and returns zero; that is why it needs the "allow_nohz" argument,
which imo also adds confusion.

This patch turns tick_check_oneshot_change() into a "pure" function
without arguments. hrtimer_run_queues() calls hrtimer_switch_to_hres()
or tick_nohz_switch_to_nohz() depending on hrtimer_is_hres_enabled().

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/time/hrtimer.c       |  7 +++++--
 kernel/time/tick-internal.h |  6 ++++--
 kernel/time/tick-sched.c    | 15 ++++-----------
 3 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 492c14aac642..806f352b095d 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1891,8 +1891,11 @@ void hrtimer_run_queues(void)
 	 * there only sets the check bit in the tick_oneshot code,
 	 * otherwise we might deadlock vs. xtime_lock.
 	 */
-	if (tick_check_oneshot_change(!hrtimer_is_hres_enabled())) {
-		hrtimer_switch_to_hres();
+	if (tick_check_oneshot_change()) {
+		if (hrtimer_is_hres_enabled())
+			hrtimer_switch_to_hres();
+		else
+			tick_nohz_switch_to_nohz();
 		return;
 	}
 
diff --git a/kernel/time/tick-internal.h b/kernel/time/tick-internal.h
index 5f2105e637bd..6764fbd18afd 100644
--- a/kernel/time/tick-internal.h
+++ b/kernel/time/tick-internal.h
@@ -111,7 +111,8 @@ extern void tick_resume_oneshot(void);
 static inline bool tick_oneshot_possible(void) { return true; }
 extern int tick_oneshot_mode_active(void);
 extern void tick_clock_notify(void);
-extern int tick_check_oneshot_change(int allow_nohz);
+extern int tick_check_oneshot_change(void);
+extern void tick_nohz_switch_to_nohz(void);
 extern int tick_init_highres(void);
 #else /* !CONFIG_TICK_ONESHOT: */
 static inline
@@ -124,7 +125,8 @@ static inline void tick_oneshot_notify(void) { }
 static inline bool tick_oneshot_possible(void) { return false; }
 static inline int tick_oneshot_mode_active(void) { return 0; }
 static inline void tick_clock_notify(void) { }
-static inline int tick_check_oneshot_change(int allow_nohz) { return 0; }
+static inline int tick_check_oneshot_change(void) { return 0; }
+static inline void tick_nohz_switch_to_nohz(void) { }
 #endif /* !CONFIG_TICK_ONESHOT */
 
 /* Functions related to oneshot broadcasting */
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 71a792cd8936..4fd70be50b7f 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1514,7 +1514,7 @@ static inline void tick_nohz_activate(struct tick_sched *ts)
 /**
  * tick_nohz_switch_to_nohz - switch to NOHZ mode
  */
-static void tick_nohz_switch_to_nohz(void)
+void tick_nohz_switch_to_nohz(void)
 {
 	if (!tick_nohz_enabled)
 		return;
@@ -1552,7 +1552,6 @@ static inline void tick_nohz_irq_enter(void)
 
 #else
 
-static inline void tick_nohz_switch_to_nohz(void) { }
 static inline void tick_nohz_irq_enter(void) { }
 static inline void tick_nohz_activate(struct tick_sched *ts) { }
 
@@ -1670,11 +1669,9 @@ void tick_oneshot_notify(void)
  * Check if a change happened, which makes oneshot possible.
  *
  * Called cyclically from the hrtimer softirq (driven by the timer
- * softirq). 'allow_nohz' signals that we can switch into low-res NOHZ
- * mode, because high resolution timers are disabled (either compile
- * or runtime). Called with interrupts disabled.
+ * softirq). Called with interrupts disabled.
  */
-int tick_check_oneshot_change(int allow_nohz)
+int tick_check_oneshot_change(void)
 {
 	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
 
@@ -1687,9 +1684,5 @@ int tick_check_oneshot_change(int allow_nohz)
 	if (!timekeeping_valid_for_hres() || !tick_is_oneshot_available())
 		return 0;
 
-	if (!allow_nohz)
-		return 1;
-
-	tick_nohz_switch_to_nohz();
-	return 0;
+	return 1;
 }
-- 
2.25.1.362.g51ebf55



