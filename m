Return-Path: <linux-kernel+bounces-248482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F121B92DDD3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 03:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42BA9B2474F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 01:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470923D978;
	Thu, 11 Jul 2024 01:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CTIXIXZT"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077CF2B9D8
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 01:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720660485; cv=none; b=VrEquISOOHXGC3YAas60xh9ERwz3Of2m7bMrrtX84ZiMlOAl27SnGsv6PsD4jyHeFSKDTGfMZQSDaKmr8h7mcdV+kA8tLUIIY/TcnjoM+chohzyvIA2YhUchFs7NNmlu8fL5MVjDg5fNK8OSi9eu/jS44PWzgxFUuvnt1JRbNsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720660485; c=relaxed/simple;
	bh=B76XIdQ1CDDECWfXcwdOXIW7b0jWnE9PUtadr970HqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U06Jrw5wC5uPDa7OqaZu8suY3Bei5AZJdag3I+XKkDGKSFPcR9hBpRug7YQmEXfroeMNyTStJrVl1Z53xwFHHI3QWzR61DNbxhr1nqGo73rhwoMQ6RqprgQ2Polhb68tDSybI71lEzo1q7sSNjF1UYcX0DR5SVOIpDtlZFWNKdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CTIXIXZT; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-706524adf91so338202b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 18:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720660483; x=1721265283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WNee8CxlBJQRxu0uozPUhxI7io6SutdLO5rI8f9raRQ=;
        b=CTIXIXZTXljU03Cr22Wc56rWF0FhCK963z/V6DVuDb8mXJ0ydrxCPzmVLbnWwxxpgp
         SnVtB/sbWLYJvkrFgoQh9RUA0NmTSHgHHC80suWTDQtUt/M7OBrryu6VZmI7ne/sfLZa
         9jEDtUXtguEK1NC6ukQ8rUmxa9/ULq0LfXwF8orUxZDpuVIy/LuJF1v2AlPPDqTtTxNs
         toU64wxkLMeBFRnMYYWjxMGCPRzFjcqS8Nu62bBgbzQXjGX3lAa7ypouZKzUNYx/7yaM
         grKdSDsYz4EelpIKR1qdK4XQob+bEt/gxy80X4vv8AEgeqHlXPVmc6f5fAIDQnM4moUv
         JDww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720660483; x=1721265283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WNee8CxlBJQRxu0uozPUhxI7io6SutdLO5rI8f9raRQ=;
        b=CW/Fkv90Sw2a+I36wTT/2lrh0OErS7b9oOJfO/mQFL4tTvkYwzfnBMGWx5SnzeN2K0
         P/x46mKpyc+6tA8/qu8l5w2JG2VY4uJblLRqDldcjrl4xH1Uj1ziCj6bv9XN/epGfMO+
         0+PQWd44vyRAMyNGQcaydna1nqNrjPd9CQZs9YlquovIEELg4bapBhz5FAWNgejKwuXG
         08J4Ij2TfqV9/XIK7XXk3t/OiW8xgoICwFPmsn/XiJ7LIgFlkk/Q4EeipbxyGSdUT0PH
         JK4VDAGukacYdLsO2S4nJQEWOjmbTL69ye4V7JdnimPSaZ7udeEtScp40NeRA4NiFcky
         ByvA==
X-Gm-Message-State: AOJu0YzGssoS+azgBowp5QT3Jl1ETXGSBSeMvCuPqxXOlbgff3jQ4UV1
	QgeIjaXGiAxMumn1DcPWyBH7JvlZtjiuyMstfFhkzFMkerkteBtr
X-Google-Smtp-Source: AGHT+IHNNzMNeMltV6bT+JJpVs0WM+vzv7oq8+Q5qSQc8wx35GlTy9vd3QgCNzuM5VYpWlyUIwPmeA==
X-Received: by 2002:a05:6a00:b56:b0:706:8a67:c395 with SMTP id d2e1a72fcca58-70b434f6165mr9059520b3a.6.1720660483076;
        Wed, 10 Jul 2024 18:14:43 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b4397ece4sm4581186b3a.144.2024.07.10.18.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 18:14:42 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	schatzberg.dan@gmail.com,
	mingo@redhat.com,
	peterz@infradead.org,
	changwoo@igalia.com,
	righi.andrea@gmail.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 4/6] sched_ext: s/SCX_RQ_BALANCING/SCX_RQ_IN_BALANCE/ and add SCX_RQ_IN_WAKEUP
