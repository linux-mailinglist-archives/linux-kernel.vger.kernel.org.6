Return-Path: <linux-kernel+bounces-448066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9597A9F3A96
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 21:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0940188DE6E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 20:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6771D63C3;
	Mon, 16 Dec 2024 20:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OFFWs2IR"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE68B1D31AE
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 20:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734380001; cv=none; b=peYXE45miN9qhMecJTugk9o+8vVULdloGJmtdjvXxZS+5vzkUO6t9UXH5EEp3+nu5HcEGIH0IKubqKhaI0bg2CmCNu/bycH2ue2b6YL5cuMkuIvl51RbBYMz9+XxESClsXkg2Z3ZHMcr/5Ueofg/qySZkQU6TuUAYW+0WcF62DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734380001; c=relaxed/simple;
	bh=GEVPFmfx8lJk0msTC4kBxvoqsFBYZDzhe/s440TxMQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HZtJrE08LlzbKGTw4OTjO3v/sz3+K0AlaSEmxpJL7X/7B2WoW84DvM0/uv2HP/oqwhDpAjA0jR6cWn09XsTnNrxyPPmdvVLpbJ27LCfq/VhnzKEyaWswTmJKSsBPv0FV/tYIoJ5V9CjVVvk+14INAzGbL09EijAF8oEaRklSV8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OFFWs2IR; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-434b3e32e9dso49695425e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 12:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734379997; x=1734984797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AQzHk+vq4hHffbPZrG6QBU6HzZrXvwTNaQRxK1FhdoM=;
        b=OFFWs2IRpc7vC2rcS0i+0eMrYoWre/vJiK8Yh6ICQwk+zBFIYTkuuw7xpedpDaw2t/
         Z+iVePgVR0GeoaC4uzHXY+0Em2qHZQT0HBtdAP220VUJRHqVDw4UIrRvym41z1lUYf2h
         e4+QaZpGvagH37I0xHbpg09t+ux22PL75JcHKUNnvjy0U44yba+B4ZPA578Ua7ZIXGQr
         slWQ8PQn6MqztxdK7qr2O7VwgfZ8uNpAQOT48OZn7SFJ5pq6/5oe67sVhlkd2CG+FB9W
         12z+1sFgQ8yhVEZd4K7dqrYmvWmwqujla2qm4LxcnUX5DutjCSl4J/Yhdnx8IEU5s20d
         xbbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734379997; x=1734984797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AQzHk+vq4hHffbPZrG6QBU6HzZrXvwTNaQRxK1FhdoM=;
        b=Lij+xq0fjsFXQnFfojM/RUDcaZpER8ktcxVY+/wyIOpvcA9TOpZP1XNe6a6IeN+UJZ
         I6YkbjwRbomkSVMh+STAHja1elhu2QghWJ3Np/FhnChZrtZOH1eaYJO5njPeTY1a5NZS
         n5hHHQJoOBcER5S40ZHDNbr+eJnrM+bbe6bjXzjpPXpo5tJNugI0PT9HXnwdm82Zo2Ca
         W3MJEsHofkehTzgtuxuY731/HXDTR2H9HkByeKQ4vM44ATQaNsW7IgdUcI0NvpJlODJB
         107eNv/NP79WJNHaeEGUoBAv7Zcz8bbEKzsjeJQcAEf+K9nzXBm2xJ5CKeNEv1+mkNYK
         HSNA==
X-Forwarded-Encrypted: i=1; AJvYcCVUxqwEYQY5hW/6L1SFR6jpc1nE96fPTqtNCa3PTIsKzkYqvs5SRbYzDhvIG4gxPAgmGCunpXBOfyWOnW4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0IkfQjUKPZYdJfnAr0miG/RkICU5aNH6LRSWt8/K4OedfPWn/
	9E9IHYH9J1HCS/6WWBnDoKiyCM41OXlg69PMsZX+jDeUXkIJP3/aBqTVndGDj+M=
