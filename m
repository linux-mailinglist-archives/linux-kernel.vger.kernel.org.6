Return-Path: <linux-kernel+bounces-448069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1999F3A9A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 21:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5279516A7EB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 20:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B38C1D90BD;
	Mon, 16 Dec 2024 20:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Wnmq1gsG"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7995E1D63C4
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 20:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734380003; cv=none; b=ChqLh0frYh3NoH0AyH3rk0wYkyLhpLQJ1f4OWXdXcEuY+13jp/jvqmxOcwBtpws+eT6ZzRWCMnXhlySB+eknrl7Pz3s+vvjTw8DiO9Y+7NORShTiC9SXMOaU/kkyu89rNisP1Hn03NE7wNIRwxX9pRS6pRse7l+IbfYmzpvQF7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734380003; c=relaxed/simple;
	bh=sAuqG2C0OeDsO12ruW4vbErIpYaHfkRnSMmWfHPILLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vGaazUG80TRpNzRJWVg/1WiXW9gRjxYXjiVQcsoITFkC3SdIghs7T3YekhZmOZpZIlGUQuCB+e9TbUYGueN/GaASpVhcigPybo/ynnJQrlPLcKDhBv/V3AgQltTBYGU1u2KFqARR7G51h3Tsk/LQrVWB9pmxo2Y0z8PzNTMDldM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Wnmq1gsG; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4361a50e337so31698165e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 12:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734380000; x=1734984800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TKj14npJ7R9cs4fWfeOYO+IBaB1ICPemXIGU+5j22xk=;
        b=Wnmq1gsGGOBpNBcw3BHfwpkWCkOSPbSxB39hoxboHQSFLAbuJx2iVYiD3ydrUMVEgP
         w/XGNuW7pBFW0ww9kRN0Rpvr1uGsMhFXUf73gPH2nEG7NXX1qblI7kjfFOuLpg/WA+Fd
         Kh0tvsyfNfJojCROZ04SYJN5jTQXJ0rYss7nHRh3EORy8tpADbJMOn3yGQu7FkMKgAnj
         vdmPJyPneIIBbG81kXDmDZgSQwZpfSkPLGXjg9E66Qs9EXcGDtIHwKVxaM3UfKB3lNPc
         5DaFe/5jFRinsywfNqJt8VaYCVct+F5ZuafiPX4TL8grQ8cVvxZOLzpt1CXlgUM9/oTl
         45dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734380000; x=1734984800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TKj14npJ7R9cs4fWfeOYO+IBaB1ICPemXIGU+5j22xk=;
        b=qDZXsWQ3jzPPacU8qC6SAh+eKapKtAnZ94cN0CCPLepr6Ln0qHlFfmrjJZ0WJphOy6
         c1tdYe66pL3B1tLf6tLX32rQTG6jbja5epf260daqVkv/DdtEqadcgl8dBVzhITIZoP6
         nkqQkd6IOgQkBhDFmVOB+TtLo1la9P7WHUOslkWyXkOrZ+KOeUIHLjypHxpk30miDAu5
         r/kk9nBtGao6novIEX61nb57saXLe4T5JmOxGXNGROPhSpcr5quBoV82dVvXC0nSGk3l
         G2uFG63g9L55KrZXKINlqY2SwujrwKyre5Onp1NoRdUTVHf25Ck6onZ1tZ7nYjeDs1UE
         w07g==
X-Forwarded-Encrypted: i=1; AJvYcCUHFXAe6VgOZYGR3wGUiiqHuGn1qXzUYkoC5naAdVGlWvx5mgRW00TF9wMidP8p187+8vHQD6ZEQt82n/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCrSz+keAaam3QW6Ecm4VO38z7xsnIQJGJlWxUUggpurKyjI0q
	K3bPJv2y+Fu9oSHRiKv1FktYAVB2WcUOC81MIxyxxnVfzT0tuFHl+RAmXi14BsY=
