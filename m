Return-Path: <linux-kernel+bounces-568731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B60A699D5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 20:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BCB93AD3A9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 19:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16CB92147EE;
	Wed, 19 Mar 2025 19:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HaH5QhT/"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACAA2101B3
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 19:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742414088; cv=none; b=onTRI+zSk7m5hF5BPqKN6HYTWNOpyySE0IRnQXu/azeeYm4jGwto2Abaosy1DvTRzAVfLHY3nDMnLlUaBRQqv/U3kujI9qhUOD7iKD9SSwNH/c1kF5tjI5j2vwAUxT1dmmiBEToSzrNaGRCkEEZLtxgNv3LnYqdTOLwEYa/TNbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742414088; c=relaxed/simple;
	bh=hvQLp4vH3VRmlxezPJqJoH19plWd6V+0cp6bjaB2y2I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YGA/sS8k5122yRmzUlh4hWJb5e1pn+xcByHvptp6Jl/O4GwEuJFpa9V0KQnNJMZGMTkc9pcy+5grtIIaZN2jmTqWPCUuWPAWcJLr8UNSZtzxam98zWZoqVyV58n0DKuXpkVKDb0OBGtvsoM1fjHfNdwNy1s2baz4RAgvTW5eTRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HaH5QhT/; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3913d129c1aso36659f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 12:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742414085; x=1743018885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cSPboHbps1j0M0K4BKk0SdZ3qnhfbcGDay6p4Hmotbc=;
        b=HaH5QhT/AGghym5DmdN4vIaXZhY5e0DaHk+4e3Vn84uuUyvNhY8LbvPoTnzgH33dAv
         mI8PZmtQTHzeovRRefLxmy9wPyksyAe6sh5CMwuhNm5tA1EeuK17e3AXLe9NHQ8oZ6DV
         gpniIbtwgoyKe7y/J03klCdksPXHTvDVgwf0NuEDX/trBNAf/JGjF/2ba27Zd8r+yr3U
         xvxoi+FbJdJDknhU9i3hEYD1mojYzro7EiHm33TbgPBCs6GMurUhqyLuY6C5Dv13raqA
         YCH/fENYlDPqWdON6nCpzzOsc1MRIxTX2Y5Vz5fdshKKaOOoxKui2L/FCw0JwOc+mUUq
         YiPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742414085; x=1743018885;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cSPboHbps1j0M0K4BKk0SdZ3qnhfbcGDay6p4Hmotbc=;
        b=spsU5Yuzk7y+15Lhr14lnitNY793YLqrIbvrWGHWd0jcWnl63xGkFjAXfYpHBF9V/x
         4OfUtkzXo/bi8VMAVM0EnTHLQ6Bf37g4yU8NDI5pinXdn4DKjTjNByRclsHv2my8b2Qf
         8CashBb9d9ZYU8iyzCsjgcrGucXgd5QpeGBvcSJV34kCFMKG+SDaVMah/Dns4rgCyJdf
         H4iVM/vshcHF/Ty5PP19hjHO0Jq843yrC8SPFsRKriHtf/TD9q6hi6hnNEC+ihKtqihw
         hu+ZYvDduhtLJKYnqEc2jYHn5bdYU3eVRiLuAXf5Rsl7HBpDh3gFphD4p3WuR7XabDiW
         q08g==
X-Forwarded-Encrypted: i=1; AJvYcCWSbYku6pZ16EfYhs4NVf3JajlbXA2vf8Jq1ZohRLVgQn1zxHKJYxZpMrfx0dx3SpSdeNPv1P9yfksQ1rI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAS4SdL2dq/xvre77Dg7dYh5AAFDKxCFENdNPYQtwcy8HwP4ca
	QZEDkDcK1kysK90kqxFYelN7jGxbLUyov1h+wPrvWYSKQDGz7UR+
X-Gm-Gg: ASbGncsNJfQusOT62nZ4FQug675l7f4AjlvryPrGs3UQhI0NfAxWJ6CkRyTz115O/Z7
	IxC1B0WBMFjb1L0CSLAb2kr+thg0NIrLvlIXyH2dOv9uq17zrrkKn8CFs/UTSjMi1GIfy8CrSS2
	HBFd3u5KwW9mqKJ1LMjt8N+pLUebTV1Ubce/Yu8GgSSS2oU6MvGLC6nr/tlZKpUfaUJ8yRfNpsw
	CeulBneeMEKT/4NOUmlIdc72OvV5eYImFCS1PVdj6lQ77+LqLyiALe4f7uypmzajKcEjyLODKro
	WeGjudGaoVASRu2BKaYm6RyCNVcaF/Fbp7TK+4+eDiZDGmFBRU0VFy3ZBtfHfBQ=
