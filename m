Return-Path: <linux-kernel+bounces-425762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBE29DEAC7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 17:18:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDB6C2821BA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 16:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DDE14E2E6;
	Fri, 29 Nov 2024 16:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lz5uOfVF"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B3F19F131
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 16:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732897093; cv=none; b=uiGef679qY6Z6yd/XC8g1Wmdh4ZeQxFWzbjyKA6jJZSH+A75oGDlm7aUM9tr1jUIYMfK7GxcVVg3b25y8r7v4rO5CRLi9wqaC1kNGTMsdqlVNPOGIgo0xku0+/2cXPU1jIRlqMsTtUmffDFpLhMcG78g02chhl0ALc7SGNGjXF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732897093; c=relaxed/simple;
	bh=GxgIChr+Nt7Mc/eCvRx7iCX/prRRYopji8rvDm6A3Hs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UGoXwcN5HGxefryirRIop8cvvzyxvuI9fJuj9N2D2h3i8OHWeZXZ2gwoY/yblcxoE3GPrV9iYbMTvcd28V7ym11c8fx+9acBK8MTE/ja0nRfHIkA3wV3PBcvrJ5HWQvRCnKg9WPy/ryeInFlR8uQDgbfbhrZX6xklME7RmCpOW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lz5uOfVF; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-434acf1f9abso18611145e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 08:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732897089; x=1733501889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Whd635DH52K+eo3lEmn9yMLzsCrUc6kKdp70v1HMEuM=;
        b=lz5uOfVFKYEFc5SgjjZR5jPB82nP6fHYoQe285ueLSYmp+55XLuFPMLk44c5oWBD5D
         J9q+4Zqto8yt7JNiyV/V0i07iC1w2upWmlsyvYqhg2DeWgue6ZnoqFbi1+jNKLFVTYcR
         pVl5SHxIyadC2WlBpj7PzBFDEYE92HEvvGBuchtG8Gl7qOULfV0Owh1TDDw1PTKjo1tf
         ytAjLdLM2wHPyYZ/+ZFjW2Scbnd2DU5Oza6wBUY1fy86XIsSGIfwZ63jereBhbwZEiMq
         wUzaswXKP3YJHUj/VN+zG/GLkvypl/F/UCKtiKKr0y2LfeU7SpIDh+s6sb13V1rF9Ap6
         +loQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732897089; x=1733501889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Whd635DH52K+eo3lEmn9yMLzsCrUc6kKdp70v1HMEuM=;
        b=ZVZ2qrIw9BuBzRJETNivwiMuMRsln3a61q4wJFnahASN9mUi3esSh3zy1wcDRDLSwb
         xKfgNm2+mMN6BjW7/gIMFpV12+74VOOvX9DSu+2tweTIz2aT31zLupMqgBu+QgjFk0N4
         an1RMDZ5djp0CGC25YalqovYkgohk9XCFxC0xc2g/OZmDwmK1/IHXy8m14eY60DwfKBG
         KpbM+0NZGRdeMLttA0Azphj6q3esEgPt6b8GYJPEt1/+us9VDI1ljEkXBvdjAsxlfLvt
         JC6OvnukCYEsRu/4V63Ftju0yHgR/ZQdtzEQRznht+msLDcN9T4GPa2SBXH1+1grHvlk
         lluQ==
X-Forwarded-Encrypted: i=1; AJvYcCXspTT481Rs/7JRZlRVjpC4XWWR0n4I6zI5bLyeLZU/j+lc7e/YHQjHRzQHOrcFhBySgoqUC99Tb1SpwiM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIDs5epmyb1lAk4tBj3o1Wwu6rml1NSgxEg7IvOab8MbPmymFe
	IDlrXOBslc1cvVLDSDksE/GycRIOAB2RP3JZ+FQxcmNHQeBZDRaC48BNg25WSB0=
X-Gm-Gg: ASbGncuFQ9c5LQQ+OQKxXERThx/8ReNAktziAirdM0NsULamQoMd/cxm3Mn/ExQz8Vz
	pqq2rGkZV2nmu/YT5W2RZCeP3f9JIpjfGDVZG0+HzeeAw693GXYiQNcJVZ7uUMxU3Vw3DE4eLmO
	YOICSJXfz0G3/HYHYvKegiWKXgjgEyFTWrQnffF6FU7XBNckukw1BbRCESrOTBulsTodI7rCYHJ
	wCXBX3UfpeYzBu9S4jcrsVSE5IT0S+MuUflwrPK59CT83Y+HM3cb4Vj4JY=
