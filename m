Return-Path: <linux-kernel+bounces-449558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EBEF9F50BE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 17:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73EFD16FD0F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 16:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F97F1F9A87;
	Tue, 17 Dec 2024 16:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vHlMX8dl"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758E81F940C
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 16:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734451663; cv=none; b=rGX4d4qG2uuuOao32OpQ2ParG00zpNEGK2faNsMJ5rJ1A7WPQpcdZ3qAClBq3i/nl7rRtyGBZGa4PtpEdeKTpeQ1HZV17h0JWNsw8Untl0rC3H7CCgzlvIMO8eHRzX50MGa0hT4SaO3HlwSVqs/w+OsG0dqfMRVqmqq37j6ymm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734451663; c=relaxed/simple;
	bh=dXS/ShcNcHU276KRefmpAmXb27O3K8SKe18Wp8y2ku0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pj7qrEvy5M19s5h1RWHD/3EV/QcFphM7V4u2czreA75biusokvgaGAUzIcTseIE+M54FAN8spHgrzrBqHp2WqYnPfmf5C1Jv7II0bQBFjWMHhw/7BDoY38toTfSniEUUH/N+VtCzJdkCHZbUHbNYbQWUHIo2omOCW+psuYAS5rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vHlMX8dl; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43624b2d453so61409115e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 08:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734451660; x=1735056460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qUSb30CiTrhpZ1NM6rfSGm6C56RYHphix50za6j+27U=;
        b=vHlMX8dlEubXt/6nxevgt3kQ5H0dUH1mn6P9x0MVNA+hwDIFbnh2SACFzVCb8LxVDX
         061cQFMFQjMIDuS5KtVx97ulzYS+jMGRGedXNYXq223dIpih5fxa+YkNFDD303hf2jqO
         e46Ll9jAesnh++RhGvPDvjL09K2jJ8Edc2f+wBeRrZuG95rFLeK4vNNQiYuKl+sPEWDf
         flI9HMKBtngG5/ISw92gTqcctKxridizsLbRbMPUpA9/NpX1wAH8s4e+wDVaF6bqOPmj
         HBTm7sfLq8aFYrNyiKeoxy3nd53cXwiht0oT3IxbjePVYwdzUl5rVtK4ksMRbJMiTN1L
         rRzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734451660; x=1735056460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qUSb30CiTrhpZ1NM6rfSGm6C56RYHphix50za6j+27U=;
        b=YKdCSicB+/W8XQbOGUUc1ugnmhIh9o6XuUPRilvheCjkUFxF5t0I9vfXmsSm3zFxXl
         DTAkseyUMiVI4ye4o4kl7zpq7CQOcVD22V6ydUEKI/cnZj8TnfMlHArlO1/f+v47sveZ
         i+RPXO3+R2Cg3j278qUJDTxca1nJoc/fW7srems67nPmh7fgxebHXl+ddom4uWBZ0Prz
         PcLAuzpzuPX3T9wYgnoQX8iAu0lG/u/+DF9vnOZ26eWqUmAw48IC4heCc4aIddNjkNG0
         2O86OoyDdOaPp0tqXxIjaCCxw8BioaDBujYsDkjsKYGWxgDul+dhdZrbpOe2WAPM9VBb
         aSuA==
X-Forwarded-Encrypted: i=1; AJvYcCUpzP67O37VLCkQeIhqHI8TFZ/Cn9qEJHP2lkAu47SpnFalyLngBQ2yVB1JFqbJKaahI8cBYg6H2YG3KC8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrCNORCc4mbZTaCa4nRm7xGS87kRrOVH7PdwnNbCtGCubcsORg
	h+ecqwMEosf4jkMg993kBb3Vsv5jl0a2r8zaiHUCIWGbR/Httam967MB5q5xHMU=
X-Gm-Gg: ASbGnctB8Z6Gk4/LDTJaMAJqnG9ZY8hF4E4YEtlnYYPjNoa6euXj4zaKZFn96asYLqC
	N+TC+Skz46p53T1au7zu2sYr/rrMOVi5d14zucybx4LLeGx0bTZRL6bwrII/oEPkaSMdWGdXcOu
	EULU4GAKPrR5kflZN/2qxbGV3K7OJoI6lSgnN7rL20sNIfcnRBPsLuDFZ1k+rK2MhrMnvCJ36L+
	mDn/fzI2AbBdDoz2U5TeyNzq4+64mf/suM1s5RhGIuItq+kER0pW6qvhrC5Z5ZrQA==
X-Google-Smtp-Source: AGHT+IE7yhM6n2qT4bX3AO5rYQwaGYYd/DtDCrDHq1aDPS9UWpDNflA38svKPTs5KwZ6j4hcosRHxA==
X-Received: by 2002:a05:600c:cc7:b0:434:f4fa:83c4 with SMTP id 5b1f17b1804b1-4362aaa65a2mr167340045e9.29.1734451659707;
        Tue, 17 Dec 2024 08:07:39 -0800 (PST)
