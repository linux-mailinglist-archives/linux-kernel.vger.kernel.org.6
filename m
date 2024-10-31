Return-Path: <linux-kernel+bounces-390739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D70A09B7E0D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 832E21F21255
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9AE1B3B28;
	Thu, 31 Oct 2024 15:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ea2gljGc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CqstlxLr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66FC1A3029
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 15:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730387705; cv=none; b=bZ6Pe13JkX+cZ4wWYkAg/JxYs+T9FI/XSHRIF9Fq0O5prYlLWR+QwI/9/uYHvY7Ph4wNqMDgU+zPZciXedJqHf3FISQGPGjfxDQPUZTRwg2+6Qx7o0dLkalVqYUsz/LXjVeAcbrEQrG4NolbkAAKOdpnB/LXcrX3rBXzIwgAVuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730387705; c=relaxed/simple;
	bh=yG4v5dLEQDMShfyJJzF9b9CF/EvKVy0NAXyVUG7j5N0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gznJRZmkR74zX63oNbXoR7LHkSX+PsNx43tEFdYzzDNYkTrqP9pIGzIOqM2dmfHfdUBXC3+UBf8OWwxb30xIjA+vt0bq9sYZ2SrJmIxqODMLxgI5b4oBgCxJGvg4g8vtpsLHHkdn24BgKQPgVB9g3X6yQc0yBCMCuryAPzzriWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ea2gljGc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CqstlxLr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730387702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3OpuVlVfGmDS4KDeN2Jbqf77TDzf3Zc1fr7oejFCTSM=;
	b=ea2gljGc/BV+BoVMvgLFNEi8043sU9vyqQDpS0h+ftCl0Wo6cCP6sHwDIGQrOTV95ZvkTy
	9lJYGcmCAJJaLxAmMOdTboAmsH3HAOERGu7XsxcKIGqxJ8VsWL9AqZ2KQmXwuBU/0cMPsb
	nFn0+qyC03e1F931j/X2DBldlmMJQqe0AFutcjqtyQi3xooASdmfqqAw4F63/+fGF299+x
	SeSwZ06mK7IEVX42pHSFi+kzM6odRmdXbCd+m1r1J4bte8XJaFVR5gW+Sagirx10tlc7F0
	QBiXvt9n2O+uGEqNpTvA0iRzAsZxQiQtdDIzHn/cFQM4c9ISdF+dvS+/GT5nmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730387702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3OpuVlVfGmDS4KDeN2Jbqf77TDzf3Zc1fr7oejFCTSM=;
	b=CqstlxLr48wIYSYPze9/lcB0CHD7PTlEaV2YbBlsmr81hdWcaBWQN3POAvCfgwPaaNUEDK
	j3818nENSXCm8yCg==
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
Subject: [RESEND PATCH v2 02/19] drm/i915/request: Remove unnecessary modification of hrtimer::function
Date: Thu, 31 Oct 2024 16:14:16 +0100
Message-Id: <50f865045aa672a9730343ad131543da332b1d8d.1730386209.git.namcao@linutronix.de>
In-Reply-To: <cover.1730386209.git.namcao@linutronix.de>
References: <cover.1730386209.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When a request is created, the hrtimer is not initialized and only its
'function' field is set to NULL. The hrtimer is only initialized when the
request is enqueued. The point of setting 'function' to NULL is that, it
can be used to check whether hrtimer_try_to_cancel() should be called while
retiring the request.

This "trick" is unnecessary, because hrtimer_try_to_cancel() already does
its own check whether the timer is armed. If the timer is not armed,
hrtimer_try_to_cancel() returns 0.

Fully initialize the timer when the request is created, which allows to
make the hrtimer::function field private once all users of hrtimer_init()
are converted to hrtimer_setup(), which requires a valid callback function
to be set.

Because hrtimer_try_to_cancel() returns 0 if the timer is not armed, the
logic to check whether to call i915_request_put() remains equivalent.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
---
 drivers/gpu/drm/i915/i915_request.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_request.c b/drivers/gpu/drm/i915/i91=
5_request.c
index 519e096c607c..8f62cfa23fb7 100644
--- a/drivers/gpu/drm/i915/i915_request.c
+++ b/drivers/gpu/drm/i915/i915_request.c
@@ -273,11 +273,6 @@ i915_request_active_engine(struct i915_request *rq,
 	return ret;
 }
=20
-static void __rq_init_watchdog(struct i915_request *rq)
-{
-	rq->watchdog.timer.function =3D NULL;
-}
-
 static enum hrtimer_restart __rq_watchdog_expired(struct hrtimer *hrtimer)
 {
 	struct i915_request *rq =3D
@@ -294,6 +289,14 @@ static enum hrtimer_restart __rq_watchdog_expired(stru=
ct hrtimer *hrtimer)
 	return HRTIMER_NORESTART;
 }
=20
+static void __rq_init_watchdog(struct i915_request *rq)
+{
+	struct i915_request_watchdog *wdg =3D &rq->watchdog;
+
+	hrtimer_init(&wdg->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	wdg->timer.function =3D __rq_watchdog_expired;
+}
+
 static void __rq_arm_watchdog(struct i915_request *rq)
 {
 	struct i915_request_watchdog *wdg =3D &rq->watchdog;
@@ -304,8 +307,6 @@ static void __rq_arm_watchdog(struct i915_request *rq)
=20
 	i915_request_get(rq);
=20
-	hrtimer_init(&wdg->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	wdg->timer.function =3D __rq_watchdog_expired;
 	hrtimer_start_range_ns(&wdg->timer,
 			       ns_to_ktime(ce->watchdog.timeout_us *
 					   NSEC_PER_USEC),
@@ -317,7 +318,7 @@ static void __rq_cancel_watchdog(struct i915_request *r=
q)
 {
 	struct i915_request_watchdog *wdg =3D &rq->watchdog;
=20
-	if (wdg->timer.function && hrtimer_try_to_cancel(&wdg->timer) > 0)
+	if (hrtimer_try_to_cancel(&wdg->timer) > 0)
 		i915_request_put(rq);
 }
=20
--=20
2.39.5