X-Google-Smtp-Source: AGHT+IFMV7qexSnBmBTl4lE96+HsE0KqpVUywGql5ajgJ8V5+3EbY8LbrGgsTuVTp7HHOvacf6D74A==
X-Received: by 2002:a05:600c:4f07:b0:431:52da:9d67 with SMTP id 5b1f17b1804b1-434a9dbbfbbmr128217665e9.3.1732897088805;
        Fri, 29 Nov 2024 08:18:08 -0800 (PST)
Received: from vingu-cube.. ([2a01:e0a:f:6020:c54b:5636:4db3:1028])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0dbf95fsm56771665e9.15.2024.11.29.08.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 08:18:07 -0800 (PST)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	linux-kernel@vger.kernel.org
Cc: kprateek.nayak@amd.com,
	pauld@redhat.com,
	efault@gmx.de,
	luis.machado@arm.com,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 06/10 v2] sched/fair: Remove unused cfs_rq.idle_nr_running
Date: Fri, 29 Nov 2024 17:17:52 +0100
Message-ID: <20241129161756.3081386-7-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241129161756.3081386-1-vincent.guittot@linaro.org>
References: <20241129161756.3081386-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cfs_rq.idle_nr_running field is not used anywhere so we can remove the
useless associated computation

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/debug.c |  2 --
 kernel/sched/fair.c  | 14 +-------------
 kernel/sched/sched.h |  1 -
 3 files changed, 1 insertion(+), 16 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 867e1102c368..37ccba0bedf5 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -846,8 +846,6 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 	SEQ_printf(m, "  .%-30s: %d\n", "nr_running", cfs_rq->nr_running);
 	SEQ_printf(m, "  .%-30s: %d\n", "h_nr_runnable", cfs_rq->h_nr_runnable);
 	SEQ_printf(m, "  .%-30s: %d\n", "h_nr_queued", cfs_rq->h_nr_queued);
-	SEQ_printf(m, "  .%-30s: %d\n", "idle_nr_running",
-			cfs_rq->idle_nr_running);
 	SEQ_printf(m, "  .%-30s: %d\n", "h_nr_idle",
 			cfs_rq->h_nr_idle);
 	SEQ_printf(m, "  .%-30s: %ld\n", "load", cfs_rq->load.weight);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 13ee5ea13580..20fe55e95882 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3674,8 +3674,6 @@ account_entity_enqueue(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	}
 #endif
 	cfs_rq->nr_running++;
-	if (se_is_idle(se))
-		cfs_rq->idle_nr_running++;
 }
 
 static void
@@ -3689,8 +3687,6 @@ account_entity_dequeue(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	}
 #endif
 	cfs_rq->nr_running--;
-	if (se_is_idle(se))
-		cfs_rq->idle_nr_running--;
 }
 
 /*
@@ -13523,7 +13519,7 @@ int sched_group_set_idle(struct task_group *tg, long idle)
 	for_each_possible_cpu(i) {
 		struct rq *rq = cpu_rq(i);
 		struct sched_entity *se = tg->se[i];
-		struct cfs_rq *parent_cfs_rq, *grp_cfs_rq = tg->cfs_rq[i];
+		struct cfs_rq *grp_cfs_rq = tg->cfs_rq[i];
 		bool was_idle = cfs_rq_is_idle(grp_cfs_rq);
 		long idle_task_delta;
 		struct rq_flags rf;
@@ -13534,14 +13530,6 @@ int sched_group_set_idle(struct task_group *tg, long idle)
 		if (WARN_ON_ONCE(was_idle == cfs_rq_is_idle(grp_cfs_rq)))
 			goto next_cpu;
 
-		if (se->on_rq) {
-			parent_cfs_rq = cfs_rq_of(se);
-			if (cfs_rq_is_idle(grp_cfs_rq))
-				parent_cfs_rq->idle_nr_running++;
-			else
-				parent_cfs_rq->idle_nr_running--;
-		}
-
 		idle_task_delta = grp_cfs_rq->h_nr_queued -
 				  grp_cfs_rq->h_nr_idle;
 		if (!cfs_rq_is_idle(grp_cfs_rq))
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 8c57da1af378..7ece69b0fc14 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -648,7 +648,6 @@ struct cfs_rq {
 	unsigned int		nr_running;
 	unsigned int		h_nr_runnable;      /* SCHED_{NORMAL,BATCH,IDLE} */
 	unsigned int		h_nr_queued;
-	unsigned int		idle_nr_running;   /* SCHED_IDLE */
 	unsigned int		h_nr_idle; /* SCHED_IDLE */
 
 	s64			avg_vruntime;
-- 
2.43.0