X-Gm-Gg: ASbGncsDux/NPwN0pNS4999gJ0wFsUNokz8L+CAOgoKjqqJO9oo/fY+sHxRzcq43hik
	U1lGba4lXbncusWzqSppcvW5ALmMkHm7dgLWnGY2zPVVYob4anKVEIbgFbtoKwkogHCjYon6ZRr
	nGxc1HwHg4kzuGsxh/Yf1PGgdeCPBYatRzVJTCD5xq9obGk6AfzKabPbTuZVtjnwCD5Omi32Fot
	9KzFkFkYEHB8xJOZCGL1CXPXXg76vzlyDPSUI+B+u6VqLjj5YVnHfcmoA==
X-Google-Smtp-Source: AGHT+IH7d1GySzdi9zfSxB6g8GzAlPF95KSWZ0OkCE4h3jr0ii1QwEHaxJGNZ/FP2XbW/sNy/OmBrw==
X-Received: by 2002:a05:600c:3109:b0:434:fdaf:af2d with SMTP id 5b1f17b1804b1-4362aab4e5amr127654525e9.30.1734379999689;
        Mon, 16 Dec 2024 12:13:19 -0800 (PST)
Received: from blackbook2.suse.cz ([84.19.86.74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4364a379d69sm473715e9.0.2024.12.16.12.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 12:13:19 -0800 (PST)
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
Subject: [RFC PATCH 8/9] sched: Add RT_GROUP WARN checks for non-root task_groups
Date: Mon, 16 Dec 2024 21:13:04 +0100
Message-ID: <20241216201305.19761-9-mkoutny@suse.com>
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

With CONFIG_RT_GROUP_SCHED but runtime disabling of RT_GROUPs we expect
the existence of the root task_group only and all rt_sched_entity'ies
should be queued on root's rt_rq.

If we get a non-root RT_GROUP something went wrong.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/sched/rt.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index db7cdc82003bd..deacd46e27823 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -178,11 +178,14 @@ static inline struct task_struct *rt_task_of(struct sched_rt_entity *rt_se)
 
 static inline struct rq *rq_of_rt_rq(struct rt_rq *rt_rq)
 {
+	/* Cannot fold with non-CONFIG_RT_GROUP_SCHED version, layout */
+	WARN_ON(!rt_group_sched_enabled() && rt_rq->tg != &root_task_group);
 	return rt_rq->rq;
 }
 
 static inline struct rt_rq *rt_rq_of_se(struct sched_rt_entity *rt_se)
 {
+	WARN_ON(!rt_group_sched_enabled() && rt_se->rt_rq->tg != &root_task_group);
 	return rt_se->rt_rq;
 }
 
@@ -190,6 +193,7 @@ static inline struct rq *rq_of_rt_se(struct sched_rt_entity *rt_se)
 {
 	struct rt_rq *rt_rq = rt_se->rt_rq;
 
+	WARN_ON(!rt_group_sched_enabled() && rt_rq->tg != &root_task_group);
 	return rt_rq->rq;
 }
 
@@ -506,8 +510,10 @@ typedef struct task_group *rt_rq_iter_t;
 
 static inline struct task_group *next_task_group(struct task_group *tg)
 {
-	if (!rt_group_sched_enabled())
+	if (!rt_group_sched_enabled()) {
+		WARN_ON(tg != &root_task_group);
 		return NULL;
+	}
 
 	do {
 		tg = list_entry_rcu(tg->list.next,
@@ -2609,8 +2615,9 @@ static int task_is_throttled_rt(struct task_struct *p, int cpu)
 {
 	struct rt_rq *rt_rq;
 
-#ifdef CONFIG_RT_GROUP_SCHED
+#ifdef CONFIG_RT_GROUP_SCHED // XXX maybe add task_rt_rq(), see also sched_rt_period_rt_rq
 	rt_rq = task_group(p)->rt_rq[cpu];
+	WARN_ON(!rt_group_sched_enabled() && rt_rq->tg != &root_task_group);
 #else
 	rt_rq = &cpu_rq(cpu)->rt;
 #endif
@@ -2720,6 +2727,9 @@ static int tg_rt_schedulable(struct task_group *tg, void *data)
 	    tg->rt_bandwidth.rt_runtime && tg_has_rt_tasks(tg))
 		return -EBUSY;
 
+	if (WARN_ON(!rt_group_sched_enabled() && tg != &root_task_group))
+		return -EBUSY;
+
 	total = to_ratio(period, runtime);
 
 	/*
-- 
2.47.1


