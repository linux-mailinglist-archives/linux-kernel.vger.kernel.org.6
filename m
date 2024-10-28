Return-Path: <linux-kernel+bounces-384241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A7A9B28B9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A93A1C212AA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E2118FC91;
	Mon, 28 Oct 2024 07:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bLVMBYPI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7ujLKY+U"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E784318C92A
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100622; cv=none; b=UcbYjlJ3q3V3YIZmghHjvhI0z+VwU78wcsjNyjdIBYSU5CoTYq2KPCZBf8hH6vrEJuZORY+YdjlQHvxP7TD1GNUJMmkw0Y+Mn2HPaP2aHCeGxUIqtMQWa0U3WFNfJ65LgbcF7INiERmtSoGTgi3PDx+zmBFtdVU3ehYME2vWXfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100622; c=relaxed/simple;
	bh=BxtJjqOoQ38YyK+lSWhG/MIQ8Pd0KmsgfVxMerM5fXY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BKZ6EwCr7CrNUvHKbv4yBXH7rd7/rOgJC4ypW93r5B3ate5nTrYLulUe1ziy896XYwcegXYW7VUx5hHvXWmcXyvIzLecJmk6ULovW4XeDcscQMRswFxDp1nPFSiFD2wSQUO+SFzdbHxo1NqMKX1a+o0/wnMfEVEBEXxNX4OsrMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bLVMBYPI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7ujLKY+U; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cEw6yd607c9j0hRNFj3/4bOHsEEeSWbFpAtoxc/umr4=;
	b=bLVMBYPIwc5Qdjpkzb0ohJjhGO8jFhbuAqMUduFYvHGW2cX8KU/7tQ+xpOUMe0fbmY+UXk
	bkEOzREohzHBRCc6bxb40YSjjTtCHYg2quq/HCRAfKeBbLaMAHplghat8bAvTjfDg6OxkE
	3Ut8/KiLf1s+qxajsOmkKN5SVcNZU2Ssn4dWQbVr57UCvm00mnX71Jeqlkzm912BNYXokd
	ad2Vdw8Ml9+qekYySTOiWk/3mPY/PFurud8qnFpOyh1/TfE7zIfX6dsETeg/igldJiItU/
	kb8J9PhbL2TifJxroOws8zNtDZUlltRgBlAYqHD+m5sfeMgl3LEPtxgG8pWpBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cEw6yd607c9j0hRNFj3/4bOHsEEeSWbFpAtoxc/umr4=;
	b=7ujLKY+Uj33W/gkVC7/WEkziBDQQnVqsopUwDShZh8uaa8ou8wbnN4VcFsBbcYgqfR8PYa
	o/38ujrJAstKX2Bg==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH 01/21] hrtimers: Add missing hrtimer_init event trace points
Date: Mon, 28 Oct 2024 08:29:20 +0100
Message-Id: <6320995cb955d3ec1d8b8cbc935303f91218bb4a.1729864615.git.namcao@linutronix.de>
In-Reply-To: <cover.1729864615.git.namcao@linutronix.de>
References: <cover.1729864615.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There is the "hrtimer_init" trace event when hrtimer gets initialized. This
event should also be triggered in hrtimer_init_on_stack() and
hrtimer_init_sleeper_on_stack(), which is not the case if
CONFIG_DEBUG_OBJECTS_TIMERS=3Dy.

Make sure the "hrtimer_init" trace event is triggered properly by
introducing debug_init_on_stack() which is analogous to debug_init() and
call this function in hrtimer_init_on_stack() and
hrtimer_init_sleeper_on_stack(). These two functions now each have a single
implementation regardless of CONFIG_DEBUG_OBJECTS_TIMERS, similar to
hrtimer_init() and hrtimer_init_sleeper().

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 include/linux/hrtimer.h | 17 +----------
 kernel/time/hrtimer.c   | 66 +++++++++++++++++++++++++++--------------
 2 files changed, 45 insertions(+), 38 deletions(-)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index aa1e65ccb615..814d489cb7a2 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -230,30 +230,15 @@ extern void hrtimer_init(struct hrtimer *timer, clock=
id_t which_clock,
 			 enum hrtimer_mode mode);
 extern void hrtimer_init_sleeper(struct hrtimer_sleeper *sl, clockid_t clo=
ck_id,
 				 enum hrtimer_mode mode);
-
-#ifdef CONFIG_DEBUG_OBJECTS_TIMERS
 extern void hrtimer_init_on_stack(struct hrtimer *timer, clockid_t which_c=
lock,
 				  enum hrtimer_mode mode);
 extern void hrtimer_init_sleeper_on_stack(struct hrtimer_sleeper *sl,
 					  clockid_t clock_id,
 					  enum hrtimer_mode mode);
=20
+#ifdef CONFIG_DEBUG_OBJECTS_TIMERS
 extern void destroy_hrtimer_on_stack(struct hrtimer *timer);
 #else
-static inline void hrtimer_init_on_stack(struct hrtimer *timer,
-					 clockid_t which_clock,
-					 enum hrtimer_mode mode)
-{
-	hrtimer_init(timer, which_clock, mode);
-}
-
-static inline void hrtimer_init_sleeper_on_stack(struct hrtimer_sleeper *s=
l,
-						 clockid_t clock_id,
-						 enum hrtimer_mode mode)
-{
-	hrtimer_init_sleeper(sl, clock_id, mode);
-}
-
 static inline void destroy_hrtimer_on_stack(struct hrtimer *timer) { }
 #endif
