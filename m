Return-Path: <linux-kernel+bounces-538599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4770EA49ABB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 14:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 827BE18986F9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 13:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DFCA26FD9D;
	Fri, 28 Feb 2025 13:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aVhodTFF"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E0726D5BF
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 13:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740750018; cv=none; b=OovMLdeihNwRp6Y3glxH71lSurMNfqHjPA3ftioSW7DR/1SAQ83RBRe/9QLRPH2hrDFFdcaHCvlXCLrhZyAO62/fQ79ZLlQxwNkp6Dwo+8fM2M3uINSt6LqdrPt+2uG2dpk0Kad4Wg7gAsbGjANWBp74VlXklbjljE5egI6Lamo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740750018; c=relaxed/simple;
	bh=8PzAsPt7+hK+rtjikvk7exCgte/EY5wdhrXBAOoMwLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sVmx6SRjVaYLt7aKqsg+ewbx2WOyzm5B+IjVrJUJIIXGnEvZ7wcJi9wx+XXROEP7nkEFixhOnJpe3gv1C2nGVt+1k4yorKxeuXgqR6ZEheSOC1nYlH7DZM45x47n0w9KKIznNTncccTpAMvvAjsYljZM4uGXI1aQLYiJlbmXg9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aVhodTFF; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4398738217aso19030155e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 05:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740750013; x=1741354813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vn4DL6lNoF03xrDB47bBVdVlyRNbpJRyEArZG5HgRw4=;
        b=aVhodTFFfKyxAH0B76NLLhO9bv2nALq2h9NCzN5FQKXr7I6M1PFhC7d9w/TDqN9Roh
         4uV976Tb/P2qcc4QRf/MrJMNdYCxGZpx127VdShZ6+zKFmu8Vs2fn8z+jJW+ULniku+i
         E/Qtt8p/pZP2k5oAZuNzKARQI2tzdA1AASj1Y/6JqzgJvSt87cdKXGXOLJUxB58JCj3h
         EGYh6ajmu1VmU99D3dSBOtOLprQZbX6VfWC6/sd+a3ew0varYEaqs9KEvezcOPsFIj9m
         6YHpD8RS189f5vrqzo/SKzeivLQ3350kgqulTH+Z96M9qVUkSWiCT4ZcEgs6Ndwcmf/8
         DFAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740750013; x=1741354813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vn4DL6lNoF03xrDB47bBVdVlyRNbpJRyEArZG5HgRw4=;
        b=pBOBogb1B793WxZpOJWWIdcZwl+l7jd2ApNtbfDFJ0me1a+iYQbgSPlUDuIxijwIDI
         vx3zFqdtlvVgAU+v7NbKnKWanzOU0ebOSuTScVI6e3JdL0874QyleoY5gdV1qWdhkrZN
         0pGd88I7/H9oGzaMloAAQQFiYVF9sF6RnujWtLsNSmarr5dH5SvTsfDmzY71XdKJ9Uh7
         iOpD3guoRkSrYWw/dDVKjRSoIsTktcXDt7yagAulpKS0PzGMI/uNsksxfHja38ZVyASF
         ItmUZlQxJmsvVfd1+EjCQzfHAMNNRJZl1N06v7P8DP9b0Uq7OoH5fu/TZgS8kapIQI7J
         gbhQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+LZBviaJYf7NFVbKwEhXFGV9A+rpE/ZOhq/anIIpIqOF/hIqX6eCFsKreNv9U5mKVVJXGfJsmrB3ZWTs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4XFbFPYYd7zXQyi/ZooUp1DyDKtwLT3SxPNPstRO1tFrYyBnG
	ysXV3l26PqylxlWqysQPK/XJA+g0vRtq/jMedANXOsIWY9wL+8Mzk1Xt11NyEy8=
X-Gm-Gg: ASbGncuZ744rgmr2NhqTKyC3tvUQuCYgOPgfrF2lktqKnlrQQyXfC8X0NwuMtZ3yJx4
	1KMxz//dDD3Zr8L6mg7RXmpsN1plp1SgSE+c3kYfNDa422Uc5xFH9rTR10PA/WYSYGHq9eFbLdb
	4ayAmPzYTY1sVFfR/9GXmlxfqYOReqLpR10ufsZXIQMddSy2ppNM9SIX8BVhIuFAf1Sfuvx+xc4
	ekmer4gCRY9egFxwSaox7nmof50IOzk8tW4g2gMNtEUkospEZMekk+AzksQrkdRVN5/CurZHomg
	jM3GJvZpDKA7+EDMFwOt7ubXYc8OjVnD6Q==
X-Google-Smtp-Source: AGHT+IGRXwA8HxsfM6ZV66UcJ4rVlcju9x0PNpHLiYU1/3zMhmGNGexVhvIGBVxWuDwJy/w+JKRohw==
X-Received: by 2002:a05:600c:a03:b0:439:6712:643d with SMTP id 5b1f17b1804b1-43ba66df7d6mr28639075e9.9.1740750013143;
        Fri, 28 Feb 2025 05:40:13 -0800 (PST)
