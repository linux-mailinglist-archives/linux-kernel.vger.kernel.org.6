Return-Path: <linux-kernel+bounces-558897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D426A5ECD7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 08:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30F16189991E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 07:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A031FC0FF;
	Thu, 13 Mar 2025 07:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="HDSzFFUg"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2191FC7F2
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 07:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741850474; cv=none; b=axciPMSmWGvhMesGhl4f12ceZ5DB6XELtswzJD5SBIVcSbqv5MXFX+Axav1S3XkmPc/LgegJL4FBC0GFU8nqUNXbpKmX1Aq3cydXag/aXQInYwrlkBOucZs3FwdkY36qC1s0CKQaiNFqQMV/wvv1taCrTemK2kxO0ET4viCWJ58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741850474; c=relaxed/simple;
	bh=gHPiJK6HRckmlXxxye7eG/CgOKv8DfBqUI+lI52Wxcc=;
	h=From:References:In-Reply-To:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TGjkFF0jRbncn8dNJTQZ2t//e7G9Kmfm5HSWYCaDmAVfRi/znYR4aIKJM8WGlh2/mxwRSNlWf2C8XrTqT7Zc79el5xNc2oZ4wG+tZ/GyeXj/rdcRwpKudbHHvIkpT6MsIk9nbOwH51PRTwTXAlq+IsL4nYEO0gUjo8gL7u1xsEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=HDSzFFUg; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5dccaaca646so1217653a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 00:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1741850471; x=1742455271; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:in-reply-to:references
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=29ZMaOlzLLl8W5L5LLXlHyP6nAGcgQli4bqNsuL0SBE=;
        b=HDSzFFUg2sbtR2XKpWnOY4+3Ls8GYrdI/rc7iYtUKg4Fkf/rarJ0eSCw29Dljo+JDR
         eWQJRpH2XOJWyILOW51qTpIsIVbGYu8s3j5lE6Hq7XmWowrdQH4mdiftBl2Fa1kZ4JlT
         1QVeYkaXa8l7h2/MjeauehY5jlbmqN7jz6VjrrAHiXbgq4tuCqHU5mHUt3i0lCX8FWKY
         gVc80YvBx7bQb3hrh5JfVW8RI2Y5p++cikiWK866KTQ/7kg4FVIgzbZVfKucbyn7sOv9
         LGjoqSklwZLiri9DfFoMtmSS74eoqS30eLq8UOyeMSSzmHIqAEsUT3tIG6hrSs3eS5J8
         5DoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741850471; x=1742455271;
        h=cc:to:subject:message-id:date:mime-version:in-reply-to:references
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=29ZMaOlzLLl8W5L5LLXlHyP6nAGcgQli4bqNsuL0SBE=;
        b=lMhaEgaZA+crsnYxp/cD7Jf88lwqt27S5SLUVWFT6u9ejpB83403DSOWPfqUOpTJTx
         pNp0QZj87QBX/9T2ChXAtMu1tz802dnIhC4i5mPnjPsY3mDwihsXYeLC5yoVNV0anme8
         kKJQZ/tvIYISjBOuOhKAyuQxLNbntNLX9npvCiFa+iikrJQ3YS9V2k75N3VtAv7bfcaC
         JX4/PQ0R0VtQ0vvsfg7BIqFzVxgW8j9SFFPbhEXOqswYbIqkfNziVy9jnqUUKtWoo7x/
         tiFC0SqK1+wE1AzfRAyL7/PW7X33nAjR4DPgTRh95uXE45aE5Rajr5p2ohKDvZUd+hYu
         nrew==
X-Gm-Message-State: AOJu0YwOUyzu6gu4+HU/GaEzuOeWfyrO7NyY3pWE8aVwmbTVbLvVhU4/
	AdNCDhdQvPXtTx8YTgN6khsrX1+yoU7PsZQwqsskUBYLL054LwqDYg8i+l5iKFFThykBIznKIHk
	415uFGmz4PAQAptIxz8rIRELEiMthBJmd1YFS
X-Gm-Gg: ASbGnctbZSCYYv8a3yS5pyUVEpKCipdNNhBrZAiaN4qBM8Rd+y+IghooKmraxn9CXEy
	5/gGN/N/gACIgXMVEAttkin4e875F1OGuGmljAODgVEOlqGREGLt7jRNPPiyJwq0w0ywDi5PyN4
	HH26KbwvGMnwV+JThXDupasplKSnhguf5HfJ+fQw==