Date: Wed, 10 Jul 2024 15:14:01 -1000
Message-ID: <20240711011434.1421572-5-tj@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240711011434.1421572-1-tj@kernel.org>
References: <20240711011434.1421572-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SCX_RQ_BALANCING is used to mark that the rq is currently in balance().
Rename it to SCX_RQ_IN_BALANCE and add SCX_RQ_IN_WAKEUP which marks whether
the rq is currently enqueueing for a wakeup. This will be used to implement
direct dispatching to local DSQ of another CPU.

Signed-off-by: Tejun Heo <tj@kernel.org>
Acked-by: David Vernet <void@manifault.com>
---
 kernel/sched/ext.c   | 13 +++++++++----
 kernel/sched/sched.h |  6 ++++--
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index d4f801cd2548..57d6ea65f857 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1827,6 +1827,9 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int enq_flags
 {
 	int sticky_cpu = p->scx.sticky_cpu;
 
+	if (enq_flags & ENQUEUE_WAKEUP)
+		rq->scx.flags |= SCX_RQ_IN_WAKEUP;
+
 	enq_flags |= rq->scx.extra_enq_flags;
 
 	if (sticky_cpu >= 0)
@@ -1843,7 +1846,7 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int enq_flags
 
 	if (p->scx.flags & SCX_TASK_QUEUED) {
 		WARN_ON_ONCE(!task_runnable(p));
-		return;
+		goto out;
 	}
 
 	set_task_runnable(rq, p);
@@ -1858,6 +1861,8 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int enq_flags
 		touch_core_sched(rq, p);
 
 	do_enqueue_task(rq, p, enq_flags, sticky_cpu);
+out:
+	rq->scx.flags &= ~SCX_RQ_IN_WAKEUP;
 }
 
 static void ops_dequeue(struct task_struct *p, u64 deq_flags)
@@ -2420,7 +2425,7 @@ static int balance_one(struct rq *rq, struct task_struct *prev, bool local)
 	bool has_tasks = false;
 
 	lockdep_assert_rq_held(rq);
-	rq->scx.flags |= SCX_RQ_BALANCING;
+	rq->scx.flags |= SCX_RQ_IN_BALANCE;
 
 	if (static_branch_unlikely(&scx_ops_cpu_preempt) &&
 	    unlikely(rq->scx.cpu_released)) {
@@ -2514,7 +2519,7 @@ static int balance_one(struct rq *rq, struct task_struct *prev, bool local)
 has_tasks:
 	has_tasks = true;
 out:
-	rq->scx.flags &= ~SCX_RQ_BALANCING;
+	rq->scx.flags &= ~SCX_RQ_IN_BALANCE;
 	return has_tasks;
 }
 
@@ -5063,7 +5068,7 @@ static bool can_skip_idle_kick(struct rq *rq)
 	 * The race window is small and we don't and can't guarantee that @rq is
 	 * only kicked while idle anyway. Skip only when sure.
 	 */
-	return !is_idle_task(rq->curr) && !(rq->scx.flags & SCX_RQ_BALANCING);
+	return !is_idle_task(rq->curr) && !(rq->scx.flags & SCX_RQ_IN_BALANCE);
 }
 
 static bool kick_one_cpu(s32 cpu, struct rq *this_rq, unsigned long *pseqs)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 86314a17f1c7..8a0e8052f6b0 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -737,8 +737,10 @@ enum scx_rq_flags {
 	 * only while the BPF scheduler considers the CPU to be online.
 	 */
 	SCX_RQ_ONLINE		= 1 << 0,
-	SCX_RQ_BALANCING	= 1 << 1,
-	SCX_RQ_CAN_STOP_TICK	= 1 << 2,
+	SCX_RQ_CAN_STOP_TICK	= 1 << 1,
+
+	SCX_RQ_IN_WAKEUP	= 1 << 16,
+	SCX_RQ_IN_BALANCE	= 1 << 17,
 };
 
 struct scx_rq {
-- 
2.45.2


