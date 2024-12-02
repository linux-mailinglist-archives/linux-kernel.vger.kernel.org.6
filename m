Return-Path: <linux-kernel+bounces-426788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F74E9DF85D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 02:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B57E3B212A7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 01:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495B1179BD;
	Mon,  2 Dec 2024 01:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FaNnFlde"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CB2134AB
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 01:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733102473; cv=none; b=WwH7olOtusTTaeYxpMOZCQaHimVQX3MFfdBuJtjPW+1J/Z4Ac+FugpxNBa7PgyFhxp8Q+240eNdr1nZUMEyBoCh/L/StxJA18B1pri5NTVlGVjLf8aeu0nBDZuu+0wjYW+EmSV9whf4XdWe7RoMu8iVFfGNf3P+oxgDoY5X59kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733102473; c=relaxed/simple;
	bh=/wZTI3UiahNixfklRx/WvDzLUzuChm2QRLE3nAmDEhw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=goD04ApVO9vgCKjRGW043Rlzx8f9Kk4f+YJ3hFODxHD2nq94m1ZsU+f99WxcM+aS9gU9sZa6JgMsancdJd5WiK1SBvDHMN7R86W2wR9Bc9sUApxUEq2D1SB+TeqsahyETLLkxZgRXJGp8Z+yvB7+sRhG0hqUO/Msc/mWbM6VqDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FaNnFlde; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7fbc29b3145so3275585a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2024 17:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733102471; x=1733707271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lypOr0RHny0xPV7z1/09rSMaYkYRgv7f2VuEbcmtql4=;
        b=FaNnFlde0ibaO/keFRaZzNYGZ10QISCx/xTHNUAIDQt12SAFEKNHHmxeLuqi2jBRR1
         KHHg7GeO6UOz0GO4MKUKF0ZKIeBubXvTKnuBdW/zxDFh3gS/QoH7jliZVnpCwZx0qoqI
         yF/XuxwLVI1Zgp//FVrSgnrklBSQptp7A+LcDqlYWZdiwcQbzzrOKA0vx94CU5GYUNyN
         kNSNTUFvyE9paCx9a/7qXG4cZWHzvIgv64rCW1xUsZ43oe1+OQdPYlSIdHgRd9Z6xDpA
         6ANG9lca7gDY4bTJlm21KsMFJc3JOhlWV9TDFquKeUvOt4kznj1f11wb527PNtAhAfBB
         8WyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733102471; x=1733707271;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lypOr0RHny0xPV7z1/09rSMaYkYRgv7f2VuEbcmtql4=;
        b=nuE/mhMveiFr6SkEvagO+bbbd44NbZacC9RHdp2AThKMqLaDmXtN1MbL+A9L7HOJgo
         24EXq2G32MkS9cgzcm7yOHq5bP+pfcIgd7Rn+hROy7pr40BslLIdZ8QrlAaazQ30OAw+
         fRwSO4nooEU+yzxWDwnt67VX/km3KHanrlJiSTE1tKdt30e7Qlc08hD0a4x5/5u9vkM6
         C8g8tPW+5qHepRmJL8/hWvOI5WQbFr5VyO2MytpNxvYpYe9oqo8IvxhFQ4Sih3snM0YZ
         f1CPE/bzkgvnUbc/Z0M59feylaX8dHDaan2KNz561uh9GwF7+Kva8JFJMwLJarq0O1XG
         JXWw==
X-Gm-Message-State: AOJu0Yw/C2QNYpQNmIM+R0G+gyG101K0b+mgE7+N7OZjaqeVm3kJQKhl
	0JKWO++3U8jmtsgPOcGF07f0YdSukXwlBP0jU+d0znO2K946nJl+
X-Gm-Gg: ASbGncvkQ3SPLTLQpGWdy+D/+2DhPkFN4LBTj1S413eZWxWI1NwNpER9k7Zi3Rpv/ZI
	SXce3loPMOS4trm1VxT8wUA7MKwMopHd0WZhl3Ir7E8CQDfSGZDrNq4fOs4dujrheZ2wGfpWsNi
	jkQtAydsm5DP2OlXdNogrsJDzf50kM3phfwV1QOQQE6/H2lr1PtMNNipEhulUT3bih85c9AQGpq
	FtS0rTeJiT68JO0L1lsGnrheSvb6AWKIKbdC43Nlhnc7suagwNQT8309uSV0eiPWUx4cPk1D/MJ
	XzcQTMAx0k5fES5BZsPk
X-Google-Smtp-Source: AGHT+IEi0VPrm1wGAXpYwSHtca8YBzh0DEi/Zh1m3Q7ntEwm+BoWtWGwA9rCV5n5tIdW1z/j+dV1QQ==
X-Received: by 2002:a05:6a20:734b:b0:1e0:c713:9a92 with SMTP id adf61e73a8af0-1e0ec7fcc77mr29014881637.6.1733102471341;
        Sun, 01 Dec 2024 17:21:11 -0800 (PST)
