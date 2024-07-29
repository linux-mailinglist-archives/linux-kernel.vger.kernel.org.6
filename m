Return-Path: <linux-kernel+bounces-265580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7932C93F318
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 12:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03B391F22B58
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 10:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F24142E90;
	Mon, 29 Jul 2024 10:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="W4jhO3Ma"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62B028399
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 10:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722250078; cv=none; b=klMGDdeiQYyAN0MTf7Vlvvu5TNWSzEdfogcXEuzqlR0dY0bCJc420GUZ+qJNOuuWIIn1Unarqw+dEvkXnhCFTD8wLR9D9ElDVhPjMM8z0yaZNyg/IEc8csthS9PfKiQsZQpj92H8P/SH9dLOw2+mG5jkOxliwPzpqybwnNcfzz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722250078; c=relaxed/simple;
	bh=CElFUaSt39LD07nbyYkOmf88j/tneKOnXESPEgQ8wfE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Eztd9TOUJFA+oCrO5A5puV/vKhoGc9zvIrq5PMDVb5RBIn/dr1wRsMYPBQvX408rUCmRDWXM4XZcyqLcnXtqHh8x+FaNvp24peevLuK6Hfwzd1u/YAuCpSBaBhGpogoNF1NgUAGtrD8fW13Mfcazc7+rmTuV7oiXt9MttNBsAtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=W4jhO3Ma; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7093d565310so2455136a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 03:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1722250076; x=1722854876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/M7x9+yc9rI0RELQUIFv0/9PMIjTrB2uN0mlMn1j5L4=;
        b=W4jhO3Maq/lXSvwQVGpAlFlQcLrEMv0hDzT/9XXGAEe5mIt5QIj/WyHZhKqQScbJnQ
         +rVH6331oYBGIZxJFSXBUiTiu8GkO+VYO2LNDyS3W8pDzOXRNOlEVrWGSM5IIVXMyeZq
         bxCb1q8sYC1qPIx9MR/7HLAcJz8QdeIZWVBE+504eSK4vsUz1VoKutVeMA01K0rg86nI
         gl5ZCufkF5mdLyZf6gqGJWwg3wEDa0hoQOu62E66mIRz3m485M6NEn6MAhM4PsbPvQ/O
         OZtJqYkoeTrG23jQc6MIrjHyRx+jg4COJ6AIhWhI7CYdOfc7i8gkGIh1Bqak5zzuYISI
         3A2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722250076; x=1722854876;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/M7x9+yc9rI0RELQUIFv0/9PMIjTrB2uN0mlMn1j5L4=;
        b=eESJFUp+dEWE5ESZreLXrP2I8tpZ3WKQdiYQn4LgbgRluwbJH5sTPXQldPB4ZJB9y/
         hx+PavayC11/LC/O445QHn3dTRrh33fcXCAtAGg7UMlNzlnFl9BzBhfKa9Uoa6CGfiTQ
         E54H5A1qYMsjI2ZQ8jX+StH6d7ytfni4NngOS9dAaR2evqufhYjZ5EpC0u36sOLbXlBF
         4FPreU/kDxwXpP0GRHvWO+VotiltnooaOAzcDdOdpQWeMsc2EeiDCyt9ehe4EiRYaOTL
         pUGw53hKx3UQuJEPDYrHygmm/5hmUjaSRtccmi9N3ofyXGx+Hrk7hdcJQWB7Trpcp4Ps
         o1Hg==
X-Forwarded-Encrypted: i=1; AJvYcCVvO27uVsCv5ZYQXqUCpBmVl9PkHwHTrgh5lTv4rP/exb8np+tai3WKSDXtFoS+gvlmq5s/sWcsAfZm050MlTc1jN9B2sjW0VTYFvRG
X-Gm-Message-State: AOJu0YzrGDzlJSswjFGDIwFdXaZy2F70DRa5KZ1mE9+EvR0E6wVktgxc
	FO65+oUxVJLrtJoa8JW1LVjlusGu4ZYvWdPsgwIF0TOTvClATTMDPwyqt9cNxow=
X-Google-Smtp-Source: AGHT+IE0RZbfCFmLjEYQdVAsWMQTCJuFf2+W1V4sAYyWVS9S9C+XrlKh0aSfsTE/AUIqiddhNRAa6w==
X-Received: by 2002:a05:6830:2587:b0:703:6e7e:3e18 with SMTP id 46e09a7af769-70940c5df12mr9508060a34.26.1722250075721;
        Mon, 29 Jul 2024 03:47:55 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.84.173])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9f836ace5sm6978594a12.34.2024.07.29.03.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 03:47:55 -0700 (PDT)
From: Chuyi Zhou <zhouchuyi@bytedance.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com
Cc: chengming.zhou@linux.dev,
	linux-kernel@vger.kernel.org,
	Chuyi Zhou <zhouchuyi@bytedance.com>,
	Vishal Chourasia <vishalc@linux.ibm.com>
