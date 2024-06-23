Return-Path: <linux-kernel+bounces-225905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C23913741
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 03:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A564DB2286E
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 01:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6997AD52A;
	Sun, 23 Jun 2024 01:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PqFRTZAh"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13683944D
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 01:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719107467; cv=none; b=RSPSqm2Yo7tsdq3dnHFf6TafsDKV9zUE0AmIcP+Bk8eQbl87LZcHe235QBMG6fwOMmIhluQoWSUPrc/IF0VHVTQhj5i25egfQy+JdqR+WvEOBeqYhQWeF3tcKzAjQjVq5rlqB3iT7GQ8emcpZV58ZAjt4KYwNsnU0APEUs4jUzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719107467; c=relaxed/simple;
	bh=x7HL8cJSTUbYMUKXamGafgosuhFnOh0LAFk+ZTMsd+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d+cZcvgKufDygopY96IO38EIFiAN09GnpI7EAu75ZifBGAp3FkSSDtmqVIv7f3hAah6QJpMr0mfI2Wb3xg9e+IRvTEOZMNdG0+ttpqqHPnJytS50B8hc7+SaaDaWCc3VyVbiN+NEOfQ0fSUWzGUsgDs6aoN8YqjQP7mRSAxXbhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PqFRTZAh; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3c9cc681ee4so1639549b6e.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 18:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719107465; x=1719712265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VPnJvNYLijffj00Ei/kDfGHxOVPdCBS9uzp5HEpr8vA=;
        b=PqFRTZAhcNqZRqPSo1sTuFq0wXFle93Oxym8evMpmDj8OroxFFJvBcEugp8rr+GGbR
         yzgFkxNyGPxEKx9Gl1Ro8gPxq/KXvIamw0E/AP3Iy2TLvQ7H+dKvm2OTsdYbg4L6bPgt
         ypQgKyMdJfy5OfVn45cCEalJ2ieo7yb8qGrRo5flbSrSglI73BGblQbI9uRSTOHHYaC1
         y8bWnOjAJQVownZJirQSb41BxMQBMvp75BRuXpSqdXaLviFxz6rnGhfRwInVTXqyOtA/
         I16e8MVX5Jokg41cOAr33ufdhmBuMPHT/Cj6BufL3WE9LTKIOGyBxuqziKtcrLpkitOb
         F/4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719107465; x=1719712265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VPnJvNYLijffj00Ei/kDfGHxOVPdCBS9uzp5HEpr8vA=;
        b=QKEqnhPMyLRmIzsJCM7CqDL7qnpJaWooPgR95TogmouWSqd7UXDXLnajQXyX759DCd
         j3K978bT0J+BNd+z4dGM/oLOiqt87qevF26Ca5GjiMMSotWXSPc/P7YcKGVdUX2yzt54
         VCfODUNLiTeamQqRr1JQcTmlGe4tshPHL3vcTYW6riDYz4BvuNWWgknwMAOUTga19TuJ
         Ik4oKBf5UwdvZ/85W32L+uUBEsuA7LLDNJL3tjebsF1c0Tf9Lntl8hGlP5iNBf37Sjl0
         Fis0+7nRMf+tV3xUxS9EY0+IOzgr+v9rp6khP7E5f0oTEZ/I/5WipE3BM7thTAtysWZb
         2jjA==
X-Forwarded-Encrypted: i=1; AJvYcCVdN1py6vkeoaIf0VFPwYbMkhk5LIjAtREIgfMQKnQQANb6VQCfsgJCtnoa7CFe9OxvgrJZIWZ4Glr/uRRarfhj8/JSuKP5/ceX9mpd
X-Gm-Message-State: AOJu0YwFJ8EY2Dz+uatBaMKMWlXSWelBmDJsfylZw+lSnRiMR8NNia2L
	oOAVOv9Ftu7RvZHrNzhdCmrI5uL+GGOvk2LmGliMVkIZMe7Rs5T4
