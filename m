Return-Path: <linux-kernel+bounces-384362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B32689B294F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41AAB1F21D79
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2615204936;
	Mon, 28 Oct 2024 07:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AECKOGxO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2WLYZgs/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B21320125B
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100951; cv=none; b=VYgi64q1oLacJY0eXNxppsLto8sTJoEt3P5PNntR11NRcPxCoKrk+0X1uUKxk86V9HGaQ5BprzM4ScSQYdTRc3g0PFgg5m1004Xw9wJnjZ5fABJ2TWdh7u8AMSXT0z6aB1KuMEJb9JrnjoMgGR/2j5p6VHZgJm2jSsbnEpY5uZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100951; c=relaxed/simple;
	bh=ziGJB9RfdWeVAvhVRtaw6OVZJOe2lPhiDj35hkfOaFU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NKMZ0TecXBopRrrZoE0LeOltbAO4Ebf/7jbx4V2tgo4TrDrXVP3iQ9O8OuceScf143f6TKnBs+Im96xxFZKe/tLWF4ottZ8O634tL/2PXd0Nsn5VGExC6PRUm1aCUbdyETkPWJrOmaRgUvybJDFnnnJtc5xArgh7esoEHYmOU6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AECKOGxO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2WLYZgs/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QEaa61gEWvaXPE5nExFqV/bQDWHuntReKn5oI83gkQo=;
	b=AECKOGxOS8ACO1ZOa5QOyusWJFLZqfGkZRKIbB8i960Sbk7ezvgNPBb0aG1s3tzizLQ/VI
	jgta6bjOTzsETj85ybgdaWyBuzAeQcDqlo57leBeGRR4EUO+cPplFpa7TFHYdbtPPbLuLC
	Mwdsaco+RlsSMqCzGPsMyI/xTcjBad/TIEGOINz4qU6Sdj6ykl6udWEmfRZ6p04rpJZWTS
	rZXy3hWnNereOrVzGBeWyM3cdvgZf1jecrg4I0BRAEsYlkMBYEPRiIPIlHUJBTboCqcseW
	BEk7qbe/Nkn4mpjt7VwCLMl/3qI0XFikKQIQj7l60yRZJzr+P+YeGRwVhp/TzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QEaa61gEWvaXPE5nExFqV/bQDWHuntReKn5oI83gkQo=;
	b=2WLYZgs/2YTVJp+ubDi+Az+EcaobMHdn1NjH/jLk+/ZRs70qvN4GsnoDW1VSEWCJ+2xZhO
	+non0N1cM0rxYACA==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Rob Clark <robdclark@gmail.com>
Subject: [PATCH 36/44] drm/msm: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:35:12 +0100
Message-Id: <e835957c9979fada4556402735d9b416e48875fa.1729865485.git.namcao@linutronix.de>
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
Cc: Rob Clark <robdclark@gmail.com>
---
 drivers/gpu/drm/msm/msm_fence.c    | 3 +--
 drivers/gpu/drm/msm/msm_io_utils.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_fence.c b/drivers/gpu/drm/msm/msm_fenc=
e.c
index 1a5d4f1c8b42..d41e5a6bbee0 100644
--- a/drivers/gpu/drm/msm/msm_fence.c
+++ b/drivers/gpu/drm/msm/msm_fence.c
@@ -65,8 +65,7 @@ msm_fence_context_alloc(struct drm_device *dev, volatile =
uint32_t *fenceptr,
 	fctx->completed_fence =3D fctx->last_fence;
 	*fctx->fenceptr =3D fctx->last_fence;
=20
-	hrtimer_init(&fctx->deadline_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
-	fctx->deadline_timer.function =3D deadline_timer;
+	hrtimer_setup(&fctx->deadline_timer, deadline_timer, CLOCK_MONOTONIC, HRT=
IMER_MODE_ABS);
=20
 	kthread_init_work(&fctx->deadline_work, deadline_work);
=20
diff --git a/drivers/gpu/drm/msm/msm_io_utils.c b/drivers/gpu/drm/msm/msm_i=
o_utils.c
index afedd61c3e28..a6efe1eac271 100644
--- a/drivers/gpu/drm/msm/msm_io_utils.c
+++ b/drivers/gpu/drm/msm/msm_io_utils.c
@@ -135,8 +135,7 @@ void msm_hrtimer_work_init(struct msm_hrtimer_work *wor=
k,
 			   clockid_t clock_id,
 			   enum hrtimer_mode mode)
 {
-	hrtimer_init(&work->timer, clock_id, mode);
-	work->timer.function =3D msm_hrtimer_worktimer;
+	hrtimer_setup(&work->timer, msm_hrtimer_worktimer, clock_id, mode);
 	work->worker =3D worker;
 	kthread_init_work(&work->work, fn);
 }
--=20
2.39.5


