Return-Path: <linux-kernel+bounces-384255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 276CC9B28CF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C75CA1F21659
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56241D1724;
	Mon, 28 Oct 2024 07:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BDLVCkuW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3fetGmtI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8877F192B9D
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100637; cv=none; b=WDAdzPbnXO9tmSlYcHXg76ksYekUDQ27VdnfU9jSQiwmlb0ACn4XuXCfwqBGwFyruT4Anb7nap7LuYXrV1pafL73uZfyiugHx9KKE9v7jAl1HvzDLDFzwyDLwNsfJTbF0ONZK4cdjNamY0KOMNotSMMtB+MqDqgtnjVXvz1c71U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100637; c=relaxed/simple;
	bh=p1WNHHJsh//H3R31M4mEAZn/dExjkNeMnZF2QHlbd0s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g1cEUeTfQ6T+cEqqbDggEYLE8Xwpd9195bioYnZ0UuhFCq2MF6LhtScf7lfD455C8467Tt48vJzHSH4rqe1kzNW0eCP0V0gs2Tfkeq4E9oBFMn4wwPodgbd1KMenIrjF6v807PCzbIiqRqoVEUm6f65AqW45ixOiELXDvQeSFiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BDLVCkuW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3fetGmtI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Kc2BZUC1ebPDEVIRiKKvNYv3u35tkYwpWsAZQDECc0=;
	b=BDLVCkuWXi66KLg8gA20FhuUkuvW0/+MimT+ESeZ0qEIfNpwO1cBSilOuA0902JiLQa8xd
	+I1FEHwmAcbb28YMis78gUs/Su4UDRojowDOcbGuZQTSuYL8NtnBqkpGH3rALURoVfqO/D
	yXjCBDc+g5YFZLxzXpCJnK5pLzZwf41MpO0D2F8V76T5blDg2F0HkTeRCwi0R4BuusdSup
	qNFF8VQs6kTkBgW/FIq655oqqXv5SsPq4RuCBWuOJVe/XrqgE/PxJVPPRyrNrQuf7aqBEn
	PGOnI3XMcpAlHUrUwwtk2+XlriXj0uRNXqpkBr7GTIeBC14XaM2EdeQFevNK1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Kc2BZUC1ebPDEVIRiKKvNYv3u35tkYwpWsAZQDECc0=;
	b=3fetGmtIPSb/5FB9Qpv8MT6Li6TNJdacDtiGS3V8Hx9Dtg8rXxst4HMZdLK1WqcC6Q+4EW
	jmWUl/oPUmgLP1AQ==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH 15/21] timers: Switch to use hrtimer_setup_sleeper_on_stack()
Date: Mon, 28 Oct 2024 08:29:34 +0100
Message-Id: <868b994e1f724ef48c44f9e06d5968a3fc5e3f71.1729864615.git.namcao@linutronix.de>
In-Reply-To: <cover.1729864615.git.namcao@linutronix.de>
References: <cover.1729864615.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There is a newly introduced function hrtimer_setup_sleeper_on_stack() which
will replace hrtimer_init_sleeper_on_stack().

This function is the same as the old hrtimer_init_sleeper_on_stack(), but
it was introduced to keep the names consistent with other changes with
hrtimer.

Switch to use the new function.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 kernel/time/hrtimer.c       | 5 ++---
 kernel/time/sleep_timeout.c | 2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 1d1f5c03673c..69430467a17d 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -2138,8 +2138,7 @@ static long __sched hrtimer_nanosleep_restart(struct =
restart_block *restart)
 	struct hrtimer_sleeper t;
 	int ret;
=20
-	hrtimer_init_sleeper_on_stack(&t, restart->nanosleep.clockid,
-				      HRTIMER_MODE_ABS);
+	hrtimer_setup_sleeper_on_stack(&t, restart->nanosleep.clockid, HRTIMER_MO=
DE_ABS);
 	hrtimer_set_expires_tv64(&t.timer, restart->nanosleep.expires);
 	ret =3D do_nanosleep(&t, HRTIMER_MODE_ABS);
 	destroy_hrtimer_on_stack(&t.timer);
@@ -2153,7 +2152,7 @@ long hrtimer_nanosleep(ktime_t rqtp, const enum hrtim=
er_mode mode,
 	struct hrtimer_sleeper t;
 	int ret =3D 0;
=20
-	hrtimer_init_sleeper_on_stack(&t, clockid, mode);
+	hrtimer_setup_sleeper_on_stack(&t, clockid, mode);
 	hrtimer_set_expires_range_ns(&t.timer, rqtp, current->timer_slack_ns);
 	ret =3D do_nanosleep(&t, mode);
 	if (ret !=3D -ERESTART_RESTARTBLOCK)
diff --git a/kernel/time/sleep_timeout.c b/kernel/time/sleep_timeout.c
index 3054e5232d20..dfe939f6e4ec 100644
--- a/kernel/time/sleep_timeout.c
+++ b/kernel/time/sleep_timeout.c
@@ -208,7 +208,7 @@ int __sched schedule_hrtimeout_range_clock(ktime_t *exp=
ires, u64 delta,
 		return -EINTR;
 	}
=20
-	hrtimer_init_sleeper_on_stack(&t, clock_id, mode);
+	hrtimer_setup_sleeper_on_stack(&t, clock_id, mode);
 	hrtimer_set_expires_range_ns(&t.timer, *expires, delta);
 	hrtimer_sleeper_start_expires(&t, mode);
=20
--=20
2.39.5