X-Google-Smtp-Source: AGHT+IHZ6ncZTnxIBg031bv8no+Fb85Vo3jpcBGbtdBpnV23i/D1fHmVNZqSmbj+jWwVGgK1NANFug==
X-Received: by 2002:a05:6808:1789:b0:3d2:21d7:4b41 with SMTP id 5614622812f47-3d5459679eamr1459631b6e.18.1719107464941;
        Sat, 22 Jun 2024 18:51:04 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-706512fac0esm3693591b3a.201.2024.06.22.18.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jun 2024 18:51:04 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: torvalds@linux-foundation.org
Cc: void@manifault.com,
	mingo@redhat.com,
	peterz@infradead.org,
	tglx@linutronix.de,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/3] sched, sched_ext: Open code for_balance_class_range()
Date: Sat, 22 Jun 2024 15:50:21 -1000
Message-ID: <20240623015057.3383223-3-tj@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240623015057.3383223-1-tj@kernel.org>
References: <20240623015057.3383223-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For flexibility, sched_ext allows the BPF scheduler to select the CPU to
execute a task on at dispatch time so that e.g. a queue can be shared across
multiple CPUs. To enable this, the dispatch path is executed from balance()
so that a dispatched task can be hot-migrated to its target CPU. This means
that sched_ext needs its balance() method invoked before every
pick_next_task() even when the CPU is waking up from SCHED_IDLE.

for_balance_class_range() defined in kernel/sched/ext.h implements this
selective iteration promotion. However, the indirection obfuscates more than
helps. Open code the iteration promotion in put_prev_task_balance() and
remove for_balance_class_range().

No functional changes intended.

Signed-off-by: Tejun Heo <tj@kernel.org>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Vernet <void@manifault.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/sched/core.c | 14 +++++++++++++-
 kernel/sched/ext.h  |  9 ---------
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1092955a7d6e..827e0dc78ea0 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5834,7 +5834,19 @@ static void put_prev_task_balance(struct rq *rq, struct task_struct *prev,
 				  struct rq_flags *rf)
 {
 #ifdef CONFIG_SMP
+	const struct sched_class *start_class = prev->sched_class;
 	const struct sched_class *class;
+
+#ifdef CONFIG_SCHED_CLASS_EXT
+	/*
+	 * SCX requires a balance() call before every pick_next_task() including
+	 * when waking up from SCHED_IDLE. If @start_class is below SCX, start
+	 * from SCX instead.
+	 */
+	if (sched_class_above(&ext_sched_class, start_class))
+		start_class = &ext_sched_class;
+#endif
+
 	/*
 	 * We must do the balancing pass before put_prev_task(), such
 	 * that when we release the rq->lock the task is in the same
@@ -5843,7 +5855,7 @@ static void put_prev_task_balance(struct rq *rq, struct task_struct *prev,
 	 * We can terminate the balance pass as soon as we know there is
 	 * a runnable task of @class priority or higher.
 	 */
-	for_balance_class_range(class, prev->sched_class, &idle_sched_class) {
+	for_active_class_range(class, start_class, &idle_sched_class) {
 		if (class->balance(rq, prev, rf))
 			break;
 	}
diff --git a/kernel/sched/ext.h b/kernel/sched/ext.h
index 229007693504..1d7837bdfaba 100644
--- a/kernel/sched/ext.h
+++ b/kernel/sched/ext.h
@@ -68,14 +68,6 @@ static inline const struct sched_class *next_active_class(const struct sched_cla
 #define for_each_active_class(class)						\
 	for_active_class_range(class, __sched_class_highest, __sched_class_lowest)
 
-/*
- * SCX requires a balance() call before every pick_next_task() call including
- * when waking up from idle.
- */
-#define for_balance_class_range(class, prev_class, end_class)			\
-	for_active_class_range(class, (prev_class) > &ext_sched_class ?		\
-			       &ext_sched_class : (prev_class), (end_class))
-
 #ifdef CONFIG_SCHED_CORE
 bool scx_prio_less(const struct task_struct *a, const struct task_struct *b,
 		   bool in_fi);
@@ -100,7 +92,6 @@ static inline bool task_on_scx(const struct task_struct *p) { return false; }
 static inline void init_sched_ext_class(void) {}
 
 #define for_each_active_class		for_each_class
-#define for_balance_class_range		for_class_range
 
 #endif	/* CONFIG_SCHED_CLASS_EXT */
 
-- 
2.45.2


