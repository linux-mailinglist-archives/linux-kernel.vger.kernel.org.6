Return-Path: <linux-kernel+bounces-554752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C875A59BF6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 18:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C3A4188740D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6013E233732;
	Mon, 10 Mar 2025 17:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WwaY1E1A"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0DD231A3F
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 17:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741626306; cv=none; b=gwC0WE6NSdP9MgXkTwIAViOD7eagS+EMJZoIW3khRf0Jldcnaxx4n8FPAT3JXv2osf63mVm1Oqd48n0Inzyc6mxJVIKm6Tu6f2m+Jwx2VP0Vd1qHlhCgVpbYTLtsvTShRkS85eeqp+ODLsZgj27SFeCW9yagcHAfA64aywf9eK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741626306; c=relaxed/simple;
	bh=eqp+p20wQUC3G9kX8x2gTPBWxovLGLvK0huXE5jYVqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SVMpX3y4zPaxEosbk0goNCkg3Pqf2CALKvoa1j4+IR1khBylJVBnTTk7NU6/OpIPYTe0EtinCxG1aJ4r5K9DcnfAsTRPpGcroQVDR1mMNgbPcs7i0XxoSIqdXjy0/8y43mjrxg4OI7iiHLMD3TrrO47Bop6S0PK52aGod6H4uv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WwaY1E1A; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-39133f709f5so1602043f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 10:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741626303; x=1742231103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G8u7m4f90z4ywcN2Oo3EiIsdxXzNCHdgpNAW3hDLWX8=;
        b=WwaY1E1AE69SzPRokTlQSuDnWVlUdHM3BFSO7Dyes5LdPU1qy1s8RtalRIrgHoftT8
         q14G5eG+MqiAB/df4xWvOGS3EJwN3V3Ht8im7wXnUr0NZu4LRZZEMuoIMxj4RpPVimPN
         /88m969lhGBpowKvAUywW/GoGOg6lZIxOfK/ibv453/Hs8IGqBA3gZ0HUSi+BlMm7XgF
         GKhGF3Vfc3NxkKxpB+xGLnveaSu0IQdVo8Ts2DshnI374vRqdXFM393+kbNMuuoAK7C4
         gRWuLW3eJ52qffxKlyJ9dhPwUfqMiGUifFYB1edyFIRdSNQDBEgI+j28C8n8Mjtp5vfQ
         1WEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741626303; x=1742231103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G8u7m4f90z4ywcN2Oo3EiIsdxXzNCHdgpNAW3hDLWX8=;
        b=sWfCK3ofVCL0HGYI6HGOl+GxOvFVikpzlhJKcbfrca8gBQpao4kblZuhxBMy8u8/nQ
         gRH+Lb1tAU91kUOZu9PJaVZt1ti226SdQpd2iADx7bNKtdVAdiMrSDPq1CBcxltBuyhh
         1BxxCHf+MFJ1hSppZsIwDmXZ6enLW3G9W/m5OLf+F3VIqisF4bxl42FCM2Jk84zsXUFG
         /bYEXqEUvCNAZx5xiffA9nCNjt6LCLutTShQW7ZPi+rYGfji9JTaq8heg0MDvDDtz2j7
         X5jnppG7MkgKO9NreHK7vjHJxlMTn9nijPgMFEuT/uFtopCT78HisHMq+EZfYtN7BgI4
         zNTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfb/gz3NKsS5Uz7y/2rfe2vr7fqa32HL6I/5kdkK2PkjjfpQSWG/vOTuMVeSL9ZI1EIeSMh1grG0H+0dA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVsudObthK/hd2N8f/YgLL5vg8GDqAp6Etn4qFGdqv96stWpnd
	AZgi2ZjcWvpunFOcRL5mncxLAoHwkcyojUZ7oax2ut3RfDwd/Asr6OzH0OAGY4k=
X-Gm-Gg: ASbGncuGcUzroXKH5Hc9t3Ys8WmFAdqA+dNGxKfc1eW7T9AS5nR4VNM+0bpOZz6M4Lt
	L6Vn8gV3hPLxvxYpITPoYektgY9+XtLKAxCGxNp8S2X1ffJQJTN/Wyieixp5PmORC+Ip9IscABj
	AKM7RE/nhnnndFRPuK1MEseQUrZupPlXkkLC4zxOGat2iniAfLEIWBWAnpLiMY43RMOVlW+d9kT
	cuXdveq7NIZVfDP6Rbpls/TOYAAQ534V1h5ov03VgxiMEMs4KCmDKR3DYsxxZdMFjOAOOZnsgLZ
	TGfdTPJqRY0ClfUCJflxfSvzSc9JwwvAleVYZlIiZsnlU6bSY/5WDc3Rgw==
X-Google-Smtp-Source: AGHT+IFlJVRZCEshYk7Wfa802nBla5K6NUqsThPUNNSFqpHEeriX8ZJPGcyYFslAHxGKJ1PxoTJywg==
X-Received: by 2002:a05:6000:1844:b0:391:8a3:d964 with SMTP id ffacd0b85a97d-39132da10e0mr10182161f8f.41.1741626302781;
        Mon, 10 Mar 2025 10:05:02 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfba679sm15302514f8f.8.2025.03.10.10.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 10:05:02 -0700 (PDT)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: Peter Zijlstra <peterz@infradead.org>,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Frederic Weisbecker <fweisbecker@suse.com>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Subject: [PATCH v2 05/10] sched: Skip non-root task_groups with disabled RT_GROUP_SCHED
Date: Mon, 10 Mar 2025 18:04:37 +0100
Message-ID: <20250310170442.504716-6-mkoutny@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170442.504716-1-mkoutny@suse.com>
References: <20250310170442.504716-1-mkoutny@suse.com>
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
index e6e072e618a00..5b67b4704a5ed 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8966,7 +8966,7 @@ void sched_online_group(struct task_group *tg, struct task_group *parent)
 	unsigned long flags;
 
 	spin_lock_irqsave(&task_group_lock, flags);
-	list_add_rcu(&tg->list, &task_groups);
+	list_add_tail_rcu(&tg->list, &task_groups);
 
 	/* Root should already exist: */
 	WARN_ON(!parent);
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index dabb26b438e88..a427c3f560b71 100644
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
index e4f6c0b1a3163..4548048dbcb8f 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2187,6 +2187,13 @@ static inline void set_task_rq(struct task_struct *p, unsigned int cpu)
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
2.48.1


