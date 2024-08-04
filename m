Return-Path: <linux-kernel+bounces-273664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3C3946BF7
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 04:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B8B31F21B4E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 02:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9402E14A84;
	Sun,  4 Aug 2024 02:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="beh+zyEq"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B814101E2
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 02:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722739260; cv=none; b=cMhEbKx+O2sBcesR+uaoYb2SRub+2sfNskH+6GHAfYKgaUebOp+8RFj7WO/Kaen5hu1CgPp3bjht1rdP9R1PENJ06wNFyzNgBGgd1QUaNC2GdRBRitSqzlYdOmaHWpdoHxXKdJ3jdX4juopdbRwGxhOyDiscWedQycRqb3PjbP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722739260; c=relaxed/simple;
	bh=80qQVctv7zmET2XoTt9MNxu/D0vluHnE5nU8q8MFPEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a6YmtsB39vkGmH6taS1L8iSIsJbieYFmgu+ih7PphqvtUTIVcAMyrR5JpGMgGBPjZTvP7tsaNJHTCYRDglSZPr4vrikPQBTL7+gvZxse+G2gX1knF66FPawh9DtXiyCAA77wIqVNgYUmq6ndpJEW/JGdO2zGMTpsQymznWBHBYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=beh+zyEq; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-70eb73a9f14so7060135b3a.2
        for <linux-kernel@vger.kernel.org>; Sat, 03 Aug 2024 19:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722739258; x=1723344058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dtNvNdju3jDNauXo8zWSGcAEEUbLeOZe/FSo2A9yads=;
        b=beh+zyEqC+Ebw/2Qt2l72Hm87pcj5ICpr1bQKQl95AVCz8hYeRgH6rmpmLQm+QBH8I
         rZKv7RsiDfUSM6FA4ZNPLMbAwWM/W0oGAEh8JV684YhwHntqBxuhfY9IpbxvTcx6TVDj
         veh6vXDoqwXMn+4QJiUIlQsT9zWH8TOiLd3mHNPw+g4jipb+wBmMQosS4Z3CJKbahO1o
         nmxrYViRbAVKD+SGJJAdENv8ZwxoLyZgpJIJ/Prl9NjzHQmoRnX7u0pO9zPOA0Cxhm4U
         Ayvr2RoZZ56CIDslmTisx2yT4xM/c8j7Yqb/kh7rgdTZfYjeqTqhgYwysUQL1CGap0iW
         0zyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722739258; x=1723344058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dtNvNdju3jDNauXo8zWSGcAEEUbLeOZe/FSo2A9yads=;
        b=ZDkrstHMYN79qwHgb6T61HH1/AG8SzgjCY7KYMGuaWSt4F3mQw1miIhLg1Y1ZVB8pS
         oO7tRCEJOv5FSsBrOE/2FCDWL+bb+WRIuuMrO/VHMJkhGvq51b1BjwnUz53zkJb36J4Q
         mSynuqF/pDvhAjb4ph9MSI5OHjhbWgXneQIXpaCGRMQcf2Mvgc16AWjN7GClQob/o0J6
         pXl7CVb64llhLt6HkJrW2wwePCQBLYgBnQr2tkBTmUjROuvEReCuunSCiHa2n3Qt3wbt
         tA6BoxUSnLo2XdDGU387Z1UcTph1W4krfuv6fLIfdh7sy/iDVIBYLoG4D/Z2j2bdnXFJ
         O4DQ==
X-Gm-Message-State: AOJu0Yw38rMNoCHdMIKehxEekwcAdTERrBKZ9IA4QNBVoRnTWu8Ko56u
	nanSsQrCidFPoS/XMPPn0Y9XUHckDMzixTTdSyXHMog9dMIxekcw
X-Google-Smtp-Source: AGHT+IG4C3G+ppMKPbBycqpNaFdx33YADfKl8G8k6vXkYiTOvAPseo2A9RYZN0giWOV9PGNSVeREtw==
X-Received: by 2002:a05:6a20:729c:b0:1be:c5d9:5a19 with SMTP id adf61e73a8af0-1c6995c9d4fmr12884178637.24.1722739258474;
        Sat, 03 Aug 2024 19:40:58 -0700 (PDT)
Received: from localhost (dhcp-72-235-129-167.hawaiiantel.net. [72.235.129.167])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ec021a1sm3330799b3a.20.2024.08.03.19.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Aug 2024 19:40:58 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	peterz@infradead.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	mingo@redhat.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 4/6] sched_ext: Simplify UP support by enabling sched_class->balance() in UP
Date: Sat,  3 Aug 2024 16:40:11 -1000
Message-ID: <20240804024047.100355-5-tj@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240804024047.100355-1-tj@kernel.org>
References: <20240804024047.100355-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On SMP, SCX performs dispatch from sched_class->balance(). As balance() was
not available in UP, it instead called the internal balance function from
put_prev_task_scx() and pick_next_task_scx() to emulate the effect, which is
rather nasty.

Enabling sched_class->balance() on UP shouldn't cause any meaningful
overhead. Enable balance() on UP and drop the ugly workaround.

