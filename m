Return-Path: <linux-kernel+bounces-257775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A449937ED0
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 05:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EDDF2821BC
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 03:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1433B661;
	Sat, 20 Jul 2024 03:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="iB/L+OOO"
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BF1B64A
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 03:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721445580; cv=none; b=YAZo3brs5Ycknbc+tSb+Ef9etokCWi5fYEQGv4DH/ef//VA28RJ9HLLWzBFUEdmJ+0Jgmda3mIerP9jT7ekgVHixdLp5nQE1Eky7O/SljFw1Nh7iLP/Z5ZvOUjkWbAf/pUAZYnPlSHO5sv1ZFALCketEUijsOzWUMK1d/5az03U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721445580; c=relaxed/simple;
	bh=l0YyvpX6gPXn8QMPeNLGqHic3iXodSpJnIFU3H51hNQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sQMXRtTDdocDn9ZxPbNk/tMsc+0DaSIIgG4zOcc44wAxOMjaueX6ISd+IcXdp1NtrHbusob1m6qooefWeyGjBdONcDrp8o4xyBYl05MrE/qCLEASivoLl864tz9v8gwdua3Id5UlnVN4PmhJxxeBIhfjCYMPp48G3P6Na7BihrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=iB/L+OOO; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-4f2fad3fb8eso910989e0c.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 20:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1721445577; x=1722050377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7mqj8DEKN2mFZRfvnvF9eQtq4AnQU8mkl96+n6nhcaI=;
        b=iB/L+OOOQKSzlqyOjWHJstqiYidwUzcpg5+LNEPYh8AuMjlZ1cQcyxzYOlMVB8bfbp
         4OooxO3mamtCO/dAuHPCVPWgCnYMWFRtAmCJXT/Uqhe3e8GI2b2NfKxOjGufXLQjk0QN
         eatwA+3+7ZK5h3iW+cBRl1NExiHHyOUwN/Dz8xcVAZheWUXhS1uhPNBPG0G0lm+5I/oU
         Pwh0j79p5dqVp4/trIn4vbDsnevklxUMhryhjBWTe3c/bycoKm0wx4yVbO561qwYtCgc
         r4JbedIcFknWISYuICD7EF7qQ4z4flhU7ymk1dVP/BGTCJKb5+P8Lb9YjY55qGt+SLeY
         nWOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721445577; x=1722050377;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7mqj8DEKN2mFZRfvnvF9eQtq4AnQU8mkl96+n6nhcaI=;
        b=LGvm8N5tYiqH56LwztdAcX3o5epyyHeZn/arltGPNPkwU55jAAulI2Tm21bKwTvgCH
         nT1PcE2sVg117z6A6hCT0jqDP/kDqDcqQIE+ncslGdwIM0tzQuw8dkx812C7s8zL47Cs
         PzpHjJZjH3FuT9zJ9wXzzuHtMOJjcVUmuO5ZwMe6tvK8wAQ39oGWVr/jwVSxV5SXEOOf
         Vj3Qbx4nivLAAyTnthV0EHb6Duu1CLM0Cte6UyHdHQF3/MHwZE8U8A+lT5LOA4HthJnt
         wltb+hlkpzvsouywHNm8KaoCLNAjHYUxZtvcVi6n8cX34ou0mLdVlJ/HwuohHbsD+R+j
         ZUdg==
X-Forwarded-Encrypted: i=1; AJvYcCW+OmTiGNz25jHaEU6s5Obec2t6LUtRY4uLWUt1iCo799mOcWEFLyf3i/eVrwHxCZq3nB4WrFA1TguiRRcTojsdO381mjxqZrkHXsgs
X-Gm-Message-State: AOJu0YxDaUj4igNKZMiSpXtbffniqHGGKLcQ2lRFDiA8PXrZYFvXk1CF
	TNKCeARSENvrAslwiTY+nPV0+J9sw+dYv36+fjExcHELCR9f/uOe0feMMbYl6QPaYW46np5Jh8s
	uZiY=
