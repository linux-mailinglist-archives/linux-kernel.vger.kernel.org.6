Return-Path: <linux-kernel+bounces-557977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94954A5E008
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 16:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 306B1175636
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37452571D0;
	Wed, 12 Mar 2025 15:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="icx4w/Z3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="feDHiAik"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5667253F30
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 15:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741792607; cv=none; b=LqalrQRhdx2W0m5XpmRTk1QFIB2RHcFYBChqfeiiPmeCnHnHkLbNOfKrpC8QwcppoXL6LtVKm2cfV4AKdvnZoLffmViMldO1OjsL0UDJK6HtSydXGwgxfgRXU8dozEF2y/lfhlt8wkRg/521fDc1SB5XvFq9n9N+sveAqTqPJlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741792607; c=relaxed/simple;
	bh=cLvRqCx4fyRpNg62flvLoAR+ZnmBnNvjRz7U70ntS/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R/MQwHAiAyzXVcEp/BOZJfLdvOVqPi45GgZz65uKXgE+v8LHq+Ct2TFQ59liXHgTRknQ4dVhcbI0qGpaWi4TT1lIWOLjtrYS8NLFdfbQocOf7Vob27IIOUEsJadyd+1p1Fr04U2TP3Np5PiKEgTrZ8anJwooCLuz1/NdioAzqoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=icx4w/Z3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=feDHiAik; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741792603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QbL60HqGpqeHNoGxFnXcSoVcCK+9wOVSWknHise1E80=;
	b=icx4w/Z3vwm5POLTn4pCb6XYzULxd21i/nAM0I24CatG+2AqlGotEVapC4/qzqyyppGVME
	sc9+GbzAWkGRstAo/T8XH9+jeCC+4wLypN3e62Ta5jPIDFdds7uxP+sirLQhzV4rQyZ3lk
	FML7qSGp2MvrulzObaWbFVCWHSlbpW4HS9rzTrWB05kdxwGMIOG5uQbMZYMjaEBijXur0g
	JDKikiuOMKfjtdjRxKvt/kFEcDR1MNZKVLyktaGIDPuwPbrbO+iKweRptAyb2MdPM40Y/c
	93R5A3OjgWbX6zvTLMrd+n3MIYQ4demA0nLpOQkQFEwQ4xpE+rFd9g4K7eHG6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741792603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QbL60HqGpqeHNoGxFnXcSoVcCK+9wOVSWknHise1E80=;
	b=feDHiAikJ54XQQAEyFBZX3OhnTeLrkwIEeRApRAX8Dj6mrmgOm521QXPIWExHBgE32wDJ8
	Ad2cxw9SJg06v/Ag==
To: linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v10 09/21] futex: Allow automatic allocation of process wide futex hash.
Date: Wed, 12 Mar 2025 16:16:22 +0100
Message-ID: <20250312151634.2183278-10-bigeasy@linutronix.de>
In-Reply-To: <20250312151634.2183278-1-bigeasy@linutronix.de>
References: <20250312151634.2183278-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Allocate a default futex hash if a task forks its first thread.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/futex.h | 12 ++++++++++++
 kernel/fork.c         | 24 ++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/include/linux/futex.h b/include/linux/futex.h
index 943828db52234..bad377c30de5e 100644
--- a/include/linux/futex.h
+++ b/include/linux/futex.h
@@ -86,6 +86,13 @@ static inline void futex_mm_init(struct mm_struct *mm)
 	mm->futex_hash_bucket =3D NULL;
 }
=20
+static inline bool futex_hash_requires_allocation(void)
+{
+	if (current->mm->futex_hash_bucket)
+		return false;
+	return true;
+}
+
 #else
 static inline void futex_init_task(struct task_struct *tsk) { }
 static inline void futex_exit_recursive(struct task_struct *tsk) { }
@@ -108,6 +115,11 @@ static inline int futex_hash_allocate_default(void)
 static inline void futex_hash_free(struct mm_struct *mm) { }
 static inline void futex_mm_init(struct mm_struct *mm) { }
=20
+static inline bool futex_hash_requires_allocation(void)
+{
+	return false;
+}
+
 #endif
=20
 #endif
diff --git a/kernel/fork.c b/kernel/fork.c
index 95d48dbc90934..440c5808f70a2 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2137,6 +2137,15 @@ static void rv_task_fork(struct task_struct *p)
 #define rv_task_fork(p) do {} while (0)
 #endif
=20
+static bool need_futex_hash_allocate_default(u64 clone_flags)
+{
+	if ((clone_flags & (CLONE_THREAD | CLONE_VM)) !=3D (CLONE_THREAD | CLONE_=
VM))
+		return false;
+	if (!thread_group_empty(current))
+		return false;
+	return futex_hash_requires_allocation();
+}
+
 /*
  * This creates a new process as a copy of the old one,
  * but does not actually start it yet.
@@ -2514,6 +2523,21 @@ __latent_entropy struct task_struct *copy_process(
 	if (retval)
 		goto bad_fork_cancel_cgroup;
=20
+	/*
+	 * Allocate a default futex hash for the user process once the first
+	 * thread spawns.
+	 */
+	if (need_futex_hash_allocate_default(clone_flags)) {
+		retval =3D futex_hash_allocate_default();
+		if (retval)
+			goto bad_fork_core_free;
+		/*
+		 * If we fail beyond this point we don't free the allocated
+		 * futex hash map. We assume that another thread will be created
+		 * and makes use of it. The hash map will be freed once the main
+		 * thread terminates.
+		 */
+	}
 	/*
 	 * From this point on we must avoid any synchronous user-space
 	 * communication until we take the tasklist-lock. In particular, we do
--=20
2.47.2


