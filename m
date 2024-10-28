Return-Path: <linux-kernel+bounces-384379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFA59B2960
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25AA51F24387
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39DE191478;
	Mon, 28 Oct 2024 07:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="B5I6+OPW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YUkT9GmL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7425206073
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100971; cv=none; b=Tgb00w6X9SCbH5zbBUjGTsTe7CVzZqzmND7kiuMD7p4moOp3fjWU8fSCfdfmXVY90HOI/BjkB9gtsmJXOEqQbmbhk35yLxdsZFzEuawyvtsHvnvOopQntF+JOwd9kvhZGmuk64VMhKTq8DuiwdKig2sa1JbR+1jXMzyv16xVudU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100971; c=relaxed/simple;
	bh=qf+PMEL1sWXuMKrQ1DoIrqLvNC8MNyx3gXNn7VkDheI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rx1m5Tyxh7r3aF4fYQuO3jTjEbm8Ukzqd7MEhB0q4OMg5ts6GHvw9ZG3wro+69BrNlt2NBlovZW0cLe/+lFt4kf8hriCw3HPrvU6rIpnIt+iAVHJvITlFLRrIKy8SJuEMqkzrrbj110eSzYfyPYWxMIhl4cLFOM306AtIW/WxQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=B5I6+OPW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YUkT9GmL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ravrCfgcfWkk1ZfX6tkHa/OzKLCsADxyfO8FJoHeiHc=;
	b=B5I6+OPW7vgxDwOldejHr3CKuPU77QkJZtzr3MofbdJP+vtf7aYqRBzKlWRhZr3hpHs6va
	Y0TWE2eW/JUjFEGAfT5M8O2RCC2P45xb/n5yiofW6cEkNCINejt/se5mfPjkTRuy8q2GL9
	gtNJFCPbTd5h8MjO3PzDsXfK3e7d3sCb2pJRzAn4PC8LTcNOnXDKrARxPrDxqnvSVvuEu2
	5+pynGspJPsAU+6xWz2JIBSY7ClNcj6aURxC6SsWfLoWj3IQhdY8yGQX59MGm9+hhbtgEm
	8IZt0lSlgMdvEq/aKt4eUfGIbidQ6lwcYUiiNkxOio5ihQD29rGFdBJekRg/uQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ravrCfgcfWkk1ZfX6tkHa/OzKLCsADxyfO8FJoHeiHc=;
	b=YUkT9GmL0rvf7RxwNWUON6Bu/rMCrVfIC9BisAbObhtLjdb88d1geCO27lHZeaDDVmvV3L
	2eKvEWHp4yG8/CAg==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH 10/12] hrtimers: Rename debug_init() to debug_setup()
Date: Mon, 28 Oct 2024 08:35:54 +0100
Message-Id: <ca4d5534625643e4d55ce693dfbc86e0af5d145a.1729865740.git.namcao@linutronix.de>
In-Reply-To: <cover.1729865740.git.namcao@linutronix.de>
References: <cover.1729865740.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

All the hrtimer_init*() functions have been renamed to hrtimer_setup*().
Rename debug_init() to debug_setup() as well, to keep the names consistent.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 kernel/time/hrtimer.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 36d55ce57810..6c29d988e145 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -448,9 +448,7 @@ static inline void debug_hrtimer_activate(struct hrtime=
r *timer,
 static inline void debug_hrtimer_deactivate(struct hrtimer *timer) { }
 #endif
=20
-static inline void
-debug_init(struct hrtimer *timer, clockid_t clockid,
-	   enum hrtimer_mode mode)
+static inline void debug_setup(struct hrtimer *timer, clockid_t clockid, e=
num hrtimer_mode mode)
 {
 	debug_hrtimer_init(timer);
 	trace_hrtimer_init(timer, clockid, mode);
@@ -1596,7 +1594,7 @@ static void __hrtimer_setup(struct hrtimer *timer,
 void hrtimer_setup(struct hrtimer *timer, enum hrtimer_restart (*function)=
(struct hrtimer *),
 		   clockid_t clock_id, enum hrtimer_mode mode)
 {
-	debug_init(timer, clock_id, mode);
+	debug_setup(timer, clock_id, mode);
 	__hrtimer_setup(timer, function, clock_id, mode);
 }
 EXPORT_SYMBOL_GPL(hrtimer_setup);
--=20
2.39.5


