Return-Path: <linux-kernel+bounces-384278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 074809B28E5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ABEA1F22184
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7871DB94F;
	Mon, 28 Oct 2024 07:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n2z1lP95";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0fjlMWvx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9882193091
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100745; cv=none; b=FUkeTfBSTqcCo95p6qTpQ+t4zRk4WWDNE5SschRef5hxJ5NBbhGAUaOSgiy4OTY5laYwc+M7+9xYN0LIsHvWbIr/iF0P6gFsAHqwZfG2XSFIKXuDJ3vTLEbyqmufRVqrrPJJF3GhugVf56ZjusiWcQjwX0HrSCtRtJt7tqqCqAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100745; c=relaxed/simple;
	bh=0ecXry8nQgCLZWFX+XxTBgYOSXIn55VUfnVFoUBcUFo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mBlaj/3EdlJx70K8JZL+8bfbc/py+8frXTmfmcHyKAZb1c0q15Fh+x+eYoqH+CvX0tU5y5pEpUXUO5xuRFdkzJRI41dpCI0VbU7oIDooTL4ZTeFoZdYUKN33A9MGljUgzM8rX6YXD1OZpBRe7h60tElMtbH69Q3iQ/1d/qCswdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n2z1lP95; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0fjlMWvx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2hsPfc6VMYyr8r/5biFCpi3upGU+24IB6TEB4bhCneg=;
	b=n2z1lP95SUBbs6/SnZlt+/Thcx1w9poXMSGdpsrB2H5mX+/z4SMDhPyAz6A2Oc9NB/qhln
	ixaXrIHkW0x+38DGabqrtcUay5ICxd5Uv5Yhlrm5im4oYnuHCdfa37aLPgA5tjZ1UN2r+/
	BCadnlooppXqIylMJVw0Khltb5+4AObY6MHPf80tmh4hrgxd9KaoVUbQkJkxTdiQk0Hp6J
	DgzQH1his8j7/plpPdik+eAK0wMx1a7NUcUHBfi9siY9K0O85jMqU7ZaYpjOuS9fAbPAoy
	VlbTieXvzBPkhRo0j0IXl+Ke2rCC5Bk7lUAwUlA4FzCZTVyJ4pjg7leutnULnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2hsPfc6VMYyr8r/5biFCpi3upGU+24IB6TEB4bhCneg=;
	b=0fjlMWvxSAmpR/tvlMHsVFPSQYzG6jswnHwfT2L2uMCje/W0BTJoK7OeKgUI5JMnxaUTZM
	A8k8/S1l0INhP7DQ==
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
Subject: [PATCH 13/31] sched: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:31:46 +0100
Message-Id: <f83c7ad9954fce1f84eaec94bb7b58f5f6974fc4.1729864823.git.namcao@linutronix.de>
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

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
Cc: Peter Zijlstra <peterz@infradead.org>
---
 kernel/sched/core.c     | 3 +--
 kernel/sched/deadline.c | 6 ++----
 kernel/sched/fair.c     | 8 ++++----
 kernel/sched/rt.c       | 5 ++---
 4 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 43e453ab7e20..b86dc57e9dcd 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -903,8 +903,7 @@ static void hrtick_rq_init(struct rq *rq)
 #ifdef CONFIG_SMP
 	INIT_CSD(&rq->hrtick_csd, __hrtick_start, rq);
 #endif
-	hrtimer_init(&rq->hrtick_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
-	rq->hrtick_timer.function =3D hrtick;
+	hrtimer_setup(&rq->hrtick_timer, hrtick, CLOCK_MONOTONIC, HRTIMER_MODE_RE=
L_HARD);
 }
 #else	/* CONFIG_SCHED_HRTICK */
 static inline void hrtick_clear(struct rq *rq)
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 9ce93d0bf452..cd9d68e87aa0 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1362,8 +1362,7 @@ static void init_dl_task_timer(struct sched_dl_entity=
 *dl_se)
 {
 	struct hrtimer *timer =3D &dl_se->dl_timer;
=20
-	hrtimer_init(timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
-	timer->function =3D dl_task_timer;
+	hrtimer_setup(timer, dl_task_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HAR=
D);
 }
=20
 /*
@@ -1817,8 +1816,7 @@ static void init_dl_inactive_task_timer(struct sched_=
dl_entity *dl_se)
 {
 	struct hrtimer *timer =3D &dl_se->inactive_timer;
=20
-	hrtimer_init(timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
-	timer->function =3D inactive_task_timer;
+	hrtimer_setup(timer, inactive_task_timer, CLOCK_MONOTONIC, HRTIMER_MODE_R=
EL_HARD);
 }
=20
 #define __node_2_dle(node) \
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 225b31aaee55..c82ada095bca 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6576,14 +6576,14 @@ void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b=
, struct cfs_bandwidth *paren
 	cfs_b->hierarchical_quota =3D parent ? parent->hierarchical_quota : RUNTI=
ME_INF;
=20
 	INIT_LIST_HEAD(&cfs_b->throttled_cfs_rq);
-	hrtimer_init(&cfs_b->period_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINN=
ED);
-	cfs_b->period_timer.function =3D sched_cfs_period_timer;
+	hrtimer_setup(&cfs_b->period_timer, sched_cfs_period_timer, CLOCK_MONOTON=
IC,
+		      HRTIMER_MODE_ABS_PINNED);
=20
 	/* Add a random offset so that timers interleave */
 	hrtimer_set_expires(&cfs_b->period_timer,
 			    get_random_u32_below(cfs_b->period));
-	hrtimer_init(&cfs_b->slack_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	cfs_b->slack_timer.function =3D sched_cfs_slack_timer;
+	hrtimer_setup(&cfs_b->slack_timer, sched_cfs_slack_timer, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
 	cfs_b->slack_started =3D false;
 }
=20
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 172c588de542..082e3970dc18 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -127,9 +127,8 @@ void init_rt_bandwidth(struct rt_bandwidth *rt_b, u64 p=
eriod, u64 runtime)
=20
 	raw_spin_lock_init(&rt_b->rt_runtime_lock);
=20
-	hrtimer_init(&rt_b->rt_period_timer, CLOCK_MONOTONIC,
-		     HRTIMER_MODE_REL_HARD);
-	rt_b->rt_period_timer.function =3D sched_rt_period_timer;
+	hrtimer_setup(&rt_b->rt_period_timer, sched_rt_period_timer, CLOCK_MONOTO=
NIC,
+		      HRTIMER_MODE_REL_HARD);
 }
=20
 static inline void do_start_rt_bandwidth(struct rt_bandwidth *rt_b)
--=20
2.39.5