Received: from vingu-cube.. ([2a01:e0a:f:6020:d4b:473f:a962:e9e2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b73717171sm55984405e9.18.2025.02.28.05.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 05:40:11 -0800 (PST)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	lukasz.luba@arm.com,
	rafael.j.wysocki@intel.com,
	pierre.gondois@arm.com,
	linux-kernel@vger.kernel.org
Cc: qyousef@layalina.io,
	hongyan.xia2@arm.com,
	christian.loehle@arm.com,
	luis.machado@arm.com,
	qperret@google.com,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 6/7 v3] sched/fair: Add misfit case to push task mecanism for EAS
Date: Fri, 28 Feb 2025 14:39:59 +0100
Message-ID: <20250228134000.1226665-7-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250228134000.1226665-1-vincent.guittot@linaro.org>
References: <20250228134000.1226665-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some task misfit cases can be handled directly by the push mecanism
instead of triggering an idle load balance to pull the task on a better
CPU.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5b2f88dec70e..87bf054cf36b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8508,6 +8508,8 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 			target_stat.runnable = cpu_runnable(cpu_rq(cpu));
 			target_stat.capa = capacity_of(cpu);
 			target_stat.nr_running = cpu_rq(cpu)->cfs.h_nr_runnable;
+			if ((p->on_rq) && (!p->se.sched_delayed) && (cpu == prev_cpu))
+				target_stat.nr_running--;
 
 			/* If the target needs a lower OPP, then look up for
 			 * the corresponding OPP and its associated cost.
@@ -8613,6 +8615,9 @@ static inline bool sched_energy_push_task(struct task_struct *p, struct rq *rq)
 	if (p->nr_cpus_allowed == 1)
 		return false;
 
+	if (!task_fits_cpu(p, cpu_of(rq)))
+		return true;
+
 	if (is_rd_overutilized(rq->rd))
 		return false;
 
@@ -8624,33 +8629,33 @@ static inline bool sched_energy_push_task(struct task_struct *p, struct rq *rq)
 
 static int active_load_balance_cpu_stop(void *data);
 
-static inline void check_pushable_task(struct task_struct *p, struct rq *rq)
+static inline bool check_pushable_task(struct task_struct *p, struct rq *rq)
 {
 	int new_cpu, cpu = cpu_of(rq);
 
 	if (!sched_energy_enabled())
-		return;
+		return false;
 
 	if (WARN_ON(!p))
-		return;
+		return false;
 
 	if (WARN_ON(!task_current(rq, p)))
-		return;
+		return false;
 
 	if (is_migration_disabled(p))
-		return;
+		return false;
 
 	/* If there are several task, wait for being put back */
 	if (rq->nr_running > 1)
-		return;
+		return false;
 
 	if (!sched_energy_push_task(p, rq))
-		return;
+		return false;
 
 	new_cpu = find_energy_efficient_cpu(p, cpu);
 
 	if (new_cpu == cpu)
-		return;
+		return false;
 
 	/*
 	 * ->active_balance synchronizes accesses to
@@ -8661,13 +8666,15 @@ static inline void check_pushable_task(struct task_struct *p, struct rq *rq)
 		rq->active_balance = 1;
 		rq->push_cpu = new_cpu;
 	} else
-		return;
+		return false;
 
 	raw_spin_rq_unlock(rq);
 	stop_one_cpu_nowait(cpu,
 		active_load_balance_cpu_stop, rq,
 		&rq->active_balance_work);
 	raw_spin_rq_lock(rq);
+
+	return true;
 }
 
 static inline int has_pushable_tasks(struct rq *rq)
@@ -8952,7 +8959,7 @@ balance_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	return sched_balance_newidle(rq, rf) != 0;
 }
 #else
-static inline void check_pushable_task(struct task_struct *p, struct rq *rq) {}
+static inline bool check_pushable_task(struct task_struct *p, struct rq *rq) {}
 static inline void fair_queue_pushable_tasks(struct rq *rq) {}
 static void fair_remove_pushable_task(struct cfs_rq *cfs_rq, struct task_struct *p) {}
 static inline void fair_add_pushable_task(struct cfs_rq *cfs_rq, struct task_struct *p) {}
@@ -13362,9 +13369,10 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 	if (static_branch_unlikely(&sched_numa_balancing))
 		task_tick_numa(rq, curr);
 
-	check_pushable_task(curr, rq);
-	update_misfit_status(curr, rq);
-	check_update_overutilized_status(task_rq(curr));
+	if (!check_pushable_task(curr, rq)) {
+		update_misfit_status(curr, rq);
+		check_update_overutilized_status(task_rq(curr));
+	}
 
 	task_tick_core(rq, curr);
 }
-- 
2.43.0