Received: from DESKTOP-NBGHJ1C.local.valinux.co.jp (vagw.valinux.co.jp. [210.128.90.14])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fc9c305637sm6632872a12.32.2024.12.01.17.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2024 17:21:11 -0800 (PST)
From: Ryo Takakura <ryotkkr98@gmail.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	will@kernel.org,
	longman@redhat.com,
	boqun.feng@gmail.com,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	rostedt@goodmis.org,
	tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Ryo Takakura <ryotkkr98@gmail.com>
Subject: [PATCH] lockdep: Fix wait context check on softirq for PREEMPT_RT
Date: Mon,  2 Dec 2024 10:20:17 +0900
Message-Id: <20241202012017.14910-1-ryotkkr98@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 0c1d7a2c2d32 ("lockdep: Remove softirq accounting on
PREEMPT_RT.") stopped updating @softirq_context on PREEMPT_RT
to ignore "inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage"
as the report accounts softirq context which PREEMPT_RT doesn't
have to.

However, wait context check still needs to report mutex usage
within softirq, even when its threaded on PREEMPT_RT. The check
is failing to report the usage as task_wait_context() checks if
its in softirq by referencing @softirq_context, ending up not 
assigning the correct wait type of LD_WAIT_CONFIG for PREEMPT_RT's
softirq.

[    0.184549]   | wait context tests |
[    0.184549]   --------------------------------------------------------------------------
[    0.184549]                                  | rcu  | raw  | spin |mutex |
[    0.184549]   --------------------------------------------------------------------------
[    0.184550]                in hardirq context:  ok  |  ok  |  ok  |  ok  |
[    0.185083] in hardirq context (not threaded):  ok  |  ok  |  ok  |  ok  |
[    0.185606]                in softirq context:  ok  |  ok  |  ok  |FAILED|

Account softirq context but only when !PREEMPT_RT so that
task_wait_context() returns LD_WAIT_CONFIG as intended.

Signed-off-by: Ryo Takakura <ryotkkr98@gmail.com>


---

Hi! 

I wasn't able come up with a way to fix the wait context test while 
keeping the commit 0c1d7a2c2d32 ("lockdep: Remove softirq accounting 
on PREEMPT_RT.") without referencing @softirq_context...
Hoping to get a feedback on it!

Also I wonder if the test can be skipped as I believe its taken care 
by spinlock wait context test since the PREEMPT_RT's softirq context is 
protected by local_lock which is mapped to rt_spinlock.

Thanks!
Ryo Takakura

---
 include/linux/irqflags.h |  2 +-
 kernel/locking/lockdep.c | 11 +++++++----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index 3f003d5fd..c33c3bbd8 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -121,7 +121,7 @@ do {						\
 # define lockdep_irq_work_exit(__work)		do { } while (0)
 #endif
 
-#if defined(CONFIG_TRACE_IRQFLAGS) && !defined(CONFIG_PREEMPT_RT)
+#if defined(CONFIG_TRACE_IRQFLAGS)
 # define lockdep_softirq_enter()		\
 do {						\
 	current->softirq_context++;		\
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 536bd4715..2a508d6a6 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -4602,7 +4602,7 @@ mark_usage(struct task_struct *curr, struct held_lock *hlock, int check)
 				if (!mark_lock(curr, hlock,
 						LOCK_USED_IN_HARDIRQ_READ))
 					return 0;
-			if (curr->softirq_context)
+			if (!IS_ENABLED(CONFIG_PREEMPT_RT) && curr->softirq_context)
 				if (!mark_lock(curr, hlock,
 						LOCK_USED_IN_SOFTIRQ_READ))
 					return 0;
@@ -4610,7 +4610,7 @@ mark_usage(struct task_struct *curr, struct held_lock *hlock, int check)
 			if (lockdep_hardirq_context())
 				if (!mark_lock(curr, hlock, LOCK_USED_IN_HARDIRQ))
 					return 0;
-			if (curr->softirq_context)
+			if (!IS_ENABLED(CONFIG_PREEMPT_RT) && curr->softirq_context)
 				if (!mark_lock(curr, hlock, LOCK_USED_IN_SOFTIRQ))
 					return 0;
 		}
@@ -4651,8 +4651,11 @@ mark_usage(struct task_struct *curr, struct held_lock *hlock, int check)
 
 static inline unsigned int task_irq_context(struct task_struct *task)
 {
-	return LOCK_CHAIN_HARDIRQ_CONTEXT * !!lockdep_hardirq_context() +
-	       LOCK_CHAIN_SOFTIRQ_CONTEXT * !!task->softirq_context;
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		return LOCK_CHAIN_HARDIRQ_CONTEXT * !!lockdep_hardirq_context();
+	else
+		return LOCK_CHAIN_HARDIRQ_CONTEXT * !!lockdep_hardirq_context() +
+		       LOCK_CHAIN_SOFTIRQ_CONTEXT * !!task->softirq_context;
 }
 
 static int separate_irq_context(struct task_struct *curr,
-- 
2.34.1