X-Gm-Gg: ASbGncvRCddQlkaLvEl8b3hKBEHMAvLurEy9rzAXyyyYBw3Htjxwuzt5cDBTKK8JaYt
	vUU2bWxSDRHFvZk0KDBev7BKJpxdpstU2xetHmqa6zFOqu9rULNNWqO4jnnnzOorOe4T3J1nJux
	uSRhbZlHEqMQjDp67wHv+gEwAlYCk9GhxNofq5RKk1Y+FeAuRRq6pn0dyPNj2sh24DURvqtcqws
	8L+FpKwBpSM0RfgXl8PdP/CVPgywQdA6WvV1ej2POK2VVg+zDjERZqPEg==
X-Google-Smtp-Source: AGHT+IGyt5ABFZR5mnMw1R3r7LXBL15BSl/L4PEq55+haAC/GNs+ad/ewuDRlHUqZRIg1Cop42eYZg==
X-Received: by 2002:a05:600c:83cf:b0:434:edcf:7474 with SMTP id 5b1f17b1804b1-4362aaa1ee4mr112233245e9.33.1734379997270;
        Mon, 16 Dec 2024 12:13:17 -0800 (PST)
Received: from blackbook2.suse.cz ([84.19.86.74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4364a379d69sm473715e9.0.2024.12.16.12.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 12:13:17 -0800 (PST)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Frederic Weisbecker <fweisbecker@suse.com>
Subject: [RFC PATCH 5/9] sched: Skip non-root task_groups with disabled RT_GROUP_SCHED
Date: Mon, 16 Dec 2024 21:13:01 +0100
Message-ID: <20241216201305.19761-6-mkoutny@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241216201305.19761-1-mkoutny@suse.com>
References: <20241216201305.19761-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

First, we want to prevent placement of RT tasks on non-root rt_rqs which
we achieve in the task migration code that'd fall back to
root_task_group's rt_rq.

Second, we want to work with only root_task_group's rt_rq when iterating
all "real" rt_rqs when RT_GROUP is disabled. To achieve this we keep
root_task_group as the first one on the task_groups and break out
quickly.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/sched/core.c  | 2 +-
 kernel/sched/rt.c    | 9 ++++++---
 kernel/sched/sched.h | 7 +++++++
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 47898f895a5a3..dfd2778622b8b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8958,7 +8958,7 @@ void sched_online_group(struct task_group *tg, struct task_group *parent)
 	unsigned long flags;
 
 	spin_lock_irqsave(&task_group_lock, flags);
-	list_add_rcu(&tg->list, &task_groups);
+	list_add_tail_rcu(&tg->list, &task_groups);
 
 	/* Root should already exist: */
 	WARN_ON(!parent);
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 41fed8865cb09..923ec978ff756 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -497,6 +497,9 @@ typedef struct task_group *rt_rq_iter_t;
 
 static inline struct task_group *next_task_group(struct task_group *tg)
 {
+	if (!rt_group_sched_enabled())
+		return NULL;
+
 	do {
 		tg = list_entry_rcu(tg->list.next,
 			typeof(struct task_group), list);
@@ -509,9 +512,9 @@ static inline struct task_group *next_task_group(struct task_group *tg)
 }
 
 #define for_each_rt_rq(rt_rq, iter, rq)					\
-	for (iter = container_of(&task_groups, typeof(*iter), list);	\
-		(iter = next_task_group(iter)) &&			\
-		(rt_rq = iter->rt_rq[cpu_of(rq)]);)
+	for (iter = &root_task_group;					\
+		iter && (rt_rq = iter->rt_rq[cpu_of(rq)]);		\
+		iter = next_task_group(iter))
 
 #define for_each_sched_rt_entity(rt_se) \
 	for (; rt_se; rt_se = rt_se->parent)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 1c457dc1472a3..d8d28c3d1ac5f 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2148,6 +2148,13 @@ static inline void set_task_rq(struct task_struct *p, unsigned int cpu)
 #endif
 
 #ifdef CONFIG_RT_GROUP_SCHED
+	/*
+	 * p->rt.rt_rq is NULL initially and it is easier to assign
+	 * root_task_group's rt_rq than switching in rt_rq_of_se()
+	 * Clobbers tg(!)
+	 */
+	if (!rt_group_sched_enabled())
+		tg = &root_task_group;
 	p->rt.rt_rq  = tg->rt_rq[cpu];
 	p->rt.parent = tg->rt_se[cpu];
 #endif
-- 
2.47.1