X-Google-Smtp-Source: AGHT+IFUdaoPLx6hsKQHtwD3DXumt/eUq+mQvyKCfoqizp/Jzvfk88mOXM7KFRcJyJEGNwDBuRdFFg==
X-Received: by 2002:a5d:598b:0:b0:38d:df15:2770 with SMTP id ffacd0b85a97d-3997951c089mr790310f8f.0.1742414084610;
        Wed, 19 Mar 2025 12:54:44 -0700 (PDT)
Received: from f.. (cst-prg-67-174.cust.vodafone.cz. [46.135.67.174])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb40cdd0sm21882420f8f.77.2025.03.19.12.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 12:54:43 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: oleg@redhat.com
Cc: akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v3] exit: combine work under lock in synchronize_group_exit() and coredump_task_exit()
Date: Wed, 19 Mar 2025 20:54:36 +0100
Message-ID: <20250319195436.1864415-1-mjguzik@gmail.com>
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

Both routines are moved below kcov and kmsan exit, which should be
harmless.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

v3:
- move coredump_task_exit into synchronize_group_exit

v2:
- push the routines after kcov and kmsan

 kernel/exit.c | 68 ++++++++++++++++++++++++---------------------------
 1 file changed, 32 insertions(+), 36 deletions(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index f97a2bbc9db9..5ffa56bcd659 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -412,44 +412,30 @@ kill_orphaned_pgrp(struct task_struct *tsk, struct task_struct *parent)
 	}
 }
 
-static void coredump_task_exit(struct task_struct *tsk)
+static void coredump_task_exit(struct task_struct *tsk,
+			       struct core_state *core_state)
 {
-	struct core_state *core_state;
+	struct core_thread self;
 
+	self.task = tsk;
+	if (self.task->flags & PF_SIGNALED)
+		self.next = xchg(&core_state->dumper.next, &self);
+	else
+		self.task = NULL;
 	/*
-	 * Serialize with any possible pending coredump.
-	 * We must hold siglock around checking core_state
-	 * and setting PF_POSTCOREDUMP.  The core-inducing thread
-	 * will increment ->nr_threads for each thread in the
-	 * group without PF_POSTCOREDUMP set.
+	 * Implies mb(), the result of xchg() must be visible
+	 * to core_state->dumper.
 	 */
-	spin_lock_irq(&tsk->sighand->siglock);
-	tsk->flags |= PF_POSTCOREDUMP;
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
+	if (atomic_dec_and_test(&core_state->nr_threads))
+		complete(&core_state->startup);
 
-		for (;;) {
-			set_current_state(TASK_IDLE|TASK_FREEZABLE);
-			if (!self.task) /* see coredump_finish() */
-				break;
-			schedule();
-		}
-		__set_current_state(TASK_RUNNING);
+	for (;;) {
+		set_current_state(TASK_IDLE|TASK_FREEZABLE);
+		if (!self.task) /* see coredump_finish() */
+			break;
+		schedule();
 	}
+	__set_current_state(TASK_RUNNING);
 }
 
 #ifdef CONFIG_MEMCG
@@ -877,6 +863,7 @@ static void synchronize_group_exit(struct task_struct *tsk, long code)
 {
 	struct sighand_struct *sighand = tsk->sighand;
 	struct signal_struct *signal = tsk->signal;
+	struct core_state *core_state;
 
 	spin_lock_irq(&sighand->siglock);
 	signal->quick_threads--;
@@ -886,7 +873,19 @@ static void synchronize_group_exit(struct task_struct *tsk, long code)
 		signal->group_exit_code = code;
 		signal->group_stop_count = 0;
 	}
+	/*
+	 * Serialize with any possible pending coredump.
+	 * We must hold siglock around checking core_state
+	 * and setting PF_POSTCOREDUMP.  The core-inducing thread
+	 * will increment ->nr_threads for each thread in the
+	 * group without PF_POSTCOREDUMP set.
+	 */
+	tsk->flags |= PF_POSTCOREDUMP;
+	core_state = signal->core_state;
 	spin_unlock_irq(&sighand->siglock);
+
+	if (unlikely(core_state))
+		coredump_task_exit(tsk, core_state);
 }
 
 void __noreturn do_exit(long code)
@@ -895,15 +894,12 @@ void __noreturn do_exit(long code)
 	int group_dead;
 
 	WARN_ON(irqs_disabled());
-
-	synchronize_group_exit(tsk, code);
-
 	WARN_ON(tsk->plug);
 
 	kcov_task_exit(tsk);
 	kmsan_task_exit(tsk);
 
-	coredump_task_exit(tsk);
+	synchronize_group_exit(tsk, code);
 	ptrace_event(PTRACE_EVENT_EXIT, code);
 	user_events_exit(tsk);
 
-- 
2.43.0


