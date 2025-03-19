Return-Path: <linux-kernel+bounces-568549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0594A69758
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 19:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24E3B461DD4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 17:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D924C20A5CA;
	Wed, 19 Mar 2025 17:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KoN9UVMr"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBE020A5D5
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 17:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742407114; cv=none; b=cm6n0a31bkbzHVHnkzX4zoPUuilUcpATrzVp40b6fRwMF7OV+oU6G+pR/Wp9ku6BdKNpmykLD7OLBfqD4wNZ80kZHcAFJnen4KtrOwRDXNNVJXO7MB0SMP0mM5sq6GQHR2kqVP53rrNjnGRY3kyQKMP5Ood56PA/o0hC3SnH478=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742407114; c=relaxed/simple;
	bh=9HdrdpQN57SPXTw9v+PkPSQaqs0uchRdMq7Am30TTdk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P9iyERHR8KYV5fCb5eZFXbdVa5UADwnmFOjmaeAECaV+wm6hAhgjzEfgn/jIFrKmqR6RBT376iY2MOqIMJSply3QcQSWhpK3od2nQ6En6rTyq2f/fpzsw8x3XzZT4gaTID6qEkNNS5NapTfGt1jjtV1jU0shMq8iaeDpQlPra5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KoN9UVMr; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3995ff6b066so2844078f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 10:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742407111; x=1743011911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vV+tzqrk5fYe/vqOzZvzfnMHBPoMCIaJ8RY1hgemTAY=;
        b=KoN9UVMr4VcueP4LDDX6EBH32oDXrfmeOMn6RiSC+w6fHBcxnyYkXKab/Hz3w2Owt4
         gxAX1jgb7a7ywHRsl2aKwy6IUzjsOBDMuCNRQIzDK1W0NTD7QPeVXWALWVbvcxKY4WPj
         lKto2vfuoJyGz2z/75+bpDPmpOrkYqpG2R/n1Gr3ClDS7jzLZOyJxySsHAXBFht3XQ1t
         PqBABpxBREeBry5runfdotbZSCbVYLFopMwEOC66L+SoA+hHVAHYHRAw8PRrTKAr0nTp
         G8qwCc1E6cVRLp6gwkSmu6s8Hs5D6mmzNkIbCPttXlNg5TOphjkn22MXvxLSGW3TBgFQ
         UWzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742407111; x=1743011911;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vV+tzqrk5fYe/vqOzZvzfnMHBPoMCIaJ8RY1hgemTAY=;
        b=bY5kMOAOTBucSzmzvGCuy/RtaYUUGqKCcl+dpQJ5/0ZTAvLQO11OG+LRgBjrsEmfFa
         nbJ0YiOg/KNWWe8J1wcto1mLrQXXP4KBR7JCgp82JvxuDhAZcNo3kSJ0bvRqEPOnhZib
         3GPEbqJK6neUfyT9dWheVwhs2t20SXf/hbzExdMhdDuTLhHsY+tVN8OwUsYuKkRGxvdR
         WIFxq6btjVvGVfAhVdi5iETEismdsMBeBSGLSQHdjpvFFcF4nYkGUamWjUzuo9l8dRSz
         g2AcZspwWzEmb1LhO4uozdTgOe3Q/X9xCGyJzOOBxdHfyxcOlwfmQJ3UgYy89rqYqAy4
         ajtg==
X-Forwarded-Encrypted: i=1; AJvYcCXfiCdGDqNfDpumMzLPPFDHYPnn5oHMal2R9UnzX/+ZTidX1EIrpVgyVO2wFwTGiY0gdpXxlz9pOuBY2DY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/4oTegoClW5KxwmGr54DjlUUhYpmpFeoUmXWeMq6fUWvOYoXR
	rs1v/myu9++xAM5c1kcRRFZlz6aH8PK6zAxZihhH2xIcwDLW7KMx
X-Gm-Gg: ASbGncty5JRUeVbCoKFgVqxMkYXR2ON3jG/c9T/3giFcc1+P89e7sKPUg5zs+SVkMsR
	c11CFqeVOvUsjUfxS93Zf4nn3DkNBhI0OdqXuGTo3KWJ2tTrhdwtl+Jm4D6rXfgVRzA32lWwgoQ
	BmPA0gsjqGiiU4udIpfPu+0MGxI9wQ8eIcghHqF3OJkqnO7m6vbpC/1UkecuPEHAQh8kNf02I2U
	C7FqyTTsxqxeg6oQzroo+c/DB4178uRc1AdeNzJRuU+tnjZ+faqGnit2Fb9/Q+3xvXfoX129WFl
	183d/jTR6cxM/AqShKXzvx8TZ1Kd+nYQa0ghUIDRKG02JkZyMNMklgBWQWQoVFw=
X-Google-Smtp-Source: AGHT+IH9dczj17t9dEjvFrCN9jBtcXzAjGWolSi31Qb3S7vtWpZT+AKkNvZjpqeomeGMV4agNcQPZw==
X-Received: by 2002:a5d:5888:0:b0:390:d6ab:6c49 with SMTP id ffacd0b85a97d-39973af6c01mr5514695f8f.35.1742407110352;
        Wed, 19 Mar 2025 10:58:30 -0700 (PDT)