=20
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 04f7d8a392c3..533769777ba4 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -417,6 +417,11 @@ static inline void debug_hrtimer_init(struct hrtimer *=
timer)
 	debug_object_init(timer, &hrtimer_debug_descr);
 }
=20
+static inline void debug_hrtimer_init_on_stack(struct hrtimer *timer)
+{
+	debug_object_init_on_stack(timer, &hrtimer_debug_descr);
+}
+
 static inline void debug_hrtimer_activate(struct hrtimer *timer,
 					  enum hrtimer_mode mode)
 {
@@ -428,28 +433,6 @@ static inline void debug_hrtimer_deactivate(struct hrt=
imer *timer)
 	debug_object_deactivate(timer, &hrtimer_debug_descr);
 }
=20
-static void __hrtimer_init(struct hrtimer *timer, clockid_t clock_id,
-			   enum hrtimer_mode mode);
-
-void hrtimer_init_on_stack(struct hrtimer *timer, clockid_t clock_id,
-			   enum hrtimer_mode mode)
-{
-	debug_object_init_on_stack(timer, &hrtimer_debug_descr);
-	__hrtimer_init(timer, clock_id, mode);
-}
-EXPORT_SYMBOL_GPL(hrtimer_init_on_stack);
-
-static void __hrtimer_init_sleeper(struct hrtimer_sleeper *sl,
-				   clockid_t clock_id, enum hrtimer_mode mode);
-
-void hrtimer_init_sleeper_on_stack(struct hrtimer_sleeper *sl,
-				   clockid_t clock_id, enum hrtimer_mode mode)
-{
-	debug_object_init_on_stack(&sl->timer, &hrtimer_debug_descr);
-	__hrtimer_init_sleeper(sl, clock_id, mode);
-}
-EXPORT_SYMBOL_GPL(hrtimer_init_sleeper_on_stack);
-
 void destroy_hrtimer_on_stack(struct hrtimer *timer)
 {
 	debug_object_free(timer, &hrtimer_debug_descr);
@@ -459,6 +442,7 @@ EXPORT_SYMBOL_GPL(destroy_hrtimer_on_stack);
 #else
=20
 static inline void debug_hrtimer_init(struct hrtimer *timer) { }
+static inline void debug_hrtimer_init_on_stack(struct hrtimer *timer) { }
 static inline void debug_hrtimer_activate(struct hrtimer *timer,
 					  enum hrtimer_mode mode) { }
 static inline void debug_hrtimer_deactivate(struct hrtimer *timer) { }
@@ -472,6 +456,13 @@ debug_init(struct hrtimer *timer, clockid_t clockid,
 	trace_hrtimer_init(timer, clockid, mode);
 }
=20
+static inline void debug_init_on_stack(struct hrtimer *timer, clockid_t cl=
ockid,
+				       enum hrtimer_mode mode)
+{
+	debug_hrtimer_init_on_stack(timer);
+	trace_hrtimer_init(timer, clockid, mode);
+}
+
 static inline void debug_activate(struct hrtimer *timer,
 				  enum hrtimer_mode mode)
 {
@@ -1600,6 +1591,23 @@ void hrtimer_init(struct hrtimer *timer, clockid_t c=
lock_id,
 }
 EXPORT_SYMBOL_GPL(hrtimer_init);
=20
+/**
+ * hrtimer_init_on_stack - initialize a timer in stack memory
+ * @timer:	The timer to be initialized
+ * @clock_id:	The clock to be used
+ * @mode:       The timer mode
+ *
+ * Similar to hrtimer_init(), except that this one must be used if struct =
hrtimer is in stack
+ * memory.
+ */
+void hrtimer_init_on_stack(struct hrtimer *timer, clockid_t clock_id,
+			   enum hrtimer_mode mode)
+{
+	debug_init_on_stack(timer, clock_id, mode);
+	__hrtimer_init(timer, clock_id, mode);
+}
+EXPORT_SYMBOL_GPL(hrtimer_init_on_stack);
+
 /*
  * A timer is active, when it is enqueued into the rbtree or the
  * callback function is running or it's in the state of being migrated
@@ -2001,6 +2009,20 @@ void hrtimer_init_sleeper(struct hrtimer_sleeper *sl=
, clockid_t clock_id,
 }
 EXPORT_SYMBOL_GPL(hrtimer_init_sleeper);
=20
+/**
+ * hrtimer_init_sleeper_on_stack - initialize a sleeper in stack memory
+ * @sl:		sleeper to be initialized
+ * @clock_id:	the clock to be used
+ * @mode:	timer mode abs/rel
+ */
+void hrtimer_init_sleeper_on_stack(struct hrtimer_sleeper *sl,
+				   clockid_t clock_id, enum hrtimer_mode mode)
+{
+	debug_init_on_stack(&sl->timer, clock_id, mode);
+	__hrtimer_init_sleeper(sl, clock_id, mode);
+}
+EXPORT_SYMBOL_GPL(hrtimer_init_sleeper_on_stack);
+
 int nanosleep_copyout(struct restart_block *restart, struct timespec64 *ts)
 {
 	switch(restart->nanosleep.type) {
--=20
2.39.5


