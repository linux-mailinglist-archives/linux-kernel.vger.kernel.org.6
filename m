Return-Path: <linux-kernel+bounces-246695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A31092C53E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 23:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7673AB2235A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 21:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D38189F38;
	Tue,  9 Jul 2024 21:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RYezcuhv"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1D7187876
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 21:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720560109; cv=none; b=gTsxsJJE99C5xA2p7wxCvnL21gCSOEsaluRIzaeePIDfCCWyOGtwx+DqgX8gfczgWJHCP3CmgXXIb0PUQJDW/6150g9f9eCucUgeXC+ahW6tBgMZJAxPnYT3WG6ypOqX4PNb1vxTTdfTSypm7nSKRTBoNdJPx6N6wmCbOd18Kwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720560109; c=relaxed/simple;
	bh=u4Yjus0OyYC0LP+4D0nGa7B7e/Pc6W9phdxcxY+0WOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BkUWKX74jq2noEeVWBdNKhb0pYNmxB5pX6ppNTSlH04voU07uq0Ft+0nJ+gJCWpXDy1v0GuOh567PPALjg0T8tkYRVneJd5gQgkG9+ydrkgdVqPeqOVODE41r5RdppzN+MtT/vqF2r/h7Uaqp11QFh5+GH+A1ylOu6Hcrg4a3a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RYezcuhv; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-70b0e7f6f8bso3970086b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 14:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720560108; x=1721164908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cLUyivwnZLUPBUS/iwdJEPuo48AXkKZfeiNH+0zNbhY=;
        b=RYezcuhvH6+7UE/T9Z6VtmdRSExgmmB2gKh3VBdLgB3HVMzLtLGPzP7oLAIA2ZGmkH
         TJIaxA2F14tntGjzNAGGqvZvB0txpUVstrid0ZJvZzS61nIQ5jQpKyfLI4LgKLqQyf5R
         aReIt2gLwk8zAnnu0We67MOB5q3/vvuXciHQV1kVRt+kLSYQ7KGVopeot+MTAe6hsvXt
         ghQVpCFNzAhF+DdElegUbyFVCQ9Rr28p5rwWix+LtELu8Z0jxp9wM3LONMyxkbSjx3p7
         KT4cXEEytHoqFF2uRu+ZE2HP3aSH6f67NNLK7r2CUm3moVVKEwQq9XsfXfe/GFuC6r/0
         do6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720560108; x=1721164908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cLUyivwnZLUPBUS/iwdJEPuo48AXkKZfeiNH+0zNbhY=;
        b=ZkkUver2nrmyHgUCkKVKmOoXxXOhjuVJDVqzDRBE3BAo9crhZvXPTd0VgPb2QPwliH
         ptlLu6Fnu8Gp9pBBVBIw/ZJxvLNeyWej82vIbp1CE3emwvDbocXPv+Mk9wae1ASXJdZx
         6PBLrD8hFObLhT/NQkEnW/lCpzATO/nlY52ZLgKSudXcwuKyO8WBIcfJPW+MFIYMsDLi
         MtWxByxB08YCucxO3wO+9lblhd3zKcI169pCEBa8IvkPKwmD26mVsadrgWc2SCV/ypQ6
         xH+NuFwbXekjtwcmz1Fm2wXFD/4tG7drsgjaaXZhfMvibvf1CbcqMtk5L1q3QqoY5gJx
         dF0A==
X-Gm-Message-State: AOJu0YyjkED0JwiYATYGg837ZW3VVjPV2wc98GRpkojS01ptxK81uV9K
	1/7+GitWNl9BflxOOVoEmcubSlhBe/AijOOFohcpVhGK1inZp8An
X-Google-Smtp-Source: AGHT+IF5+sK5U08T9KaNNziP2qSNCjoG/8iRzdHQ1qSDKoIclaEd0b6r7tIfGOA3HiwMskvfoIiUmg==
X-Received: by 2002:a05:6a20:244e:b0:1c2:8d59:d14c with SMTP id adf61e73a8af0-1c29820c62bmr4217288637.21.1720560107876;
        Tue, 09 Jul 2024 14:21:47 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-77d603fa713sm1841910a12.25.2024.07.09.14.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 14:21:47 -0700 (PDT)
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
Date: Tue,  9 Jul 2024 11:21:10 -1000
Message-ID: <20240709212137.1199269-5-tj@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240709212137.1199269-1-tj@kernel.org>
References: <20240709212137.1199269-1-tj@kernel.org>
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
Cc: David Vernet <void@manifault.com>
---
 kernel/sched/ext.c   | 13 +++++++++----
 kernel/sched/sched.h |  6 ++++--
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index e96727460df2..a88c51ce63a5 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1828,6 +1828,9 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int enq_flags
 {
 	int sticky_cpu = p->scx.sticky_cpu;
 
+	if (enq_flags & ENQUEUE_WAKEUP)
+		rq->scx.flags |= SCX_RQ_IN_WAKEUP;
+
 	enq_flags |= rq->scx.extra_enq_flags;
 
 	if (sticky_cpu >= 0)
@@ -1844,7 +1847,7 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int enq_flags
 
 	if (p->scx.flags & SCX_TASK_QUEUED) {
 		WARN_ON_ONCE(!task_runnable(p));
-		return;
+		goto out;
 	}
 
 	set_task_runnable(rq, p);
@@ -1859,6 +1862,8 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int enq_flags
 		touch_core_sched(rq, p);
 
 	do_enqueue_task(rq, p, enq_flags, sticky_cpu);
+out:
+	rq->scx.flags &= ~SCX_RQ_IN_WAKEUP;
 }
 
 static void ops_dequeue(struct task_struct *p, u64 deq_flags)
@@ -2443,7 +2448,7 @@ static int balance_one(struct rq *rq, struct task_struct *prev,
 	bool has_tasks = false;
 
 	lockdep_assert_rq_held(rq);
-	rq->scx.flags |= SCX_RQ_BALANCING;
+	rq->scx.flags |= SCX_RQ_IN_BALANCE;
 
 	if (static_branch_unlikely(&scx_ops_cpu_preempt) &&
 	    unlikely(rq->scx.cpu_released)) {
@@ -2538,7 +2543,7 @@ static int balance_one(struct rq *rq, struct task_struct *prev,
 has_tasks:
 	has_tasks = true;
 out:
-	rq->scx.flags &= ~SCX_RQ_BALANCING;
+	rq->scx.flags &= ~SCX_RQ_IN_BALANCE;
 	return has_tasks;
 }
 
@@ -5093,7 +5098,7 @@ static bool can_skip_idle_kick(struct rq *rq)
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


