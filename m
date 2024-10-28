Return-Path: <linux-kernel+bounces-384243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2890F9B28BB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCFFC2815C4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2EDE191F84;
	Mon, 28 Oct 2024 07:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eAcDo18b";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="231qBAJ2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165274685
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100630; cv=none; b=XztWzZmn6kg7EgDWOiAL8LgY29efyDpLQ1mNu9zpPuzE7g1IEWNh9wDvNyFaB4Y2LNe27FBw3Leu+ewZQsm7QxuuKr8JKwMuurzXfQFU1qP5ZxWcETmgR3E/1EhhE/2V78fm5qlcg7V7Id9JMxU+N+SEn8OJ6ApcleUUlUDlu30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100630; c=relaxed/simple;
	bh=PZOucdBLQqrkKuLaBZ6zkJh9J1MgdoenZFjgICY3dMY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f8Y99KllKnDRCqDo1MD+nI2zZqkcApG8f6mYn5pntGPKUMrWQUfNJM3/suaENm/PUwhmsd6w0c4hXhbeMZeyUi7zOdjOfDelWJaJino1EQsg2jBbACDZsKY6SrXFlXV4myMjwZaE1Hymcalr1Q+RmehZawEuq+brLsLnHSOA1+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eAcDo18b; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=231qBAJ2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iHc6xPHj2No6fqNb8FT1S9lZSL5Bwgzd8FWABxlmHlo=;
	b=eAcDo18bXC/3JADcI4wVqY8CNS6sJOwLGgDvis0ougRoal8KczlEr+g0NkHXCVrCe5jE3d
	TABNtobBpoSLzrgX5xK0KZd0mvX4ZFnJv/t4x3smSx1hvneJVb8U4mnVKhFRIDHYoFIthP
	/PtlS+ybdzfmHx6H9GvTvsOHa3FqIY6RQC7tc8X7Fwv2Dtytedd1pW/wTvChUjpsyC705s
	bBXEBiHkJ+9l6OjLY+xF9l0di9JoMDL/GsjhW+LWBziIaRveSFOhQrCoKx42YMTp3G7LY3
	Qe1ZOa6Am5M9GkaZcffhHo2NOilOdKyG0l34W9UdJR+P0jFiw1JiERXBKl6y5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iHc6xPHj2No6fqNb8FT1S9lZSL5Bwgzd8FWABxlmHlo=;
	b=231qBAJ2LX2NNrNtqc12A9Nenn6kAw4ux6vN3d1Ugu4IlOD9INPGj7vY1PCQlEtA7mGN6P
	jb6+052NAsJQTEDg==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Jani Nikula <jani.nikula@linux.intel.com>
Subject: [PATCH 03/21] drm/i915/request: Remove unnecessary abuse of hrtimer::function
Date: Mon, 28 Oct 2024 08:29:22 +0100
Message-Id: <3326c75307768230c0382f9a458a0389ce0d112f.1729864615.git.namcao@linutronix.de>
In-Reply-To: <cover.1729864615.git.namcao@linutronix.de>
References: <cover.1729864615.git.namcao@linutronix.de>
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

Remove the abuse of hrtimer::function and fully initialize the timer when
the request is created. Then, hrtimer_try_to_cancel() can be called without
touching the 'function' field.

Because hrtimer_try_to_cancel() returns 0 if the timer is not armed, the
logic to check whether to call i915_request_put() remains equivalent.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
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