X-Google-Smtp-Source: AGHT+IGbAWWEtwmG7vvsYPmqUafT5XyU/xjLRWog2vXKMzgygYvIYhEvxnhMgFVwZheYMrwxbEVW3g==
X-Received: by 2002:a67:e7c3:0:b0:48f:dec0:b6bf with SMTP id ada2fe7eead31-49283dc4267mr2312248137.4.1721445577629;
        Fri, 19 Jul 2024 20:19:37 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.84.173])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ccf7c5391bsm2507784a91.24.2024.07.19.20.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 20:19:37 -0700 (PDT)
From: Chuyi Zhou <zhouchuyi@bytedance.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com
Cc: chengming.zhou@linux.dev,
	linux-kernel@vger.kernel.org,
	Chuyi Zhou <zhouchuyi@bytedance.com>,
	Vishal Chourasia <vishalc@linux.ibm.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>
Subject: [PATCH v3] sched/fair: Remove cfs_rq::nr_spread_over and cfs_rq::exec_clock
Date: Sat, 20 Jul 2024 11:19:28 +0800
Message-Id: <20240720031928.406540-1-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nr_spread_over tracks the number of instances where the difference
between a scheduling entity's virtual runtime and the minimum virtual
runtime in the runqueue exceeds three times the scheduler latency,
indicating significant disparity in task scheduling.
Commit 5e963f2bd465 ("sched/fair: Commit to EEVDF") removed its usage.

cfs_rq->exec_clock was used to account for time spent executing tasks.
Commit 5d69eca542ee ("sched: Unify runtime accounting across classes")
removed its usage.

cfs_rq::nr_spread_over and cfs_rq::exec_clock are not used anymore in
eevdf. Remove them from struct cfs_rq.

Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
Acked-by: Vishal Chourasia <vishalc@linux.ibm.com>
Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
Changes in v3:
Fix the commit description style suggested by Prateek.

Changes in v2:
Add more description of nr_spread_over and exec_clock
suggested by Vishal.
---
 kernel/sched/debug.c | 4 ----
 kernel/sched/sched.h | 6 ------
 2 files changed, 10 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index c1eb9a1afd13..90c4a9998377 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -641,8 +641,6 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 	SEQ_printf(m, "\n");
 	SEQ_printf(m, "cfs_rq[%d]:\n", cpu);
 #endif
-	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", "exec_clock",
-			SPLIT_NS(cfs_rq->exec_clock));
 
 	raw_spin_rq_lock_irqsave(rq, flags);
 	root = __pick_root_entity(cfs_rq);
@@ -669,8 +667,6 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 			SPLIT_NS(right_vruntime));
 	spread = right_vruntime - left_vruntime;
 	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", "spread", SPLIT_NS(spread));
-	SEQ_printf(m, "  .%-30s: %d\n", "nr_spread_over",
-			cfs_rq->nr_spread_over);
 	SEQ_printf(m, "  .%-30s: %d\n", "nr_running", cfs_rq->nr_running);
 	SEQ_printf(m, "  .%-30s: %d\n", "h_nr_running", cfs_rq->h_nr_running);
 	SEQ_printf(m, "  .%-30s: %d\n", "idle_nr_running",
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 4c36cc680361..8a071022bdec 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -599,7 +599,6 @@ struct cfs_rq {
 	s64			avg_vruntime;
 	u64			avg_load;
 
-	u64			exec_clock;
 	u64			min_vruntime;
 #ifdef CONFIG_SCHED_CORE
 	unsigned int		forceidle_seq;
@@ -619,10 +618,6 @@ struct cfs_rq {
 	struct sched_entity	*curr;
 	struct sched_entity	*next;
 
-#ifdef	CONFIG_SCHED_DEBUG
-	unsigned int		nr_spread_over;
-#endif
-
 #ifdef CONFIG_SMP
 	/*
 	 * CFS load tracking
@@ -1158,7 +1153,6 @@ struct rq {
 	/* latency stats */
 	struct sched_info	rq_sched_info;
 	unsigned long long	rq_cpu_time;
-	/* could above be rq->cfs_rq.exec_clock + rq->rt_rq.rt_runtime ? */
 
 	/* sys_sched_yield() stats */
 	unsigned int		yld_count;
-- 
2.20.1