Received: from f.. (cst-prg-67-174.cust.vodafone.cz. [46.135.67.174])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb7e9f8asm21462414f8f.81.2025.03.19.10.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 10:58:29 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: oleg@redhat.com
Cc: akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] exit: combine work under lock in synchronize_group_exit() and coredump_task_exit()
Date: Wed, 19 Mar 2025 18:58:24 +0100
Message-ID: <20250319175824.1852420-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reduces single-threaded overhead as it avoids one lock+irq trip on
exit.

It also improves scalability of spawning and killing threads within one
process (just shy of 5% when doing it on 24 cores on my test jig).

This happens to test to for coredumping prior to handling kcov and
kmsan, which afaics is harmless.

I however was not comfortable lifting dumping prior to it, so it still
happens after.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 kernel/exit.c | 67 +++++++++++++++++++++++++++++----------------------
 1 file changed, 38 insertions(+), 29 deletions(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index f97a2bbc9db9..f799c32dd8f5 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -412,9 +412,9 @@ kill_orphaned_pgrp(struct task_struct *tsk, struct task_struct *parent)
 	}
 }
 
-static void coredump_task_exit(struct task_struct *tsk)
+static struct core_state *coredump_task_exit_prep(struct task_struct *tsk)
 {
-	struct core_state *core_state;
+	lockdep_assert_held(&tsk->sighand->siglock);
 
 	/*
 	 * Serialize with any possible pending coredump.
@@ -423,33 +423,37 @@ static void coredump_task_exit(struct task_struct *tsk)
 	 * will increment ->nr_threads for each thread in the
 	 * group without PF_POSTCOREDUMP set.
 	 */
-	spin_lock_irq(&tsk->sighand->siglock);
 	tsk->flags |= PF_POSTCOREDUMP;
-	core_state = tsk->signal->core_state;
-	spin_unlock_irq(&tsk->sighand->siglock);
-	if (core_state) {
-		struct core_thread self;
-
-		self.task = current;
-		if (self.task->flags & PF_SIGNALED)
-			self.next = xchg(&core_state->dumper.next, &self);
-		else
-			self.task = NULL;
-		/*
-		 * Implies mb(), the result of xchg() must be visible
-		 * to core_state->dumper.
-		 */
-		if (atomic_dec_and_test(&core_state->nr_threads))
-			complete(&core_state->startup);
+	return tsk->signal->core_state;
+}
 
-		for (;;) {
-			set_current_state(TASK_IDLE|TASK_FREEZABLE);
-			if (!self.task) /* see coredump_finish() */
-				break;
-			schedule();
-		}
-		__set_current_state(TASK_RUNNING);
+static void coredump_task_exit_finish(struct task_struct *tsk,
+				      struct core_state *core_state)
+{
+	struct core_thread self;
+
+	if (likely(!core_state))
+		return;
+
+	self.task = current;
+	if (self.task->flags & PF_SIGNALED)
+		self.next = xchg(&core_state->dumper.next, &self);
+	else
+		self.task = NULL;
+	/*
+	 * Implies mb(), the result of xchg() must be visible
+	 * to core_state->dumper.
+	 */
+	if (atomic_dec_and_test(&core_state->nr_threads))
+		complete(&core_state->startup);
+
+	for (;;) {
+		set_current_state(TASK_IDLE|TASK_FREEZABLE);
+		if (!self.task) /* see coredump_finish() */
+			break;
+		schedule();
 	}
+	__set_current_state(TASK_RUNNING);
 }
 
 #ifdef CONFIG_MEMCG
@@ -878,7 +882,8 @@ static void synchronize_group_exit(struct task_struct *tsk, long code)
 	struct sighand_struct *sighand = tsk->sighand;
 	struct signal_struct *signal = tsk->signal;
 
-	spin_lock_irq(&sighand->siglock);
+	lockdep_assert_held(&sighand->siglock);
+
 	signal->quick_threads--;
 	if ((signal->quick_threads == 0) &&
 	    !(signal->flags & SIGNAL_GROUP_EXIT)) {
@@ -886,24 +891,28 @@ static void synchronize_group_exit(struct task_struct *tsk, long code)
 		signal->group_exit_code = code;
 		signal->group_stop_count = 0;
 	}
-	spin_unlock_irq(&sighand->siglock);
 }
 
 void __noreturn do_exit(long code)
 {
 	struct task_struct *tsk = current;
+	struct sighand_struct *sighand = tsk->sighand;
+	struct core_state *core_state;
 	int group_dead;
 
 	WARN_ON(irqs_disabled());
 
+	spin_lock_irq(&sighand->siglock);
 	synchronize_group_exit(tsk, code);
+	core_state = coredump_task_exit_prep(tsk);
+	spin_unlock_irq(&sighand->siglock);
 
 	WARN_ON(tsk->plug);
 
 	kcov_task_exit(tsk);
 	kmsan_task_exit(tsk);
 
-	coredump_task_exit(tsk);
+	coredump_task_exit_finish(tsk, core_state);
 	ptrace_event(PTRACE_EVENT_EXIT, code);
 	user_events_exit(tsk);
 
-- 
2.43.0


