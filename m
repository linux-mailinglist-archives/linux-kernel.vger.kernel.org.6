Return-Path: <linux-kernel+bounces-390745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 942249B7E1B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 826D71C20E71
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED62A1C1AD4;
	Thu, 31 Oct 2024 15:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DcsaaWBy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mr9QsgWy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBC41A2C04
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 15:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730387710; cv=none; b=PVcHEnm45WSoGNXnmiTpkVw22ehVVP/o6dvnvakPg/G4/OtFYZHqvTFXeXmg6pJLpURFIRFOk515W5/fk6SGhZX4o/1aiIzETmeb6ZfbdgHl8un2pPGAQwdBJGmZp0AEnHWuzVf9BAhW6L3iZWZyraqFdF+myV38TEX9Y5o5E20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730387710; c=relaxed/simple;
	bh=GwNNF3zqHav5VPiKUemYF0iUUltEBshOaEcOGCpXNlY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JNY6KRK7gxCmux9PnsgVQj01Fkfsdqx74Pk0gAoFMz0e6xe6nOU9gvJHxL5Ovswt0pYhe98MXzYV/LGzzVw0MJ8j+n0bJups+ORRbXSS473zxfaD79LoN9gca4NDjFRP2AnBOyQXUfijrZMdjvJQpeDZv6pncxQMM+v9+zt0v60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DcsaaWBy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mr9QsgWy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730387704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ThkCl44V/neIjWVtl0sAlfXWNYdsrvkUEoH/3/3ZkiA=;
	b=DcsaaWByQ98ElkhS3oz+eKWKdWuqULhWlCPd3o0ZLc+ujYbRtAF9cUadaGeqBH0oX3SDq9
	z6iDCQYezKuQL2TUq0B54/XWY7mY+kaVOdL4Z3IqRetA4y3nyc9MSeX6EJdfJ65rNJ0NNt
	8VlNsMObaTY+sLUf8BVYdsI53njJfYnMMldKLNtZ+h+40EFyIm0H7lPS4q9eyXzoXY7nBY
	J13D5ohPZsABftu05Rkd2hmfCbEc3zdV53vBOcOiPBtlg0LbKBLnyOEYaMC3KZIYSfXpi9
	TJiPb7j3CMPudXBBjh+/S6TQN1e+4F1CGdkdNphraYuyykkLp/VxLKfFcM3I9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730387704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ThkCl44V/neIjWVtl0sAlfXWNYdsrvkUEoH/3/3ZkiA=;
	b=mr9QsgWy0okEJzOvv/jH6q6vQLK+I51K4/cWwlHe/kN4khdW8PabGSN77ZeGxufGuSI2Ox
	j/kES5y4HVmAcmCA==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
	intel-gfx@lists.freedesktop.org,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	x86@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Kalle Valo <kvalo@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	John Stultz <jstultz@google.com>,
	Nam Cao <namcao@linutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [RESEND PATCH v2 06/19] hrtimers: Introduce hrtimer_setup() to replace hrtimer_init()
Date: Thu, 31 Oct 2024 16:14:20 +0100
Message-Id: <5057c1ddbfd4b92033cd93d37fe38e6b069d5ba6.1730386209.git.namcao@linutronix.de>
In-Reply-To: <cover.1730386209.git.namcao@linutronix.de>
References: <cover.1730386209.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

To initialize hrtimer, hrtimer_init() needs to be called and also
hrtimer::function must be set. This is error-prone and awkward to use.

Introduce hrtimer_setup() which does both of these things, so that users of
hrtimer can be simplified.

The new setup function also has a sanity check for the provided function
pointer. If NULL, a warning is emitted and a dummy callback installed.

hrtimer_init() will be removed as soon as all of its users have been
converted to the new function.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 include/linux/hrtimer.h |  2 ++
 kernel/time/hrtimer.c   | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 5aa9d57528c4..bcc0715c59a8 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -228,6 +228,8 @@ static inline void hrtimer_cancel_wait_running(struct h=
rtimer *timer)
 /* Initialize timers: */
 extern void hrtimer_init(struct hrtimer *timer, clockid_t which_clock,
 			 enum hrtimer_mode mode);
+extern void hrtimer_setup(struct hrtimer *timer, enum hrtimer_restart (*fu=
nction)(struct hrtimer *),
+			  clockid_t clock_id, enum hrtimer_mode mode);
 extern void hrtimer_init_on_stack(struct hrtimer *timer, clockid_t which_c=
lock,
 				  enum hrtimer_mode mode);
 extern void hrtimer_init_sleeper_on_stack(struct hrtimer_sleeper *sl,
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 4b0507cf38ea..a5ef67edcda9 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1535,6 +1535,11 @@ static inline int hrtimer_clockid_to_base(clockid_t =
clock_id)
 	return HRTIMER_BASE_MONOTONIC;
 }
=20
+static enum hrtimer_restart hrtimer_dummy_timeout(struct hrtimer *unused)
+{
+	return HRTIMER_NORESTART;
+}
+
 static void __hrtimer_init(struct hrtimer *timer, clockid_t clock_id,
 			   enum hrtimer_mode mode)
 {
@@ -1571,6 +1576,18 @@ static void __hrtimer_init(struct hrtimer *timer, cl=
ockid_t clock_id,
 	timerqueue_init(&timer->node);
 }
=20
+static void __hrtimer_setup(struct hrtimer *timer,
+			    enum hrtimer_restart (*function)(struct hrtimer *),
+			    clockid_t clock_id, enum hrtimer_mode mode)
+{
+	__hrtimer_init(timer, clock_id, mode);
+
+	if (WARN_ON_ONCE(!function))
+		timer->function =3D hrtimer_dummy_timeout;
+	else
+		timer->function =3D function;
+}
+
 /**
  * hrtimer_init - initialize a timer to the given clock
  * @timer:	the timer to be initialized
@@ -1591,6 +1608,27 @@ void hrtimer_init(struct hrtimer *timer, clockid_t c=
lock_id,
 }
 EXPORT_SYMBOL_GPL(hrtimer_init);
=20
+/**
+ * hrtimer_setup - initialize a timer to the given clock
+ * @timer:	the timer to be initialized
+ * @function:	the callback function
+ * @clock_id:	the clock to be used
+ * @mode:       The modes which are relevant for initialization:
+ *              HRTIMER_MODE_ABS, HRTIMER_MODE_REL, HRTIMER_MODE_ABS_SOFT,
+ *              HRTIMER_MODE_REL_SOFT
+ *
+ *              The PINNED variants of the above can be handed in,
+ *              but the PINNED bit is ignored as pinning happens
+ *              when the hrtimer is started
+ */
+void hrtimer_setup(struct hrtimer *timer, enum hrtimer_restart (*function)=
(struct hrtimer *),
+		   clockid_t clock_id, enum hrtimer_mode mode)
+{
+	debug_init(timer, clock_id, mode);
+	__hrtimer_setup(timer, function, clock_id, mode);
+}
+EXPORT_SYMBOL_GPL(hrtimer_setup);
+
 /**
  * hrtimer_init_on_stack - initialize a timer in stack memory
  * @timer:	The timer to be initialized
--=20
2.39.5


