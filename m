Return-Path: <linux-kernel+bounces-384281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B949B28E8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F102BB2112C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41351DC749;
	Mon, 28 Oct 2024 07:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mZK2ibLO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/E1eEpDR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D019B1D9A70
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100747; cv=none; b=VNj6XGzSSN5R05M+DPc7nKA66447Hx4Y/7lcRoTM0X6Qmwsk/J3ZPdxhzxa+36l8wpxnHvynvWzCnYS2IjsjVG8YCC8vHfvZFaoj29U//7vuq5NbeztsWky+43lFRQIvTwkxprHGnTiio7hnksPtzVVLoA1MuL9YCIaZUJtfWe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100747; c=relaxed/simple;
	bh=nQkCZ0QeSqwArx6zMrnw3mGTzEtMAXDHMaORDcyFTtU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R6gtgS1d2uJDxEdcEI98Zqj+eTElbbiriJAt2g1stz/qrqKa3iXAzm1Ebhsh1++NSTLQmGEt0zlm712w+KVOTEjrmMa259edtMpPoBqsYAw6bs9+nlV6RMlZ+0hSzNnaINM2Phe7yLfu4yIMuzoU8YezdiQTwK5OmRUflhT26bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mZK2ibLO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/E1eEpDR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tI8GMXx99SYylXxSswRZGqbleLEadn1lRz6gImUuT2Y=;
	b=mZK2ibLOFu1sMeHJMSqqMTx4bedygVIoNlCrGxTuvnPpKGlzANApy2vzjcgpVBqtgxjwIN
	f9+Os8UPkoM29PfIM0Z7m6AlyYf/pYem6fCAiJz44cXn+RDRmzHg6c8N7OyC0M5epDJO8P
	HlRTdcbCOhQlmZbRcWBzz7KOFXcsnYY2+ic4TfFxV4udhrenZr6gp8iwkZVwEoRrJF+w2I
	RtnYKHigbXdVjbl85GgHs14Pdqn6Jw2rNa3cfgzpIHp2ysRIu+SDSxfUk7CrNrCpS8SRbb
	RbbtoJqymwpvtrF4BIN4vb0fSa3B/lKdfij7FffNpvCSCHWTA8ZXhv0ea3Y93Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tI8GMXx99SYylXxSswRZGqbleLEadn1lRz6gImUuT2Y=;
	b=/E1eEpDRn1j+7/4dFpD5Hecwj8WY1r1kBMUj94PEvfB7AjgdbE36PGSfHOkq7Mn2Mz5XPU
	XLNDwSk/37JWNlAQ==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 18/31] perf: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:31:51 +0100
Message-Id: <432209f20747fba448f80a10b5cc776536ac490b.1729864823.git.namcao@linutronix.de>
In-Reply-To: <cover.1729864823.git.namcao@linutronix.de>
References: <cover.1729864823.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There is a newly introduced hrtimer_setup() which will replace
hrtimer_init(). This new function is similar to the old one, except that it
also sanity-checks and initializes the timer's callback function.

Switch to use this new function.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
Cc: Peter Zijlstra <peterz@infradead.org>
---
 kernel/events/core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index e3589c4287cb..a4d0d7b0311f 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1151,8 +1151,8 @@ static void __perf_mux_hrtimer_init(struct perf_cpu_p=
mu_context *cpc, int cpu)
 	cpc->hrtimer_interval =3D ns_to_ktime(NSEC_PER_MSEC * interval);
=20
 	raw_spin_lock_init(&cpc->hrtimer_lock);
-	hrtimer_init(timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED_HARD);
-	timer->function =3D perf_mux_hrtimer_handler;
+	hrtimer_setup(timer, perf_mux_hrtimer_handler, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_ABS_PINNED_HARD);
 }
=20
 static int perf_mux_hrtimer_restart(struct perf_cpu_pmu_context *cpc)
@@ -11273,8 +11273,7 @@ static void perf_swevent_init_hrtimer(struct perf_e=
vent *event)
 	if (!is_sampling_event(event))
 		return;
=20
-	hrtimer_init(&hwc->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
-	hwc->hrtimer.function =3D perf_swevent_hrtimer;
+	hrtimer_setup(&hwc->hrtimer, perf_swevent_hrtimer, CLOCK_MONOTONIC, HRTIM=
ER_MODE_REL_HARD);
=20
 	/*
 	 * Since hrtimers have a fixed rate, we can do a static freq->period
--=20
2.39.5