X-Google-Smtp-Source: AGHT+IHxkyL3RCMezoLUpX6NVM2XBBM8muoFF88BBs6ttBOc0pZ9L/+IsvBgykrUwA39mrtGeeqUoWafaGRMCC+z0EM=
X-Received: by 2002:a50:cd5e:0:b0:5e7:87ea:b18c with SMTP id
 4fb4d7f45d1cf-5e814ee5d15mr1105266a12.15.1741850470812; Thu, 13 Mar 2025
 00:21:10 -0700 (PDT)
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 13 Mar 2025 02:21:10 -0500
From: Aaron Lu <ziqianlu@bytedance.com>
References: <20250313072030.1032893-1-ziqianlu@bytedance.com>
In-Reply-To: <20250313072030.1032893-1-ziqianlu@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Aaron Lu <ziqianlu@bytedance.com>
X-Mailer: git-send-email 2.39.5
Date: Thu, 13 Mar 2025 02:21:10 -0500
X-Gm-Features: AQ5f1Jqo4tNhOWmDkvlNOQeUbc53LvIH-F5HqukIKZbZifT-c4YHJ4guYgUDFVo
Message-ID: <CANCG0GcxLJOnNSZgYVYYh_Ug-sVpCOmsf3VATELrKrs_6jovQw@mail.gmail.com>
Subject: [RFC PATCH 1/7] sched/fair: Add related data structure for task based throttle
To: Valentin Schneider <vschneid@redhat.com>, Ben Segall <bsegall@google.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Peter Zijlstra <peterz@infradead.org>, 
	Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mel Gorman <mgorman@suse.de>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Chuyi Zhou <zhouchuyi@bytedance.com>
Content-Type: text/plain; charset="UTF-8"

From: Valentin Schneider <vschneid@redhat.com>

Add related data structures for this new throttle functionality.

[aaronlu: extracted from Valentin's original patches]
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Aaron Lu <ziqianlu@bytedance.com>
---
 include/linux/sched.h |  4 ++++
 kernel/sched/core.c   |  3 +++
 kernel/sched/fair.c   | 12 ++++++++++++
 kernel/sched/sched.h  |  2 ++
 4 files changed, 21 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 9632e3318e0d6..eec9087232660 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -858,6 +858,10 @@ struct task_struct {

 #ifdef CONFIG_CGROUP_SCHED
 	struct task_group		*sched_task_group;
+#ifdef CONFIG_CFS_BANDWIDTH
+	struct callback_head		sched_throttle_work;
+	struct list_head		throttle_node;
+#endif
 #endif


diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 621cfc731c5be..56e2ea14ac3b4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4493,6 +4493,9 @@ static void __sched_fork(unsigned long
clone_flags, struct task_struct *p)

 #ifdef CONFIG_FAIR_GROUP_SCHED
 	p->se.cfs_rq			= NULL;
+#ifdef CONFIG_CFS_BANDWIDTH
+	init_cfs_throttle_work(p);
+#endif
 #endif

 #ifdef CONFIG_SCHEDSTATS
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9dafb374d76d9..60eb5329bf526 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5832,6 +5832,18 @@ static inline int throttled_lb_pair(struct
task_group *tg,
 	       throttled_hierarchy(dest_cfs_rq);
 }

+static void throttle_cfs_rq_work(struct callback_head *work)
+{
+}
+
+void init_cfs_throttle_work(struct task_struct *p)
+{
+	init_task_work(&p->sched_throttle_work, throttle_cfs_rq_work);
+	/* Protect against double add, see throttle_cfs_rq() and
throttle_cfs_rq_work() */
+	p->sched_throttle_work.next = &p->sched_throttle_work;
+	INIT_LIST_HEAD(&p->throttle_node);
+}
+
 static int tg_unthrottle_up(struct task_group *tg, void *data)
 {
 	struct rq *rq = data;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 023b844159c94..c8bfa3d708081 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2724,6 +2724,8 @@ extern bool sched_rt_bandwidth_account(struct
rt_rq *rt_rq);

 extern void init_dl_entity(struct sched_dl_entity *dl_se);

+extern void init_cfs_throttle_work(struct task_struct *p);
+
 #define BW_SHIFT		20
 #define BW_UNIT			(1 << BW_SHIFT)
 #define RATIO_SHIFT		8
-- 
2.39.5