Signed-off-by: Tejun Heo <tj@kernel.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
---
 kernel/sched/core.c  |  4 +---
 kernel/sched/ext.c   | 41 +----------------------------------------
 kernel/sched/sched.h |  2 +-
 3 files changed, 3 insertions(+), 44 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0532b27fd9af..d2ccc2c4b4d3 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5826,7 +5826,6 @@ static inline void schedule_debug(struct task_struct *prev, bool preempt)
 static void put_prev_task_balance(struct rq *rq, struct task_struct *prev,
 				  struct rq_flags *rf)
 {
-#ifdef CONFIG_SMP
 	const struct sched_class *start_class = prev->sched_class;
 	const struct sched_class *class;
 
@@ -5849,10 +5848,9 @@ static void put_prev_task_balance(struct rq *rq, struct task_struct *prev,
 	 * a runnable task of @class priority or higher.
 	 */
 	for_active_class_range(class, start_class, &idle_sched_class) {
-		if (class->balance(rq, prev, rf))
+		if (class->balance && class->balance(rq, prev, rf))
 			break;
 	}
-#endif
 
 	put_prev_task(rq, prev);
 }
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 48f8f57f5954..09f394bb4889 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2616,7 +2616,6 @@ static int balance_one(struct rq *rq, struct task_struct *prev, bool local)
 	return has_tasks;
 }
 
-#ifdef CONFIG_SMP
 static int balance_scx(struct rq *rq, struct task_struct *prev,
 		       struct rq_flags *rf)
 {
@@ -2650,7 +2649,6 @@ static int balance_scx(struct rq *rq, struct task_struct *prev,
 
 	return ret;
 }
-#endif
 
 static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 {
@@ -2719,37 +2717,6 @@ static void process_ddsp_deferred_locals(struct rq *rq)
 
 static void put_prev_task_scx(struct rq *rq, struct task_struct *p)
 {
-#ifndef CONFIG_SMP
-	/*
-	 * UP workaround.
-	 *
-	 * Because SCX may transfer tasks across CPUs during dispatch, dispatch
-	 * is performed from its balance operation which isn't called in UP.
-	 * Let's work around by calling it from the operations which come right
-	 * after.
-	 *
-	 * 1. If the prev task is on SCX, pick_next_task() calls
-	 *    .put_prev_task() right after. As .put_prev_task() is also called
-	 *    from other places, we need to distinguish the calls which can be
-	 *    done by looking at the previous task's state - if still queued or
-	 *    dequeued with %SCX_DEQ_SLEEP, the caller must be pick_next_task().
-	 *    This case is handled here.
-	 *
-	 * 2. If the prev task is not on SCX, the first following call into SCX
-	 *    will be .pick_next_task(), which is covered by calling
-	 *    balance_scx() from pick_next_task_scx().
-	 *
-	 * Note that we can't merge the first case into the second as
-	 * balance_scx() must be called before the previous SCX task goes
-	 * through put_prev_task_scx().
-	 *
-         * @rq is pinned and can't be unlocked. As UP doesn't transfer tasks
-         * around, balance_one() doesn't need to.
-	 */
-	if (p->scx.flags & (SCX_TASK_QUEUED | SCX_TASK_DEQD_FOR_SLEEP))
-		balance_one(rq, p, true);
-#endif
-
 	update_curr_scx(rq);
 
 	/* see dequeue_task_scx() on why we skip when !QUEUED */
@@ -2807,12 +2774,6 @@ static struct task_struct *pick_next_task_scx(struct rq *rq)
 {
 	struct task_struct *p;
 
-#ifndef CONFIG_SMP
-	/* UP workaround - see the comment at the head of put_prev_task_scx() */
-	if (unlikely(rq->curr->sched_class != &ext_sched_class))
-		balance_one(rq, rq->curr, true);
-#endif
-
 	p = first_local_task(rq);
 	if (!p)
 		return NULL;
@@ -3673,6 +3634,7 @@ DEFINE_SCHED_CLASS(ext) = {
 
 	.wakeup_preempt		= wakeup_preempt_scx,
 
+	.balance		= balance_scx,
 	.pick_next_task		= pick_next_task_scx,
 
 	.put_prev_task		= put_prev_task_scx,
@@ -3681,7 +3643,6 @@ DEFINE_SCHED_CLASS(ext) = {
 	.switch_class		= switch_class_scx,
 
 #ifdef CONFIG_SMP
-	.balance		= balance_scx,
 	.select_task_rq		= select_task_rq_scx,
 	.task_woken		= task_woken_scx,
 	.set_cpus_allowed	= set_cpus_allowed_scx,
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 42b4d1428c2c..9b88a46d3fce 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2357,6 +2357,7 @@ struct sched_class {
 
 	void (*wakeup_preempt)(struct rq *rq, struct task_struct *p, int flags);
 
+	int (*balance)(struct rq *rq, struct task_struct *prev, struct rq_flags *rf);
 	struct task_struct *(*pick_next_task)(struct rq *rq);
 
 	void (*put_prev_task)(struct rq *rq, struct task_struct *p);
@@ -2365,7 +2366,6 @@ struct sched_class {
 	void (*switch_class)(struct rq *rq, struct task_struct *next);
 
 #ifdef CONFIG_SMP
-	int (*balance)(struct rq *rq, struct task_struct *prev, struct rq_flags *rf);
 	int  (*select_task_rq)(struct task_struct *p, int task_cpu, int flags);
 
 	struct task_struct * (*pick_task)(struct rq *rq);
-- 
2.46.0


