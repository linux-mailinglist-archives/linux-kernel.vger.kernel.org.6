Return-Path: <linux-kernel+bounces-314479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CC496B3DB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 10:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1292FB272F1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 08:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099FB18786A;
	Wed,  4 Sep 2024 08:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYmmnn1h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CDE186E40
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 08:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725437014; cv=none; b=tfCEp2DNFOk2vMX6wISJFWwHce+u6adwoBK+czd8+rEHfN/+BRbw+BZEjS3jD5k1B9yZdj49UlJd4B377uJjl7lhsCfvRQ+Iz5cngtWRLf9W7zZFMaQHfUkKWlPXIwZQg4/DlmKXoENOP0vP/kGE1cxX7E9CayyI3j28zIXkldU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725437014; c=relaxed/simple;
	bh=pT3QnS67kLjvYVx1BAB8LGImHANi7ozqL0tROzRcG5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jfe4Y/O4yP/0j7v16dVQQkgto//SyrY07d0jzGBDOVh1mQ5GOWH/DfidrQB2cdP5QNbGgaFkmNTLbZ6wI8KnFIbfMo1ve2kX+yxp4ueCmoRZTur/ZNbr9zfUnqIzDwN08k8IjtpCxQS7GrEYlH6vUX0p90M1Mw38DQf8D4HX7qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dYmmnn1h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D34C5C4CEC2;
	Wed,  4 Sep 2024 08:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725437014;
	bh=pT3QnS67kLjvYVx1BAB8LGImHANi7ozqL0tROzRcG5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dYmmnn1hmNm4jHXSmAQQRWNZOQLQbuU+xGoE94uiLGe2e37a04MvWLk7P9RvSuSoI
	 bSwYf7x5eL0BGVM25T6SKR1u6kKNv1wKyvA6YMqajLO3Dxk1BeAfrfhlQYa5+E580I
	 adVBDQeEYStBQa51rK5KKG/4Id/0gMqIJqEccL/PGsO5aYxDcnrZYnSjGnb6SJnoy5
	 Zr9/wY3nvEkCuhY+IxUtuFxMemMHM2Q6KZ9sGBoCtCKtr1FdNUFS3nCMpjKT07bSNn
	 S5WCUDRKnWJ3wzQ9YD/gFPkplH8Tc+sadJCullaywYnUuVJLuJJcR3VCjwbFjS1qSa
	 ARTKpLx7GJihg==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com
Cc: kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	peterz@infradead.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 5/6] sched_ext: Remove switch_class_scx()
Date: Tue,  3 Sep 2024 22:03:07 -1000
Message-ID: <20240904080326.1132275-6-tj@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240904080326.1132275-1-tj@kernel.org>
References: <20240904080326.1132275-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that put_prev_task_scx() is called with @next on task switches, there's
no reason to use sched_class.switch_class(). Rename switch_class_scx() to
switch_class() and call it from put_prev_task_scx().

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 24bafa649fdb..f0c9823915c6 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2723,12 +2723,10 @@ preempt_reason_from_class(const struct sched_class *class)
 	return SCX_CPU_PREEMPT_UNKNOWN;
 }
 
-static void switch_class_scx(struct rq *rq, struct task_struct *next)
+static void switch_class(struct rq *rq, struct task_struct *next)
 {
 	const struct sched_class *next_class = next->sched_class;
 
-	if (!scx_enabled())
-		return;
 #ifdef CONFIG_SMP
 	/*
 	 * Pairs with the smp_load_acquire() issued by a CPU in
@@ -2808,6 +2806,9 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 			do_enqueue_task(rq, p, 0, -1);
 		}
 	}
+
+	if (next && next->sched_class != &ext_sched_class)
+		switch_class(rq, next);
 }
 
 static struct task_struct *first_local_task(struct rq *rq)
@@ -3591,8 +3592,6 @@ DEFINE_SCHED_CLASS(ext) = {
 	.put_prev_task		= put_prev_task_scx,
 	.set_next_task		= set_next_task_scx,
 
-	.switch_class		= switch_class_scx,
-
 #ifdef CONFIG_SMP
 	.select_task_rq		= select_task_rq_scx,
 	.task_woken		= task_woken_scx,
-- 
2.46.0