Received: from vingu-cube.. ([2a01:e0a:f:6020:4e5f:e8c8:aade:2d1b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436257176a4sm176739435e9.38.2024.12.17.08.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 08:07:39 -0800 (PST)
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
	linux-kernel@vger.kernel.org
Cc: qyousef@layalina.io,
	hongyan.xia2@arm.com,
	pierre.gondois@arm.com,
	christian.loehle@arm.com,
	qperret@google.com,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 6/7 v2] sched/fair: Add misfit case to push task callback for EAS
Date: Tue, 17 Dec 2024 17:07:19 +0100
Message-ID: <20241217160720.2397239-7-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241217160720.2397239-1-vincent.guittot@linaro.org>
References: <20241217160720.2397239-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some task misfit cases can be handled directly by the push callback
instead of triggering an idle load balance to pull the task on a better
CPU.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

# Conflicts:
#	kernel/sched/fair.c
---
 kernel/sched/fair.c | 53 +++++++++++++++++++++++++++++----------------
 1 file changed, 34 insertions(+), 19 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2affc063da55..9bddb094ee21 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8541,6 +8541,8 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 			target_stat.runnable = cpu_runnable(cpu_rq(cpu));
 			target_stat.capa = capacity_of(cpu);
 			target_stat.nr_running = cpu_rq(cpu)->cfs.h_nr_runnable;
+			if ((p->on_rq) && (!p->se.sched_delayed) && (cpu == prev_cpu))
+				target_stat.nr_running--;
 
 			/* If the target needs a lower OPP, then look up for
 			 * the corresponding OPP and its associated cost.
@@ -8623,48 +8625,58 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 
 static inline bool task_misfit_cpu(struct task_struct *p, int cpu)
 {
-	unsigned long max_capa = get_actual_cpu_capacity(cpu);
-	unsigned long util = task_util_est(p);
+	unsigned long max_capa, util;
+
+	if (p->nr_cpus_allowed == 1)
+		return false;
 
-	max_capa = min(max_capa, uclamp_eff_value(p, UCLAMP_MAX));
-	util = max(util, task_runnable(p));
+	max_capa = min(get_actual_cpu_capacity(cpu),
+		       uclamp_eff_value(p, UCLAMP_MAX));
+	util = max(task_util_est(p), task_runnable(p));
 
 	/*
 	 * Return true only if the task might not sleep/wakeup because of a low
 	 * compute capacity. Tasks, which wake up regularly, will be handled by
 	 * feec().
 	 */
-	return (util > max_capa);
+	if (util > max_capa)
+		return true;
+
+	/* Return true if the task doesn't fit anymore to run on the cpu */
+	if ((arch_scale_cpu_capacity(cpu) < p->max_allowed_capacity) && !task_fits_cpu(p, cpu))
+		return true;
+
+	return false;
 }
 
 static int active_load_balance_cpu_stop(void *data);
 
-static inline void migrate_misfit_task(struct task_struct *p, struct rq *rq)
+static inline bool migrate_misfit_task(struct task_struct *p, struct rq *rq)
 {
 	int new_cpu, cpu = cpu_of(rq);
 
 	if (!sched_energy_enabled() || is_rd_overutilized(rq->rd))
-		return;
+		return false;
 
 	if (WARN_ON(!p))
-		return;
+		return false;
 
-	if (WARN_ON(p != rq->curr))
-		return;
+	if (WARN_ON(!task_current(rq, p)))
+		return false;
 
 	if (is_migration_disabled(p))
-		return;
+		return false;
 
-	if ((rq->nr_running > 1) || (p->nr_cpus_allowed == 1))
-		return;
+	if (rq->nr_running > 1)
+		return false;
 
 	if (!task_misfit_cpu(p, cpu))
-		return;
+		return false;
 
 	new_cpu = find_energy_efficient_cpu(p, cpu);
 
 	if (new_cpu == cpu)
-		return;
+		return false;
 
 	/*
 	 * ->active_balance synchronizes accesses to
@@ -8675,13 +8687,15 @@ static inline void migrate_misfit_task(struct task_struct *p, struct rq *rq)
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
@@ -13299,9 +13313,10 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 	if (static_branch_unlikely(&sched_numa_balancing))
 		task_tick_numa(rq, curr);
 
-	migrate_misfit_task(curr, rq);
-	update_misfit_status(curr, rq);
-	check_update_overutilized_status(task_rq(curr));
+	if (!migrate_misfit_task(curr, rq)) {
+		update_misfit_status(curr, rq);
+		check_update_overutilized_status(task_rq(curr));
+	}
 
 	task_tick_core(rq, curr);
 }
-- 
2.43.0


