Return-Path: <linux-kernel+bounces-259936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2D293A01F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 13:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B815028369F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 11:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F3F1514D8;
	Tue, 23 Jul 2024 11:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Wdji15RC"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FCD1509BC
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 11:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721734987; cv=none; b=p8DlE9H3WLd39kqJEsfIgLC8GgWTSaT4kK5MRKIS8nti3xz2ol0h3e+d4RJs7+qbwECPXzg+3b3pmwHvuqMcAbUnMGQqgeEBIiqfVS+qDf5cVk9L8QAbhh3b6aWDmQtWUDHo3nCC8YBd+OqdyYvxCMSqhqVMrc4NLQ0qRdHFmbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721734987; c=relaxed/simple;
	bh=Xf46QnpBhycjA2we/oIW0DMdNBdrMmsoU3E+1uhd9Ns=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MB9ZQ808gNe5iJbiyjffvBTO8dJ2SIW8FS3+N05UuZVLif9XI6GP7oBMe+cvW2IY1VK4RIY7YwhjjF2ko5SRH1I/IjksRnj1bZCLnKzu94btFarD2C/PIEOUbdqr87hhikWC6zMYLvRIoWAna4LspuZXfnOtoTss72Uw0/GGfZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Wdji15RC; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fc65329979so4404145ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 04:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1721734985; x=1722339785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tVuVHmpEOyDlXd7HaBeqyXx5iXIfyPR5YAgjEFBWvCc=;
        b=Wdji15RC/ZULCzben7UQmvrDJIi4+0LEIKEmN6gJulHwuq6FCMYxYp8ozg1ZGBaau0
         UhiKKi3mHqwsjXn+s7oDw12/OGL4enCkfDMmp3EHvFMwtv8jANjlhvGFQSxWSlQnaVpb
         TB4qkxY65fx6wfy9hPf1SmEVFALmYTLMGahURVkj7xmoL1pCNqYHCrHEGvm9s49KRvBh
         kMqVXzVKKd+57iUXm7y+DDCUV4TXQkvcaMJOu21ulmtmNn3W9pt2lXf/lNW9HXZWm7/B
         6nKjJGRx/FtfYTxpsPoKTv3UbQd46YPRVSqzB5KXtRW8kvbhhDbbQlEb8gicUNpBRdQr
         6k+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721734985; x=1722339785;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tVuVHmpEOyDlXd7HaBeqyXx5iXIfyPR5YAgjEFBWvCc=;
        b=CtxBfbzmxC+MulxAu8n8FWaeUJELlzeKQXngHxXb6qfWQDqMQm+9h12jjmp5GcMOc4
         /obuCxsz69f+b/E1b7qUgxRCB6dImBlMIqU51SiQ2M5IzzRf+ft6TTdG4z0vr0Do5+GI
         4y+mCpiSbK6w5IZ6ZlH5TvXESidB23NEKtlVZJy1hx7gO/bmeXLwal7A6KAU4/zNdAip
         RJCJ85B2oxzYG9Wrp92vcL+se0QVBDMsdOJbPuSb19eAHXgAn1b/BOhL67XSaol+hraJ
         Bm/zFp8XSl7TjcKLmrbw3726gsFBuYveAWO7ipiL8Zs/sJ4/Z+unX2OFCI8GdxDgIofO
         fanw==
X-Forwarded-Encrypted: i=1; AJvYcCUmiz5KlbjiWPxMV6aZGqwdN1+PyV0af1SNijnuZ5mHavJuuBdMsrwd5TvxaQqpAHYhwlH+VGQJYX4LKfNbW9c69uXmF9NPiz01LZnY
X-Gm-Message-State: AOJu0YxZ1uwK06w9MUQwKk82mUhsvb6jDoCtV0N3lLFeFF5OoRD4oA3b
	hFqC/yErdsfa2ikfG5SLAaZ4EyQq6SZ9OrQrb1XdHRskddCZsbmKh2sg85aUmAg=
X-Google-Smtp-Source: AGHT+IGsSpy8FXekG1ZiCZiqGqueWiF59cWFqLfR7d6TRLockjaFi0LWa/vGfHBVQ5tgxu5cToKogg==
X-Received: by 2002:a17:902:c204:b0:1fb:a2c0:53b4 with SMTP id d9443c01a7336-1fd74553f28mr79095475ad.18.1721734984822;
        Tue, 23 Jul 2024 04:43:04 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.103.200])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f259dddsm72769195ad.61.2024.07.23.04.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 04:43:04 -0700 (PDT)
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
	Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [PATCH v3] sched/fair: Sync se's load_avg with cfs_rq in reweight_task
Date: Tue, 23 Jul 2024 19:42:47 +0800
Message-Id: <20240723114247.104848-1-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In reweight_task(), there are two situations:

1. The task was on_rq, then the task's load_avg is accurate because we
synchronized it with cfs_rq through update_load_avg() in dequeue_task().

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
---
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
 kernel/sched/fair.c | 43 ++++++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9057584ec06d..da3cdd86ab2e 100644
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
@@ -3795,7 +3816,9 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 		if (!curr)
 			__dequeue_entity(cfs_rq, se);
 		update_load_sub(&cfs_rq->load, se->load.weight);
-	}
+	} else if (entity_is_task(se))
+		sync_entity_load_avg(se);
+
 	dequeue_load_avg(cfs_rq, se);
 
 	if (se->on_rq) {
@@ -4034,11 +4057,6 @@ static inline bool load_avg_is_decayed(struct sched_avg *sa)
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
@@ -4773,19 +4791,6 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
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


