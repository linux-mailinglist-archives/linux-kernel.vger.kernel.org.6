Return-Path: <linux-kernel+bounces-198194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 102648D74BE
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 12:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A7A71C2137B
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 10:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DF7374C3;
	Sun,  2 Jun 2024 10:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GC8os0fi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7386BA21
	for <linux-kernel@vger.kernel.org>; Sun,  2 Jun 2024 10:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717323703; cv=none; b=ITBr27zpQGpOB4+QJGa+Do8S1FsMptkHdn9TSNV0iU/OUKRLQLRPdmZuhUmO+0atiAhHrXjR02WHefTEm/qAO0VD7KiJFGvd28DpqVLjbrlmdu5kMY6ODLsNAWV1itNy4bLqClGKHx9QM22bCxkOlXdoLX8FAnHse1qg+ylHrlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717323703; c=relaxed/simple;
	bh=fnlLbfSOyZ0MnFmTbJ4YoXSJp7K2rHZ/snMSxi/teyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ByRKFpKsdf+4sZ5vkQe5nBoh1YPNVmGV+Y4wVEnkh3QdddQBIFse5LXy28kNPiGQ9In9FoNfMEPlMaziSiiBGiySAbnp6SIXo8VnI4ct5Har9s12R51aOrLEJNfU2q2iu8Eo/1XAkMCqZmLzwZzle7N/nGtBX4m8ID7LQv1ksVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GC8os0fi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717323700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q/+D8T/WwTv6e2GI3GlDOgO0CDu4xK1MgHugClQ+wFU=;
	b=GC8os0fiDRukUmkLEvtHb6nLZPGBlBJlhr0LdWo9L8lNnrOWHwN8VuUeYx7NLfPwXi/qjU
	k1fuCiIrmXDYXVmtKdrr2GXDBObsbKUKhLrqj+43ZklZ2N8BP4EqZ7beurFhySleqPQLzz
	djcCAUT6fRr5AAk/Rs92oPxslvxRLrw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-279-3xGdyeKRN1aQwCQJlHMUlg-1; Sun,
 02 Jun 2024 06:21:37 -0400
X-MC-Unique: 3xGdyeKRN1aQwCQJlHMUlg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AA16829AA381;
	Sun,  2 Jun 2024 10:21:36 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.19])
	by smtp.corp.redhat.com (Postfix) with SMTP id 5BCA1200A75E;
	Sun,  2 Jun 2024 10:21:35 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun,  2 Jun 2024 12:20:09 +0200 (CEST)
Date: Sun, 2 Jun 2024 12:20:07 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2] tick: shift tick_nohz_switch_to_nohz() from
 tick_check_oneshot_change() to hrtimer_run_queues()
Message-ID: <20240602102007.GA27454@redhat.com>
References: <20240530124203.GA26990@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530124203.GA26990@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

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
v2: fix build failure without CONFIG_NO_HZ_COMMON (thanks Frederic)
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
index 5f2105e637bd..961dca323649 100644
--- a/kernel/time/tick-internal.h
+++ b/kernel/time/tick-internal.h
@@ -111,7 +111,7 @@ extern void tick_resume_oneshot(void);
 static inline bool tick_oneshot_possible(void) { return true; }
 extern int tick_oneshot_mode_active(void);
 extern void tick_clock_notify(void);
-extern int tick_check_oneshot_change(int allow_nohz);
+extern int tick_check_oneshot_change(void);
 extern int tick_init_highres(void);
 #else /* !CONFIG_TICK_ONESHOT: */
 static inline
@@ -124,7 +124,7 @@ static inline void tick_oneshot_notify(void) { }
 static inline bool tick_oneshot_possible(void) { return false; }
 static inline int tick_oneshot_mode_active(void) { return 0; }
 static inline void tick_clock_notify(void) { }
-static inline int tick_check_oneshot_change(int allow_nohz) { return 0; }
+static inline int tick_check_oneshot_change(void) { return 0; }
 #endif /* !CONFIG_TICK_ONESHOT */
 
 /* Functions related to oneshot broadcasting */
@@ -157,6 +157,7 @@ static inline void tick_nohz_init(void) { }
 #endif
 
 #ifdef CONFIG_NO_HZ_COMMON
+extern void tick_nohz_switch_to_nohz(void);
 extern unsigned long tick_nohz_active;
 extern void timers_update_nohz(void);
 extern u64 get_jiffies_update(unsigned long *basej);
@@ -171,6 +172,7 @@ extern bool timer_base_is_idle(void);
 extern void timer_expire_remote(unsigned int cpu);
 # endif
 #else /* CONFIG_NO_HZ_COMMON */
+static inline void tick_nohz_switch_to_nohz(void) { }
 static inline void timers_update_nohz(void) { }
 #define tick_nohz_active (0)
 #endif
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



