Return-Path: <linux-kernel+bounces-411082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D049CF2B6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 18:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 839CF287CA7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 17:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803311D89E4;
	Fri, 15 Nov 2024 17:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BQcSAVxl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rQ7MGKcU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AB01D618E
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 17:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731691246; cv=none; b=h860hB/3UeHXcJmmXavJwufAEy8Zc+evN1m0te309XoUyPQW2HUVH17dTAKpjmHId52crKCWgJWhEbZrihUf4fFZNyfzIyfOA7WWbAYT+Hat1o1xOw2PnleoJ3XLinA7FiBUqwOQnGTjkrf3tuf9YsZoScKbLlaS5rJlCyivGs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731691246; c=relaxed/simple;
	bh=QjaveWrqakVWPDt1kCPBzhPvKFA/6V1j7gTXc4PlN0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pQArQEmD6J9hz4a/f1HLLKIbRdNKnLN8ieVTr/crd2EDbjURRAzZDpGvbCLBiLgTySIUMYbJcAvY4eHLwPC3bD//+6LN+OMYHtvkPaQn3kj2gBDQI7oSOVMnV+oxlGF+KmOWqfPMzmFQSr4gYzylKBdqGaelJhPTDbH2nY/AFlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BQcSAVxl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rQ7MGKcU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731691243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N+Zz9C96+wY0yelOjC14Yin3lUriNa4uFLkffOwJDHg=;
	b=BQcSAVxlLPVkp148JIbgjpXBFCvDoOOL+JG4ujHIq1HlLzfO9cVj3rXptijeq+/NdlYks3
	84YfSkY+o0X6dze5sX1oFCJuK4ZuDO5y28XleWok9WJYbxzcMRvl8dlK0nrb+Pete97YdF
	Ec77646gpOUYmU/eMc/GNxM0BE/+vDa+Vv7L5BAYKHxSxrwtC1Nqurz0JDy4nSr68vQixB
	RTmgTqvO/k+NzL4GQZM1F8KgghJ7KoStLBeRnSCjLMSeP43fk0ldg0wOXJjsPvn/W/2HKE
	zM4Umys45Lc44J3GU+/T9XEANk0fFgMr+DB4iPWGNt+H3Gplurpn5tN2ASpVZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731691243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N+Zz9C96+wY0yelOjC14Yin3lUriNa4uFLkffOwJDHg=;
	b=rQ7MGKcUkJ2KIvaOumavAY0j4jWR3pKykhrgfpwLcFZqldt223nw6lBbhLeeVDOJANENVh
	9NFFnx7fI1es2nCQ==
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
Subject: [RFC PATCH v3 3/9] futex: Allow automatic allocation of process wide futex hash.
Date: Fri, 15 Nov 2024 17:58:44 +0100
Message-ID: <20241115172035.795842-4-bigeasy@linutronix.de>
In-Reply-To: <20241115172035.795842-1-bigeasy@linutronix.de>
References: <20241115172035.795842-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Allocate a default futex hash if a task forks its first thread.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/fork.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/kernel/fork.c b/kernel/fork.c
index a83cf4d87ae57..2929e236a3801 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2109,6 +2109,17 @@ static void rv_task_fork(struct task_struct *p)
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
+	if (current->mm->futex_hash_bucket)
+		return false;
+	return true;
+}
+
 /*
  * This creates a new process as a copy of the old one,
  * but does not actually start it yet.
@@ -2486,6 +2497,21 @@ __latent_entropy struct task_struct *copy_process(
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
+		 * futex hash map. We assume that another thread will created
+		 * and makes use of it The hash map will be freed once the main
+		 * thread terminates.
+		 */
+	}
 	/*
 	 * From this point on we must avoid any synchronous user-space
 	 * communication until we take the tasklist-lock. In particular, we do
--=20
2.45.2


