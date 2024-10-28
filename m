Return-Path: <linux-kernel+bounces-384340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D089C9B2938
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E9531C2175E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B51E1FC7E9;
	Mon, 28 Oct 2024 07:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GfFeZayu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9d//O7Ua"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D731EF92F
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100943; cv=none; b=m03OMWZ0CWjbYAlVNmofN8TeEd5OO5BxA2aRFlek25EnhNH+7LGVDbpyjyVHdSw88HSiVk8GNhz0nz7Rfgf3KV7WYrLZK2YvA50cBYz/a3WIwnBEPP/0gECifolkYMR97DCRBlUKVO/zAvZ0mS7VT4Rr4rIq5EoUqLQ2ibBN9Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100943; c=relaxed/simple;
	bh=BxDhOeSQLPgECkty78KmlusSnACDaKkcsuLTWWzn/go=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Txcyq05nyGRLJHlgKDNk9MCGybcsGW2Sb/JmukzxVjs0jDZLIqutGMBW8XfEqFz6QuLRXCufoTBFQ+r7MSOQcJrvJxkpHUfPK0hBh88JgV3JV9dyF59H6P69bRYqoaUip1KqmWjwfbyonm2Ph5TAUnGR6WM73u69wDkrWNSncKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GfFeZayu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9d//O7Ua; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BrDakq/+76kc3UqGRrwKcgMS8Vdnk/xc6PYxmxTJvB8=;
	b=GfFeZayuAhpRvxADLlwRFO2boOh3VKl3i7CGYKwl350jfYcE6Cj2/fDATo5Dgr7ebejGTZ
	s8BGyGNuo68LOB9ugTv0MnRQSMTpsRZWmyR2SvNuKkgkIMrRp2RudXGSP0BleFCaurMZnI
	C1OV+DBDldE11YJjExct1EM7plJ6FsvopqotEarqW73FfCl731wS9BrhpjEH7E/ZxRhMOL
	polBv5chR7/oDBwTWqAB6/yDjGwS+2PR2KEhSM9WaujKspSnweuY9dXLpFUj8sxRWW+6BF
	/Oqyqg6JWJQ9AMP3UUeQjn5qXwOmdxprsVVgPZWvYYpzgJyeOH2BE8Ma+grrOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BrDakq/+76kc3UqGRrwKcgMS8Vdnk/xc6PYxmxTJvB8=;
	b=9d//O7UawOVCZwaAIqrVzIs+eCMY/VtmYnZMhl5PWAN0luBblAgXTdpPD72MmyW8SbdJrh
	K7o2oL3hPxMPuxBg==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 15/44] powercap: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:34:51 +0100
Message-Id: <d607a13a16b0e3c5b5d58b73869c83c0740214e4.1729865485.git.namcao@linutronix.de>
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
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
---
 drivers/powercap/idle_inject.c       | 3 +--
 drivers/powercap/intel_rapl_common.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/powercap/idle_inject.c b/drivers/powercap/idle_inject.c
index bafc59904ed3..29f9f452d445 100644
--- a/drivers/powercap/idle_inject.c
+++ b/drivers/powercap/idle_inject.c
@@ -339,8 +339,7 @@ struct idle_inject_device *idle_inject_register_full(st=
ruct cpumask *cpumask,
 		return NULL;
=20
 	cpumask_copy(to_cpumask(ii_dev->cpumask), cpumask);
-	hrtimer_init(&ii_dev->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	ii_dev->timer.function =3D idle_inject_timer_fn;
+	hrtimer_setup(&ii_dev->timer, idle_inject_timer_fn, CLOCK_MONOTONIC, HRTI=
MER_MODE_REL);
 	ii_dev->latency_us =3D UINT_MAX;
 	ii_dev->update =3D update;
=20
diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_=
rapl_common.c
index 5e793b80fd6b..e675d4240d9f 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -2063,8 +2063,7 @@ int rapl_package_add_pmu(struct rapl_package *rp)
 	raw_spin_lock_init(&data->lock);
 	INIT_LIST_HEAD(&data->active_list);
 	data->timer_interval =3D ms_to_ktime(rapl_pmu.timer_ms);
-	hrtimer_init(&data->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	data->hrtimer.function =3D rapl_hrtimer_handle;
+	hrtimer_setup(&data->hrtimer, rapl_hrtimer_handle, CLOCK_MONOTONIC, HRTIM=
ER_MODE_REL);
=20
 	return rapl_pmu_update(rp);
 }
--=20
2.39.5


