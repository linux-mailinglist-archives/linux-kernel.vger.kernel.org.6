Return-Path: <linux-kernel+bounces-384361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2BE89B294D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97003282906
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC8D2038CB;
	Mon, 28 Oct 2024 07:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dKE1tGt8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fQ2K/j3k"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0932010E3
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100950; cv=none; b=dNLAAfim96StC3A//unTgpeu7sYQ5zl1UfuysYZY/fZADQ1v9NcuMH+1Jd9IgNIHd/oOckETVzMdAmsZA/V2FUxGFwMAljvr7tnv7rlEX2UePlgrWmbcnhOXjeezEUCz4QSTinPun9mR5dN9rUYk2jm1TI0dCpXBWjajD/DiXzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100950; c=relaxed/simple;
	bh=vWG2uHH01sJ9W2jiPIkagHVlUuZh6PLgpKQ8r9ArHz0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aUXvTqbNN4jePzeoq0AlPMtaC8bCml8L/XIpMjufXe+usoPir1LvsXjw1GvV5qOkOP59t/xn8Z6oz9RhQaNkwk2DH8VJ6nIQ9k1TV33nXopzVR9ErT81E3CUfqMGMNDmxTXO87lKJB5Xiy9GVOnAciOnbklr6Z1dtcb4FrPO9I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dKE1tGt8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fQ2K/j3k; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bf/hLOIb0vZTjqh1LvbKYEJqnLzJOGg6pXdqyiM/rK8=;
	b=dKE1tGt8myM/uLYGLdeOSW3a/Lnn6oWxiMq2I31w1NdQ4MHiH0qw9XoI4AUdj3hLpOiWN4
	wcNzsxS+YwGNq82jVwkjC6rr2OHAQE2/u8uCO0Bn5dMMhttJIApBsRr2U0+PKL2i4r3Qwp
	jrUmY36WuhgwMBvXngALZnLZZT5KILAn5yXkqrZcC1IuHfFHdST2vSyhyM6o+rHDcJaHp+
	+Ivskg88txPGJcr2d6ut2kM7DmpI+XClDweuiBXNno0itqEX/IBWCa/TefWdqDhLSq4Wd9
	oL7ALf9kn93ZaN5/F+ZhyVVTbGEXYGy9wT/5mM7QYY1b2HNu/faE4T3+/hdvhQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bf/hLOIb0vZTjqh1LvbKYEJqnLzJOGg6pXdqyiM/rK8=;
	b=fQ2K/j3kAJvoiSPwtrqyOVT41SKsp3UGpdA4GTEkrMdNbXlQeMBHeF8Q9br6tLqbR7Mx1l
	v08+Nw20sCEEbtCA==
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
Subject: [PATCH 35/44] drm/i915/request: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:35:11 +0100
Message-Id: <a7913a53789c5cabccd0622308718e19e7efe36b.1729865485.git.namcao@linutronix.de>
In-Reply-To: <cover.1729865485.git.namcao@linutronix.de>
References: <cover.1729865485.git.namcao@linutronix.de>
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
Cc: Jani Nikula <jani.nikula@linux.intel.com>
---
 drivers/gpu/drm/i915/i915_request.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_request.c b/drivers/gpu/drm/i915/i91=
5_request.c
index 8f62cfa23fb7..ea0b8e7e4828 100644
--- a/drivers/gpu/drm/i915/i915_request.c
+++ b/drivers/gpu/drm/i915/i915_request.c
@@ -293,8 +293,7 @@ static void __rq_init_watchdog(struct i915_request *rq)
 {
 	struct i915_request_watchdog *wdg =3D &rq->watchdog;
=20
-	hrtimer_init(&wdg->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	wdg->timer.function =3D __rq_watchdog_expired;
+	hrtimer_setup(&wdg->timer, __rq_watchdog_expired, CLOCK_MONOTONIC, HRTIME=
R_MODE_REL);
 }
=20
 static void __rq_arm_watchdog(struct i915_request *rq)
--=20
2.39.5


