Return-Path: <linux-kernel+bounces-390747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5619A9B7E1D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC75C1F20FCF
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752B61C2DB8;
	Thu, 31 Oct 2024 15:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OXluRfXX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dt2VJX4y"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411911BC074
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 15:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730387710; cv=none; b=Fjgt3KEbKH0LXI9fnrdgPyvpCui9McF1me5J9lA9AY1xFSfQBc1uLo88Df2xFTLvXRxDsNJhWi19k2a0ZkvOYLUa2uEooQuNj7a9IlAq33sPAaC/AO5Iv1W0GSpNWR2RNcSidzXvXYsbvcDFteLQneygHbYAwK/oXg5B1r/tC8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730387710; c=relaxed/simple;
	bh=r6YtZHpm5SDAubcCWo1zoTd/sBxKKP+2uGLLpdpJ5cQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JlFefuoOWom4lh1UDITq8RDQGbLQK3bpjJlKihaSNwQPa32v+FveDily4NOATfhd+DuFK5ifi07WSXYdqZjWxzcivNh2bUeFzaBH3pzbqQ0DQY08JialNL/2F1xErLZ7DeT3iWBROlgPBmqEU93sjcj7JhZRDY+w3VLzNW1LSLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OXluRfXX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dt2VJX4y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730387706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WU0OQTP8K3HetutHRTwicBx6y0d4IYn/PVSH3V3yCms=;
	b=OXluRfXXeLt3edtFXLjyirTIAAVAr321b79RwSZ5xO2L6K1wgbB2mhzmJLx0eY2Zkg2pwq
	SEGQjyPmuA2GPkXOEPTYSnrqeWjkn46s7qTS1Kn8Szcs5GlNi90jddFuYQZqS9AqErvjjt
	U5Rh0d3eHN6W86mu0F3HC2/1gJ5e9tXcgMUVmyBduzW1BfeuMDOO+t1+KNtJS0H8nSc5Q3
	fQEQ+cymkgs9afOdBDrFAxlVTpehr7yNxzctx1L3AvLoH58GYGlE/zj4A4hGy1xhWdtV6c
	E0LFJ0Z/2MUV4MbkjYh+KerclqK8Xt0+SiEzdpp5L5gOUH+Q8URTcC6oqrt3WA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730387706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WU0OQTP8K3HetutHRTwicBx6y0d4IYn/PVSH3V3yCms=;
	b=dt2VJX4y7Oonm0lgdq0Gv3sFyvfZFvLpYDzXGfuTwJl/aXIr3aTCwH+cYXvOS8sOHvgwjQ
	mPal+9jnfMbIbCBg==
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
Subject: [RESEND PATCH v2 09/19] hrtimers: Introduce hrtimer_update_function()
Date: Thu, 31 Oct 2024 16:14:23 +0100
Message-Id: <20a937b0ae09ad54b5b6d86eabead7c570f1b72e.1730386209.git.namcao@linutronix.de>
In-Reply-To: <cover.1730386209.git.namcao@linutronix.de>
References: <cover.1730386209.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Some users of hrtimer need to change the callback function after the
initial setup. They write to hrtimer::function directly.

That's not safe under all circumstances as the write is lockless and a
concurrent timer expiry might end up using the wrong function pointer.

Introduce hrtimer_update_function(), which also performs runtime checks
whether it is safe to modify the callback.

This allows to make hrtimer::function private once all users are converted.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 include/linux/hrtimer.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 48872a2b4071..6e026730e803 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -327,6 +327,28 @@ static inline int hrtimer_callback_running(struct hrti=
mer *timer)
 	return timer->base->running =3D=3D timer;
 }
=20
+/**
+ * hrtimer_update_function - Update the timer's callback function
+ * @timer:	Timer to update
+ * @function:	New callback function
+ *
+ * Only safe to call if the timer is not enqueued. Can be called in the ca=
llback function if the
+ * timer is not enqueued at the same time (see the comments above HRTIMER_=
STATE_ENQUEUED).
+ */
+static inline void hrtimer_update_function(struct hrtimer *timer,
+					   enum hrtimer_restart (*function)(struct hrtimer *))
+{
+	guard(raw_spinlock_irqsave)(&timer->base->cpu_base->lock);
+
+	if (WARN_ON_ONCE(hrtimer_is_queued(timer)))
+		return;
+
+	if (WARN_ON_ONCE(!function))
+		return;
+
+	timer->function =3D function;
+}
+
 /* Forward a hrtimer so it expires after now: */
 extern u64
 hrtimer_forward(struct hrtimer *timer, ktime_t now, ktime_t interval);
--=20
2.39.5