Subject: [PATCH v4] sched/fair: Sync se's load_avg with cfs_rq in reweight_task
Date: Mon, 29 Jul 2024 18:46:16 +0800
Message-Id: <20240729104616.180445-1-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In reweight_task(), there are two situations:

1. The task was on_rq, then the task's load_avg is accurate because in
__sched_setscheduler()/set_user_nice(), we would dequeue the on_rq tasks
before doing reweight. The task's load_avg would be synchronized with
cfs_rq through update_load_avg() in dequeue_task().

2. The task is sleeping, its load_avg might not have been updated for some
time, which can result in inaccurate dequeue_load_avg() in
reweight_entity().

This patch solves this by using sync_entity_load_avg() to synchronize the
load_avg of se with cfs_rq before dequeue_load_avg() in reweight_entity().
For tasks were on_rq, since we already update load_avg to accurate values
in dequeue_task(), this change will not have other effects due to the short
time interval between the two updates.

Suggested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
Reviewed-by: Vishal Chourasia <vishalc@linux.ibm.com>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

---
Changes in v4:
- Fix the 'if else' code style issue.(Dietmar)
- Add a description of __sched_setscheduler()/set_user_nice() in the commit
  log.(Dietmar)
- Add comment before calling sync_entity_load_avg().(Qais)
Changes in v3:
- use sync_entity_load_avg() rather than update_load_avg() to sync the
sleeping task with its cfs_rq suggested by Dietmar.
- Link t0 v2: https://lore.kernel.org/lkml/20240720051248.59608-1-zhouchuyi@bytedance.com/
Changes in v2:
- change the description in commit log.
- use update_load_avg() in reweight_task() rather than in reweight_entity
suggested by chengming.
- Link to v1: https://lore.kernel.org/lkml/20240716150840.23061-1-zhouchuyi@bytedance.com/
---
 kernel/sched/fair.c | 46 +++++++++++++++++++++++++++------------------
 1 file changed, 28 insertions(+), 18 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9057584ec06d..1e3c7c582541 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3669,11 +3669,32 @@ dequeue_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	cfs_rq->avg.load_sum = max_t(u32, cfs_rq->avg.load_sum,
 					  cfs_rq->avg.load_avg * PELT_MIN_DIVIDER);
 }
+
+static inline u64 cfs_rq_last_update_time(struct cfs_rq *cfs_rq)
+{
+	return u64_u32_load_copy(cfs_rq->avg.last_update_time,
+				 cfs_rq->last_update_time_copy);
+}
+
+/*
+ * Synchronize entity load avg of dequeued entity without locking
+ * the previous rq.
+ */
+static void sync_entity_load_avg(struct sched_entity *se)
+{
+	struct cfs_rq *cfs_rq = cfs_rq_of(se);
+	u64 last_update_time;
+
+	last_update_time = cfs_rq_last_update_time(cfs_rq);
+	__update_load_avg_blocked_se(last_update_time, se);
+}
+
 #else
 static inline void
 enqueue_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se) { }
 static inline void
 dequeue_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se) { }
+static void sync_entity_load_avg(struct sched_entity *se) { }
 #endif
 
 static void reweight_eevdf(struct sched_entity *se, u64 avruntime,
@@ -3795,7 +3816,14 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 		if (!curr)
 			__dequeue_entity(cfs_rq, se);
 		update_load_sub(&cfs_rq->load, se->load.weight);
+	} else if (entity_is_task(se)) {
+		/*
+		 * If the task is sleeping, we need to synchronize entity load avg
+		 * before dequeue_load_avg().
+		 */
+		sync_entity_load_avg(se);
 	}
+
 	dequeue_load_avg(cfs_rq, se);
 
 	if (se->on_rq) {
@@ -4034,11 +4062,6 @@ static inline bool load_avg_is_decayed(struct sched_avg *sa)
 	return true;
 }
 
-static inline u64 cfs_rq_last_update_time(struct cfs_rq *cfs_rq)
-{
-	return u64_u32_load_copy(cfs_rq->avg.last_update_time,
-				 cfs_rq->last_update_time_copy);
-}
 #ifdef CONFIG_FAIR_GROUP_SCHED
 /*
  * Because list_add_leaf_cfs_rq always places a child cfs_rq on the list
@@ -4773,19 +4796,6 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 	}
 }
 
-/*
- * Synchronize entity load avg of dequeued entity without locking
- * the previous rq.
- */
-static void sync_entity_load_avg(struct sched_entity *se)
-{
-	struct cfs_rq *cfs_rq = cfs_rq_of(se);
-	u64 last_update_time;
-
-	last_update_time = cfs_rq_last_update_time(cfs_rq);
-	__update_load_avg_blocked_se(last_update_time, se);
-}
-
 /*
  * Task first catches up with cfs_rq, and then subtract
  * itself from the cfs_rq (task must be off the queue now).
-- 
2.20.1


